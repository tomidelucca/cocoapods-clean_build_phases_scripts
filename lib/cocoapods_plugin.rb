require 'cocoapods-clean_build_phases_scripts/command'

module CleanBuildPhasesScripts
    Pod::HooksManager.register('cocoapods-clean_build_phases_scripts', :post_install) do |context, options|
      argv = CLAide::ARGV.new(options)
      Pod::Command::CleanBuildPhasesScripts.new(argv).run
    end
end