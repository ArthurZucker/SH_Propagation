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

#define PORT	 4242
#define MAXLINE 1024

// necessaire car 4 clients Nord-Sud-Est-Ouest
struct _client
{
	char ipAddress[40];
	int port;
	char name[40];
	int etat;
}udpClients[4];

int nbClients;
int deck[32]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32};
int deckBadCard[32]={0,0,-1,-1,-1,0,0,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,-1,-1,0};//{3,4,5,8,9,10,11,15,16,17,18,19,20,30,31}
// 3 cartes par personne
int tableCartes[4][3];
int fsmServer;
int joueurCourant;
int tableScore[4];

void melangerDeck()
{
	int i;
	int index1,index2,tmp;

	for (i=0;i<1000;i++)
	{
		index1=rand()%32;
		index2=rand()%32;

		tmp=deck[index1];
		deck[index1]=deck[index2];
		deck[index2]=tmp;
	}
}

// Pour attribuer les cartes
// void createTable()
// {
// 	// Le joueur 0 possede les cartes d'indice 0,1,2
// 	// Le joueur 1 possede les cartes d'indice 3,4,5
// 	// Le joueur 2 possede les cartes d'indice 6,7,8
// 	// Le joueur 3 possede les cartes d'indice 9,10,11
// 	// Le coupable est la carte d'indice 12
// 	int i,j,c;
//
// 	for (i=0;i<4;i++)
// 		for (j=0;j<3;j++)
// 			tableCartes[i][j]=0;
//
// 	for (i=0;i<4;i++)
// 	{
// 		for (j=0;j<3;j++)
// 		{
// 			c=deck[i*3+j];
// 			switch (c)
// 			{
// 				case 0:
// 					tableCartes[i][7]++;
// 					tableCartes[i][2]++;
// 					break;
// 				case 1: // Irene Adler
// 					tableCartes[i][7]++;
// 					tableCartes[i][1]++;
// 					tableCartes[i][5]++;
// 					break;
// 				case 2:
// 					tableCartes[i][3]++;
// 					tableCartes[i][6]++;
// 					tableCartes[i][4]++;
// 					break;
// 				case 3:
// 					tableCartes[i][3]++;
// 					tableCartes[i][2]++;
// 					tableCartes[i][4]++;
// 					break;
// 			}
// 		}
// 	}
// }

void printClients()
{
	int i;

	for (i=0;i<nbClients;i++)
		printf("%d: %s %5.5d %s\n",i,udpClients[i].ipAddress,udpClients[i].port,udpClients[i].name);
}

int findClientByName(char *name)
{
	int i;

	for (i=0;i<nbClients;i++)
	if (strcmp(udpClients[i].name,name)==0)
	return i;
	return -1;
}

void sendMessageToGodotClient(char *hostname,int portno, char *mess)
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
		fprintf(stderr,"ERROR, no such host as %s\n", hostname);
		exit(1);
	}

	/* build the server's Internet address */
	bzero((char *) &serverGodotAddr, sizeof(serverGodotAddr));
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
	bzero((char *) sendBuffer, MAXLINE);
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

	sprintf(sendBuffer,"%s\n",mess);

	/* send the message to the server */
	serverlen = sizeof(serverGodotAddr);
	//n = sendto(socketGodot, sendBuffer, strlen(sendBuffer), 0,
	n = sendto(socketGodot, mess, strlen(mess), 0,
	(struct sockaddr *)&serverGodotAddr, serverlen);
	if (n < 0)
	{
		printf("ERROR in sendto\n");
		exit(1);
	}
	close(socketGodot);
}

void broadcastMessage(char *mess)
{
	int i;

	for (i=0;i<nbClients;i++)
		sendMessageToGodotClient(udpClients[i].ipAddress,udpClients[i].port,mess);
}

int main()
{
	int sockfd;
	char buffer[MAXLINE];
	struct sockaddr_in servaddr, cliaddr;

	char reply[256];
	int id;
	char com;
	char clientIpAddress[256], clientName[256];
	int clientPort;

	// Creating socket file descriptor
	if ( (sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0 ) {
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
	if ( bind(sockfd, (const struct sockaddr *)&servaddr,
			sizeof(servaddr)) < 0 )
	{
		perror("bind failed");
		exit(EXIT_FAILURE);
	}

	int len, n;

	len = sizeof(cliaddr); //len is value/resuslt

	for (int i=0;i<4;i++)
	{
					strcpy(udpClients[i].ipAddress,"localhost");
					udpClients[i].port=-1;
					strcpy(udpClients[i].name,"-");
					tableScore[i]=0;
	}

	while (1)
	{
		n = recvfrom(sockfd, (char *)buffer, MAXLINE,
				MSG_WAITALL, ( struct sockaddr *) &cliaddr,
				&len);
		//printf("n=%d\n",n);
		buffer[n] = '\0';

		if (fsmServer==0)
		{
			switch (buffer[0])
			{
				case 'C':
					sscanf(buffer,"%c %s %d %s", &com, clientIpAddress, &clientPort, clientName);
					printf("COM=%c ipAddress=%s port=%d name=%s\n",com, clientIpAddress, clientPort, clientName);

					// fsmServer==0 alors j'attends les connexions de tous les joueurs
					strcpy(udpClients[nbClients].ipAddress,clientIpAddress);
					udpClients[nbClients].port=clientPort;
					strcpy(udpClients[nbClients].name,clientName);
					udpClients[nbClients].etat=1;
					nbClients++;

					printClients();

					// rechercher l'id du joueur qui vient de se connecter
					id=findClientByName(clientName);
					printf("id=%d\n",id);

					// lui envoyer un message personnel pour lui communiquer son id
					sprintf(reply,"I %d",id);
					sendMessageToGodotClient(udpClients[id].ipAddress,
						udpClients[id].port,
						reply);

					// Envoyer un message broadcast pour communiquer a tout le monde la liste des joueurs actuellement connectes
					sprintf(reply,"L %s %s %s %s", udpClients[0].name, udpClients[1].name, udpClients[2].name, udpClients[3].name);
					broadcastMessage(reply);

					// Si le nombre de joueurs atteint 4, alors on peut lancer le jeu
					if (nbClients==4)
					{
						// On envoie les cartes aux joueurs, ainsi que la ligne qui leur corresponds dans tableCartes
						for(int i=0;i<4;i++){
							sprintf(reply,"D %d %d %d",deck[3*i],deck[3*i+1],deck[3*i+2]);
							sendMessageToGodotClient(udpClients[i].ipAddress,udpClients[i].port,reply);
							sprintf(reply,"V %d %d %d",tableCartes[i][0],tableCartes[i][1],tableCartes[i][2]);
							sendMessageToGodotClient(udpClients[i].ipAddress,udpClients[i].port,reply);
						}
						// On envoie le premier joueur qui doit jouer
						sprintf(reply,"M %d",joueurCourant);
						broadcastMessage(reply);

						fsmServer=1;
					}
					break;
				}
			}
			else if (fsmServer==1)
			{
				int num_card;
				int id_joueur;
				// mettre en place le jeu en fonction des messages
				switch (buffer[0]){
					// revealCard
					case 'R':
						sscanf(buffer,"R %d %d",&id_joueur,&num_card);
						// faire les bails (attribuer score ou pas si carte utile)
						tableScore[id_joueur]+=deckBadCard[num_card-1];
						// on partage la carte revele
						sprintf(reply,"R %d",num_card);
						broadcastMessage(reply);
						//on lui donne une carte
						//carte=head->suivant.num_card
						//sprintf(reply,"D %d",head->suivant.num_card);
					break;
					// hideCard
					case 'H':
						sscanf(buffer,"H %d %d",&id_joueur,&num_card);
						sprintf(reply,"H %d",num_card);
						broadcastMessage(reply);
						//on lui donne une carte
						//sprintf(reply,"D %d",);
					break;
				}
			}
			// else if( head->suivant==NULL)
	}
	close(sockfd);
	return 0;
}
