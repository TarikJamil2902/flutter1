import 'package:flutter/material.dart';
import 'package:new_flutter_app/API/entity/post.dart';
import 'package:new_flutter_app/utill/ApiService.dart';

// Your Post model

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter API CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Vogue'),
          bodyMedium: TextStyle(fontFamily: 'Vogue'),
          bodySmall: TextStyle(fontFamily: 'Vogue'),
        ),
      ),
      home: PostListScreen(),
    );
  }
}
// Your Post model

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late ApiService apiService;
  late Future<List<Post>> postList;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    postList = apiService.fetchPosts();
  }

  // Method to show the Create Post dialog
  void _showCreatePostDialog(Post? postUpdate) {
    final _titleController = TextEditingController(
      text: postUpdate != null ? postUpdate.title : '',
    );
    final _bodyController = TextEditingController(
      text: postUpdate != null ? postUpdate.body : '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(postUpdate != null ? 'Update Post' : 'Create New Post'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _bodyController,
                  decoration: InputDecoration(labelText: 'Body'),
                  maxLines: 4,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final post = Post(
                  id: postUpdate?.id,
                  title: _titleController.text,
                  body: _bodyController.text,
                );

                if (_titleController.text.isNotEmpty &&
                    _bodyController.text.isNotEmpty) {
                  try {
                    if (postUpdate != null) {
                      final updatedPost = await apiService.updatePost(post);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Post Updated: ${updatedPost.title}'),
                        ),
                      );
                      setState(() {
                        postList =
                            apiService.fetchPosts(); // Refresh the posts list
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    } else {
                      print("create--------------------");
                      final createdPost = await apiService.createPost(post);
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Post Created: ${createdPost.title}'),
                        ),
                      );
                      setState(() {
                        postList =
                            apiService.fetchPosts(); // Refresh the posts list
                      });
                      Navigator.of(context).pop();
                    }
                    // Close the dialog
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to create post: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in both fields')),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showCreatePostDialog(null),

            // onPressed: _showCreatePostDialog,
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: postList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available.'));
          }

          List<Post> postsData = snapshot.data!;

          return ListView.builder(
            itemCount: postsData.length,
            itemBuilder: (context, index) {
              Post post = postsData[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                onTap: () {
                  // Example of Update
                  Post updatedPost = Post(
                    id: post.id,
                    title: post.title,
                    body: post.body,
                  );

                  _showCreatePostDialog(updatedPost);
                  // await apiService.updatePost(updatedPost);
                  // setState(() {
                  //   postList =
                  //       apiService.fetchPosts(); // Refresh the posts list
                  // });
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await apiService.deletePost(post.id);
                    setState(() {
                      postList =
                          apiService.fetchPosts(); // Refresh the posts list
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
