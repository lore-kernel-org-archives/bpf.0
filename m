Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BF3D45CB;
	Mon, 20 Jul 2026 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540053; cv=none; b=Dyy/WWKfRlBmTuKAdcjh3+ASrDxCTGVTcmph3M/SeIqnbdBLpqqmBQ+0qI7DDR9JGFiQFvma9uD8CVvxq6kjw8dwaH/GAdghNXggaz4bnx/PxJKWj0DFywc8SRST2L98GFwQH24zS64Z0G6d4gGHz5YcV4vm0t7yWcKYpe4EPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540053; c=relaxed/simple;
	bh=WY80KBFFTZ58IsmgG8CgWNhF100PcOIx0XJMaNp2qm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVeBHjVxk2pqFp6TQRz2y3HxSWAr7GwF94doT0hqhHe6AAjaCCtqyubzy2PhMFSGWYD1R5zvayvmnwBTbslrU/FmGCdyIfh2y43+xzNPyXKabpizgmWDWJKSVcOBPXpMenixuyOZClWHqhjLOvNG0jiRZERDqXDVWP/FTaP+M1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO6EIZ93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO6EIZ93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F64B1F000E9;
	Mon, 20 Jul 2026 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540051;
	bh=IxF2LOj5owB7AseMZAs3mwjbsnW5b27Au/f5Wy11w54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jO6EIZ93I+GRI4GA9wOElCT3QrhIn/Qwg5lzTP248wsyruzxdpTd+oP2WutLdxhkL
	 E/XLwAfBoUnqJ2KUahHWvDp6BLljJiDjRaS6++3b0neXMK77FILqYyrK1zuKHkTUgm
	 5cVaZvlhJkPFGI6YMvQaD7lWhDo1nOdSbTv0xnISfGPnDsKAZm7oR3Xdodaq14Tbhh
	 UW064Y5x7qDjQixSErNTZJGXZxK04deUnkz4wAegcobQU6ZW+8vBk6BqUmjaYtofTP
	 PkxRTqq5dc83UBDvVS76918QEyzxGrQJodhoAbxme9HZ2ZizIol/85+UC1lD+9JL/r
	 jtujj0bvz3oow==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:27 +0200
Subject: [PATCH 04/21] binfmt_misc: normalize the per-exec invocation flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-4-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3765; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WY80KBFFTZ58IsmgG8CgWNhF100PcOIx0XJMaNp2qm0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm4qC2c8cZFt6Xvv9EU/Dk5bc8eNZVmhhNeM9HXPc
 i7WndE+0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARA0lGhi+3n/VG1GucNWjn
 P3wlOOdmiOniP3mhmV+TOpPYAnb+nsnwP+tx6/rvPMlpJgUqy43f/575t2PmtdzVF+yc27oqLBg
 qWQE=
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
 fs/binfmt_misc.c | 66 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 521ddda929a4..7a6bbeb8a58c 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -318,6 +318,40 @@ static const char *entry_select_interpreter(const struct binfmt_misc_entry *e,
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
@@ -327,7 +361,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	const char *interpreter;
 	struct file *interp_file;
 	struct binfmt_misc *misc;
-	bool preserve_argv0;
+	unsigned long flags;
 	int retval;
 
 	misc = current_binfmt_misc();
@@ -346,32 +380,14 @@ static int load_misc_binary(struct linux_binprm *bprm)
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
-		if (f & BPF_BINPRM_CREDENTIALS)
-			bprm->execfd_creds = 1;
-		if (f & (BPF_BINPRM_CREDENTIALS | BPF_BINPRM_EXECFD))
-			bprm->have_execfd = 1;
-	} else {
-		preserve_argv0 = fmt->flags & MISC_FMT_PRESERVE_ARGV0;
-		if (fmt->flags & MISC_FMT_CREDENTIALS)
-			bprm->execfd_creds = 1;
-		if (fmt->flags & MISC_FMT_OPEN_BINARY)
-			bprm->have_execfd = 1;
-	}
+	flags = entry_invocation_flags(fmt, bprm);
+	if (flags & MISC_FMT_CREDENTIALS)
+		bprm->execfd_creds = 1;
+	if (flags & MISC_FMT_OPEN_BINARY)
+		bprm->have_execfd = 1;
 
 	/* The entry's own choice - not one accumulated from an earlier level. */
-	if (preserve_argv0) {
+	if (flags & MISC_FMT_PRESERVE_ARGV0) {
 		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
 	} else {
 		retval = remove_arg_zero(bprm);

-- 
2.53.0

