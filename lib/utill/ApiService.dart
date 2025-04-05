import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_flutter_app/API/entity/post.dart';

class ApiService {
  // final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final String baseUrl = 'http://192.168.20.46:3000/posts';

  // Create Post
  Future<Post> createPost(Post post) async {
    // post.id = 0;
    Map<String, dynamic> data = post.toJson();
    data.remove('id');
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  // Read Posts (Get all posts)
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // Update Post
  Future<Post> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${post.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  // Delete Post
  Future<void> deletePost(String? id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }





  // Read Post (Get post by id)
  Future<Post> fetchPostById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
