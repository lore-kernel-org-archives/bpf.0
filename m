Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1534779A1;
	Fri, 25 Sep 2026 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376246; cv=none; b=E7L3vt1TB4d/K+H7L2ToZhHnGP0Czzw+UCruy2FPuBX0vHzEghsB0fOebYOfm95MxJmBD4tE/XIlXbpes2exhu87G9yZzHc+2whwHH6b/YSqu63988/HCyGZmXP2NFvNnLE5GaMj/l2osK4uzTU7DPZi00rTEmD6VHb/SFfCmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376246; c=relaxed/simple;
	bh=sj5RNaT7+ccYGcmoBdSrZ3CTRKqj46k95TJG3zQXJ0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRLdv9PeEdwllBNAL8w973u7WBhul/MWv3SdbA2JrtaPzXD9CMUrPkEJnaN7Hw2HhyUaM0uUwh1Xarzj84ndjSnh81OBmipG6RNtD4TgFXF5jx0qzBzbYoop2mOKS4b9NKisbsCbRKaQ2rFRQPuGUYunHbhDwN5NQpeMCfMBDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bACMWOFQ; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bACMWOFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790376244; x=1821912244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PswlTvOqKinHpvxN4eGk2lMowDjYCSTTV0FuztYmcSI=;
  b=bACMWOFQCorZCMNaEI3O8nNQle0yUVtaGFJ/uTGFUFRJS/NPIsUPVUc9
   wL2ve3cyU0eV7+ZMDuRLJRTCVzVqo1zwBkGJBR3xMNXEu0aYwVPbgcs9A
   3UJauY7fWJT6m/LXD7q2WeHGe3mjal2M9ggPE/n7euplPtxJGLl6RempU
   T66FYSETCTi5Ws5/iSjzw+6aY+Q0Tg55YwAgLeWC/rrwu0hjPSarUAKP5
   uWR0LvoR3jTs/XubGEph7rAXglsuYINgBkM0xxqyxTrHI2+KLtDCT6Mnr
   WmisFjsx/b2Oog3+phNiHdsuyzLjeGyqH3YHTcg+Qh35UKOq7bP/jfVLF
   A==;
X-CSE-ConnectionGUID: LnwdrDhRQIS3XmehYfQxpA==
X-CSE-MsgGUID: R/fOgX4WRRuaqGrTwOTjNQ==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29665544"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 22:44:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:4586]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.144:2525] with esmtp (Farcaster)
 id 70557bb2-f3cd-4738-b231-52af6f9f6bd1; Fri, 25 Sep 2026 22:44:03 +0000 (UTC)
X-Farcaster-Flow-ID: 70557bb2-f3cd-4738-b231-52af6f9f6bd1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 22:44:03 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 22:44:03 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
	<nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, Luis Chamberlain
	<mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
	<samitolvanen@google.com>, <linux-modules@vger.kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, <linux-kernel@vger.kernel.org>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>, Martin Pohlack
	<mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next v3 6/9] bpf: keep module BTF until the vmlinux BTF is available
Date: Fri, 25 Sep 2026 22:42:26 +0000
Message-ID: <20260925224229.1850-7-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925224229.1850-1-wanjay@amazon.com>
References: <20260925224229.1850-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Module BTF is split BTF against the vmlinux BTF and is parsed in the
module notifier.  With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF may not be
loaded yet when a module loads, and the notifier cannot load btf_vmlinux
(that would nest a module load in a module load).

So a module loaded before the vmlinux BTF keeps a copy of its .BTF and
.BTF.base and gets a list entry with btf == NULL; its kfunc, dtor kfunc
and struct_ops registrations wait on that entry.  Without a .BTF.base
the data is final and is exposed in /sys/kernel/btf right away (the raw
bytes need no parsing); with one, parsing relocates the data in place,
so its file is created once parsed, as with =y.  The next patch creates
that file earlier.

When the vmlinux BTF arrives, btf_parse_deferred_modules() parses the
kept copies (the copy is the one btf_parse_module() makes anyway, so an
existing sysfs file keeps pointing at valid data), applies the waiting
registrations and only then publishes the BTF with an id, so nobody sees
a module BTF without its kfuncs.  Applying walks the module list
(btf_check_kfunc_name()) and so happens with btf_module_mutex dropped
and the module pinned.  A module that is still initializing when the
vmlinux BTF arrives is only published; its init is still queueing
registrations, and MODULE_STATE_LIVE applies them once init is done,
which also keeps a module whose init fails from being touched after it
is freed.

A module whose BTF turns out to mismatch at that point is already
running and keeps running without BTF, with a warning; its entry stays,
dead, until the module goes, and keeps the raw data a sysfs file may
serve.  With =y such a module would have been refused at load time
unless CONFIG_MODULE_ALLOW_BTF_MISMATCH; that check only applies to
modules loaded after the vmlinux BTF.

Walkers of the module BTF list skip entries whose BTF is not parsed yet.
With =y the BTF is present from boot and the notifier takes the existing
path.  Still nothing is reachable until the Kconfig symbol becomes a
tristate.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 include/linux/btf.h   |   5 +
 kernel/bpf/btf.c      | 267 +++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c |   9 +-
 3 files changed, 262 insertions(+), 19 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 81e6c65fe5f6..fea60e36edba 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -603,6 +603,11 @@ const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 void *btf_vmlinux_data(u32 *size, bool load);
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+void btf_parse_deferred_modules(void);
+#else
+static inline void btf_parse_deferred_modules(void) {}
+#endif
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 207954b5754a..1dae1c9b53fe 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9077,7 +9077,7 @@ enum {
 /*
  * CONFIG_DEBUG_INFO_BTF=m: a kfunc, dtor kfunc or struct_ops registration
  * made while the BTF it applies to is not available yet.  Kept until the BTF
- * arrives, see btf_defer_reg().
+ * arrives, see btf_defer_reg() and btf_apply_deferred_regs().
  */
 enum btf_deferred_reg_kind {
 	BTF_DEFERRED_KFUNC_SET,
@@ -9102,12 +9102,30 @@ struct btf_deferred_reg {
 };
 
 #ifdef BTF_MODULE_NOTIFIER
+static void btf_free_deferred_regs(struct list_head *regs);
+static void btf_apply_deferred_regs(struct btf *btf, struct list_head *regs);
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
+	/* the kept BTF turned out unusable; the entry stays until the module goes */
+	bool gone;
 };
 
 static LIST_HEAD(btf_modules);
@@ -9151,8 +9169,14 @@ static void btf_module_free(struct btf_module *btf_mod)
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
@@ -9196,11 +9220,53 @@ static int btf_vmlinux_module_coming(struct module *mod)
 	smp_store_release(&btf_vmlinux_raw, data);
 	return 0;
 }
+
+/*
+ * The vmlinux BTF is not available yet and must not be loaded from the
+ * module notifier (that would nest a module load into a module load).  Keep
+ * the module's BTF for btf_parse_deferred_modules().
+ *
+ * Without a .BTF.base section the .BTF data is final and can be exposed in
+ * sysfs right away, it needs no parsing.  With one, parsing relocates the
+ * data in place against the vmlinux BTF, so the file is created afterwards,
+ * as with =y where it also only appears once the BTF is parsed.
+ */
+static int btf_module_defer(struct btf_module *btf_mod, struct module *mod)
+{
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
+	} else {
+		/* not fatal, the module BTF is usable without the sysfs file */
+		btf_module_sysfs_add(btf_mod, mod->name, btf_mod->data,
+				     btf_mod->data_size);
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
@@ -9232,6 +9298,24 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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
@@ -9270,6 +9354,26 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 				continue;
 
 			btf_mod->flags |= BTF_MODULE_F_LIVE;
+			if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && btf_mod->btf &&
+			    !list_empty(&btf_mod->deferred_regs)) {
+				/*
+				 * The vmlinux BTF arrived while this module was
+				 * initializing: btf_parse_deferred_modules()
+				 * parsed its BTF but left the registrations its
+				 * init queued to us, now that init is done and
+				 * the module is not going anywhere.  Applying
+				 * them walks btf_modules, so drop the mutex.
+				 */
+				LIST_HEAD(regs);
+
+				btf = btf_mod->btf;
+				btf_get(btf);
+				list_splice_init(&btf_mod->deferred_regs, &regs);
+				mutex_unlock(&btf_module_mutex);
+				btf_apply_deferred_regs(btf, &regs);
+				btf_put(btf);
+				goto out;
+			}
 			break;
 		}
 		mutex_unlock(&btf_module_mutex);
@@ -9286,7 +9390,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			 * btf_try_get_module() on such BTFs will fail. This may
 			 * be called again on btf_put(), but it's ok to do so.
 			 */
-			btf_free_id(btf_mod->btf);
+			if (btf_mod->btf)
+				btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
 			btf_module_free(btf_mod);
 			break;
@@ -9309,6 +9414,101 @@ static int __init btf_module_init(void)
 }
 
 fs_initcall(btf_module_init);
+
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/*
+ * A kept module whose BTF cannot be used after all.  The module is loaded
+ * and stays, so there is no way to reject it: the entry stays on the list,
+ * dead, until the module goes.  A sysfs file it has keeps serving the raw
+ * data, which is kept for that.
+ */
+static void btf_module_dead(struct btf_module *btf_mod, const char *what, int err)
+{
+	pr_warn("failed to %s module [%s] BTF: %d\n", what, btf_mod->module->name, err);
+	kvfree(btf_mod->base_data);
+	btf_mod->base_data = NULL;
+	btf_free_deferred_regs(&btf_mod->deferred_regs);
+	btf_mod->gone = true;
+}
+
+/*
+ * CONFIG_DEBUG_INFO_BTF=m: the vmlinux BTF has just become available.  Parse
+ * the BTF of the modules that were loaded before it, and apply the
+ * registrations that waited for them.  Called from bpf_get_btf_vmlinux()
+ * once btf_vmlinux is published, with no locks held.
+ *
+ * A module's BTF is published (btf_mod->btf set, id allocated) only after
+ * its queued registrations are applied, so nobody sees a module BTF without
+ * its kfuncs and struct_ops, as with the vmlinux BTF.  Applying walks
+ * btf_modules (btf_check_kfunc_name()) and so needs the mutex dropped; the
+ * module is pinned for that, and the scan restarts afterwards.  A module
+ * that is still initializing is only published: its init is still queueing
+ * registrations, and MODULE_STATE_LIVE applies them once it is done.
+ */
+void btf_parse_deferred_modules(void)
+{
+	/* Pairs with the publication in bpf_get_btf_vmlinux() */
+	struct btf *vmlinux_btf = smp_load_acquire(&btf_vmlinux);
+	struct btf_module *btf_mod;
+	bool parsed = false;
+	LIST_HEAD(regs);
+	struct btf *btf;
+	int err;
+
+	if (IS_ERR_OR_NULL(vmlinux_btf))
+		return;
+
+	mutex_lock(&btf_module_mutex);
+restart:
+	list_for_each_entry(btf_mod, &btf_modules, list) {
+		if (btf_mod->btf || btf_mod->gone)
+			continue;
+
+		btf = btf_parse_module(btf_mod->module->name, vmlinux_btf,
+				       btf_mod->data, btf_mod->data_size, true,
+				       btf_mod->base_data, btf_mod->base_data_size);
+		if (IS_ERR(btf)) {
+			/* on failure the caller keeps the data */
+			btf_module_dead(btf_mod, "validate", PTR_ERR(btf));
+			continue;
+		}
+		/* btf->data is btf_mod->data now, the sysfs file keeps pointing at valid data */
+		kvfree(btf_mod->base_data);
+		btf_mod->base_data = NULL;
+
+		if ((btf_mod->flags & BTF_MODULE_F_LIVE) &&
+		    try_module_get(btf_mod->module)) {
+			list_splice_init(&btf_mod->deferred_regs, &regs);
+			mutex_unlock(&btf_module_mutex);
+			btf_apply_deferred_regs(btf, &regs);
+			mutex_lock(&btf_module_mutex);
+			module_put(btf_mod->module);
+		}
+
+		err = btf_alloc_id(btf);
+		if (err) {
+			/* give the data back to the entry, the sysfs file may serve it */
+			btf->data = NULL;
+			btf_free(btf);
+			btf_module_dead(btf_mod, "register", err);
+			goto restart;
+		}
+
+		/* modules with .BTF.base get their sysfs file now, the data is relocated */
+		if (!btf_mod->sysfs_attr)
+			btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size);
+		btf_mod->data = NULL;
+		btf_mod->btf = btf;
+		parsed = true;
+		/* the list may have changed while the mutex was dropped */
+		goto restart;
+	}
+	mutex_unlock(&btf_module_mutex);
+
+	if (parsed)
+		purge_cand_cache(NULL);
+}
+#endif /* IS_MODULE(CONFIG_DEBUG_INFO_BTF) */
 #endif /* BTF_MODULE_NOTIFIER */
 
 struct module *btf_try_get_module(const struct btf *btf)
@@ -9361,8 +9561,11 @@ struct btf *btf_get_module_btf(const struct module *module)
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
@@ -9545,7 +9748,8 @@ static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	guard(mutex)(&btf_module_mutex);
 	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
-		if (btf_mod->btf == btf)
+		/* skip ourselves and, with CONFIG_DEBUG_INFO_BTF=m, unparsed BTF */
+		if (btf_mod->btf == btf || !btf_mod->btf)
 			continue;
 		id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
 		if (id >= 0) {
@@ -10788,14 +10992,16 @@ static int btf_struct_ops_register(struct btf *btf, struct bpf_struct_ops *st_op
 #endif
 
 /*
- * CONFIG_DEBUG_INFO_BTF=m: registrations for vmlinux made before its BTF is
- * available wait in btf_vmlinux_deferred_regs until btf_parse_vmlinux()
- * applies them.
+ * CONFIG_DEBUG_INFO_BTF=m: registrations made before the BTF they apply to
+ * is available.  Registrations for vmlinux wait in btf_vmlinux_deferred_regs
+ * until btf_parse_vmlinux() applies them; registrations for a module wait in
+ * its struct btf_module, under btf_module_mutex, until
+ * btf_parse_deferred_modules() does.
  */
 #ifdef BTF_MODULE_NOTIFIER
 /*
- * The queue has its own lock: it is drained under btf_vmlinux_lock, and
- * btf_module_mutex must not nest inside that (purge_cand_cache() takes
+ * The vmlinux queue has its own lock: it is drained under btf_vmlinux_lock,
+ * and btf_module_mutex must not nest inside that (purge_cand_cache() takes
  * cand_cache_mutex under btf_module_mutex, and CO-RE fetches the vmlinux
  * BTF under cand_cache_mutex).
  */
@@ -10807,19 +11013,31 @@ static bool btf_vmlinux_regs_closed;
 /*
  * Queue @tmpl if the BTF for @owner is not available yet.  Returns 1 if the
  * registration was queued and is to be considered done, 0 if the caller has
- * to apply it, or -ENOMEM.  Only vmlinux registrations are queued so far.
+ * to apply it, or -ENOMEM.
  */
 static int btf_defer_reg(struct module *owner, const struct btf_deferred_reg *tmpl)
 {
 	struct list_head *head = NULL;
 	struct btf_deferred_reg *reg;
+	struct btf_module *btf_mod;
 
-	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF) || owner)
+	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF))
 		return 0;
 
-	guard(mutex)(&btf_vmlinux_regs_mutex);
-	if (!btf_vmlinux_regs_closed)
-		head = &btf_vmlinux_deferred_regs;
+	guard(mutex)(owner ? &btf_module_mutex : &btf_vmlinux_regs_mutex);
+	if (!owner) {
+		if (!btf_vmlinux_regs_closed)
+			head = &btf_vmlinux_deferred_regs;
+	} else {
+		list_for_each_entry(btf_mod, &btf_modules, list) {
+			if (btf_mod->module != owner)
+				continue;
+			/* a dead entry has no BTF to register with, as with =y */
+			if (!btf_mod->btf && !btf_mod->gone)
+				head = &btf_mod->deferred_regs;
+			break;
+		}
+	}
 	if (!head)
 		return 0;
 
@@ -10872,7 +11090,10 @@ static int btf_apply_deferred_reg(struct btf *btf, const struct btf_deferred_reg
 	return -EINVAL;
 }
 
-/* Apply and free the registrations in @regs to @btf. */
+/*
+ * Apply and free the registrations in @regs to @btf.  For a module BTF the
+ * caller holds a reference on @btf and makes sure the owning module stays.
+ */
 static void btf_apply_deferred_regs(struct btf *btf, struct list_head *regs)
 {
 	struct btf_deferred_reg *reg, *tmp;
@@ -10888,6 +11109,16 @@ static void btf_apply_deferred_regs(struct btf *btf, struct list_head *regs)
 	}
 }
 
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
 /*
  * The vmlinux BTF has just been parsed; apply the registrations that waited
  * for it.  Runs under btf_vmlinux_lock, before @btf is published, so nothing
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 84968244a10f..7577c6215535 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21925,12 +21925,14 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
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
@@ -21965,8 +21967,13 @@ struct btf *bpf_get_btf_vmlinux(void)
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

