Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E0E4A2058
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210154; cv=none; b=sgznFdjaqnvQk3JM9vBshEfr15NCJ8kimnphIZLWo5AxnoEd+HnBjLkFuREnG0VlkZiupgXNq0FCP9m2dJzz6gVdxoCRlCNFV+rukG1l9oxKd2dflVzwMOYG9LnXFdAy67VTshLbtHVsS1Fn2Ol1Rl/HIQQkMoTU3ghdr3NJGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210154; c=relaxed/simple;
	bh=HGySkkqkcUB5ZsEbCbFXGPiIwtoi51qtiiXjK4UZ22c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X53qxL4LhyICteW/QNyi5mCI++xtAad6WeLasv3BGjNZaJUS5n+yAEervAfaOEvaT4uP/1AekVgrbgCgalBi6pYPbs7qPo6PFg/ZmLwfnvMpfqOx7s5rmR6bFJA+zKZhCv29K7cTlw/O+13zGEGBUQLf0MnE6a1k9SG+u4tYvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aicL9xN3; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aicL9xN3"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso12930045e9.3
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791210145; x=1791814945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vcd5l84Bv4wvuYRs0EIOYmiHfU0ix2FZOVrqGnFtaW0=;
        b=aicL9xN3RPQUzHAq0SQkLNvIrhbqTkMVuS+El9QtWzxVX2SbBKXXZMgsKHzdM2lLzi
         uGKx8iLvXZ+VpH7okN7EnE2bnc64FjRK8JL/KvhGBFVTz5zdeS/4UftH+Lg1axZrnkjc
         j6Xyhhl3K3pkf8GKEHnBpePa1qPnUDgAxjeF/oHwMcMQWCid3zwe+eR4u76B3UQ4UVrd
         uTZ9CumXO9fjBPHZp2pjDqpVKD+wv5wf+bPKfNuTh4Cn3dBkmVXAqcKyY6gFS7VBJbFM
         pM+yqzplxp1Ns4O/zDbw8hoGu19BYFFwXB7uVeng6eLfX2n6tSb2NdW3Zzyoulsrn/lk
         9ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791210145; x=1791814945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vcd5l84Bv4wvuYRs0EIOYmiHfU0ix2FZOVrqGnFtaW0=;
        b=sZ15xfz1rTRNFs30x5KpnENBzqdhHIaU48EA/gsSPgS5UbxELeVa9/hBQI80QhluyT
         uc89AGMGUuRsZl/yB52u9PUTl1y6po8BQbZLNpXs+p7Rg9W7NRMPBkNWIrss0oS8wVgO
         uEpTDuPiTPHPg2kX6jPVFu3AUokLMjDCtxZLCBkOUzMOVpr52rpm5yHv5HcQR38SVvFu
         DDOl27aUw2Z2F7r9fxBu9ad0o1jPQr4smCDXJ6aQawtr31WcovGFPyHk2Vx3PZFxL/8A
         05POxHQ+Ab2WUfnnMA/P6Vl0Tl8l0xAc3So32Qg3ByVHkgT40OuPsBAnocad+zAiZs99
         Jscw==
X-Gm-Message-State: AFuF++n1ByjuNb5/jEBxTYR1AMBTugqNKHcSSOD37ZTM0YrCwbEY2bMn
	KcL0TQALLn7TqEHQnDnJaRSAEVq70xLyCpCUPxUeJP8WQzxc62GBOc1GVj9l5u3PuV1cOsOC
X-Gm-Gg: AYBFou3MUlBdPxseX2pX4OJ7wYoDrIh/hzz/0PmcQrt124ry+6Bd/2jso3l1XWZNWtE
	my9AhkWESR7Wi8LA4o2mxG78qf+DGs0lJdbba+YEsxdbuHEVrXL+MuKbCfYEBoy2cbOAb67YRC+
	FoqyMv2JuVcvg2sOM1s5h4BMWjG9fEDIjl1YA+EDgdOgQVtUU9LIUc0k/oVnTxfRNq2n2mxEPe8
	AM9yTwa1pOcX8w9p5DsjmVuzO2B3RLFyhiAdSbVthoYAHGP4N5XkmW9kOjJYL/KNc8soQmo66vQ
	NxQZGv/B5ZS1wdzOnGW3aDAQyxUBauS06Rzgmu8N79OMtVLUXx/bui+fZM3c5KkoG+m5rT0sfPH
	tNog6UiV3iuRMl8AXzMEb/gTZX1v9BxhED+PTKO8EO64dS8xIeGxcV8KjXfdTjSsagM1LSHO1kv
	Grj1nb5Z5sh/3mCfzLIBQ5/NYSrtcJyMFfhCMOS52b5pKGS2is3Em7Vt/qHtvMNVMgt5ZuLhBdy
	7Dweu0L3T2ABDvJXZNweeA+U6qd34/ZVSuUMok45oS6irqQFRVH6DP5jEiFN8WE/d8qBD3ukEDj
	UVDgvZKza3TuAV2JXL0O58V/gj2XL4ImWhYcPw==
X-Received: by 2002:a05:600c:3510:b0:49f:ff32:803c with SMTP id 5b1f17b1804b1-4a02758653cmr173182795e9.16.1791210145095;
        Mon, 05 Oct 2026 07:22:25 -0700 (PDT)
Received: from macbook (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622ab5a1sm3881623f8f.36.2026.10.05.07.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:22:24 -0700 (PDT)
From: Yusheng Zheng <yunwei356@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Hao Sun <sunhao.th@gmail.com>,
	Yusheng Zheng <yunwei356@gmail.com>
Subject: [RFC PATCH bpf-next 3/7] bpf, x86: Inline native code for kfuncs that have a body
Date: Mon,  5 Oct 2026 07:22:15 -0700
Message-ID: <20261005142219.33451-4-yunwei356@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20261005142219.33451-1-yunwei356@gmail.com>
References: <20261005142219.33451-1-yunwei356@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bpf_jit_inline_kfunc() for x86-64. The native code for a call
comes from the emit callback of the kfunc's body, which gets the x86
registers that the operands are bound to and the values of the constant
arguments. Without a callback, when it returns an error, or when the
constant arguments differ between paths, the JIT copies the code that
the compiler produced for the kfunc, as was suggested for the bitops
kfuncs [1], with the registers of R0-R5 renamed. Only straight-line
moves, ALU instructions, cmovcc, bswap, prefetch and lea up to the
return are copied: no control flow, rip-relative addressing or
division, no registers but those of R0-R5, r10 and r11, and no implicit
operand, such as %rax in "and $imm, %eax", in a renamed register.
Otherwise the body stays. Copying needs the instruction decoder.

The JIT has no code for any particular kfunc.

[1] https://lore.kernel.org/bpf/CAADnVQLNmQGKf5S5ZNwHYzScYBhnWFmnzLg=5Xxy4SgYKE3EfQ@mail.gmail.com/

Assisted-by: LLM
Signed-off-by: Yusheng Zheng <yunwei356@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 181 ++++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 083fcd6cf15b7..6a57109caa97a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -15,8 +15,12 @@
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <linux/execmem.h>
+#include <linux/kallsyms.h>
+#include <linux/uaccess.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
@@ -2000,6 +2004,174 @@ static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
 	return prog - start;
 }
 
+/*
+ * Registers that copied kfunc code may use: those of R0-R5, which hold the
+ * arguments and the result as for a call, and the scratch registers r10 and
+ * r11. r9 can hold the private frame pointer.
+ */
+#define KFUNC_COPY_REGS	(BIT(0) | BIT(1) | BIT(2) | BIT(6) | BIT(7) | BIT(8) | \
+			 BIT(10) | BIT(11))
+
+/*
+ * Write an instruction of a compiled kfunc with the registers of R0-R5
+ * renamed by @map to those that the verifier bound them to. It must be a
+ * move, ALU or address computation without control flow, prefixes other than
+ * operand size, rip-relative addressing or registers other than
+ * KFUNC_COPY_REGS, and no division, which can trap.
+ */
+static u8 *kfunc_copy_insn(u8 *p, const struct insn *insn, const u8 *c, const u8 *map)
+{
+	u8 op = insn->opcode.bytes[insn->opcode.nbytes - 1], rex = insn->rex_prefix.bytes[0];
+	u8 modrm = insn->modrm.value, sib = insn->sib.value, ext = X86_MODRM_REG(modrm);
+	u8 mod = X86_MODRM_MOD(modrm), reg = ext, rm = 0, idx = 4;
+	bool two = insn->opcode.nbytes == 2, group, opreg, disp8, implicit;
+	u16 regs = 0;
+	int head;
+
+	if (insn->vex_prefix.nbytes || insn->opcode.nbytes > 2 || insn->prefixes.nbytes > 1 ||
+	    (insn->prefixes.nbytes && insn->prefixes.bytes[0] != 0x66))
+		return NULL;
+	if (two) {
+		/* cmovcc, imul, movzx/movsx of words, bswap, prefetch */
+		group = op == 0x18;
+		if ((op & 0xf0) != 0x40 && op != 0xaf && op != 0xb7 && op != 0xbf &&
+		    (op & 0xf8) != 0xc8 && !(group && ext < 4))
+			return NULL;
+	} else {
+		/* add, or, and, sub, xor, cmp, mov, lea, test, imul, shifts, not, neg, mul */
+		group = op == 0x81 || op == 0x83 || op == 0xc1 || op == 0xc7 ||
+			op == 0xd1 || op == 0xd3 || op == 0xf7;
+		if (!(op < 0x40 && (op & 0xf0) != 0x10 && (op & 7) % 2 && (op & 7) < 6) &&
+		    op != 0x63 && op != 0x69 && op != 0x6b && op != 0x85 && op != 0x89 &&
+		    op != 0x8b && op != 0x8d && op != 0x98 && op != 0x99 && op != 0xa9 &&
+		    (op & 0xf8) != 0xb8 &&
+		    !(group && op != 0xc7 && op != 0xf7 && ext != 2 && ext != 3) &&
+		    !(op == 0xc7 && !ext) && !(op == 0xf7 && ext != 1 && ext < 6))
+			return NULL;
+	}
+
+	/* uses %rax, %rcx or %rdx without naming it, as in "and $imm, %eax" */
+	implicit = !two && ((op < 0x40 && (op & 7) == 5) || op == 0x98 || op == 0x99 ||
+			    op == 0xa9 || op == 0xd3 || (op == 0xf7 && (ext == 4 || ext == 5)));
+
+	opreg = (op & 0xf8) == (two ? 0xc8 : 0xb8);
+	if (opreg)
+		rm = (op & 7) + (X86_REX_B(rex) ? 8 : 0);
+	if (insn->modrm.nbytes) {
+		reg = group ? ext : ext + (X86_REX_R(rex) ? 8 : 0);
+		rm = (insn->sib.nbytes ? X86_SIB_BASE(sib) : X86_MODRM_RM(modrm)) +
+		     (X86_REX_B(rex) ? 8 : 0);
+		if (insn->sib.nbytes)
+			idx = X86_SIB_INDEX(sib) + (X86_REX_X(rex) ? 8 : 0);
+		/* rip-relative or absolute */
+		if (!mod && (rm & 7) == 5)
+			return NULL;
+		regs = (group ? 0 : BIT(reg)) | (idx != 4 ? BIT(idx) : 0);
+	}
+	if ((regs | (opreg || insn->modrm.nbytes ? BIT(rm) : 0)) & ~KFUNC_COPY_REGS)
+		return NULL;
+	/* which cannot be renamed, so they must hold their operands as for a call */
+	if (implicit && (map[0] != 0 || map[1] != 1 || map[2] != 2))
+		return NULL;
+
+	/* the instruction again, with the registers renamed */
+	if (!group)
+		reg = map[reg];
+	rm = map[rm];
+	idx = idx != 4 ? map[idx] : 4;
+	if (insn->prefixes.nbytes)
+		*p++ = 0x66;
+	rex = 0x40 | X86_REX_W(rex) | (reg & 8 ? 4 : 0) | (idx & 8 ? 2 : 0) | (rm & 8 ? 1 : 0);
+	if (rex != 0x40)
+		*p++ = rex;
+	if (two)
+		*p++ = 0x0f;
+	*p++ = opreg ? (op & 0xf8) | (rm & 7) : op;
+	if (insn->modrm.nbytes) {
+		/* a base of r13 needs a displacement */
+		disp8 = !mod && (rm & 7) == 5;
+		*p++ = (disp8 ? 1 : mod) << 6 | (reg & 7) << 3 | (insn->sib.nbytes ? 4 : rm & 7);
+		if (insn->sib.nbytes)
+			*p++ = (sib & 0xc0) | (idx & 7) << 3 | (rm & 7);
+		if (disp8)
+			*p++ = 0;
+	}
+	head = insn->prefixes.nbytes + insn->rex_prefix.nbytes + insn->opcode.nbytes +
+	       insn->modrm.nbytes + insn->sib.nbytes;
+	memcpy(p, c + head, insn->length - head);
+	return p + insn->length - head;
+}
+
+/*
+ * Copy the compiled kfunc of an inlined call up to its return, without the
+ * ENDBR and NOPs at its entry, with the operands renamed by @map.
+ */
+static int kfunc_copy(const struct bpf_kfunc_inline *in, const u8 *map, u8 *buf)
+{
+	u8 code[BPF_KFUNC_INLINE_MAX + MAX_INSN_SIZE], *c, *p = buf;
+	unsigned long size, off, ret;
+	struct insn insn;
+	int pos;
+
+	if (!kallsyms_lookup_size_offset(in->addr, &size, &off) || off)
+		return -EINVAL;
+	size = min(size, sizeof(code));
+	if (copy_from_kernel_nofault(code, (void *)in->addr, size))
+		return -EFAULT;
+	for (pos = 0; pos < size; pos += insn.length) {
+		if (insn_decode(&insn, code + pos, size - pos, INSN_MODE_64))
+			return -EINVAL;
+		c = code + pos;
+		/* ret, or a jump to the return thunk */
+		ret = in->addr + pos + insn.length + insn.immediate.value;
+		if ((insn.length == 1 && c[0] == 0xc3) ||
+		    (c[0] == 0xe9 && (ret == (unsigned long)x86_return_thunk ||
+				      ret == (unsigned long)__x86_return_thunk)))
+			return p > buf ? p - buf : -EINVAL;
+		if ((insn.length == 4 && is_endbr((u32 *)c)) || insn_is_nop(&insn))
+			continue;
+		if (insn_is_rex2(&insn))
+			return -EINVAL;
+		/* renaming adds at most a REX prefix and a displacement */
+		if (p - buf + insn.length + 2 > BPF_KFUNC_INLINE_MAX)
+			return -E2BIG;
+		p = kfunc_copy_insn(p, &insn, c, map);
+		if (!p)
+			return -EINVAL;
+	}
+	return -EINVAL;
+}
+
+static u8 x86_reg(u32 reg)
+{
+	return reg2hex[reg] + (is_ereg(reg) ? 8 : 0);
+}
+
+/*
+ * Get native code for an inlined kfunc call, with the operands in the x86
+ * registers that the verifier bound them to: the code from the emit callback
+ * of the kfunc's body, or else a copy of the compiled kfunc.
+ */
+int bpf_jit_inline_kfunc(const struct bpf_kfunc_inline *in, u8 *buf)
+{
+	u8 reg[MAX_BPF_FUNC_REG_ARGS + 1], map[16];
+	int i, len;
+
+	for (i = 0; i < ARRAY_SIZE(map); i++)
+		map[i] = i;
+	for (i = BPF_REG_0; i <= BPF_REG_5; i++) {
+		reg[i] = x86_reg(in->reg[i]);
+		map[x86_reg(i)] = reg[i];
+	}
+	/* copying needs the instruction decoder */
+	if (in->copy && IS_ENABLED(CONFIG_INSTRUCTION_DECODER))
+		return kfunc_copy(in, map, buf);
+	if (in->copy || !in->body->emit)
+		return -EOPNOTSUPP;
+	len = in->body->emit(reg, in->imm, buf);
+	return len > 0 && len <= BPF_KFUNC_INLINE_MAX ? len : -EINVAL;
+}
+
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -2952,6 +3124,15 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			if (!imm32)
 				return -EINVAL;
 			if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
+				const struct bpf_kfunc_inline *in;
+
+				/* an inlined kfunc call gets its native code */
+				in = bpf_kfunc_native(env, insn_idx);
+				if (in) {
+					memcpy(prog, in->image, in->image_len);
+					prog += in->image_len;
+					break;
+				}
 				fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
 				if (!fm)
 					return -EINVAL;
-- 
2.51.1

