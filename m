Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812A37A82E;
	Tue, 14 Jul 2026 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059117; cv=none; b=n/DYC4lINCTmRry7K5o/2gj9IqWZpa7l68vGMmzgNi4lnsM2KedVF2xtEHQ2I1if5+NDOxEr4YEdbIHL/4yY3s9YDUv0UGQ4VdKfe/TpOSZ7FCHb9yioPl5rS/seREGKA3l9rVeOwOcu7PmvC2q0a/7N3aPisskpxvwOloh2/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059117; c=relaxed/simple;
	bh=ccCpCBYwz2VmPn9yua5oVLq0KAr9/ocwzydcHJJZhq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mamPj6sjKKZ2bQbHD9C0DSc8tUgy/bUeRWZNp6028oS59zfCzYdDXdcs5OHgiLLwWac5YI9e0Ujq3XYtut+7RBaBUik5T/zt2OyOsn5JrloZMMBfuHyu8oxt9zmQzqGudWqrh6d9k8ZdnITcwc6srg/cHxyjL2Y/PQwCcoq6yLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em8WrnhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em8WrnhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407C41F000E9;
	Tue, 14 Jul 2026 19:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059116;
	bh=Fo19MEO4GrOIxZIeKD3bvDaVcJiR3ZionbZ5Jyq+iHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=em8WrnhEufL1JxGqY2VL3S+mNr4kanxGWZiaMz5lg03ICE1MlAX+6LBWObE0hSZG2
	 uu/KRfUGPtX6Key8tin/0qFC29HbHAD6/s6lXsZ0jger5GzqFtKFkkjjSKvwbuR9O2
	 Q0sNfgld0yl08Mhope+YY7s4KK9kaR5Q4LOFrKyxyc3RnevZcHGfoGGlwiLDlbcjsZ
	 Thb0OpG0nZ9o9fUrBq+r2Zvccc6PiZ8+wR1PQJKqqv4yIasYM7ciMk57h7NCkn8sVu
	 gQZhlp1zW697aTIVXitTaRuQ7AR8g2xxjBfNUs+n5CzRCFgBrJNwj7QlIEx5uxbSVc
	 0w2zttvVHNODw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 14 Jul 2026 21:58:10 +0200
Subject: [PATCH v2 5/9] bpf: allow fs kfuncs for binfmt_misc_ops programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-work-bpf-binfmt_misc-v2-5-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, bpf@vger.kernel.org, jannh@google.com, 
 mail@johnericson.me, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2872; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ccCpCBYwz2VmPn9yua5oVLq0KAr9/ocwzydcHJJZhq4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSFTbk8Q3bKSTHN7uVPiv/e+Ll0FfPSLVlyvIpWQpGsz
 499b8170VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRFbYMfwXPVXXut57cvWuN
 btH304ddOtJaty260M83Z2fB8SvetgcY/hcsuFq7qso85E5ukkDjkt4l/6fM3eq2pDVnUUamzxQ
 9Uy4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The fs kfuncs are currently exclusive to LSM programs. A binfmt_misc
handler needs a subset of them to do anything interesting: computing an
interpreter relative to the binary's location wants bpf_path_d_path()
on bprm->file->f_path from the load program, and matching on per-binary
metadata wants bpf_get_file_xattr() and friends right from the match
program.

Register the fs kfunc set for struct_ops programs as well and extend
the filter to admit binfmt_misc_ops programs. The xattr setters stay
exclusive to LSM programs: a binary type handler decides how to run a
binary, it has no business modifying filesystem state.

This only takes effect in builds that have the fs kfunc set at all,
i.e. CONFIG_BPF_LSM. Without it a binfmt_misc handler is limited to
bprm fields and the file-backed dynptr, which are provided by the
common kfunc set.

Link: https://lore.kernel.org/20260704211409.1978485-1-farid.m.zakaria@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 768aca2dc0f0..aa1fe988b6d2 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Google LLC. */
 
+#include <linux/binfmt_misc.h>
 #include <linux/bpf.h>
 #include <linux/bpf_lsm.h>
 #include <linux/btf.h>
@@ -387,10 +388,20 @@ BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
+/* Side-effecting kfuncs that stay exclusive to LSM programs. */
+BTF_SET_START(bpf_fs_kfunc_lsm_only_ids)
+BTF_ID(func, bpf_set_dentry_xattr)
+BTF_ID(func, bpf_remove_dentry_xattr)
+BTF_SET_END(bpf_fs_kfunc_lsm_only_ids)
+
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
+	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id))
+		return 0;
+	if (prog->type == BPF_PROG_TYPE_LSM)
+		return 0;
+	if (bpf_prog_is_binfmt_misc_ops(prog) &&
+	    !btf_id_set_contains(&bpf_fs_kfunc_lsm_only_ids, kfunc_id))
 		return 0;
 	return -EACCES;
 }
@@ -433,7 +444,13 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 
 static int __init bpf_fs_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	if (ret || !IS_ENABLED(CONFIG_BINFMT_MISC_BPF))
+		return ret;
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &bpf_fs_kfunc_set);
 }
 
 late_initcall(bpf_fs_kfuncs_init);

-- 
2.53.0

