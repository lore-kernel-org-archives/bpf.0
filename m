Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D593932E0;
	Tue, 21 Jul 2026 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643280; cv=none; b=Ky0/mhzUUmfDQfzyJQr5ZmlRTWc9Gm/gtn33JTNjqt7UrqygIJIszmjq6cV9qo0rosDBttVLOP4VAwWs7DtCcvKJe2TpqyCmbittljyshm8JC2J60LIVGLh1nHIfbupGkT/AfI1BXh8tAi2m/ipx4U/1EdTQBjJK7nWjPmKvlUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643280; c=relaxed/simple;
	bh=WfRCXhSBfi2LzkKaz/OKGy2fNvqcBkrDAyApc0zJ7VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbB0rd8XSuYx5MvUdzeHmi+gsm/talpXlIsjmPxvsEASA+5vlYUTI8840/+bhG6eEEJXiF/T3mNG5tQY4tD7nwTFjIdwxLY8oWOUlmJeaJvGFgwTUn0v33mtouri0O5jILFC9IjwKQ7hTr4yiyqpXR4vLwbf954mvnhEv+/lSYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a218HhdR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a218HhdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544651F000E9;
	Tue, 21 Jul 2026 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643276;
	bh=Jh0kCK0JumH3aozuqcy0Oaz/v3fXNMaeUd/Qe0rfQyk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a218HhdRCmuYafaPTfLmconv3uRTsvKgdeS9DkKis8JgpYQVAoEqiXLXsmXSz/Cp/
	 2i2wBeroEgVec8kk3ohpJ4sVMmfW4mb+wVgdY+iHevi3QbqPRq/ghjXwkllQvtmCQD
	 uM3v8ZR+XrKG5nfcQB6v0Bo1u5e8Ab9vfz1FsBYdkWSO1F5s98FnayxiLMAoYtk62c
	 L7xqD7eSCuQU/K4d7Li1v92ZWZh/29nI7Xv4nkLnhTQqcP1/7Uk4gVwHvzDkV2p7TY
	 Luq0b5GkzEb4TZlKORdUmTGeDikRN92i0e3pz+Soa2fzrsoYUNlnVVMTtqQBlDMjGa
	 cVEwD7y5IgG8A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:45 +0200
Subject: [PATCH v2 03/21] binfmt_misc: table-drive the register string
 flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-3-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6070; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WfRCXhSBfi2LzkKaz/OKGy2fNvqcBkrDAyApc0zJ7VM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1+2P4XscHZNfsYiX505IkWjKprlzp69ofLXU74ui3
 NtrjSJeHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxSmf4w9F9Kjpuw6Q2x+fb
 +NI7xcqzOEMb7s5I89k9VeeKsINkBcM/hbMdKTX/Sz7uaProOe/F/cWM+t4Ljv3tDP3yO5LFwD2
 TDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Every flag character of the register string is spelled out three
times: in the parser, in the entry's /proc output and in the
delimiter blacklist that keeps a flag character from sending the flag
scan off the end of the buffer. The three lists have to agree, and
each new flag has to be added to all of them.

Describe a flag once - character, entry flag, implied flags and a
description for the registration debug output - and drive all three
from the table.

While at it, express the "a 'B' entry carries no flags" check as what
it is, an empty flags field, rather than as a fourth list of every
flag character. Equivalent: the check runs right after
check_special_flags(), which advances past exactly the flag
characters it consumed and sets exactly their flags.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 92 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 40 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index bfe30fe532ba..c0a3b42a38f7 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/array_size.h>
 #include <linux/binfmt_misc.h>
 #include <linux/binfmts.h>
 #include <linux/bitops.h>
@@ -51,6 +52,36 @@ enum binfmt_misc_entry_flags {
 	MISC_FMT_OPEN_FILE	= (1U << 28),
 };
 
+/**
+ * struct binfmt_misc_flag - a flag character of the register string
+ * @c: the character userspace writes and reads back
+ * @flag: the entry flag it sets
+ * @implies: entry flags it turns on in addition
+ * @desc: what it does, for the registration debug output
+ */
+struct binfmt_misc_flag {
+	char		c;
+	unsigned long	flag;
+	unsigned long	implies;
+	const char	*desc;
+};
+
+static const struct binfmt_misc_flag misc_flags[] = {
+	{ 'P', MISC_FMT_PRESERVE_ARGV0,	0,			"preserve argv0"		},
+	{ 'O', MISC_FMT_OPEN_BINARY,	0,			"open binary"			},
+	{ 'C', MISC_FMT_CREDENTIALS,	MISC_FMT_OPEN_BINARY,	"credentials from the binary"	},
+	{ 'F', MISC_FMT_OPEN_FILE,	0,			"open interpreter file now"	},
+};
+
+/* Look up a flag character, NULL if @c is not one. */
+static const struct binfmt_misc_flag *misc_flag_by_char(const char c)
+{
+	for (int i = 0; i < ARRAY_SIZE(misc_flags); i++)
+		if (misc_flags[i].c == c)
+			return &misc_flags[i];
+	return NULL;
+}
+
 struct binfmt_misc_entry {
 	struct hlist_node node;
 	unsigned long flags;		/* type, status, etc. */
@@ -424,30 +455,16 @@ static char *scanarg(char *s, char del)
 	return s;
 }
 
+/* Parse the 'flags' field, stopping at the first character that is not one. */
 static char *check_special_flags(char *p, struct binfmt_misc_entry *e)
 {
 	for (;; p++) {
-		switch (*p) {
-		case 'P':
-			pr_debug("register: flag: P (preserve argv0)\n");
-			e->flags |= MISC_FMT_PRESERVE_ARGV0;
-			break;
-		case 'O':
-			pr_debug("register: flag: O (open binary)\n");
-			e->flags |= MISC_FMT_OPEN_BINARY;
-			break;
-		case 'C':
-			pr_debug("register: flag: C (preserve creds)\n");
-			/* C implies O */
-			e->flags |= MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY;
-			break;
-		case 'F':
-			pr_debug("register: flag: F: open interpreter file now\n");
-			e->flags |= MISC_FMT_OPEN_FILE;
-			break;
-		default:
+		const struct binfmt_misc_flag *f = misc_flag_by_char(*p);
+
+		if (!f)
 			return p;
-		}
+		pr_debug("register: flag: %c (%s)\n", f->c, f->desc);
+		e->flags |= f->flag | f->implies;
 	}
 }
 
@@ -570,7 +587,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 					      size_t count)
 {
 	struct binfmt_misc_entry *e __free(kfree) = NULL;
-	char *buf, *p;
+	char *buf, *p, *flags;
 	char del;
 
 	pr_debug("register: received %zu bytes\n", count);
@@ -595,7 +612,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	pr_debug("register: delim: %#x {%c}\n", del, del);
 
 	/* A flag-char delimiter runs the flag scan off the buffer. */
-	if (del == 'P' || del == 'O' || del == 'C' || del == 'F')
+	if (misc_flag_by_char(del))
 		return ERR_PTR(-EINVAL);
 
 	/* Pad the buffer with the delim to simplify parsing below. */
@@ -666,21 +683,21 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	}
 
 	/* Parse the 'flags' field. */
+	flags = p;
 	p = check_special_flags(p, e);
-	if (*p == '\n')
-		p++;
-	if (p != buf + count)
-		return ERR_PTR(-EINVAL);
 
 	/*
 	 * A bpf handler decides the invocation flags per exec with
-	 * bpf_binprm_set_flags() rather than fixing them at registration, so a
-	 * 'B' entry carries no flags: 'P', 'C' and 'O' become per-exec choices
-	 * and 'F' (pre-open a fixed interpreter) is meaningless for it.
+	 * bpf_binprm_set_flags() rather than fixing them at registration, and
+	 * 'F' (pre-open a fixed interpreter) is meaningless for it, so a 'B'
+	 * entry's flags field has to be empty.
 	 */
-	if (test_bit(MISC_FMT_BPF_BIT, &e->flags) &&
-	    (e->flags & (MISC_FMT_PRESERVE_ARGV0 | MISC_FMT_OPEN_BINARY |
-			 MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_FILE)))
+	if (test_bit(MISC_FMT_BPF_BIT, &e->flags) && p != flags)
+		return ERR_PTR(-EINVAL);
+
+	if (*p == '\n')
+		p++;
+	if (p != buf + count)
 		return ERR_PTR(-EINVAL);
 
 	/* Non-F opens the interp at exec against the caller's cwd; require absolute. */
@@ -749,14 +766,9 @@ static int bm_entry_show(struct seq_file *m, void *unused)
 
 	/* print the special flags */
 	seq_puts(m, "flags: ");
-	if (e->flags & MISC_FMT_PRESERVE_ARGV0)
-		seq_putc(m, 'P');
-	if (e->flags & MISC_FMT_OPEN_BINARY)
-		seq_putc(m, 'O');
-	if (e->flags & MISC_FMT_CREDENTIALS)
-		seq_putc(m, 'C');
-	if (e->flags & MISC_FMT_OPEN_FILE)
-		seq_putc(m, 'F');
+	for (int i = 0; i < ARRAY_SIZE(misc_flags); i++)
+		if (e->flags & misc_flags[i].flag)
+			seq_putc(m, misc_flags[i].c);
 	seq_putc(m, '\n');
 
 	if (test_bit(MISC_FMT_BPF_BIT, &e->flags)) {

-- 
2.53.0

