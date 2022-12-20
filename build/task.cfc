component{

	property name="rootPath";

	void function run(rootPath=""){
		if ( isEmpty( arguments.rootPath ) )
			variables.rootPath = fileSystemUtil.resolvePath( "../" );
		else {
			variables.rootPath = arguments.rootPath;
		}
		systemOutput("Build root path: [#variables.rootPath#]", true);
		generateLexFile();
	}

	private void function generateLexFile(){
		zip action="zip" source="#variables.rootPath#extension/" file="#variables.rootPath#lucee-mariadb.lex" overwrite="true";
	}

}