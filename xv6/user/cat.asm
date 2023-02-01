
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:
#include "kernel/stat.h"
#include "user/user.h"

char buf[512];

void cat(int fd, int check) {
   0:	7159                	addi	sp,sp,-112
   2:	f486                	sd	ra,104(sp)
   4:	f0a2                	sd	s0,96(sp)
   6:	eca6                	sd	s1,88(sp)
   8:	e8ca                	sd	s2,80(sp)
   a:	e4ce                	sd	s3,72(sp)
   c:	e0d2                	sd	s4,64(sp)
   e:	fc56                	sd	s5,56(sp)
  10:	f85a                	sd	s6,48(sp)
  12:	f45e                	sd	s7,40(sp)
  14:	f062                	sd	s8,32(sp)
  16:	ec66                	sd	s9,24(sp)
  18:	e86a                	sd	s10,16(sp)
  1a:	e46e                	sd	s11,8(sp)
  1c:	1880                	addi	s0,sp,112
  1e:	8caa                	mv	s9,a0
  20:	8a2e                	mv	s4,a1

	int n;
	int num = 1;
	int counter = 1;
  22:	4b85                	li	s7,1
	int num = 1;
  24:	4905                	li	s2,1

	while((n = read(fd, buf, sizeof(buf))) > 0) {
  26:	00001d17          	auipc	s10,0x1
  2a:	fead0d13          	addi	s10,s10,-22 # 1010 <buf>
  2e:	00001b17          	auipc	s6,0x1
  32:	1e2b0b13          	addi	s6,s6,482 # 1210 <base>

		for(int x = 0; x < sizeof(buf); x++) {
			if(check == 1) {
  36:	4985                	li	s3,1
				if(num == 1) {
					printf("%d: ", counter);
  38:	00001c17          	auipc	s8,0x1
  3c:	918c0c13          	addi	s8,s8,-1768 # 950 <malloc+0xe6>
				if(buf[x] == '\n') {
					num = 1;
				}
			}
			
			printf("%c", buf[x]);
  40:	00001a97          	auipc	s5,0x1
  44:	918a8a93          	addi	s5,s5,-1768 # 958 <malloc+0xee>
		}
		printf("\n");
  48:	00001d97          	auipc	s11,0x1
  4c:	918d8d93          	addi	s11,s11,-1768 # 960 <malloc+0xf6>
	while((n = read(fd, buf, sizeof(buf))) > 0) {
  50:	a089                	j	92 <cat+0x92>
				if(buf[x] == '\n') {
  52:	0004c903          	lbu	s2,0(s1)
  56:	1959                	addi	s2,s2,-10
  58:	00193913          	seqz	s2,s2
			printf("%c", buf[x]);
  5c:	0004c583          	lbu	a1,0(s1)
  60:	8556                	mv	a0,s5
  62:	00000097          	auipc	ra,0x0
  66:	750080e7          	jalr	1872(ra) # 7b2 <printf>
		for(int x = 0; x < sizeof(buf); x++) {
  6a:	0485                	addi	s1,s1,1
  6c:	01648e63          	beq	s1,s6,88 <cat+0x88>
			if(check == 1) {
  70:	ff3a16e3          	bne	s4,s3,5c <cat+0x5c>
				if(num == 1) {
  74:	fd391fe3          	bne	s2,s3,52 <cat+0x52>
					printf("%d: ", counter);
  78:	85de                	mv	a1,s7
  7a:	8562                	mv	a0,s8
  7c:	00000097          	auipc	ra,0x0
  80:	736080e7          	jalr	1846(ra) # 7b2 <printf>
					counter++;
  84:	2b85                	addiw	s7,s7,1
  86:	b7f1                	j	52 <cat+0x52>
		printf("\n");
  88:	856e                	mv	a0,s11
  8a:	00000097          	auipc	ra,0x0
  8e:	728080e7          	jalr	1832(ra) # 7b2 <printf>
	while((n = read(fd, buf, sizeof(buf))) > 0) {
  92:	20000613          	li	a2,512
  96:	85ea                	mv	a1,s10
  98:	8566                	mv	a0,s9
  9a:	00000097          	auipc	ra,0x0
  9e:	3b6080e7          	jalr	950(ra) # 450 <read>
  a2:	00a05763          	blez	a0,b0 <cat+0xb0>
  a6:	00001497          	auipc	s1,0x1
  aa:	f6a48493          	addi	s1,s1,-150 # 1010 <buf>
  ae:	b7c9                	j	70 <cat+0x70>
	}
	
	if(n < 0){
  b0:	02054163          	bltz	a0,d2 <cat+0xd2>
		fprintf(2, "cat: read error\n");
		exit(1);
	}
}
  b4:	70a6                	ld	ra,104(sp)
  b6:	7406                	ld	s0,96(sp)
  b8:	64e6                	ld	s1,88(sp)
  ba:	6946                	ld	s2,80(sp)
  bc:	69a6                	ld	s3,72(sp)
  be:	6a06                	ld	s4,64(sp)
  c0:	7ae2                	ld	s5,56(sp)
  c2:	7b42                	ld	s6,48(sp)
  c4:	7ba2                	ld	s7,40(sp)
  c6:	7c02                	ld	s8,32(sp)
  c8:	6ce2                	ld	s9,24(sp)
  ca:	6d42                	ld	s10,16(sp)
  cc:	6da2                	ld	s11,8(sp)
  ce:	6165                	addi	sp,sp,112
  d0:	8082                	ret
		fprintf(2, "cat: read error\n");
  d2:	00001597          	auipc	a1,0x1
  d6:	89658593          	addi	a1,a1,-1898 # 968 <malloc+0xfe>
  da:	4509                	li	a0,2
  dc:	00000097          	auipc	ra,0x0
  e0:	6a8080e7          	jalr	1704(ra) # 784 <fprintf>
		exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	352080e7          	jalr	850(ra) # 438 <exit>

00000000000000ee <main>:

int main(int argc, char *argv[]) {
  ee:	7139                	addi	sp,sp,-64
  f0:	fc06                	sd	ra,56(sp)
  f2:	f822                	sd	s0,48(sp)
  f4:	f426                	sd	s1,40(sp)
  f6:	f04a                	sd	s2,32(sp)
  f8:	ec4e                	sd	s3,24(sp)
  fa:	e852                	sd	s4,16(sp)
  fc:	e456                	sd	s5,8(sp)
  fe:	e05a                	sd	s6,0(sp)
 100:	0080                	addi	s0,sp,64
	int fd, i;
	int check = 0;
	int start = 1;

	if(argc <= 1){
 102:	4785                	li	a5,1
 104:	04a7dd63          	bge	a5,a0,15e <main+0x70>
 108:	8a2a                	mv	s4,a0
		cat(0, check);
		exit(0);
	}

	if(argv[1][0] == '-' && argv[1][1] == 'n') {
 10a:	659c                	ld	a5,8(a1)
 10c:	0007c683          	lbu	a3,0(a5)
 110:	02d00713          	li	a4,45
 114:	4a81                	li	s5,0
 116:	4985                	li	s3,1
 118:	04e68e63          	beq	a3,a4,174 <main+0x86>
 11c:	00399793          	slli	a5,s3,0x3
 120:	00f58933          	add	s2,a1,a5
		check = 1;
		start = 2;
	}
	
	for(i = start; i < argc; i++){
		if((fd = open(argv[i], 0)) < 0){
 124:	4581                	li	a1,0
 126:	00093503          	ld	a0,0(s2)
 12a:	00000097          	auipc	ra,0x0
 12e:	34e080e7          	jalr	846(ra) # 478 <open>
 132:	84aa                	mv	s1,a0
 134:	04054f63          	bltz	a0,192 <main+0xa4>
			fprintf(2, "cat: cannot open %s\n", argv[i]);
			exit(1);
		}
		cat(fd, check);
 138:	85d6                	mv	a1,s5
 13a:	00000097          	auipc	ra,0x0
 13e:	ec6080e7          	jalr	-314(ra) # 0 <cat>
		close(fd);
 142:	8526                	mv	a0,s1
 144:	00000097          	auipc	ra,0x0
 148:	31c080e7          	jalr	796(ra) # 460 <close>
	for(i = start; i < argc; i++){
 14c:	2985                	addiw	s3,s3,1
 14e:	0921                	addi	s2,s2,8
 150:	fd49cae3          	blt	s3,s4,124 <main+0x36>
	}
	exit(0);
 154:	4501                	li	a0,0
 156:	00000097          	auipc	ra,0x0
 15a:	2e2080e7          	jalr	738(ra) # 438 <exit>
		cat(0, check);
 15e:	4581                	li	a1,0
 160:	4501                	li	a0,0
 162:	00000097          	auipc	ra,0x0
 166:	e9e080e7          	jalr	-354(ra) # 0 <cat>
		exit(0);
 16a:	4501                	li	a0,0
 16c:	00000097          	auipc	ra,0x0
 170:	2cc080e7          	jalr	716(ra) # 438 <exit>
	if(argv[1][0] == '-' && argv[1][1] == 'n') {
 174:	0017c703          	lbu	a4,1(a5)
 178:	06e00793          	li	a5,110
 17c:	00f70563          	beq	a4,a5,186 <main+0x98>
 180:	4a81                	li	s5,0
 182:	4985                	li	s3,1
 184:	bf61                	j	11c <main+0x2e>
	for(i = start; i < argc; i++){
 186:	4789                	li	a5,2
 188:	fca7d6e3          	bge	a5,a0,154 <main+0x66>
		check = 1;
 18c:	4a85                	li	s5,1
		start = 2;
 18e:	4989                	li	s3,2
 190:	b771                	j	11c <main+0x2e>
			fprintf(2, "cat: cannot open %s\n", argv[i]);
 192:	00093603          	ld	a2,0(s2)
 196:	00000597          	auipc	a1,0x0
 19a:	7ea58593          	addi	a1,a1,2026 # 980 <malloc+0x116>
 19e:	4509                	li	a0,2
 1a0:	00000097          	auipc	ra,0x0
 1a4:	5e4080e7          	jalr	1508(ra) # 784 <fprintf>
			exit(1);
 1a8:	4505                	li	a0,1
 1aa:	00000097          	auipc	ra,0x0
 1ae:	28e080e7          	jalr	654(ra) # 438 <exit>

00000000000001b2 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 1b2:	1141                	addi	sp,sp,-16
 1b4:	e406                	sd	ra,8(sp)
 1b6:	e022                	sd	s0,0(sp)
 1b8:	0800                	addi	s0,sp,16
  extern int main();
  main();
 1ba:	00000097          	auipc	ra,0x0
 1be:	f34080e7          	jalr	-204(ra) # ee <main>
  exit(0);
 1c2:	4501                	li	a0,0
 1c4:	00000097          	auipc	ra,0x0
 1c8:	274080e7          	jalr	628(ra) # 438 <exit>

00000000000001cc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1cc:	1141                	addi	sp,sp,-16
 1ce:	e422                	sd	s0,8(sp)
 1d0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1d2:	87aa                	mv	a5,a0
 1d4:	0585                	addi	a1,a1,1
 1d6:	0785                	addi	a5,a5,1
 1d8:	fff5c703          	lbu	a4,-1(a1)
 1dc:	fee78fa3          	sb	a4,-1(a5)
 1e0:	fb75                	bnez	a4,1d4 <strcpy+0x8>
    ;
  return os;
}
 1e2:	6422                	ld	s0,8(sp)
 1e4:	0141                	addi	sp,sp,16
 1e6:	8082                	ret

00000000000001e8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1e8:	1141                	addi	sp,sp,-16
 1ea:	e422                	sd	s0,8(sp)
 1ec:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1ee:	00054783          	lbu	a5,0(a0)
 1f2:	cb91                	beqz	a5,206 <strcmp+0x1e>
 1f4:	0005c703          	lbu	a4,0(a1)
 1f8:	00f71763          	bne	a4,a5,206 <strcmp+0x1e>
    p++, q++;
 1fc:	0505                	addi	a0,a0,1
 1fe:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 200:	00054783          	lbu	a5,0(a0)
 204:	fbe5                	bnez	a5,1f4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 206:	0005c503          	lbu	a0,0(a1)
}
 20a:	40a7853b          	subw	a0,a5,a0
 20e:	6422                	ld	s0,8(sp)
 210:	0141                	addi	sp,sp,16
 212:	8082                	ret

0000000000000214 <strlen>:

uint
strlen(const char *s)
{
 214:	1141                	addi	sp,sp,-16
 216:	e422                	sd	s0,8(sp)
 218:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 21a:	00054783          	lbu	a5,0(a0)
 21e:	cf91                	beqz	a5,23a <strlen+0x26>
 220:	0505                	addi	a0,a0,1
 222:	87aa                	mv	a5,a0
 224:	4685                	li	a3,1
 226:	9e89                	subw	a3,a3,a0
 228:	00f6853b          	addw	a0,a3,a5
 22c:	0785                	addi	a5,a5,1
 22e:	fff7c703          	lbu	a4,-1(a5)
 232:	fb7d                	bnez	a4,228 <strlen+0x14>
    ;
  return n;
}
 234:	6422                	ld	s0,8(sp)
 236:	0141                	addi	sp,sp,16
 238:	8082                	ret
  for(n = 0; s[n]; n++)
 23a:	4501                	li	a0,0
 23c:	bfe5                	j	234 <strlen+0x20>

000000000000023e <memset>:

void*
memset(void *dst, int c, uint n)
{
 23e:	1141                	addi	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 244:	ca19                	beqz	a2,25a <memset+0x1c>
 246:	87aa                	mv	a5,a0
 248:	1602                	slli	a2,a2,0x20
 24a:	9201                	srli	a2,a2,0x20
 24c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 250:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 254:	0785                	addi	a5,a5,1
 256:	fee79de3          	bne	a5,a4,250 <memset+0x12>
  }
  return dst;
}
 25a:	6422                	ld	s0,8(sp)
 25c:	0141                	addi	sp,sp,16
 25e:	8082                	ret

0000000000000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	1141                	addi	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	addi	s0,sp,16
  for(; *s; s++)
 266:	00054783          	lbu	a5,0(a0)
 26a:	cb99                	beqz	a5,280 <strchr+0x20>
    if(*s == c)
 26c:	00f58763          	beq	a1,a5,27a <strchr+0x1a>
  for(; *s; s++)
 270:	0505                	addi	a0,a0,1
 272:	00054783          	lbu	a5,0(a0)
 276:	fbfd                	bnez	a5,26c <strchr+0xc>
      return (char*)s;
  return 0;
 278:	4501                	li	a0,0
}
 27a:	6422                	ld	s0,8(sp)
 27c:	0141                	addi	sp,sp,16
 27e:	8082                	ret
  return 0;
 280:	4501                	li	a0,0
 282:	bfe5                	j	27a <strchr+0x1a>

0000000000000284 <gets>:

char*
gets(char *buf, int max)
{
 284:	711d                	addi	sp,sp,-96
 286:	ec86                	sd	ra,88(sp)
 288:	e8a2                	sd	s0,80(sp)
 28a:	e4a6                	sd	s1,72(sp)
 28c:	e0ca                	sd	s2,64(sp)
 28e:	fc4e                	sd	s3,56(sp)
 290:	f852                	sd	s4,48(sp)
 292:	f456                	sd	s5,40(sp)
 294:	f05a                	sd	s6,32(sp)
 296:	ec5e                	sd	s7,24(sp)
 298:	1080                	addi	s0,sp,96
 29a:	8baa                	mv	s7,a0
 29c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 29e:	892a                	mv	s2,a0
 2a0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2a2:	4aa9                	li	s5,10
 2a4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2a6:	89a6                	mv	s3,s1
 2a8:	2485                	addiw	s1,s1,1
 2aa:	0344d863          	bge	s1,s4,2da <gets+0x56>
    cc = read(0, &c, 1);
 2ae:	4605                	li	a2,1
 2b0:	faf40593          	addi	a1,s0,-81
 2b4:	4501                	li	a0,0
 2b6:	00000097          	auipc	ra,0x0
 2ba:	19a080e7          	jalr	410(ra) # 450 <read>
    if(cc < 1)
 2be:	00a05e63          	blez	a0,2da <gets+0x56>
    buf[i++] = c;
 2c2:	faf44783          	lbu	a5,-81(s0)
 2c6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2ca:	01578763          	beq	a5,s5,2d8 <gets+0x54>
 2ce:	0905                	addi	s2,s2,1
 2d0:	fd679be3          	bne	a5,s6,2a6 <gets+0x22>
  for(i=0; i+1 < max; ){
 2d4:	89a6                	mv	s3,s1
 2d6:	a011                	j	2da <gets+0x56>
 2d8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2da:	99de                	add	s3,s3,s7
 2dc:	00098023          	sb	zero,0(s3)
  return buf;
}
 2e0:	855e                	mv	a0,s7
 2e2:	60e6                	ld	ra,88(sp)
 2e4:	6446                	ld	s0,80(sp)
 2e6:	64a6                	ld	s1,72(sp)
 2e8:	6906                	ld	s2,64(sp)
 2ea:	79e2                	ld	s3,56(sp)
 2ec:	7a42                	ld	s4,48(sp)
 2ee:	7aa2                	ld	s5,40(sp)
 2f0:	7b02                	ld	s6,32(sp)
 2f2:	6be2                	ld	s7,24(sp)
 2f4:	6125                	addi	sp,sp,96
 2f6:	8082                	ret

00000000000002f8 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f8:	1101                	addi	sp,sp,-32
 2fa:	ec06                	sd	ra,24(sp)
 2fc:	e822                	sd	s0,16(sp)
 2fe:	e426                	sd	s1,8(sp)
 300:	e04a                	sd	s2,0(sp)
 302:	1000                	addi	s0,sp,32
 304:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 306:	4581                	li	a1,0
 308:	00000097          	auipc	ra,0x0
 30c:	170080e7          	jalr	368(ra) # 478 <open>
  if(fd < 0)
 310:	02054563          	bltz	a0,33a <stat+0x42>
 314:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 316:	85ca                	mv	a1,s2
 318:	00000097          	auipc	ra,0x0
 31c:	178080e7          	jalr	376(ra) # 490 <fstat>
 320:	892a                	mv	s2,a0
  close(fd);
 322:	8526                	mv	a0,s1
 324:	00000097          	auipc	ra,0x0
 328:	13c080e7          	jalr	316(ra) # 460 <close>
  return r;
}
 32c:	854a                	mv	a0,s2
 32e:	60e2                	ld	ra,24(sp)
 330:	6442                	ld	s0,16(sp)
 332:	64a2                	ld	s1,8(sp)
 334:	6902                	ld	s2,0(sp)
 336:	6105                	addi	sp,sp,32
 338:	8082                	ret
    return -1;
 33a:	597d                	li	s2,-1
 33c:	bfc5                	j	32c <stat+0x34>

000000000000033e <atoi>:

int
atoi(const char *s)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e422                	sd	s0,8(sp)
 342:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 344:	00054683          	lbu	a3,0(a0)
 348:	fd06879b          	addiw	a5,a3,-48
 34c:	0ff7f793          	zext.b	a5,a5
 350:	4625                	li	a2,9
 352:	02f66863          	bltu	a2,a5,382 <atoi+0x44>
 356:	872a                	mv	a4,a0
  n = 0;
 358:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 35a:	0705                	addi	a4,a4,1
 35c:	0025179b          	slliw	a5,a0,0x2
 360:	9fa9                	addw	a5,a5,a0
 362:	0017979b          	slliw	a5,a5,0x1
 366:	9fb5                	addw	a5,a5,a3
 368:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 36c:	00074683          	lbu	a3,0(a4)
 370:	fd06879b          	addiw	a5,a3,-48
 374:	0ff7f793          	zext.b	a5,a5
 378:	fef671e3          	bgeu	a2,a5,35a <atoi+0x1c>
  return n;
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret
  n = 0;
 382:	4501                	li	a0,0
 384:	bfe5                	j	37c <atoi+0x3e>

0000000000000386 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 386:	1141                	addi	sp,sp,-16
 388:	e422                	sd	s0,8(sp)
 38a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 38c:	02b57463          	bgeu	a0,a1,3b4 <memmove+0x2e>
    while(n-- > 0)
 390:	00c05f63          	blez	a2,3ae <memmove+0x28>
 394:	1602                	slli	a2,a2,0x20
 396:	9201                	srli	a2,a2,0x20
 398:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 39c:	872a                	mv	a4,a0
      *dst++ = *src++;
 39e:	0585                	addi	a1,a1,1
 3a0:	0705                	addi	a4,a4,1
 3a2:	fff5c683          	lbu	a3,-1(a1)
 3a6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3aa:	fee79ae3          	bne	a5,a4,39e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3ae:	6422                	ld	s0,8(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret
    dst += n;
 3b4:	00c50733          	add	a4,a0,a2
    src += n;
 3b8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3ba:	fec05ae3          	blez	a2,3ae <memmove+0x28>
 3be:	fff6079b          	addiw	a5,a2,-1
 3c2:	1782                	slli	a5,a5,0x20
 3c4:	9381                	srli	a5,a5,0x20
 3c6:	fff7c793          	not	a5,a5
 3ca:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3cc:	15fd                	addi	a1,a1,-1
 3ce:	177d                	addi	a4,a4,-1
 3d0:	0005c683          	lbu	a3,0(a1)
 3d4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3d8:	fee79ae3          	bne	a5,a4,3cc <memmove+0x46>
 3dc:	bfc9                	j	3ae <memmove+0x28>

00000000000003de <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3de:	1141                	addi	sp,sp,-16
 3e0:	e422                	sd	s0,8(sp)
 3e2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3e4:	ca05                	beqz	a2,414 <memcmp+0x36>
 3e6:	fff6069b          	addiw	a3,a2,-1
 3ea:	1682                	slli	a3,a3,0x20
 3ec:	9281                	srli	a3,a3,0x20
 3ee:	0685                	addi	a3,a3,1
 3f0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3f2:	00054783          	lbu	a5,0(a0)
 3f6:	0005c703          	lbu	a4,0(a1)
 3fa:	00e79863          	bne	a5,a4,40a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3fe:	0505                	addi	a0,a0,1
    p2++;
 400:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 402:	fed518e3          	bne	a0,a3,3f2 <memcmp+0x14>
  }
  return 0;
 406:	4501                	li	a0,0
 408:	a019                	j	40e <memcmp+0x30>
      return *p1 - *p2;
 40a:	40e7853b          	subw	a0,a5,a4
}
 40e:	6422                	ld	s0,8(sp)
 410:	0141                	addi	sp,sp,16
 412:	8082                	ret
  return 0;
 414:	4501                	li	a0,0
 416:	bfe5                	j	40e <memcmp+0x30>

0000000000000418 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 418:	1141                	addi	sp,sp,-16
 41a:	e406                	sd	ra,8(sp)
 41c:	e022                	sd	s0,0(sp)
 41e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 420:	00000097          	auipc	ra,0x0
 424:	f66080e7          	jalr	-154(ra) # 386 <memmove>
}
 428:	60a2                	ld	ra,8(sp)
 42a:	6402                	ld	s0,0(sp)
 42c:	0141                	addi	sp,sp,16
 42e:	8082                	ret

0000000000000430 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 430:	4885                	li	a7,1
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <exit>:
.global exit
exit:
 li a7, SYS_exit
 438:	4889                	li	a7,2
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <wait>:
.global wait
wait:
 li a7, SYS_wait
 440:	488d                	li	a7,3
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 448:	4891                	li	a7,4
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <read>:
.global read
read:
 li a7, SYS_read
 450:	4895                	li	a7,5
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <write>:
.global write
write:
 li a7, SYS_write
 458:	48c1                	li	a7,16
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <close>:
.global close
close:
 li a7, SYS_close
 460:	48d5                	li	a7,21
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <kill>:
.global kill
kill:
 li a7, SYS_kill
 468:	4899                	li	a7,6
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <exec>:
.global exec
exec:
 li a7, SYS_exec
 470:	489d                	li	a7,7
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <open>:
.global open
open:
 li a7, SYS_open
 478:	48bd                	li	a7,15
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 480:	48c5                	li	a7,17
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 488:	48c9                	li	a7,18
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 490:	48a1                	li	a7,8
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <link>:
.global link
link:
 li a7, SYS_link
 498:	48cd                	li	a7,19
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4a0:	48d1                	li	a7,20
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4a8:	48a5                	li	a7,9
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4b0:	48a9                	li	a7,10
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4b8:	48ad                	li	a7,11
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4c0:	48b1                	li	a7,12
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4c8:	48b5                	li	a7,13
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4d0:	48b9                	li	a7,14
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4d8:	1101                	addi	sp,sp,-32
 4da:	ec06                	sd	ra,24(sp)
 4dc:	e822                	sd	s0,16(sp)
 4de:	1000                	addi	s0,sp,32
 4e0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4e4:	4605                	li	a2,1
 4e6:	fef40593          	addi	a1,s0,-17
 4ea:	00000097          	auipc	ra,0x0
 4ee:	f6e080e7          	jalr	-146(ra) # 458 <write>
}
 4f2:	60e2                	ld	ra,24(sp)
 4f4:	6442                	ld	s0,16(sp)
 4f6:	6105                	addi	sp,sp,32
 4f8:	8082                	ret

00000000000004fa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4fa:	7139                	addi	sp,sp,-64
 4fc:	fc06                	sd	ra,56(sp)
 4fe:	f822                	sd	s0,48(sp)
 500:	f426                	sd	s1,40(sp)
 502:	f04a                	sd	s2,32(sp)
 504:	ec4e                	sd	s3,24(sp)
 506:	0080                	addi	s0,sp,64
 508:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 50a:	c299                	beqz	a3,510 <printint+0x16>
 50c:	0805c963          	bltz	a1,59e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 510:	2581                	sext.w	a1,a1
  neg = 0;
 512:	4881                	li	a7,0
 514:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 518:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 51a:	2601                	sext.w	a2,a2
 51c:	00000517          	auipc	a0,0x0
 520:	4dc50513          	addi	a0,a0,1244 # 9f8 <digits>
 524:	883a                	mv	a6,a4
 526:	2705                	addiw	a4,a4,1
 528:	02c5f7bb          	remuw	a5,a1,a2
 52c:	1782                	slli	a5,a5,0x20
 52e:	9381                	srli	a5,a5,0x20
 530:	97aa                	add	a5,a5,a0
 532:	0007c783          	lbu	a5,0(a5)
 536:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 53a:	0005879b          	sext.w	a5,a1
 53e:	02c5d5bb          	divuw	a1,a1,a2
 542:	0685                	addi	a3,a3,1
 544:	fec7f0e3          	bgeu	a5,a2,524 <printint+0x2a>
  if(neg)
 548:	00088c63          	beqz	a7,560 <printint+0x66>
    buf[i++] = '-';
 54c:	fd070793          	addi	a5,a4,-48
 550:	00878733          	add	a4,a5,s0
 554:	02d00793          	li	a5,45
 558:	fef70823          	sb	a5,-16(a4)
 55c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 560:	02e05863          	blez	a4,590 <printint+0x96>
 564:	fc040793          	addi	a5,s0,-64
 568:	00e78933          	add	s2,a5,a4
 56c:	fff78993          	addi	s3,a5,-1
 570:	99ba                	add	s3,s3,a4
 572:	377d                	addiw	a4,a4,-1
 574:	1702                	slli	a4,a4,0x20
 576:	9301                	srli	a4,a4,0x20
 578:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 57c:	fff94583          	lbu	a1,-1(s2)
 580:	8526                	mv	a0,s1
 582:	00000097          	auipc	ra,0x0
 586:	f56080e7          	jalr	-170(ra) # 4d8 <putc>
  while(--i >= 0)
 58a:	197d                	addi	s2,s2,-1
 58c:	ff3918e3          	bne	s2,s3,57c <printint+0x82>
}
 590:	70e2                	ld	ra,56(sp)
 592:	7442                	ld	s0,48(sp)
 594:	74a2                	ld	s1,40(sp)
 596:	7902                	ld	s2,32(sp)
 598:	69e2                	ld	s3,24(sp)
 59a:	6121                	addi	sp,sp,64
 59c:	8082                	ret
    x = -xx;
 59e:	40b005bb          	negw	a1,a1
    neg = 1;
 5a2:	4885                	li	a7,1
    x = -xx;
 5a4:	bf85                	j	514 <printint+0x1a>

00000000000005a6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5a6:	7119                	addi	sp,sp,-128
 5a8:	fc86                	sd	ra,120(sp)
 5aa:	f8a2                	sd	s0,112(sp)
 5ac:	f4a6                	sd	s1,104(sp)
 5ae:	f0ca                	sd	s2,96(sp)
 5b0:	ecce                	sd	s3,88(sp)
 5b2:	e8d2                	sd	s4,80(sp)
 5b4:	e4d6                	sd	s5,72(sp)
 5b6:	e0da                	sd	s6,64(sp)
 5b8:	fc5e                	sd	s7,56(sp)
 5ba:	f862                	sd	s8,48(sp)
 5bc:	f466                	sd	s9,40(sp)
 5be:	f06a                	sd	s10,32(sp)
 5c0:	ec6e                	sd	s11,24(sp)
 5c2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5c4:	0005c903          	lbu	s2,0(a1)
 5c8:	18090f63          	beqz	s2,766 <vprintf+0x1c0>
 5cc:	8aaa                	mv	s5,a0
 5ce:	8b32                	mv	s6,a2
 5d0:	00158493          	addi	s1,a1,1
  state = 0;
 5d4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5d6:	02500a13          	li	s4,37
 5da:	4c55                	li	s8,21
 5dc:	00000c97          	auipc	s9,0x0
 5e0:	3c4c8c93          	addi	s9,s9,964 # 9a0 <malloc+0x136>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5e4:	02800d93          	li	s11,40
  putc(fd, 'x');
 5e8:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ea:	00000b97          	auipc	s7,0x0
 5ee:	40eb8b93          	addi	s7,s7,1038 # 9f8 <digits>
 5f2:	a839                	j	610 <vprintf+0x6a>
        putc(fd, c);
 5f4:	85ca                	mv	a1,s2
 5f6:	8556                	mv	a0,s5
 5f8:	00000097          	auipc	ra,0x0
 5fc:	ee0080e7          	jalr	-288(ra) # 4d8 <putc>
 600:	a019                	j	606 <vprintf+0x60>
    } else if(state == '%'){
 602:	01498d63          	beq	s3,s4,61c <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 606:	0485                	addi	s1,s1,1
 608:	fff4c903          	lbu	s2,-1(s1)
 60c:	14090d63          	beqz	s2,766 <vprintf+0x1c0>
    if(state == 0){
 610:	fe0999e3          	bnez	s3,602 <vprintf+0x5c>
      if(c == '%'){
 614:	ff4910e3          	bne	s2,s4,5f4 <vprintf+0x4e>
        state = '%';
 618:	89d2                	mv	s3,s4
 61a:	b7f5                	j	606 <vprintf+0x60>
      if(c == 'd'){
 61c:	11490c63          	beq	s2,s4,734 <vprintf+0x18e>
 620:	f9d9079b          	addiw	a5,s2,-99
 624:	0ff7f793          	zext.b	a5,a5
 628:	10fc6e63          	bltu	s8,a5,744 <vprintf+0x19e>
 62c:	f9d9079b          	addiw	a5,s2,-99
 630:	0ff7f713          	zext.b	a4,a5
 634:	10ec6863          	bltu	s8,a4,744 <vprintf+0x19e>
 638:	00271793          	slli	a5,a4,0x2
 63c:	97e6                	add	a5,a5,s9
 63e:	439c                	lw	a5,0(a5)
 640:	97e6                	add	a5,a5,s9
 642:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 644:	008b0913          	addi	s2,s6,8
 648:	4685                	li	a3,1
 64a:	4629                	li	a2,10
 64c:	000b2583          	lw	a1,0(s6)
 650:	8556                	mv	a0,s5
 652:	00000097          	auipc	ra,0x0
 656:	ea8080e7          	jalr	-344(ra) # 4fa <printint>
 65a:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 65c:	4981                	li	s3,0
 65e:	b765                	j	606 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 660:	008b0913          	addi	s2,s6,8
 664:	4681                	li	a3,0
 666:	4629                	li	a2,10
 668:	000b2583          	lw	a1,0(s6)
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	e8c080e7          	jalr	-372(ra) # 4fa <printint>
 676:	8b4a                	mv	s6,s2
      state = 0;
 678:	4981                	li	s3,0
 67a:	b771                	j	606 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 67c:	008b0913          	addi	s2,s6,8
 680:	4681                	li	a3,0
 682:	866a                	mv	a2,s10
 684:	000b2583          	lw	a1,0(s6)
 688:	8556                	mv	a0,s5
 68a:	00000097          	auipc	ra,0x0
 68e:	e70080e7          	jalr	-400(ra) # 4fa <printint>
 692:	8b4a                	mv	s6,s2
      state = 0;
 694:	4981                	li	s3,0
 696:	bf85                	j	606 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 698:	008b0793          	addi	a5,s6,8
 69c:	f8f43423          	sd	a5,-120(s0)
 6a0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6a4:	03000593          	li	a1,48
 6a8:	8556                	mv	a0,s5
 6aa:	00000097          	auipc	ra,0x0
 6ae:	e2e080e7          	jalr	-466(ra) # 4d8 <putc>
  putc(fd, 'x');
 6b2:	07800593          	li	a1,120
 6b6:	8556                	mv	a0,s5
 6b8:	00000097          	auipc	ra,0x0
 6bc:	e20080e7          	jalr	-480(ra) # 4d8 <putc>
 6c0:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6c2:	03c9d793          	srli	a5,s3,0x3c
 6c6:	97de                	add	a5,a5,s7
 6c8:	0007c583          	lbu	a1,0(a5)
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	e0a080e7          	jalr	-502(ra) # 4d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6d6:	0992                	slli	s3,s3,0x4
 6d8:	397d                	addiw	s2,s2,-1
 6da:	fe0914e3          	bnez	s2,6c2 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 6de:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	b70d                	j	606 <vprintf+0x60>
        s = va_arg(ap, char*);
 6e6:	008b0913          	addi	s2,s6,8
 6ea:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 6ee:	02098163          	beqz	s3,710 <vprintf+0x16a>
        while(*s != 0){
 6f2:	0009c583          	lbu	a1,0(s3)
 6f6:	c5ad                	beqz	a1,760 <vprintf+0x1ba>
          putc(fd, *s);
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	dde080e7          	jalr	-546(ra) # 4d8 <putc>
          s++;
 702:	0985                	addi	s3,s3,1
        while(*s != 0){
 704:	0009c583          	lbu	a1,0(s3)
 708:	f9e5                	bnez	a1,6f8 <vprintf+0x152>
        s = va_arg(ap, char*);
 70a:	8b4a                	mv	s6,s2
      state = 0;
 70c:	4981                	li	s3,0
 70e:	bde5                	j	606 <vprintf+0x60>
          s = "(null)";
 710:	00000997          	auipc	s3,0x0
 714:	28898993          	addi	s3,s3,648 # 998 <malloc+0x12e>
        while(*s != 0){
 718:	85ee                	mv	a1,s11
 71a:	bff9                	j	6f8 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 71c:	008b0913          	addi	s2,s6,8
 720:	000b4583          	lbu	a1,0(s6)
 724:	8556                	mv	a0,s5
 726:	00000097          	auipc	ra,0x0
 72a:	db2080e7          	jalr	-590(ra) # 4d8 <putc>
 72e:	8b4a                	mv	s6,s2
      state = 0;
 730:	4981                	li	s3,0
 732:	bdd1                	j	606 <vprintf+0x60>
        putc(fd, c);
 734:	85d2                	mv	a1,s4
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	da0080e7          	jalr	-608(ra) # 4d8 <putc>
      state = 0;
 740:	4981                	li	s3,0
 742:	b5d1                	j	606 <vprintf+0x60>
        putc(fd, '%');
 744:	85d2                	mv	a1,s4
 746:	8556                	mv	a0,s5
 748:	00000097          	auipc	ra,0x0
 74c:	d90080e7          	jalr	-624(ra) # 4d8 <putc>
        putc(fd, c);
 750:	85ca                	mv	a1,s2
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	d84080e7          	jalr	-636(ra) # 4d8 <putc>
      state = 0;
 75c:	4981                	li	s3,0
 75e:	b565                	j	606 <vprintf+0x60>
        s = va_arg(ap, char*);
 760:	8b4a                	mv	s6,s2
      state = 0;
 762:	4981                	li	s3,0
 764:	b54d                	j	606 <vprintf+0x60>
    }
  }
}
 766:	70e6                	ld	ra,120(sp)
 768:	7446                	ld	s0,112(sp)
 76a:	74a6                	ld	s1,104(sp)
 76c:	7906                	ld	s2,96(sp)
 76e:	69e6                	ld	s3,88(sp)
 770:	6a46                	ld	s4,80(sp)
 772:	6aa6                	ld	s5,72(sp)
 774:	6b06                	ld	s6,64(sp)
 776:	7be2                	ld	s7,56(sp)
 778:	7c42                	ld	s8,48(sp)
 77a:	7ca2                	ld	s9,40(sp)
 77c:	7d02                	ld	s10,32(sp)
 77e:	6de2                	ld	s11,24(sp)
 780:	6109                	addi	sp,sp,128
 782:	8082                	ret

0000000000000784 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 784:	715d                	addi	sp,sp,-80
 786:	ec06                	sd	ra,24(sp)
 788:	e822                	sd	s0,16(sp)
 78a:	1000                	addi	s0,sp,32
 78c:	e010                	sd	a2,0(s0)
 78e:	e414                	sd	a3,8(s0)
 790:	e818                	sd	a4,16(s0)
 792:	ec1c                	sd	a5,24(s0)
 794:	03043023          	sd	a6,32(s0)
 798:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 79c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7a0:	8622                	mv	a2,s0
 7a2:	00000097          	auipc	ra,0x0
 7a6:	e04080e7          	jalr	-508(ra) # 5a6 <vprintf>
}
 7aa:	60e2                	ld	ra,24(sp)
 7ac:	6442                	ld	s0,16(sp)
 7ae:	6161                	addi	sp,sp,80
 7b0:	8082                	ret

00000000000007b2 <printf>:

void
printf(const char *fmt, ...)
{
 7b2:	711d                	addi	sp,sp,-96
 7b4:	ec06                	sd	ra,24(sp)
 7b6:	e822                	sd	s0,16(sp)
 7b8:	1000                	addi	s0,sp,32
 7ba:	e40c                	sd	a1,8(s0)
 7bc:	e810                	sd	a2,16(s0)
 7be:	ec14                	sd	a3,24(s0)
 7c0:	f018                	sd	a4,32(s0)
 7c2:	f41c                	sd	a5,40(s0)
 7c4:	03043823          	sd	a6,48(s0)
 7c8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7cc:	00840613          	addi	a2,s0,8
 7d0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7d4:	85aa                	mv	a1,a0
 7d6:	4505                	li	a0,1
 7d8:	00000097          	auipc	ra,0x0
 7dc:	dce080e7          	jalr	-562(ra) # 5a6 <vprintf>
}
 7e0:	60e2                	ld	ra,24(sp)
 7e2:	6442                	ld	s0,16(sp)
 7e4:	6125                	addi	sp,sp,96
 7e6:	8082                	ret

00000000000007e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e8:	1141                	addi	sp,sp,-16
 7ea:	e422                	sd	s0,8(sp)
 7ec:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ee:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f2:	00001797          	auipc	a5,0x1
 7f6:	80e7b783          	ld	a5,-2034(a5) # 1000 <freep>
 7fa:	a02d                	j	824 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7fc:	4618                	lw	a4,8(a2)
 7fe:	9f2d                	addw	a4,a4,a1
 800:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 804:	6398                	ld	a4,0(a5)
 806:	6310                	ld	a2,0(a4)
 808:	a83d                	j	846 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 80a:	ff852703          	lw	a4,-8(a0)
 80e:	9f31                	addw	a4,a4,a2
 810:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 812:	ff053683          	ld	a3,-16(a0)
 816:	a091                	j	85a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 818:	6398                	ld	a4,0(a5)
 81a:	00e7e463          	bltu	a5,a4,822 <free+0x3a>
 81e:	00e6ea63          	bltu	a3,a4,832 <free+0x4a>
{
 822:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 824:	fed7fae3          	bgeu	a5,a3,818 <free+0x30>
 828:	6398                	ld	a4,0(a5)
 82a:	00e6e463          	bltu	a3,a4,832 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82e:	fee7eae3          	bltu	a5,a4,822 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 832:	ff852583          	lw	a1,-8(a0)
 836:	6390                	ld	a2,0(a5)
 838:	02059813          	slli	a6,a1,0x20
 83c:	01c85713          	srli	a4,a6,0x1c
 840:	9736                	add	a4,a4,a3
 842:	fae60de3          	beq	a2,a4,7fc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 846:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 84a:	4790                	lw	a2,8(a5)
 84c:	02061593          	slli	a1,a2,0x20
 850:	01c5d713          	srli	a4,a1,0x1c
 854:	973e                	add	a4,a4,a5
 856:	fae68ae3          	beq	a3,a4,80a <free+0x22>
    p->s.ptr = bp->s.ptr;
 85a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 85c:	00000717          	auipc	a4,0x0
 860:	7af73223          	sd	a5,1956(a4) # 1000 <freep>
}
 864:	6422                	ld	s0,8(sp)
 866:	0141                	addi	sp,sp,16
 868:	8082                	ret

000000000000086a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 86a:	7139                	addi	sp,sp,-64
 86c:	fc06                	sd	ra,56(sp)
 86e:	f822                	sd	s0,48(sp)
 870:	f426                	sd	s1,40(sp)
 872:	f04a                	sd	s2,32(sp)
 874:	ec4e                	sd	s3,24(sp)
 876:	e852                	sd	s4,16(sp)
 878:	e456                	sd	s5,8(sp)
 87a:	e05a                	sd	s6,0(sp)
 87c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 87e:	02051493          	slli	s1,a0,0x20
 882:	9081                	srli	s1,s1,0x20
 884:	04bd                	addi	s1,s1,15
 886:	8091                	srli	s1,s1,0x4
 888:	0014899b          	addiw	s3,s1,1
 88c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 88e:	00000517          	auipc	a0,0x0
 892:	77253503          	ld	a0,1906(a0) # 1000 <freep>
 896:	c515                	beqz	a0,8c2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 898:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 89a:	4798                	lw	a4,8(a5)
 89c:	02977f63          	bgeu	a4,s1,8da <malloc+0x70>
 8a0:	8a4e                	mv	s4,s3
 8a2:	0009871b          	sext.w	a4,s3
 8a6:	6685                	lui	a3,0x1
 8a8:	00d77363          	bgeu	a4,a3,8ae <malloc+0x44>
 8ac:	6a05                	lui	s4,0x1
 8ae:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8b2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8b6:	00000917          	auipc	s2,0x0
 8ba:	74a90913          	addi	s2,s2,1866 # 1000 <freep>
  if(p == (char*)-1)
 8be:	5afd                	li	s5,-1
 8c0:	a895                	j	934 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 8c2:	00001797          	auipc	a5,0x1
 8c6:	94e78793          	addi	a5,a5,-1714 # 1210 <base>
 8ca:	00000717          	auipc	a4,0x0
 8ce:	72f73b23          	sd	a5,1846(a4) # 1000 <freep>
 8d2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8d4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8d8:	b7e1                	j	8a0 <malloc+0x36>
      if(p->s.size == nunits)
 8da:	02e48c63          	beq	s1,a4,912 <malloc+0xa8>
        p->s.size -= nunits;
 8de:	4137073b          	subw	a4,a4,s3
 8e2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8e4:	02071693          	slli	a3,a4,0x20
 8e8:	01c6d713          	srli	a4,a3,0x1c
 8ec:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8ee:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8f2:	00000717          	auipc	a4,0x0
 8f6:	70a73723          	sd	a0,1806(a4) # 1000 <freep>
      return (void*)(p + 1);
 8fa:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8fe:	70e2                	ld	ra,56(sp)
 900:	7442                	ld	s0,48(sp)
 902:	74a2                	ld	s1,40(sp)
 904:	7902                	ld	s2,32(sp)
 906:	69e2                	ld	s3,24(sp)
 908:	6a42                	ld	s4,16(sp)
 90a:	6aa2                	ld	s5,8(sp)
 90c:	6b02                	ld	s6,0(sp)
 90e:	6121                	addi	sp,sp,64
 910:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 912:	6398                	ld	a4,0(a5)
 914:	e118                	sd	a4,0(a0)
 916:	bff1                	j	8f2 <malloc+0x88>
  hp->s.size = nu;
 918:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 91c:	0541                	addi	a0,a0,16
 91e:	00000097          	auipc	ra,0x0
 922:	eca080e7          	jalr	-310(ra) # 7e8 <free>
  return freep;
 926:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 92a:	d971                	beqz	a0,8fe <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 92e:	4798                	lw	a4,8(a5)
 930:	fa9775e3          	bgeu	a4,s1,8da <malloc+0x70>
    if(p == freep)
 934:	00093703          	ld	a4,0(s2)
 938:	853e                	mv	a0,a5
 93a:	fef719e3          	bne	a4,a5,92c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 93e:	8552                	mv	a0,s4
 940:	00000097          	auipc	ra,0x0
 944:	b80080e7          	jalr	-1152(ra) # 4c0 <sbrk>
  if(p == (char*)-1)
 948:	fd5518e3          	bne	a0,s5,918 <malloc+0xae>
        return 0;
 94c:	4501                	li	a0,0
 94e:	bf45                	j	8fe <malloc+0x94>
