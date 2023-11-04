#!/bin/bash

set -o noglob

# NUMBER                  = ["-"], INTEGER;
# 
# addition_operator       = "+" | "-";
# multiplication_operator = "*" | "/";
#
# ARITHMETIC_EXPRESSION   = FACTOR, {addition_operator, FACTOR};
# FACTOR                  = TERM, {multiplication_operator, TERM};
# TERM                    = (NUMBER | PARENTHESES_EXPRESSION);
#
# PARENTHESES_EXPRESSION  = "(", ARITHMETIC_EXPRESSION, ")";

INTEGER_TYPE="INTEGER"
ADDITION_OPERATOR_TYPE="ADDITION_OPERATOR"
MULTIPLICATION_OPERATOR_TYPE="MULTIPLICATION_OPERATOR"
OPEN_PARENTHESES_TYPE="OPEN_PARENTHESES"
CLOSED_PARENTHESES_TYPE="CLOSED_PARENTHESES"
END_TOKEN_TYPE="END_FILE"

INTEGER_REGEX="^[0-9]+$"

ARGUMENTS="$@"

CURRENT_TOKEN=""
CURRENT_TOKEN_TYPE=""

EMPTY_VALUE="END"

FUNCTION_RETURN=$EMPTY_VALUE

signal_exception() {
    local MESSAGE="$1"
    echo "$MESSAGE" 1>&2
    exit 1
}

is_integer() {
    local TOKEN=$1
    [[ "$TOKEN" =~ ^[0-9]+$ ]]
}

get_token_type() {
    local TOKEN=$1
    local RESULT=""

    case "$TOKEN" in

        \+|-)
            RESULT=$ADDITION_OPERATOR_TYPE
            ;;
        
        \*|/)
            RESULT=$MULTIPLICATION_OPERATOR_TYPE
            ;;

        \()
            RESULT=$OPEN_PARENTHESES_TYPE
            ;;

        \))
            RESULT=$CLOSED_PARENTHESES_TYPE
            ;;

        [0-9]*)
            if $(is_integer $TOKEN); then
                RESULT=$INTEGER_TYPE
            else
                signal_exception "Could not parse number: $TOKEN"
            fi
            ;;
        
        $EMPTY_VALUE)
            RESULT=$END_TOKEN_TYPE
            ;;

        *)
            signal_exception "Could not parse provided token type: ${TOKEN}"
            ;;
    esac

    FUNCTION_RETURN="$RESULT"
}

next_token() {
    set -- $ARGUMENTS
    
    if [ "$#" = 0 ]; then
        CURRENT_TOKEN="$EMPTY_VALUE"
        CURRENT_TOKEN_TYPE="$END_TOKEN_TYPE"
    else
        CURRENT_TOKEN="$1"
        get_token_type "$CURRENT_TOKEN"
        CURRENT_TOKEN_TYPE="$FUNCTION_RETURN"

        shift;
        ARGUMENTS="$@"
    fi
}

skip_if() {
    local TOKEN_TYPE=$1
    if [ "$CURRENT_TOKEN_TYPE" != "$TOKEN_TYPE" ]; then
        return 1
    else
        next_token
        return 0
    fi
}

handle_skip() {
    local TOKEN_TYPE="$1"
    if ! skip_if "$TOKEN_TYPE"; then
        signal_exception "Expected token type: $TOKEN_TYPE, but got: $CURRENT_TOKEN ($CURRENT_TOKEN_TYPE)"
    fi
}

parse() {
    next_token
    parse_arithmetic_expression
}

parse_arithmetic_expression () {
    parse_factor
    local SUM="$FUNCTION_RETURN"
    while [ "$CURRENT_TOKEN_TYPE" != "$END_TOKEN_TYPE" ]; do
        local OPERATION="$CURRENT_TOKEN"
        if skip_if "$ADDITION_OPERATOR_TYPE" ; then
            parse_factor
            VALUE="$FUNCTION_RETURN"
            SUM=`expr $SUM $OPERATION $VALUE 2> /dev/null`
        else
            break
        fi
    done
    FUNCTION_RETURN="$SUM"
}

parse_factor() {
    parse_term
    local PRODUCT="$FUNCTION_RETURN"
    while [ "$CURRENT_TOKEN_TYPE" != "$END_TOKEN_TYPE" ]; do
        local OPERATION="$CURRENT_TOKEN"
        if skip_if "$MULTIPLICATION_OPERATOR_TYPE"; then
            parse_term
            VALUE="$FUNCTION_RETURN"
            PRODUCT=`expr $PRODUCT $OPERATION $VALUE 2> /dev/null`
        else
            break
        fi
    done
    FUNCTION_RETURN="$PRODUCT"
}

parse_term() {
    parse_parentheses_expression
    if [ $FUNCTION_RETURN != $EMPTY_VALUE ]; then
        return 0
    fi

    parse_number
    if [ $FUNCTION_RETURN != $EMPTY_VALUE ]; then
        return 0
    fi

    signal_exception "Expected any of tokens: (, -, [0-9]*"
}

parse_parentheses_expression() {
    if skip_if $OPEN_PARENTHESES_TYPE; then
        parse_arithmetic_expression
        RESULT="$FUNCTION_RETURN"
        handle_skip $CLOSED_PARENTHESES_TYPE
        FUNCTION_RETURN=$RESULT
    else
        FUNCTION_RETURN="$EMPTY_VALUE"
    fi
}

parse_number() {
    local NEGATION=""
    if [ "$CURRENT_TOKEN" = "-" ]; then
        NEGATION="-"
        next_token
    fi
    if [ "$CURRENT_TOKEN_TYPE" = "$INTEGER_TYPE" ]; then
        local RESULT="$NEGATION$CURRENT_TOKEN"
        next_token
        FUNCTION_RETURN="$RESULT"
    else
        FUNCTION_RETURN="$EMPTY_VALUE"
    fi
}

parse
RESULT="$FUNCTION_RETURN"
echo "$RESULT"
