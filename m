Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F55431A3D;
	Thu, 30 Jul 2026 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418486; cv=none; b=nirVGBX3iH1NVOxG8AAU0hiYzgMBSsFgp+IYCOT9rS1/re41YPMbqIeDKX+gMeR3gtchtQLGQkzKM/iro67IuWClDCFY3ghrtKNA1TLv8Xyj9TSH+z8SzpcgsgpEDdK2Vzh+qCHIC1HI6ugSidxjhosteHzvYi9wk3FadRbtOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418486; c=relaxed/simple;
	bh=ffubVVduLLMfNxpTpX0sw0fYfFiETwOhHJHux38zrPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2wgSDtH0HUCpAf9tNyYZapciMfL6v3YXOKPqP2hnXbUjSdGjAW18JauX3I33jSXQgWkQi9j1fE4v8iuEv8AzKG/mZer+MXFi8L9tjhsM4kCOObGBJdexsw2yBLM9ru5KhkGhADIKktBUuWyb4lJypBkIcDV7XcEDyUvSN876dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbqEvvt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbqEvvt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EFE1F00A3D;
	Thu, 30 Jul 2026 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785418485;
	bh=ZOVAZcleFesftTESMiI+I5WLr6SsWO6dEuEGcLcphYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QbqEvvt/WhuGlPOLcAdtMUTIWMeAnmAYVMgmkeZyg8u4r2tV2ydaYiNn10ZY9KWDY
	 wQlitPO//HGvF+M7Wjn1PNxqVpo9fJy9+x4Er6UeffOTS2mXpXFGq05HWWiA41Oa8S
	 8W4mg2bPb1NXlS8fPNs5JO5WnNwmWH2uapmGVIBstN/DEOEI5cPf3kcqflsaaTgxn4
	 4HLTW8DJ4ENRJhkByIb9LEiRL0w1EPdnAiwEHkn2iTDTbUnII6PyXbCXbyNIPozVrr
	 A/ANWbP56en6CLXikUEecNwosnprZw2ifyXHo+szFM5EGR5qFeCZFb3EeCB50P6+M4
	 pxaulqPTcSKLQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Jul 2026 15:34:03 +0200
Subject: [PATCH 1/9] binfmt_misc: let a register string create an entry
 disabled
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-work-binfmt_misc-preopen-v1-1-4a0b0da71f16@kernel.org>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
In-Reply-To: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8977; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ffubVVduLLMfNxpTpX0sw0fYfFiETwOhHJHux38zrPw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlB727fj3D7OUNp6ZJjoueLZPc+nGNm4r39++3ytIbj
 v5XXX1fpKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiDjUM/4v4N7dOuzHpZkls
 k+Ueq60LldQbGOV0taWXOpsZXxI7/57hf/3lCuGmtIont9p01JPt0s1Dn/y2++5WuMeWaefbTdI
 y3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

An entry is matchable as soon as it is registered. create_entry() sets
the enabled bit for every type and add_entry() links it straight into the
instance, so everything an entry needs has to fit in the write that
creates it.

Add a 'D' flag. The entry is created disabled and has to be enabled by
writing '1' to its entry file before it can match anything. That splits a
registration into create and activate, which a later patch uses to
configure an entry beyond what one register string can carry. It is
useful on its own too. Entries can be staged without dispatching the
moment they are written.

A staged entry stays out of the search list entirely. add_entry() only
hashes an entry that is born matchable, and the first '1' written to
the entry file hashes a staged one, which takes its place in the search
order at that point. The rcu insertion publishes the fully configured
entry, so the exec side keeps the plain enabled test it always had.

Removal cannot rely on the search list anymore. Whether an entry was
already removed is now decided by its dentry, '-1' to the status file
walks the directory instead of the list so staged entries do not
survive it, and a '1' through a file handle held across a removal
publishes nothing.

'D' is consumed at registration and not recorded. What matters afterwards
is whether the entry is enabled, and the entry file already reports that.

A 'B' entry's flags field had to be empty so far because every flag it
could name shaped the invocation, which a bpf handler picks per exec with
bpf_binprm_set_flags(). 'D' shapes the registration instead. So the rule
becomes what it always meant: a 'B' entry carries no invocation flags,
and 'D' composes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 17 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 707f8a14f8a6..ca7840b01a2b 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -37,6 +37,8 @@
 #include <linux/uaccess.h>
 #include <linux/user_namespace.h>
 
+#include "internal.h"
+
 /* Entry status and match type bit numbers. */
 enum binfmt_misc_entry_bits {
 	MISC_FMT_ENABLED_BIT	= 0,
@@ -52,8 +54,17 @@ enum binfmt_misc_entry_flags {
 	MISC_FMT_OPEN_FILE	= (1U << 28),
 	MISC_FMT_TRANSPARENT	= (1U << 27),
 	MISC_FMT_LOADER		= (1U << 26),
+	MISC_FMT_DISABLED	= (1U << 25),
 };
 
+/* The flags that shape the invocation; a 'B' handler picks those per exec. */
+#define MISC_FMT_INVOCATION_FLAGS (MISC_FMT_PRESERVE_ARGV0 |	\
+				   MISC_FMT_OPEN_BINARY |	\
+				   MISC_FMT_CREDENTIALS |	\
+				   MISC_FMT_OPEN_FILE |		\
+				   MISC_FMT_TRANSPARENT |	\
+				   MISC_FMT_LOADER)
+
 /**
  * struct binfmt_misc_flag - a flag character of the register string
  * @c: the character userspace writes and reads back
@@ -75,6 +86,7 @@ static const struct binfmt_misc_flag misc_flags[] = {
 	{ 'F', MISC_FMT_OPEN_FILE,	0,			"open interpreter file now"	},
 	{ 'T', MISC_FMT_TRANSPARENT,	MISC_FMT_OPEN_BINARY,	"transparent"			},
 	{ 'L', MISC_FMT_LOADER,		0,			"loader substitution"		},
+	{ 'D', MISC_FMT_DISABLED,	0,			"register disabled"		},
 };
 
 /* Look up a flag character, NULL if @c is not one. */
@@ -175,7 +187,12 @@ search_binfmt_handler(struct binfmt_misc *misc, struct linux_binprm *bprm)
 	/* Walk all the registered handlers. */
 	hlist_for_each_entry_rcu(e, &misc->entries, node,
 				 srcu_read_lock_held(&bm_entries_srcu)) {
-		/* Make sure this one is currently enabled. */
+		/*
+		 * Make sure this one is currently enabled. An entry enters
+		 * the list at most once and only whole: its configuration is
+		 * ordered before the rcu insertion that makes it visible
+		 * here.
+		 */
 		if (!test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
 			continue;
 
@@ -684,7 +701,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 					      size_t count)
 {
 	struct binfmt_misc_entry *e __free(kfree) = NULL;
-	char *buf, *p, *flags;
+	char *buf, *p;
 	char del;
 
 	pr_debug("register: received %zu bytes\n", count);
@@ -780,18 +797,29 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	}
 
 	/* Parse the 'flags' field. */
-	flags = p;
 	p = check_special_flags(p, e);
 
 	/*
 	 * A bpf handler decides the invocation flags per exec with
 	 * bpf_binprm_set_flags() rather than fixing them at registration, and
 	 * 'F' (pre-open a fixed interpreter) is meaningless for it, so a 'B'
-	 * entry's flags field has to be empty.
+	 * entry carries no invocation flags.
 	 */
-	if (test_bit(MISC_FMT_BPF_BIT, &e->flags) && p != flags)
+	if (test_bit(MISC_FMT_BPF_BIT, &e->flags) &&
+	    (e->flags & MISC_FMT_INVOCATION_FLAGS))
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * 'D' is a directive for this registration rather than a lasting
+	 * property, so consume it: the entry is created disabled and stays
+	 * out of the search list until '1' is written to its entry file.
+	 * The first enable publishes it, for good.
+	 */
+	if (e->flags & MISC_FMT_DISABLED) {
+		e->flags &= ~MISC_FMT_DISABLED;
+		clear_bit(MISC_FMT_ENABLED_BIT, &e->flags);
+	}
+
 	/* Transparency preserves the whole argv, argv[0] included. */
 	if ((e->flags & MISC_FMT_TRANSPARENT) &&
 	    (e->flags & MISC_FMT_PRESERVE_ARGV0))
@@ -852,6 +880,12 @@ static int parse_command(const char __user *buffer, size_t count)
 
 /* generic stuff */
 
+/* The root directory's inode; its lock serializes configuring an instance. */
+static struct inode *bm_root_inode(struct super_block *sb)
+{
+	return d_inode(sb->s_root);
+}
+
 static void bm_seq_hex(struct seq_file *m, const u8 *data, int size)
 {
 	for (int i = 0; i < size; i++)
@@ -992,10 +1026,11 @@ static void remove_binfmt_handler(struct binfmt_misc *misc,
 /* Remove @e unless it was already removed. */
 static void bm_remove_entry(struct binfmt_misc_entry *e, struct super_block *sb)
 {
-	struct inode *root = d_inode(sb->s_root);
+	struct inode *root = bm_root_inode(sb);
 
 	inode_lock_nested(root, I_MUTEX_PARENT);
-	if (!hlist_unhashed(&e->node))
+	/* A staged entry is not hashed; the dentry says if it was removed. */
+	if (!d_unhashed(e->dentry))
 		remove_binfmt_handler(i_binfmt_misc(root), e);
 	inode_unlock(root);
 }
@@ -1004,13 +1039,21 @@ static void bm_remove_entry(struct binfmt_misc_entry *e, struct super_block *sb)
 static void bm_remove_all_entries(struct binfmt_misc *misc,
 				  struct super_block *sb)
 {
-	struct inode *root = d_inode(sb->s_root);
-	struct binfmt_misc_entry *e;
-	struct hlist_node *next;
+	struct inode *root = bm_root_inode(sb);
+	struct dentry *child = NULL;
 
 	inode_lock_nested(root, I_MUTEX_PARENT);
-	hlist_for_each_entry_safe(e, next, &misc->entries, node)
-		remove_binfmt_handler(misc, e);
+	/*
+	 * Walk the directory rather than the search list: a staged entry
+	 * is in the former but not yet in the latter. The control files
+	 * carry no entry and stay.
+	 */
+	while ((child = find_next_child(sb->s_root, child))) {
+		struct binfmt_misc_entry *e = d_inode(child)->i_private;
+
+		if (e)
+			remove_binfmt_handler(misc, e);
+	}
 	inode_unlock(root);
 }
 
@@ -1067,9 +1110,27 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 	case BM_CMD_DISABLE:
 		clear_bit(MISC_FMT_ENABLED_BIT, &e->flags);
 		break;
-	case BM_CMD_ENABLE:
+	case BM_CMD_ENABLE: {
+		struct inode *root = bm_root_inode(inode->i_sb);
+
+		/*
+		 * The first enable publishes a 'D' entry into the search
+		 * list, whole. The lock keeps that ordered against a second
+		 * enable and against removal; a removed entry has nothing
+		 * left to publish.
+		 */
+		inode_lock(root);
 		set_bit(MISC_FMT_ENABLED_BIT, &e->flags);
+		if (hlist_unhashed(&e->node) && !d_unhashed(e->dentry)) {
+			struct binfmt_misc *misc = i_binfmt_misc(inode);
+
+			spin_lock(&misc->entries_lock);
+			hlist_add_head_rcu(&e->node, &misc->entries);
+			spin_unlock(&misc->entries_lock);
+		}
+		inode_unlock(root);
 		break;
+	}
 	case BM_CMD_REMOVE:
 		bm_remove_entry(e, inode->i_sb);
 		break;
@@ -1112,10 +1173,13 @@ static int add_entry(struct binfmt_misc_entry *e, struct super_block *sb)
 	inode->i_fop = &bm_entry_operations;
 
 	d_make_persistent(dentry, inode);
-	misc = i_binfmt_misc(inode);
-	spin_lock(&misc->entries_lock);
-	hlist_add_head_rcu(&e->node, &misc->entries);
-	spin_unlock(&misc->entries_lock);
+	/* A 'D' entry stays out of the search list until its first enable. */
+	if (test_bit(MISC_FMT_ENABLED_BIT, &e->flags)) {
+		misc = i_binfmt_misc(inode);
+		spin_lock(&misc->entries_lock);
+		hlist_add_head_rcu(&e->node, &misc->entries);
+		spin_unlock(&misc->entries_lock);
+	}
 	simple_done_creating(dentry);
 	return 0;
 }

-- 
2.53.0

