Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF52D9EFF
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182126; cv=none; b=BXatqlljVLVyLO0A/1gbfUlHmdjyzvUi4WrHOJoVuQNis1dsUDpUaw0fRDFmpl5uGyeG7dbyJ90ZcAaHUAluEzwGUYkgacSPtEPDPcx8nj2SAB+TISPA2gqoyaRHe+OEh+7bmymv/5zTIVuwJCJeC3ukGjA0Ck3RzzKF/NyKMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182126; c=relaxed/simple;
	bh=rSkKCc2BUtxtw9715hKpLw2JpRbbxFlizMTvGXm9vX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIZja3vqvdxoR8JDwyXMcmvUqg1IBqXor5SG5RBqrKEtManAS6W8EgBhhVzJPOU6Ysjr/K8BuvblMzH7NHNJgtAnSVidcu/bbzlNd+Y1G8GILcwGdndGNPD3oVpLvKfs7/nQoZUWlocAqAuoqKyplS4ge5852tx0BEbxiwv3cqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKuEaZr8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKuEaZr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B699C19423;
	Tue, 10 Mar 2026 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773182126;
	bh=rSkKCc2BUtxtw9715hKpLw2JpRbbxFlizMTvGXm9vX8=;
	h=From:To:Cc:Subject:Date:From;
	b=bKuEaZr84a734A4sK/WTu6LqC0x3769FXwcm3EBPvtH2BgyWBT+dl2mMcIWJlYK4Z
	 noja7fCBVUdMo6C32Za4piN9KV1E0BHRn7PpBp+dWOPM29nNfZcXOYESCc+eAUIa82
	 cxajO6GbyEDEbPNCuotyuVwCgVjSZG8ch8xIsh4bTnQ9yQg0LtTvv7kDurRWz2sIio
	 9puzavj8Pw4ofIroF32kej7kxgjcFY7KReXFV2mcC98ESx/Utpr5f+NqUUnpVoQEVC
	 9kMcGDinjFGS3eJ3pXqhTMum09Yg4i8IxTDT1wS3vc4zLDUGHrVefaO0drhadM95ac
	 fvZxWRmiFbRhA==
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
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v2] bpftool: Enable aarch64 ISA extensions for JIT disassembly
Date: Tue, 10 Mar 2026 15:34:54 -0700
Message-ID: <20260310223456.1706712-1-puranjay@kernel.org>
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
---
Changelog:
v1: https://lore.kernel.org/all/20260306163906.2870529-1-puranjay@kernel.org/
Changes in v2:
- Fix coding style issue (Quentin)
- Use strncmp() in place of strstr() for detecting aarch64 in triple. (Quentin)
---
 tools/bpf/bpftool/jit_disasm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 8895b4e1f690..6063fdcce6bd 100644
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
+	if (strncmp(triple, "aarch64", 7))
+		*ctx = LLVMCreateDisasmCPUFeatures(triple, "", "+all", NULL, 0, NULL,
+						   symbol_lookup_callback);
+	else
+		*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
 	LLVMDisposeMessage(triple);
 
 	if (!*ctx) {

base-commit: 0c55d4817aff454cfaded4f161ab13f2049758a9
-- 
2.52.0

