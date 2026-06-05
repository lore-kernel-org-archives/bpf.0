Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0E340DFA0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641266; cv=none; b=n6PG0qegxI1/MA8ThImh169k3TdX6Di+VeEyh/x3AbkNfh4Prts59mhWkDbPODgkqZd8h6sQwcqpAUMDPtF7GTybcX/pLg7k3JfWkxqezjkKbKSm+2NvAEek65DVFrGApeNaRSXbVq9mHD3Yy8lh6m4JMK01KH0W8yD0cfm6ivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641266; c=relaxed/simple;
	bh=TMacBgAPchcWgkkUFQBISrxOa2IyM7jq3hrpRRpNNy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtjJYxgEMe7xKYpaOzwL/xGiLdqr3J/Y+wwpGY4ctLKx8YsNVyBQl7kaTkFfLx8XwrvFUK+LLkIBsYoax6RdJXAu1PJqJJQjCmF+SwO3r97/vzbwsTRX9gGZf9+NhMtnVhcheinaO44jg/Z+8Rir+TX6Y3+e41fkP+FhqIuSdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmWbnoPR; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmWbnoPR"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so13036565e9.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641264; x=1781246064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vARlD/T7FHfe+5ZmC6eJ2OUiyBUd4BbB4+ZfSQyoTsI=;
        b=JmWbnoPRmiUJQW2P7reU696L/UkQkyg+/D7ZYdO8+WmeC1IJzy8Iur63tWq3WJ357W
         CQX48wM9ul2/d3XFRHsYJHXUJmxsAKKAW1MCipr07kJn+vPQSj4McXENBzyPO5yETzR7
         Rz7RO7rIIPFq0SurMf2au1d9o0HBaw6Ux6NG4nQcPIU+Rf4VKIeZ+0cbs96tW81zUvgD
         P1F1ImsDamw7TpdzEbUp6bPNnwEXbZneGrEUG85Imy60lum9S5UXMb25I/vrwzZpSWCF
         kTtJSBBC/YRVV3H+YcTvqmsLm+rKQ6lipICBjiWXs1AA/ehskhlqtGsdx9IZ5czxH+lA
         8KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641264; x=1781246064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vARlD/T7FHfe+5ZmC6eJ2OUiyBUd4BbB4+ZfSQyoTsI=;
        b=Sq4sk4ODXdU0VVkLB7GlNvWUpRHYDh0KgrlVwkDajRzh/dFmZ9UoYaJGPGKDrxHDov
         5Y+Ne0f2Fpol+w8gghSKIVIg1PIRaYOvM5ONM+dlC7CU5yKlYpJ4Mi5wbCC1jCOX3Th6
         KNxFrk6LxUnwsS3ozyu2jzoZMC0PXylgG6WJ77yrXTZb5V2/97gXMvqc7sPRA5poGXJM
         vj8BXYw3XWycbmMUIA0v/wwiCmhmc5QK+jS7bPFM/bfV2IAcpUmPEOc3NKWKKmMuJ1NS
         JMtnlI+QOfY9nPPN5q5qgN7wTTe/s2PGW1Et1+IvnQR3rtV2TKiYchJdRVD1/k4Dp0VR
         FWFA==
X-Gm-Message-State: AOJu0YwR67eZboen1pqsuxKUZXIEjhc2p6l1O6R2XrMtFez6CnKIn7Jw
	4tv6KtkxWB+OSV/m/cfldeaVHQSkD83GeN4kPD1zrAJkx1Dwzbbp00hHYZ7vxrfP
X-Gm-Gg: Acq92OEHzIdxV3tEGyFhuZ2m6xggQVJefWg7N6JgDsDb9kUwuMop9SKtT0JM3mMWBGX
	bFId84OBgkN4L77elVvDgc7ERPbuy9ciHHnZTRBiOCmQ+uQQ1dfZIHw6cLtcR8G02+8tgeAZCwW
	NNPpMaVJxtnp0XONWCSKTveWsOpbH6iuh3fqtXiCuS6VEgF4COjTGR53ZFIfRzSOXln5eF2ssJt
	LuPCD3ek/8ITpjLUTSRmzzGDQBumGWxXeMy/mqBdHoV8oIMd2Y0aCvWAr1Xqbs8sehsN/HfK+hM
	K5GopfPdcYs0cgZgSKYwXDEOoQnqCvd8KW7qxQmMDo4cGvqldabVnc8ununiGHmCn8iBux7vVDt
	JYFyaoMOQhKvwGT1uNgVy1qawKldtlk7w+TgZAJvrU3UKvm8c+sowo9DRe5bHIggVYPpQ+ByH9/
	ueVCpFt2CmAuhXqhDxunXJT2gdWpTSmAgSIdR+p9XWeZTnCMlBSCFpc86REZXqoyJhvIpR5LzXc
	XSUDSAMnWvSnDI5iDGlR62O5zOpnA15wU1xNbBpe0aoElm2rBA5Y4RcQgo+tNiddWwZ10fhAsJi
X-Received: by 2002:a05:600c:4506:b0:490:b642:ce2a with SMTP id 5b1f17b1804b1-490c25c0d27mr29122305e9.9.1780641263516;
        Thu, 04 Jun 2026 23:34:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm132893845e9.13.2026.06.04.23.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/17] bpf: Report Memory Safety bounds errors
Date: Fri,  5 Jun 2026 08:33:59 +0200
Message-ID: <20260605063412.974640-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12918; i=memxor@gmail.com; h=from:subject; bh=TMacBgAPchcWgkkUFQBISrxOa2IyM7jq3hrpRRpNNy8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt/jyU/1TJt8iOPP9Y74J7tyanrf5auF+jV7O8khPz chtzEwdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmIjDY0aGh7lRVh92GjLlNxx5 594WVTO37/fhwKmxvUYhWwIPG8x9A1Tx+syeBUs/XlzD+p5tzbILV1e8DLtT68OzNi798r/6M2o 8AA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment check_mem_region_access() range-proof failures with Memory Safety
reports. The existing terse verifier messages remain in place for compatibility;
the new report adds the failed proof, source context, causal path, and guidance.

Cover negative signed minima, minimum offsets outside the object, unbounded
upper offsets, and maximum offsets outside the object.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 113 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  16 ++++++
 kernel/bpf/verifier.c    |  77 ++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 920ac17758c2..0abe1ab19d25 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -809,6 +809,119 @@ void bpf_diag_report_unreadable_reg(struct bpf_verifier_env *env,
 				   "Avoid using the register after it is invalidated, or reload and revalidate a fresh pointer before this instruction.");
 }
 
+static void bpf_diag_format_access_offset(char *buf, size_t size, int off,
+					  const struct bpf_reg_state *reg)
+{
+	char range[BPF_DIAG_REG_DESC_LEN];
+
+	if (tnum_is_const(reg->var_off)) {
+		scnprintf(buf, size, "constant %lld",
+			  (s64)off + reg->var_off.value);
+		return;
+	}
+
+	if (bpf_diag_var_off_unknown(reg->var_off.value, reg->var_off.mask) &&
+	    bpf_diag_range_unknown(reg_smin(reg), reg_smax(reg),
+				   reg_umin(reg), reg_umax(reg))) {
+		scnprintf(buf, size, "unknown");
+		return;
+	}
+
+	bpf_diag_format_scalar_range(range, sizeof(range), reg_smin(reg),
+				     reg_smax(reg), reg_umin(reg),
+				     reg_umax(reg));
+	if (off) {
+		scnprintf(buf, size,
+			  "variable: pointer known bits %#llx, unknown mask %#llx, plus %d from this access; %s",
+			  (u64)reg->var_off.value, reg->var_off.mask, off,
+			  range);
+		return;
+	}
+
+	scnprintf(buf, size,
+		  "variable: known bits %#llx, unknown mask %#llx, %s",
+		  (u64)reg->var_off.value, reg->var_off.mask,
+		  range);
+}
+
+void bpf_diag_report_memory(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *problem, const char *reason,
+			    const char *suggestion)
+{
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_MEMORY_SAFETY,
+			       problem);
+	bpf_diag_report_reason(env, "%s", reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!', "%s", problem);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
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
+	char offset_desc[256];
+	char proof[192];
+	u64 max_start, max_end;
+
+	switch (kind) {
+	case BPF_DIAG_MEM_NEGATIVE_MIN:
+		scnprintf(proof, sizeof(proof),
+			  "The smallest possible offset is %lld, below 0",
+			  reg_smin(reg) + off);
+		break;
+	case BPF_DIAG_MEM_MIN_OUT_OF_RANGE:
+		scnprintf(proof, sizeof(proof),
+			  "The smallest possible access starts at %lld, outside an object of size %u",
+			  reg_smin(reg) + off, mem_size);
+		break;
+	case BPF_DIAG_MEM_UNBOUNDED:
+		scnprintf(proof, sizeof(proof),
+			  "The access needs offset + size <= %u, but %s has no safe upper bound",
+			  mem_size, reg_name);
+		break;
+	case BPF_DIAG_MEM_MAX_OUT_OF_RANGE:
+	default:
+		if (off < 0 && reg_umax(reg) < (u64)-off)
+			max_start = 0;
+		else
+			max_start = reg_umax(reg) + off;
+		max_end = max_start + size;
+		scnprintf(proof, sizeof(proof),
+			  "The largest possible access ends at %llu, beyond an object of size %u",
+			  max_end, mem_size);
+		break;
+	}
+
+	bpf_diag_format_access_offset(offset_desc, sizeof(offset_desc), off, reg);
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_MEMORY_SAFETY,
+			       "access outside bounds");
+	bpf_diag_report_reason(env,
+			       "The verifier cannot prove that this access stays within the object: %s. %s is %s; offset is %s; access size %d; object size %u.",
+			       proof, reg_name, type_name, offset_desc, size,
+			       mem_size);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!',
+			       "access may be outside object bounds");
+
+	bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env,
+				   "Add or adjust a bounds check that proves offset + access size stays within the object.");
+}
+
 void bpf_diag_clear_history(struct bpf_verifier_state *state)
 {
 	kfree(state->diag_history);
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index b0d42cbdfd23..4f7617fdb700 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -120,6 +120,13 @@ enum bpf_diag_invalid_deref_kind {
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
@@ -159,6 +166,15 @@ void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env,
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
 
 void bpf_diag_clear_history(struct bpf_verifier_state *state);
 void bpf_diag_copy_history(struct bpf_verifier_state *dst,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index adf660ab9e7d..e9c121892b7e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3481,7 +3481,17 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	    bpf_is_spilled_reg(&state->stack[spi]) &&
 	    !bpf_is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
+		char reason[256];
+
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
+		scnprintf(reason, sizeof(reason),
+			  "This store writes %d bytes at stack offset %d into a stack slot that currently holds a spilled pointer. Partial writes to spilled "
+			  "pointers are rejected because they can corrupt pointer metadata and leak kernel pointers.",
+			  size, off);
+		bpf_diag_report_memory(env, insn_idx,
+				       "stack spill corruption",
+				       reason,
+				       "Write the full 8-byte spilled pointer slot, or use a separate stack slot for scalar data before overwriting only part of it.");
 		return -EACCES;
 	}
 
@@ -3746,6 +3756,35 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
 	}
 }
 
+static void bpf_diag_report_stack_read_failure(struct bpf_verifier_env *env,
+					       int off, int i, int size,
+					       bool poisoned)
+{
+	char reason[256];
+
+	if (poisoned) {
+		scnprintf(reason, sizeof(reason),
+			  "This read uses %d bytes at stack offset %d, but byte %d in that range is poisoned because it was eliminated as dead code on this "
+			  "path.",
+			  size, off, i);
+		bpf_diag_report_memory(env, env->insn_idx,
+				       "poisoned stack read",
+				       reason,
+				       "Avoid reading stack bytes written only by code that the verifier proved unreachable, or initialize the stack range again on "
+				       "this path.");
+		return;
+	}
+
+	scnprintf(reason, sizeof(reason),
+		  "This read uses %d bytes at stack offset %d, but byte %d in that range is uninitialized on this path.",
+		  size, off, i);
+	bpf_diag_report_memory(env, env->insn_idx,
+			       "uninitialized stack read",
+			       reason,
+			       "Initialize every byte in the stack range before reading it, or adjust the offset and size so the read covers only initialized "
+			       "bytes.");
+}
+
 /* Read the stack at 'off' and put the results into the register indicated by
  * 'dst_regno'. It handles reg filling if the addressed stack slot is a
  * spilled reg.
@@ -3831,9 +3870,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					if (type == STACK_POISON) {
 						verbose(env, "reading from stack off %d+%d size %d, slot poisoned by dead code elimination\n",
 							off, i, size);
+						bpf_diag_report_stack_read_failure(env, off, i,
+										   size, true);
 					} else {
 						verbose(env, "invalid read from stack off %d+%d size %d\n",
 							off, i, size);
+						bpf_diag_report_stack_read_failure(env, off, i,
+										   size, false);
 					}
 					return -EACCES;
 				}
@@ -3886,9 +3929,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			if (type == STACK_POISON) {
 				verbose(env, "reading from stack off %d+%d size %d, slot poisoned by dead code elimination\n",
 					off, i, size);
+				bpf_diag_report_stack_read_failure(env, off, i,
+								   size, true);
 			} else {
 				verbose(env, "invalid read from stack off %d+%d size %d\n",
 					off, i, size);
+				bpf_diag_report_stack_read_failure(env, off, i,
+								   size, false);
 			}
 			return -EACCES;
 		}
@@ -3976,10 +4023,20 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	 */
 	if (dst_regno < 0 && var_off) {
 		char tn_buf[48];
+		char reason[256];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env, "variable offset stack pointer cannot be passed into helper function; var_off=%s off=%d size=%d\n",
 			tn_buf, off, size);
+		scnprintf(reason, sizeof(reason),
+			  "The helper would access the stack through a variable offset %s plus fixed offset %d and size %d. Helper stack arguments need a "
+			  "precise stack range so the verifier can prove every byte is initialized and inside the stack.",
+			  tn_buf, off, size);
+		bpf_diag_report_memory(env, env->insn_idx,
+				       "variable stack access",
+				       reason,
+				       "Use a fixed stack offset for helper memory arguments, or add bounds checks and copy the needed bytes into a fixed stack slot "
+				       "first.");
 		return -EACCES;
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
@@ -4249,6 +4306,11 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	      reg_smin(reg) + off < 0)) {
 		verbose(env, "%s min value is negative, either use unsigned index or do a if (index >=0) check.\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_mem_bounds(env, env->insn_idx, reg_from_argno(argno),
+					   reg_arg_name(env, argno),
+					   reg_type_str(env, reg->type),
+					   BPF_DIAG_MEM_NEGATIVE_MIN,
+					   off, size, mem_size, reg);
 		return -EACCES;
 	}
 	err = __check_mem_access(env, reg, argno, reg_smin(reg) + off, size,
@@ -4256,6 +4318,11 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	if (err) {
 		verbose(env, "%s min value is outside of the allowed memory range\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_mem_bounds(env, env->insn_idx, reg_from_argno(argno),
+					   reg_arg_name(env, argno),
+					   reg_type_str(env, reg->type),
+					   BPF_DIAG_MEM_MIN_OUT_OF_RANGE,
+					   off, size, mem_size, reg);
 		return err;
 	}
 
@@ -4266,6 +4333,11 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	if (reg_umax(reg) >= BPF_MAX_VAR_OFF) {
 		verbose(env, "%s unbounded memory access, make sure to bounds check any such access\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_mem_bounds(env, env->insn_idx, reg_from_argno(argno),
+					   reg_arg_name(env, argno),
+					   reg_type_str(env, reg->type),
+					   BPF_DIAG_MEM_UNBOUNDED,
+					   off, size, mem_size, reg);
 		return -EACCES;
 	}
 	err = __check_mem_access(env, reg, argno, reg_umax(reg) + off, size,
@@ -4273,6 +4345,11 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
 	if (err) {
 		verbose(env, "%s max value is outside of the allowed memory range\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_mem_bounds(env, env->insn_idx, reg_from_argno(argno),
+					   reg_arg_name(env, argno),
+					   reg_type_str(env, reg->type),
+					   BPF_DIAG_MEM_MAX_OUT_OF_RANGE,
+					   off, size, mem_size, reg);
 		return err;
 	}
 
-- 
2.53.0

