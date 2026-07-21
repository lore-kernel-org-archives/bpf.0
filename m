Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F538BF7A;
	Tue, 21 Jul 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643334; cv=none; b=S7i2ZeW/NiAsLndKVYGr43+Fy6jKlozEbWl/KQz0FJwG4Arh2ttxrZDviBTmTo+v4brsOGBJ970LjgtNkQ8ZFrJF1WWsB/Ki3wUM2wP7q/KErnugZJWxPAiKk3wVhGZ9rKwKURFNPt+fOeF2PZOW4TrSOFomujsyOUgFQb8RakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643334; c=relaxed/simple;
	bh=MUQuvaLG7BH+qnaycY+AeYK2F8Ox0JjhVijX9+ERWfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pMRY8kbrgXPqUsh2jum5W/jhTlP3CwlmyCRwXnIJ8yr05aG6VzDzCveAnJ2uR5K/uBBoxQKTFQaE1VDDHk3203dR2jRdsd4dZB6/BA8rV7YW+b8yrtsxK8vjCPpmb73tgWaCshMI1l2Scqcvs6ncQaSSe/mXIE9bbom3sfFVA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVBXLImp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVBXLImp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC591F00A3D;
	Tue, 21 Jul 2026 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643332;
	bh=kYvTUrZeqIK8jpOS7Fwg87PFtSxCz14nJrDSnK4sqE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nVBXLImp5THS6thpR8kxTS7DzmxPTw/3QpkvETQee2p6My9H8nx+oU/IG5DMgfVVj
	 MdFBJRhGM+52qsGFUd62IvvG2b489BldqWFZ2oZnLixO+asMXeUOS2TvVTr4jWsVg4
	 lH1SN0ZSx0SW5oOwn7aCGGhP455kHm1n+axv9bVLGcU7bW7lpScmyM3q3ZLXPAUfEz
	 9n0g7zfs7x5NyM4veZHMHTDMAA/WlAoVG0cA0yuG7POVFnT0EMYgzW8aW5JMRAxam6
	 6g1txzt0mrTxocTA2QE2kK858P9MT2L5d5cVQbMcCOhGck8QZZI11RXZLOyMoWyd1W
	 vu74pOJ1qJe9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Jul 2026 16:14:03 +0200
Subject: [PATCH v2 21/21] binfmt_misc: document loader substitution
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-work-bpf-binfmt_misc-ptinterp-v2-21-e57866e4ae0f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MUQuvaLG7BH+qnaycY+AeYK2F8Ox0JjhVijX9+ERWfc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTF1x3gCfn+xfClO+MK6XeTPx78Inj/306xnAsdd6u+f
 d6uvel6d0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEEnQZGf55OE7t1WPSWn7i
 8UTGTXsv3RaTbAzp7tnnxNfQ+3l3+DNGhhdVnDWyrhsfB3c+TDoYd3FH5mf5dyp8bzs+s62d6VT
 wgh0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Describe the L mode next to the transparent one.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 47 +++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 72b389d61f6f..d49809e62a52 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -263,6 +263,53 @@ execution is the address space layout. The interpreter occupies the main-image
 position and the program lives in the mmap region.
 
 
+Loader substitution
+-------------------
+
+The ``L`` flag turns the execution model around. Instead of running the
+registered interpreter with the binary as its payload the kernel loads
+the matched binary itself as the main image and substitutes the registered
+interpreter for the loader named in the binary's ``PT_INTERP``.
+
+Because the exec is native, there is no dispatch identity to
+reconstruct and no contract the substitute has to implement. A stock
+dynamic loader works unchanged. The argument vector is untouched,
+credentials and ``AT_SECURE`` derive from the binary, there is no
+``AT_EXECFD`` and no marker in the aux vector, the binary sits in the
+main-image slot with the native brk placement so ``/proc/pid/maps``,
+core dumps and perf mmap records have the native shape, and the
+identity is already complete when ``PTRACE_EVENT_EXEC`` stops the
+tracee. So launching under a debugger works, not just attaching. ``L``
+entries are for ELF binaries of a native architecture. Foreign-arch
+emulation and non-ELF payloads remain the domain of the classic and
+transparent modes.
+
+The override applies when the format that finally claims the file is
+ELF with a ``PT_INTERP``. A matched binary without one or an
+interpreter-less ``ET_DYN`` drops the override and runs natively. A file
+claimed by another format - a ``#!`` script, say - is handled by that
+format as if the entry had not matched. ``L`` is therefore not an
+enforcement mechanism: it decides how a binary that asks for a loader is
+run, it does not guarantee that everything matching the entry runs under
+the substitute. A format that cannot consume the override at all instead
+refuses the exec with ``ENOEXEC`` before the point of no return.
+
+A wrong-architecture ELF fails the whole exec with ``ENOEXEC`` exactly
+as if no entry had matched. A substitute that is not ELF of the right
+architecture fails with ``ELIBBAD``. The usual ``PT_INTERP`` sanity
+checks on the binary still apply. But the segment's content is otherwise
+irrelevant.
+
+``L`` rejects the classic-dispatch flags ``T``, ``P``, ``O`` and ``C``
+at registration. ``F`` composes and is valuable: with it the substitute
+is opened at registration time, so later mount namespace or path changes
+cannot redirect it. Without it the substitute is opened when the binary
+is executed, and the path is resolved in the mount namespace and root of
+whoever runs the binary, which is why it has to be absolute. As with
+``C``, register only trusted interpreters. The substituted loader runs
+with credentials derived from the binary.
+
+
 Hints
 -----
 

-- 
2.53.0

