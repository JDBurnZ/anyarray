-- Function: public.anyarray_from_json(json)

-- DROP FUNCTION public.anyarray_from_json(json);

CREATE OR REPLACE FUNCTION public.anyarray_from_json(
    IN json_in json DEFAULT '[]'::json)
  RETURNS text[] AS
$BODY$
select array_agg(a) arr from (
	select trim(both '"' from json_array_elements(json_in)::text) as a
) as elem
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
COMMENT ON FUNCTION public.anyarray_from_json(json) IS 'Converts a JSON array into a text[] array.';
