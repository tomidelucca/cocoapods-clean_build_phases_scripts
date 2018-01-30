require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::CleanBuildPhasesScripts do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ clean-build-phases-scripts }).should.be.instance_of Command::CleanBuildPhasesScripts
      end
    end
  end
end

