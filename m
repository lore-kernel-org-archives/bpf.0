Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C314C10D1;
	Fri,  9 Oct 2026 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545069; cv=none; b=EC/lF2/D5xRdRl7O17zVvLumiBaQAv870821slqUvccbQcXEWS8wGK5NxhLqmjP3WQ8S7J20CeH0m3lT0/130pOgsLkYsH1UxrmDR2E/eGCThLUNONlYJY560RuQQORc/4M8bUiuDFjQIqUVJTuwmGAOKOgSYP1Ze6hwSyAdO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545069; c=relaxed/simple;
	bh=AzVd9wnWD6jcccjp3JCAwuGQ1k1go9RNA4Fllq1Z96E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2kQm6/05p3rD4Eh89fZkoFZPbujeBMuYObAQR8qrpnwZINnyRjA4Npb3JLBV1qJwGAKlNlOcqagmQmPDySp2uGH4UI9R23TCx8Xm6K12c7UuTmwDivEZHQuRE70b8Hwuq1sxnpFAIA9fhYTRMb7WEDhfcpLMc5XtQops/DZ5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kB/44KNQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kB/44KNQ"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698K9oPI1464856;
	Fri, 9 Oct 2026 11:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=KV1XP
	8JQQFuZ1gBuZgBgYeVlR8yqzpOaTznd7+yooaQ=; b=kB/44KNQIiPuatotV/E+w
	34sFwJmYicnIMNJQKJECFbDjTMwuf0vKdrJbOj6RB/C6USSQ595CDLEZO0h11lnD
	p6b3K4La2Ae7JSGFxpPrWpEwSxGA/HbXfk+F6ehuE2lQGIM+9oNj+GOIQLeC2fjy
	LMUCVCj1rrzk/c3lHn9JGiow0UlEEmL5vh1vmJ1uTfbVri69nHlfNTbj1ba5Kiiz
	F+rt+ziIHt7oJ4MbpfoOYFkKg5xXlcvGr96KVEHoBUH0PGryws+MQbzjAON6XhG8
	ibLMpAvis5v1UMK4PSSxQvqUxOY/y+ZMQf2cFS4oAdd7vTitgewuthk2mcFvL4Rg
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xeh31gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699BLlkA040060;
	Fri, 9 Oct 2026 11:23:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xfcsnd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:39 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 699BNRkW006543;
	Fri, 9 Oct 2026 11:23:38 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-231.vpn.oracle.com [10.154.85.231])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h5xfcsn8m-4;
	Fri, 09 Oct 2026 11:23:38 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, nathan@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 3/7] kbuild, btf: Expose vmlinux inline BTF through sysfs
Date: Fri,  9 Oct 2026 12:23:20 +0100
Message-ID: <20261009112324.1442319-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261009112324.1442319-1-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610090045
X-Proofpoint-GUID: -r44zi-lcJ0FWk_9Piw2V8ApfjDg4Cd5
X-Proofpoint-ORIG-GUID: -r44zi-lcJ0FWk_9Piw2V8ApfjDg4Cd5
X-Authority-Analysis: v=2.4 cv=LZ2peTfi c=1 sm=1 tr=0 ts=6ac8cebc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=dWvMgMDXqIRcTJ4HnX4A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfXwzptFCQ1Mchp
 Mgh8/bEeNrWKMmU8mN6Bl6vyBX4oYSR11j4CpRRhE84P9kC2lHIC8EGCSqyFCzB7tiYRlL6EK8w
 OyePwWbt8kioerO9SdkogZp80jC0l0DNUrplwGqloFV7ms3L+Wtc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfXwPSCiDTnrKw/
 BUXmMW5RZ/zprR0ClVIoO3bQnHm8s4Ho3Qvy9VuSC9X5TM8zPYJ734d0IdtRNVA+Y7Fs3QgpQgO
 F4umLgy5ZUQbOnXpdeiANKTxkJByq/CU5UI0YAC8R3WW1VZ5Ya8OXwT5kHpyIXHns4kXZdGcP4J
 HIVCxpq8nRbnKg+eXnlgU4QUlyYG57pIFc6zmbjtpK7Ub02wG9CVQ0gBTl5sVBYhXuQW5FPeAQh
 cXLbg6lynEVs8ezc5jdY0pNTxOs18LPu3f1aD+mLIEf9Q1DbX6nXhfCbp99PYvDuecxnGzPzORj
 TkOpS5co5xBnODqbLfUpEb6qAgXuMkZ2EUtAcbyDe3RkMXm8srifL3lHvPEDh7UyMrY+bBMSe1L
 uTQRUqA98OfyayqS+gibCrNIAGlE2gZ9UuXR20SfXSKnYmEvapDe555wHbfQTHq+ucVx5dbeulF
 mV+Rpdsbsb0miEnm1b3s9p6+1oV7ky0w5gngqhak=

Expose BTF inline-location information from vmlinux .BTF.inline
sections in /sys/kernel/btf as vmlinux.inline. Embedded vmlinux
inline BTF supports read-only mmap().

Provide runtime support for a module-delivered vmlinux inline BTF
carrier. Its link record binds the carrier module name, BTF size, and
SHA-256 digest to the running kernel before its data is made available
through a lazy vmlinux.inline sysfs attribute. The carrier is handled
before ordinary module BTF registration, so its incidental .BTF data is
not exposed.

Make CONFIG_DEBUG_INFO_BTF_INLINE tristate. When configured as a
module, retain vmlinux final split inline BTF for
btf_vmlinux_inline.ko instead of embedding it in vmlinux.

Reserve .BTF.inline.link in vmlinux and extend the final
resolve_btfids patch pass to bind btf_vmlinux_inline to the raw
vmlinux.BTF.inline payload. This preserves the normal built-in
configuration while allowing the large inline BTF payload to load on
demand.

Normal module inline BTF is handled separately, after its
references have been relocated against the final module BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: OpenAI Codex (GPT-5.6)
---
 .gitignore                        |   1 +
 Makefile                          |   1 +
 include/asm-generic/vmlinux.lds.h |  31 ++++++
 include/linux/btf.h               |  37 +++++++
 include/linux/module.h            |   4 +
 kernel/bpf/Makefile               |   1 +
 kernel/bpf/btf.c                  | 160 ++++++++++++++++++++++++------
 kernel/bpf/btf_vmlinux_inline.c   |  29 ++++++
 kernel/bpf/sysfs_btf.c            | 149 ++++++++++++++++++++++++++--
 kernel/module/main.c              |   7 ++
 lib/Kconfig.debug                 |  18 ++++
 scripts/Makefile.btf              |   7 ++
 scripts/gen-btf.sh                |  34 ++++++-
 scripts/link-vmlinux.sh           |   8 +-
 scripts/package/kernel.spec       |  10 +-
 15 files changed, 446 insertions(+), 51 deletions(-)
 create mode 100644 kernel/bpf/btf_vmlinux_inline.c

diff --git a/.gitignore b/.gitignore
index 9875120ea7bd..d54bdaac9981 100644
--- a/.gitignore
+++ b/.gitignore
@@ -72,6 +72,7 @@ modules.order
 /vmlinux.symvers
 /vmlinux.thinlto-index
 /vmlinux.unstripped
+/vmlinux.BTF.inline
 /vmlinux-gdb.py
 /vmlinuz
 /System.map
diff --git a/Makefile b/Makefile
index 6b8b812f23b9..b3053dd3c105 100644
--- a/Makefile
+++ b/Makefile
@@ -1769,6 +1769,7 @@ endif # CONFIG_MODULES
 CLEAN_FILES += vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
 	       modules.builtin.ranges vmlinux.o.map vmlinux.unstripped \
+	       vmlinux.BTF.inline \
 	       vmlinux.thinlto-index builtin.order \
 	       compile_commands.json rust/test \
 	       rust-project.json .vmlinux.objs .vmlinux.export.c \
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..b17251bc63f5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -675,12 +675,43 @@
 /*
  * .BTF
  */
+#ifdef CONFIG_DEBUG_INFO_BTF_INLINE
+#define BTF_INLINE							\
+	. = ALIGN(PAGE_SIZE);						\
+	.BTF.inline : AT(ADDR(.BTF.inline) - LOAD_OFFSET) {		\
+		BOUNDED_SECTION_BY(.BTF.inline, _BTF_inline)		\
+	}
+#else
+#define BTF_INLINE
+#endif
+
+#ifdef CONFIG_DEBUG_INFO_BTF_INLINE_MODULE
+/* __MODULE_NAME_LEN + SHA-256 digest + u32 BTF size */
+#ifdef CONFIG_64BIT
+#define BTF_LINK_SIZE	(64 - 8 + 32 + 4)
+#else
+#define BTF_LINK_SIZE	(64 - 4 + 32 + 4)
+#endif
+#define BTF_INLINE_LINK						\
+	. = ALIGN(PAGE_SIZE);					\
+	.BTF.inline.link : AT(ADDR(.BTF.inline.link) - LOAD_OFFSET) { \
+		__start_BTF_inline_link = .;				\
+		BYTE(0)						\
+		. += BTF_LINK_SIZE - 1;					\
+		__stop_BTF_inline_link = .;				\
+	}
+#else
+#define BTF_INLINE_LINK
+#endif
+
 #ifdef CONFIG_DEBUG_INFO_BTF
 #define BTF								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
 		BOUNDED_SECTION_BY(.BTF, _BTF)				\
 	}								\
+	BTF_INLINE							\
+	BTF_INLINE_LINK						\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
 		*(.BTF_ids)						\
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4b63bb91550a..f731c7a5f14c 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -5,6 +5,7 @@
 #define _LINUX_BTF_H 1
 
 #include <linux/types.h>
+#include <linux/module.h>
 #include <linux/bpfptr.h>
 #include <linux/bsearch.h>
 #include <linux/btf_ids.h>
@@ -118,6 +119,19 @@ struct btf_show;
 struct btf_id_set;
 struct bpf_prog;
 
+#define BTF_LINK_SHA256_LEN	32
+
+/*
+ * A .BTF.link or .BTF.inline.link section identifies the module which
+ * carries a vmlinux BTF section.  The module name is NUL terminated and the
+ * field is padded to __MODULE_NAME_LEN.
+ */
+struct btf_link {
+	char module_name[__MODULE_NAME_LEN];
+	u8 sha256[BTF_LINK_SHA256_LEN];
+	u32 btf_size;
+} __packed;
+
 typedef int (*btf_kfunc_filter_t)(const struct bpf_prog *prog, u32 kfunc_id);
 
 struct btf_kfunc_id_set {
@@ -624,6 +638,29 @@ bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
 int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx);
 
+#if IS_ENABLED(CONFIG_SYSFS)
+struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_size,
+				    bool mmap, const char *lazy_module_name);
+bool sysfs_btf_update(struct bin_attribute *attr, void *data);
+void sysfs_btf_remove(struct bin_attribute *attr);
+#else
+static inline struct bin_attribute *
+sysfs_btf_add(const char *name, void *data, size_t data_size, bool mmap,
+	      const char *lazy_module_name)
+{
+	return NULL;
+}
+
+static inline bool sysfs_btf_update(struct bin_attribute *attr, void *data)
+{
+	return false;
+}
+
+static inline void sysfs_btf_remove(struct bin_attribute *attr)
+{
+}
+#endif
+
 static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
 {
 	if (!btf_type_is_ptr(t))
diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..a6abde12a458 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -503,6 +503,10 @@ struct module {
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
index c1f9b0d3468d..37e62ef45079 100644
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
index 0630675377aa..592b71a83841 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,11 +25,12 @@
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
-#include <linux/kobject.h>
 #include <linux/string.h>
-#include <linux/sysfs.h>
 #include <linux/overflow.h>
 #include <linux/bitops.h>
+#include <linux/unaligned.h>
+#include <linux/vmalloc.h>
+#include <crypto/sha2.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 
@@ -9015,21 +9016,132 @@ static DEFINE_MUTEX(btf_module_mutex);
 
 static void purge_cand_cache(struct btf *btf);
 
+#if IS_MODULE(CONFIG_DEBUG_INFO_BTF_INLINE)
+extern char __start_BTF_inline_link[];
+extern char __stop_BTF_inline_link[];
+
+static struct bin_attribute *vmlinux_inline_attr;
+static const struct btf_link *vmlinux_inline_link;
+
+static const struct btf_link *btf_parse_link(void *start, unsigned int size)
+{
+	const struct btf_link *link = start;
+	unsigned int module_name_len;
+
+	if (!link || size != sizeof(*link) || link->btf_size == 0)
+		return NULL;
+
+	module_name_len = strnlen(link->module_name, sizeof(link->module_name));
+	if (!module_name_len || module_name_len == sizeof(link->module_name) ||
+	    memchr_inv(link->module_name + module_name_len + 1, 0,
+		       sizeof(link->module_name) - module_name_len - 1))
+		return NULL;
+	return link;
+}
+
+static bool btf_verify_link(const struct btf_link *link, const struct module *mod,
+			    const void *data, size_t data_size)
+{
+	u8 actual_digest[BTF_LINK_SHA256_LEN];
+
+	if (!link || data_size != link->btf_size) {
+		pr_warn(" BTF link from module [%s] missing or has unexpected size\n", mod->name);
+		return false;
+	}
+	sha256(data, data_size, actual_digest);
+	if (memcmp(actual_digest, link->sha256, sizeof(actual_digest))) {
+		pr_warn("BTF link from module [%s] has unexpected digest\n", mod->name);
+		return false;
+	}
+
+	return true;
+}
+
+static void btf_vmlinux_inline_lazy_init(void)
+{
+	vmlinux_inline_link = btf_parse_link(__start_BTF_inline_link,
+					     __stop_BTF_inline_link -
+					     __start_BTF_inline_link);
+	if (!vmlinux_inline_link) {
+		pr_warn("invalid vmlinux inline BTF link\n");
+		return;
+	}
+	vmlinux_inline_attr = sysfs_btf_add("vmlinux.inline", NULL,
+					    vmlinux_inline_link->btf_size, true,
+					    vmlinux_inline_link->module_name);
+	if (IS_ERR(vmlinux_inline_attr)) {
+		pr_warn("failed to register vmlinux inline BTF in sysfs: %ld\n",
+			PTR_ERR(vmlinux_inline_attr));
+		vmlinux_inline_attr = NULL;
+	}
+}
+
+static bool btf_module_is_vmlinux_inline(const struct module *mod)
+{
+	return vmlinux_inline_link && !strcmp(mod->name, vmlinux_inline_link->module_name);
+}
+
+static int btf_module_handle_vmlinux_inline(const struct module *mod)
+{
+	void *data;
+
+	if (!mod->btf_inline_data ||
+	    mod->btf_inline_data_size != vmlinux_inline_link->btf_size)
+		return -EINVAL;
+
+	data = vmalloc_user(mod->btf_inline_data_size);
+	if (!data)
+		return -ENOMEM;
+	memcpy(data, mod->btf_inline_data, mod->btf_inline_data_size);
+
+	if (!btf_verify_link(vmlinux_inline_link, mod, data, mod->btf_inline_data_size) ||
+	    !sysfs_btf_update(vmlinux_inline_attr, data)) {
+		kvfree(data);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+#else
+
+static bool btf_module_is_vmlinux_inline(const struct module *mod)
+{
+	return false;
+}
+
+static int btf_module_handle_vmlinux_inline(const struct module *mod)
+{
+	return 0;
+}
+
+static void btf_vmlinux_inline_lazy_init(void)
+{
+}
+
+#endif /* IS_MODULE(CONFIG_DEBUG_INFO_BTF_INLINE) */
+
 static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			     void *module)
 {
 	struct btf_module *btf_mod, *tmp;
 	struct module *mod = module;
+	struct bin_attribute *attr;
 	struct btf *btf;
 	int err = 0;
 
-	if (mod->btf_data_size == 0 ||
-	    (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
-	     op != MODULE_STATE_GOING))
+	if (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
+	    op != MODULE_STATE_GOING)
 		goto out;
 
 	switch (op) {
 	case MODULE_STATE_COMING:
+		if (btf_module_is_vmlinux_inline(mod)) {
+			err = btf_module_handle_vmlinux_inline(mod);
+			break;
+		}
+
+		if (!mod->btf_data_size)
+			break;
 		btf_mod = kzalloc_obj(*btf_mod);
 		if (!btf_mod) {
 			err = -ENOMEM;
@@ -9062,34 +9174,16 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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
+		attr = sysfs_btf_add(btf->name, btf->data, btf->data_size, false, NULL);
+		if (IS_ERR(attr)) {
+			err = 0;
+			goto out;
 		}
-
+		btf_mod->sysfs_attr = attr;
 		break;
 	case MODULE_STATE_LIVE:
+		if (!mod->btf_data_size)
+			break;
 		mutex_lock(&btf_module_mutex);
 		list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
 			if (btf_mod->module != module)
@@ -9101,6 +9195,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		mutex_unlock(&btf_module_mutex);
 		break;
 	case MODULE_STATE_GOING:
+		if (!mod->btf_data_size)
+			break;
 		mutex_lock(&btf_module_mutex);
 		list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
 			if (btf_mod->module != module)
@@ -9115,10 +9211,9 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
 			if (btf_mod->sysfs_attr)
-				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
+				sysfs_btf_remove(btf_mod->sysfs_attr);
 			purge_cand_cache(btf_mod->btf);
 			btf_put(btf_mod->btf);
-			kfree(btf_mod->sysfs_attr);
 			kfree(btf_mod);
 			break;
 		}
@@ -9135,6 +9230,7 @@ static struct notifier_block btf_module_nb = {
 
 static int __init btf_module_init(void)
 {
+	btf_vmlinux_inline_lazy_init();
 	register_module_notifier(&btf_module_nb);
 	return 0;
 }
diff --git a/kernel/bpf/btf_vmlinux_inline.c b/kernel/bpf/btf_vmlinux_inline.c
new file mode 100644
index 000000000000..d5c599d9f729
--- /dev/null
+++ b/kernel/bpf/btf_vmlinux_inline.c
@@ -0,0 +1,29 @@
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
+		sysfs_btf_add("vmlinux.inline", __start_BTF_inline, data_size, true, NULL);
+#endif
+	return 0;
+}
+subsys_initcall(btf_vmlinux_inline_init);
+
+MODULE_DESCRIPTION("BTF inline information for vmlinux");
+MODULE_LICENSE("GPL");
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index 9cbe15ce3540..556fe92c3649 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -6,8 +6,10 @@
 #include <linux/module.h>
 #include <linux/kobject.h>
 #include <linux/init.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/mm.h>
+#include <linux/vmalloc.h>
 #include <linux/io.h>
 #include <linux/btf.h>
 
@@ -15,16 +17,12 @@
 extern char __start_BTF[];
 extern char __stop_BTF[];
 
-static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
-				  const struct bin_attribute *attr,
-				  struct vm_area_struct *vma)
+static int btf_sysfs_mmap_check(void *data, size_t size, struct vm_area_struct *vma)
 {
-	unsigned long pages = PAGE_ALIGN(attr->size) >> PAGE_SHIFT;
+	unsigned long pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	size_t vm_size = vma->vm_end - vma->vm_start;
-	phys_addr_t addr = __pa_symbol(__start_BTF);
-	unsigned long pfn = addr >> PAGE_SHIFT;
 
-	if (attr->private != __start_BTF || !PAGE_ALIGNED(addr))
+	if (!data || !PAGE_ALIGNED((unsigned long)data))
 		return -EINVAL;
 
 	if (vma->vm_pgoff)
@@ -33,24 +31,153 @@ static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
 	if (vma->vm_flags & (VM_WRITE | VM_EXEC | VM_MAYSHARE))
 		return -EACCES;
 
-	if (pfn + pages < pfn)
-		return -EINVAL;
-
 	if ((vm_size >> PAGE_SHIFT) > pages)
 		return -EINVAL;
 
 	vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC | VM_MAYWRITE);
+	return 0;
+}
+
+static int btf_sysfs_mmap_image(struct file *filp, struct kobject *kobj,
+				const struct bin_attribute *attr,
+				struct vm_area_struct *vma)
+{
+	void *data = READ_ONCE(attr->private);
+	phys_addr_t addr;
+	unsigned long pfn;
+	size_t vm_size = vma->vm_end - vma->vm_start;
+	int err;
+
+	err = btf_sysfs_mmap_check(data, attr->size, vma);
+	if (err)
+		return err;
+
+	/* Kernel image addresses can lie inside the vmalloc range on arm64. */
+	addr = __pa_symbol(data);
+	pfn = addr >> PAGE_SHIFT;
+	if (pfn + (PAGE_ALIGN(attr->size) >> PAGE_SHIFT) < pfn)
+		return -EINVAL;
+
 	return remap_pfn_range(vma, vma->vm_start, pfn, vm_size, vma->vm_page_prot);
 }
 
 static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.attr = { .name = "vmlinux", .mode = 0444, },
 	.read = sysfs_bin_attr_simple_read,
-	.mmap = btf_sysfs_vmlinux_mmap,
+	.mmap = btf_sysfs_mmap_image,
 };
 
 struct kobject *btf_kobj;
 
+struct btf_sysfs_entry {
+	struct bin_attribute attr;
+	char *module_name;
+};
+
+static void *btf_sysfs_lazy_data(const struct bin_attribute *attr)
+{
+	struct btf_sysfs_entry *entry = container_of(attr, struct btf_sysfs_entry, attr);
+	void *data;
+
+	data = smp_load_acquire(&attr->private);
+	if (!data) {
+		request_module("%s", entry->module_name);
+		data = smp_load_acquire(&attr->private);
+	}
+	return data;
+}
+
+static ssize_t btf_sysfs_read_lazy(struct file *filp, struct kobject *kobj,
+				   const struct bin_attribute *attr, char *buf,
+				   loff_t off, size_t count)
+{
+	void *data = btf_sysfs_lazy_data(attr);
+
+	if (!data)
+		return -ENODEV;
+
+	return memory_read_from_buffer(buf, count, &off, data, attr->size);
+}
+
+static int btf_sysfs_mmap_lazy(struct file *filp, struct kobject *kobj,
+			       const struct bin_attribute *attr,
+			       struct vm_area_struct *vma)
+{
+	void *data = btf_sysfs_lazy_data(attr);
+	int err;
+
+	if (!data)
+		return -ENODEV;
+
+	err = btf_sysfs_mmap_check(data, attr->size, vma);
+	if (err)
+		return err;
+
+	return remap_vmalloc_range(vma, data, 0);
+}
+
+struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_size,
+				    bool mmap, const char *lazy_module_name)
+{
+	struct btf_sysfs_entry *entry;
+	struct bin_attribute *attr;
+	int err;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	attr = &entry->attr;
+	sysfs_bin_attr_init(attr);
+	attr->attr.mode = 0444;
+	attr->size = data_size;
+	attr->private = data;
+	attr->read = lazy_module_name ? btf_sysfs_read_lazy : sysfs_bin_attr_simple_read;
+	if (mmap)
+		attr->mmap = lazy_module_name ? btf_sysfs_mmap_lazy : btf_sysfs_mmap_image;
+	attr->attr.name = kstrdup(name, GFP_KERNEL);
+	if (!attr->attr.name) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+	if (lazy_module_name) {
+		entry->module_name = kstrdup(lazy_module_name, GFP_KERNEL);
+		if (!entry->module_name) {
+			err = -ENOMEM;
+			goto err_free;
+		}
+	}
+
+	err = sysfs_create_bin_file(btf_kobj, attr);
+	if (err) {
+		pr_warn("failed to register [%s] BTF in sysfs: %d\n", name, err);
+		goto err_free;
+	}
+
+	return attr;
+
+err_free:
+	kfree(entry->module_name);
+	kfree(attr->attr.name);
+	kfree(entry);
+	return ERR_PTR(err);
+}
+
+bool sysfs_btf_update(struct bin_attribute *attr, void *data)
+{
+	return attr && !cmpxchg(&attr->private, NULL, data);
+}
+
+void sysfs_btf_remove(struct bin_attribute *attr)
+{
+	struct btf_sysfs_entry *entry = container_of(attr, struct btf_sysfs_entry, attr);
+
+	sysfs_remove_bin_file(btf_kobj, attr);
+	kfree(entry->module_name);
+	kfree(attr->attr.name);
+	kfree(entry);
+}
+
 static int __init btf_vmlinux_init(void)
 {
 	bin_attr_btf_vmlinux.private = __start_BTF;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c1b34dc1e89a..5b9eb56164b2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2723,6 +2723,10 @@ static int find_module_sections(struct module *mod, struct load_info *info)
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
@@ -3176,6 +3180,9 @@ static noinline int do_init_module(struct module *mod)
 	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointers */
 	mod->btf_data = NULL;
 	mod->btf_base_data = NULL;
+#endif
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+	mod->btf_inline_data = NULL;
 #endif
 	/*
 	 * We want to free module_init, but be aware that kallsyms may be
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..2f34619905b6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -425,6 +425,12 @@ config PAHOLE_HAS_LANG_EXCLUDE
 	  otherwise it would emit malformed kernel and module binaries when
 	  using DEBUG_INFO_BTF_MODULES.
 
+config PAHOLE_HAS_INLINE
+	def_bool PAHOLE_VERSION >= 132
+	help
+	  Support for the "inline" BTF feature is available. It encodes
+	  information about inline sites and how to retrieve their parameters.
+
 config DEBUG_INFO_BTF_MODULES
 	bool "Generate BTF type information for kernel modules"
 	default y
@@ -432,6 +438,18 @@ config DEBUG_INFO_BTF_MODULES
 	help
 	  Generate compact split BTF type information for kernel modules.
 
+config DEBUG_INFO_BTF_INLINE
+	tristate "Provide information about inline sites in BTF"
+	default n
+	depends on DEBUG_INFO_BTF && PAHOLE_HAS_INLINE && SYSFS
+	select DEBUG_INFO_BTF_MODULES if MODULES
+	help
+	  Generate information about inline sites in .BTF.inline sections.
+	  These sections contain split BTF relative to the kernel or module BTF
+	  and are made available in /sys/kernel/btf with a ".inline" suffix.
+	  The information describes inline locations and how to retrieve their
+	  associated parameters.
+
 config MODULE_ALLOW_BTF_MISMATCH
 	bool "Allow loading modules with non-matching BTF type info"
 	depends on DEBUG_INFO_BTF_MODULES
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index a1812985a61a..98012344a81e 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -22,7 +22,14 @@ endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
+btf-inline := $(CONFIG_DEBUG_INFO_BTF_INLINE)
+ifneq ($(btf-inline),)
+btf-inline-feat := inline
+pahole-flags-$(call test-ge, $(pahole-ver), 132) += --btf_features=$(btf-inline-feat)
+endif
+
 export PAHOLE_FLAGS := $(pahole-flags-y)
+export BTF_INLINE := $(btf-inline)
 
 resolve-btfids-flags-y :=
 resolve-btfids-flags-$(CONFIG_WERROR) += --fatal_warnings
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index 8ca96eb10a69..e638291753d0 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -68,6 +68,10 @@ esac
 
 gen_btf_data()
 {
+	inline=""
+	if [ -n "${BTF_INLINE}" ] && [ -z "${BTF_BASE}" ]; then
+		inline="--inline"
+	fi
 	btf1="${ELF_FILE}.BTF.1"
 	${PAHOLE} -J ${PAHOLE_FLAGS}			\
 		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
@@ -76,6 +80,7 @@ gen_btf_data()
 
 	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_FLAGS}	\
 		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
+		${inline}				\
 		--btf ${btf1} "${ELF_FILE}"
 }
 
@@ -83,14 +88,28 @@ gen_btf_o()
 {
 	btf_data=${ELF_FILE}.btf.o
 
-	# Create ${btf_data} which contains just .BTF section but no symbols. Add
+	# Create ${btf_data} which contains just BTF sections but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
 	# deletes all symbols including __start_BTF and __stop_BTF, which will
 	# be redefined in the linker script.
 	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
 	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
 		--set-section-flags .BTF=alloc,readonly ${btf_data}
-	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
+	ONLY_SEC="--only-section=.BTF"
+	btf_inline=${ELF_FILE}.BTF.inline
+	if [ "${BTF_INLINE}" = "m" ]; then
+		if [ -f "${btf_inline}" ]; then
+			cp "${btf_inline}" "${objtree}/vmlinux.BTF.inline"
+		else
+			rm -f "${objtree}/vmlinux.BTF.inline"
+		fi
+	fi
+	if [ "${BTF_INLINE}" = "y" ] && [ -f "${btf_inline}" ]; then
+		${OBJCOPY} --add-section .BTF.inline=${btf_inline} \
+			--set-section-flags .BTF.inline=alloc,readonly ${btf_data}
+		ONLY_SEC="${ONLY_SEC} --only-section=.BTF.inline"
+	fi
+	${OBJCOPY} ${ONLY_SEC} --strip-all ${btf_data}
 
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
 	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
@@ -111,6 +130,15 @@ embed_btf_data()
 	if [ -f "${btf_base}" ]; then
 		${OBJCOPY} --add-section .BTF.base=${btf_base} ${ELF_FILE}
 	fi
+	btf_inline=""
+	case "${ELF_FILE}" in
+	*/btf_vmlinux_inline.ko)
+		btf_inline=${BTF_BASE}.BTF.inline
+		;;
+	esac
+	if [ -n "${BTF_INLINE}" ] && [ -f "${btf_inline}" ]; then
+		${OBJCOPY} --add-section .BTF.inline=${btf_inline} ${ELF_FILE}
+	fi
 	btf_ids="${ELF_FILE}.BTF_ids"
 	if [ -f "${btf_ids}" ]; then
 		${RESOLVE_BTFIDS} --patch_btfids ${btf_ids} ${ELF_FILE}
@@ -121,6 +149,8 @@ cleanup()
 {
 	rm -f "${ELF_FILE}.BTF.1"
 	rm -f "${ELF_FILE}.BTF"
+	rm -f "${ELF_FILE}.BTF.inline"
+	rm -f "${ELF_FILE}.BTF.inline.link"
 	if [ "${BTFGEN_MODE}" = "module" ]; then
 		rm -f "${ELF_FILE}.BTF.base"
 		rm -f "${ELF_FILE}.BTF_ids"
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index ab0b8125c8cb..5424caf5135b 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -289,7 +289,13 @@ vmlinux_link "${VMLINUX}"
 
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	info BTFIDS ${VMLINUX}
-	${RESOLVE_BTFIDS} --patch_btfids ${btfids_vmlinux} ${VMLINUX}
+	if [ "${BTF_INLINE}" = "m" ]; then
+		${RESOLVE_BTFIDS} --patch_btfids ${btfids_vmlinux} \
+			--btf_link .BTF.inline:btf_vmlinux_inline:vmlinux.BTF.inline \
+			${VMLINUX}
+	else
+		${RESOLVE_BTFIDS} --patch_btfids ${btfids_vmlinux} ${VMLINUX}
+	fi
 fi
 
 mksysmap "${VMLINUX}" System.map
diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 46e80970f723..8f0933cbbe45 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -68,13 +68,13 @@ This package provides debug information for the kernel image and modules from th
 %undefine _debugsource_packages
 %undefine _debuginfo_subpackages
 
-# Preserve .BTF and .BTF.base sections in kernel modules during debuginfo
-# stripping. find-debuginfo.sh uses eu-strip which removes non-allocated ELF
-# sections like .BTF by default. .BTF.base is required for BTF distillation
-# support; without it, module BTF validation fails.
+# Preserve .BTF,  .BTF.base and .BTF.inline sections in kernel modules during
+# debuginfo stripping. find-debuginfo.sh uses eu-strip which removes
+# non-allocated ELF sections like .BTF by default. .BTF.base is required for
+# BTF distillation support; without it, module BTF validation fails.
 %global with_keep_section %(%{__find_debuginfo} --help 2>&1 | grep -c keep-section)
 %if %{with_keep_section}
-%global _find_debuginfo_opts -r --keep-section .BTF --keep-section .BTF.base
+%global _find_debuginfo_opts -r --keep-section .BTF --keep-section .BTF.base --keep-section .BTF.inline
 %else
 %global _find_debuginfo_opts -r
 %endif
-- 
2.43.5

