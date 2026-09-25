Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2693F7AA8;
	Fri, 25 Sep 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370852; cv=none; b=LyrlhJeoWSflLtdTRrvaC1pFTNepuUhg3FnVrJ4/w+HlzDiRuNL1ubsReePUdMHWa0Hw+/e08yFIpYCkpVNOOay8lQMRy5D75jBG9whFodjFkQJYrByyAuDGoBbl9m5LT5fzEPSRmAcOZ8Ea52CxzrANMjjlzbHWvxmjAotebDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370852; c=relaxed/simple;
	bh=/UXTztMA8II7K6+l58V6nuq5UvKa8ctF7hM7QXsAFQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POH96iY9OKgb2+QeUd30lHjPaH/UCGh1RGgpTyjDPihxJoir2/qZI0gpXuaA2l7Q0xFfv/kfgz+gmBX0wzRcQBcYK1t8Khaq3KSBeuymCPezzeerDtReWaBdtQ3xnaOxovTzAAovH0nLjweuNu79Z1L6jQwEkWTIVjvYHOTFnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PoNVrxjl; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PoNVrxjl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790370850; x=1821906850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRDSOneKtAVPphTNoBxzCkol/+cHYxEEXA2oeUAGQAY=;
  b=PoNVrxjl3mq+nceS0Fk1iCr/inbc4yxNAhbd4K1D9/nvctk89364XCJX
   LfTnSziDksHPpTVkS6rnC2nx4by7bQYNFa7D7tNypRmm40M/3819ybUXh
   pinfFabohO9Hw3uqIJuCyCXP0E+BosmaZ8iqkDv4OPIaOzc4q4ln8YAuc
   2pq+WYcnGH8ZG+rxM6AQ4aFR/FQo4NgpbwrTjhAWo/UGD5wROcC2KwfwP
   WY7XpWCTL2/Zvp7FdGb3+xVeEJGnlGiqFy1BR+CHWtcT5cdSp/lXdEzrK
   SgHjZ3MLaUB/dDVu0WZDNpSl+0srdBhtXl8lVWiyRqgOSth+j9bjBXmtf
   Q==;
X-CSE-ConnectionGUID: 0loBDvVBRC2/0EGmabmKXw==
X-CSE-MsgGUID: 4vQDf14QTAGESLban3RTww==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29701474"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 21:14:09 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:2481]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.27:2525] with esmtp (Farcaster)
 id 7e2cb21f-3828-4d46-a5c1-6c59e99b3852; Fri, 25 Sep 2026 21:14:09 +0000 (UTC)
X-Farcaster-Flow-ID: 7e2cb21f-3828-4d46-a5c1-6c59e99b3852
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 21:14:09 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 21:14:09 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
	<nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, Luis Chamberlain
	<mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	<linux-modules@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>, Martin Pohlack
	<mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next v2 3/9] bpf: fetch the vmlinux BTF where kernel types enter a program
Date: Fri, 25 Sep 2026 21:13:08 +0000
Message-ID: <20260925211314.5118-4-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925211314.5118-1-wanjay@amazon.com>
References: <20260925211314.5118-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

bpf_check() fetches the vmlinux BTF up front for every program, whether
the program uses kernel types or not.  With the upcoming
CONFIG_DEBUG_INFO_BTF=m that fetch loads a module and parses 5 MiB of
BTF, and since systemd loads socket filters at boot, it would happen on
every system, whether anything uses BTF or not.

Stop fetching up front and fetch at the points where kernel types enter
the verifier state instead:

 - bpf_add_kfunc_call(), for the first kfunc call of a program;
 - check_pseudo_btf_id(), for ldimm64 of a kernel variable;
 - check_ptr_to_map_access(), for accessing a map pointer's fields;
 - check_helper_call(), when the helper's prototype takes or returns a
   PTR_TO_BTF_ID, or is bpf_snprintf_btf()/bpf_seq_printf_btf(), which
   take the kernel type id inside a struct btf_ptr instead
   (helper_uses_vmlinux_btf());
 - the program context type table, bpf_ctx_convert, which
   btf_parse_vmlinux() fills in: global subprograms taking the context
   (btf_prepare_func_args()) and context access of tracing and EXT
   programs (btf_translate_to_vmlinux()) go through it, so its readers
   fetch the BTF (bpf_ctx_convert_type());
 - CO-RE candidate lookup (bpf_core_apply(), btf_get_ptr_to_btf_id()),
   which fetches before taking cand_cache_mutex, so that loading the
   BTF never happens under that mutex; bpf_core_find_cands() itself
   only peeks.

Together with the existing fetch in bpf_prog_load() for attach_btf and
the struct_ops map creation, every way kernel types enter a program
goes through one of these sites.  A program that uses none of them,
such as a socket filter, no longer touches the vmlinux BTF.

The two callers that used the result of bpf_get_btf_vmlinux() without
checking it, btf_prepare_func_args() and btf_check_kfunc_name(), now do.

bpf_snprintf_btf() and bpf_seq_printf_btf() run in program context and
cannot afford a fetch that may sleep.  Add bpf_peek_btf_vmlinux(), which
returns the parsed vmlinux BTF or NULL without parsing anything, and use
it there; the helpers fail with -EINVAL if the BTF is not parsed, as they
do on a kernel without BTF.

With CONFIG_DEBUG_INFO_BTF=y the vmlinux BTF is parsed at boot by the
first kfunc registration, and without BTF the new helper check is
skipped, so nothing changes for either.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/btf.c         | 56 ++++++++++++++++++++++++++++++-----
 kernel/bpf/verifier.c    | 64 +++++++++++++++++++++++++++++++++++-----
 kernel/trace/bpf_trace.c |  3 +-
 4 files changed, 108 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e7c5e203eddd..a3c4caad5dfc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3165,6 +3165,7 @@ static inline s32 bpf_call_args_imm(s16 idx)
 #endif
 
 struct btf *bpf_get_btf_vmlinux(void);
+struct btf *bpf_peek_btf_vmlinux(void);
 
 /* Map specifics */
 struct xdp_frame;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ae28d23d678b..bb33c0594091 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6126,12 +6126,25 @@ static u8 bpf_ctx_convert_map[] = {
 #undef BPF_MAP_TYPE
 #undef BPF_LINK_TYPE
 
+/*
+ * bpf_ctx_convert.t is filled in by btf_parse_vmlinux().  With
+ * CONFIG_DEBUG_INFO_BTF=m that may not have run yet: the program context
+ * types are kernel types too, so this is one of the places that loads the
+ * vmlinux BTF.  Only called from the verifier, which may sleep.
+ */
+static const struct btf_type *bpf_ctx_convert_type(void)
+{
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux()))
+		return NULL;
+	return bpf_ctx_convert.t;
+}
+
 static const struct btf_type *find_canonical_prog_ctx_type(enum bpf_prog_type prog_type)
 {
 	const struct btf_type *conv_struct;
 	const struct btf_member *ctx_type;
 
-	conv_struct = bpf_ctx_convert.t;
+	conv_struct = bpf_ctx_convert_type();
 	if (!conv_struct)
 		return NULL;
 	/* prog_type is valid bpf program type. No need for bounds check. */
@@ -6147,7 +6160,7 @@ static int find_kern_ctx_type_id(enum bpf_prog_type prog_type)
 	const struct btf_type *conv_struct;
 	const struct btf_member *ctx_type;
 
-	conv_struct = bpf_ctx_convert.t;
+	conv_struct = bpf_ctx_convert_type();
 	if (!conv_struct)
 		return -EFAULT;
 	/* prog_type is valid bpf program type. No need for bounds check. */
@@ -6406,7 +6419,11 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 	const struct btf_type *kctx_type;
 	u32 kctx_type_id;
 
-	conv_struct = bpf_ctx_convert.t;
+	conv_struct = bpf_ctx_convert_type();
+	if (!conv_struct) {
+		bpf_log(log, "btf_vmlinux is malformed\n");
+		return -EINVAL;
+	}
 	/* get member for kernel ctx type */
 	kctx_member = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2 + 1;
 	kctx_type_id = kctx_member->type;
@@ -7884,6 +7901,13 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
 		t = btf_type_by_id(btf, t->type);
 	}
 
+	/* candidates are kernel types: load the vmlinux BTF, outside the mutex */
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
+		bpf_log(log, "arg#%d reference type('%s %s') needs the vmlinux BTF\n",
+			arg_idx, btf_type_str(t), __btf_name_by_offset(btf, t->name_off));
+		return -EINVAL;
+	}
+
 	mutex_lock(&cand_cache_mutex);
 	cc = bpf_core_find_cands(&ctx, type_id);
 	if (IS_ERR(cc)) {
@@ -8235,7 +8259,10 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			if (kern_type_id < 0)
 				return kern_type_id;
 
+			/* present: btf_get_ptr_to_btf_id() found the candidate in it */
 			vmlinux_btf = bpf_get_btf_vmlinux();
+			if (IS_ERR_OR_NULL(vmlinux_btf))
+				return -EINVAL;
 			ref_t = btf_type_by_id(vmlinux_btf, kern_type_id);
 			if (!btf_type_is_struct(ref_t)) {
 				tname = __btf_name_by_offset(vmlinux_btf, t->name_off);
@@ -8973,12 +9000,18 @@ static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;
 #endif
+	struct btf *vmlinux_btf;
 	s32 id;
 
 	if (!btf_is_module(btf))
 		return 0;
 
-	id = btf_find_by_name_kind(bpf_get_btf_vmlinux(), func_name, kind);
+	/* a module BTF only exists once the vmlinux BTF is parsed */
+	vmlinux_btf = bpf_get_btf_vmlinux();
+	if (IS_ERR_OR_NULL(vmlinux_btf))
+		return -EINVAL;
+
+	id = btf_find_by_name_kind(vmlinux_btf, func_name, kind);
 	if (id >= 0) {
 		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
 		       func_name, id);
@@ -9778,9 +9811,11 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 	const char *name;
 	int id;
 
-	main_btf = bpf_get_btf_vmlinux();
-	if (IS_ERR(main_btf))
-		return ERR_CAST(main_btf);
+	/*
+	 * Callers fetch the vmlinux BTF before taking cand_cache_mutex, so
+	 * that loading it (CONFIG_DEBUG_INFO_BTF=m) happens outside the lock.
+	 */
+	main_btf = bpf_peek_btf_vmlinux();
 	if (!main_btf)
 		return ERR_PTR(-EINVAL);
 
@@ -9883,6 +9918,13 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		struct bpf_cand_cache *cc;
 		int i;
 
+		/* candidates are kernel types: load the vmlinux BTF, outside the mutex */
+		if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
+			bpf_log(ctx->log, "relo #%u: needs the vmlinux BTF\n", relo_idx);
+			kfree(specs);
+			return -EINVAL;
+		}
+
 		mutex_lock(&cand_cache_mutex);
 		cc = bpf_core_find_cands(ctx, relo->type_id);
 		if (IS_ERR(cc)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7c9e2d8965d..f02ecb0dae75 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2873,7 +2873,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	tab = prog_aux->kfunc_tab;
 	btf_tab = prog_aux->kfunc_btf_tab;
 	if (!tab) {
-		if (!btf_vmlinux) {
+		/* with CONFIG_DEBUG_INFO_BTF=m this is where the vmlinux BTF gets loaded */
+		if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
 			verbose(env, "calling kernel function is not supported without CONFIG_DEBUG_INFO_BTF\n");
 			return -ENOTSUPP;
 		}
@@ -6257,7 +6258,8 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 	u32 btf_id;
 	int ret;
 
-	if (!btf_vmlinux) {
+	/* with CONFIG_DEBUG_INFO_BTF=m this is where the vmlinux BTF gets loaded */
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
 		verbose(env, "map_ptr access not supported without CONFIG_DEBUG_INFO_BTF\n");
 		return -ENOTSUPP;
 	}
@@ -11568,6 +11570,24 @@ static int release_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	return err;
 }
 
+/* Does calling helper @func_id bring kernel BTF types into the program? */
+static bool helper_uses_vmlinux_btf(enum bpf_func_id func_id,
+				    const struct bpf_func_proto *fn)
+{
+	int i;
+
+	/* these take the kernel type id in a struct btf_ptr, not in a register */
+	if (func_id == BPF_FUNC_snprintf_btf || func_id == BPF_FUNC_seq_printf_btf)
+		return true;
+	if (base_type(fn->ret_type) == RET_PTR_TO_BTF_ID)
+		return true;
+	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
+			return true;
+	}
+	return false;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -11637,6 +11657,18 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
+	/*
+	 * Helpers that take or return kernel BTF pointers need the vmlinux
+	 * BTF; with CONFIG_DEBUG_INFO_BTF=m this is where it gets loaded.
+	 * Without CONFIG_DEBUG_INFO_BTF they keep failing as they always did.
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF) && helper_uses_vmlinux_btf(func_id, fn) &&
+	    IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
+		verbose(env, "helper %s#%d is not supported without vmlinux BTF\n",
+			func_id_name(func_id), func_id);
+		return -ENOTSUPP;
+	}
+
 	if (fn->might_sleep && !in_sleepable_context(env)) {
 		verbose(env, "sleepable helper %s#%d in %s\n", func_id_name(func_id), func_id,
 			non_sleepable_context_description(env));
@@ -19235,12 +19267,13 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 	} else {
-		if (!btf_vmlinux) {
+		/* with CONFIG_DEBUG_INFO_BTF=m this is where the vmlinux BTF gets loaded */
+		btf = bpf_get_btf_vmlinux();
+		if (IS_ERR_OR_NULL(btf)) {
 			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
 			return -EINVAL;
 		}
-		btf_get(btf_vmlinux);
-		btf = btf_vmlinux;
+		btf_get(btf);
 	}
 
 	err = __check_pseudo_btf_id(env, insn, aux, btf);
@@ -21153,6 +21186,17 @@ struct btf *bpf_get_btf_vmlinux(void)
 	return btf;
 }
 
+/*
+ * The vmlinux BTF if it has been parsed already, else NULL.  Unlike
+ * bpf_get_btf_vmlinux() this never loads or parses anything, so it is safe
+ * to call from a running BPF program.
+ */
+struct btf *bpf_peek_btf_vmlinux(void)
+{
+	/* Pairs with the smp_store_release() in bpf_get_btf_vmlinux() */
+	return smp_load_acquire(&btf_vmlinux);
+}
+
 /*
  * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
  * this case expect that every file descriptor in the array is either a map or
@@ -21724,7 +21768,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret)
 		goto err_prep;
 
-	bpf_get_btf_vmlinux();
+	/*
+	 * The vmlinux BTF is not fetched up front: with CONFIG_DEBUG_INFO_BTF=m
+	 * it is loaded on demand, at the points where kernel types enter the
+	 * program (attach_btf, kfuncs, ksyms, map pointers, BTF-typed helpers).
+	 */
 
 	/* Serialize verification of unprivileged programs. */
 	if (!is_priv)
@@ -21745,10 +21793,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 
 	mark_verifier_state_clean(env);
 
-	if (IS_ERR(btf_vmlinux)) {
+	if (IS_ERR(bpf_peek_btf_vmlinux())) {
 		/* Either gcc or pahole or kernel are broken. */
 		verbose(env, "in-kernel BTF is malformed\n");
-		ret = PTR_ERR(btf_vmlinux);
+		ret = PTR_ERR(bpf_peek_btf_vmlinux());
 		goto skip_full_check;
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 195f78db9bda..c022b2877f0b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1015,7 +1015,8 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
 	if (btf_ptr_size != sizeof(struct btf_ptr))
 		return -EINVAL;
 
-	*btf = bpf_get_btf_vmlinux();
+	/* Called from a running program: only use the BTF if it is parsed. */
+	*btf = bpf_peek_btf_vmlinux();
 
 	if (IS_ERR_OR_NULL(*btf))
 		return IS_ERR(*btf) ? PTR_ERR(*btf) : -EINVAL;
-- 
2.47.3

