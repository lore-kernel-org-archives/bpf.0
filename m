Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C411395AC5;
	Tue, 21 Jul 2026 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643327; cv=none; b=mXYqmu1c2GDj77dJ6DyzMHnR7JQ6+UFwvIptpUmLKUjAsb2lXgy4QF8yTeiSj9lHNfiyeE8ZFbe83zExzHq1egr1ntwDCvKdKxZjFe/ZlHR5d92d2QWilXATzPa8wbNwrW9AH5DBwIDYhtxJncCr3SR61M370wzKQw9AgmacL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643327; c=relaxed/simple;
	bh=JEHnQJKIYxMGNljTHKNxvVS9XbUmoHNBQb6UspZq9Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uc14kQKz4d1iVjBxm3o8na0LacDJd9FFBpKh6sHnhnaLdk7b9jLjNynhuutC9OnVWiNHZm3+Amp+Y6iIrchcKF++LZpC5yeRB6Ie/OXljlb7SXNNAnjsfVrwwdjKRHUGyWLD6nu8mF09+RptAcBXr69zzRKnhAyVsz8BEsU+rTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSVL6ZGp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSVL6ZGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D651F00A3A;
	Tue, 21 Jul 2026 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643326;
	bh=GW3jh5NfuUpeUxnNxdu7QM6ReO5XyrnCyqvrQ8HbVGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CSVL6ZGpGk/wNu/S4yldA/7PhWX7aNLYFm5B+YGSeL6bAYX0rMdjf55Me2DXSrJOh
	 xoIZABC4wjOsckACYO5Irq7KajuJ3aMIcPOfcMfwsQ8j0VAH2w99BZnMMnfh1xvsgH
	 Lop9GPvqZFseMWUhrSiqSI49Ikmra+wuricK51F21tHaaLWt2786+dGDyGtsbXZIG5
	 1FRmXkg8Ynz7G74GRCjRkpH5UAr06vMPRss9EAzhhIkOW43oUAm6ahknhAaAiKOdXg
	 tOhZncIhhdo5obOHKLFD1NEbx84LryDGIVI15EtsYN1VYV6jkGXWIh1C+kyzGMKH4I
	 kCIh7oxJQPUQQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:14:01 +0200
Subject: [PATCH v2 19/21] binfmt_misc: let a bpf handler request loader
 substitution
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-19-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6192; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JEHnQJKIYxMGNljTHKNxvVS9XbUmoHNBQb6UspZq9Sw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x0Iyp69LC692Tb8177VGUs2v5W/F367InWtzsVw+
 Yx/AlkJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZfJfhn4mUucRs2eNKNeUL
 I5LWb1Syy3iefbbl0Cz1CTIFLnEL9jP8lWIu7FNx2zXh66HTfMe5JXTMnYInC9socc52z2qyjM/
 kBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Give bpf handlers the per-exec equivalent of the static 'L' flag. A
load program that sets BPF_BINPRM_LOADER has its selected interpreter
substituted for the binary's PT_INTERP instead of run with the binary
as payload. The binary otherwise executes as a fully native exec.

A single handler can now grade its dispatch per binary: native-arch ELF
with PT_INTERP gets loader substitution for full native identity.
Anything else, such as foreign arch, static, non-ELF can use transparent
or classic dispatch. The load program can read the binary's ELF header
from bprm->buf to make that call.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst |  9 ++++++---
 fs/binfmt_misc.c                          |  2 ++
 fs/binfmt_misc_bpf.c                      | 17 ++++++++++++-----
 include/linux/binfmt_misc.h               |  4 ++++
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index a9f685077925..72b389d61f6f 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -197,9 +197,9 @@ interpreter line, e.g. for a handler that resolves ``$ORIGIN`` in a script's
 ``#!`` path and needs to preserve the argument that followed it.
 
 The invocation flags a static entry fixes at registration - ``P``, ``C``,
-``O`` and ``T`` - are per-exec choices for a bpf handler, made by the ``load``
-program with the ``bpf_binprm_set_flags()`` kfunc, so a single handler can
-decide them differently for each binary it handles:
+``O``, ``T`` and ``L`` - are per-exec choices for a bpf handler, made by the
+``load`` program with the ``bpf_binprm_set_flags()`` kfunc, so a single
+handler can decide them differently for each binary it handles:
 
 - ``BPF_BINPRM_PRESERVE_ARGV0`` keeps the caller's ``argv[0]`` (the ``P``
   flag).
@@ -220,6 +220,9 @@ decide them differently for each binary it handles:
   run a binary passed as an inaccessible ``O_CLOEXEC`` file descriptor to
   ``execveat()``, which a path-splicing dispatch cannot: the interpreter
   has no path by which to open it.
+- ``BPF_BINPRM_LOADER`` substitutes the interpreter for the binary's
+  ``PT_INTERP`` and runs the binary as a fully native exec (the ``L``
+  flag). It excludes the other flags and a staged interpreter argument.
 
 Because these are program choices, a ``B`` entry carries no flags in the
 register string; ``F`` (pre-open a fixed interpreter) has no meaning for it.
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a60e69e4514f..a68f6c18c5cf 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -355,6 +355,8 @@ static unsigned long entry_invocation_flags(const struct binfmt_misc_entry *e,
 		flags |= MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY;
 	if (bpf_flags & BPF_BINPRM_TRANSPARENT)
 		flags |= MISC_FMT_TRANSPARENT | MISC_FMT_OPEN_BINARY;
+	if (bpf_flags & BPF_BINPRM_LOADER)
+		flags |= MISC_FMT_LOADER;
 
 	return flags;
 }
diff --git a/fs/binfmt_misc_bpf.c b/fs/binfmt_misc_bpf.c
index c3d1b8c51f90..92003ea640d3 100644
--- a/fs/binfmt_misc_bpf.c
+++ b/fs/binfmt_misc_bpf.c
@@ -174,13 +174,15 @@ __bpf_kfunc int bpf_binprm_set_interp_arg(struct linux_binprm *bprm,
  * @flags: an OR of enum bpf_binprm_flags values
  *
  * To be called from the load program of a struct binfmt_misc_ops handler. It
- * decides per exec what a static entry fixes at registration with the P, C, O
- * and T flags: BPF_BINPRM_PRESERVE_ARGV0 keeps the caller's argv[0],
+ * decides per exec what a static entry fixes at registration with the P, C,
+ * O, T and L flags: BPF_BINPRM_PRESERVE_ARGV0 keeps the caller's argv[0],
  * BPF_BINPRM_CREDENTIALS computes credentials from the binary, and
  * BPF_BINPRM_EXECFD hands the binary to the interpreter through AT_EXECFD.
  * BPF_BINPRM_TRANSPARENT additionally leaves the argument vector untouched,
- * making the exec look like a direct execution of the binary. Calling it
- * again replaces the flags, passing zero clears them again.
+ * making the exec look like a direct execution of the binary.
+ * BPF_BINPRM_LOADER substitutes the interpreter for the binary's PT_INTERP
+ * and runs the binary as a native exec; it excludes every other flag.
+ * Calling it again replaces the flags, passing zero clears them again.
  *
  * Return: 0 on success, -EINVAL if @flags contains an unknown bit or an
  * invalid combination
@@ -189,7 +191,12 @@ __bpf_kfunc int bpf_binprm_set_flags(struct linux_binprm *bprm,
 				     enum bpf_binprm_flags flags)
 {
 	if (flags & ~(BPF_BINPRM_PRESERVE_ARGV0 | BPF_BINPRM_CREDENTIALS |
-		      BPF_BINPRM_EXECFD | BPF_BINPRM_TRANSPARENT))
+		      BPF_BINPRM_EXECFD | BPF_BINPRM_TRANSPARENT |
+		      BPF_BINPRM_LOADER))
+		return -EINVAL;
+
+	/* Loader substitution is a native exec: no splice, execfd or creds work. */
+	if ((flags & BPF_BINPRM_LOADER) && (flags & ~BPF_BINPRM_LOADER))
 		return -EINVAL;
 
 	/* Transparency preserves the whole argv, argv[0] included. */
diff --git a/include/linux/binfmt_misc.h b/include/linux/binfmt_misc.h
index 26da749391b4..4abdfd36b3fa 100644
--- a/include/linux/binfmt_misc.h
+++ b/include/linux/binfmt_misc.h
@@ -19,6 +19,9 @@ struct user_namespace;
  * @BPF_BINPRM_TRANSPARENT: leave argv untouched, the interpreter takes the
  *                          binary from AT_EXECFD (like the 'T' flag); implies
  *                          execfd, excludes preserve-argv0
+ * @BPF_BINPRM_LOADER: substitute the interpreter for the binary's PT_INTERP
+ *                     and run the binary as a native exec (like the 'L'
+ *                     flag); excludes every other flag
  *
  * Set from a load program with bpf_binprm_set_flags(). Unlike a static entry,
  * a bpf handler chooses these per exec rather than once at registration.
@@ -28,6 +31,7 @@ enum bpf_binprm_flags {
 	BPF_BINPRM_CREDENTIALS		= (1ULL << 1),
 	BPF_BINPRM_EXECFD		= (1ULL << 2),
 	BPF_BINPRM_TRANSPARENT		= (1ULL << 3),
+	BPF_BINPRM_LOADER		= (1ULL << 4),
 };
 
 /**

-- 
2.53.0

