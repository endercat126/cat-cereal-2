import os

# Get the current working directory
cwd = os.getcwd()

# Get all filenames in the current working directory
filenames = os.listdir(cwd)

print(cwd)

# Print the filenames
for filename in filenames:
    split_name = filename.split(' ')

    new_name = ''

    for word in split_name:
        new_name += word + '_'

    new_name = new_name.lower()

    new_name = new_name.replace('_-_1024x1024', '')
    new_name = new_name.replace('_png', '.png')
    new_name = new_name.replace('import_', 'import')
    new_name = new_name.replace('png_', 'png')

    print(f'\'{filename}\' -> \'{new_name}\'')

    os.rename(os.path.join(cwd, filename), os.path.join(cwd, new_name))