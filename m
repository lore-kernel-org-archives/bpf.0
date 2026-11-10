Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271125;
	b=XaKqXC6YMvwRhMJj4Fmq6FxYAytunqlc/an9c2nr8nDtp4WG5AAdruyllvdmLmqGSsJs
	 SE8hHLOq0CihjjDvErFD6RMYyhf7ocQ3k5VSHr+/4AIbub7XfluGqkLdnOWFImKKzQ/pk
	 PcexnPux6mpsBVxb2f2XQlc16LRh3UEcFmKpqb/K0ESmQtvCZEJK/u+OKkbyrSIt/NAD1
	 ubJ5RaOcz2XUM2t9WDD+0PMOy/xbDZccf8dwk7Fwtv+Htf6HU8Cm2Z8bsUcUfo6rScUkb
	 LCUJyaoIwA9KsMkoeI6R23hq668hWvF5hQtA1Df27x1eKW4HWxTgVSgmSa548ZypKag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UL5+LkhHayMScnL1iBCuBdsq82jHN6hGMUDaJsv2Z1s=;
	b=vtL2vT78Y9qPgVhm30EecL3MlMZHtY3ZFI3fcE1yEsFFXDv0yxE7u2vhT/Cm4Ye6XPY/
	 WjFQ1aGVsfawex9foNNAgch1g0l3UYsDWz4ryizKTndtaGc29He9CqHL9cErNg8DkAogm
	 NpJsxAH7JoMQJN+EItDolppWxQBB4Cbu6D8o7R7ndr0j1z2yJH30hM61FPCkQe637CriZ
	 qmIw3NDm5MngR+ZZt68j4suqwbALy3n0vmnZz6rjCViig/k87nt2gw5p5q0xyto7Med7O
	 8+2x423yE0VFMj+VwvN/mozUS9PaPMfhS2JjaYiSKYZXtsCWIjHCwFYTgnDC50lZFhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=TTz5BHQI;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96235606A337
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96235606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=TTz5BHQI
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso587090a12.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794271124; x=1794875924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UL5+LkhHayMScnL1iBCuBdsq82jHN6hGMUDaJsv2Z1s=;
        b=TTz5BHQIfT7uApRTn83sZbpmNBV/a8AOWDqR+WjvRZOg0dG6xqm3b2dJhHiXmyqnDO
         gcH7trRgDoU13Pxpzgk2bSxw223sM15927XC9koBHR1UkmJ8tRoDb19wcV7dMQOc2KQ+
         LQ02q3mcekpTGTtgyh82B7trkDqypzrH+5h4k3Q15mv+ITxZmWp06NYZi0a1sPlGyp80
         AOHaDIjh6bi14C9Qghr15dajrWj7coSX3nq92kfQ+owhdHBG73nCmkmeiJ3xN7fF+Sbe
         5vtE7OyaO2hmRiCi4hJI2iZ5ywgg3QsX/cBrEZ70cGll/RsutgiW7Krg8TWOVtgeqUFJ
         aKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271124; x=1794875924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UL5+LkhHayMScnL1iBCuBdsq82jHN6hGMUDaJsv2Z1s=;
        b=CIzYx+jng4+h3BJ0DqkCm71U/DY9zH42o5M+RnMYFVusZL38AwNuTECRVUp3/8lGci
         oR1xfkiDPCx9RZuhoQ2rlj911Fhu3bycOr2GR/Q1MNQ5pb1p+qcyHZILbEu1WtMropDH
         U1u+D50NVhvB5T6A2Y3reDXxNgdlXw+KOofAY3r9rM55El6astfBh5VPY7GAOyRwSB/U
         I7weUwenN0uwVRbM4iOoTC52uSCNe0ws/06JgxThI9gBoQqNGAQLfTxLiGRH+aetO1nJ
         hv9norcnhw+aP7JhVg3TMuzVxsLcm1/tVFFUNuhEsL8WEnjNQq/ROroiY2Me10x6SOPZ
         ltDQ==
X-Gm-Message-State: APuU4Z+qG3wuQJwGL0uL5Lbbu1D/iAajOQ2zCJByL67gYOF7hCV5CFmh
	O6fGXzKAFLwejfnmqGG8/IJs5rlu/NWUVeifz3muRsAfjfRGQNH+0WajwKTI6os6OmPRckd9Quo
	nOZXxn3A=
X-Gm-Gg: AYBFou3sGGx/v6aZa9r2SemZIbNPGSxP+dhoAoNhybzN+jAv9oMMuBE6tVN/qsNKBZp
	qRED3Zer/MOnXUmyLeUbjGRbgxizXgt/l5nzuWRVavUfuG5v99dR5CtzMn0iFsKNjx4A96i1eIp
	1IRSaVWJcE5iLeBLsU9R8p6k6KAOAUPOtm3H252buo7/wRvySOk0ylZndCa5Kgv3kiySRxDOWl8
	rFEe6wBLmsrOxVPxJn/sVdsVezlNCyCiLmLVBIjx9P7zgMQqzKfDBggpoYT/5Mr4CN4ZNA5gBoI
	KzLxd4kOS36M2LVd2yfVs6dMOfxDIO1NrSDnKDStZPLShX51E1+i/9jA1kJlKpJw32H+4aZ3GSU
	EqqkUuX4WB/3+jW/9IQRL0VxvWzDT79uHxJubvv5lqG7LgsJuAVMAm/Mujcb70QTe80AKpUK4H4
	vFHrBX4h8ZiV5/469CD5tLy3AtyGKb0vrCEO9FFkujxwSwCGYkF0JNIk0Mh1jqxwcKuQZsWya05
	WRmtagGJ0LfunT6P0lkbTGsLCVCf9Bn/N37GwGxIsEooUaf7O7QFn3V/sZX/T+4s+uL6/PmKQnE
	yQ/0hKo6PkudZPHXx/JqsixAAuRptA3lHVxFPg2+ulxMJbiUtSD/78JF+lpC9OIh/CfDBgCgMxP
	39k1xju5/vfoZrrk/AJrRgwca9p0=
X-Received: by 2002:a17:90b:1d45:b0:3ab:b39f:41c8 with SMTP id 98e67ed59e1d1-3b166cd1463mr1128464a91.46.1794271123687;
        Mon, 09 Nov 2026 16:38:43 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168eacb73sm640209a91.1.2026.11.09.16.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:38:43 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 2/9] selftests/bpf: Add a parallel buddy allocator benchmark
Date: Tue, 10 Nov 2026 00:38:31 +0000
Message-ID: <20261110003838.8739-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110003838.8739-1-emil@etsalapatis.com>
References: <20261110003838.8739-1-emil@etsalapatis.com>
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

