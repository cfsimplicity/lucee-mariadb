component{

	property name="rootPath";

	void function run(){
		variables.rootPath = fileSystemUtil.resolvePath( "../" );
		generateLexFile();
	}

	private void function generateLexFile(){
		zip action="zip" source="#variables.rootPath#extension/" file="#variables.rootPath#lucee-mariadb.lex" overwrite="true";
	}

}