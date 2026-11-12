Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502011;
	b=ATsJktbmu9Y6LO1uBlVvQ5BoVnpeKWaCLoNcnC84G2f7SsrJqJUWwsXPh2LNRX4ygfq5
	 U54Wr3ctbBoyQZNldXaSNTFsYBn7SZ6ThhXfm+Wl/QN5+oqsgGvuC/pQ9qQnIS+Rs6kY6
	 b7jj/QviZwaPf6TPzSdXi2sKwdOYDGjyF4+E71s8ZbEoUzBrtmhg/P4cKy1A22FCK51LH
	 5F0dnv/mYNSCeAZaoG9R6KJYR2dRnhu/WQvfhXSvSBFIIOREwiQQcX1AYSQ/SpVqkyb3e
	 L+LEwCRDkJnYB2JjamMvAurJqU5zh/E0y1yC7RuOinZDrF+4HT8PtCjaSw16NETIE5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r30230b6a4jdsann4uUCbtvW5gSKGbHIbHOH7+CBkoM=;
	b=gsh2IyKMe7zIME6AQ6F0LGIqL2IV3lM7jqElVSzKzfYtDooxGYeoQWaeii1mIJFYUYVK
	 T54QIwVjZkuzM15bRHJl3t+puoXo+UqRgN7ZMeSdn+Dk8qjwzGL9W77xh4TqJtYqA4BIt
	 3RxkDDN9r/ZjloPadoU1THnPfuZDx1FUN2e8RWZnllxy+8CdRWGocIx/aRXVt2fmWmQS3
	 cKG0G1/89RtJBNimkIHiJpy6qUqiee+0BB/NS28X5NRFhtuPx2SZIqpX1nAS2WMevvpzo
	 FAKerNgaEIDAMLa6YBL4l74iul/lLpsSkEyWyOyPbKs5yJiNG/0/vd+dnKeqZg6Ohlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xmoVdYRB;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2C606A8B0
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB2C606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xmoVdYRB
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so3437648b3a.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794502010; x=1795106810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r30230b6a4jdsann4uUCbtvW5gSKGbHIbHOH7+CBkoM=;
        b=xmoVdYRBnlLl2rO3k0mtB2JA9rLnB+1N//B83ZN8ropA1t4T9oAisPJNfWAhZuAvr6
         YtePi4i90DAwHH/265tkxLYwyeMlC17UGk7FHU+uJieKYVOmhd/75KyAUGgHS6qS1Vms
         1rbJkxyFAeyJ4/dMYfNYouIuvpsnYuHFa/us0RQRGC1IQZGQSrS9//gLZxwTQX71HvrV
         5NuJnrj/GwdC+czOcRvKJZVfO/y28UG+V917AXGsB8CThoGHFLBIh5HjR/Spirh4SGVm
         YMRzcOgGd3hLMkH/XmJW/YrAYh1Zuf0CKvmgBsNYkB8gpsQssexVAmwGn6Ck5C+/pFmR
         4czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502010; x=1795106810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r30230b6a4jdsann4uUCbtvW5gSKGbHIbHOH7+CBkoM=;
        b=K2B6iUyjWnJiOey95dRDUvt8AST7s9YERM3sBzkeyfSeHpELuiaMh1ZWRzcW6u6BDQ
         BvdsbJmUiPZ253pMpqQDdPrSnXTlT+IBHCrxxuhIOFfSWoc0/06HvUZCL5DCbBMQwpFp
         cMN8qBDC69WKYWefBe+4Kq7Hbi5nJwtFYlhEfaI6igLKao2wNQwDJnP20nWPLK10PVY+
         jNom1oK/Fx5zzAnfUMYvRe2imYF8WuFvpq1MX8clCCzHhY/Zz0GptfCRkitW52OiqXfQ
         7j7GDWVioeVhAwV7x2J2SAUdX56Mo5OSyVSRbdnIPnoB8S6boSbTDYEe6f7Q5zIPTpn3
         eHIg==
X-Gm-Message-State: APuU4Z9AwqIAGewx28JVe3o14jq0gtpvdJiKWPbNdCHyFlBbYyV8P1WK
	6OsW6wALgmSwk5itvo4pMNcBsUBOjmhqTG/yLd6oJq6QNxNYVlBdRzjz12efUQ==
X-Gm-Gg: AYBFou0upFRfqRcRs5ORc5cxAgKP5NG69Bwnqhh44b7FjTbacSXvRWgJqIx9Lf4hsf/
	0ABlm1DybzXNLjRECGeRUeePL4w8Z3kkIWGhtCIWVmKbJdNFXOebVCU5W+bv/EcW9Zr3RnQBocJ
	VR+mBNEyJG0eIdTDvnkLsqOSne7JoUpYmxmId2Ol0RNJ2RGNieRHRfBzUSDxJxU2acn4ImFBNdT
	Wl9uym9x9L8MJe+T8pjh9UcOQuA44MC59sW9nk4KC2dQM0PmlPNERnp3VO1xPAQZzkt3GgXMeO3
	BIRmaVp0N6LFuZd0LqF+kBa8hG7ImUU5O6K+qTtGLvlNx6s6Sjk+Y3sYZw8+IblfaspPj0Ig8nA
	nxBvtGuKTXGSH13T52CfYWRnj6D8LHgS9z8ySXi9Xervio4VfKM+W2sT7hCKg7OhEzx6jukka9V
	bwRpQsq3eZhdlErTYnh7MdCONbQc/5lseDx6MJ0qRwXXHlxfsNd17BCY05h5hv7Gl7tb8rtI7uW
	d4RBV2S1dhWNuQIF+5Hz/0TJtCmf4Vcj/172f2LR/k2DTGUabOMxEQYZpMlTQBUqcxC1gdTg26C
	2R45cMbmMugHOGKcNYIXznG8zKEWdBGRWeiM8IQ/RNPOtwH+LZxPu1S0hNywzoK3sYEC0Bwigpf
	dbLkF1ROrA9JGRcheH+QmhUj3jNDxa9npkwanMDLpZqy6KRr+gHX/XYVF74noPlmQqbVEPREDow
	==
X-Received: by 2002:a05:6a20:2d08:b0:3e2:a849:64bc with SMTP id adf61e73a8af0-3f2fa09c4camr7445086637.9.1794502009735;
        Thu, 12 Nov 2026 08:46:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc1889960sm27676a12.15.2026.11.12.08.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:46:49 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 06/10] resolve_btfids: Fold the constants of a select without a branch
Date: Thu, 12 Nov 2026 16:46:06 +0000
Message-ID: <20261112164610.1917256-7-alexei.starovoitov@gmail.com>
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
	arm64 clang           12496       12496

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
index 8099bbc05d8e..a24e5c6c25a9 100644
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

