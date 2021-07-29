import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:model/model.dart';
import 'package:tmail_ui_user/features/login/domain/state/authentication_user_state.dart';
import 'package:tmail_ui_user/features/login/domain/usecases/authentication_user_interactor.dart';
import 'package:tmail_ui_user/features/login/presentation/state/login_state.dart';
import 'package:tmail_ui_user/main/routes/app_routes.dart';

class LoginController extends GetxController {

  final AuthenticationInteractor _authenticationInteractor;
  final DynamicUrlInterceptors _dynamicUrlInterceptors;
  final AuthorizationInterceptors _authorizationInterceptors;

  LoginController(
    this._authenticationInteractor,
    this._dynamicUrlInterceptors,
    this._authorizationInterceptors,
  );

  var loginState = LoginState(Right(LoginInitAction())).obs;

  String? _urlText;
  String? _userNameText;
  String? _passwordText;

  void setUrlText(String url) => _urlText = url.formatURLValid();

  void setUserNameText(String userName) => _userNameText = userName;

  void setPasswordText(String password) => _passwordText = password;

  Uri? _parseUri(String? url) => url != null ? Uri.parse(url) : null;

  UserName? _parseUserName(String? userName) => userName != null ? UserName(userName) : null;

  Password? _parsePassword(String? password) => password != null ? Password(password) : null;

  void handleLoginPressed() {
    final baseUri = _parseUri(_urlText);
    final userName = _parseUserName(_userNameText);
    final password = _parsePassword(_passwordText);
    if (baseUri != null && userName != null && password != null) {
      _loginAction(baseUri, userName, password);
    } else {
      loginState.value = LoginState(Left(LoginMissPropertiesAction()));
    }
  }

  void _loginAction(Uri baseUrl, UserName userName, Password password) async {
    loginState.value = LoginState(Right(LoginLoadingAction()));
    await _authenticationInteractor.execute(baseUrl, userName, password)
      .then((response) => response.fold(
        (failure) => failure is AuthenticationUserFailure ? _loginFailureAction(failure) : null,
        (success) => success is AuthenticationUserViewState ? _loginSuccessAction(success) : null));
  }

  void _loginSuccessAction(AuthenticationUserViewState success) {
    loginState.value = LoginState(Right(success));
    _dynamicUrlInterceptors.changeBaseUrl(_urlText);
    _authorizationInterceptors.changeAuthorization(_userNameText, _passwordText);
    Get.offNamed(AppRoutes.MAILBOX_DASHBOARD);
  }

  void _loginFailureAction(AuthenticationUserFailure failure) {
    loginState.value = LoginState(Left(failure));
  }
}