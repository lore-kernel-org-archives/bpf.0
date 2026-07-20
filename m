Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377423D7A15;
	Mon, 20 Jul 2026 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540079; cv=none; b=U3qa60zMmwCsNX4HVwGs/81pgU/z6PjLo7ANcHWnLZMoEfCx7JZeMaS1D6aiq9lE6qyieGh3sSSXpnknXZ7qLyBfnu/YYH3wlsCzxWzU7C2ed0PmdXVTmIZ2O04ayTZs/DfRLuZBdkDwna4FCXPd6C6AARLJkvO7HHuL2V8r2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540079; c=relaxed/simple;
	bh=v5tPPCv52wsIeRY9DExjXFBdHey3BU0E6nUWdZfYbOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kc5O/NQ5cMxH3HjvX55slKYUTgbZaCnYl6D7T/9Lyt5tJGpN5GKdtJI774tcBiFOH7tgKL6mocg9iSgnixgGoRt+dMyRYwOaQv//c85hzyz1gdsUI8wKdO7M/agRYLQOGm6jsAje6UYFGex8FCCtZVYYrcY9+Rbgs9BVa8QzaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlHE95JD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlHE95JD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F9F1F000E9;
	Mon, 20 Jul 2026 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540077;
	bh=+DJlxoJb8mj+WdjBr8RFMm+t5S+/1moQSu0uwd7mnqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DlHE95JDp4x34D0xBiIKdo9k67NeH/iO/Pb1biaLSXfCioymivvQu0UU0wSueR7Dp
	 MuHfN3b9KFCwvmXNzl4F1WnjGtTIasEefrrfhbIlM2wYuEaa54m+8OPGE8n9yo3Tmt
	 uUrvRpGj9FqdctyBoTmGLxR89zZbb5chEFxu2MDNu4GXtfgAzDtRrwJTQNinjzv/FJ
	 7dFN4C91PiEorLS4q9Y1Dc5wlXZX7G70+Tv8vU7w7smbgOfPbZIHPsrs6ootzGL7HE
	 2+paASVXeMqPA0cDC4fT5m+kD/j+gsJxuuuIlgPu1cXoBKC25gRk0oHo1VsnRezXVc
	 oQ+7PuPZxJT/Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:35 +0200
Subject: [PATCH 12/21] binfmt_misc: let a bpf handler run the interpreter
 transparently
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-12-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5682; i=brauner@kernel.org;
 h=from:subject:message-id; bh=v5tPPCv52wsIeRY9DExjXFBdHey3BU0E6nUWdZfYbOc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm5yO6p+4HjCxn9ti9579mU83vAzd8e0zbt/y1mmq
 F85yMz5t6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiR1czMvS6uJ1evotRw+DF
 etNJB2aZeZg8cYs+l1yh1Xz5XorO8wOMDL/1nhwPXeE1YdLtU8oqr+u/G2+b5cm0LEpm3Z73D7Q
 e3OIFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Expose transparent mode 'T' to the bpf handler via a new
BPF_BINPRM_TRANSPARENT flag. A bpf handler can decide per binary whether
the dispatch is transparent. This way users may choose a native-looking
loader for one binary and a visible wrapper invocation for the next.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 14 ++++++++++++--
 fs/binfmt_misc.c                          |  2 ++
 fs/binfmt_misc_bpf.c                      | 13 ++++++++++---
 include/linux/binfmt_misc.h               |  4 ++++
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index c370c72c7dbe..b27ad31847ab 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -185,8 +185,8 @@ interpreter and the binary, exactly like the optional argument of a ``#!``
 interpreter line, e.g. for a handler that resolves ``$ORIGIN`` in a script's
 ``#!`` path and needs to preserve the argument that followed it.
 
-The invocation flags a static entry fixes at registration - ``P``, ``C``
-and ``O`` - are per-exec choices for a bpf handler, made by the ``load``
+The invocation flags a static entry fixes at registration - ``P``, ``C``,
+``O`` and ``T`` - are per-exec choices for a bpf handler, made by the ``load``
 program with the ``bpf_binprm_set_flags()`` kfunc, so a single handler can
 decide them differently for each binary it handles:
 
@@ -198,6 +198,16 @@ decide them differently for each binary it handles:
 - ``BPF_BINPRM_EXECFD`` opens the binary on the interpreter's behalf and
   passes it through the ``AT_EXECFD`` aux vector entry (the ``O`` flag), so
   the interpreter can run binaries it could not open by path.
+- ``BPF_BINPRM_TRANSPARENT`` runs the interpreter transparently (the ``T``
+  flag): the binary is handed over through ``AT_EXECFD`` as
+  with ``BPF_BINPRM_EXECFD``, but the argument vector is also left as the
+  caller passed it. An interpreter that loads the binary from ``AT_EXECFD``
+  then appears in ``argv[0]`` and ``/proc/pid/cmdline`` as a direct
+  execution of the binary. ``BPF_BINPRM_PRESERVE_ARGV0`` is rejected in
+  combination with it, just as ``P`` is with ``T``. It also lets a handler
+  run a binary passed as an inaccessible ``O_CLOEXEC`` file descriptor to
+  ``execveat()``, which a path-splicing dispatch cannot: the interpreter
+  has no path by which to open it.
 
 Because these are program choices, a ``B`` entry carries no flags in the
 register string; ``F`` (pre-open a fixed interpreter) has no meaning for it.
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index ed5ffb330749..1cd30dec3fab 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -350,6 +350,8 @@ static unsigned long entry_invocation_flags(const struct binfmt_misc_entry *e,
 		flags |= MISC_FMT_OPEN_BINARY;
 	if (bpf_flags & BPF_BINPRM_CREDENTIALS)
 		flags |= MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY;
+	if (bpf_flags & BPF_BINPRM_TRANSPARENT)
+		flags |= MISC_FMT_TRANSPARENT | MISC_FMT_OPEN_BINARY;
 
 	return flags;
 }
diff --git a/fs/binfmt_misc_bpf.c b/fs/binfmt_misc_bpf.c
index 00c787e8bdcc..d06cacc5c8c7 100644
--- a/fs/binfmt_misc_bpf.c
+++ b/fs/binfmt_misc_bpf.c
@@ -178,15 +178,22 @@ __bpf_kfunc int bpf_binprm_set_interp_arg(struct linux_binprm *bprm,
  * O flags: BPF_BINPRM_PRESERVE_ARGV0 keeps the caller's argv[0],
  * BPF_BINPRM_CREDENTIALS computes credentials from the binary, and
  * BPF_BINPRM_EXECFD hands the binary to the interpreter through AT_EXECFD.
- * Calling it again replaces the flags, passing zero clears them again.
+ * BPF_BINPRM_TRANSPARENT additionally leaves the argument vector untouched,
+ * making the exec look like a direct execution of the binary. Calling it
+ * again replaces the flags, passing zero clears them again.
  *
- * Return: 0 on success, -EINVAL if @flags contains an unknown bit
+ * Return: 0 on success, -EINVAL if @flags contains an unknown bit or an
+ * invalid combination
  */
 __bpf_kfunc int bpf_binprm_set_flags(struct linux_binprm *bprm,
 				     enum bpf_binprm_flags flags)
 {
 	if (flags & ~(BPF_BINPRM_PRESERVE_ARGV0 | BPF_BINPRM_CREDENTIALS |
-		      BPF_BINPRM_EXECFD))
+		      BPF_BINPRM_EXECFD | BPF_BINPRM_TRANSPARENT))
+		return -EINVAL;
+
+	/* Transparency preserves the whole argv, argv[0] included. */
+	if ((flags & BPF_BINPRM_TRANSPARENT) && (flags & BPF_BINPRM_PRESERVE_ARGV0))
 		return -EINVAL;
 
 	bprm->bpf_flags = flags;
diff --git a/include/linux/binfmt_misc.h b/include/linux/binfmt_misc.h
index d3112a00cc19..26da749391b4 100644
--- a/include/linux/binfmt_misc.h
+++ b/include/linux/binfmt_misc.h
@@ -16,6 +16,9 @@ struct user_namespace;
  * @BPF_BINPRM_CREDENTIALS: compute credentials from the binary; implies execfd
  *                          (like the 'C' flag)
  * @BPF_BINPRM_EXECFD: pass the binary via AT_EXECFD (like the 'O' flag)
+ * @BPF_BINPRM_TRANSPARENT: leave argv untouched, the interpreter takes the
+ *                          binary from AT_EXECFD (like the 'T' flag); implies
+ *                          execfd, excludes preserve-argv0
  *
  * Set from a load program with bpf_binprm_set_flags(). Unlike a static entry,
  * a bpf handler chooses these per exec rather than once at registration.
@@ -24,6 +27,7 @@ enum bpf_binprm_flags {
 	BPF_BINPRM_PRESERVE_ARGV0	= (1ULL << 0),
 	BPF_BINPRM_CREDENTIALS		= (1ULL << 1),
 	BPF_BINPRM_EXECFD		= (1ULL << 2),
+	BPF_BINPRM_TRANSPARENT		= (1ULL << 3),
 };
 
 /**

-- 
2.53.0

