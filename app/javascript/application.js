// Entry point for the build script in your package.json
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false

import './src/jquery'
import './src/adminlte.js'

import "./controllers"
import * as bootstrap from "bootstrap"

import './src/bootstrap_custom.js'

import 'overlayscrollbars/js/jquery.overlayScrollbars'