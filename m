Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AC02EBB89
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854592; cv=none; b=As5mn8ZjA+3rg0wRrQ5tHiAwHspGE32eNXGFoG+eqMkKKor+O6mnNYkEng0stYcHy7/WLYhHzkfeLXXMvI+UpmbtrxXgChIeoPeM10VD9HON1QL7b7uW5a2rY0eAuN1PzmWulYYH/NDeDusngiG/GUJ0+vUBqzv1gpxCd0EbGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854592; c=relaxed/simple;
	bh=NattizI9biQ+H6K0c3KgYHGTl095kjkWr8uUxkY6wFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uyWhaS7BhzwK8ycg2zTbFgQ6TqqP9O+8x//uksy0MLx2cNarX6LOzM77v6MLY6gGRDr3Qqc01skOrCxl1bK12ooxJfkqVXXQwHPeWIOqbuU373gClao73tNdDBWKKLilfxZ/Pv4f0ajiZZ99PN8txM2488bTL5B0beIHpkaUxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJkxbu7h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJkxbu7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46867C19421;
	Wed, 18 Mar 2026 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773854592;
	bh=NattizI9biQ+H6K0c3KgYHGTl095kjkWr8uUxkY6wFI=;
	h=From:To:Cc:Subject:Date:From;
	b=AJkxbu7h3e+kmQOp5GaO9Ijzn/83nNMGNbfLjDFS6GgIqP5qXCkXikA+YijdXdD70
	 FYvGyPs31NXqn9KDl07xVsj5huRxifI7Hv6YF7jXhotK7Jf4pCzoGxAxKurSrDLCx+
	 HcAS5NJghnlls7a3zYIQOlAXXla/NifLZ7eQkQ02Hn3fM2MmxnIygYjtsKT7GBE3J5
	 rPDwAeYOw2daBztMskmyb0TkobLeN98AOodrlbk6DD7YM5N68A+xfO5NNtGig3YhWJ
	 TJNG7YvHZ4zCEx9pw/SGeGf6aI5u5M2M1O5UODHD8btFCIoTjpBnqEK6S8N2is/ACR
	 ywah+mu85NqwA==
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
Subject: [PATCH bpf-next v4] bpftool: Enable aarch64 ISA extensions for JIT disassembly
Date: Wed, 18 Mar 2026 10:22:57 -0700
Message-ID: <20260318172259.2882792-1-puranjay@kernel.org>
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
Acked-by: Quentin Monnet <qmo@kernel.org>
---
Changelog:
v3: https://lore.kernel.org/all/20260311222608.521549-1-puranjay@kernel.org/
Changes in v4:
- Add acked by Quentin
- Rebased on bpf-next/master
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

base-commit: 77378dabb50f593c756d393d8eacb0b91b758863
-- 
2.52.0

