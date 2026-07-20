Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A943D9029;
	Mon, 20 Jul 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540059; cv=none; b=MMWsqXAyP1GMI3xMfeB7eLiRMtXhuQ3ZN9XfTY/1x1hxKCwHfD/9+DIpMuy362b2RNNBMKS0XA+br6B1+jaS8zDFWbrmHu9I/yodhsw57bNfHXbjYCAPotl2Ha22EAIizTPOUunvDG9c0dsbZGnbYsoFXgjWrYMA+3xGDAToSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540059; c=relaxed/simple;
	bh=S1I+8XOcJimoOZpkS+sQ4beHcupitoNVrqmvMwX3N3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tc+Tw2saoGuxodsCMX3wv0XUSrV8l1zBCdJIlUxr6p74XMEtayzh8mgHDmDAMWoAMdjVCIu+YXMeGLNnCbSyVHCwVvwebrR+IeameV1sa0p0EYwxMhae9Ymd55OoAjBftHo+IqaLO31DhfHSujaUXc1gI6l9aXg7qJ7P+bPPobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrEyjAsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrEyjAsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964FD1F000E9;
	Mon, 20 Jul 2026 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540058;
	bh=2Vi2Y6eFLaZZncWxhzA85l4SRnVsg67aEdWUPdvtHPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XrEyjAsVS7VocJDQ+FLPK0E0rZI39Dwdh6rT79D3/z1ln1ia/tdKr77fL4myrxBLK
	 QCQWUROnM69/sB3uDoCeGiQBeNiwcdluPoZxRIXSWGiR+0GOAZDFFmyUgf/FYyV3gf
	 HvD5TqOH1bEg3Qa8MwMJAKZhS/4iodK/atJcoHnSbIkA/FHqudeoJ3//DpMSC0XnHr
	 TBogyuFZsbFyB6yg211N9J1s6M1ZF30GQN69+dAoMEkSNKBkA5rRIMJaYX+0P0+fJY
	 Dol6pOpfcns7rO1KOv7uiHGBe5kUL/8ve9TMFRXRVSaFodFHkbn6V6QbsppKnvs5ZU
	 K6NXSdswly/Dg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:29 +0200
Subject: [PATCH 06/21] binfmt_misc: split out build_interp_argv()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-6-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3720; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S1I+8XOcJimoOZpkS+sQ4beHcupitoNVrqmvMwX3N3g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm7SDFilVPxMX2L7s6q2imjtE3NOdu7jMjk6dyIXq
 36+qqxVRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQaahn+uweJ89yx/B2WenzB
 +6tnN3+33VscXOLQM3npGlbhHO+pDQz/E7p5tp5b1nuP8fumJ4t9Sh9/1bkc6+mx/1vc0qXxK85
 nsAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Building the interpreter's argument vector is the bulk of
load_misc_binary() and the one part of it that is specific to the
classic dispatch. Move it into its own helper so what remains reads as
what it is: pick a handler, pick an interpreter, build the invocation,
open it.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 84 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 63c10066e3a6..f0ccc5d000f6 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -382,40 +382,23 @@ static struct file *entry_open_interpreter(const struct binfmt_misc_entry *e,
 	return no_free_ptr(interp_file);
 }
 
-/*
- * the loader itself
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
  */
-static int load_misc_binary(struct linux_binprm *bprm)
+static int build_interp_argv(struct linux_binprm *bprm, const char *interpreter,
+			     unsigned long flags)
 {
-	struct binfmt_misc_entry *fmt __free(put_binfmt_handler) = NULL;
-	const char *interpreter;
-	struct file *interp_file;
-	struct binfmt_misc *misc;
-	unsigned long flags;
 	int retval;
 
-	misc = current_binfmt_misc();
-	if (!READ_ONCE(misc->enabled))
-		return -ENOEXEC;
-
-	fmt = get_binfmt_handler(misc, bprm);
-	if (!fmt)
-		return -ENOEXEC;
-
-	/* Need to be able to load the file after exec */
-	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
-		return -ENOENT;
-
-	interpreter = entry_select_interpreter(fmt, bprm);
-	if (IS_ERR(interpreter))
-		return PTR_ERR(interpreter);
-
-	flags = entry_invocation_flags(fmt, bprm);
-	if (flags & MISC_FMT_CREDENTIALS)
-		bprm->execfd_creds = 1;
-	if (flags & MISC_FMT_OPEN_BINARY)
-		bprm->have_execfd = 1;
-
 	/* The entry's own choice - not one accumulated from an earlier level. */
 	if (flags & MISC_FMT_PRESERVE_ARGV0) {
 		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
@@ -451,6 +434,47 @@ static int load_misc_binary(struct linux_binprm *bprm)
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
+	if (flags & MISC_FMT_CREDENTIALS)
+		bprm->execfd_creds = 1;
+	if (flags & MISC_FMT_OPEN_BINARY)
+		bprm->have_execfd = 1;
+
+	retval = build_interp_argv(bprm, interpreter, flags);
+	if (retval)
+		return retval;
+
 	/* Update interp in case binfmt_script needs it. */
 	retval = bprm_change_interp(interpreter, bprm);
 	if (retval < 0)

-- 
2.53.0

