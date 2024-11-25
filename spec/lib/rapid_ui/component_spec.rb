require 'spec_helper'

RSpec.describe Ui::Component do
  describe '#initialize' do
    it 'creates a new component with default settings' do
      component = described_class.new({})
      expect(component.css_class).to include('ui')
      expect(component.data).to be_nil
    end
  end

  describe 'building components' do
    context 'with ui option' do
      it 'includes ui class by default' do
        component = described_class.new({})
        expect(component.css_class).to include('ui')
      end

      it 'excludes ui class when ui: false' do
        component = described_class.new(ui: false)
        expect(component.css_class).not_to include('ui')
      end
    end

    context 'with dynamic option' do
      it 'includes dynamic class when dynamic: true' do
        component = described_class.new(dynamic: true)
        expect(component.css_class).to include('dynamic')
      end

      it 'excludes dynamic class by default' do
        component = described_class.new({})
        expect(component.css_class).not_to include('dynamic')
      end
    end

    context 'with custom class' do
      it 'adds custom class' do
        component = described_class.new(class: 'custom-class')
        expect(component.css_class).to include('custom-class')
      end
    end

    context 'with responsive options' do
      it 'handles only option' do
        component = described_class.new(only: 'mobile')
        expect(component.css_class).to include('mobile only')
      end

      it 'handles size option' do
        component = described_class.new(size: 4)
        expect(component.css_class).to include('four')
      end

      it 'handles device-specific sizes' do
        component = described_class.new(mobile: 2, tablet: 4, computer: 6)
        expect(component.css_class).to include('two wide mobile')
        expect(component.css_class).to include('four wide tablet')
        expect(component.css_class).to include('six wide computer')
      end
    end

    context 'with name option' do
      it 'adds name class and data attribute' do
        component = described_class.new(name: 'TestComponent')
        expect(component.css_class).to include('Test Component')
        expect(component.data).to include(name: 'test_component')
      end
    end

    context 'with stimulus shortcuts' do
      it 'handles controller shortcut' do
        component = described_class.new(c: 'test')
        expect(component.data).to include(controller: 'test')
      end

      it 'handles action shortcut' do
        component = described_class.new(a: 'click->test#action')
        expect(component.data).to include(action: 'click->test#action')
      end

      it 'handles target shortcut' do
        component = described_class.new(t: { controller: 'output' })
        expect(component.data).to include("controller-target" => "output")
      end

      it 'handles params shortcut' do
        component = described_class.new(p: { controller: { url: '/test' } })
        expect(component.data).to include("controller-url-param" => "/test")
      end

      it 'handles values shortcut' do
        component = described_class.new(v: { controller: { count: 5 } })
        expect(component.data).to include("controller-count-value" => 5)
      end
    end
  end

  describe '#number_in_words' do
    let(:component) { described_class.new({}) }

    it 'converts single digits' do
      component = described_class.new(size: 1)
      expect(component.css_class).to include('one')
    end

    it 'converts teens' do
      component = described_class.new(size: 15)
      expect(component.css_class).to include('fifteen')
    end

    it 'converts tens' do
      component = described_class.new(size: 20)
      expect(component.css_class).to include('twenty')
    end

    it 'converts compound numbers' do
      component = described_class.new(size: 22)
      expect(component.css_class).to include('twenty two')
    end
  end
end
