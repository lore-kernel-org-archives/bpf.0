Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9230B51D;
	Fri, 29 May 2026 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780092761; cv=none; b=kUOHuv6HPNb/iCBbyi87z0DEOkfyAvzqueAFXR7zAhh3BxWm4MxcVQS9M+KeZg24gJhR3O4pX/nRBzprPafp1fWRU4cw7dHEqvdp0aOrrFxe1illkyNaJouSA77QU8o4vcFQTumkRlA6JGaHQDmW8eO7Vn08HzckOPSvo+J8kkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780092761; c=relaxed/simple;
	bh=GkJC3egb4LS1ayZPA66NZ/YQZuamGbqIAJf5LPP1Qbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I62gw8tCMHWB9tsH1R+M2MQKW3k2m8x75aVykW+Gb5N0JVDOUwJZBQMjQxUgTvZvWF67GLySVraDbdY8g+8EzVP6LJtd93U9T8w0SV4B7Z8WOGey044fd/2oQvxfVcCwlODwGkOi5A5e6jGN0VhDZSj4vbrYk7fvdWG6YRRPvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VeFZeFSo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VeFZeFSo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Nog/jWc5yi9ePYTbIawRZOv/Eax+bE3eHqXgfQPwFso=; b=VeFZeFSo7xwGlByhVOSwCTTi7O
	suo1VnrLTBX54syLYHoQ5uVGOIrEkYuqYQ/eepO1EQjVQIHYfhsBba8kpz5/8R1yGeg+Y4/DAhw86
	ZxBAHwJro7r/ivrT57UBFy9BZzzh6TDW3xs60dzlHN1++EHG2gWZe5QqGzIM7thcUtaDsZp1Dg7DV
	3EDozXVZBm7FeOSm0dC1ZBE2eR4diwnK59twu5OsMo8WTgQkea3tcyVZdOGDHiT007NrMb/AN27L2
	cx89n0oLuxr2SoznXV/QZvxuDzONJy+SMwJk7waNuJfH488aNbcTz/aR2LGDpgtJQ1or2uxd8ctk5
	CSlwa9+Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wT5RT-0005Vj-11;
	Sat, 30 May 2026 00:12:35 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: brauner@kernel.org
Cc: alexei.starovoitov@gmail.com,
	bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH vfs-7.2.xattr v2] bpf: Add simple xattr support to bpffs
Date: Sat, 30 May 2026 00:12:34 +0200
Message-ID: <20260529221234.324174-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28015/Fri May 29 08:24:51 2026)

Add support for extended attributes on bpffs inodes so that user space
and BPF LSM programs can attach metadata, for example, a content hash
or a security label - to a pinned object or directory. BPF LSM or user
space tooling can then uniformly look at this (e.g. security.bpf.*) in
similar way to other fs'es. The store is in-memory and non-persistent:
it lives only for the lifetime of the mount, like everything else in
bpffs. The modelling is similar to tmpfs.

bpffs serves the trusted.* and security.* namespaces; user.* is left
unsupported. As bpffs is FS_USERNS_MOUNT, security.* is reachable by
the unprivileged mounter in a user namespace, and thus we are using
the simple_xattr_set_limited infra there (trusted.* needs global
CAP_SYS_ADMIN).

bpf_fill_super() is open-coded instead of using simple_fill_super(),
because the root inode must now be allocated through bpf_fs_alloc_inode()
i.e. carry the bpf_fs_inode wrapper and come from the right cache -
which requires s_op (and s_xattr) to be installed before the first
inode is created. While at it, also harden s_iflags with SB_I_NOEXEC
and SB_I_NODEV.

bpf_fs_listxattr() is only reachable through the filesystem via
i_op->listxattr, so the BPF token inode is left untouched. Name-based
fsetxattr()/fgetxattr() on a token fd still work since the get/set
handlers are installed at the superblock.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1->v2:
  - Rebase against vfs-7.2.xattr for routing via vfs given it
    contains simple xattr rework (Christian, Alexei)
  - Use simple_xattr_set_limited for security.* namespace (sashiko)
  - Dropped user.* namespace (sashiko)

 include/linux/bpf.h |   3 +
 kernel/bpf/inode.c  | 248 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 234 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4b703c90ca9..434ba91401c6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -31,6 +31,7 @@
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
+#include <linux/xattr.h>
 #include <asm/rqspinlock.h>
 
 struct bpf_verifier_env;
@@ -1918,6 +1919,8 @@ struct bpf_mount_opts {
 	u64 delegate_maps;
 	u64 delegate_progs;
 	u64 delegate_attachs;
+
+	struct simple_xattr_cache xa_cache;
 };
 
 struct bpf_token {
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 25c06a011825..7bd21cf4e857 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -21,6 +21,9 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/kstrtox.h>
+#include <linux/xattr.h>
+#include <linux/security.h>
+
 #include "preload/bpf_preload.h"
 
 enum bpf_type {
@@ -30,6 +33,23 @@ enum bpf_type {
 	BPF_TYPE_LINK,
 };
 
+struct bpf_fs_inode {
+	struct list_head		xattrs;
+	struct simple_xattr_limits	xlimits;
+	struct inode			vfs_inode;
+};
+
+static inline struct bpf_fs_inode *BPF_FS_I(struct inode *inode)
+{
+	return container_of(inode, struct bpf_fs_inode, vfs_inode);
+}
+
+static struct kmem_cache *bpf_fs_inode_cachep __ro_after_init;
+
+static int bpf_fs_initxattrs(struct inode *inode,
+			     const struct xattr *xattr_array, void *fs_info);
+static ssize_t bpf_fs_listxattr(struct dentry *dentry, char *buf, size_t size);
+
 static void *bpf_any_get(void *raw, enum bpf_type type)
 {
 	switch (type) {
@@ -94,10 +114,17 @@ static void *bpf_fd_probe_obj(u32 ufd, enum bpf_type *type)
 }
 
 static const struct inode_operations bpf_dir_iops;
+static const struct inode_operations bpf_symlink_iops;
 
-static const struct inode_operations bpf_prog_iops = { };
-static const struct inode_operations bpf_map_iops  = { };
-static const struct inode_operations bpf_link_iops  = { };
+static const struct inode_operations bpf_prog_iops = {
+	.listxattr	= bpf_fs_listxattr,
+};
+static const struct inode_operations bpf_map_iops  = {
+	.listxattr	= bpf_fs_listxattr,
+};
+static const struct inode_operations bpf_link_iops  = {
+	.listxattr	= bpf_fs_listxattr,
+};
 
 struct inode *bpf_get_inode(struct super_block *sb,
 			    const struct inode *dir,
@@ -153,11 +180,19 @@ static struct dentry *bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
+	int ret;
 
 	inode = bpf_get_inode(dir->i_sb, dir, mode | S_IFDIR);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
+	ret = security_inode_init_security(inode, dir, &dentry->d_name,
+					   bpf_fs_initxattrs, NULL);
+	if (ret && ret != -EOPNOTSUPP) {
+		iput(inode);
+		return ERR_PTR(ret);
+	}
+
 	inode->i_op = &bpf_dir_iops;
 	inode->i_fop = &simple_dir_operations;
 
@@ -330,10 +365,20 @@ static int bpf_mkobj_ops(struct dentry *dentry, umode_t mode, void *raw,
 			 const struct file_operations *fops)
 {
 	struct inode *dir = dentry->d_parent->d_inode;
-	struct inode *inode = bpf_get_inode(dir->i_sb, dir, mode);
+	struct inode *inode;
+	int ret;
+
+	inode = bpf_get_inode(dir->i_sb, dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
+	ret = security_inode_init_security(inode, dir, &dentry->d_name,
+					   bpf_fs_initxattrs, NULL);
+	if (ret && ret != -EOPNOTSUPP) {
+		iput(inode);
+		return ret;
+	}
+
 	inode->i_op = iops;
 	inode->i_fop = fops;
 	inode->i_private = raw;
@@ -382,9 +427,11 @@ bpf_lookup(struct inode *dir, struct dentry *dentry, unsigned flags)
 static int bpf_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, const char *target)
 {
-	char *link = kstrdup(target, GFP_USER | __GFP_NOWARN);
 	struct inode *inode;
+	char *link;
+	int ret;
 
+	link = kstrdup(target, GFP_USER | __GFP_NOWARN);
 	if (!link)
 		return -ENOMEM;
 
@@ -394,13 +441,25 @@ static int bpf_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		return PTR_ERR(inode);
 	}
 
-	inode->i_op = &simple_symlink_inode_operations;
+	inode->i_op = &bpf_symlink_iops;
 	inode->i_link = link;
 
+	ret = security_inode_init_security(inode, dir, &dentry->d_name,
+					   bpf_fs_initxattrs, NULL);
+	if (ret && ret != -EOPNOTSUPP) {
+		iput(inode);
+		return ret;
+	}
+
 	bpf_dentry_finalize(dentry, inode, dir);
 	return 0;
 }
 
+static const struct inode_operations bpf_symlink_iops = {
+	.get_link	= simple_get_link,
+	.listxattr	= bpf_fs_listxattr,
+};
+
 static const struct inode_operations bpf_dir_iops = {
 	.lookup		= bpf_lookup,
 	.mkdir		= bpf_mkdir,
@@ -409,6 +468,7 @@ static const struct inode_operations bpf_dir_iops = {
 	.rename		= simple_rename,
 	.link		= simple_link,
 	.unlink		= simple_unlink,
+	.listxattr	= bpf_fs_listxattr,
 };
 
 /* pin iterator link into bpffs */
@@ -762,22 +822,143 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static struct inode *bpf_fs_alloc_inode(struct super_block *sb)
+{
+	struct bpf_fs_inode *bi;
+
+	bi = alloc_inode_sb(sb, bpf_fs_inode_cachep, GFP_KERNEL);
+	if (!bi)
+		return NULL;
+	INIT_LIST_HEAD_RCU(&bi->xattrs);
+	simple_xattr_limits_init(&bi->xlimits);
+	return &bi->vfs_inode;
+}
+
 static void bpf_destroy_inode(struct inode *inode)
 {
+	struct bpf_mount_opts *opts = inode->i_sb->s_fs_info;
+	struct bpf_fs_inode *bi = BPF_FS_I(inode);
 	enum bpf_type type;
 
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
 	if (!bpf_inode_type(inode, &type))
 		bpf_any_put(inode->i_private, type);
-	free_inode_nonrcu(inode);
+	simple_xattrs_free(&opts->xa_cache, &bi->xattrs, NULL);
+}
+
+static void bpf_free_inode(struct inode *inode)
+{
+	kmem_cache_free(bpf_fs_inode_cachep, BPF_FS_I(inode));
+}
+
+static int bpf_fs_xattr_get(const struct xattr_handler *handler,
+			    struct dentry *unused, struct inode *inode,
+			    const char *name, void *value, size_t size)
+{
+	struct bpf_mount_opts *opts = inode->i_sb->s_fs_info;
+	struct bpf_fs_inode *bi = BPF_FS_I(inode);
+
+	name = xattr_full_name(handler, name);
+	return simple_xattr_get(&opts->xa_cache, &bi->xattrs, name, value, size);
+}
+
+enum {
+	BPF_FS_XATTR_SECURITY,
+	BPF_FS_XATTR_TRUSTED,
+};
+
+static int bpf_fs_xattr_set(const struct xattr_handler *handler,
+			    struct mnt_idmap *idmap, struct dentry *unused,
+			    struct inode *inode, const char *name,
+			    const void *value, size_t size, int flags)
+{
+	struct bpf_mount_opts *opts = inode->i_sb->s_fs_info;
+	struct bpf_fs_inode *bi = BPF_FS_I(inode);
+	struct simple_xattr *old;
+	int err;
+
+	name = xattr_full_name(handler, name);
+	if (handler->flags == BPF_FS_XATTR_SECURITY) {
+		err = simple_xattr_set_limited(&opts->xa_cache, &bi->xattrs,
+					       &bi->xlimits, name, value, size,
+					       flags);
+	} else {
+		old = simple_xattr_set(&opts->xa_cache, &bi->xattrs, name,
+				       value, size, flags);
+		err = IS_ERR(old) ? PTR_ERR(old) : 0;
+		if (!err)
+			simple_xattr_free_rcu(old);
+	}
+	if (err)
+		return err;
+	inode_set_ctime_current(inode);
+	return 0;
+}
+
+static const struct xattr_handler bpf_fs_trusted_xattr_handler = {
+	.prefix	= XATTR_TRUSTED_PREFIX,
+	.flags	= BPF_FS_XATTR_TRUSTED,
+	.get	= bpf_fs_xattr_get,
+	.set	= bpf_fs_xattr_set,
+};
+
+static const struct xattr_handler bpf_fs_security_xattr_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.flags	= BPF_FS_XATTR_SECURITY,
+	.get	= bpf_fs_xattr_get,
+	.set	= bpf_fs_xattr_set,
+};
+
+static const struct xattr_handler * const bpf_fs_xattr_handlers[] = {
+	&bpf_fs_trusted_xattr_handler,
+	&bpf_fs_security_xattr_handler,
+	NULL,
+};
+
+static ssize_t bpf_fs_listxattr(struct dentry *dentry, char *buf, size_t size)
+{
+	struct inode *inode = d_inode(dentry);
+
+	return simple_xattr_list(inode, &BPF_FS_I(inode)->xattrs, buf, size);
+}
+
+static int bpf_fs_initxattrs(struct inode *inode,
+			     const struct xattr *xattr_array, void *fs_info)
+{
+	struct bpf_mount_opts *opts = inode->i_sb->s_fs_info;
+	struct bpf_fs_inode *bi = BPF_FS_I(inode);
+	const struct xattr *xattr;
+
+	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
+		CLASS(simple_xattr, new_xattr)(xattr->value, xattr->value_len);
+		if (IS_ERR(new_xattr))
+			break;
+
+		new_xattr->name = kasprintf(GFP_KERNEL_ACCOUNT,
+					    XATTR_SECURITY_PREFIX "%s",
+					    xattr->name);
+		if (!new_xattr->name)
+			break;
+		if (simple_xattr_add(&opts->xa_cache, &bi->xattrs, new_xattr))
+			break;
+
+		retain_and_null_ptr(new_xattr);
+	}
+
+	if (xattr->name != NULL)
+		return -ENOMEM;
+
+	return 0;
 }
 
 const struct super_operations bpf_super_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= inode_just_drop,
 	.show_options	= bpf_show_options,
+	.alloc_inode	= bpf_fs_alloc_inode,
 	.destroy_inode	= bpf_destroy_inode,
+	.free_inode	= bpf_free_inode,
 };
 
 enum {
@@ -996,25 +1177,38 @@ static int populate_bpffs(struct dentry *parent)
 
 static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	static const struct tree_descr bpf_rfiles[] = { { "" } };
 	struct bpf_mount_opts *opts = sb->s_fs_info;
 	struct inode *inode;
-	int ret;
 
 	/* Mounting an instance of BPF FS requires privileges */
 	if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
-	if (ret)
-		return ret;
-
+	sb->s_blocksize = PAGE_SIZE;
+	sb->s_blocksize_bits = PAGE_SHIFT;
+	sb->s_magic = BPF_FS_MAGIC;
 	sb->s_op = &bpf_super_ops;
+	sb->s_xattr = bpf_fs_xattr_handlers;
+	sb->s_iflags |= SB_I_NOEXEC;
+	sb->s_iflags |= SB_I_NODEV;
+	sb->s_time_gran = 1;
+
+	inode = bpf_get_inode(sb, NULL, S_IFDIR | 0777);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	inode->i_ino = 1;
+	inode->i_op = &bpf_dir_iops;
+	inode->i_fop = &simple_dir_operations;
+	set_nlink(inode, 2);
+
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		return -ENOMEM;
 
-	inode = sb->s_root->d_inode;
+	inode = d_inode(sb->s_root);
 	inode->i_uid = opts->uid;
 	inode->i_gid = opts->gid;
-	inode->i_op = &bpf_dir_iops;
 	inode->i_mode &= ~S_IALLUGO;
 	populate_bpffs(sb->s_root);
 	inode->i_mode |= S_ISVTX | opts->mode;
@@ -1068,6 +1262,7 @@ static void bpf_kill_super(struct super_block *sb)
 	struct bpf_mount_opts *opts = sb->s_fs_info;
 
 	kill_anon_super(sb);
+	simple_xattr_cache_cleanup(&opts->xa_cache);
 	kfree(opts);
 }
 
@@ -1080,18 +1275,37 @@ static struct file_system_type bpf_fs_type = {
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
+static void bpf_fs_inode_init_once(void *foo)
+{
+	struct bpf_fs_inode *bi = foo;
+
+	inode_init_once(&bi->vfs_inode);
+}
+
 static int __init bpf_init(void)
 {
 	int ret;
 
+	bpf_fs_inode_cachep = kmem_cache_create("bpf_fs_inode_cache",
+						sizeof(struct bpf_fs_inode), 0,
+						SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
+						bpf_fs_inode_init_once);
+	if (!bpf_fs_inode_cachep)
+		return -ENOMEM;
+
 	ret = sysfs_create_mount_point(fs_kobj, "bpf");
 	if (ret)
-		return ret;
+		goto out_cache;
 
 	ret = register_filesystem(&bpf_fs_type);
-	if (ret)
+	if (ret) {
 		sysfs_remove_mount_point(fs_kobj, "bpf");
+		goto out_cache;
+	}
 
+	return 0;
+out_cache:
+	kmem_cache_destroy(bpf_fs_inode_cachep);
 	return ret;
 }
 fs_initcall(bpf_init);
-- 
2.43.0

