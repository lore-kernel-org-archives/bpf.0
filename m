Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540106;
	b=HdgXoukViXB8nqBWANzoPf4lEBcvEFl/6sdSqZJ0r7RSYuvAcYW0k3IME3Mxb2OReUfZ
	 8qiG2in6ijC7WT6SZaOTHl/UotZSVZQYwVtUDD+o1AhOEcJf1BRGfmT2E2pmUslWiLa+P
	 xTEp69e+PPTZPAaqBvYJsNtETZYmCTGLpmde/zlXTwcycX4l+i78BpiFfFOu6LJGd4MVA
	 RxywaH7tGvhuWBRH5rUmZ1Zju7AlnRWp6GpguVB/xqjDc0q2Kt6PrUeyfjBXCTxxmFeCO
	 lkSl6W7H9RAjDoJ7cmtpAQ2onUsjqVLXRUVTy69P8EmbsE/5yy14y4nkDadTCRdGSVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ihAzbH9XqGovnAUeVwriHbw+7aq2SdtgK0asGJLKaFY=;
	b=lt4xFttHoZWFs4DHrNiQKCXwLd5dS1bYSiZfbhT6u/uozYHwqB2Wx5u8dF8Z5j5Eji2P
	 YhBplL187hWpTwIv9SjcEnosiqNp1BvgXHV0Dubm5+dDhCXyFMXs9InAEMm6rRIYr35nI
	 eD9ZkJ4A4j8X+JGXTPe8NZ2yh7sS3qKVs6aEWZd+EEgddGlgulG4Hrwl8l6M1eozRGIG1
	 7GZ3hyOGgr49OoUN96O5z1MGtn8n0C1CnMaCr6BDKSlAZknqLhhIo8vdujDZE6rVnSYeT
	 txwNAt4FgRPy4Oqh5NhJFjUxodlQDqTDWuPGKLSHoEJP0X9DmsKkQDI542TVZ5Uis7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zsa3tW3h;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7B60A2618
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AD7B60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zsa3tW3h
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8629c7cc36eso2741061a34.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795540105; x=1796144905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ihAzbH9XqGovnAUeVwriHbw+7aq2SdtgK0asGJLKaFY=;
        b=zsa3tW3hWC8onib2lcpW6aqnrwbyxJrYRbLRPudy0wqN0AgJ9X3VDeNNQ8k39Ab3I8
         7egA0zyF9wxATxZDWViTKv8pVqI5O18T05ANiD77Gef2qJ78KlY6kH+5vuM9mh/rDnAh
         iDJzN83kqedTyD4zmNYDP53CMtBtdM/AGF5KeHqgZmKLVem8QBl+SW8F4DRsu6fFAIcg
         rSTs1dY2cpUiDc9VsKQe2ajx3nIV3TCVwexOpQYpcbOrd9tQKguUMdjbtUKcdRl+5VTS
         ob0+WRTZG5epReXq5/OAzxPvYtTg0qw/9jz/r1UP6U1/xVB6QJKf0nmoScdT4EIx88v8
         xGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540105; x=1796144905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihAzbH9XqGovnAUeVwriHbw+7aq2SdtgK0asGJLKaFY=;
        b=T5Lmo6arkxDlsu8Ap09YXhCd8+6d2uP1J2IRDYKJ/ZcONIakzoq6GnFfxKEgQIlZY3
         W8Hm8UQUgDQ/NMjiSS8v+7GlLSYjnXc/FG6/KjdMZjsXho5T32JkrFgCQzEqVeonvMBf
         dbXiBxF1fmeDhSIeITFuC3vJPNFM2SfKq/U1Baj2VOASrfre56uoXyphMCu4mrhDhh1U
         WjtiSbdX5QuZcFZDXwI16xZHmStSF1GcwaA0/utvaEXOoVY1I2nKHOPZ0Z/umxm6jKES
         H7bMb1CsKzACHPN5TUK2JRJJNyvjuuYGABMRXIa96i6D9ZfwaG85Osx12ZoeK5ItM+7c
         1+Og==
X-Gm-Message-State: APuU4Z8qd2BC1rkFXbw5pU6MHs0zKx4JnGC9TeIr4IU2o5Gm4Dqj5+Iq
	BgW+EqCzhLxTdaRavrCdSz87VoEDAvDgzVGMxB4C/gOkC9xCcmWWvCdF
X-Gm-Gg: AZFdTZdiz2XWDKR0vhs1yv2e96oJKLW6XEAsytn4ElMo4v5Vslvgt+JgRthi3DPUmzp
	8D1+I1y/JnP+n7TQGey9Z466GFuEc72eRsOk+AzsSpcj4e25lov0o0HWzDPkg825AY1mgovcTjg
	tOgQlh3uzM40omn9I9TUl5JQgHz90odYAAha/WSSKWYYKFY/EKXi1cTILpyTCKmSUF9/hhLqSzP
	tQpDsnAAJgGjcS19Nt4CL6+PNlYSYQciXJk/UT2aXLVhQjggWTT5rhnvGsTeFWPf2pu9hAcGkKr
	CML57uNcCmZ0JdVvSNp631dXlUuyh/WHYC4zgQwwaCsYgcbp7oALQ8THGeiBp5SZmy28SMxKwby
	wwayXnY2jd6OZjhmiUkKM2QTDvPVgWc+bMXIhbCTTtJ5ePeSP5TLn/BYxjXLbP+rb/X5jSeUPen
	O/kVlNDG8u059DL+oDjsSAYWhCEbnEDCcPU7NoriLtR3vvAAnA1uWuKbuwplngWEICEd06SOeQD
	ivfkiBKwYO5QsRlz9/CLZQZRLtwBfV+y0AYchbDp2i1yILQUAM94rCiAGsmpORqT/ybKyJSYAWR
	a4TkvtCo80H3o7J8ZQNq
X-Received: by 2002:a05:6830:82f6:b0:85f:ee8:26c1 with SMTP id 46e09a7af769-86315994ac9mr17465366a34.22.1795540105038;
        Tue, 24 Nov 2026 09:08:25 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f3964sm11122591a34.14.2026.11.24.09.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:08:24 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 24 Nov 2026 09:08:09 -0800
Subject: [PATCH bpf-next 2/2] selftests/bpf: Fix flaky
 verifier_arena_large/big_alloc3
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-arena_big_alloc3-v1-2-141c26210bff@meta.com>
References: <20261124-arena_big_alloc3-v1-0-141c26210bff@meta.com>
In-Reply-To: <20261124-arena_big_alloc3-v1-0-141c26210bff@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 ihor.solodrai@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795540098; l=3526;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=USXagIggHhdZKzAO/+hhf4kRA1OlHQ5yTr4B4aau3Co=;
 b=7Bt3kn1CjgI9QQXVo/4Nhw5CoA6tq36p8KFykFtjfR6vKJIakmcRCzpOvdtRK4xPCQLPxHNgo
 DwopOTKXwWcDIBWoxo0l5Go5XyxNyvs5cmjIDmbMganZkKdR6rL8U/D
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

big_alloc3 is a nonsleepable program, so bpf_arena_alloc_pages() takes
each of its 1025 pages from alloc_pages_nolock(). That call does not
reclaim and only uses trylock, so it can fail when memory is low. BPF CI
sees this on aarch64 as "Unexpected retval: 1 != 0". In a KASAN VM each
arena also takes 512 MB of shadow memory, and verifier_arena_large runs
in parallel with other arena tests.

Commit 317a5df78f24 ("selftests/bpf: Fix verifier_arena_large/big_alloc3
test") counted a failed allocation as a pass. The commit below made it a
failure again. Both results are wrong, because the check did not run.
Report SKIP instead, with __skip() __retval(1). big_alloc4 still checks
the sleepable path, which can reclaim. Also run verifier_arena_large
serially, as commit a14f9ba080c1 ("selftests/bpf: Run arena tests
serially") does for the arena_* tests.

Fixes: 0f6512272538 ("selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c        | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_arena_large.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 816ab3cfafc74..f6bc573886b41 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -233,7 +233,8 @@ void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_arena_cast(void)           { RUN(verifier_arena_cast); }
 void test_verifier_arena_stack(void)          { RUN_TESTS(verifier_arena_stack); }
-void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
+/* Serial, as prog_tests/arena_*.c: each arena takes 512 MB of KASAN shadow */
+void serial_test_verifier_arena_large(void)   { RUN(verifier_arena_large); }
 void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
 void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
 void test_verifier_barrier(void)              { RUN(verifier_barrier); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 89f32a7772ac2..e6f7adc90c6be 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -284,6 +284,7 @@ int big_alloc2(void *ctx)
 /* Nonsleepable because it binds to a socket program. */
 SEC("socket")
 __success __retval(0)
+__skip("nonsleepable allocation failed") __retval(1)
 __skip_without_arena
 int big_alloc3(void *ctx)
 {
@@ -291,7 +292,13 @@ int big_alloc3(void *ctx)
 	u64 i;
 	int err = 0;
 
-	/* Verify that a nonsleepable allocation larger than 1024 pages succeeds. */
+	/*
+	 * Verify that a nonsleepable allocation larger than 1024 pages works.
+	 * Each page comes from alloc_pages_nolock(), which does not reclaim and
+	 * only uses trylock, so the allocation can fail when memory is low,
+	 * for example in a small KASAN VM. If it fails, return 1 to report
+	 * SKIP. big_alloc4 checks the sleepable path, which can reclaim.
+	 */
 	pages = bpf_arena_alloc_pages(&arena, NULL, LARGE_PAGE_CNT, NUMA_NO_NODE, 0);
 	if (!pages)
 		return 1;

-- 
2.53.1-Meta

