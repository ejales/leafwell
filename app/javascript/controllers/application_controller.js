import { Controller } from "@hotwired/stimulus"

import toastr from 'toastr'

// Connects to data-controller="application"
export default class extends Controller {
  connect() {
    $('[data-toggle="tooltip"]').tooltip()

    // select tab and put in on url
    let hash = window.location.hash
    hash && $('ul.nav a[href="' + hash + '"]').tab('show')

    $('.nav-pills a').on('click', function (e) {
      $(this).tab('show')
      let scrollmem = $('body').scrollTop() || $('html').scrollTop()
      window.location.hash = this.hash
      $('html,body').scrollTop(scrollmem)
    })
  }
}
