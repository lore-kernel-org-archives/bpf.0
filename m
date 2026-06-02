Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E0388873
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433184; cv=none; b=JRSZPJ1S1zufDsreSrXEcota/8Pe+kcLAmc66cZdD/ZDTgDUvdtnjSybMsObWbWocLiS8oi3espKPbb8vM2J6Y9lenb3BssfgwLI3skZFqQ3puY6dBaBNa54De8Lb/Sdk9LGpjsmhIHFBnj6RYKK0BlPkTTA0pRZtdRxUMxDaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433184; c=relaxed/simple;
	bh=iig8ko5HkENrJoO1L8D3+M14FcaFKNnbZ8Qu1b/2v+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZh2bbDR9qnIp8Dh6CrqyuEXoiXIECcfqnTjvxBNI6QSx3WGUjENY24N7iUEVqKCgJkPqjbfmfMW3fBLDrDNhOvwm2sBufnLok6kWih9XrUZOHWkAG/Urq6wwdFcaQ7foo6pfzu7GPXCLCVAMxlyZ9DXkzva4n6Q6ExeloLJ0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJmDm9Wy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJmDm9Wy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49068493267so69291215e9.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433181; x=1781037981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmHGZAwiM9J1pHRVFVqZaXa0IfjuRZ5vCsMaQ0gH/ZU=;
        b=qJmDm9WyRPtMmDbQi1EA+5FMCc661Y9oI48DiX7ORK/GVmJTWDMhjANlYUwcVCS6GU
         LR4xTLfx0TMiALQsaYAP4cbO6gZ7ijYM28E9/eIew4HkdsPkT+9Tf4n5hs3Jz5U94+yU
         o4clXeuIy29/D56m+jO2QO7yiqK0CoUoqF0BDn2+fR+l3dKWX/J1UoVksTS70Z1vFLqq
         x5MYH9Na63iOQEauIK4sxafT990nkSzAuhsKjAIbf857nirH9FAmllA/opXL8FST+fAT
         3ryFymPN9zvNZGyI7UAncA7eGkcSCIQi/LeetdBS4ivz/kvdQjDNljhDSHcDRgAYzmTU
         +qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433181; x=1781037981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WmHGZAwiM9J1pHRVFVqZaXa0IfjuRZ5vCsMaQ0gH/ZU=;
        b=AHHDTl3o1J2Hoa/iUzDqGZQ1w647glwmpcp/HwK3Mw8cpNGfxRGUxG/55w22MX80Au
         15yMF9d1SfChGBWZ1iw81N1hFM4NUVu66HIQhBd3AX0AeI2CBLegRTXrNDcV1aKyjt9L
         RFNwHEgRkvbxHkhZ9rtumC0B/G5NSv22t0kGd8k0UNlu374oc7IeD4zBizOkHXFAGD5X
         voOHcGNzqGwFkyhJMlW7aRN8/40JS6LARVbmaNnaSQ4QOyokRxYyqQIvRS9EMnjJT45I
         RmN3RgzUG4CR0GkYWQgj4N4dTWSEsv8cnjp8oFQolROnpI5ofRM7qo6a7dzK3KDG88Oy
         +VNw==
X-Gm-Message-State: AOJu0Yyt9Ie6yOuKCCNa8MkN5vkglVfOcX3qYr/7Y4yCsN9eaJdHJU0U
	5wnATJWkrbNboHUHIFRWfaHDuescMXX5NluXsRJb4FwlNXLxgQKL1r4f
X-Gm-Gg: Acq92OH6LzyZxI8VgRNM2jLgZ6IURxZg0Of9KmZOpVbVkVxlPFMNED7l0rD5lKrf8Fc
	x/SUQQIgTCwiNZdbh7RRfnH79gLjcZKxsvwRsQXxlnWeJoMdaRHOdkMPxglMQdebP27VmnSMAOa
	C7nOVDyURzkkkzjo3ihQv+PwCTkYH6Fc9+htE4lAzJVyx5KFvWSjISEHtOD24n1gwhxgo8MrP75
	/V5KJRYzCMdPwL7A7wWb4w/7hfatTXZQOuIwo+w0XLo5a4Zo+3m4w0hO48PTNrd2PS911Xa0yei
	OSzX4R5s8JCpWNsdAje4JwwqBVJLUpIJcKJDI2rHm2L0OIf7NQ6vOVtAre2YWEsReRDF4H/pBQ1
	mAR9CqAmZ/YuG3FW+XewAyB9jdrmUdAiXucv9D4rMDv3A7eW59sMXncSvCVL1VInqBhOUMjdL2l
	DiLa8It4R/CPa3a5LUOhNIemTPEkaQZYHJTGA=
X-Received: by 2002:a05:600c:3150:b0:490:3b87:be0e with SMTP id 5b1f17b1804b1-490b5fe7117mr6385915e9.29.1780433180759;
        Tue, 02 Jun 2026 13:46:20 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:44::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b60f6d5asm5779135e9.0.2026.06.02.13.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:46:20 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 02 Jun 2026 13:45:40 -0700
Subject: [PATCH bpf-next v6 11/11] selftests/bpf: Add resizable hashmap to
 benchmarks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-rhash-v6-11-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
In-Reply-To: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780433165; l=11024;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=VJWOsU9kMXt/rqSp1GhsKaoQ7I7rP6xHlQJHSUUxlFA=;
 b=JR7boJuZF18tn53rMjRLY736BXzzKh2VRnkXYuf6Up37umkfuMpRuqsv6bdGl9NE5D9D9JzG9
 XsqfwGXpUX3BJPnSoKfEFVcFDv6AzgB1rpIgb0DHBDgsF26fsqqUI8k
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Support resizable hashmap in BPF map benchmarks.

1. LOOKUP  (single producer, M events/sec)

  key | max | nr    |    htab |   rhtab | ratio | delta
  ----+-----+-------+---------+---------+-------+-------
    8 |  1K |   750 |   99.85 |   81.92 | 0.82x |  -18 %
    8 |  1K |    1K |  100.71 |   80.19 | 0.80x |  -20 %
    8 |  1M |  750K |   23.37 |   72.09 | 3.08x | +208 %
    8 |  1M |    1M |   13.39 |   53.72 | 4.01x | +301 %
   32 |  1K |   750 |   51.57 |   42.78 | 0.83x |  -17 %
   32 |  1K |    1K |   50.81 |   45.83 | 0.90x |  -10 %
   32 |  1M |  750K |   11.27 |   15.29 | 1.36x |  +36 %
   32 |  1M |    1M |    7.32 |    8.75 | 1.19x |  +19 %
  256 |  1K |   750 |    7.58 |    7.88 | 1.04x |   +4 %
  256 |  1K |    1K |    7.43 |    7.81 | 1.05x |   +5 %
  256 |  1M |  750K |    3.69 |    4.27 | 1.16x |  +16 %
  256 |  1M |    1M |    2.60 |    3.12 | 1.20x |  +20 %

Pattern:
  * Small map (1K): htab wins for 8 / 32 byte keys by 10-20%
  * Large map (1M): rhtab wins everywhere, up to 4x at high load
    factor with 8 byte keys.
  * Higher load factor amplifies rhtab's lead: rhtab grows the
    bucket array; htab stays at user-declared max.

2. FULL UPDATE  (M events/sec per producer)

  htab  per-producer:
    20.33   22.02   19.27   23.61   24.18   23.17   21.07
    mean  21.94   range  19.27 - 24.18

  rhtab per-producer:
   133.51  129.47   74.52  129.29  102.26  129.98  107.64
    mean 115.24   range  74.52 - 133.51

  speedup (mean): 5.25x   (+425 %)

In-place memcpy avoids the per-update alloc + RCU pointer swap
that htab pays.

3. MEMORY

  value_size |  htab ops/s | rhtab ops/s | htab mem | rhtab mem
  -----------+-------------+-------------+----------+----------
       32 B  |  122.87 k/s |  133.04 k/s | 2.47 MiB | 2.49 MiB
     4096 B  |   64.43 k/s |   65.38 k/s | 6.74 MiB | 6.44 MiB
  rhtab/htab :  +8 % ops, +0.8 % mem   (32 B)
                +1 % ops,  -4  % mem (4096 B)

Throughput effectively tied

SUMMARY

  * Small / well-fitting map: htab is faster (cache-friendly
    fixed bucket array), but only by ~10-20 %.
  * Large / high-load-factor map: rhtab is dramatically faster
    (1.2x to 4x) because rhashtable resizes to keep the load
    factor sane while htab stays stuck at user-declared max.
  * Update-heavy workloads: rhtab is ~5x faster per producer
    via in-place memcpy.
  * Memory benchmark: effectively on par.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/bench.c                |  6 ++++
 .../bpf/benchs/bench_bpf_hashmap_full_update.c     | 34 +++++++++++++++++++--
 .../bpf/benchs/bench_bpf_hashmap_lookup.c          | 31 +++++++++++++++++--
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  | 35 ++++++++++++++++++++--
 4 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 6155ce455c27..3d9d2cd7764b 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -560,13 +560,16 @@ extern const struct bench bench_bpf_loop;
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
@@ -640,13 +643,16 @@ static const struct bench *benchs[] = {
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
2.53.0-Meta

