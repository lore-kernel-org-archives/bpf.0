Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0DF38D3E8;
	Tue, 21 Jul 2026 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643272; cv=none; b=og3dyIqWeZ3o0oyjzfd7tvgutc0ctO8/17vQTMeMmLL0Pv5YaM4OOR2ZTunN99t3q46MDrEi29QekvF35ehY+zOjvMPaGewuGRKQMkGEh1MpofoLgCc3MAroD8OAM3RyE6ncGuQyCmWWxytcscQaM02OM5tUueyrEeAp2GZfuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643272; c=relaxed/simple;
	bh=/HZE81y7c4y9rwUi4c213k7Nn2GRcvgIbHRiATHZsXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FtcAgjbkf7T2wR9BqFdget1Sz8MWsD+yJaWmAIkBxA3ZjkIw0sWXPn9nv8G9rucyMDhWZbagSpUtKMU9x2kW/H3pceaZW21qReK2wP4ZxiFVDEwEx/9UIZD5X820tavr+s8ohpGzB70sU4hIhSZC6AAxD8nU/NmB6SlFieLldCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljCGZaoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljCGZaoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313F21F000E9;
	Tue, 21 Jul 2026 14:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643270;
	bh=I3oigTmZnwy5xnugZzpIrg+tDjNJLifyi9eemUipPCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ljCGZaojX/13PbiNPonTLtcNWX0L56IZnorW1+uaUFuVjaIigPKV+mPVjpgKZPDKo
	 jdkOFmi99ojgzx8L/qJWZqCuVz3Q7LlQF4PegLJwnIRixUScDKN9Ko8RL5lxZENK9V
	 A4iJ7eLCUS8Fi7tkWXDK14g1bsoVuZvIM5wIrf+EOeToS4E1mj+kzj9NJF0+TMwbZQ
	 5eJQU5RY1xGNrgsrlTlMBEpXhgAYvT8lctUMK1oySiepelBF3VSYmmi4sGVGTeboGY
	 gCB1j2wxO1cWJVL0KXA0vD5T5GJyMb+ZmzXIm1+TkXHWdhHnxNnL2lgvOse9p2X85V
	 oUhsqO2G1TMjQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:13:43 +0200
Subject: [PATCH v2 01/21] binfmt_misc: require an absolute interpreter path
 with 'C'
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-1-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/HZE81y7c4y9rwUi4c213k7Nn2GRcvgIbHRiATHZsXo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1+3f6/2lk/2pwo03b7kczijqJazfdsBgZugb3nAOP
 huG5dY1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJbmdkONqz8B1vAtf2J1Eb
 n6dke7Ptb9xjbmp0Pv+IRmH2j7fVcYwMew96126X0K9jnK0T9nVNnpELp+lVqW3ZRwNWqji217A
 wAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A 'C' entry computes the credentials from the matched binary instead of
from the interpreter. So a set*id binary hands its credentials to
whatever the entry names as its interpreter.

Without 'F' that interpreter is not opened until the exec happens and
open_exec() resolves the path relative to the current working directory.

The working directory at that point belongs to whoever runs the binary
not to whoever registered the entry. So :x:M::\x7fELF::interp:C lets
every user who execs a matching set*id binary from a directory they
control run their own interp with that binary's credentials.

A relative interpreter has no sensible use here to begin with. The
registering task cannot know what the working directory will be. Make
the register string reject the combination at registration time.

This does refuse register strings that used to be accepted. The 'F' flag
covers the case where the interpreter really is meant to be resolved in
the registrant's context, and it resolves it once, at registration.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 4 ++++
 fs/binfmt_misc.c                          | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 7f42abf9cfba..ce94c8c36534 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -98,6 +98,10 @@ There are some restrictions:
  - the magic must reside in the first 128 bytes of the file, i.e.
    offset+size(magic) has to be less than 128
  - the interpreter string may not exceed 127 characters
+ - an interpreter used with ``C`` but without ``F`` has to be named by an
+   absolute path. It is opened when the binary is executed, so a relative
+   one would be resolved against the working directory of whoever runs
+   the binary
 
 
 bpf-backed handlers
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index c06cea00a6d6..bfe30fe532ba 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -683,6 +683,12 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 			 MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_FILE)))
 		return ERR_PTR(-EINVAL);
 
+	/* Non-F opens the interp at exec against the caller's cwd; require absolute. */
+	if ((e->flags & MISC_FMT_CREDENTIALS) &&
+	    !(e->flags & MISC_FMT_OPEN_FILE) &&
+	    e->interpreter[0] != '/')
+		return ERR_PTR(-EINVAL);
+
 	return no_free_ptr(e);
 }
 

-- 
2.53.0

