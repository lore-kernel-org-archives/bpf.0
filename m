Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE743552E;
	Tue, 14 Jul 2026 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059122; cv=none; b=V/HHzbnGGV1MtQfG3DGrK4lcPsrWP1i+BYMyHi3v44Bkn7drPjGVFepco8E8a4eN7x3qLlJk5hzYym5oMx8ZFk3EuNDaL91j1fWNrXs3q5bOEsAHMIP203Br66XqdsBt2ZSsa7Il6R4w/VBK4YbcLydR+PgPN6P2YBJKR0ywskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059122; c=relaxed/simple;
	bh=d4Ff11U2JQdbUrC3jXwwqEI22gBF0oG5S4PDLPyJubc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXM+A1iC5uMMVkQFrrQCJb6xLDevMBNbbsSx7Aprb/yOTnHK7wrwEiYEv4UOuZJvqOO8WwN2Oo5SneeYtuCuZ01FJ+lD9zixkzsRhP0VWxPJSjRujgHCVozjuW2oiLjimGbrS0KIeR+95SvXc8cml634nnK7JOXS29mmJu8APnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldTGOKqe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldTGOKqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E921F00A3D;
	Tue, 14 Jul 2026 19:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059121;
	bh=xrII2yqfAxov3h2f3TrylfxbsK446SzmBTiehyPo/x4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ldTGOKqetGQvzmmKjn7+qOMI2CQ/9ByRH8kK+yHEF8b7tZEOaf7hwWm5/cbxL8Bv7
	 6a7FI642cNuuaarcDRP4nmalI6SpMnBtvbhmnLptlHoJpAfuQhLn+hOGyWfUfv4yjB
	 XDC5UVQaUsQaQMb9hovZnW8xfpwI8kvRYq+/9HLr1XbJVwKE2grcdKh3COPX39A5Xa
	 8Vv2nojgffagoy08HGuJaxGSokDZCIyWffGaAnXYjbiSasjQOttzZWQng0qtsyTYZz
	 0cAHrNHxp7TF71JJPQp5qGoWXyJ8aJoG5F2kilK02nZC+JiEKM9Dtx76xGRoeDOTD1
	 HvwfKREQdcwCw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 14 Jul 2026 21:58:11 +0200
Subject: [PATCH v2 6/9] binfmt_misc: let bpf handlers pass an argument to
 the interpreter
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-work-bpf-binfmt_misc-v2-6-57b7529c002c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4198; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d4Ff11U2JQdbUrC3jXwwqEI22gBF0oG5S4PDLPyJubc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSFTbm8NDhILvuQVPpNFlE35xeTw8IzTljX+s1o6Qm78
 ekxM9vmjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkc6Wb4X9vyzaNRKLUs7LdB
 hEfiiRPN0Yf9wn/u+HGUR5jF42unCMM/+wVCEm/mlN55NCvj9/3zkQt0+F0eC2/4vjNl46SeK5F
 uXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A bpf binfmt_misc handler selects an interpreter but, unlike binfmt_script,
load_misc_binary() builds the argument vector as just [interpreter, binary,
...] with no slot for an argument to the interpreter. A handler that wants
to reproduce a #! line therefore cannot express its single optional
argument, e.g. a handler that resolves $ORIGIN in a script's #! path loses
the argument that followed the interpreter.

Have load_misc_binary() consume the argument staged through the
bpf_binprm_set_interp_arg() kfunc and insert it between the interpreter and
the binary - the same position and single-argument semantics binfmt_script
gives the argument of a #! line. The argument is cleared once spliced into
the argument vector, and a load program that fails after staging one has it
dropped on the way out: whether the exec fails or -ENOEXEC hands the binary
back to the remaining formats, a stale argument cannot leak into a nested
interpreter's argv. This also lets static-style handlers pass a fixed
interpreter argument, which plain binfmt_misc has never been able to
express.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst |  6 ++++++
 fs/binfmt_misc.c                          | 30 ++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 45541604d528..6128057160e3 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -129,6 +129,12 @@ entries; ``-ENOEXEC`` lets the remaining binary formats have a go. The
 interpreter is opened with the credentials of the task doing the exec,
 exactly as a statically registered interpreter would be.
 
+The ``load`` program can also pass a single argument to the interpreter with
+the ``bpf_binprm_set_interp_arg()`` kfunc. It is inserted between the
+interpreter and the binary, exactly like the optional argument of a ``#!``
+interpreter line, e.g. for a handler that resolves ``$ORIGIN`` in a script's
+``#!`` path and needs to preserve the argument that followed it.
+
 Handlers are looked up in the user namespace the struct_ops map was
 registered in, falling back to ancestor namespaces, mirroring how
 binfmt_misc instances themselves are looked up. The entry keeps the handler
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a8f641c4ec2b..3fbc51197c76 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -268,14 +268,22 @@ static const char *entry_select_interpreter(const struct binfmt_misc_entry *e,
 		/* Keep a program-supplied error within errno range. */
 		if (retval > 0 || retval < -MAX_ERRNO)
 			retval = -ENOEXEC;
-		return ERR_PTR(retval);
+		goto drop_staged;
 	}
 
 	/* Selecting an interpreter is part of the contract. */
-	if (!bprm->bpf_interp)
-		return ERR_PTR(-ENOEXEC);
+	if (!bprm->bpf_interp) {
+		retval = -ENOEXEC;
+		goto drop_staged;
+	}
 
 	return bprm->bpf_interp;
+
+drop_staged:
+	/* A failing load leaves nothing behind for later entries. */
+	kfree(bprm->bpf_interp_arg);
+	bprm->bpf_interp_arg = NULL;
+	return ERR_PTR(retval);
 }
 
 /*
@@ -316,12 +324,26 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (fmt->flags & MISC_FMT_OPEN_BINARY)
 		bprm->have_execfd = 1;
 
-	/* make argv[1] be the path to the binary */
+	/* make the binary the last argument to the interpreter */
 	retval = copy_string_kernel(bprm->interp, bprm);
 	if (retval < 0)
 		return retval;
 	bprm->argc++;
 
+	/*
+	 * A single optional argument to the interpreter, inserted between it
+	 * and the binary just like the argument of a #! interpreter line.
+	 */
+	if (bprm->bpf_interp_arg) {
+		retval = copy_string_kernel(bprm->bpf_interp_arg, bprm);
+		if (retval < 0)
+			return retval;
+		bprm->argc++;
+		/* Consumed - don't let it leak into a nested interpreter's argv. */
+		kfree(bprm->bpf_interp_arg);
+		bprm->bpf_interp_arg = NULL;
+	}
+
 	/* add the interp as argv[0] */
 	retval = copy_string_kernel(interpreter, bprm);
 	if (retval < 0)

-- 
2.53.0

