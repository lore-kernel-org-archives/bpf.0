Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD653D75B1;
	Mon, 20 Jul 2026 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540102; cv=none; b=Q6eqvMrm/7R/TLLmgJ/G26WYD4qg4hZzQF0QISuqSmbmjcpbZMdFuUhQNdBezuWTdTsxCMK+EjW5Jhruav0W462qLwFGgcx1JCsYKL7vPfH/vES35Zhmo88Ca11D2mFMOMhmGTGMdLqnAA8gfDi+NHzbDdZ1gdS5+v+WSp0FA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540102; c=relaxed/simple;
	bh=fpnyYgaduuYcnmiRWrnp5KJACtxZzgRt5ZnDAdYlXgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ppKZrTBSAx2PJdiOSsQdnKG/OzHZHrLlF3OCyEdWlNPTBTeHf8FCs9yxF0U42oCDXrn3pP6D41kAcDysrugnWb2mYovKVLknYQQzeweHSfYEDL7igiJTNTL7m0FjbtquvejUAck8Gp8GmCYUKEWD0Cdr1RJnvtAq6ENdkn5xYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFpa0F5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFpa0F5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB64B1F000E9;
	Mon, 20 Jul 2026 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540100;
	bh=HynziS7CVaLQmLs1bVJl54Y4DOs2g3hrDdx+YCwmeqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PFpa0F5/CB/QfH5q/uNDOfoOoOzibT7pPTXuumMezjfn6sd6r0JQCPQKZ6JaMInV2
	 buQ5YXOW15E0XLhGZyW+MP/0ApTUacgjJpls9U5Vkt9su2DdAgxksjUdw3piNY9+hh
	 Di/Ky3I33PgNtgs8GlTYmF6xiJf/dWCSk9IG3cRNRrXAXKs7niTAff/9FN0i9vLbSY
	 RewBIMo+0HjhY3ovkLbpmwLMY+d0jZv+U/iKGD86KC5u9qbKARyfLb9XqYXPZ/uyHZ
	 ZA1aZ3fi04R8BkvtH2I6GD/19oY4dZqCRfsF9PupMLs47BOnBmeVcxyTnM9+IlLlBK
	 p42GkyFAi74pQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:42 +0200
Subject: [PATCH 19/21] binfmt_misc: let a bpf handler request loader
 substitution
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-19-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4971; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fpnyYgaduuYcnmiRWrnp5KJACtxZzgRt5ZnDAdYlXgc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm5+sZpFsep1jzCna/vkdzcPi7zepCierb7ux+nZe
 9RN9jV3d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkwS6Gf7Z3fvjPrO7e06yh
 c3zj8SNP/KY/VfeWXM5ufenYnTOS2jGMDFeOHZix4xdTE8/X5ElpV+b0XZvpmrslupbn/7/tK3Z
 aBbACAA==
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
 Documentation/admin-guide/binfmt-misc.rst |  3 +++
 fs/binfmt_misc.c                          |  2 ++
 fs/binfmt_misc_bpf.c                      | 13 ++++++++++---
 include/linux/binfmt_misc.h               |  4 ++++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 0946ca1923f2..8c861bf0c56c 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -208,6 +208,9 @@ decide them differently for each binary it handles:
   run a binary passed as an inaccessible ``O_CLOEXEC`` file descriptor to
   ``execveat()``, which a path-splicing dispatch cannot: the interpreter
   has no path by which to open it.
+- ``BPF_BINPRM_LOADER`` substitutes the interpreter for the binary's
+  ``PT_INTERP`` and runs the binary as a fully native exec (the ``L``
+  flag). It excludes the other flags and a staged interpreter argument.
 
 Because these are program choices, a ``B`` entry carries no flags in the
 register string; ``F`` (pre-open a fixed interpreter) has no meaning for it.
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index ee48dab2638a..855b41016cf0 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -354,6 +354,8 @@ static unsigned long entry_invocation_flags(const struct binfmt_misc_entry *e,
 		flags |= MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY;
 	if (bpf_flags & BPF_BINPRM_TRANSPARENT)
 		flags |= MISC_FMT_TRANSPARENT | MISC_FMT_OPEN_BINARY;
+	if (bpf_flags & BPF_BINPRM_LOADER)
+		flags |= MISC_FMT_LOADER;
 
 	return flags;
 }
diff --git a/fs/binfmt_misc_bpf.c b/fs/binfmt_misc_bpf.c
index d06cacc5c8c7..105c8afbb3f2 100644
--- a/fs/binfmt_misc_bpf.c
+++ b/fs/binfmt_misc_bpf.c
@@ -179,8 +179,10 @@ __bpf_kfunc int bpf_binprm_set_interp_arg(struct linux_binprm *bprm,
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

