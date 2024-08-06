import 'package:chatapp/constants.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/providers/authentication_provider.dart';
import 'package:chatapp/utilities/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({
    super.key,
    required this.viewType,
  });

  final FriendViewType viewType;

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthenticationProvider>().userModel!.uid;

    final future = viewType == FriendViewType.friends
        ? context.read<AuthenticationProvider>().getFriendsList(uid)
        : viewType == FriendViewType.friendRequests
            ? context.read<AuthenticationProvider>().getFriendRequestsList(uid)
            : context.read<AuthenticationProvider>().getFriendsList(uid);

    return FutureBuilder<List<UserModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No friends yet"),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              return ListTile(
                contentPadding: const EdgeInsets.only(left: -10),
                leading: userImageWidget(
                    imageUrl: data.image,
                    radius: 40,
                    onTap: () {
                      // Navigate to this friends profile with uid as argument
                      Navigator.pushNamed(context, Constants.profileScreen,
                          arguments: data.uid);
                    }),
                title: Text(data.name),
                subtitle: Text(
                  data.aboutMe,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: ElevatedButton(
                  onPressed: () async {
                    if (viewType == FriendViewType.friends) {
                      // Navigate to chat screen witht he following arguments
                      // 1. friend uid 2. friend name 3. friend image 4. groupId with an empty string
                      Navigator.pushNamed(context, Constants.chatScreen,
                          arguments: {
                            Constants.contactUID: data.uid,
                            Constants.contactName: data.name,
                            Constants.contactImage: data.image,
                            Constants.groupId: '',
                          });
                    } else if (viewType == FriendViewType.friendRequests) {
                      // Accept friend request
                      await context
                          .read<AuthenticationProvider>()
                          .acceptFriendRequest(friendID: data.uid)
                          .whenComplete(() {
                        showSnackBar(
                            context, 'You are now friends with ${data.name}');
                      });
                    } else {
                      // Check the box
                    }
                  },
                  child: viewType == FriendViewType.friends
                      ? const Text('Chat')
                      : const Text('Accept'),
                ),
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
