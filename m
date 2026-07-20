Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A3A3D7A0F;
	Mon, 20 Jul 2026 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540050; cv=none; b=XkfPKUfM1Fm5ykDGWIqOrSfcT5zsA20bdSQFF74gpQYEoKlNt60reLyKDnO7VQFLJuj3upP00PwUykI2c3Q20UQYJyoD7vRJPH50G4Xsy1zB8OUIjWyTOVGKnDECcEZ3CvxNbSq3UUMv6OyoSmXbJ/z6o57eg2oXGMGFmisjqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540050; c=relaxed/simple;
	bh=r9+zVZZXPXLbK/80ip4dEc0nKwHr02jbr/6VIF1VMGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IncX3PTMnoXUrQZGq9mrZADd3CPKqZYcwG2FLOEiGrokm9ewL5GwiuVdUYIGGghDdOrdbARmh8rNRJQWaSu1hW88gobE+05eVR6KDtVYi0DFoWhIXzgA/FjV62IFZanhAl1uCbN3YgJDA2xO2i90dLWBWO9lkp0JQcukdYhjgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHVrmoyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHVrmoyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BE61F00A3A;
	Mon, 20 Jul 2026 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540048;
	bh=lFBaQnb/LBlrKb7K7tX5A2RAZo96JQCMyZ4CUU0AmMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oHVrmoyP44Wp4dlQhYjgpP+dQ6qRvB04VzA+3+aTIIxED/50lEuCDss0uCKmtjIev
	 Uocmj6D87RhEteKLWL2MXH8YJxgZ4fDVLgYpfq70LzZxve0+Utz/Cs3Q4onz3BGDL/
	 EfMdI3ixgKdT0hBY2Oc+zd2YqYbIv6WJPLQaPiRTSYYa3rd68yQrag6UDCNWKH8ZVz
	 mSDeDe6nlXzlFKTS7BgydAp1ExXnXBjzcXFLbPIvA0KGO2Q1Xm/50EHyYvBOvfumae
	 oZ5q6uwRI2o5NQ1IeYdx+R6/qGikBLwdRd2JueuihYGVRVnClVNQYqMWadZ2D1exTP
	 a1LO1jUYPYi1g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:26 +0200
Subject: [PATCH 03/21] binfmt_misc: table-drive the register string flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-3-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6012; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r9+zVZZXPXLbK/80ip4dEc0nKwHr02jbr/6VIF1VMGI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm5K79I/GvdVXE1YVv9xKsPXLwxLZ4oqbz36exNnQ
 Myq/49vdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzky1pGhu4lN+LsxBPDD1vE
 zf12UGX5v6pz8/8/XnYq4vWCQ83C+hMZGY5y5l9OnbrLtDHP73j4qzObJ8QvOFW4rKnB9skLu6c
 KurwA
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
index a3175521c8dd..521ddda929a4 100644
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
@@ -423,30 +454,16 @@ static char *scanarg(char *s, char del)
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
 
@@ -569,7 +586,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 					      size_t count)
 {
 	struct binfmt_misc_entry *e __free(kfree) = NULL;
-	char *buf, *p;
+	char *buf, *p, *flags;
 	char del;
 
 	pr_debug("register: received %zu bytes\n", count);
@@ -594,7 +611,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	pr_debug("register: delim: %#x {%c}\n", del, del);
 
 	/* A flag-char delimiter runs the flag scan off the buffer. */
-	if (del == 'P' || del == 'O' || del == 'C' || del == 'F')
+	if (misc_flag_by_char(del))
 		return ERR_PTR(-EINVAL);
 
 	/* Pad the buffer with the delim to simplify parsing below. */
@@ -665,21 +682,21 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
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
 
 	return no_free_ptr(e);
@@ -742,14 +759,9 @@ static int bm_entry_show(struct seq_file *m, void *unused)
 
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

