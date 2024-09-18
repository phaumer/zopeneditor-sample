# Z Open Editor Preprocessor samples

This folder augments the [user documentation](https://ibm.github.io/zopeneditor-about/Docs/advanced_preprocessor.html) with examples for running simple COBOL or PL/I Preprocessor examples written in Java as well as REXX for you to try the Z Open Editor preprocessor support. Once you were able to run our sample you should be able to use your own preprocessor in a similar way by replacing the command line and parameters in the ZAPP files.

To be able to use the Z Open Editor Preprocessor feature and this example you need to have imported a valid trial or license key in the Welcome page that activies the feature.

## Local preprocessor examples

### Prepare the sample preprocessor program

To use the sample preprocessor you need to build it using Java. The folder [preprocessor/<COBOL|PLI>/local-preprocessor](./local-preprocessor/) contains a Java Maven project that you can use to build it by running `mvn package` from that folder. Altenatively, use the [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack) to build it from VS Code (Java and Maven required in your path).

### Review the ZAPP file and create ZAPP user or workspace variables

Open the samples [ZAPP file](../zapp.yaml) and find the `local-cobol` or `local-pli` preprocessor profile defined there. It references two variables for executing the preprocessor: `${JAVA_HOME}` and `${WORKSPACE}`. You find placeholders for these two in this [samples workspace settings file](../.vscode/settings.json). Open that file and replace the two values with your absolute `$JAVA_HOME` path and the absolute path of this workspace, i.e. where you cloned this Git repository on your development machine.

Note, that if you are using Windows and have a space in the path (e.g. `Program Files`), you will need to replace the portion of the path that has spaces with the Windows shorthand. Generally, this will be the first 6 non-whitespace characters in the path followed by `~1`, for example, for `Program Files` this would be `Progra~1`, for a directory like `test files` this would be `testfi~1`. If the path is shorter than 6 non-whitespace characters, you will need to use `Cmd` to get the shorthand. To do this, open `Cmd`, go to the directory above the directory you need the shorthand for, e.g. `C:/` for `C:/Program Files`. Run `dir /x`, and the directories will be listed with their shorthands.

Also note the location of the `outputPath` setting in the profile pointing to the directory [preprocessor/output](./output/). This is the folder were the preprocessed programs will be generated in.

### Running the local preprocessor from Z Open Editor

Now you are ready to run the preprocessor on a sample program. Open either the file [preprocessor/COBOL/PrintApp.cbl](./COBOL/PrintApp.cbl) or [preprocessor/PLI/PrintApp.cbl](./PLI/PrintApp.pli). You will see that Z Open Editor will show many syntax errors as it contains macros such as `+ID`, `+DD`, etc. The sample preprocessor will replace them with valid COBOL or Pl/I code behind the covers to enable our language to parse them.

Right-click inside the editor and select "Execute local preprocessor command".

A progress bar will open and as a result all the syntax errors will go away. You can now hover over the preprocessor macros and see the code that has been used to replace them in a hover. For example the `+ID.` COBOL statement will show in the hover that it was replaced with `IDENTIFICATION DIVISION.`. The PL/I `+DL` statement will show a replacement with `DECLARE`.

Open the generated output file [preprocessor/output/PrintApp.cee](./output/PrintApp.cee) in the editor. You see the file generated by the preprocessor, which is a valid COBOL or PL/I program. The Z Open Editor language server will use that program file to parse for errors and overlay the results to the original programs with macros in the editor.

Go back to [preprocessor/COBOL/PrintApp.cbl](./COBOL/PrintApp.cbl) or [preprocessor/PLI/PrintApp.cbl](./PLI/PrintApp.pli) and select "Compare preprocessor input and putput files" from the context menu. It will of a Diff editor showing you the two files and their differences side by side.

## Remote preprocessor example

### Review the ZAPP file and prepare your data sets

To run the remote preprocessor example that performs on z/OS we assume you have created a Zowe Explorer profile for RSE API or z/OSMF and made it your default using the `zopeneditor.zowe": {"profile-name"}` user setting.

Open the samples [ZAPP file](../zapp.yaml) and find the `remote-cobol` or `remote-pli` preprocessor profile defined there. It references several data set names and a `HLQ` variable. Either replace the variabe with your high-level qualifier or define a ZAPP variable in your user or workspace settings.

Create a PDS for `commandDataSet` and `outputDataSet`. You can use the suggested names from the ZAPP or create them using other names and update the ZAPP profile with these names. You also need to create or reuse an existing PDS for the COBOL sample program [preprocessor/COBOL/PrintApp.cbl](./COBOL/PrintApp.cbl), such as `${HLQ}.PREPROC.COBOL` and the equivalent for PL/I. It needs to have the words `COBOL` or `CBL` (`PLI` or `PL1`) in its name so Z Open Editor will use its default file assoications to open the file with the COBOL language server. The sample preprocessor will also create a temporal sequential data set using your HLQ and delete it after completion.

Use Zowe Explorer to upload the REXX sample preprocessor program [preprocessor/remote-preprocessor/CBLPRPC.rexx](./COBOL/remote-preprocessor/CBLPRPC.rexx) to the `commandDataSet` you created in the previous step. Upload the [preprocessor/COBOL/PrintApp.cbl](./COBOL/PrintApp.cbl) to the PDS you have created for it in the previous step, such as `${HLQ}.PREPROC.COBOL`. For Pl/I use the equivalent files.

### Running the remote preprocessor from Z Open Editor

Open the `PRINTAPP` via Zowe Explorer and ensure that it was recognized as a COBOL or PL/I program showing you syntax hightlighting, an outline view, etc. If your PDS does not contain the keywords required then you can click the status bar in VS Code to select `COBOL` as the language to use for this file. The sample program was not processed, yet, so it will show syntax errors.

Right-click inside the editor and select "Execute remote preprocessor command".

A progress bar will open and as a result all the syntax errors will go away. You can now hover over the preprocessor macros and see the code that has been used to replace them in a hover. For example the `+ID.` statement will show in the hover that it was replaced with `IDENTIFICATION DIVISION.`.

Open the generated output file that was created in the `outputDataSet` in the editor. You see the file generated by the preprocessor, which is a valid COBOL program. The Z Open Editor language server will use that program file to parse for errors and overlay the results to the original programs with macros in the editor.