module Kan
  class Application
    class InvalidScopeError < StandardError; end

    def initialize(scopes = {})
      raise(InvalidScopeError) unless scopes.is_a?(Hash)
      raise(InvalidScopeError) if scopes.empty?

      @scopes = Hash(scopes)
      @abilities_lists = {}
    end

    def [](ability)
      scope, ability_name = ability.split('.')
      abilities = Array(@scopes[scope.to_sym])

      raise_scope_error(scope) if abilities.empty?
      return @abilities_lists[ability] if @abilities_lists[ability]

      @abilities_lists[ability] = AbilitiesList.new(ability_name, abilities)
    end

    private

    def raise_scope_error(scope)
      raise ArgumentError.new("Invalid scope #{scope}")
    end
  end
end
