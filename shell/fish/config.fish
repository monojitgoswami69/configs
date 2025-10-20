function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias pamcan pacman
    alias ls 'eza --icons'
    alias lsa 'eza --icons -a'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"

    # Safety and convenience (parity with bash)
    alias cp 'cp -iv'
    alias mv 'mv -iv'
    alias rm 'rm -iv'
    alias mkdir 'mkdir -pv'
    alias src 'source ~/.config/fish/config.fish'

    # Quick directory jumps
    alias .. 'cd ..'
    alias ... 'cd ../..'
    alias .... 'cd ../../..'

    # Git shortcuts
    alias gpl 'git pull'
    alias gco 'git checkout'
    alias gb 'git branch'
    alias gc 'git clone'
    alias gs 'git status'
    alias ga 'git add'
    alias gcm 'git commit -m'
    alias gcam 'git commit -am'
    alias gp 'git push'
    alias gl 'git log --oneline --graph --decorate'
    alias gd 'git diff'

    # Pacman / yay
    alias pi 'sudo pacman -S --noconfirm'
    alias pr 'sudo pacman -Rns --noconfirm'
    alias pu 'sudo pacman -Syu --noconfirm'
    alias install 'yay -S --noconfirm'
    alias uninstall 'yay -Rns --noconfirm'
    alias update 'yay -Syu --noconfirm; and flatpak update -y'

    # Functions
    function up --description "Move up N directories (default 1)"
        set -l n 1
        if test (count $argv) -ge 1
            if string match -rq '^[0-9]+$' -- $argv[1]
                set n $argv[1]
            else
                echo "usage: up <non-negative integer>" >&2
                return 1
            end
        end
        set -l d ""
        for i in (seq $n)
            set d "$d../"
        end
        cd "$d"
    end

    function extract --description "Extract compressed files easily"
        set -l file $argv[1]
        if test -f "$file"
            switch $file
                case '*.tar.bz2'
                    tar xjf "$file"
                case '*.tar.gz'
                    tar xzf "$file"
                case '*.tar.xz'
                    tar xf "$file"
                case '*.tar.zst'
                    tar --zstd -xf "$file"
                case '*.bz2'
                    bunzip2 "$file"
                case '*.rar'
                    unrar x "$file"
                case '*.gz'
                    gunzip "$file"
                case '*.tar'
                    tar xf "$file"
                case '*.tbz2'
                    tar xjf "$file"
                case '*.tgz'
                    tar xzf "$file"
                case '*.zip'
                    unzip "$file"
                case '*.7z'
                    7z x "$file"
                case '*.xz'
                    unxz "$file"
                case '*.zst'
                    unzstd "$file"
                case '*'
                    echo "'$file' cannot be extracted via extract()"
            end
        else
            echo "'$file' is not a valid file"
        end
    end

    function alias-help --description "Show categorized aliases and helpers"
        echo 'Aliases'
        echo '======='
        echo 'Navigation:'
        echo '  ..      -> cd ..'
        echo '  ...     -> cd ../..'
        echo '  ....    -> cd ../../..'
        echo '  lsa     -> eza --icons -a'
        echo
        echo 'Safety:'
        echo '  cp      -> cp -iv'
        echo '  mv      -> mv -iv'
        echo '  rm      -> rm -iv'
        echo '  mkdir   -> mkdir -pv'
        echo '  src     -> source ~/.config/fish/config.fish'
        echo
        echo 'Git:'
        echo '  gpl     -> git pull'
        echo '  gco     -> git checkout'
        echo '  gb      -> git branch'
        echo '  gc      -> git clone'
        echo '  gs      -> git status'
        echo '  ga      -> git add'
        echo '  gcm     -> git commit -m'
        echo '  gcam    -> git commit -am'
        echo '  gp      -> git push'
        echo '  gl      -> git log --oneline --graph --decorate'
        echo '  gd      -> git diff'
        echo
        echo 'Package management:'
        echo '  pacman:'
        echo '    pi    -> sudo pacman -S --noconfirm'
        echo '    pr    -> sudo pacman -Rns --noconfirm'
        echo '    pu    -> sudo pacman -Syu --noconfirm'
        echo '  yay:'
        echo '    install   -> yay -S --noconfirm'
        echo '    uninstall -> yay -Rns --noconfirm'
        echo '    update    -> yay -Syu --noconfirm; and flatpak update -y'
        echo
        echo 'Misc:'
        echo '  ls      -> eza --icons'
        echo '  clear   -> clear screen'
        echo
        echo 'Functions'
        echo '========='
        echo '  up N             - Move up N directories (default 1)'
        echo '  extract FILE     - Extract compressed file by extension'
        echo '  alias-help       - Show this help'
    end
    
end
