import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stream_chat_flutter/src/message_widget/reactions/reaction_bubble.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../mocks.dart';

void main() {
  testGoldens(
    'it should show a like - light theme',
    (WidgetTester tester) async {
      final client = MockClient();
      final clientState = MockClientState();
      final themeData = ThemeData.light();

      when(() => client.state).thenReturn(clientState);
      when(() => clientState.currentUser).thenReturn(OwnUser(id: 'user-id'));

      final theme = StreamChatThemeData.fromTheme(themeData);
      await tester.pumpWidgetBuilder(
        StreamChat(
          client: client,
          streamChatThemeData: theme,
          connectivityStream: Stream.value(ConnectivityResult.mobile),
          child: SizedBox(
            child: StreamReactionBubble(
              reactions: [
                Reaction(
                  type: 'like',
                  user: User(id: 'test'),
                ),
              ],
              ownId: clientState.currentUser!.id,
              ownReactionColor: theme.ownMessageTheme.messageBackgroundColor ??
                  Colors.transparent,
              otherReactionColor:
                  theme.otherMessageTheme.messageBackgroundColor ??
                      Colors.transparent,
              borderColor: theme.ownMessageTheme.reactionsBorderColor!,
              backgroundColor: theme.ownMessageTheme.reactionsBackgroundColor!,
            ),
          ),
        ),
        surfaceSize: const Size(100, 100),
      );
      await screenMatchesGolden(tester, 'reaction_bubble_like_light');
    },
  );

  testGoldens(
    'it should show a like - dark theme',
    (WidgetTester tester) async {
      final client = MockClient();
      final clientState = MockClientState();
      final themeData = ThemeData.dark();
      final theme = StreamChatThemeData.fromTheme(themeData);

      when(() => client.state).thenReturn(clientState);
      when(() => clientState.currentUser).thenReturn(OwnUser(id: 'user-id'));

      await tester.pumpWidgetBuilder(
        StreamChat(
          client: client,
          streamChatThemeData: StreamChatThemeData.fromTheme(themeData),
          connectivityStream: Stream.value(ConnectivityResult.mobile),
          child: ColoredBox(
            color: Colors.black,
            child: StreamReactionBubble(
              reactions: [
                Reaction(
                  type: 'like',
                  user: User(id: 'test'),
                ),
              ],
              ownId: clientState.currentUser!.id,
              ownReactionColor: theme.ownMessageTheme.messageBackgroundColor ??
                  Colors.transparent,
              otherReactionColor:
                  theme.otherMessageTheme.messageBackgroundColor ??
                      Colors.transparent,
              borderColor: theme.ownMessageTheme.reactionsBorderColor!,
              backgroundColor: theme.ownMessageTheme.reactionsBackgroundColor!,
            ),
          ),
        ),
        surfaceSize: const Size(100, 100),
      );
      await screenMatchesGolden(tester, 'reaction_bubble_like_dark');
    },
  );

  testGoldens(
    'it should show three reactions - light theme',
    (WidgetTester tester) async {
      final client = MockClient();
      final clientState = MockClientState();
      final themeData = ThemeData.light();
      final theme = StreamChatThemeData.fromTheme(themeData);

      when(() => client.state).thenReturn(clientState);
      when(() => clientState.currentUser).thenReturn(OwnUser(id: 'user-id'));

      await tester.pumpWidgetBuilder(
        StreamChat(
          client: client,
          streamChatThemeData: StreamChatThemeData.fromTheme(themeData),
          connectivityStream: Stream.value(ConnectivityResult.mobile),
          child: ColoredBox(
            color: Colors.black,
            child: StreamReactionBubble(
              reactions: [
                Reaction(
                  type: 'like',
                  user: User(id: 'test'),
                ),
                Reaction(
                  type: 'like',
                  user: User(id: 'user-id'),
                ),
                Reaction(
                  type: 'like',
                  user: User(id: 'test'),
                ),
              ],
              ownId: clientState.currentUser!.id,
              ownReactionColor: theme.ownMessageTheme.messageBackgroundColor ??
                  Colors.transparent,
              otherReactionColor:
                  theme.otherMessageTheme.messageBackgroundColor ??
                      Colors.transparent,
              borderColor: theme.ownMessageTheme.reactionsBorderColor!,
              backgroundColor: theme.ownMessageTheme.reactionsBackgroundColor!,
            ),
          ),
        ),
        surfaceSize: const Size(140, 140),
      );
      await screenMatchesGolden(tester, 'reaction_bubble_3_light');
    },
  );

  testGoldens(
    'it should show three reactions - dark theme',
    (WidgetTester tester) async {
      final client = MockClient();
      final clientState = MockClientState();
      final themeData = ThemeData.dark();
      final theme = StreamChatThemeData.fromTheme(themeData);

      when(() => client.state).thenReturn(clientState);
      when(() => clientState.currentUser).thenReturn(OwnUser(id: 'user-id'));

      await tester.pumpWidgetBuilder(
        StreamChat(
          client: client,
          streamChatThemeData: StreamChatThemeData.fromTheme(themeData),
          connectivityStream: Stream.value(ConnectivityResult.mobile),
          child: ColoredBox(
            color: Colors.black,
            child: StreamReactionBubble(
              reactions: [
                Reaction(
                  type: 'like',
                  user: User(id: 'test'),
                ),
                Reaction(
                  type: 'like',
                  user: User(id: 'user-id'),
                ),
                Reaction(
                  type: 'like',
                  user: User(id: 'test'),
                ),
              ],
              ownId: clientState.currentUser!.id,
              ownReactionColor: theme.ownMessageTheme.messageBackgroundColor ??
                  Colors.transparent,
              otherReactionColor:
                  theme.otherMessageTheme.messageBackgroundColor ??
                      Colors.transparent,
              borderColor: theme.ownMessageTheme.reactionsBorderColor!,
              backgroundColor: theme.ownMessageTheme.reactionsBackgroundColor!,
            ),
          ),
        ),
        surfaceSize: const Size(140, 140),
      );
      await screenMatchesGolden(tester, 'reaction_bubble_3_dark');
    },
  );

  testGoldens(
    'it should show two reactions with customized ui',
    (WidgetTester tester) async {
      final client = MockClient();
      final clientState = MockClientState();
      final themeData = ThemeData();

      when(() => client.state).thenReturn(clientState);
      when(() => clientState.currentUser).thenReturn(OwnUser(id: 'user-id'));

      final theme = StreamChatThemeData.fromTheme(themeData);

      await tester.pumpWidgetBuilder(
        StreamChat(
          client: client,
          connectivityStream: Stream.value(ConnectivityResult.mobile),
          streamChatThemeData: theme,
          child: SizedBox(
            child: StreamReactionBubble(
              reactions: [
                Reaction(
                  type: 'like',
                  user: User(id: 'test'),
                ),
                Reaction(
                  type: 'love',
                  user: User(id: 'user-id'),
                ),
                Reaction(
                  type: 'unknown',
                  user: User(id: 'test'),
                ),
              ],
              ownId: clientState.currentUser!.id,
              ownReactionColor: theme.ownMessageTheme.messageBackgroundColor ??
                  Colors.transparent,
              otherReactionColor:
                  theme.otherMessageTheme.messageBackgroundColor ??
                      Colors.transparent,
              borderColor: Colors.red,
              backgroundColor: Colors.blue,
              reverse: true,
              flipTail: true,
              tailCirclesSpacing: 4,
            ),
          ),
        ),
        surfaceSize: const Size(200, 200),
      );

      await screenMatchesGolden(tester, 'reaction_bubble_2');
    },
  );
}
