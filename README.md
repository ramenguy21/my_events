# my_events

Demo App made to fulfill the technical task set by the MySkool team.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Workflow

19/11 Looking for inspirations, establishing themeing and prototyping in figma.
20/11 Working on auth
21/11 Auth Finished, moving to events

Architecture Justification:
Why GetX?
Looks to be the easiest to implement lol

Why Repository Pattern?

Separates data sources from business logic
Easy to mock for testing
Single source of truth for data operations
Can swap APIs without touching UI

Why Dio over http?
honestly, i personally think it might be bloat, but since i'm new, i need it to handhold me :3

Supported Emails
george.bluth@reqres.in
janet.weaver@reqres.in
emma.wong@reqres.in
eve.holt@reqres.in
charles.morris@reqres.in
tracey.ramos@reqres.in
Note for reviewer: ReqRes accepts any password for these emails. Common test password: pistol or any string works.
