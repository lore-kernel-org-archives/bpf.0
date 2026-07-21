Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8938E5DC;
	Tue, 21 Jul 2026 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643296; cv=none; b=riRb5PxxOKvEbeJfH4U7SCXgLCgis9tbz4zRBiHaGPSwoSc76kmha/Edb8H5hvAtWyWQawPwDouZusfFF/ZDyb+6ccL/s6FRNA4Z+KhMEVsYHnOBbUbn+ZU6NX3m8QAEEmCYmdiSJrFnAWggLjKSFazuaUmPyxRS2OLIlJKqpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643296; c=relaxed/simple;
	bh=sM2Dc+YPuybL6JF2cqrHbEvEsDEbWyegDPXYB4IgrVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k5NAVgNAaeEFEdxfwGDGC2P5q/OH1WZ2MghtBIL6xV5r1VInmij7jQcFVtGO++SOUWLRp1+HnPEeFdZ+QL/eLNkcO7LYMJ0vpq/Pa4C+enJzd/p/iqbDMRB8kHtsE/Wng5LUkmbeLfA8kdv5S/Aq09yG+85Y+4VsJPl46i93x+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D32lg9fl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D32lg9fl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13F11F000E9;
	Tue, 21 Jul 2026 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643295;
	bh=vaTnVCsoJ0zPmaD338tPdJq70OjLXnWk2vap+l5HqNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D32lg9flruBtdAUi53mTuUzpsxElWWYZSJS+/6TJMiYeB03X1v1NOxCby33NVcnBf
	 +Tu2K+lw0/RqOlddnsKiPXCLAGTZ6oFGlaLY1sel4iSdcSus9Yiwi2Gu4j8YrZ9gas
	 UKIotpr+Sz+WRFw1/5cd+1IQke6ThAB8a/8xvpw+MFWYAaU52zIjiYNWJrTDK67+Xd
	 EUHeC6vRw8k9hKIMcHAic22ikSg3h9B1q6/ilvQlpZWjGK1LwsKDiLu7WBsjlzGNa9
	 8RFboFy8+XgAvmKv5o8UFLUJQmw637G7xAcjJHDPs30rVm9PToi+/5pWd2HJb6cCPJ
	 wmod5ZbkBodpw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:51 +0200
Subject: [PATCH v2 09/21] exec: label mm->exe_file with the binary for a
 transparent dispatch
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-9-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5648; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sM2Dc+YPuybL6JF2cqrHbEvEsDEbWyegDPXYB4IgrVQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x3QuFv0enOKZrG811fdK+XR0YsXf3HvYT1zLsCdO
 U022lW+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIc6YwMB9U1qkwdjs+XXfdg
 C/eaO5F5Exgnv/q6/m37ueRYwfmOlQz/A2s1LC5YpRo9c1L4fksi68m7a6qi7mukV37ewrtCRWk
 VHwA=
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

Write-denial moves along with the label. Rather than tracking per mode
who still owes a release, the denial do_open_execat() took stays on
bprm->executable until the file is handed over. begin_new_exec() drops
it right before installing the descriptor - set_mm_exe_file() has taken
its own denial on the identity file by then - and free_bprm() releases
an unconsumed executable with do_close_execat() like the other exec
files. For a transparent dispatch the result is exact parity with a
direct execution: a concurrently written binary fails execve() with
-ETXTBSY at open and a running one cannot be opened for writing. The
interpreter consequently is not exe-pinned and matches the role it has
in a native PT_INTERP exec. A classic execfd dispatch now keeps the
binary write-denied until the exec completes rather than only until the
interpreter swap; the difference is confined to the exec itself.

Nothing sets BINPRM_FLAGS_TRANSPARENT_INTERP yet; the transparent
dispatch machinery in binfmt_misc follows and raises it from birth, so
the label and the aux vector bit that announces it appear together.

Link: https://inbox.sourceware.org/libc-alpha/87ik6fymha.fsf@oldenburg.str.redhat.com [1]
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 061e0f9fb4ef..128964d1e9d6 100644
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
@@ -1151,7 +1162,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * not visible until then. Doing it here also ensures
 	 * we don't race against replace_mm_exe_file().
 	 */
-	retval = set_mm_exe_file(bprm->mm, bprm->file);
+	retval = set_mm_exe_file(bprm->mm, bprm_identity_file(bprm));
 	if (retval)
 		goto out;
 
@@ -1241,6 +1252,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * Let's fix it up to be something reasonable.
 	 */
 	if (bprm->comm_from_dentry) {
+		struct file *comm_file = bprm_identity_file(bprm);
+
 		/*
 		 * Hold RCU lock to keep the name from being freed behind our back.
 		 * Use acquire semantics to make sure the terminating NUL from
@@ -1250,7 +1263,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 		 * detecting a concurrent rename and just want a terminated name.
 		 */
 		rcu_read_lock();
-		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
+		__set_task_comm(me, smp_load_acquire(&comm_file->f_path.dentry->d_name.name),
 				true);
 		rcu_read_unlock();
 	} else {
@@ -1291,10 +1304,17 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	/* Pass the opened binary to the interpreter. */
 	if (bprm->have_execfd) {
-		retval = FD_ADD(0, bprm->executable);
-		if (retval < 0)
-			goto out_unlock;
+		struct file *executable = bprm->executable;
+
+		/* mm->exe_file carries its own write denial now so drop it. */
+		exe_file_allow_write_access(executable);
 		bprm->executable = NULL;
+		retval = FD_ADD(0, executable);
+		if (retval < 0) {
+			/* The reference was not consumed. */
+			fput(executable);
+			goto out_unlock;
+		}
 		bprm->execfd = retval;
 	}
 	return 0;
@@ -1413,8 +1433,7 @@ static void free_bprm(struct linux_binprm *bprm)
 	if (bprm->old_mm)
 		exec_mm_put_old(bprm->old_mm);
 	do_close_execat(bprm->file);
-	if (bprm->executable)
-		fput(bprm->executable);
+	do_close_execat(bprm->executable);
 	/* If a binfmt changed the interp, free it. */
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
@@ -1740,8 +1759,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 				do_close_execat(exec);
 				return -ENOEXEC;
 			}
-			/* Only the reference is kept, for AT_EXECFD. */
-			exe_file_allow_write_access(exec);
+			/* Kept for AT_EXECFD; the write denial rides along until hand-over. */
 			bprm->executable = exec;
 		} else {
 			do_close_execat(exec);

-- 
2.53.0

