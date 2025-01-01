import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:hni_customers_app/model/hni_customer_met_model.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageInitial());

  Future<Map<String, dynamic>> _loadJson(String assetPath) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load JSON: $e');
    }
  }

  Future<HniCustomerMetResponce> _parseHniCustomerMetModel(
    Map<String, dynamic> json,
  ) async {
    return HniCustomerMetResponce.fromJson(json);
  }

  Future<HniCustomerMetResponce> _parseActivitiesConductedModel(
    Map<String, dynamic> json,
  ) async {
    return HniCustomerMetResponce.fromJson(json);
  }

  Future<HniCustomerMetResponce> _parseNonHniCustomerMetModel(
    Map<String, dynamic> json,
  ) async {
    return HniCustomerMetResponce.fromJson(json);
  }

  Future<void> init() async {
    emit(HomepageLoading());

    try {
      final hniCustomerMetJson =
          await _loadJson('lib/resources/hnicustomersmet.json');
      final activitiesConductedJson =
          await _loadJson('lib/resources/activitiesconducted.json');
      final nonHniCustomerMetJson =
          await _loadJson('lib/resources/nonhnicustomermet.json');

      final hniCustomerMetResponce =
          await _parseHniCustomerMetModel(hniCustomerMetJson);
      final activitiesConductedResponce =
          await _parseActivitiesConductedModel(activitiesConductedJson);
      final nonHniCustomerMetResponce =
          await _parseNonHniCustomerMetModel(nonHniCustomerMetJson);
      emit(
        HomepageLoaded(
          hniCustomerMetResponce,
          activitiesConductedResponce,
          nonHniCustomerMetResponce,
          [
            hniCustomerMetResponce,
            activitiesConductedResponce,
            nonHniCustomerMetResponce,
          ],
        ),
      );
    } catch (e) {
      emit(HomepageFailed('Something went wrong: $e'));
    }
  }
}
