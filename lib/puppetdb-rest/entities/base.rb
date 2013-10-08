module PuppetDbRestClient
  class Base
    attr_accessor :attrs
    alias :to_hash :attrs

    @@identity_map = IdentityMap.new

    def self.identity_map
      @@identity_map
    end # def self.identity_map

    # Define methods that retrieve the value from an initialized instance variable Hash, using the attribute as a key
    #
    # @overload self.attr_reader(attr)
    #   @param attr [Symbol]
    # @overload self.attr_reader(attrs)
    #   @param attrs [Array<Symbol>]
    def self.attr_reader(*attrs)
      attrs.each do |attribute|
        class_eval do
          define_method attribute do
            @attrs[attribute.to_s]
          end
          define_method "#{attribute}=" do |value|
            @attrs[attribute.to_s] = value
          end
        end
      end
    end # def self.attr_reader

    def self.get(attrs=Mash.new)
      @@identity_map[self] ||= {}
      if attrs['title']
        @@identity_map[self][attrs['title']] && @@identity_map[self][attrs['title']].update(attrs)
      elsif attrs['resource']
        @@identity_map[self][attrs['resource']] && @@identity_map[self][attrs['resource']].update(attrs)
      else
        @@identity_map[self][Marshal.dump(attrs)]
      end
    end # def self.get

    # Retrieve an object from the identity map or initialize a new object
    def self.get_or_new(attrs=Mash.new)
      self.get(attrs) || self.new(attrs)
    end # def self.get_or_new

    # Initializes a new object
    #
    # @param attrs [Hash]
    # @return [PuppetDbRestClient::Base]
    def initialize(attrs=Mash.new)
      self.class.attr_reader *attrs.keys
      attrs.stringify_keys!
      self.update attrs
      if attrs['title']
        @@identity_map[self.class] ||= {}
        @@identity_map[self.class][attrs['title']] = self
      elsif attrs['resource']
        @@identity_map[self.class] ||= {}
        @@identity_map[self.class][attrs['resource']] = self
      else
        @@identity_map[self.class] ||= {}
        @@identity_map[self.class][Marshal.dump(attrs)] = self
      end
    end # def initialize

    # Fetches an attribute of an object using hash notation
    #
    # @param method [String, Symbol] Message to send to the object
    def [](method)
      self.__send__(method.to_sym)
    rescue NoMethodError
      nil
    end # def []

    # Update the attributes of an object
    #
    # @param attrs [Hash]
    # @return [PuppetDbRestClient::Base]
    def update(attrs)
      @attrs = attrs
      self
    end # def update

    # @return [String]
    def resource
      @attrs['resource']
    end # def id

    # @return [String]
    def title
      @attrs['title']
    end # def name

    def keys
      @attrs.keys
    end # def keys

  end
end