use role ACCOUNTADMIN;

-- Create Storage Integration
create or replace storage integration AZURE_INSTACART_INT
  type = EXTERNAL_STAGE
  storage_provider = AZURE
  enabled = TRUE
  azure_tenant_id = '30ea0905-4fff-4b41-8047-7fbc4ff1d717'
  storage_allowed_locations = ('azure://instacartdatalake.blob.core.windows.net/instacart-raw/');

-- Access Control
grant usage on integration AZURE_INSTACART_INT to role SYSADMIN;

-- Create Warehouse, Database, and Schemas
use role SYSADMIN;

create or replace warehouse INSTACART_WH 
  with warehouse_size = 'XSMALL' 
  auto_suspend = 60 
  auto_resume = TRUE;

create or replace database INSTACART_DW;

create or replace schema INSTACART_DW.RAW;