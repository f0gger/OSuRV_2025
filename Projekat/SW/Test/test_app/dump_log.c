
#include <stdint.h> // uint16_t and family
#include <stdio.h> // printf and family
#include <unistd.h> // file ops
#include <fcntl.h> // open() flags
#include <string.h> // strerror()
#include <errno.h> // errno

#include "../../Driver/include/motor_ctrl.h"


int main(int argc, char** argv){

	int fd;
	fd = open(DEV_FN, O_RDWR);
	if(fd < 0){
		fprintf(stderr, "ERROR: \"%s\" not opened!\n", DEV_FN);
		fprintf(stderr, "fd = %d %s\n", fd, strerror(-fd));
		return 4;
	}	

	log_t log_entry[LOG_LEN];

	int r;
	
	int log_siz = LOG_LEN * sizeof(log_t);
	r = read(fd, (char*)log_entry, log_siz);
		
	//printf("log_t = %d\n", sizeof(log_t));

	printf("r = %d\nlog_siz = %d\n", r, log_siz);
	if(r != log_siz){
		fprintf(stderr, "ERROR: read went wrong!\n");
		return 4;
	}
	
	//TODO write log as textual TSV (Tab Separated Value) file

	FILE* f = fopen("log.tsv", "w");
 	if(f == NULL){
  		printf("ERROR: Cannot open log.tsv for writing!\n");
		return 4;
	}

	//int smece = 0;
	for (int i = 0; i < LOG_LEN; i++){
		fprintf(f, "0x%llx\t%d\t%d\n",
			log_entry[i].time, log_entry[i].idx, log_entry[i].on);
		}

	fclose(f);

	//TODO seek if needed.

	close(fd);

	printf("End.\n");

	return 0;
}
