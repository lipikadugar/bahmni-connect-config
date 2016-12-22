-- All patient attributes required
INSERT INTO person_attribute_type (name, description, format, searchable, creator, date_created, retired, sort_weight, uuid) VALUES ('caste', 'Caste', 'java.lang.String', '1', 1, curdate(), 0, 2, uuid());
INSERT INTO person_attribute_type (name, description, format, searchable, creator, date_created, retired, sort_weight, uuid) VALUES ('education', 'Education', 'java.lang.String', '1', 1, curdate(), 0, 3, uuid());
INSERT INTO person_attribute_type (name, description, format, searchable, creator, date_created, retired, sort_weight, uuid) VALUES ('occupation', 'Occupation', 'java.lang.String', '1', 1, curdate(), 0, 4, uuid());
INSERT INTO person_attribute_type (name, description, format, searchable, creator, date_created, retired, sort_weight, uuid) VALUES ('primaryContact', 'Primary Contact', 'java.lang.String', '1', 1, curdate(), 0, 5, uuid());
INSERT INTO person_attribute_type (name, description, format, searchable, creator, date_created, retired, sort_weight, uuid) VALUES ('secondaryContact', 'Secondary Contact', 'java.lang.String', '1', 1, curdate(), 0, 6, uuid());
INSERT INTO person_attribute_type (name, description, format, searchable, creator, date_created, retired, sort_weight, uuid) VALUES ('Health Center', 'Health Center of registered user', 'org.openmrs.Location', '1', 1, curdate(), 0, 7, uuid());
INSERT INTO person_attribute_type (name, description, format, searchable, creator, date_created, retired, sort_weight, uuid) VALUES ('primaryRelative', 'Primary Relative', 'java.lang.String', '1', 1, curdate(), 0, 8, uuid());

SELECT patient_identifier_type_id from patient_identifier_type where name = 'Bahmni Id' into @patient_identifier;

INSERT INTO idgen_identifier_source (uuid, name, description, identifier_type, creator, date_created)
  VALUES (uuid(), 'GAN', 'ID sequence source for patients whose primary health center is Ganiyari', @patient_identifier, 1, curdate());
SET @source_id := LAST_INSERT_ID();
INSERT INTO idgen_seq_id_gen (id, next_sequence_value, base_character_set, first_identifier_base, prefix, suffix, length) VALUES (@source_id, 200000, '0123456789', '200000', 'GAN', '', 9);

INSERT INTO idgen_identifier_source (uuid, name, description, identifier_type, creator, date_created)
  VALUES (uuid(), 'SEM', 'ID sequence source for patients whose primary health center is Semariya', @patient_identifier, 1, curdate());
SET @source_id := LAST_INSERT_ID();
INSERT INTO idgen_seq_id_gen (id, next_sequence_value, base_character_set, first_identifier_base, prefix, suffix, length) VALUES (@source_id, 200000, '0123456789', '200000', 'SEM', '', 9);

INSERT INTO idgen_identifier_source (uuid, name, description, identifier_type, creator, date_created)
  VALUES (uuid(), 'SHI', 'ID sequence source for patients whose primary health center is Shivtarai', @patient_identifier, 1, curdate());
SET @source_id := LAST_INSERT_ID();
INSERT INTO idgen_seq_id_gen (id, next_sequence_value, base_character_set, first_identifier_base, prefix, suffix, length) VALUES (@source_id, 200000, '0123456789', '200000', 'SHI', '', 9);

INSERT INTO idgen_identifier_source (uuid, name, description, identifier_type, creator, date_created)
  VALUES (uuid(), 'BAH', 'ID sequence source for patients whose primary health center is Bahmini', @patient_identifier, 1, curdate());
SET @source_id := LAST_INSERT_ID();
INSERT INTO idgen_seq_id_gen (id, next_sequence_value, base_character_set, first_identifier_base, prefix, suffix, length) VALUES (@source_id, 200000, '0123456789', '200000', 'BAH', '', 9);


-- Location details
INSERT INTO location_attribute_type (name, description, datatype, min_occurs, max_occurs, creator, date_created, uuid)
  VALUES ('IdentifierSourceName', 'Identifier source name of the source that needs to be used for patients coming from this location', 'org.openmrs.customdatatype.datatype.FreeTextDatatype', 0, 1, 1, curdate(), uuid());

INSERT INTO location (name, description, creator, date_created, uuid)
  VALUES ('Ganiyari', 'Ganiyari hospital', 1, curdate(), uuid());
SET @lastlocation = last_insert_id();
INSERT INTO location_attribute (location_id, attribute_type_id, value_reference, uuid, creator, date_created)
  (SELECT  @lastlocation, location_attribute_type_id, 'GAN', uuid(), 1, curdate()
   FROM location_attribute_type
   WHERE name = 'IdentifierSourceName');

INSERT INTO location (name, description, creator, date_created, uuid)
  VALUES ('Semariya', 'Semariya subcentre', 1, curdate(), uuid());
SET @lastlocation = last_insert_id();
INSERT INTO location_attribute (location_id, attribute_type_id, value_reference, uuid, creator, date_created)
  (SELECT  @lastlocation, location_attribute_type_id, 'SEM', uuid(), 1, curdate()
   FROM location_attribute_type
   WHERE name = 'IdentifierSourceName');

INSERT INTO location (name, description, creator, date_created, uuid)
  VALUES ('Shivtarai', 'Shivtarai subcentre', 1, curdate(), uuid());
SET @lastlocation = last_insert_id();
INSERT INTO location_attribute (location_id, attribute_type_id, value_reference, uuid, creator, date_created)
  (SELECT  @lastlocation, location_attribute_type_id, 'SHI', uuid(), 1, curdate()
   FROM location_attribute_type
   WHERE name = 'IdentifierSourceName');

INSERT INTO location (name, description, creator, date_created, uuid)
  VALUES ('Bahmni', 'Bahmni subcentre', 1, curdate(), uuid());
SET @lastlocation = last_insert_id();
INSERT INTO location_attribute (location_id, attribute_type_id, value_reference, uuid, creator, date_created)
  (SELECT  @lastlocation, location_attribute_type_id, 'BAH', uuid(), 1, curdate()
   FROM location_attribute_type
   WHERE name = 'IdentifierSourceName');
