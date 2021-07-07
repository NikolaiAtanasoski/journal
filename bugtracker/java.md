# Java Bugs #

## Websphere / OJDBC: ORA-01722 Invalid Number ##

ojdbc gets locale from java locale setting.

comma or dot as decimal point seperator.

possbile solution: hard coding TO_NUMBER function so it looks like this

``AMOUNT = TO_NUMBER('123,95', '999D99', 'NLS_NUMERIC_CHARACTERS='',.''');``
```java
public String createToNumberSqlFunction(String value){
        //TO_NUMBER() needs information how to format number
        String format = "";
        if (value.contains(",")) {
            int numberOfDigitsBeforeComma = value.indexOf(",");
            int numberOfDigitsAfterComma = value.length() - numberOfDigitsBeforeComma;

            format += StringUtils.repeat("9", numberOfDigitsBeforeComma); //9 matches a digit between 0-9 at declared place
            format += "D"; //"D" matches the Decimal Point, which is specified through NLS_NUMERIC_CHARACTERS parameter
            format += (StringUtils.repeat("9", numberOfDigitsAfterComma));
        }
        else {
            format += (StringUtils.repeat("9", value.length()));
        }
        return String.format("TO_NUMBER(?, '%s', 'NLS_NUMERIC_CHARACTERS='',.''')", format);
    }
```

