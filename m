Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498864;
	b=o7lBCwuLiMkIOgfzojak9ibY2XvY2lZtgjdqoU+LcPiJMUZEgVlVl4iK0XlELgM5M0g+
	 vBJddPSR+Y2PpyRmjd7jXv1tN6AP3Qgum3LA2+f/arthw9lhueCnWwq9TvhLhOVi1E90N
	 k/85W3y31gbY09Yeod8k5aQ9f5T0Nt29IihD6AD/eoWAUyoxzkUYK7K7HYB/n5nwYs4dZ
	 ldDEOiIz2Dd4hpPU2e4TCgEuoNToEMNkEAPBSJB2dM2s33vFsl+XFOLTiLhdYYbr9kdZx
	 Gf8a/gBufrAdFTYXCmy1xbwpx4gpmrUauEgyzELE6PnrmcXCvmsEZu4fJ53B+t2Fp7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8qdm3SNpYXeFY/Ful0f6JaU3PLgiAwuEl7Jl8mzsFeE=;
	b=lb2VXi1eJB9qCeD/VE/QiSjHlVRFbNl+0tLwsDG8vTsUZGkRifnhD5I346HMadMvS3Y3
	 Q1zwgz2Ezy8C3P/BuKZZZOthM/4PIagQHYmiYm0x1WsmAHciDwYqrXolPZAqag0kW/JYw
	 cXhCjZClzj5/mSunDUewNAUIqqJEciake4xqKs1+wDJv0Jog/1dKWud0ZEaLc0j1kuI1l
	 qjVaHxlTySPViz1MYPO2YHoawjmM0E1OkebtSWHXY5/19iIB7n24zp01gzgmcuTe4cjV5
	 QdmUMDmxiLzPjrK59shxmHci5xqzb1hKVzT7KyZd9A9I5ig7xyQkPMc7NbqFiy6gVuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lg62D+o+;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA6606A327
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8AA6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lg62D+o+
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so2641882a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498862; x=1795103662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8qdm3SNpYXeFY/Ful0f6JaU3PLgiAwuEl7Jl8mzsFeE=;
        b=lg62D+o+XPCZWaBj0NUbStVtZGu51Wr4BL9HxVnKbyKWslh9VBEnHcbz0G3cYXJeaq
         DUpjUJKrzc1OfhyFvZMmkhLt9agyICF8xqFdxqd5NunJo9wis+Ed6Z9eeQUn3yBnF48H
         FD+JPo4qGTJQkN3OoBCfBStTXpJso91vGg6lMKD7l6PUzWtYdWKCp25gk90kzoF5n4J4
         T3U/msogC6B1RWxhNqR31OwFjQFiZLF4Y9icuhVyzRecg8arGnEnVjTZUkclNEdczAdn
         az7LOKzscKKBinA4G0/AZm6iWmWqNh0O8MqlvageLIcltxXLAfSV26fwxMRwi7KVza6p
         tMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498862; x=1795103662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8qdm3SNpYXeFY/Ful0f6JaU3PLgiAwuEl7Jl8mzsFeE=;
        b=PFNgpUPFFgzfPnIxSklcv+Z0P74hLIHH/d5FNIjYg3E89wgm1mXY/M7ahdMMGF2kxk
         QSfho2sPSlTN2HGJjWXXN9NqFqpUjv/gl7qMh9N+NqPoAUPACYWNMdiR3AjjNoLP8DO6
         /DJaC8qt2APsmQhJfytE4VE8KofnGsiF6fmELFlczYbqt0Y8LwTepaUZEZ2nDpsWOOJe
         ELwLNfi4mVPh4LENS++TL+rwLaaWQ8SkZyKZ2aXj9FNyUDl8OUTy6D1nf+WkYzDYKrHJ
         hStIiCKNjuebX+aAuvVcRzUEcv2LlLomOw1yqtjS10siChPiaKq8NO3YPUGSxAvkGBSR
         FNsg==
X-Gm-Message-State: APuU4Z8iUF5GEDTKkLm6rgbymMyYpi+3jsjKT0IWcMq9S4nqXLYBppBv
	0LGI6tq5OPpBya215d6jdiN7v7xZxXYu8e80DDFfZP7OTrZQaLN34NdkoxT4dA==
X-Gm-Gg: AYBFou2MJEJQhd5nQHFkPX5gNtGAPQDWE5KJTlNDlJzW7gFalZcr+ySoneulmNk2HL/
	nkm6nsJFdMFj2fcPdKH/moXu3/3fOX2sExRmB3dsQPeUXXC720FNU/oBASuN3NVolwb8vYlotGJ
	wjCeJf+MWXErJuK426dcJcTpZgY4TITQI8FeRLB9YcaaiGWQ1bWlphoQekxwT3dnxS2aeUYymlh
	uNUNyXzJ3sMuiwWpiuHSo2XiBc6n+vHlTFWUFAv5OWuuxqCUU4BOGi/EoMKcvVIq/5uVWLatHK2
	mZ4Sz3gDa22ehdIvT0NxwdBpw+iVSsjgRgy9wKRwJwhXBbcIaIau2bUUCwXTmQBlP98dQ6aw1HU
	CrVmkFFDxINpj/EzdpWhgLWTNgabgAAgVF0q+oevqSv2YoFBH7qr91FzmR+GE7MA8IXkRCwHAh6
	h5snQGwsoAx0ZkBMaxwqyjfnbFhC2UYJaLscWxPv71Mk5OCaB8S//LF0PqMDusPJ2kgQYMNZUs4
	3SMkVlAPMP7yOZJU5n5bLr1sgJlkdCLqSJtlTR9X83rvwMGprFeVwdihmT5hJU6jg34PMHUfuiY
	FvVv1w+Y8ofRusJsbmmPPYKN7QucRa0nWpIJ2d0M1YKEHTUiae90GbAizYrGgycsP6wZOB31J4W
	ojlHVI1Qn7UKPGq+gmKpH9Qe4X+JgIy4IP8aldYx9s7BcoASH4GISvMIFnsxV9j9ozEODldBIaZ
	E=
X-Received: by 2002:a17:90b:3e82:b0:3a7:a6bc:9d58 with SMTP id 98e67ed59e1d1-3b182f36310mr5807327a91.54.1794498862248;
        Thu, 12 Nov 2026 07:54:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27cf1sm5375860a91.12.2026.11.12.07.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:54:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 07/12] bpf: Take the outermost common base of two linked expressions
Date: Thu, 12 Nov 2026 15:53:32 +0000
Message-ID: <20261112155337.1040699-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
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

	n = hdr.len;			/* __u16 */
	m = n + 1;
	if ((u32)(n - 1) > 61)
		return 0;
	c = buf[m];			/* char buf[64] */

	r2 = *(u16 *)(r10 - 8)		(zext16 x), x is the stack slot
	r3 = r2
	r3 += 1				(+ (zext16 x) 1)
	w4 = w2
	w4 += -1			(zext32 (+ (zext16 x) -1))
	if r4 > 61 goto out
	r1 = r6
	r1 += r3
	r0 = *(u8 *)(r1 + 0)
	invalid access to map value, value_size=64 off=65536 size=1

The base of an expression is what is left when constants, extensions and
partial spills are stripped. It is x for r3 and for r4, so const_diff()
says that they have a constant difference modulo 2^16. r3 is [1, 65536]
and does not fit in a u16: the jump does not refine it.

An extension has the low bits of its operand, and it is a value number of
its own: r3 and r4 are (zext16 x) + a constant modulo 2^32. Both fit in
a u32: r3 is [2, 63] after the jump.

Make an extension and a partial spill their own base. set_expr_base()
strips constants only, so what it caches holds in 64 bits and 'bits' of
struct expr goes. next_base() steps from an extension to the base of its
operand, in fewer bits. const_diff() walks the bases of both expressions
from the outermost one on and takes the first that both have. next_base()
steps to fewer bits only: an expression has four bases at most.

Two expressions that have a constant difference in some bits have the same
innermost base, or they are two header phis. The filter of
find_linked_regs() and forget_dead_mem_regs() compare that base.

'x & 0xffff' is a base of its own today. The next patch makes it an
extension: without this patch 'm = n + 1' would no longer be linked to
'n = x & 0xffff'.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 156 +++++++++++++++++++++++++++-------------------
 1 file changed, 91 insertions(+), 65 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index b413998d9cf9..991f800b1b15 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -90,8 +90,6 @@ struct expr {
 	u16 op;
 	/* A value number: all SCEV registers of an env that have this id hold the same value */
 	bool is_vn;
-	/* expr == base + off (mod 2^bits), see split_const_offset() */
-	u8 bits;
 	/*
 	 * UNKNOWN, OPAQUE and ANY don't describe a value. With a def the id stands for one value,
 	 * see struct expr_def. Without a def every use of the id can be another value.
@@ -101,6 +99,7 @@ struct expr {
 		u32 params[2];
 		s64 imm;
 	};
+	/* expr == base + off, see set_expr_base() */
 	u32 base;
 	/*
 	 * id of the first add on the way to 'base' whose insn may still become ALU32, see
@@ -291,18 +290,14 @@ static bool expr_is_vn(struct scev *scev, struct expr *e)
 	return true;
 }
 
-static u32 op_low_bits(u32 op);
-
 /*
- * @e gets the id @id. (+ x imm), an extension and a partial spill of x have the base of x, which
- * was constructed earlier. mk_phi() sets the base of a phi that it value numbers. Every other
- * expression is its own base. So split_const_offset() does not traverse the expression.
+ * @e gets the id @id. (+ x imm) has the base of x, which was constructed earlier. mk_phi() sets the
+ * base of a phi that it value numbers. Every other expression is its own base, an extension and a
+ * partial spill too, see next_base(). So split_const_offset() does not traverse the expression.
  */
 static void set_expr_base(struct scev *scev, struct expr *e, u32 id)
 {
-	u32 low = op_low_bits(e->op);
 	struct expr *x;
-	s64 imm = 0;
 
 	e->arena_add = 0;
 	/* mk_phi() found the base */
@@ -310,18 +305,12 @@ static void set_expr_base(struct scev *scev, struct expr *e, u32 id)
 		return;
 	e->base = id;
 	e->off = 0;
-	e->bits = 64;
 	/* nothing looks through a phi, see struct expr_def */
-	if (e->def.phi)
-		return;
-	if (e->op == BPF_ADD && scev->exprs[e->params[1]].op == IMM)
-		imm = scev->exprs[e->params[1]].imm;
-	else if (!low || e->def.set)
+	if (e->def.phi || e->op != BPF_ADD || scev->exprs[e->params[1]].op != IMM)
 		return;
 	x = &scev->exprs[e->params[0]];
 	e->base = x->base;
-	e->off = (u64)x->off + imm;
-	e->bits = low ? min(x->bits, low) : x->bits;
+	e->off = (u64)x->off + scev->exprs[e->params[1]].imm;
 	e->arena_add = e->def.set ? id : x->arena_add;
 }
 
@@ -529,6 +518,38 @@ static bool is_low_bits(struct scev *scev, int id, u32 bits, u32 *left)
 	return true;
 }
 
+/*
+ * A value is *@base + *@off (mod 2^*@bits). An extension and a partial spill are values of their
+ * own, and they have the low N bits of their operand: go on to the base of the operand, modulo 2^N.
+ * Only to fewer bits: three steps at most. N is 32 or less: it does not matter if an add on the way
+ * becomes ALU32, see split_const_offset().
+ */
+static bool next_base(struct scev *scev, u32 *base, s64 *off, u32 *bits)
+{
+	struct expr *x, *e = &scev->exprs[*base];
+	u32 low = op_low_bits(e->op);
+
+	/* nothing looks through a phi, see struct expr_def */
+	if (!low || low >= *bits || e->def.set)
+		return false;
+	x = &scev->exprs[e->params[0]];
+	*base = x->base;
+	*off = (u64)*off + x->off;
+	*bits = low;
+	return true;
+}
+
+/* Two expressions that have a constant difference in some bits have the same one, or two REGs */
+static u32 innermost_base(struct scev *scev, u32 id)
+{
+	u32 base = scev->exprs[id].base, bits = 64;
+	s64 off = 0;
+
+	while (next_base(scev, &base, &off, &bits))
+		;
+	return base;
+}
+
 static bool is_any(struct scev *scev, int id, u32 *left, u32 *right)
 {
 	return is_binop(scev, ANY, id, left, right);
@@ -1131,13 +1152,14 @@ static void forget_mem_regs(struct bpf_verifier_env *env, struct env *e, u32 add
  */
 static void forget_dead_mem_regs(struct bpf_verifier_env *env, struct env *e, int idx)
 {
-	struct expr *exprs = env->scev->exprs;
+	struct scev *scev = env->scev;
 	u32 i, r, base;
 
 	for (i = 0; i < MEM_REGS_NUM; i++) {
-		base = exprs[e->reg2expr[REGS_NUM + i]].base;
+		base = innermost_base(scev, e->reg2expr[REGS_NUM + i]);
 		for (r = 0; r < REGS_NUM; r++)
-			if (exprs[e->reg2expr[r]].base == base && reg_alive_at(env, r, idx + 1))
+			if (reg_alive_at(env, r, idx + 1) &&
+			    innermost_base(scev, e->reg2expr[r]) == base)
 				break;
 		if (r == REGS_NUM)
 			forget_mem_reg(e, i);
@@ -1556,17 +1578,15 @@ next:;
 	return expr_with_def(scev, id, def);
 }
 
-static void split_const_offset(struct bpf_verifier_env *env, u32 id, u32 *base, s64 *off,
-			       u32 *bits);
+static u32 split_const_offset(struct bpf_verifier_env *env, u32 id, u32 *base, s64 *off);
 
-/* @id == *@base + *@off in 64 bits: no extension and no partial spill is stripped */
+/* @id == *@base + *@off in 64 bits: no add that may become ALU32 is stripped */
 static void split_const_offset64(struct bpf_verifier_env *env, u32 id, u32 *base, s64 *off)
 {
 	struct scev *scev = env->scev;
-	u32 bits, l, r;
+	u32 l, r;
 
-	split_const_offset(env, id, base, off, &bits);
-	if (bits == 64)
+	if (split_const_offset(env, id, base, off) == 64)
 		return;
 	*base = id;
 	*off = 0;
@@ -1615,7 +1635,6 @@ static int mk_phi(struct bpf_verifier_env *env, u32 a, u32 b, int idx, u32 reg)
 		return id;
 	e.base = id;
 	e.off = off_a;
-	e.bits = 64;
 	return add_expr(scev, e);
 }
 
@@ -2070,29 +2089,26 @@ static int join_added_edges(struct bpf_verifier_env *env, struct bpf_subprog_inf
 }
 
 /*
- * @id == *@base + *@off (mod 2^*@bits): constant offsets, extensions and partial spills are
- * stripped, see set_expr_base(). An add with a def holds modulo 2^32 whether its insn is converted
- * to ALU32 or not, see alu64_with_def(). It holds modulo 2^64 once the main pass has set
- * prevent_zext: it verified the insn without a pointer to the arena and rejects a state that brings
- * one. The def dominates every use, and prevent_zext is only ever set: such an add is not checked
- * again.
+ * @id == *@base + *@off: constant offsets are stripped, see set_expr_base(). Returns the number of
+ * bits in which that holds. An add with a def holds modulo 2^32 whether its insn is converted to
+ * ALU32 or not, see alu64_with_def(). It holds modulo 2^64 once the main pass has set prevent_zext:
+ * it verified the insn without a pointer to the arena and rejects a state that brings one. The def
+ * dominates every use, and prevent_zext is only ever set: such an add is not checked again.
  */
-static void split_const_offset(struct bpf_verifier_env *env, u32 id, u32 *base, s64 *off, u32 *bits)
+static u32 split_const_offset(struct bpf_verifier_env *env, u32 id, u32 *base, s64 *off)
 {
 	struct scev *scev = env->scev;
 	struct expr *add, *e = &scev->exprs[id];
 
 	*base = e->base;
 	*off = e->off;
-	*bits = e->bits;
 	while (e->arena_add) {
 		add = &scev->exprs[e->arena_add];
-		if (!env->insn_aux_data[add->def.idx].prevent_zext) {
-			*bits = min(*bits, 32);
-			break;
-		}
+		if (!env->insn_aux_data[add->def.idx].prevent_zext)
+			return 32;
 		e->arena_add = scev->exprs[add->params[0]].arena_add;
 	}
+	return 64;
 }
 
 static bool const_diff_at_header(struct bpf_verifier_env *env, int h, u32 ra, u32 rb, s64 *delta);
@@ -2100,30 +2116,39 @@ static bool const_diff_at_header(struct bpf_verifier_env *env, int h, u32 ra, u3
 /*
  * @id_a and @id_b are expressions of one env of the loop at @h, or of a subprog: @h is -1. Do they
  * have a constant difference, @id_b == @id_a + *@delta (mod 2^*@bits)?
+ *	n = (u16)x; m = n + 600; if ((u32)(n - 1) < 256) use(m);
+ * m and the tested value are x + a constant modulo 2^16, and n + a constant modulo 2^32: take the
+ * outermost base that both have.
  */
 static bool const_diff(struct bpf_verifier_env *env, int h, u32 id_a, u32 id_b, s64 *delta,
 		       u32 *bits)
 {
 	struct scev *scev = env->scev;
-	u32 base_a, base_b, bits_a, ra, rb;
-	s64 off_a, c;
+	u32 base_a, base_b, bits_a = 64, bits_b, ra, rb;
+	s64 off_a, off_b, c;
 
-	split_const_offset(env, id_a, &base_a, &off_a, &bits_a);
-	split_const_offset(env, id_b, &base_b, delta, bits);
-	*delta = (u64)*delta - off_a;
-	*bits = min(*bits, bits_a);
+	*delta = 0;
+	*bits = 64;
 	/* copies are equal in all bits */
-	if (id_a == id_b && scev->exprs[id_a].is_vn) {
-		*bits = 64;
+	if (id_a == id_b && scev->exprs[id_a].is_vn)
 		return true;
-	}
-	if (base_a == base_b)
-		return scev->exprs[base_a].is_vn;
-	if (h < 0 || !is_reg(scev, base_a, &ra) || !is_reg(scev, base_b, &rb) ||
-	    !const_diff_at_header(env, h, ra, rb, &c))
-		return false;
-	*delta = (u64)*delta + c;
-	return true;
+	*bits = split_const_offset(env, id_a, &base_a, &off_a);
+	do {
+		*bits = min(*bits, split_const_offset(env, id_b, &base_b, &off_b));
+		bits_b = 64;
+		do {
+			c = 0;
+			/* header phis: rb == ra + c */
+			if (base_a == base_b ? !scev->exprs[base_a].is_vn :
+			    h < 0 || !is_reg(scev, base_a, &ra) || !is_reg(scev, base_b, &rb) ||
+			    !const_diff_at_header(env, h, ra, rb, &c))
+				continue;
+			*delta = (u64)off_b - off_a + c;
+			*bits = min3(*bits, bits_a, bits_b);
+			return true;
+		} while (next_base(scev, &base_b, &off_b, &bits_b));
+	} while (next_base(scev, &base_a, &off_a, &bits_a));
+	return false;
 }
 
 /*
@@ -2138,7 +2163,7 @@ static bool const_diff_at_header(struct bpf_verifier_env *env, int h, u32 ra, u3
 	int outer_header = env->insn_aux_data[h].loop_header;
 	struct env *entry_env = find_loop_env(env->scev, outer_header, h);
 	struct env *header_env = find_header_env(env->scev, h);
-	u32 base_a, base_b, bits_a, bits;
+	u32 base_a, base_b, bits;
 	s64 off_a, c;
 
 	if (!entry_env || !can_compute_loop_scev(env->insn_aux_data[h].loop) ||
@@ -2147,10 +2172,9 @@ static bool const_diff_at_header(struct bpf_verifier_env *env, int h, u32 ra, u3
 		return false;
 	if (const_diff(env, -1, header_env->reg2expr[ra], header_env->reg2expr[rb], &c, &bits))
 		return bits == 64 && c == *delta;
-	split_const_offset(env, header_env->reg2expr[ra], &base_a, &off_a, &bits_a);
-	split_const_offset(env, header_env->reg2expr[rb], &base_b, &c, &bits);
-	return base_a == REG_EXPR_ID(ra) && base_b == REG_EXPR_ID(rb) && off_a == c &&
-	       bits_a == 64 && bits == 64;
+	return split_const_offset(env, header_env->reg2expr[ra], &base_a, &off_a) == 64 &&
+	       split_const_offset(env, header_env->reg2expr[rb], &base_b, &c) == 64 &&
+	       base_a == REG_EXPR_ID(ra) && base_b == REG_EXPR_ID(rb) && off_a == c;
 }
 
 /*
@@ -2168,7 +2192,7 @@ static bool match_linked_add(struct bpf_verifier_env *env, int h, u32 tested, u3
 	struct expr_def def;
 	s64 c;
 
-	split_const_offset(env, id, &id, delta, bits);
+	*bits = split_const_offset(env, id, &id, delta);
 	if (h >= 0 && is_reg(scev, id, &reg)) {
 		id = find_header_env(scev, h)->reg2scev[reg];
 		op = ADD_SCEV;
@@ -2209,7 +2233,9 @@ static bool const_diff_reg(struct bpf_verifier_env *env, int h, u32 id_a, u32 re
 	}
 	if (!is_big_endian_slot(reg) || !scev->exprs[id_b].is_vn)
 		return false;
-	split_const_offset(env, id_a, &x, delta, bits);
+	*bits = split_const_offset(env, id_a, &x, delta);
+	while (next_base(scev, &x, delta, bits))
+		;
 	e = &scev->exprs[x];
 	if ((e->op != BPF_RSH && e->op != BPF_ARSH) || e->def.set || e->params[0] != id_b ||
 	    !is_imm(scev, e->params[1], &k) || (k != 32 && k != 48 && k != 56))
@@ -2263,12 +2289,12 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 	for (r = REGS_NUM; r < ENV_REGS_NUM; r++)
 		if (e->mem_addr[r - REGS_NUM])
 			__set_bit(r, live);
-	split_const_offset(env, dst, &base_dst, &delta, &bits);
-	split_const_offset(env, src, &base_src, &delta, &bits);
+	base_dst = innermost_base(scev, dst);
+	base_src = innermost_base(scev, src);
 	for_each_set_bit(r, live, ENV_REGS_NUM) {
 		id = e->reg2expr[r];
 		/* most are not linked */
-		split_const_offset(env, id, &base, &delta, &bits);
+		base = innermost_base(scev, id);
 		if (base != base_dst && base != base_src && !is_op(scev, base, BPF_ADD) &&
 		    (h < 0 || !is_op(scev, base, REG)) && !is_big_endian_slot(r))
 			continue;
-- 
2.55.0

