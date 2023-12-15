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
                    <h5 class="card-title">Nilai Vektor</h5>
                    <!-- Table with stripped rows -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>V</th>
                                <th>#</th>
                                <th>Hasil</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $no = 0;
                            foreach ($dataMahasiswa as $rowMahasiswa) : $no++; ?>
                                <tr>
                                    <td><?= $no; ?></td>
                                    <th>
                                        <?php
                                        $a = $rowMahasiswa->kode_alternatif;
                                        $number = substr($a, 1);
                                        echo "V<sub>" . $number . "</sub>";
                                        ?>
                                    </th>
                                    <td><?= $hasilSkor[$no - 1]; ?><sub>/<?= $totalSkor; ?></sub></td>
                                    <td><?= $hasilVektor[$no - 1]; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <!-- End Table with stripped rows -->
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Ranking</h5>
                    <!-- Table with stripped rows -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>A</th>
                                <th>Nama Mahasiswa</th>
                                <th>Nilai V</th>
                                <th>Keterangan</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $no = 0;
                            foreach ($rankings as $rowRankings) : $no++; ?>
                                <tr>
                                    <td><?= $no; ?></td>
                                    <th>
                                        <?php
                                        $a = $rowRankings['kode_alternatif'];
                                        $number = substr($a, 1);
                                        echo "A<sub>" . $number . "</sub>";
                                        ?>
                                    </th>
                                    <td><?= $rowRankings['nama']; ?></td>
                                    <td><?= $rowRankings['hasilVektor']; ?></td>
                                    <td>Ranking <?= $no; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <!-- End Table with stripped rows -->
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Modal Hapus -->
<div class="modal fade" id="modalHapus" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Yakin ingin menghapus data ini?</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form>
                <div class="modal-body row g-3">
                    <!-- Vertical Form -->
                    <input type="hidden" class="form-control" id="id" name="id">
                    <div class="col-12">
                        <label for="kriteria_penilaian" class="form-label">Kriteria Penilaian</label>
                        <input type="text" class="form-control" id="kriteria_penilaian" name="kriteria_penilaian" value="1" disabled>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-danger">Hapus</button>
                </div>
            </form><!-- Vertical Form -->
        </div>
    </div>
</div><!-- End Basic Modal-->