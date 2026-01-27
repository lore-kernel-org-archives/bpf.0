Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C236EA8F
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542333; cv=none; b=iU9P+DdxuI6G+tcJmFF4jNx1XRCVsC4lryoGkSCoU9pt/EluQ80qLZ5laBkD0YwgX/fipKW/ByiuqH3SA5L+d2MGTXL5JtAWvBPx4PnjRHdgKFaUgG5a7GXzlUSaYcAWhGwJpZrdKeXOv6A08gf3rsMik9jqnjLLkhQxYuvy5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542333; c=relaxed/simple;
	bh=lRes9l+x3wDpNSO2Sa5JkIhFzgz9xGBZD8cX6/ZNbvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFqa2KQeOnd9ubILV1eDxqDYm66fUAAXZL6svhjd3YiRV8f1j2or8p46HDMDt/LDnrb2YB0D33AFyGZpDjjEAfd2RW2nLRVtF2IxMVU4/w0Rc5Iw0kowv1W31Hm/665gFnGBnZGON0ugJVeGz+jTqNNatl9zFnDkMcEWJKwxJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW0EnWqC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW0EnWqC"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edffe5540so69826495e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542330; x=1770147130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=IW0EnWqCctSJATu9FKjCkKte1RRl3oPHrA1Q2LY8Vz5bnitnmODUr4LK0EUeDyhDFJ
         s7qbfD6uLxn99h/C0/AmiLhVeQVS1NsxQHb1Q5NTgJenXb4v018AmeROg0AP6IVv6s1D
         XmK1psYBGSZWvgWMsWEc6oWQ24WA8o3N8bljelDnJl4nnAEiYRpAQvowhUY9cMHgaWT7
         6Lem+APPR/RZ6ZlqRrkObxO5N89Km6adBtrL0u459YYQbgPjjp4/gj88tmvGIflfVXOb
         HCu1fFlKbbmqvzMNoq8tUXJkxHaFd9L/nwCCJUx0K9267F3Njj3YXYnDAH54ahB1aJn0
         5GQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542330; x=1770147130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=CHs/7WhoFmnl3sMZcJc5Jsqa/Hlo6QUPED1JgRekv5hXF8M7QVXP569CVBRTQ5b3jK
         shfKS452+E25OP0/8usoH3PgARTTjWy/6XoN3v31MVp+iUi5kCTHI8C0cCVWL9QEjbMA
         HM/A1N+LRNvbKlxDLWFF2GA1shNcxd+0sdEMC66wSFyLUCAleNNO2hkaj91bB+g4fVYY
         ULvRdMgWdfo250vq2gN3KHhQots8KZRYPj/T1fiwB5etGSXrFGnr/OLKGrPIZmQOzVrf
         5FcQzxV0SHhbnqY+AB9xeU97enLp1ei30g/u0gcHCqez8V0HuUB1q8a2RChFWVB3U5gV
         aYlA==
X-Gm-Message-State: AOJu0YzFVX/GP/NN3k9RqF41gwdd6wzC6vAWPkAVouoTdCKMXDJYp4CK
	Ojq4AwGvdeIwQALHluAHseWYDCS85OXtmxWb4e2LHA7O5IxN2SIxd4t+oEcvK551
X-Gm-Gg: AZuq6aL8b3AdV2Ue6fS5unz67iAxTVD24YT8OQEvuyqfJDCJiiQmhCZa/ee0RuCdGq1
	teh7fLRg12wSiFwSOAQt9lLkkwjcEUqFIAaz/B5umHJZG/jvkpsuaGSb+LSWN0e0yuq7WzA2Yvo
	FSVuvrNZSq9sS4M6A5jH6JY/pngEv9L9Ep5T2ZrzNnDebFwkuE4FzSF/74WGw5EvFjup4E42vCn
	sc277MQRhEL/BB4SHlBgIYwVwE7MnZ8Sj/geXRadZp6Vv8kVyWD24HpaGg2NwkQdsoB/iNZaNnn
	FZcC22vdpYfvumOLB4/wFr3x8fASi07Ch5CU/EbFK0i/8U2jCmB1OqFmKail+LhyaMhWnzth+9w
	ZYukehHWZeB+I9aD4x0gMuv2gMexgsr8zjz45GlRwUpm8RaPD/VCVQKJi77TxKRqaOKuvfNT1Z6
	o6Hf+oG9nhK15g3B+v0pXiuP+aPlq1EQ==
X-Received: by 2002:a05:600c:1da8:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-48069c165c6mr43377965e9.6.1769542329939;
        Tue, 27 Jan 2026 11:32:09 -0800 (PST)
Received: from localhost (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806df6056esm1283215e9.2.2026.01.27.11.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:32:09 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 27 Jan 2026 19:31:23 +0000
Subject: [PATCH bpf-next v8 6/8] selftests/bpf: Verify
 bpf_timer_cancel_async works
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-timer_nolock-v8-6-5a29a9571059@meta.com>
References: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
In-Reply-To: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769542292; l=2785;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=rxvPvabdjJ7jjXmOwc3ttq22Faa0bJrvplOFprPR9ZE=;
 b=jzSGUjrGobaRFB9ST3QQIjCXX0i9CIrAxuc6oEbVHvvPSQJCMBMxDV+tjEZLuzwHOozrqo9qC
 SBInGj1ZxDDCnOwgMLW0t0BCUMS0njzH2xEp5RJ6fz5sqhXTBYzAqbI
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add test that verifies that bpf_timer_cancel_async works: can cancel
callback successfully.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 25 +++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/timer.c      | 23 +++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index a157a2a699e638c9f21712b1e7194fc4b6382e71..2b932d4dfd436fd322bd07169f492e20e4ec7624 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -99,6 +99,26 @@ static int timer(struct timer *timer_skel)
 	return 0;
 }
 
+static int timer_cancel_async(struct timer *timer_skel)
+{
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	prog_fd = bpf_program__fd(timer_skel->progs.test_async_cancel_succeed);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	usleep(500);
+	/* check that there were no errors in timer execution */
+	ASSERT_EQ(timer_skel->bss->err, 0, "err");
+
+	/* check that code paths completed */
+	ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
+
+	return 0;
+}
+
 static void test_timer(int (*timer_test_fn)(struct timer *timer_skel))
 {
 	struct timer *timer_skel = NULL;
@@ -134,6 +154,11 @@ void serial_test_timer_stress_async_cancel(void)
 	test_timer(timer_stress_async_cancel);
 }
 
+void serial_test_timer_async_cancel(void)
+{
+	test_timer(timer_cancel_async);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index a81413514e4b07ef745f27eade71454234e731e8..4b4ca781e7cdcf78015359cbd8f8d8ff591d6036 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -169,6 +169,29 @@ int BPF_PROG2(test1, int, a)
 	return 0;
 }
 
+static int timer_error(void *map, int *key, struct bpf_timer *timer)
+{
+	err = 42;
+	return 0;
+}
+
+SEC("syscall")
+int test_async_cancel_succeed(void *ctx)
+{
+	struct bpf_timer *arr_timer;
+	int array_key = ARRAY;
+
+	arr_timer = bpf_map_lookup_elem(&array, &array_key);
+	if (!arr_timer)
+		return 0;
+	bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(arr_timer, timer_error);
+	bpf_timer_start(arr_timer, 100000 /* 100us */, 0);
+	bpf_timer_cancel_async(arr_timer);
+	ok = 7;
+	return 0;
+}
+
 /* callback for prealloc and non-prealloca hashtab timers */
 static int timer_cb2(void *map, int *key, struct hmap_elem *val)
 {

-- 
2.52.0

