--copiar dados 
copy customers_dataset(
	customer_id,
	"customer_unique_id",
	"customer_zip_code_prefix",
	"customer_city",
	"customer_state")
from 'C:\Users\Public\Documents\E-commerce Business Performance\customers_dataset.csv'
with (format csv, header, delimiter ',');

insert into unique_zip_codes (zip_code) values
(56485); --eram muitos os codigos porais que não existiam para adicionar manualmente 

--criação de tabela temporária com todos os codigos postais 
CREATE TEMPORARY TABLE temp_zip_code (
  zip_code int PRIMARY KEY
);

-- extração do ficheiro csv onde fiz uma sequecia entre 1001 e 142812
COPY temp_zip_code(zip_code) 
FROM 'C:\Users\Public\Documents\E-commerce Business Performance\unique_zip_codes.csv' 
CSV HEADER;

--para associar a tabela unique_zip_codes os valores que só existem na tabela temporaria: 
INSERT INTO unique_zip_codes (zip_code)
SELECT zip_code FROM temp_zip_code
WHERE NOT EXISTS (
  SELECT 1 FROM unique_zip_codes WHERE zip_code = temp_zip_code.zip_code
);












