package model;

import java.time.LocalDate;
import java.time.LocalTime;

public class History {

    private final String name;
    private final String operation;
    private final int amount;
    private final LocalTime time;
    private final LocalDate date;


    private History(Builder builder) {
        this.name = builder.name;
        this.operation = builder.operation;
        this.amount = builder.amount;
        this.time = builder.time;
        this.date = builder.date;
    }

    @Override
    public String toString() {
        return "History{" +
                "  name = '" + name + "'\n" +
                "  operation = '" + operation + "'\n" +
                "  amount = " + amount + "\n" +
                "  time = " + time.withNano(0) + "\n" +
                "  date = " + date + "\n" +
                "}";
    }

    public static class Builder {
        private String name;
        private String operation;
        private int amount;
        private LocalTime time;
        private LocalDate date;

        public Builder setName(String name) {
            this.name = name;
            return this;
        }

        public Builder setOperation(String operation) {
            this.operation = operation;
            return this;
        }

        public Builder setAmount(int amount) {
            this.amount = amount;
            return this;
        }

        public Builder setTime(LocalTime time) {
            this.time = time;
            return this;
        }

        public Builder setDate(LocalDate date) {
            this.date = date;
            return this;
        }

        public History build() {
            return new History(this);
        }

    }
}