Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D94395ADB;
	Tue, 21 Jul 2026 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643324; cv=none; b=tm18O+nLq7cAKEjVny5UOH46Vi9z8LExWbLinOoDXFxdq4DayWz/DQR1YmJFGqbj2LJ+s7Xi+Efr5pBIy9FiZJ2Rn+zsnfyB5297zL5QSe1O2WjnC+9geHPJKVaElqMzTuwSNo+7bcBQ1oY4OhJWKeZQNjrK2PChCo5m6tIAb7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643324; c=relaxed/simple;
	bh=wdkZgOe/8vQSPskeqBA3ngJtdEFYbMDm4FoSAnRSB8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNxuPnrDLTOrlGUJT0Hi/i5qRQ7ExDArJHmZb+XzWqEQTTJvgFdY6vGZPUJC+2Zq4fLcCEM5gOxTWun533DzSO33ZIfeQIdiKSKCLkbg0tHqLw96NKH3ANnw6zHb1iY3xlUe6Oigx7kaHDjtRZo/YK468a6NFe6Giu646jJcdIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzm0LzOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzm0LzOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA001F000E9;
	Tue, 21 Jul 2026 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643323;
	bh=woNR9nUmR4fnrmuwxeA19vlJY8p3K9kHmFu6j7jog6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Bzm0LzOmuw3ZP/Yn70Vbui30ezGB96gmFNfjQZFYm8Io/qZifqjqI6dHKJO8RAelv
	 dSQtV89iB/jOsR0D4e16JviawBR1BG7oZEkLIlbO+0zk5b73dvf15MgKTxpcOjmjxn
	 FHkXkeSbhZ+Qak8FkPF4YPzGT1pK8CPxgXv4vclawkkn1wmR91CYrylDIDnLYZ7qLy
	 EDj0CovKoPV2ol4lgaR4zHyDMGSGcUhOJkWSkkn2d0ZeEd1VFY4wcx8CXQIw8JcLqi
	 0CkdL0bs/ppIP2dinLwlTb4AZu/O5kWN8/vvsrR9VeY/6FGcH2C6UDfU7Ws+v4LEkf
	 KFVxvOe2Ntrcw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:14:00 +0200
Subject: [PATCH v2 18/21] binfmt_misc: add the 'L' loader substitution flag
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-18-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6343; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wdkZgOe/8vQSPskeqBA3ngJtdEFYbMDm4FoSAnRSB8A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x14+mPlT6NLC2astjKa7691K7LIR/71FIE9lnbu3
 JbODRsOdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE5jzDX9lY5qaOo8V6d+pe
 /Xb4xvJ69Y4Y5aw65cnnze+e4fuaac7wz6i8Q8/zAidr5M20PxeuRm09Fee/+IjC9okq8rbq3y/
 +4wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add the first activation of the PT_INTERP substitution machinery. A
static entry registered with the new 'L' flag no longer runs the
registered interpreter with the binary as payload. It stashes the
interpreter as bprm->loader and declines the match with -ENOEXEC. The
format search continues in the same round. binfmt_elf claims the binary
as a fully native exec and substitutes the stashed file for the binary's
PT_INTERP.

'L' rejects every classic-dispatch flag at registration. 'T', 'P' and
'O' have nothing to act on (no argv splice, no execfd) and 'C' is
subsumed (credentials derive from the binary natively). 'F' composes and
is valuable: with it the substitute is pre-opened at registration time
and immune to mount namespace changes. Without it the substitute is
opened at exec time in the exec'ing task's context, so 'L' joins 'C' in
the requirement that the interpreter be named by an absolute path. As
with 'C', only trusted interpreters should be registered. The
substituted loader runs with credentials derived from the binary.

Like the other flag characters 'L' cannot be used as the field
delimiter. The flag scan would run off the registration buffer.

The interpreter open is shared with the classic path via the
entry_open_interpreter() helper. An open error fails the exec. Map
-ENOEXEC to -EACCES to avoid letting the binary run with its own
PT_INTERP.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 15 ++++++++++----
 fs/binfmt_misc.c                          | 33 +++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index ea1c1c0676c8..a9f685077925 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -100,6 +100,13 @@ Here is what the fields mean:
             ``AT_FLAGS_TRANSPARENT_INTERP`` contract. Combining ``T``
             with ``P`` is rejected: transparency preserves the whole
             argument vector, argv[0] included.
+      ``L`` - loader substitution
+            Do not run the interpreter on the binary at all: load the
+            binary itself as a fully native exec and substitute the
+            interpreter for the loader named in the binary's
+            ``PT_INTERP``. See the "Loader substitution" section
+            below. ``L`` rejects ``T``, ``P``, ``O`` and ``C``;
+            ``F`` composes.
 
 
 There are some restrictions:
@@ -108,10 +115,10 @@ There are some restrictions:
  - the magic must reside in the first 128 bytes of the file, i.e.
    offset+size(magic) has to be less than 128
  - the interpreter string may not exceed 127 characters
- - an interpreter used with ``C`` but without ``F`` has to be named by an
-   absolute path. It is opened when the binary is executed, so a relative
-   one would be resolved against the working directory of whoever runs
-   the binary
+ - an interpreter used with ``C`` or ``L`` but without ``F`` has to be
+   named by an absolute path. It is opened when the binary is executed, so
+   a relative one would be resolved against the working directory of
+   whoever runs the binary
 
 
 To use binfmt_misc you have to mount it first. You can mount it with
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 622c62ee6683..a60e69e4514f 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -51,6 +51,7 @@ enum binfmt_misc_entry_flags {
 	MISC_FMT_CREDENTIALS	= (1U << 29),
 	MISC_FMT_OPEN_FILE	= (1U << 28),
 	MISC_FMT_TRANSPARENT	= (1U << 27),
+	MISC_FMT_LOADER		= (1U << 26),
 };
 
 /**
@@ -73,6 +74,7 @@ static const struct binfmt_misc_flag misc_flags[] = {
 	{ 'C', MISC_FMT_CREDENTIALS,	MISC_FMT_OPEN_BINARY,	"credentials from the binary"	},
 	{ 'F', MISC_FMT_OPEN_FILE,	0,			"open interpreter file now"	},
 	{ 'T', MISC_FMT_TRANSPARENT,	MISC_FMT_OPEN_BINARY,	"transparent"			},
+	{ 'L', MISC_FMT_LOADER,		0,			"loader substitution"		},
 };
 
 /* Look up a flag character, NULL if @c is not one. */
@@ -458,6 +460,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	unsigned long flags;
 	int retval;
 
+	/* Only binfmt_misc stages one and exec_binprm() clears it per round. */
+	WARN_ON_ONCE(bprm->loader);
+
 	misc = current_binfmt_misc();
 	if (!READ_ONCE(misc->enabled))
 		return -ENOEXEC;
@@ -473,9 +478,27 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	flags = entry_invocation_flags(fmt, bprm);
 
 	/* No argv is built for a staged argument to land in. */
-	if ((flags & MISC_FMT_TRANSPARENT) && bprm->bpf_interp_arg)
+	if ((flags & (MISC_FMT_LOADER | MISC_FMT_TRANSPARENT)) &&
+	    bprm->bpf_interp_arg)
 		return -EINVAL;
 
+	/*
+	 * Stash the interpreter for binfmt_elf to consume in place of the
+	 * binary's PT_INTERP and decline the match, so the search continues
+	 * to the real format in the same round.
+	 */
+	if (flags & MISC_FMT_LOADER) {
+		interp_file = entry_open_interpreter(fmt, interpreter);
+		if (IS_ERR(interp_file)) {
+			retval = PTR_ERR(interp_file);
+			/* Declining here would run the binary's own PT_INTERP. */
+			return retval == -ENOEXEC ? -EACCES : retval;
+		}
+
+		bprm->loader = interp_file;
+		return -ENOEXEC;
+	}
+
 	if (!(flags & MISC_FMT_TRANSPARENT)) {
 		retval = build_interp_argv(bprm, interpreter, flags);
 		if (retval)
@@ -772,13 +795,19 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	    (e->flags & MISC_FMT_PRESERVE_ARGV0))
 		return ERR_PTR(-EINVAL);
 
+	/* A native exec splices no argv, passes no execfd and needs no creds. */
+	if ((e->flags & MISC_FMT_LOADER) &&
+	    (e->flags & (MISC_FMT_TRANSPARENT | MISC_FMT_PRESERVE_ARGV0 |
+			 MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY)))
+		return ERR_PTR(-EINVAL);
+
 	if (*p == '\n')
 		p++;
 	if (p != buf + count)
 		return ERR_PTR(-EINVAL);
 
 	/* Non-F opens the interp at exec against the caller's cwd; require absolute. */
-	if ((e->flags & MISC_FMT_CREDENTIALS) &&
+	if ((e->flags & (MISC_FMT_LOADER | MISC_FMT_CREDENTIALS)) &&
 	    !(e->flags & MISC_FMT_OPEN_FILE) &&
 	    e->interpreter[0] != '/')
 		return ERR_PTR(-EINVAL);

-- 
2.53.0

