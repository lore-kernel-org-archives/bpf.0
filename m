Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46EE3DD870
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484874; cv=none; b=ZuDONrshBDUdk0YzIwcimQ5NgTa4ETiwtR5TQH/oXslNVT1MocwMLmZIs/qNCX6V2UHfuCN+kRtaNLOfyIOTTTRyaXiCv7zIG1iOLQcSKYoirSqfhvuv5XIpzqjpcAp2NGCWLGTsL+ToD74M0WP1rOH22YnGXpb8EBg/FUpQgdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484874; c=relaxed/simple;
	bh=kw/ukZr21kE1jo6e3TNqLspPowIphR0Y27dQSsoEJJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3Bbj4KN10aPVDWYkAsmzdy1bl9BlbREm+2ZhU0NS4GTUXeEDe20M0IT6ODcG2cM+z4uVcbCwOWWvXnF8AYSdgVyxkLwP5U9+ktjvns7WPjtZj1430cOAVlWl9h4vBp1Ddm4k9/rTxAcI/m/+eQkmPaEYOBERE3EkdOmHbMATQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=A+9dqhLQ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="A+9dqhLQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OlEn8KsEfGCQmB6c/U3Mb+yYg3UKNGr7maRvcrDv6rE=; b=A+9dqhLQda3sNTevsGK6W4d9Ix
	I7OXRt6o37vzjZaq1fTkLu+wy6NDBfZLEDnLeMv77HgZnEHqlZk4Es4wNLF6MrptNH01joLEI9iIp
	PZ3bLQHeqhMcMARSqoLKoOykJQdzPQaisytg6Tyo/IowmxCe6H4Kvi42Uz8ZW1KtxyTORJLdHKc7Z
	dQlm9kvpXm2WtrDE9sTipDziN/Q5Zg12bzUThE/VHO8p8S59cBJyFlCEgMJxGV+pD/yuubcCMsRRr
	ovw/QpMyplhTEIUDjtyHBYrArCEA0XtNb2Gx3NttyW/E5wGUSJAhzeSDu/7hXp/K/N9x+vfh0qV9O
	reknucOQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6Ul6-0007KQ-0Y;
	Tue, 15 Sep 2026 17:07:44 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: brauner@kernel.org,
	dwindsor@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at inode creation
Date: Tue, 15 Sep 2026 17:07:35 +0200
Message-ID: <20260915150739.284189-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915150739.284189-1-daniel@iogearbox.net>
References: <20260915150739.284189-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28124/Tue Sep 15 08:27:28 2026)

From: David Windsor <dwindsor@gmail.com>

Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in extended
attributes. For these LSMs, atomic labeling during inode creation is
critical: if the inode becomes accessible before its xattr is set, it is
briefly unlabeled, which can disrupt LSMs making policy decisions based
on file labels. Existing LSMs solve this by setting xattrs in the
inode_init_security hook, which runs before the inode becomes accessible.
BPF LSM programs currently lack this capability because the hook uses an
output parameter (xattr_count) that BPF programs cannot write to, and
existing kfuncs like bpf_set_dentry_xattr() require a dentry that isn't
available until after the inode is accessible.

Add a bpf_inode_init_xattr() kfunc that takes the hook's own xattrs and
xattr_count arguments, passed through from the program's context, and
claims a slot via lsm_get_xattr_slot() on the program's behalf. The
xattr_count output argument is exposed to inode_init_security programs
as trusted read-only memory, so programs can pass it to the kfunc but
cannot modify the count themselves.

Reserve BPF_LSM_INODE_INIT_XATTRS slots in bpf_lsm_blob_sizes the way
every other xattr-providing LSM does, for the life of the kernel. The
framework keys the collection off the reserved slot count, so a kernel
built with CONFIG_BPF_LSM=y now allocates the xattr array on every inode
creation, whether or not a program sits on the hook.

Give the hook a strong prototype in bpf_lsm_proto.c so that its qstr and
xattrs arguments are marked __nullable. Both can be NULL for some callers.
Without the annotation the verifier otherwise hands the program a trusted
non-NULL pointer which it dereferences. Also, keep the hook out of the
sleepable set. inode_init_security runs inside the transaction creating
the inode, with a journal handle held on ext4 and btrfs and the parent's
i_rwsem down, which is why everything on the path allocates GFP_NOFS.

Signed-off-by: David Windsor <dwindsor@gmail.com>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 fs/bpf_fs_kfuncs.c         | 99 ++++++++++++++++++++++++++++++++++++++
 include/linux/bpf_lsm.h    | 11 ++++-
 kernel/bpf/bpf_lsm.c       | 22 ++++++++-
 kernel/bpf/bpf_lsm_proto.c | 15 ++++++
 security/bpf/hooks.c       |  1 +
 5 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 6cb877267978..c51c3ae8063b 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -11,6 +11,7 @@
 #include <linux/fsnotify.h>
 #include <linux/file.h>
 #include <linux/kernfs.h>
+#include <linux/lsm_hooks.h>
 #include <linux/mm.h>
 #include <linux/net.h>
 #include <linux/xattr.h>
@@ -328,6 +329,89 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name_
 	return ret;
 }
 
+static int bpf_inode_init_xattrs_claimed(const struct xattr *xattrs, int xattr_count)
+{
+	const size_t suffix_len = sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
+	int i, claimed = 0;
+
+	for (i = 0; i < xattr_count; i++) {
+		const char *name = xattrs[i].name;
+
+		if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, suffix_len))
+			claimed++;
+	}
+	return claimed;
+}
+
+/**
+ * bpf_inode_init_xattr - attach a xattr to an inode that is being created
+ * @xattrs: xattr array the inode_init_security hook was handed
+ * @xattr_count__ctx_out: xattr count the inode_init_security hook was handed
+ * @name__str: name of the xattr
+ * @value_p: xattr value
+ *
+ * Claim one of the slots the BPF LSM reserved in the xattr array, so that
+ * the xattr is written out as part of the transaction creating the inode.
+ *
+ * For security reasons, only *name__str* with prefix "security.bpf." is
+ * allowed. The slot stores the name without that "security." prefix, which
+ * the filesystem's initxattrs() callback puts back.
+ *
+ * At most BPF_LSM_INODE_INIT_XATTRS xattrs can be attached to one inode,
+ * matching the number of slots the BPF LSM reserves.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_inode_init_xattr(struct xattr *xattrs,
+				     int *xattr_count__ctx_out,
+				     const char *name__str,
+				     const struct bpf_dynptr *value_p)
+{
+	const struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	int *xattr_count = xattr_count__ctx_out;
+	const char *suffix;
+	struct xattr *slot;
+	const void *value;
+	size_t name_len;
+	u32 value_len;
+	char *buf;
+
+	if (!match_security_bpf_prefix(name__str))
+		return -EPERM;
+	if (bpf_inode_init_xattrs_claimed(xattrs, *xattr_count) >=
+	    BPF_LSM_INODE_INIT_XATTRS)
+		return -ENOSPC;
+
+	suffix = name__str + XATTR_SECURITY_PREFIX_LEN;
+	name_len = strlen(suffix);
+	if (name_len <= sizeof(XATTR_BPF_LSM_SUFFIX) - 1 ||
+	    name_len > XATTR_NAME_MAX - XATTR_SECURITY_PREFIX_LEN)
+		return -EINVAL;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	value = __bpf_dynptr_data(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+	if (value_len > XATTR_SIZE_MAX)
+		return -E2BIG;
+
+	buf = kmalloc(value_len + name_len + 1, GFP_NOWAIT | __GFP_NOWARN);
+	if (!buf)
+		return -ENOMEM;
+	memcpy(buf, value, value_len);
+	memcpy(buf + value_len, suffix, name_len + 1);
+
+	slot = lsm_get_xattr_slot(xattrs, xattr_count);
+	if (!slot) {
+		kfree(buf);
+		return -ENOSPC;
+	}
+	slot->value = buf;
+	slot->value_len = value_len;
+	slot->name = buf + value_len;
+	return 0;
+}
+
 #ifdef CONFIG_CGROUPS
 /**
  * bpf_cgroup_read_xattr - read xattr of a cgroup's node in cgroupfs
@@ -425,6 +509,7 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_inode_init_xattr)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_sock_read_xattr, KF_RCU)
 #endif
@@ -436,10 +521,24 @@ BTF_ID(func, bpf_set_dentry_xattr)
 BTF_ID(func, bpf_remove_dentry_xattr)
 BTF_SET_END(bpf_fs_kfunc_lsm_only_ids)
 
+BTF_ID_LIST_SINGLE(bpf_inode_init_xattr_ids, func, bpf_inode_init_xattr)
+
+BTF_SET_START(bpf_inode_init_xattr_hooks)
+BTF_ID(func, bpf_lsm_inode_init_security)
+BTF_SET_END(bpf_inode_init_xattr_hooks)
+
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id))
 		return 0;
+	if (kfunc_id == bpf_inode_init_xattr_ids[0]) {
+		if (prog->type != BPF_PROG_TYPE_LSM ||
+		    prog->expected_attach_type != BPF_LSM_MAC ||
+		    !btf_id_set_contains(&bpf_inode_init_xattr_hooks,
+					 prog->aux->attach_btf_id))
+			return -EACCES;
+		return 0;
+	}
 	if (prog->type == BPF_PROG_TYPE_LSM)
 		return 0;
 	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index dda272d78f01..eb4a38eef87e 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -21,6 +21,13 @@ extern bool bpf_lsm_initialized __ro_after_init;
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+/*
+ * Number of xattr slots the BPF LSM reserves in the array handed to
+ * security_inode_init_security(), i.e. the maximum number of labels
+ * a policy may attach to an inode while it is being created.
+ */
+#define BPF_LSM_INODE_INIT_XATTRS	2
+
 struct bpf_storage_blob {
 	struct bpf_local_storage __rcu *storage;
 };
@@ -28,7 +35,7 @@ struct bpf_storage_blob {
 extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
 
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
-			const struct bpf_prog *prog);
+			struct bpf_prog *prog);
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id);
 bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
@@ -71,7 +78,7 @@ static inline bool bpf_lsm_is_trusted(const struct bpf_prog *prog)
 }
 
 static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
-				      const struct bpf_prog *prog)
+				      struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 2660a89fc8d7..f58dce888ff4 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -116,8 +116,11 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 }
 #endif
 
+BTF_ID_LIST_SINGLE(bpf_lsm_inode_init_security_btf_id, func,
+		   bpf_lsm_inode_init_security)
+
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
-			const struct bpf_prog *prog)
+			struct bpf_prog *prog)
 {
 	u32 btf_id = prog->aux->attach_btf_id;
 	const char *func_name = prog->aux->attach_func_name;
@@ -140,6 +143,23 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 		return -EINVAL;
 	}
 
+	if (btf_id == bpf_lsm_inode_init_security_btf_id[0]) {
+		/*
+		 * inode, dir, qstr, xattrs, xattr_count
+		 *
+		 * The trusted pointer this hands the program is only as
+		 * trustworthy as the context it is loaded from, which
+		 * lsm_verifier_ops keeps read-only.
+		 */
+		static const struct bpf_ctx_arg_aux xattr_count_arg_info = {
+			.offset		= 4 * sizeof(u64),
+			.reg_type	= PTR_TO_MEM | MEM_RDONLY | PTR_TRUSTED,
+			.mem_size	= sizeof(int),
+		};
+
+		return bpf_prog_ctx_arg_info_init(prog, &xattr_count_arg_info, 1);
+	}
+
 	return 0;
 }
 
diff --git a/kernel/bpf/bpf_lsm_proto.c b/kernel/bpf/bpf_lsm_proto.c
index 44a54fd8045e..4a776df76cbb 100644
--- a/kernel/bpf/bpf_lsm_proto.c
+++ b/kernel/bpf/bpf_lsm_proto.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/xattr.h>
 #include <linux/bpf_lsm.h>
 
 /*
@@ -17,3 +18,17 @@ int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
 {
 	return 0;
 }
+
+/*
+ * Strong definition of the inode_init_security() BPF LSM hook. Both the
+ * qstr and the xattr array are NULL for some callers, so the __nullable
+ * suffix marks it as PTR_MAYBE_NULL. BPF LSM programs have to check before
+ * dereferencing them or handing them to bpf_inode_init_xattr().
+ */
+int bpf_lsm_inode_init_security(struct inode *inode, struct inode *dir,
+				const struct qstr *qstr__nullable,
+				struct xattr *xattrs__nullable,
+				int *xattr_count)
+{
+	return -EOPNOTSUPP;
+}
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 7b98f5d1e2be..8f8c3de3035f 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -33,6 +33,7 @@ static int __init bpf_lsm_init(void)
 
 struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
+	.lbs_xattr_count = BPF_LSM_INODE_INIT_XATTRS,
 };
 
 DEFINE_LSM(bpf) = {
-- 
2.43.0

