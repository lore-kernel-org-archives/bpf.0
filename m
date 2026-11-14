Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633527;
	b=Da4hhWwuC/fk3GNcMkfQlan+8Dkd6Gz6V88KI1wkCmGV0wuXSclUyBaBPbIeFaMGAS+p
	 +HkV08E2LNXNNf5dUpWObNzUgpTAJ4cwn/f7ADVU6RfPe6RmFk8sds6fAxkCDTxF0ibUn
	 E//yPS0bEqHBgi9D0l35itTVuZ76gdRPsGT6LFlHZhCYMxw/FFU+X0x5rSzAsP4sAc25B
	 CUeWIu/2VXeKJrvxNsP5eq9mgwrqGdz+/pR16RwOEUvn16Rbe7MyjydRF3mqDI150fiM6
	 V2buOM9uLRjD2ywbZ/gp24R8b+1SITu+i4N6Ehk4UDghF4tJdShMBbT5nAfqZ2kYPxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PgTaAkX1JiCUakJQ/XZBGXsHATet38jPyBJxKA3bDbU=;
	b=nQon0MEteT9NltyNjpwr1NDgr4uodQM3fGolj+aBZ0Piurqpq0fCvy0OiSFcPJZWINUu
	 Gk4pWR4X5ICa9DEvwUgcMxTFaYFd4y5GsaErugOsZb1os4YkGXYsAeieCCiO2z6rnQepy
	 yfb9MfCu4CBRuS1FkNm/5z40KfPz3LIXEEDENmjbKeMNd6kZNe0rXTIcoIMOeq2gygWiN
	 ohGCiyISAvVvyDnKF2EeThfQj3NZY5n8Z7L7Mh1MWEAEc1fJVoW2ov8HS2yTmRz53EbNr
	 jqUYbpLz9kWmvyTYDTz0ISEjiH/DIfQriRoGbY0ZOf+1DlG9PBVKmyb+b8SbVK+ye4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oJi6XDce;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC13606A32E
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FC13606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oJi6XDce
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ed1e9ae5a8so5982515ad.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633526; x=1795238326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PgTaAkX1JiCUakJQ/XZBGXsHATet38jPyBJxKA3bDbU=;
        b=oJi6XDceboST4uxZgtRxDl6yM+GtJhQIRG0OQ/h6ON60jsB9kzu0abZbPnFhbsdmax
         JZHUgIvZ74hMMWJfjLV+vwRdN5Idi9BbhKSnx/HDWXoboTP3t14+yKYAQ2zVoiHO80he
         r6GGv5bG1Ov8Iffw9a1IpTM2GAW41Qf6Cc4V8lmrIKaW1VX8M42a8MdJFXvSQ0VpWF2q
         7fByfM2S3LPRusadabCXpmLZuwET6GOYHSiugx5Pyiv6JSoIM8ueHBx9WDRXxG6O4ROc
         Bhh6ibBBg3cAnERQ86RKktCtqzGVO00CseF9iz6GRIzSDypjaSCAzJCBbIRkGOCmyAAl
         t1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633526; x=1795238326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PgTaAkX1JiCUakJQ/XZBGXsHATet38jPyBJxKA3bDbU=;
        b=bhQuprxQrAVCZBuLuxZyXYOMX7wFJDd7+irkG5Rv1k3I/behI6sDPO/nkrs6A6MCKt
         b/IjrhAlhklItCPJJZ3FUpEwYKt3gezVFOk7GFjy0OcY7waptlR7m9gb3av575GXqk7I
         xxkY61oaD7RaksuKOC296uLGVFoVkrj3S7/4idl8rIMUULzcNRqwtTkA7Vae1o9IEl3f
         rgjIbvTyzXb1dL2E515chUwCMBgoZHZWDPipHmR3By+ANwmj/F8DPV6Amz8rvR9ZGJqN
         1JZjjJZvkKEw684xFAZA6hzBz4PMWIgiAyb1jWrCVr9fh2rqVmG/FgUFr1EU8XJSkNvr
         Ap2Q==
X-Gm-Message-State: APuU4Z+RuaXlPVWS9ffD7TOK2iB2IZHari6Wo4s3gcoQRkvT1O+l0Csj
	OZUH7sZi/P4DdzjR2YH9IPMqUukrcKNS77wbKkDOEHM2e3hNs3EWigzmn7U7qw==
X-Gm-Gg: AYBFou1pbVQE7zHe9fqiBLtBO03qm7cVzJqjoaSSJ51PI6I24/NjhDW2TUs8k+ASY39
	oM7he5WBI0zLmm1FuzZoMncurfVHXeuQdATB/Aew5wpnaipJzI8KhRa5Xlr2CXRpx/bcOFbG4vP
	hnpUYT4k8RbPtdge5I8cc+OFAST6eQWzswgL/Bt5bEKy/PxoIRUAgghBbgWU0+UfCvrFgq9myDj
	K3+WWma5q4hxI2WRzEKJp2xLdemXb3cWSvk73igQrfGa4cMioA/hW2k9+IQemwOo8X1A67CN4g4
	37i3wnu7LVulUCIhxBQMRdkb+GUj+/T6idl55ki/PrOYCYbBy9Kky0SJec3/md5JSe4ra6IDz0n
	12bRv04kc6t0bUs+utxzQkr9fQbN41VmaX92IwHCrvdwPL+Ot7/2A/oMUEU2cNm5KvLPhY4NO5H
	5YClmLZCxEFzq+N2cGqagiahPAJX7J58ez0ZJ8PEherZl6jP7yEp2yitKYDs1PS7FBmGptQbOKs
	mUaLhwcfYUwzzN397m3If5oM4gL1sZHRN6vhA5MlPIpfRec5rjnH4GKJa5oO/Yy6zlmIaLWQO54
	3/iRvTjZCi2MFNb3yMpiytjtYbPgXNbYgHX9qwuLWOcG7q+iLTzF+TfErKe6IoCtwv326z6Hle7
	b5JM0KYeyH33Vb0cZOztlxCJe1tYWA+XSgKWrR9pfzMW/a1naujin1oGwLcxfbieVAk8T+5+WVv
	Sssq9Iu0hM+naVKHULaSF2
X-Received: by 2002:a17:903:3887:b0:2ed:2810:7cc5 with SMTP id d9443c01a7336-2ee0dcc6d2emr45714225ad.56.1794633526091;
        Fri, 13 Nov 2026 21:18:46 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f862426sm18385085ad.46.2026.11.13.21.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:18:45 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v3 bpf-next 06/11] resolve_btfids: Fold the constants of a select without a branch
Date: Sat, 14 Nov 2026 05:18:00 +0000
Message-ID: <20261114051805.683966-7-alexei.starovoitov@gmail.com>
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

	return copy_to_user(to, from, n) ? -EFAULT : 0;

GCC for x86-64 never loads -14 into a register here:

	neg    %rax
	sbb    %eax,%eax                0 or -1
	and    $0xfffffff2,%eax         0 or -14
	ret

So the function gets no tag. Other forms of the same select:

	one of two errors               sbb; and; sub
	the condition is negated        sbb; not; and

The table of x86-64 describes "sbb %eax,%eax" as a definition with two
constants, 0 and -1. Describe "dst = src op imm" in text_insn.h as
TEXT_ALU_IMM. text_flow_fold() runs before the analysis. It computes the
instruction if src still holds the constants of an earlier instruction,
and the code falls through from there. The result is again a definition
with two constants.

Five patterns of x86-64 use it: "and" and "sub" of a short immediate, in
32 and in 64 bits, and "not".

	functions tagged     before      after
	x86-64 GCC            12076       12256
	x86-64 clang          12994       13002
	arm64 clang           11837       11837

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/fmodret_scan.c |  1 +
 tools/bpf/resolve_btfids/text_flow.c    | 49 +++++++++++++++++++++++++
 tools/bpf/resolve_btfids/text_flow.h    |  6 +++
 tools/bpf/resolve_btfids/text_insn.h    |  8 ++++
 tools/bpf/resolve_btfids/text_mc.cpp    |  3 ++
 tools/bpf/resolve_btfids/text_mc.h      |  1 +
 tools/bpf/resolve_btfids/text_mc_x86.c  | 10 +++++
 7 files changed, 78 insertions(+)

diff --git a/tools/bpf/resolve_btfids/fmodret_scan.c b/tools/bpf/resolve_btfids/fmodret_scan.c
index 6df10be92610..5b5eb8cb414b 100644
--- a/tools/bpf/resolve_btfids/fmodret_scan.c
+++ b/tools/bpf/resolve_btfids/fmodret_scan.c
@@ -160,6 +160,7 @@ int scan_func(struct scan *s, const struct image_func *f, const int64_t **values
 		return err;
 	if (!has_entry_nop(flow, f->addr))
 		return 0;
+	text_flow_fold(&s->flow);
 	text_flow_solve(&s->flow);
 
 	s->nr_values = 0;
diff --git a/tools/bpf/resolve_btfids/text_flow.c b/tools/bpf/resolve_btfids/text_flow.c
index 2d58ffb2e939..3fe2c75eb2fc 100644
--- a/tools/bpf/resolve_btfids/text_flow.c
+++ b/tools/bpf/resolve_btfids/text_flow.c
@@ -16,6 +16,54 @@ static u32 next_insn(const struct text_flow *flow, u32 i)
 	       i + 1 : TEXT_NO_INSN;
 }
 
+static u64 alu(const struct text_insn *insn, u64 v)
+{
+	switch (insn->op) {
+	case TEXT_AND:
+		v &= insn->imm;
+		break;
+	case TEXT_XOR:
+		v ^= insn->imm;
+		break;
+	case TEXT_SUB:
+		v -= insn->imm;
+		break;
+	}
+	return insn->is32 ? (u32)v : v;
+}
+
+void text_flow_fold(struct text_flow *flow)
+{
+	/* The instruction which has left a constant in each register */
+	u32 def[TEXT_MAX_REGS], i, r;
+
+	for (i = 0; i < flow->nr_insns; i++) {
+		struct text_insn *insn = &flow->insns[i];
+		u32 defs = insn->defs;
+
+		/* The function or a cold subfunction begins */
+		if (!i || next_insn(flow, i - 1) == TEXT_NO_INSN)
+			for (r = 0; r < TEXT_MAX_REGS; r++)
+				def[r] = TEXT_NO_INSN;
+		if (insn->kind == TEXT_ALU_IMM && def[insn->src] != TEXT_NO_INSN) {
+			insn->kind = TEXT_MOV_IMM;
+			insn->imm2 = alu(insn, flow->insns[def[insn->src]].imm2);
+			insn->imm = alu(insn, flow->insns[def[insn->src]].imm);
+		}
+		if (insn->kind == TEXT_BRANCH || insn->kind == TEXT_RETURN)
+			defs = TEXT_ALL_REGS;
+		else if (insn->kind == TEXT_CALL)
+			defs |= flow->arch->caller_saved;
+		else if (insn->kind != TEXT_OTHER && insn->kind != TEXT_COND_BRANCH)
+			defs |= BIT(insn->dst);
+		for (r = 0; defs && r < TEXT_MAX_REGS; r++)
+			if (defs & BIT(r))
+				def[r] = TEXT_NO_INSN;
+		if (insn->kind == TEXT_MOV_IMM)
+			def[insn->dst] = i;
+	}
+}
+
 static u32 insn_at(const struct text_flow *flow, u64 addr)
 {
 	u32 lo = 0, hi = flow->nr_insns;
@@ -90,6 +138,7 @@ static struct text_facts transfer(const struct text_flow *flow, u32 i)
 		kill(&in, flow->arch->caller_saved);
 		break;
 	case TEXT_MOV_IMM:
+	case TEXT_ALU_IMM:
 		kill(&in, BIT(insn->dst));
 		break;
 	case TEXT_MOV:
diff --git a/tools/bpf/resolve_btfids/text_flow.h b/tools/bpf/resolve_btfids/text_flow.h
index b307c08fd163..a266419400f9 100644
--- a/tools/bpf/resolve_btfids/text_flow.h
+++ b/tools/bpf/resolve_btfids/text_flow.h
@@ -36,6 +36,12 @@ struct text_flow {
 	struct text_facts *facts;
 };
 
+/*
+ * Fold constants: "dst = imm or imm2" and a later "dst = src op imm" in the same
+ * straight line of code give "dst = imm' or imm2'". Compilers select one of two
+ * constants without a branch in this way.
+ */
+void text_flow_fold(struct text_flow *flow);
 /* Compute the facts */
 void text_flow_solve(struct text_flow *flow);
 /* Return the facts behind instruction I, which is not a branch */
diff --git a/tools/bpf/resolve_btfids/text_insn.h b/tools/bpf/resolve_btfids/text_insn.h
index 0ead445f5442..a79a4c9a86d5 100644
--- a/tools/bpf/resolve_btfids/text_insn.h
+++ b/tools/bpf/resolve_btfids/text_insn.h
@@ -18,6 +18,7 @@
 enum text_insn_kind {
 	TEXT_OTHER,
 	TEXT_MOV_IMM,		/* dst = imm or imm2 */
+	TEXT_ALU_IMM,		/* dst = src op imm */
 	TEXT_MOV,		/* dst = src */
 	TEXT_SEXT32,		/* dst = (s32)src */
 	TEXT_SELECT,		/* dst = src or src2 */
@@ -28,6 +29,12 @@ enum text_insn_kind {
 	TEXT_RETURN,
 };
 
+enum text_alu_op {
+	TEXT_AND,
+	TEXT_XOR,
+	TEXT_SUB,
+};
+
 /* The arch numbers its registers */
 #define TEXT_MAX_REGS	32
 #define TEXT_ALL_REGS	(~0U)
@@ -37,6 +44,7 @@ struct text_insn {
 	u8 kind;
 	u8 len;
 	u8 dst, src, src2;
+	u8 op;		/* of TEXT_ALU_IMM */
 	bool is32;	/* It works on the low 32 bits and zero extends the result */
 	bool nop;	/* It does nothing */
 	/* The registers which it writes, but for dst */
diff --git a/tools/bpf/resolve_btfids/text_mc.cpp b/tools/bpf/resolve_btfids/text_mc.cpp
index cb57f9db9f9d..ddf9e33ee5a0 100644
--- a/tools/bpf/resolve_btfids/text_mc.cpp
+++ b/tools/bpf/resolve_btfids/text_mc.cpp
@@ -284,6 +284,7 @@ bool match(const MCInst &inst, const Opcode &o, const mc_pattern &pattern, text_
 	ti->dst = dst.nr;
 	ti->src = src;
 	ti->src2 = src2;
+	ti->op = pattern.op;
 	ti->imm = imm;
 	ti->imm2 = pattern.or_zero ? 0 : imm;
 	return true;
@@ -360,6 +361,7 @@ void print(raw_ostream &os, const text_insn &ti)
 	os << "nop " << ti.nop << " ";
 	os << "kind " << (int)ti.kind << " is32 " << ti.is32 << " dst " << (int)ti.dst
 	   << " src " << (int)ti.src << " src2 " << (int)ti.src2
+	   << " op " << (int)ti.op
 	   << " defs " << format_hex(ti.defs, 1) << " imm " << format_hex(ti.imm, 1)
 	   << " imm2 " << format_hex(ti.imm2, 1);
 }
@@ -381,6 +383,7 @@ bool run_tests()
 		    ti.nop == want.nop &&
 		    ti.kind == want.kind && ti.is32 == want.is32 && ti.dst == want.dst &&
 		    ti.src == want.src && ti.src2 == want.src2 &&
+		    ti.op == want.op &&
 		    ti.defs == want.defs && ti.imm == want.imm && ti.imm2 == want.imm2)
 			continue;
 		print(error() << test->code << " is " << d.MII->getName(d.inst.getOpcode()) << ", length "
diff --git a/tools/bpf/resolve_btfids/text_mc.h b/tools/bpf/resolve_btfids/text_mc.h
index 8eef0860aa1c..70fe54595d60 100644
--- a/tools/bpf/resolve_btfids/text_mc.h
+++ b/tools/bpf/resolve_btfids/text_mc.h
@@ -64,6 +64,7 @@ struct mc_pattern {
 	u8 dst, src, src2;	/* the numbers of the operands. DST is 0 unless it is given */
 	u8 imm;			/* the operand with the immediate */
 	u8 shift;		/* the operand which says how far the immediate is shifted left */
+	u8 op;			/* of TEXT_ALU_IMM */
 	bool invert;		/* the immediate */
 	bool or_zero;		/* TEXT_MOV_IMM: the immediate or 0 */
 	bool fixed;		/* the immediate is VALUE, not an operand */
diff --git a/tools/bpf/resolve_btfids/text_mc_x86.c b/tools/bpf/resolve_btfids/text_mc_x86.c
index d907fac001c8..2773f35bfc12 100644
--- a/tools/bpf/resolve_btfids/text_mc_x86.c
+++ b/tools/bpf/resolve_btfids/text_mc_x86.c
@@ -26,6 +26,11 @@ static const struct mc_pattern x86_patterns[] = {
 	{ "SBB32rr",		TEXT_MOV_IMM, VALUE(-1), .or_zero = true, .predicates = { SAME_REG(1, 2) } },
 	{ "SBB64rr",		TEXT_MOV_IMM, VALUE(-1), .or_zero = true, .predicates = { SAME_REG(1, 2) } },
 	{ "SAR32ri",		TEXT_MOV_IMM, VALUE(-1), .or_zero = true, .predicates = { IMM(2, 31) } },
+	{ "AND32ri8",		TEXT_ALU_IMM, .src = 1, .imm = 2, .op = TEXT_AND },
+	{ "AND64ri8",		TEXT_ALU_IMM, .src = 1, .imm = 2, .op = TEXT_AND },
+	{ "SUB32ri8",		TEXT_ALU_IMM, .src = 1, .imm = 2, .op = TEXT_SUB },
+	{ "SUB64ri8",		TEXT_ALU_IMM, .src = 1, .imm = 2, .op = TEXT_SUB },
+	{ "NOT32r",		TEXT_ALU_IMM, .src = 1, .op = TEXT_XOR, VALUE(-1) },
 	{ "LOCK_PREFIX",	TEXT_OTHER },
 	{ "NOOPL",		TEXT_OTHER, .nop = true },
 	/* A rep prefix is not a part of the MCInst */
@@ -58,6 +63,11 @@ static const struct mc_test x86_tests[] = {
 	T("48 98",		  TEXT_SEXT32, SRC(RAX)),			/* cltq */
 	T("0f 44 c3",		  TEXT_SELECT, .is32 = true, .src = RBX, .src2 = RAX),	/* cmove %ebx, %eax */
 	T("48 0f 44 c3",	  TEXT_SELECT, .src = RBX, .src2 = RAX),	/* cmove %rbx, %rax */
+	T("83 e3 f2",		  TEXT_ALU_IMM, .is32 = true, .dst = RBX, SRC(RBX), .op = TEXT_AND, IMMS(0xfffffff2, 0xfffffff2)), /* and $-14, %ebx */
+	T("48 83 e3 f2",	  TEXT_ALU_IMM, .dst = RBX, SRC(RBX), .op = TEXT_AND, IMMS(-14, -14)),	/* and $-14, %rbx */
+	T("83 eb 0e",		  TEXT_ALU_IMM, .is32 = true, .dst = RBX, SRC(RBX), .op = TEXT_SUB, IMMS(14, 14)), /* sub $14, %ebx */
+	T("48 83 eb 0e",	  TEXT_ALU_IMM, .dst = RBX, SRC(RBX), .op = TEXT_SUB, IMMS(14, 14)),	/* sub $14, %rbx */
+	T("f7 d0",		  TEXT_ALU_IMM, .is32 = true, .op = TEXT_XOR, IMMS(0xffffffff, 0xffffffff)), /* not %eax */
 	T("f0",			  TEXT_OTHER),					/* lock */
 	T("0f 1f 44 00 00",	  TEXT_OTHER, .nop = true),			/* nopl 0x0(%rax,%rax,1) */
 	T("f3 48 ab",		  TEXT_OTHER, .defs = BIT(RCX) | BIT(RDI)),	/* rep stosq */
-- 
2.55.0

