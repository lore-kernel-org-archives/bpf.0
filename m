Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782637AA74;
	Tue, 21 Jul 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643286; cv=none; b=g0wuqBNqdiiZ5FDKaH2cIcTbmrXk3F3flV0QMacvNfoKoVg1sDDnyZsT+Bh5WPtdyVikfS/cplSUKKzj1bP9EjD9ASAGS396Gbso8DfaRknu7gucFjcMU+7686JKXE6PxryZLm4O5qEwZ6LfRnRWMZpphuz+zYRmypVTx1Ym96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643286; c=relaxed/simple;
	bh=k/hMy0kVcRHGLKQwOzJAwZZ8svOPTcyroGFEZc0+CGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZenxHleKjPigf4a5KLNFb4E1wj/VCuo7zzGXIhTSfOy05icG7LGjVo7TLLsz3AXHReirxpJUGhc2vX4eVO5ofLN7XMRZAq6YbC96qK8uvU0suK/BkegbKOKHqhkcq6FOctOCFVcsCXYyFMlY08Rs2f12MYJgr7oSa6MXAoLjpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSdt31W1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSdt31W1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E54C1F00A3D;
	Tue, 21 Jul 2026 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643283;
	bh=duxkptqHCs8NlPAFgm0agkM0Ne79nLrUlXWxBx15U2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gSdt31W17nVihKiXN+zywJvxfCcz1NRvt4sjbDXGtHJNnRe9N/yGaD5fC9MSwIJxi
	 Rv4cXnm3PK356bgiea74LNfkr8MdD+1H+gMQcRQb34aOe9hxZX12zyAHtyZdU08vlm
	 sNyWMrq6CYiBvjeAGCWKy3dKSX8w9wLtm3h1g+AqChnfic59F5T4vGufzbanrsNxiX
	 wiLlE9Ajes5sokGmAHW6/xxw3dt0Vbcs2s81EbgKdbmD1NST2/qwSp0LICiDB1piCt
	 gNLnoRQ+xkmUurpTwOZCKTRUb7P+nUH9qicxCGYPo8K+3NCDaEXWYaaKObtinsryiX
	 pw2gKxUWq8f0Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:47 +0200
Subject: [PATCH v2 05/21] binfmt_misc: split out entry_open_interpreter()
 and build_interp_argv()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-5-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5121; i=brauner@kernel.org;
 h=from:subject:message-id; bh=k/hMy0kVcRHGLKQwOzJAwZZ8svOPTcyroGFEZc0+CGM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1+1nCTN6+O/osnQz4flezpEGHOwi/iliIjy/pFtfG
 xw68HBxRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES8XzL8M1y2mVlcJIYpUKhA
 4CvTE/2bGVu3PZn/8uHuzllsl1U/MTD8M5/ZInTAd59dmcSnf7X3P3x3PWHh+UFv4bKve49GW1s
 0cwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Opening the interpreter is a property of the matched entry: an 'F' entry
hands out a clone of the file it pre-opened at registration time, any
other entry opens the selected path. Give that its own helper instead of
an if/else in the middle of load_misc_binary(), and let it fail early
rather than carrying an ERR_PTR through the successful branch.

Building the interpreter's argument vector is the bulk of what remains
and the one part of load_misc_binary() that is specific to the classic
dispatch. Move it into its own helper too, so the dispatch reads as what
it is: pick a handler, pick an interpreter, build the invocation, open
it.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 110 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 34 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index dc2ee012da10..304109a5091f 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -353,35 +353,52 @@ static unsigned long entry_invocation_flags(const struct binfmt_misc_entry *e,
 	return flags;
 }
 
-/*
- * the loader itself
+/**
+ * entry_open_interpreter - open the entry's interpreter for execution
+ * @e: matched binary type handler
+ * @interpreter: the interpreter selected for this exec
+ *
+ * An 'F' entry hands out a clone of the file it pre-opened at registration,
+ * any other entry opens the selected path.
+ *
+ * Return: the opened interpreter on success, an ERR_PTR on failure
  */
-static int load_misc_binary(struct linux_binprm *bprm)
+static struct file *entry_open_interpreter(const struct binfmt_misc_entry *e,
+					   const char *interpreter)
 {
-	struct binfmt_misc_entry *fmt __free(put_binfmt_handler) = NULL;
-	const char *interpreter;
-	struct file *interp_file;
-	struct binfmt_misc *misc;
-	unsigned long flags;
+	struct file *interp_file __free(fput) = NULL;
 	int retval;
 
-	misc = current_binfmt_misc();
-	if (!READ_ONCE(misc->enabled))
-		return -ENOEXEC;
+	if (!(e->flags & MISC_FMT_OPEN_FILE))
+		return open_exec(interpreter);
 
-	fmt = get_binfmt_handler(misc, bprm);
-	if (!fmt)
-		return -ENOEXEC;
+	interp_file = file_clone_open(e->interp_file);
+	if (IS_ERR(interp_file))
+		return interp_file;
 
-	/* Need to be able to load the file after exec */
-	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
-		return -ENOENT;
+	retval = exe_file_deny_write_access(interp_file);
+	if (retval)
+		return ERR_PTR(retval);
 
-	interpreter = entry_select_interpreter(fmt, bprm);
-	if (IS_ERR(interpreter))
-		return PTR_ERR(interpreter);
+	return no_free_ptr(interp_file);
+}
 
-	flags = entry_invocation_flags(fmt, bprm);
+/**
+ * build_interp_argv - splice the interpreter invocation into the argv
+ * @bprm: binary that is being executed
+ * @interpreter: the interpreter selected for this exec
+ * @flags: invocation flags in effect for this exec
+ *
+ * The interpreter becomes argv[0] and the binary its last argument, with an
+ * optional staged argument in between. The caller's argv[0] is dropped
+ * unless 'P' keeps it.
+ *
+ * Return: 0 on success, a negative error code on failure
+ */
+static int build_interp_argv(struct linux_binprm *bprm, const char *interpreter,
+			     unsigned long flags)
+{
+	int retval;
 
 	/* The entry's own choice - not one accumulated from an earlier level. */
 	if (flags & MISC_FMT_PRESERVE_ARGV0) {
@@ -418,24 +435,49 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		return retval;
 	bprm->argc++;
 
+	return 0;
+}
+
+/*
+ * the loader itself
+ */
+static int load_misc_binary(struct linux_binprm *bprm)
+{
+	struct binfmt_misc_entry *fmt __free(put_binfmt_handler) = NULL;
+	const char *interpreter;
+	struct file *interp_file;
+	struct binfmt_misc *misc;
+	unsigned long flags;
+	int retval;
+
+	misc = current_binfmt_misc();
+	if (!READ_ONCE(misc->enabled))
+		return -ENOEXEC;
+
+	fmt = get_binfmt_handler(misc, bprm);
+	if (!fmt)
+		return -ENOEXEC;
+
+	/* Need to be able to load the file after exec */
+	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
+		return -ENOENT;
+
+	interpreter = entry_select_interpreter(fmt, bprm);
+	if (IS_ERR(interpreter))
+		return PTR_ERR(interpreter);
+
+	flags = entry_invocation_flags(fmt, bprm);
+
+	retval = build_interp_argv(bprm, interpreter, flags);
+	if (retval)
+		return retval;
+
 	/* Update interp in case binfmt_script needs it. */
 	retval = bprm_change_interp(interpreter, bprm);
 	if (retval < 0)
 		return retval;
 
-	if (fmt->flags & MISC_FMT_OPEN_FILE) {
-		interp_file = file_clone_open(fmt->interp_file);
-		if (!IS_ERR(interp_file)) {
-			int err = exe_file_deny_write_access(interp_file);
-
-			if (err) {
-				fput(interp_file);
-				interp_file = ERR_PTR(err);
-			}
-		}
-	} else {
-		interp_file = open_exec(interpreter);
-	}
+	interp_file = entry_open_interpreter(fmt, interpreter);
 	if (IS_ERR(interp_file))
 		return PTR_ERR(interp_file);
 

-- 
2.53.0

