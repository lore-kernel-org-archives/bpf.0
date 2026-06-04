Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC063FB075;
	Thu,  4 Jun 2026 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604560; cv=none; b=J/S71vSC0m6X1lAkiCNowtnVq2sYj6Gxo/lausjsMGGHrl2R8M5fzCwrO9fmrDXII76wSmIm25tFrJufwqLRRWBkpyH1mJasT0yaBFdpZQLw7Xs3SJbI6L/phQwh6GG2a/j0kk0azcdxZzUxZGwzwv2L8FZl/hEOzNhwLXit1KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604560; c=relaxed/simple;
	bh=d70yGDy2a/ZDsF0eE0o36k1UjTfp/5kRIgMkTjoR0/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYFe7fi2ppY9iIr0zlTd3QZWq/NuJlqb4dSVDoYrcbvMXcne0gvxyKGjuAwzp08Ka5tTDLmKDalgtRPvkTi/kh4LZjrpDN4f/XHsbFFuS6/AcJSNpJgcMzLTM9T3Fkroz2WhHldPs4G6dJCZQgqFq6m6A6vayn2yCYhj0A1oo/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ew6G7Kqh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ew6G7Kqh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3344F4E406AC;
	Thu,  4 Jun 2026 20:22:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0635A5FED1;
	Thu,  4 Jun 2026 20:22:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3108D106A1D3D;
	Thu,  4 Jun 2026 22:22:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780604555; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=onobyqUpNxQD6/u3MqsXH18ymnmpWqQmDfG8EEUxqLc=;
	b=ew6G7KqhTvHYNtp8yVygJarlPlaU1vsp2QeUIk98VAjxLseyvgvyOuz6Wgj8h4OlRaPjbn
	VdBpElk0eUFDLzcuyO9b43etwltKoEEUjekbphiNWscK4R4l+fzLAtKNIKKz31MZbo7J7K
	2WdJ2ofGmoW00YAtGX/LA5n30J+9TpURm+MAhmrg7s61IoO/mvbb7PDWE2d7gZACq+89bq
	espnfaox5Tr1a/WaS82xLgMM+uuQYRqjePSrWpYC+EgOcNrm7mWbpRtSGEtjHbuBUcuuFZ
	j8yj9B9xjuMFKvWgaFcAH/iRmGe7GHaF7dUbOicoppl6+IXaYaZvG+l5NruraQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 04 Jun 2026 22:22:01 +0200
Subject: [PATCH bpf-next v2 3/8] bpf, x86: add helper to emit kasan checks
 in x86 JITed programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-kasan-v2-3-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
In-Reply-To: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Add the emit_kasan_check() function that emits KASAN shadow memory
checks before memory accesses in JIT-compiled BPF programs. The
implementation relies on the existing __asan_{load,store}X functions
from KASAN subsystem. The helper:
- ensures that the kasan instrumention is actually needed: if the
  instruction being processed accesses the program stack, we skip the
  instrumentation, as those accesses are already protected with page
  guards
- saves registers. This includes caller-saved registers, but also
  temporary registers, as those were possibly used by the
  affected program
- computes the accessed address and stores it in %rdi
- calls the relevant function, depending on the instruction being a load
  or a store, and the size of the access.
- restores registers

The special care needed when inserting this instrumentation comes at the
cost of a non negligeable increase in JITed code size. For example, a
bare

  mov 	0x0(%si),rbx # Load in rbx content at address stored in rsi

becomes

  push    %rax
  push    %rcx
  push    %rdx
  push    %rsi
  push    %rdi
  push    %r8
  push    %r9
  mov     %rsi,%rdi
  call    0xffffffff81da0a60 <__asan_load8>
  pop     %r9
  pop     %r8
  pop     %rdi
  pop     %rsi
  pop     %rdx
  pop     %rcx
  pop     %rax
  mov     0x0(%rsi),rbx

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- move asan functions declaration directly into jit compiler, and guard
  them with IS_ENABLED
- remove faulty stack alignment, no arg is passed to kasan funcs on the
  stack anyway
- make sure to emit call depth accounting code
- do not save unneeded registers
- update helper signature to let caller configure some values (eg:
  is_write)

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 arch/x86/net/bpf_jit_comp.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a0c541a441cf..0981791014eb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -21,6 +21,19 @@
 #include <asm/unwind.h>
 #include <asm/cfi.h>
 
+#if IS_ENABLED(CONFIG_BPF_JIT_KASAN)
+void __asan_load1(void *p);
+void __asan_store1(void *p);
+void __asan_load2(void *p);
+void __asan_store2(void *p);
+void __asan_load4(void *p);
+void __asan_store4(void *p);
+void __asan_load8(void *p);
+void __asan_store8(void *p);
+void __asan_load16(void *p);
+void __asan_store16(void *p);
+#endif
+
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
@@ -1330,6 +1343,86 @@ static void emit_store_stack_imm64(u8 **pprog, int reg, int stack_off, u64 imm64
 	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
 }
 
+static int emit_kasan_check(u8 **pprog, u32 addr_reg, struct bpf_insn *insn,
+			    u8 *ip, bool is_write, bool accesses_stack_only)
+{
+#ifdef CONFIG_BPF_JIT_KASAN
+	u32 bpf_size = BPF_SIZE(insn->code);
+	s32 off = insn->off;
+	u8 *prog = *pprog;
+	void *kasan_func;
+
+	if (accesses_stack_only)
+		return 0;
+
+	/* Derive KASAN check function from access type and size */
+	switch (bpf_size) {
+	case BPF_B:
+		kasan_func = is_write ? __asan_store1 : __asan_load1;
+		break;
+	case BPF_H:
+		kasan_func = is_write ? __asan_store2 : __asan_load2;
+		break;
+	case BPF_W:
+		kasan_func = is_write ? __asan_store4 : __asan_load4;
+		break;
+	case BPF_DW:
+		kasan_func = is_write ? __asan_store8 : __asan_load8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Save rax */
+	EMIT1(0x50);
+	/* Save rcx */
+	EMIT1(0x51);
+	/* Save rdx */
+	EMIT1(0x52);
+	/* Save rsi */
+	EMIT1(0x56);
+	/* Save rdi */
+	EMIT1(0x57);
+	/* Save r8 */
+	EMIT2(0x41, 0x50);
+	/* Save r9 */
+	EMIT2(0x41, 0x51);
+
+	/* mov rdi, addr_reg */
+	EMIT_mov(BPF_REG_1, addr_reg);
+
+	/* add rdi, off (if offset is non-zero) */
+	if (off) {
+		if (is_imm8(off)) {
+			/* add rdi, imm8 */
+			EMIT4(0x48, 0x83, 0xC7, (u8)off);
+		} else {
+			/* add rdi, imm32 */
+			EMIT3_off32(0x48, 0x81, 0xC7, off);
+		}
+	}
+
+	/* Adjust ip to account for the instrumentation generated so far */
+	ip += (prog - *pprog);
+	/* We emit a call, so update call depth counting */
+	ip += x86_call_depth_emit_accounting(&prog, kasan_func, ip);
+	/* call kasan_func */
+	if (emit_call(&prog, kasan_func, ip))
+		return -ERANGE;
+
+	EMIT2(0x41, 0x59);
+	EMIT2(0x41, 0x58);
+	EMIT1(0x5F);
+	EMIT1(0x5E);
+	EMIT1(0x5A);
+	EMIT1(0x59);
+	EMIT1(0x58);
+
+	*pprog = prog;
+#endif /* CONFIG_BPF_JIT_KASAN */
+	return 0;
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {

-- 
2.54.0

