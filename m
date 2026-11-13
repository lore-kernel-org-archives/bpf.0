Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546587;
	b=V5GqsZCT+Et42fhevhlorq9GlLlxHgpdzvRDEtK9dlVXkMWVOkuVhN6NZoEoIzUUzLhu
	 Xe8EwOAVksB6SMY0mXVG8fDz/1s2GiFxd4FaKFjlouGTpK9RbzEc5zXzDrSiAX/aevX6n
	 UVKCpT6Nf9VuReO/eDHZIH9BjNh/yK6R77iXI5yeHEL6peM2rv23EB8AMcGrq1nIupVtT
	 Q+LO6Isks4kpMVFc2jlnMj9HC7Ysf5Z8yLQtrh3pVnahMPdN4uEo1fA1dbtLtbTS5SV7G
	 RzeEN8HiS+AdrePEo1e4yQiVigUoRQzvaLUWWGPJDazhh+a3yRnNNPUlldNLEN7VzjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=edl+DLzgv803gXcZL9zN7F97e/O9QKLsm/OlVZ2e3Y4=;
	b=vE6L09ROjzjcMEgumZWTWHvTBgO+DBYU9mhv5H+DqE5CuA8szJyAjV8dUKfq/kYjghgN
	 igML6GVFcPumWNJKtHuwaF8gZiIqL+WvAWQlQyvleH6IUEPRCoxoXTDp3/Fs5sAiyA2mO
	 TCVbHZ+gWK0FqdyAJzz2n4Nuqh5+OipJ+8yYU8I94ygdGThUloUOGB9kTHYE0rsWDLFt5
	 pcrxo1uhaASBJEJbLlvEgjJSqlC8pZQ4B//YJ+HszxdSOWRf8/vcKGz86HG9bRzFR8XgE
	 VWs/d1rIiKVgL715Ql7Qi4S1dAP6bqnoNjXglcVZ27/xN1rSP45N6/jzvEyryHcS0Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mi6PuGIO;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A00606A323
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6A00606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mi6PuGIO
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so238400a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546586; x=1795151386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=edl+DLzgv803gXcZL9zN7F97e/O9QKLsm/OlVZ2e3Y4=;
        b=Mi6PuGIOQZQ2TDHWuYfBdk3+K5c7wqQsiGmIBOGQuXUnFMFgQCjqTSvTmt8SsRRdWs
         w88MuQ3jnHtbCwOEtO8YiZrX2wuljD8QAuGWAOjUecqSYMNYyE3m8BuTFSsYmM4A/IF6
         BWyHlJw4qSrnu1mhcgkSg/b6NAZV3uAvViOiTjvPziSaZqW3U/s7A64vDKLqoWnKQn6/
         SIc/c/Nh/khA+ZTlo2a0l5b3IqHN3G2p4PL9+BmZrKXZrsT89fjRPp0kz2lQv27GQQwI
         mqry/C5aA9MpMXS3AiV5E+Rizd5FJuIZpesphYerlOQxL7FaOBWRN4WMSzR91o+t+DHd
         wBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546586; x=1795151386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=edl+DLzgv803gXcZL9zN7F97e/O9QKLsm/OlVZ2e3Y4=;
        b=LLgUmd3pUBrEzceZioPWdT7vjdfj8DQi0IOQNznqz4A1K6SIj4STF93FJfp7bWZeI8
         /kephYR+yB8ll65N+t9pzSMluHLoubU0pSMKFWUBwKQjOM+1XSGqCZdRkrBBODsSPwoG
         z1hyYOs6SqrcMl7ntsZDmwJEpnq1k40qxM+/q8ejQW2WQA1MFzrW7/0dOogRsHhF3Mpf
         iNWsoDlPyhxYxLg9ljluLvmch9tsFAQpd6EwSu4SAKTFAoUqdGFKg8DFsmTpCXYhQ/OC
         oURy/jg9uC5Rs5UtdCOYLOyCnGgEY4jzEYGv7A74JDmkjCg60a9tsCxAc7l/Qp4zTJSc
         9CjQ==
X-Gm-Message-State: APuU4Z8ZGF2KZkV/nLdOFLYh7rYCtRGixP2/X6UsW1zOvLLtsppp/5Ux
	NhWdkwzHn6uEM4N1xbIMnPS2AW7Wt6OjFW58ntbfia+MN5ZmKNk6xZXQlC31pg==
X-Gm-Gg: AYBFou1QqPqJjabPMugPE6qFj3/CNYO28v9IsLNbCjEr+nDKEuX5nfHCIZjT5L8Wlw+
	hsnixgZm5it9asXMuK1IFx4aYk4vi1X4KQqJJQrUr4iHOE4x5nr7+EyuEKw+RKr++22LUGaWUQc
	GcHMDA0iXvAQ8PqT6TdH+t7QMd4ixEstAfIzCyWstqSzVSDekX12lo9WIMbkqLQLNwvYxMmQXP5
	dbWXB1UmYJYrGVkcqRGdOffaR7Po+reSjRcOT0CMknWvNHCOjb36DzKaE/KtlEahVBZbS17lcfy
	XbSoejG2/7Vt6uOqLKklcw9RgkyllDyTKMfYjIvxCNboBC4H8rDFuCxrYR5liSlK3Tnws74n4Ku
	V0jl1TjTgIW2mvJLg2gGlv4NchfSWxf8746TpliWdyZZpphuRplQXcWQCwCaO5FItVUHGWBO+ow
	N1tg4KfpmjWzdiyUv2x7gZIbzsKtepapeLAomiFeGJm6KgGGtoSJefx+s/BwRwSxz3hzRTsW0mT
	O4iK4q+kxAyGbEpuT+G61761xMHifSgKxWRyD1L6bHz1MMDmHI6fngRLOVmRXYkrpXfcHu8XvxQ
	MKrEhxg5oA0+HBuv5WYXDE9ZjcnMG3nI9JHM7h2nc94VL+PMyOqXsUUPpGXdVgIryfjxFHl9zZy
	NyXHVYQHraeYQnHWWvJFXnS7XdsLIWgkwMRnglX5F3tGoxaaDo/QwOEMS5uqJNPW4I/TarBGWMG
	g=
X-Received: by 2002:a17:90b:2590:b0:3ad:3e8:12 with SMTP id 98e67ed59e1d1-3b1b0b49e91mr865838a91.48.1794546585868;
        Thu, 12 Nov 2026 21:09:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae981c55sm2591741a91.1.2026.11.12.21.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:09:45 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v2 bpf-next 07/13] resolve_btfids: Say which registers an instruction reads
Date: Fri, 13 Nov 2026 05:08:55 +0000
Message-ID: <20261113050901.1399091-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

	Ebusy:
		spin_unlock(&files->file_lock);
		return -EBUSY;

	mov    %rdi,%r13                files, the first argument
	...
	lea    0xc0(%r13),%rdi          &files->file_lock
	call   _raw_spin_unlock
	mov    $0xfffffff0,%eax

do_dup2() unlocks an object of its caller before it returns the error. The
next patch looks for that in the machine code: is the pointer in %rdi
computed from an argument of do_dup2()? The decoder says which registers
an instruction writes. It does not say from what.

	text_insn.uses    the registers that the instruction reads: the
	                  operands behind the defs of MCInstrDesc, and its
	                  implicit uses
	text_insn.load    it reads memory: MCInstrDesc::mayLoad()

	lea    0xc0(%r13),%rdi          uses r13: a pointer into *files
	mov    0xc0(%r13),%rdi          uses r13, load: another object

An opcode with hasUnmodeledSideEffects() reads all registers, as it writes
all registers.

For LLVM "xor %edi,%edi" reads %edi. Compilers pass NULL in this way. The
table of x86-64 gets a pattern for it: dst = 0.

A test instruction says what is read only if that is its point: four for
x86-64, three for arm64.

No tag changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/resolve_btfids/text_insn.h     |  3 +++
 tools/bpf/resolve_btfids/text_mc.cpp     | 22 ++++++++++++++++++++++
 tools/bpf/resolve_btfids/text_mc.h       |  1 +
 tools/bpf/resolve_btfids/text_mc_arm64.c |  4 ++++
 tools/bpf/resolve_btfids/text_mc_x86.c   |  7 +++++++
 5 files changed, 37 insertions(+)

diff --git a/tools/bpf/resolve_btfids/text_insn.h b/tools/bpf/resolve_btfids/text_insn.h
index da464827007d..2b148e74835d 100644
--- a/tools/bpf/resolve_btfids/text_insn.h
+++ b/tools/bpf/resolve_btfids/text_insn.h
@@ -48,6 +48,9 @@ struct text_insn {
 	bool is32;	/* It works on the low 32 bits and zero extends the result */
 	/* The registers which it writes, but for dst */
 	u32 defs;
+	/* The registers which it reads. TEXT_ALL_REGS if the decoder does not know it */
+	u32 uses;
+	bool load;	/* It reads memory */
 	u64 imm, imm2;
 	/* For the user of the decoder */
 	u64 addr;
diff --git a/tools/bpf/resolve_btfids/text_mc.cpp b/tools/bpf/resolve_btfids/text_mc.cpp
index d21e343d55a4..3344630d75e1 100644
--- a/tools/bpf/resolve_btfids/text_mc.cpp
+++ b/tools/bpf/resolve_btfids/text_mc.cpp
@@ -7,6 +7,8 @@
  *	branch, call			MCInstrAnalysis, which asks MCInstrDesc
  *	target				MCInstrAnalysis::evaluateBranch()
  *	registers written		MCInstrDesc: defs, implicit defs
+ *	registers read			MCInstrDesc: the other operands, implicit uses
+ *	load				MCInstrDesc::mayLoad()
  *	eax and rax, w0 and x0		MCRegAliasIterator
  *
  * Whatever MC does not describe completely writes TEXT_ALL_REGS.
@@ -59,6 +61,7 @@ struct Reg {
 /* What is known about an opcode before its operands are */
 struct Opcode {
 	u32 implicit_defs = 0;
+	u32 implicit_uses = 0;
 	unsigned int implicit_def = 0, implicit_use = 0;	/* the first ones, LLVM registers */
 	bool unmodeled = false, is_return = false;
 	std::vector<const mc_pattern *> patterns;
@@ -181,6 +184,8 @@ bool read_opcodes()
 		for (MCPhysReg r : desc.implicit_uses())
 			if (!o.implicit_use && d.regs[r].mask)
 				o.implicit_use = r;
+		for (MCPhysReg r : desc.implicit_uses())
+			o.implicit_uses |= d.regs[r].mask;
 		/* defs_of() does not look for the last two */
 		o.unmodeled = desc.hasUnmodeledSideEffects() || desc.hasOptionalDef() ||
 			      desc.variadicOpsAreDefs();
@@ -326,6 +331,19 @@ u32 defs_of(const MCInst &inst, const Opcode &o)
 	return defs;
 }
 
+/* Return the registers which INST reads */
+u32 uses_of(const MCInst &inst, const Opcode &o)
+{
+	u32 uses = o.implicit_uses;
+
+	if (o.unmodeled)
+		return TEXT_ALL_REGS;
+	for (unsigned int i = d.MII->get(inst.getOpcode()).getNumDefs(); i < inst.getNumOperands(); i++)
+		if (inst.getOperand(i).isReg())
+			uses |= d.regs[inst.getOperand(i).getReg()].mask;
+	return uses;
+}
+
 int decode(const void *code, unsigned int len, u64 addr, text_insn *ti)
 {
 	MCInst &inst = d.inst;
@@ -342,6 +360,8 @@ int decode(const void *code, unsigned int len, u64 addr, text_insn *ti)
 	const Opcode &o = d.opcodes[inst.getOpcode()];
 
 	ti->defs = defs_of(inst, o);
+	ti->uses = uses_of(inst, o);
+	ti->load = d.MII->get(inst.getOpcode()).mayLoad();
 	for (const mc_pattern *pattern : o.patterns) {
 		if (match(inst, o, *pattern, ti)) {
 			ti->defs &= ~(1U << ti->dst);
@@ -359,6 +379,7 @@ void print(raw_ostream &os, const text_insn &ti)
 	   << " op " << (int)ti.op
 	   << " defs " << format_hex(ti.defs, 1) << " imm " << format_hex(ti.imm, 1)
 	   << " imm2 " << format_hex(ti.imm2, 1);
+	os << " uses " << format_hex(ti.uses, 1) << " load " << ti.load;
 }
 
 bool run_tests()
@@ -378,6 +399,7 @@ bool run_tests()
 		    ti.kind == want.kind && ti.is32 == want.is32 && ti.dst == want.dst &&
 		    ti.src == want.src && ti.src2 == want.src2 &&
 		    ti.op == want.op &&
+		    (!want.uses || (ti.uses == want.uses && ti.load == want.load)) &&
 		    ti.defs == want.defs && ti.imm == want.imm && ti.imm2 == want.imm2)
 			continue;
 		print(error() << test->code << " is " << d.MII->getName(d.inst.getOpcode()) << ", length "
diff --git a/tools/bpf/resolve_btfids/text_mc.h b/tools/bpf/resolve_btfids/text_mc.h
index ecca0dd5fbbb..72de86166db0 100644
--- a/tools/bpf/resolve_btfids/text_mc.h
+++ b/tools/bpf/resolve_btfids/text_mc.h
@@ -75,6 +75,7 @@ struct mc_pattern {
 /* An instruction, in hex, and what text_arch.decode() has to say about it at MC_TEST_ADDR */
 struct mc_test {
 	const char *code;
+	/* uses and load are compared only if uses is set */
 	struct text_insn insn;
 };
 
diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
index 9cc44281242b..2fe9bc281d83 100644
--- a/tools/bpf/resolve_btfids/text_mc_arm64.c
+++ b/tools/bpf/resolve_btfids/text_mc_arm64.c
@@ -88,6 +88,10 @@ static const struct mc_test arm64_tests[] = {
 	T("20 c0 5f b8", TEXT_OTHER, .defs = BIT(0)),			/* ldur w0, [x1, #-4] */
 	T("20 c0 9f b8", TEXT_OTHER, .defs = BIT(0)),			/* ldursw x0, [x1, #-4] */
 	T("08 09 40 b8", TEXT_OTHER, .defs = BIT(8)),			/* ldtr w8, [x8] */
+	/* What is read */
+	T("20 00 01 91", TEXT_OTHER, .defs = BIT(0), .uses = BIT(1)),	/* add x0, x1, #0x40 */
+	T("20 20 40 f9", TEXT_OTHER, .defs = BIT(0), .uses = BIT(1), .load = true),	/* ldr x0, [x1, #0x40] */
+	T("20 00 00 b9", TEXT_OTHER, .uses = BIT(0) | BIT(1)),		/* str w0, [x1] */
 	/* The control flow */
 	T("10 00 00 14", TEXT_BRANCH, .imm = MC_TEST_ADDR + 0x40),	/* b */
 	T("00 01 1f d6", TEXT_BRANCH),					/* br x8 */
diff --git a/tools/bpf/resolve_btfids/text_mc_x86.c b/tools/bpf/resolve_btfids/text_mc_x86.c
index 24402ea8c544..e73cb8f1b4a3 100644
--- a/tools/bpf/resolve_btfids/text_mc_x86.c
+++ b/tools/bpf/resolve_btfids/text_mc_x86.c
@@ -16,6 +16,7 @@ static const struct mc_pattern x86_patterns[] = {
 	{ "MOV64ri32",		TEXT_MOV_IMM, .imm = 1 },
 	{ "OR32ri8",		TEXT_MOV_IMM, .imm = 2, .predicates = { IMM(2, -1) } },
 	{ "OR64ri8",		TEXT_MOV_IMM, .imm = 2, .predicates = { IMM(2, -1) } },
+	{ "XOR32rr",		TEXT_MOV_IMM, VALUE(0), .predicates = { SAME_REG(1, 2) } },
 	{ "MOV32rr",		TEXT_MOV, .src = 1 },
 	{ "MOV64rr",		TEXT_MOV, .src = 1 },
 	{ "MOVSX64rr32",	TEXT_SEXT32, .src = 1 },
@@ -50,6 +51,7 @@ static const struct mc_test x86_tests[] = {
 	T("48 83 c8 ff",	  TEXT_MOV_IMM, IMMS(-1, -1)),			/* or $-1, %rax */
 	T("83 c8 f0",		  TEXT_OTHER, .defs = BIT(RAX)),		/* or $-16, %eax */
 	T("48 83 c8 f0",	  TEXT_OTHER, .defs = BIT(RAX)),		/* or $-16, %rax */
+	T("31 c0",		  TEXT_MOV_IMM, .is32 = true),			/* xor %eax, %eax */
 	T("19 c0",		  TEXT_MOV_IMM, .is32 = true, IMMS(0xffffffff, 0)),	/* sbb %eax, %eax */
 	T("48 19 c0",		  TEXT_MOV_IMM, IMMS(-1, 0)),			/* sbb %rax, %rax */
 	T("19 d8",		  TEXT_OTHER, .defs = BIT(RAX)),		/* sbb %ebx, %eax */
@@ -101,6 +103,11 @@ static const struct mc_test x86_tests[] = {
 	T("48 0f bd c3",	  TEXT_OTHER, .defs = BIT(RAX)),		/* bsr %rbx, %rax */
 	T("80 e3 01",		  TEXT_OTHER, .defs = BIT(RBX)),		/* and $1, %bl */
 	T("48 0f c1 13",	  TEXT_OTHER, .defs = BIT(RDX)),		/* xadd %rdx, (%rbx) */
+	/* What is read */
+	T("48 8d 47 40",	  TEXT_OTHER, .defs = BIT(RAX), .uses = BIT(RDI)),	/* lea 0x40(%rdi), %rax */
+	T("48 8b 47 40",	  TEXT_OTHER, .defs = BIT(RAX), .uses = BIT(RDI), .load = true), /* mov 0x40(%rdi), %rax */
+	T("89 04 cb",		  TEXT_OTHER, .uses = BIT(RAX) | BIT(RBX) | BIT(RCX)),	/* mov %eax, (%rbx,%rcx,8) */
+	T("50",			  TEXT_OTHER, .defs = BIT(RSP), .uses = BIT(RAX) | BIT(RSP)),	/* push %rax */
 	/* The control flow */
 	T("eb 10",		  TEXT_BRANCH, .imm = MC_TEST_ADDR + 0x12),	/* jmp */
 	T("ff e0",		  TEXT_BRANCH),					/* jmp *%rax */
-- 
2.55.0

