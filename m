Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE984FECC3
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583626; cv=none; b=U/Q86l+VIcnKHwot/XeFbeHpj/TMXm2ncS6DsHuZC86EaIINtxQw9GJKoKwy+1kDY+QyljwxlrPsUXWyciokEAtRW0FRVNSRNYl5w2jE6dwQm+Z5KlvMyx/1xty39/obKzqTwymAQH0O7GnFQGpw4vUcYIEaP+glmF/HYu3kPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583626; c=relaxed/simple;
	bh=h/uo9xMScgEjxpUKugslC5jfH/3gk5WgBvRRfZAVbpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgjj6NJ2bDFu1JUw7s91zts/Ls0UjhPz5n0KH5/s2hWsTfvyZNhth7Rl8w5kKcYJYh3DeEKdSMnuyLeMeExuaCEhfelcDBz8I38ZlV27mFvjIzS891N/hsGQ4UCEcjLNyKYg7E+IJpuvZjvYTqb0CdVGvHjsgi6WqatZ6zQ5Wuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoCj9pb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoCj9pb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3380C1F0089B;
	Wed, 16 Sep 2026 18:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583586;
	bh=5aMlB6DYC602KH2r0iXZgBp5Q3trtzBncqD3fVsSj9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MoCj9pb0OOlU6su5VsQSuFkCOJG4Yu+xK7gco1bIPFUaS6u2HVUKphgfgGWWM1Z78
	 L2cJ+q90tfYdi5GXLQVoXhBvQ4KjFe3+lJGwijX4ZjqSi3/mPS8guBk/o63t/ZvYAI
	 S3/0Fhlg2TZ5PxhP7LERU8k1uIfQEBJLk9qoTH57kbba1SKo3LQAEAjL62ehSGtCGB
	 LEzwvqeba29s9/m+rNl71fVYrHP7HCkykPGOCrUXMPr1/7h+rPOj4xkQE0bvFjPUyk
	 /np3Sp0gyF940Jvzlvn55ovQHR86zZcBICbm8uh013H4WZBafJUrk6e2RLFl6l992w
	 zOXiBM8A+e9Ww==
From: Chris Mason <mason@kernel.org>
To: mason@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	brauner@kernel.org
Subject: [PATCH RFC 2/2] selftests/bpf: test f_inode walk around bpf_put_file()
Date: Wed, 16 Sep 2026 18:33:03 +0000
Message-ID: <20260916183303.3504885-3-mason@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916183303.3504885-1-mason@kernel.org>
References: <20260916183303.3504885-1-mason@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No selftest covers a trusted pointer that is loaded from a referenced
object and used after the reference is released. The verifier change
in the previous patch is therefore untested.

The previous patch links a trusted pointer loaded from a referenced
object to that reference through parent_id, so that
release_reference() invalidates it together with its parent. Before
that, a program could keep f->f_inode from a bpf_get_task_exe_file()
file and dereference it after bpf_put_file().

Test both sides of the release on that f_inode walk. The reject test
dereferences the inode after the put and expects "invalid mem access
'scalar'". Without the previous patch the verifier accepts the program,
so the test fails. The accept control reads inode->i_ino while the
reference is held and uses only the scalar after the put, which catches
a verifier that invalidates too much.

Walked pointers have been able to stay trusted since commit
57539b1c0ac2 ("bpf: Enable annotating trusted nested pointers").

Assisted-by: kres
Signed-off-by: Chris Mason <mason@kernel.org>
---
 .../selftests/bpf/progs/verifier_vfs_accept.c | 26 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 27 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
index 55398c04290a..6fb0d2ed3d5f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -100,4 +100,30 @@ int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
 	return 0;
 }
 
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(f_inode_walk_used_before_put_file)
+{
+	struct file *acquired;
+	struct inode *inode;
+	ino_t ino;
+
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+
+	/*
+	 * f_inode walked from a referenced file can be dereferenced while
+	 * the file reference is held. Only the scalar read from it is used
+	 * after the put.
+	 */
+	inode = acquired->f_inode;
+	ino = inode->i_ino;
+	bpf_put_file(acquired);
+
+	if (ino == 0)
+		return -EACCES;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index b5f456d57669..536acbe15357 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -173,4 +173,31 @@ int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
 		return -EACCES;
 	return 0;
 }
+
+SEC("lsm.s/file_open")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(f_inode_walk_used_after_put_file)
+{
+	struct file *acquired;
+	struct inode *inode;
+	ino_t ino;
+
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+
+	/*
+	 * f_inode walked from a referenced file is trusted, but only for
+	 * as long as the file reference is held.
+	 */
+	inode = acquired->f_inode;
+	bpf_put_file(acquired);
+
+	/* The put invalidated inode, it can't be dereferenced anymore. */
+	ino = inode->i_ino;
+	if (ino == 0)
+		return -EACCES;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

