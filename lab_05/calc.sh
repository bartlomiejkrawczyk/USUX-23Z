#!/bin/bash

set -o noglob

# NUMBER                  = INTEGER;
# 
# addition_operator       = "+" | "-";
# multiplication_operator = "*" | "/";
#
# ARITHMETIC_EXPRESSION   = FACTOR, {addition_operator, FACTOR};
# FACTOR                  = TERM, {multiplication_operator, TERM};
# TERM                    = (["-"], SIMPLE_TYPE | PARENTHESES_EXPRESSION);
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

    echo $TOKEN 1>&2

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

    echo $RESULT 1>&2
    echo $RESULT
}

next_token() {
    set -- $ARGUMENTS

    echo ARGUMENTS:  "$@" 1>&2
    
    if [ "$#" = 0 ]; then
        CURRENT_TOKEN="$EMPTY_VALUE"
        CURRENT_TOKEN_TYPE="$END_TOKEN_TYPE"
    else
        CURRENT_TOKEN="$1"
        CURRENT_TOKEN_TYPE=$(get_token_type "$CURRENT_TOKEN")

        echo Current token: "$CURRENT_TOKEN" 1>&2
        echo Current token type: "$CURRENT_TOKEN_TYPE" 1>&2

        shift;
        ARGUMENTS="$@"
    fi
}

skip_if() {
    local TOKEN_TYPE=$1
    echo "Current: $CURRENT_TOKEN_TYPE" 1>&2
    echo "Expected: $TOKEN_TYPE" 1>&2
    if [ "$CURRENT_TOKEN_TYPE" != "$TOKEN_TYPE" ]; then
        echo "Did not skip: $TOKEN" 1>&2
        return 1
    else
        echo "Skipped: $TOKEN" 1>&2
        next_token
        return 0
    fi
}

handle_skip() {
    local TOKEN_TYPE="$1"
    if skip_if "$TOKEN_TYPE"; then
        signal_exception "Expected token type: $TOKEN_TYPE, but got: $CURRENT_TOKEN ($CURRENT_TOKEN_TYPE)"
    fi
}

parse_arithmetic_expression () {
    next_token
    parse_factor
    local OPTIONAL_FACTOR="$FUNCTION_RETURN"
    if [ "$OPTIONAL_FACTOR" = "$EMPTY_VALUE" ]; then
        FUNCTION_RETURN="$EMPTY_VALUE"
    else
        local SUM=$OPTIONAL_FACTOR
        while [ "$CURRENT_TOKEN_TYPE" != "$END_TOKEN_TYPE" ]; do
            local OPERATION="$CURRENT_TOKEN"
            if skip_if "$ADDITION_OPERATOR_TYPE" ; then
                parse_factor
                VALUE="$FUNCTION_RETURN"
                # TODO: handle empty value
                echo "$PRODUCT $OPERATION $VALUE" 1>&2
                SUM=`expr $SUM $OPERATION $VALUE 2> /dev/null`
            else
                break
            fi
        done
        FUNCTION_RETURN="$SUM"
    fi
}

parse_factor() {
    parse_term
    local OPTIONAL_TERM="$FUNCTION_RETURN"
    if [ "$OPTIONAL_TERM" = "$EMPTY_VALUE" ]; then
        FUNCTION_RETURN="$EMPTY_VALUE"
    else
        local PRODUCT=$OPTIONAL_TERM
        while [ "$CURRENT_TOKEN_TYPE" != "$END_TOKEN_TYPE" ]; do
            local OPERATION="$CURRENT_TOKEN"
            if skip_if "$MULTIPLICATION_OPERATOR_TYPE"; then
                parse_term
                VALUE="$FUNCTION_RETURN"
                # TODO: handle empty value
                echo "$PRODUCT $OPERATION $VALUE" 1>&2
                PRODUCT=`expr $PRODUCT $OPERATION $VALUE 2> /dev/null`
            else
                break
            fi
        done
        FUNCTION_RETURN="$PRODUCT"
    fi
}

# parse_term -> int or null
parse_term() {
    FUNCTION_RETURN="$CURRENT_TOKEN"
    next_token
}

# parse_parentheses_expression -> int or null
parse_parentheses_expression() {
    echo "1"
}

parse_arithmetic_expression
RESULT="$FUNCTION_RETURN"
echo "$RESULT"

