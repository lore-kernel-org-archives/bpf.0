Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF1363C63
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481412; cv=none; b=TGfBXeZjXsMmSZT4oCjk9G/oFdJTYra38JBMB7CwWu/BcwkONnJ0hhXJvel/RLy/yoNkpwttK2JGhDzzj7AkcWAglLUn4j7a0xqBez+xHiBV2cHeuTnqNAlmhleq70+gW3/JevvD1zooPG0Dps/OLC6ndv4DlNuZ//qxTFyPmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481412; c=relaxed/simple;
	bh=uSi807c1+kk1PBjiGcI8ccu2tMhRlvYu/2LiZCT7xis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nyfwus2JRGqNvoj0oYakCwLrIQIKRbOMiKbtFsEagq69pXdf2bkMwXoPRq4mKTWjSK7+dPgHvbFbWCVcIW86k75MQAE4hmU4d7wwg1DrWfNhc3RFeYC76wiQTUky1DzkA3WjhqNQkdRA+CpeWKjiAKweL9fO13tgI15kiTr2gX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWnH208x; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWnH208x"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so1279509f8f.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481408; x=1790086208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9a0OWiiNRpVBaRhvjiZ1DIFsyNFpbQF+RTZeJaa7ps=;
        b=FWnH208xhgtsngseyJxWMho+sVRhvViYITnQhl85Mx255YsTYbsm/g17nSjaCsw1BV
         O2QSgW8j7C1LaOkekrZdfkUH1xX+VebM5fG8cqjYYqa2HOW33r4edmdpOPsLltXIPpRe
         zKV1qPoexVmt8ICHmJR4t1/rjGBrntJzU8b5GZ8wEtbnBkBkktQd0kzHB4+3+L7iInmq
         F2PoQ7j8lcuup/2vyUotgjwSeZNmGJVW0JpZg4jPcsd/GT2t0teLcIRRVzQVl+LO7bL7
         MuEC7kdmp3OHh/AKclocJuHrhSol6iQEhLFyR0Nqi5rsNoL+NFj+2PRik53kAa6h51Dr
         WgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481408; x=1790086208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r9a0OWiiNRpVBaRhvjiZ1DIFsyNFpbQF+RTZeJaa7ps=;
        b=J4WMDiwksmUxchciVbTi2WyqrxkdXO+B8UlOSVuUR1HLYZkFHF0YFgOYx/rVL8ItXN
         4njVTyCNYpdgAAfqyjk+624JmtAaycDNQuCDk9clihwOLQ38u0SrnOryKRuyk73L4fYW
         vu0FVbVb21MSd/ptjyCxRgMC2UfABiDTjs1mxo4cNnpcYNq5s9846tI1Df1+mleFFltg
         Jz0m5Z+vXXzwvD6GLfU/+wr4rTZ+O2gMRZeneTh0ucm/3wX+bfjGvwYJTH3McPa5I4C2
         HeZNA69JP/ayYmQyFO/ASk5ISmAucPTHRd5KPl1N+vSYTDoF5v5ZQAum/rsJgzoyw07g
         RIkw==
X-Gm-Message-State: AFuF++nEqvgqq4w71COMXf/OXAOkrf11OhqaAH1EUtMPDvg0SeGsGMif
	6MI3CHLhcRUC8BO0MvM3L53c4bQEqH9CWt3djpPrHWWEjLFM+o297IggFcDBXvUGg4w=
X-Gm-Gg: AYBFou2XosLIEhp7KMUC2yZKvZqrFLCrBeDfHga1kNTPKuvK5J9f1it5M5rG+pJ3VOW
	1uZv/Yfjcd/Ap2WeQmBGU0vZgKHtPUskkLhsyjcYmsVb5ytAc0PhtyuLT15EfQYvwocDq1MTRs+
	hzkvOzlFwj1HCttIDbM3FmF6KLHBjwO56jTmK9dPiCIxSddA8pJv/mtBj1FaspIU3s2eovdTByo
	VTMkzzdfwQtKIUdcmPznRORk8X8mfPqSH2JK/9bEYaBUdtVJ9xUnX9Ev01KaDAplV5wXOvCvJ3p
	3Wx+ttO3gJ85ZuTi/9ubBQylA5cPPx00rxOW1gygUaoCRQZpqGG6pKuUdC5zS/LNoXAFCmz9OdG
	Q9Q+6h3R6USOCoOJHzpLRlDMcNrvSjkETePM3iJ+F7mjZtAONj6gbkd8K1gF9w4h17RDvfcqSAQ
	ME3z9aGV4/S3Y5dqdHytBGlnEZmwd0f4GnHMean8bPRKN2f9xc5KspNIRf+Sl9MnivvNwk+Pr4f
	D6xGItqIgP1N2Yv4V1FwvhREmgmdXM7+TBNg1A432A8bZXUkx0wYMQbyC+kd2EPHQSQh2gqOrBr
	OmSKgb/jppYWvCoQ/2l5d1dFNxlBSwMHF+lFZQ==
X-Received: by 2002:a05:6000:471c:b0:487:489:7b02 with SMTP id ffacd0b85a97d-4870a979086mr1278698f8f.24.1789481407977;
        Tue, 15 Sep 2026 07:10:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb36e4a6sm36428485f8f.37.2026.09.15.07.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:10:07 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] bpf: Fix generic __uninit kfunc output buffers
Date: Tue, 15 Sep 2026 16:10:01 +0200
Message-ID: <20260915141004.1196460-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915141004.1196460-1-memxor@gmail.com>
References: <20260915141004.1196460-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11234; i=memxor@gmail.com; h=from:subject; bh=uSi807c1+kk1PBjiGcI8ccu2tMhRlvYu/2LiZCT7xis=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtlYOfaiiul/DFJ7y6ttOTb7cf8v+6T8bl/Bs7lLW++z +B/mHC5o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNxuMnwm8WLSXvSZOfnX8+V qjxNtl/rdSDLLmlDnYCOx0H5xWrKaxkZHu+2fXbbWVXO3KSsUkm9g01s/SLNb8tK/nzewZx9eNt qFgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Stack liveness treats __uninit kfunc arguments as writes, but generic memory
argument validation still checks them as both reads and writes. A checkpoint
can consequently poison an output buffer before the call and cause its read
check to reject the program. Allowing that read would not suffice: ordinary
clobber checks leave poisoned bytes poisoned after the call.

Check generic __uninit memory arguments as write-only and reuse helper raw
memory handling to record their definite initialization. Track output sizes
per argument slot so that a call can initialize multiple buffers, including
arguments passed on the stack. Apply the writes after validating all
arguments, preserving input checks when an input aliases an output. Keep
variable offsets and sizes conservative, disabling raw mode only for the
affected argument.

Preserve MEM_UNINIT when a scalar-only struct pointer is resolved to a
fixed-size memory argument. In stack liveness, inspect the resolved BTF
parameter rather than its ABI slot when looking up the annotation, since a
preceding by-value parameter can occupy multiple slots.

Document that generic output buffers must be fully initialized on every
return path, including error returns and padding.

Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/bpf/86d966ec88bbf27d21b2bb4e18c8aa00@kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 27 ++++++++++----
 include/linux/bpf_verifier.h | 11 +++---
 kernel/bpf/verifier.c        | 70 +++++++++++++++++++++++++-----------
 3 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 6c2c048dccef..71fb0ca72d69 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -164,19 +164,32 @@ suffix should be used.
 2.3.3 __uninit Annotation
 -------------------------
 
-This annotation is used to indicate that the argument will be treated as
-uninitialized.
+Use ``__uninit`` on a pointer parameter for an output that the kfunc
+initializes without reading its incoming contents.
 
-An example is given below::
+For generic memory buffers, the kfunc must initialize every byte in the
+declared range on every return path, including error returns and struct
+padding. The range is determined by the pointed-to type or the associated
+``__sz`` or ``__szk`` size argument.
+
+The annotation does not change the accepted pointer types. A stack-backed
+struct passed as a generic memory buffer must still be scalar-only.
+
+A stack buffer with a verifier-known constant offset and size may be
+uninitialized before the call and is considered initialized afterwards.
+For variable offsets or sizes, callers with neither ``CAP_PERFMON`` nor
+``CAP_SYS_ADMIN`` must initialize the potentially accessed stack range before
+the call.
+
+For dynptr parameters, ``__uninit`` indicates that the kfunc constructs a
+dynptr in the supplied storage. For example::
 
-        __bpf_kfunc int bpf_dynptr_from_skb(..., struct bpf_dynptr_kern *ptr__uninit)
+        __bpf_kfunc int bpf_dynptr_from_skb(..., struct bpf_dynptr *ptr__uninit)
         {
         ...
         }
 
-Here, the dynptr will be treated as an uninitialized dynptr. Without this
-annotation, the verifier will reject the program if the dynptr passed in is
-not initialized.
+Without this annotation, a dynptr argument must already be initialized.
 
 2.3.4 __nullable Annotation
 ---------------------------
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cf85141ea167..9ddbb20ec1e9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1547,12 +1547,13 @@ struct ref_obj_desc {
 };
 
 /*
- * A memory argument a call fills in. The verifier allows the stack to be uninitialized if
- * the range is a known constant. Stack slots are marked as STACK_MISC by check_mem_access().
+ * Memory arguments a call fills in, indexed by argument slot. The verifier allows the
+ * stack to be uninitialized if the range is a known constant. Stack slots are marked as
+ * STACK_MISC by check_mem_access() after all arguments have been checked.
  */
 struct arg_raw_mem_desc {
-	u8 regno;
-	int size;
+	u16 mask;
+	int size[MAX_BPF_FUNC_ARGS];
 };
 
 /* Size of PTR_TO_MEM returned, taken from a constant allocation-size argument */
@@ -1579,6 +1580,7 @@ struct bpf_call_arg_meta {
 	struct bpf_dynptr_desc dynptr;
 	struct ref_obj_desc ref_obj;
 	struct ret_mem_desc ret_mem;
+	struct arg_raw_mem_desc arg_raw_mem;
 
 	/* Only set by kfunc */
 	bool r0_rdonly;
@@ -1617,7 +1619,6 @@ struct bpf_call_arg_meta {
 	s64 const_map_key;
 	struct btf *ret_btf;
 	struct btf_field *kptr_field;
-	struct arg_raw_mem_desc arg_raw_mem;
 };
 
 int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cd..070ec5daeec3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6981,7 +6981,9 @@ static int check_stack_range_initialized(
 	 */
 	bool allow_poison = access_size < 0 || clobber;
 	/* The call will initialize the memory; uninitialized stack allowed */
-	bool raw_mode = meta && meta->arg_raw_mem.regno == reg_from_argno(argno);
+	u32 arg_slot = abs(argno.argno) - 1;
+	bool raw_mode = meta && arg_slot < MAX_BPF_FUNC_ARGS &&
+		       (meta->arg_raw_mem.mask & BIT(arg_slot));
 
 	access_size = abs(access_size);
 
@@ -7023,7 +7025,7 @@ static int check_stack_range_initialized(
 	}
 
 	if (raw_mode) {
-		meta->arg_raw_mem.size = access_size;
+		meta->arg_raw_mem.size[arg_slot] = access_size;
 		return 0;
 	}
 
@@ -7216,7 +7218,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * the memory that the helper could just partially fill up.
 	 */
 	if (!tnum_is_const(size_reg->var_off))
-		meta->arg_raw_mem.regno = 0;
+		meta->arg_raw_mem.mask &= ~BIT(abs(mem_argno.argno) - 1);
 
 	if (reg_smin(size_reg) < 0) {
 		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
@@ -9024,7 +9026,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		 */
 		if (is_helper_call(meta, BPF_FUNC_map_peek_elem) &&
 		    meta->map.ptr->map_type == BPF_MAP_TYPE_BLOOM_FILTER)
-			meta->arg_raw_mem.regno = 0;
+			meta->arg_raw_mem.mask &= ~BIT(slot);
 
 		err = check_helper_mem_access(env, reg, argno, meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
@@ -9176,6 +9178,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		enum bpf_access_type access_type;
 		bool known_memory;
 
+		if (meta->btf && (arg_type & MEM_UNINIT))
+			meta->arg_raw_mem.mask |= BIT(slot);
+
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
 		 */
@@ -9184,7 +9189,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 
 		access_type = arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;
 		if (meta->btf)
-			access_type = BPF_READ | BPF_WRITE;
+			access_type = arg_type & MEM_UNINIT ? BPF_WRITE : BPF_READ | BPF_WRITE;
 
 		err = check_mem_reg(env, reg, argno, arg_size, access_type, meta, &known_memory);
 		if (err < 0) {
@@ -9232,7 +9237,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 
 		access_type = fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ;
 		if (meta->btf)
-			access_type = BPF_READ | BPF_WRITE;
+			access_type = fn->arg_type[arg - 1] & MEM_UNINIT ?
+				      BPF_WRITE : BPF_READ | BPF_WRITE;
 
 		zero_size_allowed = meta->btf || base_type(arg_type) == ARG_MEM_SIZE_OR_ZERO;
 
@@ -9550,6 +9556,33 @@ static int check_func_args(struct bpf_verifier_env *env, struct bpf_call_arg_met
 	return 0;
 }
 
+static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
+			  int insn_idx)
+{
+	struct bpf_func_state *caller = cur_func(env);
+	u32 slot;
+	int i, err;
+
+	/*
+	 * Validate every argument before initializing outputs: an input argument
+	 * may alias an output buffer. Use the normal stack-write checks to discard
+	 * stale spills and preserve the rules for special stack objects.
+	 */
+	for (slot = 0; slot < MAX_BPF_FUNC_ARGS; slot++) {
+		struct bpf_reg_state *reg = get_func_arg_reg(caller, cur_regs(env), slot);
+		argno_t argno = argno_from_arg(slot + 1);
+
+		for (i = 0; i < meta->arg_raw_mem.size[slot]; i++) {
+			err = check_mem_access(env, insn_idx, reg, argno, i, BPF_B,
+					       BPF_WRITE, -1, false, false);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 {
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
@@ -9851,9 +9884,9 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 			break;
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
-		if (meta->arg_raw_mem.regno)
+		if (meta->arg_raw_mem.mask)
 			return false;
-		meta->arg_raw_mem.regno = i + 1;
+		meta->arg_raw_mem.mask = BIT(i);
 	}
 
 	return true;
@@ -11572,16 +11605,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	regs = cur_regs(env);
 
-	/* Mark slots with STACK_MISC in case of raw mode, stack offset
-	 * is inferred from register state.
-	 */
-	for (i = 0; i < meta.arg_raw_mem.size; i++) {
-		err = check_mem_access(env, insn_idx, regs + meta.arg_raw_mem.regno,
-				       argno_from_reg(meta.arg_raw_mem.regno), i, BPF_B,
-				       BPF_WRITE, -1, false, false);
-		if (err)
-			return err;
-	}
+	err = mark_raw_stack(env, &meta, insn_idx);
+	if (err)
+		return err;
 
 	if (meta.release_regno) {
 		struct bpf_reg_state *reg = &regs[meta.release_regno];
@@ -12437,7 +12463,7 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 			PTR_ERR(resolve_ret));
 		return -EINVAL;
 	}
-	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | (*arg_type & PTR_MAYBE_NULL);
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
 
 	return 0;
 }
@@ -13859,7 +13885,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
 	if (arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
 		return -size;
-	if (is_kfunc_arg_uninit(btf, &args[arg]))
+	if (is_kfunc_arg_uninit(btf, &args[i]))
 		return -size;
 	return size;
 }
@@ -14140,6 +14166,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err < 0)
 		return err;
 
+	err = mark_raw_stack(env, &meta, insn_idx);
+	if (err)
+		return err;
+
 	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
 	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_type(prog_type) ||
 	     /* is_tracing_prog_type() for now doesn't cover non-iterator tracing progs. */
-- 
2.53.0

