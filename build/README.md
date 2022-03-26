# Upgrading the driver

1. Download the new jar from https://mariadb.com/downloads/#connectors selecting the Java 8 stable connector
2. Add the jar to the `/extension/jars` folder and remove the previous version
3. Update `/extension/META-INF/MANIFEST.MF` with new version number and date.
4. Update `box.json` with new version number.
5. Open CommandBox in the this `build` directory and execute:
```
task run
```