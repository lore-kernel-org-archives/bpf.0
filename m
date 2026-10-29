Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793279145;
	b=dWefedldAbNNVUcw4EaViuyxwxot8zvpdr5+sYGMLiqI+GgT/s7/TMFHH3Yp0SDU+wiL
	 pYLEPrFB5fkkUQYnhN1UlFYEUPmb6D+Q6587L83yBFFJ58ZF36KrGGf9IClBgb6HvqNdP
	 c6f3eA0T0bbCwXE3Bv/1OaD8WezbuGVUbUoLYFrNZGsuXY1i0T+rjTChCD6oCLyySaW0+
	 sr4TN4aySBZTDR+uTybPlpowCCsFSzaoEpVfUDmK5n5IkzSlkxeFv0GrKqVBiFdGDwri4
	 Hw0tIaQckY7MftPmL6WLIYgnG5pKiRTjYo35WOsJyY4Jkwls4mZx7jeY3oD+wzBLsjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279145;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ydVblDX7W0cXEAEJbmWVNGpTe/4AkHnmmnq8en75pvQ=;
	b=LdhvgC3CsTmWlT0Jwu2R7mrrtORZSJozCnX6LrWIgiEdGR4pTBy9QKYvwhbjGCXEpM3z
	 Hpr2wxMfQQhEyP870M9dfON9Eh+BKMNUXnA04ALGsUFfDqvB2F83Q1YVrR5RAbNCktp7q
	 s/N6H8lTv+dp1P7D/RH9gjup/pTPznXbFsLTYfwooZP5kf0qe4BTKkPVtB+9GdgGLRyy/
	 dfLl/EGsDM7hb4zTnDW15J4mtH3CUin3zWf9g0+JfKQHgBe+hsvBNnfgP92m3UmML57rL
	 zc/u6i607JUEPz3Y43NiqNK2u9exUN/Bq3vDtJwndYTMJBLrLdxgOCZDLyVD7oC/r3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DW1iasmv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1F606A31D;
	Thu, 29 Oct 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DW1iasmv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793279144;
	b=Z7ZxDgWr+vzqFsKwwb/FLajA01kpVL6aJwTo6ELmtTyG2qCK061aFpgtT0iWR7l+Wd35
	 77/6+t/0mgtt4yH7V9T2AQLLhrsM1j7sHZoTyoT1kFRm7mPWcs5M11J5y40s8DP42WUT1
	 DDPnlF58DsPuC9t1GQpbnk0nlkAWTsETTh3oEoksGvGd2wo1j8wI9obSMJ4FyRuMh41GB
	 JBqg7HTzOV0XPKPQ2q+tQ6XbWu1KVLn9tbLY+90SPJe3yOZ56V/a85Aaudm//w5NxdoOs
	 iBaCK6o3PiNMZdYvtorRM+6n4lxA9xkpnFqOgjqbrDQuV/2pGtH0h9/xQ95FdDp11Hg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793279144;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ydVblDX7W0cXEAEJbmWVNGpTe/4AkHnmmnq8en75pvQ=;
	b=d9J8LOSGinW5xSo7kMAHEKweRt8XMOq8Z1IvvT6dg5BcDS4VDWyWjv1ndfXvAsUwS+ds
	 L+kigOhrPAxpuubhao7jVF7UMvQVtB8RHRyUXsdhN+VXyxXHIkAS4PJsOAWjPy5EZNhXp
	 A7qoFRyO4rGpPq2dekZmjMi3YzWNQ6FM6zRpyCnM8eKD0smIfQQsim1XG8dcoCqwutuBT
	 DvmK+ZIknD3KNoZaT+U7/PQMMIIKnVtuvSfRWzyotXf04xNOsWmhH46AThUMM5Leu3AaR
	 SVeJ1Y4Ewo/jL7xBQRoojXn4cvfD3dKMOELyUyYIlgXkX3x4XQWIxXzb67u33ZQY+mw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AFA331F01825;
	Thu, 29 Oct 2026 13:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279144;
	bh=ydVblDX7W0cXEAEJbmWVNGpTe/4AkHnmmnq8en75pvQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=DW1iasmvUlF7zfZbIHeTFsBp2ko6wPmN3RrarFZ0T94IG7+xlz0qOKq58qCfaOLAY
	 PTRtPd8/IR7BccKA7uNGx96FqGNiUQu/xojrS5WPSv+TTMQ2zl6kGAPK64b9SxK3qO
	 vZGd9TYfGVa0aSn0i85unV9iguGtY1m8a8poQhvlin5uA1Vgc5beCjDGfNE3h26PYv
	 pjaDwOMVdpqDKipOCpk7DybUh+7o61bHNcgMr3MEUSCA6xSzJvbeHwa84eUIvwjzom
	 p5HjLQEeeIXu/v//6TmFLT2QNxJ/MpjbRWDejcC8oVRAlA48Iti5dBaquGbuJt8xYk
	 lx2xuD8+B7ADg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 11EB945872;
	Thu, 29 Oct 2026 13:05:43 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Subject: [PATCH bpf-next v3 0/2] bpftool: Make the LLVM disassembler an
 optional runtime dependency
Date: Thu, 29 Oct 2026 18:05:36 +0500
Message-Id: <20261029-bpftool-plugin-v3-0-87af799da40a@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNywrCMBREf0Xu2it51Ghc+R/iIolpG2iTktRQK
 f13QxYiiMth5pxZIdnobILLboVos0su+BL4fgemV76z6B4lAyNMEEE46qmdQxhwGp6d82ikbLT
 hloiGQ4GmaFu3VOENyha9XWa4l6Z3aQ7xVZ8yrf0/aaZIUZwNUUbS9qj4tRuVGw4mjFWV2Qenh
 MkfnCFBqpqTZlxSTfQ3vm3bGzLVaGH1AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793279142; l=2789;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=4+EVE0vRRHLPdxZueJ3Z0rAQkXRNx4EBHKNnKXGICFc=;
 b=3b61HIda+LvZWU94BX+vCZzYrThe3BCs40LS4OpIm+W09DBcofh39uT5hDHoua/0i3W6GoYZ1
 3rCH3FG558rBB6tXw7G3nHFVNwKuiPn2leCvd2fisZAAWToY1bCNbJv
X-Developer-Key: i=socketpair@gmail.com; a=ed25519;
 pk=2iAMjWhs7kA9X8ccetT2YVX8dvniXua2okQogw3Don8=
X-Endpoint-Received: by B4 Relay for socketpair@gmail.com/20260603 with
 auth_id=806
X-Original-From: Mark Korenberg <socketpair@gmail.com>
Reply-To: socketpair@gmail.com

libLLVM (~140 MiB on Fedora) is a hard dependency of bpftool, although it
is only used by "bpftool prog dump jited". This series moves the LLVM
disassembler to a plugin that bpftool loads on demand, so that
distributions can make it optional. Patch 1 fixes a leak found on the way.

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

Tested on Fedora 44 x86_64, LLVM 22: plugin, built-in and SKIP_LLVM
builds; plugin lookup (installed, build directory, missing, wrong ABI);
install/uninstall; "prog dump jited" (plain and JSON) on live programs,
and disassembly of aarch64 code through the plugin. Not tested: a fully
static build (no static libraries available).

The v2 changes were written with the help of an AI assistant (Claude),
from the review comments; I reviewed and tested them.

---
Mark Korenberg (2):
      bpftool: Fix disposal of the LLVM disassembler context
      bpftool: Make the LLVM disassembler an optional runtime dependency

 tools/bpf/bpftool/Makefile      |  38 +++++++++-
 tools/bpf/bpftool/jit_disasm.c  | 158 ++++++++++++++++++++++++++++------------
 tools/bpf/bpftool/llvm_disasm.c |  84 +++++++++++++++++++++
 tools/bpf/bpftool/llvm_disasm.h |  41 +++++++++++
 tools/bpf/bpftool/main.c        |   3 +-
 tools/bpf/bpftool/main.h        |   3 +
 6 files changed, 276 insertions(+), 51 deletions(-)
---
base-commit: d80373a8e70d3193151232c3062abbbe367ff5ad
change-id: 20260603-bpftool-plugin-c994bc3e0643

Best regards,
-- 
Mark Korenberg <socketpair@gmail.com>


