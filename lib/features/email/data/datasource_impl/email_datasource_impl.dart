import 'package:dio/dio.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:model/model.dart';
import 'package:tmail_ui_user/features/composer/domain/model/email_request.dart';
import 'package:tmail_ui_user/features/email/data/datasource/email_datasource.dart';
import 'package:tmail_ui_user/features/email/data/network/email_api.dart';
import 'package:tmail_ui_user/features/email/domain/model/move_request.dart';

class EmailDataSourceImpl extends EmailDataSource {

  final EmailAPI emailAPI;

  EmailDataSourceImpl(this.emailAPI);

  @override
  Future<Email> getEmailContent(AccountId accountId, EmailId emailId) {
    return Future.sync(() async {
      return await emailAPI.getEmailContent(accountId, emailId);
    }).catchError((error) {
      throw error;
    });
  }

  @override
  Future<bool> sendEmail(AccountId accountId, EmailRequest emailRequest) {
    return Future.sync(() async {
      return await emailAPI.sendEmail(accountId, emailRequest);
    }).catchError((error) {
      throw error;
    });
  }

  @override
  Future<List<Email>> markAsRead(AccountId accountId, List<Email> emails, ReadActions readActions) {
    return Future.sync(() async {
      return await emailAPI.markAsRead(accountId, emails, readActions);
    }).catchError((error) {
      throw error;
    });
  }

  @override
  Future<List<DownloadTaskId>> downloadAttachments(
      List<Attachment> attachments,
      AccountId accountId,
      String baseDownloadUrl,
      AccountRequest accountRequest
  ) {
    return Future.sync(() async {
      return await emailAPI.downloadAttachments(attachments, accountId, baseDownloadUrl, accountRequest);
    }).catchError((error) {
      throw error;
    });
  }

  @override
  Future<String> exportAttachment(
      Attachment attachment,
      AccountId accountId,
      String baseDownloadUrl,
      AccountRequest accountRequest,
      CancelToken cancelToken
  ) {
    return Future.sync(() async {
      return await emailAPI.exportAttachment(attachment, accountId, baseDownloadUrl, accountRequest, cancelToken);
    }).catchError((error) {
      throw error;
    });
  }

  @override
  Future<List<EmailId>> moveToMailbox(AccountId accountId, MoveRequest moveRequest) {
    return Future.sync(() async {
      return await emailAPI.moveToMailbox(accountId, moveRequest);
    }).catchError((error) {
      throw error;
    });
  }

  @override
  Future<List<Email>> markAsStar(AccountId accountId, List<Email> emails, MarkStarAction markStarAction) {
    return Future.sync(() async {
      return await emailAPI.markAsStar(accountId, emails, markStarAction);
    }).catchError((error) {
      throw error;
    });
  }
}