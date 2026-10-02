Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F332165EA
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945241; cv=none; b=pL8T9x3ZvM333RHPBjcEoN3t0WOYlcBi8WcPU0lD/aA2D1C3sO2foYQyhZO5jcCiZVaixVn7M9I1anyu9eGvzoywYF5WWTP7ZBA8zMILq7ISQW0LC2909nR0ld9otHB4Azh9Q4oO6qivlfvTyzCI4DjhtsmOvPl2Tw6jOo5XVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945241; c=relaxed/simple;
	bh=VYwqJoXAk6UkWCGQ9MqICl8DuUu38tdIAg3PCm9XHUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pS9HUhMGTO7myG1AEGhm8UE7G9gpvWAHkvQ52o78nIApfZZVEWWIRarkjifzbcoDbAEUxtQ9wXiwzGS77jQmM2LbClr1WrXvNUKqBX/yABzgsppBLWn3zheHEIgobjTADWyS/0nMICDdEaoVBP0WmSwfD+CCkb5r78r6kVE609Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjuGPb1I; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjuGPb1I"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so3745475b3a.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945239; x=1791550039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DP1mlw3+PWQumSXdA7GYmWglXzdNV5GweIjhbhcHKXQ=;
        b=VjuGPb1Ivz7/vK5zGtngKdUWjpDMvXRc4mxUpqEnnJeu9uWUMJeDNSw5V/q6zWLpwm
         0YMOqr8NjlQuhmlxIf/pUeaV1JJPqbebI1kIrm1jPDwbpD+JPMebG7wGjfc2rI0vTgq/
         qMzqj7FCMWkVagbm0DDNliDIN8od3GLohTdNc6vf93mXJlPCOGpcHISmDUstj4J265Br
         r+sspk8OFi3/CgAwPB9gXCjoWWcXbOTN6TdsO6Rcli9X0jgSQeO/RI9A8jnAOcY/jKKe
         QfUKhVOU4qplJRUSlqNEkJ8DkGDqOgKeKeBQn94HuzYPeOwg3dpoRq/qlMtEiMY18CZ1
         mg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945239; x=1791550039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DP1mlw3+PWQumSXdA7GYmWglXzdNV5GweIjhbhcHKXQ=;
        b=2tTEYGHaZIdf/8x/NKvCa9sFc2IfcJkJN92HYBRCR9Ro4v/PMqONSXx6cy2DKdvCNE
         k+I9e6BkJKzTgPj4W8XrSkV5rdljMR2HudV1elSTlkKEadhQTUzVkpHyfgQm+2P8/n0B
         0kMLLgKmGmm9w8RG+ZZJ38oMtjlZnx7xtgpQPkDptC0C73cMSVz6239NmF5XFgHV48Y1
         w9MtfhO4RaRrHQ2vLnIwO51q1dVAB/OhkS6Ki2o/HBq4dG0hYvPTImA+SK0Ve0Qjvkmo
         ZnuS82IY2UOwxpg7NWK3zRgJdb6FmOIiCNfeBT02o13FphUBCxZLnV8vp3ktd5BFZJoi
         k3GQ==
X-Gm-Message-State: AFuF++lZABdVW2Jrn4zItU9cTZ8laGcfziL1lwFztjDdxhr4kwT9mVJ9
	Q/mhX8xwPI+/xpjmWM5y71WReWSww9PWhIBbwQ+qiOkwJBlSmRy7hLHx18gxR7tGKnQ=
X-Gm-Gg: AYBFou2gASI9H6hkAiSLwpato8OX3F959sByNYQUuJAgTAsoV2RNHvIP9MvqWSN2l5Q
	+vEsKpUXFYl3XDKJ4gOu+EM5ysHKD/scurCC+JZ+yCWQvvRtaKdhsx5xVAxdgSny/LJz7TOLu4P
	CRK1bWvks1E1TcnD2IQSdN10bz3UW+7NxB6HH/jrUbStQkExnuhXlvTcb2DxSdu/qMzd1gZX1nb
	jrbBr35s0LbL74+JtT3U21eIQrbT9oNeEHmmjJFZYABjGdeo1eCRVHrvMzqkxk1j6Fg9/xbXcCi
	Vn0ARb/O+8gk8V7uV/MuH3B8+XaPoRfD9u0j9pWs9AlIqD2fK/5KL/lk8WwmiIWIwdj2HEJv8+f
	Dx7MiSH+OR+4Pt9c79/In8VSkWBDH3DxruuPJMEnORexvpYrD7SphvaU6hSGmAa2cLg8u+cAHfT
	v1Awiiw0AZ2s0qjNeirWbZffQzSSa3FdrQjrjVT68jQjUQ0uT1ImtzYTsH2XNlMfcEIwj6Fd+2u
	gnK1WCDF6v2mn6F1VXD4E2Ivg0l7K5j/7H+DsZafRwAohxEZhw1D7uA9TMK8rv0rPZCwk2StPlD
	7ZTutthq3cgEqDS8iNC3cklFTxwnJTQqX6J/YnahH+I=
X-Received: by 2002:a05:6a00:2308:b0:881:42e0:b92d with SMTP id d2e1a72fcca58-88af72eff88mr2602017b3a.57.1790945239367;
        Fri, 02 Oct 2026 05:47:19 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0b8f85bcsm853687b3a.19.2026.10.02.05.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 01/15] bpf: Allow bitwise ops, shifts and mul/div on pointers with CAP_PERFMON
Date: Fri,  2 Oct 2026 12:47:00 +0000
Message-ID: <20261002124714.180012-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
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

Assisted-by: 11 bots, 0 humans
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                               | 13 ++++++++++++-
 .../bpf/progs/verifier_value_illegal_alu.c          |  8 ++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b840b3eb9b22..1033167cfa93 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15561,8 +15561,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
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
@@ -15573,7 +15579,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		return 0;
 	}
 
-	if (BPF_CLASS(insn->code) != BPF_ALU64) {
+	if (BPF_CLASS(insn->code) != BPF_ALU64 && !to_scalar) {
 		/* 32-bit ALU ops on pointers produce (meaningless) scalars */
 		if (opcode == BPF_SUB && env->allow_ptr_leaks) {
 			__mark_reg_unknown(env, dst_reg);
@@ -15639,6 +15645,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
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

