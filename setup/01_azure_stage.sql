use role SYSADMIN;
use database INSTACART_DW;
use schema RAW;

-- File Format
create or replace file format INSTACART_DW.RAW.FF_INSTACART_CSV
  type = CSV
  skip_header = 1 
  field_delimiter = ','
  record_delimiter = '\n'
  field_optionally_enclosed_by = '"'
  empty_field_as_null = TRUE
  error_on_column_count_mismatch = TRUE;

-- Map Stage to Storage Integration
create or replace stage INSTACART_DW.RAW.STG_ADLS_INSTACART
  storage_integration = AZURE_INSTACART_INT
  url = 'azure://instacartdatalake.blob.core.windows.net/instacart-raw/'
  file_format = INSTACART_DW.RAW.FF_INSTACART_CSV;