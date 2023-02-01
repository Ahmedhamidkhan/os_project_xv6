
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char* fmtname(char *path) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
	static char buf[DIRSIZ+1];
	char *p;

	// Find first character after last slash.
	for(p=path+strlen(path); p >= path && *p != '/'; p--);
  10:	00000097          	auipc	ra,0x0
  14:	3b0080e7          	jalr	944(ra) # 3c0 <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
	p++;
  36:	00178493          	addi	s1,a5,1

	// Return blank-padded name.
	if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	384080e7          	jalr	900(ra) # 3c0 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
		return p;
		
	memmove(buf, p, strlen(p));
	memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
	return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
	memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	362080e7          	jalr	866(ra) # 3c0 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	faa98993          	addi	s3,s3,-86 # 1010 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	4bc080e7          	jalr	1212(ra) # 532 <memmove>
	memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	340080e7          	jalr	832(ra) # 3c0 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	332080e7          	jalr	818(ra) # 3c0 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	342080e7          	jalr	834(ra) # 3ea <memset>
	return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <ls>:

void ls(char *path, int check) {
  b4:	d7010113          	addi	sp,sp,-656
  b8:	28113423          	sd	ra,648(sp)
  bc:	28813023          	sd	s0,640(sp)
  c0:	26913c23          	sd	s1,632(sp)
  c4:	27213823          	sd	s2,624(sp)
  c8:	27313423          	sd	s3,616(sp)
  cc:	27413023          	sd	s4,608(sp)
  d0:	25513c23          	sd	s5,600(sp)
  d4:	25613823          	sd	s6,592(sp)
  d8:	25713423          	sd	s7,584(sp)
  dc:	25813023          	sd	s8,576(sp)
  e0:	23913c23          	sd	s9,568(sp)
  e4:	0d00                	addi	s0,sp,656
  e6:	89aa                	mv	s3,a0
  e8:	892e                	mv	s2,a1
	char buf[512], *p;
	int fd;
	struct dirent de;
	struct stat st;

	if((fd = open(path, 0)) < 0){
  ea:	4581                	li	a1,0
  ec:	00000097          	auipc	ra,0x0
  f0:	538080e7          	jalr	1336(ra) # 624 <open>
  f4:	08054c63          	bltz	a0,18c <ls+0xd8>
  f8:	84aa                	mv	s1,a0
		fprintf(2, "ls: cannot open %s\n", path);
		return;
	}

	if(fstat(fd, &st) < 0){
  fa:	d7840593          	addi	a1,s0,-648
  fe:	00000097          	auipc	ra,0x0
 102:	53e080e7          	jalr	1342(ra) # 63c <fstat>
 106:	08054e63          	bltz	a0,1a2 <ls+0xee>
		fprintf(2, "ls: cannot stat %s\n", path);
		close(fd);
		return;
	}

	switch(st.type){
 10a:	d8041783          	lh	a5,-640(s0)
 10e:	0007869b          	sext.w	a3,a5
 112:	4705                	li	a4,1
 114:	0ce68163          	beq	a3,a4,1d6 <ls+0x122>
 118:	37f9                	addiw	a5,a5,-2
 11a:	17c2                	slli	a5,a5,0x30
 11c:	93c1                	srli	a5,a5,0x30
 11e:	02f76963          	bltu	a4,a5,150 <ls+0x9c>
		case T_DEVICE:
		case T_FILE:
			if(check == 1) {
 122:	4785                	li	a5,1
 124:	08f90f63          	beq	s2,a5,1c2 <ls+0x10e>
				printf("%d: ", counter);
				counter++;
			}
			printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 128:	854e                	mv	a0,s3
 12a:	00000097          	auipc	ra,0x0
 12e:	ed6080e7          	jalr	-298(ra) # 0 <fmtname>
 132:	85aa                	mv	a1,a0
 134:	d8843703          	ld	a4,-632(s0)
 138:	d7c42683          	lw	a3,-644(s0)
 13c:	d8041603          	lh	a2,-640(s0)
 140:	00001517          	auipc	a0,0x1
 144:	9f850513          	addi	a0,a0,-1544 # b38 <malloc+0x122>
 148:	00001097          	auipc	ra,0x1
 14c:	816080e7          	jalr	-2026(ra) # 95e <printf>
				}
				printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
			}
			break;
	}
	close(fd);
 150:	8526                	mv	a0,s1
 152:	00000097          	auipc	ra,0x0
 156:	4ba080e7          	jalr	1210(ra) # 60c <close>
}
 15a:	28813083          	ld	ra,648(sp)
 15e:	28013403          	ld	s0,640(sp)
 162:	27813483          	ld	s1,632(sp)
 166:	27013903          	ld	s2,624(sp)
 16a:	26813983          	ld	s3,616(sp)
 16e:	26013a03          	ld	s4,608(sp)
 172:	25813a83          	ld	s5,600(sp)
 176:	25013b03          	ld	s6,592(sp)
 17a:	24813b83          	ld	s7,584(sp)
 17e:	24013c03          	ld	s8,576(sp)
 182:	23813c83          	ld	s9,568(sp)
 186:	29010113          	addi	sp,sp,656
 18a:	8082                	ret
		fprintf(2, "ls: cannot open %s\n", path);
 18c:	864e                	mv	a2,s3
 18e:	00001597          	auipc	a1,0x1
 192:	97258593          	addi	a1,a1,-1678 # b00 <malloc+0xea>
 196:	4509                	li	a0,2
 198:	00000097          	auipc	ra,0x0
 19c:	798080e7          	jalr	1944(ra) # 930 <fprintf>
		return;
 1a0:	bf6d                	j	15a <ls+0xa6>
		fprintf(2, "ls: cannot stat %s\n", path);
 1a2:	864e                	mv	a2,s3
 1a4:	00001597          	auipc	a1,0x1
 1a8:	97458593          	addi	a1,a1,-1676 # b18 <malloc+0x102>
 1ac:	4509                	li	a0,2
 1ae:	00000097          	auipc	ra,0x0
 1b2:	782080e7          	jalr	1922(ra) # 930 <fprintf>
		close(fd);
 1b6:	8526                	mv	a0,s1
 1b8:	00000097          	auipc	ra,0x0
 1bc:	454080e7          	jalr	1108(ra) # 60c <close>
		return;
 1c0:	bf69                	j	15a <ls+0xa6>
				printf("%d: ", counter);
 1c2:	4585                	li	a1,1
 1c4:	00001517          	auipc	a0,0x1
 1c8:	96c50513          	addi	a0,a0,-1684 # b30 <malloc+0x11a>
 1cc:	00000097          	auipc	ra,0x0
 1d0:	792080e7          	jalr	1938(ra) # 95e <printf>
				counter++;
 1d4:	bf91                	j	128 <ls+0x74>
			if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
 1d6:	854e                	mv	a0,s3
 1d8:	00000097          	auipc	ra,0x0
 1dc:	1e8080e7          	jalr	488(ra) # 3c0 <strlen>
 1e0:	2541                	addiw	a0,a0,16
 1e2:	20000793          	li	a5,512
 1e6:	00a7fb63          	bgeu	a5,a0,1fc <ls+0x148>
				printf("ls: path too long\n");
 1ea:	00001517          	auipc	a0,0x1
 1ee:	95e50513          	addi	a0,a0,-1698 # b48 <malloc+0x132>
 1f2:	00000097          	auipc	ra,0x0
 1f6:	76c080e7          	jalr	1900(ra) # 95e <printf>
				break;
 1fa:	bf99                	j	150 <ls+0x9c>
			strcpy(buf, path);
 1fc:	85ce                	mv	a1,s3
 1fe:	da040513          	addi	a0,s0,-608
 202:	00000097          	auipc	ra,0x0
 206:	176080e7          	jalr	374(ra) # 378 <strcpy>
			p = buf+strlen(buf);
 20a:	da040513          	addi	a0,s0,-608
 20e:	00000097          	auipc	ra,0x0
 212:	1b2080e7          	jalr	434(ra) # 3c0 <strlen>
 216:	1502                	slli	a0,a0,0x20
 218:	9101                	srli	a0,a0,0x20
 21a:	da040793          	addi	a5,s0,-608
 21e:	00a789b3          	add	s3,a5,a0
			*p++ = '/';
 222:	00198a13          	addi	s4,s3,1
 226:	02f00793          	li	a5,47
 22a:	00f98023          	sb	a5,0(s3)
	int counter = 1;
 22e:	4b85                	li	s7,1
				if(check == 1) {
 230:	4b05                	li	s6,1
				printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 232:	00001a97          	auipc	s5,0x1
 236:	92ea8a93          	addi	s5,s5,-1746 # b60 <malloc+0x14a>
					printf("%d: ", counter);
 23a:	00001c17          	auipc	s8,0x1
 23e:	8f6c0c13          	addi	s8,s8,-1802 # b30 <malloc+0x11a>
					printf("ls: cannot stat %s\n", buf);
 242:	00001c97          	auipc	s9,0x1
 246:	8d6c8c93          	addi	s9,s9,-1834 # b18 <malloc+0x102>
			while(read(fd, &de, sizeof(de)) == sizeof(de)) {
 24a:	a81d                	j	280 <ls+0x1cc>
					printf("ls: cannot stat %s\n", buf);
 24c:	da040593          	addi	a1,s0,-608
 250:	8566                	mv	a0,s9
 252:	00000097          	auipc	ra,0x0
 256:	70c080e7          	jalr	1804(ra) # 95e <printf>
					continue;
 25a:	a01d                	j	280 <ls+0x1cc>
				printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 25c:	da040513          	addi	a0,s0,-608
 260:	00000097          	auipc	ra,0x0
 264:	da0080e7          	jalr	-608(ra) # 0 <fmtname>
 268:	85aa                	mv	a1,a0
 26a:	d8843703          	ld	a4,-632(s0)
 26e:	d7c42683          	lw	a3,-644(s0)
 272:	d8041603          	lh	a2,-640(s0)
 276:	8556                	mv	a0,s5
 278:	00000097          	auipc	ra,0x0
 27c:	6e6080e7          	jalr	1766(ra) # 95e <printf>
			while(read(fd, &de, sizeof(de)) == sizeof(de)) {
 280:	4641                	li	a2,16
 282:	d9040593          	addi	a1,s0,-624
 286:	8526                	mv	a0,s1
 288:	00000097          	auipc	ra,0x0
 28c:	374080e7          	jalr	884(ra) # 5fc <read>
 290:	47c1                	li	a5,16
 292:	eaf51fe3          	bne	a0,a5,150 <ls+0x9c>
				if(de.inum == 0)
 296:	d9045783          	lhu	a5,-624(s0)
 29a:	d3fd                	beqz	a5,280 <ls+0x1cc>
				memmove(p, de.name, DIRSIZ);
 29c:	4639                	li	a2,14
 29e:	d9240593          	addi	a1,s0,-622
 2a2:	8552                	mv	a0,s4
 2a4:	00000097          	auipc	ra,0x0
 2a8:	28e080e7          	jalr	654(ra) # 532 <memmove>
				p[DIRSIZ] = 0;
 2ac:	000987a3          	sb	zero,15(s3)
				if(stat(buf, &st) < 0) {
 2b0:	d7840593          	addi	a1,s0,-648
 2b4:	da040513          	addi	a0,s0,-608
 2b8:	00000097          	auipc	ra,0x0
 2bc:	1ec080e7          	jalr	492(ra) # 4a4 <stat>
 2c0:	f80546e3          	bltz	a0,24c <ls+0x198>
				if(check == 1) {
 2c4:	f9691ce3          	bne	s2,s6,25c <ls+0x1a8>
					printf("%d: ", counter);
 2c8:	85de                	mv	a1,s7
 2ca:	8562                	mv	a0,s8
 2cc:	00000097          	auipc	ra,0x0
 2d0:	692080e7          	jalr	1682(ra) # 95e <printf>
					counter++;
 2d4:	2b85                	addiw	s7,s7,1
 2d6:	b759                	j	25c <ls+0x1a8>

00000000000002d8 <main>:

int main(int argc, char *argv[]) {
 2d8:	7179                	addi	sp,sp,-48
 2da:	f406                	sd	ra,40(sp)
 2dc:	f022                	sd	s0,32(sp)
 2de:	ec26                	sd	s1,24(sp)
 2e0:	e84a                	sd	s2,16(sp)
 2e2:	e44e                	sd	s3,8(sp)
 2e4:	1800                	addi	s0,sp,48
		int i;
	int check = 0;
	int start = 0;

	if(argv[1][0] == '-' && argv[1][1] == 'n') {
 2e6:	659c                	ld	a5,8(a1)
 2e8:	0007c683          	lbu	a3,0(a5)
 2ec:	02d00713          	li	a4,45
	int check = 0;
 2f0:	4981                	li	s3,0
	if(argv[1][0] == '-' && argv[1][1] == 'n') {
 2f2:	04e68163          	beq	a3,a4,334 <main+0x5c>
		check = 1;
		start = 1;
	}
	
	if(argc < (2 + start)){
 2f6:	00198493          	addi	s1,s3,1
 2fa:	04a4d463          	bge	s1,a0,342 <main+0x6a>
		ls(".", check);
		exit(0);
	}
	
	for(i=start+1; i<argc; i++)
 2fe:	048e                	slli	s1,s1,0x3
 300:	94ae                	add	s1,s1,a1
 302:	ffe5091b          	addiw	s2,a0,-2
 306:	4139093b          	subw	s2,s2,s3
 30a:	1902                	slli	s2,s2,0x20
 30c:	02095913          	srli	s2,s2,0x20
 310:	994e                	add	s2,s2,s3
 312:	090e                	slli	s2,s2,0x3
 314:	05c1                	addi	a1,a1,16
 316:	992e                	add	s2,s2,a1
		ls(argv[i], check);
 318:	85ce                	mv	a1,s3
 31a:	6088                	ld	a0,0(s1)
 31c:	00000097          	auipc	ra,0x0
 320:	d98080e7          	jalr	-616(ra) # b4 <ls>
	for(i=start+1; i<argc; i++)
 324:	04a1                	addi	s1,s1,8
 326:	ff2499e3          	bne	s1,s2,318 <main+0x40>
		
	exit(0);
 32a:	4501                	li	a0,0
 32c:	00000097          	auipc	ra,0x0
 330:	2b8080e7          	jalr	696(ra) # 5e4 <exit>
	if(argv[1][0] == '-' && argv[1][1] == 'n') {
 334:	0017c983          	lbu	s3,1(a5)
 338:	f9298993          	addi	s3,s3,-110
	int check = 0;
 33c:	0019b993          	seqz	s3,s3
 340:	bf5d                	j	2f6 <main+0x1e>
		ls(".", check);
 342:	85ce                	mv	a1,s3
 344:	00001517          	auipc	a0,0x1
 348:	82c50513          	addi	a0,a0,-2004 # b70 <malloc+0x15a>
 34c:	00000097          	auipc	ra,0x0
 350:	d68080e7          	jalr	-664(ra) # b4 <ls>
		exit(0);
 354:	4501                	li	a0,0
 356:	00000097          	auipc	ra,0x0
 35a:	28e080e7          	jalr	654(ra) # 5e4 <exit>

000000000000035e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 35e:	1141                	addi	sp,sp,-16
 360:	e406                	sd	ra,8(sp)
 362:	e022                	sd	s0,0(sp)
 364:	0800                	addi	s0,sp,16
  extern int main();
  main();
 366:	00000097          	auipc	ra,0x0
 36a:	f72080e7          	jalr	-142(ra) # 2d8 <main>
  exit(0);
 36e:	4501                	li	a0,0
 370:	00000097          	auipc	ra,0x0
 374:	274080e7          	jalr	628(ra) # 5e4 <exit>

0000000000000378 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e422                	sd	s0,8(sp)
 37c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 37e:	87aa                	mv	a5,a0
 380:	0585                	addi	a1,a1,1
 382:	0785                	addi	a5,a5,1
 384:	fff5c703          	lbu	a4,-1(a1)
 388:	fee78fa3          	sb	a4,-1(a5)
 38c:	fb75                	bnez	a4,380 <strcpy+0x8>
    ;
  return os;
}
 38e:	6422                	ld	s0,8(sp)
 390:	0141                	addi	sp,sp,16
 392:	8082                	ret

0000000000000394 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 394:	1141                	addi	sp,sp,-16
 396:	e422                	sd	s0,8(sp)
 398:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 39a:	00054783          	lbu	a5,0(a0)
 39e:	cb91                	beqz	a5,3b2 <strcmp+0x1e>
 3a0:	0005c703          	lbu	a4,0(a1)
 3a4:	00f71763          	bne	a4,a5,3b2 <strcmp+0x1e>
    p++, q++;
 3a8:	0505                	addi	a0,a0,1
 3aa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3ac:	00054783          	lbu	a5,0(a0)
 3b0:	fbe5                	bnez	a5,3a0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3b2:	0005c503          	lbu	a0,0(a1)
}
 3b6:	40a7853b          	subw	a0,a5,a0
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret

00000000000003c0 <strlen>:

uint
strlen(const char *s)
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e422                	sd	s0,8(sp)
 3c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3c6:	00054783          	lbu	a5,0(a0)
 3ca:	cf91                	beqz	a5,3e6 <strlen+0x26>
 3cc:	0505                	addi	a0,a0,1
 3ce:	87aa                	mv	a5,a0
 3d0:	4685                	li	a3,1
 3d2:	9e89                	subw	a3,a3,a0
 3d4:	00f6853b          	addw	a0,a3,a5
 3d8:	0785                	addi	a5,a5,1
 3da:	fff7c703          	lbu	a4,-1(a5)
 3de:	fb7d                	bnez	a4,3d4 <strlen+0x14>
    ;
  return n;
}
 3e0:	6422                	ld	s0,8(sp)
 3e2:	0141                	addi	sp,sp,16
 3e4:	8082                	ret
  for(n = 0; s[n]; n++)
 3e6:	4501                	li	a0,0
 3e8:	bfe5                	j	3e0 <strlen+0x20>

00000000000003ea <memset>:

void*
memset(void *dst, int c, uint n)
{
 3ea:	1141                	addi	sp,sp,-16
 3ec:	e422                	sd	s0,8(sp)
 3ee:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3f0:	ca19                	beqz	a2,406 <memset+0x1c>
 3f2:	87aa                	mv	a5,a0
 3f4:	1602                	slli	a2,a2,0x20
 3f6:	9201                	srli	a2,a2,0x20
 3f8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3fc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 400:	0785                	addi	a5,a5,1
 402:	fee79de3          	bne	a5,a4,3fc <memset+0x12>
  }
  return dst;
}
 406:	6422                	ld	s0,8(sp)
 408:	0141                	addi	sp,sp,16
 40a:	8082                	ret

000000000000040c <strchr>:

char*
strchr(const char *s, char c)
{
 40c:	1141                	addi	sp,sp,-16
 40e:	e422                	sd	s0,8(sp)
 410:	0800                	addi	s0,sp,16
  for(; *s; s++)
 412:	00054783          	lbu	a5,0(a0)
 416:	cb99                	beqz	a5,42c <strchr+0x20>
    if(*s == c)
 418:	00f58763          	beq	a1,a5,426 <strchr+0x1a>
  for(; *s; s++)
 41c:	0505                	addi	a0,a0,1
 41e:	00054783          	lbu	a5,0(a0)
 422:	fbfd                	bnez	a5,418 <strchr+0xc>
      return (char*)s;
  return 0;
 424:	4501                	li	a0,0
}
 426:	6422                	ld	s0,8(sp)
 428:	0141                	addi	sp,sp,16
 42a:	8082                	ret
  return 0;
 42c:	4501                	li	a0,0
 42e:	bfe5                	j	426 <strchr+0x1a>

0000000000000430 <gets>:

char*
gets(char *buf, int max)
{
 430:	711d                	addi	sp,sp,-96
 432:	ec86                	sd	ra,88(sp)
 434:	e8a2                	sd	s0,80(sp)
 436:	e4a6                	sd	s1,72(sp)
 438:	e0ca                	sd	s2,64(sp)
 43a:	fc4e                	sd	s3,56(sp)
 43c:	f852                	sd	s4,48(sp)
 43e:	f456                	sd	s5,40(sp)
 440:	f05a                	sd	s6,32(sp)
 442:	ec5e                	sd	s7,24(sp)
 444:	1080                	addi	s0,sp,96
 446:	8baa                	mv	s7,a0
 448:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 44a:	892a                	mv	s2,a0
 44c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 44e:	4aa9                	li	s5,10
 450:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 452:	89a6                	mv	s3,s1
 454:	2485                	addiw	s1,s1,1
 456:	0344d863          	bge	s1,s4,486 <gets+0x56>
    cc = read(0, &c, 1);
 45a:	4605                	li	a2,1
 45c:	faf40593          	addi	a1,s0,-81
 460:	4501                	li	a0,0
 462:	00000097          	auipc	ra,0x0
 466:	19a080e7          	jalr	410(ra) # 5fc <read>
    if(cc < 1)
 46a:	00a05e63          	blez	a0,486 <gets+0x56>
    buf[i++] = c;
 46e:	faf44783          	lbu	a5,-81(s0)
 472:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 476:	01578763          	beq	a5,s5,484 <gets+0x54>
 47a:	0905                	addi	s2,s2,1
 47c:	fd679be3          	bne	a5,s6,452 <gets+0x22>
  for(i=0; i+1 < max; ){
 480:	89a6                	mv	s3,s1
 482:	a011                	j	486 <gets+0x56>
 484:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 486:	99de                	add	s3,s3,s7
 488:	00098023          	sb	zero,0(s3)
  return buf;
}
 48c:	855e                	mv	a0,s7
 48e:	60e6                	ld	ra,88(sp)
 490:	6446                	ld	s0,80(sp)
 492:	64a6                	ld	s1,72(sp)
 494:	6906                	ld	s2,64(sp)
 496:	79e2                	ld	s3,56(sp)
 498:	7a42                	ld	s4,48(sp)
 49a:	7aa2                	ld	s5,40(sp)
 49c:	7b02                	ld	s6,32(sp)
 49e:	6be2                	ld	s7,24(sp)
 4a0:	6125                	addi	sp,sp,96
 4a2:	8082                	ret

00000000000004a4 <stat>:

int
stat(const char *n, struct stat *st)
{
 4a4:	1101                	addi	sp,sp,-32
 4a6:	ec06                	sd	ra,24(sp)
 4a8:	e822                	sd	s0,16(sp)
 4aa:	e426                	sd	s1,8(sp)
 4ac:	e04a                	sd	s2,0(sp)
 4ae:	1000                	addi	s0,sp,32
 4b0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b2:	4581                	li	a1,0
 4b4:	00000097          	auipc	ra,0x0
 4b8:	170080e7          	jalr	368(ra) # 624 <open>
  if(fd < 0)
 4bc:	02054563          	bltz	a0,4e6 <stat+0x42>
 4c0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4c2:	85ca                	mv	a1,s2
 4c4:	00000097          	auipc	ra,0x0
 4c8:	178080e7          	jalr	376(ra) # 63c <fstat>
 4cc:	892a                	mv	s2,a0
  close(fd);
 4ce:	8526                	mv	a0,s1
 4d0:	00000097          	auipc	ra,0x0
 4d4:	13c080e7          	jalr	316(ra) # 60c <close>
  return r;
}
 4d8:	854a                	mv	a0,s2
 4da:	60e2                	ld	ra,24(sp)
 4dc:	6442                	ld	s0,16(sp)
 4de:	64a2                	ld	s1,8(sp)
 4e0:	6902                	ld	s2,0(sp)
 4e2:	6105                	addi	sp,sp,32
 4e4:	8082                	ret
    return -1;
 4e6:	597d                	li	s2,-1
 4e8:	bfc5                	j	4d8 <stat+0x34>

00000000000004ea <atoi>:

int
atoi(const char *s)
{
 4ea:	1141                	addi	sp,sp,-16
 4ec:	e422                	sd	s0,8(sp)
 4ee:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4f0:	00054683          	lbu	a3,0(a0)
 4f4:	fd06879b          	addiw	a5,a3,-48
 4f8:	0ff7f793          	zext.b	a5,a5
 4fc:	4625                	li	a2,9
 4fe:	02f66863          	bltu	a2,a5,52e <atoi+0x44>
 502:	872a                	mv	a4,a0
  n = 0;
 504:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 506:	0705                	addi	a4,a4,1
 508:	0025179b          	slliw	a5,a0,0x2
 50c:	9fa9                	addw	a5,a5,a0
 50e:	0017979b          	slliw	a5,a5,0x1
 512:	9fb5                	addw	a5,a5,a3
 514:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 518:	00074683          	lbu	a3,0(a4)
 51c:	fd06879b          	addiw	a5,a3,-48
 520:	0ff7f793          	zext.b	a5,a5
 524:	fef671e3          	bgeu	a2,a5,506 <atoi+0x1c>
  return n;
}
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret
  n = 0;
 52e:	4501                	li	a0,0
 530:	bfe5                	j	528 <atoi+0x3e>

0000000000000532 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 532:	1141                	addi	sp,sp,-16
 534:	e422                	sd	s0,8(sp)
 536:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 538:	02b57463          	bgeu	a0,a1,560 <memmove+0x2e>
    while(n-- > 0)
 53c:	00c05f63          	blez	a2,55a <memmove+0x28>
 540:	1602                	slli	a2,a2,0x20
 542:	9201                	srli	a2,a2,0x20
 544:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 548:	872a                	mv	a4,a0
      *dst++ = *src++;
 54a:	0585                	addi	a1,a1,1
 54c:	0705                	addi	a4,a4,1
 54e:	fff5c683          	lbu	a3,-1(a1)
 552:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 556:	fee79ae3          	bne	a5,a4,54a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 55a:	6422                	ld	s0,8(sp)
 55c:	0141                	addi	sp,sp,16
 55e:	8082                	ret
    dst += n;
 560:	00c50733          	add	a4,a0,a2
    src += n;
 564:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 566:	fec05ae3          	blez	a2,55a <memmove+0x28>
 56a:	fff6079b          	addiw	a5,a2,-1
 56e:	1782                	slli	a5,a5,0x20
 570:	9381                	srli	a5,a5,0x20
 572:	fff7c793          	not	a5,a5
 576:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 578:	15fd                	addi	a1,a1,-1
 57a:	177d                	addi	a4,a4,-1
 57c:	0005c683          	lbu	a3,0(a1)
 580:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 584:	fee79ae3          	bne	a5,a4,578 <memmove+0x46>
 588:	bfc9                	j	55a <memmove+0x28>

000000000000058a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 58a:	1141                	addi	sp,sp,-16
 58c:	e422                	sd	s0,8(sp)
 58e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 590:	ca05                	beqz	a2,5c0 <memcmp+0x36>
 592:	fff6069b          	addiw	a3,a2,-1
 596:	1682                	slli	a3,a3,0x20
 598:	9281                	srli	a3,a3,0x20
 59a:	0685                	addi	a3,a3,1
 59c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 59e:	00054783          	lbu	a5,0(a0)
 5a2:	0005c703          	lbu	a4,0(a1)
 5a6:	00e79863          	bne	a5,a4,5b6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5aa:	0505                	addi	a0,a0,1
    p2++;
 5ac:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5ae:	fed518e3          	bne	a0,a3,59e <memcmp+0x14>
  }
  return 0;
 5b2:	4501                	li	a0,0
 5b4:	a019                	j	5ba <memcmp+0x30>
      return *p1 - *p2;
 5b6:	40e7853b          	subw	a0,a5,a4
}
 5ba:	6422                	ld	s0,8(sp)
 5bc:	0141                	addi	sp,sp,16
 5be:	8082                	ret
  return 0;
 5c0:	4501                	li	a0,0
 5c2:	bfe5                	j	5ba <memcmp+0x30>

00000000000005c4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5c4:	1141                	addi	sp,sp,-16
 5c6:	e406                	sd	ra,8(sp)
 5c8:	e022                	sd	s0,0(sp)
 5ca:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5cc:	00000097          	auipc	ra,0x0
 5d0:	f66080e7          	jalr	-154(ra) # 532 <memmove>
}
 5d4:	60a2                	ld	ra,8(sp)
 5d6:	6402                	ld	s0,0(sp)
 5d8:	0141                	addi	sp,sp,16
 5da:	8082                	ret

00000000000005dc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5dc:	4885                	li	a7,1
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5e4:	4889                	li	a7,2
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ec:	488d                	li	a7,3
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5f4:	4891                	li	a7,4
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <read>:
.global read
read:
 li a7, SYS_read
 5fc:	4895                	li	a7,5
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <write>:
.global write
write:
 li a7, SYS_write
 604:	48c1                	li	a7,16
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <close>:
.global close
close:
 li a7, SYS_close
 60c:	48d5                	li	a7,21
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <kill>:
.global kill
kill:
 li a7, SYS_kill
 614:	4899                	li	a7,6
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <exec>:
.global exec
exec:
 li a7, SYS_exec
 61c:	489d                	li	a7,7
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <open>:
.global open
open:
 li a7, SYS_open
 624:	48bd                	li	a7,15
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 62c:	48c5                	li	a7,17
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 634:	48c9                	li	a7,18
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 63c:	48a1                	li	a7,8
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <link>:
.global link
link:
 li a7, SYS_link
 644:	48cd                	li	a7,19
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 64c:	48d1                	li	a7,20
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 654:	48a5                	li	a7,9
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <dup>:
.global dup
dup:
 li a7, SYS_dup
 65c:	48a9                	li	a7,10
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 664:	48ad                	li	a7,11
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 66c:	48b1                	li	a7,12
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 674:	48b5                	li	a7,13
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 67c:	48b9                	li	a7,14
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 684:	1101                	addi	sp,sp,-32
 686:	ec06                	sd	ra,24(sp)
 688:	e822                	sd	s0,16(sp)
 68a:	1000                	addi	s0,sp,32
 68c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 690:	4605                	li	a2,1
 692:	fef40593          	addi	a1,s0,-17
 696:	00000097          	auipc	ra,0x0
 69a:	f6e080e7          	jalr	-146(ra) # 604 <write>
}
 69e:	60e2                	ld	ra,24(sp)
 6a0:	6442                	ld	s0,16(sp)
 6a2:	6105                	addi	sp,sp,32
 6a4:	8082                	ret

00000000000006a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6a6:	7139                	addi	sp,sp,-64
 6a8:	fc06                	sd	ra,56(sp)
 6aa:	f822                	sd	s0,48(sp)
 6ac:	f426                	sd	s1,40(sp)
 6ae:	f04a                	sd	s2,32(sp)
 6b0:	ec4e                	sd	s3,24(sp)
 6b2:	0080                	addi	s0,sp,64
 6b4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6b6:	c299                	beqz	a3,6bc <printint+0x16>
 6b8:	0805c963          	bltz	a1,74a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6bc:	2581                	sext.w	a1,a1
  neg = 0;
 6be:	4881                	li	a7,0
 6c0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6c4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6c6:	2601                	sext.w	a2,a2
 6c8:	00000517          	auipc	a0,0x0
 6cc:	51050513          	addi	a0,a0,1296 # bd8 <digits>
 6d0:	883a                	mv	a6,a4
 6d2:	2705                	addiw	a4,a4,1
 6d4:	02c5f7bb          	remuw	a5,a1,a2
 6d8:	1782                	slli	a5,a5,0x20
 6da:	9381                	srli	a5,a5,0x20
 6dc:	97aa                	add	a5,a5,a0
 6de:	0007c783          	lbu	a5,0(a5)
 6e2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6e6:	0005879b          	sext.w	a5,a1
 6ea:	02c5d5bb          	divuw	a1,a1,a2
 6ee:	0685                	addi	a3,a3,1
 6f0:	fec7f0e3          	bgeu	a5,a2,6d0 <printint+0x2a>
  if(neg)
 6f4:	00088c63          	beqz	a7,70c <printint+0x66>
    buf[i++] = '-';
 6f8:	fd070793          	addi	a5,a4,-48
 6fc:	00878733          	add	a4,a5,s0
 700:	02d00793          	li	a5,45
 704:	fef70823          	sb	a5,-16(a4)
 708:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 70c:	02e05863          	blez	a4,73c <printint+0x96>
 710:	fc040793          	addi	a5,s0,-64
 714:	00e78933          	add	s2,a5,a4
 718:	fff78993          	addi	s3,a5,-1
 71c:	99ba                	add	s3,s3,a4
 71e:	377d                	addiw	a4,a4,-1
 720:	1702                	slli	a4,a4,0x20
 722:	9301                	srli	a4,a4,0x20
 724:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 728:	fff94583          	lbu	a1,-1(s2)
 72c:	8526                	mv	a0,s1
 72e:	00000097          	auipc	ra,0x0
 732:	f56080e7          	jalr	-170(ra) # 684 <putc>
  while(--i >= 0)
 736:	197d                	addi	s2,s2,-1
 738:	ff3918e3          	bne	s2,s3,728 <printint+0x82>
}
 73c:	70e2                	ld	ra,56(sp)
 73e:	7442                	ld	s0,48(sp)
 740:	74a2                	ld	s1,40(sp)
 742:	7902                	ld	s2,32(sp)
 744:	69e2                	ld	s3,24(sp)
 746:	6121                	addi	sp,sp,64
 748:	8082                	ret
    x = -xx;
 74a:	40b005bb          	negw	a1,a1
    neg = 1;
 74e:	4885                	li	a7,1
    x = -xx;
 750:	bf85                	j	6c0 <printint+0x1a>

0000000000000752 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 752:	7119                	addi	sp,sp,-128
 754:	fc86                	sd	ra,120(sp)
 756:	f8a2                	sd	s0,112(sp)
 758:	f4a6                	sd	s1,104(sp)
 75a:	f0ca                	sd	s2,96(sp)
 75c:	ecce                	sd	s3,88(sp)
 75e:	e8d2                	sd	s4,80(sp)
 760:	e4d6                	sd	s5,72(sp)
 762:	e0da                	sd	s6,64(sp)
 764:	fc5e                	sd	s7,56(sp)
 766:	f862                	sd	s8,48(sp)
 768:	f466                	sd	s9,40(sp)
 76a:	f06a                	sd	s10,32(sp)
 76c:	ec6e                	sd	s11,24(sp)
 76e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 770:	0005c903          	lbu	s2,0(a1)
 774:	18090f63          	beqz	s2,912 <vprintf+0x1c0>
 778:	8aaa                	mv	s5,a0
 77a:	8b32                	mv	s6,a2
 77c:	00158493          	addi	s1,a1,1
  state = 0;
 780:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 782:	02500a13          	li	s4,37
 786:	4c55                	li	s8,21
 788:	00000c97          	auipc	s9,0x0
 78c:	3f8c8c93          	addi	s9,s9,1016 # b80 <malloc+0x16a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 790:	02800d93          	li	s11,40
  putc(fd, 'x');
 794:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 796:	00000b97          	auipc	s7,0x0
 79a:	442b8b93          	addi	s7,s7,1090 # bd8 <digits>
 79e:	a839                	j	7bc <vprintf+0x6a>
        putc(fd, c);
 7a0:	85ca                	mv	a1,s2
 7a2:	8556                	mv	a0,s5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	ee0080e7          	jalr	-288(ra) # 684 <putc>
 7ac:	a019                	j	7b2 <vprintf+0x60>
    } else if(state == '%'){
 7ae:	01498d63          	beq	s3,s4,7c8 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 7b2:	0485                	addi	s1,s1,1
 7b4:	fff4c903          	lbu	s2,-1(s1)
 7b8:	14090d63          	beqz	s2,912 <vprintf+0x1c0>
    if(state == 0){
 7bc:	fe0999e3          	bnez	s3,7ae <vprintf+0x5c>
      if(c == '%'){
 7c0:	ff4910e3          	bne	s2,s4,7a0 <vprintf+0x4e>
        state = '%';
 7c4:	89d2                	mv	s3,s4
 7c6:	b7f5                	j	7b2 <vprintf+0x60>
      if(c == 'd'){
 7c8:	11490c63          	beq	s2,s4,8e0 <vprintf+0x18e>
 7cc:	f9d9079b          	addiw	a5,s2,-99
 7d0:	0ff7f793          	zext.b	a5,a5
 7d4:	10fc6e63          	bltu	s8,a5,8f0 <vprintf+0x19e>
 7d8:	f9d9079b          	addiw	a5,s2,-99
 7dc:	0ff7f713          	zext.b	a4,a5
 7e0:	10ec6863          	bltu	s8,a4,8f0 <vprintf+0x19e>
 7e4:	00271793          	slli	a5,a4,0x2
 7e8:	97e6                	add	a5,a5,s9
 7ea:	439c                	lw	a5,0(a5)
 7ec:	97e6                	add	a5,a5,s9
 7ee:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7f0:	008b0913          	addi	s2,s6,8
 7f4:	4685                	li	a3,1
 7f6:	4629                	li	a2,10
 7f8:	000b2583          	lw	a1,0(s6)
 7fc:	8556                	mv	a0,s5
 7fe:	00000097          	auipc	ra,0x0
 802:	ea8080e7          	jalr	-344(ra) # 6a6 <printint>
 806:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 808:	4981                	li	s3,0
 80a:	b765                	j	7b2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 80c:	008b0913          	addi	s2,s6,8
 810:	4681                	li	a3,0
 812:	4629                	li	a2,10
 814:	000b2583          	lw	a1,0(s6)
 818:	8556                	mv	a0,s5
 81a:	00000097          	auipc	ra,0x0
 81e:	e8c080e7          	jalr	-372(ra) # 6a6 <printint>
 822:	8b4a                	mv	s6,s2
      state = 0;
 824:	4981                	li	s3,0
 826:	b771                	j	7b2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 828:	008b0913          	addi	s2,s6,8
 82c:	4681                	li	a3,0
 82e:	866a                	mv	a2,s10
 830:	000b2583          	lw	a1,0(s6)
 834:	8556                	mv	a0,s5
 836:	00000097          	auipc	ra,0x0
 83a:	e70080e7          	jalr	-400(ra) # 6a6 <printint>
 83e:	8b4a                	mv	s6,s2
      state = 0;
 840:	4981                	li	s3,0
 842:	bf85                	j	7b2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 844:	008b0793          	addi	a5,s6,8
 848:	f8f43423          	sd	a5,-120(s0)
 84c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 850:	03000593          	li	a1,48
 854:	8556                	mv	a0,s5
 856:	00000097          	auipc	ra,0x0
 85a:	e2e080e7          	jalr	-466(ra) # 684 <putc>
  putc(fd, 'x');
 85e:	07800593          	li	a1,120
 862:	8556                	mv	a0,s5
 864:	00000097          	auipc	ra,0x0
 868:	e20080e7          	jalr	-480(ra) # 684 <putc>
 86c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 86e:	03c9d793          	srli	a5,s3,0x3c
 872:	97de                	add	a5,a5,s7
 874:	0007c583          	lbu	a1,0(a5)
 878:	8556                	mv	a0,s5
 87a:	00000097          	auipc	ra,0x0
 87e:	e0a080e7          	jalr	-502(ra) # 684 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 882:	0992                	slli	s3,s3,0x4
 884:	397d                	addiw	s2,s2,-1
 886:	fe0914e3          	bnez	s2,86e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 88a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 88e:	4981                	li	s3,0
 890:	b70d                	j	7b2 <vprintf+0x60>
        s = va_arg(ap, char*);
 892:	008b0913          	addi	s2,s6,8
 896:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 89a:	02098163          	beqz	s3,8bc <vprintf+0x16a>
        while(*s != 0){
 89e:	0009c583          	lbu	a1,0(s3)
 8a2:	c5ad                	beqz	a1,90c <vprintf+0x1ba>
          putc(fd, *s);
 8a4:	8556                	mv	a0,s5
 8a6:	00000097          	auipc	ra,0x0
 8aa:	dde080e7          	jalr	-546(ra) # 684 <putc>
          s++;
 8ae:	0985                	addi	s3,s3,1
        while(*s != 0){
 8b0:	0009c583          	lbu	a1,0(s3)
 8b4:	f9e5                	bnez	a1,8a4 <vprintf+0x152>
        s = va_arg(ap, char*);
 8b6:	8b4a                	mv	s6,s2
      state = 0;
 8b8:	4981                	li	s3,0
 8ba:	bde5                	j	7b2 <vprintf+0x60>
          s = "(null)";
 8bc:	00000997          	auipc	s3,0x0
 8c0:	2bc98993          	addi	s3,s3,700 # b78 <malloc+0x162>
        while(*s != 0){
 8c4:	85ee                	mv	a1,s11
 8c6:	bff9                	j	8a4 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 8c8:	008b0913          	addi	s2,s6,8
 8cc:	000b4583          	lbu	a1,0(s6)
 8d0:	8556                	mv	a0,s5
 8d2:	00000097          	auipc	ra,0x0
 8d6:	db2080e7          	jalr	-590(ra) # 684 <putc>
 8da:	8b4a                	mv	s6,s2
      state = 0;
 8dc:	4981                	li	s3,0
 8de:	bdd1                	j	7b2 <vprintf+0x60>
        putc(fd, c);
 8e0:	85d2                	mv	a1,s4
 8e2:	8556                	mv	a0,s5
 8e4:	00000097          	auipc	ra,0x0
 8e8:	da0080e7          	jalr	-608(ra) # 684 <putc>
      state = 0;
 8ec:	4981                	li	s3,0
 8ee:	b5d1                	j	7b2 <vprintf+0x60>
        putc(fd, '%');
 8f0:	85d2                	mv	a1,s4
 8f2:	8556                	mv	a0,s5
 8f4:	00000097          	auipc	ra,0x0
 8f8:	d90080e7          	jalr	-624(ra) # 684 <putc>
        putc(fd, c);
 8fc:	85ca                	mv	a1,s2
 8fe:	8556                	mv	a0,s5
 900:	00000097          	auipc	ra,0x0
 904:	d84080e7          	jalr	-636(ra) # 684 <putc>
      state = 0;
 908:	4981                	li	s3,0
 90a:	b565                	j	7b2 <vprintf+0x60>
        s = va_arg(ap, char*);
 90c:	8b4a                	mv	s6,s2
      state = 0;
 90e:	4981                	li	s3,0
 910:	b54d                	j	7b2 <vprintf+0x60>
    }
  }
}
 912:	70e6                	ld	ra,120(sp)
 914:	7446                	ld	s0,112(sp)
 916:	74a6                	ld	s1,104(sp)
 918:	7906                	ld	s2,96(sp)
 91a:	69e6                	ld	s3,88(sp)
 91c:	6a46                	ld	s4,80(sp)
 91e:	6aa6                	ld	s5,72(sp)
 920:	6b06                	ld	s6,64(sp)
 922:	7be2                	ld	s7,56(sp)
 924:	7c42                	ld	s8,48(sp)
 926:	7ca2                	ld	s9,40(sp)
 928:	7d02                	ld	s10,32(sp)
 92a:	6de2                	ld	s11,24(sp)
 92c:	6109                	addi	sp,sp,128
 92e:	8082                	ret

0000000000000930 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 930:	715d                	addi	sp,sp,-80
 932:	ec06                	sd	ra,24(sp)
 934:	e822                	sd	s0,16(sp)
 936:	1000                	addi	s0,sp,32
 938:	e010                	sd	a2,0(s0)
 93a:	e414                	sd	a3,8(s0)
 93c:	e818                	sd	a4,16(s0)
 93e:	ec1c                	sd	a5,24(s0)
 940:	03043023          	sd	a6,32(s0)
 944:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 948:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 94c:	8622                	mv	a2,s0
 94e:	00000097          	auipc	ra,0x0
 952:	e04080e7          	jalr	-508(ra) # 752 <vprintf>
}
 956:	60e2                	ld	ra,24(sp)
 958:	6442                	ld	s0,16(sp)
 95a:	6161                	addi	sp,sp,80
 95c:	8082                	ret

000000000000095e <printf>:

void
printf(const char *fmt, ...)
{
 95e:	711d                	addi	sp,sp,-96
 960:	ec06                	sd	ra,24(sp)
 962:	e822                	sd	s0,16(sp)
 964:	1000                	addi	s0,sp,32
 966:	e40c                	sd	a1,8(s0)
 968:	e810                	sd	a2,16(s0)
 96a:	ec14                	sd	a3,24(s0)
 96c:	f018                	sd	a4,32(s0)
 96e:	f41c                	sd	a5,40(s0)
 970:	03043823          	sd	a6,48(s0)
 974:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 978:	00840613          	addi	a2,s0,8
 97c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 980:	85aa                	mv	a1,a0
 982:	4505                	li	a0,1
 984:	00000097          	auipc	ra,0x0
 988:	dce080e7          	jalr	-562(ra) # 752 <vprintf>
}
 98c:	60e2                	ld	ra,24(sp)
 98e:	6442                	ld	s0,16(sp)
 990:	6125                	addi	sp,sp,96
 992:	8082                	ret

0000000000000994 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 994:	1141                	addi	sp,sp,-16
 996:	e422                	sd	s0,8(sp)
 998:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 99a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 99e:	00000797          	auipc	a5,0x0
 9a2:	6627b783          	ld	a5,1634(a5) # 1000 <freep>
 9a6:	a02d                	j	9d0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9a8:	4618                	lw	a4,8(a2)
 9aa:	9f2d                	addw	a4,a4,a1
 9ac:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9b0:	6398                	ld	a4,0(a5)
 9b2:	6310                	ld	a2,0(a4)
 9b4:	a83d                	j	9f2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9b6:	ff852703          	lw	a4,-8(a0)
 9ba:	9f31                	addw	a4,a4,a2
 9bc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9be:	ff053683          	ld	a3,-16(a0)
 9c2:	a091                	j	a06 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c4:	6398                	ld	a4,0(a5)
 9c6:	00e7e463          	bltu	a5,a4,9ce <free+0x3a>
 9ca:	00e6ea63          	bltu	a3,a4,9de <free+0x4a>
{
 9ce:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d0:	fed7fae3          	bgeu	a5,a3,9c4 <free+0x30>
 9d4:	6398                	ld	a4,0(a5)
 9d6:	00e6e463          	bltu	a3,a4,9de <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9da:	fee7eae3          	bltu	a5,a4,9ce <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9de:	ff852583          	lw	a1,-8(a0)
 9e2:	6390                	ld	a2,0(a5)
 9e4:	02059813          	slli	a6,a1,0x20
 9e8:	01c85713          	srli	a4,a6,0x1c
 9ec:	9736                	add	a4,a4,a3
 9ee:	fae60de3          	beq	a2,a4,9a8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9f2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9f6:	4790                	lw	a2,8(a5)
 9f8:	02061593          	slli	a1,a2,0x20
 9fc:	01c5d713          	srli	a4,a1,0x1c
 a00:	973e                	add	a4,a4,a5
 a02:	fae68ae3          	beq	a3,a4,9b6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a06:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a08:	00000717          	auipc	a4,0x0
 a0c:	5ef73c23          	sd	a5,1528(a4) # 1000 <freep>
}
 a10:	6422                	ld	s0,8(sp)
 a12:	0141                	addi	sp,sp,16
 a14:	8082                	ret

0000000000000a16 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a16:	7139                	addi	sp,sp,-64
 a18:	fc06                	sd	ra,56(sp)
 a1a:	f822                	sd	s0,48(sp)
 a1c:	f426                	sd	s1,40(sp)
 a1e:	f04a                	sd	s2,32(sp)
 a20:	ec4e                	sd	s3,24(sp)
 a22:	e852                	sd	s4,16(sp)
 a24:	e456                	sd	s5,8(sp)
 a26:	e05a                	sd	s6,0(sp)
 a28:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a2a:	02051493          	slli	s1,a0,0x20
 a2e:	9081                	srli	s1,s1,0x20
 a30:	04bd                	addi	s1,s1,15
 a32:	8091                	srli	s1,s1,0x4
 a34:	0014899b          	addiw	s3,s1,1
 a38:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a3a:	00000517          	auipc	a0,0x0
 a3e:	5c653503          	ld	a0,1478(a0) # 1000 <freep>
 a42:	c515                	beqz	a0,a6e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a44:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a46:	4798                	lw	a4,8(a5)
 a48:	02977f63          	bgeu	a4,s1,a86 <malloc+0x70>
 a4c:	8a4e                	mv	s4,s3
 a4e:	0009871b          	sext.w	a4,s3
 a52:	6685                	lui	a3,0x1
 a54:	00d77363          	bgeu	a4,a3,a5a <malloc+0x44>
 a58:	6a05                	lui	s4,0x1
 a5a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a5e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a62:	00000917          	auipc	s2,0x0
 a66:	59e90913          	addi	s2,s2,1438 # 1000 <freep>
  if(p == (char*)-1)
 a6a:	5afd                	li	s5,-1
 a6c:	a895                	j	ae0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a6e:	00000797          	auipc	a5,0x0
 a72:	5b278793          	addi	a5,a5,1458 # 1020 <base>
 a76:	00000717          	auipc	a4,0x0
 a7a:	58f73523          	sd	a5,1418(a4) # 1000 <freep>
 a7e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a80:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a84:	b7e1                	j	a4c <malloc+0x36>
      if(p->s.size == nunits)
 a86:	02e48c63          	beq	s1,a4,abe <malloc+0xa8>
        p->s.size -= nunits;
 a8a:	4137073b          	subw	a4,a4,s3
 a8e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a90:	02071693          	slli	a3,a4,0x20
 a94:	01c6d713          	srli	a4,a3,0x1c
 a98:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a9a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a9e:	00000717          	auipc	a4,0x0
 aa2:	56a73123          	sd	a0,1378(a4) # 1000 <freep>
      return (void*)(p + 1);
 aa6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 aaa:	70e2                	ld	ra,56(sp)
 aac:	7442                	ld	s0,48(sp)
 aae:	74a2                	ld	s1,40(sp)
 ab0:	7902                	ld	s2,32(sp)
 ab2:	69e2                	ld	s3,24(sp)
 ab4:	6a42                	ld	s4,16(sp)
 ab6:	6aa2                	ld	s5,8(sp)
 ab8:	6b02                	ld	s6,0(sp)
 aba:	6121                	addi	sp,sp,64
 abc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 abe:	6398                	ld	a4,0(a5)
 ac0:	e118                	sd	a4,0(a0)
 ac2:	bff1                	j	a9e <malloc+0x88>
  hp->s.size = nu;
 ac4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ac8:	0541                	addi	a0,a0,16
 aca:	00000097          	auipc	ra,0x0
 ace:	eca080e7          	jalr	-310(ra) # 994 <free>
  return freep;
 ad2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ad6:	d971                	beqz	a0,aaa <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ada:	4798                	lw	a4,8(a5)
 adc:	fa9775e3          	bgeu	a4,s1,a86 <malloc+0x70>
    if(p == freep)
 ae0:	00093703          	ld	a4,0(s2)
 ae4:	853e                	mv	a0,a5
 ae6:	fef719e3          	bne	a4,a5,ad8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 aea:	8552                	mv	a0,s4
 aec:	00000097          	auipc	ra,0x0
 af0:	b80080e7          	jalr	-1152(ra) # 66c <sbrk>
  if(p == (char*)-1)
 af4:	fd5518e3          	bne	a0,s5,ac4 <malloc+0xae>
        return 0;
 af8:	4501                	li	a0,0
 afa:	bf45                	j	aaa <malloc+0x94>
