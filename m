Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8943914E1;
	Tue, 21 Jul 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643293; cv=none; b=Y21TVDgkjOZut1HIVYYzva8SkT3+MLpUvjBNtOgb/2K7kcYL02KcC8G0/uN5sf7Ce5cAWjyQ/IayvlHTCNajJ9gdLQGRQXvgodvP0mgz2AkieKskSj9tCIKN977+0wBIMgxUTYsApJuuh/xAPRlAw6rHz2sY9OeMc0tk4v2RAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643293; c=relaxed/simple;
	bh=dcn3exS0UqOj46umxFwpcXTiYELp/TCDmqshcuBqt8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NURFqwjQTWhnlhbaQmPwI9ZgmERs/jhxSVHxvDVvUB+NVGTEmtl80Es9At6DIog9goxC+gZJPp9BogqT95zwWwFshsETLpD+ucoz3nfjsCr+IXcsIY2++i2pqrEPQhw3lnPNUDjdt2nt+q7y8DmmyCIQaOvlLB/s0ojhGW2kTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSWhBb/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSWhBb/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D211F00A3D;
	Tue, 21 Jul 2026 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643292;
	bh=aJFyMzTJ4FolU905whTQ72izW+aZYYQ8/kr3Ly6K5/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oSWhBb/eEZC6UuqZP1IuWojZcpBKT7h33wTakRNloiLoSnl4AnhjwP/O8uzrjLDql
	 Jb5v0LgZh/IVxdGyuMBSZgWTyfGHjCrzhG0dtKzXEQFMsDWVp5htN87Pc5fZ+y5ttr
	 nVqaj0ntKoPD6T1ozecdC6pNuXd6W3uTAZa/sl5955xRskrQ248iEJrgD75Z6+EeWt
	 CwpDA/mHTBIh52+CwiJyK2Kl+ZmnxWk0OlWVyneadTm9Q7XEGH2bYGFQ1PW79VdgW8
	 Wr4AA9qHyUbTFgwprqIoscrgCMToJd9Ptk9ta/737bIIgBeAYbHRr4GWUgIncc3R7A
	 B6sN8bHFIAeHg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:50 +0200
Subject: [PATCH v2 08/21] exec: add AT_FLAGS_TRANSPARENT_INTERP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-8-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5565; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dcn3exS0UqOj46umxFwpcXTiYELp/TCDmqshcuBqt8M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1+2f+XnS6ynL5c49vOmz+cyv1QcmNCdEsO0+tmveD
 dMQ7zvy6R2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATYZvN8D+IZ07hNrM94drV
 m+7wvuKpUm971fj/qsD0dZpHNOzcj4Yx/I88vPe7jF/qlV0u7Od23tv7+GHIneZ6+zf734XnL78
 45TIvAA==
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

BINPRM_FLAGS_TRANSPARENT_INTERP carries the mode from binfmt_misc to the
ELF loaders. Both had their own copy of the AT_FLAGS translation, so
give them one bprm_at_flags() to share instead of a second copy that can
drift. Nothing sets the bprm flag yet.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_elf.c              |  5 +----
 fs/binfmt_elf_fdpic.c        |  5 +----
 include/linux/binfmts.h      | 22 ++++++++++++++++++++++
 include/uapi/linux/binfmts.h |  7 +++++++
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 16a56b6b3f6c..be8fd437b5a3 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -179,7 +179,6 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	unsigned char k_rand_bytes[16];
 	int items;
 	elf_addr_t *elf_info;
-	elf_addr_t flags = 0;
 	int ei_index;
 	const struct cred *cred = current_cred();
 	struct vm_area_struct *vma;
@@ -254,9 +253,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
-		flags |= AT_FLAGS_PRESERVE_ARGV0;
-	NEW_AUX_ENT(AT_FLAGS, flags);
+	NEW_AUX_ENT(AT_FLAGS, bprm_at_flags(bprm));
 	NEW_AUX_ENT(AT_ENTRY, e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index fe0b5c5ed2bc..0a3cdf280307 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -509,7 +509,6 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	char *k_platform, *k_base_platform;
 	char __user *u_platform, *u_base_platform, *p;
 	int loop;
-	unsigned long flags = 0;
 	int ei_index;
 	elf_addr_t *elf_info;
 
@@ -649,9 +648,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
-		flags |= AT_FLAGS_PRESERVE_ARGV0;
-	NEW_AUX_ENT(AT_FLAGS,	flags);
+	NEW_AUX_ENT(AT_FLAGS,	bprm_at_flags(bprm));
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
 	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 03e1794b5cbb..62465574e2a0 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -93,6 +93,28 @@ struct linux_binprm {
 #define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
 #define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
 
+/* binfmt_misc dispatched to the interpreter transparently */
+#define BINPRM_FLAGS_TRANSPARENT_INTERP_BIT 4
+#define BINPRM_FLAGS_TRANSPARENT_INTERP (1 << BINPRM_FLAGS_TRANSPARENT_INTERP_BIT)
+
+/**
+ * bprm_at_flags - the AT_FLAGS this invocation implies
+ * @bprm: binary that is being executed
+ *
+ * Tell the program on the receiving end which dispatch contract it got.
+ *
+ * Return: the AT_FLAGS value for this exec
+ */
+static inline unsigned long bprm_at_flags(const struct linux_binprm *bprm)
+{
+	/* Transparency preserves the whole argv, argv[0] included. */
+	if (bprm->interp_flags & BINPRM_FLAGS_TRANSPARENT_INTERP)
+		return AT_FLAGS_TRANSPARENT_INTERP;
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
+		return AT_FLAGS_PRESERVE_ARGV0;
+	return 0;
+}
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

