RSpec.describe BeforeHooks do
  it 'has a version number' do
    expect(BeforeHooks::VERSION).not_to be nil
  end

  context 'when ModuleA is included to ClassA' do
    let(:moduleA) do
      Module.new do
        def self.included(base)
          puts 'ModuleA included is called!'
        end
      end
    end
    let(:classA) { Class.new }
    subject { classA.include moduleA }

    context 'when `before_included` is defined in ModuleA' do
      before do
        moduleA.class_eval do
          def self.before_included(base)
            puts 'ModuleA before_included is called!'
          end
        end
      end

      it 'calls `ModuleA.before_included` first before `ModuleA.included`' do
        expect(STDOUT).to receive(:puts).with('ModuleA before_included is called!').ordered
        expect(STDOUT).to receive(:puts).with('ModuleA included is called!').ordered
        subject
      end
    end

    context 'when `before_included` is not defined in ModuleA' do
      it 'does not call `ModuleA.before_included`' do
        expect(STDOUT).to_not receive(:puts).with('ModuleA before_included is called!')
        subject
      end

      it 'calls `ModuleA.included`' do
        expect(STDOUT).to receive(:puts).with('ModuleA included is called!').ordered
        subject
      end
    end
  end

  context 'when ModuleA is extended to ClassA' do
    let(:moduleA) do
      Module.new do
        def self.extended(base)
          puts 'ModuleA extended is called!'
        end
      end
    end
    let(:classA) { Class.new }
    subject { classA.extend moduleA }

    context 'when `before_extended` is defined in ModuleA' do
      before do
        moduleA.class_eval do
          def self.before_extended(base)
            puts 'ModuleA before_extended is called!'
          end
        end
      end

      it 'calls `ModuleA.before_extended` first before `ModuleA.extended`' do
        expect(STDOUT).to receive(:puts).with('ModuleA before_extended is called!').ordered
        expect(STDOUT).to receive(:puts).with('ModuleA extended is called!').ordered
        subject
      end
    end

    context 'when `before_extended` is not defined in ModuleA' do
      it 'does not call `ModuleA.before_extended`' do
        expect(STDOUT).to_not receive(:puts).with('ModuleA before_extended is called!')
        subject
      end

      it 'calls `ModuleA.extended`' do
        expect(STDOUT).to receive(:puts).with('ModuleA extended is called!').ordered
        subject
      end
    end
  end

  context 'when ModuleA is prepended to ClassA' do
    let(:moduleA) do
      Module.new do
        def self.prepended(base)
          puts 'ModuleA prepended is called!'
        end
      end
    end
    let(:classA) { Class.new }
    subject { classA.send(:prepend, moduleA) }

    context 'when `before_prepended` is defined in ModuleA' do
      before do
        moduleA.class_eval do
          def self.before_prepended(base)
            puts 'ModuleA before_prepended is called!'
          end
        end
      end

      it 'calls `ModuleA.before_prepended` first before `ModuleA.prepended`' do
        expect(STDOUT).to receive(:puts).with('ModuleA before_prepended is called!').ordered
        expect(STDOUT).to receive(:puts).with('ModuleA prepended is called!').ordered
        subject
      end
    end

    context 'when `before_prepended` is not defined in ModuleA' do
      it 'does not call `ModuleA.before_prepended`' do
        expect(STDOUT).to_not receive(:puts).with('ModuleA before_prepended is called!')
        subject
      end

      it 'calls `ModuleA.prepended`' do
        expect(STDOUT).to receive(:puts).with('ModuleA prepended is called!').ordered
        subject
      end
    end
  end

  # # TODO: add a `before_method_added` and `before_method_reoved`; not yet working; couldn't yet think of a solution
  # context 'when some_method is added to ClassA' do
  #   let(:classA) do
  #     Class.new do
  #       def self.method_added(method_name)
  #         puts 'ClassA method_added is called!'
  #       end
  #     end
  #   end
  #
  #   subject do
  #     classA.class_eval do
  #       def some_method
  #       end
  #     end
  #   end
  #
  #   context 'when `before_method_added` is defined in ClassA' do
  #     before do
  #       classA.class_eval do
  #         def self.before_method_added(*args)
  #           puts 'ClassA before_method_added is called!'
  #         end
  #       end
  #     end
  #
  #     it 'calls `ClassA.before_method_added` first before `ClassA.method_added`' do
  #       expect(STDOUT).to receive(:puts).with('ClassA before_method_added is called!').ordered
  #       expect(STDOUT).to receive(:puts).with('ClassA method_added is called!').ordered
  #       subject
  #     end
  #   end
  #
  #   context 'when `before_method_added` is not defined in ModuleA' do
  #     it 'does not call `ClassA.before_method_added`' do
  #       expect(STDOUT).to_not receive(:puts).with('ClassA before_method_added is called!')
  #       subject
  #     end
  #
  #     it 'calls `ClassA.method_added`' do
  #       expect(STDOUT).to receive(:puts).with('ClassA method_added is called!').ordered
  #       subject
  #     end
  #   end
  # end
end
