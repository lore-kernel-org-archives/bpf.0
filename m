Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE83D79F9;
	Mon, 20 Jul 2026 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540070; cv=none; b=hr5YeTUEWfjnmy3jLHdetOUIW8GNfia6dZW6I5G3o/IZfEKdVhCfn6Wv2r0Jcr7+UmPCwsAB6erQPGV5YlB6bGof98BAJmeb7pNDLLuglALVYbE0RGBN7fxkjDy7yVZO9vxUZyFn4v5zVkLOyUkl8xM38N2UTcY22R+1X2EI46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540070; c=relaxed/simple;
	bh=i7lH8bNEiRx9Hi67BUFlmbcbsKQKKwiaM+41Ap7Y50w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsZHPHT/vrt6h5g5k97S0qlQoj1JYxhOZz90Ou3VsPM9A8KGgXSVAIDIIQUJ2XOVK4FQ2CSaoqYqponyFvKLWRE/MolFkOTUtPBcPvno2rdhTWMcLCfVkCf+1uwHMDiH7qTSNz2dfO4JM4kdp5RREtqprBqe//vJdZA4FrUjM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtcLvcUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtcLvcUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4665D1F00A3A;
	Mon, 20 Jul 2026 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540068;
	bh=wAKUaYj5DHW9nm1lOWEWXJhJ77C/0u0qe7FA/HC26JE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PtcLvcUWgji8C06pO0Nbhwhuinq8erGH6bGMb88UpzguOUqi8cwYu177TSeZfq3nK
	 JuOIjRKM++e1kFvETq/72YFxc1wl+YD+c4w2LS+2ftIdOm/K3OaozZBG8PrkqH+lMB
	 Z6X4uxML9bRxF9qiy/G8m4nYTuOUCeWApMNvaLKGConVh4HB0sGHgBV8KVnUBz0WQ/
	 +6bz2t91NfmIm2BVuBg9Mc0bfjCI9CAiTo+Wm7+oxFMQjhnS6RqmWc9ZwwqSgwwkC8
	 alnweCozFNKlHCNztQ029Go+EDXQN9BTkXnG5fCSjgjZmEKckkj0bMgzeOE+ofzutL
	 ib61ufI5orCOg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:32 +0200
Subject: [PATCH 09/21] exec: label mm->exe_file with the binary for a
 transparent dispatch
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-9-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5670; i=brauner@kernel.org;
 h=from:subject:message-id; bh=i7lH8bNEiRx9Hi67BUFlmbcbsKQKKwiaM+41Ap7Y50w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm5yv1tXtSltJovFJx2r1+qzFujUPQ37qJTg8zWDq
 9C7N4Kno5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLPgxj+x6oHSVama7zOueS3
 73DIwaceCj0m7v+/XNXeFBcuci6DgeF/hceE9XcbtliXcfyTFpjLVPx1y/vnx85u+Xb8y4zDBcq
 pTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When binfmt_misc dispatches a binary to an interpreter, the interpreter
becomes bprm->file and begin_new_exec() labels mm->exe_file with it. For
wine or qemu-user that is the point. For the transparent mode it
defeats the point. The interpreter is an implementation detail and the
process's identity is the binary. Relocatable programs that locate
themselves via /proc/self/exe find the dynamic linker instead [1].

Userspace cannot repair this after the fact. The exe link is the one
capability-gated field of PR_SET_MM_MAP, deliberately, because an
uncapped exe swap lets any ptrace-capable process masquerade as an
arbitrary executable.

bprm->executable is the file execve() access-checked and kept open for
AT_EXECFD. It is already the file would_dump() bases the dumpability
decision on and the file bprm->execfd_creds derives credentials from.
Label mm->exe_file with it when the dispatch is transparent and the
identity is correct from the start. The label names precisely the file
the caller passed to execve().

Write-denial moves along with the label. The result is exact parity with
a direct execution. A concurrently written binary fails execve() with
-ETXTBSY at open and a running one cannot be opened for writing. The
interpreter consequently is not exe-pinned and matches the role it has
in a native PT_INTERP exec.

Nothing sets BINPRM_FLAGS_TRANSPARENT_INTERP yet; the transparent
dispatch machinery in binfmt_misc follows and raises it from birth, so
the label and the aux vector bit that announces it appear together.

Link: https://inbox.sourceware.org/libc-alpha/87ik6fymha.fsf@oldenburg.str.redhat.com [1]
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               | 33 ++++++++++++++++++++++++++++-----
 include/linux/binfmts.h |  4 +++-
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6e540f4b43d8..45d416994682 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1101,6 +1101,17 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 	perf_event_comm(tsk, exec);
 }
 
+/*
+ * The file the process presents as: its exe link and comm. A transparent
+ * dispatch presents as the binary, which is bprm->executable.
+ */
+static struct file *bprm_identity_file(const struct linux_binprm *bprm)
+{
+	if (bprm->interp_flags & BINPRM_FLAGS_TRANSPARENT_INTERP)
+		return bprm->executable;
+	return bprm->file;
+}
+
 /*
  * Calling this is the point of no return. None of the failures will be
  * seen by userspace since either the process is already taking a fatal
@@ -1157,7 +1168,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * not visible until then. Doing it here also ensures
 	 * we don't race against replace_mm_exe_file().
 	 */
-	retval = set_mm_exe_file(bprm->mm, bprm->file);
+	retval = set_mm_exe_file(bprm->mm, bprm_identity_file(bprm));
 	if (retval)
 		goto out;
 
@@ -1247,6 +1258,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * Let's fix it up to be something reasonable.
 	 */
 	if (bprm->comm_from_dentry) {
+		struct file *comm_file = bprm_identity_file(bprm);
+
 		/*
 		 * Hold RCU lock to keep the name from being freed behind our back.
 		 * Use acquire semantics to make sure the terminating NUL from
@@ -1256,7 +1269,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 		 * detecting a concurrent rename and just want a terminated name.
 		 */
 		rcu_read_lock();
-		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
+		__set_task_comm(me, smp_load_acquire(&comm_file->f_path.dentry->d_name.name),
 				true);
 		rcu_read_unlock();
 	} else {
@@ -1300,6 +1313,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 		retval = FD_ADD(0, bprm->executable);
 		if (retval < 0)
 			goto out_unlock;
+		/* mm->exe_file carries its own write denial now. */
+		if (bprm->executable_denied)
+			exe_file_allow_write_access(bprm->executable);
 		bprm->executable = NULL;
 		bprm->execfd = retval;
 	}
@@ -1419,8 +1435,12 @@ static void free_bprm(struct linux_binprm *bprm)
 	if (bprm->old_mm)
 		exec_mm_put_old(bprm->old_mm);
 	do_close_execat(bprm->file);
-	if (bprm->executable)
+	if (bprm->executable) {
+		/* A transparent dispatch still holds the write denial. */
+		if (bprm->executable_denied)
+			exe_file_allow_write_access(bprm->executable);
 		fput(bprm->executable);
+	}
 	/* If a binfmt changed the interp, free it. */
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
@@ -1746,8 +1766,11 @@ static int exec_binprm(struct linux_binprm *bprm)
 				do_close_execat(exec);
 				return -ENOEXEC;
 			}
-			/* Only the reference is kept, for AT_EXECFD. */
-			exe_file_allow_write_access(exec);
+			/* A transparent dispatch keeps the denial for mm->exe_file. */
+			if (bprm->interp_flags & BINPRM_FLAGS_TRANSPARENT_INTERP)
+				bprm->executable_denied = 1;
+			else
+				exe_file_allow_write_access(exec);
 			bprm->executable = exec;
 		} else {
 			do_close_execat(exec);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index d4f64d143d1a..ba5037b69866 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -59,7 +59,9 @@ struct linux_binprm {
 		 * Set by user space to check executability according to the
 		 * caller's environment.
 		 */
-		is_check:1;
+		is_check:1,
+		/* bprm->executable holds a write denial still to be released. */
+		executable_denied:1;
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
 	struct file *file;

-- 
2.53.0

