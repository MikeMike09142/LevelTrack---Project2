
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
    _initializeStore();
  }
  
  Future<void> _initializeStore() async {
    try {
        final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
        _subscription = purchaseUpdated.listen((purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
        }, onError: (error) {
          // Handle errors here.
        });
    
        await initStoreInfo();
    } catch (e) {
        // print('Store initialization failed: $e');
        if (mounted) {
          setState(() {
              _isStoreAvailable = false;
              _isLoading = false;
          });
        }
    }
  }

  @override
  void dispose() {
    try {
        _subscription.cancel();
    } catch (_) {}
    super.dispose();
  }

  Future<void> initStoreInfo() async {
    try {
        // Add timeout to prevent hanging on unsupported platforms (like Windows desktop without config)
        final bool isAvailable = await _inAppPurchase.isAvailable().timeout(
          const Duration(seconds: 2), 
          onTimeout: () => false,
        );
        
        if (!isAvailable) {
          setState(() {
            _isStoreAvailable = false;
            _isLoading = false;
          });
          return;
        }
    
        // Load the product details from the store.
        final ProductDetailsResponse productDetailResponse =
            await _inAppPurchase.queryProductDetails({_kProductId}).timeout(
              const Duration(seconds: 3),
              onTimeout: () => ProductDetailsResponse(
                productDetails: [], 
                notFoundIDs: [_kProductId], 
                error: null // No IAPError available, so treating as empty
              ),
            );
    
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
    } catch (e) {
         // print('Store info failed: $e');
         if (mounted) {
           setState(() {
              _isStoreAvailable = false;
              _isLoading = false;
            });
         }
    }
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
    return ValueListenableBuilder<int>(
      valueListenable: AppState.instance.diamonds,
      builder: (context, diamondCount, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Diamond Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.diamond, color: Colors.cyanAccent, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    '$diamondCount',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Power-ups
            _buildSectionHeader('Ayudas (Power-ups)'),
            _buildHintItem(
              title: 'Pack Pequeño',
              subtitle: '5 Pistas',
              cost: 50,
              icon: Icons.lightbulb_outline,
              onBuy: () => _buyHints(5, 50),
            ),
            _buildHintItem(
              title: 'Pack Grande',
              subtitle: '20 Pistas (¡Oferta!)',
              cost: 150,
              icon: Icons.lightbulb,
              onBuy: () => _buyHints(20, 150),
            ),
            const SizedBox(height: 24),

            // Section: Themes
            _buildSectionHeader('Temas de Color'),
            _buildThemeItem(
              id: 'dark_neon',
              name: 'Neón Oscuro',
              cost: 200,
              color: Colors.purpleAccent,
            ),
            _buildThemeItem(
              id: 'gold',
              name: 'Lujo Dorado',
              cost: 500,
              color: Colors.amber,
            ),
            _buildThemeItem(
              id: 'ocean',
              name: 'Océano Profundo',
              cost: 300,
              color: Colors.tealAccent,
            ),
             // Allow reverting to default
            _buildThemeItem(
              id: 'default',
              name: 'Clásico',
              cost: 0, // Free/Owned
              color: Colors.blue,
            ),

            const SizedBox(height: 24),

            // Section: Premium
            _buildSectionHeader('Premium'),
            _buildPremiumItem(),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
      ),
    );
  }

  Widget _buildHintItem({required String title, required String subtitle, required int cost, required IconData icon, required VoidCallback onBuy}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white10,
      child: ListTile(
        leading: Icon(icon, color: Colors.yellowAccent, size: 32),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        trailing: ElevatedButton(
          onPressed: onBuy,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$cost', style: const TextStyle(color: Colors.black)),
              const SizedBox(width: 4),
              const Icon(Icons.diamond, size: 16, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeItem({required String id, required String name, required int cost, required Color color}) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: AppState.instance.ownedThemes,
      builder: (context, owned, _) {
        final bool isOwned = owned.contains(id);
        final bool isSelected = AppState.instance.currentThemeId.value == id;
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: Colors.white10,
          shape: isSelected ? RoundedRectangleBorder(side: BorderSide(color: color, width: 2), borderRadius: BorderRadius.circular(12)) : null,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: color),
            title: Text(name, style: TextStyle(color: isSelected ? color : Colors.white, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            trailing: isOwned
                ? (isSelected
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : ElevatedButton(
                        onPressed: () {
                          AppState.instance.setTheme(id);
                          setState(() {});
                        },
                        child: const Text('Usar'),
                      ))
                : ElevatedButton(
                    onPressed: () => _buyTheme(id, cost),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$cost', style: const TextStyle(color: Colors.black)),
                        const SizedBox(width: 4),
                        const Icon(Icons.diamond, size: 16, color: Colors.black),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildPremiumItem() {
    // ... existing IAP logic wrapper ...
    if (_isLoading) return const CircularProgressIndicator();
    final bool hasProduct = _products.isNotEmpty;
    final String title = hasProduct ? _products.first.title : 'Eliminar Anuncios';
    final String price = hasProduct ? _products.first.price : '\$1.49';
    final VoidCallback? onBuy = (hasProduct && _isStoreAvailable) ? _buyProduct : null;

    return Card(
      color: Colors.white10,
      child: ListTile(
        leading: const Icon(Icons.block, color: Colors.redAccent, size: 32),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: const Text('Elimina la publicidad para siempre', style: TextStyle(color: Colors.white70)),
        trailing: ElevatedButton(
          onPressed: onBuy,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          child: Text(price, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }

  Future<void> _buyHints(int amount, int cost) async {
    final success = await AppState.instance.spendDiamonds(cost);
    if (success) {
      await AppState.instance.addHint(amount);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('¡Pistas compradas!')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No tienes suficientes diamantes')));
      }
    }
  }

  Future<void> _buyTheme(String id, int cost) async {
    final success = await AppState.instance.spendDiamonds(cost);
    if (success) {
      await AppState.instance.buyTheme(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('¡Tema desbloqueado!')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No tienes suficientes diamantes')));
      }
    }
  }
}

