Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93828250C06
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268107; cv=none; b=UCm8SSKdYocfUyZ2Rbdu257FA8mFBr+X1BaWd1COpdfXL+KQcD7xWbLa6Yrhgz5x4o3d8l10D1pCZOAL4Fh987eRVrgl0ymzKi4m/ALTdNHk+5Gi3qirSLzBTODe2InpWIg7tGVbu36cWhX431/1Qh6YskK/QyM43y2XM9/5V00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268107; c=relaxed/simple;
	bh=IXYCnmF0x03ouehniGmIqAcs4TOSlYSV3KvZIyNVMSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGh5kfkEFSxqw2dfZovvH581didAlRmZfVrTyoWWa8TfYp4FIQPt0lnvF7QAiqoCD6dKCun0N3SjbG3fFsXuv7ckTrt27P/9OfoG/HdmHhoewnWT5+UYKLrZEvFHWkewjzMVEzYIrSMG0gI8nSHqS15aLsyKsZ0KuniFsKzA3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0iq+ngO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0iq+ngO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BAAC4CEF7;
	Wed, 11 Mar 2026 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773268107;
	bh=IXYCnmF0x03ouehniGmIqAcs4TOSlYSV3KvZIyNVMSc=;
	h=From:To:Cc:Subject:Date:From;
	b=O0iq+ngO1if/Ka6+WXBviOFZksjmK5+ov4fP4CJLgZwtNc14frMd+T4pFuFpFbHE1
	 S6hSVWRbgRPHKxT8GX8RiGBdm1XpXchZQnRhmk6MHGAuIdCkRgr42w6fMyEzMoLMJ7
	 8FXZ54MwU8cjCogg2tALUhug6JRc85ZHumZx7A0FDDWeBHx2jPgYs/+TZjhv7AND/R
	 rzwqEXV3hzJz+g/5NbMeUJko5urKT9dMqTaRHOddX9wJLHWsicUdXzsW1bfHStESrD
	 rtkbaM27LMxHjCF4EvdqYqEc28eDE/asUwdgU9XxKr6EEPLRX+3qLiqZUZ5iiotxFb
	 iWAFT6cLS4+8A==
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
	kernel-team@meta.com,
	Yonghong Song <yonghong.song@linux.dev>,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v3] bpftool: Enable aarch64 ISA extensions for JIT disassembly
Date: Wed, 11 Mar 2026 15:26:05 -0700
Message-ID: <20260311222608.521549-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
---
Changelog:
v2: https://lore.kernel.org/all/20260310223456.1706712-1-puranjay@kernel.org/
Chnages in v3:
- Fix bug in usage of strncmp() (AI)
v1: https://lore.kernel.org/all/20260306163906.2870529-1-puranjay@kernel.org/
Changes in v2:
- Fix coding style issue (Quentin)
- Use strncmp() in place of strstr() for detecting aarch64 in triple. (Quentin)
---
 tools/bpf/bpftool/jit_disasm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 8895b4e1f690..04541155e9cc 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -93,7 +93,16 @@ init_context(disasm_ctx_t *ctx, const char *arch,
 		p_err("Failed to retrieve triple");
 		return -1;
 	}
-	*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
+
+	/*
+	 * Enable all aarch64 ISA extensions so the disassembler can handle any
+	 * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics).
+	 */
+	if (!strncmp(triple, "aarch64", 7))
+		*ctx = LLVMCreateDisasmCPUFeatures(triple, "", "+all", NULL, 0, NULL,
+						   symbol_lookup_callback);
+	else
+		*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
 	LLVMDisposeMessage(triple);
 
 	if (!*ctx) {

base-commit: ca0f39a369c5f927c3d004e63a5a778b08a9df94
-- 
2.52.0

