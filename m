Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37E3AFAEB
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776404; cv=none; b=thjDSy9MIfnoe689A0h6U7St8i/tshIhm0ZHZyc+3y5D+cBj4HX8omVFGG/3mHwSWnht/cvQI2C6PuxFgPwBrXeOeFvJQiNeGAxiFnaJZJzRZRZQbOsaK1jV3wnpr4FiENqdfslMNNsqbG2KNBqBgzRLosPjq+LLhC47spzEF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776404; c=relaxed/simple;
	bh=g6pw8253T+GBDl1aIm1fuyRqJMGArG3U4vLnRpsP6Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAIej7MfMpx4Mk7QdXpRJXfWVnHPGnx5PBZHq1DHTJ7jNdrnNOvZSmH8PxdLCtmmGWABkcHVZN/SCKOnCPRqab0rm1eRQoULV7c1/3YR1XGaAvq2z/dlnuJr6ovls14orR+XAHF8qfQT04safZfBQU0AB4Wqt3oL49uvYoLR7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxvBBIzG; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxvBBIzG"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so7427525e9.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776386; x=1787381186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BbHPwU7y4rMy/OJ9ZB8OPq0UVPg30GjLTRsuWWqNDME=;
        b=SxvBBIzGi1Qg0TF3meSdSKGfOYWu/dkJVMZ1SiRhdGAU58efwmAJHhgXhXjCHHgS8A
         vdGJxsGbCZzel+wMqwy+brNhIrH3Fxf83MUqezCSgZeJmTzd+sZycFK0dhhc/1KSsr9S
         XmuIJ7aq7OA/Fbq4jFQUQhKcz9Y3OAcyMRRQbzpcPZ8DAMxxRrmIYupoZhJACS+OQsFr
         lo3kZPf9SYlNv9nLPB6EMENyKnD4oCK0zJlfAeEPg1CftaM2U3L8RxK2u8mnBU1IcO09
         sqKeZkE8xlmrJd8r8ZfzgP6mHwqgkTsDO7a0Vj8RmpTcTV0rBKx+KE0lFglfl7QRmSPZ
         QrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776386; x=1787381186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BbHPwU7y4rMy/OJ9ZB8OPq0UVPg30GjLTRsuWWqNDME=;
        b=NyHYjHgOFn0ZlXTizoQYV4tkxmBnimPUw1we3d/MDR/hbpbKUICD4ERvd4kJ/YhY38
         +zkwD50UyGVZEQXMPAsyePSux0CV/ptPKAdr7NIk+jBTGna/lahjl8zCcGCQIDmAzvgs
         mVLdJbTwMZh5bjBoE8ebfKiKE4vaBk4eMZNb+7iRWy82V+rynDBngK71uII+ubvla2GE
         WZp97zAJvSMbMBsO1mb658LqwKli71ZacBrO+pFJbICE36XLBBhwI7u16NgR4L6WObC0
         xsQgMVluTPYWY1ZexjipNkBh3OV1GdAU8s8OcYXD9p5nKInPni30GiNehlMTbqejd6LO
         EEEg==
X-Gm-Message-State: AOJu0Yy1CJIMA4P6Y91UggNnIM5yJiLV8Ch9pgpG0a6aNSFPmo84Z2LS
	Qe2w0/qzmcNUCscdelkvGIU8OemVJg6mojEBF4y5dx9NnAk/Uu13KemWVwtXlcvi
X-Gm-Gg: AR+sD10sn02N7rsGe7bFcJQ9WwejEhvg8J0cRNOC8PRgZgvQ0Zt0v0yQxTWMyys7S83
	2JYj+LMLURrJspJN/okkcTg7up9qmo0cSEhof6v+7K2Z8VyavTJ77vCRTQG2gGRmNoNl9VPEaW3
	a4Srs4qqUIMZNfGj2+yKLtlS0MbaSGAIQ3B+2psrn+AOEbsRa+9OdhJyq41bVGha4SyFUmVPY36
	soeXpmOGR7OVLuVATvUbVAlZhRYP5HMSYnhzwGQ6Im82qhOk7LPsnvsj1tDa+u4qMyVHPPN0nh0
	T9swLL9RInZM7LREOoDVOoVOKbjDWoXupddtPdBQ30zvpcYjkd7JqKaNmp9RYvdQfvCUN3JpOBc
	XRWzn6cO7f3nZS7ZAGKK4b6AYqHbsptrVr8ijPi3f2Xs6gu7tiXRReOA1gMP3/WoUcksPOK48UR
	snP3ENtLgrQqHbIiRXbpk1BKzMqQ+PGRS4utAm13In2KuuznI57I/vOptvezCLsDxFf/9BrJUzV
	dFHH3lwD5tPlNguB7Bc3Qgy1mit+49Q7X7YUibgUkfVtuCmY8QRiEAWnuishRTnvkVZX4HOCmfG
	EU3dkdJhW6sOHzGv3Kdj0gUtKkoQvIwaeT4uwQ==
X-Received: by 2002:a05:600c:609a:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-4998d7aeb12mr55457715e9.3.1786776386279;
        Fri, 14 Aug 2026 23:46:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b2a176sm126430955e9.4.2026.08.14.23.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 09/14] bpf: Report Memory Safety bounds errors
Date: Sat, 15 Aug 2026 08:46:04 +0200
Message-ID: <20260815064612.378577-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12596; i=memxor@gmail.com; h=from:subject; bh=g6pw8253T+GBDl1aIm1fuyRqJMGArG3U4vLnRpsP6Us=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy8c5M+0vs9Gl3Qs+9lROX7tCbXP9oynvI56kT1a4f zAz3rqzo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPR8GX4n/TQ29V12X6P+XXu x4omyJq353iXntCa2KOjc0B99+U+Q4a/EmaF2o6d5r+mNRy5OzlzPjNr8nTt+UdvuV1yzuxynre BHwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected memory-range verifier failures with Memory Safety reports
while preserving the existing terse verifier messages for compatibility.

Cover stack spill corruption, uninitialized stack reads, variable stack helper
accesses, and check_mem_region_access() range-proof failures. The bounds report
spells out the required offset + access_size <= object_size proof with concrete
values and uses scoped diagnostic history for causal context.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 78 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  6 +++
 kernel/bpf/verifier.c    | 79 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 02399cad2fb0..058574a1411e 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/seq_buf.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/stdarg.h>
 #include <linux/string.h>
@@ -16,6 +17,7 @@
 #include "diagnostics.h"
 
 #define REGISTER_TYPE_SAFETY "Register Type Safety"
+#define MEMORY_SAFETY "Memory Safety"
 
 #define BPF_DIAG_TEXT_WIDTH 100
 #define BPF_DIAG_TEXT_INDENT "  "
@@ -1164,6 +1166,18 @@ void bpf_diag_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int n
 		env, "Write the outgoing stack argument after any operation that may invalidate stored pointer values, and before making this call.");
 }
 
+void bpf_diag_memory(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+		     const char *reason, const char *suggestion)
+{
+	bpf_diag_header(env, MEMORY_SAFETY, problem);
+	diag_reason(env, "%s", reason);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s", problem);
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true)
 {
 	struct bpf_diag_history_event event = {
@@ -1657,6 +1671,70 @@ static const char *diag_scalar_range(struct bpf_verifier_env *env, struct cnum64
 			    diag_u64_str(env, cnum64_umax(range)));
 }
 
+const char *bpf_diag_fmt_s64_sum(struct bpf_verifier_env *env, s64 value, int addend)
+{
+	s64 sum;
+
+	if (check_add_overflow(value, (s64)addend, &sum))
+		return bpf_diag_fmt(env, "%lld plus %d (%s)", value, addend,
+				    addend < 0 ? "below S64_MIN" : "above S64_MAX");
+
+	return bpf_diag_fmt(env, "%lld", sum);
+}
+
+static const char *diag_access_offset(struct bpf_verifier_env *env, int off,
+				      const struct bpf_reg_state *reg)
+{
+	if (tnum_is_const(reg->var_off))
+		return bpf_diag_fmt(env, "constant %s",
+				    bpf_diag_fmt_s64_sum(env, (s64)reg->var_off.value, off));
+
+	if (tnum_is_unknown(reg->var_off) && diag_cnum64_unknown(reg->r64))
+		return bpf_diag_fmt(env, "unbounded");
+
+	if (off)
+		return bpf_diag_fmt(env,
+			"variable: known bits %#llx, unknown mask %#llx, plus fixed offset %d; %s",
+			(u64)reg->var_off.value, reg->var_off.mask, off,
+			diag_scalar_range(env, reg->r64));
+	return bpf_diag_fmt(env, "variable: known bits %#llx, unknown mask %#llx; %s",
+			    (u64)reg->var_off.value, reg->var_off.mask,
+			    diag_scalar_range(env, reg->r64));
+}
+
+void bpf_diag_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+			 const char *reg_name, const char *type_name, const char *proof,
+			 int off, int size, u32 mem_size, const struct bpf_reg_state *reg)
+{
+	const struct bpf_func_state *frame = diag_current_frame(env);
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frame_id = frame->diag_frame_id,
+		.frameno = frame->frameno,
+		.regno = regno,
+	};
+	const char *offset_desc;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	offset_desc = diag_access_offset(env, off, reg);
+
+	bpf_diag_header(env, MEMORY_SAFETY, "access outside bounds");
+	diag_reason(
+		env, "The verifier cannot prove offset + access_size <= object_size. Here, %s. %s is %s; offset is %s; access_size is %d; object_size is %u.",
+		proof, reg_name, type_name, offset_desc, size, mem_size);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "access may be outside object bounds");
+
+	if (regno >= 0)
+		diag_print_history(env, &opts);
+
+	diag_suggestion(
+		env, "Add or adjust a bounds check that proves offset + access_size stays within the object.");
+}
+
 static const char *diag_var_offset(struct bpf_verifier_env *env,
 				   const struct bpf_diag_reg_snapshot *snapshot)
 {
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index d2355c46dad1..b5feda71de3e 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -15,6 +15,7 @@ struct bpf_verifier_env;
 struct bpf_verifier_state;
 struct btf;
 
+const char *bpf_diag_fmt_s64_sum(struct bpf_verifier_env *env, s64 value, int addend);
 enum bpf_diag_mod_reason {
 	BPF_DIAG_MOD_WRITE,
 	BPF_DIAG_MOD_SPILL,
@@ -62,6 +63,11 @@ void bpf_diag_unreadable_reg(struct bpf_verifier_env *env, u32 insn_idx, int reg
 void bpf_diag_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int nargs,
 			       int stack_arg_slot, const char *callee_name,
 			       const char *arg_name);
+void bpf_diag_memory(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+		     const char *reason, const char *suggestion);
+void bpf_diag_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+			 const char *reg_name, const char *type_name, const char *proof,
+			 int off, int size, u32 mem_size, const struct bpf_reg_state *reg);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 962eb7b37e6b..cfc14167cad1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3470,7 +3470,16 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	    bpf_is_spilled_reg(&state->stack[spi]) &&
 	    !bpf_is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
+		const char *reason;
+
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
+		reason = bpf_diag_fmt(env,
+				      "This store writes %d bytes at stack offset %d into a stack slot that currently holds a spilled pointer. "
+			"Partial writes to spilled pointers are rejected because they can corrupt pointer metadata and leak kernel pointers.",
+			size, off);
+		bpf_diag_memory(
+			env, insn_idx, "stack spill corruption", reason,
+			"Write the full 8-byte spilled pointer slot, or use a separate stack slot for scalar data before overwriting only part of it.");
 		return -EACCES;
 	}
 
@@ -3762,6 +3771,21 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static void bpf_diag_stack_read_uninit(struct bpf_verifier_env *env, int off, int i,
+				       int size)
+{
+	const char *reason;
+
+	reason = bpf_diag_fmt(env,
+			      "This rejected read uses %d bytes at stack offset %d, but byte %d in that range is uninitialized on this path. "
+		"Programs loaded with CAP_PERFMON can be allowed to read uninitialized stack bytes, but this program is being rejected without that allowance.",
+		size, off, i);
+	bpf_diag_memory(
+		env, env->insn_idx, "uninitialized stack read", reason,
+		"Initialize every byte in the stack range before reading it, adjust the offset and size so the read covers only initialized bytes, "
+		"or load with CAP_PERFMON if uninitialized stack reads are intended.");
+}
+
 /* Read the stack at 'off' and put the results into the register indicated by
  * 'dst_regno'. It handles reg filling if the addressed stack slot is a
  * spilled reg.
@@ -3851,6 +3875,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					} else {
 						verbose(env, "invalid read from stack off %d+%d size %d\n",
 							off, i, size);
+						bpf_diag_stack_read_uninit(env, off, i,
+									   size);
 					}
 					return -EACCES;
 				}
@@ -3909,6 +3935,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			} else {
 				verbose(env, "invalid read from stack off %d+%d size %d\n",
 					off, i, size);
+				bpf_diag_stack_read_uninit(env, off, i, size);
 			}
 			return -EACCES;
 		}
@@ -4001,11 +4028,19 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	 * check_stack_read_fixed_off).
 	 */
 	if (dst_regno < 0 && var_off) {
+		const char *reason;
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env, "variable offset stack pointer cannot be passed into helper function; var_off=%s off=%d size=%d\n",
 			tn_buf, off, size);
+		reason = bpf_diag_fmt(env,
+				      "The helper would access the stack through variable offset %s plus fixed offset %d and size %d. "
+			"Helper stack memory arguments require a constant stack offset and a precise initialized range.",
+			tn_buf, off, size);
+		bpf_diag_memory(
+			env, env->insn_idx, "variable stack access", reason,
+			"Use a fixed stack offset for helper memory arguments, or copy the needed bytes into a fixed stack slot first.");
 		return -EACCES;
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
@@ -4247,6 +4282,9 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 				   int off, int size, u32 mem_size,
 				   bool zero_size_allowed)
 {
+	const char *proof = "";
+	const char *start;
+	s64 max_start, max_end;
 	int err;
 
 	/* We may have adjusted the register pointing to memory region, so we
@@ -4265,14 +4303,28 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	      reg_smin(reg) + off < 0)) {
 		verbose(env, "%s min value is negative, either use unsigned index or do a if (index >=0) check.\n",
 			reg_arg_name(env, argno));
-		return -EACCES;
+		err = -EACCES;
+		if (bpf_diag_enabled(env)) {
+			start = bpf_diag_fmt_s64_sum(env, reg_smin(reg), off);
+			proof = bpf_diag_fmt(
+				env, "the minimal bound for a memory access is a negative value: %s",
+				start);
+		}
+		goto report_error;
 	}
+
 	err = __check_mem_access(env, reg, argno, reg_smin(reg) + off, size,
 				 mem_size, zero_size_allowed);
 	if (err) {
 		verbose(env, "%s min value is outside of the allowed memory range\n",
 			reg_arg_name(env, argno));
-		return err;
+		if (bpf_diag_enabled(env)) {
+			start = bpf_diag_fmt_s64_sum(env, reg_smin(reg), off);
+			proof = bpf_diag_fmt(
+				env, "the minimal bound for a memory access is %s and is outside of the object of size %u",
+				start, mem_size);
+		}
+		goto report_error;
 	}
 
 	/* If we haven't set a max value then we need to bail since we can't be
@@ -4282,17 +4334,36 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	if (reg_umax(reg) >= BPF_MAX_VAR_OFF) {
 		verbose(env, "%s unbounded memory access, make sure to bounds check any such access\n",
 			reg_arg_name(env, argno));
-		return -EACCES;
+		err = -EACCES;
+		if (bpf_diag_enabled(env))
+			proof = bpf_diag_fmt(
+				env, "the maximal bound for a memory access is %llu and exceeds maximum allowed offset of %u",
+				reg_umax(reg), BPF_MAX_VAR_OFF);
+		goto report_error;
 	}
+
 	err = __check_mem_access(env, reg, argno, reg_umax(reg) + off, size,
 				 mem_size, zero_size_allowed);
 	if (err) {
 		verbose(env, "%s max value is outside of the allowed memory range\n",
 			reg_arg_name(env, argno));
-		return err;
+		if (bpf_diag_enabled(env)) {
+			max_start = (s64)reg_umax(reg) + off;
+			max_end = max_start + size;
+			proof = bpf_diag_fmt(
+				env, "the maximal bound for a memory access is %lld: start %lld + access_size %d, beyond object_size %u",
+				max_end, max_start, size, mem_size);
+		}
+		goto report_error;
 	}
 
 	return 0;
+
+report_error:
+	bpf_diag_mem_bounds(env, env->insn_idx, reg_from_argno(argno),
+			    reg_arg_name(env, argno), reg_type_str(env, reg->type), proof,
+				   off, size, mem_size, reg);
+	return err;
 }
 
 static int __check_ptr_off_reg(struct bpf_verifier_env *env,
-- 
2.53.0

