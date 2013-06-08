module Hackeroo
  class Version
    MAJOR = 0 unless defined? Hackeroo::Version::MAJOR
    MINOR = 1 unless defined? Hackeroo::Version::MINOR
    PATCH = 0 unless defined? Hackeroo::Version::PATCH
    PRE = nil unless defined? Hackeroo::Version::PRE

    class << self

      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end

    end

  end
end
