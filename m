Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE38370AFB;
	Tue, 23 Jun 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207155; cv=none; b=ikpm49DSffntQJOU/vo9Ir+1BjlCCfOxRxBq57M+9QdKBKhXK2g7zaaba50GXMq5RXA63BIOirpLqe4pyx8YpXwrkz4ytJ8lnIky5WnmHVxHnERcb+jfjQHFqbbo5Zfaqrw5I+ht+U79xOuY9Jrg85rXK4VEgupHu+Bc1q9TAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207155; c=relaxed/simple;
	bh=STm7jH09D99Mjllu9NSRKcTd9KuDTMiKMLWylsZX04M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V+7t8sBSFYhZ82vIuvFhXKUoJyyfzvK5UcJLr9i7mD9bDiFEDn6vAIumvQ493+iffQZSnwDxLrPkEH7UR11ekzxCPi1x3qse5JFcanvTlhTdqno4eP2Ibir3m4SD9i3z5cjnJiDN9OzdoBXNwZbKdg/ataM04o9jmrapGK1ip9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwzP4J2V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwzP4J2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66C71F00A3D;
	Tue, 23 Jun 2026 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782207154;
	bh=vps8ys9ng9ec0/LH06KpU4OGpxNPWI6t7qEIv2BmAz0=;
	h=From:Date:Subject:To:Cc;
	b=EwzP4J2VhTJJxu0jrHViuMQw/RtMATu9PsPDfT+O8F5/rgPJZ9AVwYNbTjH0/YZEJ
	 A2VCVu1pq9BxRb858xRE/YHZ7UI6zFY9y3H3ohJSFziIu/UPtfVlvSZB2X6EgCXKHZ
	 XbU6bz1rn6tpuMFxdFjDtmzv2tzb2Ya41ZDj/We7J+RQnlMdL8dgU97p7QQitq5Sv0
	 vkAU4PR4Pdifrw15x1MCNGjXB1EO3zQWIjP8hFZgO/bBfkQAG+PlxMy+8N5+llXZvi
	 VnGMtJdEfuaZtJVKWO4ASkOXVDpCH7Rf5twciFdw3rBriuFxUOyCbHqxJyihGpC03g
	 T8zPWnrjJAong==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jun 2026 11:32:27 +0200
Subject: [PATCH v2] bpf: have bpf_real_data_inode() take a struct file
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-work-bpf-real_inode-v2-1-8e8b57dd25f7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKpSOmoC/32O0W7DIAxFf6XiuVRAEiL61P+YqskG07C2UJks2
 1Tl3xe69z0e+/r4PkUlTlTFcfcUTEuqqeQNzH4n/AT5QjKFjYVRxiprjPwqfJX4iJIJbu8pl0D
 Sd9s6IEQFKLbLB1NM3y/r2/mP6yd+kJ+bqiUQKklkyH5qozvUmfgwYNdFb3tnYMQRrOkGp4cxo
 IrOxAEtOYjWqWaYUp0L/7yKL7p9+r/joqWWvdI9Ye+RYjhdiTPdDoUv4ryu6y9yC/8PCwEAAA=
 =
X-Change-ID: 20260622-work-bpf-real_inode-c3202dbaf0ab
To: bpf@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-9f537
X-Developer-Signature: v=1; a=openpgp-sha256; l=3523; i=brauner@kernel.org;
 h=from:subject:message-id; bh=STm7jH09D99Mjllu9NSRKcTd9KuDTMiKMLWylsZX04M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZBW3gkKvN/3SpYeF5tfwE3j+K9dG2ksvqbDb5lqvIb
 UmbVfqno5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIRzYwM60q16nXsxD+/urNS
 WOnbBkupC84xfXMn8IYv4OVeOuHfNEaGnyfUui9lP/UumvVWuSNX2j7F/vXDzq/TEgxXfJxeXpX
 OAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

bpf_real_data_inode() must be usable from the bprm_check_security,
mmap_file and file_mprotect hooks for systemd's RestrictFilesystemAccess
BPF LSM program, so have it take a struct file instead of a dentry.

Amir Goldstein <amir73il@gmail.com> suggests:

  While doing so, rename it from bpf_real_inode() to
  bpf_real_data_inode(). For a regular file on a union/overlay
  filesystem it resolves to the underlying inode that hosts the data,
  but for a non-regular file it returns the overlay inode. The new name
  makes the "inode hosting the data" intent explicit and avoids the
  ambiguity of "the real inode backing a file". Document the
  non-regular-file behavior in the kfunc too.

Both the signature change and the rename are safe because the kfunc
landed this cycle and has no released users.

Fixes: 9af8c8a54f6e ("bpf: add bpf_real_inode() kfunc")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Rename bpf_real_inode() -> bpf_real_data_inode() (Amir); the new name
  makes the "inode hosting the data" intent explicit.
- Document that the kfunc returns the overlay inode for non-regular files.
- Link to v1: https://patch.msgid.link/20260622-work-bpf-real_inode-v1-1-4014eb4cbefd@kernel.org
---
 fs/bpf_fs_kfuncs.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 768aca2dc0f0..f1863a891db6 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -360,18 +360,23 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
 #endif /* CONFIG_CGROUPS */
 
 /**
- * bpf_real_inode - get the real inode backing a dentry
- * @dentry: dentry to resolve
+ * bpf_real_data_inode - get the real inode hosting a file's data
+ * @file: file to resolve
  *
- * If the dentry is on a union/overlay filesystem, return the underlying, real
- * inode that hosts the data.  Otherwise return the inode attached to the
- * dentry itself.
+ * Resolve @file to the inode that hosts its data. For a regular file on a
+ * union/overlay filesystem this is the underlying (upper or lower) inode that
+ * stores the data, not the overlay inode.
  *
- * Return: The real inode backing the dentry, or NULL for a negative dentry.
+ * Data resolution only applies to regular files. For a non-regular file (e.g.
+ * a device node, fifo or socket) on a union/overlay filesystem the overlay
+ * inode itself is returned; for any file on a non-union filesystem the inode
+ * attached to @file is returned.
+ *
+ * Return: The inode hosting @file's data, or NULL.
  */
-__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
+__bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
 {
-	return d_real_inode(dentry);
+	return d_real_inode(file_dentry(file));
 }
 
 __bpf_kfunc_end_defs();
@@ -384,7 +389,7 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)

---
base-commit: 5b33fc6492a7b7a62359157db0f92f5b6e9af690
change-id: 20260622-work-bpf-real_inode-c3202dbaf0ab

