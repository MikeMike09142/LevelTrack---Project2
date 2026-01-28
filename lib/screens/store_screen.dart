
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../state/app_state.dart';

// Define the ID of your in-app product.
// You will create this ID in the Google Play Console.
const String _kProductId = 'remove_ads_forever';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  bool _isStoreAvailable = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // Handle errors here.
    });

    initStoreInfo();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isStoreAvailable = false;
        _isLoading = false;
      });
      return;
    }

    // Load the product details from the store.
    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails({_kProductId});

    if (productDetailResponse.error != null) {
      setState(() {
        _isStoreAvailable = false;
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _products = productDetailResponse.productDetails;
      _isStoreAvailable = true;
      _isLoading = false;
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Show a pending UI if needed.
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // Handle errors.
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
                   purchaseDetails.status == PurchaseStatus.restored) {
          // This is where you unlock the feature.
          // For example, you could call a method in your AppState:
          AppState.instance.setAdsRemoved(true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Purchase successful! Ads removed.')),
          );
        }
        if (purchaseDetails.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  void _buyProduct() {
    if (_products.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product not available to buy.')),
      );
      return;
    }
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: _products.first);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_isStoreAvailable) {
      return const Center(
        child: Text('The store is not available on this device.'),
      );
    }

    if (_products.isEmpty) {
      return const Center(
        child: Text('Could not load products from the store. Please try again later.'),
      );
    }

    final ProductDetails product = _products.first;

    return ListView(
      children: [
        ListTile(
          title: Text(product.title),
          subtitle: Text(product.description),
          trailing: ElevatedButton(
            onPressed: _buyProduct,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
            ),
            // Display the price from the store.
            child: Text(product.price),
          ),
        ),
      ],
    );
  }
}
