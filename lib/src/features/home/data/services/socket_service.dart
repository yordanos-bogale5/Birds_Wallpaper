import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initializeSocket(String token, WidgetRef ref) {
    log("Initializing socket with token: $token");
    socket = IO.io(
      'https://api.chatremedy.com',
      IO.OptionBuilder()
          .setTransports(['websocket']) // WebSocket transport only
          .disableAutoConnect() // Manual connection control
          .setExtraHeaders({
            'Authorization': 'Bearer $token', // Auth    orization header
            'Content-Type': 'application/json', // Header for JSON content type
          })
          .setQuery({
            'token': token, // Authentication token as query
            'EIO': '4', // Engine.IO version
          })
          .setPath('/socket.io/') // Ensure server path is correct
          .setTimeout(20000) // 20-second timeout
          .enableReconnection() // Reconnect automatically if disconnected
          .enableForceNewConnection() // Force new session each time
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      log('Connected to the server');
    });

    socket.on('onlineUsers', (users) {
      log('Online Users: $users');
    });

    socket.onConnectError((error) {
      log('Connect Error: $error');
    });

    socket.onError((error) {
      log('Socket Error: $error');
    });

    socket.onDisconnect((_) {
      log('Socket Disconnected');
    });
  }

  void manuallyConnect() {
    if (!socket.connected) {
      socket.connect();
    }
  }

  void disconnectSocket() {
    if (socket.connected) {
      socket.disconnect();
      log('Socket disconnected');
    }
  }

  void reconnectSocket(String token, WidgetRef ref) {
    if (!socket.connected) {
      initializeSocket(token, ref);
    }
  }
}

final socketServiceProvider = Provider((ref) {
  return SocketService();
});
