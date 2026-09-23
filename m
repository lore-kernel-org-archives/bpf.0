Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD073C1977;
	Wed, 23 Sep 2026 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142070; cv=none; b=SRfWmAfuwiKrk/WrTl1Mfmal1exTwdd+gxTnE9EBRJSdYGURSEClBAlnc2KaaWHDFyBFYiS29QkAN746/d8d7iYu8X9M8sbNdh+xaBs7pm+Et7O5/5vmC0gIu+skBFwdfh5EgKwFUYvgxGG+s5uu8iYtxKcKt6fvd9KZkoN4rjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142070; c=relaxed/simple;
	bh=3mrZ06axOfwxF5syrWegesLOKvJNpg2qVDvYk0jNGsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c24I0nrRgM13CD+nqkFUI36LgZAAGvTaOveKJfnFfI9ZhvguPTr0cmKHu6DPYVjAZy2+Lhp9tSxyicMKOe/zVG2A4FM4ozsnuTPYAC4y7uPIXv/lJ/18BusgLLLKMsB39FxBl4Ky01EkEDKDNQIVJVh65c2+lGIrnFxTmDBp32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=O5RoG8ht; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="O5RoG8ht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790142068; x=1821678068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m57+EWci8nagxSm0zqha+4oBDWC0wPRFTb81AvfWLH0=;
  b=O5RoG8ht5CidcuK8nd679J5jpleudXpyl1wepQ0AAbTB52QSXZCO4opg
   Do2ZMKrXA/RxZse3EYZT3C80BZdV1e/DkmR/hAOG5pJc764gQLW9k4onV
   OvAJi1F1EmYfZGSMrCK+woWP8bd+KuvbrjLv7Ln3XDc2bT0RDeIlib0FG
   Q8mck9RdwFeyMXju69gal0V1uEsNTuzLr/9rqvd6mLWy3HMs64rsJwZVV
   9TMOTWq6jRCbU12AeiVGUAFeW0+elYO3gwXtzg0ifeb99eRtiOVSMuai8
   +aCLN3MUTkbp+fShmeeSN6SFaaFz0aKIwPiYDUOPXPe4gbwZ1YWodOHBt
   g==;
X-CSE-ConnectionGUID: uBpdzH8jRB+ntUvuCudFNg==
X-CSE-MsgGUID: j2KDraPMRpiavy0EO1dhBQ==
X-IronPort-AV: E=Sophos;i="6.27,117,1787011200"; 
   d="scan'208";a="29318535"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:41:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:24310]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.195:2525] with esmtp (Farcaster)
 id ff2f438e-ffd1-4b3a-87e3-1a5ba2fd6b64; Wed, 23 Sep 2026 05:41:07 +0000 (UTC)
X-Farcaster-Flow-ID: ff2f438e-ffd1-4b3a-87e3-1a5ba2fd6b64
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:41:07 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:41:07 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, "Nathan
 Chancellor" <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	<linux-kbuild@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, <linux-modules@vger.kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, <linux-kernel@vger.kernel.org>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>,
	<jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next 5/6] bpf: defer registrations until the vmlinux BTF is available
Date: Wed, 23 Sep 2026 05:39:47 +0000
Message-ID: <20260923053948.30617-6-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923053948.30617-1-wanjay@amazon.com>
References: <20260923053948.30617-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is loaded on first use.  For
that to save anything, nothing may pull it in at boot.  The verifier no
longer does since the previous patches; two things still do:

 - register_btf_kfunc_id_set(), register_btf_id_dtor_kfuncs() and
   register_bpf_struct_ops() for vmlinux run from initcalls and need the
   parsed BTF.  Queue them instead (btf_defer_reg()) and apply them in
   btf_parse_vmlinux(), before the BTF is published, so that no program
   can see a vmlinux BTF without its kfuncs and struct_ops.  Applying a
   struct_ops runs its ->init(), which registers the kfunc sets of its
   hook; those land back on the queue, so it is drained in a loop until a
   pass adds nothing, and only then are new registrations applied
   directly.  The dtor arrays are copied: every caller in the tree builds
   them on the stack of its initcall.

 - Module BTF is split BTF against the vmlinux BTF and used to be parsed
   in the module notifier.  The notifier cannot load btf_vmlinux (that
   would nest a module load in a module load), so a module loaded before
   the vmlinux BTF keeps a copy of its .BTF and .BTF.base, is exposed in
   /sys/kernel/btf right away (the raw bytes need no parsing) and gets a
   list entry with btf == NULL.  Its kfunc, dtor kfunc and struct_ops
   registrations wait on that entry.  When the vmlinux BTF arrives,
   btf_parse_deferred_modules() parses the kept copies, gives them ids
   and applies the waiting registrations; the copy is the one
   btf_parse_module() makes anyway, so the sysfs file keeps pointing at
   valid data.  Registrations are applied after dropping btf_module_mutex
   because they walk the module list (btf_check_kfunc_name()).

A module whose BTF turns out to mismatch at that point is already
running and keeps running without BTF, with a warning.  With =y such a
module would have been refused at load time unless
CONFIG_MODULE_ALLOW_BTF_MISMATCH; that check only applies to modules
loaded after the vmlinux BTF.

Walkers of the module BTF list skip entries whose BTF is not parsed yet.

With =y the BTF is present from boot, so the queues never fill and the
notifier takes the existing path.  Still nothing is reachable until the
Kconfig symbol becomes a tristate.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 include/linux/btf.h   |   5 +
 kernel/bpf/btf.c      | 426 +++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c |   9 +-
 3 files changed, 433 insertions(+), 7 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 0bf10811fe53..3b99d6386dec 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -583,6 +583,11 @@ const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 void *btf_vmlinux_data(u32 *size, bool load);
 u32 btf_vmlinux_size(void);
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+void btf_parse_deferred_modules(void);
+#else
+static inline void btf_parse_deferred_modules(void) {}
+#endif
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 50eb7a95fd82..cbba20a908e9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6551,6 +6551,8 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	return ERR_PTR(err);
 }
 
+static void btf_apply_deferred_vmlinux_regs(struct btf *btf);
+
 struct btf *btf_parse_vmlinux(void)
 {
 	struct btf_verifier_env *env = NULL;
@@ -6581,7 +6583,15 @@ struct btf *btf_parse_vmlinux(void)
 	if (err) {
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
@@ -8697,13 +8707,62 @@ enum {
 #define BTF_MODULE_NOTIFIER 1
 #endif
 
+/*
+ * CONFIG_DEBUG_INFO_BTF=m: a kfunc, dtor kfunc or struct_ops registration
+ * made while the BTF it applies to is not available yet.  Kept until the BTF
+ * arrives, see btf_defer_reg() and btf_apply_deferred_regs().
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
+	/* set while the registration is queued for a module BTF */
+	struct btf *btf;
+	struct module *module;
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
+static void btf_free_deferred_regs(struct list_head *regs);
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+static void btf_free_deferred_reg(struct btf_deferred_reg *reg);
+static void btf_apply_deferred_regs(struct list_head *regs);
+#endif
+
 struct btf_module {
 	struct list_head list;
 	struct module *module;
 	struct btf *btf;
 	struct bin_attribute *sysfs_attr;
 	int flags;
+	/*
+	 * CONFIG_DEBUG_INFO_BTF=m: a module loaded before the vmlinux BTF is
+	 * available cannot have its BTF parsed yet.  Its .BTF and .BTF.base
+	 * sections are copied here and parsed once the vmlinux BTF arrives
+	 * (btf_parse_deferred_modules()); @btf is NULL until then.
+	 * Registrations of the module's kfuncs, dtor kfuncs and struct_ops
+	 * wait in @deferred_regs.
+	 */
+	void *data;
+	void *base_data;
+	u32 data_size;
+	u32 base_data_size;
+	struct list_head deferred_regs;
 };
 
 static LIST_HEAD(btf_modules);
@@ -8747,8 +8806,14 @@ static void btf_module_free(struct btf_module *btf_mod)
 {
 	if (btf_mod->sysfs_attr)
 		sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
-	purge_cand_cache(btf_mod->btf);
-	btf_put(btf_mod->btf);
+	if (btf_mod->btf) {
+		purge_cand_cache(btf_mod->btf);
+		btf_put(btf_mod->btf);
+	} else {
+		kvfree(btf_mod->data);
+		kvfree(btf_mod->base_data);
+	}
+	btf_free_deferred_regs(&btf_mod->deferred_regs);
 	kfree(btf_mod->sysfs_attr);
 	kfree(btf_mod);
 }
@@ -8792,11 +8857,55 @@ static int btf_vmlinux_module_coming(struct module *mod)
 	smp_store_release(&btf_vmlinux_raw, data);
 	return 0;
 }
+
+/*
+ * The vmlinux BTF is not available yet and must not be loaded from the
+ * module notifier (that would nest a module load into a module load).  Keep
+ * the module's BTF for btf_parse_deferred_modules().  The .BTF data can be
+ * exposed in sysfs right away, it needs no parsing.
+ */
+static int btf_module_defer(struct btf_module *btf_mod, struct module *mod)
+{
+	int err;
+
+	btf_mod->data = kvmemdup(mod->btf_data, mod->btf_data_size,
+				 GFP_KERNEL | __GFP_NOWARN);
+	if (!btf_mod->data)
+		return -ENOMEM;
+	btf_mod->data_size = mod->btf_data_size;
+
+	if (mod->btf_base_data) {
+		btf_mod->base_data = kvmemdup(mod->btf_base_data,
+					      mod->btf_base_data_size,
+					      GFP_KERNEL | __GFP_NOWARN);
+		if (!btf_mod->base_data) {
+			kvfree(btf_mod->data);
+			return -ENOMEM;
+		}
+		btf_mod->base_data_size = mod->btf_base_data_size;
+	}
+
+	err = btf_module_sysfs_add(btf_mod, mod->name, btf_mod->data,
+				   btf_mod->data_size);
+	if (err) {
+		kvfree(btf_mod->data);
+		kvfree(btf_mod->base_data);
+		return err;
+	}
+
+	list_add(&btf_mod->list, &btf_modules);
+	return 0;
+}
 #else
 static int btf_vmlinux_module_coming(struct module *mod)
 {
 	return 0;
 }
+
+static int btf_module_defer(struct btf_module *btf_mod, struct module *mod)
+{
+	return 0;
+}
 #endif
 
 static int btf_module_notify(struct notifier_block *nb, unsigned long op,
@@ -8828,6 +8937,24 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			goto out;
 		}
 		btf_mod->module = module;
+		INIT_LIST_HEAD(&btf_mod->deferred_regs);
+
+		if (IS_MODULE(CONFIG_DEBUG_INFO_BTF)) {
+			mutex_lock(&btf_module_mutex);
+			/* Pairs with the publication in bpf_get_btf_vmlinux() */
+			if (!smp_load_acquire(&btf_vmlinux)) {
+				err = btf_module_defer(btf_mod, mod);
+				mutex_unlock(&btf_module_mutex);
+				if (err) {
+					pr_warn("failed to keep module [%s] BTF: %d\n",
+						mod->name, err);
+					kfree(btf_mod);
+					err = 0;
+				}
+				goto out;
+			}
+			mutex_unlock(&btf_module_mutex);
+		}
 
 		btf = btf_parse_module(mod->name, bpf_get_btf_vmlinux(),
 				       mod->btf_data, mod->btf_data_size, false,
@@ -8882,7 +9009,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			 * btf_try_get_module() on such BTFs will fail. This may
 			 * be called again on btf_put(), but it's ok to do so.
 			 */
-			btf_free_id(btf_mod->btf);
+			if (btf_mod->btf)
+				btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
 			btf_module_free(btf_mod);
 			break;
@@ -8905,6 +9033,87 @@ static int __init btf_module_init(void)
 }
 
 fs_initcall(btf_module_init);
+
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/*
+ * CONFIG_DEBUG_INFO_BTF=m: the vmlinux BTF has just become available.  Parse
+ * the BTF of the modules that were loaded before it, and apply the
+ * registrations that waited for them.  Called from bpf_get_btf_vmlinux()
+ * once btf_vmlinux is published, with no locks held.
+ */
+void btf_parse_deferred_modules(void)
+{
+	/* Pairs with the publication in bpf_get_btf_vmlinux() */
+	struct btf *vmlinux_btf = smp_load_acquire(&btf_vmlinux);
+	struct btf_deferred_reg *reg, *rtmp;
+	struct btf_module *btf_mod, *tmp;
+	bool parsed = false;
+	LIST_HEAD(regs);
+	struct btf *btf;
+	int err;
+
+	if (IS_ERR_OR_NULL(vmlinux_btf))
+		return;
+
+	mutex_lock(&btf_module_mutex);
+	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
+		if (btf_mod->btf)
+			continue;
+
+		btf = btf_parse_module(btf_mod->module->name, vmlinux_btf,
+				       btf_mod->data, btf_mod->data_size, true,
+				       btf_mod->base_data, btf_mod->base_data_size);
+		err = PTR_ERR_OR_ZERO(btf);
+		if (!err) {
+			err = btf_alloc_id(btf);
+			if (err) {
+				/* btf owns the data now, btf_free() drops it */
+				btf_mod->data = NULL;
+				btf_free(btf);
+			}
+		}
+		if (err) {
+			/*
+			 * The module is loaded and stays.  Unlike at load time
+			 * there is no way to reject it, so drop its BTF.
+			 */
+			pr_warn("failed to validate module [%s] BTF: %d\n",
+				btf_mod->module->name, err);
+			list_del(&btf_mod->list);
+			btf_module_free(btf_mod);
+			continue;
+		}
+
+		/* btf->data is btf_mod->data now, the sysfs file keeps working */
+		btf_mod->data = NULL;
+		kvfree(btf_mod->base_data);
+		btf_mod->base_data = NULL;
+		btf_mod->btf = btf;
+		parsed = true;
+
+		/*
+		 * Registrations are applied after dropping the mutex (they
+		 * walk btf_modules); pin what they need until then.
+		 */
+		list_for_each_entry_safe(reg, rtmp, &btf_mod->deferred_regs, list) {
+			list_del(&reg->list);
+			if (!try_module_get(btf_mod->module)) {
+				btf_free_deferred_reg(reg);
+				continue;
+			}
+			btf_get(btf);
+			reg->btf = btf;
+			reg->module = btf_mod->module;
+			list_add_tail(&reg->list, &regs);
+		}
+	}
+	mutex_unlock(&btf_module_mutex);
+
+	if (parsed)
+		purge_cand_cache(NULL);
+	btf_apply_deferred_regs(&regs);
+}
+#endif /* IS_MODULE(CONFIG_DEBUG_INFO_BTF) */
 #endif /* BTF_MODULE_NOTIFIER */
 
 struct module *btf_try_get_module(const struct btf *btf)
@@ -8957,8 +9166,11 @@ struct btf *btf_get_module_btf(const struct module *module)
 		if (btf_mod->module != module)
 			continue;
 
-		btf_get(btf_mod->btf);
-		btf = btf_mod->btf;
+		/* NULL while waiting for the vmlinux BTF (CONFIG_DEBUG_INFO_BTF=m) */
+		if (btf_mod->btf) {
+			btf_get(btf_mod->btf);
+			btf = btf_mod->btf;
+		}
 		break;
 	}
 	mutex_unlock(&btf_module_mutex);
@@ -9135,7 +9347,8 @@ static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	guard(mutex)(&btf_module_mutex);
 	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
-		if (btf_mod->btf == btf)
+		/* skip ourselves and, with CONFIG_DEBUG_INFO_BTF=m, unparsed BTF */
+		if (btf_mod->btf == btf || !btf_mod->btf)
 			continue;
 		id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
 		if (id >= 0) {
@@ -9475,12 +9688,22 @@ static int btf_kfunc_id_set_add(struct btf *btf, enum btf_kfunc_hook hook,
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
@@ -9649,9 +9872,17 @@ static int btf_dtor_kfuncs_add(struct btf *btf, const struct btf_id_dtor_kfunc *
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
@@ -10321,9 +10552,17 @@ static int btf_struct_ops_add(struct btf *btf, struct bpf_struct_ops *st_ops)
 
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
@@ -10335,8 +10574,183 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 	return err;
 }
 EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
+#else
+static int btf_struct_ops_add(struct btf *btf, struct bpf_struct_ops *st_ops)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+/*
+ * CONFIG_DEBUG_INFO_BTF=m: registrations made before the BTF they apply to
+ * is available.  Registrations for vmlinux wait in btf_vmlinux_deferred_regs
+ * until btf_parse_vmlinux() applies them; registrations for a module wait in
+ * its struct btf_module until btf_parse_deferred_modules() does.  Both lists
+ * are protected by btf_module_mutex.
+ */
+#ifdef BTF_MODULE_NOTIFIER
+static LIST_HEAD(btf_vmlinux_deferred_regs);
+/* Set when the vmlinux BTF is parsed; new registrations apply directly */
+static bool btf_vmlinux_regs_closed;
+
+/*
+ * Queue @tmpl if the BTF for @owner is not available yet.  Returns 1 if the
+ * registration was queued and is to be considered done, 0 if the caller has
+ * to apply it, or -ENOMEM.
+ */
+static int btf_defer_reg(struct module *owner, const struct btf_deferred_reg *tmpl)
+{
+	struct list_head *head = NULL;
+	struct btf_deferred_reg *reg;
+	struct btf_module *btf_mod;
+
+	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF))
+		return 0;
+
+	guard(mutex)(&btf_module_mutex);
+	if (!owner) {
+		if (!btf_vmlinux_regs_closed)
+			head = &btf_vmlinux_deferred_regs;
+	} else {
+		list_for_each_entry(btf_mod, &btf_modules, list) {
+			if (btf_mod->module != owner)
+				continue;
+			if (!btf_mod->btf)
+				head = &btf_mod->deferred_regs;
+			break;
+		}
+	}
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
+		return btf_struct_ops_add(btf, reg->st_ops);
+	}
+	return -EINVAL;
+}
+
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/* Apply and free the registrations in @regs; each is pinned to its BTF and module. */
+static void btf_apply_deferred_regs(struct list_head *regs)
+{
+	struct btf_deferred_reg *reg, *tmp;
+	int err;
+
+	list_for_each_entry_safe(reg, tmp, regs, list) {
+		err = btf_apply_deferred_reg(reg->btf, reg);
+		if (err)
+			pr_warn("failed to register deferred %s for module [%s] BTF: %d\n",
+				btf_deferred_reg_name(reg), reg->btf->name, err);
+		btf_put(reg->btf);
+		module_put(reg->module);
+		list_del(&reg->list);
+		btf_free_deferred_reg(reg);
+	}
+}
 #endif
 
+static void btf_free_deferred_regs(struct list_head *regs)
+{
+	struct btf_deferred_reg *reg, *tmp;
+
+	list_for_each_entry_safe(reg, tmp, regs, list) {
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
+	struct btf_deferred_reg *reg, *tmp;
+	LIST_HEAD(regs);
+	int err;
+
+	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF))
+		return;
+
+	mutex_lock(&btf_module_mutex);
+	while (!list_empty(&btf_vmlinux_deferred_regs)) {
+		list_splice_init(&btf_vmlinux_deferred_regs, &regs);
+		mutex_unlock(&btf_module_mutex);
+
+		list_for_each_entry_safe(reg, tmp, &regs, list) {
+			err = btf_apply_deferred_reg(btf, reg);
+			if (err)
+				pr_warn("failed to register deferred %s for vmlinux BTF: %d\n",
+					btf_deferred_reg_name(reg), err);
+			list_del(&reg->list);
+			btf_free_deferred_reg(reg);
+		}
+
+		mutex_lock(&btf_module_mutex);
+	}
+	btf_vmlinux_regs_closed = true;
+	mutex_unlock(&btf_module_mutex);
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7b73bc146a8..b6f094d5306a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21160,12 +21160,14 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 /*
  * Returns the parsed vmlinux BTF, NULL if the kernel has none, or an ERR_PTR
  * if it is malformed.  With CONFIG_DEBUG_INFO_BTF=m the BTF lives in the
- * btf_vmlinux module; the first caller loads it and parses it.  May sleep.
+ * btf_vmlinux module; the first caller loads it, parses it and then registers
+ * the BTF of the modules that were loaded before it.  May sleep.
  */
 struct btf *bpf_get_btf_vmlinux(void)
 {
 	/* Pairs with the smp_store_release() on the parse path below. */
 	struct btf *btf = smp_load_acquire(&btf_vmlinux);
+	bool parsed = false;
 	u32 size;
 
 	if (btf || !IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
@@ -21190,8 +21192,13 @@ struct btf *bpf_get_btf_vmlinux(void)
 		 * on the lockless fast path above.
 		 */
 		smp_store_release(&btf_vmlinux, btf);
+		parsed = true;
 	}
 	mutex_unlock(&btf_vmlinux_lock);
+
+	if (parsed && IS_MODULE(CONFIG_DEBUG_INFO_BTF))
+		btf_parse_deferred_modules();
+
 	return btf;
 }
 
-- 
2.47.3

