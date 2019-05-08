module Pod
  class Command
    class CleanBuildPhasesScripts < Command
      self.summary = "Remove input/output files from 'Copy Pod Resources' build phases script"
      self.description = <<-DESC
        Remove input/output files from 'Copy Pod Resources' build phases script.
      DESC

      self.arguments = [ CLAide::Argument.new('xcodeproj', false) ]

      def self.options
        [ ['--xcodeproj=PATH', '.xcodeproj path'] ].concat(super)
      end

      def initialize(argv)
        @xcodeproj_path = argv ? argv.option('xcodeproj') : nil
        super
      end

      def validate!
        super
      end

      def run
        if !@xcodeproj_path 
          @xcodeproj_path = Dir.glob("*.xcodeproj").first
        end

        puts "RUNNING in #@xcodeproj_path"

        help! 'A xcodeproj file could not found.' unless @xcodeproj_path

        xcode_project = Xcodeproj::Project.open(@xcodeproj_path)

        puts "XCODEPROJ: #{xcode_project}"

        puts "TARGETS: #{xcode_project.targets}"

        xcode_project.targets.each do |target|
          puts "TARGET: #{target}"
          phase_name = '[CP] Copy Pods Resources'
          target.shell_script_build_phases.select { |phase| phase.name && phase.name.end_with?(phase_name) }.each do |phase|
                puts "Removing input/output paths from script '#{phase.name}' in target '#{target.name}'"
                phase.input_paths = []
                phase.output_paths = []
          end
        end
        xcode_project.save
      end

    end
  end
end
