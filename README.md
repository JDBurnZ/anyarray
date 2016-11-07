anyarray
========

A set of PostgeSQL functions adding highly desirable, data-type independent array functionality.

Inspired by intarray's complete disregard for all non-integer data-types.

license
-------
Please refer to the LICENSE file for licensing and copyright information.

source code
-----------
anyarray source code, documentation and examples are available on GitHub at:
https://www.github.com/JDBurnZ/anyarray

compatibility
-------------

Tested on PostgreSQL 9.1, 9.2 and 9.3, but should be compatible with all versions which support arrays.

* PostgreSQL 8.x
* PostgreSQL 9.x

functions
---------

<table><tbody>
<tr><th>Method</th><th>Returns</th><th>Description</th></tr>
<tr><td>anyarray_concat(anyarray, anyarray)</td><td>anyarray</td><td>Returns the first argument with values from the second argument appended to it.</td></tr>
<tr><td>anyarray_concat(anyarray, anynonarray)</td><td>anyarray</td><td>Returns the first argument with the second argument appended appended to it.</td></tr>
<tr><td>anyarray_concat_uniq(anyarray, anyarray)</td><td>anyarray</td><td>Returns the first argument with values from the second argument (which are not in the first argument) appended to it.</td></tr>
<tr><td>anyarray_concat_uniq(anyarray, anynonarray)</td><td>anyarray</td><td>Returns the first argument with the second argument appended to it, if the second argument isn't in the first argument.</td></tr>
<tr><td>anyarray_diff(anyarray, anyarray)</td><td>anyarray</td><td>Returns an array of every element which is not common between arrays.</td></tr>
<tr><td>anyarray_diff_uniq(anyarray, anyarray)</td><td>anyarray</td><td>Returns an array of every unique value which is not common between arrays.</td></tr>
<tr>
	<td>anyarray_enumerate(anyarray)</td>
	<td>TABLE (index bigint, value anyelement)</td>
	<td>Unnests the array along with the indices of each element.</td>
</tr>
<tr><td>anyarray_is_array(anyelement)</td><td>boolean</td><td>Determines whether or not the argument passed is an array.</td></tr>
<tr><td>anyarray_numeric_only(anyarray)</td><td>anyarray</td><td>Returns the array passed with all non-numeric values removed from it. Retains whole and decimal values.</td></tr>
<tr><td>anyarray_ranges(anyarray)</td><td>text[]</td><td>Converts an array of values into ranges. Currently only supports smalling, integer and bigint.</td></tr>
<tr><td>anyarray_remove(anyarray, anyarray)</td><td>anyarray</td><td>Returns the first argument with all values from the second argument removed from it.</td></tr>
<tr><td>anyarray_remove(anyarray, anynonarray)</td><td>anyarray</td><td>Returns the first argument with all values matching the second argument removed from it.</td></tr>
<tr><td>anyarray_remove_null(anyarray)</td><td>anyarray</td><td>Returns an array with all occurrences of NULL omitted.</td></tr>
<tr><td>anyarray_sort(anyarray)</td><td>anyarray</td><td>Returns the array, sorted.</td></tr>
<tr><td>anyarray_uniq(anyarray)</td><td>anyarray</td><td>Returns an array of unique values present within the array passed.</td></tr>
<tr><td>anyarray_from_json(json)</td><td>anyarray</td><td>Converts a JSON array into a text array.</td></tr>
</tbody></table>

aggregates
----------

<table><tbody>
<tr><th>Method</th><th>Returns</th><th>Description</th></tr>
<tr><td>anyarray_agg(anyarray)</td><td>anyarray</td><td>Concatenates arrays into a single array when aggregating.</td></tr>
</tbody></table>

operators
---------

Coming Soon!

examples
--------

<table><tbody>

<tr><th>Query</th><th>Return Data-Type</th><th>Result</th></tr>

<tr><td><pre>SELECT anyarray_concat(
	ARRAY[1, 2],
	ARRAY[2, 3]
)</pre></pre></td><td>integer[]</td><td><pre>{1,2,2,3}</pre></td></tr>

<tr><td><pre>SELECT anyarray_concat(
	ARRAY['one', 'two'],
	ARRAY['two', 'three']
)</pre></td><td>text[]</td><td><pre>{one,two,two,three}</pre></td></tr>

<tr><td><pre>SELECT anyarray_concat(
	ARRAY[1, 2],
	2
)</pre></td><td>integer[]</td><td><pre>{1,2,2}</pre></td></tr>

<tr><td><pre>SELECT anyarray_concat(
	ARRAY['one', 'two'],
	'two'::text
)</pre></td><td>text[]</td><td><pre>{one,two,two}</pre></td></tr>

<tr><td><pre>SELECT anyarray_concat_uniq(
	ARRAY[1, 2],
	ARRAY[2, 3]
)</pre></td><td>integer[]</td><td><pre>{1,2,3}</pre></td></tr>

<tr><td><pre>SELECT anyarray_concat_uniq(
	ARRAY['one', 'two'],
	ARRAY['two', 'three']
)</pre></td><td>text[]</td><td><pre>{one,two,three}</pre></td></tr>

<tr><td><pre>SELECT anyarray_concat_uniq(
	ARRAY[1, 2],
	2
)</pre></td><td>integer[]</td><td><pre>{1,2}</pre></td></tr>

<tr><td><pre>SELECT anyarray_concat_uniq(
	ARRAY[1, 2],
	3
)</pre></td><td>integer[]</td><td><pre>{1,2,3}</pre></td></tr>

<tr><td><pre>SELECT anyarray_concat_uniq(
	ARRAY['one', 'two'],
	'two'::text
)</pre></td><td>text[]</td><td><pre>{one,two}</pre></td></tr>

<tr><td><pre>SELECT anyarray_concat_uniq(
	ARRAY['one', 'two'],
	'three'::text
)</pre></td><td>text[]</td><td><pre>{one,two,three}</pre></td></tr>

<tr><td><pre>SELECT anyarray_diff(
	ARRAY[1, 1, 2],
	ARRAY[2, 3, 4, 4]
)</pre></td><td>integer[]</td><td><pre>{1,1,3,4,4}</pre></td></tr>

<tr><td><pre>SELECT anyarray_diff(
	ARRAY['one', 'one', 'two'],
	ARRAY['two', 'three', 'four', 'four']
)</pre></td><td>text[]</td><td><pre>{one,one,three,four,four}</pre></td></tr>

<tr><td><pre>SELECT anyarray_diff_uniq(
	ARRAY[1, 1, 2],
	ARRAY[2, 3, 4, 4]
)</pre></td><td>integer[]</td><td><pre>{1,3,4}</pre></td></tr>

<tr><td><pre>SELECT anyarray_diff_uniq(
	ARRAY['one', 'one', 'two'],
	ARRAY['two', 'three', 'four', 'four']
)</pre></td><td>text[]</td><td><pre>{one,three,four}</pre></td></tr>

<tr>
	<td><pre>SELECT *
FROM anyarray_enumerate(
	ARRAY[
		'foo', 'bar', 'spam', 'eggs'
	]::TEXT[]
);</pre></td>
	<td>TABLE (index bigint, value text)</td>
	<td><pre>{1,'foo'}
{2,'bar'}
{3,'spam'}
{4,'eggs'}</pre></td>
</tr>

<tr>
	<td><pre>SELECT *
FROM anyarray_enumerate(
	ARRAY[
		ARRAY['foo', 'bar'],
		ARRAY['spam', 'eggs']
	]::TEXT[]
);</pre></td>
	<td>TABLE (index bigint, value text)</td>
	<td><pre>{1,'foo'}
{2,'bar'}
{3,'spam'}
{4,'eggs'}</pre></td>
</tr>

<tr><td><pre>SELECT anyarray_numeric_only(
	ARRAY['1', '1.1', '1.1a', '1.a', 'a']::text[]
)</pre></td><td>text[]</td><td><pre>{1,1.1}</pre></td></tr>

<tr><td><pre>SELECT anyarray_numeric_only(
	ARRAY[1, 1.1, 1.1234567890]::numeric[]
)</pre></td><td>numeric[]</td><td><pre>{1,1.1,1.1234567890}</pre></td></tr>

<tr><td><pre>SELECT anyarray_is_array(ARRAY[1, 2])</pre></td><td>boolean[]</td><td><pre>TRUE</pre></td></tr>

<tr><td><pre>SELECT anyarray_is_array(ARRAY['one', 'two'])</pre></td><td>boolean[]</td><td><pre>TRUE</pre></td></tr>

<tr><td><pre>SELECT anyarray_is_array(1)</pre></td><td>boolean[]</td><td><pre>FALSE</pre></td></tr>

<tr><td><pre>SELECT anyarray_is_array('one'::text)</pre></td><td>boolean[]</td><td><pre>FALSE</pre></td></tr>

<tr><td><pre>SELECT anyarray_ranges(ARRAY[1, 2, 4, 5, 6, 9])</pre></td><td>text[]</td><td><pre>{1-2,4-6,9}</pre></td></tr>

<tr><td><pre>SELECT anyarray_ranges(ARRAY[1.1, 1.2, 2, 3, 5])</pre></td><td>text[]</td><td><pre>{1.1,1.2,2-3,5}</pre></td></tr>

<tr><td><pre>SELECT anyarray_remove(
	ARRAY[1, 2],
	ARRAY[2, 3]
)</pre></td><td>integer[]</td><td><pre>{1}</pre></td></tr>

<tr><td><pre>SELECT anyarray_remove(
	ARRAY['one', 'two'],
	ARRAY['two', 'three']
)</pre></td><td>text[]</td><td><pre>{one}</pre></td></tr>

<tr><td><pre>SELECT anyarray_remove(
	ARRAY[1, 2],
	2
)</pre></td><td>integer[]</td><td><pre>{1}</pre></td></tr>

<tr><td><pre>SELECT anyarray_remove(
	ARRAY['one', 'two'],
	'two'::text
)</pre></td><td>text[]</td><td><pre>{one}</pre></td></tr>

<tr><td><pre>SELECT anyarray_remove_null(ARRAY[1, 2, NULL, 4])</pre></td><td>integer[]</td><td><pre>{1,2,4}</pre></td></tr>

<tr><td><pre>SELECT anyarray_remove_null(ARRAY['one', 'two', NULL, 'four'])</pre></td><td>text[]</td><td><pre>{one,two,four}</pre></td></tr>

<tr><td><pre>SELECT anyarray_sort(ARRAY[1, 46, 15, 3])</pre></td><td>integer[]</td><td><pre>{1,3,15,46}</pre></td></tr>

<tr><td><pre>SELECT anyarray_sort(ARRAY['1', '46', '15', '3'])</pre></td><td>integer[]</td><td><pre>{1,15,3,46}</pre></td></tr>

<tr><td><pre>SELECT anyarray_sort(ARRAY['one', 'forty-six', 'fifteen', 'three'])</pre></td><td>text[]</td><td><pre>{fifteen,forty-six,one,three}</pre></td></tr>

<tr><td><pre>SELECT anyarray_uniq(ARRAY[1, 2, 3, 2, 1])</pre></td><td>integer[]</td><td><pre>{1,2,3}</td></tr>

<tr><td><pre>SELECT anyarray_uniq(ARRAY['one', 'two', 'three', 'two', 'one'])</pre></td><td>text[]</td><td><pre>{one,two,three}</pre></td></tr>

<tr><td><pre>SELECT id, anyarray_agg(list)
FROM (VALUES
	('a', ARRAY[1,2]),
	('a', ARRAY[3,4]),
	('b', ARRAY[5,6]),
	('b', ARRAY[7,8])
) AS data (id, list)
GROUP BY id</pre></td><td>text, integer[]</td><td><pre>'a', {1,2,3,4}
'b', {5,6,7,8}</pre></td></tr>

<tr><td><pre>SELECT id, anyarray_agg(ARRAY[list])
FROM (VALUES
	('a', ARRAY[1,2]),
	('a', ARRAY[3,4]),
	('b', ARRAY[5,6]),
	('b', ARRAY[7,8])
) AS data (id, list)
GROUP BY id</pre></td><td>text, integer[]</td><td><pre>'a', {{1,2},{3,4}}<br/>'b', {{5,6},{7,8}}</pre></td></tr>

<tr><td><pre>SELECT anyarray_from_json('["one", "two", "three"]')</pre></td><td>text[]</td><td><pre>{one,two,three}</pre></td></tr>

</tbody></table>

Donations
---------
AnyArray is free software, but donations help the developer spend more time maintaining this project and others like it.
<br />
<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=S42X58PL8SR2Y"><img src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" /></a>
