Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16433489895;
	Tue,  1 Sep 2026 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281965; cv=none; b=cXp1mlTBEEcYBKAJzz+XE8OTpUoHVGVxhOqUj4j0NJyTEfhDDhuwKeY0JK2eNW7OFKJbLeRmGn6+a1UrI08Y9LR+nKV8MkfenL2mZ3ix9R6sT41ZrqcE7EM1+s9xoMApa/UjC/pRRtao30xiqwHoc3nSziqmraW3WeDwbA0RwJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281965; c=relaxed/simple;
	bh=MwNbTWlb/LPNW4ecdvPK6sbRJaB2jrL5TWSL/Be8AUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvbKzTFXHLHQ+ee6ibzOKUjtbUCSymgNt8L4OK3Ng1ZSPZJTbjpWeTk01HgI9Nnpm1FFDLpm50z5WDaWUJRQAcN5pcgTOZq69ZXO0hWIq4aV5p4toURkwk0JwbUs9SyzLcGXFmrRfx7E2Z+h7CbJrJuGG+pNhd6BcBeItK6E53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TWUtLpca; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TWUtLpca"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQBsX231372;
	Tue, 1 Sep 2026 16:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=qCEIF
	J/nFtGYxIzlOJ69MtoF8nIb6tFxVbRxxCff0Q8=; b=TWUtLpcaZuEucHBvW3Z/B
	JSic8mKJOpbQv+4QEWmCJaAp0uXxa4bpoBlQbbUjqz7OGqoBcvDcYjm0ZgvuyO7e
	UdvJ4ioQiL+Slot1yAbKx115A700O2FvIcZtPfn25vRrtN1VZhqzT5jRzfYVQIb+
	gkWUVkQPI+MnFUAg1p0WuCcQ3z42XW/t9UoNQQ26SQ7F4x/Ify/H34mf8y+qaVbY
	DGxbZsopFuHEMzgH+zOWgPLpSB2Y+Jc0J/MxJtGVi8tfpvl65bP+LSurIFA64oAf
	U9VZ8JTUXeUud0NEUOmlpIy1/SBZCvKZVJyhsH/apJSf2QjQTFUI1kPY3ENiBIXz
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7n3vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjUH5001862;
	Tue, 1 Sep 2026 16:58:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg983-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:56 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1WL011129;
	Tue, 1 Sep 2026 16:58:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-16;
	Tue, 01 Sep 2026 16:58:55 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 15/18] btf: Support CONFIG_DEBUG_INFO_BTF_INLINE=m
Date: Tue,  1 Sep 2026 17:57:54 +0100
Message-ID: <20260901165757.801449-16-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX0ZQn0ooBhlyt
 2EUWz4fdY35cylxIQ7/m0TpsS9MwsN0+KXFdLSQHSeU1S+p21Kzlkyasm+HhjVFsFCObk7QCAyL
 yD8B4A/ocfMAskDCGqKMGMfKoz3ovCKAWX38QQ92d7JDaeX7IUmx
X-Proofpoint-GUID: 5lYMBIqPI7gkIRmO3W9ikzJ8_yaYva47
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a970452 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=1K3RzDzeQnhQGU_ASvkA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: 5lYMBIqPI7gkIRmO3W9ikzJ8_yaYva47
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX40C3xv4AVNPT
 1GGn4KfEPWb4GKn0FEJyVwqfyQJIN32ecjgv6ss7pOAjBCoq55q9dU8neMoafr1acumc1VKZcjt
 GQhtA0+W+vMjvdXIjFzrai3Ld8cR07laJkPc0B0jhCnbjZBg4b45x90YsZ8V1p/T+YWAMZfs8zY
 wpaFtUR5iUJifbh/zVbeKkyBG54/wH4wdv0ZQt/TUDwqpy3n2DKEpHoyvYXh99KfinPo/PAiRnl
 AT6Y2NVM4sxhKSaf4caXPHREb1Htvx4vXLoVatgld56yVzAeEORGOrkXqznWx9fH8R5nATxPEZ/
 IamBMdDRDnMMmo+hUmjNoCkkn7yrOQl2JSysCEXq97hg+jHuLpLZvu4wo/kzm91v1kfRlQmxU7f
 AjuTjXyZs41c6PvRgyiE3C5y133lsJ1Si6k7SI+jUJg5ZP2rKPNMA3Q4txb0SLJUzxQJ2y0fXOu
 BOcHQU6DQe/1GJOtJK/XL3ZWOi1CQwelJpehalV4=

Allow vmlinux BTF inline info to be delivered via a loadable
module btf_vmlinux_inline.ko; this reduces the vmlinux binary size.

We cannot use the standard sysfs_create_bin_file() interface
for this because when the user open()s vmlinux.inline() we
want to trigger module load.  To do this we need to use
a kernfs representation for vmlinux.inline which we initialize
with NULL data, 0 size.  When open() is called the kernfs
callback uses request_module() to trigger the module load
and the module notifier allocates the BTF data and sets the
size in the bin_attribute.  Once this is complete we can
update the file inode and the caller will see the updated
size and be able to fseek(), ftell() and fread() normally.

With all this in place vmlinux.inline is created on startup
with size 0 and when open()ed we will synchronously load
the module and assign the binary data.  So a user running
"bpftool btf dump -B vmlinux file vmlinux.inline" sees identical
behaviour whether the inline info is module-delivered or otherwise;
we simply save memory allocation if the inline info is not needed.

Inline BTF module delivery relies on the module BTF notifier, so select
DEBUG_INFO_BTF_MODULES when modules are enabled. Keep built-in-only
CONFIG_DEBUG_INFO_BTF_INLINE=y configurations independent of module BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Makefile                        |   1 +
 kernel/bpf/btf.c                | 114 +++++++++++++++++++++++++++++++-
 kernel/bpf/btf_vmlinux_inline.c |   7 ++
 lib/Kconfig.debug               |   3 +-
 scripts/gen-btf.sh              |  18 ++++-
 5 files changed, 139 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 130926fa592e..4fa15fa5d1ed 100644
--- a/Makefile
+++ b/Makefile
@@ -1733,6 +1733,7 @@ endif # CONFIG_MODULES
 CLEAN_FILES += vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
 	       modules.builtin.ranges vmlinux.o.map vmlinux.unstripped \
+	       vmlinux.BTF.inline \
 	       vmlinux.thinlto-index builtin.order \
 	       compile_commands.json rust/test \
 	       rust-project.json .vmlinux.objs .vmlinux.export.c \
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3e5890aed2db..2ac1f1d39660 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8,6 +8,7 @@
 #include <linux/seq_file.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/anon_inodes.h>
@@ -25,6 +26,7 @@
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
+#include <linux/kernfs.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/overflow.h>
@@ -8736,10 +8738,82 @@ enum {
 };
 
 #if IS_ENABLED(CONFIG_SYSFS)
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+static struct bin_attribute *vmlinux_inline_attr;
+#endif
+
+static int sysfs_btf_bin_attr_load(struct bin_attribute *attr)
+{
+	char modname[MODULE_NAME_LEN + sizeof("btf_vmlinux_inline")];
+	int retries = 0;
+
+	/* First on-demand read; load module. */
+	snprintf(modname, sizeof(modname), "btf_%s", attr->attr.name);
+	strreplace(modname, '.', '_');
+	request_module("%s", modname);
+
+	/*
+	 * request_module() is synchronous, but the module notifier is
+	 * responsible for updating private data, so retries are required.
+	 */
+	while (retries++ < 10) {
+		if (smp_load_acquire(&attr->size))
+			return 0;
+		udelay(50);
+	}
+	return -ENODEV;
+}
+
+static int sysfs_btf_kernfs_open(struct kernfs_open_file *of)
+{
+	struct bin_attribute *attr = of->kn->priv;
+	size_t data_size;
+	int err;
+
+	if (!smp_load_acquire(&attr->size)) {
+		err = sysfs_btf_bin_attr_load(attr);
+		if (err)
+			return err;
+	}
+	/* Refresh file size or the open() caller will not see updated size. */
+	data_size = smp_load_acquire(&attr->size);
+	of->kn->attr.size = data_size;
+	if (of->file) {
+		struct inode *inode = file_inode(of->file);
+
+		if (inode)
+			i_size_write(inode, data_size);
+	}
+	return 0;
+}
+
+static ssize_t sysfs_btf_kernfs_read(struct kernfs_open_file *of, char *buf,
+				     size_t bytes_requested, loff_t offset)
+{
+	struct bin_attribute *attr = of->kn->priv;
+	void *data;
+	size_t data_size;
+
+	data_size = smp_load_acquire(&attr->size);
+	if (offset >= data_size)
+		return 0;
+	if (offset + bytes_requested > data_size)
+		bytes_requested = data_size - offset;
+	data = READ_ONCE(attr->private);
+	memcpy(buf, data + offset, bytes_requested);
+
+	return bytes_requested;
+}
+
+static const struct kernfs_ops sysfs_btf_kernfs_ops = {
+	.open = sysfs_btf_kernfs_open,
+	.read = sysfs_btf_kernfs_read,
+};
+
 struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_size)
 {
 	struct bin_attribute *attr;
-	int err;
+	int err = 0;
 
 	attr = kzalloc_obj(*attr);
 	if (!attr)
@@ -8755,7 +8829,18 @@ struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_si
 		err = -ENOMEM;
 		goto err_free;
 	}
-	err = sysfs_create_bin_file(btf_kobj, attr);
+	if (data_size > 0) {
+		err = sysfs_create_bin_file(btf_kobj, attr);
+	} else {
+		struct kernfs_node *node;
+
+		node = __kernfs_create_file(btf_kobj->sd, attr->attr.name,
+					    attr->attr.mode, GLOBAL_ROOT_UID,
+					    GLOBAL_ROOT_GID, data_size,
+					    &sysfs_btf_kernfs_ops, attr, NULL, NULL);
+		if (IS_ERR(node))
+			err = PTR_ERR(node);
+	}
 	if (err) {
 		pr_warn("failed to register [%s] BTF in sysfs: %d\n", name, err);
 		goto err_free;
@@ -8775,6 +8860,17 @@ struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_si
 }
 #endif
 
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+static void sysfs_btf_update(struct bin_attribute *attr, void *data, size_t data_size)
+{
+	if (!attr)
+		return;
+	WRITE_ONCE(attr->private, data);
+	/* Publish data before its non-zero size makes it readable. */
+	smp_store_release(&attr->size, data_size);
+}
+#endif
+
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 #if IS_ENABLED(CONFIG_SYSFS)
 static void sysfs_btf_remove(struct bin_attribute *attr)
@@ -8872,6 +8968,14 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 				err = 0;
 				goto out;
 			}
+			if (strcmp(mod->name, "btf_vmlinux_inline") == 0) {
+				if (vmlinux_inline_attr)
+					sysfs_btf_update(vmlinux_inline_attr, data,
+							 mod->btf_inline_data_size);
+				else
+					kvfree(data);
+				break;
+			}
 			snprintf(name, sizeof(name), "%s.inline", mod->name);
 			attr = sysfs_btf_add(name, data, mod->btf_inline_data_size);
 			if (IS_ERR(attr)) {
@@ -8937,6 +9041,12 @@ static struct notifier_block btf_module_nb = {
 static int __init btf_module_init(void)
 {
 	register_module_notifier(&btf_module_nb);
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF_INLINE)
+	/* Attribute data will be filled in on-demand if vmlinux.inline is read. */
+	vmlinux_inline_attr = sysfs_btf_add("vmlinux.inline", NULL, 0);
+	if (IS_ERR(vmlinux_inline_attr))
+		vmlinux_inline_attr = NULL;
+#endif
 	return 0;
 }
 
diff --git a/kernel/bpf/btf_vmlinux_inline.c b/kernel/bpf/btf_vmlinux_inline.c
index b155df9849b9..13ed962ffceb 100644
--- a/kernel/bpf/btf_vmlinux_inline.c
+++ b/kernel/bpf/btf_vmlinux_inline.c
@@ -26,5 +26,12 @@ static int __init btf_vmlinux_inline_init(void)
 }
 subsys_initcall(btf_vmlinux_inline_init);
 
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF_INLINE)
+static void __exit btf_vmlinux_inline_fini(void)
+{
+}
+module_exit(btf_vmlinux_inline_fini);
+#endif
+
 MODULE_DESCRIPTION("BTF inline information for vmlinux");
 MODULE_LICENSE("GPL");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dd1b2d9ebe99..1b96d6acfdce 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -439,9 +439,10 @@ config DEBUG_INFO_BTF_MODULES
 	  Generate compact split BTF type information for kernel modules.
 
 config DEBUG_INFO_BTF_INLINE
-	bool "Provide information about inline sites in BTF"
+	tristate "Provide information about inline sites in BTF"
 	default n
 	depends on DEBUG_INFO_BTF && PAHOLE_HAS_INLINE && SYSFS
+	select DEBUG_INFO_BTF_MODULES if MODULES
 	help
 	  Generate information about inline sites in .BTF.inline sections.
 	  These sections contain split BTF relative to the kernel or module BTF
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index a75f41878c32..cd6588588fb8 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -93,7 +93,16 @@ gen_btf_o()
 		--set-section-flags .BTF=alloc,readonly ${btf_data}
 	ONLY_SEC="--only-section=.BTF"
 	btf_inline=${ELF_FILE}.BTF.inline
-	if [ -n "${BTF_INLINE}" ] && [ -f "${btf_inline}" ]; then
+	if [ "${BTF_INLINE}" = "m" ]; then
+		# vmlinux BTF is generated from a temporary ELF.  Retain its
+		# vmlinux-relative inline BTF for btf_vmlinux_inline.ko.
+		if [ -f "${btf_inline}" ]; then
+			cp "${btf_inline}" "${objtree}/vmlinux.BTF.inline"
+		else
+			rm -f "${objtree}/vmlinux.BTF.inline"
+		fi
+	fi
+	if [ "${BTF_INLINE}" = "y" ] && [ -f "${btf_inline}" ]; then
 		${OBJCOPY} --add-section .BTF.inline=${btf_inline} \
 			--set-section-flags .BTF.inline=alloc,readonly ${btf_data}
 		ONLY_SEC="${ONLY_SEC} --only-section=.BTF.inline"
@@ -120,6 +129,13 @@ embed_btf_data()
 		${OBJCOPY} --add-section .BTF.base=${btf_base} ${ELF_FILE}
 	fi
 	btf_inline=${ELF_FILE}.BTF.inline
+	case "${ELF_FILE}" in
+	*/btf_vmlinux_inline.ko)
+		# With CONFIG_DEBUG_INFO_BTF_INLINE=m, deliver vmlinux
+		# .BTF.inline via module
+		btf_inline=${BTF_BASE}.BTF.inline
+		;;
+	esac
 	if [ -n "${BTF_INLINE}" ] && [ -f "${btf_inline}" ]; then
 		${OBJCOPY} --add-section .BTF.inline=${btf_inline} ${ELF_FILE}
 	fi
-- 
2.43.5

