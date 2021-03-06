--
-- CMS High Level Trigger Configuration Database Schema: MySQL
-- -----------------------------------------------------------
--
-- CREATED:
-- 12/12/2006 Philipp Schieferdecker <philipp.schieferdecker@cern.ch>
--

-- create the database
DROP DATABASE IF EXISTS hltdb;
CREATE DATABASE hltdb;
USE hltdb;

-- TABLE 'SoftwareReleases'
CREATE TABLE SoftwareReleases
(
	releaseId  	BIGINT UNSIGNED   NOT NULL AUTO_INCREMENT UNIQUE,
	releaseTag     	VARCHAR(32)       NOT NULL UNIQUE,
	PRIMARY KEY(releaseId)
) ENGINE=INNODB;

-- TABLE 'SoftwareSubsystems'
CREATE TABLE SoftwareSubsystems
(
	subsysId	BIGINT UNSIGNED	  NOT NULL AUTO_INCREMENT UNIQUE,
	name		VARCHAR(64)	  NOT NULL,
	PRIMARY KEY(subsysId)
) ENGINE=INNODB;

-- TABLE 'SoftwarePackages'
CREATE TABLE SoftwarePackages
(
	packageId	BIGINT UNSIGNED	  NOT NULL AUTO_INCREMENT UNIQUE,
	subsysId	BIGINT UNSIGNED	  NOT NULL,
	name		VARCHAR(64)	  NOT NULL,
	PRIMARY KEY(packageId),
	FOREIGN KEY(subsysId) REFERENCES SoftwareSubsystems(subsysId)
) ENGINE=INNODB;

-- TABLE 'Directories'
CREATE TABLE Directories
(
	dirId		BIGINT UNSIGNED   NOT NULL AUTO_INCREMENT UNIQUE,
	parentDirId     BIGINT UNSIGNED,
        dirName         VARCHAR(512)      NOT NULL UNIQUE,
	created		TIMESTAMP         NOT NULL,
	PRIMARY KEY(dirId),
	FOREIGN KEY(parentDirId) REFERENCES Directories(dirId)
) ENGINE=INNODB;

-- TABLE 'Configurations'
CREATE TABLE Configurations
(
	configId   	BIGINT UNSIGNED   NOT NULL AUTO_INCREMENT UNIQUE,
	releaseId	BIGINT UNSIGNED	  NOT NULL,
	configDescriptor VARCHAR(512)     NOT NULL UNIQUE,
	parentDirId     BIGINT UNSIGNED   NOT NULL,
	config     	VARCHAR(128)      NOT NULL,
	version         SMALLINT UNSIGNED NOT NULL,
	created         TIMESTAMP         NOT NULL,
	creator		VARCHAR(128)	  NOT NULL,
	processName	VARCHAR(32)	  NOT NULL,
	description     VARCHAR(1024)     DEFAULT NULL,
	UNIQUE (parentDirId,config,version),
	PRIMARY KEY(configId),
	FOREIGN KEY(releaseId)   REFERENCES SoftwareReleases(releaseId),
	FOREIGN KEY(parentDirId) REFERENCES Directories(dirId)
) ENGINE=INNODB;

-- TABLE'LockedConfigurations'
CREATE TABLE LockedConfigurations
(
	parentDirId	BIGINT UNSIGNED	  NOT NULL,
	config		VARCHAR(128)	  NOT NULL,
	userName        VARCHAR(128)      NOT NULL,
	UNIQUE (parentDirId,config),
	FOREIGN KEY(parentDirId) REFERENCES Directories(dirId)
) ENGINE=INNODB;

-- TABLE 'Streams'
CREATE Table Streams
(
	streamId	BIGINT UNSIGNED	  NOT NULL AUTO_INCREMENT UNIQUE,
	streamLabel	VARCHAR(128)	  NOT NULL UNIQUE,
	PRIMARY KEY(streamId)
) ENGINE=INNODB;

-- TABLE 'PrimaryDatasets'
CREATE Table PrimaryDatasets
(
	datasetId	BIGINT UNSIGNED	  NOT NULL AUTO_INCREMENT UNIQUE,
	datasetLabel	VARCHAR(128)	  NOT NULL UNIQUE,
	PRIMARY KEY(datasetId)
) ENGINE=INNODB;

-- TABLE 'SuperIds'
CREATE TABLE SuperIds
(
	superId    	BIGINT UNSIGNED   NOT NULL AUTO_INCREMENT UNIQUE,
	PRIMARY KEY(superId)
) ENGINE=INNODB;

-- TABLE 'SuperIdReleaseAssoc'
CREATE TABLE SuperIdReleaseAssoc
(
	superId    	BIGINT UNSIGNED   NOT NULL,
	releaseId  	BIGINT UNSIGNED   NOT NULL,
	UNIQUE(superId,releaseId),
	FOREIGN KEY(superId)   REFERENCES SuperIds(superId),
	FOREIGN KEY(releaseId) REFERENCES SoftwareReleases(releaseId)
) ENGINE=INNODB;

-- TABLE 'Paths'
CREATE TABLE Paths
(
	pathId     	BIGINT UNSIGNED   NOT NULL AUTO_INCREMENT UNIQUE,
	name       	VARCHAR(128)      NOT NULL,
	isEndPath       BOOL              NOT NULL DEFAULT false,
	PRIMARY KEY(pathId)
) ENGINE=INNODB;

-- TABLE 'ConfigurationPathAssoc'
CREATE TABLE ConfigurationPathAssoc
(
	configId	BIGINT UNSIGNED   NOT NULL,
	pathId          BIGINT UNSIGNED   NOT NULL,
	sequenceNb      SMALLINT UNSIGNED NOT NULL,
	UNIQUE(configId,sequenceNb),
	PRIMARY KEY(configId,pathId),
	FOREIGN KEY(configID) REFERENCES Configurations(configId),
	FOREIGN KEY(pathId)   REFERENCES Paths(pathId)
) ENGINE=INNODB;

-- TABLE 'PathInPathAssoc'
CREATE TABLE PathInPathAssoc
(
	parentPathId	BIGINT UNSIGNED   NOT NULL,
	childPathId	BIGINT UNSIGNED   NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	operator	SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	UNIQUE(parentPathId,sequenceNb),
	PRIMARY KEY(parentPathId,childPathId),
	FOREIGN KEY(parentPathId) REFERENCES Paths(pathId),
	FOREIGN KEY(childPathId)  REFERENCES Paths(pathId)
) ENGINE=INNODB;

-- TABLE 'ConfigurationStreamAssoc'
CREATE TABLE ConfigurationStreamAssoc
(
	configId	BIGINT UNSIGNED   NOT NULL,
	streamId	BIGINT UNSIGNED	  NOT NULL,
	datasetId       BIGINT UNSIGNED   NOT NULL,
	PRIMARY KEY(configId,streamId,datasetId),
	FOREIGN KEY(configId) REFERENCES Configurations(configId),
	FOREIGN KEY(streamId) REFERENCES Streams(streamId),
	FOREIGN KEY(datasetId)REFERENCES PrimaryDatasets(datasetId)
) ENGINE=INNODB;

-- TABLE 'StreamPathAssoc'
CREATE TABLE StreamPathAssoc
(
	streamId	BIGINT UNSIGNED	  NOT NULL,
	pathId		BIGINT UNSIGNED   NOT NULL,
	PRIMARY KEY(streamId,pathId),
	FOREIGN KEY(streamId) REFERENCES Streams(streamId),
	FOREIGN KEY(pathId)   REFERENCES Paths(pathId)
) ENGINE=INNODB;

-- TABLE 'PrimaryDatasetPathAssoc'
CREATE TABLE PrimaryDatasetPathAssoc
(
	datasetId	BIGINT UNSIGNED	  NOT NULL,
	pathId		BIGINT UNSIGNED   NOT NULL,
	PRIMARY KEY(datasetId,pathId),
	FOREIGN KEY(datasetId) REFERENCES PrimaryDatasets(datasetId),
	FOREIGN KEY(pathId)    REFERENCES Paths(pathId)
) ENGINE=INNODB;

-- TABLE 'Sequences'
CREATE TABLE Sequences
(
	sequenceId	BIGINT UNSIGNED	  NOT NULL AUTO_INCREMENT UNIQUE,
	name		VARCHAR(128)	  NOT NULL,
	PRIMARY KEY(sequenceId)
) ENGINE=INNODB;

-- TABLE 'ConfigurationSequenceAssoc'
CREATE TABLE ConfigurationSequenceAssoc
(
	configId	BIGINT UNSIGNED	  NOT NULL,
	sequenceId	BIGINT UNSIGNED	  NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	UNIQUE(configId,sequenceNb),
	PRIMARY KEY(configId,sequenceId),
	FOREIGN KEY(configId)   REFERENCES Configurations(configId),
	FOREIGN KEY(sequenceId) REFERENCES Sequences(sequenceId)
) ENGINE=INNODB;

-- TABLE 'PathSequenceAssoc'
CREATE TABLE PathSequenceAssoc
(
	pathId		BIGINT UNSIGNED   NOT NULL,
	sequenceId	BIGINT UNSIGNED   NOT NULL,
	sequenceNb      SMALLINT UNSIGNED NOT NULL,
	operator	SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	UNIQUE(pathId,sequenceNb),
	PRIMARY KEY(pathId,sequenceId),
	FOREIGN KEY(pathId)     REFERENCES Paths(pathId),
	FOREIGN KEY(sequenceId) REFERENCES Sequences(sequenceId)
) ENGINE=INNODB;

-- TABLE 'SequenceInSequenceAssoc'
CREATE TABLE SequenceInSequenceAssoc
(
	parentSequenceId BIGINT UNSIGNED   NOT NULL,
	childSequenceId	 BIGINT UNSIGNED   NOT NULL,
	sequenceNb	 SMALLINT UNSIGNED NOT NULL,
	operator	 SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	UNIQUE(parentSequenceId,sequenceNb),
	PRIMARY KEY(parentSequenceId,childSequenceId),
	FOREIGN KEY (parentSequenceId) REFERENCES Sequences(sequenceId),
	FOREIGN KEY (childSequenceId)  REFERENCES Sequences(sequenceId)
) ENGINE=INNODB;



--
-- SERVICES
--

-- TABLE 'ServiceTemplates'
CREATE TABLE ServiceTemplates
(
	superId  	BIGINT UNSIGNED   NOT NULL UNIQUE,
	name       	VARCHAR(128)      NOT NULL,
	cvstag       	VARCHAR(32)       NOT NULL,
	packageId       BIGINT UNSIGNED   NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId)   REFERENCES SuperIds(superId),
	FOREIGN KEY(packageId) REFERENCES SoftwarePackages(packageId)
) ENGINE=INNODB;

-- TABLE 'Services'
CREATE TABLE Services
(
	superId      	BIGINT UNSIGNED   NOT NULL UNIQUE,
	templateId     	BIGINT UNSIGNED   NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId)    REFERENCES SuperIds(superId) ON DELETE CASCADE,
	FOREIGN KEY(templateId) REFERENCES ServiceTemplates(superId)
) ENGINE=INNODB;

-- TABLE 'ConfigurationServiceAssoc'
CREATE TABLE ConfigurationServiceAssoc
(
	configId	BIGINT UNSIGNED	  NOT NULL,
	serviceId       BIGINT UNSIGNED   NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	UNIQUE(configId,sequenceNb),
	PRIMARY KEY(configId,serviceId),
	FOREIGN KEY(configId)  REFERENCES Configurations(configId),
	FOREIGN KEY(serviceId) REFERENCES SuperIds(superId)
) ENGINE=INNODB;


--
-- EDSOURCES
--

-- TABLE 'EDSourceTemplates'
CREATE TABLE EDSourceTemplates
(
	superId  	BIGINT UNSIGNED   NOT NULL UNIQUE,
	name       	VARCHAR(128)      NOT NULL,
	cvstag       	VARCHAR(32)       NOT NULL,
	packageId	BIGINT UNSIGNED	  NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId)   REFERENCES SuperIds(superId),
	FOREIGN KEY(packageId) REFERENCES SoftwarePackages(packageId)
) ENGINE=INNODB;

-- TABLE 'EDSources'
CREATE TABLE EDSources
(
	superId      	BIGINT UNSIGNED   NOT NULL UNIQUE,
	templateId     	BIGINT UNSIGNED   NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId)    REFERENCES SuperIds(superId) ON DELETE CASCADE,
	FOREIGN KEY(templateId) REFERENCES EDSourceTemplates(superId)
) ENGINE=INNODB;

-- TABLE 'ConfigurationEDSourceAssoc'
CREATE TABLE ConfigurationEDSourceAssoc
(
	configId	BIGINT UNSIGNED	  NOT NULL,
	edsourceId      BIGINT UNSIGNED   NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	UNIQUE(configId,sequenceNb),
	PRIMARY KEY(configId,edsourceId),
	FOREIGN KEY(configId)   REFERENCES Configurations(configId),
	FOREIGN KEY(edsourceId) REFERENCES SuperIds(superId)
) ENGINE=INNODB;



--
-- ESSOURCES
--

-- TABLE 'ESSourceTemplates'
CREATE TABLE ESSourceTemplates
(
	superId  	BIGINT UNSIGNED   NOT NULL UNIQUE,
	name       	VARCHAR(128)      NOT NULL,
	cvstag       	VARCHAR(32)       NOT NULL,
	packageId	BIGINT UNSIGNED	  NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId)   REFERENCES SuperIds(superId),
	FOREIGN KEY(packageId) REFERENCES SoftwarePackages(packageId)
) ENGINE=INNODB;

-- TABLE 'ESSources'
CREATE TABLE ESSources
(
	superId      	BIGINT UNSIGNED   NOT NULL UNIQUE,
	templateId     	BIGINT UNSIGNED   NOT NULL,
	name       	VARCHAR(128)	  NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId)    REFERENCES SuperIds(superId) ON DELETE CASCADE,
	FOREIGN KEY(templateId) REFERENCES ESSourceTemplates(superId)
) ENGINE=INNODB;

-- TABLE 'ConfigurationESSourceAssoc'
CREATE TABLE ConfigurationESSourceAssoc
(
	configId	BIGINT UNSIGNED	  NOT NULL,
	essourceId      BIGINT UNSIGNED   NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	prefer		BOOLEAN		  NOT NULL DEFAULT false,
	UNIQUE(configId,sequenceNb),
	PRIMARY KEY(configId,essourceId),
	FOREIGN KEY(configId)   REFERENCES Configurations(configId),
	FOREIGN KEY(essourceId) REFERENCES SuperIds(superId)
) ENGINE=INNODB;


--
-- ESMODULES
--

-- TABLE 'ESModuleTemplates'
CREATE TABLE ESModuleTemplates
(
	superId  	BIGINT UNSIGNED   NOT NULL UNIQUE,
	name       	VARCHAR(128)      NOT NULL,
	cvstag       	VARCHAR(32)       NOT NULL,
	packageId	BIGINT UNSIGNED	  NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId)   REFERENCES SuperIds(superId),
	FOREIGN KEY(packageId) REFERENCES SoftwarePackages(packageId)
) ENGINE=INNODB;

-- TABLE 'ESModules'
CREATE TABLE ESModules
(
	superId      	BIGINT UNSIGNED   NOT NULL UNIQUE,
	templateId     	BIGINT UNSIGNED   NOT NULL,
	name       	VARCHAR(128)	  NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId)    REFERENCES SuperIds(superId) ON DELETE CASCADE,
	FOREIGN KEY(templateId) REFERENCES ESModuleTemplates(superId)
) ENGINE=INNODB;

-- TABLE 'ConfigurationESModuleAssoc'
CREATE TABLE ConfigurationESModuleAssoc
(
	configId	BIGINT UNSIGNED	  NOT NULL,
	esmoduleId      BIGINT UNSIGNED   NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	prefer		BOOLEAN		  NOT NULL DEFAULT false,
	UNIQUE(configId,sequenceNb),
	PRIMARY KEY(configId,esmoduleId),
	FOREIGN KEY(configId)   REFERENCES Configurations(configId),
	FOREIGN KEY(esmoduleId) REFERENCES SuperIds(superId)
) ENGINE=INNODB;



--
-- MODULES
--

-- TABLE 'ModuleTypes'
CREATE TABLE ModuleTypes
(
	typeId 		BIGINT UNSIGNED    NOT NULL AUTO_INCREMENT UNIQUE,
	type   		VARCHAR(32)        NOT NULL UNIQUE,
	PRIMARY KEY(typeId)
) ENGINE=INNODB;

-- TABLE 'ModuleTemplates'
CREATE TABLE ModuleTemplates
(
	superId  	BIGINT UNSIGNED   NOT NULL UNIQUE,
	typeId  	BIGINT UNSIGNED   NOT NULL,
	name       	VARCHAR(128)      NOT NULL,
	cvstag       	VARCHAR(32)       NOT NULL,
	packageId	BIGINT UNSIGNED	  NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId)   REFERENCES SuperIds(superId),
	FOREIGN KEY(typeId)    REFERENCES ModuleTypes(typeId),
	FOREIGN KEY(packageId) REFERENCES SoftwarePackages(packageId)
) ENGINE=INNODB;

-- TABLE 'Modules'
CREATE TABLE Modules
(
	superId   	BIGINT UNSIGNED   NOT NULL UNIQUE,
	templateId  	BIGINT UNSIGNED   NOT NULL,
	name       	VARCHAR(128)      NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId)    REFERENCES SuperIds(superId) ON DELETE CASCADE,
	FOREIGN KEY(templateId) REFERENCES ModuleTemplates(superId)
) ENGINE=INNODB;

-- TABLE 'PathModuleAssoc'
CREATE TABLE PathModuleAssoc
(
	pathId     	BIGINT UNSIGNED   NOT NULL,
        moduleId   	BIGINT UNSIGNED   NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	operator	SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	UNIQUE(pathId,sequenceNb),
	PRIMARY KEY(pathId,moduleId),
	FOREIGN KEY(pathId)   REFERENCES Paths(pathId),
	FOREIGN KEY(moduleId) REFERENCES Modules(superId)
) ENGINE=INNODB;

-- TABLE 'SequenceModuleAssoc'
CREATE TABLE SequenceModuleAssoc
(
	sequenceId     	BIGINT UNSIGNED   NOT NULL,
        moduleId   	BIGINT UNSIGNED   NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	operator	SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	UNIQUE(sequenceId,sequenceNb),
	PRIMARY KEY(sequenceId,moduleId),
	FOREIGN KEY(sequenceId) REFERENCES Sequences(sequenceId),
	FOREIGN KEY(moduleId)   REFERENCES Modules(superId)
) ENGINE=INNODB;


--
-- PARAMETER SETS
--

-- TABLE 'ParameterSets'
CREATE TABLE ParameterSets
(
	superId		BIGINT UNSIGNED	  NOT NULL UNIQUE,
	name		VARCHAR(128)	  NOT NULL,
	tracked         BOOLEAN           NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId) REFERENCES SuperIds(superId) ON DELETE CASCADE
) ENGINE=INNODB;

--TABLE 'VecParameterSets'
CREATE TABLE VecParameterSets
(
	superId		BIGINT UNSIGNED   NOT NULL UNIQUE,
	name		VARCHAR(128)	  NOT NULL,
	tracked         BOOLEAN           NOT NULL,
	PRIMARY KEY(superId),
	FOREIGN KEY(superId) REFERENCES SuperIds(superId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'ConfigurationParamSetAssoc'
CREATE TABLE ConfigurationParamSetAssoc
(
	configId	BIGINT UNSIGNED	  NOT NULL,
	psetId		BIGINT UNSIGNED	  NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	UNIQUE(configId,sequenceNb),
	PRIMARY KEY(configId,psetId),
	FOREIGN KEY(configId) REFERENCES Configurations(configId),
	FOREIGN KEY(psetId)   REFERENCES ParameterSets(superId)
) ENGINE=INNODB;

-- TABLE 'SuperIdParamSetAssoc'
CREATE TABLE SuperIdParamSetAssoc
(
	superId		BIGINT UNSIGNED	  NOT NULL,
	psetId		BIGINT UNSIGNED	  NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	UNIQUE(superId,sequenceNb),
	PRIMARY KEY(superId,psetId),
	FOREIGN KEY(superId) REFERENCES SuperIds(superId),
	FOREIGN KEY(psetId)  REFERENCES ParameterSets(superId)
) ENGINE=INNODB;

-- TABLE 'SuperIdVecParamSetAssoc'
CREATE TABLE SuperIdVecParamSetAssoc
(
	superId		BIGINT UNSIGNED	  NOT NULL,
	vpsetId	        BIGINT UNSIGNED	  NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	UNIQUE(superId,sequenceNb),
	PRIMARY KEY(superId,vpsetId),
	FOREIGN KEY(superId) REFERENCES SuperIds(superId),
	FOREIGN KEY(vpsetId) REFERENCES VecParameterSets(superId)
) ENGINE=INNODB;


--
-- PARAMETERS
--

-- TABLE 'ParameterTypes'
CREATE TABLE ParameterTypes
(
	paramTypeId	BIGINT UNSIGNED   NOT NULL AUTO_INCREMENT UNIQUE,
	paramType       VARCHAR(32)       NOT NULL UNIQUE,
	PRIMARY KEY(paramTypeId)
) ENGINE=INNODB;

-- TABLE 'Parameters'
CREATE TABLE Parameters
(
	paramId    	BIGINT UNSIGNED   NOT NULL AUTO_INCREMENT UNIQUE,
	paramTypeId    	BIGINT UNSIGNED   NOT NULL,
	name       	VARCHAR(128)      NOT NULL,
	tracked         BOOLEAN           NOT NULL,
	PRIMARY KEY(paramId),
	FOREIGN KEY(paramTypeId) REFERENCES ParameterTypes(paramTypeId)
) ENGINE=INNODB;

-- TABLE 'SuperIdParameterAssoc'
CREATE TABLE SuperIdParameterAssoc
(
	superId		BIGINT UNSIGNED	  NOT NULL,
	paramId		BIGINT UNSIGNED	  NOT NULL,
	sequenceNb	SMALLINT UNSIGNED NOT NULL,
	UNIQUE(superId,sequenceNb),
	PRIMARY KEY(superId,paramId),
	FOREIGN KEY(superId) REFERENCES SuperIds(superId),
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId)
) ENGINE=INNODB;

-- TABLE 'Int32ParamValues'
CREATE TABLE Int32ParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL UNIQUE,
	value      	BIGINT            NOT NULL,
	hex		BOOLEAN           NOT NULL DEFAULT false,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'VInt32ParamValues'
CREATE TABLE VInt32ParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	sequenceNb 	SMALLINT UNSIGNED NOT NULL,
	value      	BIGINT            NOT NULL,
	hex		BOOLEAN		  NOT NULL DEFAULT false,
	UNIQUE(paramId,sequenceNb),
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'UInt32ParamValues'
CREATE TABLE UInt32ParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL UNIQUE,
	value      	BIGINT UNSIGNED   NOT NULL,
        hex		BOOLEAN		  NOT NULL DEFAULT false,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'VUInt32ParamValues'
CREATE TABLE VUInt32ParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	sequenceNb 	SMALLINT UNSIGNED NOT NULL,
	value      	BIGINT UNSIGNED   NOT NULL,
	hex		BOOLEAN		  NOT NULL DEFAULT false,
	UNIQUE(paramId,sequenceNb),
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'Int64ParamValues'
CREATE TABLE Int64ParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL UNIQUE,
	value      	BIGINT            NOT NULL,
	hex		BOOLEAN           NOT NULL DEFAULT false,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'VInt64ParamValues'
CREATE TABLE VInt64ParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	sequenceNb 	SMALLINT UNSIGNED NOT NULL,
	value      	BIGINT            NOT NULL,
	hex		BOOLEAN		  NOT NULL DEFAULT false,
	UNIQUE(paramId,sequenceNb),
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'UInt64ParamValues'
CREATE TABLE UInt64ParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL UNIQUE,
	value      	BIGINT UNSIGNED   NOT NULL,
        hex		BOOLEAN		  NOT NULL DEFAULT false,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'VUInt64ParamValues'
CREATE TABLE VUInt64ParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	sequenceNb 	SMALLINT UNSIGNED NOT NULL,
	value      	BIGINT UNSIGNED   NOT NULL,
	hex		BOOLEAN		  NOT NULL DEFAULT false,
	UNIQUE(paramId,sequenceNb),
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'BoolParamValues'
CREATE TABLE BoolParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL UNIQUE,
	value      	BOOLEAN           NOT NULL,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'DoubleParamValues'
CREATE TABLE DoubleParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL UNIQUE,
	value      	REAL              NOT NULL,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'VDoubleParamValues'
CREATE TABLE VDoubleParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	sequenceNb 	SMALLINT UNSIGNED NOT NULL,
	value      	REAL              NOT NULL,
	UNIQUE(paramId,sequenceNb),
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'StringParamValues'
CREATE TABLE StringParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL UNIQUE,
	value      	VARCHAR(1024)     NOT NULL,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'VStringParamValues'
CREATE TABLE VStringParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	sequenceNb 	SMALLINT UNSIGNED NOT NULL,
	value      	VARCHAR(1024)     NOT NULL,
	UNIQUE(paramId,sequenceNb),
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'InputTagParamValues'
CREATE TABLE InputTagParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	value      	VARCHAR(128)      NOT NULL,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'VInputTagParamValues'
CREATE TABLE VInputTagParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	sequenceNb 	SMALLINT UNSIGNED NOT NULL,
	value      	VARCHAR(128)      NOT NULL,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'EventIDParamValues'
CREATE TABLE EventIDParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	value      	VARCHAR(32)       NOT NULL,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'VEventIDParamValues'
CREATE TABLE VEventIDParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	sequenceNb 	SMALLINT UNSIGNED NOT NULL,
	value      	VARCHAR(32)       NOT NULL,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;

-- TABLE 'FileInPathParamValues'
CREATE TABLE FileInPathParamValues
(
	paramId    	BIGINT UNSIGNED   NOT NULL,
	value      	VARCHAR(512)      NOT NULL,
	FOREIGN KEY(paramId) REFERENCES Parameters(paramId) ON DELETE CASCADE
) ENGINE=INNODB;


--
-- INSERTs
-- 

-- INSERT root directory
INSERT INTO Directories (parentDirId,dirName,created) VALUES(null,"/",NOW());

-- INSERT valid module types
INSERT INTO ModuleTypes (type) VALUES("EDProducer");
INSERT INTO ModuleTypes (type) VALUES("EDFilter");
INSERT INTO ModuleTypes (type) VALUES("EDAnalyzer");
INSERT INTO ModuleTypes (type) VALUES("HLTProducer");
INSERT INTO ModuleTypes (type) VALUES("HLTFilter");
INSERT INTO ModuleTypes (type) VALUES("OutputModule");


-- INSERT valid parameter types
INSERT INTO ParameterTypes (paramType) VALUES("bool");
INSERT INTO ParameterTypes (paramType) VALUES("int32");
INSERT INTO ParameterTypes (paramType) VALUES("vint32");
INSERT INTO ParameterTypes (paramType) VALUES("uint32");
INSERT INTO ParameterTypes (paramType) VALUES("vuint32");
INSERT INTO ParameterTypes (paramType) VALUES("double");
INSERT INTO ParameterTypes (paramType) VALUES("vdouble");
INSERT INTO ParameterTypes (paramType) VALUES("string");
INSERT INTO ParameterTypes (paramType) VALUES("vstring");
INSERT INTO ParameterTypes (paramType) VALUES("InputTag");
INSERT INTO ParameterTypes (paramType) VALUES("VInputTag");
INSERT INTO ParameterTypes (paramType) VALUES("EventID");
INSERT INTO ParameterTypes (paramType) VALUES("VEventID");
INSERT INTO ParameterTypes (paramType) VALUES("FileInPath");
INSERT INTO ParameterTypes (paramType) VALUES("int64");
INSERT INTO ParameterTypes (paramType) VALUES("vint64");
INSERT INTO ParameterTypes (paramType) VALUES("uint64");
INSERT INTO ParameterTypes (paramType) VALUES("vuint64");


-- CREATE PROCEDURES
source hlt_create_procedures_MYSQL.sql;
