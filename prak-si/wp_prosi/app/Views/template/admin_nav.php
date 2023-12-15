  <body>
      <div class="preloader-container">
          <div class="preloader">
              <img src="img/prosi/uin_logo.png">
          </div>
      </div>
      <!-- ======= Header ======= -->
      <header id="header" class="header fixed-top d-flex align-items-center">

          <div class="d-flex align-items-center justify-content-between">
              <a href="<?= base_url(); ?>" class="logo d-flex align-items-center">
                  <img src="img/prosi/uin_logo.png" alt="">
                  <span class="d-none d-lg-block ps-2">TI UIN Malang</span>
              </a>
              <i class="bi bi-list toggle-sidebar-btn"></i>
          </div><!-- End Logo -->

      </header><!-- End Header -->

      <!-- ======= Sidebar ======= -->
      <aside id="sidebar" class="sidebar">

          <ul class="sidebar-nav pb-5" id="sidebar-nav">

              <li class="nav-heading">Informasi</li>
              <li class="nav-item">
                  <a class="nav-link collapsed" href="<?= base_url(); ?>" id="home">
                      <i class="bi bi-question-circle"></i>
                      <span>Kelompok dan Kredit</span>
                  </a>
              </li><!-- End Profile Page Nav -->

              <li class="nav-heading">Paper</li>
              <li class="nav-item">
                  <a class="nav-link collapsed" href="<?= base_url('review'); ?>" id="review">
                      <i class="bi bi-gem"></i>
                      <span>Review</span>
                  </a>
              </li><!-- End Profile Page Nav -->

              <li class="nav-heading">Menentukan kriteria</li>
              <li class="nav-item">
                  <a class="nav-link collapsed" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
                      <i class="bi bi-menu-button-wide"></i><span>Master Data</span><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul id="components-nav" class="nav-content collapse show" data-bs-parent="#sidebar-nav">
                      <li>
                          <a href="<?= base_url('tingkat_bobot_kriteria'); ?>">
                              <i class="bi bi-circle"></i><span class="" id="tingkat_bobot_kriteria">Tingkat Bobot Kriteria</span>
                          </a>
                      </li>
                      <li>
                          <a href="<?= base_url('kriteria'); ?>">
                              <i class="bi bi-circle"></i><span class="" id="kriteria">Kriteria</span>
                          </a>
                      </li>
                      <li>
                          <a href="<?= base_url('subkriteria'); ?>">
                              <i class="bi bi-circle"></i><span class="" id="subkriteria">Subkriteria</span>
                          </a>
                      </li>
                      <li>
                          <a href="<?= base_url('mahasiswa'); ?>">
                              <i class="bi bi-circle"></i><span class="" id="mahasiswa">Mahasiswa</span>
                          </a>
                      </li>
                  </ul>
              </li><!-- End Components Nav -->

              <li class="nav-heading">Menghitung perbaikan bobot</li>
              <li class="nav-item">
                  <a class="nav-link collapsed" href="<?= base_url('bobot_dan_kriteria'); ?>" id="bobot_dan_kriteria">
                      <i class="bi bi-journal-text"></i>
                      <span>Bobot dan Kriteria</span>
                  </a>
              </li><!-- End Profile Page Nav -->

              <li class="nav-heading">Menghitung nilai skor</li>
              <li class="nav-item">
                  <a class="nav-link collapsed" href="<?= base_url('konversi_nilai'); ?>" id="konversi_nilai">
                      <i class="bi bi-layout-text-window-reverse"></i>
                      <span>Konversi Nilai Data Mahasiswa</span>
                  </a>
              </li><!-- End Profile Page Nav -->

              <li class="nav-heading">Menghitung nilai vektor</li>
              <li class="nav-item">
                  <a class="nav-link collapsed" href="<?= base_url('perankingan_wp'); ?>" id="perankingan_wp">
                      <i class="bi bi-bar-chart"></i>
                      <span>Perankingan WP</span>
                  </a>
              </li><!-- End Profile Page Nav -->

          </ul>

      </aside><!-- End Sidebar-->

      <main id="main" class="main">