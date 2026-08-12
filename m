Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AEE41CB26
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577628; cv=none; b=F2M/ilI7wVprFNdp1WNXlq8qWiw3mlfyX6NRGCFfdgFzhlpfYmgIlA4WKl2Jr4YEsk6iZZ/e+hWkT9pgZdmBX9jzMKO5cdZhGqv4vvDe930kFlacLHc1HY2b+VW6PwjxXpdKRzBK7r/Wj2tJ1FC/IebMS5fFmtKf97GDWmFclhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577628; c=relaxed/simple;
	bh=dT/ca+r/kYfAdhZQtIFFQhwWZzmltwUElCrcLJ2fHXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elVxHN/9fhTABiUJxoLH/T1gX/sOFpxe5Bk1Mf2nuRta291MZwZsprvJjZqQhhGFiS6LUAgLfGr/PLuGqAg/gkFjuwtoFg9z2OxaB+YlJgYBXSSvYAMHOGue1rn/luldqexki+DVP+3ji4jXUkMCS15U9xktGv9L41wl6Eekd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3uq0Rr/; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3uq0Rr/"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so3226965e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577624; x=1787182424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FSnuDNHPA8mjLiBXTKVv9XmcSIGr5mBU8k7A5lWTKqI=;
        b=P3uq0Rr/t1jWeRpO6HSDxKuykUn3NBpPseXWAPCOVDczWLdFAoyk/GFoUzG5BVjLpt
         kKIKO94eHzZ+EFkS3wiBc3wiKcb6QKvk4VavE1Ar1AnTWwEgH5vuXWkwMi5G6LwZVpgN
         /bCvU5Brq70rf8YZsW0uKCrgOV3bdibX2Aefk7IP0qrijUgVJxtwF1/hb0jMkng2G3xY
         ZTVlJw2iTmD0/moHWtz2ZE3I4wAYg4u3HPh1+urj8A+98NqaYsdBFPA5TfpeWFYrmgHx
         3F33bFREx5Qf3AzCwtyxtkG11z5hDhv3up5q2SQwiPW44/tP9RSTkEAYbNY7oBr6MLV3
         EpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577624; x=1787182424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FSnuDNHPA8mjLiBXTKVv9XmcSIGr5mBU8k7A5lWTKqI=;
        b=ii+kaS3q6D1/9Yg78FjwpnwTaraAaxh6zfzvuCgUYWpmLJt3V5cQBcOYR/Wf29TbRu
         082Eq6pC2+K7i5cqo/pHmm2YFadhG0zx2sDcDNbpCJbQvDK9t1LXwFd/nYCRxiHpLkN/
         YHrOo73CpV9/XkdkYb+Ywdg0sg+kFGKZkzTG6kiyNkxJOLKGklR99KI6sjrMtFDZ68Pu
         CrsfeD6dQBdNoK6uWwsRAsxjFq/4C94TT5ccYpv7O2E4LY3mFAkPZ0jtYw3g6iDiJ6yq
         tb8SFaeLR8XRWaCZFaBxePSF+uUxRxVviAWHQFI0aTdADYXtBlpTO3P+ulvT9HvG4JeO
         nehg==
X-Gm-Message-State: AOJu0YwN8dv6Kb+Dcs8DNqj4EMJ1iQGhb+AaCPtjgBcPZig/y7l/flJl
	1jP05TlNWZsHb9dWFLy+rQUBGD0Rk1LpY7USKahd285+wZ7vVHjnvAP9UESiI1Xn
X-Gm-Gg: AR+sD13RbxNCY5v6Rp8sguo7MmolX1ae8gU+XCA5Uv7kK9/UbkHLWySSRbrK5LyIVc2
	EMAI0VD7vQ3vZ4j2vS4ZndEzl+0eKs3AjVBahLGaMGolo0nAKB+/ZS+qBRJVyVvoQJcMvYaGHpb
	iT/RRoUwvmm4CEsDdW/Igq5k5v8EhLJqzfbMh06mTnVq8CqPYLEepeR1C3Vd2l93azRmndYChLH
	Y+0aDmwP3zrtkNBheMAXvjErmyqnpV6enCbNSRFFnB9vfEgvqce3rso1g7bGG5kkFUNLoCNSkYQ
	lVMUxCaEdFyecsgTlmthVYKE+oOb3aF8aKvGFTEOKAyXH3x8cPh7nQcQJwDLv1VA4gwGl8e0T5M
	XKprYCj5PaxCXoWyrrnah8uqQlZfHwnxNwuJUaeimuCvgIFthxHEa2Eu9kIhAPZUa23Dt1oMDNP
	g2REvwzSDPfvhjkdcIaBbuDHlS9PHyfGPh9S6V/7nLgIFjy6T/lnEC9GycKcGM0EdsAv/qRdGsn
	VOQEHPYzpLDAfO5l0xeL3a1uY23s0uP+xoJnvQE1x1riy19Wy2cnQZBLKZ4PPwZnt4C0ognl/2w
	ZAc8ExoBcE2ZJ8/iev7nJO5MOdo=
X-Received: by 2002:a05:600c:4584:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-499821c680amr9674205e9.10.1786577624261;
        Wed, 12 Aug 2026 16:33:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a56123asm1576579f8f.8.2026.08.12.16.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:43 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 09/16] bpf: Report Memory Safety bounds errors
Date: Thu, 13 Aug 2026 01:33:12 +0200
Message-ID: <20260812233326.3575958-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12869; i=memxor@gmail.com; h=from:subject; bh=dT/ca+r/kYfAdhZQtIFFQhwWZzmltwUElCrcLJ2fHXw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQefow3cuRk8W5f1qK5XS9LKfo3DiCNMe/zMP871mT BTezjm3o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABN5Z8zI0Fe55NX6+FW7XKJX yP6oePUsvfiH5nFhM4vYDZ4uq27sDGZkeMKx539Tf/QB/siMCRznd27R/tfZeOn77C+ub67/KfX Q4wMA
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
 kernel/bpf/diagnostics.c | 75 +++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  6 +++
 kernel/bpf/verifier.c    | 85 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 157 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 53529475b0ec..66b5ac451108 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/seq_buf.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/stdarg.h>
 #include <linux/string.h>
@@ -1105,6 +1106,18 @@ void bpf_diag_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int n
 				    "call.");
 }
 
+void bpf_diag_memory(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+			    const char *reason, const char *suggestion)
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
@@ -1623,6 +1636,68 @@ static const char *diag_scalar_range(struct bpf_verifier_env *env, struct cnum64
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
+				const char *reg_name, const char *type_name, const char *proof,
+				int off, int size, u32 mem_size, const struct bpf_reg_state *reg)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = diag_current_frameno(env),
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
index 2f243306346e..51e6a527b075 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -13,6 +13,7 @@ struct bpf_verifier_env;
 struct bpf_verifier_state;
 struct btf;
 
+const char *bpf_diag_fmt_s64_sum(struct bpf_verifier_env *env, s64 value, int addend);
 enum bpf_diag_mod_reason {
 	BPF_DIAG_MOD_WRITE,
 	BPF_DIAG_MOD_SPILL,
@@ -123,6 +124,11 @@ void bpf_diag_unreadable_reg(struct bpf_verifier_env *env, u32 insn_idx, int reg
 void bpf_diag_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int nargs,
 				      int stack_arg_slot, const char *callee_name,
 				      const char *arg_name);
+void bpf_diag_memory(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+			    const char *reason, const char *suggestion);
+void bpf_diag_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+				const char *reg_name, const char *type_name, const char *proof,
+				int off, int size, u32 mem_size, const struct bpf_reg_state *reg);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8b28862939f..080c6b893fb0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3448,7 +3448,15 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	    bpf_is_spilled_reg(&state->stack[spi]) &&
 	    !bpf_is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
+		const char *fmt = "This store writes %d bytes at stack offset %d into a stack slot that currently holds a spilled pointer. "
+				  "Partial writes to spilled pointers are rejected because they can corrupt pointer metadata and leak kernel pointers.";
+		const char *reason;
+
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
+		reason = bpf_diag_fmt(env, fmt, size, off);
+		bpf_diag_memory(
+			env, insn_idx, "stack spill corruption", reason,
+			"Write the full 8-byte spilled pointer slot, or use a separate stack slot for scalar data before overwriting only part of it.");
 		return -EACCES;
 	}
 
@@ -3740,6 +3748,20 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static void bpf_diag_stack_read_uninit(struct bpf_verifier_env *env, int off, int i,
+					      int size)
+{
+	const char *fmt = "This rejected read uses %d bytes at stack offset %d, but byte %d in that range is uninitialized on this path. "
+			  "Programs loaded with CAP_PERFMON can be allowed to read uninitialized stack bytes, but this program is being rejected without that allowance.";
+	const char *reason;
+
+	reason = bpf_diag_fmt(env, fmt, size, off, i);
+	bpf_diag_memory(
+		env, env->insn_idx, "uninitialized stack read", reason,
+		"Initialize every byte in the stack range before reading it, adjust the offset and size so the read covers only initialized bytes, "
+		"or load with CAP_PERFMON if uninitialized stack reads are intended.");
+}
+
 /* Read the stack at 'off' and put the results into the register indicated by
  * 'dst_regno'. It handles reg filling if the addressed stack slot is a
  * spilled reg.
@@ -3829,6 +3851,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					} else {
 						verbose(env, "invalid read from stack off %d+%d size %d\n",
 							off, i, size);
+						bpf_diag_stack_read_uninit(env, off, i,
+										  size);
 					}
 					return -EACCES;
 				}
@@ -3887,6 +3911,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			} else {
 				verbose(env, "invalid read from stack off %d+%d size %d\n",
 					off, i, size);
+				bpf_diag_stack_read_uninit(env, off, i, size);
 			}
 			return -EACCES;
 		}
@@ -3979,11 +4004,18 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	 * check_stack_read_fixed_off).
 	 */
 	if (dst_regno < 0 && var_off) {
+		const char *fmt = "The helper would access the stack through variable offset %s plus fixed offset %d and size %d. "
+				  "Helper stack memory arguments require a constant stack offset and a precise initialized range.";
+		const char *reason;
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env, "variable offset stack pointer cannot be passed into helper function; var_off=%s off=%d size=%d\n",
 			tn_buf, off, size);
+		reason = bpf_diag_fmt(env, fmt, tn_buf, off, size);
+		bpf_diag_memory(
+			env, env->insn_idx, "variable stack access", reason,
+			"Use a fixed stack offset for helper memory arguments, or copy the needed bytes into a fixed stack slot first.");
 		return -EACCES;
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
@@ -4222,10 +4254,13 @@ static int __check_mem_access(struct bpf_verifier_env *env, struct bpf_reg_state
 }
 
 /* check read/write into a memory region with possible variable offset */
-static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-				   int off, int size, u32 mem_size,
+static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				   argno_t argno, int off, int size, u32 mem_size,
 				   bool zero_size_allowed)
 {
+	const char *proof = "";
+	const char *start;
+	s64 max_start, max_end;
 	int err;
 
 	/* We may have adjusted the register pointing to memory region, so we
@@ -4239,19 +4274,32 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
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
@@ -4261,17 +4309,36 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
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
+				   reg_arg_name(env, argno), reg_type_str(env, reg->type), proof,
+				   off, size, mem_size, reg);
+	return err;
 }
 
 static int __check_ptr_off_reg(struct bpf_verifier_env *env,
-- 
2.53.0

