Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790509;
	b=MRmmps7qgOLYgZOQxM9jZDxpNEi9O5FFmFWHqt5v+T5hc/ePri558xmetSXhgS2l46y2
	 QqUl+7F09zOHlpjhTQB/kR2rdyPxKIe11pmGi9GFajFqEj3vvPr8FSTQQsC8aCk6n+GIp
	 DOKgXPhv17UTBOadGBPj4aMx3Hfj4MDsBdFWM2eIYIOCBwu/cuW9vxlgHHnPDFZSk7KzR
	 HI1sHtkkDfYVdogejPpyxZauxeCihae77nR/oRCvqyyskujN/oJzyZH3it7ET5PgKEiOH
	 4heRywG0XcEtVM4RauP0vQ+pLoXYWsU07FjDlkloXtfdqv5FbAlUFhyBukfB/XtWP7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FvBMqxIwh1oZOl1lZY0s5VUPvODvirY3nMmy9CUo58Y=;
	b=sHXdAVC2tKmAcJ7NKHYCq4MDzM5xoNRBGcLSl3T1ZDVZM2tcLe50w/mdVEw9wKkIaZsS
	 iiWYlSpWpmxIvigL0umF+u0wueXzp3XLSogw2I7ceRsTfl/9Uu1pYh0N0iipUwaUSP9Fr
	 BY3Jb1Z+BxNDaiQPKZA4Fy77YNtfHFMX1SuD5PI6+Ea0eljPAqhQb6d+zYg5WHpLSzEgI
	 wbDtEJyvxDCPx0i2EAyQLl1eGvn2PKAlxb9XwC2vruqRAbuKQiNV+or1Ce0H4NuB7lGFT
	 T0GamzJRIhLkhNbRjUazk3DEORatcl6nzbRoPlj1eq/C+YPhfIhMwyfrU0vYm9lMM8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EBovwyZd;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B12606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 21:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23B12606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EBovwyZd
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab395abf79so13044387b3.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790508; x=1793395308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FvBMqxIwh1oZOl1lZY0s5VUPvODvirY3nMmy9CUo58Y=;
        b=EBovwyZd0XGl8zLb7N4mXEht5Mz8K1SLRknd7iWJyQkINYKR4D+2e/7CyMO3+xNK+a
         B/gqkYJkWBmhU4Nq34WZXhxDrJChne95J0EfP20pOwTTIUCl+LGlUHrBkMg6/Jb8+j0G
         ualfNvZmA/rcwNJuH/uvdRQcJncyjO+Wk0bLUjf8bAYkXF7yqURtRrq5BANZC5HAPqhL
         T/T5zRdBDWUhm+Qv5HdiYvvOpZHYyhKkek0v46LpevukTuWtQOUbLQfcdLuNWoTNqAO+
         /2WxGWi9AZAfig8yASFNer2QUmaE80ID6zSA5ZLen5FXbgDnO+PfGPB9PtuXIoMY9cVD
         cB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790508; x=1793395308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FvBMqxIwh1oZOl1lZY0s5VUPvODvirY3nMmy9CUo58Y=;
        b=k7tJi9hDcGPpjI/+joUnVWF9o3cw5sL8C8H2rI+9x/D/k/Zahww32bVb/EcrG/qKMm
         dzGTHZlQfUbmKW2iSlzea7mOdze01LhaqwsdM4PZ/VFj3fIMhFPEoSdED9IkBW/9VqXD
         7Qa4R+c5RMP/LobTza1FzIpSNrZsOQ2v82YD65yXtyMfDZDKOUq2Zs36Ae3M6BBh5lx/
         sJEDnLyj7tTqszkRUhPAplK72GuYn49BHA3OZ+gqXI97Np/8AY/rJmvKdsfTDDLU9Bem
         1LSwEh3vee3Vz5y4ItnIugbW+U240mUBN7vneLh/ZrhUf4+Nh4GdjRukx/Iec9ykBj0p
         em/w==
X-Forwarded-Encrypted: i=1; AKwUvBw0FSjugD0cEfRqnrIHQ1XENczkO+o3fh8vZMvYZQ6ijFf704t9B30BwpJytETcBcibp9k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDmaeOrthcfUweX1sVMvMKJRHIwIOEg9Jd9I9ZiOprBeoA+vdZ
	YjYTUgsvz+jNRFD6+0sOVFY/cK1RPKLg3dyPLWwMCtauDEOQv04kInsT
X-Gm-Gg: AYBFou18mcG9nMVoICnUWskHmU60IDdywBZru1/Kyb9d2nlFIoxWCTD2wBpcqVgV7Ec
	HOpUl7g84gzeMERzD2NGCtunHja3qG2dzRwmre3rDkXxfOG60f8PHbsbrqNHyh+/Oy7/9zjbN4R
	ksRZHH0gEOqlJqgeIDFTUI7U8dLgpuYBfthUj6QGILBNaEwi5/TDq5cv+B+nl7PzLP346wcZ+ka
	a6yKoFX1ho8xd15C253EUfQZs48+nZQOPeWsw1UnrvJEQdUhLnf1O5BX6aG8fkKTHCjz51mLzzS
	kuzeaozeTqa+WoarzfSsupeswjfAZIOSCFqtFgIEuH8tA3FbzNWr+7f0aeER/mdBhnUYcGKlhz9
	U+lW1m3mYMX6TpYTxq2cEy2rZOxryFtmA3tCPSUE+o8cMDm4wlVGpknTH8ZxlsCjiAFGxrFliGw
	3Gik/dryClTeZkk0Qpz1xriqeU0lGjKnuZTr00Hst/FtArJZVqOFQ/2Ia4SMwMQxlZh1WBFMWUy
	HejzZfIK0AmfOLxhGyuDZemIaY0WzcxlWt6KvigPfhTGRYONkmxn2zgDA==
X-Received: by 2002:a05:690c:f04:b0:8b0:702f:2a69 with SMTP id 00721157ae682-8b166c74cb3mr4053017b3.39.1792790508027;
        Fri, 23 Oct 2026 14:21:48 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:35e2:98f8:e90a:1695])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e46a93sm1915667b3.26.2026.10.23.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:21:47 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Xu Yunxiang <xyx2021@mail.ustc.edu.cn>,
	Amery Hung <ameryhung@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 3/5] bpf: Add a __derives_ret kfunc argument annotation
Date: Fri, 23 Oct 2026 17:20:39 -0400
Message-ID: <20261023212041.884996-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023212041.884996-1-utilityemal77@gmail.com>
References: <20261023212041.884996-1-utilityemal77@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kfunc that returns a pointer it borrows from one of its arguments,
without taking a reference of its own, hands out a pointer whose
lifetime is that of the argument. The verifier types every struct
pointer a non-acquire kfunc returns as PTR_TRUSTED for the whole
program, with nothing tying it to the argument it came from, so the
return outlives the reference that keeps the argument alive:

	file = bpf_get_task_exe_file(task);	/* acquired */
	inode = bpf_real_data_inode(file);	/* borrowed from file */
	bpf_put_file(file);			/* inode stays trusted */
	mode = inode->i_mode;

The verifier cannot infer that relationship, the kfunc has to declare
it. Add a __derives_ret parameter name suffix for the argument the
return is derived from. When a kfunc with such an argument is called,
record what keeps that argument alive and set it as the return's
parent_id, so releasing the reference invalidates the return. That is
the argument's own reference if it is referenced, and its parent_id
otherwise, so a return derived from an already derived pointer stays
bound to the original reference; add reg_lifetime_id() for the
choice. On the PTR_TO_MEM return path the annotation takes
precedence over the implicit binding to a referenced argument.

A KF_RCU kfunc may be passed an RCU-protected argument, which only
guarantees its memory until the end of the critical section. A return
derived from it carries MEM_RCU instead of PTR_TRUSTED, so it is
invalidated by bpf_rcu_read_unlock() like the argument. No such kfunc
exists today, but the rule keeps the next one from reopening the hole.

Check at registration that at most one argument carries the suffix,
that it is a pointer, that the kfunc returns a pointer, and that the
kfunc is neither KF_ACQUIRE nor KF_RELEASE: an acquire returns its own
reference, a release destroys it.

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 31 +++++++++++++++++++++++++++++++
 include/linux/bpf_verifier.h |  6 ++++++
 kernel/bpf/btf.c             | 35 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c        | 34 ++++++++++++++++++++++++++++++++--
 4 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 73578a4c3b1f..ef4b1baba2a5 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -351,6 +351,37 @@ In this case, a program attached to the ``inode_init_security`` LSM hook
 can pass the hook's own ``xattr_count`` argument through to the kfunc,
 which claims xattr slots by writing through it.
 
+2.3.10 __derives_ret Annotation
+-------------------------------
+
+This annotation is used to indicate that the pointer the kfunc returns is
+derived from the annotated pointer argument: it points into, or is kept
+alive by, the object the argument refers to, and the kfunc takes no
+reference of its own on it. The returned pointer is therefore only valid
+for as long as the argument is. The verifier binds the return to whatever
+keeps the argument alive, so the two are invalidated together, e.g. when
+the reference that pins the argument is released.
+
+An example is given below::
+
+        __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file__derives_ret)
+        {
+        ...
+        }
+
+Here the inode is kept alive by the file. A program that obtained the file
+from a KF_ACQUIRE kfunc may use the inode until it releases the file, and
+no longer afterwards. A return derived from an argument that is valid for
+the whole program, such as a tracepoint or struct_ops callback argument,
+is valid for the whole program as well. A return derived from an
+RCU-protected argument, which only a KF_RCU kfunc accepts, is itself
+RCU-protected and is only valid until the end of the RCU critical section.
+
+At most one argument of a kfunc can carry the annotation. The kfunc must
+return a pointer and must not be a KF_ACQUIRE or a KF_RELEASE kfunc: the
+former returns a reference of its own, the latter has nothing left to
+lend. Registering a kfunc that breaks these rules fails.
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5926f13ff43c..afd8832f9ae1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1818,6 +1818,12 @@ struct bpf_call_arg_meta {
 	struct arg_constant_desc arg_constant;
 	/* The type of the dynptr that the kfunc writes through */
 	enum bpf_dynptr_type dynptr_write_type;
+	/* What keeps the __derives_ret argument alive, see reg_lifetime_id() */
+	struct {
+		bool found;
+		bool rcu;
+		u32 parent_id;
+	} derives_ret;
 
 	/* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
 	 * generally to pass info about user-defined local kptr types to later
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 538129ed2418..d78ae95da35d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9768,6 +9768,39 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	return 0;
 }
 
+/*
+ * A __derives_ret argument lends its lifetime to the kfunc's return. It has
+ * to be a pointer, there can only be one, and the kfunc has to return a
+ * pointer that is neither acquired nor released: an acquire returns a
+ * reference of its own, a release has nothing left to lend.
+ */
+static int btf_check_derives_ret_kfunc(struct btf *btf, const struct btf_type *func,
+				       u32 func_flags)
+{
+	const struct btf_param *args = btf_params(func);
+	const struct btf_type *t;
+	int i, n = 0;
+
+	for (i = 0; i < btf_type_vlen(func); i++) {
+		if (!btf_param_match_suffix(btf, &args[i], "__derives_ret"))
+			continue;
+		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+		if (!t || !btf_type_is_ptr(t) || n++)
+			return -EINVAL;
+	}
+	if (!n)
+		return 0;
+
+	if (func_flags & (KF_ACQUIRE | KF_RELEASE))
+		return -EINVAL;
+
+	t = btf_type_skip_modifiers(btf, func->type, NULL);
+	if (!t || !btf_type_is_ptr(t))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
@@ -9828,7 +9861,7 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 			return err;
 	}
 
-	return 0;
+	return btf_check_derives_ret_kfunc(btf, func, func_flags);
 }
 
 /* Kernel Function (kfunc) BTF ID set registration API */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4a32875d7077..5a13b5ef688b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1627,6 +1627,12 @@ static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg
 	return find_reference_state(env->cur_state, reg->id);
 }
 
+/* The reference that keeps @reg alive, or 0 if it is valid for the whole program. */
+static u32 reg_lifetime_id(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
+{
+	return reg_is_referenced(env, reg) ? reg->id : reg->parent_id;
+}
+
 static int release_lock_state(struct bpf_verifier_env *env, int type, int id, void *ptr)
 {
 	struct bpf_verifier_state *state = env->cur_state;
@@ -9097,6 +9103,8 @@ static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struct bpf_re
 				     struct bpf_call_arg_meta *meta, int insn_idx);
 static bool is_kfunc_arg_nonown_allowed(const struct btf *btf,
 					const struct btf_param *arg);
+static bool is_kfunc_arg_derives_ret(const struct btf *btf,
+				     const struct btf_param *arg);
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name);
@@ -9848,6 +9856,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (reg_is_referenced(env, reg))
 		update_ref_obj(&meta->ref_obj, reg);
 
+	/* The return of a __derives_ret kfunc lives exactly as long as this argument. */
+	if (btf_arg && is_kfunc_arg_derives_ret(meta->btf, btf_arg)) {
+		meta->derives_ret.found = true;
+		meta->derives_ret.rcu = is_rcu_reg(reg);
+		meta->derives_ret.parent_id = reg_lifetime_id(env, reg);
+	}
+
 	switch (base_type(arg_type)) {
 	case ARG_CONST_SCALAR:
 		err = process_const_arg(env, reg, argno, meta);
@@ -13278,6 +13293,11 @@ static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__str");
 }
 
+static bool is_kfunc_arg_derives_ret(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__derives_ret");
+}
+
 static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
@@ -15790,14 +15810,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].type |= MEM_RDONLY;
 
 			/* Ensures we don't access the memory after a release_reference() */
-			if (meta.ref_obj.id) {
+			if (meta.derives_ret.found) {
+				regs[BPF_REG_0].parent_id = meta.derives_ret.parent_id;
+			} else if (meta.ref_obj.id) {
 				err = validate_ref_obj(env, &meta.ref_obj);
 				if (err)
 					return err;
 				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
 			}
 
-			if (is_kfunc_rcu_protected(&meta))
+			if (is_kfunc_rcu_protected(&meta) || meta.derives_ret.rcu)
 				regs[BPF_REG_0].type |= MEM_RCU;
 		} else {
 			enum bpf_reg_type type = PTR_TO_BTF_ID;
@@ -15819,6 +15841,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				 * bpf_iter_task_next).
 				 */
 				type |= MEM_RCU;
+			} else if (meta.derives_ret.rcu) {
+				/*
+				 * Derived from an RCU-protected argument, so
+				 * only valid for as long as that is.
+				 */
+				type |= MEM_RCU;
 			} else {
 				/*
 				 * Any PTR_TO_BTF_ID that is returned from a BPF
@@ -15832,6 +15860,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = type;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+			if (meta.derives_ret.found)
+				regs[BPF_REG_0].parent_id = meta.derives_ret.parent_id;
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
-- 
2.55.0

