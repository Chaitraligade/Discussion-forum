// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
//import "controllers"

import { Turbo } from "@hotwired/turbo-rails";
Turbo.session.drive = false;
import "channels"  // Ensure this is correctly included
import { createConsumer } from "@rails/actioncable";

export default createConsumer();

import "controllers";