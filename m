Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88931B83B
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958343; cv=none; b=gqdEb4c1SSAvsIv3H9C+oEMbk+CnE1kAQ9r4Fldw8Llc+zx5qBBCj59ehjVCODuOpacEZc5UT4TJgwIwVusbpOgZIwlz1O55hN7UyptcZTpKf6SYCCjCuwqC+JFbo7eFP12+V/voHSFYHRZgMRwn3PLl5Ri8CZDotmpUoIl6pvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958343; c=relaxed/simple;
	bh=s0oq8Ojy543xdBWFaEUQRc1VS+2EkTGF2GOcW5JcUEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdtSZXx8MSezRMWm0mio5H67i9N35NEmYjNvc3SBZmg6y6xyT/yrlVdKHPLVYyMQ2/LclX6jugFn49GDZhL2o2NT2wcDw9vFntThOdz7nkdr7ouVLJ1Ar5gOO7WFuodiqFEBTJvgKYQ445tGGfOWB1mW6yezgZ/5ioDwmiJaVWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8j5glOK; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8j5glOK"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so6494095e9.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958339; x=1790563139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m1UdqTrOeNs0QTR5WTLSj3NfiIWFGBtY4KxUsOrX/FM=;
        b=T8j5glOKHhF4yVCP5iYweNc2+wuw7as+Q9H0p6NtrLOkMpZoTcqFrUVG3EdUBZ5Xju
         6PKbafjvSNr5fdQd0Svlytv3l9MeY12yq3AKRdSMPJW2A4eXW3Gq3uVg2MU1xqoCohO+
         ylAeoSBroSz0jGDXrH2J56SLOqPxGYaoh6OyShfwdltwGY+FHmvxIjwXtpXfzvvsC9y5
         rb67Yo/aSA/sm++gCnqTyY43xjzscn+BlXZNT2r+4U1buNlTSanycDEdgFDW5EWjLhhv
         HNRFDJnoAGqXi5P+35+23BN8GWIRppOp6yq+/jdGUTkAlzFNCGMW4tDnL02wTwpvUefT
         +ZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958339; x=1790563139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m1UdqTrOeNs0QTR5WTLSj3NfiIWFGBtY4KxUsOrX/FM=;
        b=CI4G2yniGUCyrweu1j5WNRi63Su5yJyqLPyGLzGwOpHpz19WYuH8r7rnT8/R/zNlLs
         +yeSC04KdktdZQa8Wk/v56itD/dscU3acIP7ur6zTOT8MTPa23TyLzuryKgwLvFY4p8J
         HWc2mZUoP+2hZ35WLQUUeZtpnAB7udI2NdwTdGvogUUxaGQEycT+Ltk11KJtH+uWfo/Q
         xYeil5Dy+xAPTBVnx51YWqDT+NlPSAlQ5qLTbbAoDevFvGJNK/e78hgV9mexiz8OoB9D
         38rpgO2HoXjXa79nSuWilWpHl3pkxGwuBr+9QLcI9wV7QqL8wCifHF5xj57AjuPpx4b4
         XeFg==
X-Gm-Message-State: AFuF++lSw+9ZvulD4LmOwSc9ox0LN8LTiv+7lbncJNnK0okHRdJbGRX/
	iGGUoSTMwQAzWJaSr6TjmJrmzaDGD9iajSeVFZOm0mDwmVR7HHrGN05PBSCbqvFs
X-Gm-Gg: AYBFou0qObd1IPdvbd3LQG9nxMSWWpuSF9i1dKlYd5bOEgZBmOKpFaQzqUfjY90UZ37
	9MdBcgCEEeb5Hi1oxKhBwF7xRqerPIMSHCBvUiayvf+qCSJJKNOu3OKwyiS7hZfS+NaFfhpnyVl
	zy53woFWGABSEfGiN8LMNhbDKLC79LJMJ/VlrtILKF9i1y5vtSFddbCgQ5+GU1j/pIq2rZaE2G4
	BRxLxTand6Al1m/TJRftMQ/Gcy9+BN9CmyZlLQt7IF2geQvaWQ2uiH3WNPPYDFwDZNx9Y57vSAu
	tLMnd9KAf1vzCI96p+YO0WZOQfBNGY00phvb5xMmF42MlLwoicO8vYuQh0BaOLFfv4vVhi/G20v
	96B0en9z6unhZkLa1ScB0qMgqaFK8+I1OyAvJNAuMj116f5HlxrWYa9fL6+Sp6I5beHdbplBxB7
	sdxudkwSWRBVejETqRyQWz+3MsivrsMxvnBPs+ekkQVjg4Xtlpc2MT3TdtAl5vPx5CQo/jKIPuN
	iPmeOovp7ZzyBWt+PnYnKxKcQ+2eF9mshqVuwS6RTL/LGMoL2C36btfxtbg0ffXQl1Xn6hjjEZN
	gQlVB5KhlkHTWhpPNVIBvCllQBQA5ZDDWGNNeNY=
X-Received: by 2002:a05:6000:186a:b0:486:f97b:6412 with SMTP id ffacd0b85a97d-4871e363fe0mr12943135f8f.46.1789958339280;
        Sun, 20 Sep 2026 19:38:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48854e5a2c1sm12388660f8f.34.2026.09.20.19.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:38:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 08/11] bpf: Preserve stack initialization for generic output buffers
Date: Mon, 21 Sep 2026 04:38:32 +0200
Message-ID: <20260921023843.411943-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
References: <20260921023843.411943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12765; i=memxor@gmail.com; h=from:subject; bh=s0oq8Ojy543xdBWFaEUQRc1VS+2EkTGF2GOcW5JcUEE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9C22k/M/lTbwJZ1lb8+uWqL+XWGH7p0jpclHbxfFC CXu3uHRUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkomDH8D339h/XAhMd+CRsX bblsvupJx1JvWf3s/Dc1nMYBulnmXYwMf3Ydqa7ymFPZeSf1QpdvqHpR+83szB8PAvZvrTr6d+Z eVgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Partial-output helpers such as bpf_snprintf() do not read incoming buffer
contents, but may leave some bytes untouched. Let them accept uninitialized
storage without promising full initialization to callers that cannot read
uninitialized stack memory.

Make this the default for generic MEM_UNINIT buffers, including __uninit
kfunc arguments. Allow invalid stack bytes through the output check but
leave them invalid when uninitialized stack reads are not allowed. Scrub
initialized bytes and scalar spills as possible writes, retaining the
existing restrictions on spilled pointers and special stack objects.

Retain the output annotation for variable-sized arguments and track their
raw-mode eligibility separately. Callers allowed uninitialized stack reads
can continue treating the potentially written range as initialized. For
constant ranges, defer that initialization until all inputs are checked.

Keep prior stack contents live for generic outputs when the caller cannot
read uninitialized stack memory. Such calls do not define the entire range,
so liveness must preserve initialization facts that remain relevant after
the call. Dynptr and iterator constructors still define their storage.

Annotate the snprintf, sysctl name, d_path, snprintf_btf and branch-record
destinations with MEM_UNINIT, and document that generic __uninit kfuncs may
leave bytes untouched. This also changes readback from existing full-writing
helpers: without permission to read uninitialized stack memory, programs
must initialize those bytes themselves before reading them after a call.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 21 +++++++++--------
 include/linux/bpf.h          |  5 +++-
 include/linux/bpf_verifier.h |  8 ++++---
 kernel/bpf/cgroup.c          |  2 +-
 kernel/bpf/helpers.c         |  2 +-
 kernel/bpf/verifier.c        | 44 ++++++++++++++++++++++++------------
 kernel/trace/bpf_trace.c     |  6 ++---
 7 files changed, 54 insertions(+), 34 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index f393c3c3d3b4..c27663cc6cc5 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -164,21 +164,22 @@ suffix should be used.
 2.3.3 __uninit Annotation
 -------------------------
 
-Use ``__uninit`` on a pointer parameter for an output that the kfunc
-initializes without reading its incoming contents.
+Use ``__uninit`` on a pointer parameter for an output buffer whose incoming
+contents the kfunc does not read.
 
-For generic memory buffers, the kfunc must initialize every byte in the
-declared range on every return path, including error returns and struct
-padding. The range is determined by the pointed-to type or the associated
-``__sz`` or ``__szk`` size argument.
+For generic memory buffers, the kfunc may leave bytes untouched, including
+on error returns. The writable range is determined by the pointed-to type
+or the associated ``__sz`` or ``__szk`` size argument.
 
 The annotation does not change the accepted pointer types. A stack-backed
 struct passed as a generic memory buffer must still be scalar-only.
 
-A stack buffer with a verifier-known constant offset and size may be
-uninitialized before the call and is considered initialized afterwards.
-For variable offsets or sizes, the usual stack-initialization and
-variable-offset restrictions still apply.
+Generic stack buffers may be uninitialized before the call. The call does
+not make previously uninitialized bytes readable unless the program is
+allowed to read uninitialized stack memory (normally requiring
+``CAP_PERFMON``). Other callers must initialize those bytes themselves
+before reading them. Stack bounds and variable-offset restrictions still
+apply.
 
 For dynptr parameters, ``__uninit`` indicates that the kfunc constructs a
 dynptr in the supplied storage. For example::
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5033b934ffd9..fd22db8bc6c5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -781,7 +781,10 @@ enum bpf_type_flag {
 	 */
 	PTR_UNTRUSTED		= BIT(6 + BPF_BASE_TYPE_BITS),
 
-	/* MEM can be uninitialized. */
+	/*
+	 * MEM can be uninitialized. Generic memory outputs need not be fully
+	 * initialized by the callee.
+	 */
 	MEM_UNINIT		= BIT(7 + BPF_BASE_TYPE_BITS),
 
 	/* DYNPTR points to memory local to the bpf program. */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9ddbb20ec1e9..92f528c45605 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1547,12 +1547,14 @@ struct ref_obj_desc {
 };
 
 /*
- * Memory arguments a call fills in, indexed by argument slot. The verifier allows the
- * stack to be uninitialized if the range is a known constant. Stack slots are marked as
- * STACK_MISC by check_mem_access() after all arguments have been checked.
+ * Generic MEM_UNINIT arguments, indexed by ABI slot. var_size_mask excludes
+ * variable-sized buffers from raw mode without losing the output annotation.
+ * size records constant ranges to mark initialized after checking all arguments,
+ * only when the caller is allowed to read uninitialized stack memory.
  */
 struct arg_raw_mem_desc {
 	u16 mask;
+	u16 var_size_mask;
 	int size[MAX_BPF_FUNC_ARGS];
 };
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 696b27383974..1cb5e6a6ffc1 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2491,7 +2491,7 @@ static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_UNINIT | MEM_WRITE,
 	.arg3_type	= ARG_MEM_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 82402d97ce67..501c7ce35cba 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1130,7 +1130,7 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.func		= bpf_snprintf,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
+	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL | MEM_UNINIT | MEM_WRITE,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_CONST_STR,
 	.arg4_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0c94f1214cc3..7f1cc115456f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6993,10 +6993,11 @@ static int check_stack_range_initialized(
 	 * but BTF based global subprog validation isn't accurate enough.
 	 */
 	bool allow_poison = access_size < 0 || clobber;
-	/* The call will initialize the memory; uninitialized stack allowed */
 	u32 arg_slot = arg_slot_from_argno(argno);
-	bool raw_mode = meta && arg_slot < MAX_BPF_FUNC_ARGS &&
-		       (meta->arg_raw_mem.mask & BIT(arg_slot));
+	bool uninit = clobber && meta && arg_slot < MAX_BPF_FUNC_ARGS &&
+		      (meta->arg_raw_mem.mask & BIT(arg_slot));
+	bool raw_mode = uninit && env->allow_uninit_stack &&
+			!(meta->arg_raw_mem.var_size_mask & BIT(arg_slot));
 
 	access_size = abs(access_size);
 
@@ -7035,6 +7036,7 @@ static int check_stack_range_initialized(
 		max_off = reg_smax(reg) + off;
 	}
 
+	/* Unprivileged outputs retain each byte's initialization state. */
 	if (raw_mode) {
 		meta->arg_raw_mem.size[arg_slot] = access_size;
 		return 0;
@@ -7054,8 +7056,8 @@ static int check_stack_range_initialized(
 		if (*stype == STACK_MISC)
 			goto mark;
 		if ((*stype == STACK_ZERO) ||
-		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
-			if (clobber) {
+		    (*stype == STACK_INVALID && (uninit || env->allow_uninit_stack))) {
+			if (clobber && (*stype != STACK_INVALID || env->allow_uninit_stack)) {
 				/* helper can write anything into the stack */
 				*stype = STACK_MISC;
 			}
@@ -7074,8 +7076,11 @@ static int check_stack_range_initialized(
 		}
 
 		if (*stype == STACK_POISON) {
-			if (allow_poison)
+			if (allow_poison) {
+				if (uninit && env->allow_uninit_stack)
+					*stype = STACK_MISC;
 				goto mark;
+			}
 			verbose(env, "reading from stack %s off %d+%d size %d, slot poisoned by dead code elimination\n",
 				reg_arg_name(env, argno), min_off, i - min_off, access_size);
 		} else if (tnum_is_const(reg->var_off)) {
@@ -7224,12 +7229,12 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	meta->msize_max_value = reg_umax(size_reg);
 
 	/*
-	 * A variable size does not guarantee that the call initializes the whole
-	 * checked range. Disable raw mode for this output and apply the ordinary
-	 * stack initialization checks, including their privilege exceptions.
+	 * Check variable ranges byte by byte instead of using raw mode. Keep the
+	 * MEM_UNINIT annotation so invalid bytes are accepted without marking them
+	 * initialized when the caller cannot read uninitialized stack memory.
 	 */
 	if (!tnum_is_const(size_reg->var_off))
-		meta->arg_raw_mem.mask &= ~BIT(arg_slot_from_argno(mem_argno));
+		meta->arg_raw_mem.var_size_mask |= BIT(arg_slot_from_argno(mem_argno));
 
 	if (reg_smin(size_reg) < 0) {
 		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
@@ -13730,12 +13735,20 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
 	const struct bpf_func_proto *fn;
 	enum bpf_arg_type at;
+	bool full_write;
 	s64 size;
 
 	if (bpf_get_helper_proto(env, insn->imm, &fn) < 0)
 		return S64_MIN;
 
 	at = fn->arg_type[arg];
+	/*
+	 * Generic outputs may leave bytes untouched. Keep prior initialization
+	 * live when the caller cannot read uninitialized bytes. Constructors of
+	 * special objects, such as dynptrs, still define their storage.
+	 */
+	full_write = (at & MEM_UNINIT) &&
+		     (!arg_type_is_raw_mem(at) || env->allow_uninit_stack);
 
 	switch (base_type(at)) {
 	case ARG_PTR_TO_MAP_KEY:
@@ -13804,7 +13817,7 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 			 * Size arg is const on each path but differs across merged
 			 * paths. MAX_BPF_STACK is a safe upper bound for reads.
 			 */
-			if (at & MEM_UNINIT)
+			if (full_write)
 				return 0;
 			return MAX_BPF_STACK;
 		}
@@ -13824,10 +13837,10 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 	}
 out:
 	/*
-	 * MEM_UNINIT args are write-only: the helper initializes the
-	 * buffer without reading it.
+	 * Other accesses keep the previous state live, including untouched bytes
+	 * of an unprivileged generic output.
 	 */
-	if (at & MEM_UNINIT)
+	if (full_write)
 		return -size;
 	return size;
 }
@@ -13907,7 +13920,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
 	if (arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
 		return -size;
-	if (is_kfunc_arg_uninit(btf, &args[i]))
+	if (is_kfunc_arg_uninit(btf, &args[i]) &&
+	    (is_kfunc_arg_dynptr(btf, &args[i]) || env->allow_uninit_stack))
 		return -size;
 	return size;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 29260951aa87..195f78db9bda 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -995,7 +995,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_UNINIT | MEM_WRITE,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.allowed	= bpf_d_path_allowed,
 };
@@ -1052,7 +1052,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.func		= bpf_snprintf_btf,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM | MEM_WRITE,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_UNINIT | MEM_WRITE,
 	.arg2_type	= ARG_MEM_SIZE,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_MEM_SIZE,
@@ -1565,7 +1565,7 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
 	.gpl_only       = true,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
+	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL | MEM_UNINIT | MEM_WRITE,
 	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 };
-- 
2.53.0

