Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FBB3ED5DE;
	Tue, 14 Jul 2026 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059126; cv=none; b=SBgrU1KaDsVFOrpn5jYOIhQIZV8Va/G4HapnDKyRyDmfdirvBmV0+y74fzvBg36Aqe+gEyAxnFt63xYUDHfkqKHk8f7fHOd63NCEbfimZXs1uHb1ip9UZ3ij96062UCOUQTjR3XiakswjWloBc/VFGs7VWktjjJb8RqW2j4d/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059126; c=relaxed/simple;
	bh=pRcOZeiAnSAEMiBNYaGd7SrGR13AOsRcfDnsOK+6ZbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+ZnbcLomRZAa6LIlmkHar/NSJUmEJdUps28cFVF3+7UVxb/biyajnLbwVe4E3OW19aOVmNszW0X4V5NbXprkEmJcCh7REMAPjYK1RpJCz66oEH9L+bMvsXaevXlY55ohW/Uh3uR2rXgOA3o6VPRUf8oKSOdov9KyatxXgvmyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcEV24/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcEV24/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008E61F000E9;
	Tue, 14 Jul 2026 19:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059125;
	bh=r400Db0eFmVhpt4B7u39a7XVOL/Lj6Zbx5bElPgIePE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UcEV24/RnzLJrgkozaVceI5HzSPF7HPJxpAZd2Epufb5AcCypWpgAMtEBgiaiDuxb
	 Apy7FsFx6acpJjFNAId3uPO3/ODS/ktIijehpRKlwgLCWcKtzcOlU0ICbwesT32cC4
	 840RqDfwKw30jlH+y9BnT8yvzy/oZmVQr8gr49Ll6nsafMsPssXzGBn2F5OmmKr8wN
	 YwDqE43UgYsXPFHDORkl3kbT8dxSDJqzXyVa6TCdzfbz25WaxTtqbVwkko9khNWPOr
	 G9b3T/WpeVOXcHMzo4d1nN0L8TxPWGxwFlOtO1M3iqXkbCbYC+LXWaXI2NH7YQWL1W
	 hpSzLEsor2CUQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 14 Jul 2026 21:58:12 +0200
Subject: [PATCH v2 7/9] binfmt_misc: let a bpf handler choose the
 invocation flags per exec
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-work-bpf-binfmt_misc-v2-7-57b7529c002c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7396; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pRcOZeiAnSAEMiBNYaGd7SrGR13AOsRcfDnsOK+6ZbU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSFTbmsafKp4Wuak6lpetbzdOd1BRdr1v9umz7z456uV
 aKzavPCO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayVZGRob9R9Pe2iiOdn258
 7fbtLLgyt2HBjCi3I78vzbD6c+Op2DSG/7Xb7yhK7BFtzatiWXDVk6EmdF6I6+f4I7M9ZTYJKlV
 d4QIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The 'P', 'C' and 'O' flags of a binfmt_misc entry - preserve argv[0],
compute credentials from the binary, and pass the binary as an open file
descriptor - are fixed at registration and apply to every binary the entry
matches. A bpf handler matches, selects the interpreter and reads the
binary per exec, so the flags should be its per-exec decision too: one
handler may match both setuid and non-setuid binaries, argv[0]-sensitive
ones and not.

Honor the flags the load program stages in bprm->bpf_flags through the
bpf_binprm_set_flags() kfunc: BPF_BINPRM_PRESERVE_ARGV0,
BPF_BINPRM_CREDENTIALS and BPF_BINPRM_EXECFD map to 'P', 'C' and 'O' and
keep the semantics of their static counterparts, credentials implying the
open file descriptor included.

Flags staged by a load program that then fails are dropped on the way out
so they cannot leak into a later handler's exec, and the argv[0] decision
acts on the entry's own choice instead of testing the accumulated
bprm->interp_flags bit, which an earlier chain level may have left set and
binfmt_misc never clears.

Since a 'B' entry's flags come from the program, it carries none in the
register string: 'P', 'C' and 'O' are rejected there alongside 'F', which
was already meaningless for it. load_misc_binary() takes the flags from
the entry for a static handler and from bprm->bpf_flags for a bpf one.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 23 ++++++++++++----
 fs/binfmt_misc.c                          | 46 +++++++++++++++++++++++--------
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 6128057160e3..7f42abf9cfba 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -135,17 +135,28 @@ interpreter and the binary, exactly like the optional argument of a ``#!``
 interpreter line, e.g. for a handler that resolves ``$ORIGIN`` in a script's
 ``#!`` path and needs to preserve the argument that followed it.
 
+The invocation flags a static entry fixes at registration - ``P``, ``C``
+and ``O`` - are per-exec choices for a bpf handler, made by the ``load``
+program with the ``bpf_binprm_set_flags()`` kfunc, so a single handler can
+decide them differently for each binary it handles:
+
+- ``BPF_BINPRM_PRESERVE_ARGV0`` keeps the caller's ``argv[0]`` (the ``P``
+  flag).
+- ``BPF_BINPRM_CREDENTIALS`` computes credentials from the binary (the ``C``
+  flag), bounded to user namespaces that map the binary's owner just like
+  any other setuid exec.
+- ``BPF_BINPRM_EXECFD`` opens the binary on the interpreter's behalf and
+  passes it through the ``AT_EXECFD`` aux vector entry (the ``O`` flag), so
+  the interpreter can run binaries it could not open by path.
+
+Because these are program choices, a ``B`` entry carries no flags in the
+register string; ``F`` (pre-open a fixed interpreter) has no meaning for it.
+
 Handlers are looked up in the user namespace the struct_ops map was
 registered in, falling back to ancestor namespaces, mirroring how
 binfmt_misc instances themselves are looked up. The entry keeps the handler
 alive; deleting the struct_ops map only prevents new activations.
 
-The ``F`` flag cannot be combined with ``B`` entries: it pre-opens a fixed
-interpreter at registration time and a ``B`` entry has none. The ``C`` flag
-works as it does for a static entry: the interpreter runs with the matched
-binary's credentials, bounded to user namespaces that map the binary's owner
-just like any other setuid exec.
-
 To use binfmt_misc you have to mount it first. You can mount it with
 ``mount -t binfmt_misc none /proc/sys/fs/binfmt_misc`` command, or you can add
 a line ``none  /proc/sys/fs/binfmt_misc binfmt_misc defaults 0 0`` to your
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 3fbc51197c76..a3175521c8dd 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -283,6 +283,7 @@ static const char *entry_select_interpreter(const struct binfmt_misc_entry *e,
 	/* A failing load leaves nothing behind for later entries. */
 	kfree(bprm->bpf_interp_arg);
 	bprm->bpf_interp_arg = NULL;
+	bprm->bpf_flags = 0;
 	return ERR_PTR(retval);
 }
 
@@ -295,6 +296,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	const char *interpreter;
 	struct file *interp_file;
 	struct binfmt_misc *misc;
+	bool preserve_argv0;
 	int retval;
 
 	misc = current_binfmt_misc();
@@ -313,7 +315,32 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (IS_ERR(interpreter))
 		return PTR_ERR(interpreter);
 
-	if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
+	/*
+	 * The invocation flags are fixed at registration for a static handler
+	 * and chosen per exec by the load program, via bpf_binprm_set_flags(),
+	 * for a bpf one.
+	 */
+	if (test_bit(MISC_FMT_BPF_BIT, &fmt->flags)) {
+		u64 f = bprm->bpf_flags;
+
+		/* Clear so it can't accumulate into a nested interpreter level. */
+		bprm->bpf_flags = 0;
+
+		preserve_argv0 = f & BPF_BINPRM_PRESERVE_ARGV0;
+		if (f & BPF_BINPRM_CREDENTIALS)
+			bprm->execfd_creds = 1;
+		if (f & (BPF_BINPRM_CREDENTIALS | BPF_BINPRM_EXECFD))
+			bprm->have_execfd = 1;
+	} else {
+		preserve_argv0 = fmt->flags & MISC_FMT_PRESERVE_ARGV0;
+		if (fmt->flags & MISC_FMT_CREDENTIALS)
+			bprm->execfd_creds = 1;
+		if (fmt->flags & MISC_FMT_OPEN_BINARY)
+			bprm->have_execfd = 1;
+	}
+
+	/* The entry's own choice - not one accumulated from an earlier level. */
+	if (preserve_argv0) {
 		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
 	} else {
 		retval = remove_arg_zero(bprm);
@@ -321,9 +348,6 @@ static int load_misc_binary(struct linux_binprm *bprm)
 			return retval;
 	}
 
-	if (fmt->flags & MISC_FMT_OPEN_BINARY)
-		bprm->have_execfd = 1;
-
 	/* make the binary the last argument to the interpreter */
 	retval = copy_string_kernel(bprm->interp, bprm);
 	if (retval < 0)
@@ -372,8 +396,6 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		return PTR_ERR(interp_file);
 
 	bprm->interpreter = interp_file;
-	if (fmt->flags & MISC_FMT_CREDENTIALS)
-		bprm->execfd_creds = 1;
 	return 0;
 }
 
@@ -650,14 +672,14 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 		return ERR_PTR(-EINVAL);
 
 	/*
-	 * 'F' pre-opens a fixed interpreter at registration time which is
-	 * meaningless for a per-exec computed path. 'C' is fine: it honors the
-	 * suid bits of the matched binary exactly like a static entry, gated by
-	 * the same vfsuid_has_mapping() check in bprm_fill_uid() that keeps the
-	 * transition to uids mapped in the caller's user namespace.
+	 * A bpf handler decides the invocation flags per exec with
+	 * bpf_binprm_set_flags() rather than fixing them at registration, so a
+	 * 'B' entry carries no flags: 'P', 'C' and 'O' become per-exec choices
+	 * and 'F' (pre-open a fixed interpreter) is meaningless for it.
 	 */
 	if (test_bit(MISC_FMT_BPF_BIT, &e->flags) &&
-	    (e->flags & MISC_FMT_OPEN_FILE))
+	    (e->flags & (MISC_FMT_PRESERVE_ARGV0 | MISC_FMT_OPEN_BINARY |
+			 MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_FILE)))
 		return ERR_PTR(-EINVAL);
 
 	return no_free_ptr(e);

-- 
2.53.0

