Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9683406822;
	Mon,  3 Aug 2026 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759329; cv=none; b=ZOcMFI8JQgXO+3UKkjjLdKNndO/Z6vLL5a68FxMudu97nwPaPitK3uk7xaOdnuz4LSCvNh16PPYPAENo4meaeV6zvkZTquXj40BqRrMhmV5bnDeei05+nzwSkAGzGSKKgjYXIQHdGRwp3G9bK8HhK4fHT8+MQn7UPeGyg29TQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759329; c=relaxed/simple;
	bh=PImZ5+k3jMoTX28E8qhoeuXRjw+pYMUOFIcPhrFW/TM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sUA/LZaP7tUr4j5STiBB1jUG7VIYo0UYrqy5D+Y08NAtLHSdPF6EMd0lYofFB2fRMbHAczQ0FOxVt5lhPqKM6gFfOt2KnAMDVwTpRpKP7C8f9zpDjR0IGhMYs78lF7RsBMuMPwmDRfGOAnCaBfSIaMBa+BIl6yp0lPdQHHAeHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwEjg8yt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwEjg8yt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EB91F00A3A;
	Mon,  3 Aug 2026 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785759324;
	bh=D2Rl97NSLMDDjgLpCbEgbfCYGpNmImEFbOqRGKOWqHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FwEjg8ytRRjlCirzGeKDlrIae4cstHl9EMKHUG9MCKw2DQsRDi3lPKQrVIohza5Uk
	 wu9Q4eDBAQfi+hojiTZnRFFKSdaED5+Ef2oBKjWEr6V4pdaj4kfjM75bIay4QsHg6/
	 CnhZDZ0io7WIa0cRCyS6qwS2L3+5zxg0wi2h5nMpNicFipa97ojwaiPdM73ElcNL2j
	 RYFOJ3dSMsPWT+WMmPefyEsL6r3o+EIa7qvsMPUMH3UbsGUcSjTNsZwnku4xVCC3fB
	 TQtsAyqQI0cMRggVIF0zk2wvtt6q10NWnXlOn3qtgeQ92qLEDwtm4YYT0HisHDUeNN
	 WtXKhrxDB2wKg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Aug 2026 14:15:00 +0200
Subject: [PATCH 1/3] binfmt_misc: correctly account pre-opened interpreters
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-work-binfmt_misc-interplimit-v1-1-4a2435500bd9@kernel.org>
References: <20260803-work-binfmt_misc-interplimit-v1-0-4a2435500bd9@kernel.org>
In-Reply-To: <20260803-work-binfmt_misc-interplimit-v1-0-4a2435500bd9@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com, 
 mail@johnericson.me, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-f2f85
X-Developer-Signature: v=1; a=openpgp-sha256; l=6690; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PImZ5+k3jMoTX28E8qhoeuXRjw+pYMUOFIcPhrFW/TM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQVtIVlzhR44CkpLMZ09H5Gvth/iwjeXYWypeln6vmiF
 J+kRRZ3lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATOShGCPD/Zyu+x6LNDlPT5dN
 TLtkJ3ticdjDjSvfP1P+xNAW8vKgMsNPxk2n5Se6J8z6uPHeZya7fxw5nGYSz7S/Lbz8oXqqwJT
 FLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

An 'F' entry, and every interpreter a 'B' entry binds, holds a file open
from registration until the entry goes away, pinning the file, its inode,
the mount it came from and that mount's superblock. Nothing bounds how
many of those a user namespace can hold. An entry binds at most
BINFMT_MISC_INTERP_MAX interpreters, but nothing caps the entries.

Charge each binding to the user namespace and uid that makes it against a
new UCOUNT_BINFMT_MISC_INTERPRETERS. Going over budget causes -ENOSPC.

A per-instance cap would suck. Instances are keyed on the user
namespace. So any constant is multiplied by the number of namespaces the
caller creates. Creating those is virtually free. A ucount charges the
namespace and every one of its ancestors. And a namespace can raise only
its own limit. So nesting buys nothing.

The knob is /proc/sys/user/max_binfmt_misc_interpreters. Leave it at the
max_threads/2 default fork_init() gives a new type. No existing
configuration comes close to that.

binfmt_misc is tristate, which makes it the first ucount user that can be
built as a module. Export inc_ucount() and dec_ucount(); without them
CONFIG_BINFMT_MISC=m fails to link. Export them to binfmt_misc alone:
charging a ucount type is not something a module has any business doing
in general, and the list is trivial to extend if a second user shows up.
init_user_ns and init_binfmt_misc are already exported for the same
module.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c               | 16 ++++++++++++++--
 include/linux/binfmt_misc.h    |  3 +++
 include/linux/user_namespace.h |  3 +++
 kernel/ucount.c                |  6 ++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index ad8c4f64bf10..a3aa42fd5761 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -289,6 +289,7 @@ static void entry_put_interpreters(struct binfmt_misc_entry *e)
 	list_for_each_entry_safe(interp, tmp, &e->interps, list) {
 		list_del(&interp->list);
 		close_interp_file(interp->file);
+		dec_ucount(interp->ucounts, UCOUNT_BINFMT_MISC_INTERPRETERS);
 		kfree(interp);
 	}
 }
@@ -307,7 +308,8 @@ static void entry_put_interpreters(struct binfmt_misc_entry *e)
  * The caller has to have validated @name and @path, established that @e
  * cannot be matched yet, and owns @f until this succeeds.
  *
- * Return: 0 on success, a negative errno on failure
+ * Return: 0 on success, -ENOSPC if the entry is full or the binder is out of
+ *         UCOUNT_BINFMT_MISC_INTERPRETERS budget, a negative errno on failure
  */
 static int entry_attach_interpreter(struct binfmt_misc_entry *e,
 				    const char *name, const char *path,
@@ -315,22 +317,32 @@ static int entry_attach_interpreter(struct binfmt_misc_entry *e,
 {
 	size_t nlen = strlen(name), plen = strlen(path);
 	struct binfmt_misc_interp *interp;
+	struct ucounts *ucounts;
 
 	if (binfmt_misc_find_interp(&e->interps, name))
 		return -EEXIST;
 	if (list_count_nodes(&e->interps) >= BINFMT_MISC_INTERP_MAX)
 		return -ENOSPC;
 
+	/* The binding keeps a file open, so charge it to whoever binds it. */
+	ucounts = inc_ucount(current_user_ns(), current_euid(),
+			     UCOUNT_BINFMT_MISC_INTERPRETERS);
+	if (!ucounts)
+		return -ENOSPC;
+
 	/* One allocation, both strings in it, like the entry's own buffer. */
 	interp = kmalloc(struct_size(interp, name, nlen + plen + 2),
 			 GFP_KERNEL_ACCOUNT);
-	if (!interp)
+	if (!interp) {
+		dec_ucount(ucounts, UCOUNT_BINFMT_MISC_INTERPRETERS);
 		return -ENOMEM;
+	}
 
 	interp->path = interp->name + nlen + 1;
 	strscpy(interp->name, name, nlen + 1);
 	strscpy(interp->name + nlen + 1, path, plen + 1);
 	interp->file = f;
+	interp->ucounts = ucounts;
 	/* Publish the node: a lockless cat may be walking the list. */
 	list_add_tail_rcu(&interp->list, &e->interps);
 	pr_debug("register: interpreter: %s {%s}\n", name, path);
diff --git a/include/linux/binfmt_misc.h b/include/linux/binfmt_misc.h
index 072e4b3dd78d..8045b10dd3e5 100644
--- a/include/linux/binfmt_misc.h
+++ b/include/linux/binfmt_misc.h
@@ -7,6 +7,7 @@
 struct bpf_prog;
 struct file;
 struct linux_binprm;
+struct ucounts;
 struct user_namespace;
 
 #define BINFMT_MISC_OPS_NAME_MAX 16
@@ -21,6 +22,7 @@ struct user_namespace;
  * struct binfmt_misc_interp - an interpreter an entry was registered with
  * @list: link in the entry's list, in registration order
  * @file: the file, opened at registration and never resolved again
+ * @ucounts: the UCOUNT_BINFMT_MISC_INTERPRETERS charge the binding took
  * @path: the path it was registered under, used as the name the interpreter
  *        runs under; stored after @name in the same allocation
  * @name: the name the load program selects it by; empty for the fixed
@@ -33,6 +35,7 @@ struct user_namespace;
 struct binfmt_misc_interp {
 	struct list_head	list;
 	struct file		*file;
+	struct ucounts		*ucounts;
 	const char		*path;
 	char			name[];
 };
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 9c3be157397e..e38d9e60569f 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -57,6 +57,9 @@ enum ucount_type {
 #ifdef CONFIG_FANOTIFY
 	UCOUNT_FANOTIFY_GROUPS,
 	UCOUNT_FANOTIFY_MARKS,
+#endif
+#if IS_ENABLED(CONFIG_BINFMT_MISC)
+	UCOUNT_BINFMT_MISC_INTERPRETERS,
 #endif
 	UCOUNT_COUNTS,
 };
diff --git a/kernel/ucount.c b/kernel/ucount.c
index d6dc3e859f12..ec8b1445e287 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -4,6 +4,7 @@
 #include <linux/sysctl.h>
 #include <linux/slab.h>
 #include <linux/cred.h>
+#include <linux/export.h>
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
 #include <linux/user_namespace.h>
@@ -89,6 +90,9 @@ static const struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_fanotify_groups"),
 	UCOUNT_ENTRY("max_fanotify_marks"),
 #endif
+#if IS_ENABLED(CONFIG_BINFMT_MISC)
+	UCOUNT_ENTRY("max_binfmt_misc_interpreters"),
+#endif
 };
 #endif /* CONFIG_SYSCTL */
 
@@ -233,6 +237,7 @@ struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid,
 	put_ucounts(ucounts);
 	return NULL;
 }
+EXPORT_SYMBOL_FOR_MODULES(inc_ucount, "binfmt_misc");
 
 void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
 {
@@ -243,6 +248,7 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
 	}
 	put_ucounts(ucounts);
 }
+EXPORT_SYMBOL_FOR_MODULES(dec_ucount, "binfmt_misc");
 
 long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
 {

-- 
2.53.0

