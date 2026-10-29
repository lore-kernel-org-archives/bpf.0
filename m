Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793277820;
	b=U0SPQTCW/bH/TKS5ZU0xF1BGIt+Ufg4DA3MerHfZVaAR8m1FOz8MxeLb6MDt6O8i4keU
	 VEpEQdUhf5pUWjv1QwtaMG1x/S9u23Y9ulsrVu0KuAu1D1W7MHh0sOblBMkhhxbcXswFg
	 JP0joIOhwQbUUEkXvOzKsDF6Tf+rCTUkHPOn89Am4CGQv5iN5UIOWt/pKTVnfbOfk/oL8
	 hc2FwShnYQPq+FpeafYfft5jPGdQqQOtCfg1X8iOe+idK4SW5L/0rwos/4bYGlL48d98T
	 ITSOO3Xps7zBSTja9+OX45CLftxwOPvLgdcULzyfo4Uboxt2OlRLPaYJ7Oqt6oL0MXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277820;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=3DcUbqGu4+qxOKmStpIXUxe4jW/Aa4+qpvGi4pywUXo=;
	b=xTcjcUIM0nyJBadfxRTUkqmoZqvCfiyoUfCh6d7BDANfNOSr0ArWqmOOyRZ/y6HreHv4
	 fAFZHSY0lSIvBIXcCL8f8SiqBzDont2VzVTUFtj9M1r2266+9ieNW+vIYytcPMqNnYXBp
	 tYEb2FDh4bUT6Oe0CGTWM+R8j7pRPy1fPEnh51Vo6IfJb4aFHzYyqXkwHgoGfM9pj8Fx4
	 1rmWslcue/ULZnPVX49zqdS4nIS6H6z/5Kq1Vj77xORZoukZ2Y/vsvbTeM21+IAPY1pE+
	 bYgCQfg7EwyH/9Lkvq0F1ihfgoLeH3ZRQxlmdvZeRjxO2EIIlgATPHCnBBlhvG5r8TQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWUpC4As;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30802606A323;
	Thu, 29 Oct 2026 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWUpC4As
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793277819;
	b=xMaPoU46kKMKmOJq7ejva+FBE+F1tTra2Z3g3Cwh4r3MYV8gSfQEN0eKd/4tvt9AOzOD
	 +wUzWSdyhnYZgrGZYEYugMeEJqt4NesNhTUUT+IZw6MgTPquAJG5NHNhiz0hUt4AyTmTX
	 SdodU+8J3eEsogIiEmDTEwGZq0gqZuQ1hbzAmP0ktV6kYv7WvvjcQdihKS6QzsiRFf29q
	 ywsHdbunaqyjUTG0tLYodglr4lQluPEz15PuFmDo5F5LSeHQsbsODLB9QqNfynDMIHsMC
	 rcgZBiIrGiMsutiJk1CYXU5xDRR0r9aze1Wncs2g4ytGGUq8zcH9LdEmqjW5VKHTvFw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793277819;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=3DcUbqGu4+qxOKmStpIXUxe4jW/Aa4+qpvGi4pywUXo=;
	b=cmNnfdlteo2pUEwf6pQQAkeBJkLoma4KYpP6O3djhnM5pQJf4xD4pmkQ9MW0kUxXLEJt
	 uHRQogJ1lCMZik+z5wSBmkm14ViDP/fk+xLTQQVmEn6ldTXMl1VaYsZ7gPqOVJvMqGu9d
	 NubmPbooYxIV/NGxdPmi3BhNE9DDfPfht2dGwECFbSVcZ38+sUOEWowWoVpAMLPnzNhkr
	 7feGdfdvetMq+YZGMQVIhwANuEh5C2l3g9hE4UDLbAD/K6U7EItWfZCLL0cqwmvSaqIRN
	 NYyMS45Fneqq9XI837GEgydS3muuGD6CO15Jbyv6t+V5o/sX6LxznS02nUitJ8puXkg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DBBEE1F01829;
	Thu, 29 Oct 2026 12:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793277819;
	bh=3DcUbqGu4+qxOKmStpIXUxe4jW/Aa4+qpvGi4pywUXo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=iWUpC4AsJNCaw/4aMs26NfzE/0H+NwkmMUuwkvVnTCH3GLNHlsQaKtFDvC5OL/GeU
	 iRlICOJ1yDDdBI9Ijrhz4+SroxR2c0VmgUUjchIrmtkgn+uLhcrQupqFwZJg33tnDK
	 xkpDfEut4e6cUWUPuSjKtGpF7ILqSwSYaT0H/KzTOQ8gUYfC/GIagxhMf3dZq4K3yp
	 U6h+33w4BFbLZJSWJ6aYuaFte8BXDTytqnVmRYWPy7uqPXiAuLBrr+nQ9aPq+XPrL8
	 sivPZRHTShM4KDCHFS7OBEJ9TMYaA8J5mgoDoOlj+7ENaWIngvQjejLimu8WIxxBN/
	 6TVmPH4aIedww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3FD644585B;
	Thu, 29 Oct 2026 12:43:38 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Subject: [PATCH bpf-next v2 0/2] bpftool: Make the LLVM disassembler an
 optional runtime dependency
Date: Thu, 29 Oct 2026 17:43:17 +0500
Message-Id: <20261029-bpftool-plugin-v2-0-1a47b2391b0b@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6DIBBEf8XsuduAWFJ76n80HpAuuImCAWtsj
 P9e4r3HyZt5s0OmxJThUe2QaOXMMZRQXyqwgwmekN8lQy1qLbRQ2M9uiXHEefx4DmjbtumtIqE
 bBWU0J3K8ncIXlC4G2hboChk4LzF9z6dVnvyfdJUoUd+tMLaV7mbU00+Gx6uNE3THcfwAHfHQh
 rYAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793277817; l=2496;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=zLigtogb2hNT9/npTF66tViWfleGoRd//6M0rXeSiyM=;
 b=pV2kzMabYC80Jid/Kv+FKPzcvfWUjTKszoWxsw6TcbY2zNeEEe+k+fKas/26bnTxVO1omH3oZ
 20xhndlSoCiBXgqCKEgHoEnv+Is9D9EeTCmTfxZle4RbYclcqy7nX7B
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
 tools/bpf/bpftool/jit_disasm.c  | 161 ++++++++++++++++++++++++++++------------
 tools/bpf/bpftool/llvm_disasm.c |  84 +++++++++++++++++++++
 tools/bpf/bpftool/llvm_disasm.h |  41 ++++++++++
 tools/bpf/bpftool/main.c        |   3 +-
 tools/bpf/bpftool/main.h        |   3 +
 6 files changed, 279 insertions(+), 51 deletions(-)
---
base-commit: d80373a8e70d3193151232c3062abbbe367ff5ad
change-id: 20260603-bpftool-plugin-c994bc3e0643

Best regards,
-- 
Mark Korenberg <socketpair@gmail.com>


