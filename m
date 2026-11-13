Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546581;
	b=nz4TqMICG7H9+TVVaKaXs0bKN+4oMZhChgERo3Zw6eNvNRvn+iODe8ZxuAlwpXK5efBo
	 A4Mq5kF42OO3c3HlhI8fyLHnAyrD0FONR1Sfl46lb8nsBq8XqoAZsROtCaROKei7l9ipx
	 6/ydU+JXVXBosOY8eq9fZ7ZKFvXyLshBA7dq0E4JZPWB91/rg9Y60/SRl60ioWNUY5rPQ
	 rWXL7I1FOknNlHr3hz7ffvKRITYMtFmDkrYSAaI5VJDUBlq9OIkGTHWjdRq8vUwk9dAAA
	 fsEp+5lzNOhYhJeukYhlC8WQ0u2yBgwcftoeu73IAd6PQaKo3Eo56TLtqH6tl2K/3Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UyrdwekTREkmfi83LrXj2ILPmXMgMc13/dtk0hRMPt4=;
	b=4xq6XQO8lQDO3rYNuIEbIGJVlPfEGYVJ6g13GXqpm+TmhplBwwQzM2JiNkb2xP3dN86K
	 sagx9uLSmeOWJCTIWgP9bPZha6bVpY5MUo1ZpHIIRoOCY3gk3wJWBwUf7OnraPiyLR8QQ
	 TIMWFdRCkqNwKRPE6BtBQz54saXd0fNc/2zcLq3/APzdoceST5Czhlyw+olvT3nwQ5TJa
	 i9Qey7Y2R5owVpE7QPSYo2OhhtPbj0G7TehF/EURMEu35fBZrjNGL48W7toJD9eCpHT86
	 L47BiOsobsAhR1Zl0AapDzswp16b3FkDsdTaWH9LOxDV+cSNachLh0vtZjdgi3N9gUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G5W3trFo;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F69606A321
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8F69606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G5W3trFo
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso946141a91.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546580; x=1795151380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UyrdwekTREkmfi83LrXj2ILPmXMgMc13/dtk0hRMPt4=;
        b=G5W3trFo14yFW1B5OKJg89TX/Qd0iONiGjyNE2K/h3fQQXd2+efRVXokqiUh0ndryQ
         PiOGb7CtIoQuVVPEhHFh4FQPotP7wz48W5gbdSqqUNPz3zXoCViYSY7lefDNk5Jpb4rj
         4cMS/la3T42L5S8fAhpSJ2d1tPnFx7s/VOpez/a9DAcmfMB2MtGkJSsmRugFnNlRrI35
         hVZXBYxJnYns1QIYcI4axYtaJp4FTZPTfgUeyDiTd8hITesspP+8KgChx+lRBCB1DeHF
         QttFf5wUhwV9z2bOFvIX7CDfMViNKHktQFANrhkqQ6mJ5ewD37N3zrygRwUgZv9p5NP5
         MJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546580; x=1795151380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UyrdwekTREkmfi83LrXj2ILPmXMgMc13/dtk0hRMPt4=;
        b=YMKq86N7qs8IsTwKHnKAPWzkBP+13eMGPzoXN6IuYlClsHeKrFcpd02NtePbVZ8rrF
         DVQ3IjBYIoMZBd8WhG1cILVNtkttyjvVOUeJYBIsozvWU6ebpOEEAJnKATQ1s7dX/9VL
         03Rvbr1o7k30sI8sXgeB1FmueaL12aN4GraYRyIv07Y3FXifDmt1pJO4GH0D8m8gweNu
         /w8uFjlkFYGtBmJlgYkhBJaWrkGdK7T8LylPYU39giLYbfL+7REmQhzMe+w+bIhQzCQf
         2ZdOm+77qWBQzqkzAqporkIgWsnUX1eM5+DdzdMtKkUOHPJCxFABQU+XgDLL4K41RbJM
         6anw==
X-Gm-Message-State: APuU4Z+XJYQnTIRhIJlH8C1G+uJI9Q2wgXDt+komvUDOsHJ4fZqEji8r
	1EePtkA2gmlLeMyaVJuTtPGVtSEs+cA+D4ZUniCfFucdTC40xro2GtIwP/b5IA==
X-Gm-Gg: AYBFou0wuo0QrHmqd3UoI12nVKhWVIgvR1xeupc1B4AzdGvdY849nfhMS9jvEMVp/7v
	ruSd/DrIbETEouj/ui6jRdL4e8WwXuXOJcE3MYnCTDLolJJiDleAI+M/SL8j2VL2G2FXvcBilzP
	PzQuoQD2zcj8PgOKxqjaajCSuGcHZ5IcLIw4yle0F5jlBVRNRQ2Ag4Wzr3QSbAeTbVSf5PK4Kc2
	nt/+cjwssWR5R4qSuXqG2m6KADWovkfaEWFAnSuwcsOB5VZnIjvVi/TICSx1Gdhf3ByKIWhGuED
	Q9FMNvlCggrTEhDKrl2ZIsTDVBnEkyazvUQpOwfHphSifvjI51FUM3TuoVI1ckSeNC/QdvQUxRO
	ODInuX24/aJr+Qcmrhaf9KtGgtCRZrn790k39dgqc+OMm7JluX4cdwHgT2pLoy95VT8P22Vd+n0
	BhzsoV+IdqZnQef67N0vvWLD0QVHhvgvLlxgOZsMLjF2/TQfj/nWkSIuA5WD2fDyu6pRc2e4RDk
	JZ1ClDuMovNyxTIzFHQ9KJpJimlRYn5ddpzm+4P5fPNSXUBjIUY7+6YDeQEbtCfc1/WapDR4gvx
	tQVV9mHc3QApvM5Dh9EG1iP+Ju7E4sSgLAYd2bmDB/45jSYKTgos16Qk00AqRw1BACU9gYXjqXe
	SWbsl46wdPmGxySlN45OR6L6iFJE8BgfDwuga3s7MvyBK6Ff3+ffvNqltmxXCK6nBwW+zwQK0Cg
	==
X-Received: by 2002:a17:90b:2548:b0:3ac:a521:959 with SMTP id 98e67ed59e1d1-3b1b0ba3583mr1094824a91.29.1794546580015;
        Thu, 12 Nov 2026 21:09:40 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b24938bdsm900781a91.1.2026.11.12.21.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:09:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v2 bpf-next 06/13] resolve_btfids: Fold the constants of a select without a branch
Date: Fri, 13 Nov 2026 05:08:54 +0000
Message-ID: <20261113050901.1399091-7-alexei.starovoitov@gmail.com>
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
	x86-64 GCC            12633       12817
	x86-64 clang          13541       13549
	arm64 clang           12435       12435

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
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
index 9cf8883322cf..231433f61715 100644
--- a/tools/bpf/resolve_btfids/fmodret_scan.c
+++ b/tools/bpf/resolve_btfids/fmodret_scan.c
@@ -137,6 +137,7 @@ int scan_func(struct scan *s, const struct image_func *f, const int64_t **values
 
 	if (err)
 		return err;
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
index 210d749439e7..da464827007d 100644
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
 	/* The registers which it writes, but for dst */
 	u32 defs;
diff --git a/tools/bpf/resolve_btfids/text_mc.cpp b/tools/bpf/resolve_btfids/text_mc.cpp
index e7166ad4b871..d21e343d55a4 100644
--- a/tools/bpf/resolve_btfids/text_mc.cpp
+++ b/tools/bpf/resolve_btfids/text_mc.cpp
@@ -281,6 +281,7 @@ bool match(const MCInst &inst, const Opcode &o, const mc_pattern &pattern, text_
 	ti->dst = dst.nr;
 	ti->src = src;
 	ti->src2 = src2;
+	ti->op = pattern.op;
 	ti->imm = imm;
 	ti->imm2 = pattern.or_zero ? 0 : imm;
 	return true;
@@ -355,6 +356,7 @@ void print(raw_ostream &os, const text_insn &ti)
 {
 	os << "kind " << (int)ti.kind << " is32 " << ti.is32 << " dst " << (int)ti.dst
 	   << " src " << (int)ti.src << " src2 " << (int)ti.src2
+	   << " op " << (int)ti.op
 	   << " defs " << format_hex(ti.defs, 1) << " imm " << format_hex(ti.imm, 1)
 	   << " imm2 " << format_hex(ti.imm2, 1);
 }
@@ -375,6 +377,7 @@ bool run_tests()
 		if (!decode(code.data(), code.size(), MC_TEST_ADDR, &ti) && ti.len == code.size() &&
 		    ti.kind == want.kind && ti.is32 == want.is32 && ti.dst == want.dst &&
 		    ti.src == want.src && ti.src2 == want.src2 &&
+		    ti.op == want.op &&
 		    ti.defs == want.defs && ti.imm == want.imm && ti.imm2 == want.imm2)
 			continue;
 		print(error() << test->code << " is " << d.MII->getName(d.inst.getOpcode()) << ", length "
diff --git a/tools/bpf/resolve_btfids/text_mc.h b/tools/bpf/resolve_btfids/text_mc.h
index 9d39095aab20..ecca0dd5fbbb 100644
--- a/tools/bpf/resolve_btfids/text_mc.h
+++ b/tools/bpf/resolve_btfids/text_mc.h
@@ -63,6 +63,7 @@ struct mc_pattern {
 	u8 dst, src, src2;	/* the numbers of the operands. DST is 0 unless it is given */
 	u8 imm;			/* the operand with the immediate */
 	u8 shift;		/* the operand which says how far the immediate is shifted left */
+	u8 op;			/* of TEXT_ALU_IMM */
 	bool invert;		/* the immediate */
 	bool or_zero;		/* TEXT_MOV_IMM: the immediate or 0 */
 	bool fixed;		/* the immediate is VALUE, not an operand */
diff --git a/tools/bpf/resolve_btfids/text_mc_x86.c b/tools/bpf/resolve_btfids/text_mc_x86.c
index 11223cd1c077..24402ea8c544 100644
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
 	/* A rep prefix is not a part of the MCInst */
 	{ "STOSQ",		TEXT_OTHER, .defs = BIT(RCX) },
@@ -57,6 +62,11 @@ static const struct mc_test x86_tests[] = {
 	T("48 98",		  TEXT_SEXT32, SRC(RAX)),			/* cltq */
 	T("0f 44 c3",		  TEXT_SELECT, .is32 = true, .src = RBX, .src2 = RAX),	/* cmove %ebx, %eax */
 	T("48 0f 44 c3",	  TEXT_SELECT, .src = RBX, .src2 = RAX),	/* cmove %rbx, %rax */
+	T("83 e3 f2",		  TEXT_ALU_IMM, .is32 = true, .dst = RBX, SRC(RBX), .op = TEXT_AND, IMMS(0xfffffff2, 0xfffffff2)), /* and $-14, %ebx */
+	T("48 83 e3 f2",	  TEXT_ALU_IMM, .dst = RBX, SRC(RBX), .op = TEXT_AND, IMMS(-14, -14)),	/* and $-14, %rbx */
+	T("83 eb 0e",		  TEXT_ALU_IMM, .is32 = true, .dst = RBX, SRC(RBX), .op = TEXT_SUB, IMMS(14, 14)), /* sub $14, %ebx */
+	T("48 83 eb 0e",	  TEXT_ALU_IMM, .dst = RBX, SRC(RBX), .op = TEXT_SUB, IMMS(14, 14)),	/* sub $14, %rbx */
+	T("f7 d0",		  TEXT_ALU_IMM, .is32 = true, .op = TEXT_XOR, IMMS(0xffffffff, 0xffffffff)), /* not %eax */
 	T("f0",			  TEXT_OTHER),					/* lock */
 	T("f3 48 ab",		  TEXT_OTHER, .defs = BIT(RCX) | BIT(RDI)),	/* rep stosq */
 	/* hasUnmodeledSideEffects() */
-- 
2.55.0

