Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5048821A;
	Tue,  1 Sep 2026 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281960; cv=none; b=EiOJMkU+I1t6U1SwO04oNbuy/IfXSaN9GoUfWbR0oJQIFMxpIz0Q9l9OnxHrztEsl6Om3f+BvWrhj2k4Ch3aGh34xdntouyFqUh1b1HqBqNNt+qtZaAHDBZlPs3ovBi3oDyDwRWfgtf8yGKFxrcO/F/jGHW1T4lJCzvqvS12+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281960; c=relaxed/simple;
	bh=/IgdYBcTGGAxcCHQtMFWP/GoQKHHGktLP+vPv9jk9+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3pXpAVQ38IJYNZxHG/ll2xJ8iPyb1t1eLcIFQMQo2AnYc6xtQnkelnuRp/Ne8ueGIWQtAc8l5/blPQyXmIGbHMSX1XSliUitNyLGNnZ7WdBuhfwa2vfnzAXXlerveksNtGhyHo23h/5IZjvm0zP8mvVY9wOZfu9LR3EQDG3trE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l7Pn+BvW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l7Pn+BvW"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681ERRfh396200;
	Tue, 1 Sep 2026 16:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=tCols
	EuxGCBc1/XPdpEDcOOPFQDYv2jaqaHanShHPYs=; b=l7Pn+BvWBlKtRYSop2YzI
	UXArDoBECKUIKEByo4XVqB1ibF7FzgP4ZMyuBuu3zdvcVJfk5o6dFQGn10ujA+eh
	YeOnqlb1UyeqNpSu2pYrFepkbdabFgNe1usgCr3AHXgTcPGowBZBg2pkObk6fX8A
	HqoQoPmkdWVyP6oj9Mcj9ST/TJd7EvSy61qWHqnLILCGDb3sNuF8qxXjL8bpLyPO
	P6o7WHYqnNo2BOsXrcNUyerfinanLDSvVmGp18k0v7hkuee2WGA33AQ+NrZ72ljG
	GjfHsLWU5adsVi9aZ9hGn5+gsuhTPMS8YlZNGMky9Bt6SQiGqq0MiuleCEqdv4E5
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbpbaw6rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjWk9002025;
	Tue, 1 Sep 2026 16:58:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg96w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:52 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1WJ011129;
	Tue, 1 Sep 2026 16:58:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-15;
	Tue, 01 Sep 2026 16:58:52 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 14/18] btf: Make vmlinux, module inline info available in /sys/kernel/btf
Date: Tue,  1 Sep 2026 17:57:53 +0100
Message-ID: <20260901165757.801449-15-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260901165757.801449-1-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010148
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfXxWmo/+Ufy1P1
 c/idgJ7+EFFCafXrRvi77DiAQmhOIpYelXlMeZ8H6zoYdsk53aqNVlz3NLBSl8/CEeLACk0q74g
 tiENZvS4NP4XBcVYRlQBEaj9Po7zcy6a5Ln8NGstyFLUHEnJ8Gk8
X-Proofpoint-ORIG-GUID: kN2JQ6Jq0ZeiGg5VH1X_kEK__ZzzS8bl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX5yiPbxRcjKfo
 iLo71Lrp5asKLVJbNHKyZUSnmfp1T9pT+sgtHSQjS4oJparr+6UaUdLovqw18n9gpMc9x34pVKJ
 4Go40Fby9p3K3pWpf4mcHDCGQtTjPQ0C20hCqLA2MqdOyW8CNsPkS/H29AaoI1TFq54dcXKO+aj
 qAf2MMh2WvIwSshNB56uMDLE1f/AnqHgfb8Uj/B/DgeVoz+FrhGygbs4JRP177zRFXDDpvvRLHC
 BPJbMbbzMReKqfhIUpU/a0ghvQmavk505d82AGGJafnO6Fr5iauvvyhdp8ZmtPMcC7JdYeOZeTI
 W11WHbpOcuD0ql70L3aozqxpFkN3UM1yAiApguh/GPoZ+7CiYecdJgM2YvCQ8Q4LsqlSRJPRcdF
 Ogb9IYTGmlyBtqlh6TvhOLHS4SsYekWxfI4EtsRuQYQRfZNkh74sK2JFk3Ko6QGnhtVimYq6KkG
 gXzWu5jqAyZnepTZQCfLwu/QOKpmTWMEBbZzgHwg=
X-Authority-Analysis: v=2.4 cv=DMi/JSNb c=1 sm=1 tr=0 ts=6a97044e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=s-T9MRnivL4uZTGNJVgA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: kN2JQ6Jq0ZeiGg5VH1X_kEK__ZzzS8bl

Expose BTF inline-location information from vmlinux/module .BTF.inline
sections in /sys/kernel/btf using a ".inline" suffix.

vmlinux inline BTF is split relative to vmlinux BTF and can be examined
with:

bpftool btf dump file /sys/kernel/btf/vmlinux.inline

Register the sysfs attribute only when the embedded .BTF.inline section
is non-empty.

Module inline BTF is split relative to the module BTF, which in turn may
be split relative to its distilled base BTF.  For example:

    bpftool btf dump -B /sys/kernel/btf/vmlinux -B /sys/kernel/btf/xfs \
            file /sys/kernel/btf/xfs.inline

Copy the inline BTF data into a private buffer for its sysfs lifetime
and remove the attribute and buffer when the module is unloaded.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/btf.h             |   1 +
 include/linux/module.h          |   4 ++
 kernel/bpf/Makefile             |   1 +
 kernel/bpf/btf.c                | 109 ++++++++++++++++++++++++++------
 kernel/bpf/btf_vmlinux_inline.c |  30 +++++++++
 kernel/module/main.c            |   4 ++
 6 files changed, 128 insertions(+), 21 deletions(-)
 create mode 100644 kernel/bpf/btf_vmlinux_inline.c

diff --git a/include/linux/btf.h b/include/linux/btf.h
index a4412bc16688..93f10d3ccabe 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -617,6 +617,7 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
 int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx);
+struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_size);
 
 static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
 {
diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..3d32c4e86f44 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -507,6 +507,10 @@ struct module {
 	void *btf_data;
 	void *btf_base_data;
 #endif
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+	unsigned int btf_inline_data_size;
+	void *btf_inline_data;
+#endif
 #ifdef CONFIG_JUMP_LABEL
 	struct jump_entry *jump_entries;
 	unsigned int num_jump_entries;
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 9a92c348bbda..60aa5adb0354 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
 endif
 ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
+obj-$(CONFIG_DEBUG_INFO_BTF_INLINE) += btf_vmlinux_inline.o
 endif
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d74c8668aa3f..3e5890aed2db 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8735,12 +8735,69 @@ enum {
 	BTF_MODULE_F_LIVE = (1 << 0),
 };
 
+#if IS_ENABLED(CONFIG_SYSFS)
+struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_size)
+{
+	struct bin_attribute *attr;
+	int err;
+
+	attr = kzalloc_obj(*attr);
+	if (!attr)
+		return ERR_PTR(-ENOMEM);
+
+	sysfs_bin_attr_init(attr);
+	attr->attr.mode = 0444;
+	attr->size = data_size;
+	attr->private = data;
+	attr->read = sysfs_bin_attr_simple_read;
+	attr->attr.name = kstrdup(name, GFP_KERNEL);
+	if (!attr->attr.name) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+	err = sysfs_create_bin_file(btf_kobj, attr);
+	if (err) {
+		pr_warn("failed to register [%s] BTF in sysfs: %d\n", name, err);
+		goto err_free;
+	}
+	return attr;
+
+err_free:
+	kfree(attr->attr.name);
+	kfree(attr);
+	return ERR_PTR(err);
+}
+
+#else
+struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_size)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+#if IS_ENABLED(CONFIG_SYSFS)
+static void sysfs_btf_remove(struct bin_attribute *attr)
+{
+	sysfs_remove_bin_file(btf_kobj, attr);
+	kfree(attr->attr.name);
+	kfree(attr);
+}
+#else
+static void sysfs_btf_remove(struct bin_attribute *attr)
+{
+}
+#endif
+
 struct btf_module {
 	struct list_head list;
 	struct module *module;
 	struct btf *btf;
 	struct bin_attribute *sysfs_attr;
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+	struct bin_attribute *sysfs_inline_attr;
+	void *btf_inline_data;
+#endif
 	int flags;
 };
 
@@ -8754,6 +8811,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 {
 	struct btf_module *btf_mod, *tmp;
 	struct module *mod = module;
+	struct bin_attribute *attr;
 	struct btf *btf;
 	int err = 0;
 
@@ -8796,31 +8854,35 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		list_add(&btf_mod->list, &btf_modules);
 		mutex_unlock(&btf_module_mutex);
 
-		if (IS_ENABLED(CONFIG_SYSFS)) {
-			struct bin_attribute *attr;
-
-			attr = kzalloc_obj(*attr);
-			if (!attr)
-				goto out;
+		attr = sysfs_btf_add(btf->name, btf->data, btf->data_size);
+		if (IS_ERR(attr)) {
+			err = 0;
+			goto out;
+		}
+		btf_mod->sysfs_attr = attr;
 
-			sysfs_bin_attr_init(attr);
-			attr->attr.name = btf->name;
-			attr->attr.mode = 0444;
-			attr->size = btf->data_size;
-			attr->private = btf->data;
-			attr->read = sysfs_bin_attr_simple_read;
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+		if (mod->btf_inline_data_size > 0) {
+			char name[MODULE_NAME_LEN + sizeof(".inline")];
+			void *data;
 
-			err = sysfs_create_bin_file(btf_kobj, attr);
-			if (err) {
-				pr_warn("failed to register module [%s] BTF in sysfs: %d\n",
-					mod->name, err);
-				kfree(attr);
+			data = kvmemdup(mod->btf_inline_data, mod->btf_inline_data_size,
+					GFP_KERNEL | __GFP_NOWARN);
+			if (!data) {
 				err = 0;
 				goto out;
 			}
-
-			btf_mod->sysfs_attr = attr;
+			snprintf(name, sizeof(name), "%s.inline", mod->name);
+			attr = sysfs_btf_add(name, data, mod->btf_inline_data_size);
+			if (IS_ERR(attr)) {
+				err = 0;
+				kvfree(data);
+				goto out;
+			}
+			btf_mod->btf_inline_data = data;
+			btf_mod->sysfs_inline_attr = attr;
 		}
+#endif
 
 		break;
 	case MODULE_STATE_LIVE:
@@ -8849,10 +8911,15 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
 			if (btf_mod->sysfs_attr)
-				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
+				sysfs_btf_remove(btf_mod->sysfs_attr);
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+			if (btf_mod->sysfs_inline_attr) {
+				sysfs_btf_remove(btf_mod->sysfs_inline_attr);
+				kvfree(btf_mod->btf_inline_data);
+			}
+#endif
 			purge_cand_cache(btf_mod->btf);
 			btf_put(btf_mod->btf);
-			kfree(btf_mod->sysfs_attr);
 			kfree(btf_mod);
 			break;
 		}
diff --git a/kernel/bpf/btf_vmlinux_inline.c b/kernel/bpf/btf_vmlinux_inline.c
new file mode 100644
index 000000000000..b155df9849b9
--- /dev/null
+++ b/kernel/bpf/btf_vmlinux_inline.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, Oracle and/or its affiliates. */
+/*
+ * Provide kernel BTF inline function information for use by BPF tools.
+ */
+#include <linux/btf.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF_INLINE)
+extern char __start_BTF_inline[];
+extern char __stop_BTF_inline[];
+#endif
+
+static int __init btf_vmlinux_inline_init(void)
+{
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF_INLINE)
+	size_t data_size = __stop_BTF_inline - __start_BTF_inline;
+
+	if (data_size)
+		sysfs_btf_add("vmlinux.inline", __start_BTF_inline,
+			      data_size);
+#endif
+	return 0;
+}
+subsys_initcall(btf_vmlinux_inline_init);
+
+MODULE_DESCRIPTION("BTF inline information for vmlinux");
+MODULE_LICENSE("GPL");
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..7e06ef113113 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2712,6 +2712,10 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->btf_base_data = any_section_objs(info, ".BTF.base", 1,
 					      &mod->btf_base_data_size);
 #endif
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+	mod->btf_inline_data = any_section_objs(info, ".BTF.inline", 1,
+						&mod->btf_inline_data_size);
+#endif
 #ifdef CONFIG_JUMP_LABEL
 	mod->jump_entries = section_objs(info, "__jump_table",
 					sizeof(*mod->jump_entries),
-- 
2.43.5

