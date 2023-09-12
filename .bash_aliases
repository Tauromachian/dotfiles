alias sudo="sudo "

alias code="flatpak run com.visualstudio.code"

alias docker=podman
alias docker-compose=podman-compose

alias nr="npm run"
alias ni="npm install"
alias y="yarn"

alias rog="./Documents/rogauracore/rogauracore"
alias start-proxy="sudo bash ~/Documents/linux-proxy-starter/proxy.sh"

alias php8.0="podman run --rm -v $(pwd):/var/www/html --network host -p 8000:8000 localhost/php8.0 php"

alias php="podman run --interactive --tty --rm -v $(pwd):/var/www/html --network host -p 8000:8000 localhost/php8.2:latest php"
alias php-laravel-serve="podman run --rm --network host --interactive --tty -v $(pwd):/var/www/html -p 8000:8000 localhost/php8.2:latest php artisan serve --host 0.0.0.0 --port 8000"
alias composer="podman run --rm -v $(pwd):/app composer composer"

alias art="php artisan"
alias art:serve="php-laravel-serve"
