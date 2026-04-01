Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BB407568
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046509; cv=none; b=a/7YKcgOVT+RwHZvR6BZch8e6lkD03PjTNWmB18a1/N0GJ60BNFyG+kibep/BKxHzPZRoyT7AkRXNPsqMpdmeq+lytB1NFD8DXeaUr97RrSHpI6n9LUOJCpsTcWRjEyL88ivJOZ2zpivWbSMP9BQvT2D9oWRNpO2u5sTk5arWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046509; c=relaxed/simple;
	bh=MpUhHP0ofVhmvw6mOpEj8AJb3nT6dN7P02Xz73pShHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnkjvFDf3zLwdU5AvvDVdDn7o/1leRK/JQ18dLmo5gOAicymFprAKBAGzI9OvitwkNUdEvqO9itfnGJAtk0eHrj0d9njqPxgbLXguOlvg4I6oetkSlMpNaTw2NZD5EU6cldnL7Pf67XOEM+OrXaRYsx/YFcJ14fnJXpK8NcJfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh2Lex8k; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh2Lex8k"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d9e22176a7so3489009a34.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775046506; x=1775651306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXJVX13xASurFqBJh3BCJiyCcu7ro5Yhh1LhRci2k40=;
        b=eh2Lex8kwYaaHPsuPSBcgSTBIsZp2TM03XcK3gO/qnIkU3YkC+jELWobNBV5pHb0NR
         8BIIAol2ZIFkM2WLevU5su/X6I/3bIXU+amSDpF84CizBxysQo1265wkyKW4gzakWMXi
         lnQHZd/xRCr5HZ+702j24oyfS2exdfgxv3iEmerEqIltojqKjKSkPNqPAgxMYbO4US+h
         O1IGEXe/rIRRfnA/KvCscISGgTimEyyv+bQCVrRpJc40mjMqAHm/5gcH7FZDTsHysMzB
         XxtKHj6bXkVYdeq7UmKXGdksUXYzKRBEdtMvDk0Z8UhHC/P9uJLAhywzWxLndjIseX+H
         u1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046506; x=1775651306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXJVX13xASurFqBJh3BCJiyCcu7ro5Yhh1LhRci2k40=;
        b=MszZ3Cv8bvKJXfLhfoidgt7FDwlOvAyfYk1HRAQsgGIoTDoWQYY+2J2RngyEs4IbSO
         SQJ2dE0yWjypite+EDUS50NJvOtr9xQkMWJAHyfE9Y6+SDx5EpR4qJkgp1BKwDyNLDCo
         BlprwQRPgyvgbUSXrMwl8glF8rKf06LxxnsB9TQpEkEsm3K46JUxrOg90jM0lVGbAIjt
         Zw0DGt+NMcp5hlo5PJjSWUlu0I2L/BzXBTO7NMm7HBnPDv1QiG715FDoBJP3QQzLfqem
         hIK3hWBtniiuhStbsuOpS93buI/PE0bgVoKoZCwEI7kTdlOfy+nwwTL0S+ZE8Rdlwo2o
         vmCg==
X-Gm-Message-State: AOJu0YxxFZGmGsjbElR7rALLQzGnavMvTdstpCLjTRzIjHMS2iukEfB7
	o7KAGBffisaPzHQmHZBDdDGBKNU6ic+p2XC5QGEy6E6KV5F0VGAxMFTxpsVWkWE0et4=
X-Gm-Gg: ATEYQzx0vrV3/ZG4bw51S29yAjjvDk/bJkmXP/HcrC6IwUrjaQXalWNy8ULgAvpjZYu
	51fZZ5DgmrI1R3//cQ/k7WOT5fNfDc1lzzw2RmAB4qLVtZ2L0mX/3vf9coaKI6DtfORjOhWxSnZ
	ZQvTKhsIdjjvi5y1WIx5HufhAx3o9Cach6oELhGLndA2EUbB4/Eos91N9fEmyPL566GAIIdeEAF
	VAn3g3nEh5xkHzuD0BwsPV3pRpD9GZAXy/6MP1BxRIaOPWsLoog5CwSfLPaITwVM3Z+ziZLT8VW
	ujBnLNjfaOSts1ekDdKWFBMS/MR+OvMkSBdnVBBETbT8ybA9/kTFqabqoMeVx171qLAtDwO5y3i
	Us52jYxqGF/JcWr8sw8JxnKQishlteBFF3iEgmAlPVfS/D3AWAtZrvQtVM/8P1ZkcNGbNrvpAaT
	FMv49/tNBPqI3MUH9dyHfEg8z9jTX242PKfWOpMgptb1Af
X-Received: by 2002:a05:6830:4904:b0:7d7:da02:1aa4 with SMTP id 46e09a7af769-7db991e71ddmr1960274a34.1.1775046506125;
        Wed, 01 Apr 2026 05:28:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a0f2bf9sm10235137a34.0.2026.04.01.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:28:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 3/7] selftests/bpf: Convert ctx tests from ASM to C
Date: Wed,  1 Apr 2026 14:28:12 +0200
Message-ID: <20260401122818.2240807-4-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401122818.2240807-1-memxor@gmail.com>
References: <20260401122818.2240807-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4869; h=from:subject; bh=MpUhHP0ofVhmvw6mOpEj8AJb3nT6dN7P02Xz73pShHI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMs370jjuKCHge5rfKD2N5ZGsftfWWnZy14Wffbybsml1/3 fpTvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESeTGb4K55b5buc25D9wt9Z857810 3Y6v/pZnWTyuRWv4pHc/msyxkZdn1R2v1tmc5GqTTz+fwLOH89Lr+mtPRyDuuiWtnKAt61/AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Convert existing tests from ASM to C, in prep for future changes to add
more comprehensive tests.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +-
 .../selftests/bpf/progs/verifier_ctx.c        | 78 ++++++++-----------
 2 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index bcf01cb4cfe4..0c50a4305292 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -174,7 +174,7 @@ void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
 void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
 void test_verifier_const(void)                { RUN(verifier_const); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
-void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
+void test_verifier_ctx(void)                  { RUN_TESTS(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_d_path(void)               { RUN(verifier_d_path); }
 void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_default_trusted_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index ae756764ffba..4c285ac8fff6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -295,68 +295,58 @@ padding_access("sk_reuseport", sk_reuseport_md, hash, 4);
 SEC("syscall")
 __description("syscall: write to ctx with fixed offset")
 __success
-__naked void syscall_ctx_fixed_off_write(void)
+int syscall_ctx_fixed_off_write(void *ctx)
 {
-	asm volatile ("					\
-	r0 = 0;						\
-	*(u32*)(r1 + 0) = r0;				\
-	r1 += 4;					\
-	*(u32*)(r1 + 0) = r0;				\
-	exit;						\
-"	::: __clobber_all);
+	char *p = ctx;
+
+	*(__u32 *)p = 0;
+	*(__u32 *)(p + 4) = 0;
+	return 0;
 }
 
 /*
- * Test that program types without convert_ctx_access can dereference
- * their ctx pointer after adding a fixed offset. Variable and negative
- * offsets should still be rejected.
+ * For non-syscall program types without convert_ctx_access, direct ctx
+ * dereference is still allowed after adding a fixed offset, while variable
+ * and negative direct accesses reject.
+ *
+ * Passing ctx as a helper or kfunc memory argument is only permitted for
+ * syscall programs, so the helper and kfunc cases below validate rejection
+ * for non-syscall ctx pointers at fixed, variable, and zero-sized accesses.
  */
-#define no_rewrite_ctx_access(type, name, off, ld_op)			\
+#define no_rewrite_ctx_access(type, name, off, load_t)			\
 	SEC(type)							\
 	__description(type ": read ctx at fixed offset")		\
 	__success							\
-	__naked void no_rewrite_##name##_fixed(void)			\
+	int no_rewrite_##name##_fixed(void *ctx)			\
 	{								\
-		asm volatile ("						\
-		r1 += %[__off];						\
-		r0 = *(" #ld_op " *)(r1 + 0);				\
-		r0 = 0;							\
-		exit;"							\
-		:							\
-		: __imm_const(__off, off)				\
-		: __clobber_all);					\
+		char *p = ctx;						\
+		volatile load_t val;					\
+									\
+		val = *(load_t *)(p + off);				\
+		(void)val;						\
+		return 0;						\
 	}								\
 	SEC(type)							\
 	__description(type ": reject variable offset ctx access")	\
 	__failure __msg("variable ctx access var_off=")			\
-	__naked void no_rewrite_##name##_var(void)			\
+	int no_rewrite_##name##_var(void *ctx)			\
 	{								\
-		asm volatile ("						\
-		r6 = r1;						\
-		call %[bpf_get_prandom_u32];				\
-		r1 = r6;						\
-		r0 &= 4;						\
-		r1 += r0;						\
-		r0 = *(" #ld_op " *)(r1 + 0);				\
-		r0 = 0;							\
-		exit;"							\
-		:							\
-		: __imm(bpf_get_prandom_u32)				\
-		: __clobber_all);					\
+		__u64 off_var = bpf_get_prandom_u32();			\
+		char *p = ctx;						\
+									\
+		off_var &= 4;						\
+		p += off_var;						\
+		return *(load_t *)p;					\
 	}								\
 	SEC(type)							\
 	__description(type ": reject negative offset ctx access")	\
-	__failure __msg("negative offset ctx ptr")			\
-	__naked void no_rewrite_##name##_neg(void)			\
+	__failure __msg("invalid bpf_context access")			\
+	int no_rewrite_##name##_neg(void *ctx)			\
 	{								\
-		asm volatile ("						\
-		r1 += %[__neg_off];					\
-		r0 = *(" #ld_op " *)(r1 + 0);				\
-		r0 = 0;							\
-		exit;"							\
-		:							\
-		: __imm_const(__neg_off, -(off))			\
-		: __clobber_all);					\
+		char *p = ctx;						\
+									\
+		p -= 612;						\
+		return *(load_t *)p;					\
 	}
 
 no_rewrite_ctx_access("kprobe", kprobe, 8, u64);
-- 
2.52.0

