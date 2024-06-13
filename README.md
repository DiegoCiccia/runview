# runview
How to preview Stata help files from VSCode.

## Ackowledgements

## Setup 

The setup process takes 5/10 minutes. In general, this process can be divided into two steps:
1. [runview setup](#setting-up-runview)
2. [VSCode setup](#setting-up-vscode)

### Setting up runview

1. Download the latest version of `runview` ([1.0.0](https://github.com/DiegoCiccia/runview/raw/main/dist/1.0.0.zip)).
2. Unzip it. For what follows, we assume that the directory of the unzipped file is "C:\Users\User\runview", where User is the name of the PC (that can be retrieved from any directory).
3. Open "runview.ini" as a text file and replace the placeholders in the next two lines:

```stata
statapath = "C:\Program Files\Stata_version\Stata_exec.exe"
statawin = "full_text_that_appears_in_the_upper-left_corner_of_a_Stata_window"
```
The statapath is the path where the Stata executable is stored. You should replace Stata_version with something like "Stata18" and Stata_exec is something like "Stata/MP 18". It is way easier to locate the replacement for statawin: just open a Stata window and copy/paste the text on the upper-left corner, e.g. Stata/MP 18", in place of the placeholder above. After these changes, the .ini file should look like this:

```
[Stata]
statapath = "C:\Program Files\Stata18\StataMP-64.exe"
statawin = "StataNow/MP 18.5"
statacmd = "^1"

[Delays]
clippause = 100
winpause = 200
keypause = 1
```

4. Save the .ini file. 

5. Lastly, add the installation folder to the environment variables of Windows. To do that, just go:
    + Search "Edit the system environment variables" -> 
    + Click on "Environment Variables..." -> 
    + Double click on "Path" in User Variables box -> 
    + Click on "New" -> 
    + Copy and Paste the directory where runview has been unzipped (in our example, C:\Users\User\runview) ->
    + Click OK until you exit the window

To double-check the setup of runview, open a command prompt, type "runview" and press enter. If the command prompts an error window, it means that it has been installed correctly (we run it without any argument!). If, instead, the result is something in the line of "runview is not recognized as a command" and no external window is prompted, then something went wrong in the installation process.

### Setting up VSCode

You can download VSCode from [here](https://code.visualstudio.com/). After you install the software, run it and locate the Extension section on the left vertical panel (or just press CTRL + Shift + X). From there, search "Code runner" and press "Install". We will use this extension to activate runview.