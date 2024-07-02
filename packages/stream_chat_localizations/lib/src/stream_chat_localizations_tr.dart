part of 'stream_chat_localizations.dart';

/// The translations for Turkish (`tr`).
class StreamChatLocalizationsTr extends GlobalStreamChatLocalizations {
  /// Create an instance of the translation bundle for Turkish.
  const StreamChatLocalizationsTr({super.localeName = 'tr'});

  @override
  String get launchUrlError => 'URL başlatılamıyor';

  @override
  String get loadingUsersError => 'Kullanıcılar yüklenirken hata oluştu';

  @override
  String get noUsersLabel => 'Şu anda kullanıcı yok';

  @override
  String get noPhotoOrVideoLabel => 'Fotoğraf veya video yok';

  @override
  String get retryLabel => 'Yeniden dene';

  @override
  String get userLastOnlineText => 'Son çevrimiçi';

  @override
  String get userOnlineText => 'Çevrimiçi';

  @override
  String userTypingText(Iterable<User> users) {
    if (users.isEmpty) return '';
    final first = users.first;
    if (users.length == 1) {
      return '${first.name} yazıyor';
    }
    return '${first.name} ve ${users.length - 1} kişi daha yazıyor';
  }

  @override
  String get threadReplyLabel => 'İplik Yanıtı';

  @override
  String get onlyVisibleToYouText => 'Sadece size görünür';

  @override
  String threadReplyCountText(int count) => '$count İplik Yanıtları';

  @override
  String attachmentsUploadProgressText({
    required int remaining,
    required int total,
  }) =>
      'Yükleniyor $remaining/$total ...';

  @override
  String pinnedByUserText({
    required User pinnedBy,
    required User currentUser,
  }) {
    final pinnedByCurrentUser = currentUser.id == pinnedBy.id;
    if (pinnedByCurrentUser) return 'Sizin tarafınızdan işaretlendi';
    return '${pinnedBy.name} tarafından işaretlendi';
  }

  @override
  String get sendMessagePermissionError => 'Mesaj gönderme izniniz yok';

  @override
  String get emptyMessagesText => 'Şu anda mesaj yok';

  @override
  String get genericErrorText => 'Bir şeyler yanlış gitti';

  @override
  String get loadingMessagesError => 'Mesajlar yüklenirken hata oluştu';

  @override
  String resultCountText(int count) => '$count sonuç';

  @override
  String get messageDeletedText => 'Bu mesaj silindi.';

  @override
  String get messageDeletedLabel => 'Mesaj silindi';

  @override
  String get messageReactionsLabel => 'Mesaj Tepkileri';

  @override
  String get emptyChatMessagesText => 'Burada henüz sohbet yok...';

  @override
  String threadSeparatorText(int replyCount) {
    if (replyCount == 1) return '1 Yanıt';
    return '$replyCount Yanıtlar';
  }

  @override
  String get connectedLabel => 'Bağlandı';

  @override
  String get disconnectedLabel => 'Bağlantı kesildi';

  @override
  String get reconnectingLabel => 'Yeniden bağlanıyor...';

  @override
  String get alsoSendAsDirectMessageLabel =>
      'Ayrıca doğrudan mesaj olarak gönder';

  @override
  String get addACommentOrSendLabel => 'Yorum ekle veya gönder';

  @override
  String get searchGifLabel => 'GIF Ara';

  @override
  String get writeAMessageLabel => 'Bir mesaj yaz';

  @override
  String get instantCommandsLabel => 'Anında Komutlar';

  @override
  String fileTooLargeAfterCompressionError(double limitInMB) =>
      'Dosya yüklemek için çok büyük. '
      'Dosya boyutu limiti $limitInMB MB. '
      'Sıkıştırmayı denedik, ancak yeterli değildi.';

  @override
  String fileTooLargeError(double limitInMB) =>
      'Dosya yüklemek için çok büyük. Dosya boyutu limiti $limitInMB MB.';

  @override
  String get couldNotReadBytesFromFileError => 'Dosyadan bayt okunamadı.';

  @override
  String get addAFileLabel => 'Bir dosya ekle';

  @override
  String get photoFromCameraLabel => 'Kameradan fotoğraf';

  @override
  String get uploadAFileLabel => 'Bir dosya yükle';

  @override
  String get uploadAPhotoLabel => 'Bir fotoğraf yükle';

  @override
  String get uploadAVideoLabel => 'Bir video yükle';

  @override
  String get videoFromCameraLabel => 'Kameradan video';

  @override
  String get okLabel => 'Tamam';

  @override
  String get somethingWentWrongError => 'Bir şeyler yanlış gitti';

  @override
  String get addMoreFilesLabel => 'Daha fazla dosya ekle';

  @override
  String get enablePhotoAndVideoAccessMessage =>
      'Lütfen arkadaşlarınızla paylaşabilmeniz için'
      'fotoğraf ve videolara erişimi etkinleştirin.';

  @override
  String get allowGalleryAccessMessage => 'Galerinize erişime izin verin';

  @override
  String get flagMessageLabel => 'Mesajı İşaretle';

  @override
  String get flagMessageQuestion =>
      'Bu mesajın bir kopyasını daha fazla inceleme için bir'
      'moderatöre göndermek istiyor musunuz?';

  @override
  String get flagLabel => 'İŞARETLE';

  @override
  String get cancelLabel => 'İPTAL';

  @override
  String get flagMessageSuccessfulLabel => 'Mesaj işaretlendi';

  @override
  String get flagMessageSuccessfulText => 'Mesaj bir moderatöre rapor edildi.';

  @override
  String get deleteLabel => 'SİL';

  @override
  String get deleteMessageLabel => 'Mesajı Sil';

  @override
  String get deleteMessageQuestion =>
      'Bu mesajı kalıcı olarak silmek istediğinizden emin misiniz?';

  @override
  String get operationCouldNotBeCompletedText => 'İşlem tamamlanamadı.';

  @override
  String get replyLabel => 'Yanıtla';

  @override
  String togglePinUnpinText({required bool pinned}) {
    if (pinned) return 'Mesajın işaretini kaldır';
    return 'Mesajı işaretle';
  }

  @override
  String toggleDeleteRetryDeleteMessageText({required bool isDeleteFailed}) {
    if (isDeleteFailed) return 'Mesaj Silmeyi Yeniden Dene';
    return 'Mesajı Sil';
  }

  @override
  String get copyMessageLabel => 'Mesajı Kopyala';

  @override
  String get editMessageLabel => 'Mesajı Düzenle';

  @override
  String toggleResendOrResendEditedMessage({required bool isUpdateFailed}) {
    if (isUpdateFailed) return 'Düzenlenmiş Mesajı Yeniden Gönder';
    return 'Yeniden Gönder';
  }

  @override
  String get photosLabel => 'Fotoğraflar';

  String _getDay(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (date == today) {
      return 'bugün';
    } else if (date == yesterday) {
      return 'dün';
    } else {
      return '${Jiffy.parseFromDateTime(date).MMMd} tarihinde';
    }
  }

  @override
  String sentAtText({required DateTime date, required DateTime time}) =>
      '${_getDay(date)} saat ${Jiffy.parseFromDateTime(time.toLocal()).format(
        pattern: 'HH:mm',
      )} gönderildi';

  @override
  String get todayLabel => 'Bugün';

  @override
  String get yesterdayLabel => 'Dün';

  @override
  String get channelIsMutedText => 'Kanal sessize alındı';

  @override
  String get noTitleText => 'Başlık yok';

  @override
  String get letsStartChattingLabel => 'Hadi sohbete başlayalım!';

  @override
  String get sendingFirstMessageLabel =>
      'Bir arkadaşınıza ilk mesajınızı göndermek ister misiniz?';

  @override
  String get startAChatLabel => 'Sohbet Başlat';

  @override
  String get loadingChannelsError => 'Kanallar yüklenirken hata oluştu';

  @override
  String get deleteConversationLabel => 'Görüşmeyi Sil';

  @override
  String get deleteConversationQuestion =>
      'Bu görüşmeyi silmek istediğinizden emin misiniz?';

  @override
  String get streamChatLabel => 'Akış Sohbeti';

  @override
  String get searchingForNetworkText => 'Ağ Aranıyor';

  @override
  String get offlineLabel => 'Çevrimdışı...';

  @override
  String get tryAgainLabel => 'Tekrar Deneyin';

  @override
  String membersCountText(int count) {
    if (count == 1) return '1 Üye';
    return '$count Üye';
  }

  @override
  String watchersCountText(int count) {
    if (count == 1) return '1 Çevrimiçi';
    return '$count Çevrimiçi';
  }

  @override
  String get viewInfoLabel => 'Bilgileri Görüntüle';

  @override
  String get leaveGroupLabel => 'Grubu Terk Et';

  @override
  String get leaveLabel => 'TERK ET';

  @override
  String get leaveConversationLabel => 'Görüşmeyi Terk Et';

  @override
  String get leaveConversationQuestion =>
      'Bu görüşmeyi terk etmek istediğinizden emin misiniz?';

  @override
  String get showInChatLabel => 'Sohbette Göster';

  @override
  String get saveImageLabel => 'Resmi Kaydet';

  @override
  String get saveVideoLabel => 'Videoyu Kaydet';

  @override
  String get uploadErrorLabel => 'YÜKLEME HATASI';

  @override
  String get giphyLabel => 'Giphy';

  @override
  String get shuffleLabel => 'Karıştır';

  @override
  String get sendLabel => 'Gönder';

  @override
  String get withText => 'ile';

  @override
  String get inText => 'içinde';

  @override
  String get youText => 'Sen';

  @override
  String get editedText => 'Düzenlendi';

  @override
  String galleryPaginationText({
    required int currentPage,
    required int totalPages,
  }) =>
      '${currentPage + 1} / $totalPages';

  @override
  String get fileText => 'Dosya';

  @override
  String get replyToMessageLabel => 'Mesaja Yanıt Ver';

  @override
  String attachmentLimitExceedError(int limit) =>
      'Ek limiti aşıldı, limit: $limit';

  @override
  String get slowModeOnLabel => 'Yavaş mod AÇIK';

  @override
  String get downloadLabel => 'İndir';

  @override
  String toggleMuteUnmuteUserText({required bool isMuted}) {
    if (isMuted) {
      return 'Kullanıcıyı Sesi Aç';
    } else {
      return 'Kullanıcıyı Sessize Al';
    }
  }

  @override
  String toggleMuteUnmuteGroupQuestion({required bool isMuted}) {
    if (isMuted) {
      return 'Bu grubun sesini açmak istediğinizden emin misiniz?';
    } else {
      return 'Bu grubu sessize almak istediğinizden emin misiniz?';
    }
  }

  @override
  String toggleMuteUnmuteUserQuestion({required bool isMuted}) {
    if (isMuted) {
      return 'Bu kullanıcının sesini açmak istediğinizden emin misiniz?';
    } else {
      return 'Bu kullanıcıyı sessize almak istediğinizden emin misiniz?';
    }
  }

  @override
  String toggleMuteUnmuteAction({required bool isMuted}) {
    if (isMuted) {
      return 'SESSİZİ AÇ';
    } else {
      return 'SESSİZE AL';
    }
  }

  @override
  String toggleMuteUnmuteGroupText({required bool isMuted}) {
    if (isMuted) {
      return 'Grubun Sessizini Aç';
    } else {
      return 'Grubu Sessize Al';
    }
  }

  @override
  String get linkDisabledDetails => 'Bu görüşmede bağlantı göndermek yasaktır.';

  @override
  String get linkDisabledError => 'Bağlantılar devre dışı';

  @override
  String get viewLibrary => 'Kütüphaneyi Görüntüle';

  @override
  String unreadMessagesSeparatorText(int unreadCount) {
    if (unreadCount == 1) {
      return '1 okunmamış mesaj';
    }
    return '$unreadCount okunmamış mesaj';
  }

  @override
  String get enableFileAccessMessage => 'Lütfen dosyalara erişimi etkinleştirin'
      'böylece arkadaşlarınızla paylaşabilirsiniz.';

  @override
  String get allowFileAccessMessage => 'Dosyalara erişime izin ver';
}
