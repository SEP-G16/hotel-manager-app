enum Role{
  ROLE_ADMIN, ROLE_HOTEL_MANAGER, ROLE_RESTAURANT_MANAGER, ROLE_CHEF, ROLE_FRONT_DESK;

  static Role fromString(String role){
    switch(role){
      case 'ADMIN':
        return Role.ROLE_ADMIN;
      case 'HOTEL_MANAGER':
        return Role.ROLE_HOTEL_MANAGER;
      case 'RESTAURANT_MANAGER':
        return Role.ROLE_RESTAURANT_MANAGER;
      case 'CHEF':
        return Role.ROLE_CHEF;
      case 'FRONT_DESK':
        return Role.ROLE_FRONT_DESK;
      default:
        throw Exception('Role not found');
    }
  }
}