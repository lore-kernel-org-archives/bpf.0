Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374134;
	b=DfXqsgY6pYSeyU8lrscwH60LPhHfrOygMBvMalflczf4T3jZuiXfnSom1aVh1IYvoVzj
	 CaBOcukVdYXBegak6uuCpS84Sa87QjiAO/Jm7cnVVF4aJb28V4udGV5ombhDVd73izPpi
	 AATayHecJhxaZGnaDiEIlgd1ydc8HZA8//L8igMNLNUoYjvxAbYOKvEJowc1Fq5ZaiSCy
	 EmWlcvGfKKSexwLyP8JH4LDz72onpihW+Ojz+mqQLyt9itLpv3g2WMfbxYjBTjcLLVPIi
	 IVzbScFDvwVfq4f/kn9n7gVguD1aLI4yZ7w1CihhztgaxxLnXKyPGDz9OVyoTBDPjrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UqgOseBrsOg92jgrvQE3YiNVxmX+mwESG+PkFCv8OdU=;
	b=YvYE/tQ7CBIC0wf1DLiT8Xm7eexCIAP0iJmsEYaLcc9JxHgX4RlLCe03Szsdnk/R9rNZ
	 VtomUPyKn/VidBPi8Zs+Rnyo3AAQmemDVZoAbF3maXh2yCiG/o7gcEWdC++NGCzvWQE9X
	 01VxOOwKCkXf7/9QgKl0XR1DvtWsTgDJYwGhtIGYwJ/tCrCxaCo9uQMHJev2fOG23xloj
	 XTLJVWvPttNXVz0RLXs+cCq7Z8jSm4+epGa9VR3uB1JQl1NJ934nZD4qT98XEx263T0Jz
	 wrBgvOi3XD4KBaoPpEc6KqCHBfk1NaD5RZVB5U7NijK7Jk7j5r6g2DXFKglJd0r7eIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RLW/65Mr";
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B845606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B845606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLW/65Mr
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b6399ebb41so2487213b3a.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374133; x=1794978933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UqgOseBrsOg92jgrvQE3YiNVxmX+mwESG+PkFCv8OdU=;
        b=RLW/65Mr/kfn3blv5HywzM77RSu3Ph/nhidL9Bpwp9eqVd3UPelpEKgtdJp7zHcmct
         8pbFoCCS/EV83K8HTEu08UpmZVZ4b/L8QyiLlojwMJYuuUzyKvs9uIiAc6/8s1ezRreL
         M2yFeDMyM32ekFG04d2P3KNOv3PySbpvLe83vsuDfGRCPTUwOGTe1zbqmWUSYFjw1rsZ
         5qCmpspuJ27gag8UvRemUk8RUkRXItgY/2SjrII4aoVrxbqOYo8p9BLrHtO+OWFrRIOL
         ItAnDQCt/LSJOvypDO6JAErBS81B6mNAGJe0SZ1kPikaO/a3HOQlU2rDZ1dYxio2p+SG
         2jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374133; x=1794978933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UqgOseBrsOg92jgrvQE3YiNVxmX+mwESG+PkFCv8OdU=;
        b=wX0aDZrfVwcaZxNA0q8oHx+r4BD2kTcNxMW4Lf9dqmMMEdmMLeUiorxrQuc4L1m1Wg
         t8+7T9sKlcG5KSs1M4ATQxEWA6hdtAUN/AAqywu/lLD8Lu66PvzTY7MdMJ612iQz8r1C
         xLfl/cHpdB//n/6Pkx3NmIxi92rLn26jMtgptVvfNoERBRj6b3tJFmpFynaOMik7j9Ss
         5xIHwJrMdCeHgcNHqZVuRVB8NT8VTA5AlbFKVKEgFjWrFn+CYPZzyT4ceageW/zv1xlF
         z6R+4oZw7JMgDkJbSucdKA2fxCkT0yXFb7WyELMwCrKxwLXYYIyG/ZkH2hz7W8xhQ2Sy
         YfKg==
X-Gm-Message-State: APuU4Z8mcU6gvHPgfhNj4OV4lTmZuebToRdHAn3dCriz+G4vcnmRh2LT
	EF4Ia5HcM3oSj4dRzkWrFgUv2ICPoMHEuFjLGZjQA5yFn9dr4uxIDwc07FT2pg==
X-Gm-Gg: AYBFou36jrObehmnvdIfJvk6U5QzJhdQcfTxVdSspcsNfZrcDetS2RVyAM1mxKNkFV0
	8nOPeW96FrsEk9TYbR8m7s8SM0EabaTLUfmE/QI/WAcBcb9bQ5rpUY4SMMR54yaEWEEYa7x+hpc
	XC9FxSYfZiY3zEBH+sf4YP3biqm+GYmmx67bJpP71zbRzl8rQHdVRoGdwsLX8+hoj/RevQoqOg4
	6+u0J/LCaKQRBOfY0z3e67l0EC6DU0TcVoyEKRD+wbbdqQ11iVOiHwmWXMB5lcTXMsy+LyCkj67
	hmYRADOrv+tkgMXozdKo8lBRBkStPDigy/6LKTyUp+kQ9xWYOmSM/cjUZMTEVPuP5T2Lfky9E7+
	hvz4CJreRrqsw65tZBoJoYL2d+nblta+HvCnNaZDbIaQ5B1bdir7b9Apz8tQ0K//k0TRcO2SmpP
	UgIq0ermdqtDNruITY8GDU/l4rOqyVKG3PxSgO5+xMdp3a6jVCeCbmRcEEqJqXlG9GOC2eS0hgs
	NRN9AAUQo3m9dpxpEeOhlENNMFo6siTj9+e1L90rTs2Hyvch88q+0fg6eDguLVrjn/kqoKxmVNG
	FhUUya7Vumn+BXUjQPdIIxbzOts4+6NuivUAIhuQS0FKp3ik4Gr5jNx0FI8ZmosnHB0qpIfgNEA
	i3y+4+m8kFSWpAR5E4UlS59jcGXtgpU85Tf1M/THW96aQkX8IcOnlTcD7rDYsasKtsoHchSfo9a
	4=
X-Received: by 2002:a05:6a00:1810:b0:898:664:446 with SMTP id d2e1a72fcca58-8bc1def2610mr1518474b3a.54.1794374132868;
        Tue, 10 Nov 2026 21:15:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab8dccc7sm1600990b3a.52.2026.11.10.21.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:15:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 18/29] bpf: Promote memory behind a pointer to SCEV registers
Date: Wed, 11 Nov 2026 05:13:29 +0000
Message-ID: <20261111051341.2800252-19-alexei.starovoitov@gmail.com>
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

A prerequisite of the removal of scalar ids. Linked registers belong to the
frame of the jump. A scalar id also links a register to a stack slot of
a caller, and programs depend on that:

	struct { char *buf; u64 len; } c = { buf, 0 };
	bpf_loop(100, append, &c, 0);

	static long append(u64 i, void *ctx)
	{
		if (c->len > 63)
			return 1;
		n = bpf_get_prandom_u32();
		c->buf[c->len] = n;
		c->len++;
		return 0;
	}

c is on the stack of the caller. The compiler loads c->len again after the
call. The first load gives the register the id of the stack slot, so the
jump refines both. Without ids the second load gets the old range:

  R2 unbounded memory access, make sure to bounds check any such access

A program that builds a file path in a bpf_loop() callback has this shape.
So has a clamp in a static subprog, 'if (b->len > 63) b->len = 0;'.

A stack slot is memory that scev.c promotes to a register: a spill defines
it, a join point has a phi, an insn that may write is a may-def. Do the
same behind other pointers. struct env gets 16 more SCEV registers, memory
locations. The expression of its address names a location:

  29: r6 = r2
  30: r1 = *(u64 *)(r6 + 8)       r1 is %r1.30, mem0=*(+ r2 8) is %r1.30
  31: if r1 > 63 goto ..          mem0 is linked to r1
  32: call bpf_get_prandom_u32    mem0 is '?'

A store defines a location like a spill. A load defines its register as
before, and the location gets that value number (EarlyCSE, GVN). A call, an
atomic, a nested loop and a store through a pointer are may-defs of all
locations. A store spares those with its address base that it does not
overlap. mk_phi(), find_linked_regs(), const_diff_reg() and the iterator
take a location like a stack slot.

Which memory it is depends on the caller, so the main pass answers that.
bpf_scev_mem_addr() names a live register that holds the address,
scev_mem_to_slot() reads it in the state at the jump. If it points to the
stack of a caller, refine_linked_regs() goes on with that frame and slot.

Why it is sound:
- No expression of a register depends on memory: what is not stack can
  change between two loads. Loop summaries and links between registers
  stay as they are.
- 'f(&c, &c)' makes two names for one memory. A store through one address
  base forgets the locations of all others.
- A store through r10 is no may-def: no slot of the frame of the jump is
  taken.
- Nothing is kept in a state, and only what is live is read there.

Why 16: a location is dead once no live register holds its value, no jump
can link it any more. Its SCEV register is reused. In the programs of
Tetragon, Tracee, Falco and the Datadog agent at most 15 are alive at
a time, while one subprog loads and stores at more than 100 addresses.

Not found: no live register holds the address at the jump, as in
'c->n = x; if (x >= 16) return -1; return 0;' and in 'if (w->c->n > 63)'.
A value number of a loop means nothing outside: no location is tracked at
a header or across a nested loop. Liveness does not follow a pointer to
the stack through callx: no location is tracked in a subprog that is only
called through a function pointer.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/scev.c            | 265 +++++++++++++++++++++++++++++++----
 kernel/bpf/verifier.c        |  43 +++++-
 3 files changed, 281 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 11025ed77a7f..5a6bb40310f2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2228,6 +2228,8 @@ int bpf_scev_jump_counts(struct bpf_verifier_env *env, int header, int n, bool t
 bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
 			      u32 *linked_regno, u32 *fill_off, int *base_regno, s64 *delta,
 			      u32 *bits);
+bool bpf_scev_mem_addr(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *base_regno,
+		       s64 *off);
 bool bpf_is_widenable_reg_type(const struct bpf_reg_state *reg);
 bool bpf_scev_in_slice_slots(struct bpf_verifier_env *env, int off, u32 size, bool fixed_off);
 
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 50b440142bf9..98a05f97196a 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -12,6 +12,9 @@
 #include <linux/overflow.h>
 
 #define REGS_NUM BPF_SCEV_REGS_NUM
+/* The SCEV registers of an env: r0 - r10, the stack slots and memory locations, see struct env */
+#define MEM_REGS_NUM 16
+#define ENV_REGS_NUM (REGS_NUM + MEM_REGS_NUM)
 #define UNKNOWN_EXPR_ID 0
 #define OPAQUE_EXPR_ID  1
 /* (REG r). UNKNOWN, OPAQUE and (REG r) have fixed ids and are not in the hash table. */
@@ -82,7 +85,7 @@ struct expr_def {
 	u32 idx:21;
 };
 /* def.reg of the phi of two bases, see mk_phi() */
-#define BASE_REG REGS_NUM
+#define BASE_REG ENV_REGS_NUM
 static_assert(BASE_REG < 1 << 9 && BPF_COMPLEXITY_LIMIT_INSNS <= 1 << 21);
 
 static const struct expr_def no_def;
@@ -113,14 +116,31 @@ struct expr {
 
 struct env {
 	bool empty;
-	u32 reg2expr[REGS_NUM];
+	u32 reg2expr[ENV_REGS_NUM];
 	u32 reg2scev[REGS_NUM];
+	/*
+	 * Register promotion of memory that is not behind r10. The SCEV register REGS_NUM + i is
+	 * the memory at the address mem_addr[i], a value number of this env. 0: not in use.
+	 * - A store through a pointer defines it like a spill defines a stack slot.
+	 * - A load defines its register as before, and the memory gets that value number: it holds
+	 *   what a store of the register would leave. No expression of a register depends on
+	 *   memory, which is private only if it is stack. That is not known here.
+	 * - A join point has a phi. An insn that may write is a may-def, see forget_mem_regs().
+	 * - A store through r10 is not: the main pass takes the stack of a caller only.
+	 * A value number of a loop means nothing in the enclosing loop: no memory is tracked at
+	 * a header, a nested loop is a may-def.
+	 */
+	u32 mem_addr[MEM_REGS_NUM];
 };
 
-/* A SCEV register and the id of its expression before a conditional jump */
+/*
+ * A SCEV register and the id of its expression before a conditional jump. 'addr' is mem_addr[] of
+ * a memory location.
+ */
 struct scev_linked_reg {
 	u32 reg;
 	u32 id;
+	u32 addr;
 };
 
 struct insn_envs {
@@ -253,7 +273,7 @@ static bool expr_is_vn(struct scev *scev, struct expr *e)
 	 * comes from a call that may write to the slot.
 	 */
 	if (e->def.set)
-		return reg < MAX_BPF_REG || reg == BASE_REG ||
+		return reg < MAX_BPF_REG || reg >= REGS_NUM ||
 		       !test_bit(reg - MAX_BPF_REG, scev->slice_slots);
 	switch (e->op) {
 	case UNKNOWN:
@@ -539,8 +559,10 @@ static void log_reg(struct bpf_verifier_env *env, u32 reg)
 {
 	if (reg < MAX_BPF_REG)
 		bpf_log(&env->log, "r%d", reg);
-	else
+	else if (reg < REGS_NUM)
 		bpf_log(&env->log, "*fp%d", (MAX_BPF_REG - reg - 1) * 8);
+	else
+		bpf_log(&env->log, "mem%d", reg - REGS_NUM);
 }
 
 static const char *op_str(u32 op)
@@ -695,8 +717,10 @@ static void log_def(struct bpf_verifier_env *env, struct expr_def def)
 		return;
 	if (def.reg < MAX_BPF_REG)
 		bpf_log(&env->log, "%%r%d.%d", def.reg, def.idx);
-	else
+	else if (def.reg < REGS_NUM)
 		bpf_log(&env->log, "%%fp%d.%d", (MAX_BPF_REG - def.reg - 1) * 8, def.idx);
+	else
+		bpf_log(&env->log, "%%mem%d.%d", def.reg - REGS_NUM, def.idx);
 }
 
 static void log_expr(struct bpf_verifier_env *env, u32 id)
@@ -775,6 +799,9 @@ static bool reg_alive_at(struct bpf_verifier_env *env, u32 reg, u32 insn_idx)
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	u16 live_regs = aux[insn_idx].live_regs_before;
 
+	/* memory */
+	if (reg >= REGS_NUM)
+		return true;
 	return reg < MAX_BPF_REG
 	       ? (BIT(reg) & live_regs)
 	       : test_bit(reg - MAX_BPF_REG, aux[insn_idx].live_stack_before);
@@ -1040,6 +1067,129 @@ static int maybe_load_fp(struct scev *scev, struct env *e, struct bpf_insn *insn
 	return replace_reg(scev, e, insn->dst_reg, id);
 }
 
+static bool const_diff(struct bpf_verifier_env *env, int h, u32 id_a, u32 id_b, s64 *delta,
+		       u32 *bits);
+
+/* The memory location of @e at the address @addr, 0: one that is not in use. MEM_REGS_NUM: none. */
+static u32 find_mem_reg(const struct env *e, u32 addr)
+{
+	u32 i;
+
+	for (i = 0; i < MEM_REGS_NUM && e->mem_addr[i] != addr; i++)
+		;
+	return i;
+}
+
+static void forget_mem_reg(struct env *e, u32 i)
+{
+	e->mem_addr[i] = 0;
+	e->reg2expr[REGS_NUM + i] = UNKNOWN_EXPR_ID;
+}
+
+/*
+ * The insn may write @size bytes at the address @addr, 0: anywhere. A may-def of all memory
+ * locations but those that have the same address base and don't overlap. Two bases can be two names
+ * of one memory, 'f(&c, &c)'.
+ */
+static void forget_mem_regs(struct bpf_verifier_env *env, struct env *e, u32 addr, u32 size)
+{
+	u32 i, x, bits;
+	s64 delta;
+
+	for (i = 0; i < MEM_REGS_NUM; i++) {
+		/* the caller defines it */
+		if (e->mem_addr[i] == addr)
+			continue;
+		if (addr && const_diff(env, -1, addr, e->mem_addr[i], &delta, &bits) &&
+		    bits == 64 && (delta >= size ||
+		    delta + expr_spill_size(env->scev, e->reg2expr[REGS_NUM + i], &x) <= 0))
+			continue;
+		forget_mem_reg(e, i);
+	}
+}
+
+/*
+ * A jump tests a register, and a load makes a new value number. So a memory location is dead once
+ * no register that is live after the insn at @idx has the base of its value: no jump is going to
+ * link it.
+ */
+static void forget_dead_mem_regs(struct bpf_verifier_env *env, struct env *e, int idx)
+{
+	struct expr *exprs = env->scev->exprs;
+	u32 i, r, base;
+
+	for (i = 0; i < MEM_REGS_NUM; i++) {
+		base = exprs[e->reg2expr[REGS_NUM + i]].base;
+		for (r = 0; r < REGS_NUM; r++)
+			if (exprs[e->reg2expr[r]].base == base && reg_alive_at(env, r, idx + 1))
+				break;
+		if (r == REGS_NUM)
+			forget_mem_reg(e, i);
+	}
+}
+
+/*
+ * The address of the load or store at @idx through @reg, 0: the memory is not tracked. r10 has the
+ * stack slots, r11 and r12 are no SCEV registers. The main pass takes nothing but stack.
+ */
+static int mk_mem_addr(struct bpf_verifier_env *env, struct env *e, int idx, u32 reg)
+{
+	struct scev *scev = env->scev;
+
+	if (reg >= BPF_REG_FP || !(env->insn_aux_data[idx].stack_ptrs & BIT(reg)) ||
+	    !scev->exprs[e->reg2expr[reg]].is_vn)
+		return 0;
+	return expr2(scev, BPF_ADD, e->reg2expr[reg], imm_expr(scev, env->prog->insnsi[idx].off));
+}
+
+/*
+ * The insn at @idx stored the low bytes of @id at the address @addr, or it loaded them from there.
+ * The location takes a SCEV register that is not in use, or that of a dead one.
+ */
+static int replace_mem_reg(struct bpf_verifier_env *env, struct env *e, int idx, int addr, int id)
+{
+	u32 i;
+
+	if (addr <= 0)
+		return addr;
+	i = find_mem_reg(e, addr);
+	if (i == MEM_REGS_NUM)
+		i = find_mem_reg(e, 0);
+	if (i == MEM_REGS_NUM) {
+		forget_dead_mem_regs(env, e, idx);
+		i = find_mem_reg(e, 0);
+	}
+	if (i == MEM_REGS_NUM)
+		return 0;
+	e->mem_addr[i] = addr;
+	return replace_reg(env->scev, e, REGS_NUM + i,
+			   mk_spill(env->scev, BPF_SIZE(env->prog->insnsi[idx].code), id));
+}
+
+static int load_mem(struct bpf_verifier_env *env, struct env *e, int idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	/* the insn defines dst_reg, which can be src_reg */
+	int addr = mk_mem_addr(env, e, idx, insn->src_reg);
+
+	return maybe_load_fp(env->scev, e, insn, idx) ?:
+	       replace_mem_reg(env, e, idx, addr, e->reg2expr[insn->dst_reg]);
+}
+
+static int store_mem(struct bpf_verifier_env *env, struct env *e, int idx, int id)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	int addr;
+
+	if (insn->dst_reg == BPF_REG_FP)
+		return maybe_store_fp(env->scev, e, insn, idx, id);
+	addr = mk_mem_addr(env, e, idx, insn->dst_reg);
+	if (addr < 0)
+		return addr;
+	forget_mem_regs(env, e, addr, bpf_size_to_bytes(BPF_SIZE(insn->code)));
+	return replace_mem_reg(env, e, idx, addr, id);
+}
+
 /*
  * The low 32 bits of a + b depend on the low 32 bits of a and b only: 'w1 += w2' is
  * (zext32 (+ a b)). That doesn't hold for a right shift and for a division. Their operands are zero
@@ -1226,19 +1376,19 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 				imm = env->insn_aux_data[idx + 1].const_reg_vals[dst];
 				return replace_reg(scev, e, dst, imm_expr(scev, imm));
 			}
-			return maybe_load_fp(scev, e, insn, idx);
+			return load_mem(env, e, idx);
 		default:
 			goto mark_dst_unknown;
 		}
 	case BPF_STX:
 		switch (mode) {
 		case BPF_MEM:
-			return maybe_store_fp(scev, e, insn, idx, reg2expr[src]);
+			return store_mem(env, e, idx, reg2expr[src]);
 		case BPF_ATOMIC:
 			if (insn->imm == BPF_LOAD_ACQ)
 				return maybe_load_fp(scev, e, insn, idx);
 			if (insn->imm == BPF_STORE_REL) {
-				return maybe_store_fp(scev, e, insn, idx, reg2expr[src]);
+				return store_mem(env, e, idx, reg2expr[src]);
 			}
 			/*
 			 * verifier does not track other atomic ops precisely,
@@ -1249,6 +1399,8 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 						 bpf_size_to_bytes(BPF_SIZE(insn->code)));
 				if (id < 0)
 					return id;
+			} else {
+				forget_mem_regs(env, e, 0, 0);
 			}
 			if (insn->imm == BPF_CMPXCHG)
 				return forget_reg(scev, e, BPF_REG_0, OPAQUE_EXPR_ID, idx);
@@ -1258,16 +1410,14 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 		}
 		break;
 	case BPF_ST:
-		if (insn->dst_reg == BPF_REG_FP) {
-			id = imm_expr(scev, insn->imm);
-			if (id < 0)
-				return id;
-			return maybe_store_fp(scev, e, insn, idx, id);
-		}
-		break;
+		id = imm_expr(scev, insn->imm);
+		if (id < 0)
+			return id;
+		return store_mem(env, e, idx, id);
 	case BPF_JMP:
 	case BPF_JMP32:
 		if (opcode == BPF_CALL) {
+			forget_mem_regs(env, e, 0, 0);
 			id = forget_call_regs(env, e, idx);
 			if (id < 0)
 				return id;
@@ -1299,6 +1449,7 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 		/* unknown instruction, nuke state */
 		for (i = 0; i < REGS_NUM; i++)
 			reg2expr[i] = UNKNOWN_EXPR_ID;
+		forget_mem_regs(env, e, 0, 0);
 		break;
 	}
 	return 0;
@@ -1456,7 +1607,7 @@ static int mk_phi(struct bpf_verifier_env *env, u32 a, u32 b, int idx, u32 reg)
 static int join(struct bpf_verifier_env *env, struct env *acc, struct env *cur, int idx)
 {
 	struct scev *scev = env->scev;
-	int i, id;
+	int i, j, id;
 
 	if (acc->empty) {
 		memcpy(acc, cur, sizeof(*acc));
@@ -1464,11 +1615,17 @@ static int join(struct bpf_verifier_env *env, struct env *acc, struct env *cur,
 		return 0;
 	}
 
-	for (i = 0; i < REGS_NUM; i++) {
-		if (!same_exprs(scev, acc->reg2expr[i], cur->reg2expr[i])) {
+	for (i = 0; i < ENV_REGS_NUM; i++) {
+		/* the address names a memory location. It has a phi if all edges track it. */
+		j = i < REGS_NUM ? i : REGS_NUM + find_mem_reg(cur, acc->mem_addr[i - REGS_NUM]);
+		if (j == ENV_REGS_NUM) {
+			forget_mem_reg(acc, i - REGS_NUM);
+			continue;
+		}
+		if (!same_exprs(scev, acc->reg2expr[i], cur->reg2expr[j])) {
 			/* no phi for a dead register: pruned SSA */
 			id = reg_alive_at(env, i, idx) ?
-			     mk_phi(env, acc->reg2expr[i], cur->reg2expr[i], idx, i) :
+			     mk_phi(env, acc->reg2expr[i], cur->reg2expr[j], idx, i) :
 			     UNKNOWN_EXPR_ID;
 			if (id < 0)
 				return id;
@@ -1499,6 +1656,7 @@ static int forget_non_invariants(struct bpf_verifier_env *env, struct env *acc,
 	int i, idx, h, err;
 
 	acc->empty = false;
+	forget_mem_regs(env, acc, 0, 0);
 	forget_modified_regs(scev, acc, find_header_env(scev, header));
 	for (i = 0; i < loop->exits_cnt; i++) {
 		idx = loop->exits[i].from;
@@ -1616,7 +1774,7 @@ static void log_env_changes(struct bpf_verifier_env *env, enum changes_at at,
 	len = log->end_pos - null_pos;
 	bpf_log(log, "%*s", max(37 - (int)len, 1), " ");
 	bpf_log(log, " ; ");
-	for (r = 0; r < REGS_NUM; r++) {
+	for (r = 0; r < ENV_REGS_NUM; r++) {
 		old_id = old->reg2expr[r];
 		new_id = new->reg2expr[r];
 		if (at == LOG_AT_TRANSFER && !reg_alive_at_succ(env, r, insn_idx))
@@ -1631,6 +1789,10 @@ static void log_env_changes(struct bpf_verifier_env *env, enum changes_at at,
 		if (any_changes)
 			bpf_log(log, ", ");
 		log_reg(env, r);
+		if (r >= REGS_NUM && new->mem_addr[r - REGS_NUM]) {
+			bpf_log(log, "=*");
+			log_expr(env, new->mem_addr[r - REGS_NUM]);
+		}
 		bpf_log(log, " ");
 		log_expr(env, old_id);
 		bpf_log(log, " -> ");
@@ -2036,6 +2198,19 @@ static bool const_diff_reg(struct bpf_verifier_env *env, int h, u32 id_a, u32 re
 	return true;
 }
 
+/* The first of the registers and stack slots @live that holds @id + a constant. REGS_NUM: none. */
+static u32 find_leader(struct bpf_verifier_env *env, struct env *e, int h,
+		       const unsigned long *live, u32 id)
+{
+	u32 r, bits;
+	s64 delta;
+
+	for_each_set_bit(r, live, REGS_NUM)
+		if (const_diff(env, h, e->reg2expr[r], id, &delta, &bits))
+			break;
+	return r;
+}
+
 /*
  *	n = bpf_get_stack(..); m = n; if (n < 0) ..; use(m);
  * The main pass refines the registers that the conditional jump at @idx tests. Find the live SCEV
@@ -2051,8 +2226,8 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 	struct scev *scev = env->scev;
 	u32 r, q, other, id, fill_off, base, base_dst, base_src, bits, cap, tested = 0;
 	u32 first = scev->linked_cnt;
-	DECLARE_BITMAP(live, REGS_NUM) = {};
-	DECLARE_BITMAP(found, REGS_NUM) = {};
+	DECLARE_BITMAP(live, ENV_REGS_NUM) = {};
+	DECLARE_BITMAP(found, ENV_REGS_NUM) = {};
 	void *tmp;
 	s64 delta;
 
@@ -2063,9 +2238,12 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 	bitmap_copy(live, aux->live_stack_before, MAX_BPF_STACK_SLOTS);
 	bitmap_shift_left(live, live, MAX_BPF_REG, REGS_NUM);
 	live[0] |= aux->live_regs_before;
+	for (r = REGS_NUM; r < ENV_REGS_NUM; r++)
+		if (e->mem_addr[r - REGS_NUM])
+			__set_bit(r, live);
 	split_const_offset(env, dst, &base_dst, &delta, &bits);
 	split_const_offset(env, src, &base_src, &delta, &bits);
-	for_each_set_bit(r, live, REGS_NUM) {
+	for_each_set_bit(r, live, ENV_REGS_NUM) {
 		id = e->reg2expr[r];
 		/* most are not linked */
 		split_const_offset(env, id, &base, &delta, &bits);
@@ -2089,7 +2267,17 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 			break;
 		}
 	}
-	for_each_set_bit(r, found, REGS_NUM) {
+	/* the main pass finds memory by a live register that holds its address */
+	for (r = REGS_NUM; r < ENV_REGS_NUM; r++) {
+		if (!test_bit(r, found))
+			continue;
+		q = find_leader(env, e, h, live, e->mem_addr[r - REGS_NUM]);
+		if (q < REGS_NUM)
+			__set_bit(q, found);
+		else
+			__clear_bit(r, found);
+	}
+	for_each_set_bit(r, found, ENV_REGS_NUM) {
 		if (scev->linked_cnt == scev->linked_cap) {
 			cap = max(scev->linked_cap * 2, 16);
 			tmp = kvrealloc(scev->linked, array_size(cap, sizeof(*scev->linked)),
@@ -2101,6 +2289,7 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 		}
 		tested += r == insn->dst_reg || (src != dst && r == insn->src_reg);
 		scev->linked[scev->linked_cnt].reg = r;
+		scev->linked[scev->linked_cnt].addr = r < REGS_NUM ? 0 : e->mem_addr[r - REGS_NUM];
 		scev->linked[scev->linked_cnt++].id = e->reg2expr[r];
 	}
 	/* nothing but the tested registers */
@@ -2127,6 +2316,7 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
  * no more links are known. Types are not known here: the caller checks them in its state.
  * A linked register can be a pointer: *base_regno + regno + delta. *base_regno is the address base,
  * as in store_base_regs. It is -1 for a link without a base.
+ * BPF_SCEV_REGS_NUM and above is a memory location, see struct env and bpf_scev_mem_addr().
  */
 bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
 			      u32 *linked_regno, u32 *fill_off, int *base_regno, s64 *delta,
@@ -2167,6 +2357,31 @@ bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 re
 	return false;
 }
 
+/*
+ * The memory location @regno is a linked register of the conditional jump at @insn_idx. Its address
+ * is *@base_regno + *@off. *@base_regno is a live register or stack slot. Which memory it is
+ * depends on the state.
+ */
+bool bpf_scev_mem_addr(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *base_regno,
+		       s64 *off)
+{
+	struct insn_envs *envs = env->scev->envs[insn_idx];
+	struct scev_linked_reg *linked = &env->scev->linked[envs->linked_first];
+	int h = bpf_loop_at_index(env, insn_idx);
+	u32 i, j, bits;
+
+	for (i = 0; linked[i].reg != regno; i++)
+		if (i + 1 == envs->linked_cnt)
+			return false;
+	for (j = 0; linked[j].reg < REGS_NUM; j++) {
+		if (!const_diff(env, h, linked[j].id, linked[i].addr, off, &bits) || bits != 64)
+			continue;
+		*base_regno = linked[j].reg;
+		return true;
+	}
+	return false;
+}
+
 /*
  * @cur_header and @first are a loop header. Or -1 and the first insn of a subprog: the subprog is
  * the outermost loop, which runs once. (REG r) is the entry value of r, the loops in it are single
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2a3f74d441f..cc4cbd9da270 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19741,6 +19741,36 @@ static struct bpf_reg_state *scev_reg_for_fill(struct bpf_func_state *frame, u32
 	return &ss->spilled_ptr;
 }
 
+/*
+ * Scalar evolution promoted memory to the SCEV register *@regno, see struct env there, and names
+ * its address at the jump at @idx. This state knows which memory it is: the frame that is returned,
+ * its stack slot *@regno, *@fill_off counts from the start of the slot. The stack of a caller only:
+ * other memory has no state, and a store through r10 is no def of memory for scalar evolution.
+ * What holds the address is live: it was compared all the way from its def. Every place that
+ * compares, joins or drops states cleans them of what is dead first, see flow_arrive().
+ */
+static struct bpf_func_state *scev_mem_to_slot(struct bpf_verifier_env *env,
+					       struct bpf_verifier_state *vstate, int idx,
+					       u32 *regno, u32 *fill_off)
+{
+	struct bpf_reg_state *ptr;
+	u32 base_regno;
+	s64 addr;
+
+	if (!bpf_scev_mem_addr(env, idx, *regno, &base_regno, &addr))
+		return NULL;
+	ptr = scev_reg_for_fill(vstate->frame[vstate->curframe], base_regno, 0, 64);
+	if (!ptr || ptr->type != PTR_TO_STACK || !tnum_is_const(ptr->var_off) ||
+	    ptr->frameno >= vstate->curframe)
+		return NULL;
+	addr += ptr->var_off.value + *fill_off;
+	if (addr >= 0 || addr < -MAX_BPF_STACK_JIT)
+		return NULL;
+	*regno = MAX_BPF_REG + bpf_get_spi(addr);
+	*fill_off = addr & (BPF_REG_SIZE - 1);
+	return vstate->frame[ptr->frameno];
+}
+
 /*
  *	p = buf + i; if (i > 100) return 0; *p = 0;
  * p is @dst_reg, x is @ptr_reg, i is @off_reg. Scalar evolution says that p == x + i. So the insns
@@ -19786,7 +19816,7 @@ static bool recompute_ptr(struct bpf_verifier_env *env, struct bpf_reg_state *ds
 static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *vstate,
 			       int idx, u32 regno)
 {
-	struct bpf_func_state *frame = vstate->frame[vstate->curframe];
+	struct bpf_func_state *frame = vstate->frame[vstate->curframe], *linked_frame;
 	struct bpf_reg_state *reg, *base_reg, implied, saved;
 	u32 pos, linked_regno, fill_off, bits;
 	int base_regno;
@@ -19798,7 +19828,12 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 	     bpf_scev_next_linked_reg(env, idx, regno, &pos, &linked_regno, &fill_off, &base_regno,
 				      &delta, &bits);
 	     pos++) {
-		reg = scev_reg_for_fill(frame, linked_regno, fill_off, bits);
+		linked_frame = frame;
+		if (linked_regno >= BPF_SCEV_REGS_NUM)
+			linked_frame = scev_mem_to_slot(env, vstate, idx, &linked_regno, &fill_off);
+		if (!linked_frame)
+			continue;
+		reg = scev_reg_for_fill(linked_frame, linked_regno, fill_off, bits);
 		/*
 		 * The other half-slot of a 64-bit spill is dead: __clean_func_state() left
 		 * a 32-bit spill, the low 32 bits of the value.
@@ -19806,7 +19841,7 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 		if (!reg && bits == 64 &&
 		    bpf_stack_narrow_access_ok(fill_off, BPF_REG_SIZE / 2, BPF_REG_SIZE)) {
 			bits = 32;
-			reg = scev_reg_for_fill(frame, linked_regno, fill_off, bits);
+			reg = scev_reg_for_fill(linked_frame, linked_regno, fill_off, bits);
 		}
 		if (!reg || (base_regno < 0 && reg->type != SCALAR_VALUE))
 			continue;
@@ -19844,7 +19879,7 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 scratch:
 		if (linked_regno < MAX_BPF_REG)
 			mark_reg_scratched(env, linked_regno);
-		else
+		else if (linked_frame == frame)
 			mark_stack_slot_scratched(env, linked_regno - MAX_BPF_REG);
 	}
 }
-- 
2.55.0

