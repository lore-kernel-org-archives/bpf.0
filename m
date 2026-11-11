Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374127;
	b=tu3AhP2y7bhZM7JDdSX2XMCEIiRLvYmzhwV6qhkW9fVHhKQgvddGMDoSf34uO9S+SUcO
	 KddfgYTpcFvwnU5ObyQE8y0X1OnwEnDsQ/ghehzhRw7e3sFisPiJDqBUCXLOYLnfyxoe1
	 Dm5v4mCkuc/Z3xHt7yxy9vrX2rPEVWozLQr+QfZBW7NdoT6i9rM+Wtb1pcQBbRn69zxWu
	 fVgm+NVhfHOWHcsruIt1voouOvZ3JpnSnw/pHPEuniQjlRj7hgRC9qXPv1Thk4zhXWrG1
	 QWvVBNj6ASXi4b5uoHkygsh7s5NTk1bElKy6ibPGW6EuEbZ1tbRbSUQtPZAGchQ67gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oOODrqM4lU1W5uA6wonOmsRnqszFLu1ucD5pl1nTKVE=;
	b=TFEEKdrwYVTfRSYj/koPAEEo8qhWpktZzKrtCaGLmMx1otoU08P5CKqxSPUdfoR7puFT
	 gmvX9/v4YTDjQrSv7snYfAfQv9V6Wd1UZodifnQWHTEaaHT/Oujs2IwrBw72kHoVQW5Lx
	 ysJIL7lqx8SUqs8I4RA8H0qYnxIX2Uuyt3hxJ8a0PiaZK6HaqelUk4Z54yd7/Yp317Bxo
	 5weBlRFadiCfTeLIPPbhhWnpwBYikldF2fObvySwdIisyxeQI+tG5EW9oXfkQRRH0ZbjK
	 8iiGYcUx8dOlqvY5NbeB8qcSyNxRJPEuABcKk5ozMt1nLLHIjqviFXm9SkBABrwygwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s5eHMwcK;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07E606A32D
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF07E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s5eHMwcK
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0d09df973so2195396a91.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374121; x=1794978921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oOODrqM4lU1W5uA6wonOmsRnqszFLu1ucD5pl1nTKVE=;
        b=s5eHMwcKw531c6VXUWqOpq+ofg5GpqnHy6M3xSVg81zPdPGki6xc7p5PCY2AlQegdZ
         npMVVssrwVaSOnkOQSaeddIzJF5fp0LC/V0JOuwF48DoWLCrpdqoG1TC1qG/Q4pMl0vy
         YBoDgOFAjcqUfiSfsf6dFGg57jFTQoim99w81m2EHkUfqKV9mXv7UII7dmK37qrsIWOX
         8lXEsvp1P5izsdzEqFQHwoMmqgAMeQx4gr1kfPl0EmG3ewvOBqNWZgsRCapzbrqad+Lt
         An5mciI1xGRhNRaKXQ3y+bzaa105z0jABcXid0rB6LQpdoTNWwzQRLQqmN2273FEi0e9
         SKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374121; x=1794978921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oOODrqM4lU1W5uA6wonOmsRnqszFLu1ucD5pl1nTKVE=;
        b=N4VDlLF98ArHxfb3Tsux9XbNA57LaEBaxq7Pcv8hI4YoACLHhjXcGITRiIeKO0toEK
         R45hq90p6lnv/oyweViekk9LHLKs/WIO2SlUODwczvmVFuibaeAxisa15LFzj70sabaH
         38meYP65GzQHEmz3S57JQagag0FmPmY5b/pdPRDFHc50BrNKn6uU7s8VaV5lYQyve9Qz
         pxoWrKq+zuUfOpUjaAQiLB1i4CAusaOQRjgb+KpXWfXnssOLlDW3wauEJJfO6vFTM8Mq
         IPSDFAmERIoA1QQFlMFzieo9tUC2kBA3WtGfYmxdtssNO8MykXhjJMoWv5h3/JX4bs2Q
         jM7g==
X-Gm-Message-State: APuU4Z94uYgkWzMhvZGoziZDiDrDwHYSnhXN3byY9tiPC4SLE5aSYrx1
	1xLvGAPcZUobxLKoCPS39ZBsGn/2OYD+EXkmDBNPHj9X5KeVtMOuMZ3bjeLK9w==
X-Gm-Gg: AYBFou3LoEOPaK1KTftP6fIvyvnXLSYG6EiT9Jtdl14MgL6OHYAnWo5c/pCSnqewdCL
	17v9OmIbqQKO/vFOsfEcjyFxl7CcNZT8dwQpKM/4KSXQN3zMTIdTpwS/ALSV0kJlg/ZJePsmw34
	gibmJfCohuZuDOcLeCKE4M/fF4cWCGZDXGQHSqALx8PxXPCbgGdjRbIJw5GXjEiXiJvxc2lI6SD
	fgNNyTc5hCAZlk4cEtzdASDozVICfBcfye4PsnAKXHBzrzsxZ5xKPM+Ho+GzMToCPgg2BgwCnlH
	ifsBFhJAL2Nx+9wGasOB1oWGk9q59STLg9t76+X1pAGMIKiJTRRp00ZOgmyW6pierVW17WNotUZ
	UxSjtt+aexPQoflYWWKkbgLsJqejeLhAArvVuHSGCHFb6qiZKh+cN+1z3rZcy3uBfjShNTPJMWd
	6G4eEXz6ya0KFty0t6fVBXVmlGKfvQH6J0Eaxe8Ax0bHDiXWHRg+j/wJc+am/r1fbHwXPa03zQP
	F3ltpuLM2ILTXDYaZYUTbEfFSE3NGsx5WybWI4aR5+/r+0FOPgudVNVkif20bohboT4RT+vkuVf
	iCHgh4tg83ecFLjww1eW4NAp0eLgwoIOGm9y+n3Pi4VFaylsKcZtlm1vaa+WCNy/GfBKQ9Dx5x9
	CV8vC/laQx2wgPWTfujfvIy74YXqOxwxN5X7s0Ez94xcpW0/zQuK1QVVy6dUUnObWg/VuAcGg+q
	w=
X-Received: by 2002:a17:90b:1c01:b0:3ab:e588:c29b with SMTP id 98e67ed59e1d1-3b182defa51mr1496964a91.5.1794374120862;
        Tue, 10 Nov 2026 21:15:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db321dfsm2745991a91.5.2026.11.10.21.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:15:20 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 16/29] bpf: Recompute a pointer after the jump that bounds its index
Date: Wed, 11 Nov 2026 05:13:27 +0000
Message-ID: <20261111051341.2800252-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

A new ability. It extends the patch that refines linked registers at
conditional jumps to 'p = buf + i' that is computed before i is bounded.
Nothing links a pointer to its index today.

	while (buf[i]) {
		if (i < 0 || i > 32)
			break;
		if (bpf_map_lookup_elem(&names, buf + i))
			return 0;
		while (buf[i++] && i < 32)
			;
	}

Strings are stored back to back in a map value of 64 bytes, a key has 32.
clang computes 'buf + i' for the load at the end of an iteration and tests
i at the start of the next one. The jumps bound r8, the offset of r2 stays:

	27: r2 = r6
	28: r2 += r8
	30: r1 = *(u8 *)(r2 +0)
	36: if r8 s> 0x20 goto pc-4
	38: if r8 s< 0x0 goto pc-6
	41: call bpf_map_lookup_elem#1
	invalid access to map value, value_size=64 off=33 size=32

The linked registers of a conditional jump are the live registers and
stack slots that are a tested register + a constant on every path to the
jump. bpf_scev_next_linked_reg() gets one more result. A linked register
can be a pointer: *base_regno + regno + delta. *base_regno is the address
base, as in store_base_regs. Here r2 == r6 + r8.

So 'r2 = r6; r2 += r8' after the jump would change no value at run time,
and a state that is sound before two insns is sound after them.
recompute_ptr() applies their transfer function. Type, object and offset of
r2 are taken from r6 as it is now; how r2 was computed does not matter. The
range is that of r8 after the jump.

match_linked_add(): the expression of r2 is (+ x y), y has a constant
difference from the tested register, and a live register or stack slot has
one from x. At a loop header r2 is a phi. There ADD_SCEV has its operands:

	scev at header 35:
	  r2=(+ r6 %r8.21?) / (add r6 r8)
	  r8=%r8.21?

(add r6 r8): r2 == r6 + r8 at the header in every iteration. It holds at
loop entry, where r2 is r6 and r8 is 0. Every backedge preserves it: the
backedge values, before the '/', are r6 + %r8.21? and %r8.21?, the def of
r8 by the nested loop at 21. r6 and r8 are the header phis here, not the
entry values as below LINEAR_SCEV.

recompute_ptr() replaces r2 only if
 - r6 is a pointer that may have a variable offset, and no packet pointer,
 - type, object and ids of r6 are those of r2,
 - the new range is a subset of the old one and not empty (an empty range:
   the path is infeasible),
 - the loader has CAP_PERFMON: the cpu can speculate past the jump with an
   out-of-bounds index.
The old offset is replaced, not intersected: a state cannot distinguish two
values of a hash map, so the two offsets may belong to two objects. In
a prog with an arena the add has a def, %r2.28=(add r6 r8), and is trusted
once the main pass has verified insn 28 without an arena pointer.

Not found: 'buf += i', which overwrites the base, and an add whose base is
dead at the jump. No register holds buf there.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   4 +-
 kernel/bpf/scev.c            | 174 +++++++++++++++++++++++++++++++----
 kernel/bpf/verifier.c        |  53 ++++++++++-
 3 files changed, 208 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d1841f68437d..11025ed77a7f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2226,7 +2226,9 @@ void bpf_free_scev(struct bpf_verifier_env *env);
 int bpf_compute_scev(struct bpf_verifier_env *env);
 int bpf_scev_jump_counts(struct bpf_verifier_env *env, int header, int n, bool taken_leaves);
 bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
-			      u32 *linked_regno, u32 *fill_off, s64 *delta, u32 *bits);
+			      u32 *linked_regno, u32 *fill_off, int *base_regno, s64 *delta,
+			      u32 *bits);
+bool bpf_is_widenable_reg_type(const struct bpf_reg_state *reg);
 bool bpf_scev_in_slice_slots(struct bpf_verifier_env *env, int off, u32 size, bool fixed_off);
 
 int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index f45abe90d498..50b440142bf9 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -50,6 +50,11 @@ enum expr_op {
 	 * equal when the loop is entered. Not known otherwise.
 	 */
 	COPY_SCEV,
+	/*
+	 * (add rB rC) is the SCEV of rA: rA == rB + rC at the header in every iteration. rB and rC
+	 * are the header phis here, not the entry values as below LINEAR_SCEV.
+	 */
+	ADD_SCEV,
 };
 
 /*
@@ -66,9 +71,9 @@ enum expr_op {
  * In the env of loop H a phi at H merges the backedge values only, the header phi itself is
  * (REG r). In the env of the enclosing loop a phi at H merges the entering edges.
  * Op and params of a def by an insn are what that insn computes, see alu64_with_def():
- * set_expr_base() looks through such an add, split_const_offset() checks prevent_zext of the insn.
- * Those of a phi are the shape that its operands share, no insn computes them: nothing looks
- * through a phi.
+ * set_expr_base() and match_linked_add() look through such an add, split_const_offset() and
+ * match_linked_add() check prevent_zext of the insn. Those of a phi are the shape that its operands
+ * share, no insn computes them: nothing looks through a phi.
  */
 struct expr_def {
 	u32 set:1;	/* 0: the expression has no def */
@@ -261,6 +266,8 @@ static bool expr_is_vn(struct scev *scev, struct expr *e)
 	/* a function of the iteration number */
 	case LINEAR_SCEV:
 	case COPY_SCEV:
+	/* a relation between header phis */
+	case ADD_SCEV:
 		return false;
 	}
 	for (i = 0; i < op_params_num(e->op); i++)
@@ -568,6 +575,7 @@ static const char *op_str(u32 op)
 	case ANY:      return "any";
 	case LINEAR_SCEV:  return "linear";
 	case COPY_SCEV:    return "copy";
+	case ADD_SCEV:     return "add";
 	}
 	return NULL;
 }
@@ -591,6 +599,7 @@ static u32 op_params_num(u32 op)
 	case ANY:
 	case LINEAR_SCEV:
 	case COPY_SCEV:
+	case ADD_SCEV:
 		return 2;
 	case BPF_NEG:
 	case SEXT8:
@@ -1954,6 +1963,41 @@ static bool const_diff_at_header(struct bpf_verifier_env *env, int h, u32 ra, u3
 	       bits_a == 64 && bits == 64;
 }
 
+/*
+ *	p = buf + i; if (i > 100) return 0; *p = 0;
+ * @tested is the expression of the tested register and @id that of p, in one env as for
+ * const_diff(). Is @id an add, and one operand @tested + a constant? Then
+ * @id == *@other + @tested + *@delta (mod 2^*@bits). A header phi can be an add, see ADD_SCEV. For
+ * an add with a def see split_const_offset(). Which operand is the pointer is not known here.
+ */
+static bool match_linked_add(struct bpf_verifier_env *env, int h, u32 tested, u32 id, u32 *other,
+			     s64 *delta, u32 *bits)
+{
+	struct scev *scev = env->scev;
+	u32 reg, r, b, op = BPF_ADD;
+	struct expr_def def;
+	s64 c;
+
+	split_const_offset(env, id, &id, delta, bits);
+	if (h >= 0 && is_reg(scev, id, &reg)) {
+		id = find_header_env(scev, h)->reg2scev[reg];
+		op = ADD_SCEV;
+	}
+	def = scev->exprs[id].def;
+	if (!is_binop(scev, op, id, other, &r) || def.phi)
+		return false;
+	if (def.set && !env->insn_aux_data[def.idx].prevent_zext)
+		*bits = min(*bits, 32);
+	if (!const_diff(env, h, tested, r, &c, &b)) {
+		swap(*other, r);
+		if (!const_diff(env, h, tested, r, &c, &b))
+			return false;
+	}
+	*delta = (u64)*delta + c;
+	*bits = min(*bits, b);
+	return true;
+}
+
 /* The first bytes of a stack slot are its high bits */
 static bool is_big_endian_slot(u32 reg)
 {
@@ -2005,9 +2049,10 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 	u32 dst = e->reg2expr[insn->dst_reg], src = dst;
 	struct insn_envs *envs = env->scev->envs[idx];
 	struct scev *scev = env->scev;
-	u32 r, id, fill_off, base, base_dst, base_src, bits, cap, tested = 0;
+	u32 r, q, other, id, fill_off, base, base_dst, base_src, bits, cap, tested = 0;
 	u32 first = scev->linked_cnt;
 	DECLARE_BITMAP(live, REGS_NUM) = {};
+	DECLARE_BITMAP(found, REGS_NUM) = {};
 	void *tmp;
 	s64 delta;
 
@@ -2024,12 +2069,27 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 		id = e->reg2expr[r];
 		/* most are not linked */
 		split_const_offset(env, id, &base, &delta, &bits);
-		if (base != base_dst && base != base_src && (h < 0 || !is_op(scev, base, REG)) &&
-		    !is_big_endian_slot(r))
+		if (base != base_dst && base != base_src && !is_op(scev, base, BPF_ADD) &&
+		    (h < 0 || !is_op(scev, base, REG)) && !is_big_endian_slot(r))
 			continue;
-		if (!const_diff_reg(env, h, dst, r, id, &fill_off, &delta, &bits) &&
-		    (src == dst || !const_diff_reg(env, h, src, r, id, &fill_off, &delta, &bits)))
+		if (const_diff_reg(env, h, dst, r, id, &fill_off, &delta, &bits) ||
+		    (src != dst && const_diff_reg(env, h, src, r, id, &fill_off, &delta, &bits))) {
+			__set_bit(r, found);
+			continue;
+		}
+		if (!match_linked_add(env, h, dst, id, &other, &delta, &bits) &&
+		    (src == dst || !match_linked_add(env, h, src, id, &other, &delta, &bits)))
 			continue;
+		/* an add is of use only with a live register that holds its other operand */
+		for_each_set_bit(q, live, REGS_NUM) {
+			if (q == r || !const_diff(env, h, e->reg2expr[q], other, &delta, &bits))
+				continue;
+			__set_bit(r, found);
+			__set_bit(q, found);
+			break;
+		}
+	}
+	for_each_set_bit(r, found, REGS_NUM) {
 		if (scev->linked_cnt == scev->linked_cap) {
 			cap = max(scev->linked_cap * 2, 16);
 			tmp = kvrealloc(scev->linked, array_size(cap, sizeof(*scev->linked)),
@@ -2041,7 +2101,7 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 		}
 		tested += r == insn->dst_reg || (src != dst && r == insn->src_reg);
 		scev->linked[scev->linked_cnt].reg = r;
-		scev->linked[scev->linked_cnt++].id = id;
+		scev->linked[scev->linked_cnt++].id = e->reg2expr[r];
 	}
 	/* nothing but the tested registers */
 	if (scev->linked_cnt - first == tested) {
@@ -2065,14 +2125,18 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
  * the same frame. It is a register, or MAX_BPF_REG + the index of a stack slot: a fill from byte
  * *@fill_off of the slot reads these bits. *@pos is the position of the search, 0 at first. False:
  * no more links are known. Types are not known here: the caller checks them in its state.
+ * A linked register can be a pointer: *base_regno + regno + delta. *base_regno is the address base,
+ * as in store_base_regs. It is -1 for a link without a base.
  */
 bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
-			      u32 *linked_regno, u32 *fill_off, s64 *delta, u32 *bits)
+			      u32 *linked_regno, u32 *fill_off, int *base_regno, s64 *delta,
+			      u32 *bits)
 {
 	struct insn_envs *envs = env->scev->envs[insn_idx];
 	int h = bpf_loop_at_index(env, insn_idx);
 	struct scev_linked_reg *linked;
-	u32 i;
+	u32 i, j, other, b;
+	s64 c;
 
 	if (!envs || !envs->linked_cnt)
 		return false;
@@ -2083,10 +2147,22 @@ bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 re
 			return false;
 	for (; *pos < envs->linked_cnt; ++*pos) {
 		*linked_regno = linked[*pos].reg;
-		if (*pos != i &&
-		    const_diff_reg(env, h, linked[i].id, *linked_regno, linked[*pos].id, fill_off,
+		*base_regno = -1;
+		if (*pos == i)
+			continue;
+		if (const_diff_reg(env, h, linked[i].id, *linked_regno, linked[*pos].id, fill_off,
 				   delta, bits))
 			return true;
+		if (!match_linked_add(env, h, linked[i].id, linked[*pos].id, &other, delta, bits))
+			continue;
+		for (j = 0; j < envs->linked_cnt; j++) {
+			if (j == *pos || !const_diff(env, h, linked[j].id, other, &c, &b))
+				continue;
+			*base_regno = linked[j].reg;
+			*delta = (u64)*delta + c;
+			*bits = min(*bits, b);
+			return true;
+		}
 	}
 	return false;
 }
@@ -2561,6 +2637,64 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 	return 0;
 }
 
+/*
+ * Find a SCEV register with the entry value @x and the backedge value @l, and one with @y and @r.
+ * All that match are copies of each other at the header: take the first.
+ */
+static bool find_operands(struct env *entry_env, struct env *header_env, u32 x, u32 y, u32 l, u32 r,
+			  u32 *rb, u32 *rc)
+{
+	for (*rb = 0; *rb < REGS_NUM; ++*rb)
+		if (entry_env->reg2expr[*rb] == x && header_env->reg2expr[*rb] == l)
+			break;
+	for (*rc = 0; *rc < REGS_NUM; ++*rc)
+		if (entry_env->reg2expr[*rc] == y && header_env->reg2expr[*rc] == r)
+			break;
+	return *rb < REGS_NUM && *rc < REGS_NUM;
+}
+
+/*
+ *	p = buf; i = 0; while (*p) { if (i > 512) break; use(p); i += len(p); p = buf + i; }
+ * rA == rB + rC holds at the header in every iteration: it holds at loop entry and every backedge
+ * preserves it. The backedge values are rA = (+ l r), rB = l, rC = r. The entry values, by the env
+ * of the enclosing loop at @h, are rA = x, rB = x, rC = 0 or rA = (+ x y), rB = x, rC = y.
+ * (add rB rC) keeps the def of (+ l r), see alu64_with_def().
+ */
+static int compute_header_adds(struct bpf_verifier_env *env, int h)
+{
+	struct scev *scev = env->scev;
+	struct env *entry_env = find_loop_env(scev, env->insn_aux_data[h].loop_header, h);
+	struct env *header_env = find_header_env(scev, h);
+	u32 ra, rb, rc, l, r, x, y, entry_expr;
+	struct expr_def def;
+	int id, zero = imm_expr(scev, 0);
+
+	if (zero < 0)
+		return zero;
+	for (ra = 0; entry_env && ra < REGS_NUM; ra++) {
+		entry_expr = entry_env->reg2expr[ra];
+		if (header_env->reg2scev[ra] != UNKNOWN_EXPR_ID ||
+		    !is_add(scev, header_env->reg2expr[ra], &l, &r) ||
+		    !scev->exprs[entry_expr].is_vn || !scev->exprs[l].is_vn ||
+		    !scev->exprs[r].is_vn)
+			continue;
+		if (!find_operands(entry_env, header_env, entry_expr, zero, l, r, &rb, &rc) &&
+		    !find_operands(entry_env, header_env, zero, entry_expr, l, r, &rb, &rc) &&
+		    (scev->exprs[entry_expr].def.set || !is_add(scev, entry_expr, &x, &y) ||
+		     (!find_operands(entry_env, header_env, x, y, l, r, &rb, &rc) &&
+		      !find_operands(entry_env, header_env, y, x, l, r, &rb, &rc))))
+			continue;
+		/* expr2() can move exprs[] */
+		def = scev->exprs[header_env->reg2expr[ra]].def;
+		id = expr_with_def(scev, expr2(scev, ADD_SCEV, REG_EXPR_ID(rb), REG_EXPR_ID(rc)),
+				   def);
+		if (id < 0)
+			return id;
+		header_env->reg2scev[ra] = id;
+	}
+	return 0;
+}
+
 /*
  * 'sum += a[i]', 'if (..) { len -= n; len -= 2; }': is 'id', what an iteration makes of
  * register 'r', the register plus or minus something, or the register as it was?
@@ -2729,9 +2863,13 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 					   find_loop_env(scev, header, idx));
 		if (err)
 			return err;
-		if (aux[idx].loop)
+		if (aux[idx].loop) {
 			scev_compute_linear_regs(scev, aux[idx].loop,
 						 find_header_env(scev, header));
+			err = compute_header_adds(env, idx);
+			if (err)
+				return err;
+		}
 		err = find_linked_regs(env, aux[idx].loop ? &scev->identity_env :
 				       find_loop_env(scev, header, idx), header, idx);
 		if (err)
@@ -3970,7 +4108,7 @@ static bool is_const_scev_reg(struct bpf_verifier_env *env, int insn_idx, u32 r)
 }
 
 /* Main logic in verifier.c forbids varying offsets for certain register types. */
-static bool is_widenable_reg_type(const struct bpf_reg_state *reg)
+bool bpf_is_widenable_reg_type(const struct bpf_reg_state *reg)
 {
 	if (type_may_be_null(reg->type))
 		return false;
@@ -4017,7 +4155,7 @@ static bool is_widenable_any(struct bpf_verifier_env *env, struct bpf_func_state
 	if (!is_any(scev, id, &l, &rr))
 		return false;
 	reg = scev_reg_for_read(env, loop_entry, r);
-	if (!reg || !is_widenable_reg_type(reg))
+	if (!reg || !bpf_is_widenable_reg_type(reg))
 		return false;
 
 	scev->stack_sz = 0;
@@ -4550,7 +4688,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		}
 		/* If SCEV for r is (linear <reg> <slope>) */
 		if (reg && is_linear_at_header(scev, cur_func, r_scev, r, &coefs) &&
-		    is_widenable_reg_type(reg)) {
+		    bpf_is_widenable_reg_type(reg)) {
 			/* 32-bit ALU operations on pointers convert them to scalars */
 			if (coefs.zext32 && reg->type != SCALAR_VALUE)
 				goto cant_widen;
@@ -4893,7 +5031,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		 * bpf_compute_loop_iters() gives no range to a pointer to arena that moves, and
 		 * it does not look at dead registers. Set a range only where it would.
 		 */
-		if (!is_widenable_reg_type(entry_reg) ||
+		if (!bpf_is_widenable_reg_type(entry_reg) ||
 		    (coefs.zext32 && entry_reg->type != SCALAR_VALUE))
 			continue;
 clamp:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 138581a759bb..c2a3f74d441f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19741,6 +19741,43 @@ static struct bpf_reg_state *scev_reg_for_fill(struct bpf_func_state *frame, u32
 	return &ss->spilled_ptr;
 }
 
+/*
+ *	p = buf + i; if (i > 100) return 0; *p = 0;
+ * p is @dst_reg, x is @ptr_reg, i is @off_reg. Scalar evolution says that p == x + i. So the insns
+ * 'p = x; p += i' are a no-op at run time, and a state that is sound before them is sound after
+ * them: apply their transfer function. Type, object and offset of p are taken from x as it is now;
+ * how p was computed does not matter.
+ * The old p is replaced, not intersected: a state does not distinguish two values of one hash map,
+ * and the intersection of an offset into the one with an offset into the other holds for neither.
+ * It is replaced only if the new range is a subset of the old one. An empty range is a subset too:
+ * the path is infeasible, p is left as it is.
+ */
+static bool recompute_ptr(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
+			  const struct bpf_reg_state *ptr_reg, const struct bpf_reg_state *off_reg)
+{
+	struct bpf_reg_state sum = *ptr_reg;
+
+	/* the cpu can speculate past the jump with an out-of-bounds index */
+	if (!env->bypass_spec_v1)
+		return false;
+	/* 'p += i' assigns a new id to a packet pointer */
+	if (ptr_reg->type == SCALAR_VALUE || type_is_pkt_pointer(ptr_reg->type) ||
+	    !bpf_is_widenable_reg_type(ptr_reg))
+		return false;
+	__mark_reg32_unbounded(&sum);
+	scalar_step_add(&sum, ptr_reg, off_reg);
+	sum.r64 = cnum64_add(ptr_reg->r64, off_reg->r64);
+	sum.var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
+	reg_bounds_sync(&sum);
+	if (reg_is_empty(&sum) || const_tnum_range_mismatch(&sum) ||
+	    const_tnum_range_mismatch_32(&sum))
+		return false;
+	if (!bpf_reg_union_compatible(dst_reg, &sum) || !cnum64_is_subset(dst_reg->r64, sum.r64))
+		return false;
+	*dst_reg = sum;
+	return true;
+}
+
 /*
  * The jump at @idx refined @regno. A register that scalar evolution links to it holds
  * @regno + delta on every path to the jump: intersect the two. The intersection is empty: no
@@ -19750,15 +19787,16 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 			       int idx, u32 regno)
 {
 	struct bpf_func_state *frame = vstate->frame[vstate->curframe];
-	struct bpf_reg_state *reg, implied, saved;
+	struct bpf_reg_state *reg, *base_reg, implied, saved;
 	u32 pos, linked_regno, fill_off, bits;
+	int base_regno;
 	s64 delta;
 
 	if (frame->regs[regno].type != SCALAR_VALUE)
 		return;
 	for (pos = 0;
-	     bpf_scev_next_linked_reg(env, idx, regno, &pos, &linked_regno, &fill_off, &delta,
-				      &bits);
+	     bpf_scev_next_linked_reg(env, idx, regno, &pos, &linked_regno, &fill_off, &base_regno,
+				      &delta, &bits);
 	     pos++) {
 		reg = scev_reg_for_fill(frame, linked_regno, fill_off, bits);
 		/*
@@ -19770,11 +19808,17 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 			bits = 32;
 			reg = scev_reg_for_fill(frame, linked_regno, fill_off, bits);
 		}
-		if (!reg || reg->type != SCALAR_VALUE)
+		if (!reg || (base_regno < 0 && reg->type != SCALAR_VALUE))
 			continue;
 
 		implied = frame->regs[regno];
 		add_scalar_to_reg(&implied, delta);
+		if (base_regno >= 0) {
+			base_reg = scev_reg_for_fill(frame, base_regno, 0, 64);
+			if (base_reg && bits == 64 && recompute_ptr(env, reg, base_reg, &implied))
+				goto scratch;
+			continue;
+		}
 		if (regs_fit_in_bits(reg, &implied, bits))
 			bits = 64;
 		if (bits < 32)
@@ -19797,6 +19841,7 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 			*reg = saved;
 			continue;
 		}
+scratch:
 		if (linked_regno < MAX_BPF_REG)
 			mark_reg_scratched(env, linked_regno);
 		else
-- 
2.55.0

