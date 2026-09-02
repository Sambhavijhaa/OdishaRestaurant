CREATE TABLE IF NOT EXISTS menu_items (
  id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  description TEXT DEFAULT '',
  price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
  category VARCHAR(30) NOT NULL,
  image_url TEXT DEFAULT '',
  available BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  phone VARCHAR(30) NOT NULL UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  total NUMERIC(10,2) NOT NULL DEFAULT 0,
  status VARCHAR(30) NOT NULL DEFAULT 'Pending',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  menu_item_id INTEGER REFERENCES menu_items(id) ON DELETE SET NULL,
  item_name VARCHAR(120) NOT NULL,
  quantity INTEGER NOT NULL CHECK (quantity > 0),
  price NUMERIC(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS opening_hours (
  id SERIAL PRIMARY KEY,
  day_name VARCHAR(20) NOT NULL UNIQUE,
  open_time TIME,
  close_time TIME,
  is_closed BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS feedback (
  id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(160) NOT NULL,
  phone VARCHAR(30) NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO opening_hours (day_name, open_time, close_time)
VALUES
('Monday','11:00','22:30'),('Tuesday','11:00','22:30'),('Wednesday','11:00','22:30'),
('Thursday','11:00','22:30'),('Friday','11:00','22:30'),('Saturday','11:00','22:30'),('Sunday','11:00','22:30')
ON CONFLICT (day_name) DO NOTHING;

INSERT INTO menu_items (name, description, price, category, image_url)
VALUES
('Dalma','Traditional Odia lentils cooked with vegetables and raw papaya.',180,'veg',''),
('Pakhala Bhata','Traditional fermented rice served with delicious Odia sides.',150,'veg',''),
('Machha Besara','Fresh fish cooked in a traditional mustard-based Odia gravy.',280,'fish',''),
('Chicken Kosha','Slow-cooked chicken with aromatic spices and traditional flavors.',320,'chicken',''),
('Odia Mutton Curry','Tender mutton cooked with traditional Odia spices.',390,'mutton',''),
('Chhena Poda', 'Odisha''s famous caramelized cottage cheese dessert.',120,'dessert','')
ON CONFLICT DO NOTHING;
