confpath=${HOME}/.bash

##########
## Modules are snippets of configuration
## that can be active dynamically or enabled
## and active at startup
##########

mod_path=${confpath}/modules
enabled_list=${confpath}/enabled_mods
active_list=${confpath}/active_mods


is_mod_active(){
    module=$1
    if $(grep -qx $module $active_list 2> /dev/null); then
        return 0
    else
        return 1
    fi
}

is_mod_enabled(){
    module=$1
    if $(grep -qx $module $enabled_list 2> /dev/null); then
        return 0
    else
        return 1
    fi
}

is_mod_present(){
    module=$1
    if [ -e $mod_path/$module ]; then
        return 0
    else
        return 1
    fi
}

#Enable module and write to $enabled_list
bash_enable_mod() {
    module=$1
    if is_mod_present $module; then
        if is_mod_enabled $module; then
            echo "$module already enabled"
            return 1
        else
            echo $module >> $enabled_list
            echo "$module enabled, it will be available on next startup"
            return 0
        fi
    else
        echo "$module not present"
        return 2
    fi
}
# Removes mod from $enabled_list
bash_disable_mod() {
    module=$1
    if is_mod_enabled "$module"; then
        echo -e "/$module/d\nwq"|ex -s $enabled_list
        echo "$module disabled, it won't be active on next startup"
        return 0
    else
        echo "$module not enabled"
        return 1
    fi
}

#Shows enabled mods
bash_list_enabled_mods() {
    echo "Modules active:"
    cat $enabled_list
    return 0
}

#Load all the enabled modules
bash_load_modules(){
    #cleanup $active_list
    echo > $active_list
    for mod in $(cat $enabled_list); do
        source $mod_path/$mod
        echo $mod >> $active_list
    done
    return 0
}

#Load only one module even if it's not enabled
#Useful for testing
bash_load_module(){
    module=$1
    if is_module_present $module;then
        source $module;
        echo "$module active"
        return 0
    else
        echo "Couldn't find $module"
        return 1
    fi
}
#Shows active mods
bash_list_active_mods() {
    echo "Modules enabled:"
    cat $active_list
    return 0
}
