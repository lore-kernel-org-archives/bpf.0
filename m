Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8E3F166F
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851373; cv=none; b=gPaQDbeHNQ4TH4fC8ku3y4PVjPC33RpEV1pSf1SIK77ey4tA0+vahRXNHkG41xp05xBiUvgjqYfIxwjKHFjyjFMC8gzEjJq9i+MpC592H7PNOJTDIX6mRVvdfcQO5HZ+cHWI5DilnlKE0AXufzZQ93CzSvrnG3iciUAQYgvtLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851373; c=relaxed/simple;
	bh=shWNtMW4HROtp/m+MjcGgyjnuzkoy7zxD5XzP6QK+7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+aM8AhTk9bDayFWrHSjM6KshZ25P9wkpe6erLbYtrhaLdPRlCg8tbCH8qO9AenQ5ntBemY6LVaK4FT1zY6dlcdudPjTj5pysY0E8ARUZNHZORuHHjKsYtbNI9rQP/yUQvI67JqVhEbENyuuCPJPJE9EOmSvi5I0XrMo/G4cQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF8Le0Xc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF8Le0Xc"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso48827a91.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851366; x=1774456166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD3ByxdiUT0lbwU4HxpyWr08bvWDS0l19f38ySuEHYk=;
        b=FF8Le0XcBLKg5wAPA2gkJoy+aQJBSE7pjjJyxs1MKhX9s00f11ADQ+urY7QLDQUFD7
         n9CUBJL6GK94Pt9ey8FlEB/I65OaM32I6Y4KCal0BBopBUd8seX5pdgxiIylJipZs6E8
         uoc7zK2Bxm2i6p/4w6ZFlO+mPnCulirCGpyIkKM1PiuvLtBMcB/+sU5wUmacU9HHrBsd
         FyP2tBNBwznQ5JCcDNGRk3xZVS1yntGP8i4/OHDvf5o8/kFd++t4Ngpv6St8gaUNz8zO
         U0PWXgEO1cImLK9qLW7SVd4qe/8vjE9MjWYezrpafKaUkpuhumGgjH17A2xOYESDDQp1
         Df+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851366; x=1774456166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lD3ByxdiUT0lbwU4HxpyWr08bvWDS0l19f38ySuEHYk=;
        b=BTUD5SbxE0msVUVPwC3iX7IIee/kpCEthyxWJsvnbLW1e3KZtZ/cU1YbaqUvIVhIPP
         Af+Qd/9CLDlqo20NOpFSJ2itdQtmb21cxTk6j8Fx4yrFUYvyqS5vcZ/XFkb0qNxbPYN2
         zxdvtFH1Nk+b+uzN3NYq8gPTavkTXYgcWVvGPJ28Xj1b93TReUqubEhU0i55uvx2j5G8
         RYhAVC6ZX94gquVB+rc80rPo7gAXB4M8ozD4qMzXA5FdXarbNY9zXeY/rUvQ+TUw+8sg
         G6W0Ei4j9ozAQPcm/RP/OvDBUTlD8wDJ3gePBJw9kAtBtHxM1d3GlYG80IVDLBABWGfH
         nwmg==
X-Gm-Message-State: AOJu0Yy40jfDw51bz7IVs7djBnSUXu5uaWCWWjil8uDeedRRcQ7CSoQA
	+koGp9mAS5GYuJ8vnV/sCv6CSi+uGdEFNiZj/1nA9zmxl8zYVyyf/SHfrANj3w==
X-Gm-Gg: ATEYQzx9WA+ejFhBDOk1HvV+8Z35OtHuvF27NbgiuvfESWtreAK9HzAbdng9WGX0Df9
	b7XXTRL1sVFT4916XwaaWXriVA1viRM24auPrq15N7aDGVjwyb6+yjAmGt92bwh8262JjEnva4e
	z82iNKWd7pWTyDiMKhF3ceoeqXq5rPcntBPesjYAdMe6bTKoajdB+QeOJ2bJ33OH/n9PL35/QrN
	Kn9JsHiPKChOCvvFKzqrJ7nEodXxrZiJljl1oIVUaqQzOC1Oezv9CNNbnuqcZidTv+HNysYOdHY
	5nW3+U5zhPDlf08j36hxe14z0HHG2taK0yhYnj3XSCIl39wDOmzXUC9lGdWoRPAYE7J8wMO2wXM
	b8xSTX/QzkfalNUTUywzXUMA97c1Aa4Ke2OJHWhd/FgSWfq/NM02MbaBZlpVuRHYpCWo4WGCgFR
	kKIjDGcMIn3BZPVd0Pl/1+vpgksL6MhIfMo70rGIjV+ucBC4C1oa0Hx5Tq7S8=
X-Received: by 2002:a17:90b:3c8b:b0:359:9bad:13d9 with SMTP id 98e67ed59e1d1-35bb9ebfd90mr3872967a91.15.1773851366172;
        Wed, 18 Mar 2026 09:29:26 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm89370a91.14.2026.03.18.09.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:29:25 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next v1 4/4] selftests/bpf: new cases handled by 32->64 range refinements
Date: Wed, 18 Mar 2026 09:29:01 -0700
Message-ID: <20260318-cnum-sync-bounds-v1-4-1f2e455ea711@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
References: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
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
index 3724d5e5bcb3623aa54b2eaddb70adc9c7987813..c6980ac049f668799301de33b50bd8c420fd8985 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2070,4 +2070,84 @@ __naked void refinement_32bounds_not_overwriting_64bounds(void *ctx)
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
+	"	:
+	: __imm(bpf_get_prandom_u32)
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
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.51.1
