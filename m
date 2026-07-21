Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A92571DA;
	Tue, 21 Jul 2026 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643303; cv=none; b=NZTawf+rw+8Pi1tBv67QPMdf/wEP1qYw0FeqBqHWzJuFGxDAksixdlHd0IT2Dfi3vHiUSu73dzajveRq7yAuzqq+q9LlEJ3PFQ8lHKscRhcwH6afw/bCo7/VHGpRxjbdUYYRcZeElN0fCgQtTnF9Xi38mdN3/zA7LofDD2yR1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643303; c=relaxed/simple;
	bh=xQkD7EvYlbnkQP6t+SOqQeUbRjqO8LeVxW0pS0icYbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REkBiXN/h5IKzPgY4Zu/PAz+3m727K1d+g5aCV7YM5anla4Qu0QjAMFzdP+462Eqze90GetiGXBakZ128Ut9QWbIsX0rUu2gqmwnKIW8yD1oLhUL5dgXiTwTjl4y9H5sb1hB9FtF+N/FOVnPAqNZcmBplwDA0X1Tqfgg06u9gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItKCh1+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItKCh1+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000D61F00A3A;
	Tue, 21 Jul 2026 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643301;
	bh=1MU+7JSdoi6orVVaIMQYqvBSkSC7CWSYlhT848v7s9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ItKCh1+8+Evtct+V4b8WoIioxv2P0XTOQ2/kg4rULAUBa4qeYBbLarLaxd2LHzvSU
	 GX58rIA3wZsKhdaO+vdKBfe3MiHllojsvwWCxa7nKtvCVIuLvstfrGCTxKF9RHbc6W
	 VQfcAHXBQmddmXWdDQft3P0B89mRgTQvQd1InAQ3zN9ooXth1NI1wrwtvxRnzDlT29
	 Nnme9rbKIdDgC7oiKLIeFL/OiYgGPkMa9pa2Ihk8+lCrIpoTAtjCPlBQhuzjoR0m2K
	 UQjK6F6Vl2AD6dymt+HeZ3z0Wso8+RmI3Y+Z8ypUfqBgjpTK4Vk2uS+VR1GzeFDPZy
	 aespPJbFsaXGQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:53 +0200
Subject: [PATCH v2 11/21] binfmt_misc: add a static transparent flag 'T'
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-11-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xQkD7EvYlbnkQP6t+SOqQeUbRjqO8LeVxW0pS0icYbE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x1oXjz3mW/rxyeufn8k5M52bl9fndzUYWvKw8b8V
 IHxPV9YRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER+P2dkmFwhndPxpZDbbMG0
 3czB2k8SpdVckoKiGm//Nq1/XpOqxfA/NsuydGqDWcDTMJ33Kx9v52SIfqMyZ9mCrOfSPAtvRni
 xAQA=
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
index d689f21858b2..f0a0bdb681fe 100644
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
index e5a17ca935ca..71833b976131 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -72,6 +72,7 @@ static const struct binfmt_misc_flag misc_flags[] = {
 	{ 'O', MISC_FMT_OPEN_BINARY,	0,			"open binary"			},
 	{ 'C', MISC_FMT_CREDENTIALS,	MISC_FMT_OPEN_BINARY,	"credentials from the binary"	},
 	{ 'F', MISC_FMT_OPEN_FILE,	0,			"open interpreter file now"	},
+	{ 'T', MISC_FMT_TRANSPARENT,	MISC_FMT_OPEN_BINARY,	"transparent"			},
 };
 
 /* Look up a flag character, NULL if @c is not one. */
@@ -764,6 +765,11 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
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

