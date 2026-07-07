Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886CF3ACA41;
	Tue,  7 Jul 2026 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453041; cv=none; b=kPCbZ0GTHpzXSlQ6851k+gqyRkHkzD42rKo8drrc4HLvURSz/zgrpA95koj1/ItNomPnccxELxZjOasUaltGOaIl9BYxDSdTm/Fe2GcUqkoB7B6hxgMETVxMwrrF3WkZWLYp2hTA7eEjm+FREO50M7zTl756ZEYOMMsh2MbWpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453041; c=relaxed/simple;
	bh=WrSENH+5tMwx8U3a+mcJ71xVE4chcPlq2GvrRcLbaCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4LySNeVufeCB6EzktANiHj54Q3zyph8M4kzqhXGDV23hCmM/4JT7c51IYANnlPook0shy06n9+J6dKc15SYGkhCgkcWhuX29lFdRxFZelaVQlX8Jd6EEwsGCT9IWEm7W0UevabfaTcGofXek3xjekfh+HTR5hqs6bX9jPL9pxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1YSoy+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1YSoy+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A5E1F000E9;
	Tue,  7 Jul 2026 19:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783453040;
	bh=NdXDOxsyu1F5h/+GeY4wpi+0FA2AfuOSIvwjDrH3T+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=n1YSoy+L4RPfRGgqyLgaXdMaChn1+sLhk+EF1OhoEwNObgYeL1tLyQdph1MituyWF
	 3r0fhnPd+kgIDIoqVlJt6XHQO1xRJWhK05klTcaRJ5oEwFZ3Q/e+w4MFxw9E5aEqjx
	 SV4bbiQR+AKNKQjqnC6Ao0aPZowcBVeFkowrGfiZVCez0XyvL3Er3WmXUJMTZ2N8j9
	 rfNdNZj3q7/9cyZHjpM/HUAFGcsOba2M7whbD1Vlwi/6C29FmJHIcCeNNjr5m4kowK
	 qHPoa8lfH2YoriIMQLQ1jhiy0c2LYdx6gh03u6blKwV/ocU68+tMhCTi5+9+D6Okbu
	 j/GIRykCsgwlw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 07 Jul 2026 21:36:48 +0200
Subject: [PATCH RFC POC 4/4] bpf: allow fs kfuncs for binfmt_misc_ops
 programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-work-bpf-binfmt_misc-v1-4-74b995c84ec1@kernel.org>
References: <20260707-work-bpf-binfmt_misc-v1-0-74b995c84ec1@kernel.org>
In-Reply-To: <20260707-work-bpf-binfmt_misc-v1-0-74b995c84ec1@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 jannh@google.com, linux-mm@kvack.org, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WrSENH+5tMwx8U3a+mcJ71xVE4chcPlq2GvrRcLbaCc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5hiZ0V0S6GO/pEbObbcBiabC0pke2++Z9xmeeV3t6H
 pvliHB2lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATKRwNiPD7vlldy336y+90aCy
 p21d6d2Opo1MF8T/uIbqCN/qXzzxG8P/xC3blbKfKf9asil6n/nyUwcZleZeenVxvtCJ1R1zXfZ
 rcgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The fs kfuncs are currently exclusive to LSM programs. A binfmt_misc
load program needs a subset of them to do anything interesting: to
compute an interpreter relative to the binary's location it wants
bpf_path_d_path() on bprm->file->f_path, and matching on per-binary
metadata wants bpf_get_file_xattr() and friends.

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

