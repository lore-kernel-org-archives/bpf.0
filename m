Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B325779
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358700; cv=none; b=AmlwVMPa6JgKYLpCkNgSx5cQV4RFiY38ohqsIPbK+AJMavCGRhkaG3llHzUSzDrEheN+JQBY3QGYFJr9U1tOicmxedo8oSEc72lS1Ooe/Hao2IHe04YJajap7b7xycgMYDHxuWAx7KMBGveltRy26IA5PEIdLtAA8hra0HitGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358700; c=relaxed/simple;
	bh=kvtyysUzwi6W9jFScALbS8EhX+JCcGgt4krYyCKRRSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LO9nP7QHjKXajSeH2JCZAKv58rZNC6ihrTALwg6ZoM+KccNPwIJ65UEIqWTWR30btHzqckiQL+LbcUmQ7MffZ+Um36871qfrkLMd+1cmSDHjv2GeWZEjaVW23q2jNFt4sTcsAeiHFXN0ms7TaCH/4dV6+odTfKe93I1qa1GBiBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujqqj3uw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujqqj3uw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e2232e30f4so24599895ad.2
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712358697; x=1712963497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5KyUYB94+ZPJZvFKvWD3TGLrDO1iX179EgrTQ3O81U=;
        b=Ujqqj3uwta0Y5xn6jNd/1UqDQ4PlGiTmUJEK+d/adO+meTBxWoHeYF3CuwyyoQNXGV
         iuUVv4JEqydyBK9xjUzwUxnxQyJYS0dTHxZuaRZqnDYWiGqZ4EEopcaLbRmXnZsEYAU4
         ed3f4tap5fETpr3YKFKrijBZgoulq0YMpRVtFtK+XiFaWyVLgvz30LdNWJimnGKwicRK
         WTRy7ToB99QLGKdT6lbhZRap4rWXt8cqX76CV0BGx4kqGo5ayNoQGX/tgkBxtKiHGQlE
         4x4Ksiq61DvchXwxz96ojLWGbSBSskHrZmQhS3Nox0/8MB8C8BXrdbHHoWKFbdEMt6Ld
         7k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712358697; x=1712963497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5KyUYB94+ZPJZvFKvWD3TGLrDO1iX179EgrTQ3O81U=;
        b=klu9rTyT5HTSh4p/de4TmB12HyC8KXId7si1isx2ToGmt3l8lSoEPk7NynC2QJhmcN
         fM82L4zl5YQyE1vqtzJ7zerAbeXcLpUIm78iQy37MF2Q6D4tWATrJ75M22P8AM78D2zq
         UZUEx1YFyBLL6Ac5u1SBwH+zvi+cSGsd+B5x9ybPTdlca3/DAEZ+Zo0Bkkh9Ynd6IUjQ
         V7G1cDbqrGjraPvd5kJ6Qzb47I/gaeF1KEQJ2nlZN8RZA3aQflZwVB5JLrd2/lR8NeVz
         D+wwTOjjmcPWDeOil07qucaFsHFkYiR+UC5XyEsYKBIblRVSEIH7FfOazueQEV1dRpRi
         gKzA==
X-Gm-Message-State: AOJu0Ywq371gPhAosyC0hgHP8z2JHiksd++Ih6LAlDaMsur/63p9RuCc
	tDx2DxIFUgNPgMDXYB+Rz2q/OIdxVsqrFTBbsHCRR1+jIPy9f5x4deDDdPgC
X-Google-Smtp-Source: AGHT+IGHSiX6Zc1z0QV6/kaiGHB+Lk3WCXRlSjL7luxuYVlMA14Sd2YCkzSK7rnHmTKWMSXE8GXjFQ==
X-Received: by 2002:a17:903:2351:b0:1e2:88fd:c211 with SMTP id c17-20020a170903235100b001e288fdc211mr3236492plh.4.1712358697289;
        Fri, 05 Apr 2024 16:11:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b42e])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e80400b001e3c972c83bsm1464495plg.76.2024.04.05.16.11.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Apr 2024 16:11:36 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	puranjay@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Add support for certain atomics in bpf_arena to x86 JIT
Date: Fri,  5 Apr 2024 16:11:33 -0700
Message-Id: <20240405231134.17274-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Support atomics in bpf_arena that can be JITed as a single x86 instruction.
Instructions that are JITed as loops are not supported at the moment,
since they require more complex extable and loop logic.

JITs can choose to do smarter things with bpf_jit_supports_insn().
Like arm64 may decide to support all bpf atomics instructions
when emit_lse_atomic is available and none in ll_sc mode.

bpf_jit_supports_percpu_insn(), bpf_jit_supports_ptr_xchg() and
other such callbacks can be replaced with bpf_jit_supports_insn()
in the future.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 72 +++++++++++++++++++++++++++++++++++++
 include/linux/filter.h      |  4 +++
 kernel/bpf/core.c           |  5 +++
 kernel/bpf/verifier.c       | 19 +++++++++-
 4 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6cf9a5697c09..2b5a475c4dd0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1172,6 +1172,54 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 	return 0;
 }
 
+static int emit_atomic_index(u8 **pprog, u8 atomic_op, u32 size,
+			     u32 dst_reg, u32 src_reg, u32 index_reg, int off)
+{
+	u8 *prog = *pprog;
+
+	EMIT1(0xF0); /* lock prefix */
+	switch (size) {
+	case BPF_W:
+		EMIT1(add_3mod(0x40, dst_reg, src_reg, index_reg));
+		break;
+	case BPF_DW:
+		EMIT1(add_3mod(0x48, dst_reg, src_reg, index_reg));
+		break;
+	default:
+		pr_err("bpf_jit: 1 and 2 byte atomics are not supported\n");
+		return -EFAULT;
+	}
+
+	/* emit opcode */
+	switch (atomic_op) {
+	case BPF_ADD:
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
+		/* lock *(u32/u64*)(dst_reg + idx_reg + off) <op>= src_reg */
+		EMIT1(simple_alu_opcodes[atomic_op]);
+		break;
+	case BPF_ADD | BPF_FETCH:
+		/* src_reg = atomic_fetch_add(dst_reg + idx_reg + off, src_reg); */
+		EMIT2(0x0F, 0xC1);
+		break;
+	case BPF_XCHG:
+		/* src_reg = atomic_xchg(dst_reg + idx_reg + off, src_reg); */
+		EMIT1(0x87);
+		break;
+	case BPF_CMPXCHG:
+		/* r0 = atomic_cmpxchg(dst_reg + idx_reg + off, r0, src_reg); */
+		EMIT2(0x0F, 0xB1);
+		break;
+	default:
+		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
+		return -EFAULT;
+	}
+	emit_insn_suffix_SIB(&prog, dst_reg, src_reg, index_reg, off);
+	*pprog = prog;
+	return 0;
+}
+
 #define DONT_CLEAR 1
 
 bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
@@ -1982,6 +2030,15 @@ st:			if (is_imm8(insn->off))
 				return err;
 			break;
 
+		case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
+		case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
+			start_of_ldx = prog;
+			err = emit_atomic_index(&prog, insn->imm, BPF_SIZE(insn->code),
+						dst_reg, src_reg, X86_REG_R12, insn->off);
+			if (err)
+				return err;
+			goto populate_extable;
+
 			/* call */
 		case BPF_JMP | BPF_CALL: {
 			int offs;
@@ -3486,6 +3543,21 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
+bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
+{
+	if (!in_arena)
+		return true;
+	switch (insn->code) {
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		if (insn->imm == (BPF_AND | BPF_FETCH) ||
+		    insn->imm == (BPF_OR | BPF_FETCH) ||
+		    insn->imm == (BPF_XOR | BPF_FETCH))
+			return false;
+	}
+	return true;
+}
+
 bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 161d5f7b64ed..7a27f19bf44d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -75,6 +75,9 @@ struct ctl_table_header;
 /* unused opcode to mark special load instruction. Same as BPF_MSH */
 #define BPF_PROBE_MEM32	0xa0
 
+/* unused opcode to mark special atomic instruction */
+#define BPF_PROBE_ATOMIC 0xe0
+
 /* unused opcode to mark call to interpreter with arguments */
 #define BPF_CALL_ARGS	0xe0
 
@@ -997,6 +1000,7 @@ bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
+bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7a33a3a7e63c..a41718eaeefe 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2965,6 +2965,11 @@ bool __weak bpf_jit_supports_arena(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend satisfies the following two conditions:
  * 1) JIT backend supports atomic_xchg() on pointer-sized words.
  * 2) Under the specific arch, the implementation of xchg() is the same
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 590db4e4c071..2aad6d90550f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6970,6 +6970,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	return err;
 }
 
+static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
+			     bool allow_trust_missmatch);
+
 static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
 {
 	int load_reg;
@@ -7030,7 +7033,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	    is_pkt_reg(env, insn->dst_reg) ||
 	    is_flow_key_reg(env, insn->dst_reg) ||
 	    is_sk_reg(env, insn->dst_reg) ||
-	    is_arena_reg(env, insn->dst_reg)) {
+	    (is_arena_reg(env, insn->dst_reg) && !bpf_jit_supports_insn(insn, true))) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
 			reg_type_str(env, reg_state(env, insn->dst_reg)->type));
@@ -7066,6 +7069,11 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (err)
 		return err;
 
+	if (is_arena_reg(env, insn->dst_reg)) {
+		err = save_aux_ptr_type(env, PTR_TO_ARENA, false);
+		if (err)
+			return err;
+	}
 	/* Check whether we can write into the same memory. */
 	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
@@ -18955,6 +18963,12 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
 			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
 			type = BPF_WRITE;
+		} else if ((insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
+			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW)) &&
+			   env->insn_aux_data[i + delta].ptr_type == PTR_TO_ARENA) {
+			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
+			env->prog->aux->num_exentries++;
+			continue;
 		} else {
 			continue;
 		}
@@ -19226,6 +19240,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			     BPF_CLASS(insn->code) == BPF_ST) &&
 			     BPF_MODE(insn->code) == BPF_PROBE_MEM32)
 				num_exentries++;
+			if (BPF_CLASS(insn->code) == BPF_STX &&
+			     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC)
+				num_exentries++;
 		}
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
-- 
2.43.0

