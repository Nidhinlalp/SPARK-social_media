import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spark/screens/add_post_screen.dart';
import 'package:spark/screens/feed_screen.dart';
import 'package:spark/screens/profile_screen.dart';
import 'package:spark/screens/search_screen.dart';

const webScreenSize = 600;
List<Widget> homescreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('data'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
