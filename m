Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D32F3D8902;
	Mon, 20 Jul 2026 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540056; cv=none; b=XlItWZIOIflfJXa1rVHR4t/cMfBEzLxeXOPGKsVwnNIUAVunnQCeNqXaSnE8UsXy34ISK3HUlZndGy+8eRQ3tOs3KggdGo/cKBor+Qtf6PDlou+7MpcXX/xtum6CfDWTm11LDtGDM/Xg/1GdwBZ9J8WQqFzYczIZeXpqrLpf5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540056; c=relaxed/simple;
	bh=rTLpfXr1BN78GmzRT93H9qEQR280+PMjndmHO+m2QyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FVWHjcQwVJ53QEiDwS1zgMZ5OqmVcc6hXlnUWD5t4vO0HYBqHhyMRbpIf37adaXtoHY01gJyh+CbVtfu2WXjdq27fYjDirHTd7nIbkJnadFUd7hi79AmxfTuL8LP94vp1tCrR67lDRMHumr3mw//kp1wd55Rnph5467I1TYW1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QA7RLa9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA7RLa9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EEB1F00A3A;
	Mon, 20 Jul 2026 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540055;
	bh=1GDtZ/H9PPREqEQroKi/tSbzImHJ30r90YyvmcEwAQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QA7RLa9QP1SNmuoZc7iunsr2CmLaNtwj8OM+BAV/YHGw6uzfHI5uoU1JjHuEq5TBZ
	 iK1su5CVPaC2a/DtjPRMF4GGRA8uZ4lB4Ib1cRq1bL5OzWJKgwEYKlb/KdOPUsAgRr
	 72xlwvjhTyvTIp29vcN1KmhzA1Ay9a1/76GrPPl9m/mE9tJjKIi/8sphCnHx3X018E
	 jouqZqg+qTV/UIAVIxmls32K6Sw5Pk0WIv2llawmEpAlV1R42326b6+QOrjGv7fcYm
	 R3EqZdfplXTgN5Nf+qZCYeieJHdc2xYpygQcY2d+j5bShKkYGM4ZvEQR8qA1UfiRJH
	 f1+5Pv0aScTIg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:28 +0200
Subject: [PATCH 05/21] binfmt_misc: split out entry_open_interpreter()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-5-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rTLpfXr1BN78GmzRT93H9qEQR280+PMjndmHO+m2QyM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm7yVZj6SXb71wclfLy13s1ffzav2VM3zfPyxL36g
 UXPJMusO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiNJmRYXp4jZHv7AvszMwL
 2o0r7thc+5N5QOmKVsxXrj33sjT3SDD8z0g75T+79Ekgx86ehZlvflcW5+qVME+2FmuKnWRc0P2
 NHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Opening the interpreter is a property of the matched entry: an 'F'
entry hands out a clone of the file it pre-opened at registration
time, any other entry opens the selected path. Give that its own
helper instead of an if/else in the middle of load_misc_binary(), and
let it fail early rather than carrying an ERR_PTR through the
successful branch.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 7a6bbeb8a58c..63c10066e3a6 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -352,6 +352,36 @@ static unsigned long entry_invocation_flags(const struct binfmt_misc_entry *e,
 	return flags;
 }
 
+/**
+ * entry_open_interpreter - open the entry's interpreter for execution
+ * @e: matched binary type handler
+ * @interpreter: the interpreter selected for this exec
+ *
+ * An 'F' entry hands out a clone of the file it pre-opened at registration,
+ * any other entry opens the selected path.
+ *
+ * Return: the opened interpreter on success, an ERR_PTR on failure
+ */
+static struct file *entry_open_interpreter(const struct binfmt_misc_entry *e,
+					   const char *interpreter)
+{
+	struct file *interp_file __free(fput) = NULL;
+	int retval;
+
+	if (!(e->flags & MISC_FMT_OPEN_FILE))
+		return open_exec(interpreter);
+
+	interp_file = file_clone_open(e->interp_file);
+	if (IS_ERR(interp_file))
+		return interp_file;
+
+	retval = exe_file_deny_write_access(interp_file);
+	if (retval)
+		return ERR_PTR(retval);
+
+	return no_free_ptr(interp_file);
+}
+
 /*
  * the loader itself
  */
@@ -426,19 +456,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
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

