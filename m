Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340AE41F34A
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586947; cv=none; b=qrqU5+47Gvw09vWon5wMe0aJIfax/9tLmu6jjv1s7nqGG9uJ6OBiikVTiJO+ijyrdcPozjXlmDmVZpKKpAY45kGQFdcM/Y8auSnaulCjV0qZ7M8wX3L8vrRcP0UhbqEA3Z+qHKn9U1NzsGtpj9qwBtIQ8bQtUpFh5K9DmMjKkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586947; c=relaxed/simple;
	bh=WTwgmbfU2YvZ7PDfi7fBurKh7poNt59VBQlsT76MWkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=af5UofYU4kvNlTlm6p78xcjwEHEVcMo5WID+ncVt4y2inDnlOSmUvqU+3yeQsv/oUjcbiV9wNIfOfrSJl/xQnakkO4OPSMo0uDqxbcNtsC5R/fGZXNiwpXBL9xWGbKqfVhc1uZLbaI4RSYsE4gTPYsIps0xRxeS/aJYj/s6qwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8Vy4a+O; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8Vy4a+O"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b46dc430fso211365e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586890; x=1790191690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nqCfGokO8x1jlGzFq2xlURRPDZvKQpQ8HoRhhQxhltk=;
        b=E8Vy4a+OIfWRxHT28TobX46NmW1/F8O7X1On9O6PuP/dHaoUyc4FSRqIJbFSyKX/gi
         1u1bQJe1+dEdDT9huMIQouUYnAnWXYAEAwm7vKgQ9cEFsqwsBUqFdOQhZc4eMsDfV1A9
         /gFzIuzz2zt1Lq71qKwvpOv9bLHgPm696i7Qva8k/CksiTDMpmtmFxS7zrW8H5/yWWDr
         hR0U28PlRt4520l3clNAvKC6cYVXGQEpEDdkcV8giftqVT8Jhb7p1v5hfVdtLrzla0CF
         N9pz2aaxFtbPUKzAP9D3oZLTRdO12zEuB8bdeLd+sqoMBEB7HOF7YRcuMehvlkELxEv/
         KjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586890; x=1790191690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nqCfGokO8x1jlGzFq2xlURRPDZvKQpQ8HoRhhQxhltk=;
        b=Sn/FxbSfA6fqL7wgN+29DbgvRVpBBqQMVcH8XIOP0ugghOwwMDgy01aJJhQMNNRk3E
         MzMNJoYVDPsLMjSKrYiNMGJpSJduAeSXtWkHOKj9HKjCqjrg/ud/iW5IboOmdGj19kws
         pOZtfO783HfYRWepY8zfYS3X9+4hcONxbuHPECyqBb1qrZySkMlrvr/8oN0gfKRwytze
         8BPgZL2AexOSXJw3yEFrmgmCEfK5oTTrXUGJafx8kcwVfDkS+VFEWIOWuEBu1/pmWCcr
         rBZhv06LZNXoY685ieJPHq/N84XAArKVr1Om4ACaPwxLz1ZPkzr1irVgYYT2ho7wwS4K
         YBNg==
X-Gm-Message-State: AFuF++lBghrmoC6xDezGATGrrablcxW07XMtL63Jc/ltZ+Nhuv4sz8Zr
	HFr8yicbYkk2SE8CH6pI74J52BI9lrkNowD4n+DPpW6INuAqjQA5k2Pixp42bVKO
X-Gm-Gg: AYBFou383RfH5NnUec558m0oOHC80Vgd+34Xrgg+K3u7QijOeAq07yogCRjbpK6/lPU
	D0qWmjuISoKb5716ZAq4LgYilFqSoHKqn8J0x3AxJJ3vUreByfwz/lKkZDHxM/JLDxesRwM7x+v
	rtTW9PAAVpJLC/1NziHI6hggRgfgYjrxIiAaiZKd6CtLRWwxPIImmZB03BA1YRyS78PaO+ME27k
	2kUDgPDlMhgZSEu8z6bNWUwhuZA6QYpTyRxrz2oGoHlV9R8s7aE8PcDOUCy2Jdhs4zz8m6fljyf
	wfbHys8+K7I0r0r/2EUO1tu1qa7iUSCx8IzVRrZpuUtJesLP5E9+skQOGWp6hZGSL57qaCZ/SEe
	MugztKtS5q07vxOMgKUnybrViVJZ1pk/U+nshhQ4RNwGJ3iQOg3g1qKru7Xa71y0qGE5yQagXUH
	XYp4kBjt8gvW3w7sXEnqmJV0XHnn+dk0PJxzO13nT01E3+VmHSLiWNamj4lqkP+suwUsQbySm33
	saT+TsEzcm/IQ0iu3KoBiqMFIH8ANE0jFCX+ijbU5XcWmhd5zpHjHXI7ODZ9e0bm8oJY94gw7So
	0hoSxrArjqZOIiHUvoWbCU39zCqil8sdfyLNGQ==
X-Received: by 2002:a05:600c:a00e:b0:49c:fa20:cc07 with SMTP id 5b1f17b1804b1-49eb7336c57mr50735085e9.30.1789586890374;
        Wed, 16 Sep 2026 12:28:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf34440sm9038064f8f.25.2026.09.16.12.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:28:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/5] bpf: Fix generic __uninit kfunc output buffers
Date: Wed, 16 Sep 2026 21:27:59 +0200
Message-ID: <20260916192805.3991983-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916192805.3991983-1-memxor@gmail.com>
References: <20260916192805.3991983-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12039; i=memxor@gmail.com; h=from:subject; bh=WTwgmbfU2YvZ7PDfi7fBurKh7poNt59VBQlsT76MWkk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvV27o7j9rUUpdfdnqX/ubm8/2W85XnRohnKoimsRr3y 52Nnbe3o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPJvMvIsEXM8KvwQZ6WNvnD K53lzv9/ovljbd256u5Y+W33Hmkf8mJkuCGl4vh/woJnNb0hlxyzbRzs9EXeaOvsu8tfF7/Svvg nHwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Stack liveness treats __uninit kfunc arguments as writes, but generic memory
argument validation still checks them as both reads and writes. A checkpoint
can consequently poison an output buffer before the call and cause its read
check to reject the program. Allowing that read would not suffice: ordinary
clobber checks leave poisoned bytes poisoned after the call.

Check generic __uninit memory arguments as write-only and reuse the helper
output descriptor to record definite initialization of a single output.
Apply the writes after validating all arguments so an output does not make
an aliased, uninitialized input appear valid. Look up the output register
state only when there are recorded bytes to initialize.

Preserve MEM_UNINIT when a scalar-only struct pointer is resolved to a
fixed-size memory argument. Use a common access-mode helper for fixed-size
and sized arguments. Disable raw mode for a variable-size argument only
when it is the tracked output.

Reuse check_raw_mode_ok() after generating the kfunc prototype to reject
multiple generic outputs before checking any call arguments. Include struct
pointers that are resolved to generic memory later. Record the actual output
slot during call checking, where the ABI slot and resolved memory type are
known.

Document that generic output buffers must be fully initialized on every
return path, including error returns and padding. Multiple-output tracking
is left to a separate change.

Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/bpf/86d966ec88bbf27d21b2bb4e18c8aa00@kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 27 ++++++++---
 include/linux/bpf_verifier.h |  7 +--
 kernel/bpf/verifier.c        | 88 +++++++++++++++++++++++++++---------
 3 files changed, 90 insertions(+), 32 deletions(-)

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
index cf85141ea167..3c1b06a3daf3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1548,10 +1548,11 @@ struct ref_obj_desc {
 
 /*
  * A memory argument a call fills in. The verifier allows the stack to be uninitialized if
- * the range is a known constant. Stack slots are marked as STACK_MISC by check_mem_access().
+ * the range is a known constant. Stack slots are marked as STACK_MISC by check_mem_access()
+ * after all arguments have been checked.
  */
 struct arg_raw_mem_desc {
-	u8 regno;
+	u8 regno; /* Register number, or one-based kfunc argument slot. */
 	int size;
 };
 
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
index 6c6b8d8520cd..d7a40dc159ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6981,7 +6981,7 @@ static int check_stack_range_initialized(
 	 */
 	bool allow_poison = access_size < 0 || clobber;
 	/* The call will initialize the memory; uninitialized stack allowed */
-	bool raw_mode = meta && meta->arg_raw_mem.regno == reg_from_argno(argno);
+	bool raw_mode = meta && meta->arg_raw_mem.regno == abs(argno.argno);
 
 	access_size = abs(access_size);
 
@@ -7215,7 +7215,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * raw mode so that the program is required to initialize all
 	 * the memory that the helper could just partially fill up.
 	 */
-	if (!tnum_is_const(size_reg->var_off))
+	if (!tnum_is_const(size_reg->var_off) &&
+	    meta->arg_raw_mem.regno == abs(mem_argno.argno))
 		meta->arg_raw_mem.regno = 0;
 
 	if (reg_smin(size_reg) < 0) {
@@ -8157,9 +8158,12 @@ static bool arg_type_is_raw_mem(enum bpf_arg_type type)
 	 * A map value output buffer (e.g. bpf_map_pop_elem) is also a raw
 	 * (uninitialized) memory argument, and like ARG_PTR_TO_MEM it may be
 	 * passed as a PTR_TO_STACK that reaches check_stack_range_initialized().
+	 * A kfunc's struct pointer remains ARG_PTR_TO_BTF_ID until call argument
+	 * checking resolves it to generic memory, so include it in proto validation.
 	 */
 	return (base_type(type) == ARG_PTR_TO_MEM ||
-		base_type(type) == ARG_PTR_TO_MAP_VALUE) &&
+		base_type(type) == ARG_PTR_TO_MAP_VALUE ||
+		base_type(type) == ARG_PTR_TO_BTF_ID) &&
 	       type & MEM_UNINIT;
 }
 
@@ -8885,6 +8889,16 @@ static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_stat
 	return 0;
 }
 
+static enum bpf_access_type func_arg_access_type(enum bpf_arg_type arg_type,
+						 const struct bpf_call_arg_meta *meta)
+{
+	if (arg_type & MEM_UNINIT)
+		return BPF_WRITE;
+	if (meta->btf)
+		return BPF_READ | BPF_WRITE;
+	return arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 prev_slot,
 			  struct bpf_call_arg_meta *meta,
 			  int insn_idx)
@@ -9176,15 +9190,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		enum bpf_access_type access_type;
 		bool known_memory;
 
+		if (meta->btf && (arg_type & MEM_UNINIT))
+			meta->arg_raw_mem.regno = slot + 1;
+
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
 		 */
 		if (!(arg_type & MEM_FIXED_SIZE))
 			break;
 
-		access_type = arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;
-		if (meta->btf)
-			access_type = BPF_READ | BPF_WRITE;
+		access_type = func_arg_access_type(arg_type, meta);
 
 		err = check_mem_reg(env, reg, argno, arg_size, access_type, meta, &known_memory);
 		if (err < 0) {
@@ -9230,9 +9245,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		if (meta->btf && bpf_register_is_null(buff_reg))
 			break;
 
-		access_type = fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ;
-		if (meta->btf)
-			access_type = BPF_READ | BPF_WRITE;
+		access_type = func_arg_access_type(fn->arg_type[arg - 1], meta);
 
 		zero_size_allowed = meta->btf || base_type(arg_type) == ARG_MEM_SIZE_OR_ZERO;
 
@@ -9550,6 +9563,33 @@ static int check_func_args(struct bpf_verifier_env *env, struct bpf_call_arg_met
 	return 0;
 }
 
+static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
+			  int insn_idx)
+{
+	struct bpf_func_state *caller = cur_func(env);
+	struct bpf_reg_state *reg;
+	u32 slot = meta->arg_raw_mem.regno - 1;
+	int i, err;
+
+	if (!meta->arg_raw_mem.size)
+		return 0;
+	reg = get_func_arg_reg(caller, cur_regs(env), slot);
+
+	/*
+	 * Validate every argument before initializing outputs: an input argument
+	 * may alias an output buffer. Use the normal stack-write checks to discard
+	 * stale spills and preserve the rules for special stack objects.
+	 */
+	for (i = 0; i < meta->arg_raw_mem.size; i++) {
+		err = check_mem_access(env, insn_idx, reg, argno_from_arg(slot + 1), i, BPF_B,
+				       BPF_WRITE, -1, false, false);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 {
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
@@ -9844,6 +9884,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 
 static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
 {
+	bool seen = false;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
@@ -9851,9 +9892,11 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 			break;
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
-		if (meta->arg_raw_mem.regno)
+		if (seen)
 			return false;
-		meta->arg_raw_mem.regno = i + 1;
+		seen = true;
+		if (!meta->btf)
+			meta->arg_raw_mem.regno = i + 1;
 	}
 
 	return true;
@@ -11572,16 +11615,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
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
@@ -12437,7 +12473,7 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 			PTR_ERR(resolve_ret));
 		return -EINVAL;
 	}
-	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | (*arg_type & PTR_MAYBE_NULL);
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
 
 	return 0;
 }
@@ -13063,6 +13099,10 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 		return -ENOTSUPP;
 	}
 
+	if (!check_raw_mode_ok(proto, meta)) {
+		verbose(env, "multiple __uninit buffers are not supported\n");
+		return -EINVAL;
+	}
 	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
 }
 
@@ -14140,6 +14180,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

