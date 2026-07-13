Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25C31F9B7;
	Mon, 13 Jul 2026 02:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910658; cv=none; b=oyOjQFu7x39EAkEtuzgPbzREU9vgZh42Lue73Uw8XHXxLamM4f0P+3Tkw+e8gsouqjXrFeSK0+TcuA+LCewINf18ea3UWrMF1/0++8AbakT6w3/IO9w9IQEND9SlJ6D8lQwhB3q61HA5NyaSvHff2fcOEJnWf/gRiYeGCQ+2qbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910658; c=relaxed/simple;
	bh=undR9u0NMDBm8Fk/FfEdax7WV4xMh3NFoI1kOYBGmQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z90jEPGmc9aQKK7JivYJaRYMHZgfQsdaMN878Wq2cnxPR9PDZXiSsyVN+EgIVo4ZHLWihYzkWrnvrI4r0KF3NlVjJptl+qdlKMC1LqE9PeupZke0lEYbm/57RekoFYJkwndqIOJuKRs5rQ3V2OJuBrPFH4cKmA9j/yWBkx3zHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isMeg9vB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isMeg9vB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04261F00A3A;
	Mon, 13 Jul 2026 02:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910657;
	bh=gzyRii9mw/0NcKb7ElmsK5Shp+DDYGHTpEmZBaBolpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=isMeg9vB81wSI6j8U2MuDx+r/Ogc/RHNT0ydK0uz8eddd2xqaN2ph2r+moWq9UXVP
	 iqyGRqrVDY33BzrjqJrehNpm2/fn7sHfArhxdUIGmZU/h/ls2o7CkzprjvI9moo77P
	 p8UA7XKlOTke2RjyZPUcOnTOTEMHtP7LB1CAEZ0QTlPCdda+nKOFSH2rJrASpZbhxe
	 dGK13yvOA5zyF0IkCp3vuGm1LtE7diD17tg12mUKU5KCX8O/j80+yZbz46JrE24MFF
	 rE/B8S4/DLVBNvWZBjpcGhpdpnOlPch3jT1QH26d02ZW2UtHMB/Xc0QtELEzdpqbgt
	 sb3f6mUi8iD4w==
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET SLOP RFC 1/6] bpf: Support __arena suffix for kfunc arguments
Date: Sun, 12 Jul 2026 16:44:09 -1000
Message-ID: <20260713024414.3759854-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713024414.3759854-1-tj@kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing an arena pointer to a kfunc takes two steps today. There is no
arena pointer argument type, so the pointer crosses the boundary as a bare
scalar, and the kfunc then offsets it by the arena base and casts it
before it can touch the memory. Every such kfunc open-codes the same
translation.

Add the __arena argument suffix and both steps go away. The kfunc declares
the parameter by its real pointer type and dereferences it directly. The
verifier rebases each one at the call site, rN = kern_vm_start + (u32)rN
with NULL preserved. No bounds check is needed: the u32 offset stays within
the guard-padded arena kernel mapping, and a fault on an unpopulated page
recovers through the per-arena scratch page. A suffixed argument accepts a
PTR_TO_ARENA or scalar register, matching global subprog arena arguments.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 22 +++++++++
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/verifier.c        | 86 +++++++++++++++++++++++++++++++++---
 3 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index c801a330aece..bad2ac85b318 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -250,6 +250,26 @@ This annotation is used to indicate that the argument is a constant string.
                 ...
         }
 
+2.3.7 __arena Annotation
+------------------------
+
+This annotation is used to indicate that the pointer argument points into
+the program's arena. The verifier translates it to a directly
+dereferenceable kernel address before the call, subject to the access
+rules described in :ref:`BPF_kfunc_arena_access`. NULL is preserved and the
+kfunc is responsible for checking for NULL before dereferencing.
+
+An example is given below::
+
+        __bpf_kfunc int bpf_process_item(struct item *item__arena)
+        {
+        ...
+        }
+
+Calling such a kfunc requires the program to use an arena map. The program
+can pass any value without compromising the kernel. A value that does not
+point into the arena is a program bug.
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
@@ -487,6 +507,8 @@ In order to accommodate such requirements, the verifier will enforce strict
 PTR_TO_BTF_ID type matching if two types have the exact same name, with one
 being suffixed with ``___init``.
 
+.. _BPF_kfunc_arena_access:
+
 2.8 Accessing arena memory through kfunc arguments
 --------------------------------------------------
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 317e99b9acc0..2153d546736a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -690,6 +690,8 @@ struct bpf_insn_aux_data {
 	 */
 	u8 fastcall_spills_num:3;
 	u8 arg_prog:4;
+	/* bitmask of R1-R5 kfunc args to rebase to arena kernel addresses */
+	u8 arg_arena_regs;
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03e2202cca13..b2b00a612e58 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10856,6 +10856,11 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }
 
+static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__arena");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -12060,6 +12065,32 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			continue;
 		}
 
+		if (is_kfunc_arg_arena(btf, &args[i])) {
+			t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+			if (verifier_bug_if(!btf_type_is_ptr(t), env,
+					    "kfunc %s arg#%d has __arena tag on non-pointer",
+					    func_name, i))
+				return -EFAULT;
+			if (!env->prog->aux->arena) {
+				verbose(env,
+					"%s arena pointer requires a program with an associated arena\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			if (regno < 0) {
+				verbose(env, "%s arena pointer cannot be a stack argument\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a pointer to arena or scalar\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			cur_aux(env)->arg_arena_regs |= BIT(regno - BPF_REG_1);
+			continue;
+		}
+
 		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
 			continue;
 
@@ -19890,13 +19921,58 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = 6;
 	}
 
-	if (env->insn_aux_data[insn_idx].arg_prog) {
-		u32 regno = env->insn_aux_data[insn_idx].arg_prog;
-		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(regno, (long)env->prog->aux) };
+	if (env->insn_aux_data[insn_idx].arg_prog ||
+	    env->insn_aux_data[insn_idx].arg_arena_regs) {
+		unsigned long arena_regs = env->insn_aux_data[insn_idx].arg_arena_regs;
+		u64 kern_vm_start = bpf_arena_get_kern_vm_start(env->prog->aux->arena);
+		u32 prog_regno = env->insn_aux_data[insn_idx].arg_prog;
 		int idx = *cnt;
+		int bit;
 
-		insn_buf[idx++] = ld_addrs[0];
-		insn_buf[idx++] = ld_addrs[1];
+		if (verifier_bug_if(idx, env, "kfunc call at %d already patched", insn_idx))
+			return -EFAULT;
+
+		/*
+		 * A kfunc may take both an __arena arg and the __prog aux. Emit
+		 * each present fixup, then append the call once.
+		 */
+		if (arena_regs) {
+			bool blinding = env->prog->blinding_requested;
+			int base_reg = blinding ? BPF_REG_0 : BPF_REG_AX;
+			struct bpf_insn ld[2] = { BPF_LD_IMM64(base_reg, kern_vm_start) };
+
+			/*
+			 * rN = kern_vm_start + (u32)rN, NULL left as 0.
+			 * Constant blinding rewrites immediate-carrying insns
+			 * unless they use BPF_REG_AX. With hardening, the
+			 * constant sits in R0 (an AX-destined LD_IMM64 would be
+			 * corrupted) and NULL is tested against AX = 0. Without
+			 * hardening, use the cheaper AX constant and immediate
+			 * test.
+			 */
+			insn_buf[idx++] = ld[0];
+			insn_buf[idx++] = ld[1];
+			if (blinding)
+				insn_buf[idx++] = BPF_MOV64_IMM(BPF_REG_AX, 0);
+
+			for_each_set_bit(bit, &arena_regs, MAX_BPF_FUNC_REG_ARGS) {
+				int regno = BPF_REG_1 + bit;
+
+				insn_buf[idx++] = BPF_ZEXT_REG(regno);
+				insn_buf[idx++] = blinding ?
+					BPF_JMP_REG(BPF_JEQ, regno, BPF_REG_AX, 1) :
+					BPF_JMP_IMM(BPF_JEQ, regno, 0, 1);
+				insn_buf[idx++] = BPF_ALU64_REG(BPF_ADD, regno, base_reg);
+			}
+		}
+		if (prog_regno) {
+			struct bpf_insn ld_addrs[2] = {
+				BPF_LD_IMM64(prog_regno, (long)env->prog->aux)
+			};
+
+			insn_buf[idx++] = ld_addrs[0];
+			insn_buf[idx++] = ld_addrs[1];
+		}
 		insn_buf[idx++] = *insn;
 		*cnt = idx;
 	}
-- 
2.55.0

