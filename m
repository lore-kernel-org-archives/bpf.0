Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C63D75A8;
	Mon, 20 Jul 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540076; cv=none; b=b9cVwINKSOENbZVmVjffZHvL1softsUbkDRhYHAb8E/vnwV8K+JAbgkmsdnXXodvmwPAlBkF+sx1bVGPSkgKSNn1DIfZJRMD//LZVbnl5fuKTRLVnqqcGCGvKMb4MsvBfskCbIGoC0DIkV/F9GRzm2wq9pi9pXDgSb+saYlEtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540076; c=relaxed/simple;
	bh=BTEGIWQaX9jff031zmDSWPlSXTNAsmK1AWo7J/WcJjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FR1IA3k11b71RhrKDc4vIRPfnNuQZAhjbhc12E7PEFzed/U2UvBQ3kplatQ36FJyN8qBAq2dzXwdaVDYPg7L2msR/9lms83m8OySBkDXyDOBN+EHiSKFClBxQKWw1Mw6zwxwESbsIqxXvYts0dgxv2ZltlyUKRPddFkHMjWKgg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fym/3b1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fym/3b1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC1D1F00A3A;
	Mon, 20 Jul 2026 09:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540074;
	bh=EGDTcSWwY/u2lTvfjlboAKTY2F0iAMegCLfkIgM9cL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fym/3b1lyAPxhRO9XNhLDfEeiEo6uRvLVxDDYcaM0+n++IiM2/TipR8kWYHKhY3B3
	 oN/Q09k7MgfDzEodITObqAGGWZxuswBHcrqMpsI3F+/MsJLG0rKiXoqEwlrMrkUeUi
	 WguHPmJ6XbwuD5HNHDieQBA1avQRPXYVO+cdy36BmWH6LCZ9Q8hPSRX3BpmWrJ4LAT
	 HXkQ5sF71PxyOgCg2JteAgvFhW6YuChz18jdCcsD1erpdHelR19kwsY/9vsCIO7PfR
	 JgHxodO854f8e7Niged5iEBtnH7lXE0+qT5VSneBrK6yTA9r3AAEFURzUOjBody1R9
	 /3B47xtAz8F+w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:34 +0200
Subject: [PATCH 11/21] binfmt_misc: add a static transparent flag 'T'
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-11-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BTEGIWQaX9jff031zmDSWPlSXTNAsmK1AWo7J/WcJjk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm76c3X1C5uHurNeH9TbufzoyRl8OjyHOrVVeOpy3
 Y/b7bPm6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI/3KGf6rWJxmO6PHNNu91
 0l++YJn9tY2WS7zUbR7e38X0uX5tcycjw3S1adJqX46sEDNef07Z7srjh+uE0vTUGgrfO/5/tW/
 7fG4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Let a registration opt into transparent dispatch. The 'T' flag lets a
matched binary keep its argument vector and is sent to the interpreter
through AT_EXECFD. The process's identity is the binary's.

'T' implies 'O' exactly like 'C' does. 'P' is rejected in combination
with it. Transparency preserves the whole argument vector so there is
nothing left for 'P' to say. 'C' remains an independent choice and 'F'
keeps working. A pre-opened interpreter is orthogonal to how the binary
is handed over.

Like the other flag characters 'T' cannot be used as the field
delimiter. The flag scan would run off the registration buffer.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 10 ++++++++++
 fs/binfmt_misc.c                          |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index c76381a4bcad..c370c72c7dbe 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -90,6 +90,16 @@ Here is what the fields mean:
 	    emulation is installed and uses the opened image to spawn the
 	    emulator, meaning it is always available once installed,
 	    regardless of how the environment changes.
+      ``T`` - transparent
+            Run the interpreter transparently. The binary is handed to
+            the interpreter through ``AT_EXECFD`` (``T`` implies ``O``),
+            the argument vector is left exactly as the caller built it
+            and the kernel labels ``/proc/pid/exe`` with the binary
+            instead of the interpreter. The interpreter has to load the
+            binary from ``AT_EXECFD`` and follow the
+            ``AT_FLAGS_TRANSPARENT_INTERP`` contract. Combining ``T``
+            with ``P`` is rejected: transparency preserves the whole
+            argument vector, argv[0] included.
 
 
 There are some restrictions:
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 239cca389e0e..ed5ffb330749 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -72,6 +72,7 @@ static const struct binfmt_misc_flag misc_flags[] = {
 	{ 'O', MISC_FMT_OPEN_BINARY,	0,			"open binary"			},
 	{ 'C', MISC_FMT_CREDENTIALS,	MISC_FMT_OPEN_BINARY,	"credentials from the binary"	},
 	{ 'F', MISC_FMT_OPEN_FILE,	0,			"open interpreter file now"	},
+	{ 'T', MISC_FMT_TRANSPARENT,	MISC_FMT_OPEN_BINARY,	"transparent"			},
 };
 
 /* Look up a flag character, NULL if @c is not one. */
@@ -763,6 +764,11 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	if (test_bit(MISC_FMT_BPF_BIT, &e->flags) && p != flags)
 		return ERR_PTR(-EINVAL);
 
+	/* Transparency preserves the whole argv, argv[0] included. */
+	if ((e->flags & MISC_FMT_TRANSPARENT) &&
+	    (e->flags & MISC_FMT_PRESERVE_ARGV0))
+		return ERR_PTR(-EINVAL);
+
 	if (*p == '\n')
 		p++;
 	if (p != buf + count)

-- 
2.53.0

