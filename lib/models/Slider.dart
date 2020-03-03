class SliderItem {
  final String name;
  final String description;
  final String image;
  final int point;

  SliderItem({this.name, this.description, this.image, this.point});

  static List<SliderItem> fetchAllSliderItem() {
    return [
      SliderItem(
          name: 'Sneaker',
          image:
              'https://images.unsplash.com/photo-1509418969973-c560ee8f02a0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1164&q=80',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          point: 120),
      SliderItem(
          name: 'Sneaker',
          image:
              'https://images.unsplash.com/photo-1509418969973-c560ee8f02a0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1164&q=80',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          point: 120),
      SliderItem(
          name: 'Sneaker',
          image:
              'https://images.unsplash.com/photo-1509418969973-c560ee8f02a0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1164&q=80',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          point: 120),
    ];
  }
}
