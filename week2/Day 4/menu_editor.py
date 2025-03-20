from menu_item import MenuItem
from menu_manager import MenuManager

def show_user_menu():
    """Affiche le menu de l'utilisateur."""
    while True:
        print("\n--- Restaurant Menu Editor ---")
        print("V - View an Item")
        print("A - Add an Item")
        print("D - Delete an Item")
        print("U - Update an Item")
        print("S - Show the Menu")
        print("Q - Quit")
        choice = input("Choose an option: ").upper()

        if choice == "V":
            name = input("Enter the item name: ")
            item = MenuManager.get_by_name(name)
            if item:
                print(f"Item found: {item}")
            else:
                print("Item not found.")
        elif choice == "A":
            add_item_to_menu()
        elif choice == "D":
            remove_item_from_menu()
        elif choice == "U":
            update_item_from_menu()
        elif choice == "S":
            show_restaurant_menu()
        elif choice == "Q":
            show_restaurant_menu()
            print("Exiting the program...")
            break
        else:
            print("Invalid option. Please try again.")

def add_item_to_menu():
    """Ajoute un nouvel élément au menu."""
    name = input("Enter the item name: ")
    price = int(input("Enter the item price: "))
    item = MenuItem(name, price)
    item.save()

def remove_item_from_menu():
    """Supprime un élément du menu."""
    name = input("Enter the item name to delete: ")
    item = MenuItem(name, 0)  # Price is irrelevant for deletion
    item.delete()

def update_item_from_menu():
    """Met à jour un élément du menu."""
    name = input("Enter the item name to update: ")
    new_name = input("Enter the new name: ")
    new_price = int(input("Enter the new price: "))
    item = MenuItem(name, 0)  # Price is irrelevant for update
    item.update(new_name, new_price)

def show_restaurant_menu():
    """Affiche tous les éléments du menu."""
    items = MenuManager.all_items()
    if items:
        print("\n--- Restaurant Menu ---")
        for item in items:
            print(f"{item[1]} - ${item[2]}")
    else:
        print("No items in the menu.")

if __name__ == "__main__":
    show_user_menu()