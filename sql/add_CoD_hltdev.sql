--
-- ADD 'CASCADE ON DELETE' FK CONSTRAINTS ON CMS_HLTDEV@CMS_ORCOFF_PROD (!!)
--

ALTER TABLE EDSourceTemplates DROP CONSTRAINT SYS_C00435875;
ALTER TABLE ESSourceTemplates DROP CONSTRAINT SYS_C00435881;
ALTER TABLE ESModuleTemplates DROP CONSTRAINT SYS_C00435887;
ALTER TABLE ServiceTemplates  DROP CONSTRAINT SYS_C00435869;
ALTER TABLE ModuleTemplates   DROP CONSTRAINT SYS_C00435893;

@add_CoD.sql