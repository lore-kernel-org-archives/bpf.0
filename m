Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D73D25CC;
	Mon, 20 Jul 2026 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540066; cv=none; b=iQ2weaumOskYOpL0h6o+N3AAyVpfCXSvdfqJAOFFa7g//7hG2DCNA9lMvtU3sG13zRZ24mBLnS6WVEa4d29iN96mgTNw/vcwrcHkyLk3pNwvzHxP5zh833Mar0qLyRmcrDtB2Y3lbTwItNBMrPjNzn7csm5KYPzhPVW6F4re+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540066; c=relaxed/simple;
	bh=HTd4FlQ/ImzVQFbVjYVnYvCT5MQJdjtKW6kGkWqTDs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g3Y/1kFfd5cZ9jV8Hqe4E8eJtV0fJ8p//2De+iQATy7kuxEfjDZjprCdfeBn+WZGFNPkIOOjt9NSCkVASqOK5twvyDBpUe40OLS4B11fj1YQdpRW5b7jqZ0YpWk1LI7Q+MIPJHKJZb6hX42hPIzELeyaNrbuus3kO2i+BoFiFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL9HwLcI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL9HwLcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CBC1F000E9;
	Mon, 20 Jul 2026 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540064;
	bh=qiqkk6rXeNnoqsmRilhTR74TetGVo2qWnVY/kCrNM9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KL9HwLcIv8tVa5sPFjWGyTsjHza2tuUE3dpiQXmXF5Y6K55NFaTwY2sSDcqnTzbHQ
	 bKOWNkU6CGhFzONqd6QNHEDM/4UV3x4tGWZIdmRW/IiAisXLy+YmUFGneBqrGlBIQP
	 DexRGWtMLkDa6ubxnhaqqCMTZhF6hDTUNhrAMw/pRCdjG/yWhcxEzlL8VvtKQQitsy
	 vTV5a1/cMQfqh0OuDM6p97pxEH0uTReOmoDIAuO7ALGRCY0XXiJ6ndUJgfNuqWUZ35
	 1pItIQDNMSBsfh94YEPOxnBIlg83a8DIUQrUazIaOEFrh2OAO+wxn9wn+Sh0ZN1ngA
	 KA0nHZRk3vAHg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:31 +0200
Subject: [PATCH 08/21] exec: add AT_FLAGS_TRANSPARENT_INTERP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-8-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4399; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HTd4FlQ/ImzVQFbVjYVnYvCT5MQJdjtKW6kGkWqTDs0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm4KV5BpNiyZcrzlW2+61XqH7AVL+Zyn8s6XebLt/
 50pcnF+HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZGMjI8Ou737uDJs6/tl9s
 0TZMrdH/fPZbgfW8hPl3zdj0V703MWH4H/Tn5s19J6UnMRRbySnOeTyPdYZSgE+Y0hr9DI+j3kV
 L2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A transparent binfmt_misc dispatch hands the binary to the interpreter
through AT_EXECFD and leaves the argument vector exactly as the caller
built it. The loader on the receiving end has to know which contract it
got.

On the classic 'O'/'C' entries the binary's path is spliced into the
argument vector and the loader consumes arguments. In transparent mode
nothing was spliced and argv belongs entirely to the program. This
cannot be inferred from AT_EXECFD alone. Raise a new AT_FLAGS bit
following the AT_FLAGS_PRESERVE_ARGV0 precedent added for qemu-user in
commit 2347961b11d4 ("binfmt_misc: pass binfmt_misc flags to the
interpreter").

The bit also announces that mm->exe_file names the binary rather than
the interpreter (added in the next commit). A loader that sees the bit
may finish the identity polish by fixing up AT_PHDR/AT_ENTRY/AT_BASE in
saved_auxv and fix the code/data markers via one uncapped PR_SET_MM_MAP
once it has mapped the binary. I've got glibc patches for this as well
but it's useful for any loader.

BINPRM_FLAGS_TRANSPARENT_INTERP carries the mode from binfmt_misc to
the ELF loaders. Both create_elf_tables() variants translate it into
the aux vector bit. Nothing sets the bprm flag yet.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_elf.c              | 5 ++++-
 fs/binfmt_elf_fdpic.c        | 5 ++++-
 include/linux/binfmts.h      | 4 ++++
 include/uapi/linux/binfmts.h | 7 +++++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 16a56b6b3f6c..e44230242f3a 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -254,7 +254,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
+	/* Transparency preserves the whole argv, argv[0] included. */
+	if (bprm->interp_flags & BINPRM_FLAGS_TRANSPARENT_INTERP)
+		flags |= AT_FLAGS_TRANSPARENT_INTERP;
+	else if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
 		flags |= AT_FLAGS_PRESERVE_ARGV0;
 	NEW_AUX_ENT(AT_FLAGS, flags);
 	NEW_AUX_ENT(AT_ENTRY, e_entry);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 7e3108489c83..3306d21ab738 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -645,7 +645,10 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
+	/* Transparency preserves the whole argv, argv[0] included. */
+	if (bprm->interp_flags & BINPRM_FLAGS_TRANSPARENT_INTERP)
+		flags |= AT_FLAGS_TRANSPARENT_INTERP;
+	else if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
 		flags |= AT_FLAGS_PRESERVE_ARGV0;
 	NEW_AUX_ENT(AT_FLAGS,	flags);
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 03e1794b5cbb..d4f64d143d1a 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -93,6 +93,10 @@ struct linux_binprm {
 #define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
 #define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
 
+/* binfmt_misc dispatched to the interpreter transparently */
+#define BINPRM_FLAGS_TRANSPARENT_INTERP_BIT 4
+#define BINPRM_FLAGS_TRANSPARENT_INTERP (1 << BINPRM_FLAGS_TRANSPARENT_INTERP_BIT)
+
 /*
  * This structure defines the functions that are used to load the binary formats that
  * linux accepts.
diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
index c6f9450efc12..aafc07d78b80 100644
--- a/include/uapi/linux/binfmts.h
+++ b/include/uapi/linux/binfmts.h
@@ -22,4 +22,11 @@ struct pt_regs;
 #define AT_FLAGS_PRESERVE_ARGV0_BIT 0
 #define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
 
+/*
+ * The interpreter runs transparently: the argument vector and the exe
+ * link belong to the binary passed in AT_EXECFD.
+ */
+#define AT_FLAGS_TRANSPARENT_INTERP_BIT 1
+#define AT_FLAGS_TRANSPARENT_INTERP (1 << AT_FLAGS_TRANSPARENT_INTERP_BIT)
+
 #endif /* _UAPI_LINUX_BINFMTS_H */

-- 
2.53.0

