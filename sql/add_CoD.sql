--
-- ADD FOREIGN KEY CONSTRAINTS TO *TEMPLATES TABLES
-- !! NEED TO DROP EXISTING CONSTRAINTS FIRST !!
--

ALTER TABLE EDSourceTemplates ADD CONSTRAINT FK_EDST_SID
FOREIGN KEY(superId) REFERENCES SuperIds(superId) ON DELETE CASCADE;

ALTER TABLE ESSourceTemplates ADD CONSTRAINT FK_ESST_SID
FOREIGN KEY(superId) REFERENCES SuperIds(superId) ON DELETE CASCADE;

ALTER TABLE ESModuleTemplates ADD CONSTRAINT FK_ESMT_SID
FOREIGN KEY(superId) REFERENCES SuperIds(superId) ON DELETE CASCADE;

ALTER TABLE ServiceTemplates ADD CONSTRAINT FK_SVCT_SID
FOREIGN KEY(superId) REFERENCES SuperIds(superId) ON DELETE CASCADE;

ALTER TABLE ModuleTemplates ADD CONSTRAINT FK_MODT_SID
FOREIGN KEY(superId) REFERENCES SuperIds(superId) ON DELETE CASCADE;
