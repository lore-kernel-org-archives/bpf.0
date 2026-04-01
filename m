Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9CE44105B
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051491; cv=none; b=TD8k3whaqaMzXw+7fSnQ5PJ6jEzgWIs9NhsEl9BVZJzUbFVn+e6XdIy1VRscEaMssIollGS7lrL0V3EGk/q7rolnk+RRQ9GxnA++QraPUP5iE2C9jXRuw/ll6PtL3smVnTExL4AMRZ2jLBa27Tj3ioehjnrDTs/DodoXhacBGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051491; c=relaxed/simple;
	bh=W7b/pPPiD4RFNLg/CzzpNLn0ZtWiqWm/+bYntF4S3mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNgiIWCDH+5bIMRKlMB7Gj+u7eFXKQ71Dtf1qTVWEEYwgkSVxdcgxthYX9oUkGtL24SH3xD9h3lVZLc2G5GzpJSOR90Bs/CMXxQGaJ65Xg+Doql09Nd2QRhxWYk9L0kTQcEz8pG7ACboqZ4VzIgYcr/oGBJzEAe07vj00tkWMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8bWCLjg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8bWCLjg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so54734815e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775051488; x=1775656288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8I9WYnBfy6HTGWCjHpPWQRPspo43wY0V7PnrObm4Wc=;
        b=j8bWCLjgwrkOKX89Ie4mwwxyEN3NDwxdlsKQMBWEtGC5y/iSRfDHUFI5qfmAvlv2xU
         REwDCJlX9jPI1eCgGq98bzk5cBGy7A/1D342YV6luMkyOD0xHW3IOjgm4Va8xxdxwJ8Y
         MdDoLuFbrh/Msl8eMWywsnmA7zeTSUhBq+rgswzptQ4r1mimTsAXJBrfx7Z3MAdTHDJJ
         tTKfgIvaPRQSrFy6t37Ij5t3BMJI4X3Dqcpeba2kisxw7RhtuKUJpw7L+mlezJkWUf71
         bW39+MsgfPIjEdzQ1sIsS0wQIbwUkL4oyJwt5cyu4xGsWuEdX9ohRwC1+W/2rSzAYzii
         eZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051488; x=1775656288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k8I9WYnBfy6HTGWCjHpPWQRPspo43wY0V7PnrObm4Wc=;
        b=K+dm5cGDWbTt12+wigNSXafvPNMAT3nAwovSKa7IU85y1B4nkhG1+1MC/IxZfk1ERj
         n/eObiHVfQlwqKZ1nK4e4tB/H3ERpTrSX51093MPXGoBtXXdNam86DrkGs1Am3uvMvct
         61ZsTINestgqWaL7CB9rzgrCyQsD2q1aNTEY6yHSJzwhbwPgSlDuluLk2ptg1UDQn/k0
         lHG4twYBdzSWZ8rBeKuYH95XyH/+7mJrTSf8wt5BOVujm/MhHKQfF6BigVaBubYVneJ7
         TqAZo92TQoxKkrzUa9PuOZJfqW1VYHasHdsHvAOTQNMaQbrcoq/YDgLTSeLSKLtgS2mz
         uXNQ==
X-Gm-Message-State: AOJu0YyWofrC2c5h341TvamhXezEBEB3JwAay96A9EzMc9Pc55lj1A/b
	hbNksyNOz4hE79ApAIfRo6D7+Kfq3eUf668Xs+TJq4yjf7nnQjbfbshe
X-Gm-Gg: ATEYQzy6FnYAQDWOQsyO2GDfNmXrLdbtL6LXsurDoVgcQLFIFY04U4n3kVrEVVsWpal
	4+0n6b9xhn5yKuWFFjGDRJ7zTCA4X1/anK98cQEsm+s7ZGs6TRlzJ/3whupcrXBI0KDInrb6e8D
	PH5nQ1WdrWEmtlpcfK6dd3RvA18MdsUPfg7XuaY0NVcdjPc+sbbkhzUo0Sqq88PGL5F5FT57Yjx
	8gikB6m3Npk5YgqtCsL8dNgKxqxGflA7CRRNkinYrdGwUw/F5liv57qRgTWFZsVHq/nN7+A8GwE
	XRp8EcHVKFzQ9IxIAn0ugx1HcRZ2FNIOmgAcK+ElVSwvMwYAgkXV9SlKZeiRPGPE2i9IRJmbOqz
	P2DTcGMVBfbeF5WDJeTrgLsrGmZVQ+fI9DOvd44uidomNI2ZJiTC0L+BcwtCMPZ9PP48qvOeTu0
	sZ2ylXIs5B1T0r2eltllMwrULQ
X-Received: by 2002:a05:600c:6986:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-48883595078mr61434225e9.20.1775051488136;
        Wed, 01 Apr 2026 06:51:28 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4c::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm108166835e9.12.2026.04.01.06.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:51:27 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 01 Apr 2026 06:50:37 -0700
Subject: [PATCH 2/2] selftests/bpf: Add torn write detection test for htab
 BPF_F_LOCK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-bpf_map_torn_writes-v1-2-782d071c55e7@meta.com>
References: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
In-Reply-To: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Aaron Esau <aaron1esau@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775051483; l=5898;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=LsrU46IwQ/WkZJUo5rdzn1L60KvmtFhPiv3uoGPW4MA=;
 b=UvbX4KURex1NvHdFX7eMD4KLgLPEEd61e7jHeTGgSn9yDdvPzDkl83E7lZaWk4Qsp0S7Qqs7V
 R9PdU707Ex5CZGzf5J0PXWXXcSqvWspz4d+bXls+mh/yK2edmPp9jB2
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add a consistency subtest to htab_reuse that detects torn writes
caused by the BPF_F_LOCK lockless update racing with element
reallocation in alloc_htab_elem().

The test uses three thread roles started simultaneously via a pipe:
 - locked updaters: BPF_F_LOCK|BPF_EXIST in-place updates
 - delete+update workers: delete then BPF_ANY|BPF_F_LOCK insert
 - locked readers: BPF_F_LOCK lookup checking value consistency

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../testing/selftests/bpf/prog_tests/htab_reuse.c  | 169 ++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/htab_reuse.c     |  16 ++
 2 files changed, 184 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_reuse.c b/tools/testing/selftests/bpf/prog_tests/htab_reuse.c
index a742dd994d60..d7c3df165adc 100644
--- a/tools/testing/selftests/bpf/prog_tests/htab_reuse.c
+++ b/tools/testing/selftests/bpf/prog_tests/htab_reuse.c
@@ -59,7 +59,7 @@ static void *htab_update_fn(void *arg)
 	return NULL;
 }
 
-void test_htab_reuse(void)
+static void test_htab_reuse_basic(void)
 {
 	unsigned int i, wr_nr = 1, rd_nr = 4;
 	pthread_t tids[wr_nr + rd_nr];
@@ -99,3 +99,170 @@ void test_htab_reuse(void)
 	}
 	htab_reuse__destroy(skel);
 }
+
+/*
+ * Writes consistency test for BPF_F_LOCK update
+ *
+ * The race:
+ *   1. Thread A: BPF_F_LOCK|BPF_EXIST update
+ *   2. Thread B: delete element then update it with BPF_ANY
+ */
+
+struct htab_val_large {
+	struct bpf_spin_lock lock;
+	__u32 seq;
+	__u64 data[256];
+};
+
+struct consistency_ctx {
+	int fd;
+	int start_fd;
+	int loop;
+	volatile bool torn_write;
+};
+
+static void wait_for_start(int fd)
+{
+	char buf;
+
+	read(fd, &buf, 1);
+}
+
+static void *locked_update_fn(void *arg)
+{
+	struct consistency_ctx *ctx = arg;
+	struct htab_val_large value;
+	unsigned int key = 1;
+	int i;
+
+	memset(&value, 0xAA, sizeof(value));
+	wait_for_start(ctx->start_fd);
+
+	for (i = 0; i < ctx->loop; i++) {
+		value.seq = i;
+		bpf_map_update_elem(ctx->fd, &key, &value,
+				    BPF_F_LOCK | BPF_EXIST);
+	}
+
+	return NULL;
+}
+
+/* Delete + update: removes the element then re-creates it with BPF_ANY. */
+static void *delete_update_fn(void *arg)
+{
+	struct consistency_ctx *ctx = arg;
+	struct htab_val_large value;
+	unsigned int key = 1;
+	int i;
+
+	memset(&value, 0xBB, sizeof(value));
+
+	wait_for_start(ctx->start_fd);
+
+	for (i = 0; i < ctx->loop; i++) {
+		value.seq = i;
+		bpf_map_delete_elem(ctx->fd, &key);
+		bpf_map_update_elem(ctx->fd, &key, &value, BPF_ANY | BPF_F_LOCK);
+	}
+
+	return NULL;
+}
+
+static void *locked_lookup_fn(void *arg)
+{
+	struct consistency_ctx *ctx = arg;
+	struct htab_val_large value;
+	unsigned int key = 1;
+	int i, j;
+
+	wait_for_start(ctx->start_fd);
+
+	for (i = 0; i < ctx->loop && !ctx->torn_write; i++) {
+		if (bpf_map_lookup_elem_flags(ctx->fd, &key, &value, BPF_F_LOCK))
+			continue;
+
+		for (j = 0; j < 256; j++) {
+			if (value.data[j] != value.data[0]) {
+				ctx->torn_write = true;
+				return NULL;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static void test_htab_reuse_consistency(void)
+{
+	int threads_total = 6, threads = 2;
+	pthread_t tids[threads_total];
+	struct consistency_ctx ctx;
+	struct htab_val_large seed;
+	struct htab_reuse *skel;
+	unsigned int key = 1, i;
+	int pipefd[2];
+	int err;
+
+	skel = htab_reuse__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "htab_reuse__open_and_load"))
+		return;
+
+	if (!ASSERT_OK(pipe(pipefd), "pipe"))
+		goto out;
+
+	ctx.fd = bpf_map__fd(skel->maps.htab_lock_consistency);
+	ctx.start_fd = pipefd[0];
+	ctx.loop = 100000;
+	ctx.torn_write = false;
+
+	/* Seed the element so locked updaters have something to find */
+	memset(&seed, 0xBB, sizeof(seed));
+	err = bpf_map_update_elem(ctx.fd, &key, &seed, BPF_ANY);
+	if (!ASSERT_OK(err, "seed_element"))
+		goto close_pipe;
+
+	memset(tids, 0, sizeof(tids));
+	for (i = 0; i < threads; i++) {
+		err = pthread_create(&tids[i], NULL, locked_update_fn, &ctx);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto stop;
+	}
+	for (i = 0; i < threads; i++) {
+		err = pthread_create(&tids[threads + i], NULL, delete_update_fn, &ctx);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto stop;
+	}
+	for (i = 0; i < threads; i++) {
+		err = pthread_create(&tids[threads * 2 + i], NULL, locked_lookup_fn, &ctx);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto stop;
+	}
+
+	/* Release all threads simultaneously */
+	close(pipefd[1]);
+	pipefd[1] = -1;
+
+stop:
+	for (i = 0; i < threads_total; i++) {
+		if (!tids[i])
+			continue;
+		pthread_join(tids[i], NULL);
+	}
+
+	ASSERT_FALSE(ctx.torn_write, "no torn writes detected");
+
+close_pipe:
+	if (pipefd[1] >= 0)
+		close(pipefd[1]);
+	close(pipefd[0]);
+out:
+	htab_reuse__destroy(skel);
+}
+
+void test_htab_reuse(void)
+{
+	if (test__start_subtest("basic"))
+		test_htab_reuse_basic();
+	if (test__start_subtest("consistency"))
+		test_htab_reuse_consistency();
+}
diff --git a/tools/testing/selftests/bpf/progs/htab_reuse.c b/tools/testing/selftests/bpf/progs/htab_reuse.c
index 7f7368cb3095..1c7fa7ee45ee 100644
--- a/tools/testing/selftests/bpf/progs/htab_reuse.c
+++ b/tools/testing/selftests/bpf/progs/htab_reuse.c
@@ -17,3 +17,19 @@ struct {
 	__type(value, struct htab_val);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 } htab SEC(".maps");
+
+#define HTAB_NDATA 256
+
+struct htab_val_large {
+	struct bpf_spin_lock lock;
+	__u32 seq;
+	__u64 data[HTAB_NDATA];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 8);
+	__type(key, unsigned int);
+	__type(value, struct htab_val_large);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} htab_lock_consistency SEC(".maps");

-- 
2.52.0

