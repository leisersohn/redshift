--Redshift user defined function that allows to compare a column to a regex from another column
--e.g. check there is no match by checking the result is empty (dev.udf_regexp_match(column1,column2) = '')

CREATE OR REPLACE FUNCTION dev.udf_regexp_match (string_value VARCHAR(255), regexp_pattern VARCHAR(255)) RETURNS VARCHAR(255) IMMUTABLE as $$ 
    import re

    #Compile regular expression pattern
    reg = re.compile(r'%s'%regexp_pattern)

    #Create list of patterns matched
    matches_found = reg.findall(string_value)

    #Join list into one
    return '|'.join(matches_found)
$$ LANGUAGE plpythonu;