Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248462;
	b=39ny4DFK8reOeImEC7UqppqrMiQeN3g63aSJdyk/KuE0rUc43KP9pztYRMWAI89MAjJi
	 9w0MqgQq95t6zB+rYrAi+/2uDT08rWZcK0cyPwLAfKCJx7Ebv0zkLWifcvtzzPISSabjf
	 HjhQ02jpwPBBiQR+f56d8DikSykPGoL+ygLsk6fspZdB4h4nv7GFLV5kBYYgJZ7EeGb9V
	 3+em+At2O0QtrEn/PijA/w6M7mFOgqSJ/cGaowYUPebC4IH8MddxuH81ciZ2TnKtvzWZR
	 vXoTSHJ6IIV2FqB/IlbCtUYwNwMgRwuLsWVr0pc4RCud3Ui1XQUujb5j8KjPJhVTpLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UL5+LkhHayMScnL1iBCuBdsq82jHN6hGMUDaJsv2Z1s=;
	b=S1Mz3Rhvv4M+AvDQYFqegL3MTJBaKVcqCfFMJF/tZJkO/65UE7+hwOlN4hH9zUZ6SYbs
	 1YsKk7rR+vRlVXF3lYIjnUmv/tnG33qMsFfnGrG8KkVYlGkCanvhiILD5EMld3oqoZwa4
	 aBqdyZG1Y6V2ZNjyx7oi05aGOqUIW39LsX2R7Db2i1ei+mifVLxOrurWE5v+uBQ2bIfWm
	 A+D08t9uR9xKv+CsFZfekAfdGeM4gxK8FAwTMUZZfalNUZZqrtpGufTbGTDBlfkz8eo6l
	 gNql4mfTp6K9AL5hE/XMqq1w66QaU7vJ2dpsngs1k9RQOHbWvgMPOOjCBe3w5qnmElQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=v73N6VoR;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDE60A261E
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDDDE60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=v73N6VoR
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc147d86bebso627865a12.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248461; x=1794853261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UL5+LkhHayMScnL1iBCuBdsq82jHN6hGMUDaJsv2Z1s=;
        b=v73N6VoRjH9biYK1FN9TfiCwO+wljjohDbJzzneg5P+2YviqZq+jx9Aj4X1c+o2FUY
         hul9wdMPp2jA+NFm/3iUV2HAqrSqXfsfyN+Db9hbB/qYPdqWSLJmwZNcMM7TcXI6tVpt
         haHwD4aBgd9rnr6HW/kKaRSbHPnvYnHbgS4Q/AfMrteYRcJDP4lHwRqQyT6QCxb31PPA
         5IwUCfYRoMDFoZS0Dj2W0uWnLu5t9GtQFUnTMOtxvizyaDbBkt237i89HY6fmfkjM8y7
         5L5OciKwc4UR/a+w8gzTG7y2FYnLC/+62vPoGgFNSotYb9OJAaU5pu9FICCEBzFU1Xa0
         mtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248461; x=1794853261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UL5+LkhHayMScnL1iBCuBdsq82jHN6hGMUDaJsv2Z1s=;
        b=H3csFshaBXJoaEjsJBcGIu2m8fZZHszJxlcgRHA/Sjcde+zYEhA5GvpAIA3VbMfh5I
         9PfSyri2D0BQhCwTrPfIKSOCmXp+9w0C442VK6Osx0b9l1FolFzdF/qri9VgZ90hpjTL
         HP9NoQmRcNK62gLjxK3TEBoywlPNxJrMWUKM/bptlxXzRB0hXDTUaRefm2HoNEeZiOZl
         PB09edj2lg3yNSqYRdn0aJwod7mVPnUC7ondUDDjSrpQ9f3g7DpFmsCc4z7ElXGKnCEs
         NsA+ztemNHnM9BYLjHUEsYbphvMABCPLxwOI2x/VxJOW2SdztcSHGbYxRWMSpsnZWtyv
         DnMg==
X-Gm-Message-State: APuU4Z9ihhRpSTet51uw7TE66JkUM5E17/NvTOfYlqT5gCbdGD/1RDil
	7PIX6KpHKjt2RMHMffcWoS9823RitzCCSRU4FYCnnlC6gMT2oim48k6p6dUUccp5wkDHzNWDPNb
	S4Uv0qCU=
X-Gm-Gg: AYBFou00FXSC3fue/r8DLbCgRJuMYzursneYsPNApxF2yfw1Ub4wMAVK2y2JszCdGGE
	DD0AGyAOqAyeHmBcODMNy0exwFRdvbuCDxvd8yJ11hDD5iaYelaUXZvsckusn6W+tkxvySP5dFr
	OH9WIx5n+Sx/2wY3SE4vu+rIM+l05u4i9Kqv6DQjey6KU8hcEgD+riFx1bkBR6AqwZDDPl1uG5B
	/7mvviEP+nIzwF6x9abFGJRbdZAAAnT33ei4Oe6K8iLOWTkvP56/fVqBTAB1U1rSDTi47MB/cAC
	DlEDWnOF/AiLmi0DhqLVPIOhzCANBDVEQaBYcMdd+5i1TnZZRXDLfKn3R4YVdpVFy0Iu6S/n002
	7CZ8k2JVlaEWfEtffUoVU5VwxtX6piCQbcwsw1h6ZO2oMXz0VqJtupLcYXsV384aHSsSfh2Hel0
	5vuQx+B2SAN46OB/+beMUYx+lITS5vdDbKBUJLDdyWfe54jE5MTPVlcLexgibx5fOLU+BWWRD4y
	TSaKSxAeaihn93aaJ91jI3dKsbQq165XGhDnYxsqDUYpvLdey44Y5Qoq0Uroe3wQeCAW6MLx6dj
	WxFFIeTDtZFTW8Q2QV+NLwEpH7Xsj9D1bjh2+0H38A28mnWo8t6fAIbAeZz+IsMmh8K603P5ehN
	DpVFQah4FapkpT+RLyzCUO5A7Qhg=
X-Received: by 2002:a17:90b:4a46:b0:3b1:6689:a016 with SMTP id 98e67ed59e1d1-3b167931c23mr193026a91.16.1794248461024;
        Mon, 09 Nov 2026 10:21:01 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676e2974sm474860a91.9.2026.11.09.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:21:00 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 2/9] selftests/bpf: Add a parallel buddy allocator benchmark
Date: Mon,  9 Nov 2026 18:20:47 +0000
Message-ID: <20261109182055.7581-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109182055.7581-1-emil@etsalapatis.com>
References: <20261109182055.7581-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a benchmark for measuring buddy allocator latency under concurrent
load. Each worker performs a configurable number of allocations followed
by the corresponding frees, and the summary reports the mean latency of
allocations and frees separately. The frees chain the objects through
their first word, so the allocation size must be large enough to hold a
pointer.

Add a cross-CPU variant in which each worker publishes its list in a
shared slot, takes the list left there by the previous invocation and
frees it. With more than one pinned worker, most objects are then freed
on a different CPU from the one that allocated them.

Add both benchmarks to the libarena runner alongside the existing
single-threaded cases, sweeping the producer count from 1 to 8 with a
fixed allocation size and count to expose lock contention.

Report the existing libarena-malloc and libarena-calloc results in
ns/allocation and summarize them by total allocation count, so that all
libarena benchmarks share one output format. This replaces the previous
ns/op unit and the invocation and allocations-per-invocation fields.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_libarena.c     | 118 ++++++++++++++++--
 .../bpf/benchs/run_bench_libarena.sh          |  16 +++
 .../bpf/libarena/benchs/bench_malloc.bpf.c    | 110 ++++++++++++++++
 4 files changed, 237 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index d5f494184f9d..fbbd55399019 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -589,6 +589,8 @@ extern const struct bench bench_bpf_nop;
 extern const struct bench bench_xdp_lb;
 extern const struct bench bench_libarena_malloc;
 extern const struct bench bench_libarena_calloc;
+extern const struct bench bench_libarena_malloc_free;
+extern const struct bench bench_libarena_malloc_xfree;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -675,6 +677,8 @@ static const struct bench *benchs[] = {
 	&bench_xdp_lb,
 	&bench_libarena_malloc,
 	&bench_libarena_calloc,
+	&bench_libarena_malloc_free,
+	&bench_libarena_malloc_xfree,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_libarena.c b/tools/testing/selftests/bpf/benchs/bench_libarena.c
index 24e432244bf5..4096b54db520 100644
--- a/tools/testing/selftests/bpf/benchs/bench_libarena.c
+++ b/tools/testing/selftests/bpf/benchs/bench_libarena.c
@@ -25,6 +25,10 @@ static struct {
 	struct libarena_bench *skel;
 	int bench_fd;
 	int reset_fd;
+	bool reset_each_run;
+	bool stop;
+	int stopped;
+	int samples;
 } ctx;
 
 enum {
@@ -36,7 +40,7 @@ static const struct argp_option opts[] = {
 	{ "alloc_size", ARG_LIBARENA_ALLOC_SIZE, "BYTES", 0,
 	  "Size of each arena allocation" },
 	{ "nallocs", ARG_LIBARENA_NALLOCS, "ITERS", 0,
-	  "Number of allocation per measurement" },
+	  "Number of allocations per invocation" },
 	{},
 };
 
@@ -68,12 +72,17 @@ const struct argp bench_libarena_argp = {
 	.parser = parse_arg,
 };
 
-static void validate(void)
+static void validate_common(void)
 {
 	if (env.consumer_cnt != 0) {
 		fprintf(stderr, "benchmark doesn't support consumers\n");
 		exit(1);
 	}
+}
+
+static void validate(void)
+{
+	validate_common();
 
 	if (env.producer_cnt != 1) {
 		fprintf(stderr, "benchmark supports exactly one producer\n");
@@ -81,6 +90,21 @@ static void validate(void)
 	}
 }
 
+static void malloc_free_validate(void)
+{
+	validate_common();
+
+	if (env.producer_cnt < 1) {
+		fprintf(stderr, "benchmark requires at least one producer\n");
+		exit(1);
+	}
+
+	if (args.alloc_size < sizeof(void *)) {
+		fprintf(stderr, "allocation size must hold a pointer\n");
+		exit(1);
+	}
+}
+
 static void setup_common(void)
 {
 	struct arena_alloc_reserve_args reserve_args = {
@@ -114,38 +138,62 @@ static void setup_common(void)
 	ctx.skel->bss->bench_alloc_size = args.alloc_size;
 	ctx.skel->bss->bench_nallocs = args.nallocs;
 	ctx.reset_fd = bpf_program__fd(ctx.skel->progs.arena_buddy_reset);
+	ctx.reset_each_run = false;
+	ctx.stop = false;
+	ctx.stopped = 0;
+	ctx.samples = 0;
 }
 
 static void malloc_setup(void)
 {
 	setup_common();
 	ctx.bench_fd = bpf_program__fd(ctx.skel->progs.bench_malloc);
+	ctx.reset_each_run = true;
 }
 
 static void calloc_setup(void)
 {
 	setup_common();
 	ctx.bench_fd = bpf_program__fd(ctx.skel->progs.bench_calloc);
+	ctx.reset_each_run = true;
+}
+
+static void malloc_free_setup(void)
+{
+	setup_common();
+	ctx.bench_fd = bpf_program__fd(ctx.skel->progs.bench_malloc_free);
+	ctx.skel->bss->bench_collect = false;
+}
+
+static void malloc_xfree_setup(void)
+{
+	setup_common();
+	ctx.bench_fd = bpf_program__fd(ctx.skel->progs.bench_malloc_xfree);
+	ctx.skel->bss->bench_collect = false;
 }
 
 static void *producer(void *input)
 {
 	int err;
 
-	while (true) {
+	while (!__atomic_load_n(&ctx.stop, __ATOMIC_ACQUIRE)) {
 		err = libarena_run_prog(ctx.bench_fd);
 		if (err) {
 			fprintf(stderr, "libarena benchmark failed: %d\n", err);
 			exit(1);
 		}
 
-		err = libarena_run_prog(ctx.reset_fd);
-		if (err) {
-			fprintf(stderr, "libarena alloc reset failed: %d\n", err);
-			exit(1);
+		if (ctx.reset_each_run) {
+			err = libarena_run_prog(ctx.reset_fd);
+			if (err) {
+				fprintf(stderr, "libarena alloc reset failed: %d\n", err);
+				exit(1);
+			}
 		}
 	}
 
+	__atomic_add_fetch(&ctx.stopped, 1, __ATOMIC_RELEASE);
+
 	return NULL;
 }
 
@@ -155,6 +203,13 @@ static void measure(struct bench_res *res)
 	res->hits = atomic_swap(&ctx.skel->bss->bench_hits, 0);
 }
 
+static void malloc_free_measure(struct bench_res *res)
+{
+	if (++ctx.samples == env.warmup_sec)
+		__atomic_store_n(&ctx.skel->bss->bench_collect, true,
+				 __ATOMIC_RELAXED);
+}
+
 static void report_progress(int iter, struct bench_res *res, long delta_ns)
 {
 	double latency_ns = 0.0;
@@ -162,7 +217,7 @@ static void report_progress(int iter, struct bench_res *res, long delta_ns)
 	if (res->hits)
 		latency_ns = res->duration_ns / (double)res->hits;
 
-	printf("Iter %3d (%7.3lfus): latency %8.3lf ns/op (%ld allocations)\n",
+	printf("Iter %3d (%7.3lfus): latency %8.3lf ns/allocation (%ld allocations)\n",
 	       iter, (delta_ns - 1000000000) / 1000.0, latency_ns, res->hits);
 }
 
@@ -182,9 +237,30 @@ static void report_final(struct bench_res res[], int res_cnt)
 		return;
 	}
 
-	printf("Summary: %.3lf ns/op, %.0lf invocations for %u allocations/invocation)\n",
-	       duration_ns / (double)hits, hits / (double)res_cnt,
-	       ctx.skel->bss->bench_nallocs);
+	printf("Summary: %.3lf ns/allocation (%ld allocations)\n",
+	       duration_ns / (double)hits, hits);
+}
+
+static void malloc_free_report_final(struct bench_res res[], int res_cnt)
+{
+	long alloc_ns, free_ns, hits, free_hits;
+
+	__atomic_store_n(&ctx.stop, true, __ATOMIC_RELEASE);
+	while (__atomic_load_n(&ctx.stopped, __ATOMIC_ACQUIRE) != env.producer_cnt)
+		usleep(1000);
+
+	alloc_ns = __atomic_load_n(&ctx.skel->bss->bench_duration_ns, __ATOMIC_RELAXED);
+	free_ns = __atomic_load_n(&ctx.skel->bss->bench_free_duration_ns, __ATOMIC_RELAXED);
+	hits = __atomic_load_n(&ctx.skel->bss->bench_hits, __ATOMIC_RELAXED);
+	free_hits = __atomic_load_n(&ctx.skel->bss->bench_free_hits, __ATOMIC_RELAXED);
+
+	if (!hits || !free_hits) {
+		printf("Summary: no runs measured\n");
+		return;
+	}
+
+	printf("Summary: %.3lf ns/allocation, %.3lf ns/free (%ld allocations)\n",
+	       alloc_ns / (double)hits, free_ns / (double)free_hits, hits);
 }
 
 const struct bench bench_libarena_malloc = {
@@ -208,3 +284,23 @@ const struct bench bench_libarena_calloc = {
 	.report_progress = report_progress,
 	.report_final = report_final,
 };
+
+const struct bench bench_libarena_malloc_free = {
+	.name = "libarena-malloc-free",
+	.argp = &bench_libarena_argp,
+	.validate = malloc_free_validate,
+	.setup = malloc_free_setup,
+	.producer_thread = producer,
+	.measure = malloc_free_measure,
+	.report_final = malloc_free_report_final,
+};
+
+const struct bench bench_libarena_malloc_xfree = {
+	.name = "libarena-malloc-xfree",
+	.argp = &bench_libarena_argp,
+	.validate = malloc_free_validate,
+	.setup = malloc_xfree_setup,
+	.producer_thread = producer,
+	.measure = malloc_free_measure,
+	.report_final = malloc_free_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh b/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
index 10afe4d52ebf..2dfa32cd95cc 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
@@ -29,3 +29,19 @@ printf "\t-------------------\n"
 			"$($RUN_BENCH --alloc_size "$size" --nallocs "$nallocs" libarena-calloc)"
 	done
 done
+
+header "libarena parallel malloc/free\n"
+
+for producers in 1 2 4 8; do
+	summarize_libarena "$producers producers:" \
+		"$($RUN_BENCH -a -p "$producers" --alloc_size 64 --nallocs 1000 \
+		libarena-malloc-free)"
+done
+
+header "libarena parallel cross-CPU malloc/free\n"
+
+for producers in 1 2 4 8; do
+	summarize_libarena "$producers producers:" \
+		"$($RUN_BENCH -a -p "$producers" --alloc_size 64 --nallocs 1000 \
+		libarena-malloc-xfree)"
+done
diff --git a/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c b/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
index 636178f1fa6a..de6d3d5c6bd7 100644
--- a/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
@@ -9,6 +9,9 @@ u32 bench_alloc_size;
 u32 bench_nallocs;
 long bench_hits;
 long bench_duration_ns;
+long bench_free_duration_ns;
+long bench_free_hits;
+bool bench_collect;
 
 SEC("syscall")
 int bench_malloc(void)
@@ -50,4 +53,111 @@ int bench_calloc(void)
 	return 0;
 }
 
+struct bench_alloc {
+	struct bench_alloc __arena *next;
+};
+
+SEC("syscall")
+int bench_malloc_free(void)
+{
+	struct bench_alloc __arena *next, *obj, *head = NULL;
+	u64 alloc_ns = 0, free_ns = 0, start_ns;
+	u32 i, nallocs;
+	bool collect;
+
+	collect = READ_ONCE(bench_collect);
+	for (i = zero; i < bench_nallocs && can_loop; i++) {
+		start_ns = bpf_ktime_get_ns();
+		obj = arena_malloc(bench_alloc_size);
+		alloc_ns += bpf_ktime_get_ns() - start_ns;
+		if (!obj)
+			break;
+
+		obj->next = head;
+		head = obj;
+	}
+	nallocs = i;
+
+	for (i = zero; head && can_loop; i++) {
+		next = head->next;
+		start_ns = bpf_ktime_get_ns();
+		arena_free(head);
+		free_ns += bpf_ktime_get_ns() - start_ns;
+		head = next;
+	}
+
+	if (nallocs != bench_nallocs)
+		return -ENOMEM;
+
+	if (!collect)
+		return 0;
+
+	__sync_add_and_fetch(&bench_duration_ns, alloc_ns);
+	__sync_add_and_fetch(&bench_free_duration_ns, free_ns);
+	__sync_add_and_fetch(&bench_hits, nallocs);
+	__sync_add_and_fetch(&bench_free_hits, nallocs);
+	return 0;
+}
+
+/* List left behind by the last bench_malloc_xfree() invocation. */
+struct bench_alloc __arena *bench_xfree_head;
+
+SEC("syscall")
+int bench_malloc_xfree(void)
+{
+	struct bench_alloc __arena *next, *obj, *old, *cur, *head = NULL;
+	u64 alloc_ns = 0, free_ns = 0, start_ns;
+	u32 i, nallocs, nfrees;
+	bool collect;
+
+	collect = READ_ONCE(bench_collect);
+	for (i = zero; i < bench_nallocs && can_loop; i++) {
+		start_ns = bpf_ktime_get_ns();
+		obj = arena_malloc(bench_alloc_size);
+		alloc_ns += bpf_ktime_get_ns() - start_ns;
+		if (!obj)
+			break;
+
+		obj->next = head;
+		head = obj;
+	}
+	nallocs = i;
+
+	/*
+	 * Publish this list and take the one left by the previous invocation,
+	 * usually allocated by a worker on another CPU. If the exchange does
+	 * not complete, free our own list instead.
+	 */
+	old = READ_ONCE(bench_xfree_head);
+	while (can_loop) {
+		cur = cmpxchg(&bench_xfree_head, old, head);
+		if (cur == old) {
+			head = old;
+			break;
+		}
+		old = cur;
+	}
+
+	for (i = zero; head && can_loop; i++) {
+		next = head->next;
+		start_ns = bpf_ktime_get_ns();
+		arena_free(head);
+		free_ns += bpf_ktime_get_ns() - start_ns;
+		head = next;
+	}
+	nfrees = i;
+
+	if (nallocs != bench_nallocs)
+		return -ENOMEM;
+
+	if (!collect)
+		return 0;
+
+	__sync_add_and_fetch(&bench_duration_ns, alloc_ns);
+	__sync_add_and_fetch(&bench_free_duration_ns, free_ns);
+	__sync_add_and_fetch(&bench_hits, nallocs);
+	__sync_add_and_fetch(&bench_free_hits, nfrees);
+	return 0;
+}
+
 char _license[] SEC("license") = "Dual BSD/GPL";
-- 
2.52.0

