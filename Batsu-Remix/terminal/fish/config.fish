if status is-interactive
    # Commands to run in interactive sessions can go here
    function fish_greeting
        echo "fish in a shell"
    end
    # Set Neovim as the default editor
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    oh-my-posh init fish --config ~/path/to/stelbent-batsu-remix.omp.json | source

end


