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
    <?php if (session()->has('header_success')) : ?>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <?= session()->getFlashdata('header_success') ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <?php endif; ?>

    <?php if (session()->has('header_error')) : ?>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <?= session()->getFlashdata('header_error') ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <?php endif; ?>
    <div class="row">
        <div class="col-lg-12">

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Data Alternatif</h5>
                    <!-- Table with stripped rows -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th rowspan="2">No.</th>
                                <th rowspan="2">A</th>
                                <th colspan="<?= $jumlahKriteria['jumlah']; ?>">
                                    Kriteria
                                </th>
                                <th rowspan="2">Aksi</th>
                            </tr>
                            <tr>
                                <?php
                                for ($i = 0; $i < $jumlahKriteria['jumlah']; $i++) : ?>
                                    <th>C<sub><?= $i + 1; ?></sub></th>
                                <?php endfor; ?>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $no = 0;
                            foreach ($dataMahasiswa as $rowMahasiswa) : $no++;
                            ?>
                                <tr>
                                    <td><?= $no; ?></td>
                                    <th>
                                        <?php
                                        $a = $rowMahasiswa->kode_alternatif;
                                        $number = substr($a, 1);
                                        echo "A<sub>" . $number . "</sub>";
                                        ?>
                                    </th>
                                    <?php foreach ($dataKriteria as $rowDataKriteria) : ?>
                                        <?php $found = false; ?>
                                        <?php foreach ($dataKonversiNilai as $rowKonversiNilai) : ?>
                                            <?php if ($rowKonversiNilai->alternatif == $rowMahasiswa->id && $rowKonversiNilai->kriteria_subkriteria == $rowDataKriteria->id) : ?>
                                                <td><?= $rowKonversiNilai->skot_tingkat_bobot_kriteria; ?></td>
                                                <?php $found = true; ?>
                                            <?php endif; ?>
                                        <?php endforeach; ?>
                                        <?php if (!$found) : ?>
                                            <td></td>
                                        <?php endif; ?>
                                    <?php endforeach; ?>
                                    <td>
                                        <a href="<?= base_url($controller . '/edit//' . $rowMahasiswa->id) ?>"><span class="badge bg-secondary">Edit</span></a>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <!-- End Table with stripped rows -->
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Bobot</h5>
                    <!-- Table with stripped rows -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th></th>
                                <?php
                                $no = 0;
                                foreach ($dataKriteria as $rowKriteria) : $no++; ?>
                                    <th>W<sub><?= $no; ?></sub></th>
                                <?php endforeach; ?>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>W</th>
                                <?php
                                foreach ($hasilNormalisasiBobot as $rowBobot) : ?>
                                    <td><?= $rowBobot; ?></td>
                                <?php endforeach; ?>
                            </tr>
                            <tr>
                                <th>Ket.</th>
                                <?php
                                foreach ($dataKriteria as $rowKriteria) : ?>
                                    <td><?= $rowKriteria->keterangan; ?></td>
                                <?php endforeach; ?>
                            </tr>
                        </tbody>
                    </table>
                    <!-- End Table with stripped rows -->
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Skor Alternatif</h5>
                    <!-- Table with stripped rows -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>S</th>
                                <th>#</th>
                                <th>Hasil</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $no = 0;
                            foreach ($dataMahasiswa as $rowMahasiswa) : $no++;
                            ?>
                                <tr>
                                    <td><?= $no; ?></td>
                                    <th>
                                        <?php
                                        $a = $rowMahasiswa->kode_alternatif;
                                        $number = substr($a, 1);
                                        echo "S<sub>" . $number . "</sub>";
                                        ?>
                                    </th>
                                    <td>
                                        <?php
                                        $noBobot = 0;
                                        foreach ($dataKriteria as $rowDataKriteria) : $noBobot++;
                                            foreach ($dataKonversiNilai as $rowKonversiNilai) :
                                                if ($rowKonversiNilai->alternatif == $rowMahasiswa->id && $rowKonversiNilai->kriteria_subkriteria == $rowDataKriteria->id) :
                                                    echo $rowKonversiNilai->skot_tingkat_bobot_kriteria;
                                                    if ($rowDataKriteria->keterangan == 'Cost') {
                                                        echo "<sup>-" .
                                                            $hasilNormalisasiBobot[$noBobot - 1] . "</sup>";
                                                    } else {
                                                        echo "<sup>" .
                                                            $hasilNormalisasiBobot[$noBobot - 1] . "</sup>";
                                                    }
                                                    if ($rowDataKriteria !== end($dataKriteria)) {
                                                        echo '*';
                                                    }
                                                endif;
                                            endforeach;
                                        endforeach;
                                        ?>
                                    </td>
                                    <td><?= $hasilSkor[$no - 1]; ?></td>
                                </tr>
                            <?php endforeach; ?>
                            <tr>
                                <th colspan="3">Total</th>
                                <th><?= $totalSkor; ?></th>
                            </tr>
                        </tbody>
                    </table>
                    <!-- End Table with stripped rows -->
                </div>
            </div>
        </div>
    </div>
</section>