Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C039A078;
	Tue, 21 Jul 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643315; cv=none; b=G69CuaDBNBVeibwsmL0oje9L+qkzlda8WpdoVHvnTUEP/pwQ3pTUEkSqTS0YtN259tL3QmYfrGkP8IT+oQMd5+XoFnxdEgrXSvyFarAwoAy1E5/Sjo/geJ+5RgPM09war8E4UgWmap35qttXd3Y+Es/mm+gdxcHQWvZZttkQE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643315; c=relaxed/simple;
	bh=qFJ5ovqMAAT99gsAnowfCX/JHYUOWQhKlZwSrrvkzdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYpQnDGXyawSCJ/DmHHdDYDoNk/RGSk4q94ZGJV/E4YNnWHKtdeDXIwGfesoTlic8iPzfusnsgaV/vbEPDrHKPTYui83Ts64wsfyHTxBJxdjqQlzfEpCOcn84KTc+kFNB9FReq5ZscFE4i1Tgiix7JANbPkECMS57IUrjdOwTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLmRJ+ja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLmRJ+ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493441F00A3F;
	Tue, 21 Jul 2026 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643313;
	bh=BTTXgK6MflQH7VLuF19bKcKZcCVGUHt81E3aPbdRda8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MLmRJ+jaIAPy/yzwojAurYmnlXHImcyyUKBO7ZqgoaSopjxOf+z4CsVM5iPC0/fCr
	 h0mrmwpuycmLXjg/OTJ80P9M0447OdqtErCDrU6hvZQIooN++eYO0p0PCFFVFneh6T
	 Ien9UtDzki1gd/tyDJZEQWsT0DMW+sdJwVm/obLrnHDstjvsVgzN2HcOzGh+QdgKb1
	 UfzF8FoNt4RMhkTKmDE0n9VhQ5lexqI4ed3ScWlszxzZLoQDjfWnCRBLlkSINo+OPC
	 /VCi8z6x9a6HweIn/XlbCKnnPJKU8GJEr6RApKwgDLotT5R4JcatRznZPiOe8bHsRo
	 4h9XHvp9r7aiA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:57 +0200
Subject: [PATCH v2 15/21] exec: carry a PT_INTERP substitute in struct
 linux_binprm
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-15-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5372; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qFJ5ovqMAAT99gsAnowfCX/JHYUOWQhKlZwSrrvkzdo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x3Q8rzc09A3Y3+oWLXcq4+f3m8p+JrlZ3zZp+FAz
 NYz/O8yOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSYMfwh2+nyL6qHfO8PLJ1
 DA4eL3MTyJgTy83utz/TSmnFlxun9BgZ3mSf5lXhtEioZHoYWptjb+ZizB49aYuCUiZDgmXVhSV
 MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

binfmt_misc currently supports an execution model where the registered
interpreter becomes the executed program and the matched binary is
handed to it as payload. The upcoming binfmt_misc loader mode inverts
this. The matched binary remains the executed program and the registered
interpreter is substituted into the role the binary's PT_INTERP would
have played.

Add the channel for that hand-over. bprm->loader carries an
open_exec-style struct file reference from the binfmt_misc match to the
binary format that consumes it. Unlike bprm->interpreter it does not
request a restart of the format search. The stashing handler declines
the exec with -ENOEXEC and the search continues to the real format in
the same round.

Both ELF loaders consume it, so give them the two helpers to do it with
rather than a copy each. bprm_open_interpreter() hands out the substitute
in place of what PT_INTERP names and bprm_drop_loader() releases one that
turned out not to apply.

Establish the complete lifecycle up front so a stashed loader can
neither leak nor be silently ignored.

- Chain restart: if another format wins the round by staging
  bprm->interpreter (binfmt_script) the stashed loader belonged to
  the file being replaced. Drop it at the top of the swap block in
  exec_binprm().

- Unclaimed or error: free_bprm() releases a still-stashed loader
  next to the other bprm file references.

- Silent non-substitution: a final format that reaches
  begin_new_exec() with a pending loader would run the binary while
  ignoring the override. Refuse with -ENOEXEC before the point of no
  return. Formats that do not know about the override (binfmt_flat,
  out-of-tree) need no changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/binfmts.h |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 128964d1e9d6..856731f78d05 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1123,6 +1123,10 @@ int begin_new_exec(struct linux_binprm * bprm)
 	struct task_struct *me = current;
 	int retval;
 
+	/* A pending PT_INTERP substitution this format cannot consume. */
+	if (bprm->loader)
+		return -ENOEXEC;
+
 	/* Once we are committed compute the creds */
 	retval = bprm_creds_from_file(bprm);
 	if (retval)
@@ -1414,6 +1418,39 @@ static void do_close_execat(struct file *file)
 	fput(file);
 }
 
+/**
+ * bprm_open_interpreter - open the interpreter the binary asks for
+ * @bprm: binary that is being executed
+ * @path: the interpreter path named in the binary's PT_INTERP
+ *
+ * A binfmt_misc loader entry substitutes for the interpreter the binary
+ * names. Hand out the stashed substitute if there is one and open @path
+ * if there is not. The caller owns the reference either way and releases
+ * it like any other open_exec() one.
+ *
+ * Return: the interpreter on success, an ERR_PTR on failure
+ */
+struct file *bprm_open_interpreter(struct linux_binprm *bprm, const char *path)
+{
+	if (bprm->loader)
+		return no_free_ptr(bprm->loader);
+	return open_exec(path);
+}
+
+/**
+ * bprm_drop_loader - discard a PT_INTERP substitute that does not apply
+ * @bprm: binary that is being executed
+ *
+ * A binary without PT_INTERP has nothing to substitute for, so drop the
+ * override and let the binary load natively rather than have
+ * begin_new_exec() refuse it. A no-op once bprm_open_interpreter() took
+ * the substitute.
+ */
+void bprm_drop_loader(struct linux_binprm *bprm)
+{
+	do_close_execat(no_free_ptr(bprm->loader));
+}
+
 static void free_bprm(struct linux_binprm *bprm)
 {
 	if (bprm->mm) {
@@ -1433,6 +1470,8 @@ static void free_bprm(struct linux_binprm *bprm)
 	if (bprm->old_mm)
 		exec_mm_put_old(bprm->old_mm);
 	do_close_execat(bprm->file);
+	/* An unconsumed PT_INTERP substitute from a binfmt_misc loader entry. */
+	bprm_drop_loader(bprm);
 	do_close_execat(bprm->executable);
 	/* If a binfmt changed the interp, free it. */
 	if (bprm->interp != bprm->filename)
@@ -1750,6 +1789,9 @@ static int exec_binprm(struct linux_binprm *bprm)
 		if (!bprm->interpreter)
 			break;
 
+		/* A stashed PT_INTERP substitute belonged to the replaced file. */
+		bprm_drop_loader(bprm);
+
 		exec = bprm->file;
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 62465574e2a0..a2daecbb01d6 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -62,6 +62,7 @@ struct linux_binprm {
 		is_check:1;
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
+	struct file *loader;
 	struct file *file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
@@ -159,6 +160,8 @@ extern int begin_new_exec(struct linux_binprm * bprm);
 extern void setup_new_exec(struct linux_binprm * bprm);
 extern void finalize_exec(struct linux_binprm *bprm);
 extern void would_dump(struct linux_binprm *, struct file *);
+struct file *bprm_open_interpreter(struct linux_binprm *bprm, const char *path);
+void bprm_drop_loader(struct linux_binprm *bprm);
 
 extern int suid_dumpable;
 

-- 
2.53.0

