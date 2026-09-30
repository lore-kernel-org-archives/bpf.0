Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD524028F7
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796696; cv=none; b=OtNE/OcHn7sksPPvIz8YK20tOxZVAsUcEawlgHDWAR8NnCGqaKVg7PksX6MZ3pp/SgXpImNns5wSQjRWnYIo/MQ/e9j6rKQ6Ie/3QrDXMvrWlgg0c6xjYNLAakbpjnDBQIBRPTeaIMi7eDTZh5NjBj419pQXjN9jDGX6RmuS9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796696; c=relaxed/simple;
	bh=7U6B6sv4g5q3I7L3XoTEy04SyUtuKMyyM92bteKPYLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bm1XpAUv8jLk9Ztk5MLH3gUZBCkRttH2+48OespY3KbkRGIi0TDUsolhQksBLCcKSWhpy6htDnIiELHrPwrR3V21F2SwW0NVu9taj/7Hg1JxrvMdVxxnryGBGu49Bm80favd4SxNQOwxqTTnbKNsboTi567Fuw+zOoNkc3kRRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWzrZqHI; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWzrZqHI"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a4c8262465so1186137a91.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796694; x=1791401494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IyDHBCsJ39EIYvy7h9XyJB5OP+SyUjXzdCypIaiIZSs=;
        b=iWzrZqHID9C4Zd4S+2QMyTKE/UjhRgNTxxrHRZaY69dtqFGFAkc/LddI+m4tJ0+sfb
         voAgo5JgKtPhYvJulyTszXCM0NdAQRjYF3lZL0i4LIKipx4LZ3Ozmj7Qf7jFVOaN25kl
         KvXqaL/tre4p9Ijx68FpoYOCzuj4nT5LhaiHo2rGFYZYhcUlALnHbU7iNfSMfI0yZThu
         6k3N2fdSnqfVVUpgZRHEMhqkS2dtJiPk4BDcYHZNGSRxEwkOMOUad6I8I4SJM+TWZVMh
         i6HaZj073TjiAfw3ZMKP3UXFltEJrlIG7WB8AHg2zdaifr+8yu3lqXhNdzrw2n01ZM7M
         Ce7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796694; x=1791401494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IyDHBCsJ39EIYvy7h9XyJB5OP+SyUjXzdCypIaiIZSs=;
        b=qS4W947O+uF5QezTf2NjOuWTYJnBPTwvJM5qnGRnLZSqwUz7ah1WkPsLWKiCBJrEMd
         wIasLAHUXQazWZONf9mLfKMQA+/XdLod0b2NrQ89SMbZzzKb+JIjL+FT/aQzHYEbV2h2
         bI5bZn+RErHFlZTl7GyyGqDxBB3r7EhHNFCqqhwdGrheo3o5ChGrHy6i320aBBoRatIA
         eyYxkzSAWRV7yzz2soNL5aWWGh6PbJkIr7kFCUHm6r1z/k1276pC5WdaInPYgj4KiFJ7
         T0BYJuWe+tD+TwUN5MwQMxCefN9lzQtcjMm//Adocl22PwS4VUrYzR6ONy9CG3EBm8O0
         f/tQ==
X-Gm-Message-State: AFq9FYJ+uXWThtFAuPJRYPXarBKBOZaVWDkTV3F1KjyFg2vzjYueihtA
	XM4onbz5W3lNgMvWEeTRocMdCcdiDZv7unlaDkZOSLuePVqsBDfuuDzLz1cogHIf
X-Gm-Gg: AYBFou2QLl92AiifRxilrRFxHaf4AYzsLLJwGAH0OjqNcm1PxTT3HYuPeIeH/WTULym
	qThdR2wqFrALbckiwwGSfHe5QH3xUgVcacQCehT2JnHepwWHw5/IC8lsSmK1z3K+Ff16vcdpewI
	M5HK+mLqapiJ8G/tPhjV7wseTU9/Rn9n25qTREFajhdtiX2L+lFy/Djy00yGaew4Vmt3REXDaz1
	uXPa3cUHXpdhCBzASwb7er3cj+f2EwvMcxVijnnd6BL/m+nk7dwx1xzfs9nrIEE/c4FWM5/iJ2f
	sXJk4GtCUAgt8BSCGyzeac/aAU6nhu1bb23+fB3gU6Id+GoJAefvhoUQWYq59bl7i+FqwqllwiJ
	SRmk/BXpgqZ6hpuNnfd0qMxgX5rE1F3XnTCi1WaYZE4P7B53eGkgJ+BO4DpxMIsoYOrbVzkh3PQ
	dYywkuTWrjjXn7egiyNO06IFv5dXnfqZ2dFh7k4rt+zNCB57Lh9EoeHQJsyHwosB3jqDPcbAYRl
	IEBT6Edc9EI+djTQ1EN9LU6FMXFMGsST/1aZbwPCxGRLhLLNowC+iQ7jOy9rOWsWWjH/VnH20+X
	MLGhgk2XorGDNvhwIGXlKS+KRIa+Vvp8qK3lCheqd0M=
X-Received: by 2002:a17:90b:5343:b0:39e:6c68:c77a with SMTP id 98e67ed59e1d1-3a4d18c21b1mr1758695a91.48.1790796694104;
        Wed, 30 Sep 2026 12:31:34 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f44f5299sm660364a91.17.2026.09.30.12.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:31:33 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 01/14] bpf: Allow bitwise ops, shifts and mul/div on pointers with CAP_PERFMON
Date: Wed, 30 Sep 2026 19:31:14 +0000
Message-ID: <20260930193127.2181684-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Rust's core::fmt keeps a flag in the low bit of a pointer:

  r2 = *(u64 *)(r1 + 0)
  r3 = r2
  r3 &= 1
  r2 >>= 1

The verifier rejects it:

  r0 &= 8
  R0 bitwise operator &= on pointer prohibited

Negation and byte swap of a pointer already produce a number when
allow_ptr_leaks is set. Do the same for bitwise ops, shifts, *=, /= and
%=, 64-bit and 32-bit. The result is an unknown number. With CAP_PERFMON
the program can store the pointer and load it back as a number already.

+= and -= are not changed: they keep the pointer, 32-bit += is rejected.
Pointers that allow no arithmetic and pointers that may be NULL are
still rejected.

Two tests in verifier_value_illegal_alu store through the result of
&= and /=. They are rejected at the store now. Update expected messages.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                               | 13 ++++++++++++-
 .../bpf/progs/verifier_value_illegal_alu.c          |  8 ++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1599bac1bac9..4bd14f4bcf40 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15543,8 +15543,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	u32 dst = insn->dst_reg;
 	const char *reason;
 	int ret, bounds_ret;
+	bool to_scalar;
 
 	dst_reg = &regs[dst];
+	/*
+	 * Only += and -= keep a pointer. Any other op makes a number of it,
+	 * which is fine when the program may see values of pointers anyway.
+	 */
+	to_scalar = opcode != BPF_ADD && opcode != BPF_SUB && env->allow_ptr_leaks;
 
 	if ((known && (smin_val != smax_val || umin_val != umax_val)) ||
 	    smin_val > smax_val || umin_val > umax_val) {
@@ -15555,7 +15561,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		return 0;
 	}
 
-	if (BPF_CLASS(insn->code) != BPF_ALU64) {
+	if (BPF_CLASS(insn->code) != BPF_ALU64 && !to_scalar) {
 		/* 32-bit ALU ops on pointers produce (meaningless) scalars */
 		if (opcode == BPF_SUB && env->allow_ptr_leaks) {
 			__mark_reg_unknown(env, dst_reg);
@@ -15621,6 +15627,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		return -EACCES;
 	}
 
+	if (to_scalar) {
+		__mark_reg_unknown(env, dst_reg);
+		return 0;
+	}
+
 	/* For 'scalar += pointer', dst_reg inherits the complete pointer
 	 * register state. Individual fields may be adjusted later by pointer
 	 * arithmetic. Callers guarantee that below does not overwrite off_reg.
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index 4d8273c258d5..9f669cf85c59 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -22,8 +22,8 @@ struct {
 
 SEC("socket")
 __description("map element value illegal alu op, 1")
-__failure __msg("R0 bitwise operator &= on pointer")
-__failure_unpriv
+__failure __msg("R0 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("R0 bitwise operator &= on pointer")
 __naked void value_illegal_alu_op_1(void)
 {
 	asm volatile ("					\
@@ -70,8 +70,8 @@ l0_%=:	exit;						\
 
 SEC("socket")
 __description("map element value illegal alu op, 3")
-__failure __msg("R0 pointer arithmetic with /= operator")
-__failure_unpriv
+__failure __msg("R0 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("R0 pointer arithmetic with /= operator")
 __naked void value_illegal_alu_op_3(void)
 {
 	asm volatile ("					\
-- 
2.55.0

