--
-- create synonyms CMS_HLT.TableName -> TableName
--

CREATE SYNONYM SuperIdReleaseAssoc 		FOR CMS_HLT.SuperIdReleaseAssoc; 	
CREATE SYNONYM SoftwareReleases 		FOR CMS_HLT.SoftwareReleases;		
CREATE SYNONYM SoftwareSubsystems 		FOR CMS_HLT.SoftwareSubsystems;
CREATE SYNONYM SoftwarePackages 		FOR CMS_HLT.SoftwarePackages;
CREATE SYNONYM ConfigurationPathAssoc 		FOR CMS_HLT.ConfigurationPathAssoc; 	
CREATE SYNONYM StreamPathAssoc	 		FOR CMS_HLT.StreamPathAssoc; 	
CREATE SYNONYM PathInPathAssoc 			FOR CMS_HLT.PathInPathAssoc; 		
CREATE SYNONYM PathModuleAssoc 			FOR CMS_HLT.PathModuleAssoc; 		 
CREATE SYNONYM ConfigurationSequenceAssoc 	FOR CMS_HLT.ConfigurationSequenceAssoc;
CREATE SYNONYM PathSequenceAssoc 		FOR CMS_HLT.PathSequenceAssoc; 	
CREATE SYNONYM SequenceInSequenceAssoc 		FOR CMS_HLT.SequenceInSequenceAssoc;
CREATE SYNONYM SequenceModuleAssoc 		FOR CMS_HLT.SequenceModuleAssoc;
CREATE SYNONYM ConfigurationServiceAssoc 	FOR CMS_HLT.ConfigurationServiceAssoc;
CREATE SYNONYM ConfigurationEDSourceAssoc 	FOR CMS_HLT.ConfigurationEDSourceAssoc;
CREATE SYNONYM ConfigurationESSourceAssoc 	FOR CMS_HLT.ConfigurationESSourceAssoc;
CREATE SYNONYM ConfigurationESModuleAssoc 	FOR CMS_HLT.ConfigurationESModuleAssoc;
CREATE SYNONYM ConfigurationParamSetAssoc 	FOR CMS_HLT.ConfigurationParamSetAssoc;
CREATE SYNONYM Paths 				FOR CMS_HLT.Paths;
CREATE SYNONYM Sequences 			FOR CMS_HLT.Sequences;
CREATE SYNONYM Services 			FOR CMS_HLT.Services;
CREATE SYNONYM ServiceTemplates 		FOR CMS_HLT.ServiceTemplates;
CREATE SYNONYM EDSources 			FOR CMS_HLT.EDSources;
CREATE SYNONYM EDSourceTemplates 		FOR CMS_HLT.EDSourceTemplates;
CREATE SYNONYM ESSources 			FOR CMS_HLT.ESSources;
CREATE SYNONYM ESSourceTemplates 		FOR CMS_HLT.ESSourceTemplates;
CREATE SYNONYM ESModules 			FOR CMS_HLT.ESModules;
CREATE SYNONYM ESModuleTemplates 		FOR CMS_HLT.ESModuleTemplates;
CREATE SYNONYM Modules 				FOR CMS_HLT.Modules;
CREATE SYNONYM ModuleTemplates		 	FOR CMS_HLT.ModuleTemplates;
CREATE SYNONYM ModuleTypes 			FOR CMS_HLT.ModuleTypes;
CREATE SYNONYM Configurations 			FOR CMS_HLT.Configurations;
CREATE SYNONYM LockedConfigurations		FOR CMS_HLT.LockedConfigurations;
CREATE SYNONYM Streams	 			FOR CMS_HLT.Streams;
CREATE SYNONYM Directories 			FOR CMS_HLT.Directories;
CREATE SYNONYM Int32ParamValues 		FOR CMS_HLT.Int32ParamValues;
CREATE SYNONYM VInt32ParamValues 		FOR CMS_HLT.VInt32ParamValues;
CREATE SYNONYM UInt32ParamValues 		FOR CMS_HLT.UInt32ParamValues;
CREATE SYNONYM VUInt32ParamValues 		FOR CMS_HLT.VUInt32ParamValues;
CREATE SYNONYM BoolParamValues 			FOR CMS_HLT.BoolParamValues;
CREATE SYNONYM DoubleParamValues	 	FOR CMS_HLT.DoubleParamValues;
CREATE SYNONYM VDoubleParamValues 		FOR CMS_HLT.VDoubleParamValues;
CREATE SYNONYM StringParamValues 		FOR CMS_HLT.StringParamValues;
CREATE SYNONYM VStringParamValues	 	FOR CMS_HLT.VStringParamValues;
CREATE SYNONYM InputTagParamValues 		FOR CMS_HLT.InputTagParamValues;
CREATE SYNONYM VInputTagParamValues 		FOR CMS_HLT.VInputTagParamValues;
CREATE SYNONYM EventIDParamValues 		FOR CMS_HLT.EventIDParamValues;
CREATE SYNONYM VEventIDParamValues 		FOR CMS_HLT.VEventIDParamValues;
CREATE SYNONYM FileInPathParamValues 		FOR CMS_HLT.FileInPathParamValues;
CREATE SYNONYM SuperIdParameterAssoc 		FOR CMS_HLT.SuperIdParameterAssoc;
CREATE SYNONYM SuperIdParamSetAssoc 		FOR CMS_HLT.SuperIdParamSetAssoc;
CREATE SYNONYM SuperIdVecParamSetAssoc 		FOR CMS_HLT.SuperIdVecParamSetAssoc;
CREATE SYNONYM ParameterSets 			FOR CMS_HLT.ParameterSets;
CREATE SYNONYM VecParameterSets 		FOR CMS_HLT.VecParameterSets;
CREATE SYNONYM Parameters 			FOR CMS_HLT.Parameters;
CREATE SYNONYM SuperIds 			FOR CMS_HLT.SuperIds;
CREATE SYNONYM ParameterTypes 			FOR CMS_HLT.ParameterTypes;

CREATE SYNONYM ReleaseId_Sequence 		FOR CMS_HLT.ReleaseId_Sequence;
CREATE SYNONYM SubsysId_Sequence 		FOR CMS_HLT.SubsysId_Sequence;
CREATE SYNONYM PackageId_Sequence 		FOR CMS_HLT.PackageId_Sequence;
CREATE SYNONYM DirId_Sequence 			FOR CMS_HLT.DirId_Sequence;
CREATE SYNONYM ConfigId_Sequence 		FOR CMS_HLT.ConfigId_Sequence;
CREATE SYNONYM StreamId_Sequence 		FOR CMS_HLT.StreamId_Sequence;
CREATE SYNONYM SuperId_Sequence 		FOR CMS_HLT.SuperId_Sequence;
CREATE SYNONYM PathId_Sequence 			FOR CMS_HLT.PathId_Sequence;
CREATE SYNONYM SequenceId_Sequence 		FOR CMS_HLT.SequenceId_Sequence;
CREATE SYNONYM ParamId_Sequence 		FOR CMS_HLT.ParamId_Sequence;
