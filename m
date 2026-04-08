Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D63D6472
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661066; cv=none; b=Vu0sXjFPJ3iH25c1W5YfDGRAn9nq5LPxXdZ6fPuVsnZ8DaNMnBrsjTCA8CakaqKxSul9Mzj+Cy5bj3UNSCpxoBKTEmv68k+8jQHAr/rqA1O2woeGRaOuPVDUmwNS+/p4vyMIcK2rGYQRsB4Y8k5yYD+C9tsKOjWu+5qFS9rSmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661066; c=relaxed/simple;
	bh=05WceFQ+jlbO7VwEhw0CqNyOmEz1Dd8qlLfHdIjrZDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9fsxyG5fPAZwrp8UPLp04NHv7ABjUeNiyMbU5FC2KkK5VVvtmexC0e/t1vsREBcydc8Fxj1XzDJh8j5bDvRQkkqA7H47V8rcH4PDT5rYziPa4UFqpSfLUx7HQn/kglqld2Zr1JRKeqQevL/vdjj1fUQ2bfCJVFiTFITSi+I1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iABrgjoC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iABrgjoC"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso52514265e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661063; x=1776265863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWVI8GJE/Hda6mIp0wO6UoZeAPQCbTkS/zx/jdQFdls=;
        b=iABrgjoCPi4mNmMy7AWWOgtxidNVYIl7vKf3svRSNTbVq2+nwKIELt8pz70Mc1eUjq
         7tu6lCZQdliT+pO+dfVSl9ktwW2P6QadpQzjbyggvZxzk2yYGVlCnoVH01HVfev2AZWt
         f12qViciltOubOPr7/WbekkQBQTLKlcP7ZgA/fS6LBVii0IxXYQayJQpmVlE00QF0ZUG
         Su/gNZaA/fnvkq+510A72V2xBAnSqYKvmmrrsXOz31t+1RyW8Wmpo0ARfU2DNibBmTkj
         Rktf2KeufEjp1kO6wqvhnWRXl4YfrW10ttKN4E3nG/qnpeqsbog9WOA7i60YA0OQMOHf
         nIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661063; x=1776265863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SWVI8GJE/Hda6mIp0wO6UoZeAPQCbTkS/zx/jdQFdls=;
        b=Rl2+bYby2C5cU09ZZDHouho2zjo3tVsXrSFsNH635HEJPFxdjRAyVN1I+Hisnl5/a9
         YZUQXHleO4zDwOCKdDNyRO1shmB0nIrbqqzYgbASV6Z3KHNoovAqJZT1otZAgSQp4wxd
         2hb/hADX2FB536NPEqzL7rNKCVQFo8pa28Gt0+AONI3nFYCRp/ahYjZDFVT5wKKKWe90
         Xwh6gCreVo9q/2wxg9/NM7wnJxsCph0QNI87xEKhkVEFo6qubBfHvzPSq9164Ok7t3NI
         dbzWRYTRL+hRN5OFkHc2rpOynVG3zBmhTbmPV5GEC9ctd12s4UFWO6iqmXaWy+llTA61
         wy5Q==
X-Gm-Message-State: AOJu0YwB5jGy/TMbNzYBtWMA427vqJuAon65mTbJekpM9FbZ+ngQKGeq
	FYUaa+BimZhle3Y+ytSPyNzehpFuD0tfBQQEYTxYDtvX7khGPjCXI1wZ
X-Gm-Gg: AeBDieuYVcwKyZ1iE8KQmzzfphD1HpluaRHUG07llcQsYorfLVpSAOlvr4OOxr5aLqa
	o/f7KgYM3dUbjNYCe9M+ALCJefS3QjCob1VLzGBEbFT0O1VsxWaMzl3BUI0kuQN7utfxHSZ/UEC
	h9m/m7mP+ZxgXJDaDaLFMJfQFusApLtpZ4+0FfcjgnDvWP37yyTAZJUdfSjAY9TcRMagpxT3PeN
	msoVEd92c/+iKfCmtJCzzPPNmeWkUOkrJO+GozXII8mfsvN0OdDwLbkycFQxtudBLM/7PilhXzD
	8wmgkuee3RzgRSmvIgVJnWjP6L/JJEOSVRMhXYc1m6zwAOhwpQdujJmt6BSVtiilw6/1xtF1eEY
	cs/hGtZhlRmSkqhCMhDeSdckTQDLV8y3ulPzosWcvjU5b/Tf/L/JBCFfGiqksx6V3JaiS0BZXoq
	9Q+8t5ADLR8F5AKg==
X-Received: by 2002:a05:600c:1396:b0:487:338:b4f3 with SMTP id 5b1f17b1804b1-488997d1371mr300846845e9.17.1775661063435;
        Wed, 08 Apr 2026 08:11:03 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:46::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm436595285e9.12.2026.04.08.08.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:11:02 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:23 -0700
Subject: [PATCH RFC bpf-next v2 18/18] selftests/bpf: Add resizable hashmap
 to benchmarks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-rhash-v2-18-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=11603;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=QsAZqfMI2X3o+6Y9FeoQn73+3WLcWjKyYsZ6ifpRo4Y=;
 b=AlBD0NHmEx0sG2ib9onJwmBn0gOgl46ng0EHQ7UqusAhpzwy2iN0hG1AhbnKYcfxpvt4DCgOw
 g7VoRKDxOTtDYw5cMd0SlTMCAXnOOTI6rkO4KHbV4NZNjpL0M6eNrGc
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Support resizable hashmap in BPF map benchmarks.

Results:
$ sudo ./bench -w3 -d10 -a bpf-rhashmap-full-update
0:hash_map_full_perf 21641414 events per sec

$ sudo ./bench -w3 -d10 -a bpf-hashmap-full-update
0:hash_map_full_perf 4392758 events per sec

$ sudo ./bench -w3 -d10 -a -p8 htab-mem --use-case overwrite --value-size 8
Iter   0 (302.834us): per-prod-op   62.85k/s, memory usage    2.70MiB
Iter   1 (-44.810us): per-prod-op   62.81k/s, memory usage    2.70MiB
Iter   2 (-45.821us): per-prod-op   62.81k/s, memory usage    2.70MiB
Iter   3 (-63.658us): per-prod-op   62.92k/s, memory usage    2.70MiB
Iter   4 ( 32.887us): per-prod-op   62.85k/s, memory usage    2.70MiB
Iter   5 (-76.948us): per-prod-op   62.75k/s, memory usage    2.70MiB
Iter   6 (157.235us): per-prod-op   63.01k/s, memory usage    2.70MiB
Iter   7 (-118.761us): per-prod-op   62.85k/s, memory usage    2.70MiB
Iter   8 (127.139us): per-prod-op   62.92k/s, memory usage    2.70MiB
Iter   9 (-169.908us): per-prod-op   62.99k/s, memory usage    2.70MiB
Iter  10 (101.962us): per-prod-op   62.97k/s, memory usage    2.70MiB
Iter  11 (-64.330us): per-prod-op   63.05k/s, memory usage    2.70MiB
Iter  12 (-20.543us): per-prod-op   62.86k/s, memory usage    2.70MiB
Iter  13 ( 55.382us): per-prod-op   62.95k/s, memory usage    2.70MiB
Summary: per-prod-op   62.92 ±    0.09k/s, memory usage    2.70 ±    0.00MiB, peak memory usage    2.96MiB

$ sudo ./bench -w3 -d10 -a -p8 rhtab-mem --use-case overwrite --value-size 8
Iter   0 (316.805us): per-prod-op   96.40k/s, memory usage    2.71MiB
Iter   1 (-35.225us): per-prod-op   96.54k/s, memory usage    2.71MiB
Iter   2 (-12.431us): per-prod-op   96.54k/s, memory usage    2.71MiB
Iter   3 (-56.537us): per-prod-op   96.58k/s, memory usage    2.71MiB
Iter   4 ( 27.108us): per-prod-op   96.62k/s, memory usage    2.71MiB
Iter   5 (-52.491us): per-prod-op   96.57k/s, memory usage    2.71MiB
Iter   6 ( -2.777us): per-prod-op   96.52k/s, memory usage    2.71MiB
Iter   7 (108.963us): per-prod-op   96.45k/s, memory usage    2.71MiB
Iter   8 (-61.575us): per-prod-op   96.48k/s, memory usage    2.71MiB
Iter   9 (-21.595us): per-prod-op   96.14k/s, memory usage    2.71MiB
Iter  10 (  3.243us): per-prod-op   96.36k/s, memory usage    2.71MiB
Iter  11 (  3.102us): per-prod-op   94.70k/s, memory usage    2.71MiB
Iter  12 (109.102us): per-prod-op   95.77k/s, memory usage    2.71MiB
Iter  13 ( 16.153us): per-prod-op   95.91k/s, memory usage    2.71MiB
Summary: per-prod-op   96.19 ±    0.57k/s, memory usage    2.71 ±    0.00MiB, peak memory usage    2.71MiB

sudo ./bench -w3 -d10 -a bpf-hashmap-lookup --key_size 4\
  --max_entries 1000 --nr_entries 500 --nr_loops 1000000
cpu00: lookup 28.603M ± 0.536M events/sec (approximated from 32 samples of ~34ms)

sudo ./bench -w3 -d10 -a bpf-rhashmap-lookup --key_size 4\
  --max_entries 1000 --nr_entries 500 --nr_loops 1000000
cpu00: lookup 27.340M ± 0.864M events/sec (approximated from 32 samples of ~36ms)

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/bench.c                |  6 ++++
 .../bpf/benchs/bench_bpf_hashmap_full_update.c     | 34 +++++++++++++++++++--
 .../bpf/benchs/bench_bpf_hashmap_lookup.c          | 31 +++++++++++++++++--
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  | 35 ++++++++++++++++++++--
 4 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 029b3e21f438..722877c00e8b 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -558,13 +558,16 @@ extern const struct bench bench_bpf_loop;
 extern const struct bench bench_strncmp_no_helper;
 extern const struct bench bench_strncmp_helper;
 extern const struct bench bench_bpf_hashmap_full_update;
+extern const struct bench bench_bpf_rhashmap_full_update;
 extern const struct bench bench_local_storage_cache_seq_get;
 extern const struct bench bench_local_storage_cache_interleaved_get;
 extern const struct bench bench_local_storage_cache_hashmap_control;
 extern const struct bench bench_local_storage_tasks_trace;
 extern const struct bench bench_bpf_hashmap_lookup;
+extern const struct bench bench_bpf_rhashmap_lookup;
 extern const struct bench bench_local_storage_create;
 extern const struct bench bench_htab_mem;
+extern const struct bench bench_rhtab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
 extern const struct bench bench_sockmap;
@@ -636,13 +639,16 @@ static const struct bench *benchs[] = {
 	&bench_strncmp_no_helper,
 	&bench_strncmp_helper,
 	&bench_bpf_hashmap_full_update,
+	&bench_bpf_rhashmap_full_update,
 	&bench_local_storage_cache_seq_get,
 	&bench_local_storage_cache_interleaved_get,
 	&bench_local_storage_cache_hashmap_control,
 	&bench_local_storage_tasks_trace,
 	&bench_bpf_hashmap_lookup,
+	&bench_bpf_rhashmap_lookup,
 	&bench_local_storage_create,
 	&bench_htab_mem,
+	&bench_rhtab_mem,
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
 	&bench_sockmap,
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
index ee1dc12c5e5e..7278fa860397 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
@@ -34,19 +34,29 @@ static void measure(struct bench_res *res)
 {
 }
 
-static void setup(void)
+static void hashmap_full_update_setup(enum bpf_map_type map_type)
 {
 	struct bpf_link *link;
 	int map_fd, i, max_entries;
 
 	setup_libbpf();
 
-	ctx.skel = bpf_hashmap_full_update_bench__open_and_load();
+	ctx.skel = bpf_hashmap_full_update_bench__open();
 	if (!ctx.skel) {
 		fprintf(stderr, "failed to open skeleton\n");
 		exit(1);
 	}
 
+	bpf_map__set_type(ctx.skel->maps.hash_map_bench, map_type);
+	if (map_type == BPF_MAP_TYPE_RHASH)
+		bpf_map__set_map_flags(ctx.skel->maps.hash_map_bench,
+				       BPF_F_NO_PREALLOC);
+
+	if (bpf_hashmap_full_update_bench__load(ctx.skel)) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
 	ctx.skel->bss->nr_loops = MAX_LOOP_NUM;
 
 	link = bpf_program__attach(ctx.skel->progs.benchmark);
@@ -62,6 +72,16 @@ static void setup(void)
 		bpf_map_update_elem(map_fd, &i, &i, BPF_ANY);
 }
 
+static void setup(void)
+{
+	hashmap_full_update_setup(BPF_MAP_TYPE_HASH);
+}
+
+static void rhash_setup(void)
+{
+	hashmap_full_update_setup(BPF_MAP_TYPE_RHASH);
+}
+
 static void hashmap_report_final(struct bench_res res[], int res_cnt)
 {
 	unsigned int nr_cpus = bpf_num_possible_cpus();
@@ -87,3 +107,13 @@ const struct bench bench_bpf_hashmap_full_update = {
 	.report_progress = NULL,
 	.report_final = hashmap_report_final,
 };
+
+const struct bench bench_bpf_rhashmap_full_update = {
+	.name = "bpf-rhashmap-full-update",
+	.validate = validate,
+	.setup = rhash_setup,
+	.producer_thread = producer,
+	.measure = measure,
+	.report_progress = NULL,
+	.report_final = hashmap_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
index 279ff1b8b5b2..5264b7b20e39 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
@@ -148,9 +148,10 @@ static inline void patch_key(u32 i, u32 *key)
 	/* the rest of key is random */
 }
 
-static void setup(void)
+static void hashmap_lookup_setup(enum bpf_map_type map_type)
 {
 	struct bpf_link *link;
+	__u32 map_flags;
 	int map_fd;
 	int ret;
 	int i;
@@ -163,10 +164,15 @@ static void setup(void)
 		exit(1);
 	}
 
+	map_flags = args.map_flags;
+	if (map_type == BPF_MAP_TYPE_RHASH)
+		map_flags |= BPF_F_NO_PREALLOC;
+
+	bpf_map__set_type(ctx.skel->maps.hash_map_bench, map_type);
 	bpf_map__set_max_entries(ctx.skel->maps.hash_map_bench, args.max_entries);
 	bpf_map__set_key_size(ctx.skel->maps.hash_map_bench, args.key_size);
 	bpf_map__set_value_size(ctx.skel->maps.hash_map_bench, 8);
-	bpf_map__set_map_flags(ctx.skel->maps.hash_map_bench, args.map_flags);
+	bpf_map__set_map_flags(ctx.skel->maps.hash_map_bench, map_flags);
 
 	ctx.skel->bss->nr_entries = args.nr_entries;
 	ctx.skel->bss->nr_loops = args.nr_loops / args.nr_entries;
@@ -197,6 +203,16 @@ static void setup(void)
 	}
 }
 
+static void setup(void)
+{
+	hashmap_lookup_setup(BPF_MAP_TYPE_HASH);
+}
+
+static void rhash_setup(void)
+{
+	hashmap_lookup_setup(BPF_MAP_TYPE_RHASH);
+}
+
 static inline double events_from_time(u64 time)
 {
 	if (time)
@@ -275,3 +291,14 @@ const struct bench bench_bpf_hashmap_lookup = {
 	.report_progress = NULL,
 	.report_final = hashmap_report_final,
 };
+
+const struct bench bench_bpf_rhashmap_lookup = {
+	.name = "bpf-rhashmap-lookup",
+	.argp = &bench_hashmap_lookup_argp,
+	.validate = validate,
+	.setup = rhash_setup,
+	.producer_thread = producer,
+	.measure = measure,
+	.report_progress = NULL,
+	.report_final = hashmap_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
index 297e32390cd1..1ee217d97434 100644
--- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
+++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
@@ -152,7 +152,7 @@ static const struct htab_mem_use_case *htab_mem_find_use_case_or_exit(const char
 	exit(1);
 }
 
-static void htab_mem_setup(void)
+static void htab_mem_setup_impl(enum bpf_map_type map_type)
 {
 	struct bpf_map *map;
 	const char **names;
@@ -178,10 +178,11 @@ static void htab_mem_setup(void)
 	}
 
 	map = ctx.skel->maps.htab;
+	bpf_map__set_type(map, map_type);
 	bpf_map__set_value_size(map, args.value_size);
 	/* Ensure that different CPUs can operate on different subset */
 	bpf_map__set_max_entries(map, MAX(8192, 64 * env.nr_cpus));
-	if (args.preallocated)
+	if (map_type != BPF_MAP_TYPE_RHASH && args.preallocated)
 		bpf_map__set_map_flags(map, bpf_map__map_flags(map) & ~BPF_F_NO_PREALLOC);
 
 	names = ctx.uc->progs;
@@ -220,6 +221,16 @@ static void htab_mem_setup(void)
 	exit(1);
 }
 
+static void htab_mem_setup(void)
+{
+	htab_mem_setup_impl(BPF_MAP_TYPE_HASH);
+}
+
+static void rhtab_mem_setup(void)
+{
+	htab_mem_setup_impl(BPF_MAP_TYPE_RHASH);
+}
+
 static void htab_mem_add_fn(pthread_barrier_t *notify)
 {
 	while (true) {
@@ -338,6 +349,15 @@ static void htab_mem_report_final(struct bench_res res[], int res_cnt)
 	cleanup_cgroup_environment();
 }
 
+static void rhtab_mem_validate(void)
+{
+	if (args.preallocated) {
+		fprintf(stderr, "rhash map does not support preallocation\n");
+		exit(1);
+	}
+	htab_mem_validate();
+}
+
 const struct bench bench_htab_mem = {
 	.name = "htab-mem",
 	.argp = &bench_htab_mem_argp,
@@ -348,3 +368,14 @@ const struct bench bench_htab_mem = {
 	.report_progress = htab_mem_report_progress,
 	.report_final = htab_mem_report_final,
 };
+
+const struct bench bench_rhtab_mem = {
+	.name = "rhtab-mem",
+	.argp = &bench_htab_mem_argp,
+	.validate = rhtab_mem_validate,
+	.setup = rhtab_mem_setup,
+	.producer_thread = htab_mem_producer,
+	.measure = htab_mem_measure,
+	.report_progress = htab_mem_report_progress,
+	.report_final = htab_mem_report_final,
+};

-- 
2.52.0

