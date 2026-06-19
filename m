Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089A3CF04C
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902798; cv=none; b=XcsJJQz1QKttwRJ0IRdl9sfi8e1lFdr3lwy/Lrx2B1yvchBCVMtEJ04CgZX9B7bjJO0+6lDj+0Is3RgYHDG4kfU4J62u6qJg1PU5gY5E9TEv0nm5QDO9PdMHNjUf+riMm+GhFO+FGEhN7p6ku5BNqxCp5uG/qGlbUpOTzbz73wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902798; c=relaxed/simple;
	bh=4g/odY+dLGPzhglUwfg3gXzak4u/hMDahYl989jQXhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVXPETmSK3fy85pj7LaCwCLUFc35iNIZ58AJpt7Nu/0G6FPmFpjwlXjLVlJA9MnkLI1Z9IfEpr0UzsMKrh8RYmSmbanf5Xo3/ZgNCdcYau3I8rwwl3kgXmmYD8mWWVmWMa+oIt6gTxop78gaK3sZ0QaH6745iL+vdMv7DlI1rTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWSN/lMT; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWSN/lMT"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-49249072f03so1016845e9.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902785; x=1782507585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc9Rv1EpfoK3U1/1mSA9bsiiqbqPF4Nq6L9I63iVTCU=;
        b=UWSN/lMToD7guG+jDz/SbVo4jXJw+1z/wnMj6SMN577gs+C2lZ8C6oIb4DJqUywKiG
         7aH50Bvj0UgcQ5V6QyOX3CVJkW8aXrOHhR+MWYoxMYZJm5w1mdkcVRQi3y/m0Witdwt3
         2yNjJt/g52qw6JMKkoy3f65O+TzBHR3jLzOYGesh2zbpJA+zCZG6RXo8f+5pvVr+eoiJ
         AAFjGM3/6P9SrjKbqypdy721akLN4rZblQ1kVL5wxDKXhrJbb5HOgRuxU4P5YQR3gPcY
         ciPMteQFgzpDU0l9ltSNaUoL25+WLIjkBYWVKodagTACwjMKAX6pr5BMBrj3Rp0q5G5k
         3zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902785; x=1782507585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tc9Rv1EpfoK3U1/1mSA9bsiiqbqPF4Nq6L9I63iVTCU=;
        b=k8iQlhsl+KOjQii5PErZFFnC/FCXuUYctMZho88YkoFGnWdVIKgQJ4TJelPnqZ+Hgj
         0S41IfK6G3DWU/qfJNQQ1mAQbvD7+kZ198Ms04kDY/6MMe/Pey9T75TUkHKIPKw1QtSp
         H9q1JHIWxjjeAOWEjDaxBtN9Wv2l9oscv77pOwc9PGRpSERl955n1TVG1wW8854lT3rq
         gIQUHUbwQWKUOmqFvbz7FrgTECBX9KHFLSNgQCjfQFRkFT2To4giMd83BnS93IsfyN9L
         ahgWM+IJM6vPi9DDfwjskblVgOxMqd2yOddha4DVmruLtNznCMZh/UEcmyzmYATkdOPx
         DmyA==
X-Gm-Message-State: AOJu0YwIEXsNldLC4587NIvTyXgikZA9w/ZzhuYz5eWu2vvQVvquGY7m
	on8Zd8aa7kj2wH8poB69buE0ZeV9IGLbnhzs+DCtSlE97wVEcobGrELqUzfQ6xeM
X-Gm-Gg: AfdE7cl6hjsfpab33UkWJThZGWOo6egWuel8fLywlKivxwuZPtLqeOwoZAtFGlHK6Ht
	EH6ZI8FldUS5ZcBYD9O82Fi2zA7QQRPTnucw3R2vtYYNdJg02RiIIhABx4PAvUyUzyjqR6EcHbB
	g+wTK8/u2TRy/y18KrFNA2qEQfmvwPTE3GQR5h7k9AFeoncfj8mACFSernDyrYoZZvPHjIriuJe
	Vr7fXriqws7owLyAohsTg3G8da/mhYPkeoXChoiyJjgvT3IQVYcugjpaoTNQ8+uy1KPD55SIw/2
	9JhT8Ml99fs1yOSUsny3xdKfia/68SNee2tcU3MwF8uGZSOydMWW8A8JKvR6UsFLI+J7eqmoKOK
	Cm2fYlia8RSwARuBAbaf9s/sazTGG/1OOH+DMRnCSfBSLGuVTPIy4loRO5lRIo5tx6Wk7h8Ie10
	lVlmIvKNZpqc4iRZk2MO0O/HDncnHNTjTj2gi1O760QsTW4udefcmBZAwmKz5IDbz3KtNbFdLGo
	Op2zOUZLfar+zEJQvMjQOimr76ZGWecYuPGXbXAj+C33f7S642FRvfzlpBnOAL0rA==
X-Received: by 2002:a05:600c:8b42:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-4923f5944eemr107485955e9.33.1781902784873;
        Fri, 19 Jun 2026 13:59:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46667221da1sm1774063f8f.36.2026.06.19.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:44 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 09/17] bpf: Report Memory Safety bounds errors
Date: Fri, 19 Jun 2026 22:59:22 +0200
Message-ID: <20260619205934.1312876-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14366; i=memxor@gmail.com; h=from:subject; bh=4g/odY+dLGPzhglUwfg3gXzak4u/hMDahYl989jQXhQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct05X+7ugebBac1mussrmW+4fh75fmK5UL6rBHfnf9Pj 1AuqWDvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQyPzIybPj9RK6F10TjfP1s y4/lmSyNM3qFbfwEFkwV9KqqPOFfxMgw47989O3XIpxshinyB/cH9v2qvj6p0j3eTeu7e1edsRE TAA==
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
 kernel/bpf/diagnostics.c | 161 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  16 ++++
 kernel/bpf/verifier.c    |  56 ++++++++++++++
 3 files changed, 233 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 92a4aef3cc90..933540eb105b 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -6,6 +6,7 @@
 #include <linux/btf.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/stdarg.h>
 #include <linux/string.h>
@@ -1048,6 +1049,19 @@ void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env,
 				   "Write the outgoing stack argument after any operation that may invalidate stored pointer values, and before making this call.");
 }
 
+void bpf_diag_report_memory(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *problem, const char *reason,
+			    const char *suggestion)
+{
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_MEMORY_SAFETY, problem);
+	bpf_diag_report_reason(env, "%s", reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true)
 {
@@ -1541,6 +1555,153 @@ static void bpf_diag_format_scalar_range(struct bpf_diag_reg_fmt *fmt,
 		  fmt->smin_buf, fmt->smax_buf, fmt->umin_buf, fmt->umax_buf);
 }
 
+static void bpf_diag_format_s64_sum(char *buf, size_t size, s64 value,
+				    int addend)
+{
+	s64 sum;
+
+	if (check_add_overflow(value, (s64)addend, &sum)) {
+		if (addend < 0)
+			scnprintf(buf, size, "%lld plus %d (below S64_MIN)",
+				  value, addend);
+		else
+			scnprintf(buf, size, "%lld plus %d (above S64_MAX)",
+				  value, addend);
+		return;
+	}
+
+	scnprintf(buf, size, "%lld", sum);
+}
+
+static void bpf_diag_format_access_offset(struct bpf_verifier_env *env,
+					  char *buf, size_t size, int off,
+					  const struct bpf_reg_state *reg)
+{
+	struct bpf_diag_scratch *scratch = bpf_diag_scratch(env);
+	struct bpf_diag_reg_fmt *fmt;
+	char *start;
+
+	if (tnum_is_const(reg->var_off)) {
+		start = bpf_diag_scratch_buf(env, 2,
+					     NULL);
+		if (!start) {
+			scnprintf(buf, size, "constant");
+			return;
+		}
+		bpf_diag_format_s64_sum(start, BPF_DIAG_SCRATCH_STR_LEN,
+					(s64)reg->var_off.value, off);
+		scnprintf(buf, size, "constant %s", start);
+		return;
+	}
+
+	if (tnum_is_unknown(reg->var_off) &&
+	    bpf_diag_cnum64_unknown(reg->r64)) {
+		scnprintf(buf, size, "unknown");
+		return;
+	}
+
+	fmt = &scratch->reg_fmt;
+	memset(fmt, 0, sizeof(*fmt));
+
+	bpf_diag_format_scalar_range(fmt, fmt->range, sizeof(fmt->range),
+				     reg->r64);
+	if (off)
+		scnprintf(buf, size,
+			  "variable: known bits %#llx, unknown mask %#llx, plus fixed offset %d; %s",
+			  (u64)reg->var_off.value, reg->var_off.mask, off,
+			  fmt->range);
+	else
+		scnprintf(buf, size,
+			  "variable: known bits %#llx, unknown mask %#llx; %s",
+			  (u64)reg->var_off.value, reg->var_off.mask,
+			  fmt->range);
+}
+
+static u64 bpf_diag_mem_max_start(const struct bpf_reg_state *reg, int off)
+{
+	/* A negative fixed offset can clamp the maximum start to zero when
+	 * the unsigned variable maximum is smaller than -off.
+	 */
+	if (off < 0 && reg_umax(reg) < (u64)-off)
+		return 0;
+	return reg_umax(reg) + off;
+}
+
+void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx,
+				int regno, const char *reg_name,
+				const char *type_name,
+				enum bpf_diag_mem_bounds_kind kind,
+				int off, int size, u32 mem_size,
+				const struct bpf_reg_state *reg)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = bpf_diag_current_frameno(env),
+		.regno = regno,
+	};
+	char *offset_desc, *proof, *start;
+	u64 max_start, max_end;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	offset_desc = bpf_diag_scratch_buf(env, 0, NULL);
+	proof = bpf_diag_scratch_buf(env, 1, NULL);
+	start = bpf_diag_scratch_buf(env, 2, NULL);
+	if (!offset_desc || !proof || !start)
+		return;
+
+	switch (kind) {
+	case BPF_DIAG_MEM_NEGATIVE_MIN:
+		bpf_diag_format_s64_sum(start, BPF_DIAG_SCRATCH_STR_LEN, reg_smin(reg),
+					off);
+		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
+			  "the smallest possible access starts at %s, below 0",
+			  start);
+		break;
+	case BPF_DIAG_MEM_MIN_OUT_OF_RANGE:
+		bpf_diag_format_s64_sum(start, BPF_DIAG_SCRATCH_STR_LEN, reg_smin(reg),
+					off);
+		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
+			  "the smallest possible access starts at %s, outside object_size %u",
+			  start, mem_size);
+		break;
+	case BPF_DIAG_MEM_UNBOUNDED:
+		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
+			  "%s has unsigned maximum %llu, which exceeds BPF_MAX_VAR_OFF %u",
+			  reg_name, reg_umax(reg), BPF_MAX_VAR_OFF);
+		break;
+	case BPF_DIAG_MEM_MAX_OUT_OF_RANGE:
+	default:
+		max_start = bpf_diag_mem_max_start(reg, off);
+		max_end = max_start + size;
+		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
+			  "the largest possible access ends at %llu: start %llu + access_size %d, beyond object_size %u",
+			  max_end, max_start, size, mem_size);
+		break;
+	}
+
+	bpf_diag_format_access_offset(env, offset_desc, BPF_DIAG_SCRATCH_STR_LEN,
+				      off, reg);
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_MEMORY_SAFETY,
+			       "access outside bounds");
+	bpf_diag_report_reason(env,
+			       "The verifier cannot prove offset + access_size <= object_size. Here, %s. %s is %s; offset is %s; access_size is %d; object_size is %u.",
+			       proof, reg_name, type_name, offset_desc, size,
+			       mem_size);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error",
+			       "access may be outside object bounds");
+
+	if (regno >= 0)
+		bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env,
+				   "Add or adjust a bounds check that proves offset + access_size stays within the object.");
+}
+
 static void bpf_diag_format_var_offset(struct bpf_diag_reg_fmt *fmt,
 				       char *buf, size_t size,
 				       const struct bpf_diag_reg_snapshot *snapshot)
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index d6e858cd39f2..fea7731d431c 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -124,6 +124,13 @@ enum bpf_diag_invalid_deref_kind {
 	BPF_DIAG_DEREF_INVALID_PTR,
 };
 
+enum bpf_diag_mem_bounds_kind {
+	BPF_DIAG_MEM_NEGATIVE_MIN,
+	BPF_DIAG_MEM_MIN_OUT_OF_RANGE,
+	BPF_DIAG_MEM_UNBOUNDED,
+	BPF_DIAG_MEM_MAX_OUT_OF_RANGE,
+};
+
 struct bpf_diag_history_opts {
 	enum bpf_diag_history_scope scope;
 	u32 frameno;
@@ -171,6 +178,15 @@ void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env,
 				      u32 insn_idx, int nargs,
 				      int stack_arg_slot,
 				      const char *callee_name);
+void bpf_diag_report_memory(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *problem, const char *reason,
+			    const char *suggestion);
+void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx,
+				int regno, const char *reg_name,
+				const char *type_name,
+				enum bpf_diag_mem_bounds_kind kind,
+				int off, int size, u32 mem_size,
+				const struct bpf_reg_state *reg);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true);
 void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c5f24528071..af04709c5178 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3527,6 +3527,13 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	    !bpf_is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
+		bpf_diag_report_memory(env, insn_idx,
+				       "stack spill corruption",
+				       bpf_diag_scratch_printf(env,
+							       0,
+							       "This store writes %d bytes at stack offset %d into a stack slot that currently holds a spilled pointer. Partial writes to spilled pointers are rejected because they can corrupt pointer metadata and leak kernel pointers.",
+							       size, off),
+				       "Write the full 8-byte spilled pointer slot, or use a separate stack slot for scalar data before overwriting only part of it.");
 		return -EACCES;
 	}
 
@@ -3811,6 +3818,18 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
 	}
 }
 
+static void bpf_diag_report_stack_read_uninit(struct bpf_verifier_env *env,
+					      int off, int i, int size)
+{
+	bpf_diag_report_memory(env, env->insn_idx,
+			       "uninitialized stack read",
+			       bpf_diag_scratch_printf(env,
+						       0,
+						       "This rejected read uses %d bytes at stack offset %d, but byte %d in that range is uninitialized on this path. Programs with sufficient privilege can be allowed to read uninitialized stack bytes, but this program is being rejected without that allowance.",
+						       size, off, i),
+			       "Initialize every byte in the stack range before reading it, adjust the offset and size so the read covers only initialized bytes, or load with the privilege needed for uninitialized stack reads.");
+}
+
 /* Read the stack at 'off' and put the results into the register indicated by
  * 'dst_regno'. It handles reg filling if the addressed stack slot is a
  * spilled reg.
@@ -3896,9 +3915,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					if (type == STACK_POISON) {
 						verbose(env, "reading from stack off %d+%d size %d, slot poisoned by dead code elimination\n",
 							off, i, size);
+						return -EFAULT;
 					} else {
 						verbose(env, "invalid read from stack off %d+%d size %d\n",
 							off, i, size);
+						bpf_diag_report_stack_read_uninit(env, off, i,
+										  size);
 					}
 					return -EACCES;
 				}
@@ -3951,9 +3973,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			if (type == STACK_POISON) {
 				verbose(env, "reading from stack off %d+%d size %d, slot poisoned by dead code elimination\n",
 					off, i, size);
+				return -EFAULT;
 			} else {
 				verbose(env, "invalid read from stack off %d+%d size %d\n",
 					off, i, size);
+				bpf_diag_report_stack_read_uninit(env, off, i,
+								  size);
 			}
 			return -EACCES;
 		}
@@ -4045,6 +4070,13 @@ static int check_stack_read(struct bpf_verifier_env *env,
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env, "variable offset stack pointer cannot be passed into helper function; var_off=%s off=%d size=%d\n",
 			tn_buf, off, size);
+		bpf_diag_report_memory(env, env->insn_idx,
+				       "variable stack access",
+				       bpf_diag_scratch_printf(env,
+							       0,
+							       "The helper would access the stack through variable offset %s plus fixed offset %d and size %d. Helper stack memory arguments require a constant stack offset and a precise initialized range.",
+							       tn_buf, off, size),
+				       "Use a fixed stack offset for helper memory arguments, or copy the needed bytes into a fixed stack slot first.");
 		return -EACCES;
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
@@ -4312,6 +4344,12 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	      reg_smin(reg) + off < 0)) {
 		verbose(env, "%s min value is negative, either use unsigned index or do a if (index >=0) check.\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_mem_bounds(env, env->insn_idx,
+					   reg_from_argno(argno),
+					   reg_arg_name(env, argno),
+					   reg_type_str(env, reg->type),
+					   BPF_DIAG_MEM_NEGATIVE_MIN,
+					   off, size, mem_size, reg);
 		return -EACCES;
 	}
 	err = __check_mem_access(env, reg, argno, reg_smin(reg) + off, size,
@@ -4319,6 +4357,12 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	if (err) {
 		verbose(env, "%s min value is outside of the allowed memory range\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_mem_bounds(env, env->insn_idx,
+					   reg_from_argno(argno),
+					   reg_arg_name(env, argno),
+					   reg_type_str(env, reg->type),
+					   BPF_DIAG_MEM_MIN_OUT_OF_RANGE,
+					   off, size, mem_size, reg);
 		return err;
 	}
 
@@ -4329,6 +4373,12 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	if (reg_umax(reg) >= BPF_MAX_VAR_OFF) {
 		verbose(env, "%s unbounded memory access, make sure to bounds check any such access\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_mem_bounds(env, env->insn_idx,
+					   reg_from_argno(argno),
+					   reg_arg_name(env, argno),
+					   reg_type_str(env, reg->type),
+					   BPF_DIAG_MEM_UNBOUNDED,
+					   off, size, mem_size, reg);
 		return -EACCES;
 	}
 	err = __check_mem_access(env, reg, argno, reg_umax(reg) + off, size,
@@ -4336,6 +4386,12 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	if (err) {
 		verbose(env, "%s max value is outside of the allowed memory range\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_mem_bounds(env, env->insn_idx,
+					   reg_from_argno(argno),
+					   reg_arg_name(env, argno),
+					   reg_type_str(env, reg->type),
+					   BPF_DIAG_MEM_MAX_OUT_OF_RANGE,
+					   off, size, mem_size, reg);
 		return err;
 	}
 
-- 
2.53.0

