# runview
Previewing Stata help files from VSCode.

![view](https://github.com/DiegoCiccia/runview/assets/71022390/50d7da9e-5128-4cf8-ac24-fa88aa30bb72)

## Ackowledgements

`runview` is an extension of `rundo` and `rundolines` to .sthlp files.
I am deeply thankful to Friedrich Huebler for his work on these projects. 
Check out [his website](https://huebler.blogspot.com/2008/04/stata.html) for FAQs and other information about the original programs. 

## Setup 

The setup process takes 5/10 minutes. In general, this process can be divided into two steps:
1. [runview setup](#setting-up-runview)
2. [VSCode setup](#setting-up-vscode)

### Setting up runview

1. Download the latest version of `runview` ([1.0.0](https://github.com/DiegoCiccia/runview/raw/main/dist/runview_1.0.0.zip)).
2. Unzip it. For what follows, we assume that the directory of the unzipped file is "C:\Users\User\runview", where User is the name of the PC (that can be retrieved from any directory).
3. Open "runview.ini" as a text file and replace the placeholders in the first two lines:

```stata
statapath = "C:\Program Files\Stata_version\Stata_exec.exe"
statawin = "full_text_that_appears_in_the_upper-left_corner_of_a_Stata_window"
```
The statapath is the path where your Stata executable is stored. You should replace Stata_version with something like "Stata18" and Stata_exec is something like "Stata/MP 18". It is way easier to locate the replacement for statawin: just open a Stata window and copy/paste the text on the upper-left corner, e.g. Stata/MP 18", in place of the placeholder above. After these changes, the .ini file should look like this:

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

5. Lastly, add the installation folder to the environment variables of Windows:
    + Browse "Edit the system environment variables" in the search bar and click on it -> 
    + Click on "Environment Variables..." -> 
    + Double click on "Path" in User Variables box -> 
    + Click on "New" -> 
    + Copy and Paste the directory where runview has been unzipped (in our example, C:\Users\User\runview) ->
    + Click OK until you exit the window

To double-check the setup of runview, open a command prompt, type "runview" and press enter. If the command prompts an error window, it means that it has been installed correctly (we are running runview it without any file argument!). If, instead, the result is something in the line of "runview is not recognized as a command" and no external window is prompted, then something went wrong in the installation process.

### Setting up VSCode

You can download VSCode from [here](https://code.visualstudio.com/). After you install the software, run it and locate the Extension section on the left vertical panel (or just press CTRL + Shift + X). From there, search "Code runner" and click on "Install". We will use this extension to activate runview.

Go "File -> Preferences -> Settings". Browse "Executor Map By File Extension", locate the "Executor Map By File Extension" box in the results (it should be the first result) and click on "Edit in settings.json". A json file should appear and you will be prompted to the section of the json file with the command prompt lines by file extensions. Namely, you should be looking at something like this:
```json
    "code-runner.executorMapByFileExtension": {


        ".vb": "cd $dir && vbc /nologo $fileName && $dir$fileNameWithoutExt",
        ".vbs": "cscript //Nologo",
        ".scala": "scala",
        ".jl": "julia",
        ".cr": "crystal",
        ".ml": "ocaml",
        ".exs": "elixir",
        ".hx": "haxe --cwd $dirWithoutTrailingSlash --run $fileNameWithoutExt",
        ".rkt": "racket",
        ...
    }
```
To finish the setup, it is enough to add the following line to the top of the list:
```json
        ".sthlp": "runview",
```
The block above will now look like this:
```json
    "code-runner.executorMapByFileExtension": {

        ".sthlp": "runview",
        ".vb": "cd $dir && vbc /nologo $fileName && $dir$fileNameWithoutExt",
        ".vbs": "cscript //Nologo",
        ".scala": "scala",
        ".jl": "julia",
        ".cr": "crystal",
        ".ml": "ocaml",
        ".exs": "elixir",
        ".hx": "haxe --cwd $dirWithoutTrailingSlash --run $fileNameWithoutExt",
        ".rkt": "racket",
        ...
    }
```

Close and reopen VSCode. Now, `runview` should be working inside VSCode. 
Open a .sthlp file inside VSCode (right click on the file -> Open with... -> VSCode, or make it the default program for .sthlp files).
Press `CTRL + ALT + N`. A Stata Window will pop open and you will see the .sthlp file as if it was loaded with the `help` function.

