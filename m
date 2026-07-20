Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4FB3DB324;
	Mon, 20 Jul 2026 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540108; cv=none; b=pT6NfxTVgzpY3Cm2fXk19LkyqgwbfISGtWRg/CC9ndDNe4XciHRTsf5pTNRRRdYtGrIrB3SgP25/iO9L7AfbhMA0ycFKGuVP0vWXyPdLhIIG38aZiq3GYXHof2aaYQ73tdV2s73yl0Grypn3Sb4xAlFYFCKAL4bzR8XAvHxsxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540108; c=relaxed/simple;
	bh=0j319FPLkEeRXmctLHltffws9S9bb83D0lCdaC6N404=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQ/URfpmEvmmCb5GNTFP0nwIXEqFIKox00NvuzJr9CPggDmNHPSj3S2HASV86DVjGdWtcZK669SdwrYE83vAIG7eKZYJ+opLpWWKZJ9JaFqzyGrKpoHqcCBqEJ8Hg0pF3FdYSyoo0GJ+aC3y7zKaNX9/+RkjTPWMFTjMazTQNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE5DXy4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE5DXy4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3509A1F000E9;
	Mon, 20 Jul 2026 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540107;
	bh=B6JaCQcV8O+LfMG8OzzqYe5U+TWtCj2Zt7kHSq9d4Fw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CE5DXy4kPwdEQyYig4MniIz4zKm3a95jCEgF/pbnav0bNwpAoZoL7202DiwyHA3GK
	 Y5J07MvnCijLc3v9yrxtpvcqt6k8nyHtxH62ZzcEpZlNG6sMPcVwpL85VyO+Pp9/fe
	 UsYy5bbGfeq5KL7IBNYrO1BWwWKXZMhphZo8Fh3/SdQo7uBTK3V+wYpJDUKIWdLdtf
	 USp6s14f6bVx2En1DaT6tsKmhB/R1hTYhrgHYdvur9auQFBO4NhPXu7L5bkjReWVR2
	 3p2R6wmlxMdlmsK1bjZZ6cPsduVEQMlWjxyI6sxqROdVhYQDtoEp5XnRdKDTrXI8hI
	 NED8/pNMIt+Yw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Jul 2026 11:33:44 +0200
Subject: [PATCH 21/21] binfmt_misc: document loader substitution
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-work-bpf-binfmt_misc-ptinterp-v1-21-ddb76c9a508e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3659; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0j319FPLkEeRXmctLHltffws9S9bb83D0lCdaC6N404=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTFvm42NDdgDVKvt+Y5aFrkKnDmclOYb3Lyq0un1a5eS
 63TTNbsKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMjDrYwM72cvrFp77PQ3L9e/
 7G/+dMVN2tK93EP7xyEbRlljqxVXvjMyTEjcyDr3YdtR29kazf0bFFxeO/wUmfxUfNfKq9P28Xx
 g4AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Describe the L mode next to the transparent one.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/admin-guide/binfmt-misc.rst | 50 +++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
index 8c861bf0c56c..b468a148cdab 100644
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
@@ -246,6 +253,49 @@ execution is the address space layout. The interpreter occupies the main-image
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
+interpreter-less ``ET_DYN`` drops the override and runs natively. A
+file claimed by another format is handled by that format as if the entry
+had not matched. A format that cannot consume the override at
+all instead refuses the exec with ``ENOEXEC`` before the point of no
+return, so the substitution is never silently ignored where it would
+have applied.
+
+A wrong-architecture ELF fails the whole exec with ``ENOEXEC`` exactly
+as if no entry had matched. A substitute that is not ELF of the right
+architecture fails with ``ELIBBAD``. The usual ``PT_INTERP`` sanity
+checks on the binary still apply. But the segment's content is otherwise
+irrelevant.
+
+``L`` rejects the classic-dispatch flags ``T``, ``P``, ``O`` and ``C``
+at registration. ``F`` composes and is valuable. The substitute is
+opened at registration time, so later mount namespace or path changes
+cannot redirect it. As with ``C``, register only trusted interpreters.
+The substituted loader runs with credentials derived from the binary.
+
+
 Hints
 -----
 

-- 
2.53.0

