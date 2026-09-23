Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F1418A2D;
	Wed, 23 Sep 2026 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142054; cv=none; b=RKMifVzzay6gsiSnsi6f55knOHY5gWxIHYAiI0IGbOZ/zg3nLZFjdIMwvsm1QnkHBnokLVQjtUiYz6hn6TfeJJsG6Nmm/NqurAHRt0Se9AHHNYYmGSNnzrNTcbhBTyexKHT/qgAyPyE5p9ucfRHeykPWIOB/q13ieoEFzePXWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142054; c=relaxed/simple;
	bh=Hw5gkQ2orDU/8pZftu6havBJSOrFzrWOnv5UYWuVba0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzZVT2PIP7c3t9rDgfQDOaqNLCsJtpHuzGm2EIIL5I0uyVWPTi7OcuLvEqFWHCO8SuLrgRAxZRLjLhELWJTOVkKHb6ce9U2ByM2NsLvVSgiLiIenLP00vGgj0dTz4K06OvmAiN9+5YWysxf6ri6JuC1/5X7Jj+zUE4GsgVnWWHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lQPhofLI; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lQPhofLI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790142052; x=1821678052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ExtyunNGCNzKwBq3DLx8FFZogSxkEtEWhjPwJuhR+g=;
  b=lQPhofLIvt+nBXH3lQAL0RSYqcvebSXmBO0fOvQTBQY09bCGPKv1Zd6F
   ijRlN1qsRqKEmBBWYA4Cmh7y8PhyGJRmgMMSHlSIpKp1J682MY0SqR8tv
   ONctXxY9FMqlnU5VjH9ebcbNSpUq2v8QEhxAncdO8iLZoxKjrd+7HHhI7
   u6DTsmm2hh2ASSvcf4cW7YPqQzMb4YiS9fpXX6+pbJn0jUKR8p84rp7mc
   hZfh4HaJXy+Ny8DFx3nTKlwIBRytSpBfmK7bmsplMgBVpeliJ2h9948aZ
   uS9H6k0Sa5Ge0ImIxHwK04Hh6yBlTxd/Pqvs680v3xtuAGUUCcjI2UEnI
   g==;
X-CSE-ConnectionGUID: lps+hww6TV+xy4EWY+sQoQ==
X-CSE-MsgGUID: IRDXTvs9SXeWKIu7bELnzg==
X-IronPort-AV: E=Sophos;i="6.27,117,1787011200"; 
   d="scan'208";a="29318518"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:40:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:10800]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.137:2525] with esmtp (Farcaster)
 id 719cb39e-d607-431e-b29a-ce0313174c3e; Wed, 23 Sep 2026 05:40:52 +0000 (UTC)
X-Farcaster-Flow-ID: 719cb39e-d607-431e-b29a-ce0313174c3e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:40:51 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:40:51 +0000
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
Subject: [PATCH bpf-next 4/6] bpf: take the vmlinux BTF from the btf_vmlinux module
Date: Wed, 23 Sep 2026 05:39:46 +0000
Message-ID: <20260923053948.30617-5-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Add the runtime side of delivering the vmlinux BTF as a module: with
CONFIG_DEBUG_INFO_BTF=m the BTF is carried by a module named btf_vmlinux
and installed by the BTF module notifier when it loads, and whoever needs
the BTF first loads the module.  Nothing in this patch is reachable yet:
CONFIG_DEBUG_INFO_BTF is still a bool and every new path is under
IS_MODULE(CONFIG_DEBUG_INFO_BTF); the kbuild side and the Kconfig change
follow.

With CONFIG_DEBUG_INFO_BTF=y the vmlinux BTF, 5.4 MiB on x86-64 with a
distribution config, is part of the kernel image and resident from boot
whether anything uses it or not.  Most systems never do.  Carrying it in
a module that is loaded on first use makes the memory a cost of using
BTF rather than of having a kernel that supports it.

btf_vmlinux_data() hands out the raw vmlinux BTF: from __start_BTF with
=y, or with =m from a vmalloc_user() copy that the notifier makes when
the btf_vmlinux module loads.  If the copy is not there and the caller
asked to load, it calls request_module("btf_vmlinux"); the notifier
installs the copy before init_module() returns, so the data is either
present afterwards or the module is not available (yet).  The result is
not cached, a later call retries.  btf_parse_vmlinux() and
bpf_get_btf_vmlinux() use it; the latter loads outside btf_vmlinux_lock
so that the notifier is never blocked by the caller, and returns NULL
like a kernel without BTF when the module cannot be loaded.

The verifier trusts the BTF as the description of this kernel's types, so
the notifier only accepts a payload whose size and SHA-256 match the
values linked into the kernel as .BTF.meta (struct btf_vmlinux_meta,
filled in by scripts/gen-btf.sh in a later patch).  A carrier from
another build is refused with -EINVAL even if vermagic lets it load, and
a second carrier is ignored.  The copy is never freed: as with =y, the
BTF stays for the lifetime of the kernel, and the carrier has no exit.

The module notifier, btf_parse_module() and the btf_data fields in struct
module are compiled for CONFIG_DEBUG_INFO_BTF_MODULES or =m; with =m and
no module BTF, the notifier only recognizes the carrier.

/sys/kernel/btf/vmlinux exists from boot with its final size, which is
known from .BTF.meta before the BTF is loaded; the first read() or mmap()
loads it.  mmap() uses remap_vmalloc_range() on the copy.  This keeps
stat() working before the load, which is what the btf_sysfs selftest
does.

BPF_BTF_GET_NEXT_ID loads the BTF too: kernel BTFs get their ids when
the vmlinux BTF is parsed, and whoever enumerates BTF ids wants them.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 include/linux/btf.h    |   2 +
 include/linux/module.h |   2 +-
 kernel/bpf/btf.c       | 168 +++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c   |   6 ++
 kernel/bpf/sysfs_btf.c |  80 +++++++++++++++++++-
 kernel/bpf/verifier.c  |  43 +++++++----
 kernel/module/main.c   |   4 +-
 7 files changed, 277 insertions(+), 28 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index ddd0f4f32d24..0bf10811fe53 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -581,6 +581,8 @@ __u32 *btf_field_iter_next(struct btf_field_iter *it);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
+void *btf_vmlinux_data(u32 *size, bool load);
+u32 btf_vmlinux_size(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag);
diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..82734996a862 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -497,7 +497,7 @@ struct module {
 	unsigned int num_bpf_raw_events;
 	struct bpf_raw_event_map *bpf_raw_events;
 #endif
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
 	unsigned int btf_data_size;
 	unsigned int btf_base_data_size;
 	void *btf_data;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c3c1421208b4..50eb7a95fd82 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/overflow.h>
+#include <crypto/sha2.h>
 #include <linux/bitops.h>
 
 #include <net/netfilter/nf_bpf_link.h>
@@ -6092,10 +6093,86 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
 	return ERR_PTR(err);
 }
 
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF)
 extern char __start_BTF[];
 extern char __stop_BTF[];
+#endif
 extern struct btf *btf_vmlinux;
 
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/*
+ * With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is not part of the kernel
+ * image.  The btf_vmlinux module carries it in its .BTF section; when the
+ * module loads, btf_module_notify() copies the section here.  The copy is
+ * made with vmalloc_user() so that /sys/kernel/btf/vmlinux can be mmap()ed
+ * as with the built-in BTF.  Set once, never cleared: like the built-in
+ * BTF, once present it stays for the lifetime of the kernel.
+ *
+ * The size and SHA-256 of the BTF are linked into the kernel as .BTF.meta
+ * by scripts/gen-btf.sh: the size makes /sys/kernel/btf/vmlinux report its
+ * size before the BTF is loaded, the hash makes sure only the BTF this
+ * kernel was built with is accepted.
+ */
+struct btf_vmlinux_meta {
+	u32 size;
+	u8 sha256[SHA256_DIGEST_SIZE];
+} __packed;
+
+extern const struct btf_vmlinux_meta __start_BTF_meta[];
+#define btf_vmlinux_meta (__start_BTF_meta[0])
+
+static void *btf_vmlinux_raw;
+#endif
+
+/**
+ * btf_vmlinux_data - get the raw vmlinux BTF
+ * @size: where to store the size of the BTF
+ * @load: with CONFIG_DEBUG_INFO_BTF=m, load the btf_vmlinux module if the
+ *	  BTF is not present yet; may sleep
+ *
+ * Return: the raw BTF, or NULL if it is not available.
+ */
+void *btf_vmlinux_data(u32 *size, bool load)
+{
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF)
+	*size = __stop_BTF - __start_BTF;
+	return __start_BTF;
+#elif IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+	/* Pairs with the smp_store_release() in btf_vmlinux_module_coming() */
+	void *data = smp_load_acquire(&btf_vmlinux_raw);
+
+	if (!data && load) {
+		/*
+		 * The module notifier installs the BTF before init_module()
+		 * returns, so it is either there after this or the module is
+		 * not available (yet).  Not cached: a later call retries,
+		 * e.g. once the module becomes reachable on the root fs.
+		 */
+		request_module("btf_vmlinux");
+		/* Same pairing as above */
+		data = smp_load_acquire(&btf_vmlinux_raw);
+	}
+	*size = btf_vmlinux_meta.size;
+	return data;
+#else
+	return NULL;
+#endif
+}
+
+/**
+ * btf_vmlinux_size - size of the vmlinux BTF, known even before it is loaded
+ */
+u32 btf_vmlinux_size(void)
+{
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF)
+	return __stop_BTF - __start_BTF;
+#elif IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+	return btf_vmlinux_meta.size;
+#else
+	return 0;
+#endif
+}
+
 #define BPF_MAP_TYPE(_id, _ops)
 #define BPF_LINK_TYPE(_id, _name)
 static union {
@@ -6479,15 +6556,22 @@ struct btf *btf_parse_vmlinux(void)
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf;
+	void *data;
+	u32 size;
 	int err;
 
+	/* The caller made sure the BTF is present, see bpf_get_btf_vmlinux() */
+	data = btf_vmlinux_data(&size, false);
+	if (!data)
+		return ERR_PTR(-ENOENT);
+
 	env = kzalloc_obj(*env, GFP_KERNEL | __GFP_NOWARN);
 	if (!env)
 		return ERR_PTR(-ENOMEM);
 
 	log = &env->log;
 	log->level = BPF_LOG_KERNEL;
-	btf = btf_parse_base(env, "vmlinux", __start_BTF, __stop_BTF - __start_BTF);
+	btf = btf_parse_base(env, "vmlinux", data, size);
 	if (IS_ERR(btf))
 		goto err_out;
 
@@ -6514,7 +6598,7 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 	return btf->base_id_map[id];
 }
 
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
 
 /*
  * Parse split module BTF against @vmlinux_btf.  @data is the module's .BTF
@@ -6620,7 +6704,7 @@ static struct btf *btf_parse_module(const char *module_name, struct btf *vmlinux
 	return ERR_PTR(err);
 }
 
-#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
+#endif /* CONFIG_DEBUG_INFO_BTF_MODULES || CONFIG_DEBUG_INFO_BTF=m */
 
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 {
@@ -8604,7 +8688,16 @@ enum {
 	BTF_MODULE_F_LIVE = (1 << 0),
 };
 
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+/*
+ * The module notifier registers module BTF (CONFIG_DEBUG_INFO_BTF_MODULES)
+ * and picks up the vmlinux BTF from the btf_vmlinux module
+ * (CONFIG_DEBUG_INFO_BTF=m).
+ */
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+#define BTF_MODULE_NOTIFIER 1
+#endif
+
+#ifdef BTF_MODULE_NOTIFIER
 struct btf_module {
 	struct list_head list;
 	struct module *module;
@@ -8660,6 +8753,52 @@ static void btf_module_free(struct btf_module *btf_mod)
 	kfree(btf_mod);
 }
 
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
+/*
+ * The btf_vmlinux module carries the vmlinux BTF in its .BTF section
+ * (scripts/gen-btf.sh).  Keep a copy; the module is only the carrier and
+ * has no BTF of its own.
+ */
+static int btf_vmlinux_module_coming(struct module *mod)
+{
+	u8 sha256sum[SHA256_DIGEST_SIZE];
+	void *data;
+
+	if (btf_vmlinux_raw)
+		return 0;
+
+	/*
+	 * The verifier trusts the BTF as the description of this kernel's
+	 * types, so a BTF from a different build must not get in even if
+	 * the module otherwise loads (same release string, same vermagic).
+	 */
+	if (mod->btf_data_size != btf_vmlinux_meta.size) {
+		pr_err("module [%s]: BTF size %u does not match this kernel (%u)\n",
+		       mod->name, mod->btf_data_size, btf_vmlinux_meta.size);
+		return -EINVAL;
+	}
+	sha256(mod->btf_data, mod->btf_data_size, sha256sum);
+	if (memcmp(sha256sum, btf_vmlinux_meta.sha256, sizeof(sha256sum))) {
+		pr_err("module [%s]: BTF does not match this kernel\n", mod->name);
+		return -EINVAL;
+	}
+
+	data = vmalloc_user(mod->btf_data_size);
+	if (!data)
+		return -ENOMEM;
+	memcpy(data, mod->btf_data, mod->btf_data_size);
+
+	/* Pairs with the smp_load_acquire() in btf_vmlinux_data() */
+	smp_store_release(&btf_vmlinux_raw, data);
+	return 0;
+}
+#else
+static int btf_vmlinux_module_coming(struct module *mod)
+{
+	return 0;
+}
+#endif
+
 static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			     void *module)
 {
@@ -8668,9 +8807,17 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 	struct btf *btf;
 	int err = 0;
 
-	if (mod->btf_data_size == 0 ||
-	    (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
-	     op != MODULE_STATE_GOING))
+	if (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
+	    op != MODULE_STATE_GOING)
+		goto out;
+
+	if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && !strcmp(mod->name, "btf_vmlinux")) {
+		if (op == MODULE_STATE_COMING)
+			err = btf_vmlinux_module_coming(mod);
+		goto out;
+	}
+
+	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || mod->btf_data_size == 0)
 		goto out;
 
 	switch (op) {
@@ -8758,7 +8905,7 @@ static int __init btf_module_init(void)
 }
 
 fs_initcall(btf_module_init);
-#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
+#endif /* BTF_MODULE_NOTIFIER */
 
 struct module *btf_try_get_module(const struct btf *btf)
 {
@@ -9715,6 +9862,11 @@ static void purge_cand_cache(struct btf *btf)
 	__purge_cand_cache(btf, module_cand_cache, MODULE_CAND_CACHE_SIZE);
 	mutex_unlock(&cand_cache_mutex);
 }
+#elif defined(BTF_MODULE_NOTIFIER)
+/* CONFIG_DEBUG_INFO_BTF=m without module BTF: nothing is ever cached */
+static void purge_cand_cache(struct btf *btf)
+{
+}
 #endif
 
 static struct bpf_cand_cache *
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 74496fd716d3..9e9eaa798813 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6406,6 +6406,12 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 					  &map_idr, &map_idr_lock);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
+		/*
+		 * With CONFIG_DEBUG_INFO_BTF=m the kernel BTFs get ids when the
+		 * vmlinux BTF is loaded; whoever enumerates them wants them.
+		 */
+		if (IS_MODULE(CONFIG_DEBUG_INFO_BTF))
+			bpf_get_btf_vmlinux();
 		err = bpf_obj_get_next_id(&attr, uattr.user,
 					  &btf_idr, &btf_idr_lock);
 		break;
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index 9cbe15ce3540..03f47734987f 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -9,8 +9,13 @@
 #include <linux/sysfs.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/vmalloc.h>
 
+struct kobject *btf_kobj;
+
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF)
 /* See scripts/link-vmlinux.sh, gen_btf() func for details */
 extern char __start_BTF[];
 extern char __stop_BTF[];
@@ -49,12 +54,81 @@ static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.mmap = btf_sysfs_vmlinux_mmap,
 };
 
-struct kobject *btf_kobj;
-
-static int __init btf_vmlinux_init(void)
+static void __init btf_sysfs_vmlinux_init(void)
 {
 	bin_attr_btf_vmlinux.private = __start_BTF;
 	bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
+}
+
+#else /* CONFIG_DEBUG_INFO_BTF=m */
+
+/*
+ * The BTF is carried by the btf_vmlinux module and only loaded when
+ * something needs it.  Its size is known from the start, so the file has
+ * its final size from boot; the first read() or mmap() loads the BTF.
+ */
+static ssize_t btf_sysfs_vmlinux_read(struct file *filp, struct kobject *kobj,
+				      const struct bin_attribute *attr,
+				      char *buf, loff_t off, size_t count)
+{
+	void *data;
+	u32 size;
+
+	/* Loads the module, parses the BTF and registers module BTFs. */
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux()))
+		return -ENODEV;
+	data = btf_vmlinux_data(&size, false);
+	if (!data)
+		return -ENODEV;
+
+	/* sysfs clamps @off and @count to attr->size, which is @size */
+	memcpy(buf, data + off, count);
+	return count;
+}
+
+static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
+				  const struct bin_attribute *attr,
+				  struct vm_area_struct *vma)
+{
+	size_t vm_size = vma->vm_end - vma->vm_start;
+	void *data;
+	u32 size;
+
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux()))
+		return -ENODEV;
+	data = btf_vmlinux_data(&size, false);
+	if (!data)
+		return -ENODEV;
+
+	if (vma->vm_pgoff)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_WRITE | VM_EXEC | VM_MAYSHARE))
+		return -EACCES;
+
+	if (vm_size > PAGE_ALIGN(size))
+		return -EINVAL;
+
+	vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC | VM_MAYWRITE);
+	/* the copy was made with vmalloc_user() for this purpose */
+	return remap_vmalloc_range(vma, data, 0);
+}
+
+static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
+	.attr = { .name = "vmlinux", .mode = 0444, },
+	.read = btf_sysfs_vmlinux_read,
+	.mmap = btf_sysfs_vmlinux_mmap,
+};
+
+static void __init btf_sysfs_vmlinux_init(void)
+{
+	bin_attr_btf_vmlinux.size = btf_vmlinux_size();
+}
+#endif
+
+static int __init btf_vmlinux_init(void)
+{
+	btf_sysfs_vmlinux_init();
 
 	if (bin_attr_btf_vmlinux.size == 0)
 		return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2425ea74b61d..a7b73bc146a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21157,26 +21157,41 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 	return 0;
 }
 
+/*
+ * Returns the parsed vmlinux BTF, NULL if the kernel has none, or an ERR_PTR
+ * if it is malformed.  With CONFIG_DEBUG_INFO_BTF=m the BTF lives in the
+ * btf_vmlinux module; the first caller loads it and parses it.  May sleep.
+ */
 struct btf *bpf_get_btf_vmlinux(void)
 {
 	/* Pairs with the smp_store_release() on the parse path below. */
 	struct btf *btf = smp_load_acquire(&btf_vmlinux);
+	u32 size;
 
-	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-		mutex_lock(&btf_vmlinux_lock);
-		btf = btf_vmlinux;
-		if (!btf) {
-			btf = btf_parse_vmlinux();
-			/*
-			 * Order the parsed BTF contents and the globals the
-			 * parse populated (e.g. bpf_ctx_convert.t) before
-			 * the pointer publication. Pairs with the acquire
-			 * on the lockless fast path above.
-			 */
-			smp_store_release(&btf_vmlinux, btf);
-		}
-		mutex_unlock(&btf_vmlinux_lock);
+	if (btf || !IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
+		return btf;
+
+	/*
+	 * Loading the module may take a while and its notifier must not be
+	 * blocked by us, so do it outside btf_vmlinux_lock.  Not available:
+	 * behave like a kernel without BTF, and retry next time.
+	 */
+	if (!btf_vmlinux_data(&size, true))
+		return NULL;
+
+	mutex_lock(&btf_vmlinux_lock);
+	btf = btf_vmlinux;
+	if (!btf) {
+		btf = btf_parse_vmlinux();
+		/*
+		 * Order the parsed BTF contents and the globals the
+		 * parse populated (e.g. bpf_ctx_convert.t) before
+		 * the pointer publication. Pairs with the acquire
+		 * on the lockless fast path above.
+		 */
+		smp_store_release(&btf_vmlinux, btf);
 	}
+	mutex_unlock(&btf_vmlinux_lock);
 	return btf;
 }
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..694c4bc7e679 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2718,7 +2718,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					   sizeof(*mod->bpf_raw_events),
 					   &mod->num_bpf_raw_events);
 #endif
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
 	mod->btf_data = any_section_objs(info, ".BTF", 1, &mod->btf_data_size);
 	mod->btf_base_data = any_section_objs(info, ".BTF.base", 1,
 					      &mod->btf_base_data_size);
@@ -3172,7 +3172,7 @@ static noinline int do_init_module(struct module *mod)
 		mod->mem[type].size = 0;
 	}
 
-#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
 	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointers */
 	mod->btf_data = NULL;
 	mod->btf_base_data = NULL;
-- 
2.47.3

