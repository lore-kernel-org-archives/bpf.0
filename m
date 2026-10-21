Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625221;
	b=evYx0W7qEZ+29TQ9One8Y66MAdeaAicfmNSCk1H4yMHXz4plO72GVdh1W5nahQzxck+m
	 6tq0bwBgMpoz8Y3LkKYlSBfKN27fSC/XRrQwgfKQZJBO51AL86cZND/CgiaXcXkP6DzaY
	 qe3RUVQcwfhNB3D8rRsHU9V/IHBtKXAouYCMeTS3yhiB1ebysn+ddL0J6bBMDhtmLKoFc
	 pIAyBEs9sBLmrMH9WBfEKrMM/ow+s1lMo+Z5i1tZybGpMxI50Tl02SukloxTPw/dA+SbO
	 ieR5D5cCD7SHA16A12Unz5oYaXdTi+o6weoNnSvpUY2dVWCkHScCFa5j2bo0c8/CZgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kttcivgKPkfHRJEKlV9hpJuxI1L+qc9obH5MubJcPtk=;
	b=mPOQQcJFLUQl/WYcUBQSodAHjRzRvX+tBu2sV/yfMrrmflwPUbER/MbzVddZT8d6gTXJ
	 boCqOIOMO5umXmDjKFMsWNC+vncVIlCJFgnrg2Q8QX0rIC7CMjA4SHBk6sov+iplFCIan
	 cXj8GcM17qB5rhMqSlvT9gVnG5TDN7Kon8ygp62jj631KVN8Ttkfw3dVj7wKeFCvhxsrS
	 auevXsMGxAgV5Wp+7h4CmyCk4hANFb+HpaHxeJP8tDvbNdfevKEWMGYWQEHQ0eVK3Mgq9
	 YjPQdB2f6RTL3Mvc3B7zA5EDBsXoOqX1ey9cn3JFISY9feMpnmhwDqz/+KMhNww/YNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=PW+XeOqt;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB0606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 23:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58EB0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=PW+XeOqt
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e5d0ee1951so8514335ad.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792625221; x=1793230021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kttcivgKPkfHRJEKlV9hpJuxI1L+qc9obH5MubJcPtk=;
        b=PW+XeOqtZFbtfx+mX09crUZeOSppLTJSKX0LmdhDiDeVR/f6Wi57v2xCD6/4YSrMwo
         yKnp3UHTZY2+7M5x/zoP2dGkzfcBBj2qAWzJieUiFipDKtmN99+fE2NZJGVuBJEMgjuX
         GVMXY2+iGfVHC/48o6ESxayEbKna1fDxj7NA5gRD7gYoOZA3A3rUhTYSy/6Vyyndgoz2
         HUqMirxf+zyCmHQRA62b1T24CgCSMN8U0qPr3HkDULtJ0TCi6S9L62dtcXvxo84dD1om
         +W5nHMD86IxP+ak6/qOt6M8hNiZ06fUpEXYOrE3pI1ljpcrAJ0kOmxm6hrXqh15YISLT
         OHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625221; x=1793230021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kttcivgKPkfHRJEKlV9hpJuxI1L+qc9obH5MubJcPtk=;
        b=n2MiCGS7fS8zkTA8UV3EvjqfM7eChQswRT7+ZFHd9lOFrZXEp45m7DIvLTsGXN941N
         sIEXmv+27sFDT7uUfBW2JB1FN2qkdaZ63n7u3chHjMLITO1z+AF+Pc8vqvyYwK11sJ2/
         uPdR11DDk71ydn3Bl17O/ZUJEYUzB0KfmuxpYUolqJkYXuuwDQxptE7AyzQVw5T6KwVw
         I4u4VZ4ZrIFWLrGiFyVSCUr+0zvf19LCzZVL6hyRTo2oeNjJLVc9cvvCooHKppNsLCri
         PyMNq7n86x7aoLadHxYW5sVwz1cq5azyCPfcDVl/2Ret/BkhR4k16RygFzzLuU/MaxPs
         q9wg==
X-Gm-Message-State: AFq9FYK0tE8m1F4IN2PpyvL+dujssaQiooHVLg0HTbIU/6UxGjeofqMe
	Vesg8P960N4GW8gLF0ZuxUIT3Wi+qPeYpJtmIvQcV+JhS08FBiqTNfz5PqziXJNQNsJQjMymciG
	ETZDgElNFVg==
X-Gm-Gg: AYBFou1XRjei2SuD1ciHm25vKGVnmYShwRoDJUPCOo35hm/1NzNMdbAYAHZTfY9EHY0
	+ENOjoSUxJoM0y8hluBvIQ/cqphQ9cNFsQoHGnsr2V8mtXVGa5Gn/NrcfkZeQqPhJ8tTJsN6Ftm
	A1Uwn5cxsUjPPs83DXQDX7Bsl1BcgcdfHoDthiZEq0uSynfIWVqbOpMC/WBwah8Tdh964ZEuR9Q
	dah5bunp5HcOxKf8QObZHKoPRgO9Z4uUqqLULiXXc6CqGhOFyiAGz10cMHbM6GFkayGchlJb15M
	30as27DoE146AhYy2TevFK8ekB2gQ9xaUc1y9xI/Swkh1waV8im72ZK82uhh00bDycRIA9g0u0V
	WQVzPdZQr6RoFAghNyDeNMZuO2mvKbYfoMtspPQgSrp47H4vr2xZU3VXMyml2CxvmuWB2PF4j9r
	DE18hSiP9H/dtjv8YEkXTmKpNGJnv6F5qK52E8M6eK744FMgH4tCMKQ/aomhdvBvQIT4h7Z2AMq
	QUk60N7hJeARCQn6v6LvfUsMj8bwQL3sPjboCvNGPvF
X-Received: by 2002:a17:903:190d:b0:2e5:d2b1:c70b with SMTP id d9443c01a7336-2ea43e052d0mr28895705ad.60.1792625220532;
        Wed, 21 Oct 2026 16:27:00 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:725c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ada70sm15651425ad.72.2026.10.21.16.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:27:00 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 2/7] selftests/bpf: Add a parallel buddy allocator benchmark
Date: Wed, 21 Oct 2026 23:26:36 +0000
Message-ID: <20261021232641.10063-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021232641.10063-1-emil@etsalapatis.com>
References: <20261021232641.10063-1-emil@etsalapatis.com>
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
index e06397dc9a40..dedecee6d80f 100644
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
@@ -49,3 +52,110 @@ int bench_calloc(void)
 	__sync_add_and_fetch(&bench_hits, i);
 	return 0;
 }
+
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
-- 
2.52.0

