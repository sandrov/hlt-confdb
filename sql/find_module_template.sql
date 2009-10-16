COLUMN CVSTAG    FORMAT A10;
COLUMN SUBSYSTEM FORMAT A16;
COLUMN PACKAGE   FORMAT A16;
COLUMN PLUGIN    FORMAT A24;

SELECT
  MODULETEMPLATES.SUPERID,
  MODULETEMPLATES.CVSTAG,
  SOFTWARESUBSYSTEMS.NAME AS SUBSYSTEM,
  SOFTWAREPACKAGES.NAME AS PACKAGE,
  MODULETEMPLATES.NAME AS PLUGIN
FROM
  MODULETEMPLATES
JOIN
  SOFTWAREPACKAGES ON SOFTWAREPACKAGES.PACKAGEID = MODULETEMPLATES.PACKAGEID
JOIN
  SOFTWARESUBSYSTEMS ON SOFTWARESUBSYSTEMS.SUBSYSID = SOFTWAREPACKAGES.SUBSYSID
JOIN
  SUPERIDRELEASEASSOC ON SUPERIDRELEASEASSOC.SUPERID = MODULETEMPLATES.SUPERID
JOIN
  SOFTWARERELEASES ON SOFTWARERELEASES.RELEASEID = SUPERIDRELEASEASSOC.RELEASEID
WHERE
  SOFTWARERELEASES.RELEASETAG= '&1' AND
  MODULETEMPLATES.NAME       = '&2';
