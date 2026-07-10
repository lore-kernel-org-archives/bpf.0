Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFB2E5429
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711806; cv=none; b=mYQ6x8H/YGRV6LW0oVgH+SNWSJUzkYMlOm/O1a60h91HiK9WQPOBjHzkDlmX5VzVWwMoyuCKLNdr0hgzKAsnYbSBmjtY6ZTelPb3n/lDvGbqCVCpSYqYP8hkuIXQUPRNmBhG7x32Xi/0lW50ZcLKDAMnUnIk1XNwhWn8B4pXKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711806; c=relaxed/simple;
	bh=bETI05dEDa3EzmL9zo4TrIfhEGQ5uoRtO2bgaO+HfT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCVJWij8PvQU410e5rDmg2cDZY9T3NNYm5gh4E1o3a6HpBEsSoXNb/HiQUyYG4YwyRFep2O4KJDPPXuIjPfDktIdavzWLC8E0jI9tMHGaL6A/ux0ajqwGTtODRZ7kX6s6Qt0GRvFSi9RR+L/BAgfyCKoc5t0kZDjTwxgPHC7Hto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R1e2vQ0u; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R1e2vQ0u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783711799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxQWbYis0XSiUqKMA3uNNLF5eoMF2f8mUEQw++DxL48=;
	b=R1e2vQ0uW6XUP3lj1S1GgJBEtkcrUpxB6DlUcZDZbslVwQkFIYs2hOyTD3Cvg5aZpzbjS0
	papvHmfQO8QYxtW+SvKyIS3J2v/aWW9W+SAeyInCWwHZ5Y/m2iNBB4Oph8kBIZrXAv+Idz
	paH2SA4tV/8+KkzqKHkZ59vX9CNyAgI=
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
Subject: [PATCH bpf v2 1/2] bpf: Fix tracing of kfuncs with implicit args
Date: Fri, 10 Jul 2026 12:29:39 -0700
Message-ID: <20260710192940.3020280-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
References: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
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
  * introduce btf_kfunc_accumulated_flags() helper to read a kfunc's
    flags across all hooks, because a program attaching to a kfunc is
    not in the kfunc's call-set

btf_attach_func_proto() reads the kfunc's flags from the target's
kfunc_set_tab via btf_kfunc_accumulated_flags(). For a module BTF that
table is stable only after the module is live, so take a module
reference around the read, mirroring how the kfunc call path gates the
same lookup with btf_try_get_module().

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
 kernel/bpf/btf.c      | 20 ++++++++++++++
 kernel/bpf/verifier.c | 64 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 240401d9b25b..c52245ae0df5 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -578,6 +578,7 @@ const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
+u32 btf_kfunc_accumulated_flags(const struct btf *btf, u32 kfunc_btf_id);
 bool btf_kfunc_is_allowed(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64572f85edc8..20aeca6b4f95 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9114,6 +9114,26 @@ u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_p
 	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
 }
 
+/*
+ * Return the union of a kfunc's flags across all hooks.
+ * Unlike btf_kfunc_flags(), not restricted to a calling
+ * program's hook. Used when attaching to a kfunc for tracing.
+ */
+u32 btf_kfunc_accumulated_flags(const struct btf *btf, u32 kfunc_btf_id)
+{
+	enum btf_kfunc_hook hook;
+	u32 *hook_flags;
+	u32 flags = 0;
+
+	for (hook = 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
+		hook_flags = btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
+		if (hook_flags)
+			flags |= *hook_flags;
+	}
+
+	return flags;
+}
+
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6515d4d3c003..2f56ab8d6b58 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2584,24 +2584,24 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 
 #define KF_IMPL_SUFFIX "_impl"
 
-static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_env *env,
-						    struct btf *btf,
-						    const char *func_name)
+static const struct btf_type *
+find_kfunc_impl_proto(struct bpf_verifier_log *log, struct btf *btf, const char *func_name)
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
 
@@ -2653,7 +2653,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	 * can be found through the counterpart _impl kfunc.
 	 */
 	if (kfunc_flags && (*kfunc_flags & KF_IMPLICIT_ARGS))
-		func_proto = find_kfunc_impl_proto(env, btf, func_name);
+		func_proto = find_kfunc_impl_proto(&env->log, btf, func_name);
 	else
 		func_proto = btf_type_by_id(btf, func->type);
 
@@ -18873,6 +18873,44 @@ static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct b
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
+	u32 kfunc_flags;
+
+	func = btf_type_by_id(btf, func_id);
+	if (!func || !btf_type_is_func(func))
+		return NULL;
+
+	/*
+	 * btf_kfunc_accumulated_flags() reads kfunc_set_tab, which for a
+	 * module is stable only once it is live; hold a module ref across
+	 * the read to exclude a concurrent module load.
+	 */
+	if (btf_is_module(btf)) {
+		mod = btf_try_get_module(btf);
+		if (!mod)
+			return NULL;
+	}
+	kfunc_flags = btf_kfunc_accumulated_flags(btf, func_id);
+	module_put(mod);
+
+	if (kfunc_flags & KF_IMPLICIT_ARGS) {
+		name = btf_name_by_offset(btf, func->name_off);
+		return find_kfunc_impl_proto(log, btf, name);
+	}
+
+	return btf_type_by_id(btf, func->type);
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -19121,8 +19159,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (prog_extension &&
 		    btf_check_type_match(log, prog, btf, t))
 			return -EINVAL;
-		t = btf_type_by_id(btf, t->type);
-		if (!btf_type_is_func_proto(t))
+		t = btf_attach_func_proto(log, btf, btf_id);
+		if (!t || !btf_type_is_func_proto(t))
 			return -EINVAL;
 
 		if ((prog->aux->saved_dst_prog_type || prog->aux->saved_dst_attach_type) &&
@@ -19407,8 +19445,8 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 		return -EINVAL;
 	if (!btf_type_is_func(t))
 		return -EINVAL;
-	t = btf_type_by_id(btf, t->type);
-	if (!btf_type_is_func_proto(t))
+	t = btf_attach_func_proto(NULL, btf, btf_id);
+	if (!t || !btf_type_is_func_proto(t))
 		return -EINVAL;
 	err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
 	if (err < 0)
-- 
2.55.0

