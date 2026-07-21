Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3D396B9A;
	Tue, 21 Jul 2026 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643306; cv=none; b=lg/L/Q7H76CRrImn0G2FsiH7PvJGPOMzFXMMY8Cn2jjrNYZbd1yK7QYsN/ROZvWfMnHRX5FnTbz0Ht2660SSTzLkz5NAsQ3fKC6B/+jBsNAdlcdVQwjWIW4dbJN4SV0Sc6vSXy1M8Rf3BlEdA3d/q+q+aSMYIWgn75W6uzmifiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643306; c=relaxed/simple;
	bh=EYy1Pu9sggOyd1mg73qy+S9dmEWqaDxMgfL0QQOI1PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBpZU4HXBqcOqB8aXCjnJ8jo9L8LGYNuq3KDgqFSbTQOGEjBa4H/W/QWsmf2B5uFkhclD8mpos1eTTbCRYe4cqgq3Ub0wbWa4FZt926ZBdnmwDcWHnASOAkQhP455nSoMJM6lzFokg6zgCYm3HBZW8tQeSQUDswJ4YLcYZ5iZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4ayPqhB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4ayPqhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF001F000E9;
	Tue, 21 Jul 2026 14:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643304;
	bh=T2FbVYT8GdQbAOGzntvgqBPUl5VQ68Dh/kgqqh0cu2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I4ayPqhB55eMN5+dM+XiWAWa4UCPqkrYYSZyH5aN8HNa687ASChHcgLyf3cUHCBXb
	 knlO07+C0IbewbdWneK0NwurNiopWmhoy6lCmC/q64cM8k97t847cCfU+uuViDhbZq
	 N4zy13yfuxqnjOfkNSq9rif8dGruge12m9mKPPchZJSh1jhKtTVdvo/GA+2h3Lq3jg
	 ytsRNHjDm9Hn0HCVt66s8juaSgZK63nY4EMxJt5KWT0o40WqzOaYAwKo2ThGAoMuFi
	 gnkgJgnSPpZ3XfhdaITG0gbKk6fdZITZEycWjzmFr5oWJaB535MdP85E+RHd516/1M
	 W4TTnCJZzWIVw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:54 +0200
Subject: [PATCH v2 12/21] binfmt_misc: let a bpf handler run the
 interpreter transparently
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-12-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6097; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EYy1Pu9sggOyd1mg73qy+S9dmEWqaDxMgfL0QQOI1PI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x3InaKbViOzVGGv+X32bkdt14euwUxiXRpu239dY
 ov5HXe0o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJSXxj+x7jcTxOJlt5WX21b
 fMZ3yoz5JydkP/G5rGfNs8Dm3+PvMxj+ijXucJ+Yu/Qxf/cSX9X3PVL7rsSU2vAb3e7ofXTt8wM
 dFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Expose transparent mode 'T' to the bpf handler via a new
BPF_BINPRM_TRANSPARENT flag. A bpf handler can decide per binary whether
the dispatch is transparent. This way users may choose a native-looking
loader for one binary and a visible wrapper invocation for the next.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 15 +++++++++++++--
 fs/binfmt_misc.c                          |  2 ++
 fs/binfmt_misc_bpf.c                      | 17 ++++++++++++-----
 include/linux/binfmt_misc.h               |  4 ++++
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index f0a0bdb681fe..81b78e315fad 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -189,8 +189,8 @@ interpreter and the binary, exactly like the optional argument of a ``#!``
 interpreter line, e.g. for a handler that resolves ``$ORIGIN`` in a script's
 ``#!`` path and needs to preserve the argument that followed it.
 
-The invocation flags a static entry fixes at registration - ``P``, ``C``
-and ``O`` - are per-exec choices for a bpf handler, made by the ``load``
+The invocation flags a static entry fixes at registration - ``P``, ``C``,
+``O`` and ``T`` - are per-exec choices for a bpf handler, made by the ``load``
 program with the ``bpf_binprm_set_flags()`` kfunc, so a single handler can
 decide them differently for each binary it handles:
 
@@ -202,6 +202,17 @@ decide them differently for each binary it handles:
 - ``BPF_BINPRM_EXECFD`` opens the binary on the interpreter's behalf and
   passes it through the ``AT_EXECFD`` aux vector entry (the ``O`` flag), so
   the interpreter can run binaries it could not open by path.
+- ``BPF_BINPRM_TRANSPARENT`` runs the interpreter transparently (the ``T``
+  flag): the binary is handed over through ``AT_EXECFD`` as
+  with ``BPF_BINPRM_EXECFD``, but the argument vector is also left as the
+  caller passed it. An interpreter that loads the binary from ``AT_EXECFD``
+  then appears in ``argv[0]`` and ``/proc/pid/cmdline`` as a direct
+  execution of the binary. ``BPF_BINPRM_PRESERVE_ARGV0`` and a staged
+  interpreter argument are rejected in combination with it, just as ``P``
+  is with ``T``. It also lets a handler
+  run a binary passed as an inaccessible ``O_CLOEXEC`` file descriptor to
+  ``execveat()``, which a path-splicing dispatch cannot: the interpreter
+  has no path by which to open it.
 
 Because these are program choices, a ``B`` entry carries no flags in the
 register string; ``F`` (pre-open a fixed interpreter) has no meaning for it.
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 71833b976131..622c62ee6683 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -351,6 +351,8 @@ static unsigned long entry_invocation_flags(const struct binfmt_misc_entry *e,
 		flags |= MISC_FMT_OPEN_BINARY;
 	if (bpf_flags & BPF_BINPRM_CREDENTIALS)
 		flags |= MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY;
+	if (bpf_flags & BPF_BINPRM_TRANSPARENT)
+		flags |= MISC_FMT_TRANSPARENT | MISC_FMT_OPEN_BINARY;
 
 	return flags;
 }
diff --git a/fs/binfmt_misc_bpf.c b/fs/binfmt_misc_bpf.c
index 65a3b8313fbe..c3d1b8c51f90 100644
--- a/fs/binfmt_misc_bpf.c
+++ b/fs/binfmt_misc_bpf.c
@@ -174,19 +174,26 @@ __bpf_kfunc int bpf_binprm_set_interp_arg(struct linux_binprm *bprm,
  * @flags: an OR of enum bpf_binprm_flags values
  *
  * To be called from the load program of a struct binfmt_misc_ops handler. It
- * decides per exec what a static entry fixes at registration with the P, C and
- * O flags: BPF_BINPRM_PRESERVE_ARGV0 keeps the caller's argv[0],
+ * decides per exec what a static entry fixes at registration with the P, C, O
+ * and T flags: BPF_BINPRM_PRESERVE_ARGV0 keeps the caller's argv[0],
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

