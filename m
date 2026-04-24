Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFD3FA5C4
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060291; cv=none; b=mKJNXNXtkqpz+YjtqdZwKUpbUU5uQpSuO6tuHme9oN7LdmCDbkfvZd6yHLf+11PRfvuF4su9nHz6iMaEpYP9yFDl0/yhWNGmIa6IqGz6Q/UCTspotVJFF0FgdSITza8HqacBh4E4JzMU6ftD3FqfpND0LHkUrMbt9HkZ80Yyq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060291; c=relaxed/simple;
	bh=++YX2Tiuy7Q0ZWJ1eHbB86XzGNkOn58uKmgjZsjc7cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pg4NxnycKddcL91KDbbxGoyPawDrSjQpVi8oNX5QBPcLWPjWFYCJXPg1UyrkUge+4P6xacZskCpV3W6qKUVh3OG8eSWFF6dqMWC8bMdjtLpIGjXXTcLzImsGfxJ/PL+0V3Z5yEGZ5s+WniEW8r8wjUGx2uup6p74VDfoCHtm8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2mbVU46; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2mbVU46"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d77f6092eso5706626f8f.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060280; x=1777665080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAbv9ZiQ9sv4UAeiithLvkxGHzZLyMxpb8eySB7mZxI=;
        b=U2mbVU46SSbmMSFVa6W4HWtF6ZLs0oN7m8NUX4sfUP0GasG9Ge/yNxQ64t7Nmmy/gK
         pIJmsEbS8UFYpFxRlgRjsuxKEAoUzVhVv2dBYrFthsBtz9mY0u5tXvxE253JIHM5y+dw
         UYfOuRRLheInJmCefp0l2OpBMdjGGhZe6u3fD1i96yUQ91pHf23xFRzMHSm6tarYdqLQ
         L4QMIbfkaJ04S9hzj8j6Dy0TsOHCDU40+Get3zT+8CSdprniwksVTafiPClPco7gk3an
         ZiH4kXnuumWlbQKrdL94BsPT5QBKsBY79x6nbVXi2AEhn3XxQeTGO9zhb8Tz0JvxZTTc
         +e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060280; x=1777665080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lAbv9ZiQ9sv4UAeiithLvkxGHzZLyMxpb8eySB7mZxI=;
        b=WseovavNUr+owqKsfefUm+0ge8YZDj7Kbnz5e3uKiKdx9WLJm/rE4eFovAmYnP8/MP
         1+O0N4l1roBw8m8TkTdIgMmfnCCOZakiqgptUER/H2NPHvrbEVC0p4vdUUhdSICT3TCk
         OqRqE4bYGIwr12jGWzmWuJe+gJag+c0y0j25W5ZarujSSpQN5SG6zKjje14uKgIkMbw5
         ZZYaRu45bYDG7WCp7qvQVa7hR69uQfOdahpLHda+/qpoQN8VsFFSblEJ3dNB4ha0pTVI
         cdjNgfaD+MaSUW14yFBRhmDXwF04FsxIsUF941YSBL0LHF/HCLRoNcr0hMWmnD0HZj+B
         FkBg==
X-Gm-Message-State: AOJu0YztnvS+sUhZ0J4zRAkhMuR4B13gnTNqYI5UmEeJQz9yWQfep1M1
	sBp2hjIMNNWZCIz+KNDlc+h++mf0XrrCLCSI5qH7/reaQTO9yQHP0vOy5su3q9u+q/M=
X-Gm-Gg: AeBDietOhv7KTPL9kDtatYjaOvygWiwLLs6AcTmN++C2KMlWY6ztndbutUSFTzLFIC6
	6vwChc1N7t2VZzbv1xHmNl9rGeTeMFrfLRRPrF52VFG6mXFi6NsWPHp7k0wy7cyBxHn2CRGmDGK
	1CxzAQjlFJVFO5hvWGf94TqyabciLBh6Ra1OQhCSyU1/6ZrqvOHVDvQbXxgOu4zeGyqJDE8cVMB
	fWrqVChA7TACrb8tGjW4T0Weeu3qjFHArp2bhpHvrRfSVvqkSIduavIuupIwmIS/K2qQf2fbP5z
	J4SS0KPQC+xYLopRb/LOmIxaFBQPJaRDN6wFfS+prR9N2Zz/1dAVlghtiWpcxr0Gzyjrj6O5al9
	ICegzvTnXDJPSkDe2aG97yNWmrwNkf7mRYRwlBdVFE39TIVvTvhJ20zGLhuHzug40n0Poryc8zT
	25JdLls0rB9JZG5vdGAyT7AKFG
X-Received: by 2002:a05:6000:2282:b0:43d:7a97:78a2 with SMTP id ffacd0b85a97d-43fe3e09218mr51418830f8f.28.1777060279603;
        Fri, 24 Apr 2026 12:51:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm66342843f8f.7.2026.04.24.12.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:51:19 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 24 Apr 2026 12:50:52 -0700
Subject: [PATCH bpf-next v3 10/10] selftests/bpf: Add resizable hashmap to
 benchmarks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-rhash-v3-10-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
In-Reply-To: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777060253; l=10091;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Qww2BXzcai1hou1MKSHoPZ3mQEl45FkFK8N7vQV/VNk=;
 b=adPXNlUzHvGLRiVFxZeqkifLynwmqCsyCEs8h4rNnbD0N7DwNKMHGZb1cpLArmNQJCuOCZhhn
 3vN0V8hh0MgDSyJV3D/wk2+k1Ivf3181fLlt6NIAndpZG2yDMpq/Jmt
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Support resizable hashmap in BPF map benchmarks.

Lookup performance (bpf-rhashmap-lookup vs bpf-hashmap-lookup, events/sec):

  key_size | max_entries | nr_entries |    htab   |   rhtab
  ---------+-------------+------------+-----------+-----------
     4     |    1,000    |    500     |  17.22M   |  16.92M
     8     |  1,000,000  |  200,000   |  15.21M   |  13.39M
     8     |  1,000,000  |  700,000   |  13.16M   |  13.62M
     8     |  1,000,000  | 1,000,000  |   7.93M   |   9.52M
    16     |  1,000,000  |  700,000   |  10.77M   |  11.85M
    32     |  1,000,000  |  700,000   |  10.24M   |  10.69M

rhtab matches or exceeds htab at higher load factors and larger keys.
At full occupancy (1M/1M) rhtab is 20% faster since htab's fixed
bucket count leads to longer chains while rhtab resizes to maintain
a healthy load factor.

In-place update (bpf-*-full-update, events/sec):

  htab :  7.62M
  rhtab: 14.94M  (+96%)

rhtab updates values in place via memcpy; htab allocates a new element
and swaps the pointer for each update.

Memory (htab-mem / rhtab-mem, 8 producers, overwrite workload):

  value_size |  htab ops/s  |  rhtab ops/s  |  htab mem  |  rhtab mem
  -----------+--------------+---------------+------------+-----------
      32     |   18.27k/s   |   27.05k/s    |  0.98 MiB  |  0.99 MiB
    4096     |   14.00k/s   |   17.00k/s    |  2.23 MiB  |  1.99 MiB

rhtab is 21-48% faster on concurrent overwrites due to in-place
updates avoiding per-element allocation.

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

