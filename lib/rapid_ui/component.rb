module Ui
  # responsible for the out building of the component
  class Component
    attr_accessor :action_attr, :alt, :css_class, :data, :id, :img, :method, :name_attr, :placeholder, :params,
                  :rows, :style, :tag, :text, :title, :type, :target, :url, :value, :rel, :step, :disabled

    def initialize(settings)
      @settings = settings
      set_defaults
      build_component
      transpose_settings %w[action_attr alt data id img method name_attr placeholder rows style tag text title type url
                            value rel step disabled]
    end

    # sets component defaults
    def set_defaults
      @data = nil
      @css_class = ""
    end

    # builds out the component
    def build_component
      build_ui
      build_dynamic
      build_class
      build_responsiveness
      build_name
      build_default_class
      apply_stimulus_shortcuts
      build_stimulus_props
      trim_css_class
    end

    # removes the ui class if the switch is set to false
    def build_ui
      add_class "ui" unless @settings.key?(:ui) && @settings[:ui] == false
    end

    # adds dynamic class to the component is the switch is set to true
    def build_dynamic
      add_class "dynamic" if @settings.key?(:dynamic) && @settings[:dynamic]
    end

    # builds out css class for the component
    def build_class
      add_class @settings[:class] if @settings.key?(:class)
    end

    # builds out the responsive css classes
    # used by semantic-ui responsive classes
    def build_responsiveness
      add_class build_only if @settings.key?(:only)
      add_class build_size if @settings.key?(:size)

      sizes = %i[computer tablet mobile]
      sizes.each do |device|
        add_class build_size(device) if @settings.key?(device)
      end
    end

    # builds out the name for the component
    def build_name
      return unless @settings.key?(:name)

      add_class @settings[:name]
      add_data :name, @settings[:name].parameterize.underscore
    end

    # builds out a default class for the component
    def build_default_class
      add_class @settings[:css_class] if @settings.key?(:css_class)
    end

    def apply_stimulus_shortcuts
      @settings[:controller] = @settings[:c] if @settings.key?(:c)
      @settings[:action] = @settings[:a] if @settings.key?(:a)
      @settings[:target] = @settings[:t] if @settings.key?(:t)
      @settings[:params] = @settings[:p] if @settings.key?(:p)
      @settings[:values] = @settings[:v] if @settings.key?(:v)
    end

    # builds out stimulus.js shortcuts
    def build_stimulus_props
      add_data :controller, @settings[:controller] if @settings.key?(:controller)
      add_data :action, @settings[:action] if @settings.key?(:action)
      add_target_data @settings[:target] if @settings.key?(:target)
      add_params_data @settings[:params] if @settings.key?(:params)
      add_values_data @settings[:values] if @settings.key?(:values)
    end

    private

    # Converts numbers into words
    # It seems to be having issues with larger valeus such as 1001
    # rubocop:disable all
    def number_in_words(int)
      numbers_to_name = {
        1_000_000 => 'million', 1000 => 'thousand', 100 => 'hundred', 90 => 'ninety', 80 => 'eighty', 70 => 'seventy', 60 => 'sixty', 50 => 'fifty', 40 => 'forty',
        30 => 'thirty', 20 => 'twenty', 19 => 'nineteen', 18 => 'eighteen', 17 => 'seventeen', 16 => 'sixteen', 15 => 'fifteen', 14 => 'fourteen', 13 => 'thirteen',
        12 => 'twelve', 11 => 'eleven', 10 => 'ten', 9 => 'nine', 8 => 'eight', 7 => 'seven', 6 => 'six', 5 => 'five', 4 => 'four', 3 => 'three', 2 => 'two', 1 => 'one'
      }
      str = ''
      numbers_to_name.each do |num, name|
        if int.zero?
          return str
        elsif int.to_s.length == 1 && (int / num).positive?
          return str + name.to_s
        elsif int < 100 && (int / num).positive?
          return str + name.to_s if (int % num).zero?
          return str + name.to_s + ' ' + number_in_words(int % num)
        elsif (int / num).positive?
          return str + number_in_words(int / num) + ' ' + name.to_s + number_in_words(int % num)
        end
      end
    end

    def transpose_settings(items)
      items.each do |item|
        instance_variable_set("@#{item}", @settings[item.to_sym])
      end
    end

    # appends class to the css_clss object
    def add_class(klass)
      css_class << ' ' + klass
    end

    # builds out the class markup for 'only' type display
    def build_only
      "#{@settings[:only]} only"
    end

    # builds out the class markup for the size
    def build_size(device = nil)
      return number_in_words(@settings[:size]) if device.equal? nil
      "#{number_in_words(@settings[device])} wide #{device}"
    end

    # adds items to the data hash
    def add_data(name, value)
      # initialize data hash if one doesn't exist
      @settings[:data] = {} if @settings[:data].nil?

      @settings[:data][name] = value
    end

    # goes through the target object and populates the data variables
    def add_target_data(target_obj)
      target_obj.keys.each do |target|
        controller = target.to_s
        target=  target_obj[target]

        data_string = "#{controller}-target"
        add_data(data_string, target)
      end
    end


    # goes through the params object and populate the data variables
    def add_params_data(params_obj)
      params_obj.keys.each do |params_controller|
        controller = params_controller.to_s

        params = params_obj[params_controller]
        params.keys.each do |param|
          param_value = params[param]
          data_string = "#{controller}-#{param}-param"

          add_data(data_string, param_value)
        end
      end
    end

    # goes through the values object and populate the data variables
    def add_values_data(params_obj)
      params_obj.keys.each do |params_controller|
        controller = params_controller.to_s

        params = params_obj[params_controller]
        params.keys.each do |param|
          param_value = params[param]
          data_string = "#{controller}-#{param}-value"

          add_data(data_string, param_value)
        end
      end
    end

    def trim_css_class
      @css_class = @css_class.strip.empty? ? "" : @css_class.strip
    end

  end
end
