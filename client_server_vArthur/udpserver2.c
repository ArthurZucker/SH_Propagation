// Server side implementation of an UDP client-server model
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>

#define PORT 4242
#define MAXLINE 1024

// void melangerDeck()
// {
// 	int i;
// 	int index1, index2, tmp;

// 	for (i = 0; i < 1000; i++)
// 	{
// 		index1 = rand() % 13;
// 		index2 = rand() % 13;
// 		tmp = deck[index1];
// 		deck[index1] = deck[index2];
// 		deck[index2] = tmp;
// 	}
// }

void sendMessageToGodotClient(char *hostname, int portno, char *mess)
{
	/* socket: create the socket */
	int socketGodot;
	struct hostent *serverGodot;
	int serverlen;
	struct sockaddr_in serverGodotAddr;
	int n;
	char sendBuffer[MAXLINE];

	socketGodot = socket(AF_INET, SOCK_DGRAM, 0);
	if (socketGodot < 0)
	{
		printf("ERROR opening socketGodot\n");
		exit(1);
	}

	/* gethostbyname: get the server's DNS entry */
	serverGodot = gethostbyname(hostname);
	if (serverGodot == NULL)
	{
		fprintf(stderr, "ERROR, no such host as %s\n", hostname);
		exit(1);
	}

	/* build the server's Internet address */
	bzero((char *)&serverGodotAddr, sizeof(serverGodotAddr));
	serverGodotAddr.sin_family = AF_INET;
	bcopy((char *)serverGodot->h_addr,
		  (char *)&serverGodotAddr.sin_addr.s_addr, serverGodot->h_length);
	serverGodotAddr.sin_port = htons(portno);

	/*
0:13
1:0
2:0
3:0
4:1
5:0
6:0
7:0
8:4
9:0
10:0
11:0
12:6
13:0
14:0
15:0
*/
	bzero((char *)sendBuffer, MAXLINE);
	/*
	sendBuffer[0]=0x13;
	sendBuffer[4]=1;
	sendBuffer[8]=4;
	sendBuffer[12]=6;
	sprintf(sendBuffer+16,"%s\n",mess);

	printf("about to send this %d\n",16+strlen(sendBuffer+16));
	for (int i=0;i<16+strlen(sendBuffer+16+1);i++)
		printf("%d:%x\n",i,sendBuffer[i]);
*/

	sprintf(sendBuffer, "ABCDEFGHIJKLMNOPQRSTUVWXYZ");

	/* send the message to the server */
	serverlen = sizeof(serverGodotAddr);
	//n = sendto(socketGodot, sendBuffer, strlen(sendBuffer), 0,
	n = sendto(socketGodot, mess, strlen(mess), 0, (struct sockaddr *)&serverGodotAddr, serverlen);
	if (n < 0)
	{
		printf("ERROR in sendto\n");
		exit(1);
	}
	close(socketGodot);
}

int main()
{
	int sockfd;
	char buffer[MAXLINE];
	struct sockaddr_in servaddr, cliaddr;

	// Creating socket file descriptor
	if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
	{
		perror("socket creation failed");
		exit(EXIT_FAILURE);
	}

	memset(&servaddr, 0, sizeof(servaddr));
	memset(&cliaddr, 0, sizeof(cliaddr));

	// Filling server information
	servaddr.sin_family = AF_INET; // IPv4
	servaddr.sin_addr.s_addr = INADDR_ANY;
	servaddr.sin_port = htons(PORT);

	// Bind the socket with the server address
	if (bind(sockfd, (const struct sockaddr *)&servaddr, sizeof(servaddr)) < 0)
	{
		perror("bind failed");
		exit(EXIT_FAILURE);
	}

	int len, n;

	len = sizeof(cliaddr); //len is value/resuslt

	while (1)
	{
		n = recvfrom(sockfd, (char *)buffer, MAXLINE, MSG_WAITALL, (struct sockaddr *)&cliaddr, &len);
		//printf("n=%d\n",n);
		buffer[n] = '\0';
		printf("Client : %s\n", buffer);
		sendMessageToGodotClient("192.168.1.75", 4000, "Houla");
	}

	return 0;
}
