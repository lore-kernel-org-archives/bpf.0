Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7B438023;
	Wed, 23 Sep 2026 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142007; cv=none; b=KptKm/OVRrEMVzDVwhst3Hh6trqb0UZR3v6C7qY5qBtJW0PYPq7IRSMoRcuVU8/2NhOc/z+5yAtsYMFM2d+Sz16p3q/PxwaEwCb3pd9elQyd67Gs3Y1su9SDL94YdYztxZV/UoWvNxb1DZt7riW2WXJSvZlFamwysGHQPFvqqj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142007; c=relaxed/simple;
	bh=ry4jQGL2wKU9mNSo2ehUuXrA6vdswJ5kRMdi0BaXGPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtEe9y+/aYW/myTVnG+naDcy2CLyppXwYNLFYhh6FYS14/1YDi7e9JqxW1IDq9y6IRyUuJil8LvjzYq5FH2CS8y48Igx6QuTFTw3VPj2NRfs2Hfeyss9YXffWi1qHcZp3p2FLsv8E8c0JMVa4UEz0BqXRLTT4dih5roNrTjGGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DzviD7TV; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DzviD7TV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790142005; x=1821678005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/T3L6Erhez9jj6KkQNlY833QrYTQpIlvZMQo38B3kLc=;
  b=DzviD7TVLx4okwPnnjwCKrSMeNiBtH4j9gI/o+XB8uei0u3mY6Dpy0ZW
   oSNTWi5+xtVQBDLW1zOXUeZwOmJMQOtASH1u2tJpqAFKs89pOGc+9ekHT
   ZNDfxPqzFibd3ruz3vRnB6U6MHJ+dC+mq9/7SqSm0bzLrubxwfMkdJvM8
   jpbuoqX+QkeLbGjpsLcywnRlXyUZMXdOikxbXeE6KVE9NyAAlUKQXegov
   58OL9oC92Tu9hsHFErhVTTdRTpAQDPmSJEyVgXp2P5nXAxQCpqmW8u9UO
   X2GPpxgX+Y8qeJe+gEJXYrG/9o9lV0chwCeDVRvlMOfs9Xr32vJ2547g5
   Q==;
X-CSE-ConnectionGUID: L+gsmlieQC26TX0aL6CBFQ==
X-CSE-MsgGUID: tfhBL2k4TFuylusL659bKg==
X-IronPort-AV: E=Sophos;i="6.27,117,1787011200"; 
   d="scan'208";a="29438704"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:40:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:17433]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.232:2525] with esmtp (Farcaster)
 id 62ed8f0f-62c8-4742-83aa-d70b362ac146; Wed, 23 Sep 2026 05:40:04 +0000 (UTC)
X-Farcaster-Flow-ID: 62ed8f0f-62c8-4742-83aa-d70b362ac146
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:40:04 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:40:04 +0000
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
Subject: [PATCH bpf-next 1/6] bpf: pass the vmlinux BTF to btf_parse_module() and let it adopt the data
Date: Wed, 23 Sep 2026 05:39:43 +0000
Message-ID: <20260923053948.30617-2-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
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
index 4a1fa4fbdf4e..a6634237dc89 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6516,16 +6516,20 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 
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
@@ -6562,7 +6566,10 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
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
@@ -6605,7 +6612,8 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	if (!IS_ERR(base_btf) && base_btf != vmlinux_btf)
 		btf_free(base_btf);
 	if (btf) {
-		kvfree(btf->data);
+		if (!data_owned)
+			kvfree(btf->data);
 		kvfree(btf->types);
 		kfree(btf);
 	}
@@ -8610,6 +8618,48 @@ static DEFINE_MUTEX(btf_module_mutex);
 
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
@@ -8630,7 +8680,10 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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
@@ -8652,37 +8705,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 
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
@@ -8709,12 +8737,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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

