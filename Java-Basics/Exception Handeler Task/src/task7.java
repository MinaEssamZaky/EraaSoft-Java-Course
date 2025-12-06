class InvalidAgeException extends Exception {
    public InvalidAgeException(String message) {
        super(message);
    }
}

class CheckAge {
    public static void checkAge(int age) throws InvalidAgeException {

        if (age < 18) {
            throw new InvalidAgeException("Age is less than 18 — Access Denied.");
        }

        System.out.println("Age is valid. Welcome!");
    }
}
