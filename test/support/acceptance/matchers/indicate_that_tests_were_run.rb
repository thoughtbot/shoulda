require_relative '../helpers/array_helpers'
require_relative '../helpers/pluralization_helpers'

module AcceptanceTests
  module Matchers
    def indicate_that_tests_were_run(series)
      IndicateThatTestsWereRunMatcher.new(series)
    end

    class IndicateThatTestsWereRunMatcher
      include ArrayHelpers
      include PluralizationHelpers

      def initialize(expected_numbers)
        @expected_numbers = expected_numbers
      end

      def matches?(runner)
        @runner = runner
        Set.new(expected_numbers).subset?(Set.new(actual_numbers))
      end

      def failure_message
        "Expected output to indicate that #{some_tests_were_run}.\n" +
          "#{formatted_expected_numbers}\n" +
          "#{formatted_actual_numbers}\n\n" +
          "Output:\n\n" +
          actual_output
      end

      protected

      attr_reader :expected_numbers, :runner

      private

      def some_tests_were_run
        if some_tests_were_run_clauses.size > 1
          "#{to_sentence(some_tests_were_run_clauses)} were run"
        else
          "#{some_tests_were_run_clauses} was run"
        end
      end

      def some_tests_were_run_clauses
        expected_numbers.map do |type, number|
          if number == 1
            "#{number} #{type.to_s.chop}"
          else
            "#{number} #{type}"
          end
        end
      end

      def formatted_expected_numbers
        "Expected numbers: #{format_hash(expected_numbers)}"
      end

      def formatted_actual_numbers
        report_line = find_report_line_in(actual_output)

        if report_line
          "Actual numbers: #{report_line.inspect}"
        else
          'Actual numbers: (n/a)'
        end
      end

      def actual_numbers
        numbers = parse(
          actual_output,
          [:tests, :assertions, :failures, :errors, :skips],
        )
        numbers || {}
      end

      def actual_output
        runner.output
      end

      def parse(text, pieces)
        report_line = find_report_line_in(text)

        if report_line
          pieces.inject({}) do |hash, piece|
            number = report_line.match(/(\d+) #{piece}/)[1].to_i
            hash.merge(piece => number)
          end
        end
      end

      def find_report_line_in(text)
        lines = text.split(/\n/)

        index_of_line_with_time = lines.find_index do |line|
          line =~ /\AFinished in \d\.\d+s\Z/
        end

        if index_of_line_with_time
          lines[index_of_line_with_time + 1]
        end
      end

      def format_hash(hash)
        '{' + hash.map { |k, v| "#{k}: #{v.inspect}" }.join(', ') + '}'
      end
    end
  end
end
