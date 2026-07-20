Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45053D669F;
	Mon, 20 Jul 2026 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540091; cv=none; b=U2YPt2rmwAJVf9KBG2awWtYpaX/HfBW96BD+IVxx7BdHh71I70vNvvQbC+0jORZy5/qPHJFZwefZqhlnlYcIYvxbBkFLW6SBjBO/RQK1iOF37GY+DchHGzFuGWhpFNGBIR7i5Yi2aO+qGcPPNykqAJOCMTwNx9msYjhvPAmNXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540091; c=relaxed/simple;
	bh=x2DkL4sFAm5IyQlbm2cRRy4gizA87I+afph09+me8n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYWhEwfle57f3NK2Ccg+D8SUo2KfNAjitgweK2IzFB5iWULTOJmr3GvSEzOxfyG+pfYHstiI3n4r2cinxqZ6RlhliJXrmqMiyVth5HKthwsjaLL/TwGnqKuGNH8vJ+vHwedY4VwcT1K2O3Ov58t5yGNeuKUBtAbTZii3SGiCd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3dcM21p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3dcM21p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8421F00A3D;
	Mon, 20 Jul 2026 09:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540090;
	bh=LTLWrh6caoD4CwLDzNTxAt3JlVH4gwwkfJU5sX9FL1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K3dcM21p+m2SrtYLQIkzXAXOKFJR71qgjlFct9K1ryfM/c1CdWvAnAdravTwuTc/9
	 ZgarO3e4TXpe1IrGauTgUmgSNlELIYaQaHm7FOWcvNe9a2zswu9NKjfxAA01hPoWGN
	 yBnYMrZR2bZAxv9ahZs/5j5mDltPmdi69VyBFoLjcHGpAOtCKbhfrZXImlv7sisIwe
	 EtCyV8B2dw1NNYBpFSw48oxExk0rLHbT4fSaCaMM/lBteTUNUKsakEG0x2snlnqH8k
	 BYCJnGWYUPJEW0doVOVhP9eYMHMrpLjgLyYTgtt+WZtHnbrrk/rEKSRsQDK7I/lqUQ
	 qwne+RUKZdaQA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:39 +0200
Subject: [PATCH 16/21] exec: carry a PT_INTERP substitute in struct
 linux_binprm
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-16-ddb76c9a508e@kernel.org>
References: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
In-Reply-To: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3383; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x2DkL4sFAm5IyQlbm2cRRy4gizA87I+afph09+me8n0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm6yXpq/pXDH3p+bXp8Wyf8690tnmr3pyq8cp1Yfl
 s6dePS+Z0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE9h5l+KcTeOGKlszauJ8u
 p3XXvNSSWyGdWfj/f6NL34YNSe3sqhMZGeacqN/+MKWoZuX7lTcPR+541ZGrq3w34tsXkUJrrcb
 ou3wA
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
  binfmt_elf_fdpic, out-of-tree) need no changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               | 9 +++++++++
 include/linux/binfmts.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 45d416994682..797d9a0cf6c6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1123,6 +1123,10 @@ int begin_new_exec(struct linux_binprm * bprm)
 	struct task_struct *me = current;
 	int retval;
 
+	/* A pending PT_INTERP substitution this format cannot consume. */
+	if (bprm->loader)
+		return -ENOEXEC;
+
 	/* A declined execfd request has no executable for a later format. */
 	if (!bprm->executable) {
 		bprm->have_execfd = 0;
@@ -1435,6 +1439,8 @@ static void free_bprm(struct linux_binprm *bprm)
 	if (bprm->old_mm)
 		exec_mm_put_old(bprm->old_mm);
 	do_close_execat(bprm->file);
+	/* An unconsumed PT_INTERP substitute from a binfmt_misc loader entry. */
+	do_close_execat(bprm->loader);
 	if (bprm->executable) {
 		/* A transparent dispatch still holds the write denial. */
 		if (bprm->executable_denied)
@@ -1757,6 +1763,9 @@ static int exec_binprm(struct linux_binprm *bprm)
 		if (!bprm->interpreter)
 			break;
 
+		/* A stashed PT_INTERP substitute belonged to the replaced file. */
+		do_close_execat(no_free_ptr(bprm->loader));
+
 		exec = bprm->file;
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index ba5037b69866..aa6dac777173 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -64,6 +64,7 @@ struct linux_binprm {
 		executable_denied:1;
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
+	struct file *loader;
 	struct file *file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */

-- 
2.53.0

