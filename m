Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A173388390
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783986763; cv=none; b=HkbJ0MaU5TQQoqcwP0MxR2UC8msUwMFfXFq9ZTwDJf63zfnyC+w17xLDUoq6WejR5BOnb4N+g+AZ5HwO7HPsMd0T83Q20IJ1nwDjBrW1KLnUS9JGppHMkVXEyzQAKZT/ESRg/fBJZH1x4ZXJekOS0lSEJ6XM/QCPlxgf1qHtCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783986763; c=relaxed/simple;
	bh=K5nfJZKfz1nhLlF5uZiseGskPTi/Zt7/3s7Cng8pO/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRHRDkODnC+wm2S99EekfnrbJygM886mGyYiX4Ce2K2LY6KRa/MQ1bEIxXkSxELZ5xYYrotYY3HH53zf1opHDMgFTYgmvdxpm3t5ujgdrdcqSQyfbBPELq52eB1Ft1fn8c490nLg9KYGOIM43iG8nkYdfkHdL/PPjgrK+ItaVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lmCXxbTK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lmCXxbTK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783986759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VurXxk2cP482r1ak/cF4fZkLgK/+UDaIRsGeJUyNss=;
	b=lmCXxbTK4dPOH+QNrXYFg5+RQo/Kk95DXT2OXYJg2hOzpv567SNz+P9v+z7bUm/rm6FfHN
	o72MDvtH49azgCdcaIDRWp+ufBwXCC3zMpa0VGfETRu28MkFw7tymKHXhNVn8HlYH1J56O
	S1ckriAC7x5AasIEHPkgG7Kqr+Mzn2g=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v3 1/2] bpf: Fix tracing of kfuncs with implicit args
Date: Mon, 13 Jul 2026 16:52:22 -0700
Message-ID: <20260713235223.1639022-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260713235223.1639022-1-ihor.solodrai@linux.dev>
References: <20260713235223.1639022-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A kfunc marked with KF_IMPLICIT_ARGS flag takes implicit arguments
(such as bpf_prog_aux) that the verifier injects at load time.
resolve_btfids strips those from the kfunc's BTF-visible prototype and
keeps the real kernel ABI in a counterpart _impl prototype [1].

fentry/fexit/fmod_ret/fsession programs may attach to the BPF kernel
functions, including those with implicit args. However
bpf_check_attach_target() and bpf_check_attach_btf_id_multi() extract
the struct btf_func_model from the wrong BTF prototype of the
kfunc. The btf_func_model is later read to construct the trampoline,
which then causes the injected implicit argument to be clobbered and
the kfunc dereferencing garbage.

Add btf_attach_func_proto() to resolve the real ABI prototype of the
kfunc the way the call site does: by looking up the _impl prototype
for a KF_IMPLICIT_ARGS kfunc. Use it at both attach-target model
construction sites.

To enable this, make two supporting changes:
  * pass bpf_verifier_log instead of bpf_verifier_env to
    find_kfunc_impl_proto(), so it can be reused from the attach path
  * add btf_kfunc_check_flag() to test a flag across all of a kfunc's
    hook sets, because a program attaching to a kfunc is not in the
    kfunc's call-set

KF_IMPLICIT_ARGS must be consistent across the sets, so
btf_kfunc_check_flag() returns -EINVAL on inconsistency.

btf_kfunc_check_flag() reads the kfunc's flags from the target's
kfunc_set_tab. For a module BTF that table is stable only after the
module is live, so take a module reference around the read, mirroring
how the kfunc call path gates the same lookup with btf_try_get_module().

The remaining call sites of btf_distill_func_proto() are safe as
is. The BPF_TRACE_ITER case distills a registered iterator's
prototype, and bpf_struct_ops_desc_init() distills the
function-pointer members of a struct_ops type. Neither is a kfunc, and
so can't have implicit arguments.

[1] https://lore.kernel.org/all/20260120222638.3976562-1-ihor.solodrai@linux.dev/

Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://github.com/sched-ext/scx/issues/3687#issuecomment-4906694106
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/btf.c      | 29 +++++++++++++++++++
 kernel/bpf/verifier.c | 66 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 240401d9b25b..c09b7994de4e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -578,6 +578,7 @@ const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
+int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag);
 bool btf_kfunc_is_allowed(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64572f85edc8..c4673a54c4ba 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9114,6 +9114,35 @@ u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_p
 	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
 }
 
+/*
+ * Check a single KF_* @flag on a kfunc across all of its hook sets.
+ * Returns:
+ *   * 1 if @flag is set
+ *   * 0 if @flag is not set
+ *   * -EINVAL if @flag is set inconsistently across the sets
+ *   * -ENOENT if kfunc_btf_id is not a registered kfunc
+ */
+int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag)
+{
+	enum btf_kfunc_hook hook;
+	int res = -ENOENT;
+	bool is_set;
+	u32 *flags;
+
+	for (hook = 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
+		flags = btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
+		if (!flags)
+			continue;
+		is_set = *flags & flag;
+		if (res < 0)
+			res = is_set;
+		else if (res != is_set)
+			return -EINVAL;
+	}
+
+	return res;
+}
+
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6515d4d3c003..5d47f58dbe13 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2584,24 +2584,25 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 
 #define KF_IMPL_SUFFIX "_impl"
 
-static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_env *env,
+static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_log *log,
 						    struct btf *btf,
 						    const char *func_name)
 {
-	char *buf = env->tmp_str_buf;
 	const struct btf_type *func;
+	char buf[KSYM_NAME_LEN];
 	s32 impl_id;
 	int len;
 
-	len = snprintf(buf, TMP_STR_BUF_LEN, "%s%s", func_name, KF_IMPL_SUFFIX);
-	if (len < 0 || len >= TMP_STR_BUF_LEN) {
-		verbose(env, "function name %s%s is too long\n", func_name, KF_IMPL_SUFFIX);
+	len = snprintf(buf, sizeof(buf), "%s%s", func_name, KF_IMPL_SUFFIX);
+	if (len < 0 || len >= sizeof(buf)) {
+		bpf_log(log, "function name %s%s is too long\n",
+			func_name, KF_IMPL_SUFFIX);
 		return NULL;
 	}
 
 	impl_id = btf_find_by_name_kind(btf, buf, BTF_KIND_FUNC);
 	if (impl_id <= 0) {
-		verbose(env, "cannot find function %s in BTF\n", buf);
+		bpf_log(log, "cannot find function %s in BTF\n", buf);
 		return NULL;
 	}
 
@@ -2653,7 +2654,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	 * can be found through the counterpart _impl kfunc.
 	 */
 	if (kfunc_flags && (*kfunc_flags & KF_IMPLICIT_ARGS))
-		func_proto = find_kfunc_impl_proto(env, btf, func_name);
+		func_proto = find_kfunc_impl_proto(&env->log, btf, func_name);
 	else
 		func_proto = btf_type_by_id(btf, func->type);
 
@@ -18873,6 +18874,47 @@ static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct b
 	return -EINVAL;
 }
 
+/*
+ * Resolve the prototype describing a trace target's real ABI. A
+ * KF_IMPLICIT_ARGS kfunc has its injected args stripped from the public
+ * prototype, so use the _impl prototype; other targets use their own.
+ */
+static const struct btf_type *
+btf_attach_func_proto(struct bpf_verifier_log *log, struct btf *btf, u32 func_id)
+{
+	const struct btf_type *func;
+	struct module *mod = NULL;
+	const char *name;
+	int implicit;
+
+	func = btf_type_by_id(btf, func_id);
+	if (!func || !btf_type_is_func(func))
+		return NULL;
+	name = btf_name_by_offset(btf, func->name_off);
+
+	/*
+	 * btf_kfunc_check_flag() reads kfunc_set_tab, which for a module is
+	 * stable only once it is live; hold a module ref across the read to
+	 * exclude a concurrent module load.
+	 */
+	if (btf_is_module(btf)) {
+		mod = btf_try_get_module(btf);
+		if (!mod)
+			return NULL;
+	}
+	implicit = btf_kfunc_check_flag(btf, func_id, KF_IMPLICIT_ARGS);
+	module_put(mod);
+
+	if (implicit == -EINVAL) {
+		bpf_log(log, "kfunc %s has inconsistent KF_IMPLICIT_ARGS\n", name);
+		return NULL;
+	}
+	if (implicit > 0)
+		return find_kfunc_impl_proto(log, btf, name);
+
+	return btf_type_by_id(btf, func->type);
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -19121,8 +19163,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (prog_extension &&
 		    btf_check_type_match(log, prog, btf, t))
 			return -EINVAL;
-		t = btf_type_by_id(btf, t->type);
-		if (!btf_type_is_func_proto(t))
+		t = btf_attach_func_proto(log, btf, btf_id);
+		if (!t || !btf_type_is_func_proto(t))
 			return -EINVAL;
 
 		if ((prog->aux->saved_dst_prog_type || prog->aux->saved_dst_attach_type) &&
@@ -19405,10 +19447,8 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 	tname = btf_name_by_offset(btf, t->name_off);
 	if (!tname)
 		return -EINVAL;
-	if (!btf_type_is_func(t))
-		return -EINVAL;
-	t = btf_type_by_id(btf, t->type);
-	if (!btf_type_is_func_proto(t))
+	t = btf_attach_func_proto(NULL, btf, btf_id);
+	if (!t || !btf_type_is_func_proto(t))
 		return -EINVAL;
 	err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
 	if (err < 0)
-- 
2.55.0

