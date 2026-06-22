Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FE3B5820;
	Mon, 22 Jun 2026 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136734; cv=none; b=KMiOzAbI2v/BoWYdmVk8kZkiF/4hb9TyGrTt37VFsOA0DzZgQa2UMPQEIDy4+56kcb05/q3vrINrvkGQFoYLf9eCKHYfVSmACXyGLl4KeSXQGIcvC6ZfGj4dR6LxWUOO7b2QDEdL/P67TLVvDvmwSexfdMKNthAjHGejwEVyjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136734; c=relaxed/simple;
	bh=EbywcOeBUD/3KDZbFHUyFPmRrJ1Wsf0mAmgqs5EikC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ta2pQVNnkyd5PvopY21aYNOBCHgMFlGo5CokHAYLGVqWQ05pi1XVGohQcNx7NYHL+v85WbPZnTuV94lEWQtYavGtuZ28ziGwPc/ss4+JFlwXOqIacpRGLcMTNTF5lu2QRqwVtversvcrQatPORRYvgP4FY9HRJDZ922EI7+u5Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5TeNLy/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5TeNLy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9C31F00A3A;
	Mon, 22 Jun 2026 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782136733;
	bh=7wczdpIjeibGp9rK2iPHI7/hKWAclW8NjbOpMC8+8mA=;
	h=From:Date:Subject:To:Cc;
	b=I5TeNLy/ap4Mq5ytoF2Uf5RNlWlP+XlUnvwq2TWFoplyWKCNhqh/OOOYpfXbnjzfa
	 RzrA+tvjsJ9Sj5FkuNOnJdIzTm4L/ndpQzXoWhAAzKU6MbtKtIV+b396SZSgiZUuCA
	 8/uNBZa/8moPcCsrJNkZ7DnflTLp/qkIvjeOISVAFWEkByASz2rqNDQhZ5jBE6BaJ1
	 +2cAQOJQKsfxu6wlakVhEFDvkCKy+hiGmlj5umJvGZeyMJSddAhrMAL80bE6e2XglB
	 YOmYP1CQ5y8pCjOGupWNf7yH3useqz8YrAI5eW1HCF1wIHWWobz6XXLJzpxDAjxpGt
	 5GK7FBzzvbCew==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 22 Jun 2026 15:58:43 +0200
Subject: [PATCH] bpf: have bpf_real_inode() take a struct file
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-work-bpf-real_inode-v1-1-4014eb4cbefd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJI/OWoC/yWM2Q7CIBBFf6XhWQwFocFfaYyZgcHiQhuoS9L03
 6X6eO5yFlYoRyrs2Cws0yuWOKYK7a5hboB0IR59ZSaFNMJIyd9jvnGcAs8E93NMoyfuVK09QhC
 ArD6nTCF+ftb+9OfyxCu5eVNtC4RCHDMkN2zRA8pMea9RqeDMwUrosAMjlbat7jyKYGXQaMhCM
 Fawdf0C9Znqe7kAAAA=
X-Change-ID: 20260622-work-bpf-real_inode-c3202dbaf0ab
To: bpf@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-490fe
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EbywcOeBUD/3KDZbFHUyFPmRrJ1Wsf0mAmgqs5EikC0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZ2s9mnX/18d6bpX9kZhRec9pyTu5rrpu9y5Mvgm2OL
 Aqb3uy+0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR7NkM/7M9T0UXd3kXMU8o
 FFZZ5md6SIujXEZk9+fs/Ag3/+UG9xn+ik/nOBR8VXdhxOydC95N5JngpmK7aEL4qiv/lu54zXl
 AiAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

bpf_real_inode() must be usable from the bprm_check_security, mmap_file
and file_mprotect hooks for systemd's RestrictFilesystemAccess BPF LSM
program. It should take a file instead. The kfunc landed this cycle so
changing the signature is safe.

Fixes: 9af8c8a54f6e ("bpf: add bpf_real_inode() kfunc")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 768aca2dc0f0..f941c29d26ef 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -360,18 +360,18 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
 #endif /* CONFIG_CGROUPS */
 
 /**
- * bpf_real_inode - get the real inode backing a dentry
- * @dentry: dentry to resolve
+ * bpf_real_inode - get the real inode backing a file
+ * @file: file to resolve
  *
- * If the dentry is on a union/overlay filesystem, return the underlying, real
+ * If the file is on a union/overlay filesystem, return the underlying, real
  * inode that hosts the data.  Otherwise return the inode attached to the
- * dentry itself.
+ * file itself.
  *
- * Return: The real inode backing the dentry, or NULL for a negative dentry.
+ * Return: The real inode backing the file, or NULL.
  */
-__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
+__bpf_kfunc struct inode *bpf_real_inode(struct file *file)
 {
-	return d_real_inode(dentry);
+	return d_real_inode(file_dentry(file));
 }
 
 __bpf_kfunc_end_defs();

---
base-commit: 5b33fc6492a7b7a62359157db0f92f5b6e9af690
change-id: 20260622-work-bpf-real_inode-c3202dbaf0ab

