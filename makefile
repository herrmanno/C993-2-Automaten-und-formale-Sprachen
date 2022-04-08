all:
	@for f in ./*/*md;\
	do\
	  pandoc --pdf-engine=xelatex -i "$$f" -o "$${f%.md}.pdf"; \
	done

.PHONY: all
