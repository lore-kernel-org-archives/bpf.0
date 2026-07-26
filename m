Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355203A1C9
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785029471; cv=none; b=GgXwCno4TJtCQxIs7Auw2CWaARZOaP8DAjv4lk0jTeMXcIRgJxIFquQ1WN9obIkS/ue4t3N3z3F/aNnT5P3zkyYhzJS63R/ipBUsff6tAqPsYFcYH8Rxfe0X/q3tmFnfgSVaRKEz5ngXWQlcLqAl+4ruRjXcQQWvHFU+B4ahfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785029471; c=relaxed/simple;
	bh=gCHyIjthtAZ9DUc5pjZ7SWDWjaU+N9rqNtyomvXDj7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFz9jdEUC+xNMEGVTSS+vA82D5EWAch6x2tHUjed0f+x1EMlh6ZUZW2t6C1is7Roz+ozFWcYY0qf/6Z6JrpgW59jrwTPmvI3v+t/74LwkHRP4Rq4J7b/3EB4ebUkJzG9HVwECfiQGVv16lUMreFwkbsN/YewTpM2fF8yEQXz4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMXVM7qK; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMXVM7qK"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46e260f9e57so798007f8f.0
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785029467; x=1785634267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0Dn4CBx/zK5pBGw5rF11MyCbCoPdu3Aj3izKYlFblc=;
        b=sMXVM7qK1DGB7l6cSyEf45GK4tnaHLZjGsQUvQXXLZuURgN9Do1EwJjhXQFM61TU86
         p/hPPvqMPv4oh9wn0i2884OB8qQtqHlufyurGynkSiGfdygbQBnouHN7HULyfF/iFn3V
         kfeySroMqFMHUrjE+kiOZFxD8o7HiQYjaWDwapdI5lWhDTGERmmt7LIrz/OI6D0WLfps
         CeYEXH6AN5R8WEaRmyoKEewHTIIKCnIC82evx/sCGHIUnvP1qPo81uW79TBoG05MOxFC
         /eD9CHSHgo9c2b11GOlspTt+p7IJ3ncB+P989790nYFLeZRw5GyxsOfr/5PjmynvnzjK
         +rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785029467; x=1785634267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h0Dn4CBx/zK5pBGw5rF11MyCbCoPdu3Aj3izKYlFblc=;
        b=iDGiEflN75lPZRNiWWtgEnWjeJ94IgYEo2iWfvu6S9NwY7WWbb1tPCdqnPe9ugC1vL
         AB3QtlffMqU0bdNdZXMHrue3zdB/7MJhvgfvVXUS+kmJaBcjIwu9a5j4YP0HI/PDWFQE
         TMCqECdhqx9jH7rycoQ1tO8FQwRlOhMITdZhtjzhVHOZgudYPYsJumjvWqz7hgKHfG7w
         fcXwn/cvJ/wDsNoXtoA9Rj+tnRVuo0diO2IxqXWmn+WP8XeQ35HknvLVdEOx4mkA4MhA
         yGubbdjb4Y9MQTmEDt7hfv1MhpbYuRea7AUWM6V1Hdsqp8Qq20ECB7G2mPdzdWCOu9ye
         S2kw==
X-Gm-Message-State: AOJu0Yzhr9anlo6AHUw6K6Ko7Aw36oBCjW2UyicKU9PDRGuQln7nX29p
	UPvnaZ0a3F2/4n2YdMBoko85SC6kLBRjcEWpkjUvBeHdfWoDQlj/pKGhJNnS3/6s
X-Gm-Gg: AR+sD13YahfOQ/XMoNEuZq8hK7H7VSXMXd07etP59xvtg2otMHOQ3MaOn//5xrv0DKT
	eHmhEtUn6UBcouJuppsm3jbowrV0XjcUP/hEPlWTkomhw7IHawltI3YU6GigBHij2PplSGRwl50
	l9adsJYHfsfBCKfGCL9sRvIE3pC1dxG+04FEev6MouEEjPp37kLPOOVm7GGXcuK0RVekKObLo3n
	IAHIvsvL3xdWnkGD/1MXoGI98J4TbR3WgEYt33iHOlpG6Y9NPIJ9d84s0MuiH4iYsQje/fvZ6ok
	R5Psi47fuofylsJbYZg/iDuQiE2Sh3J0BWFa+bW/3h/OVKesE5/o6WvusOYKCep//nFx3xPYks/
	YgWswj9jCMU2wEH03+UxgC2vi5OkTP6ParJdxnSvbEDbQ+eiJok/xRRniNJxH4QHth5R/L2Viyg
	hgN7Iwhmn/s1VWfhBAstI/+gFzD1UHhCzZGJ9RR59ARv+CkXGnoScg5tqndRRH73qkoyzJt8/md
	DGlHrIR8kvStmsmXTp1e0mp09ntHFZG8vD6agXgxzIi
X-Received: by 2002:a05:6000:2908:b0:47f:81a9:3f36 with SMTP id ffacd0b85a97d-47f9fc8c922mr4391969f8f.18.1785029467168;
        Sat, 25 Jul 2026 18:31:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c631fdsm34900229f8f.28.2026.07.25.18.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:31:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/9] bpf: Support __arena and __arena_nullable kfunc argument suffixes
Date: Sun, 26 Jul 2026 03:30:54 +0200
Message-ID: <20260726013105.3689867-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726013105.3689867-1-memxor@gmail.com>
References: <20260726013105.3689867-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8674; i=memxor@gmail.com; h=from:subject; bh=PshHlmB3rl8mo3wzqDkDqx50l4zsnYEQi2mFZG9Upqw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISs12eLvg1OiaZX93ZblRRuZjmx1sTDurn/0cH3Pufsq6 RVv/Td2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIh3Qx/pS+0zJq3rkHR9Nrk x3+FC9TslxZfeTN3defT3/2n4lcteMvI8DL67PSHbNaSM/hYfi/ufXu+b8WU58wzLs78wRt6qSL tODsA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Passing an arena pointer to a kfunc takes two steps today. There is no
arena pointer argument type, so the pointer crosses the boundary as a
bare scalar, and the kfunc then offsets it by the arena base and casts
it before it can touch the memory. Every such kfunc open-codes the same
translation.

Add the __arena and __arena_nullable argument suffixes to make this more
convenient. The kfunc declares the parameter by its real pointer type
and dereferences it directly, with the JIT rebasing the value at the
call site, rN = kern_vm_start + (u32)rN. No bounds check is needed: the
u32 offset stays within the guard-padded arena kernel mapping, and a
fault on an unpopulated page recovers through the per-arena scratch
page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
matching global subprog arena arguments.

__arena rebases unconditionally, so the kfunc never sees NULL and a
value with zero in the low 32 bits arrives as the arena base.
__arena_nullable preserves NULL for optional arguments by skipping the
rebase when the truncated value, arena offset 0, is zero. Keeping the
plain form NULL-free saves the NULL test on every call.

This patch adds the verifier side: the suffixes are recognized in
check_kfunc_args() and distilled into argument flags in the function
model stored in the kfunc descriptor. JITs retrieve the model while
emitting the call, avoiding per-call state in insn_aux_data.

JITs declare support with bpf_jit_supports_arena_args() and verification
fails with -ENOTSUPP elsewhere.

Signed-off-by: Tejun Heo <tj@kernel.org>
Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 29 +++++++++++++++++++++++++++
 include/linux/bpf.h          |  6 ++++++
 include/linux/filter.h       |  1 +
 kernel/bpf/btf.c             | 18 ++++++++++++++++-
 kernel/bpf/core.c            |  5 +++++
 kernel/bpf/verifier.c        | 39 ++++++++++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index c801a330aece..9809680bee43 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -250,6 +250,33 @@ Or::
                 ...
         }
 
+2.3.7 __arena and __arena_nullable Annotations
+----------------------------------------------
+
+Both annotations indicate that the pointer argument points into the
+calling program's arena. The JIT rebases the value at the call site so
+the kfunc receives a directly dereferenceable kernel address, subject to
+the access rules described in :ref:`BPF_kfunc_arena_access` (at most
+``GUARD_SZ / 2``, 32 KiB, past the pointer in a single unchecked access).
+
+With ``__arena`` the rebase is unconditional and the argument is never
+NULL: a value whose lower 32 bits are zero arrives as the arena base
+address (arena offset 0). The kfunc must not check the argument for NULL.
+With ``__arena_nullable`` such a value arrives as NULL instead and the
+kfunc must check before dereferencing.
+
+An example is given below::
+
+        __bpf_kfunc int bpf_process_item(struct item *item__arena)
+        {
+        ...
+        }
+
+Calling such a kfunc requires the program to use an arena map and a JIT with
+arena argument support (currently x86-64); verification fails otherwise. The
+program can pass any value without compromising the kernel. A value that does
+not point into the arena is a program bug.
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
@@ -487,6 +514,8 @@ In order to accommodate such requirements, the verifier will enforce strict
 PTR_TO_BTF_ID type matching if two types have the exact same name, with one
 being suffixed with ``___init``.
 
+.. _BPF_kfunc_arena_access:
+
 2.8 Accessing arena memory through kfunc arguments
 --------------------------------------------------
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7bfc28673124..1ca4f2115fde 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1213,6 +1213,12 @@ struct bpf_prog_offload {
 /* The argument is signed. */
 #define BTF_FMODEL_SIGNED_ARG		BIT(1)
 
+/* The argument is an arena pointer. */
+#define BTF_FMODEL_ARENA_ARG		BIT(2)
+
+/* The argument is nullable. */
+#define BTF_FMODEL_NULLABLE_ARG		BIT(3)
+
 struct btf_func_model {
 	u8 ret_size;
 	u8 ret_flags;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 32d5297c557e..36ce3403fe59 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1183,6 +1183,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_stack_args(void);
+bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4eeeaeb69790..f54fddfb5c8e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7541,6 +7541,22 @@ static u8 __get_type_fmodel_flags(const struct btf_type *t)
 	return flags;
 }
 
+static u8 __get_arg_fmodel_flags(const struct btf *btf,
+				 const struct btf_param *arg,
+				 const struct btf_type *t)
+{
+	u8 flags = __get_type_fmodel_flags(t);
+
+	if (btf_param_match_suffix(btf, arg, "__arena") ||
+	    btf_param_match_suffix(btf, arg, "__arena_nullable"))
+		flags |= BTF_FMODEL_ARENA_ARG;
+	if (btf_param_match_suffix(btf, arg, "__nullable") ||
+	    btf_param_match_suffix(btf, arg, "__arena_nullable"))
+		flags |= BTF_FMODEL_NULLABLE_ARG;
+
+	return flags;
+}
+
 int btf_distill_func_proto(struct bpf_verifier_log *log,
 			   struct btf *btf,
 			   const struct btf_type *func,
@@ -7606,7 +7622,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 			return -EINVAL;
 		}
 		m->arg_size[i] = ret;
-		m->arg_flags[i] = __get_type_fmodel_flags(t);
+		m->arg_flags[i] = __get_arg_fmodel_flags(btf, &args[i], t);
 	}
 	m->nr_args = nargs;
 	return 0;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e2076667b245..a3e1fae32eac 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3308,6 +3308,11 @@ bool __weak bpf_jit_supports_stack_args(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_arena_args(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_far_kfunc_call(void)
 {
 	return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 641c3c62c1ec..f3e6190f639e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10847,6 +10847,16 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }
 
+static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__arena");
+}
+
+static bool is_kfunc_arg_arena_nullable(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__arena_nullable");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -12056,6 +12066,35 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
+		if (is_kfunc_arg_arena(btf, &args[i]) || is_kfunc_arg_arena_nullable(btf, &args[i])) {
+			if (verifier_bug_if(!btf_type_is_ptr(t), env,
+					    "kfunc %s arg#%d has __arena tag on non-pointer",
+					    func_name, i))
+				return -EFAULT;
+			if (!bpf_jit_supports_arena_args()) {
+				verbose(env, "JIT does not support kfunc %s() with arena pointer arguments\n",
+					func_name);
+				return -ENOTSUPP;
+			}
+			if (!env->prog->aux->arena) {
+				verbose(env,
+					"%s arena pointer requires a program with an associated arena\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			if (regno < 0) {
+				verbose(env, "%s arena pointer cannot be a stack argument\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a pointer to arena or scalar\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			continue;
+		}
+
 		if (btf_type_is_scalar(t)) {
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
-- 
2.53.0

