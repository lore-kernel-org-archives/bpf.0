Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8485B4EE86D;
	Fri, 25 Sep 2026 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370883; cv=none; b=lPXCqczwIXW9KePGuqMa97XSBf58U1hn21JNifTeOZOpplMj2D9I8jPfrTWhIZWZquLnhTeYjkLhT44zBhVOg0dS9FimmNYk3PTB+PhqxBle+3g8vHiG99yFtpTYhJOHJOuQSEEw4UnJ7bYSU6vRNZ2WHjaJyN1J6VhcdLI9HNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370883; c=relaxed/simple;
	bh=4c8gfNTvvmu8jDhauf3cjWGruwkPDridKCF+wclNxOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQDOkM9xnIb8Ydn2ylVGuHw9R085ONMXfQe3Rl1Qhl3MgzWJGtvCQ+z9viDBP5tz5sYIhsYpTPvwzdlsICxttWVf7ZeeJNHkjGz4YGAgdR6iaYTBpZiBg3M4rWf8wUlthVSox/VhpyBDjuRg8OcfYLNF9cu9C6LELzmeemUCfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XCdjEETC; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XCdjEETC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790370881; x=1821906881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Te9B7qzOAJuiMtGuZMTRa1eN03dUQwGV4pthZSZfQXI=;
  b=XCdjEETCt1XTsDvUW9GWaZrLbg8wiXXcsRoStKUBdjYn55FjC0i7ys64
   6X0gAJfK2uKTzNYSCq3NNb49FToN0aaWr/hDWHXORI1lBbyZ02JAAEm1h
   2ErAZGYk9xMpQlJ0CYmO1YhyhDdONf04KIoFbE1F9oxf9q8indqylPiNm
   SSL7RlxAsBfVY31PGuAiDC7c8RyduMPwAcpTemgFmrYI26BvQ1juGruEh
   AjSoMtKRYms4bLNvpy+5x8QjsxzJTqht9pmeDPRLEJiL0PkiH2138kHYf
   54u3T1Tm3OtmfqnXlAF47lTPmg/8ytdecpWBAwtynZmsR1JZ4zNlIJ3IR
   A==;
X-CSE-ConnectionGUID: +Rtm8uoSRwWICdKPpXrg9A==
X-CSE-MsgGUID: 7wS8zI+DRqy0qoulWWBVjw==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29540548"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 21:14:41 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:19279]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.237:2525] with esmtp (Farcaster)
 id e08b429d-c2ac-46de-8476-c8e2d636a569; Fri, 25 Sep 2026 21:14:40 +0000 (UTC)
X-Farcaster-Flow-ID: e08b429d-c2ac-46de-8476-c8e2d636a569
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 21:14:40 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 21:14:40 +0000
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
Subject: [PATCH bpf-next v2 5/9] bpf: defer vmlinux kfunc and struct_ops registrations
Date: Fri, 25 Sep 2026 21:13:10 +0000
Message-ID: <20260925211314.5118-6-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is loaded on first use.  For
that to save anything, nothing may pull it in at boot.  The verifier no
longer does since the previous patches, but register_btf_kfunc_id_set(),
register_btf_id_dtor_kfuncs() and register_bpf_struct_ops() for vmlinux
run from initcalls and need the parsed BTF.

Queue them instead (btf_defer_reg()) and apply them in
btf_parse_vmlinux(), before the BTF is published, so that no program can
see a vmlinux BTF without its kfuncs and struct_ops.  Applying a
struct_ops runs its ->init(), which registers the kfunc sets of its hook;
those land back on the queue, so it is drained in a loop until a pass
adds nothing, and only then are new registrations applied directly.  The
dtor arrays are copied: every caller in the tree builds them on the stack
of its initcall.

The queue has its own lock, btf_vmlinux_regs_mutex: it is drained under
btf_vmlinux_lock, and btf_module_mutex must not nest inside that, since
purge_cand_cache() takes cand_cache_mutex under btf_module_mutex and
CO-RE takes btf_vmlinux_lock under cand_cache_mutex.

Module registrations are not queued yet; the next patch does that
together with deferring the module BTF itself.  With =y the BTF is
present from boot and nothing is queued.  Nothing here is reachable
until the Kconfig symbol becomes a tristate.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c | 207 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 04626cbd6110..aa3fdc98034b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6555,6 +6555,8 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	return ERR_PTR(err);
 }
 
+static void btf_apply_deferred_vmlinux_regs(struct btf *btf);
+
 struct btf *btf_parse_vmlinux(void)
 {
 	struct btf_verifier_env *env = NULL;
@@ -6586,7 +6588,15 @@ struct btf *btf_parse_vmlinux(void)
 		bpf_ctx_convert.t = NULL;
 		btf_free(btf);
 		btf = ERR_PTR(err);
+		goto err_out;
 	}
+
+	/*
+	 * With CONFIG_DEBUG_INFO_BTF=m, kfunc, dtor kfunc and struct_ops
+	 * registrations for vmlinux made before the BTF was available were
+	 * queued; apply them now, before the BTF becomes visible to anyone.
+	 */
+	btf_apply_deferred_vmlinux_regs(btf);
 err_out:
 	btf_verifier_env_free(env);
 	return btf;
@@ -8712,6 +8722,33 @@ enum {
 #define BTF_MODULE_NOTIFIER 1
 #endif
 
+/*
+ * CONFIG_DEBUG_INFO_BTF=m: a kfunc, dtor kfunc or struct_ops registration
+ * made while the BTF it applies to is not available yet.  Kept until the BTF
+ * arrives, see btf_defer_reg().
+ */
+enum btf_deferred_reg_kind {
+	BTF_DEFERRED_KFUNC_SET,
+	BTF_DEFERRED_DTOR_KFUNCS,
+	BTF_DEFERRED_STRUCT_OPS,
+};
+
+struct btf_deferred_reg {
+	struct list_head list;
+	enum btf_deferred_reg_kind kind;
+	union {
+		struct {
+			enum btf_kfunc_hook hook;
+			const struct btf_kfunc_id_set *kset;
+		} kfunc;
+		struct {
+			const struct btf_id_dtor_kfunc *dtors;
+			u32 cnt;
+		} dtor;
+		struct bpf_struct_ops *st_ops;
+	};
+};
+
 #ifdef BTF_MODULE_NOTIFIER
 struct btf_module {
 	struct list_head list;
@@ -9496,12 +9533,22 @@ static int btf_kfunc_id_set_add(struct btf *btf, enum btf_kfunc_hook hook,
 	return btf_populate_kfunc_set(btf, hook, kset);
 }
 
+static int btf_defer_reg(struct module *owner, const struct btf_deferred_reg *tmpl);
+
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 				       const struct btf_kfunc_id_set *kset)
 {
+	struct btf_deferred_reg tmpl = {
+		.kind = BTF_DEFERRED_KFUNC_SET,
+		.kfunc = { .hook = hook, .kset = kset },
+	};
 	struct btf *btf;
 	int ret;
 
+	ret = btf_defer_reg(kset->owner, &tmpl);
+	if (ret)
+		return ret > 0 ? 0 : ret;
+
 	btf = btf_get_module_btf(kset->owner);
 	if (!btf)
 		return check_btf_kconfigs(kset->owner, "kfunc");
@@ -9670,9 +9717,17 @@ static int btf_dtor_kfuncs_add(struct btf *btf, const struct btf_id_dtor_kfunc *
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner)
 {
+	struct btf_deferred_reg tmpl = {
+		.kind = BTF_DEFERRED_DTOR_KFUNCS,
+		.dtor = { .dtors = dtors, .cnt = add_cnt },
+	};
 	struct btf *btf;
 	int ret;
 
+	ret = btf_defer_reg(owner, &tmpl);
+	if (ret)
+		return ret > 0 ? 0 : ret;
+
 	btf = btf_get_module_btf(owner);
 	if (!btf)
 		return check_btf_kconfigs(owner, "dtor kfuncs");
@@ -10351,9 +10406,17 @@ static int btf_struct_ops_register(struct btf *btf, struct bpf_struct_ops *st_op
 
 int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 {
+	struct btf_deferred_reg tmpl = {
+		.kind = BTF_DEFERRED_STRUCT_OPS,
+		.st_ops = st_ops,
+	};
 	struct btf *btf;
 	int err;
 
+	err = btf_defer_reg(st_ops->owner, &tmpl);
+	if (err)
+		return err > 0 ? 0 : err;
+
 	btf = btf_get_module_btf(st_ops->owner);
 	if (!btf)
 		return check_btf_kconfigs(st_ops->owner, "struct_ops");
@@ -10365,8 +10428,152 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 	return err;
 }
 EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
+#elif defined(BTF_MODULE_NOTIFIER)
+static int btf_struct_ops_register(struct btf *btf, struct bpf_struct_ops *st_ops)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
+/*
+ * CONFIG_DEBUG_INFO_BTF=m: registrations for vmlinux made before its BTF is
+ * available wait in btf_vmlinux_deferred_regs until btf_parse_vmlinux()
+ * applies them.
+ */
+#ifdef BTF_MODULE_NOTIFIER
+/*
+ * The queue has its own lock: it is drained under btf_vmlinux_lock, and
+ * btf_module_mutex must not nest inside that (purge_cand_cache() takes
+ * cand_cache_mutex under btf_module_mutex, and CO-RE fetches the vmlinux
+ * BTF under cand_cache_mutex).
+ */
+static DEFINE_MUTEX(btf_vmlinux_regs_mutex);
+static LIST_HEAD(btf_vmlinux_deferred_regs);
+/* Set when the vmlinux BTF is parsed; new registrations apply directly */
+static bool btf_vmlinux_regs_closed;
+
+/*
+ * Queue @tmpl if the BTF for @owner is not available yet.  Returns 1 if the
+ * registration was queued and is to be considered done, 0 if the caller has
+ * to apply it, or -ENOMEM.  Only vmlinux registrations are queued so far.
+ */
+static int btf_defer_reg(struct module *owner, const struct btf_deferred_reg *tmpl)
+{
+	struct list_head *head = NULL;
+	struct btf_deferred_reg *reg;
+
+	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF) || owner)
+		return 0;
+
+	guard(mutex)(&btf_vmlinux_regs_mutex);
+	if (!btf_vmlinux_regs_closed)
+		head = &btf_vmlinux_deferred_regs;
+	if (!head)
+		return 0;
+
+	reg = kmemdup(tmpl, sizeof(*reg), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+	/*
+	 * kfunc id sets and struct_ops are static data of their owner, but
+	 * the dtor arrays are commonly built on the stack of the initcall.
+	 */
+	if (reg->kind == BTF_DEFERRED_DTOR_KFUNCS) {
+		reg->dtor.dtors = kmemdup_array(tmpl->dtor.dtors, tmpl->dtor.cnt,
+						sizeof(*tmpl->dtor.dtors), GFP_KERNEL);
+		if (!reg->dtor.dtors) {
+			kfree(reg);
+			return -ENOMEM;
+		}
+	}
+	list_add_tail(&reg->list, head);
+	return 1;
+}
+
+static void btf_free_deferred_reg(struct btf_deferred_reg *reg)
+{
+	if (reg->kind == BTF_DEFERRED_DTOR_KFUNCS)
+		kfree(reg->dtor.dtors);
+	kfree(reg);
+}
+
+static const char *btf_deferred_reg_name(const struct btf_deferred_reg *reg)
+{
+	switch (reg->kind) {
+	case BTF_DEFERRED_KFUNC_SET:	return "kfunc set";
+	case BTF_DEFERRED_DTOR_KFUNCS:	return "dtor kfuncs";
+	case BTF_DEFERRED_STRUCT_OPS:	return "struct_ops";
+	}
+	return "?";
+}
+
+static int btf_apply_deferred_reg(struct btf *btf, const struct btf_deferred_reg *reg)
+{
+	switch (reg->kind) {
+	case BTF_DEFERRED_KFUNC_SET:
+		return btf_kfunc_id_set_add(btf, reg->kfunc.hook, reg->kfunc.kset);
+	case BTF_DEFERRED_DTOR_KFUNCS:
+		return btf_dtor_kfuncs_add(btf, reg->dtor.dtors, reg->dtor.cnt);
+	case BTF_DEFERRED_STRUCT_OPS:
+		return btf_struct_ops_register(btf, reg->st_ops);
+	}
+	return -EINVAL;
+}
+
+/* Apply and free the registrations in @regs to @btf. */
+static void btf_apply_deferred_regs(struct btf *btf, struct list_head *regs)
+{
+	struct btf_deferred_reg *reg, *tmp;
+	int err;
+
+	list_for_each_entry_safe(reg, tmp, regs, list) {
+		err = btf_apply_deferred_reg(btf, reg);
+		if (err)
+			pr_warn("failed to register deferred %s for [%s] BTF: %d\n",
+				btf_deferred_reg_name(reg), btf->name, err);
+		list_del(&reg->list);
+		btf_free_deferred_reg(reg);
+	}
+}
+
+/*
+ * The vmlinux BTF has just been parsed; apply the registrations that waited
+ * for it.  Runs under btf_vmlinux_lock, before @btf is published, so nothing
+ * can observe a vmlinux BTF without its kfuncs and struct_ops.
+ *
+ * Applying a registration can queue further ones: a struct_ops ->init()
+ * registers the kfuncs of its hook.  Those must not go through
+ * bpf_get_btf_vmlinux() (we hold its lock), so the queue stays open until
+ * a pass applies nothing new, and only then are registrations applied directly.
+ */
+static void btf_apply_deferred_vmlinux_regs(struct btf *btf)
+{
+	LIST_HEAD(regs);
+
+	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF))
+		return;
+
+	mutex_lock(&btf_vmlinux_regs_mutex);
+	while (!list_empty(&btf_vmlinux_deferred_regs)) {
+		list_splice_init(&btf_vmlinux_deferred_regs, &regs);
+		mutex_unlock(&btf_vmlinux_regs_mutex);
+		btf_apply_deferred_regs(btf, &regs);
+		mutex_lock(&btf_vmlinux_regs_mutex);
+	}
+	btf_vmlinux_regs_closed = true;
+	mutex_unlock(&btf_vmlinux_regs_mutex);
+}
+#else
+static int btf_defer_reg(struct module *owner, const struct btf_deferred_reg *tmpl)
+{
+	return 0;
+}
+
+static void btf_apply_deferred_vmlinux_regs(struct btf *btf)
+{
+}
+#endif /* BTF_MODULE_NOTIFIER */
+
 bool btf_param_match_suffix(const struct btf *btf,
 			    const struct btf_param *arg,
 			    const char *suffix)
-- 
2.47.3

