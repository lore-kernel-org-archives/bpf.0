Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192EF40EB81;
	Fri, 25 Sep 2026 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376173; cv=none; b=twNoQmEFMu8hxcAxOqrKWNaQGki2D7Szx8EqzyPpXu6T5IBGNY17HabG2u5YtnyvA7bwzjFuwZTA28lugiOUZwOcLogYL9WcoCXO82eukaRQmrmWYb3AzXl36q5bwsJenm3VxLQLqCAwOQY9o4DD2rVaEJthdjMXWX2NCA3aXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376173; c=relaxed/simple;
	bh=P2JU5BWSagDWLTsXpbgCI+u0D8fR31c7n0cmL56VBOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5HYdjCDybzY5VtfuSB0UuUexyZYjRi733u4Wu8l0A7FUPGLpvl/gtkiFUmmC/S8pjgR0u2KXBRent2/cupdtKp6hvB4cNut6vyBftSewULNhGfk9M7JkLfHbnOK4tpRlY4/HiczwhLEZlFO0VdvHsEM1ivZrT+T0H6V/V3sUO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KfES5Azq; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KfES5Azq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790376170; x=1821912170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YLFyowLKMrVAHaoNarE4z9YwjV2cuEkQguyck9CKPe0=;
  b=KfES5AzqLyLBqppMT+1qoeKLPji0OZu36klVZ048rmWucmYWp27Tzu9U
   /ci5p4i6vbU7zdnvXvIWCWa7xjoBgXvVSz5l7IBOE4srselcsQvladIHR
   aKvyCixdUnyMkOSEIfBkk+E3tpVuTQ2beWfC3htq58690CNEZpqbKVU8j
   zosGdAnmY+0kKpmdqPhiHFKnOE2feSrOiJmE0/DRNhFsBphaBqjeWZQ+5
   1n1XfSZcG0bRJwGZphtz8hUu4qEePZ5sNMzWpteDLqEeQlHwJpEhRg3Qy
   RXlsgxVSw8TxvYeGkCapePsvMbjRbHwNAkhF24EsKGsUPQtVKGFExJ7U6
   A==;
X-CSE-ConnectionGUID: CZiycwO8Sj2VF7si5wT32w==
X-CSE-MsgGUID: k1nqsEZETHa75zBKsR++Mw==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29481147"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 22:42:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:13637]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.18:2525] with esmtp (Farcaster)
 id 7bc355be-3e6e-440f-be30-65f01db19a22; Fri, 25 Sep 2026 22:42:45 +0000 (UTC)
X-Farcaster-Flow-ID: 7bc355be-3e6e-440f-be30-65f01db19a22
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 22:42:45 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 22:42:45 +0000
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
Subject: [PATCH bpf-next v3 1/9] bpf: pass the vmlinux BTF to btf_parse_module() and let it adopt the data
Date: Fri, 25 Sep 2026 22:42:21 +0000
Message-ID: <20260925224229.1850-2-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Make btf_parse_module() take the vmlinux BTF as an argument instead of
fetching it with bpf_get_btf_vmlinux(), and add a data_owned flag: when
set, the passed .BTF data is an already kvmalloc()ed copy that the new
btf takes ownership of on success (on failure the caller keeps it).

Factor the sysfs file creation out of the module notifier into
btf_module_sysfs_add() and the teardown into btf_module_free(), and set
btf_mod->module right after the allocation rather than under the mutex.

No functional change.  This prepares for CONFIG_DEBUG_INFO_BTF=m, where a
module can be loaded before the vmlinux BTF is available: its .BTF is
then copied and exposed in sysfs first and parsed later, at which point
the parser must take the copy as is so that the sysfs file keeps
pointing at valid data.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c | 105 +++++++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9bcfefdfb734..49c4ea7f75c5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6868,16 +6868,20 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
-static struct btf *btf_parse_module(const char *module_name, const void *data,
-				    unsigned int data_size, void *base_data,
-				    unsigned int base_data_size)
+/*
+ * Parse split module BTF against @vmlinux_btf.  @data is the module's .BTF
+ * section; if @data_owned, it is an already kvmalloc()ed copy that the new
+ * btf takes ownership of on success (on failure the caller keeps it).
+ */
+static struct btf *btf_parse_module(const char *module_name, struct btf *vmlinux_btf,
+				    void *data, unsigned int data_size, bool data_owned,
+				    void *base_data, unsigned int base_data_size)
 {
-	struct btf *btf = NULL, *vmlinux_btf, *base_btf = NULL;
+	struct btf *btf = NULL, *base_btf = NULL;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	int err = 0;
 
-	vmlinux_btf = bpf_get_btf_vmlinux();
 	if (IS_ERR(vmlinux_btf))
 		return vmlinux_btf;
 	if (!vmlinux_btf)
@@ -6914,7 +6918,10 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->named_start_id = 0;
 	strscpy(btf->name, module_name);
 
-	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
+	if (data_owned)
+		btf->data = data;
+	else
+		btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!btf->data) {
 		err = -ENOMEM;
 		goto errout;
@@ -6957,7 +6964,8 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	if (!IS_ERR(base_btf) && base_btf != vmlinux_btf)
 		btf_free(base_btf);
 	if (btf) {
-		kvfree(btf->data);
+		if (!data_owned)
+			kvfree(btf->data);
 		kvfree(btf->types);
 		kfree(btf);
 	}
@@ -8962,6 +8970,48 @@ static DEFINE_MUTEX(btf_module_mutex);
 
 static void purge_cand_cache(struct btf *btf);
 
+static int btf_module_sysfs_add(struct btf_module *btf_mod, const char *name,
+				void *data, size_t data_size)
+{
+	struct bin_attribute *attr;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_SYSFS))
+		return 0;
+
+	attr = kzalloc_obj(*attr);
+	if (!attr)
+		return -ENOMEM;
+
+	sysfs_bin_attr_init(attr);
+	attr->attr.name = name;
+	attr->attr.mode = 0444;
+	attr->size = data_size;
+	attr->private = data;
+	attr->read = sysfs_bin_attr_simple_read;
+
+	err = sysfs_create_bin_file(btf_kobj, attr);
+	if (err) {
+		pr_warn("failed to register module [%s] BTF in sysfs: %d\n",
+			name, err);
+		kfree(attr);
+		return err;
+	}
+
+	btf_mod->sysfs_attr = attr;
+	return 0;
+}
+
+static void btf_module_free(struct btf_module *btf_mod)
+{
+	if (btf_mod->sysfs_attr)
+		sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
+	purge_cand_cache(btf_mod->btf);
+	btf_put(btf_mod->btf);
+	kfree(btf_mod->sysfs_attr);
+	kfree(btf_mod);
+}
+
 static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			     void *module)
 {
@@ -8982,7 +9032,10 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			err = -ENOMEM;
 			goto out;
 		}
-		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
+		btf_mod->module = module;
+
+		btf = btf_parse_module(mod->name, bpf_get_btf_vmlinux(),
+				       mod->btf_data, mod->btf_data_size, false,
 				       mod->btf_base_data, mod->btf_base_data_size);
 		if (IS_ERR(btf)) {
 			kfree(btf_mod);
@@ -9004,37 +9057,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 
 		purge_cand_cache(NULL);
 		mutex_lock(&btf_module_mutex);
-		btf_mod->module = module;
 		btf_mod->btf = btf;
 		list_add(&btf_mod->list, &btf_modules);
 		mutex_unlock(&btf_module_mutex);
 
-		if (IS_ENABLED(CONFIG_SYSFS)) {
-			struct bin_attribute *attr;
-
-			attr = kzalloc_obj(*attr);
-			if (!attr)
-				goto out;
-
-			sysfs_bin_attr_init(attr);
-			attr->attr.name = btf->name;
-			attr->attr.mode = 0444;
-			attr->size = btf->data_size;
-			attr->private = btf->data;
-			attr->read = sysfs_bin_attr_simple_read;
-
-			err = sysfs_create_bin_file(btf_kobj, attr);
-			if (err) {
-				pr_warn("failed to register module [%s] BTF in sysfs: %d\n",
-					mod->name, err);
-				kfree(attr);
-				err = 0;
-				goto out;
-			}
-
-			btf_mod->sysfs_attr = attr;
-		}
-
+		/* not fatal, the module BTF is usable without the sysfs file */
+		btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size);
 		break;
 	case MODULE_STATE_LIVE:
 		mutex_lock(&btf_module_mutex);
@@ -9061,12 +9089,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			 */
 			btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
-			if (btf_mod->sysfs_attr)
-				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
-			purge_cand_cache(btf_mod->btf);
-			btf_put(btf_mod->btf);
-			kfree(btf_mod->sysfs_attr);
-			kfree(btf_mod);
+			btf_module_free(btf_mod);
 			break;
 		}
 		mutex_unlock(&btf_module_mutex);
-- 
2.47.3

