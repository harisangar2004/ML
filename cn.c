#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <netdb.h>
#include <arpa/inet.h>

void connect_to_hosts_iterative(char *hosts[], int num_hosts, int port) {
    for (int i = 0; i < num_hosts; i++) {
        int sockfd;
        struct sockaddr_in server_addr;
        struct hostent *server;

        /* Create socket */
        sockfd = socket(AF_INET, SOCK_STREAM, 0);
        if (sockfd < 0) {
            perror("Error opening socket");
            continue;
        }

        /* Get server by hostname */
        server = gethostbyname(hosts[i]);
        if (server == NULL) {
            fprintf(stderr, "No such host: %s\n", hosts[i]);
            close(sockfd);
            continue;
        }

        /* Setup server address structure */
        memset(&server_addr, 0, sizeof(server_addr));
        server_addr.sin_family = AF_INET;
        memcpy(&server_addr.sin_addr.s_addr, server->h_addr, server->h_length);
        server_addr.sin_port = htons(port);

        /* Connect to server */
        if (connect(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
            perror("Connection failed");
            close(sockfd);
            continue;
        }

        printf("Connected to %s on port %d\n", hosts[i], port);
        close(sockfd);
    }
}

int main() {
    char *hosts[] = {"example.com", "google.com", "openai.com"};
    int num_hosts = sizeof(hosts) / sizeof(hosts[0]);
    int port = 80;  // HTTP port

    connect_to_hosts_iterative(hosts, num_hosts, port);

    return 0;
}
recu code
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <netdb.h>
#include <arpa/inet.h>

void connect_to_host_recursive(char *hosts[], int index, int num_hosts, int port) {
    if (index >= num_hosts) {
        return;
    }

    int sockfd;
    struct sockaddr_in server_addr;
    struct hostent *server;

    /* Create socket */
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        perror("Error opening socket");
        connect_to_host_recursive(hosts, index + 1, num_hosts, port);
        return;
    }

    /* Get server by hostname */
    server = gethostbyname(hosts[index]);
    if (server == NULL) {
        fprintf(stderr, "No such host: %s\n", hosts[index]);
        close(sockfd);
        connect_to_host_recursive(hosts, index + 1, num_hosts, port);
        return;
    }

    /* Setup server address structure */
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    memcpy(&server_addr.sin_addr.s_addr, server->h_addr, server->h_length);
    server_addr.sin_port = htons(port);

    /* Connect to server */
    if (connect(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
        perror("Connection failed");
        close(sockfd);
        connect_to_host_recursive(hosts, index + 1, num_hosts, port);
        return;
    }

    printf("Connected to %s on port %d\n", hosts[index], port);
    close(sockfd);

    /* Recursive call to next host */
    connect_to_host_recursive(hosts, index + 1, num_hosts, port);
}

int main() {
    char *hosts[] = {"example.com", "google.com", "openai.com"};
    int num_hosts = sizeof(hosts) / sizeof(hosts[0]);
    int port = 80;  // HTTP port

    connect_to_host_recursive(hosts, 0, num_hosts, port);

    return 0;
}
client
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define PORT 8080
#define SERVER_IP "127.0.0.1" // Localhost, replace with actual server IP

void connect_to_server(int times) {
    if (times <= 0) return;

    int sock = 0;
    struct sockaddr_in serv_addr;
    char *message = "Hello from client";
    char buffer[1024] = {0};

    // Creating socket
    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        printf("\n Socket creation error \n");
        return;
    }

    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(PORT);

    // Convert IPv4 and IPv6 addresses from text to binary form
    if (inet_pton(AF_INET, SERVER_IP, &serv_addr.sin_addr) <= 0) {
        printf("\nInvalid address/ Address not supported \n");
        return;
    }

    // Connect to the server
    if (connect(sock, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
        printf("\nConnection Failed \n");
        return;
    }

    send(sock, message, strlen(message), 0);
    printf("Message sent to server. Attempt: %d\n", times);
    read(sock, buffer, 1024);
    printf("Server reply: %s\n", buffer);

    // Close the socket
    close(sock);

    // Recursive call
    connect_to_server(times - 1);
}

int main() {
    int connections = 5; // Number of connections you want to make
    connect_to_server(connections);
    return 0;
}

c;ient iterative
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define PORT 8080
#define SERVER_IP "127.0.0.1" // Localhost, replace with actual server IP

int main() {
    int connections = 5; // Number of connections you want to make

    for (int i = 0; i < connections; i++) {
        int sock = 0;
        struct sockaddr_in serv_addr;
        char *message = "Hello from client";
        char buffer[1024] = {0};

        // Creating socket
        if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
            printf("\n Socket creation error \n");
            return -1;
        }

        serv_addr.sin_family = AF_INET;
        serv_addr.sin_port = htons(PORT);

        // Convert IPv4 and IPv6 addresses from text to binary form
        if (inet_pton(AF_INET, SERVER_IP, &serv_addr.sin_addr) <= 0) {
            printf("\nInvalid address/ Address not supported \n");
            return -1;
        }

        // Connect to the server
        if (connect(sock, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
            printf("\nConnection Failed \n");
            return -1;
        }

        send(sock, message, strlen(message), 0);
        printf("Message sent to server. Attempt: %d\n", i + 1);
        read(sock, buffer, 1024);
        printf("Server reply: %s\n", buffer);

        // Close the socket
        close(sock);
    }

    return 0;
}
