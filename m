Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162317B50A
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007788; cv=none; b=qzn+VSUgCQmmATIndHOEZ5Yky9CDL6DDUhMihIDpQsi5hdRPnkGSH3I8ydwbmeFTEw97yNlDKEnHXcy5CZOTMRvrF77N6FnyzRQBqdtZNbX34MeDuf8WOHpx2POlniGf0lMiouRfe3q5ph7Di3ORW/Kej1YCgvWtxmwJC5V273A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007788; c=relaxed/simple;
	bh=uAhbXE1x+z72O+BkBBH07o4Ho5vGcGBhu3va7Ocz3S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwIwZSAZZ8Uv59xcrVQT9+7h9RsbnRENUk9dttIuNXNp4i06TgrM+ftyY5UI8nKDyNCAPsnN7ld0eWPGZhhgeAhueZyebnMAq8OyggOSRR4YKwS8PJA59F1y4DrflvWAO2zKJij1OWSTT/OOPaYDNseLe9yeFqz5mNTwx9ajOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJDwhEXp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJDwhEXp"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso234466a91.2
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776007786; x=1776612586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbzhHNiX2rlidWU9aJccJBzq6bwjnOobMEQvvjogvP0=;
        b=XJDwhEXp5YnlUAXBUpCzvkXJBi5QzE75mwHbPImMIySAO3nhT/m4n6a0eFC8jAP9RF
         9VX5DZ1FqwefIBlfEtlHb4YHo76YKMQnryrAteQ1YHNdFwruLBYUcrLqrMGrh6D/XKeo
         +E4lLseEg0slQknOFlCjhxT+9vw6t2hDfA8dxXgH75cBsjH/5Ih1IStKCUE1Be4HtfP+
         NMH+bapVOHPQII1ses7NHEjFeceBsORJUj7ykkLvJw6ZooFxD+7sxhrsoijlF0C0YnYc
         BsXzY3R9N3k8gsIlYwkzUVZLHT/40bSCZ0ysP7F5fowoq0irgzsV10eqk0+ngv55DjsY
         OOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776007786; x=1776612586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kbzhHNiX2rlidWU9aJccJBzq6bwjnOobMEQvvjogvP0=;
        b=er+Ovg18iFboyNJcC5hiWqUrhoylYYup3Mw8sbu/3OLuqDu42hM6xmhD02QC379UY5
         Wji40+tjVzDUH86SQxGZ0ZFpL2spTnRQVEEzE7+wy6dFkor+6GdcPAVhEPxdf1394CfL
         QUcQ0i6PmUqeQkr04ZPG9ocs9tIXsNVsB9gsLX8RMtUWKz0P47OuzRGOYt+ZPm5esTGV
         Yh3d5jOtsagu1o4MY6Vn3T7GT8RUDHSaHChPVBT+2ldRgduhRUL9bXJLYZwvAaMmCdIR
         Dkx7k5hj+w9JqE4h8geaAQp53/FH63yPUYhQddPDF4X+T+WZDqtjmFAw44Gj6voMZ3bQ
         yvaA==
X-Gm-Message-State: AOJu0YzJ3ymqVnZPl8Zegt3uFL9YD0+WdQ1S1xFYCWPnizu12u8SFfmA
	OZgUvgk78k8DNi0eKyN/irN6zMEBxq4tWCQ31HsjjSQPc+GyrehAdUAgbgKPTw==
X-Gm-Gg: AeBDiesJKOdmVZMMScsiFjIWL+hUq77FXBazs0BswerCmlHvFohAOrVAvUIDBAaRNUC
	AnEFsbaAfpt7ocqzgPhISanxG5PK+6O9gRK7O3ROmWJXOYpKUJw8J6oVe4Kmm51tmIDi0P25NYU
	f6or4+Wyb7a0yHEmzUoigew1tzcQd5jPNiH5TWImOU9MnpsaZ3YH3HPgcvxg0R1ic7OlojVb6iQ
	27y5ZgmUntkxF3oUZzKZvFSur/QBuo3/+1EasRGaHQ4sM5t7wPxrJevDJW1IjO+rKDRoyhPZ0NV
	VQfRVXVUtImOWku7J7x8zA1XtzOSLaUOLT4mj83wHogon1cg4Qno98vES5TP0q77Wd/MhWZEtwG
	SV3zETIAl6w1jXmim/sZ/ARhoPOsjN2l7tTDxoIYelmvvlU79nRaKEtamI0v63Qxx/IOUAbmHIy
	f9FgS9n9pmOO3HVKyEWve9WQpVZ/CmsU4xAM+K09zd4SDtlHsDx66Rh98TVZ37lJfhlS8JCG/5K
	Dqp+G4N6sJuz6eyeQSvpR4VOsWksBL5KYImerLV17WQeBoR2xmuNZcXIaDemgcxwCoWfvVN
X-Received: by 2002:a17:90b:4a04:b0:35e:3afb:a3ff with SMTP id 98e67ed59e1d1-35e42541708mr10646371a91.3.1776007785915;
        Sun, 12 Apr 2026 08:29:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e42db1b51sm3836412a91.3.2026.04.12.08.29.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Apr 2026 08:29:45 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v4 bpf-next 2/6] bpf: Move compute_insn_live_regs() into liveness.c
Date: Sun, 12 Apr 2026 08:29:31 -0700
Message-ID: <20260412152936.54262-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260412152936.54262-1-alexei.starovoitov@gmail.com>
References: <20260412152936.54262-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

verifier.c is huge. Move compute_insn_live_regs() into liveness.c.

Mechanical move. No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/liveness.c        | 247 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 250 +----------------------------------
 3 files changed, 250 insertions(+), 249 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4380ecad485b..e3f18667e030 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1204,6 +1204,7 @@ int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
+int bpf_compute_live_registers(struct bpf_verifier_env *env);
 
 #define BPF_MAP_KEY_POISON	(1ULL << 63)
 #define BPF_MAP_KEY_SEEN	(1ULL << 62)
@@ -1234,6 +1235,7 @@ static inline u64 bpf_map_key_immediate(const struct bpf_insn_aux_data *aux)
 }
 
 #define MAX_PACKET_OFF 0xffff
+#define CALLER_SAVED_REGS 6
 
 enum bpf_reg_arg_type {
 	SRC_OP,		/* register is used as source operand */
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 59d990237cbd..1fb4c511db5a 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1953,3 +1953,250 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 	kvfree(info);
 	return err;
 }
+
+/* Each field is a register bitmask */
+struct insn_live_regs {
+	u16 use;	/* registers read by instruction */
+	u16 def;	/* registers written by instruction */
+	u16 in;		/* registers that may be alive before instruction */
+	u16 out;	/* registers that may be alive after instruction */
+};
+
+/* Bitmask with 1s for all caller saved registers */
+#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
+
+/* Compute info->{use,def} fields for the instruction */
+static void compute_insn_live_regs(struct bpf_verifier_env *env,
+				   struct bpf_insn *insn,
+				   struct insn_live_regs *info)
+{
+	struct bpf_call_summary cs;
+	u8 class = BPF_CLASS(insn->code);
+	u8 code = BPF_OP(insn->code);
+	u8 mode = BPF_MODE(insn->code);
+	u16 src = BIT(insn->src_reg);
+	u16 dst = BIT(insn->dst_reg);
+	u16 r0  = BIT(0);
+	u16 def = 0;
+	u16 use = 0xffff;
+
+	switch (class) {
+	case BPF_LD:
+		switch (mode) {
+		case BPF_IMM:
+			if (BPF_SIZE(insn->code) == BPF_DW) {
+				def = dst;
+				use = 0;
+			}
+			break;
+		case BPF_LD | BPF_ABS:
+		case BPF_LD | BPF_IND:
+			/* stick with defaults */
+			break;
+		}
+		break;
+	case BPF_LDX:
+		switch (mode) {
+		case BPF_MEM:
+		case BPF_MEMSX:
+			def = dst;
+			use = src;
+			break;
+		}
+		break;
+	case BPF_ST:
+		switch (mode) {
+		case BPF_MEM:
+			def = 0;
+			use = dst;
+			break;
+		}
+		break;
+	case BPF_STX:
+		switch (mode) {
+		case BPF_MEM:
+			def = 0;
+			use = dst | src;
+			break;
+		case BPF_ATOMIC:
+			switch (insn->imm) {
+			case BPF_CMPXCHG:
+				use = r0 | dst | src;
+				def = r0;
+				break;
+			case BPF_LOAD_ACQ:
+				def = dst;
+				use = src;
+				break;
+			case BPF_STORE_REL:
+				def = 0;
+				use = dst | src;
+				break;
+			default:
+				use = dst | src;
+				if (insn->imm & BPF_FETCH)
+					def = src;
+				else
+					def = 0;
+			}
+			break;
+		}
+		break;
+	case BPF_ALU:
+	case BPF_ALU64:
+		switch (code) {
+		case BPF_END:
+			use = dst;
+			def = dst;
+			break;
+		case BPF_MOV:
+			def = dst;
+			if (BPF_SRC(insn->code) == BPF_K)
+				use = 0;
+			else
+				use = src;
+			break;
+		default:
+			def = dst;
+			if (BPF_SRC(insn->code) == BPF_K)
+				use = dst;
+			else
+				use = dst | src;
+		}
+		break;
+	case BPF_JMP:
+	case BPF_JMP32:
+		switch (code) {
+		case BPF_JA:
+			def = 0;
+			if (BPF_SRC(insn->code) == BPF_X)
+				use = dst;
+			else
+				use = 0;
+			break;
+		case BPF_JCOND:
+			def = 0;
+			use = 0;
+			break;
+		case BPF_EXIT:
+			def = 0;
+			use = r0;
+			break;
+		case BPF_CALL:
+			def = ALL_CALLER_SAVED_REGS;
+			use = def & ~BIT(BPF_REG_0);
+			if (bpf_get_call_summary(env, insn, &cs))
+				use = GENMASK(cs.num_params, 1);
+			break;
+		default:
+			def = 0;
+			if (BPF_SRC(insn->code) == BPF_K)
+				use = dst;
+			else
+				use = dst | src;
+		}
+		break;
+	}
+
+	info->def = def;
+	info->use = use;
+}
+
+/* Compute may-live registers after each instruction in the program.
+ * The register is live after the instruction I if it is read by some
+ * instruction S following I during program execution and is not
+ * overwritten between I and S.
+ *
+ * Store result in env->insn_aux_data[i].live_regs.
+ */
+int bpf_compute_live_registers(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *insn_aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	struct insn_live_regs *state;
+	int insn_cnt = env->prog->len;
+	int err = 0, i, j;
+	bool changed;
+
+	/* Use the following algorithm:
+	 * - define the following:
+	 *   - I.use : a set of all registers read by instruction I;
+	 *   - I.def : a set of all registers written by instruction I;
+	 *   - I.in  : a set of all registers that may be alive before I execution;
+	 *   - I.out : a set of all registers that may be alive after I execution;
+	 *   - insn_successors(I): a set of instructions S that might immediately
+	 *                         follow I for some program execution;
+	 * - associate separate empty sets 'I.in' and 'I.out' with each instruction;
+	 * - visit each instruction in a postorder and update
+	 *   state[i].in, state[i].out as follows:
+	 *
+	 *       state[i].out = U [state[s].in for S in insn_successors(i)]
+	 *       state[i].in  = (state[i].out / state[i].def) U state[i].use
+	 *
+	 *   (where U stands for set union, / stands for set difference)
+	 * - repeat the computation while {in,out} fields changes for
+	 *   any instruction.
+	 */
+	state = kvzalloc_objs(*state, insn_cnt, GFP_KERNEL_ACCOUNT);
+	if (!state) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < insn_cnt; ++i)
+		compute_insn_live_regs(env, &insns[i], &state[i]);
+
+	/* Forward pass: resolve stack access through FP-derived pointers */
+	err = bpf_compute_subprog_arg_access(env);
+	if (err)
+		goto out;
+
+	changed = true;
+	while (changed) {
+		changed = false;
+		for (i = 0; i < env->cfg.cur_postorder; ++i) {
+			int insn_idx = env->cfg.insn_postorder[i];
+			struct insn_live_regs *live = &state[insn_idx];
+			struct bpf_iarray *succ;
+			u16 new_out = 0;
+			u16 new_in = 0;
+
+			succ = bpf_insn_successors(env, insn_idx);
+			for (int s = 0; s < succ->cnt; ++s)
+				new_out |= state[succ->items[s]].in;
+			new_in = (new_out & ~live->def) | live->use;
+			if (new_out != live->out || new_in != live->in) {
+				live->in = new_in;
+				live->out = new_out;
+				changed = true;
+			}
+		}
+	}
+
+	for (i = 0; i < insn_cnt; ++i)
+		insn_aux[i].live_regs_before = state[i].in;
+
+	if (env->log.level & BPF_LOG_LEVEL2) {
+		verbose(env, "Live regs before insn:\n");
+		for (i = 0; i < insn_cnt; ++i) {
+			if (env->insn_aux_data[i].scc)
+				verbose(env, "%3d ", env->insn_aux_data[i].scc);
+			else
+				verbose(env, "    ");
+			verbose(env, "%3d: ", i);
+			for (j = BPF_REG_0; j < BPF_REG_10; ++j)
+				if (insn_aux[i].live_regs_before & BIT(j))
+					verbose(env, "%d", j);
+				else
+					verbose(env, ".");
+			verbose(env, " ");
+			bpf_verbose_insn(env, &insns[i]);
+			if (bpf_is_ldimm64(&insns[i]))
+				i++;
+		}
+	}
+
+out:
+	kvfree(state);
+	return err;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 31e03aa6b070..11f0c5a050b3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2144,7 +2144,6 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	return &elem->st;
 }
 
-#define CALLER_SAVED_REGS 6
 static const int caller_saved[CALLER_SAVED_REGS] = {
 	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
 };
@@ -23461,253 +23460,6 @@ static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr,
 	return 0;
 }
 
-/* Each field is a register bitmask */
-struct insn_live_regs {
-	u16 use;	/* registers read by instruction */
-	u16 def;	/* registers written by instruction */
-	u16 in;		/* registers that may be alive before instruction */
-	u16 out;	/* registers that may be alive after instruction */
-};
-
-/* Bitmask with 1s for all caller saved registers */
-#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
-
-/* Compute info->{use,def} fields for the instruction */
-static void compute_insn_live_regs(struct bpf_verifier_env *env,
-				   struct bpf_insn *insn,
-				   struct insn_live_regs *info)
-{
-	struct bpf_call_summary cs;
-	u8 class = BPF_CLASS(insn->code);
-	u8 code = BPF_OP(insn->code);
-	u8 mode = BPF_MODE(insn->code);
-	u16 src = BIT(insn->src_reg);
-	u16 dst = BIT(insn->dst_reg);
-	u16 r0  = BIT(0);
-	u16 def = 0;
-	u16 use = 0xffff;
-
-	switch (class) {
-	case BPF_LD:
-		switch (mode) {
-		case BPF_IMM:
-			if (BPF_SIZE(insn->code) == BPF_DW) {
-				def = dst;
-				use = 0;
-			}
-			break;
-		case BPF_LD | BPF_ABS:
-		case BPF_LD | BPF_IND:
-			/* stick with defaults */
-			break;
-		}
-		break;
-	case BPF_LDX:
-		switch (mode) {
-		case BPF_MEM:
-		case BPF_MEMSX:
-			def = dst;
-			use = src;
-			break;
-		}
-		break;
-	case BPF_ST:
-		switch (mode) {
-		case BPF_MEM:
-			def = 0;
-			use = dst;
-			break;
-		}
-		break;
-	case BPF_STX:
-		switch (mode) {
-		case BPF_MEM:
-			def = 0;
-			use = dst | src;
-			break;
-		case BPF_ATOMIC:
-			switch (insn->imm) {
-			case BPF_CMPXCHG:
-				use = r0 | dst | src;
-				def = r0;
-				break;
-			case BPF_LOAD_ACQ:
-				def = dst;
-				use = src;
-				break;
-			case BPF_STORE_REL:
-				def = 0;
-				use = dst | src;
-				break;
-			default:
-				use = dst | src;
-				if (insn->imm & BPF_FETCH)
-					def = src;
-				else
-					def = 0;
-			}
-			break;
-		}
-		break;
-	case BPF_ALU:
-	case BPF_ALU64:
-		switch (code) {
-		case BPF_END:
-			use = dst;
-			def = dst;
-			break;
-		case BPF_MOV:
-			def = dst;
-			if (BPF_SRC(insn->code) == BPF_K)
-				use = 0;
-			else
-				use = src;
-			break;
-		default:
-			def = dst;
-			if (BPF_SRC(insn->code) == BPF_K)
-				use = dst;
-			else
-				use = dst | src;
-		}
-		break;
-	case BPF_JMP:
-	case BPF_JMP32:
-		switch (code) {
-		case BPF_JA:
-			def = 0;
-			if (BPF_SRC(insn->code) == BPF_X)
-				use = dst;
-			else
-				use = 0;
-			break;
-		case BPF_JCOND:
-			def = 0;
-			use = 0;
-			break;
-		case BPF_EXIT:
-			def = 0;
-			use = r0;
-			break;
-		case BPF_CALL:
-			def = ALL_CALLER_SAVED_REGS;
-			use = def & ~BIT(BPF_REG_0);
-			if (bpf_get_call_summary(env, insn, &cs))
-				use = GENMASK(cs.num_params, 1);
-			break;
-		default:
-			def = 0;
-			if (BPF_SRC(insn->code) == BPF_K)
-				use = dst;
-			else
-				use = dst | src;
-		}
-		break;
-	}
-
-	info->def = def;
-	info->use = use;
-}
-
-/* Compute may-live registers after each instruction in the program.
- * The register is live after the instruction I if it is read by some
- * instruction S following I during program execution and is not
- * overwritten between I and S.
- *
- * Store result in env->insn_aux_data[i].live_regs.
- */
-static int compute_live_registers(struct bpf_verifier_env *env)
-{
-	struct bpf_insn_aux_data *insn_aux = env->insn_aux_data;
-	struct bpf_insn *insns = env->prog->insnsi;
-	struct insn_live_regs *state;
-	int insn_cnt = env->prog->len;
-	int err = 0, i, j;
-	bool changed;
-
-	/* Use the following algorithm:
-	 * - define the following:
-	 *   - I.use : a set of all registers read by instruction I;
-	 *   - I.def : a set of all registers written by instruction I;
-	 *   - I.in  : a set of all registers that may be alive before I execution;
-	 *   - I.out : a set of all registers that may be alive after I execution;
-	 *   - insn_successors(I): a set of instructions S that might immediately
-	 *                         follow I for some program execution;
-	 * - associate separate empty sets 'I.in' and 'I.out' with each instruction;
-	 * - visit each instruction in a postorder and update
-	 *   state[i].in, state[i].out as follows:
-	 *
-	 *       state[i].out = U [state[s].in for S in insn_successors(i)]
-	 *       state[i].in  = (state[i].out / state[i].def) U state[i].use
-	 *
-	 *   (where U stands for set union, / stands for set difference)
-	 * - repeat the computation while {in,out} fields changes for
-	 *   any instruction.
-	 */
-	state = kvzalloc_objs(*state, insn_cnt, GFP_KERNEL_ACCOUNT);
-	if (!state) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	for (i = 0; i < insn_cnt; ++i)
-		compute_insn_live_regs(env, &insns[i], &state[i]);
-
-	/* Forward pass: resolve stack access through FP-derived pointers */
-	err = bpf_compute_subprog_arg_access(env);
-	if (err)
-		goto out;
-
-	changed = true;
-	while (changed) {
-		changed = false;
-		for (i = 0; i < env->cfg.cur_postorder; ++i) {
-			int insn_idx = env->cfg.insn_postorder[i];
-			struct insn_live_regs *live = &state[insn_idx];
-			struct bpf_iarray *succ;
-			u16 new_out = 0;
-			u16 new_in = 0;
-
-			succ = bpf_insn_successors(env, insn_idx);
-			for (int s = 0; s < succ->cnt; ++s)
-				new_out |= state[succ->items[s]].in;
-			new_in = (new_out & ~live->def) | live->use;
-			if (new_out != live->out || new_in != live->in) {
-				live->in = new_in;
-				live->out = new_out;
-				changed = true;
-			}
-		}
-	}
-
-	for (i = 0; i < insn_cnt; ++i)
-		insn_aux[i].live_regs_before = state[i].in;
-
-	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "Live regs before insn:\n");
-		for (i = 0; i < insn_cnt; ++i) {
-			if (env->insn_aux_data[i].scc)
-				verbose(env, "%3d ", env->insn_aux_data[i].scc);
-			else
-				verbose(env, "    ");
-			verbose(env, "%3d: ", i);
-			for (j = BPF_REG_0; j < BPF_REG_10; ++j)
-				if (insn_aux[i].live_regs_before & BIT(j))
-					verbose(env, "%d", j);
-				else
-					verbose(env, ".");
-			verbose(env, " ");
-			bpf_verbose_insn(env, &insns[i]);
-			if (bpf_is_ldimm64(&insns[i]))
-				i++;
-		}
-	}
-
-out:
-	kvfree(state);
-	return err;
-}
-
 /*
  * Compute strongly connected components (SCCs) on the CFG.
  * Assign an SCC number to each instruction, recorded in env->insn_aux[*].scc.
@@ -24247,7 +23999,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = compute_live_registers(env);
+	ret = bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-- 
2.52.0

