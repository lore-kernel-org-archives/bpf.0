Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95323DFC80
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484874; cv=none; b=Nux5W+SLn5MF1oyb9G5sPH8vVyRpEqr4bowA8FBqZF9nXTRF/pkqufWU4kEbi12o+4zLpME4EICmWPy8PR1fyMW3btUOM4IdIiYQq4RHDvet7nDlWKTE6XozlrH9nNi9/rvzQ8LybXyCTVJFTxUmE47qZWUF8L7Hqt1PKHEx6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484874; c=relaxed/simple;
	bh=2Bi6Hue9cmd9pnQvJgS4mDccy9AO0mvqpPrT+kh3k6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsbJSb7XHnoDZBPO+lrSyU+Njpx1M27HZO7XlNyiPp57r4j105Iaqm4LNEy+Nc+grxTqBf2w/36OtW2jyVKKIWVTc74nyYpSGvtkmyvcEmfOOlTfphx3E+SUo0UqTvHC9zeRwYHcbzgWZ4hN+dvZktYqXqCtzeWYbZpQ49mquuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=a80+LXDC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="a80+LXDC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+TNDDOiidREGQjfqht1JG4FzdvUzrh7W+neXjOB0dj8=; b=a80+LXDCmjQxvmiNj7OzzA2Bgu
	1iMGuouQy56kmUo6Gn6z/2+zIXqbMGMhRgP3O3ZvR+cYglAiXey+x5NGrNvFunRj3B/M9DWoXsfjF
	Ipyc8G0Niu8OELjXA8o9fuce8tMJmTK++2HNt/DgorUGb033Uln5N75KIv4g4seKP4pzvqA1uWRxS
	3Sj7r5RdysQaRi/Ql4MtiNFK10tfrRSeultb8G8YqwpQHI0gJ4QEy4gVdqmn4y5M3QiKYvoTSHfpo
	JUo1nMvWujab9LmW4StF5Wb15YQF87zDAciw7K3fe3XW3BcfiB02vSyZ5r66JRZ83XHsDMVlpW7g+
	Y+K2VtfA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6Ul5-0007KG-18;
	Tue, 15 Sep 2026 17:07:43 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: brauner@kernel.org,
	dwindsor@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/8] bpf: Support passing context output arguments to kfuncs
Date: Tue, 15 Sep 2026 17:07:34 +0200
Message-ID: <20260915150739.284189-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915150739.284189-1-daniel@iogearbox.net>
References: <20260915150739.284189-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28124/Tue Sep 15 08:27:28 2026)

From: David Windsor <dwindsor@gmail.com>

Allows programs to pass a context argument that points to a scalar
output value on to a kfunc that writes the result on the program's
behalf.

A ctx_arg_info entry can now describe a fixed-size PTR_TO_MEM context
argument through a new mem_size field, honored in btf_ctx_access().
Loading the argument yields a PTR_TO_MEM | MEM_RDONLY | PTR_TRUSTED
register of known size, readable but not writable by the program. A
kfunc argument tagged with the new "__ctx_out" suffix accepts only that
register type with a size matching the pointed-to type, so the only
value a program can pass is an output argument from its own context.

The pointer stays read-only to the program because the value is
trusted by whoever invoked the BPF program. In the first use case, the
inode_init_security LSM hook, every LSM receives a shared xattr array
and an int *xattr_count that lsm_get_xattr_slot() increments; a program
that could store a garbage count would push another LSM's write out of
bounds, so only the kfunc itself writes through it.

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: David Windsor <dwindsor@gmail.com>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 Documentation/bpf/kfuncs.rst | 23 +++++++++++++++++++++++
 include/linux/bpf.h          |  3 +++
 kernel/bpf/btf.c             |  7 +++++--
 kernel/bpf/diagnostics.c     |  2 ++
 kernel/bpf/verifier.c        | 36 +++++++++++++++++++++++++++++++++++-
 5 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 6c2c048dccef..3f300118a623 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -315,6 +315,29 @@ However, there is no obligation to prove to the verifier that such a pointer is
 non-NULL before use, in-line with existing semantics of arena pointers used in
 a program (or obtained from any other source).
 
+2.3.9 __ctx_out Annotation
+--------------------------
+
+This annotation is used to indicate that the argument is an output
+parameter of the attached hook, passed through from the program's
+context. The verifier requires the register to be a trusted read-only
+pointer to fixed-size memory, which can only be produced by loading an
+argument described by the program's ctx_arg_info from the context. The
+program itself cannot write through the pointer; the kfunc may.
+
+An example is given below::
+
+        __bpf_kfunc int bpf_inode_init_xattr(struct xattr *xattrs,
+                                             int *xattr_count__ctx_out,
+                                             ...)
+        {
+        ...
+        }
+
+In this case, a program attached to the ``inode_init_security`` LSM hook
+can pass the hook's own ``xattr_count`` argument through to the kfunc,
+which claims xattr slots by writing through it.
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2a5fa346aada..f72413a383ba 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -923,6 +923,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_TASK_WORK,	/* pointer to bpf_task_work */
 	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
 	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
+	ARG_PTR_TO_CTX_OUT,	/* hook output argument passed through from ctx */
 	ARG_PTR_TO_PROG_AUX,	/* pointer to the caller's bpf_prog_aux */
 	ARG_IGNORE,		/* argument the verifier does not check at all */
 	__BPF_ARG_TYPE_MAX,
@@ -1137,6 +1138,7 @@ struct bpf_insn_access_aux {
 			u32 ref_id;
 		};
 	};
+	u32 mem_size;
 	struct bpf_verifier_log *log; /* for verbose logs */
 	bool is_retval; /* is accessing function return value ? */
 };
@@ -1715,6 +1717,7 @@ struct bpf_ctx_arg_aux {
 	struct btf *btf;
 	u32 btf_id;
 	u32 ref_id;
+	u32 mem_size;
 	bool refcounted;
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7daf4c286c9b..8bc463e31704 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6994,8 +6994,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	}
 
 	/*
-	 * Check for PTR_TO_RDONLY_BUF_OR_NULL, PTR_TO_RDWR_BUF_OR_NULL or
-	 * PTR_TO_ARENA (both nullable and non-nullable cases).
+	 * Check for PTR_TO_RDONLY_BUF_OR_NULL, PTR_TO_RDWR_BUF_OR_NULL,
+	 * PTR_TO_ARENA (both nullable and non-nullable cases) or fixed-size
+	 * PTR_TO_MEM.
 	 */
 	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
 		const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];
@@ -7005,8 +7006,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		flag = type_flag(ctx_arg_info->reg_type);
 		if (ctx_arg_info->offset == off &&
 		    (type == PTR_TO_ARENA ||
+		     type == PTR_TO_MEM ||
 		     (type == PTR_TO_BUF && (flag & PTR_MAYBE_NULL)))) {
 			info->reg_type = ctx_arg_info->reg_type;
+			info->mem_size = ctx_arg_info->mem_size;
 			return true;
 		}
 	}
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index a2cac59c6639..787932f92cdf 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -984,6 +984,8 @@ const char *bpf_diag_arg_type_plain(enum bpf_arg_type type)
 		return "the address of a stack iterator object for iterator new, next, and destroy calls";
 	case ARG_PTR_TO_IRQ_FLAG:
 		return "the same stack slot used by bpf_local_irq_save() or bpf_res_spin_lock_irqsave()";
+	case ARG_PTR_TO_CTX_OUT:
+		return "the attach hook's own output argument, loaded directly from the program context";
 	default:
 		return "a value with one of the accepted pointer or scalar types for this call";
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cd..cf067634d3c3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6579,6 +6579,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
 					regs[value_regno].id = info.ref_id;
+				} else if (base_type(info.reg_type) == PTR_TO_MEM) {
+					regs[value_regno].mem_size = info.mem_size;
 				}
 				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
 					regs[value_regno].id = ++env->id_gen;
@@ -8358,6 +8360,9 @@ static const struct bpf_reg_types arena_types = {
 		SCALAR_VALUE,
 	}
 };
+static const struct bpf_reg_types ctx_out_types = {
+	.types = { PTR_TO_MEM | MEM_RDONLY | PTR_TRUSTED },
+};
 
 static const struct bpf_reg_types alloc_obj_drop_types = {
 	.types = {
@@ -8429,6 +8434,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_TASK_WORK]		= &map_value_types,
 	[ARG_PTR_TO_IRQ_FLAG]		= &stack_ptr_types,
 	[ARG_PTR_TO_ARENA]		= &arena_types,
+	[ARG_PTR_TO_CTX_OUT]		= &ctx_out_types,
 };
 
 static void bpf_diag_call_arg(struct bpf_verifier_env *env, u32 insn_idx, argno_t argno,
@@ -9421,6 +9427,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		if (err < 0)
 			return err;
 		break;
+	case ARG_PTR_TO_CTX_OUT:
+		if (reg->mem_size != arg_size) {
+			verbose(env, "%s expected %u bytes of ctx-provided memory, got %u\n",
+				reg_arg_name(env, argno), arg_size, reg->mem_size);
+			return -EINVAL;
+		}
+		break;
 	case ARG_PTR_TO_RES_SPIN_LOCK:
 	{
 		int flags;
@@ -12137,6 +12150,11 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }
 
+static bool is_kfunc_arg_ctx_out(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__ctx_out");
+}
+
 static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__arena__nullable") ||
@@ -12900,7 +12918,23 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		arg_type = ARG_PTR_TO_IRQ_FLAG;
 	else if (is_kfunc_arg_res_spin_lock(meta->btf, &args[arg]))
 		arg_type = ARG_PTR_TO_RES_SPIN_LOCK;
-	else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
+	else if (is_kfunc_arg_ctx_out(meta->btf, &args[arg])) {
+		if (!btf_type_is_scalar(ref_t)) {
+			verbose(env, "%s __ctx_out argument must point to a scalar\n",
+				reg_arg_name(env, argno));
+			return -EINVAL;
+		}
+		resolve_ret = btf_resolve_size(meta->btf, ref_t, &type_size);
+		if (IS_ERR(resolve_ret)) {
+			verbose(env,
+				"%s reference type('%s %s') size cannot be determined: %ld\n",
+				reg_arg_name(env, argno), btf_type_str(ref_t),
+				ref_tname, PTR_ERR(resolve_ret));
+			return -EINVAL;
+		}
+		proto->arg_size[arg] = type_size;
+		arg_type = ARG_PTR_TO_CTX_OUT | MEM_FIXED_SIZE;
+	} else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
 		arg_type = ARG_PTR_TO_FUNC;
 	else if (is_kfunc_arg_arena(meta->btf, &args[arg])) {
 		if (!bpf_jit_supports_arena_args()) {
-- 
2.43.0

