Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2A3B8D6D
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709363; cv=none; b=fZcn6mkT+eL98XNP0GpmKnAQJax0Bs2J0m7NFB/8AiyE5eOgsJY6JtkUtzKFRh8E2/SVQ94JrCGjn5SszQdVZo1swdRtQ+bbKDvig7oBYZOMIAx+0HM6RIzFQtQ8qKGWDqPX1yxZiWwAJ8UkI/JhY+VcKcwCnrFczmmtkXUVsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709363; c=relaxed/simple;
	bh=zuWvnwkvIWIiiXFFm1JCqxtg449sbgMPWh303KUYqsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWFYuj15dNh6hMowqCtZVWdJaq++dSrRe/FFjR4o/mNy0v8IORHwzqCXjGQ/GBxfQDHxUiNk70CaCW4OYM5w6epzkaUUwHvykZSbNUuZvoLWGoe6ZxiToliX9au5FykifSjroh/RCEaOyPittqz0E0xHkDRB5hRgVsfXytCUCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqsobZ3K; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqsobZ3K"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-482dd2e92ebso100243f8f.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709359; x=1790314159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7uOuFLOiQTR8S4rADP/keQ8X4b89ehu6M25s/5KgogQ=;
        b=fqsobZ3KmHSvcXpFHZke/euoEncw8P8AGk/YJrAFg43JdN5wKoXLPuwcwaAdSlXKAQ
         kk/kYQyutWP9AD0YeTHh1Rs0PHnfqnZ/ukp4RqiIJ/E17C4YFMTF7YVz2pR16bztiGHQ
         W9mo5KD2ciL2H7bsme8KdBQ6LfnwQQPJkHJSQZyTQVng/8ydRLfaDPo8I7fjwbWlMdGV
         V9vurrq+XhtBqtx5dT0S6FfOlO58MZrrgWhTDT2Q+E/ClwH7YQTKtPfWsYOceRsxIiLf
         4WMHENscBVnJ3DIxcvLjPd90ebxyxngCwngtLvDPBLgCwyUvbxl8gDhDSdOqI1e0C+jp
         UVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709359; x=1790314159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7uOuFLOiQTR8S4rADP/keQ8X4b89ehu6M25s/5KgogQ=;
        b=TUBKxOLbhz+wOBFeNtGRwovnqDZ1eOwwK2GJzZDENGFfOUuUValJdN1pakycb8ZrOB
         TdDgigJnU2GNzFxtVslYzKQ7+2PddDj9j2wQ4at1deXuj0UHUpP/3iKAlVBfA11RpaxL
         qO2e3ZmSfUfQqs+dU3HdTnxS77GksSLR545H193mmAtAMbYTb1SDpgzkckwc1wJqi0S4
         dzEOBhd1p8oqdRQaAvVN5SVnXenO1DNu/c5q9evccTtG8cuWKFosSu+0ePo6185xNC/A
         xcDgWLMB8TVd4n0QMqTzDBx2Vt1RnvQcknpGY7Rfd89iGf0tUZiSROqYiXac1ex2dsey
         5lSw==
X-Gm-Message-State: AFuF++m1QfKBA+k3D1wrV+Fk2dGeOpInpCQY0UgV4iktdq+20GbY9Tzf
	aWeFc14/JXFOcOG2s6Gyw6YDf7wTEbQ2pD+2MvPi/p8eNR0T/PHy2AxnBaUJIKeo
X-Gm-Gg: AYBFou32MH2oktdxJ8kIVvO6Y9UxOss2mTVLXqMRlvk1QtMQ5w3U3oM8iVF4IHIHM70
	4gSHpXPHPXp4oSmLltGdlVCdyicIkvNrzjKSc8sYIz/5Mba4/EyOr3Ar+A8xLmBxUGSVOchwj7S
	b5NwP7iVjYnI8v9zfOlR1fmXjCWRII6JSo/8XRvN+g8HYU5aP3PSiMdSNssXrr/D/q7/D/0uWEJ
	5vx75yJf9zaGTZGqm4XzfZ1DMVdUlunca7VgPY+NZE+E9X6k6F17Qi3MLVy565X1DdH+rWPK1z3
	z1jbgszW0Q5Evw8+0N1KSWc22644m/+sqjS6nifiBwSMHLw+Zs11PKCWs2ol95cJoPKSMEMOvbw
	6NeEvwu71MicMT31BOujd1Uc0A97Fo3C8GaBn8WGtjempN2EZ1N9ilLCwTHipSKwfDJRJ8smQoV
	NkDRjoPrDRyQBVCuTYxK6JuDPNcbQaD1duz9Ty5vrEsCxadF7XywBoounwFm4pUeyro1gSLvpJw
	GV74rhm+kntqYkB8H4VTJ0Nu3wIcj/GTj4yBAnB87VDEKRm502BIp5dIzJhCX9J4D7HlxbX9mxH
	vZiJJYKf99AGZR23wqGIFUB/QGy7wclaIrmpfg==
X-Received: by 2002:a05:6000:2211:b0:485:8a46:b3ce with SMTP id ffacd0b85a97d-4871e386655mr1437981f8f.54.1789709359294;
        Thu, 17 Sep 2026 22:29:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff3a928sm1473038f8f.13.2026.09.17.22.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:29:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 7/8] bpf: Support multiple __uninit kfunc output arguments
Date: Fri, 18 Sep 2026 07:29:01 +0200
Message-ID: <20260918052906.12226-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918052906.12226-1-memxor@gmail.com>
References: <20260918052906.12226-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7762; i=memxor@gmail.com; h=from:subject; bh=zuWvnwkvIWIiiXFFm1JCqxtg449sbgMPWh303KUYqsk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvN6de1yjnzTotHPyq4k8n06I60IH/LBZELa79MFnty/ 2GR7bPdHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZiISA4jwye5KifOjSGXtm73 77yY7Zyd1VRdxXBrqsuZGdwruRrK0hgZ7hqqMrCkXOPs2bustoT7/qT/rFfn2PFcOSr8j2vnw04 zDgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A single output descriptor cannot retain the initialization ranges of two
__uninit memory arguments. Track raw-mode eligibility and the definite
output size separately for each ABI slot, so a variable-size output leaves
independent constant-size outputs intact.

Use the shared argument-checking path to record outputs for both helpers
and kfuncs. With per-slot tracking, neither needs the single-output
prototype restriction. Initialize every recorded output after checking all
arguments, skipping empty slots before looking up their register state.

Use the resolved BTF parameter when looking up __uninit for stack liveness.
A preceding by-value parameter can consume multiple ABI slots, so its slot
number cannot index the BTF parameter array.

Suggested-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 10 ++---
 kernel/bpf/verifier.c        | 79 +++++++++++-------------------------
 2 files changed, 28 insertions(+), 61 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6ff1c227d298..9ddbb20ec1e9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1547,13 +1547,13 @@ struct ref_obj_desc {
 };
 
 /*
- * A memory argument a call fills in. The verifier allows the stack to be uninitialized if
- * the range is a known constant. Stack slots are marked as STACK_MISC by check_mem_access()
- * after all arguments have been checked.
+ * Memory arguments a call fills in, indexed by argument slot. The verifier allows the
+ * stack to be uninitialized if the range is a known constant. Stack slots are marked as
+ * STACK_MISC by check_mem_access() after all arguments have been checked.
  */
 struct arg_raw_mem_desc {
-	u8 argno; /* One-based ABI argument slot; zero means no output. */
-	int size;
+	u16 mask;
+	int size[MAX_BPF_FUNC_ARGS];
 };
 
 /* Size of PTR_TO_MEM returned, taken from a constant allocation-size argument */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d327b5356d53..4ba7929f6d7e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6987,7 +6987,9 @@ static int check_stack_range_initialized(
 	 */
 	bool allow_poison = access_size < 0 || clobber;
 	/* The call will initialize the memory; uninitialized stack allowed */
-	bool raw_mode = meta && meta->arg_raw_mem.argno == arg_slot_from_argno(argno) + 1;
+	u32 arg_slot = arg_slot_from_argno(argno);
+	bool raw_mode = meta && arg_slot < MAX_BPF_FUNC_ARGS &&
+		       (meta->arg_raw_mem.mask & BIT(arg_slot));
 
 	access_size = abs(access_size);
 
@@ -7029,7 +7031,7 @@ static int check_stack_range_initialized(
 	}
 
 	if (raw_mode) {
-		meta->arg_raw_mem.size = access_size;
+		meta->arg_raw_mem.size[arg_slot] = access_size;
 		return 0;
 	}
 
@@ -7221,9 +7223,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * raw mode so that the program is required to initialize all
 	 * the memory that the helper could just partially fill up.
 	 */
-	if (!tnum_is_const(size_reg->var_off) &&
-	    meta->arg_raw_mem.argno == arg_slot_from_argno(mem_argno) + 1)
-		meta->arg_raw_mem.argno = 0;
+	if (!tnum_is_const(size_reg->var_off))
+		meta->arg_raw_mem.mask &= ~BIT(arg_slot_from_argno(mem_argno));
 
 	if (reg_smin(size_reg) < 0) {
 		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
@@ -8158,21 +8159,6 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
 	return type == ARG_MEM_SIZE || type == ARG_MEM_SIZE_OR_ZERO;
 }
 
-static bool arg_type_is_raw_mem(enum bpf_arg_type type)
-{
-	/*
-	 * A map value output buffer (e.g. bpf_map_pop_elem) is also a raw
-	 * (uninitialized) memory argument, and like ARG_PTR_TO_MEM it may be
-	 * passed as a PTR_TO_STACK that reaches check_stack_range_initialized().
-	 * A kfunc's struct pointer remains ARG_PTR_TO_BTF_ID until call argument
-	 * checking resolves it to generic memory, so include it in proto validation.
-	 */
-	return (base_type(type) == ARG_PTR_TO_MEM ||
-		base_type(type) == ARG_PTR_TO_MAP_VALUE ||
-		base_type(type) == ARG_PTR_TO_BTF_ID) &&
-	       type & MEM_UNINIT;
-}
-
 static bool arg_type_is_release(enum bpf_arg_type type)
 {
 	return type & OBJ_RELEASE;
@@ -8951,7 +8937,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if ((arg_type & MEM_UNINIT) &&
 	    (base_type(arg_type) == ARG_PTR_TO_MEM ||
 	     base_type(arg_type) == ARG_PTR_TO_MAP_VALUE))
-		meta->arg_raw_mem.argno = slot + 1;
+		meta->arg_raw_mem.mask |= BIT(slot);
 
 	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
 		err = mark_arg_precision(env, argno);
@@ -9566,24 +9552,28 @@ static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_arg_meta
 			  int insn_idx)
 {
 	struct bpf_func_state *caller = cur_func(env);
-	struct bpf_reg_state *reg;
-	u32 slot = meta->arg_raw_mem.argno - 1;
+	u32 slot;
 	int i, err;
 
-	if (!meta->arg_raw_mem.size)
-		return 0;
-	reg = get_func_arg_reg(caller, cur_regs(env), slot);
-
 	/*
 	 * Validate every argument before initializing outputs: an input argument
 	 * may alias an output buffer. Use the normal stack-write checks to discard
 	 * stale spills and preserve the rules for special stack objects.
 	 */
-	for (i = 0; i < meta->arg_raw_mem.size; i++) {
-		err = check_mem_access(env, insn_idx, reg, argno_from_arg(slot + 1), i, BPF_B,
-				       BPF_WRITE, -1, false, false);
-		if (err)
-			return err;
+	for (slot = 0; slot < MAX_BPF_FUNC_ARGS; slot++) {
+		struct bpf_reg_state *reg;
+		argno_t argno = argno_from_arg(slot + 1);
+
+		if (!meta->arg_raw_mem.size[slot])
+			continue;
+		reg = get_func_arg_reg(caller, cur_regs(env), slot);
+
+		for (i = 0; i < meta->arg_raw_mem.size[slot]; i++) {
+			err = check_mem_access(env, insn_idx, reg, argno, i, BPF_B,
+					       BPF_WRITE, -1, false, false);
+			if (err)
+				return err;
+		}
 	}
 
 	return 0;
@@ -9881,24 +9871,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	return -EINVAL;
 }
 
-static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
-{
-	bool seen = false;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (fn->arg_type[i] == ARG_UNUSED)
-			break;
-		if (!arg_type_is_raw_mem(fn->arg_type[i]))
-			continue;
-		if (seen)
-			return false;
-		seen = true;
-	}
-
-	return true;
-}
-
 static bool check_args_pair_invalid(const struct bpf_func_proto *fn, int arg)
 {
 	bool is_fixed = fn->arg_type[arg] & MEM_FIXED_SIZE;
@@ -10025,7 +9997,6 @@ static int check_func_proto(struct bpf_verifier_env *env, const struct bpf_func_
 			    struct bpf_call_arg_meta *meta)
 {
 	return check_arg_prog_aux(env, fn) &&
-	       check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
 	       check_mem_arg_rw_flag_ok(fn) &&
 	       check_proto_release_reg(fn, meta) &&
@@ -13097,10 +13068,6 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 		return -ENOTSUPP;
 	}
 
-	if (!check_raw_mode_ok(proto)) {
-		verbose(env, "multiple __uninit buffers are not supported\n");
-		return -EINVAL;
-	}
 	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
 }
 
@@ -13897,7 +13864,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
 	if (arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
 		return -size;
-	if (is_kfunc_arg_uninit(btf, &args[arg]))
+	if (is_kfunc_arg_uninit(btf, &args[i]))
 		return -size;
 	return size;
 }
-- 
2.53.0

