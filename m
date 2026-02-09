Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E437FF60
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652785; cv=none; b=bZ/bHFv+y80fcISwGg0U2yQiZ9UF4Qe08SGs8/K15aN4FqO2UlGjbXkb9K9vuA2KA1R38DAjhjzdwy6LsRCzfT09+dRUYFFS1Ok76P/KMHqUiMxEuytkhMjxYFP31nBJlQdfAsO85lE0NlWIkoiDsrR34J8y8Dud1gcC5xNoBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652785; c=relaxed/simple;
	bh=F61Hu50xD2sdfh3O8y4gfK6WPDizuEx5rjh5PRK3e0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evn1/J0i8m1teErdZ0xZkljZ+ggRx/W5nyj2qLCz8JskPWldMhSXPT7bzmu3jRnxEPpQ0drJkaVYBlKAacYaWzNd5S7fGjOqYpNGDYDWv+B09VmFTtWPWrW0jYviYXzEhsZ0/cNziQt65YTPRl1MWuZ8p9lFn23JyGJ4izNmK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pn32hGCw; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pn32hGCw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770652782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=et+YdrHD/kIFIylPe4F2BCtZ/VXjygnH1F+PyE83QhE=;
	b=Pn32hGCwtZONpSBtplRDW9qK/BjXjSeHH2UbBHUJJ0lgoE6LMl/2/xdcKV6IzaZXkxnURk
	DfhlMxHwvE6CcX+14Mv/+bB0R3t6d1gM4kg/+lIZDGJUiJ0b7kXq+kLUnP8fYu47B8WUNv
	Vq1BZvx5bJAwJXfLnwVW2dBpn9yqDcg=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 2/4] bpf, x86: Add 64bit bitops kfuncs support for x86_64
Date: Mon,  9 Feb 2026 23:59:13 +0800
Message-ID: <20260209155919.19015-3-leon.hwang@linux.dev>
In-Reply-To: <20260209155919.19015-1-leon.hwang@linux.dev>
References: <20260209155919.19015-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement JIT inlining of the 64bit bitops kfuncs on x86_64.

bpf_rol64() and bpf_ror64() are always supported via ROL/ROR.

bpf_clz64(), bpf_ctz64(), bpf_ffs64(), and bpf_fls64() are supported
when the CPU has X86_FEATURE_ABM (LZCNT/TZCNT).

bpf_popcnt64() is supported when the CPU has X86_FEATURE_POPCNT.

bpf_bitrev64() is not supported as x86_64 has no native bit-reverse
instruction.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 153 ++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 070ba80e39d7..5d6215071cbd 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -19,6 +19,7 @@
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 #include <asm/cfi.h>
+#include <asm/cpufeatures.h>
 
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
@@ -1604,6 +1605,134 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
 	*pprog = prog;
 }
 
+static int emit_bitops(u8 **pprog, u32 bitops)
+{
+	u8 *prog = *pprog;
+
+	/*
+	 * x86 Bit manipulation instruction set
+	 * https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruction_set
+	 */
+
+	switch (bitops) {
+	case BPF_CLZ64:
+		/*
+		 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
+		 *
+		 *   LZCNT - Count the Number of Leading Zero Bits
+		 *
+		 *     Opcode/Instruction
+		 *     F3 REX.W 0F BD /r
+		 *     LZCNT r64, r/m64
+		 *
+		 *     Op/En
+		 *     RVM
+		 *
+		 *     64/32-bit Mode
+		 *     V/N.E.
+		 *
+		 *     CPUID Feature Flag
+		 *     LZCNT
+		 *
+		 *     Description
+		 *     Count the number of leading zero bits in r/m64, return
+		 *     result in r64.
+		 */
+		/* emit: x ? 64 - fls64(x) : 64 */
+		/* lzcnt rax, rdi */
+		EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
+		break;
+
+	case BPF_CTZ64:
+		/*
+		 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
+		 *
+		 *   TZCNT - Count the Number of Trailing Zero Bits
+		 *
+		 *     Opcode/Instruction
+		 *     F3 REX.W 0F BC /r
+		 *     TZCNT r64, r/m64
+		 *
+		 *     Op/En
+		 *     RVM
+		 *
+		 *     64/32-bit Mode
+		 *     V/N.E.
+		 *
+		 *     CPUID Feature Flag
+		 *     BMI1
+		 *
+		 *     Description
+		 *     Count the number of trailing zero bits in r/m64, return
+		 *     result in r64.
+		 */
+		/* emit: x ? __ffs64(x) : 64 */
+		/* tzcnt rax, rdi */
+		EMIT5(0xF3, 0x48, 0x0F, 0xBC, 0xC7);
+		break;
+
+	case BPF_FFS64:
+		/* emit: __ffs64(x), 'x == 0' was handled by verifier */
+		/* tzcnt rax, rdi */
+		EMIT5(0xF3, 0x48, 0x0F, 0xBC, 0xC7);
+		break;
+
+	case BPF_FLS64:
+		/* emit: fls64(x) */
+		/* lzcnt rax, rdi; neg rax; add rax, 64 */
+		EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
+		EMIT3(0x48, 0xF7, 0xD8);       /* neg rax */
+		EMIT4(0x48, 0x83, 0xC0, 0x40); /* add rax, 64 */
+		break;
+
+	case BPF_POPCNT64:
+		/*
+		 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
+		 *
+		 *   POPCNT - Return the Count of Number of Bits Set to 1
+		 *
+		 *     Opcode/Instruction
+		 *     F3 REX.W 0F B8 /r
+		 *     POPCNT r64, r/m64
+		 *
+		 *     Op/En
+		 *     RM
+		 *
+		 *     64 Mode
+		 *     Valid
+		 *
+		 *     Compat/Leg Mode
+		 *     N.E.
+		 *
+		 *     Description
+		 *     POPCNT on r/m64
+		 */
+		/* popcnt rax, rdi */
+		EMIT5(0xF3, 0x48, 0x0F, 0xB8, 0xC7);
+		break;
+
+	case BPF_ROL64:
+		/* emit: rol64(x, s) */
+		EMIT3(0x48, 0x89, 0xF1); /* mov rcx, rsi */
+		EMIT3(0x48, 0x89, 0xF8); /* mov rax, rdi */
+		EMIT3(0x48, 0xD3, 0xC0); /* rol rax, cl */
+		break;
+
+	case BPF_ROR64:
+		/* emit: ror64(x, s) */
+		EMIT3(0x48, 0x89, 0xF1); /* mov rcx, rsi */
+		EMIT3(0x48, 0x89, 0xF8); /* mov rax, rdi */
+		EMIT3(0x48, 0xD3, 0xC8); /* ror rax, cl */
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	*pprog = prog;
+	return 0;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
 #define __LOAD_TCC_PTR(off)			\
@@ -2113,6 +2242,12 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			}
 			break;
 
+		case BPF_ALU64 | BPF_BITOPS:
+			err = emit_bitops(&prog, insn->imm);
+			if (err)
+				return err;
+			break;
+
 			/* speculation barrier */
 		case BPF_ST | BPF_NOSPEC:
 			EMIT_LFENCE();
@@ -4117,3 +4252,21 @@ bool bpf_jit_supports_fsession(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_bitops(s32 imm)
+{
+	switch (imm) {
+	case BPF_CLZ64:
+	case BPF_CTZ64:
+	case BPF_FFS64:
+	case BPF_FLS64:
+		return boot_cpu_has(X86_FEATURE_ABM);
+	case BPF_POPCNT64:
+		return boot_cpu_has(X86_FEATURE_POPCNT);
+	case BPF_ROL64:
+	case BPF_ROR64:
+		return true;
+	default:
+		return false;
+	}
+}
-- 
2.52.0

