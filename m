Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292822;
	b=rH7/Nnr1bdGQUdfQz5v65YM6xKwBBm1R4yn+WCul9v94ekNLa+SnSgJnABABo6aHuhAL
	 JT0iNyi3RQXqpzMxVUAK3Nugb4tTOSEKEgH49jK8MSiQXHSLwbE1cbUURMWmAsvLQKfVz
	 C2oyB2sV9aFHtoWlxGddYMovNaG3/tiEXYlmNv9QvDkhhcWYlgMt50N+Vark7ZrWCdCsY
	 SjPMRrV4N3ZuDu0iSGqA1JYEXjfFgQmZ3d9UZOSNUvTAGF7sQ/JdQJB8duo+lh2wDk1gV
	 PZ+ULoaFpC5/p5D96T3GqC9tYzO2ZYTyvF2f8mpRqEqCrZzok1Uxu/JJe2LCLLhdm9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292822;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-B4-Tracking:X-Change-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=xicm+YH2a4PUoOSmMn8TLqtg/+7g+DqOkRD//rxQtbY=;
	b=f3Na3GKkmlgOB5z6DEigcGPB2v31K7GUK3QeYZPGUOyhsZLnl66s2cHEXIjl+uw5H8tl
	 U6W0ctj5foTEuna/45CbOcTfLjtpLH4PB+oLmd0wKoAgXkd7TizgRkqHiW2zsuOr3IH9Z
	 FeLpPotLkzYTjvFOskXNNWwQqrIzel6XZeRu7MA/1IeqPXBhgsCFXKZYYTMFl0Gjy8TRw
	 EQdXPGfoo3y83jzg4r5jZyzHZJyzvREwj69acl4yxvfbZnQI+NnxkcZbwptRqhwbrcTdy
	 dLviM9nZEYFGRV//ZnMn4oIWFA8c2cB48ZPHEv18M+EHWPpMS4OkhhubiqJ9hhxz6uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EVxZ22xQ;
	arc=none smtp.remote-ip=95.215.58.113
Received: from mta1.migadu.com (out-113.mta1.migadu.com [95.215.58.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56174606A320
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56174606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EVxZ22xQ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5V+8HyL5uJ0zKjY71SJSOirPlHGHHScakry3b0/ZuAo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793292818; v=1; x=1793897618;
 b=EVxZ22xQDCcH/lwHniDlwe0CRQ7lrrBeLIQZIBive8RbiMouP2oO5TSq/AQXjVos8S4umjvj
 YghQl+FID3DBYSxXrjTduzJQ7CTaTuHDK8QSp/NT+Y538XUG+jwymq3aspA0YH91bU9iOzgNyhj
 fJLFyyn5Bo3AdJoa/nDP5G44=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a6ae364d7e57fffe;
	Thu, 29 Oct 2026 16:53:37 +0000
X-Mizu-Trace-ID: a6ae364d7e57fffe
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 16:53:28 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Ben Cressey <ben@cressey.dev>, 
	Florent Revest <florent.revest@linux.dev>, Bill Wendling <morbo@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Subject: [PATCH v3 0/7] arm64: ftrace: support CALL_OPS on kernels built with
 kCFI
Message-ID: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>
X-B4-Tracking: v=1; b=H4sIANdz42oC/yXMwQ6CMAyA4VchPdOkYrNEX8Vw2EanVQSygiEhv
 DtTj9/h/zcwySoG12qDLB81HYeCc11BfPjhLqhdMTTUOLoQY2D0+e0Yo+/7cTJ8xaTIRCcn0nE
 KBKWdsiRdf99b+7ct4Slx/s5g3w8GzHcReQAAAA==
X-Change-ID: 20260904-b4-arm64-callops-kcfi-40016eed4fb0
X-Mailer: b4 0.15.2
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

CALL_OPS and kCFI have been mutually exclusive on arm64 since commit
baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS").
kCFI checks the type hash at a fixed offset before the entry point, so
every function needs the same number of prefix NOPs. Before clang 21 the
compiler could not emit prefix NOPs without also adding the function to
ftrace's table. Since commit 9315e22b0c0a ("arm64: ftrace: allow
DIRECT_CALLS without CALL_OPS") a kCFI kernel can attach BPF
trampolines. A trampoline out of BL range is reached through
ftrace_caller. That path costs ~10 ns more per call than on a CALL_OPS
kernel, plus ~4 ns for every extra ftrace_ops registered. Clang 21 takes
a section name as a third argument of -fpatchable-function-entry [1].
This series uses it to give every function three prefix NOPs while
keeping untraced functions out of ftrace's table, and enables CALL_OPS
under kCFI. The per-call cost drops by ~10 ns and stops growing with the
number of ftrace_ops registered.

Patch 1 takes the sorttable entry offset from Kconfig. Patch 2 lets
notrace keep the prefix NOPs. Patch 3 makes the arm64 prefix layout
configurable and refuses patch sites that do not fit. Patch 4 applies
the prefix count where the type hash is emitted or read by hand.
Patch 5 adds the compiler probe and enables CALL_OPS under CFI. Patch 6
uses five NOPs on ThinLTO kernels with BTI. Patch 7 gives Rust
functions the same prefix NOPs.

The cost is text size, 4.8% of .text on a defconfig-based build with
CFI and 7.4% with ThinLTO and BTI. CALL_OPS under CFI needs clang 21 or
later, and Rust 1.98 or later with RUST=y. Commit d3359af21fc9e ("arm64:
bti: Disable in-kernel BTI with recent versions of Clang") turns BTI
off on clang 21 or later, so a mainline build has one or the other
today. A module must be built with the same prefix count as its kernel,
since vermagic does not carry the count.

Numbers below are from a KVM guest on a Graviton4 host, v7.3-rc1 with
and without this series, clang 21.1.4. Cost of a fentry program on a
syscall, per call, the call with the program attached minus the call
without it:

  Kernel            | Trampoline   | Extra      || Per-call cost (ns)
                    | vs. BL range | ftrace_ops || Median | Min  | Max
  ==================+==============+============++========+======+======
  kCFI, base        | out of range |          0 ||   32.9 | 32.6 | 33.4
  kCFI, base        | out of range |         16 ||   92.6 | 92.4 | 96.3
  kCFI, base        | in range     |          0 ||   21.3 | 21.0 | 21.8
  ------------------+--------------+------------++--------+------+------
  kCFI, this series | out of range |          0 ||   22.7 | 22.0 | 22.9
  kCFI, this series | out of range |         16 ||   22.1 | 21.9 | 22.4
  kCFI, this series | in range     |          0 ||   22.4 | 22.1 | 22.6
  ------------------+--------------+------------++--------+------+------

Mark Rutland discussed the uniform prefix with a section for untraced
entries in 2022 [2]. His review of the DIRECT_CALLS series raised the
cost of the ftrace_caller path [3]. Josh Poimboeuf's objtool support
for arm64 livepatch [4] detects the prefix by the CALL_OPS layout and
treats kCFI and CALL_OPS as never meeting, which this series changes.

[1] https://github.com/llvm/llvm-project/pull/131230
[2] https://lore.kernel.org/all/Y1LBGZPMfCZ8A1bl@FVFF77S0Q05N/
[3] https://lore.kernel.org/all/amjnf5gz0xP5PTSB@J2N7QTR9R3/
[4] https://lore.kernel.org/all/cover.1786230311.git.jpoimboe@kernel.org/

---
Changes in v3:
- Drop patches 1 and 2 of v2, now in mainline through the tracing tree
  as commit 6703ab347f4b ("ftrace: Do not leak a module's empty page
  group") and commit c738829502be ("ftrace: Let ftrace_call_adjust()
  reject a patch site"). Patches 3 to 9 become 1 to 7.
- Rebase onto Linus's tree at 8a36f53fd5ec, in the 7.4 merge window.
- Patch 4: write the second 4 in cfi_get_offset() as AARCH64_INSN_SIZE,
  include <asm/insn-def.h> for it, and comment the type hash offset
  (Bill Wendling).
  https://patch.msgid.link/CAGG=3QVs=e5JtAs-D98vDsj2ax9H0gH-_rPc0oKhx-vNpq_RyQ@mail.gmail.com
- Patch 7: say in the message that bindgen's C flags lose
  -fpatchable-function-entry on every architecture (bpf-ci).
- Collect Alexei Starovoitov's Acked-by for the series.
  https://patch.msgid.link/DLNXZ2WK7TPD.2RZBUNRS4FA4L@gmail.com
- Link to v2: https://patch.msgid.link/20260924-b4-arm64-callops-kcfi-v2-0-587865b6d991@linux.dev

Changes in v2:
- Drop the RFC tag.
- New patch 1: free the page group of a module whose patch sites are
  all skipped (sashiko on v1 patch 1). Tested on arm64 under KVM with
  KASAN: a module built without the prefix NOPs, loaded 20 times,
  leaks one page group per load without it and none with it.
- Patch 2: comment the new check in ftrace_process_locs() (Steven
  Rostedt).
- Patch 3: comment the 0 case of the sorttable Makefile guard (bpf-ci).
- Patches 4 and 9: reword the bindgen comments, the flag can go because
  removing it does not change the ABI (Miguel Ojeda).
- Patch 9: filter -fpatchable-function-entry out of bindgen's flags on
  the bindgen_c_flags_final line, so GCC builds are covered too
  (Miguel Ojeda).
- Link to v1: https://patch.msgid.link/20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev

---
Jose Fernandez (Anthropic) (7):
      scripts/sorttable: Make the arm64 before_func offset configurable
      compiler_types: Let notrace keep the function prefix NOPs
      arm64: ftrace: Make the CALL_OPS prefix layout configurable
      arm64: cfi: Use CONFIG_ARM64_FUNCTION_PREFIX_NOPS for the type hash offset
      arm64: ftrace: Support CALL_OPS on kernels built with kCFI
      arm64: ftrace: Use five prefix NOPs on ThinLTO kernels with BTI
      arm64: ftrace: Allow CALL_OPS on kCFI kernels built with Rust

 arch/arm64/Kconfig                    |  27 +++++++-
 arch/arm64/Makefile                   |  15 ++++-
 arch/arm64/include/asm/cfi.h          |  11 ++++
 arch/arm64/include/asm/ftrace.h       |  16 +++++
 arch/arm64/include/asm/linkage.h      |  11 ++++
 arch/arm64/kernel/entry-ftrace.S      |  16 ++---
 arch/arm64/kernel/ftrace.c            | 120 +++++++++++++++++++---------------
 arch/arm64/kernel/pi/Makefile         |   2 +
 arch/arm64/kernel/vdso/Makefile       |   2 +-
 arch/arm64/net/bpf_jit_comp.c         |   8 ++-
 drivers/firmware/efi/libstub/Makefile |   2 +-
 include/linux/compiler_types.h        |   9 +++
 rust/Makefile                         |   7 +-
 scripts/Makefile                      |   4 ++
 scripts/sorttable.c                   |   7 +-
 15 files changed, 190 insertions(+), 67 deletions(-)
---
base-commit: 8a36f53fd5ec3eff01f1b637d42cbdc3821d0493
change-id: 20260904-b4-arm64-callops-kcfi-40016eed4fb0

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

