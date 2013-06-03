require "yaml"
namespace :styleguide do
  desc "Generate the color count file"
  task :generate_colors do
    p "Generating color count file..."
    color_lines = File.read(Rails.root.join("app/assets/stylesheets/constants/_colors.scss")).split("\n").reject(&:blank?)
    colors = color_lines.map do |l|
      color_pair = l.gsub(/[$,;]/, "").split(":")
      count = `ack -lch --invert-file-match --G '(_colors\.scss)' #{color_pair[0]} app/assets/stylesheets/`.chomp.to_i
      {name: color_pair[0], hex: color_pair[1].gsub(/\/\/.*$/,"").strip, count: count}
    end

    colors.sort! do |x, y|
      x_color = Color::RGB.from_html(x[:hex].gsub("#", "")).to_hsl
      y_color = Color::RGB.from_html(y[:hex].gsub("#", "")).to_hsl
      compare_color(x_color, y_color)
    end

    File.open(Rails.root.join("doc/colors.yml"), "w") do |f|
      f.write(colors.to_yaml)
    end
  end

  def compare_color(x, y)
    if (x.hue - y.hue).abs >= 30.0
      x.hue + x.luminosity + x.saturation <=> y.hue + y.luminosity + y.saturation
    elsif (x.saturation - y.saturation).abs >= 20.0
      x.saturation + x.luminosity <=> y.saturation + y.luminosity
    else
      x.luminosity <=> y.luminosity
    end
  end
end
