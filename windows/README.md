# windows: a Vagrant box for Windows guests

# FEATURES

* Supports `vagrant ssh [--no-tty -c <command>]`
* Supports `vagrant rsync`
* Supports file and shell Vagrant provisioners
* Includes [Chocolatey](https://chocolatey.org/) package manager

Note that Vagrant support for Windows guests exhibits quirks of varying disquiet. Suffice to say:

* `vagrant ssh` launches an interactive Command Prompt cmd session (Use `dir` here).
* `vagrant ssh --no-tty -c "<command>"` executes a bash command (Use `ls` here).
* `vagrant ssh --no-tty -c "powershell -Command \"<command>\""` executes a PowerShell command.
* `vagrant ssh --no-tty -c "sh <cygwin-path>.sh` executes a bash script.
* `vagrant ssh --no-tty -c "powershell -NoLogo -ExecutionPolicy RemoteSigned -File <cygwin-path>.ps1` executes a PowerShell script.
* `vagrant ssh --no-tty -c "powershell -NoLogo -ExecutionPolicy RemoteSigned -File <cygwin-path>-shim.ps1"` can invoke an MS-DOS `.bat`/`.cmd` script using a PowerShell wrapper.
* `vagrant rsync` uses `/cygdrive/c/...` syntax for cygwin paths
* `vagrant ssh --no-tty -c` and bash.exe use `/c/...` syntax for cygwin paths

# CROSS-PLATFORM BUILD ADVICE

## WINDOWS ON VAGRANT ON *

Applications targeting purely Windows environments can be built from Windows and non-Windows hosts, by executing build commands via Vagrant commands. At a minimum, however, byzantine MS-DOS batch scripts should be rewritten or wrapped as PowerShell in order to be callable via `vagrant ssh`...

## UNIX ON VAGRANT ON *

UNIX-style applications are often built with bash scripts and Makefile's, the duct tape of grey-haired system administrators. Windows application builds can likewise be triggered by bash and make for *build portability*, though some care with cygwin paths and per-OS conditionals is likely necessary.

With the absurd proliferation of shell environments available in Windows (Command Prompt, PowerShell, bash, ...), writing a shell script-driven build configuration that actually succeeds regardless of the environment (PowerShell 3+ on a native Windows host, Command Prompt by way of PowerShell on Windows on VirtualBox through Vagrant from a macOS host, , bloody zsh.exe, etc.) borders on impractical. Basic things like querying the user's home directory, deleting files, and escaping quotes, have dramatically different syntaxes depending on the active shell *and* the way the shell is called from other shells. Few application builds are tested on these many environment configurations, so build failures often hide until a user bothers to attempt the build with his particular environment. In short, bugs are likely to abound in shell script-based builds.

One solution for cross-platform builds is to treat bash as the lingua franca of shells, and require users building for Windows to configure bash.exe (e.g., bash on Ubuntu on Windows, or Git Bash). This organizes the build environment around a single shell, which can be expected to function reasonably consistently across many different UNIX and Windows environments. So instead of `.bat`, `.cmd`, and `.ps1` scripts, developers simply write `.sh` scripts. Bash conditionals querying the exact operating system and architecture details can then multiplex between low level build details, such as which header files to specify for compilation.

Here, UNIX-style paths are preferred. `cygpath` is your friend. Note that `vagrant ssh` defaults to a Command Prompt environment, where Windows paths are expected at the top-level, while `vagrant ssh ... -c ...` defaults to a bash environment, where cygwin paths are expected at the top-level, *and* paths may need to be converted back and forth as we descend from the top-level environment to different shell script contexts--bash calling PowerShell calling bash calling PowerShell calling cmd.exe involves a careful dance of `cygpath` application at many stages.

There are some efforts to provide cross-platform Makefile recipes, see [meme](https://github.com/mcandre/meme), but these are fragile experiments, leaning on constant testing for a wide variety of environments, not so much deriving from a consistent or trusted platform.

## WINDOWS AND UNIX ON VAGRANT ON *

Oy, computers are supposed to automate this drudgery! Enough with stupid shell-specific pitfalls, just write your build system like a normal application against a standard lib. Tools like [mage](https://magefile.org/), [Gulp](https://gulpjs.com/), [Grunt](https://gruntjs.com/), [Gradle](https://gradle.org/), [Maven](https://maven.apache.org/), [Ant](http://ant.apache.org/), [SBT](https://www.scala-sbt.org/) offer standard methods for your build steps, offering a single, coherent build system that resolves to appropriate low-level, OS-specific operations on behalf of the developer. Don't call shell commands, call *libraries*, streamlining cross-platform builds like never before!
