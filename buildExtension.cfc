component {
  /*
  Totally "borrowed" generateZips() the from https://michaelborn.me/entry/creating-an-ms-access-lucee-extension#JDBC-Is-Awesome

  Also check out https://bitbucket.org/michaelborn_me/ucanaccess/src/master/

  Thank you Michael Born
  */

  function run() {
    generateZips();
  }

  function generateZips() {

    cfzip( action="zip", source="extension", file="#expandPath('lucee-mariadb.zip')#", overwrite="true" );
    cfzip( action="zip", source="extension", file="#expandPath('lucee-mariadb.lex')#", overwrite="true" );

    print.line( "Generated lucee-mariadb.zip and lucee-mariadb.lex" );
    print.line( "Generated lucee-mariadb.zip and lucee-mariadb.lex" );
  }

}