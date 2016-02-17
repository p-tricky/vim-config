def FlagsForFile(filename, **kwargs):
  flags = [
    '-Wall',
    '-Wextra',
    '-Werror'
    '-pedantic',
    '-I',
    '.',
    '-isystem',
    '/usr/include',
    '-isystem',
    '/usr/include/mpich',
    '-isystem',
    '/usr/local/include',
    '-isystem',
    '/usr/lib/clang/3.4/include',
    '-isystem',
    '/usr/lib/gcc/x86_64-linux-gnu/4.8/include',
    '-isystem',
    '/usr/lib/clang/3.4/include',
    '-isystem',
    '/usr/include/x86_64-linux-gnu',
    '-isystem',
    '/usr/lib/openmpi/include',
    '-isystem',
    '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include',
    '-isystem',
    '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/7.0.2/include',
    '-isystem',
    '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1',
    '-isystem',
    '/usr/local/Cellar/gcc/4.9.2_1/lib/gcc/4.9/gcc/x86_64-apple-darwin14.0.0/4.9.2/include'
  ]

  data = kwargs['client_data']
  filetype = data['&filetype']

  if filetype == 'c':
    flags += ['-xc']
  elif filetype == 'cpp':
    flags += ['-xc++']
  elif filetype == 'objc':
    flags += ['-ObjC']
  else:
    flags = []

  return {
    'flags': flags,
    'do_cache': True
  }
