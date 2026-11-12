Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502017;
	b=N7s04vP0i87dvjuwpMRGqRqjirYddB+vBmjTvdfSnRe7E60Es6AuGGXea3/Nv4cYrFeB
	 LCtOJqYfl3eYMqZ5g7BMANcDWEbWBN1+k9uBE/6OLRqBkaNiDseyPAI5+7w1UmsNwK93K
	 CdJIIGigrQ6o1a8vWUd8E5i/dYGxAbiD3CJz54okpTeF7E4o5nEevDb+6kH860mGKpOf2
	 LnS0scBEGLxJBSq6o0kh39GuquRXYSHC4888gQ1vrYrRvf51N1n9Eb2HC2QcG3rPp/agF
	 jjZNpw1kkSzSDIf9fZJN4/3Am7HZOcTHmgLvX5SKtjfOa3xjIngiZZn/qRY1vo/3Z0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tc9IOImSSlnwiB2KCenqcisslf7jJyuZqfWaYIZOnvk=;
	b=wXLZzvK9ZrJuoIEjMiYa84cBoMTngVolfhxXR5e4g+WiktUIgkv47Sppxs81R2DdxknB
	 dRf7uu4Mh+SwOkNztowU8h2maofLpRqKx+nFVgZT2+e6ftkLZ1QdfS/OSJBVnsrkOv2tl
	 bbrZGW9sLJfRZAbKvw2jHN+IQpSkSXpE3SMf6WvNpy73dc8TIwnetboijCxJuYHd5NtMq
	 KeJDgdrtuxmFQmg9NJA13Trk8u7G7+j+4eAgBxp8Zo3NROrFzqfWKNye8fvjp6+Bt+On/
	 xbFSe9mcb1KwDUr0X01BVgKRi1JvT1swS1fDilvCyRCFgoPUeZezOu6AyZAU1Rk25/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MIClwqm1;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B150C606A8BD
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B150C606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MIClwqm1
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so2486067a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794502016; x=1795106816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tc9IOImSSlnwiB2KCenqcisslf7jJyuZqfWaYIZOnvk=;
        b=MIClwqm1Tky4D2IwjjofDi33985pDweFWataVgtkkrPZcA0IAQG8Hx5+j0oYDIappE
         RXakK+VZRqkGTQIcs7J9CoB0QGpDeN5vKA7uKnZ/hO+eiDgPrwqZud4mUKMHPbmPJaG1
         VSWssmOz0qUPIkbGnyvx7BN6n4JLrXQHEvJxW9vgKsDRVaf1hXiDziMHh0tplL2ZZa/z
         aP58jh2+3Fcs7WE2nmG2bpKJRDCBrTl40Grhr7qu3MenV3i4wnluSrLnqA1na+4an+AK
         2veNwARAp6wajmjIjQ11h1EA2At9oaWqTZWD2KRAZyHDYmDC97fjwJJAm8ygRl0/vbwC
         LPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502016; x=1795106816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tc9IOImSSlnwiB2KCenqcisslf7jJyuZqfWaYIZOnvk=;
        b=HTRVkGTZbZ4WQd8HbretHYSty3subJoDettW4h+a43mHFihgbq743UFbdcSLBHjOcB
         yoJLvdetFbp6o88wuyHl1OtzqDyyinvEME96PzxzdP8Eeig5u1woclKVeoJ/P3ol0ThS
         LrQnl3Qn/Au5AlPJalBvHdzoyMQs06/k7gpgYYPX4T4ygTGbh3jlSpFttJCQOJiQT7DK
         hkBi1z5NqSqO8peSbPVzr53dmop7L7pYblmsXQP8bLUzESCfGbt2hqauo3lmqrWUNULP
         Puh/+SXL2IZqUdDUAAMnQaS+9Zkx+2PAKNBzN6g7q9WGpl24pKNpGpIykXnn/XKhWWYD
         biHQ==
X-Gm-Message-State: APuU4Z892LaMqSp+ioLDU4oRPUBHE7Y+tlZtg9BZOfM7Ir19I2nPQAlS
	EIoc2eb9XV4JsAlmpetseYFFxxqNSdgD5RfuWEUjE8wDZw68J2NJHhiMr82arQ==
X-Gm-Gg: AYBFou2co7x4H9stTbVd+XXU6Q2BhzLhkoTVML7b7wINrO4khXPOLi4zWnSn9cd7F7g
	U2loP6ZobeAcV5KVYrpc5JU+SMmds2i5FTW2KiyC6h4zZEDRMHXPftVUa050NhfsUbvJGdPgj5M
	Q455pljmVpZ44gCvOlI10FZQJj1Ed3229QWMFS2lwdS5T0PlSJ0iVkZ+PHdi7kCjlJptn5vTv5w
	56BFUXp1l2PEvj5HAd7MUqElOKHIW7wlPFAfn1YBRS1AkXbn/5b/3s0zN5ATyMSIb+AH59wk72s
	vvplD9PZHdd3alk0+HdXqjbMTpEwC+Gla1i4rQllEi6BkYH0+Py3KQs3JfGr4VguGgdhcds5skg
	3iqr3ePI4tDMNf+NhliQXthgzEamW4PZ7KjyJMzxgInr2aIyYh0UtpF0CEUV+UYCVywEzVA01re
	8WS4bvLTlAJfuHCna28wKXbKLE99/UcBhkaqp/J/ZI9DXzi7OaVkihABN9U+InPMJjmdWfTFc++
	qGk5AG8d1Ric/ZVoTpmsVc69F89OI0NmmYWW3+LxsRuj3q/L6a1+JrEL57BiELgOEhabvaV1Dbs
	VS1iTF5AqXsvDENrXBrqrvbJIV+j+ep8mqrtvWtINprI8Yn6usfNi/5Dqda6Gk2vsZPqYyV8BzJ
	DYuT73V9BYGx5YXkBY3NQCR5kC9NGKOuMsf5Ubp2b4OaDnJ1W7xBHvmmWXCSLdI7vYD/aOKAdRw
	==
X-Received: by 2002:a17:90b:1c01:b0:3ab:9f1a:3825 with SMTP id 98e67ed59e1d1-3b182df2fd9mr6177448a91.4.1794502015606;
        Thu, 12 Nov 2026 08:46:55 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec66f4csm132391a91.14.2026.11.12.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:46:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 07/10] resolve_btfids: Say which registers an instruction reads
Date: Thu, 12 Nov 2026 16:46:07 +0000
Message-ID: <20261112164610.1917256-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
References: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
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
index 31f3d932056b..a87d4f240eaf 100644
--- a/tools/bpf/resolve_btfids/text_mc_arm64.c
+++ b/tools/bpf/resolve_btfids/text_mc_arm64.c
@@ -87,6 +87,10 @@ static const struct mc_test arm64_tests[] = {
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
index a24e5c6c25a9..b41cc50965ee 100644
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
@@ -100,6 +102,11 @@ static const struct mc_test x86_tests[] = {
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

