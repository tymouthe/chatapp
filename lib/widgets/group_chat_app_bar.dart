

// class GroupChatAppBar extends StatefulWidget {
//   const GroupChatAppBar({super.key, required this.groupId});

//   final String groupId;

//   @override
//   State<GroupChatAppBar> createState() => _GroupChatAppBarState();
// }

// class _GroupChatAppBarState extends State<GroupChatAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: context
//           .read<AuthenticationProvider>()
//           .userStream(userID: widget.groupId),
//       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return const Center(
//             child: Text('Something went wrong'),
//           );
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         final groupModel =
//             GroupModel.fromMap(snapshot.data!.data() as Map<String, dynamic>);

//         return Row(
//           children: [
//             userImageWidget(
//               imageUrl: groupModel.image,
//               radius: 20,
//               onTap: () {
//                 // Navigate to group settings screen
//               },
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(groupModel.name),
//                 const Text(
//                   'Online',
//                   // userModel.isOnline
//                   // ? 'Online'
//                   // : 'Last seen ${GlobalMethods.formatTimestamp(userModel.lastSeen)}',
//                   style: TextStyle(fontSize: 12),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
