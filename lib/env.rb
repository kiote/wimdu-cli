module Env
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def env
      ENV['ENV'] == 'test' ? 'test' : 'production'
    end

    def test?
      ENV['ENV'] == 'test'
    end
  end
end
