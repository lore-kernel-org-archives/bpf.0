Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884A3CB8E9;
	Fri, 25 Sep 2026 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376261; cv=none; b=aqoqHHg9hUiCJdu9ZZMB+x/TWX1iHD0mIEHLEdndnurMi65CzPn3ncVWMTNeV5kGg5dUhsFog52mhrhIkNdm200mApyFwQ+wD8jqiGU+vSZJKDpafvHtV/BjFkSjgTZ/y3/KY/NDzFH9j927RGZ5yrlBvAZNjXEFuW5SMlVtulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376261; c=relaxed/simple;
	bh=UNTj/m5jaUj/WB1wQ3H45MGf70dLVn2dOJy7o2R2H8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhM5fliCxfjlYGZ3Il9TEM6jMDRzy4qT552XcK6Gh3R88y0kHnGT2dtWYJWLqyU6QzYVk/Dylqj+bljgunDQITaI/zwBLai+Rj9kyp+D8boIcH95p3ZeJqRDTf97KMDUxiVWFMu7u8B4GkeJnphSEcY/iUo6RMfm5i1BJOlbDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iJdOl9Iv; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iJdOl9Iv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790376260; x=1821912260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LlKtBjWm1vlOixievJy2+085DomcoTKjXaUoWf6pKvk=;
  b=iJdOl9Ivt9mq5i38RyEkVlx7sspjz2BgC4kFb1+CuAu7yAPxtfIZdCf6
   3dFJ0Gt5FEwBHnLOmiLZtydh8fE8rqMRuI2udY5oo9z4GY5kUFwAXx3xG
   DpIltQsi+uNft5upk/G4XgB0Rer8FJdd/Z+EUE4YMbHW8c5G6EBdF2MH/
   fm9C6vIRZJ3vDcO/AMc/fLKmHCL+5U4kMBg/gx7Z6yZqxnxkiLLaEIsHU
   xlUJb59GQrkB9xrvlkTfgUQ8pJfOFUPw0eqBrau5Jl2U6Z+R0jw3seMpz
   exc0SXGoyyqtNRbHn/nPfNGfGkacz5FgZwSM8xrYEDti9u5H+TlXff3oJ
   w==;
X-CSE-ConnectionGUID: HsjZzFo2RaqgFrSlyuiJXw==
X-CSE-MsgGUID: 3NP0ymeRTu6y649UtDnIhg==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29674646"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 22:44:20 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:13451]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.18:2525] with esmtp (Farcaster)
 id 5545bac1-06d4-40a0-94c7-0c8b35c11a26; Fri, 25 Sep 2026 22:44:19 +0000 (UTC)
X-Farcaster-Flow-ID: 5545bac1-06d4-40a0-94c7-0c8b35c11a26
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 22:44:19 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 22:44:19 +0000
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
Subject: [PATCH bpf-next v3 7/9] bpf: expose deferred .BTF.base module BTF in sysfs from module load
Date: Fri, 25 Sep 2026 22:42:27 +0000
Message-ID: <20260925224229.1850-8-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

A module with a .BTF.base section (built out of tree) that is loaded
before the vmlinux BTF only gets its /sys/kernel/btf file once the
vmlinux BTF has been loaded and its BTF relocated, because the raw .BTF
is only valid against the distilled base and relocation rewrites it in
place.  Until then the module is missing from /sys/kernel/btf, unlike
with =y, and reading its file cannot trigger the load.

Create the file at module load instead, with its final size: relocation
only rewrites type ids and string offsets, never the length.  Its reader,
btf_module_sysfs_read_deferred(), loads the vmlinux BTF, which parses and
relocates the kept modules, then waits until this module's BTF is
published (btf_mod->ready) before serving it, so no unrelocated or
half-relocated data is ever visible.  If the module goes away or its BTF
turns out unusable first (btf_mod->gone), the read fails with -ENODEV.

Because that reader may itself be the thread running
btf_parse_deferred_modules(), and removing a sysfs file waits for its
readers, nothing removes a sysfs file from that path (a failed entry
stays dead until the module goes, which the previous patch already
arranged), and MODULE_STATE_GOING removes the file after dropping
btf_module_mutex, which the reader may need to get there.

Modules without .BTF.base are unchanged: their data is final and is
served as is.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c | 108 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1dae1c9b53fe..64583fb1f380 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9124,17 +9124,27 @@ struct btf_module {
 	u32 data_size;
 	u32 base_data_size;
 	struct list_head deferred_regs;
-	/* the kept BTF turned out unusable; the entry stays until the module goes */
+	/*
+	 * For the sysfs reader of a module whose data is only final once its
+	 * BTF is relocated: @ready once @btf is published, @gone once the
+	 * entry is dead (parse failed or module going).  Both only ever go
+	 * from false to true; waiters sleep on btf_module_wq.
+	 */
+	bool ready;
 	bool gone;
 };
 
 static LIST_HEAD(btf_modules);
 static DEFINE_MUTEX(btf_module_mutex);
+static DECLARE_WAIT_QUEUE_HEAD(btf_module_wq);
 
 static void purge_cand_cache(struct btf *btf);
 
 static int btf_module_sysfs_add(struct btf_module *btf_mod, const char *name,
-				void *data, size_t data_size)
+				void *private, size_t size,
+				ssize_t (*read)(struct file *, struct kobject *,
+						const struct bin_attribute *,
+						char *, loff_t, size_t))
 {
 	struct bin_attribute *attr;
 	int err;
@@ -9149,9 +9159,9 @@ static int btf_module_sysfs_add(struct btf_module *btf_mod, const char *name,
 	sysfs_bin_attr_init(attr);
 	attr->attr.name = name;
 	attr->attr.mode = 0444;
-	attr->size = data_size;
-	attr->private = data;
-	attr->read = sysfs_bin_attr_simple_read;
+	attr->size = size;
+	attr->private = private;
+	attr->read = read;
 
 	err = sysfs_create_bin_file(btf_kobj, attr);
 	if (err) {
@@ -9165,8 +9175,14 @@ static int btf_module_sysfs_add(struct btf_module *btf_mod, const char *name,
 	return 0;
 }
 
+/*
+ * Called with btf_module_mutex NOT held: removing the sysfs file waits for
+ * readers to leave, and a deferred reader may need the mutex to get there.
+ */
 static void btf_module_free(struct btf_module *btf_mod)
 {
+	WRITE_ONCE(btf_mod->gone, true);
+	wake_up_all(&btf_module_wq);
 	if (btf_mod->sysfs_attr)
 		sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
 	if (btf_mod->btf) {
@@ -9221,15 +9237,57 @@ static int btf_vmlinux_module_coming(struct module *mod)
 	return 0;
 }
 
+/*
+ * sysfs reader for a module kept aside with a .BTF.base section: its .BTF is
+ * split against the distilled base and only becomes valid split BTF against
+ * the vmlinux BTF once relocated, which rewrites the buffer in place.  So
+ * first make sure the vmlinux BTF is loaded (which parses and relocates the
+ * kept modules), then wait until this module's BTF is published.  The size
+ * does not change: relocation only rewrites ids and string offsets.
+ */
+static bool btf_module_published(struct btf_module *btf_mod)
+{
+	/* Pairs with the smp_store_release() of @ready after btf_mod->btf is set */
+	return smp_load_acquire(&btf_mod->ready);
+}
+
+static ssize_t btf_module_sysfs_read_deferred(struct file *filp, struct kobject *kobj,
+					      const struct bin_attribute *attr,
+					      char *buf, loff_t off, size_t count)
+{
+	struct btf_module *btf_mod = attr->private;
+	int err;
+
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux()))
+		return -ENODEV;
+
+	/*
+	 * Another thread may still be relocating and publishing it; if the
+	 * module goes away or its BTF turns out unusable, btf_module_free()
+	 * or btf_parse_deferred_modules() set @gone and wake us.
+	 */
+	err = wait_event_interruptible(btf_module_wq,
+				       btf_module_published(btf_mod) ||
+				       READ_ONCE(btf_mod->gone));
+	if (err)
+		return err;
+	if (!btf_module_published(btf_mod))
+		return -ENODEV;
+
+	/* sysfs clamps @off and @count to attr->size == btf->data_size */
+	memcpy(buf, btf_mod->btf->data + off, count);
+	return count;
+}
+
 /*
  * The vmlinux BTF is not available yet and must not be loaded from the
  * module notifier (that would nest a module load into a module load).  Keep
  * the module's BTF for btf_parse_deferred_modules().
  *
- * Without a .BTF.base section the .BTF data is final and can be exposed in
- * sysfs right away, it needs no parsing.  With one, parsing relocates the
- * data in place against the vmlinux BTF, so the file is created afterwards,
- * as with =y where it also only appears once the BTF is parsed.
+ * The sysfs file is created right away with its final size, as with =y.
+ * Without a .BTF.base section the .BTF data is final and is served as is;
+ * with one, it is only valid once relocated, so its reader waits for that
+ * (btf_module_sysfs_read_deferred()).
  */
 static int btf_module_defer(struct btf_module *btf_mod, struct module *mod)
 {
@@ -9248,10 +9306,12 @@ static int btf_module_defer(struct btf_module *btf_mod, struct module *mod)
 			return -ENOMEM;
 		}
 		btf_mod->base_data_size = mod->btf_base_data_size;
-	} else {
 		/* not fatal, the module BTF is usable without the sysfs file */
+		btf_module_sysfs_add(btf_mod, mod->name, btf_mod, btf_mod->data_size,
+				     btf_module_sysfs_read_deferred);
+	} else {
 		btf_module_sysfs_add(btf_mod, mod->name, btf_mod->data,
-				     btf_mod->data_size);
+				     btf_mod->data_size, sysfs_bin_attr_simple_read);
 	}
 
 	list_add(&btf_mod->list, &btf_modules);
@@ -9345,7 +9405,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		mutex_unlock(&btf_module_mutex);
 
 		/* not fatal, the module BTF is usable without the sysfs file */
-		btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size);
+		btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size,
+				     sysfs_bin_attr_simple_read);
 		break;
 	case MODULE_STATE_LIVE:
 		mutex_lock(&btf_module_mutex);
@@ -9393,8 +9454,10 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			if (btf_mod->btf)
 				btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
+			mutex_unlock(&btf_module_mutex);
+			/* off the list, nobody else can find it now */
 			btf_module_free(btf_mod);
-			break;
+			goto out;
 		}
 		mutex_unlock(&btf_module_mutex);
 		break;
@@ -9419,8 +9482,10 @@ fs_initcall(btf_module_init);
 /*
  * A kept module whose BTF cannot be used after all.  The module is loaded
  * and stays, so there is no way to reject it: the entry stays on the list,
- * dead, until the module goes.  A sysfs file it has keeps serving the raw
- * data, which is kept for that.
+ * dead, until the module goes.  Its sysfs file stays too, its reader, or
+ * the caller of this function, may be inside it right now: a .BTF.base
+ * reader wakes up and fails, a plain one keeps serving the raw data, which
+ * is kept for that.
  */
 static void btf_module_dead(struct btf_module *btf_mod, const char *what, int err)
 {
@@ -9428,14 +9493,17 @@ static void btf_module_dead(struct btf_module *btf_mod, const char *what, int er
 	kvfree(btf_mod->base_data);
 	btf_mod->base_data = NULL;
 	btf_free_deferred_regs(&btf_mod->deferred_regs);
-	btf_mod->gone = true;
+	WRITE_ONCE(btf_mod->gone, true);
+	wake_up_all(&btf_module_wq);
 }
 
 /*
  * CONFIG_DEBUG_INFO_BTF=m: the vmlinux BTF has just become available.  Parse
  * the BTF of the modules that were loaded before it, and apply the
  * registrations that waited for them.  Called from bpf_get_btf_vmlinux()
- * once btf_vmlinux is published, with no locks held.
+ * once btf_vmlinux is published, with no locks held -- possibly from the
+ * sysfs reader of one of these modules, which is why no sysfs file is
+ * removed here.
  *
  * A module's BTF is published (btf_mod->btf set, id allocated) only after
  * its queued registrations are applied, so nobody sees a module BTF without
@@ -9494,11 +9562,11 @@ void btf_parse_deferred_modules(void)
 			goto restart;
 		}
 
-		/* modules with .BTF.base get their sysfs file now, the data is relocated */
-		if (!btf_mod->sysfs_attr)
-			btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size);
 		btf_mod->data = NULL;
 		btf_mod->btf = btf;
+		/* Pairs with the smp_load_acquire() in btf_module_sysfs_read_deferred() */
+		smp_store_release(&btf_mod->ready, true);
+		wake_up_all(&btf_module_wq);
 		parsed = true;
 		/* the list may have changed while the mutex was dropped */
 		goto restart;
-- 
2.47.3

