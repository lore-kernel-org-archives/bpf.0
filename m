Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520347;
	b=sorV7mVgDuAmEpQ7VBAs2hvKnsYrtRuZ1jenS0p62aAkSzZoZ4IVBtLfE1HUuCnrKsX0
	 K8h3srsyYwpXQnr9eEV3hBRi5GiYgMPo/B9J46R+SNaJc6tE8t6TieZ6tTsU7mN9HSlVI
	 dcKYTnpEGe1WA0wuaTdkEWrhBi+UVAc6I7HG48mAGK52hegrPcQmBtyRAZewRj7INORHf
	 GNTvf1xQsoEil1dNYLKE22iKos69XX5HlI5om7XBpgv4FlZmu/h5ncAZQQhTpuBjfG8jm
	 xRzHD0NMWWSacnsKmgtNz4Q4q3itZyoy3pQZPhQMkCWS3XinYyI7Uu39oMFR97hAT2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gmv6TL1vmNzMKoJ16snZPTYX0cu4HYsfkPo0x4mSXIs=;
	b=qgi3or4YCqvRsBvk9ZaRKgDF+QDHL3jrJjb0ZjFjuNwxeeTQaX+WWbHvXfKGbC/wBl0E
	 +Dv38c3dVjrWa0lgjPMRpWIBjfjG0CfIhcX+i2BnUpCR7Z6YCGYdT8ms39TeevdKorh4t
	 iUJzCfBWRxRnkEgYOTK6eWiGSaFmdkQLjWwr83O2gbn5Hr+On2qw26LVwsLdxowGXZubc
	 GfxnLZoRuaWoGkM4QOIt6S5nEi6df9v3xHmkWCz4pVSfQCF4FrdtsLGwJykq5P4nsdPkF
	 KogFRCcSyqFnz1Cjt6QkRWT2UBJKDshlgccmbgNWE8l4P6Hg9CFyzEhghHj1Uy13D5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TK61oiBG;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDEA60A2610
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BDEA60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TK61oiBG
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso2078147a91.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792520346; x=1793125146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gmv6TL1vmNzMKoJ16snZPTYX0cu4HYsfkPo0x4mSXIs=;
        b=TK61oiBGGMJTztpPYzvy18B9K3vkaGa/PuCxbuRb+w6FZ7ZTp24na9mrcFXDrcoY7h
         Dl3zsggM7wuazte0PiyQlJMAo4zxn80Oa/0LTfSoScsIVBK2FMTrQhLltqhSlZaONQwv
         smniYD1ZjnLd65PzDSlkeoZuNOM1ow69jaaVFs7sGI4rwxksYtsLm2mqJUUuDZGgVbSr
         plQ0kP2zEXU6eJg96GaXtKnHZdImdyTxgrGyMRKNo5pzOJNczsU3NWevDW8yrzf2O63V
         BAN+Q3n0ylLEFY+7XJYQDU42Ci0fiSzvflANG8DTGEORL05f3HK1HJ+d+BJjXIdmOETm
         LPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520346; x=1793125146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gmv6TL1vmNzMKoJ16snZPTYX0cu4HYsfkPo0x4mSXIs=;
        b=oL3BgXT9gDI6OkgXoajAstHZrX06GE3673AFnZBDDn9eA5GmncBL5E5RoaDQ/fKPZa
         Zfg2/LOf1z+LgKdzySFtVZHgyg1akv0KbwFHXVJfjPEYk3ZU3egeDrxs5C0AZQ1WRcuU
         yfhPsTqaaE31s7oyw4S7Qt+2F8c+AbzyVcLFLsWqSn5xpU5pbgQKiYbyRPmWAPs94tRs
         CjH8ITb9mxRRU0yLxYF/bPsLDs/wSJgU6iEJiVQO8b2ZH8l4azqeT7RtfJ0noiXaV58f
         nsCNyf4of7/xF3726Wq2/iqQ546ykALbX0P5agJHFCeRURutVsSCB3O7rVd9RoNnWpLC
         as1w==
X-Gm-Message-State: AFq9FYKeNAU7IrGO9a9hyd2rlTmaMLTIxZlmLH7/ars1BS8RqTWuB9Fe
	LkbsGCf9gPb3jL0dd8PoJ8lFxt6EnXjqXj3xDeee7XJTsVLOt+mS5YfSkKaPJzKetbh91TVahA7
	ZKmty
X-Gm-Gg: AYBFou2HRDkwe6t4A90s6MqL9UMDGxCGicE8KMkwVGzMZC59wn9zkqRgE+B6BRZTmQA
	HzJCTO9onZFPxK8nEwwlANZQX6+PpRAtLE0b/kRXxPPG5gTSX5n/kVNndvjl0MVITgNxESGtuSd
	jrK0esvr8JSKr5178b6GwupLCZ+yb1kDYY4K4ETt1OC/bN+SGxNraomXLc5g0zfaWmWxNPSzs6h
	G1X3nHfOQw1jeRUnzh9t74ONBTa4RbGgHXImtPccWG6G0vxE1rNkeMUaAt1htfgceD984OZnL1g
	gSmzzwsjC4VGnX29bc810fNJo6/LMrnPa/00/bs6zO5WGFXNA1uVkpP3b4GG+K95TEgQtDN9YfS
	I1TBsUm6G22hIdAh6Iyt1WfV0lWtRvJgcJ4pKaIS7A+m2rqof71P0y+CqaVTTyIjPNclXF4qF4y
	yoBBG1WKe5mzzIC0HgenVcLPPWvVmpIXJOlRFN2s4S4/cjiMATF3552VcAin/xBtYkV2kdEYvsl
	bQc++D6GA5DaUyWUXIyPgKiq74ypJFsnAxB
X-Received: by 2002:a17:90b:1d50:b0:3a8:a98c:ea07 with SMTP id 98e67ed59e1d1-3aceebb4bd2mr8654685a91.13.1792520345635;
        Tue, 20 Oct 2026 11:19:05 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad7ffb84a8sm710661a91.2.2026.10.20.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:05 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 2/7] selftests/bpf: Add a parallel buddy allocator benchmark
Date: Tue, 20 Oct 2026 18:18:55 +0000
Message-ID: <20261020181900.6755-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020181900.6755-1-emil@etsalapatis.com>
References: <20261020181900.6755-1-emil@etsalapatis.com>
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
by the corresponding frees.

Vary the worker count, allocation count and allocation size to expose both
lock contention and cache pressure. Add the benchmark to the libarena
runner alongside the existing single-threaded cases.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../selftests/bpf/benchs/bench_libarena.c     | 100 ++++++++++++++++--
 .../bpf/benchs/run_bench_libarena.sh          |   8 ++
 .../bpf/libarena/benchs/bench_malloc.bpf.c    |  43 ++++++++
 4 files changed, 142 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index d5f494184f9d..7d2a3587971f 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -589,6 +589,7 @@ extern const struct bench bench_bpf_nop;
 extern const struct bench bench_xdp_lb;
 extern const struct bench bench_libarena_malloc;
 extern const struct bench bench_libarena_calloc;
+extern const struct bench bench_libarena_malloc_free;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -675,6 +676,7 @@ static const struct bench *benchs[] = {
 	&bench_xdp_lb,
 	&bench_libarena_malloc,
 	&bench_libarena_calloc,
+	&bench_libarena_malloc_free,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_libarena.c b/tools/testing/selftests/bpf/benchs/bench_libarena.c
index 24e432244bf5..1185a471123c 100644
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
@@ -114,38 +138,55 @@ static void setup_common(void)
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
 
@@ -155,6 +196,15 @@ static void measure(struct bench_res *res)
 	res->hits = atomic_swap(&ctx.skel->bss->bench_hits, 0);
 }
 
+static void malloc_free_measure(struct bench_res *res)
+{
+	(void)res;
+
+	if (++ctx.samples == env.warmup_sec)
+		__atomic_store_n(&ctx.skel->bss->bench_collect, true,
+				 __ATOMIC_RELAXED);
+}
+
 static void report_progress(int iter, struct bench_res *res, long delta_ns)
 {
 	double latency_ns = 0.0;
@@ -162,7 +212,7 @@ static void report_progress(int iter, struct bench_res *res, long delta_ns)
 	if (res->hits)
 		latency_ns = res->duration_ns / (double)res->hits;
 
-	printf("Iter %3d (%7.3lfus): latency %8.3lf ns/op (%ld allocations)\n",
+	printf("Iter %3d (%7.3lfus): latency %8.3lf ns/allocation (%ld allocations)\n",
 	       iter, (delta_ns - 1000000000) / 1000.0, latency_ns, res->hits);
 }
 
@@ -182,9 +232,27 @@ static void report_final(struct bench_res res[], int res_cnt)
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
+	struct bench_res final = {};
+
+	(void)res;
+	(void)res_cnt;
+
+	__atomic_store_n(&ctx.stop, true, __ATOMIC_RELEASE);
+	while (__atomic_load_n(&ctx.stopped, __ATOMIC_ACQUIRE) != env.producer_cnt)
+		usleep(1000);
+
+	final.duration_ns = __atomic_load_n(
+		&ctx.skel->bss->bench_duration_ns, __ATOMIC_RELAXED);
+	final.hits = __atomic_load_n(
+		&ctx.skel->bss->bench_hits, __ATOMIC_RELAXED);
+
+	report_final(&final, 1);
 }
 
 const struct bench bench_libarena_malloc = {
@@ -208,3 +276,13 @@ const struct bench bench_libarena_calloc = {
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
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh b/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
index 10afe4d52ebf..5d5f84310b26 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
@@ -29,3 +29,11 @@ printf "\t-------------------\n"
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
diff --git a/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c b/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
index e06397dc9a40..3c9235c56b00 100644
--- a/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
@@ -9,6 +9,7 @@ u32 bench_alloc_size;
 u32 bench_nallocs;
 long bench_hits;
 long bench_duration_ns;
+bool bench_collect;
 
 SEC("syscall")
 int bench_malloc(void)
@@ -49,3 +50,45 @@ int bench_calloc(void)
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
+	u64 duration_ns = 0, start_ns;
+	u32 i, nallocs;
+	bool collect;
+
+	collect = READ_ONCE(bench_collect);
+	for (i = zero; i < bench_nallocs && can_loop; i++) {
+		start_ns = bpf_ktime_get_ns();
+		obj = arena_malloc(bench_alloc_size);
+		duration_ns += bpf_ktime_get_ns() - start_ns;
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
+		arena_free(head);
+		head = next;
+	}
+
+	if (nallocs != bench_nallocs)
+		return -ENOMEM;
+
+	if (!collect)
+		return 0;
+
+	__sync_add_and_fetch(&bench_duration_ns, duration_ns);
+	__sync_add_and_fetch(&bench_hits, nallocs);
+	return 0;
+}
-- 
2.52.0

