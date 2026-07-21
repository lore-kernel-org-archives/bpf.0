Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846C38D3FD;
	Tue, 21 Jul 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643284; cv=none; b=oUmcqLqZfuGz/PdSPimvIVNnYLMPemOwkQSMDJ2uj1c91fWxbyGsmwSrdOd4RAm9HNUk57zNtLMp7Jel02DwPJjAeGQZEeZOi0Gr6yxregd4WhmrPekhLOd7ExpS2BpCJeEj5y5POZwwlzX4kkgESJCELD735GmygVtxmIkUYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643284; c=relaxed/simple;
	bh=QIDHtR3KSxAJAQLN+OvdeHpWTXL5ZRWoOyF3KfYp6pI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZTMAgPis1fmLejCtLPKvxDHWhTHeHLb04AonswE4M2VdjGVwOp93Ic05qgOFFRrA/XI00BxW4ng7NlzGkwXlOtPny52sOJcsrVH9rW+x11Zvgd/dxNWPlc3m1Amke1ghnOSutUx2CBIdHkFSjjgGF+vbtXicbWC7iUPTOUq67VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONsSPN4c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONsSPN4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E2E1F00A3A;
	Tue, 21 Jul 2026 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643280;
	bh=fyGEpYbcwGv7piRskie7GEiXfFGsg+Xr0oBrZjeYwV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ONsSPN4cVun5DrXfOww/uNOoV/vVFsfQmMlEIbMbUTvdBuXX/yaORqZquI1GgvXAX
	 DTnJZ7+R2M56xXMkMgqpqK9xY6ywV2JlcfVIqe11nXNuG31WBWg0zQUN1qaL3TvN+p
	 dnPr5YCsB5OujvP0Ie4+oMqq/uKGRzax5sXVtSAQpaZgeewOztOKIUSuTrqYSza1kC
	 ViLjVQCra09ZvWVfXL30UW9v4pxNUkCZ7QHuijjMjrV/fST1IUn/SB9BEhcURO5z8F
	 W7UN//+6rOr9Z+Y5G32MrRlyaaWhnNS1za+Wp4P9TNN8cb3IU5LzY79x+fB9hgA+Cb
	 DSqJRtCluJyVQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:46 +0200
Subject: [PATCH v2 04/21] binfmt_misc: normalize the per-exec invocation
 flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-4-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3918; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QIDHtR3KSxAJAQLN+OvdeHpWTXL5ZRWoOyF3KfYp6pI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1+23SrF7Y3ddXMkgp+jtotNP3Ze/6Yu4HTF375yTa
 3bM44417ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIfQnDP01mI/4jt+KWSh7t
 mLH5xMU1mqd286xbpOOpcfr/wmP/Vpow/I+YuOeHp/ghvmO/RK+k7nTiOnN/3tTJ2x00uhX4mVf
 NWcgEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A static entry fixes its invocation flags at registration. A 'B' entry's
load program picks them per exec. Since load_misc_binary() branches on
which kind of entry matched and then applies the two flag sets side by
side every flag is handled twice and each new one has to be added to
both arms.

Translate the 'B' flags into the entry flags they mirror and let the
dispatch act on a single set of flags. The boolean the two arms
communicated 'P' can be removed.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 62 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index c0a3b42a38f7..dc2ee012da10 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -319,6 +319,40 @@ static const char *entry_select_interpreter(const struct binfmt_misc_entry *e,
 	return ERR_PTR(retval);
 }
 
+/**
+ * entry_invocation_flags - the invocation flags in effect for this exec
+ * @e: matched binary type handler
+ * @bprm: binary that is being executed
+ *
+ * A static entry fixes its flags at registration, a 'B' entry's load program
+ * picks them per exec with bpf_binprm_set_flags(). Translate the latter into
+ * the former, implications included, so the dispatch has one set to act on.
+ *
+ * Return: the invocation flags for this exec
+ */
+static unsigned long entry_invocation_flags(const struct binfmt_misc_entry *e,
+					    struct linux_binprm *bprm)
+{
+	unsigned long flags = 0;
+	u64 bpf_flags;
+
+	if (!test_bit(MISC_FMT_BPF_BIT, &e->flags))
+		return e->flags;
+
+	bpf_flags = bprm->bpf_flags;
+	/* Clear so they can't accumulate into a nested interpreter level. */
+	bprm->bpf_flags = 0;
+
+	if (bpf_flags & BPF_BINPRM_PRESERVE_ARGV0)
+		flags |= MISC_FMT_PRESERVE_ARGV0;
+	if (bpf_flags & BPF_BINPRM_EXECFD)
+		flags |= MISC_FMT_OPEN_BINARY;
+	if (bpf_flags & BPF_BINPRM_CREDENTIALS)
+		flags |= MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY;
+
+	return flags;
+}
+
 /*
  * the loader itself
  */
@@ -328,7 +362,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	const char *interpreter;
 	struct file *interp_file;
 	struct binfmt_misc *misc;
-	bool preserve_argv0, want_execfd, want_creds;
+	unsigned long flags;
 	int retval;
 
 	misc = current_binfmt_misc();
@@ -347,28 +381,10 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (IS_ERR(interpreter))
 		return PTR_ERR(interpreter);
 
-	/*
-	 * The invocation flags are fixed at registration for a static handler
-	 * and chosen per exec by the load program, via bpf_binprm_set_flags(),
-	 * for a bpf one.
-	 */
-	if (test_bit(MISC_FMT_BPF_BIT, &fmt->flags)) {
-		u64 f = bprm->bpf_flags;
-
-		/* Clear so it can't accumulate into a nested interpreter level. */
-		bprm->bpf_flags = 0;
-
-		preserve_argv0 = f & BPF_BINPRM_PRESERVE_ARGV0;
-		want_creds = f & BPF_BINPRM_CREDENTIALS;
-		want_execfd = f & (BPF_BINPRM_CREDENTIALS | BPF_BINPRM_EXECFD);
-	} else {
-		preserve_argv0 = fmt->flags & MISC_FMT_PRESERVE_ARGV0;
-		want_creds = fmt->flags & MISC_FMT_CREDENTIALS;
-		want_execfd = fmt->flags & MISC_FMT_OPEN_BINARY;
-	}
+	flags = entry_invocation_flags(fmt, bprm);
 
 	/* The entry's own choice - not one accumulated from an earlier level. */
-	if (preserve_argv0) {
+	if (flags & MISC_FMT_PRESERVE_ARGV0) {
 		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
 	} else {
 		retval = remove_arg_zero(bprm);
@@ -424,9 +440,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		return PTR_ERR(interp_file);
 
 	bprm->interpreter = interp_file;
-	if (want_execfd)
+	if (flags & MISC_FMT_OPEN_BINARY)
 		bprm->have_execfd = 1;
-	if (want_creds)
+	if (flags & MISC_FMT_CREDENTIALS)
 		bprm->execfd_creds = 1;
 	return 0;
 }

-- 
2.53.0

