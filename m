Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2810B3A63E3
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767350; cv=none; b=W5JfPUqwC9yQq4ihhcFmm+I7HZOiEBaS/wjmUheO5hC0QA39x9YlHR0GD8z6sAQlwPHZhZe+O+O3C7sK/y2Qk1ZLhc/kGMR8ZHLm1hivOoRWCliqHzuUP5ak1Bfxbgj6GOtPyu/v2TzJyJKl25EHwZf1rQUGoupevb64aEyQ0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767350; c=relaxed/simple;
	bh=g7AYFduwT60b/J50Hjj1pQ5hfYl06MRg/nUpLEBBe/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4ve0Tf0aCPSXiY0gyXnabcd3JEUSo1GVSGtOUIGq9t+pwOkAbfJZaL+0OAZ4bmYHcnK/JtKk8Hz7X3kURoHoNWkYisdyHmCgRDTiSmFcgr4yWuDb8PvEFduwAaAkOHIR2+L5RaE+PdcFTlpe8zfFnuQZwoV+3k6bzEDOpsNHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVgwvbdk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVgwvbdk"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f69a286dbso3186998b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776767348; x=1777372148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N79AG4N3cdSrxtjy6zkabR96oBPnoMx/cGNJEHD91s=;
        b=hVgwvbdkIyeY1GWTpTAUcnEDcgAucqiaQ/glG/B7vQagYglfDSJvU4P4F+bqcCAHtg
         i4GHpF6hn2lBsYlUuDwOn16MR/brYMohEomwVUrMul8p+bN9obiEs6/N82M4/XuS4JJy
         3EvtvK6Xu8sl2dCCC78zc4yEBlHTCS5l+5IFGDXfw/MS+1lfC8Leiib6Azv1piOQrlfD
         Zib4mMgg4kIw7NRo4nNgS8TvHAHqpYro7K1S/vfakGbCD7BDS2wh8J6Lvb13wjOcr6vw
         jj1SsBtzyr1AQ1tnTZIUVF6mKP+GtTKhb8NUsTXOSkiMPL8k+VoKx3rKVVYi8ijpowr7
         eO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776767348; x=1777372148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4N79AG4N3cdSrxtjy6zkabR96oBPnoMx/cGNJEHD91s=;
        b=sMD1eibc7PgYU9VNWip8UMyoukJDPBtK+nHupqilCWtXdXuDpj8lRewdd/n/zcryLM
         aeaU0LUpgyVTkRRwEh20D3js0P2PQQwoYPoou4N3Ak60y/bAUYaXy6ROLFEM+60+JG2i
         njB4M1hs8FZWatyjaUq04MoyhA+1spyZ9eEdFuHzfnBNNnm1P91o/x5uwsUtclZY0H1Y
         JnPlQhK1QwtBVdFX8L0QYrLAka+wtUNsASJOj4Xt37F2zum79axSf0uoyEyOlxfhM1fW
         GVmmWGmVPzHdOM2f6Wf49scRMbvJ4UfUFi08GNYQ/IiZPpdNv99tB2h9ImocWkOyNIEg
         +y4w==
X-Gm-Message-State: AOJu0YyVgofV7+ngLmXNAoJcLRkHlZxmYiZnAtuKsJFndnxnpgogMzoz
	Lvr6TnFX/7Py9wp3JMYk6493KdG4f1JK1mmkr8k/9+j81PaQtAOxEBsDUBJxEEdu
X-Gm-Gg: AeBDieuLQ1Lgcd8NHAOk95alHhMI9ea7hV231i7HLNqlSg4LheuAQ/FRQN9FeZ8HnHN
	QSEC4bdgTQjLNm0Zzgpcm/ayq6KxZTtSEAPJMxbGbIqnElsUrDscCm6IQtVXyLxLIEj6WtMqaKb
	5oN0CSEMh8P+szhEpjzwHUOh5IyEwaURBKLiEgCe7PT40EHZEIjh6nrwFi5LlhTuvDIB46q6QHF
	0dV+pUZeOHnnfqfIG7+s8UBplcHlNsfv46xG/T5rNiWCIYafj816m8qGAUrosAZHIzHJQIlS+75
	ut73dWG3iuylYskyBgGW6gnzbAWoZbAS8WRWvi4uSSwXaRdWKMizh70bseXTtnaOIjTWXnzW5w4
	IywhV6OsuFBYGfQmCddclvjBshv9IAP5l9YTeNq2xzjAvkcjrq8PkEDUVYfVVP0Jfj6tyz+uIjT
	rP1lQ/nCQNtvapW//ue1B3ncKKyR6xng2g+U1qL++pO/nePkw9qf1turFUJpN0/s4+pY91eztB4
	/R2OQ==
X-Received: by 2002:a05:6a00:2d06:b0:82c:b808:4c59 with SMTP id d2e1a72fcca58-82f8c93901amr17689079b3a.46.1776767348291;
        Tue, 21 Apr 2026 03:29:08 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm16135000b3a.1.2026.04.21.03.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:29:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com
Subject: [PATCH RFC bpf-next 4/4] selftests/bpf: new cases handled by 32->64 range refinements
Date: Tue, 21 Apr 2026 03:28:52 -0700
Message-ID: <20260421-cnums-everywhere-rfc-v1-v1-4-8f8e98537f48@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

1. 32-bit range starts before 64-bit range's low bits in each block,
   causing intersection to skip entire blocks.
2. 32-bit range crosses the U32_MAX/0 boundary, represented as s32
   range crossing sign boundary.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index f0b3fbbbb627..1d38f809c559 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2187,4 +2187,84 @@ __naked void tnums_equal_impossible_constant(void *ctx)
 	: __clobber_all);
 }
 
+/*
+ * 32-bit range starts before 64-bit range low bits in each 2^32 block.
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||----|=====|--|----------||----|=====|-------------||--|-|=====|-------------||
+ *       |< b >|  |                |< b >|                 | |< b >|
+ *                |                |     |                 |
+ *                |<---------------+- a -+---------------->|
+ *                                 |     |
+ *                                 |< t >| refined r0 range
+ *
+ * a = u64 [0x1'00000008, 0x3'00000001]
+ * b = u32 [2, 5]
+ * t = u64 [0x2'00000002, 0x2'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_before_block_start(void *ctx)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x100000008 ll;						\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x300000001 ll;						\
+	if r0 > r1 goto 2f;	/* u64: [0x1'00000008, 0x3'00000001] */	\
+	if w0 < 2 goto 2f;						\
+	if w0 > 5 goto 2f;	/* u32: [2, 5] */			\
+	r2 = 0x200000002 ll;						\
+	r3 = 0x200000005 ll;						\
+	if r0 >= r2 goto 1f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+1:	if r0 <= r3 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * 32-bit range crossing U32_MAX / 0 boundary.
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||===|---------|------|===||===|----------------|===||===|---------|------|===||
+ *  |b >|         |      |< b||b >|                |< b||b >|         |      |< b|
+ *                |      |                                  |         |
+ *                |<-----+----------------- a --------------+-------->|
+ *                       |                                  |
+ *                       |<---------------- t ------------->| refined r0 range
+ *
+ * a = u64 [0x1'00000006, 0x2'FFFFFFEF]
+ * b = s32 [-16, 5] (u32 wrapping [0xFFFFFFF0, 0x00000005])
+ * t = u64 [0x1'FFFFFFF0, 0x2'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_wrapping_32bit(void *ctx)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x100000006 ll;						\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x2ffffffef ll;						\
+	if r0 > r1 goto 2f;	/* u64: [0x1'00000006, 0x2'FFFFFFEF] */	\
+	if w0 s< -16 goto 2f;						\
+	if w0 s> 5 goto 2f;	/* s32: [-16, 5] */			\
+	r1 = 0x1fffffff0 ll;						\
+	r2 = 0x200000005 ll;						\
+	if r0 >= r1 goto 1f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+1:	if r0 <= r2 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
