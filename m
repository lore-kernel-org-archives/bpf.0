Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793623455;
	b=DDiV6Ir8L/VYe0TGFEy44+jxxZfaJpWy9VoOSrPDvogpfQ8+rXtm6nBPYaHshyAi9J2T
	 Vuy0vmeGVgMthsmYDck1e/HICJlkZVnBgR4WgeMe8dQDsuXqibs1n0KoC/YJT2EwDYBAH
	 ObvJi7NexVAW2nvX2YKMwH84Q9pQ8fJPy119kEMC2Gg74/FSqhJyDGBV7HbtpVjBlzzNo
	 Upr9SFHXTGosvjcCfzgP4ycNyjW+6BQxDf3bQj5ibmhzHIWOfuV0sX5KEynwnPvNxk7B4
	 oTAdLB34QRflsnwj5xnFXxBAf7t6gy5y6kbZigjHvXobCs3crbdOJvW+eQTfKODsA7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623455;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=NGGMAMhFrzKmynmWR15heKv/jXN7yXxWkpWk0IctRQk=;
	b=jil3dbA72tnv4ZacggElmq/dd1YX0uJLuy3pgHSIOiuvKciXs9szbW04ebepsTlnfxkN
	 sOPe4AEH3OBYM+z0JTSBczecmvCAWY0F1xIdYVDrX1mDjeSuBUmw7vWD4/mHVuYaKq1JC
	 TTGm8yu0tj5QfM9vb9GkNBcIwCa4eJ45NhxfnyAGWBMWdoEdE7pkfNp3mYXA+BKg7TekD
	 24fStRoGVCVZB2wTmgx9tz/DyxlOgHP/UPLwoZ7CPqvrL0xYBJqDbdhE5IHX/GHCZGC1s
	 DJIiNDtUe4YYJbTmb0q1LH30FPW8T45bdab22KrZxoftqqvo3apyd8FgA2wbKJ8aKuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaP3jgKf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8F60A2607;
	Mon,  2 Nov 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaP3jgKf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793623454;
	b=abA5Nl+cX/3BsH9/o3z7d6Dw+OHqPcbRSSJ9mK/m80D4D+yeScszjUa6rC69/H9/Tkte
	 KKMFHYSMdac4LhmA6SgjWzvJ2hvOT/Fzw+Q/rUTZY7eVzxAd88QyxYnlKh22RxfsMJJxG
	 PeOq6RW+4P/Z+ufvhc4MxKHM0gDtP+lZ93ov+iRvQLic9F8fgM8DWgDYuAIdiVr8ygdQJ
	 HgJeV7J8Tkh84dcX+SwyYvlw8DjGZUB58BimySJIJ+GrGFF/hbs9/3dXAZGYjpnH/mYR+
	 e3wN7zKn9/LSp6e0aEUhbgHqcJ3ZLNnNxIX0umkyHUDRKORdi1vTNltC9Mc2jSMB5uA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793623454;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=NGGMAMhFrzKmynmWR15heKv/jXN7yXxWkpWk0IctRQk=;
	b=nB15c2GfPUOb8bJJ1b5h1wOcC6d4Ch6PKCaIX9xwR0KSDNzCjNrVWDpkFcRiigAAGaWB
	 H4u2pfm6mZ4t88CzJJTZODmKMQ9oYYkMRTzVbna3Jp+KaWA94CXc7Ae+1HCjFE/rUmJU6
	 KMD1e6UmlWgXdZMH0TKjKhhvFYFTMTU+pWtbVW+0mN+Km+mwJqST/TElz4qN9jBaoaLOs
	 pjr715oiV42S6/vvNL+oqRJiFbTXr78K3SXXolgTCoFfO18UWpQ40rcxAYOI3+ImLNLcQ
	 lcamGXT8uFQuL59Fl+pMLqgD3lEDwcW+Ge6RqtYt7CBGx1XmozP3THyDV2YMnadA3BA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 37B6D1F00A16;
	Mon,  2 Nov 2026 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623454;
	bh=NGGMAMhFrzKmynmWR15heKv/jXN7yXxWkpWk0IctRQk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=AaP3jgKf+YUr8MpLjY0dYT3FQDt/31c9LpPO/RCkjfDMYlFNLoR9Fh04gxPOkkv7I
	 /5I23qCu4xV5jpPOc/PITqVq5rfQPG24zzm1+Shr+OMOf/Wt/zod8qsXJkbV49Mb8d
	 ITwszn0Y6aEjyEPeOkec1REvrh4IEtEmpXoVulyMthIPEQ8FQPH+gUQ63ifOcZcsCn
	 mdFjctVOq5yjXwFiGwZpD8VzIUxLDyzyXsfvfT4uAkzlntQLWW8vtqrpKY9ipvv3t0
	 nTz0Kkb81+kf9evHzPbqSIpAXJoQ95AN6nUn0YV4p+RWGaFKDsKwjNNvFPFhC6XQIi
	 t4FcUBQc5TlRw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8CA46464DD;
	Mon,  2 Nov 2026 12:44:12 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Subject: [PATCH bpf-next v4 0/2] bpftool: Make the LLVM disassembler an
 optional runtime dependency
Date: Mon, 02 Nov 2026 17:44:10 +0500
Message-Id: <20261102-bpftool-plugin-v4-0-5a853e973db9@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6CMBAF4KuQrh0z/RGoK+9hXLSlQBOgBLDBE
 O5u04UxGl2+vPnebGS2k7MzOWcbmWxws/NDDOKQEdOqobHgqpgJQ5Zjjhz0WC/edzB298YNYKQ
 U2nCLueAkonGytVvT4JXEWxjsupBbbFo3L356pE+Bpv7XaKBAIS8NKiNpfVL80vTKdUfj+zQV2
 ItTZPKLM0CgShSacUk16k/O/3MeeVmoupCyUgLVO9/3/QmVAESRNAEAAA==
X-Change-ID: 20260603-bpftool-plugin-c994bc3e0643
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Korenberg <socketpair@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793623450; l=3058;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=s1BbFMwahYj2EEmbxI8ooWySbm8Sdb/tUQr9mxtP7uY=;
 b=r9H0AK2by86Kthvuqg88ineEV295m+sPSFKixzmZg8wXsojAwENyTtUt1ZTcbRZiRf6j03FZJ
 SbaWivmTQbeC96PvwLJQCz7cUFjb4bHPoTuUNqSyTyq8zT68ipaJrPT
X-Developer-Key: i=socketpair@gmail.com; a=ed25519;
 pk=2iAMjWhs7kA9X8ccetT2YVX8dvniXua2okQogw3Don8=
X-Endpoint-Received: by B4 Relay for socketpair@gmail.com/20260603 with
 auth_id=806
X-Original-From: Mark Korenberg <socketpair@gmail.com>
Reply-To: socketpair@gmail.com

libLLVM (~140 MiB on Fedora) is a hard dependency of bpftool, although it
is only used by "bpftool prog dump jited". With this series, bpftool is
no longer linked with libLLVM.so but loads it with dlopen() when it needs
to disassemble JITed programs, so that distributions can make it optional.
Patch 1 fixes a leak found on the way.

Changes in v4:
- Drop the plugin, load libLLVM.so with dlopen() instead, as suggested by
  Alexei. This also makes "prog dump jited" work with the bpftool built by
  selftests.
- Keep "llvm" in "bpftool version" a build time feature (Alexei)
- Unlike the suggested diff, still link with LLVM built with
  BUILD_SHARED_LIBS=ON, rather than failing to build
- Link to v3: https://lore.kernel.org/r/20261029-bpftool-plugin-v3-0-87af799da40a@gmail.com

Changes in v3:
- Look for the plugin next to the bpftool binary before its install
  directory, so that bpftool run from its build directory does not pick
  an older installed plugin (Sashiko)
- Link to v2: https://lore.kernel.org/r/20261029-bpftool-plugin-v2-0-1a47b2391b0b@gmail.com

Changes in v2:
- Move the LLVMDisasmDispose() fix to a separate patch (Quentin)
- Look for the plugin next to the bpftool binary when it is not installed,
  so that bpftool works from its build directory (Quentin, Sashiko). Not in
  the current directory: bpftool usually runs as root.
- Export a single versioned structure of callbacks from the plugin (Quentin)
- Only report "llvm" in "bpftool version" if the plugin loads (Quentin)
- Handle dlerror() returning NULL (Quentin)
- Rebuild jit_disasm.o if libdir changes between "make" and
  "make install" (Quentin)
- uninstall: use QUIET_UNINST, remove $(libdir)/bpftool (Quentin)
- With a static libLLVM, which a static bpftool requires, link the
  disassembler into bpftool as before (Sashiko). This drops
  LLVM_LINK_STATIC: static LLVM archives are never linked into a shared
  object.
- Commit log and comment fixes (Quentin, Sashiko)
- Rebase on bpf-next
- Link to v1: https://lore.kernel.org/r/20260603-bpftool-plugin-v1-1-68c0ac91f5a3@gmail.com

Tested on Fedora 44 x86_64, LLVM 22: builds with shared, static and
per-component LLVM, and with SKIP_LLVM; "prog dump jited" (plain and
JSON) on live programs; bpftool, also when installed as selftests do,
loads libLLVM.so only for "prog dump jited" and reports an error if it is
missing.

The changes since v1 were written with the help of an AI assistant
(Claude), from the review comments; I reviewed and tested them.

---
Mark Korenberg (2):
      bpftool: Fix disposal of the LLVM disassembler context
      bpftool: Make the LLVM disassembler an optional runtime dependency

 tools/bpf/bpftool/Makefile     | 10 ++++-
 tools/bpf/bpftool/jit_disasm.c | 88 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 2 deletions(-)
---
base-commit: cd5bc55288d4fd999595c8f2af6a5408cbe92a52
change-id: 20260603-bpftool-plugin-c994bc3e0643

Best regards,
-- 
Mark Korenberg <socketpair@gmail.com>


