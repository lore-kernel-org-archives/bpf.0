Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC592BE644
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105043; cv=none; b=R/QInb73ohgYlPuHXyRebiX15AFWnCTHZQa5KnDG7d0t6VH3DUkHcDxAw4EsncPTkYAm2CgE1abVtCMZjsMKV6fafLc4bniSJsLKeDejNKSD0OcDVymA7W0hhZMvH4mchEFuliNhuagHxkPUfkqp6/cwN/rakeDM3gYOG3Ob5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105043; c=relaxed/simple;
	bh=lRes9l+x3wDpNSO2Sa5JkIhFzgz9xGBZD8cX6/ZNbvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9ZIM3M30YpXgiOrFIKQSBCdGoU9WMeiTrQMJNHxIpAtjS1DnmkxEEKJcd1kcJvIZAPmBiUWeQDOEMmFcgRauMFPTDsX1rVeCmWKiTB2sEm/0vxLCZRXdUSzde4R1XJcIy3H0oj3mSBfZ61TsT6PaAHkujkzuSFYbxgZ4XUl7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex4ILdum; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex4ILdum"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4358fb60802so808718f8f.1
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 10:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105026; x=1769709826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=Ex4ILdum0dwoZUW/TV2ByB6XbbJd3iedR74aEPwXAwvHRjdBoV0VXa5wJ+09ZzV2Gj
         c6TfPgltgD8fNxOnFPgDPtFmsfH/i+WSb+sq4ZBL/P+UIu/73k+yjcG8Bihq/IQeTgVm
         P4rN5eXo90+OkYFqiuDV8z/KII6iEZVDnsqzJzE5dvcZPTTI7be+n8/M2h4YjbSdY5bE
         jwZu9hkHSpvPIsul7junKAP7qZOg7FntkAWuFDXtl69yi6pnE81+hcP4JGs4zJrrVGHW
         gzQPagj/ZHRUxRKK4xZKUF8MOPtVRgdMKHoF06IrOYorYV+sN7b2IDDpBtB/a2mbJj8K
         qh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105026; x=1769709826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4FzDrJXSiFpMM2oO5xJw4oZibyZTAtzJi/b5pFlTTC8=;
        b=X1STSxrPErok0BjVN/ErrR8N1B2WEbcBfZu2vmx3K1n0XSWJOflUlh2oqR8WpczuI9
         CWpl88GNtqrlmBVtFp0sDbURkR/5pFDjMmQVfBbNFoSU5jSLOfkzLgIGQbbzJJE/d3TL
         RShBOSarZFSke83bDAvwXHlGi4rwLxbThKOXSiU2Rfp+Mvg0MuNv0uISnFYtySvAynMZ
         5zf1FWEZ/SuS0mtoQ+jFiLv4MPG2m6BlqdePAyeV064IKppH7hGXk8s0NAG0q2auSOV8
         F7t1aMe6syREVupsxPOEnY+XppmsIHSDgEfyqQqBiFoP/HMgTRyhN/Zf4fnLmJAob4zG
         orpg==
X-Gm-Message-State: AOJu0YyRjT/C8zgp5k6lfXSGLEEKws4LcKd4E7dMVGftSGpuQOTUf5dA
	OrfGrrqGDYbNDhYl9VZsfFmcIsROFsLYaQtTwLyYIVKC6Uq3RcU8J9tO
X-Gm-Gg: AZuq6aKRMyRDT0kNbaZhpiGiBqaTbTc/wMVUIvDOrKXG1jck+9TfM5V/vaDZM2YO3bu
	QTB5YS3zWLKY3nSKFsJBwbHtHpKxTvjGi9QF+u1G8UCAaiINEqgekD1tAygKAi5xbJ7S/qo1Qky
	rZxoW/pOcqextszoORl+0DQ/8Ept2HEkzmXcsooNT1rWYsu7Y7Z2+03bs0eR5mp6Blkodi4cHAF
	66c1wcdH6RR1dFLH8MMoNtoDDVUGX3XgsBOtjDayMs9mttXa5x+MsgRCgqc7mBVP2ICFmDA6Uwi
	/jXUS7H9m8nP1dBkw4+cN71J2pFBE5UYijFs8Zvspp7LQ6DvzcWCB+hUYeRs3OWuOZvWiyLCQi/
	eSI7b43U6mNwlyiImtPz94Msw6KRVdMON+WAm86w2iDAfOI7CRXFslbtpst6T+PDEI5kgyXZGBp
	1QC0mtGcgveBZ5
X-Received: by 2002:a05:6000:2405:b0:434:304e:9ae5 with SMTP id ffacd0b85a97d-435a5f5cf4dmr6670897f8f.5.1769105026244;
        Thu, 22 Jan 2026 10:03:46 -0800 (PST)
Received: from localhost ([2a02:8109:a307:d900:df8b:2445:a6ca:bb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24a8asm429510f8f.12.2026.01.22.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:03:45 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 22 Jan 2026 18:03:19 +0000
Subject: [PATCH bpf-next v7 6/8] selftests/bpf: Verify
 bpf_timer_cancel_async works
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-timer_nolock-v7-6-04a45c55c2e2@meta.com>
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
In-Reply-To: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769105012; l=2785;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=rxvPvabdjJ7jjXmOwc3ttq22Faa0bJrvplOFprPR9ZE=;
 b=DniXDe2Fdc0CHOzFmEP7D8uc3KdAmezb4ntIAyFL5rODtjgOGlOVZWhJuBm9SJPoWi7/F+lTk
 XCJIFr0116LAYSnA13XE/VDv/aASZ/k7LGELhH8LufEgRXz/TbH15R5
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

