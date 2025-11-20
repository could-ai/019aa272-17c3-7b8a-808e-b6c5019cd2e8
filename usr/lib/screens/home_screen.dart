import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // ডামি ডেটা - ফিচার তালিকা
  final List<Map<String, dynamic>> _features = [
    {'icon': Icons.analytics, 'title': 'বিশ্লেষণ', 'color': Colors.blue},
    {'icon': Icons.people, 'title': 'গ্রাহক', 'color': Colors.orange},
    {'icon': Icons.shopping_cart, 'title': 'অর্ডার', 'color': Colors.green},
    {'icon': Icons.inventory, 'title': 'স্টক', 'color': Colors.purple},
    {'icon': Icons.notifications, 'title': 'নোটিফিকেশন', 'color': Colors.red},
    {'icon': Icons.settings, 'title': 'সেটিংস', 'color': Colors.grey},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ডজ ড্যাশবোর্ড'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // সার্চ অ্যাকশন
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // মেনু অ্যাকশন
            },
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? _buildDashboard()
          : Center(
              child: Text(
                'পাতা ${_selectedIndex + 1} শীঘ্রই আসছে',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'হোম',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'এক্সপ্লোর',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'প্রোফাইল',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // নতুন কিছু যোগ করার অ্যাকশন
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // স্বাগতম কার্ড
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.deepPurple.shade50,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'স্বাগতম!',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'আপনার অ্যাপের ড্যাশবোর্ডে আপনাকে স্বাগতম। এখান থেকে আপনি সবকিছু নিয়ন্ত্রণ করতে পারবেন।',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.rocket_launch,
                    size: 48,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // সেকশন টাইটেল
          Text(
            'ফিচারসমূহ',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),

          // গ্রিড মেনু
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            itemCount: _features.length,
            itemBuilder: (context, index) {
              final item = _features[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item['title']} ক্লিক করা হয়েছে')),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (item['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          size: 32,
                          color: item['color'] as Color,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
