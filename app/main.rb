def read_file(file_name)
  dir_ref = `pwd`
  current_dir = dir_ref[0..dir_ref.length-'\n'.length]
  current_dir = "#{current_dir}/app/source" unless current_dir.index('app')
  file_dir = "#{current_dir}/#{file_name}"

  file = File.open(file_dir, 'r')
  data = file.read
  file.close
  data
end

def write_output(file_name, data)
  dir_ref = `pwd`
  current_dir = dir_ref[0..dir_ref.length-'\n'.length]
  current_dir = "#{current_dir}/app/output" unless current_dir.index('app')
  file_dir = "#{current_dir}/#{file_name}"

  File.open(file_dir, 'w') do |file|
    data.each do |d|
      file.write "@include makeIcon(#{d[:key]}, #{d[:value]}) \n"
    end
  end
end

# ReadFile
data = read_file 'mdi.min.css'
# Get all classes (remove the first, which is empty)
classes_ref = data.split('.')[1, data.length]
classes = []

# get classes key/value
classes_ref.each do |c|
  class_attrs = c.split(':')
  key = class_attrs[0]
  value = class_attrs[2]

  classes << {
      key: class_attrs[0],
      value: value[0, value.length-1]
  }
end

write_output('mdi.output.scss', classes)