#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

char buf[512];

void cat(int fd, int check) {

	int n;
	int num = 1;
	int counter = 1;

	while((n = read(fd, buf, sizeof(buf))) > 0) {

		for(int x = 0; x < sizeof(buf); x++) {
			if(check == 1) {
				if(num == 1) {
					printf("%d: ", counter);
					num = 0;
					counter++;
				}
				
				if(buf[x] == '\n') {
					num = 1;
				}
			}
			
			printf("%c", buf[x]);
		}
		printf("\n");
	}
	
	if(n < 0){
		fprintf(2, "cat: read error\n");
		exit(1);
	}
}

int main(int argc, char *argv[]) {
	int fd, i;
	int check = 0;
	int start = 1;

	if(argc <= 1){
		cat(0, check);
		exit(0);
	}

	if(argv[1][0] == '-' && argv[1][1] == 'n') {
		check = 1;
		start = 2;
	}
	
	for(i = start; i < argc; i++){
		if((fd = open(argv[i], 0)) < 0){
			fprintf(2, "cat: cannot open %s\n", argv[i]);
			exit(1);
		}
		cat(fd, check);
		close(fd);
	}
	exit(0);
}
