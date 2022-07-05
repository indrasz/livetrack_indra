import 'package:livetrack_indra/models/base_response.dart';
import 'package:livetrack_indra/utils/enums.dart';
import 'package:livetrack_indra/utils/exceptions.dart';
import 'package:livetrack_indra/utils/typedefs.dart';

class ResponseWrapper {
  static T guard<T>(
    ResponseOfRequest response, {
    Function(Object e)? onError,
  }) {
    assert(T == MapString || T == List, 'T must be MapString or List');

    try {
      if (response.status == ResponseStatus.success) {
        final data = response.data! as MapString;
        final raw = data['data'] as T;

        return raw;
      }
      throw CustomExceptionString(response.message ?? 'Unknown error');
    } catch (e) {
      onError?.call(e);
      rethrow;
    }
  }
}
