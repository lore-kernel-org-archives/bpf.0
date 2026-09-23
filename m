Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6E321A459;
	Wed, 23 Sep 2026 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142022; cv=none; b=JhURkVErdc67O750bXxfLlFNm3alLyKcps1SKpetES0+Frfew784I3BxzE6dqSBf0MQsYKkZleXGtVbEKc9okIuzwCr69m+I8hRiznaaLisCx3iPpFUOzzAkhlK1ufBLZKuTYhirKYKfmxF6eWRCXGeo0r7yLbA7tSmzaNyrj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142022; c=relaxed/simple;
	bh=hDWO4kKtFW0ws5P8AqsAJnLaI0zPunaAAMiFodM6fPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQotEb6UIj4UXVnC9fWGr0HouFb5ztawn9vd4Q3wWK5YOMwF8OhcjHYnuekKf5wXoMWxFafj4EiE5io9b6f7BZgmoLIAJNabzqYWJbDQHFxjXYb56z6GsyP+PP3QYjsWrSqPDgVidDiLZrJ6xkkZShxCSH/GG4rDXAhjtEcd6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YGjjWEst; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YGjjWEst"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790142020; x=1821678020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oYdFmiyHha0KnlTs+SZuSj16NqNIECti33IxnnQ3JPY=;
  b=YGjjWEstgaHx5ilCKCX4WRCmAC6cbhJKETdhoGreLxPp+9Z5GhsHJJEC
   9nczxidqs7LGaDMQzkcMNOtQTYHJjOTLd5+k7YtKOUiWyjSoVsVdePVT/
   vzrgn17weyJ18mFwrU6H0/EWX5vCWfzKEKGcdBvRTQodcLuHWKUVorjNN
   IxQamSicvsCeTFOIXCQENx2AWUqPnhtL/Dt6hWjKwIVXoSgMfND6gw052
   lSC4zI9A4QLi2h5LlnM5DuC+5A9Tc5u3Ehaxdp772cocv1pKSL/7xV20v
   0mVkcaODKBLlh4dUqYU6pfQOIFZbk0niaYe5Ki6daDdxnXcnfTZKFsutC
   A==;
X-CSE-ConnectionGUID: krfUjUrZT1SyzXdQGrDikQ==
X-CSE-MsgGUID: 1eaHeKSaT1CYavLe1CkrUA==
X-IronPort-AV: E=Sophos;i="6.27,117,1787011200"; 
   d="scan'208";a="29402263"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:40:20 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:8335]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.70:2525] with esmtp (Farcaster)
 id b07ed87e-ffeb-4ce0-bea5-2fd6a0aba4f1; Wed, 23 Sep 2026 05:40:20 +0000 (UTC)
X-Farcaster-Flow-ID: b07ed87e-ffeb-4ce0-bea5-2fd6a0aba4f1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:40:20 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 23 Sep 2026 05:40:19 +0000
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
Subject: [PATCH bpf-next 2/6] bpf: split the kfunc, dtor kfunc and struct_ops registration bodies
Date: Wed, 23 Sep 2026 05:39:44 +0000
Message-ID: <20260923053948.30617-3-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Split __register_btf_kfunc_id_set(), register_btf_id_dtor_kfuncs() and
__register_bpf_struct_ops() into the part that looks up the BTF for the
owner and the part that adds the registration to a given BTF:
btf_kfunc_id_set_add(), btf_dtor_kfuncs_add() and btf_struct_ops_add().

In is_valid_value_type(), look up bpf_struct_ops_common_value in the btf
the function was given rather than in the btf_vmlinux global.  The id is
a vmlinux id and a module BTF resolves it through its base, so the result
is the same; the function already uses the passed btf for every other
lookup.

No functional change.  With CONFIG_DEBUG_INFO_BTF=m, registrations made
from initcalls before the vmlinux BTF is available are queued and applied
later by the BTF parsing code, which needs the add-to-this-btf half on
its own; the struct_ops ones are applied before the parsed vmlinux BTF is
published, i.e. while btf_vmlinux is still NULL.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/bpf_struct_ops.c |  3 +-
 kernel/bpf/btf.c            | 91 ++++++++++++++++++++++---------------
 2 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1178acd72296..bf3004908d15 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -103,7 +103,8 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
 	}
 	member = btf_type_member(vt);
 	mt = btf_type_by_id(btf, member->type);
-	common_value_type = btf_type_by_id(btf_vmlinux,
+	/* a vmlinux id resolves through the base BTF of a module BTF too */
+	common_value_type = btf_type_by_id(btf,
 					   st_ops_ids[IDX_ST_OPS_COMMON_VALUE_ID]);
 	if (mt != common_value_type) {
 		pr_warn("The first member of %s should be bpf_struct_ops_common_value\n",
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a6634237dc89..c3c1421208b4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9313,11 +9313,26 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 	return btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id);
 }
 
+static int btf_kfunc_id_set_add(struct btf *btf, enum btf_kfunc_hook hook,
+				const struct btf_kfunc_id_set *kset)
+{
+	int ret, i;
+
+	for (i = 0; i < kset->set->cnt; i++) {
+		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
+					     kset->set->pairs[i].flags);
+		if (ret)
+			return ret;
+	}
+
+	return btf_populate_kfunc_set(btf, hook, kset);
+}
+
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 				       const struct btf_kfunc_id_set *kset)
 {
 	struct btf *btf;
-	int ret, i;
+	int ret;
 
 	btf = btf_get_module_btf(kset->owner);
 	if (!btf)
@@ -9325,16 +9340,7 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
-	for (i = 0; i < kset->set->cnt; i++) {
-		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
-					     kset->set->pairs[i].flags);
-		if (ret)
-			goto err_out;
-	}
-
-	ret = btf_populate_kfunc_set(btf, hook, kset);
-
-err_out:
+	ret = btf_kfunc_id_set_add(btf, hook, kset);
 	btf_put(btf);
 	return ret;
 }
@@ -9426,21 +9432,13 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 	return 0;
 }
 
-/* This function must be invoked only from initcalls/module init functions */
-int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
-				struct module *owner)
+static int btf_dtor_kfuncs_add(struct btf *btf, const struct btf_id_dtor_kfunc *dtors,
+			       u32 add_cnt)
 {
 	struct btf_id_dtor_kfunc_tab *tab;
-	struct btf *btf;
 	u32 tab_cnt, i;
 	int ret;
 
-	btf = btf_get_module_btf(owner);
-	if (!btf)
-		return check_btf_kconfigs(owner, "dtor kfuncs");
-	if (IS_ERR(btf))
-		return PTR_ERR(btf);
-
 	if (add_cnt >= BTF_DTOR_KFUNC_MAX_CNT) {
 		pr_err("cannot register more than %d kfunc destructors\n", BTF_DTOR_KFUNC_MAX_CNT);
 		ret = -E2BIG;
@@ -9497,6 +9495,23 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 end:
 	if (ret)
 		btf_free_dtor_kfunc_tab(btf);
+	return ret;
+}
+
+/* This function must be invoked only from initcalls/module init functions */
+int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
+				struct module *owner)
+{
+	struct btf *btf;
+	int ret;
+
+	btf = btf_get_module_btf(owner);
+	if (!btf)
+		return check_btf_kconfigs(owner, "dtor kfuncs");
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+
+	ret = btf_dtor_kfuncs_add(btf, dtors, add_cnt);
 	btf_put(btf);
 	return ret;
 }
@@ -10135,32 +10150,36 @@ bpf_struct_ops_find(struct btf *btf, u32 type_id)
 	return NULL;
 }
 
-int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+static int btf_struct_ops_add(struct btf *btf, struct bpf_struct_ops *st_ops)
 {
 	struct bpf_verifier_log *log;
-	struct btf *btf;
-	int err = 0;
-
-	btf = btf_get_module_btf(st_ops->owner);
-	if (!btf)
-		return check_btf_kconfigs(st_ops->owner, "struct_ops");
-	if (IS_ERR(btf))
-		return PTR_ERR(btf);
+	int err;
 
 	log = kzalloc_obj(*log, GFP_KERNEL | __GFP_NOWARN);
-	if (!log) {
-		err = -ENOMEM;
-		goto errout;
-	}
+	if (!log)
+		return -ENOMEM;
 
 	log->level = BPF_LOG_KERNEL;
 
 	err = btf_add_struct_ops(btf, st_ops, log);
 
-errout:
 	kfree(log);
-	btf_put(btf);
+	return err;
+}
 
+int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	struct btf *btf;
+	int err;
+
+	btf = btf_get_module_btf(st_ops->owner);
+	if (!btf)
+		return check_btf_kconfigs(st_ops->owner, "struct_ops");
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+
+	err = btf_struct_ops_add(btf, st_ops);
+	btf_put(btf);
 	return err;
 }
 EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
-- 
2.47.3

