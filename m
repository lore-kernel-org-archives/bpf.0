Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293015;
	b=j3TZbxOmapXZBO8DNWABfnj07yk7llSULgny0DPHB0axpsJ0Xf4cHShf6EbHxLiR6ldu
	 +c3X3wGEgOmBRDogmb6AwWDkmxS1TDoBnPlHESlxdg3s0fcharJhvrilXZ++jwIfkFbpY
	 vn7OzrRXQmZ86s0ir5sDW0lHHWZOWqIaPgczuKJUS5zkcHMq1sOSdBT5KW0e6dRp0LpTW
	 MFZ00phxswOYIzjiTVTt0gYokNbX8jqLdDHpuDwSRsrHnmK4knCog5jJx2X+pAOzoCF13
	 UlMkdd2jDzuYea6wvIadCTqw+uoSzvTdoBQo9U40boj4vdAuxwa8itqYRwFhl+xcZIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293015;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Hl2FAoChiij72hAtomRJkkZ9M0nlYfCdBuDh7jqAxB4=;
	b=A2y49/szJHOAi15VhR9o7t4Z0jeitKVexW0k8t4R34kMqwrte5LHIFsXBJPwTLQq1TGO
	 6B1CC0kpq1SqXH7m7qSH3to0VRjB956EGX3ylc+TPwGeblD6w+i8SVEfUajmUxWdKBoGo
	 FS14K6iFLg3peusCXKddB7vaEEB2dVdyYWmVlCLAeTa3QZ+klrG4ymaqCNBmvC0yXgyIa
	 6JwcNIR3CotUMhsHhpEA/d4qL400g5C+HKiT2bLwMeIzTWP+kZi7OgBl3YfSezpR7eOGS
	 /6Z+KemxaJulwklrdA+5M+o+WWMa9L1+ytm4sb4MsbPy1fVnplLgk7+tEWwyeMPTVEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HBpBkoHc;
	arc=none smtp.remote-ip=95.215.58.26
Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED4606A324
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19ED4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HBpBkoHc
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/dXjDDSTBXGEfyEbgPW2q5whv/wUPaoNdKn8g3XixeA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793293013; v=1; x=1793897813;
 b=HBpBkoHcFVqLjDak0A0AiIuKpaOWWoIm72CoiuStEa7WVSzIyXKrh0+rtgqzDyrPFxC+d914
 GA1H+ITTAuwpUjVgMe/TUyvq3K6E5aZv+yaTkNN1OrPXnpMPP0b6Q/3QOmGw8GUzjDQJQ/2PCse
 pFHaeYTco1wtDPGjsWEK0rD0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 28a782b4a7711c87;
	Thu, 29 Oct 2026 16:56:53 +0000
X-Mizu-Trace-ID: 28a782b4a7711c87
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 16:56:43 +0000
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
Subject: [PATCH v3 5/7] arm64: ftrace: Support CALL_OPS on kernels built with
 kCFI
Message-ID: <20261029-b4-arm64-callops-kcfi-v3-5-1b011ad5ddec@linux.dev>
X-Mailer: b4 0.15.2
References: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>
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
In-Reply-To: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>

CALL_OPS and kCFI have been mutually exclusive on arm64 since commit
baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS").
kCFI checks the type hash at a fixed offset before the entry point, so
every function needs the same number of prefix NOPs. Before clang 21,
prefix NOPs came only with an entry in ftrace's table, and untraced
functions had none. Since commit 9315e22b0c0a ("arm64: ftrace: allow
DIRECT_CALLS without CALL_OPS") a kCFI kernel can attach BPF
trampolines. But without CALL_OPS, a trampoline out of BL range is
reached through ftrace_caller, ~10 ns more per call than on a CALL_OPS
kernel, plus ~4 ns for every extra ftrace_ops registered.

Clang 21 added a third argument to -fpatchable-function-entry that names
the section the entries go to [1]. Point it at a section the linker
scripts already drop and a function gets prefix NOPs with no entry in
ftrace's table. When CFI and CALL_OPS are both enabled, compile every
object with
-fpatchable-function-entry=M,M,.discard.patchable_function_entries,
where M is CONFIG_ARM64_FUNCTION_PREFIX_NOPS.

Gate CALL_OPS under CFI on ARM64_CFI_PERMITS_CALL_OPS, which needs
clang 21 or newer and RUST off. rustc has its own flag for the prefix
NOPs and this patch does not pass it, so Rust functions would have no
prefix and a different hash offset.

M is 3 because the ops pointer needs an aligned 8-byte slot inside the
prefix NOPs, and the 4-byte hash puts the NOPs at offset 4. A traced
function, with the two entry NOPs from CC_FLAGS_FTRACE, then looks
like this:

  func-16:            .word <hash>    // kCFI type hash
  func-12:            NOP
  func-08:            NOP             // ops pointer, 8 bytes
  func-04:            NOP             //
  func+00:    func:   NOP             // To be patched to MOV X9, LR
  func+04:            NOP             // To be patched to BL <caller>

Size of .text in vmlinux on a defconfig-based config with clang 21.1.4:

  Kernel                 || .text bytes | Delta       | Delta
  =======================++=============+=============+=======
  kCFI, base             ||  21,023,888 |             |
  kCFI, M = 3            ||  22,031,504 |  +1,007,616 | +4.8%
  -----------------------++-------------+-------------+-------

Numbers below are from a KVM guest on a Graviton4 host, v7.3-rc1 with
and without this series. The workload is a fentry program on
__arm64_sys_getpid, 20M calls per pass, six passes per boot, six
boots, each cell the call with the program attached minus the call
without it. The in-range rows are the same kernels booted with nokaslr.

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

Out of range this saves ~10 ns per call and the cost stops growing
with extra ftrace_ops. In range both kernels branch straight to
the trampoline and the numbers roughly match.

ftracetest and the BPF trampoline, struct_ops and kprobe_multi
selftests pass with CFI enforcing.

[1] https://github.com/llvm/llvm-project/pull/131230

Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 arch/arm64/Kconfig                    | 15 ++++++++++++++-
 arch/arm64/Makefile                   | 12 +++++++++++-
 arch/arm64/kernel/pi/Makefile         |  2 ++
 arch/arm64/kernel/vdso/Makefile       |  2 +-
 drivers/firmware/efi/libstub/Makefile |  2 +-
 5 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7d5e1859af..6715adcae38b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -190,7 +190,8 @@ config ARM64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
 		if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
-		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI && \
+		if (DYNAMIC_FTRACE_WITH_ARGS && \
+		    (!CFI || ARM64_CFI_PERMITS_CALL_OPS) && \
 		    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_ARGS
@@ -271,8 +272,20 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS
 	def_bool CC_IS_GCC
 	depends on $(cc-option,-fpatchable-function-entry=2)
 
+config CC_HAS_PATCHABLE_FUNCTION_ENTRY_SECTION
+	# The section argument needs clang 21 or later:
+	# https://github.com/llvm/llvm-project/pull/131230
+	def_bool $(cc-option,-fpatchable-function-entry=1$(comma)1$(comma).discard.patchable_function_entries)
+
+config ARM64_CFI_PERMITS_CALL_OPS
+	def_bool y
+	depends on CFI
+	depends on CC_HAS_PATCHABLE_FUNCTION_ENTRY_SECTION
+	depends on !RUST
+
 config ARM64_FUNCTION_PREFIX_NOPS
 	int
+	default 3 if DYNAMIC_FTRACE_WITH_CALL_OPS && CFI
 	default 2 if DYNAMIC_FTRACE_WITH_CALL_OPS
 	default 0
 
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index ed28f94be428..9fbfe5ab3724 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -137,7 +137,17 @@ CHECKFLAGS	+= -D__aarch64__
 
 ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
-  CC_FLAGS_FTRACE := -fpatchable-function-entry=4,2
+  prefix_nops := $(CONFIG_ARM64_FUNCTION_PREFIX_NOPS)
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=$(shell expr $(prefix_nops) + 2),$(prefix_nops)
+  ifeq ($(CONFIG_CFI),y)
+    # Every object gets the prefix NOPs and no ftrace entry by default.
+    # CC_FLAGS_FTRACE comes later for traced objects and overrides the
+    # -fpatchable-function-entry.
+    CFI_PREFIX_CFLAGS := -fpatchable-function-entry=$(prefix_nops),$(prefix_nops),.discard.patchable_function_entries \
+			 -DCC_USING_PATCHABLE_FUNCTION_PREFIX=$(prefix_nops)
+    KBUILD_CFLAGS += $(CFI_PREFIX_CFLAGS)
+    export CFI_PREFIX_CFLAGS
+  endif
 else ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_ARGS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
   CC_FLAGS_FTRACE := -fpatchable-function-entry=2
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index a273ab5af805..0ccae4ff00a0 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -18,6 +18,8 @@ CFLAGS_map_range.o += -mstrict-align
 KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
+# the discard section holds absolute relocations, which relacheck rejects
+KBUILD_CFLAGS	:= $(filter-out $(CFI_PREFIX_CFLAGS), $(KBUILD_CFLAGS))
 
 hostprogs	:= relacheck
 
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index f6619e1cb2ce..334ea3fac812 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -38,7 +38,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
 			$(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
 			$(GCC_PLUGINS_CFLAGS) \
-			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(CFI_PREFIX_CFLAGS) \
 			-Wmissing-prototypes -Wmissing-declarations
 
 CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables $(CONFIG_CC_OPT_INLINE_MEMSET)
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index bbab12b8eb4b..5bbb57c64fe0 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -54,7 +54,7 @@ KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS), $(KBUILD_CFLAGS))
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 # disable CFI
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_CFI) $(CFI_PREFIX_CFLAGS), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 

-- 
2.54.0

