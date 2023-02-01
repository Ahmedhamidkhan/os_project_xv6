#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fcntl.h"

char buf[512];

int main(int argc, char *argv[]) {
	int fd0, fd1, n;

	if(argc < 2)
	{
		printf( "Need 2 arguments for this function to work!\n");
		exit(0);
	}


	if((fd0 = open(argv[1], O_RDONLY)) < 0)
	{
		printf("cp: cannot open %s\n", argv[1]);
		exit(0);
	}
	
	if((fd1 = open(argv[2], O_CREATE | O_WRONLY)) < 0)
	{
		printf("cp: cannot open %s\n", argv[2]);
		exit(0);
	}
	
	while ((n = read(fd0, buf, sizeof(buf))) > 0) {
		if (write(fd1, buf, n) != n) {
			printf("cp: cannot write on file.\n");
			exit(0);
		}
	}
	
	close(fd0);
	close(fd1);

	exit(0);	
}
