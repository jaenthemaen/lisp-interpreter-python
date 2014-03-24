import os

filenames = os.listdir('.')

for some_file in filenames:
    combo = some_file.split('.')
    combo[0] = combo[0].split('_')
    if combo[0][0].isdigit():
        if combo[1] == "py":
            new_filename = some_file.replace("_test", "")
            new_filename = "test_" + new_filename
            os.rename(some_file, new_filename)
