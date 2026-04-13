Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF3386568;
	Mon, 13 Apr 2026 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104961; cv=none; b=iomYrxcTFwdPn5VaE5ayYwXX3rro4ZQ7WJ4HjSzl7uYDaDtC9VmiUhk91psScg6iZYvCJRFoBfU+UszFqQVIBJ/Nc6LEqfqATM6Rv6new7FcSWrpjsfn+YAspGykoK15YD/jozVSp1/JJtf+QXLtWm4we0xok5AsyB9D8tGhfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104961; c=relaxed/simple;
	bh=C3KSUrt0pBx1xyZoYOhbOvRg22YYGyMtepsdmFRljXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NX/o+e/BWSV87ljx/AcqHf3ckbfCsL2fC7igx6VkT2fMee7RDsOinoI3/+nPBx2GMLwBqk8ZOyYr/5UpQxmL08sleEx96TqRQWkFe1pSzZhWCuYv7X/xUaOXcytRgY9u8fIkrlfUNcv4quKSRVwCvFqcfcHsX3gC8FrTACIi5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=plX1wAia; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="plX1wAia"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3E267C5B1AF;
	Mon, 13 Apr 2026 18:29:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A00C5FFB9;
	Mon, 13 Apr 2026 18:29:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9615210450503;
	Mon, 13 Apr 2026 20:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776104956; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lEqpkfSG4bvQgxtPI4x8t4f5ElxNEGTXzPOFRzqjwCY=;
	b=plX1wAiahNNvYLrmKHyngjgbUZTsjXMi0XkNrQqatZIZfwi5y+MpfMYnpaPSrFPPIx5z1o
	DjTmJalfQiDo3KOvAbGJ1qE8SiwJJI0z30hz7Hh1mg2vocPtrjUgfmRmqgaiTA1AVxu05f
	TSmPLflLKUoX/QhZnH3X4nY86J0jvLHmL8Prsn2b5oH9X82bb0dFnuzoVhoZEXNtsuu8LG
	RYUj2X6gdbavH0vUvSLXR3PcQcqHbq/u/pQ6CScqPoDPnGCm0BxblVPKU5DjB93iCZrcYO
	uXojuVumNxIojmUJCrrBnPbAjhBsiAlqNEnuhQUM5TcX823OQvFjhzlelwNoqg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 13 Apr 2026 20:28:45 +0200
Subject: [PATCH RFC bpf-next 5/8] bpf, x86: emit KASAN checks into x86
 JITed programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-kasan-v1-5-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
In-Reply-To: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3

Insert KASAN shadow memory checks before memory load and store
operations in JIT-compiled BPF programs. This helps detect memory safety
bugs such as use-after-free and out-of-bounds accesses at runtime.

The main instructions being targeted are BPF_LDX and BPF_STX, but not
all of them are being instrumented:
- if the load/store instruction is in fact accessing the program stack,
  emit_kasan_check silently skips the instrumentation, as we already
  have page guards to monitor stack accesses. Stack accesses _could_ be
  monitored more finely by adding kasan checks, but it would need JIT
  compiler to insert red zones around any variable on stack, and we likely
  do not have enough info in JIT compiler to do so.
- if the load/store instruction is a BPF_PROBE_MEM or a BPF_PROBE_ATOMIC
  instruction, we do not instrument it, as the passed address can fault
  (hence the custom fault management with BPF_PROBE_XXX instructions),
  and so the corresponding kasan check could fault as well.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
This RFC also ignores for now atomic operations, because I am not
perfectly clear yet about how they are JITed and so how much kasan
instrumentation is legitimate here.
---
 arch/x86/net/bpf_jit_comp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b90103bd0080..111fe1d55121 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1811,6 +1811,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		const s32 imm32 = insn->imm;
 		u32 dst_reg = insn->dst_reg;
 		u32 src_reg = insn->src_reg;
+		bool accesses_stack;
 		u8 b2 = 0, b3 = 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
@@ -1831,6 +1832,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			EMIT_ENDBR();
 
 		ip = image + addrs[i - 1] + (prog - temp);
+		accesses_stack = bpf_insn_accesses_stack(env, bpf_prog, i - 1);
 
 		switch (insn->code) {
 			/* ALU */
@@ -2242,6 +2244,11 @@ st:			if (is_imm8(insn->off))
 		case BPF_STX | BPF_MEM | BPF_H:
 		case BPF_STX | BPF_MEM | BPF_W:
 		case BPF_STX | BPF_MEM | BPF_DW:
+			err = emit_kasan_check(&prog, dst_reg, insn,
+					       image + addrs[i - 1],
+					       accesses_stack);
+			if (err)
+				return err;
 			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			break;
 
@@ -2390,6 +2397,12 @@ st:			if (is_imm8(insn->off))
 				/* populate jmp_offset for JAE above to jump to start_of_ldx */
 				start_of_ldx = prog;
 				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
+			} else {
+				err = emit_kasan_check(&prog, src_reg, insn,
+						       image + addrs[i - 1],
+						       accesses_stack);
+				if (err)
+					return err;
 			}
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
 			    BPF_MODE(insn->code) == BPF_MEMSX)

-- 
2.53.0

