Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B093976A0
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504654; cv=none; b=kLbax5dbZH63RNojXG5yMslmtpuM99riZqUiApBvuxn1lg6+RS3ejtPRpREpe7uKqHvTy0iD0s7xl5FQDgR+bcRqWUelsgwgykerrlLL3I3i/vpXQz1FwEtXc+PCAs/znH2tp6+NxbDrMrd3yPBmTqKIm0kQvmQ4CHtooVUQHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504654; c=relaxed/simple;
	bh=Ke/foYSh8+Qxxcvhsgf/MyBOxg9bHj6+/MrnxFpoQL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYYqr+L9cN5nTWRDtyPWeGB9jmFW2JnY7kyjhaHAHi3UijsioxrgsKBlRk2hONB2uB7vzV/CWrWaJikK7W+Oke6FHnn81rG6XUXNar0QCrhHcDg3KiQIpHi5gqyidqB9QEMv5m1WiFQv0a7tgxWjEgE5Vy5UZEpClelPhxhgQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbNzVaet; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbNzVaet"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-46aa216a5edso2446123b6e.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775504651; x=1776109451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1vgcO21XX1mWrTyPnsZmLyuDB+vY/4S1sCwLQNdQlk=;
        b=SbNzVaet67sDGPv0y9xwp72eF3cDM3zDv9lZGF9XkFyMRNwcpwxC8+dEKPtvuwNLFL
         7AwgzjsZEz3q2yE1aqiK9AmAH2MyvrR9LP16Ysp/5ciL1u3G/lW/7BmMvoqFPA2ymVJb
         XBCW6FK4nSB1hIxfc+erMGnvU5fTmjQRX5tjHruwMPpuADPJmTArx98JLxFp036CM18w
         4gel5PLy43qBsQu/1ECwPCrx5uzff9VX1xno1aoPU5zRiEfPwXjZwX4/Y+aeKD4965cM
         B6JkgdQtlXRaS9dTTQx5InXaHd9xkYzWDC0ggNhzfzKC3iglfpw4j5zyH5g6NQwFULwI
         4ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775504651; x=1776109451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L1vgcO21XX1mWrTyPnsZmLyuDB+vY/4S1sCwLQNdQlk=;
        b=QRP/qKMnznCx6FPyd2zv586XFFErs9C2Upf1B8ozWNotQln/49hEOmp+OsO97eajc0
         3x0h05EYgcbATUXXKD8rUE+u8rbU6W4K2xUIyr/diC3vDs1j9I9yzoMr1Ei44uC+i6yf
         TZPy/btfzZh6PFVuyP05OaGvBC6Mz8Wr/HJsbIDdgb6oLLOyS9vPnJHLi4/4t9MJ7JZ9
         fWgRrW8DH+GOP0kMxqkZxn+68Knd+nOvqQ0ZPeF5ptwvWVhfmakUwOC+tuws9X7SS3on
         KPFrO7JJagH7Ssx1uxsmgidDjN4Tf47584bfUKnmyOnVxSWIKrM2zSmxXIfaiRzjnuju
         pFpQ==
X-Gm-Message-State: AOJu0YxOjdPG30Kk8GKLOFQ275J0DQPB8hUUVKNmWirZ1/twGZZB2O/5
	JVaHnevBbXKXSy3aIfPChj+zklg48owHI5kV5psUPcSIqfPqRcM635QPc0Xv0j2KyZ8=
X-Gm-Gg: AeBDiesTiNJLQWAJPHv87EBGaeaBTvaPLAaxXyOpVShRuQcKW5Gdv99pThRtJYL9Vn3
	7nf64qoLcVDlTmqNk/m88RvKm4pFPmA76wqa2n0CcUwhB1iqUcel8y+fbxxMTBK1zwQj3raGMOu
	l95wjI3pes56FRWD4Aw3D2ev974RYjgMm0NIqkkMOZKSg3d4i3r79XyQHmehPlQlw7COndvL0fs
	fQ7/jbQsiS0ezJXsglmoNxDksS623XCOYPnPO83uqiLJSetvqf3RX23n5fn9+zHDfbCmrnbOzuf
	ZGSjpXj7ph4qrK95UCYd4s7hfJzEKku+odTm8D5nExNIJMIRJAhgTXeLwFFNHerZUX1GGjkO/9h
	PfP6o3rhubqUx8+ceV4V1WDeLgoXQXUwWTS5dbI5kxo6wNUGX39kS5NNxRwTC275ri6gQjk92s5
	mGY/SEXPKCQFomBfG9a4pF5xH7BB8v3WLGPIPSYxpf7jty
X-Received: by 2002:a05:6808:120d:b0:464:74e1:45a0 with SMTP id 5614622812f47-46ef8017e4bmr6789433b6e.36.1775504651386;
        Mon, 06 Apr 2026 12:44:11 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-471cdaf207dsm3329167b6e.3.2026.04.06.12.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:44:10 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 3/7] selftests/bpf: Convert ctx tests from ASM to C
Date: Mon,  6 Apr 2026 21:43:57 +0200
Message-ID: <20260406194403.1649608-4-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260406194403.1649608-1-memxor@gmail.com>
References: <20260406194403.1649608-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4922; h=from:subject; bh=Ke/foYSh8+Qxxcvhsgf/MyBOxg9bHj6+/MrnxFpoQL0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMKD9tdrYtqi7SCn261UkjUzWdQevR3oxZj3MRmG78/fsa7 dQ51lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLVnYwMB0qaRX6/jpvOcKV87ZLUxZ v67V+zzwyznWzV/vLwqg15sYwMby/YbNlRIbjNc03KqQKp1jmekz+71D4OVZ10ql7mzuwmPgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Convert existing tests from ASM to C, in prep for future changes to add
more comprehensive tests.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +-
 .../selftests/bpf/progs/verifier_ctx.c        | 78 ++++++++-----------
 2 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 1ac366fd4dae..169cf7fbf40f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -175,7 +175,7 @@ void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
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

