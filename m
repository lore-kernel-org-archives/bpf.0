Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6D2571A0
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872463; cv=none; b=l4ndP3PAD9x5TxYLkxAt8ns8vZtNQbdmkDSBCxBPhGqH5SiKL3hwAZT9eNP7XgGJWx9rHYBvvThckFUbDkxP/lrzcIDOkW5pm8H8+W3S4H7qPCSMaKzlv3CzcoBcMeB4++ntR7aTRFzEnbxd/wiWrdtMntG6mHV4bKc//TFPcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872463; c=relaxed/simple;
	bh=SudG+jDJunOsI/OEMque3c7RwjkfU8QMeUquLEG2qAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUYgLWF4iHDnRacscHKD+4vuuw7Z5kZNUsl5i1Ekd9ADQPtPvDIXUP9tjMdJTFIZ2gf2VsjO+w45MaqGQcxu9W/Mv54GUQI5PCytDVZ9XLedUg5lQcSO3u4I80D+DAG+jPxVrFjToNdd6iBN73+WonnYwt+kTFkBbq87E+8yoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZLK//Kr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZLK//Kr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2503753efso22323695ad.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775872462; x=1776477262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6+ORxmBxUJDC+8lFcSXAEheocoFoy9EPciA5CoKp8Y=;
        b=bZLK//Kr03FTFNLQsZWxuVvvhzkGb16SeRv1kX0HPT0UA51pwK5Q4ymFSl7/MqPjQW
         8vjv1KDZ3JqDe8AwO9w8AYFqnUcmu78vDz1C89+HUEW5XVGSyg0xlh2uPLGoLrdIxNpu
         WXBmV5kXf0VvxDIKERPfzzAonBhnDprx0df6L3xFjG3jDc7F+ltUZSm9rFtFxwC1a/zG
         E0GLeYZmbvJac804c4ReC/ULOv6J+E+1E0sObDz40v54pxc9KxQNhpwfKUfCD1Wea/2A
         YyXL7WwV8KvvgE2YSoIOkpKDPJoQE4FGu8Q14MWojFzKVzkekBCbSYv3NkDQos42P5h0
         agiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775872462; x=1776477262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6+ORxmBxUJDC+8lFcSXAEheocoFoy9EPciA5CoKp8Y=;
        b=NWopGmOTptTLZ5mCdeFSBxslrWkEJgYIcpQ17wAumktPrGBVyOWD5D0tIiwMnB+aQY
         2i/ehsJb2NNNtP/Km5f8gbJXVyZNEZMq9LbF9ohLQwE/SUITrm4z1oQsYb46KBrKnqnC
         CsPzV9q13C+wu+Sw17sLQk+DlyJ6d2mndVwiiggR4+TJRyABt1Li2x1JtR28rEbdyTIb
         AQPHwwc0PSt2dXeOl11ND+3IPwNSbkDGpzgEYXG09xOHSjblYwT0m77Lnq4NIRGook2b
         hancZXuV/B4Wa8E1x+eDd7mMDMC2nMZEf8tm1pRejX+0MGLcTVut5V6NAiQwKJ+cH5XR
         QKEg==
X-Gm-Message-State: AOJu0Yy5SnV50n/Yi+w5SyOJl95U/inYrSoz+JzDaUel7eq33FMuRmOJ
	jHa6V8YQz8iW9OYv+ffXbDNS8Ve80dx73JDgCFNbUicXIpnyqdElrt9kMe3ubA==
X-Gm-Gg: AeBDietZIK75ud19PNvPQfcrPxlLAOs6tdroLY01EzMdpVnLknVrTXr2heyblIQ8RsP
	EEqxrvT3Xzp3N+96YIwyvwKC3vkhVYAs7OCsjMeDKfk6hBD9ZVHREz6GFwZPvawXDlgwleUgoq1
	HLdvgpGWWlR+THVLKZiIV3ewcU910ZKnl3W0JLN/svBdo015fCQ1mcSJl98tyn2cz+NMXraucLf
	FQC0PMDupLevzs8ueFI8jlMxycHxbRZQpuCJP1tBmKhJpDQT32RZHlv2U3pFfh6+aTU4cx7Dla7
	a9T3DDb8BBpcu4CWMMujAltkaPkw5Yr1mk/OV/26b1r32Z0zk/tC3dM/MCtMoL+YL8QDXvb3u1q
	PYC8avntvBWeydE+9zzzCckXXbjOKR36a6wcugm8aL9/4dDEcIeyHZNRxXDVmO8EPQU4FkI/T4J
	Sp6pat4vTWRSFDGA==
X-Received: by 2002:a17:902:cf04:b0:2b0:5b4e:370c with SMTP id d9443c01a7336-2b2d5a5d686mr62852115ad.32.1775872461485;
        Fri, 10 Apr 2026 18:54:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd5cfasm53672975ad.18.2026.04.10.18.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:54:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: Remove kmalloc tracing from local storage create bench
Date: Fri, 10 Apr 2026 18:54:16 -0700
Message-ID: <20260411015419.114016-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411015419.114016-1-ameryhung@gmail.com>
References: <20260411015419.114016-1-ameryhung@gmail.com>
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

