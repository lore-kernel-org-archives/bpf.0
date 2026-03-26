Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280713988E6;
	Thu, 26 Mar 2026 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544030; cv=none; b=IyuaO2QHoSRNjKdaTyGGzcBIrvqeZhb/aZCx7eqTmt9R1LJ5XxDNVe4TzfUfzTXUUKfok8dQ5QCrH+sh9YPPFee9xPqp7zyPmi+sPAaNK8eBs7WENlVWZuoLI1uPoT17gH97larjLf4OFkI76oP3ulkI4ZfKzNpuP/VTCzmhv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544030; c=relaxed/simple;
	bh=XZWJ98mw/d9PXWaJqt8DPzYRnSBX+nG8fMx5SP0rQXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s4u5nac5gxz1im5Xittfrv/f/QQ4r2rJ19jRdrmb64s4176D7pRzneD0wC2e0+qFL1kPkAtO0kFr3RkWLr1Z0UhofGd5xSUYs8EfWW8HeMtx7iSESnrAiIPGaFl6OpNOl4gVxwA++zFofCq9GYNw4BGBQPFHdoaN9wQz9AfYDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unrPE2Ev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unrPE2Ev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01275C116C6;
	Thu, 26 Mar 2026 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774544029;
	bh=XZWJ98mw/d9PXWaJqt8DPzYRnSBX+nG8fMx5SP0rQXc=;
	h=From:Date:Subject:To:Cc:From;
	b=unrPE2EvfuDKdH/n7sObSmFy+deZnmxUY/tJi/vcs/TAHdHW+RFa/vQ9GJhyMF6kS
	 lMXpn5/fUQboEG6XnqZGNQV37bMpw3f6kXBF1yZFL+7Ooxe5tKbe7QLlOGDvndyI8b
	 GRcuAm6rFzGOKy8ewBtAYjFdJGFH5H6WL29C/mVD+5kxF50tDibAZQXsgEWZ74fLXx
	 mUPcAhCD/aiJh5sJ+qGbj74mPjFS25IQN3fDlA5J44XKTiWo5TyTkkp4eF4+UdiM0m
	 551WzpPQOclOwClhsOTJQvQQmZDpyP58US+t33BcoD9VMr5f60TuAyIG8w4zvBe2GH
	 9nX0YRaqnS6Ug==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Mar 2026 17:53:44 +0100
Subject: [PATCH] bpf: add bpf_real_inode() kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJdkxWkC/yWM0QrCMAxFf2Xk2cjMxhB/RXxIa+qi0I1mVmXs3
 2318RzuuSuYJBWDU7NCkqymUyxw2DXgR443Qb0WBmppaDsa8DWlB7o5YC7h8kHuu0BHx0w9Qan
 mJEHfv8fz5c/2dHfxS72pC8cm6BJHP1aVg+2rgm37AnSmVnuOAAAA
X-Change-ID: 20260326-work-bpf-verity-a43f28baa242
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XZWJ98mw/d9PXWaJqt8DPzYRnSBX+nG8fMx5SP0rQXc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQeTZmtpy73ZXGkPPMmxmsBspXBp3wDXrH78k/lvbjHq
 WFRw4GcjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlo7mNkuKpyXOGWfGHZP4O/
 b9d2lkXYhc1esfb0qzJl9o8u+/warzMynDZQkvfYr7OsbVPGUSnhrJt+Tm6P7lnvYJb5aHawTXY
 XAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a sleepable BPF kfunc that resolves the real inode backing a dentry
via d_real_inode(). On overlay/union filesystems the inode attached to
the dentry is the overlay inode which does not carry the underlying
device information. d_real_inode() resolves through the overlay and
returns the inode from the lower, real filesystem.

This is needed by the dm-verity based execution policy implemented in
systemd [1] where BPF LSM hooks must resolve a file's backing block
device via inode->i_sb->s_dev. Without looking through overlayfs the
device lookup would return the overlay's anonymous device number instead
of the actual dm-verity block device, causing all overlayfs-hosted
binaries to be incorrectly denied.

Link: https://github.com/systemd/systemd/pull/41340 [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index e4e51a1d0de2..fc30aa906b8c 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -353,6 +353,21 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
 }
 #endif /* CONFIG_CGROUPS */
 
+/**
+ * bpf_real_inode - get the real inode backing a dentry
+ * @dentry: dentry to resolve
+ *
+ * If the dentry is on a union/overlay filesystem, return the underlying, real
+ * inode that hosts the data.  Otherwise return the inode attached to the
+ * dentry itself.
+ *
+ * Return: The real inode backing the dentry.
+ */
+__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
+{
+	return d_real_inode(dentry);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -363,6 +378,7 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)

---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20260326-work-bpf-verity-a43f28baa242

