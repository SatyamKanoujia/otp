const express = require('express');
const auth = require('./middlewares/auth');
const errors = require('./middlewares/errors');
const userRoutes = require('./routes/users.routes');
const app = express();

app.use(express.json());

app.use("/users", userRoutes);

app.use(errors.errorHandler);

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}!`);
});
