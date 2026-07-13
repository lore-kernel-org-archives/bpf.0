Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B642EEAB
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957167; cv=none; b=qORbgdJcRW3qA6mk3zJ8TCwjm9bRuDzfWK42QovsG+YBSv8ODEW7VlspbkAywR1gE9h5EK35+LIn8kDpjF54jFqaJpWtPYhtUfMxE1VPga1V1y4qnJM9jcNhHHf98CyMZYcBHVuYfbpZh33+Oh5Z98d9AfMoLAok9q9rQvncAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957167; c=relaxed/simple;
	bh=6nyXlkBNlxYlSBzvrwquW3GUR1RTlBDxmsKg4fbenYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpyRBQKl32Oc5Pl9b1zvBb0AgH1qXgNqkJ0AFNE/rgerkTpZ0SA5rgdvtEjkc/Du8xGOY92Azi5nh/JysOwNW1SdCS6DMC5M3gyzXml+syTn8+7Khvp7c6ibwPlrLqq29+kXqZZGv3d2XkEjDAq4W7zK94msT588zLtLVRVva5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPhqQltx; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPhqQltx"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493c234fba7so7611165e9.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957164; x=1784561964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ogt4yEmvudHYz7ryebrtcH0cHD4IC0R83iAOSvPTEQk=;
        b=gPhqQltxVMGR4IbhD5zejo60V2gLm8gpA30/0LlJXyryuGsKmKsQ0t1blj0I8spvP+
         5q74ekaH0QXJSCjnWcqZ7VLrfMlUIZmbyiXmno+NrAC9fm064jmA40YgZ1PtNiwT4o7W
         ud50no+CFLHsvHMlbtt1YWGwl0qBH97+WTBECJH9aU85QX1oY9kF2ZyjcbhNYXBVmlCV
         jx/9ux6HxJol8Rd9gZ/9mvbti3yjYQho7doSDny1WXrXp+XezcbbZ3+mC4Piu3sdEP01
         yd33iIERuUymB7IKgVFnSptgRums1DytyqTR1TNuw53dkW5ouioMN52UXgnqSp+hrs2I
         ytwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957164; x=1784561964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ogt4yEmvudHYz7ryebrtcH0cHD4IC0R83iAOSvPTEQk=;
        b=SBBnWNo2J5rpMKS7xHR8OXea6L7kDj6I8an+MDxoxlPS9y0dQmtQWtTYUQ2a5JYbOd
         /qEsuOl4e6opAgzzjrYCD07VgTFppfBbvCR3vFbr9h+ApWn7pwly5B4VLGwnTYuZlkTQ
         ZcKT+VchdCAN+hQJ2IA1N6bjHLODxz1b7ZtgXAXBAgK7CETgjy/22JOkkgGMUa18s9dB
         TgjNDYdW3asIJRMPAu6RsUIxpB95HbSt5gUXRVxTi/seBwGaw5//uyy5CBhYmREacxUj
         ys2JFgHSk6jK302xCVnGb+s4I2V/iYzZxLcFuFg5kWblX0O8U4qBb0MsCQ9d5ank5mrB
         uEUg==
X-Gm-Message-State: AOJu0Yx85rH5Y++R0jUD7QYr5Ay5HhRonH1yaJk6U7xriOw9aioZU/7e
	6vpvuaKVbNTeJJ+RMDaN6jpHBP/J8bdqH1b0wV9dFjaMOPQ4PiZGVfK9avJfL7rU
X-Gm-Gg: AfdE7cnpWfh/oYl4glfNfK/hNafglfWyvh2h7ou1qUXO2H3iD4zc1s0HsfKP2SPrj19
	CFPq1GFwyNjLNdKm68KLHSque/YxSgEPy/8QuOIbKXV17CP+3UoHH3VcBvNHz93ylWtv+rbW0hr
	3zs3gYdoqe1ZtqMdGHcI0Eeey5zYZhpsK+waKpVewf8SRvqWZj/sGvsIqoU8ZD0buMbo1niSeB3
	ZhR52PTk/RwtaWgVy5NbnZF9QzMYQAQc5LAy9h/wWDWIucxO3IFdaf9QCJYW9KatFug8txv/Smr
	Uk3iD7/okI96JvBwYC9aQo70+ckCgCJsohjxDlvfc99HNk04ACtInCYHpj56CKtB7Ka5gSqr5q9
	S8/GtKO8osObJN39RHXT4DisDonkFt3A3RuHp+Ard8T3uMSr2Awxsbkz0SpJdPv0XU3Bi1v+kZ/
	e8DlargWjKCBuB5+x8gMM4j1WGLKxiCpyYx79z3clsSAusRHFPLk35eEguMs5AzzYT3hVsSgrxB
	ucOWEqeVVNPVRiznNMsZipJAy5Jp/um7mT8JXqwDFnaloR0wdvbtv8=
X-Received: by 2002:a05:600c:8284:b0:493:a5f9:d33d with SMTP id 5b1f17b1804b1-493f8824395mr103445575e9.18.1783957163704;
        Mon, 13 Jul 2026 08:39:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a2e499sm302962285e9.0.2026.07.13.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 09/17] bpf: Report Memory Safety bounds errors
Date: Mon, 13 Jul 2026 17:38:58 +0200
Message-ID: <20260713153910.2556007-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14161; i=memxor@gmail.com; h=from:subject; bh=6nyXlkBNlxYlSBzvrwquW3GUR1RTlBDxmsKg4fbenYk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURSH46OalTeuqhE9uvtUeYGDIoB7EuevX2eumM1hv3 QuZmzy3o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABMpiGb4K/J57h3d7TmHF9/o 2FT30vLyJjuhDId5tjNsLZVTajf+z2f4H1V36fnN66Zs2h+SFzudXBYbuvQaa/PmV8sOT34Rtsl SlwsA
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
 kernel/bpf/diagnostics.c | 100 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |   6 +++
 kernel/bpf/verifier.c    | 102 +++++++++++++++++++++++++++++++++++----
 3 files changed, 199 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 0fa61882ee69..d4588b19aac9 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -7,6 +7,7 @@
 #include <linux/btf.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/stdarg.h>
 #include <linux/string.h>
@@ -1102,6 +1103,18 @@ void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx
 				    "call.");
 }
 
+void bpf_diag_report_memory(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+			    const char *reason, const char *suggestion)
+{
+	bpf_diag_report_header(env, CATEGORY_MEMORY_SAFETY, problem);
+	diag_report_reason(env, "%s", reason);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	diag_report_suggestion(env, "%s", suggestion);
+}
+
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true)
 {
 	struct bpf_diag_history_event event = {
@@ -1544,6 +1557,93 @@ static void diag_format_scalar_range(struct bpf_diag_reg_fmt *fmt, char *buf, si
 		  fmt->smax_buf, fmt->umin_buf, fmt->umax_buf);
 }
 
+void bpf_diag_format_s64_sum(char *buf, size_t size, s64 value, int addend)
+{
+	s64 sum;
+
+	if (check_add_overflow(value, (s64)addend, &sum)) {
+		if (addend < 0)
+			scnprintf(buf, size, "%lld plus %d (below S64_MIN)", value, addend);
+		else
+			scnprintf(buf, size, "%lld plus %d (above S64_MAX)", value, addend);
+		return;
+	}
+
+	scnprintf(buf, size, "%lld", sum);
+}
+
+static void diag_format_access_offset(struct bpf_verifier_env *env, char *buf, size_t size, int off,
+				      const struct bpf_reg_state *reg)
+{
+	struct bpf_diag_scratch *scratch = diag_scratch(env);
+	struct bpf_diag_reg_fmt *fmt;
+	char *start;
+
+	if (tnum_is_const(reg->var_off)) {
+		start = bpf_diag_scratch_buf(env, 2, NULL);
+		if (!start) {
+			scnprintf(buf, size, "constant");
+			return;
+		}
+		bpf_diag_format_s64_sum(start, BPF_DIAG_SCRATCH_STR_LEN, (s64)reg->var_off.value,
+					off);
+		scnprintf(buf, size, "constant %s", start);
+		return;
+	}
+
+	if (tnum_is_unknown(reg->var_off) && diag_cnum64_unknown(reg->r64)) {
+		scnprintf(buf, size, "unbounded");
+		return;
+	}
+
+	fmt = &scratch->reg_fmt;
+	memset(fmt, 0, sizeof(*fmt));
+
+	diag_format_scalar_range(fmt, fmt->range, sizeof(fmt->range), reg->r64);
+	if (off)
+		scnprintf(buf, size,
+			  "variable: known bits %#llx, unknown mask %#llx, plus fixed offset %d; "
+			  "%s",
+			  (u64)reg->var_off.value, reg->var_off.mask, off, fmt->range);
+	else
+		scnprintf(buf, size, "variable: known bits %#llx, unknown mask %#llx; %s",
+			  (u64)reg->var_off.value, reg->var_off.mask, fmt->range);
+}
+
+void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+				const char *reg_name, const char *type_name, const char *proof,
+				int off, int size, u32 mem_size, const struct bpf_reg_state *reg)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = diag_current_frameno(env),
+		.regno = regno,
+	};
+	char *offset_desc;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	offset_desc = bpf_diag_scratch_buf(env, 0, NULL);
+
+	diag_format_access_offset(env, offset_desc, BPF_DIAG_SCRATCH_STR_LEN, off, reg);
+
+	bpf_diag_report_header(env, CATEGORY_MEMORY_SAFETY, "access outside bounds");
+	diag_report_reason(env,
+			   "The verifier cannot prove offset + access_size <= object_size. Here, "
+			   "%s. %s is %s; offset is %s; access_size is %d; object_size is %u.",
+			   proof, reg_name, type_name, offset_desc, size, mem_size);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "access may be outside object bounds");
+
+	if (regno >= 0)
+		diag_print_history(env, &opts);
+
+	diag_report_suggestion(env, "Add or adjust a bounds check that proves offset + access_size "
+				    "stays within the object.");
+}
+
 static void diag_format_var_offset(struct bpf_diag_reg_fmt *fmt, char *buf, size_t size,
 				   const struct bpf_diag_reg_snapshot *snapshot)
 {
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 28bc234cfe56..4fc8abb2f2b9 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -14,6 +14,7 @@ struct bpf_verifier_state;
 struct btf;
 
 void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *btf, u32 type_id);
+void bpf_diag_format_s64_sum(char *buf, size_t size, s64 value, int addend);
 
 enum bpf_diag_mod_reason {
 	BPF_DIAG_MOD_WRITE,
@@ -136,6 +137,11 @@ void bpf_diag_report_unreadable_reg(struct bpf_verifier_env *env, u32 insn_idx,
 void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int nargs,
 				      int stack_arg_slot, const char *callee_name,
 				      const char *arg_name);
+void bpf_diag_report_memory(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+			    const char *reason, const char *suggestion);
+void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+				const char *reg_name, const char *type_name, const char *proof,
+				int off, int size, u32 mem_size, const struct bpf_reg_state *reg);
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca903e4e53ea..bd233083b495 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3614,7 +3614,18 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	    bpf_is_spilled_reg(&state->stack[spi]) &&
 	    !bpf_is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
+		const char *fmt = "This store writes %d bytes at stack offset %d into a stack slot "
+				  "that currently holds a spilled pointer. Partial writes to "
+				  "spilled pointers are rejected because they can corrupt pointer "
+				  "metadata and leak kernel pointers.";
+		const char *reason;
+
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
+		reason = bpf_diag_scratch_printf(env, 0, fmt, size, off);
+		bpf_diag_report_memory(env, insn_idx, "stack spill corruption", reason,
+				       "Write the full 8-byte spilled pointer slot, or use a "
+				       "separate stack slot for scalar data before overwriting "
+				       "only part of it.");
 		return -EACCES;
 	}
 
@@ -3913,6 +3924,22 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static void bpf_diag_report_stack_read_uninit(struct bpf_verifier_env *env, int off, int i,
+					      int size)
+{
+	const char *fmt = "This rejected read uses %d bytes at stack offset %d, but byte %d in "
+			  "that range is uninitialized on this path. Programs loaded with "
+			  "CAP_PERFMON can be allowed to read uninitialized stack bytes, but this "
+			  "program is being rejected without that allowance.";
+	const char *reason;
+
+	reason = bpf_diag_scratch_printf(env, 0, fmt, size, off, i);
+	bpf_diag_report_memory(env, env->insn_idx, "uninitialized stack read", reason,
+			       "Initialize every byte in the stack range before reading it, adjust "
+			       "the offset and size so the read covers only initialized bytes, or "
+			       "load with CAP_PERFMON if uninitialized stack reads are intended.");
+}
+
 /* Read the stack at 'off' and put the results into the register indicated by
  * 'dst_regno'. It handles reg filling if the addressed stack slot is a
  * spilled reg.
@@ -4002,6 +4029,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					} else {
 						verbose(env, "invalid read from stack off %d+%d size %d\n",
 							off, i, size);
+						bpf_diag_report_stack_read_uninit(env, off, i,
+										  size);
 					}
 					return -EACCES;
 				}
@@ -4060,6 +4089,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			} else {
 				verbose(env, "invalid read from stack off %d+%d size %d\n",
 					off, i, size);
+				bpf_diag_report_stack_read_uninit(env, off, i, size);
 			}
 			return -EACCES;
 		}
@@ -4152,11 +4182,20 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	 * check_stack_read_fixed_off).
 	 */
 	if (dst_regno < 0 && var_off) {
+		const char *fmt = "The helper would access the stack through variable offset %s "
+				  "plus fixed offset %d and size %d. Helper stack memory arguments "
+				  "require a constant stack offset and a precise initialized "
+				  "range.";
+		const char *reason;
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env, "variable offset stack pointer cannot be passed into helper function; var_off=%s off=%d size=%d\n",
 			tn_buf, off, size);
+		reason = bpf_diag_scratch_printf(env, 0, fmt, tn_buf, off, size);
+		bpf_diag_report_memory(env, env->insn_idx, "variable stack access", reason,
+				       "Use a fixed stack offset for helper memory arguments, or "
+				       "copy the needed bytes into a fixed stack slot first.");
 		return -EACCES;
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
@@ -4405,10 +4444,14 @@ static int __check_mem_access(struct bpf_verifier_env *env, struct bpf_reg_state
 }
 
 /* check read/write into a memory region with possible variable offset */
-static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-				   int off, int size, u32 mem_size,
+static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				   argno_t argno, int off, int size, u32 mem_size,
 				   bool zero_size_allowed)
 {
+	const char *proof = "";
+	char *start;
+	size_t start_size;
+	s64 max_start, max_end;
 	int err;
 
 	/* We may have adjusted the register pointing to memory region, so we
@@ -4422,19 +4465,37 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	 * will have a set floor within our range.
 	 */
 	if (reg_smin(reg) < 0 &&
-	    (reg_smin(reg) == S64_MIN ||
-	     (off + reg_smin(reg) != (s64)(s32)(off + reg_smin(reg))) ||
-	      reg_smin(reg) + off < 0)) {
+	    (reg_smin(reg) == S64_MIN || (off + reg_smin(reg) != (s64)(s32)(off + reg_smin(reg))) ||
+	     reg_smin(reg) + off < 0)) {
 		verbose(env, "%s min value is negative, either use unsigned index or do a if (index >=0) check.\n",
 			reg_arg_name(env, argno));
-		return -EACCES;
+		err = -EACCES;
+		if (bpf_diag_enabled(env)) {
+			start = bpf_diag_scratch_buf(env, 2, &start_size);
+			bpf_diag_format_s64_sum(start, start_size, reg_smin(reg), off);
+			proof = bpf_diag_scratch_printf(env, 1,
+							"the minimal bound for a memory access is "
+							"a negative value: %s",
+							start);
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
+			start = bpf_diag_scratch_buf(env, 2, &start_size);
+			bpf_diag_format_s64_sum(start, start_size, reg_smin(reg), off);
+			proof = bpf_diag_scratch_printf(env, 1,
+							"the minimal bound for a memory access is "
+							"%s and is outside of the object of size "
+							"%u",
+							start, mem_size);
+		}
+		goto report_error;
 	}
 
 	/* If we haven't set a max value then we need to bail since we can't be
@@ -4444,17 +4505,40 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	if (reg_umax(reg) >= BPF_MAX_VAR_OFF) {
 		verbose(env, "%s unbounded memory access, make sure to bounds check any such access\n",
 			reg_arg_name(env, argno));
-		return -EACCES;
+		err = -EACCES;
+		if (bpf_diag_enabled(env))
+			proof = bpf_diag_scratch_printf(env, 1,
+							"the maximal bound for a memory access is "
+							"%llu and exceeds maximum allowed offset "
+							"of %u",
+							reg_umax(reg), BPF_MAX_VAR_OFF);
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
+			proof = bpf_diag_scratch_printf(env, 1,
+							"the maximal bound for a memory access is "
+							"%lld: start %lld + access_size %d, beyond "
+							"object_size %u",
+							max_end, max_start, size, mem_size);
+		}
+		goto report_error;
 	}
 
 	return 0;
+
+report_error:
+	bpf_diag_report_mem_bounds(env, env->insn_idx, reg_from_argno(argno),
+				   reg_arg_name(env, argno), reg_type_str(env, reg->type), proof,
+				   off, size, mem_size, reg);
+	return err;
 }
 
 static int __check_ptr_off_reg(struct bpf_verifier_env *env,
-- 
2.53.0

