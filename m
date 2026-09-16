Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C021421259
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586918; cv=none; b=fFYSoSTMpq9e5ZhgBhKxTtPtqLBpvf/l+aYcx6sh/H1YF1QBrUO1daeXpKRinJJmSY0rTGX4U0U+LYKe5O47S1lk53SN0N1fN8SadWxuK/GNH+GhOjwLtpZu59BvTplwRb+tVmKJfWOU19r1/VdkoP7gcoL6ZpUJtOtt48OAoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586918; c=relaxed/simple;
	bh=p2Toow/XxN44Qvqh6oGz+fM6/piRiOhtB2ZaLY+pRto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIjT/GJacD5LEycg7KZcgMZbwYXkuNkllGyB4HLSlLJwRND4SdmVMGo8cD8MCnzRRkqOlqnwVfG/Pb27aLOqlb9dzq7cfHs6vXMTklH3Y4dl+eYngb0jFeTe4HkYIMjfLDF2o3gGy/XxzQcTL4+3eWLEKlIc9RtXoTs9IogwHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2Xy1Yx4; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2Xy1Yx4"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-484392e3450so11937f8f.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586894; x=1790191694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYCJUP+VbuCmF4xDA5riqXBkDfxQQKeR0s/tbFjzqBc=;
        b=d2Xy1Yx4Y+n2hKLx5nsshC4+qV1IEi//PiZ5AW/0pDgPYA7Bdi2T3OFMsQlZE0r6h7
         CeQtf+PDQjs2wDXf0uhZxEOyGL+wsI+f7pi1ngXKIYhsrklBdETdQOeDgsG8Y5x5iN08
         Uyz/vZNfhsZNDQ4RAg4G+FY/lpcGppUU8oe6bty56TjYLgM5z8/R//Ps20z6x616rBmy
         Ck86JYes9sgEJvdyz7v0oZHDbenmBblMaKM7D7VkpHVXeUA9XnHdA4I0S943qU3Ry3qA
         J5F6D8H2WGhwZ/I7X31HppMKG0ct+W/b4OmiFkNCmxa10FBKfL63kKr+u0TDW1ngFDG0
         GWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586894; x=1790191694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYCJUP+VbuCmF4xDA5riqXBkDfxQQKeR0s/tbFjzqBc=;
        b=DsH9GriNSakZQW6JH201K3edoVidopwamD+CxqIb9AyBNA5bVjoWTvHDfC6ltAwEi6
         iGlbLNskG8VDPvflT/o7Q+cnE3iXlQyH9kLtyuVXkqo/WF0ZucIyaP+1m6uU2zQi3tD7
         27SpcMCGFn2GWRjPSYUHHYj/bDM67vgxxDpeqTENl4hNZls2+dwv0D1YYLFB2hpl+4h7
         d45Bx70vOI4vxtWi69zG0/7bbROetHSClOT2r8Ei0JiI1DT9YGI0zZ0MYDfJ5rF0F0Gd
         FelOsxmcLpPW2ZFIiyfsuiO/N7KHV4spkkbgKOUG1jkoJzx3YFs8+DMa5TJ923MV0KBm
         5jDw==
X-Gm-Message-State: AFuF++mh/aKsWUSkcPQaxsVhbNyDR46Ooe6Bc+P2pXkvZ0IrLUA4RSyJ
	W4zTWIGiYLL0kN/fkYFk4IP4JlFiebdXEIcvDQWVo25W44Aa0DsjBzUuJO9ztawt
X-Gm-Gg: AYBFou3uc5hxfmcaY2QZe2vErbF7JOHdDe9xchzkIsYcuxf1ua6Qc6Hb1c+GN2ts144
	72K+0/aLDjECrAeb+Uv1vUj1EGbBf/yAYDtpT7opfmisZmCUn21OOJoilAenC7NR118FqajVTr0
	rFNBxrX00sOxo27BpcTfkdVOBJTXfM20T6MhrDt/tzC+K4LlG8QurPWbplyizucAQaj1I2MjIQZ
	QqFXr+TDiMZPSINIKpgN1OtPDNkz+raw82V7YdGJv+KnMbDiE2mMqcjbcbBr56Y5veTh7/tmI8Q
	eu6XKAW78jFGbX3S7D0fuqunEK9zfb2BnU4XarnyvVot8ZkZ1ouN8vdru6D4TrZHgVdYtpnSVky
	qiA9ywzRB77v0AodHeyqQfZsJtvEu2DZxXZt2ch4eSyRcgdnT3NRGQWc4AqWi8J0+KV66yUAvri
	3MQUJS0PDsPWZYd9DHXqcSeLfYUvuGFqwHn3gb/Jo93zUWN8BuVYLX9Hydv7NodE3krjzwTFq78
	sGFdDGRQpgEFORMx1XhzvSeu2owPczt03197jRmju9hqTtGaJX3RVw8dqPuBg2GoYAuoUo+h8eR
	Em3CFhJRMxNeC/2LK1kwUMK4/I0O+a1uFPyQ0A==
X-Received: by 2002:a05:600d:844e:10b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49fbd14f472mr8848665e9.0.1789586893857;
        Wed, 16 Sep 2026 12:28:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbbcf5277sm37118015e9.3.2026.09.16.12.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:28:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 4/5] bpf: Support multiple __uninit kfunc output arguments
Date: Wed, 16 Sep 2026 21:28:01 +0200
Message-ID: <20260916192805.3991983-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916192805.3991983-1-memxor@gmail.com>
References: <20260916192805.3991983-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8329; i=memxor@gmail.com; h=from:subject; bh=p2Toow/XxN44Qvqh6oGz+fM6/piRiOhtB2ZaLY+pRto=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvV2/oOqYMxr+bWfs/dJVI21UXh/B8di661xb/d3wn+E J24Lzyuo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNR3MfIcOJ97sEVG/n3Pswq iPQ8fDHhZP6u08F/Uzap6n//Wcb04QbDfwfpd/mVx04Ltlu/O2Cfay67zEvJL+1K0tIJV1+YlTQ 78QEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A single output descriptor cannot retain the initialization ranges of two
__uninit memory arguments. Track raw-mode eligibility and the definite
output size separately for each argument slot, so a variable-size output
also leaves independent constant-size outputs intact.

Normalize helper register numbers and kfunc argument numbers through one
slot conversion helper. After checking every argument, initialize each
recorded output. Skip empty entries before looking up register state: an
unused slot need not have an allocated stack-argument record. Helpers keep
their existing single-output restriction in check_raw_mode_ok(). Remove the
kfunc output-count check, which no longer constrains the prototype, and
simplify the validator back to its helper-only role.

Use the resolved BTF parameter when looking up __uninit for stack liveness.
A preceding by-value parameter can consume multiple ABI slots, so its slot
number cannot index the BTF parameter array. Keep this argument-slot handling
with the extension rather than the minimal single-output regression fix.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 10 +++---
 kernel/bpf/verifier.c        | 65 ++++++++++++++++++------------------
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3c1b06a3daf3..9ddbb20ec1e9 100644
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
-	u8 regno; /* Register number, or one-based kfunc argument slot. */
-	int size;
+	u16 mask;
+	int size[MAX_BPF_FUNC_ARGS];
 };
 
 /* Size of PTR_TO_MEM returned, taken from a constant allocation-size argument */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d7a40dc159ae..644ada706c62 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -302,6 +302,12 @@ static int arg_idx_from_argno(argno_t a)
 	return arg_from_argno(a) - 1;
 }
 
+/* Normalize helper register numbers and kfunc argument numbers to ABI slots. */
+static u32 arg_slot_from_argno(argno_t a)
+{
+	return abs(a.argno) - 1;
+}
+
 static const char *btf_type_name(const struct btf *btf, u32 id)
 {
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
@@ -6981,7 +6987,9 @@ static int check_stack_range_initialized(
 	 */
 	bool allow_poison = access_size < 0 || clobber;
 	/* The call will initialize the memory; uninitialized stack allowed */
-	bool raw_mode = meta && meta->arg_raw_mem.regno == abs(argno.argno);
+	u32 arg_slot = arg_slot_from_argno(argno);
+	bool raw_mode = meta && arg_slot < MAX_BPF_FUNC_ARGS &&
+		       (meta->arg_raw_mem.mask & BIT(arg_slot));
 
 	access_size = abs(access_size);
 
@@ -7023,7 +7031,7 @@ static int check_stack_range_initialized(
 	}
 
 	if (raw_mode) {
-		meta->arg_raw_mem.size = access_size;
+		meta->arg_raw_mem.size[arg_slot] = access_size;
 		return 0;
 	}
 
@@ -7215,9 +7223,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * raw mode so that the program is required to initialize all
 	 * the memory that the helper could just partially fill up.
 	 */
-	if (!tnum_is_const(size_reg->var_off) &&
-	    meta->arg_raw_mem.regno == abs(mem_argno.argno))
-		meta->arg_raw_mem.regno = 0;
+	if (!tnum_is_const(size_reg->var_off))
+		meta->arg_raw_mem.mask &= ~BIT(arg_slot_from_argno(mem_argno));
 
 	if (reg_smin(size_reg) < 0) {
 		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
@@ -8158,12 +8165,9 @@ static bool arg_type_is_raw_mem(enum bpf_arg_type type)
 	 * A map value output buffer (e.g. bpf_map_pop_elem) is also a raw
 	 * (uninitialized) memory argument, and like ARG_PTR_TO_MEM it may be
 	 * passed as a PTR_TO_STACK that reaches check_stack_range_initialized().
-	 * A kfunc's struct pointer remains ARG_PTR_TO_BTF_ID until call argument
-	 * checking resolves it to generic memory, so include it in proto validation.
 	 */
 	return (base_type(type) == ARG_PTR_TO_MEM ||
-		base_type(type) == ARG_PTR_TO_MAP_VALUE ||
-		base_type(type) == ARG_PTR_TO_BTF_ID) &&
+		base_type(type) == ARG_PTR_TO_MAP_VALUE) &&
 	       type & MEM_UNINIT;
 }
 
@@ -9038,7 +9042,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		 */
 		if (is_helper_call(meta, BPF_FUNC_map_peek_elem) &&
 		    meta->map.ptr->map_type == BPF_MAP_TYPE_BLOOM_FILTER)
-			meta->arg_raw_mem.regno = 0;
+			meta->arg_raw_mem.mask &= ~BIT(slot);
 
 		err = check_helper_mem_access(env, reg, argno, meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
@@ -9191,7 +9195,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		bool known_memory;
 
 		if (meta->btf && (arg_type & MEM_UNINIT))
-			meta->arg_raw_mem.regno = slot + 1;
+			meta->arg_raw_mem.mask |= BIT(slot);
 
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
@@ -9567,24 +9571,28 @@ static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_arg_meta
 			  int insn_idx)
 {
 	struct bpf_func_state *caller = cur_func(env);
-	struct bpf_reg_state *reg;
-	u32 slot = meta->arg_raw_mem.regno - 1;
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
@@ -9884,7 +9892,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 
 static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
 {
-	bool seen = false;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
@@ -9892,11 +9899,9 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 			break;
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
-		if (seen)
+		if (meta->arg_raw_mem.mask)
 			return false;
-		seen = true;
-		if (!meta->btf)
-			meta->arg_raw_mem.regno = i + 1;
+		meta->arg_raw_mem.mask = BIT(i);
 	}
 
 	return true;
@@ -13099,10 +13104,6 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 		return -ENOTSUPP;
 	}
 
-	if (!check_raw_mode_ok(proto, meta)) {
-		verbose(env, "multiple __uninit buffers are not supported\n");
-		return -EINVAL;
-	}
 	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
 }
 
@@ -13899,7 +13900,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
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

