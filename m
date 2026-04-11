Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5426F2A0
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866636; cv=none; b=ADmd/OMZyvQOPN3cyLsyVV1B/xjguTvK2q1tF3+uH7BiaVLgz39Mro9aXiG0h3k28sLsOvCFFJ0VBMcJqPgJQvVddSIjkQQ09QZoBNaWujUetxDNs9ix7OfUC9E9tmHL0chZiu9yk04ZstA1+7LsEDJnbnIXxedP+0irzROvovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866636; c=relaxed/simple;
	bh=SudG+jDJunOsI/OEMque3c7RwjkfU8QMeUquLEG2qAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmEvw8zmqhZ3eXtt6MxRPrN+8OPUBh488Go1vEQ4OTPKBjhGQGxtsSc+o3O3aQ0E3gpqfJxkOx7uBKUVx/1M58hTBCUTpPStz8jnryj3x+V9iiIFLinS0BOurRcvFH34FkGYy5/7Apr8JTxfEBDGs199GkTG2qOaoL6kVprmesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhzDiyYK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhzDiyYK"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so1967328a91.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775866635; x=1776471435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6+ORxmBxUJDC+8lFcSXAEheocoFoy9EPciA5CoKp8Y=;
        b=mhzDiyYKgo+/1S3/vLy2la7BlnTm7YkwmJxlcXmUBOfFd7C3CejOZTdkDDO7XQE+Ol
         vX35vwx+MUj2pwcIF2xJYC9tpLUHPQcq9/dLSV0Sc1xU0eFVEbP7RAXWbia+57tyr/xl
         RWAG2hfVmom88ci9lKx8FtEvqmCE70IjmRa744qXSW1j4o7YYSkq44KoqW0+PDVBoCnA
         WmzlS9YCHLZeN3ZApRqCs93C8eQMouIjFZYg+Bj37TWFmWf5O7d2g6clFVjxvVQT69gP
         f7LOSgYNUpziCNVO/VY19LgyqH9U6bo7K5iejtCdHS70CdXsHHVmmYuK0ZRyKnJNnwC3
         07dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775866635; x=1776471435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6+ORxmBxUJDC+8lFcSXAEheocoFoy9EPciA5CoKp8Y=;
        b=QFGhvsaAVlA2ZVFyTb4UhzYMPMFzdKcH0U320n3Dx7RHBuC2YPEpbth3lwGvEFUqVc
         LN8S84wrvpcAkodARhXkzCKDv8X5bcpMuVtAwrEYI3wMi/6ge0VDUs+u2oGxCDPKARiE
         1VI+WJRVyOTZXx3BiZ6+42WZN6Yhy8SQD5LkmzbFdNQYLlQFfBFRVKCTrhP2FxlA/ejB
         mJbUxM2Qgi7Vxe6HDD2w7PtLQbIgs01RblISIWNHfDDv4BlD+fNmjsk3bDSc97VTub/h
         4e4L3yV2mxOTJlHYravZVeU+G3ZjQ1m+lNr7z0Z61Pm7w5bQPZuIaa60JUPPLLUybwIC
         lwaA==
X-Gm-Message-State: AOJu0YzcQR8tIiu+l+x0Dp2OdoqKH7Gwt/iyWFkjOw6JqZ2BKFtv53kh
	BlZwbHMtTR2EHN4/C29xQd9PDrWvgRMps9EA6cvkbVCWXv5odpEVF9WmpNd8OQ==
X-Gm-Gg: AeBDieu9OmsC0g0Ga419qDj37BYYuu/m3Q8ZSIn1Ed0hvJDrb7DrNBH8f912X9s1sAI
	ghave3eDdTtI+hWFs2cBoWFnLn27IOvXETH51UivWjlJNMMcZrxtDmHPJAF1ORtD7rQCBgv6MfL
	2lPF168235WQT4vgOSxxzU0qyz3n9+I5n3HrD+1uoo/hSkl7e4z0WhCRdF5NgaOsxoI34tVAgFN
	EVS+05GJLzk6vm/32UdEmCQUdCTN+UDK4i5+3lhDaR8nnqeqZfsTYmVvs2UjU87CqGTPEv7PyWf
	r59rAi7gLpbYUPKlqH7SBGvi0oRmzq8O23H0OvSdp4zbyJUqMKVYOprWiqSkpbIKbZq18edXuqI
	KD+6uuvRQSbsfLa4w1J8SmdxdPEZ06jQAdLCPFsEhwxbC88CyX/UdEXlGWFwk1ZDJU9+1ZhuE78
	xy4pYuHrIvszwu
X-Received: by 2002:a17:90a:fc4e:b0:35d:9fe9:f830 with SMTP id 98e67ed59e1d1-35e430e512cmr3658710a91.12.1775866634931;
        Fri, 10 Apr 2026 17:17:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35156445sm7729654a91.14.2026.04.10.17.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 17:17:14 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] selftests/bpf: Remove kmalloc tracing from local storage create bench
Date: Fri, 10 Apr 2026 17:17:09 -0700
Message-ID: <20260411001711.3418264-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411001711.3418264-1-ameryhung@gmail.com>
References: <20260411001711.3418264-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the raw_tp/kmalloc BPF program and its associated reporting from
the local storage create benchmark. The kmalloc count per create is not
a useful metric as different code paths use different allocators (e.g.
kmalloc_nolock vs kzalloc), introducing noise that makes the number
hard to interpret.

Keep total_creates in the summary output as it is useful for normalizing
perf statistics collected alongside the benchmark.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/benchs/bench_local_storage_create.c   | 21 ++++++-------------
 .../bpf/progs/bench_local_storage_create.c    | 11 ----------
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
index e2ff8ea1cb79..71e38000ee06 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
@@ -101,11 +101,6 @@ static void setup(void)
 		}
 	}
 
-	if (!bpf_program__attach(skel->progs.kmalloc)) {
-		fprintf(stderr, "Error attaching bpf program\n");
-		exit(1);
-	}
-
 	threads = calloc(env.producer_cnt, sizeof(*threads));
 
 	if (!threads) {
@@ -140,7 +135,6 @@ static void setup(void)
 static void measure(struct bench_res *res)
 {
 	res->hits = atomic_swap(&skel->bss->create_cnts, 0);
-	res->drops = atomic_swap(&skel->bss->kmalloc_cnts, 0);
 }
 
 static void *sk_producer(void *input)
@@ -203,28 +197,25 @@ static void *producer(void *input)
 
 static void report_progress(int iter, struct bench_res *res, long delta_ns)
 {
-	double creates_per_sec, kmallocs_per_create;
+	double creates_per_sec;
 
 	creates_per_sec = res->hits / 1000.0 / (delta_ns / 1000000000.0);
-	kmallocs_per_create = (double)res->drops / res->hits;
 
 	printf("Iter %3d (%7.3lfus): ",
 	       iter, (delta_ns - 1000000000) / 1000.0);
-	printf("creates %8.3lfk/s (%7.3lfk/prod), ",
+	printf("creates %8.3lfk/s (%7.3lfk/prod)\n",
 	       creates_per_sec, creates_per_sec / env.producer_cnt);
-	printf("%3.2lf kmallocs/create\n", kmallocs_per_create);
 }
 
 static void report_final(struct bench_res res[], int res_cnt)
 {
 	double creates_mean = 0.0, creates_stddev = 0.0;
-	long total_creates = 0, total_kmallocs = 0;
+	long total_creates = 0;
 	int i;
 
 	for (i = 0; i < res_cnt; i++) {
 		creates_mean += res[i].hits / 1000.0 / (0.0 + res_cnt);
 		total_creates += res[i].hits;
-		total_kmallocs += res[i].drops;
 	}
 
 	if (res_cnt > 1)  {
@@ -234,9 +225,9 @@ static void report_final(struct bench_res res[], int res_cnt)
 				       (res_cnt - 1.0);
 		creates_stddev = sqrt(creates_stddev);
 	}
-	printf("Summary: creates %8.3lf \u00B1 %5.3lfk/s (%7.3lfk/prod), ",
-	       creates_mean, creates_stddev, creates_mean / env.producer_cnt);
-	printf("%4.2lf kmallocs/create\n", (double)total_kmallocs / total_creates);
+	printf("Summary: creates %8.3lf \u00B1 %5.3lfk/s (%7.3lfk/prod), %ld total\n",
+	       creates_mean, creates_stddev, creates_mean / env.producer_cnt,
+	       total_creates);
 	if (create_owner_errs || skel->bss->create_errs)
 		printf("%s() errors %ld create_errs %ld\n",
 		       storage_type == BPF_MAP_TYPE_SK_STORAGE ?
diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
index c8ec0d0368e4..25ca6045fea3 100644
--- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
@@ -8,7 +8,6 @@
 
 long create_errs = 0;
 long create_cnts = 0;
-long kmalloc_cnts = 0;
 __u32 bench_pid = 0;
 
 struct storage {
@@ -29,16 +28,6 @@ struct {
 	__type(value, struct storage);
 } task_storage_map SEC(".maps");
 
-SEC("raw_tp/kmalloc")
-int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
-	     size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags,
-	     int node)
-{
-	__sync_fetch_and_add(&kmalloc_cnts, 1);
-
-	return 0;
-}
-
 SEC("tp_btf/sched_process_fork")
 int BPF_PROG(sched_process_fork, struct task_struct *parent, struct task_struct *child)
 {
-- 
2.52.0

