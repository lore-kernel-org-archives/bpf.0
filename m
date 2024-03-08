Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AB21379
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860117; cv=none; b=bLnZlyWolTdTS1VWyMRM+43RW1KhDO+HhRQiydWbdQZWRSyXuANHKYQVgtszVCUgOZlgxNPGyiS6xp9gEfHcAtMiAmL+VppcLWwaNxi9ABaVSe3l6fmO5FtWAxkxjXI/L4eo1T1sExXth9HjzafrcbHzj+BlUxkssWPOFQEAZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860117; c=relaxed/simple;
	bh=c997/1CDh+iQxItNWusrIV88YLyd45ta65BckREANpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INPVnKyh1v5I51TBklx2rKV7gQHHm8dR6x/WrUUoddFjhvi4ql9Xgf92iaLfWIVqaKAwOwsOxKtyb/VpG80I+Hkme7s3OE8mgnzkInP/nAdeTg9kabWuyTKPBq3WEM2NPY8Xf/3IyFeVgYvJNNP2zzVl7Ik0vITeX4Qju+qDAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8OUhtY4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8OUhtY4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dd59b95677so2552465ad.1
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860114; x=1710464914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lkyp9efeEagfn6y8PJPOXOX09CgdUF30AdwzL8hr20Y=;
        b=V8OUhtY4W1qOFw6QCtYJdwkbqkvlV/J44HogpR6kixJOQC6FWH62QEw7WMs5wQIgC5
         i652uA+C1p8Q3PsyM/52OslRp9NQxCkij428QcNzpCK2RqndvaKIWjXT3KNuVsTzAvrF
         sdMgcpIGT5cO5jYBT3gqVJ9wVUqEVZOXaT9xvEUeqvatmbJpulJ3yHsENNoFG1yGUK0S
         jzVSWaHrg5mYxTFgRpEyvYzfVfgpnJS+Hk2ZHhTW/dxHPymTQ3hcyZy+fXpAadGH5nDn
         K9/GQj6TBihG2uaw2im3HTTFk6R1/qlOd9rAhwmm80QA4COQKu4vJWRQJDzSQpSEBAyk
         z2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860114; x=1710464914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lkyp9efeEagfn6y8PJPOXOX09CgdUF30AdwzL8hr20Y=;
        b=P+aFLW7mqPT5UI1/hwaPiOp1dQv8bHRAqHYLP+m4nHEfbv2tkJZ2ILGB9TwXVAO0QV
         0HW20MSavJ2gQZoQCjoINCowa9zb6r3Cz+9/SkfXTehGVYPvT77qkWvZCg5A+SReLwMG
         iG4+ZpUqxhpZs+UGsGBbVjExCppnLA8YsEKRm7ibxy0Xh2l/O87YU3zP9jwQoD1FM8lX
         AAmJX7n77beZR44E0UaqwUpxlDZ/lW/CHP3m+TU138pN2DIXIM2jucru6IcjwJuxAKPJ
         4wJGrQNoFR5LXY+iq64/+x2Uq+38Awlq3O5rRpZL2zNN6u6e35Q5C6oaH0yh+N8Gf2FX
         Dg0g==
X-Gm-Message-State: AOJu0YzvU+/KWyMfHetatOyqQjHJ68BYCHRi9uN2/vg9SnUCA1TAW5ur
	xLZdbJN7VCVRONDyXvo1XNRl2wfS1VQGe1UX2Upi6mD80Z31EkB9YXRevYtb
X-Google-Smtp-Source: AGHT+IGbPH2MtuaGWw0VekvRznI8x2ly+NuakKatvQ2KPmQwUaZIGdnaGGExWa1D3KERl05ySFE8ug==
X-Received: by 2002:a17:902:c406:b0:1dc:177b:1d85 with SMTP id k6-20020a170902c40600b001dc177b1d85mr11828080plk.27.1709860114086;
        Thu, 07 Mar 2024 17:08:34 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b001dccaafe249sm2971923plb.220.2024.03.07.17.08.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:33 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 05/14] bpf: Recognize addr_space_cast instruction in the verifier.
Date: Thu,  7 Mar 2024 17:08:03 -0800
Message-Id: <20240308010812.89848-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

rY = addr_space_cast(rX, 0, 1) tells the verifier that rY->type = PTR_TO_ARENA.
Any further operations on PTR_TO_ARENA register have to be in 32-bit domain.

The verifier will mark load/store through PTR_TO_ARENA with PROBE_MEM32.
JIT will generate them as kern_vm_start + 32bit_addr memory accesses.

rY = addr_space_cast(rX, 1, 0) tells the verifier that rY->type = unknown scalar.
If arena->map_flags has BPF_F_NO_USER_CONV set then convert cast_user to mov32 as well.
Otherwise JIT will convert it to:
  rY = (u32)rX;
  if (rY)
     rY |= arena->user_vm_start & ~(u64)~0U;

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |   1 +
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/log.c             |   3 +
 kernel/bpf/syscall.c         |   6 ++
 kernel/bpf/verifier.c        | 107 ++++++++++++++++++++++++++++++++---
 5 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8904d1606125..d0c836ba009d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -883,6 +883,7 @@ enum bpf_reg_type {
 	 * an explicit null check is required for this struct.
 	 */
 	PTR_TO_MEM,		 /* reg points to valid memory region */
+	PTR_TO_ARENA,
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4b0f6600e499..7cb1b75eee38 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -548,6 +548,7 @@ struct bpf_insn_aux_data {
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
 	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
 	bool zext_dst; /* this insn zero extends dst reg */
+	bool needs_zext; /* alu op needs to clear upper bits */
 	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 63c34e7b0715..2a243cf37c60 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -458,6 +458,7 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 		[PTR_TO_XDP_SOCK]	= "xdp_sock",
 		[PTR_TO_BTF_ID]		= "ptr_",
 		[PTR_TO_MEM]		= "mem",
+		[PTR_TO_ARENA]		= "arena",
 		[PTR_TO_BUF]		= "buf",
 		[PTR_TO_FUNC]		= "func",
 		[PTR_TO_MAP_KEY]	= "map_key",
@@ -693,6 +694,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	}
 
 	verbose(env, "%s", reg_type_str(env, t));
+	if (t == PTR_TO_ARENA)
+		return;
 	if (t == PTR_TO_STACK) {
 		if (state->frameno != reg->frameno)
 			verbose(env, "[%d]", reg->frameno);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 67923e41a07e..07f2a4db4511 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4453,6 +4453,12 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 			continue;
 		}
 
+		if ((BPF_CLASS(code) == BPF_LDX || BPF_CLASS(code) == BPF_STX ||
+		     BPF_CLASS(code) == BPF_ST) && BPF_MODE(code) == BPF_PROBE_MEM32) {
+			insns[i].code = BPF_CLASS(code) | BPF_SIZE(code) | BPF_MEM;
+			continue;
+		}
+
 		if (code != (BPF_LD | BPF_IMM | BPF_DW))
 			continue;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fbcf2e5e635a..1358e20d315a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4386,6 +4386,7 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_MEM:
 	case PTR_TO_FUNC:
 	case PTR_TO_MAP_KEY:
+	case PTR_TO_ARENA:
 		return true;
 	default:
 		return false;
@@ -5828,6 +5829,8 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
 	case PTR_TO_XDP_SOCK:
 		pointer_desc = "xdp_sock ";
 		break;
+	case PTR_TO_ARENA:
+		return 0;
 	default:
 		break;
 	}
@@ -6937,6 +6940,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
+	} else if (reg->type == PTR_TO_ARENA) {
+		if (t == BPF_READ && value_regno >= 0)
+			mark_reg_unknown(env, regs, value_regno);
 	} else {
 		verbose(env, "R%d invalid mem access '%s'\n", regno,
 			reg_type_str(env, reg->type));
@@ -8408,6 +8414,7 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_MEM | MEM_RINGBUF:
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
+	case PTR_TO_ARENA:
 	case SCALAR_VALUE:
 		return 0;
 	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
@@ -13852,6 +13859,21 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
 	dst_reg = &regs[insn->dst_reg];
 	src_reg = NULL;
+
+	if (dst_reg->type == PTR_TO_ARENA) {
+		struct bpf_insn_aux_data *aux = cur_aux(env);
+
+		if (BPF_CLASS(insn->code) == BPF_ALU64)
+			/*
+			 * 32-bit operations zero upper bits automatically.
+			 * 64-bit operations need to be converted to 32.
+			 */
+			aux->needs_zext = true;
+
+		/* Any arithmetic operations are allowed on arena pointers */
+		return 0;
+	}
+
 	if (dst_reg->type != SCALAR_VALUE)
 		ptr_reg = dst_reg;
 	else
@@ -13969,19 +13991,20 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	} else if (opcode == BPF_MOV) {
 
 		if (BPF_SRC(insn->code) == BPF_X) {
-			if (insn->imm != 0) {
-				verbose(env, "BPF_MOV uses reserved fields\n");
-				return -EINVAL;
-			}
-
 			if (BPF_CLASS(insn->code) == BPF_ALU) {
-				if (insn->off != 0 && insn->off != 8 && insn->off != 16) {
+				if ((insn->off != 0 && insn->off != 8 && insn->off != 16) ||
+				    insn->imm) {
 					verbose(env, "BPF_MOV uses reserved fields\n");
 					return -EINVAL;
 				}
+			} else if (insn->off == BPF_ADDR_SPACE_CAST) {
+				if (insn->imm != 1 && insn->imm != 1u << 16) {
+					verbose(env, "addr_space_cast insn can only convert between address space 1 and 0\n");
+					return -EINVAL;
+				}
 			} else {
-				if (insn->off != 0 && insn->off != 8 && insn->off != 16 &&
-				    insn->off != 32) {
+				if ((insn->off != 0 && insn->off != 8 && insn->off != 16 &&
+				     insn->off != 32) || insn->imm) {
 					verbose(env, "BPF_MOV uses reserved fields\n");
 					return -EINVAL;
 				}
@@ -14008,7 +14031,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			struct bpf_reg_state *dst_reg = regs + insn->dst_reg;
 
 			if (BPF_CLASS(insn->code) == BPF_ALU64) {
-				if (insn->off == 0) {
+				if (insn->imm) {
+					/* off == BPF_ADDR_SPACE_CAST */
+					mark_reg_unknown(env, regs, insn->dst_reg);
+					if (insn->imm == 1) /* cast from as(1) to as(0) */
+						dst_reg->type = PTR_TO_ARENA;
+				} else if (insn->off == 0) {
 					/* case: R1 = R2
 					 * copy register state to dest reg
 					 */
@@ -15182,6 +15210,10 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 	if (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
+		if (map->map_type == BPF_MAP_TYPE_ARENA) {
+			__mark_reg_unknown(env, dst_reg);
+			return 0;
+		}
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
 		WARN_ON_ONCE(map->max_entries != 1);
@@ -16568,6 +16600,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * the same stack frame, since fp-8 in foo != fp-8 in bar
 		 */
 		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
+	case PTR_TO_ARENA:
+		return true;
 	default:
 		return regs_exact(rold, rcur, idmap);
 	}
@@ -17443,6 +17477,7 @@ static bool reg_type_mismatch_ok(enum bpf_reg_type type)
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
+	case PTR_TO_ARENA:
 		return false;
 	default:
 		return true;
@@ -18296,6 +18331,31 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				fdput(f);
 				return -EBUSY;
 			}
+			if (map->map_type == BPF_MAP_TYPE_ARENA) {
+				if (env->prog->aux->arena) {
+					verbose(env, "Only one arena per program\n");
+					fdput(f);
+					return -EBUSY;
+				}
+				if (!env->allow_ptr_leaks || !env->bpf_capable) {
+					verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
+					fdput(f);
+					return -EPERM;
+				}
+				if (!env->prog->jit_requested) {
+					verbose(env, "JIT is required to use arena\n");
+					return -EOPNOTSUPP;
+				}
+				if (!bpf_jit_supports_arena()) {
+					verbose(env, "JIT doesn't support arena\n");
+					return -EOPNOTSUPP;
+				}
+				env->prog->aux->arena = (void *)map;
+				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
+					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
+					return -EINVAL;
+				}
+			}
 
 			fdput(f);
 next_insn:
@@ -18917,6 +18977,14 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				env->prog->aux->num_exentries++;
 			}
 			continue;
+		case PTR_TO_ARENA:
+			if (BPF_MODE(insn->code) == BPF_MEMSX) {
+				verbose(env, "sign extending loads from arena are not supported yet\n");
+				return -EOPNOTSUPP;
+			}
+			insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32 | BPF_SIZE(insn->code);
+			env->prog->aux->num_exentries++;
+			continue;
 		default:
 			continue;
 		}
@@ -19102,13 +19170,19 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->nr_linfo = prog->aux->nr_linfo;
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
+		func[i]->aux->arena = prog->aux->arena;
 		num_exentries = 0;
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
 			if (BPF_CLASS(insn->code) == BPF_LDX &&
 			    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+			     BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
 			     BPF_MODE(insn->code) == BPF_PROBE_MEMSX))
 				num_exentries++;
+			if ((BPF_CLASS(insn->code) == BPF_STX ||
+			     BPF_CLASS(insn->code) == BPF_ST) &&
+			     BPF_MODE(insn->code) == BPF_PROBE_MEM32)
+				num_exentries++;
 		}
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
@@ -19507,6 +19581,21 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	}
 
 	for (i = 0; i < insn_cnt;) {
+		if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
+			if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
+			    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
+				/* convert to 32-bit mov that clears upper 32-bit */
+				insn->code = BPF_ALU | BPF_MOV | BPF_X;
+				/* clear off, so it's a normal 'wX = wY' from JIT pov */
+				insn->off = 0;
+			} /* cast from as(0) to as(1) should be handled by JIT */
+			goto next_insn;
+		}
+
+		if (env->insn_aux_data[i + delta].needs_zext)
+			/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
+			insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
+
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
-- 
2.43.0

