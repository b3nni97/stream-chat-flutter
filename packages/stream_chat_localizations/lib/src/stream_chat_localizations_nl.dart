part of 'stream_chat_localizations.dart';

/// The translations for Dutch (`nl`).
class StreamChatLocalizationsNl extends GlobalStreamChatLocalizations {
  /// Create an instance of the translation bundle for Dutch.
  const StreamChatLocalizationsNl({super.localeName = 'nl'});

  @override
  String get launchUrlError => 'Kan de URL niet openen';

  @override
  String get loadingUsersError => 'Fout bij het laden van gebruikers';

  @override
  String get noUsersLabel => 'Er zijn momenteel geen gebruikers';

  @override
  String get noPhotoOrVideoLabel => 'Geen foto of video';

  @override
  String get retryLabel => 'Opnieuw proberen';

  @override
  String get userLastOnlineText => 'Laatst online';

  @override
  String get userOnlineText => 'Online';

  @override
  String userTypingText(Iterable<User> users) {
    if (users.isEmpty) return '';
    final first = users.first;
    if (users.length == 1) {
      return '${first.name} is aan het typen';
    }
    return '${first.name} en nog ${users.length - 1} anderen zijn aan het typen';
  }

  @override
  String get threadReplyLabel => 'Thread antwoord';

  @override
  String get onlyVisibleToYouText => 'Alleen zichtbaar voor jou';

  @override
  String threadReplyCountText(int count) => '$count thread antwoorden';

  @override
  String attachmentsUploadProgressText({
    required int remaining,
    required int total,
  }) =>
      'Uploaden $remaining/$total ...';

  @override
  String pinnedByUserText({
    required User pinnedBy,
    required User currentUser,
  }) {
    final pinnedByCurrentUser = currentUser.id == pinnedBy.id;
    if (pinnedByCurrentUser) return 'Gemarkeerd door jou';
    return 'Gemarkeerd door ${pinnedBy.name}';
  }

  @override
  String get sendMessagePermissionError =>
      'Je hebt geen toestemming om berichten te versturen';

  @override
  String get emptyMessagesText => 'Er zijn momenteel geen berichten';

  @override
  String get genericErrorText => 'Er is iets fout gegaan';

  @override
  String get loadingMessagesError => 'Fout bij het laden van berichten';

  @override
  String resultCountText(int count) => '$count resultaten';

  @override
  String get messageDeletedText => 'Dit bericht is verwijderd.';

  @override
  String get messageDeletedLabel => 'Bericht verwijderd';

  @override
  String get messageReactionsLabel => 'Berichtreacties';

  @override
  String get emptyChatMessagesText => 'Nog geen chats hier...';

  @override
  String threadSeparatorText(int replyCount) {
    if (replyCount == 1) return '1 antwoord';
    return '$replyCount antwoorden';
  }

  @override
  String get connectedLabel => 'Verbonden';

  @override
  String get disconnectedLabel => 'Verbinding verbroken';

  @override
  String get reconnectingLabel => 'Opnieuw verbinden...';

  @override
  String get alsoSendAsDirectMessageLabel => 'Ook als direct bericht versturen';

  @override
  String get addACommentOrSendLabel => 'Voeg een opmerking toe of verstuur';

  @override
  String get searchGifLabel => 'Zoek GIFs';

  @override
  String get writeAMessageLabel => 'Schrijf een bericht';

  @override
  String get instantCommandsLabel => 'Directe commando’s';

  @override
  String fileTooLargeAfterCompressionError(double limitInMB) =>
      'Het bestand is te groot om te uploaden. '
      'De bestandsgrootte limiet is $limitInMB MB. '
      'We hebben geprobeerd het te comprimeren, maar het was niet genoeg.';

  @override
  String fileTooLargeError(double limitInMB) =>
      'Het bestand is te groot om te uploaden. De bestandsgrootte limiet is $limitInMB MB.';

  @override
  String get couldNotReadBytesFromFileError =>
      'Kon bytes niet lezen van bestand.';

  @override
  String get addAFileLabel => 'Voeg een bestand toe';

  @override
  String get photoFromCameraLabel => 'Foto van camera';

  @override
  String get uploadAFileLabel => 'Upload een bestand';

  @override
  String get uploadAPhotoLabel => 'Upload een foto';

  @override
  String get uploadAVideoLabel => 'Upload een video';

  @override
  String get videoFromCameraLabel => 'Video van camera';

  @override
  String get okLabel => 'OK';

  @override
  String get somethingWentWrongError => 'Er is iets fout gegaan';

  @override
  String get addMoreFilesLabel => 'Voeg meer bestanden toe';

  @override
  String get enablePhotoAndVideoAccessMessage => "Sta toegang toe tot je foto's"
      "\nen video's zodat je ze kunt delen met vrienden.";

  @override
  String get allowGalleryAccessMessage => 'Sta toegang tot je galerij toe';

  @override
  String get flagMessageLabel => 'Markeer bericht';

  @override
  String get flagMessageQuestion =>
      'Wil je een kopie van dit bericht sturen naar een '
      '\nmoderator voor verder onderzoek?';

  @override
  String get flagLabel => 'MARKEREN';

  @override
  String get cancelLabel => 'ANNULEREN';

  @override
  String get flagMessageSuccessfulLabel => 'Bericht gemarkeerd';

  @override
  String get flagMessageSuccessfulText =>
      'Het bericht is gemeld bij een moderator.';

  @override
  String get deleteLabel => 'VERWIJDEREN';

  @override
  String get deleteMessageLabel => 'Verwijder bericht';

  @override
  String get deleteMessageQuestion =>
      'Weet je zeker dat je dit bericht permanent wilt verwijderen?';

  @override
  String get operationCouldNotBeCompletedText =>
      'De operatie kon niet worden voltooid.';

  @override
  String get replyLabel => 'Antwoord';

  @override
  String togglePinUnpinText({required bool pinned}) {
    if (pinned) return 'Bericht demarkeren';
    return 'Bericht markeren';
  }

  @override
  String toggleDeleteRetryDeleteMessageText({required bool isDeleteFailed}) {
    if (isDeleteFailed) return 'Verwijdering opnieuw proberen';
    return 'Bericht verwijderen';
  }

  @override
  String get copyMessageLabel => 'Kopieer bericht';

  @override
  String get editMessageLabel => 'Bewerk bericht';

  @override
  String toggleResendOrResendEditedMessage({required bool isUpdateFailed}) {
    if (isUpdateFailed) return 'Bewerkt bericht opnieuw versturen';
    return 'Opnieuw versturen';
  }

  @override
  String get photosLabel => 'Foto’s';

  String _getDay(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (date == today) {
      return 'vandaag';
    } else if (date == yesterday) {
      return 'gisteren';
    } else {
      return 'op ${Jiffy.parseFromDateTime(date).MMMd}';
    }
  }

  @override
  String sentAtText({required DateTime date, required DateTime time}) =>
      'Verzonden ${_getDay(date)} om ${Jiffy.parseFromDateTime(time.toLocal()).format(
        pattern: 'HH:mm',
      )}';

  @override
  String get todayLabel => 'Vandaag';

  @override
  String get yesterdayLabel => 'Gisteren';

  @override
  String get channelIsMutedText => 'Kanaal is gedempt';

  @override
  String get noTitleText => 'Geen titel';

  @override
  String get letsStartChattingLabel => 'Laten we beginnen met chatten!';

  @override
  String get sendingFirstMessageLabel =>
      'Hoe zit het met het versturen van je eerste bericht aan een vriend?';

  @override
  String get startAChatLabel => 'Begin een chat';

  @override
  String get loadingChannelsError => 'Fout bij het laden van kanalen';

  @override
  String get deleteConversationLabel => 'Gesprek verwijderen';

  @override
  String get deleteConversationQuestion =>
      'Weet je zeker dat je dit gesprek wilt verwijderen?';

  @override
  String get streamChatLabel => 'Stream Chat';

  @override
  String get searchingForNetworkText => 'Zoeken naar netwerk';

  @override
  String get offlineLabel => 'Offline...';

  @override
  String get tryAgainLabel => 'Probeer opnieuw';

  @override
  String membersCountText(int count) {
    if (count == 1) return '1 lid';
    return '$count leden';
  }

  @override
  String watchersCountText(int count) {
    if (count == 1) return '1 online';
    return '$count online';
  }

  @override
  String get viewInfoLabel => 'Bekijk informatie';

  @override
  String get leaveGroupLabel => 'Verlaat groep';

  @override
  String get leaveLabel => 'VERLATEN';

  @override
  String get leaveConversationLabel => 'Verlaat gesprek';

  @override
  String get leaveConversationQuestion =>
      'Weet je zeker dat je dit gesprek wilt verlaten?';

  @override
  String get showInChatLabel => 'Toon in chat';

  @override
  String get saveImageLabel => 'Afbeelding opslaan';

  @override
  String get saveVideoLabel => 'Video opslaan';

  @override
  String get uploadErrorLabel => 'UPLOADFOUT';

  @override
  String get giphyLabel => 'Giphy';

  @override
  String get shuffleLabel => 'Schudden';

  @override
  String get sendLabel => 'Verstuur';

  @override
  String get withText => 'met';

  @override
  String get inText => 'in';

  @override
  String get youText => 'Jij';

  @override
  String get editedText => 'Bewerkt';

  @override
  String galleryPaginationText({
    required int currentPage,
    required int totalPages,
  }) =>
      '${currentPage + 1} van $totalPages';

  @override
  String get fileText => 'Bestand';

  @override
  String get replyToMessageLabel => 'Antwoord op bericht';

  @override
  String attachmentLimitExceedError(int limit) =>
      'Bijlage limiet overschreden, limiet: $limit';

  @override
  String get slowModeOnLabel => 'Langzame modus AAN';

  @override
  String get downloadLabel => 'Download';

  @override
  String toggleMuteUnmuteUserText({required bool isMuted}) {
    if (isMuted) {
      return 'Gebruiker dempen';
    } else {
      return 'Gebruiker ontdempen';
    }
  }

  @override
  String toggleMuteUnmuteGroupQuestion({required bool isMuted}) {
    if (isMuted) {
      return 'Weet je zeker dat je deze groep wilt ontdempen?';
    } else {
      return 'Weet je zeker dat je deze groep wilt dempen?';
    }
  }

  @override
  String toggleMuteUnmuteUserQuestion({required bool isMuted}) {
    if (isMuted) {
      return 'Weet je zeker dat je deze gebruiker wilt ontdempen?';
    } else {
      return 'Weet je zeker dat je deze gebruiker wilt dempen?';
    }
  }

  @override
  String toggleMuteUnmuteAction({required bool isMuted}) {
    if (isMuted) {
      return 'ONTDEMPEN';
    } else {
      return 'DEMPEN';
    }
  }

  @override
  String toggleMuteUnmuteGroupText({required bool isMuted}) {
    if (isMuted) {
      return 'Groep ontdempen';
    } else {
      return 'Groep dempen';
    }
  }

  @override
  String get linkDisabledDetails =>
      'Het verzenden van links is niet toegestaan in dit gesprek.';

  @override
  String get linkDisabledError => 'Links zijn uitgeschakeld';

  @override
  String get viewLibrary => 'Bekijk bibliotheek';

  @override
  String unreadMessagesSeparatorText(int unreadCount) {
    if (unreadCount == 1) {
      return '1 ongelezen bericht';
    }
    return '$unreadCount ongelezen berichten';
  }

  @override
  String get enableFileAccessMessage => 'Sta toegang tot bestanden toe'
      '\nzodat je ze kunt delen met vrienden.';

  @override
  String get allowFileAccessMessage => 'Sta toegang tot bestanden toe';
}
