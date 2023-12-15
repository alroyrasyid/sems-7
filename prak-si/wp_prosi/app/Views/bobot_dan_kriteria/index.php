<div class="pagetitle">
    <h1><?= $title; ?></h1>
    <nav class="d-flex justify-content-end">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<?= base_url(); ?>">Home</a></li>
            <li class="breadcrumb-item active"><?= $title; ?></li>
        </ol>
    </nav>
</div><!-- End Page Title -->

<section class="section">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Normalisasi Bobot</h5>
                    <!-- Table with stripped rows -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>W</th>
                                <th>#</th>
                                <th>#</th>
                                <th>Hasil</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $no = 0;
                            foreach ($dataKriteria as $kriteria) : $no++
                            ?>
                                <tr>
                                    <td><?= $no; ?></td>
                                    <th>W<sub><?= $no; ?></sub></th>
                                    <td>
                                        <?= $kriteria->nilai_bobot; ?>
                                        <sub>/
                                            <?php
                                            foreach ($dataKriteria as $key => $kriteria2) {
                                                echo $kriteria2->nilai_bobot;
                                                if ($kriteria2 !== end($dataKriteria)) {
                                                    echo '+';
                                                }
                                            }
                                            ?>
                                        </sub>
                                    </td>
                                    <td>
                                        <?= $kriteria->nilai_bobot; ?>
                                        <sub>/
                                            <?= $totalBobot; ?>
                                        </sub>
                                    </td>
                                    <td><?= $hasilNormalisasiBobot[$no - 1]; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <!-- End Table with stripped rows -->
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Hasil Normalisasi Bobot</h5>
                    <!-- Table with stripped rows -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Kriteria</th>
                                <th>Bobot (sebelum)</th>
                                <th>Bobot (sesudah)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $no = 0;
                            foreach ($dataKriteria as $kriteria) : $no++
                            ?>
                                <tr>
                                    <td><?= $no; ?></td>
                                    <td><?= $kriteria->kriteria; ?></td>
                                    <td><?= $kriteria->nilai_bobot; ?></td>
                                    <td><?= $hasilNormalisasiBobot[$no - 1]; ?></td>
                                </tr>
                            <?php endforeach; ?>
                            <tr>
                                <th colspan="2">Total</th>
                                <th><?= $totalBobot; ?></th>
                                <th><?= $totalBobotNormalisasi; ?></th>
                            </tr>
                        </tbody>
                    </table>
                    <!-- End Table with stripped rows -->
                </div>
            </div>
        </div>
    </div>
</section>