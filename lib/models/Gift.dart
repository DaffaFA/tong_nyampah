class Gift {
  final String image;
  final String name;
  final int point;
  final String description;

  Gift({this.image, this.name, this.point, this.description});

  static List<Gift> getAllGift() {
    return <Gift>[
      Gift(
        name: 'Backpack',
        image:
            'https://target.scene7.com/is/image/Target/GUEST_175d6caf-9aeb-4a80-af84-58857a7723c4?wid=488&hei=488&fmt=pjpeg',
        point: 1000,
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      ),
      Gift(
        name: 'Sneaker',
        image:
            'https://www.famousfootwear.com/ProductImages/shoes_ia30215.jpg?trim.threshold=105&width=600&height=350&paddingWidth=40&anchor=bottomcenter',
        point: 3500,
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      ),
      Gift(
        name: 'Tumbler',
        image:
            'https://www.stevehandmade.com/wp-content/uploads/2019/02/TM0318-BLACK-600x600.jpg',
        point: 500,
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      ),
    ];
  }
}
