import 'package:get/get.dart';
import 'package:hotel_manager/controllers/network/review_network_controller.dart';
import 'package:hotel_manager/enum/review_status.dart';
import 'package:hotel_manager/exception/network_exception.dart';

import '../../models/review.dart';

class ReviewDataController extends GetxController {
  ReviewNetworkController _rnc = ReviewNetworkController.instance;

  static ReviewDataController instance = Get.find();

  RxList<Review> _tempReviewList = <Review>[].obs;
  List<Review> get tempReviewList => _tempReviewList;

  RxList<Review> _reviewList = <Review>[].obs;
  List<Review> get reviewList => _reviewList;

  ReviewDataController._();

  static Future<ReviewDataController> create() async {
    final ReviewDataController controller = ReviewDataController._();
    controller._initController();
    return controller;
  }

  Future<void> reinitController() async
  {
    await _initController();
  }

  Future<void> _initController() async {
    _tempReviewList.value = await _getTempReviews();
    _reviewList.value = await _getAcceptedReviews();
  }

  Future<List<Review>> _getTempReviews() async {
    try {
      List<Map<String, dynamic>> tempReviewsMapList =
          await _rnc.getTempReviews();
      return tempReviewsMapList.map((map) => Review.fromMap(map)).toList();
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Review>> _getAcceptedReviews() async {
    try {
      List<Map<String, dynamic>> acceptedReviewsMapList =
          await _rnc.getAcceptedReviews();
      return acceptedReviewsMapList.map((map) => Review.fromMap(map)).toList();
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> acceptReview({required int tempReviewId}) async {
    try {
      await _rnc.acceptReview(tempReviewId: tempReviewId);
      Review review = _tempReviewList
          .where((tempReview) => tempReview.id == tempReviewId)
          .toList()
          .first;
      _tempReviewList
          .removeWhere((tempReview) => tempReview.id == tempReviewId);
      _reviewList.add(review.copyWith(status: ReviewStatus.Accepted));
      _reviewList.sort(
          (a, b) => a.createdAt.isBefore(b.createdAt) ? 1 : 0); //check sort
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectReview({required int tempReviewId}) async {
    try {
      await _rnc.rejectReview(tempReviewId: tempReviewId);
      _tempReviewList
          .removeWhere((tempReview) => tempReview.id == tempReviewId);
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
