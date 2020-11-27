# wrapping in a function to prevent variables from leaking
make_prompt() {

    local USER=""
    # tell me when root
    if [[ $UID == 0 || $EUID == 0 ]];
        then
        USER="%F{red}root%f"
    fi

    local CWD="[%F{242}%2.%f]"
    local END="%(?.%F{85}.%F{red})⮞ %f"

PROMPT=$USER$CWD$END
}

make_prompt;

