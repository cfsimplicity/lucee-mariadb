<cfscript>
    systemOutput("Building MariaDB extension", true);
    task =  new Task();
    //new task().run( getDirectoryFromPath( getDirectoryFromPath( getDirectoryFromPath( getCurrentTemplatePath() ) ) ) ); 
    task.run( expandPath("../" ) ); 

    systemOutput("Finished building extension", true);
</cfscript>