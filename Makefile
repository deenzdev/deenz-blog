PUBLIC_DIR=public
HUGO_BASE_URL=https://www.deenzcan.com

build:
	rm -rf $(PUBLIC_DIR)
	hugo --minify -b $(HUGO_BASE_URL)

up:
	make build
	docker compose up --build -d
