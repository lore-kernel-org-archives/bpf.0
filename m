Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A525392A;
	Tue, 21 Jul 2026 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643300; cv=none; b=bJFgvyq0qCg6c+1+ZDXfhSgn4qZv74kLNoT2UCGke7HhzrN2CcHYrFyBN2huyOrribWx3XzFc9bkJiemkiImLAaOxTmlQVjItIVfqvNSjHGcjJKSKVmQeblCZghEDNEyGQKUApCl97jOu2M4wjVs6vYDkF1AgIviK0H5jUjqcN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643300; c=relaxed/simple;
	bh=DSYNqcIM1+jrmVAVu+qrpBRkYhiyLa1vNJEMqRXR1aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u72ui2OexGo7qYdq8MkgZkmqMAxouHruYCLj4tjNTX/VGk2GLPp4orT2WZkPJwkYHcc2dcw3E/kHA/+JmpuHM58jpf4++1AR1JOy/6HNyXOqsHM5DMBN/WRTN2HyzQlkUyDmLNZBvCtPtxnxGhxK45gUmEOb6psnvbSA8WMiLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR6OB0eJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR6OB0eJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D4F1F00A3E;
	Tue, 21 Jul 2026 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643298;
	bh=S85u9Vd8bwRPw9yrtEJnMsDDfBmi6Cn6GYO5y60rirM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jR6OB0eJepuUgW+8RX4cCYqijbPsezCmjsHq90yIEN/6kgju0pIpbCyHiE1GM9jme
	 fDWkxxfI6C7Tt7gN7+LeVOmppiea60KFBIME41ZDLGPu5aERAX9JGg8JFZt8Bcf2Xz
	 zqo9tvq0hmRqydJEqE5gep/4f2UZBtXu0d29v/zEDYTZi5fqyTgUSPTRwxZXJpsKBy
	 tT1tLfi6Xn754CPZN46nsxWB5Vr5z0+TxmM+yZZqGdUnTK7DxbuB/FfdS8FqnTjhkL
	 emTYVKdUJBakbDrpfcrmNdvXr63XsSAZ1GYzhQVbiB+g4+X3OUX1vbRfxO+hHp/81n
	 nYO0POQo1sW6Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:52 +0200
Subject: [PATCH v2 10/21] binfmt_misc: add transparent interpreter dispatch
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-10-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4238; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DSYNqcIM1+jrmVAVu+qrpBRkYhiyLa1vNJEMqRXR1aY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x1wO/crMUBx8t/50vx2Mey8vtPP+rDvvt78b3rXi
 yXcYm++d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExESp6R4ecxtagJQQUX1jzq
 P/9hC7dp4W25X399lS36+v6+WP/n2hZGhjfTbs9aHVG4cG7O+ml307dNWNM676j8HZvNE1IdN0W
 XtjEAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A binfmt_misc interpreter is visible to the binary it runs. argv[0]
becomes the interpreter path and the binary's path is appended as an
argument and /proc/pid/cmdline shows both. For wine or qemu-user that is
the point. For a per-binary loader the interpreter is an implementation
detail of running the binary that has no business in the argument
vector. And a binary handed to execveat() as an O_CLOEXEC fd without a
usable path cannot be run through binfmt_misc at all. The interpreter
would have no path to open the binary by.

Add the dispatch machinery for a transparent mode. The binary is handed
to the interpreter through AT_EXECFD. The argument vector and
bprm->interp are left exactly as the caller set them. argv[0] and
/proc/pid/cmdline look like a direct execution of the binary.

The interpreter loads the binary from AT_EXECFD for this. A relocatable
loader can and glibc's ld.so is gaining AT_EXECFD support [1]. A staged
interpreter argument is rejected: no argv slot is built for it to land
in.

The transparent branch raises BINPRM_FLAGS_TRANSPARENT_INTERP. A
dispatch through it labels mm->exe_file with the binary and raises
AT_FLAGS_TRANSPARENT_INTERP next to AT_EXECFD. The aux vector bit is the
loader's hint to retarget saved_auxv and the statistics markers to the
binary, which is only correct while the exe link names the binary too.

The inaccessible-path bail moves after handler selection and into the
path-building branch. A transparent interpreter takes the binary from
AT_EXECFD instead of a path, so the restriction does not apply to it
and the O_CLOEXEC execveat() case above can work. Nothing can take the
transparent branch yet.

Link: https://inbox.sourceware.org/libc-alpha/20260717-work-glibc-binfmt_misc-v3-0-45129bfb13fe@kernel.org [1]
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 304109a5091f..e5a17ca935ca 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -50,6 +50,7 @@ enum binfmt_misc_entry_flags {
 	MISC_FMT_OPEN_BINARY	= (1U << 30),
 	MISC_FMT_CREDENTIALS	= (1U << 29),
 	MISC_FMT_OPEN_FILE	= (1U << 28),
+	MISC_FMT_TRANSPARENT	= (1U << 27),
 };
 
 /**
@@ -400,6 +401,10 @@ static int build_interp_argv(struct linux_binprm *bprm, const char *interpreter,
 {
 	int retval;
 
+	/* The interpreter has to be able to load the binary by path. */
+	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
+		return -ENOENT;
+
 	/* The entry's own choice - not one accumulated from an earlier level. */
 	if (flags & MISC_FMT_PRESERVE_ARGV0) {
 		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
@@ -458,21 +463,23 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (!fmt)
 		return -ENOEXEC;
 
-	/* Need to be able to load the file after exec */
-	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
-		return -ENOENT;
-
 	interpreter = entry_select_interpreter(fmt, bprm);
 	if (IS_ERR(interpreter))
 		return PTR_ERR(interpreter);
 
 	flags = entry_invocation_flags(fmt, bprm);
 
-	retval = build_interp_argv(bprm, interpreter, flags);
-	if (retval)
-		return retval;
+	/* No argv is built for a staged argument to land in. */
+	if ((flags & MISC_FMT_TRANSPARENT) && bprm->bpf_interp_arg)
+		return -EINVAL;
 
-	/* Update interp in case binfmt_script needs it. */
+	if (!(flags & MISC_FMT_TRANSPARENT)) {
+		retval = build_interp_argv(bprm, interpreter, flags);
+		if (retval)
+			return retval;
+	}
+
+	/* Update interp for the next round; sched_prepare_exec reports it. */
 	retval = bprm_change_interp(interpreter, bprm);
 	if (retval < 0)
 		return retval;
@@ -481,6 +488,10 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (IS_ERR(interp_file))
 		return PTR_ERR(interp_file);
 
+	/* Raise only past the last failure, or an -ENOEXEC decline leaks it. */
+	if (flags & MISC_FMT_TRANSPARENT)
+		bprm->interp_flags |= BINPRM_FLAGS_TRANSPARENT_INTERP;
+
 	bprm->interpreter = interp_file;
 	if (flags & MISC_FMT_OPEN_BINARY)
 		bprm->have_execfd = 1;

-- 
2.53.0

