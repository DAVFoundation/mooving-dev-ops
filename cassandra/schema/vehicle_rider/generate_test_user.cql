

INSERT INTO vehicle_rider.riders ("id", "phone_number", "phone_confirmed") VALUES (ffffffff-ffff-ffff-ffff-ffffffffffff, '+972500000000', true);

INSERT INTO vehicle_rider.vehicles (
  "id",
  "battery_percentage",
  "model",
  "status",
  "vehicle_name",
  "qr_code",
  "owner_id",
  "base_price",
  "price_per_minute",
  "geo_hash",
  "geo_hash_4",
  "geo_hash_5",
  "geo_hash_6",
  "geo_hash_7",
  "geo_hash_8",
  "operator_name",
  "in_transition"
)
VALUES (ffffffff-ffff-ffff-ffff-ffffffffffff,
  100,
  'Test Scooter',
  'available',
  'Test',
  '000000',
  ffffffff-ffff-ffff-ffff-ffffffffffff,
  1,
  1,
  's00000000',
  's000',
  's0000',
  's00000',
  's000000',
  's0000000',
  'Test Manager',
  false
  );

INSERT INTO vehicle_rider.owners (
 "id",
 "commission_factor",
 "email",
 "eth_addr",
 "fiat_currency_code",
 "first_name",
 "last_name",
 "payment_dav_factor",
 "phone_confirmed",
 "phone_number",
 "pricing_using_fiat",
 "private_key",
 "profile_image_id",
 "vendor_id",
 "company_name"
)
VALUES (
  ffffffff-ffff-ffff-ffff-ffffffffffff,
  0.1,
  'test@dav.network',
  '0x0',
  'USD',
  'Test',
  'Test',
  0,
  True,
  '+972500000000',
  True,
  null,
  null,
  'vendorId',
  'Test Manager'
);
