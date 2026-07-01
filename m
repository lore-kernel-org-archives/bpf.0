Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E94071E2;
	Wed,  1 Jul 2026 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900221; cv=none; b=bJciXyhqnAiQV82FJTZ8I4a/7qXe3BHtETDVHop0D2W5nMlUDn10Ys6gwwPA5KFmTsS1rmjSvQQUEDOJWjzW4xaLdOfl5MsJWl4OgwtxKRdP5BpyKc2xOqWWF6nYo70yRnz98YfJJRG3VIVD9BAvS4ubzi5ogGh1C1hdBXX06qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900221; c=relaxed/simple;
	bh=jGZV7QQ8rGY/MrY2OW/6GaIB5LX3KW2+7YvRg2tY34I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPmGxea5JyUDQLGjSYCojBu1SeTfm+0gU/v8QqSUJblOioy7jmU3mPItvqvzOJ+/6xT/DiGM1a5jBrGXnqPxVJM+y9wYpHYidkH8z7uAy6OIMC3zSiBf4d4f2wfe1IByfEWeEEDDYxg9EINp1VLVuvSJo6umsXG/KrAjraUxkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ixIKYaiB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ixIKYaiB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 971521A0DB1;
	Wed,  1 Jul 2026 10:03:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6ABFE60288;
	Wed,  1 Jul 2026 10:03:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D142104C9B0F;
	Wed,  1 Jul 2026 12:03:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782900217; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O6olMhd58LedJgnlT/pXJ8soS/vMwllcEt4eUgi6fAQ=;
	b=ixIKYaiBQi/R1Lri5dwpZ0nyOMqWPqrrbM7GD2VtfFVHCB6FeSBT7EtKzYtiJ7+pTfTgcc
	Cq5UH90hqvB1S1xoR45QFznRmzES2/1OcxTZJKtSxq5P/2Li6R7DPyg0bNYS62jB0P3C2o
	09YtV8Eidf6/+BbuI+a5jFPUuzCoXGHhvATpKwB2lpZkaz2zhnaJ0MpmCtkNwTIWBVuRxW
	TlHs89w8bsa+R3llfZK2zEHtHFrikWdT/NrcQPz707O1cdmpT3/ui15FZDGe6TPvxeJEtN
	6fQZpvpEogRo2HJDgS49u2vyfkqlJ22LX3SuVN2UblaW0Ztg8qkXYgQSvtVNVA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 01 Jul 2026 12:02:52 +0200
Subject: [PATCH bpf-next v3 04/10] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-kasan-v3-4-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
In-Reply-To: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
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
  affected program. Theoretically, r10 and r11 should be saved as well,
  but the number of called function and their scope being limited, they
  are skipped for the sake of reducing the overhead
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
Changes in v3:
- skip kasan instrumentation if there is no verifier env (cBPF)
- move helper up in the file

Changes in v2:
- move asan functions declaration directly into jit compiler, and guard
  them with IS_ENABLED
- remove faulty stack alignment, no arg is passed to kasan funcs on the
  stack anyway
- make sure to emit call depth accounting code
- do not save unneeded registers
- update helper signature to let caller configure some values (eg:
  is_write)
---
 arch/x86/net/bpf_jit_comp.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 054e043ffcd2..68c5f9f94e5e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -21,6 +21,17 @@
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
+#endif
+
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
@@ -1110,6 +1121,90 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)
 	*pprog = prog;
 }
 
+static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
+			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
+			    bool is_write, bool accesses_stack_only)
+{
+#ifdef CONFIG_BPF_JIT_KASAN
+	u32 bpf_size = BPF_SIZE(insn->code);
+	s32 off = insn->off;
+	u8 *prog = *pprog;
+	void *kasan_func;
+
+	if (!env)
+		return 0;
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
 /* LDX: dst_reg = *(u8*)(src_reg + off) */
 static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {

-- 
2.54.0

