Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A733CEBB
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815168; cv=none; b=tleRedhfkGI5n3cnEZYRQ9mlfiO2vcII99fvEZTe4wsO0/yWvzAUJ4TF7FABXhselz4LdNQbMjPvqV2Q3moBp9aU5TSSsL8jX8nhz6zqOB8efljR5ltQF+4FN+s9aW7vJCvTpliQpd4s4suVSemH0yu79OWkn6wWvpmbRvOKb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815168; c=relaxed/simple;
	bh=9KlKj/xXdlkct5wGQheoeFEGIJnTX8bugXZN8QBRMQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZgls2SkYAI+YKaseAKyr44nBTlpXIWHcnl31n5ShMSPDscZouzMozK7YuZIbdbcJliWm9NoRXvoFz/kEezGwCHEGzudgWCDMREB6AKAmIut7iaGDA98Wj6qmZP5G+MxYWzdXn9QSiROWWufBp/COF74UPnmp3EGui4lBIRaOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUi2yI12; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUi2yI12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA0C4CEF7;
	Fri,  6 Mar 2026 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772815168;
	bh=9KlKj/xXdlkct5wGQheoeFEGIJnTX8bugXZN8QBRMQ8=;
	h=From:To:Cc:Subject:Date:From;
	b=KUi2yI12N3qhcDC4iwhWw+KJrAQYv3RuXDN+SPXMQN4DSzeT324HdF8cXSYH2VGRw
	 fhvSwLV3xGxJhmIi1myf7NVXkg4ZCRq+BdCAA1GJfISVjhdrCiTG9kU3D7loLG/kGE
	 sNKEEJDo1u6mR2QQAWndBkVE9VjlqcXaUTx5gJqg4tTMSfh2e+SlZzocMgo11PAqIY
	 sLX4edJ2Ew3xiaywnc+gFOzGBEn0RFctR9qhw3wS6LHeRRRf5eM+34rFQfFU1717k/
	 3GJYB6QRqim2yDMWGjJVssU/rtwO3UL/NgH6bYluMI1lfHktbh/LCgvQo/ga7knZkS
	 Md1W1a5bzvsIQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpftool: Enable aarch64 ISA extensions for JIT disassembly
Date: Fri,  6 Mar 2026 08:39:05 -0800
Message-ID: <20260306163906.2870529-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LLVM disassembler needs ISA extension features enabled to correctly
decode instructions from those extensions. On aarch64, without these
features, instructions like LSE atomics (e.g. ldaddal) are silently
decoded as incorrect instructions and disassembly is truncated.

Use LLVMCreateDisasmCPUFeatures() with "+all" features for aarch64
targets so that the disassembler can handle any instruction the kernel
JIT might emit.

Before:

int bench_trigger_uprobe(void * ctx):
bpf_prog_538c6a43d1c6b84c_bench_trigger_uprobe:
; int cpu = bpf_get_smp_processor_id();
   0:   mov     x9, x30
   4:   nop
   8:   stp     x29, x30, [sp, #-16]!
   c:   mov     x29, sp
  10:   stp     xzr, x26, [sp, #-16]!
  14:   mov     x26, sp
  18:   mrs     x10, SP_EL0
  1c:   ldr     w7, [x10, #16]
; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
  20:   and     w7, w7, #0xff
; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
  24:   lsl     x7, x7, #7
  28:   mov     x0, #-281474976710656
  2c:   movk    x0, #32768, lsl #32
  30:   movk    x0, #35407, lsl #16
  34:   add     x0, x0, x7
  38:   mov     x1, #1
; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
  3c:   mov     x1, #1

After:

int bench_trigger_uprobe(void * ctx):
bpf_prog_538c6a43d1c6b84c_bench_trigger_uprobe:
; int cpu = bpf_get_smp_processor_id();
   0:   mov     x9, x30
   4:   nop
   8:   stp     x29, x30, [sp, #-16]!
   c:   mov     x29, sp
  10:   stp     xzr, x26, [sp, #-16]!
  14:   mov     x26, sp
  18:   mrs     x10, SP_EL0
  1c:   ldr     w7, [x10, #16]
; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
  20:   and     w7, w7, #0xff
; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
  24:   lsl     x7, x7, #7
  28:   mov     x0, #-281474976710656
  2c:   movk    x0, #32768, lsl #32
  30:   movk    x0, #35407, lsl #16
  34:   add     x0, x0, x7
  38:   mov     x1, #1
; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
  3c:   ldaddal x1, x1, [x0]
; return 0;
  40:   mov     w7, #0
  44:   ldp     xzr, x26, [sp], #16
  48:   ldp     x29, x30, [sp], #16
  4c:   mov     x0, x7
  50:   ret
  54:   nop
  58:   ldr     x10, #8
  5c:   br      x10

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/bpf/bpftool/jit_disasm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 8895b4e1f690..317d810a30ba 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -93,7 +93,18 @@ init_context(disasm_ctx_t *ctx, const char *arch,
 		p_err("Failed to retrieve triple");
 		return -1;
 	}
-	*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
+
+	/*
+	 * Enable all aarch64 ISA extensions so the disassembler can handle any
+	 * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics).
+	 */
+	if (strstr(triple, "aarch64"))
+		*ctx = LLVMCreateDisasmCPUFeatures(triple, "", "+all",
+						   NULL, 0, NULL,
+						   symbol_lookup_callback);
+	else
+		*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL,
+					symbol_lookup_callback);
 	LLVMDisposeMessage(triple);
 
 	if (!*ctx) {

base-commit: 6dd780f973816133f189efec04118c1e6b1b443d
-- 
2.47.3

