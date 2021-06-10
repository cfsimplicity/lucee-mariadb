component{

	property name="rootPath";

	void function run(){
		variables.rootPath = fileSystemUtil.resolvePath( "../" );
		generateZips();
	}

	private void function generateZips(){
		zip action="zip" source="#variables.rootPath#extension/" file="#variables.rootPath#lucee-mariadb.zip" overwrite="true";
		zip action="zip" source="#variables.rootPath#extension/" file="#variables.rootPath#lucee-mariadb.lex" overwrite="true";
	}

}