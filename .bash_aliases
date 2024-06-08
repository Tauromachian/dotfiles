alias sudo="sudo "

alias v="nvim"

alias docker=podman
alias docker-compose=podman-compose

alias nr="npm run"
alias ni="corepack npm install"
alias y="corepack yarn"

alias ghost:start="ghost start --no-setup-linux-user"

alias rog="./Documents/rogauracore/rogauracore"
alias start-proxy="sudo bash ~/Documents/linux-proxy-starter/proxy.sh"

alias php8.0="podman run --rm -v $(pwd):/var/www/html --network host -p 8000:8000 localhost/php8.0 php"
alias php="/home/jose/.config/php/php"
alias composer='podman run --rm -v "$(pwd)":/app composer composer'
alias art="php artisan"
alias art:serve="podman run --rm --network host --interactive --tty -v $(pwd):/usr/src/myapp -w /usr/src/myapp -p 8000:8000 docker.io/library/php php artisan serve --host 0.0.0.0 --port 8000"
