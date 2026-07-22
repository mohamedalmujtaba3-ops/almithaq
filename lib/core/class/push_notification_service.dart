import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class PushNotificationService {

  static Future<String> getAccessToken() async {

    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "almithaq-delivery",
      "private_key_id": "ee2b0a98c9a9fd4cac7876aeb7c078e40d1dfb94",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC2vzwXYUizqGKO\nZi5eVAmkt0w7TkpBS/LaVo6D+V4kmsvmcGMfbTDkAwNM5liKcg/hQWB+FSdyupyO\nERExV6usdNzmR03yDzxJiKvNmFbTXQyezVxnDU93VuA1RcKJdM4iOyVTlSqut/Kj\nl3V7i73qVFLNUgz1i/LiDKyAaRPD6zp12zGhOsNvoEHqgDMvPa1EuiAbX4EPlBtL\nHk3B5iSjw52WO95fuUtJQZqpYtGwEX6YyxSbhsR1rtorFgxIP+mjm1NxlA3xmo2k\nRM8NJVbyTRg5vHozEm4rHgFHI/DiyOleKRNaA8V1L0hXs5F6d7A2GK5KRz6r4Xv6\nYSbm0CKBAgMBAAECggEADKw+zc1ChijtarwVx5dS0uAeMnenqRcL+I2rlOXYXDf6\n31hYW1/OVeWKl0zbA4DM7p1CxIORiIB95lEzLMWMY2l4PyTfOCPL1bqbVWbU0JQB\nkcqid4gCBH/bDP6xMqiNuex5lm3/931Mn4Eblc13RlaCJnhj6yxBE+F2nfILe5jI\nkBBee10U/ykQj13mnbNRPkfWEMKJ3oMgxc4/u5r5mh40p+c+6QJkkXH/2qBtJ5oT\n4PWlox+q4tqnaNOkp9gsEVW2vXSWAHMMyEVE9M2nk7WFNYkqnnS0EKc4rvDpMiTE\noG45cZlkmD4Z22gjtRlH6QUvRoz5q1SHfzYu+Sm1UQKBgQDpG6VX4CghK5A8HaVL\n2y01mFJGgYQC6e6+Cn+y8gJKxpMuW7TCUWL8hyIQ/P6pDrg0l9jkcAz8KhQEEISq\nrrgCF/UyD/eZ0mFoHmHJHDSrQNyrGW8uBH/rm4Bm8GFs0/D7+eZ8I8dv4W6WoVVw\nPKzMokYNSXC1bMuXN5kRfEfTSQKBgQDIsYJ4G/vXuOYk11k4xiXY7v7urTbrzVnP\nt1TFCeWdG7X5d58vwbaG3u55Ac/iuYdlLiJi0oBbtNa2iFmBD12/U47OW3ePiblP\nPpmSZIxwwLZ9X7T52cBRc07y8u0JTO8QLXJSgDC/cHra42N9HTw1MePSGDbjWu3M\nGn1EyH4deQKBgQCxaR7/sFQaWqNdfVqOTvMrdRA5JN0psozHCgqCUHm6G0Ns5tK9\niV+Cvf4JW+MdG1zKej7SLQ1U5VlydnfhxzO4NC+iuFBDO8Byk5zsiJD1PVo0xhi9\ntyL8V87ziUM8plkkDN+D318sITAfaA40a5k/7MjP1/L1wSV5oxDWI/YuMQKBgFD9\n0flG0cutArO7dHZFAOEbEiagIJnotWXuRnd+FvvgQv/6FnPfaRnkvbh30r1cwhdD\nFv1qlgJsaHohbH15BgxAXFFK+GUk33Prf25kxYh7PSo7hX2PMt2r+yBwiNhIA/Iz\nZP+GXCXl7q6HNY84TSPqjlYrD3uRJoZH6mXnw32BAoGAFzqW1EEnpPGezvGn1VHO\n8zUVYyecDkWaRcKjuJUo/tDNim0CpePnk5JRkPrRDxx1PXD9OWt4DVqufpCUMh1c\nZ+QjtjQJIP4nB0JC2Nd355vIQ8s2U1R02JEoxzonMEV5iDSKZfBRanQnJ8Dii1wA\nhg4t3BB/4LfjVgIhPKPT4cc=\n-----END PRIVATE KEY-----\n",
      "client_email": "almithaq-notification-service@almithaq-delivery.iam.gserviceaccount.com",
      "client_id": "104440675196681830032",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/almithaq-notification-service%40almithaq-delivery.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes
    );

    // get the access token
    auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client
    );

    client.close();

    return credentials.accessToken.data;

  }


  sendNotificationTopic(String topic, String title, String body, String pageid, String pagename) async {

    final String serverAccessTokenKey = await getAccessToken();
    String endpointFirebaseCloudMessaging = "https://fcm.googleapis.com/v1/projects/almithaq-delivery/messages:send";
    final Map<String, dynamic> message = {
      "message": {
        "topic": topic,
        "notification": {
          "title": title,
          "body": body
        },
        "data": {
          "pageid": pageid,
          "pagename": pagename
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessTokenKey'
      },
      body: jsonEncode(message), 
    );

    if(response.statusCode == 200) {
      print("oooooooooooooo notification sent successfully");
    } else {
      print("oooooooooooooo notification failed : ${response.statusCode}");
    }

  }





}