Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505700;
	b=NKV/UUryNQLDzgWmICujwvvDhEUciihnzJRR5V7AEHfH5IaX7oaGe1bJZnMw/KZe4azI
	 B7KUR/dBOnvzmnKSSv6p00g14kDuGKEnhejrG60VdeWAW7SkTFSJdBIGJJMTkpNqE+EMw
	 +jjWHdObqHCGxra7T42auPAxPsN2TdQsLA4QvyCkN088rYReG/cxBJ6I9l3hnbCL5rcQU
	 VO5447GER1iqULlOH6DTS9ywzAGhEGZcNBmfJ6OfPWuWf2PoaPx9lK0GOncCvmOgDo6Al
	 w8+4ehAxQbhUxxU2ucI+Gtkzp6YolvYdluZtu4urpIwfFJBxECDu51zCveJs5Yt1Q4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505700;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=VkDe+bgofG0djlbAtK4W6vrXyVZ2YZFDR0meLeYLWpc=;
	b=XIDeWnzBV7WdWmLsRDQI/frBgkWwHWXaf91qY93JW29Ex6GKh157BQ2/9rFsTxzmq0Bm
	 +5+WfK9OoemjDJQEGioq+KlZqNrQauVnepB4XnMJyCg5swkElPNm4Ztm+l0Vwr5sS4iHH
	 iOawyJbeuXSwY0/O7uQACK4+Uscpbrgb9D0Kp0JfiLPGb8mOxTNPHoAaIBkx7I3ezLgC0
	 hmrntLYYljyqfpOyCRNWDcKkJ9jYWoiJWdWcaWXlIkiJ2+4TOi5dwfOMr3WN8wbOlBxKB
	 0SEpXVtQo22G+givhKZKWHgDEQIq9r+tQ8CtoVtzdwbRzwrrvJdMDpA7ZexxuZnTtWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bvi5ajtq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58497606A327
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bvi5ajtq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE111F000C4;
	Thu, 12 Nov 2026 17:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505699;
	bh=VkDe+bgofG0djlbAtK4W6vrXyVZ2YZFDR0meLeYLWpc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Bvi5ajtqAILF3pk2K6y5gmvImelA+kYOGGtjs4Qdc6n7mAmiCPdEiAC1UekwIg0u2
	 x7lbVkwY8RFwCDuWiMH8+poCJKR/7A1v/qtX1VY8SGsmBxsArg+HH1sKTMBdZpOSfi
	 qpoFfYVnpDXALk9+hlsjXdLMHBM/Vp7SkSPJZNF44HPTLL3elLn/UZYtwwpuKA2W+k
	 g6Fi3T+gVzsUTUC4zqhOHsPTsDaUPYTIHBBOSNazCRo8OmfeLxMQSw7xibMV7GtiHm
	 hIb6cOgDdob9k3LcCiTqP0R0kpeCG/J0v7hptQDFFrxzVO6JHj7MbeYIOfRFHx/aUo
	 p38RW3UAvMfng==
Content-Type: multipart/mixed; boundary="===============2198600940477456396=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a883615eaa9c9ddc3282e389768f449baff8f6897dabd4148bebb61334d57f23@mail.kernel.org>
In-Reply-To: <20261112164610.1917256-4-alexei.starovoitov@gmail.com>
References: <20261112164610.1917256-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 03/10] resolve_btfids: Describe machine instructions with LLVM's MC layer
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 12 Nov 2026 17:48:18 +0000 (UTC)

--===============2198600940477456396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Describe machine instructions with LLVM's MC layer

TL;DR:
- arm64 BRK is treated as falling through, so a BUG() brk may let
  resolve_btfids tag a made-up error as an fmod_ret return value
- Makefile runs llvm-mc.sh directly, relying on the execute bit
- x18 caller-saved comment is inaccurate (nit)

> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile

[ ... ]

> +ifneq ($(filter --fmodret_scan,$(RESOLVE_BTFIDS_FLAGS)),)
> +LLVM_MC := y
> +HOSTCXX ?= g++
> +LLVM_MC_SH := LLVM_CONFIG="$(LLVM_CONFIG)" HOSTCXX="$(HOSTCXX)" \
> +	      $(srctree)/tools/bpf/resolve_btfids/llvm-mc.sh $(SRCARCH)

This script is run by its path with no interpreter in front, so it depends
on the execute bit.  Documentation/kbuild/makefiles.rst ("Script
invocation") says make rules shall not rely on the execute bits being set
and shall not invoke the script directly.

If the mode is lost (a patch applied by a tool that ignores git mode lines,
for example), $(shell) returns nothing and the build stops here:

> +CXXFLAGS := $(filter-out -Werror,$(HOSTCFLAGS_resolve_btfids)) -O2 \
> +	    $(or $(shell $(LLVM_MC_SH) cxxflags),$(error $(LLVM_MC_HELP)))

with a message about a missing C++17 compiler or LLVM 17 headers, when the
real cause is the file mode.  The Kconfig check added later in the series
would quietly make the option unavailable.

Would it be better to name the interpreter, as in
"$(CONFIG_SHELL) $(srctree)/tools/bpf/resolve_btfids/llvm-mc.sh" (or sh
for standalone tools builds where CONFIG_SHELL is not exported)?

[ ... ]

> diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/bpf/resolve_btfids/text_mc_arm64.c

[ ... ]

> +	/* HINT: nop, bti, yield, wfe ... */
> +	{ "HINT", TEXT_OTHER }, { "AUTIASP", TEXT_OTHER }, { "PRFMui", TEXT_OTHER },
> +	{ "DMB", TEXT_OTHER }, { "BRK", TEXT_OTHER }, { "MRS", TEXT_OTHER }, { "MSR", TEXT_OTHER },

Can marking BRK as an ordinary instruction with complete defs make the
tool report an error value that no path returns?

On arm64, BUG() and WARN() both emit "brk BUG_BRK_IMM"
(arch/arm64/include/asm/asm-bug.h), and only the __bug_table flags tell
them apart.  BUG() is followed by unreachable(), and __builtin_trap(),
UBSAN_TRAP and non-recoverable KASAN brks also never return.  So after
such a brk the next instruction starts an unrelated block, and the
brk -> next edge does not exist.

With this entry, read_opcodes() clears o.unmodeled for BRK, defs_of()
returns 0, and control_flow() leaves the kind as TEXT_OTHER (the test
T("00 00 21 d4", TEXT_OTHER) pins this).  In the backward analysis that
consumes this decoder (text_flow.c transfer(), commit 1865bd1e7620), a
TEXT_OTHER does:

    join(&out, flow, next_insn(flow, i))

and kills only insn->defs, which is 0 here.  So every "may become the
return value" fact of the block placed after a BUG brk flows backwards
into the BUG path, x0 included.

For example, if the compiler hoists "mov w0, #-22" (an argument for a
later call) above a BUG_ON() branch, and the block after "brk #0x800" is a
shared epilogue that returns w0 as it is, scan_func() tags -22 as a return
value even though no real path returns it.  That is the made-up error the
commit message says the tool never adds ("the tool drops an error. It adds
none").  Commit 68cfc611da01 then lets an fmod_ret program return it.

On x86-64 the same BUG site is a barrier: ud2 keeps
hasUnmodeledSideEffects(), gets defs = TEXT_ALL_REGS, and kills every
fact.  The arm64 entry removes that barrier for x0..x30.

The flow from the brk is real for WARN and for the inline kCFI brk, so the
entry cannot just be dropped.  Could a BUG brk end the path, for example
by using the __bug_table flags (BUGFLAG_WARNING) or the BRK immediate, and
everything else be treated like the x86 ud2?  Nothing later in the series
changes the BRK entry or teaches text_flow.c about non-returning
instructions.

[ ... ]

> +const struct mc_arch mc_arch = {
> +	.arch = {
> +		.retval = 0,
> +		/* AAPCS64: x0 to x17 and x30. x18 is fixed in the kernel */
> +		.caller_saved = 0x4003ffff,

This isn't a bug, but is the comment accurate?  arch/arm64/Makefile adds
-ffixed-x18 only under CONFIG_SHADOW_CALL_STACK:

  ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
  KBUILD_CFLAGS += -ffixed-x18

Without SCS, GCC and clang treat x18 as call-clobbered, so the caller-saved
set would be x0..x18 plus x30 (0x4007ffff).  This has no effect on
compiler-generated code today, but adding x18 is safe in both
configurations (it only kills facts) and would make the comment
unnecessary.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43267213382
--===============2198600940477456396==--
