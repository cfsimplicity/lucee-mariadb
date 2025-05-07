# Upgrading the driver

1) On develop branch
* Download the new jar from https://mariadb.com/downloads/connectors/ selecting the Java 8+ GA connector
* Add the jar to the `/extension/jars` folder and remove the previous version
* Update `/extension/META-INF/MANIFEST.MF` with new version number and date.
* Update `box.json` with new version number.
* Open CommandBox in the this `build` directory and execute:
```
task run
```
* Upload .lex file to testing instance and run tests
* Commit changes as Upgrade driver to x.x.x
2) Switch to main branch
* Merge/commit from latest develop commit
* Add tag vx.x.x
* Push to Github
3) In Github
* Releases > Draft new release
* Enter vx.x.x @ target:main
* Title: vx.x.x
* Description: Update driver to x.x.x
* Attach the generated .lex binary
* Publish
4) Publish to ForgeBox
* CD in CommandBox to the root directory and execute: publish
5) Switch to develop branch
* Push to Github