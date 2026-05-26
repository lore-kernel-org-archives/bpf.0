Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567233E344;
	Tue, 26 May 2026 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796950; cv=none; b=jRbfGyKyLosJ9dFidteTMiOfmpEnS63/ySvPGwwGRkMdeCo+AQvIt4/BLbzLtghxeZjZ4/xW++RAVlfRg4DLCE8G1aejjiJ5sKU8YWzcHzvFnnV7E40AdwDviapsvmnh5i4Tbtu9VKEsVdTBnMtaU4Fz/7jt9KQdd7isahlDMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796950; c=relaxed/simple;
	bh=HC/RRl7IeOAinVVv8FTx45RsO7SLy1U7LXFQtVtsiX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n0UGxsI4+y3n9OMURD5wqU1jYUFXlMdeAtpli8Ek2LeP3yEB6DWG2rbxvgWC3/I10zX/a/8Bp/OgVEZ00WDlnpHRJyNpO2DlBH+pbZlHm4Uf+2LiFQRALQyxdvGvyPXhIAZpERRSA1yzahW7i4V8L1V8qzZYpJMn0VIpTNOpggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRVQDXRO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRVQDXRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164611F000E9;
	Tue, 26 May 2026 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779796946;
	bh=oFZlcdmvc6uWeWfWn5ncZbAd8VOp345YbTiD6AiVdyU=;
	h=From:Date:Subject:To:Cc;
	b=dRVQDXROub6YH+v1/eDSykgyZ4AB+PQbBLV96lBX6YcY1qDkXGkD1P9phBkSC/5JT
	 KEDDHyXhdWwcmCNIV5U5W8m/kaGLknLhyTqf4x7yWJleMY4gkmupTa/fbn+Ij2Ltpg
	 uPAqeujWFeiipRXbfN0ebVPygsFsCUxr+N38MuprTbQ3hagtN/w8OoILI+kPTdbclo
	 ydfMKy8SPgFEcwKCeJu1ra+iU9/1QwTKRh0Q5afXDBLoFHcaMwVhfkd45+br0NyBs+
	 rrtOXJLWs/cV7OatdDkdIjNW5/rGbmCFrouJ0lGl4wtkofoAGNSiO3mJYdCMQG0tUx
	 hiZMXldI5H11g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 26 May 2026 14:02:22 +0200
Subject: [PATCH v2] bpf: add bpf_real_inode() kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-work-bpf-verity-v2-1-cd0b1850d31b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM2LFWoC/3WOyw6CMBBFf4V07RAohKgr/8Ow6GMKFdOSKVYJ4
 d9tce3y3Jl7ZjYWkCwGdi02RhhtsN4l4KeCqVG4AcHqxIxXvKsa3sHb0wRyNhBTcVlBtI3hZyk
 EbzlLrZnQ2M9hvPc/Di/5QLVkTd6QIiBIEk6NOYomlDnKo9GGxdN6fBPrrPh/ONZQAxq8oFZtp
 7W6TUgOn6WngfX7vn8B9E2lqdwAAAA=
X-Change-ID: 20260326-work-bpf-verity-a43f28baa242
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HC/RRl7IeOAinVVv8FTx45RsO7SLy1U7LXFQtVtsiX4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSJdl+Y+L+I92O4hAtb67avhueDnya80jPQZHZqcPhgt
 v/PzqZXHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABORZ2dkOBQSHVt4coZQkHug
 uk/6gg23D7BmpQl80OlRr1so0rVjGyPDnis1Ha1JqxIvb3XIu/Hqy+xXMmeDOro52ZPaTFusDp/
 nBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a sleepable BPF kfunc that resolves the real inode backing a dentry
via d_real_inode(). On overlay/union filesystems the inode attached to
the dentry is the overlay inode which does not carry the underlying
device information. d_real_inode() resolves through the overlay and
returns the inode from the lower, real filesystem.

This is used in the RestrictFilesytemAccess bpf program that has been
merged into systemd a little while ago.

Link: https://github.com/systemd/systemd/pull/41340 [1]
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Tag bpf_real_inode() with KF_RET_NULL and document that it returns
  NULL for negative dentries; LSM hooks such as security_inode_create()
  pass negative dentries, and without the flag the verifier marks the
  return as PTR_TRUSTED and skips the NULL check.
- Link to v1: https://patch.msgid.link/20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org
---
 fs/bpf_fs_kfuncs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index e4e51a1d0de2..761fbe0fec5d 100644
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
+ * Return: The real inode backing the dentry, or NULL for a negative dentry.
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
+BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)

---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20260326-work-bpf-verity-a43f28baa242

