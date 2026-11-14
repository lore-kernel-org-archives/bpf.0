Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633534;
	b=vn7CBgc6QsndslpMmTne/toYH4oUjhDcqpF0rbBzq6Fkjz4XIp63yrh2LmSjtxeIv/Pg
	 M/t/Sg+Zy9KbrskBgH2GiQwB4jVAax+ctajWPETGIZaeCVj1cD21Zgn8+9f5+Q4dUfcVL
	 VLlDbS0YwZA+oiZDZpyKKEUvcbp/tTPcqDmjb5ZDkCwCOc6XB1RjiNpXKGUn/pRnVsNqF
	 yHtfTbHrohae/6JD0+V9ujy72q2ER6sO2kQXJdIh9E4Cru/9jhxI/wri3sbcAiH8Cs2Eo
	 at7mnc17wFBfLMEqPWhnsD5PI718oNn7Nnf11BSNNXf5cQhcOiXjG3mT7r0CWBw0BLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x0duj03V9lFCUFLIgA2r6RkQeW/NSplPLzjIQ31AAAs=;
	b=a9nBosbE64kFByfuubBoHrUE+nBnC2oyk4ofhtfbNL8oiaJf1PYDncJqkgr9s1pKhOJ9
	 +ZPAeDy910F52DvWR6SX/KsbEg2GJN3Awxa9Lr5gHeNyrzsP9NZeEl8t7+QeKfA5cS6Xs
	 D1ijHg3d1X1H/rAUr94z8HD1r0FX3vKcHgHok7yOPuuRMDNOh6bWGGtrmZXyoa3DAVtjR
	 W2p6nao7GdznEn67R005ar67ilXsnTQ6u20uzZHyYPS27AbJKvFBfAAY9IXUisZjuxxkZ
	 ytEW+NuC7djyc35PekA6lYKBWvt0YSRku0C7HkkBEgQofdlOjNDJ0f/O2ctMZYSpmkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BliuQnxc;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032F606A329
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9032F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BliuQnxc
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ed06b725fdso19033705ad.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633532; x=1795238332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0duj03V9lFCUFLIgA2r6RkQeW/NSplPLzjIQ31AAAs=;
        b=BliuQnxce1JKhuscuQiBx52vjuPakbRkkiNoDDW5AiG5bnRQDeFIPE7hvPN2Fg4rRp
         dT02Cb4+PTV4lEDNmB94fW3NIiF4fJvcckGC641vU3paKn7cMm2IabSAI5MaYBStZ3/b
         MsHqjT2zkTKjTkqu837AjpxC+I3TqLC1tdPvyedncY6I02MhnCuDTSzm/KLgkoxXvn/D
         FR57WrH41FiImzCt+Ph8fVp7kFMG0itSBMgj6tlTU9OSHKe4uezoPUMUU4IuypiQgAN7
         pGBnURBqZA5/wMiF9kkvNwY/f9NJC3yNgGb/qGldyw5B0BHcrtqHaxJ04YIQqMgL754k
         TWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633532; x=1795238332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x0duj03V9lFCUFLIgA2r6RkQeW/NSplPLzjIQ31AAAs=;
        b=snRRl4i2B+kbZ8HrALTkauQBhjo8e23moL6St555rkVPndf4DkUF/9R8uIZx7wV7y9
         rDkoxbcsZFl5adAl4Ipr3Wzlfz6HThjrcNf/6OaFNf+OItE3bpBvNk33ywIlBc9S1Hcx
         /8E5Yvvj2kiMtYJ0XBc4IszGrxm7cdKyqyUMeNgLIHr+0RQIKGpE6gNvDqIXVUsRAYKn
         RIyIxH6F7q2ivqMW9YFD2OT1yMu9xQFACJm8j66TLvOLmtQ6BJrf1R6EPK+MZhy+RUat
         JVR6RSn3At3J+EvPEVcEug1uKapKYExk4VG8IOJrHWd0QGv7srKnQK+XN+djToq8/yii
         US3w==
X-Gm-Message-State: APuU4Z/SqSm2+h/jRpVrdBBCigfVDZLnp3ttCWrHwgW9eKm2zSXZgATJ
	6iAxTFgZJzukzn5glwvUKlB5F3ZcouFykkbT7P8TyLvbVhDrMoWfAKHP3Ir7hA==
X-Gm-Gg: AYBFou0bRtE6khWlG3eBwWVA0TMPtfZjpp66wCbYwRglgtqcKD3Sd5wz1Zx2UobcTiN
	hAJR+FiJHLJLQWWbiLMFLXo6RL3xhVaIOkErbjnZYgvqhGGZytBJsOpZKKgef8gvZPTXvBOFkup
	fUoizcHmitdUNUXmgS8+uWbqUg+yuTkxs0NLILvPFd8eTmhN0dJLyK/qNSBIDnFKdj7LmJeNwn1
	Y4NAknguA+kJSRhVwuXecJYTNKAgDq6AAMrKMoQ9kx/9ZdcNz+ensVDb8zi9S6SMsqgY92NgpJk
	2k5LsllhIYNMJJGDelf+VB9FsB3KfWJG0FHQAjXuw+Xn0jJXRVCXWrYk021t5n8W3hK+ruGZDOb
	lW+uS55Xe0deJzjjqhczUUz3J2tzUJwjTr3Qio3bhBKj7bShkM1BVYxu4Lkjwp8eTGfjbL4Te7M
	GQGTCf7BT8zazfPy2CKRR6GkQWUZFFgd+yKzLfnRHqBlqKE4rksxp3bVKlt6EQV4A5Ijfq1mSE4
	XlXKcpozMqZ+vs5y6A5EFZvcIpVsJuphUbx2hFWR11qHI1Acmy5b5mGl8DUJz7XE3tMXaCV1+U7
	EI/ncx/CJusbXnRen0HTHuA+0i2247gLS+Jo9I7JqNucCqsx21cvDiSKxBT0n1KoI6Sdho6D+EW
	CmoeTAy16Ya0LBSSkr01wYSNaoFvVSTBd7VyYQND4rZ1QToKfuli9bUsWo5BctKGLKJQMxfK8+Q
	==
X-Received: by 2002:a17:902:fd8c:b0:2e9:46a9:9b56 with SMTP id d9443c01a7336-2edf206817amr55800765ad.21.1794633532212;
        Fri, 13 Nov 2026 21:18:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75b472sm17900915ad.19.2026.11.13.21.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:18:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v3 bpf-next 07/11] resolve_btfids: Say which registers an instruction reads
Date: Sat, 14 Nov 2026 05:18:01 +0000
Message-ID: <20261114051805.683966-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
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
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/text_insn.h     |  3 +++
 tools/bpf/resolve_btfids/text_mc.cpp     | 22 ++++++++++++++++++++++
 tools/bpf/resolve_btfids/text_mc.h       |  1 +
 tools/bpf/resolve_btfids/text_mc_arm64.c |  4 ++++
 tools/bpf/resolve_btfids/text_mc_x86.c   |  7 +++++++
 5 files changed, 37 insertions(+)

diff --git a/tools/bpf/resolve_btfids/text_insn.h b/tools/bpf/resolve_btfids/text_insn.h
index a79a4c9a86d5..5c3ba3a54856 100644
--- a/tools/bpf/resolve_btfids/text_insn.h
+++ b/tools/bpf/resolve_btfids/text_insn.h
@@ -49,6 +49,9 @@ struct text_insn {
 	bool nop;	/* It does nothing */
 	/* The registers which it writes, but for dst */
 	u32 defs;
+	/* The registers which it reads. TEXT_ALL_REGS if the decoder does not know it */
+	u32 uses;
+	bool load;	/* It reads memory */
 	u64 imm, imm2;
 	/* For the user of the decoder */
 	u64 addr;
diff --git a/tools/bpf/resolve_btfids/text_mc.cpp b/tools/bpf/resolve_btfids/text_mc.cpp
index ddf9e33ee5a0..57f45a4bed6f 100644
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
 	const mc_pattern *nop = nullptr;
@@ -182,6 +185,8 @@ bool read_opcodes()
 		for (MCPhysReg r : desc.implicit_uses())
 			if (!o.implicit_use && d.regs[r].mask)
 				o.implicit_use = r;
+		for (MCPhysReg r : desc.implicit_uses())
+			o.implicit_uses |= d.regs[r].mask;
 		/* defs_of() does not look for the last two */
 		o.unmodeled = desc.hasUnmodeledSideEffects() || desc.hasOptionalDef() ||
 			      desc.variadicOpsAreDefs();
@@ -329,6 +334,19 @@ u32 defs_of(const MCInst &inst, const Opcode &o)
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
@@ -346,6 +364,8 @@ int decode(const void *code, unsigned int len, u64 addr, text_insn *ti)
 
 	ti->nop = o.nop && holds(inst, o.nop->predicates[0]);
 	ti->defs = defs_of(inst, o);
+	ti->uses = uses_of(inst, o);
+	ti->load = d.MII->get(inst.getOpcode()).mayLoad();
 	for (const mc_pattern *pattern : o.patterns) {
 		if (match(inst, o, *pattern, ti)) {
 			ti->defs &= ~(1U << ti->dst);
@@ -364,6 +384,7 @@ void print(raw_ostream &os, const text_insn &ti)
 	   << " op " << (int)ti.op
 	   << " defs " << format_hex(ti.defs, 1) << " imm " << format_hex(ti.imm, 1)
 	   << " imm2 " << format_hex(ti.imm2, 1);
+	os << " uses " << format_hex(ti.uses, 1) << " load " << ti.load;
 }
 
 bool run_tests()
@@ -384,6 +405,7 @@ bool run_tests()
 		    ti.kind == want.kind && ti.is32 == want.is32 && ti.dst == want.dst &&
 		    ti.src == want.src && ti.src2 == want.src2 &&
 		    ti.op == want.op &&
+		    (!want.uses || (ti.uses == want.uses && ti.load == want.load)) &&
 		    ti.defs == want.defs && ti.imm == want.imm && ti.imm2 == want.imm2)
 			continue;
 		print(error() << test->code << " is " << d.MII->getName(d.inst.getOpcode()) << ", length "
diff --git a/tools/bpf/resolve_btfids/text_mc.h b/tools/bpf/resolve_btfids/text_mc.h
index 70fe54595d60..f2add1f45f4f 100644
--- a/tools/bpf/resolve_btfids/text_mc.h
+++ b/tools/bpf/resolve_btfids/text_mc.h
@@ -77,6 +77,7 @@ struct mc_pattern {
 /* An instruction, in hex, and what text_arch.decode() has to say about it at MC_TEST_ADDR */
 struct mc_test {
 	const char *code;
+	/* uses and load are compared only if uses is set */
 	struct text_insn insn;
 };
 
diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
index 546a9d319126..c2576473773e 100644
--- a/tools/bpf/resolve_btfids/text_mc_arm64.c
+++ b/tools/bpf/resolve_btfids/text_mc_arm64.c
@@ -90,6 +90,10 @@ static const struct mc_test arm64_tests[] = {
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
index 2773f35bfc12..d8d48b0f68fe 100644
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
@@ -51,6 +52,7 @@ static const struct mc_test x86_tests[] = {
 	T("48 83 c8 ff",	  TEXT_MOV_IMM, IMMS(-1, -1)),			/* or $-1, %rax */
 	T("83 c8 f0",		  TEXT_OTHER, .defs = BIT(RAX)),		/* or $-16, %eax */
 	T("48 83 c8 f0",	  TEXT_OTHER, .defs = BIT(RAX)),		/* or $-16, %rax */
+	T("31 c0",		  TEXT_MOV_IMM, .is32 = true),			/* xor %eax, %eax */
 	T("19 c0",		  TEXT_MOV_IMM, .is32 = true, IMMS(0xffffffff, 0)),	/* sbb %eax, %eax */
 	T("48 19 c0",		  TEXT_MOV_IMM, IMMS(-1, 0)),			/* sbb %rax, %rax */
 	T("19 d8",		  TEXT_OTHER, .defs = BIT(RAX)),		/* sbb %ebx, %eax */
@@ -103,6 +105,11 @@ static const struct mc_test x86_tests[] = {
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

