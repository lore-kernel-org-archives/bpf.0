Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC714F5E1B
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416153; cv=none; b=VoNCi5EwvEsvANXDMsXzZ5vHEXFcEWq3XuGgXGM73yEUENAKd8u3DxpSBLr81xDGly1i5dmOMt51GwMHT3rGIP25oh1+eC5qncZoJoXnJFIIq8JS32jUAE8f7zcXIW/WZeqX2NPplGcfImS7Ji887ESN1pStUl0DIcKHD8sddIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416153; c=relaxed/simple;
	bh=DaO3sVJtY4rh7NsUmpHhPw4VFCmPzdoyRzVBruHU6S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxkGBCMx5MUaS2QkkpGnh6B2agGODTBSeHWkeUb6yiHu47jkD6a2SnJXUQ8DL1rhPqREW6JjXWnx29Cd0Mzk40AzUk5/afg1wLqpOWc4sGRjW8bSXDThPF6q5PSDf7wB4j2jn4Jp0MpJmzrOK7q+FwmrejUfbHAdqTediNdwrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTVH9zQA; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTVH9zQA"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-82890dea412so868380a34.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416147; x=1793020947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AIfNevGm3HbiNpFeGixOvu/aK5FipqQqHTCQPzthzsM=;
        b=qTVH9zQAXcDjbTVo2sGRAX3Ce3N9bkXHT8D15ybLuA3ZB1AubnA75cX05kBOiW/qfd
         8YU4Rh9Cn0rKtdYmkE0XCuw49u7TINwgwVLsv5SkxwiQ8jCD9N+eEBJu4D54Pgi2yL3V
         D8px87plB08jwfcCdUxJodfV1Hcr+mioIKvPLfjuBjmePE2IPNqmEMAQt0DvBVriNQHs
         go/Mtjll3Qcgxm9x0N0GV8E1fEcfFzCOE4NhBpd09Mg3jHz69ocYqVKzCkWPw4cc3RoD
         3JAl9dWw7lVdzvQWVCV62JKIflMVb9jhi/GdbfPcyxNE1KkZNz3yZbECnV+Tl+zbZU4M
         HO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416147; x=1793020947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AIfNevGm3HbiNpFeGixOvu/aK5FipqQqHTCQPzthzsM=;
        b=MSZWdok5c+uO7zNhFGlo5CpfvL09hyBDtcCpZV8rzrswhVm16HPf1eCYtEW8etHWQP
         /NGvsUcnyVDnQORXbI4kV6FEXDyq8T1UGS+rA+0RXsAJMjb+O7arS/P0xoE97WHzBiVu
         adb2V7SM9ZplQ4uApoqe//dJQFnv97BasKxBTG25QVlne4UHvraasrR+rtesxbWpIhZ6
         bx8RiW1Qa0KxW3YwUsO/jleCukRZQnI/NnnJnh2ngfd6P8hK38t9o4v+NOfGVBObJggG
         yO0UMm8dDInxreCcll5kthxeAhCGstgv4TdF2Wx0Kioj1NuTWJ5zlLgih4qXTL/GFyIy
         6yQw==
X-Gm-Message-State: AFq9FYJGE6si+66eGQGq/lVZe8ATurDLtdAZ7ZnjP/jAceDQhtb84Ed1
	5DQsnfr8oNtAdFAxrP13cAgTweArdhUS3r6SMdB4M7Kd9m2af/5U/zxP56jlxqeDVdA=
X-Gm-Gg: AYBFou0VcfbPBPwimy73VsLOnpkRRhJUjzZTJ36XVWK/tLU08IqBdb3Tw5coWhOF0DL
	SXY56sQ1NwK3LoCpT776okR3FXNG8PQ23Fe7yrhMCXYm9tAKm6498ErAvZDgYrspHrkUjF2XDm/
	N1Hor2uPD6VXRoTnE9Oa+MjLb5Ej8SnyFtNz9Mjr7BUNYV/y0K8kkYLOCgCHKcaytjfMqX0HI4g
	S4F9Pp9wSJMGZn1Lzr0CAz6lvK4e8lxTbDfiF8Z0Yw8OZyXPgx3WlfBJ3kRe9yuiqfJMWN8uleL
	nTaPWyrxNTuZXNrTUb3pZRtK9Zx1XGX+raLKrrWRZmkYoVKfkHn2ABSxGmI+i0diDs5VMSnR41w
	PF7Mzb1XIGpTPibidQ3KOFkvmZt3SZ/zCESipzNPqJPgL7xRuEPvPSM6Zrnv1HffLpoEUNCesMR
	DOmvLWxvZ4xi0vmnHKF80TWhFhR5wqTrRetPed6AJ0nmBVwV2o/DNL35MnkRwCCxhONnt9wMvrR
	9SGCWMq3af0YymvbA+oSqYplVsumA9G4e6351rs5TpXKMUFDy7+EY+rQWCDLLd8ETKwQkPRDpyX
	5bN6
X-Received: by 2002:a05:6808:15a2:b0:4fa:95f4:3334 with SMTP id 5614622812f47-53cd14ef368mr4838430b6e.42.1792416147250;
        Mon, 19 Oct 2026 06:22:27 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388f6ed365sm7452875b6e.16.2026.10.19.06.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 07/16] bpf: Turn loads of __arena pointer members into arena pointers
Date: Mon, 19 Oct 2026 15:21:49 +0200
Message-ID: <20261019132203.3034698-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11734; h=from:subject; bh=DaO3sVJtY4rh7NsUmpHhPw4VFCmPzdoyRzVBruHU6S0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxBG9fXrTVzHlVIrsLLLrzFvJucB+Oufd/EmxD+oZn5k3 8R3uKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwET2v2T4ZyS++zZn15HrEnNXCdo7hE 42Frh6YNOFCJbDK64ujZ3LdoWRoVtXNf3/kne583dfNwmwdL//9oDOIaWo+pXtP/QWNxgeZwUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A kernel struct shared with BPF programs may want to point at arena
memory, e.g. a sched_ext argument struct that the kernel builds in the
scheduler's arena and that refers to another arena object. A pointer
member reaches the program typed as a kernel pointer, so sched_ext
publishes a plain u64 holding a pre-translated arena address that the
program casts before use.

Translate in the verifier instead. When a load through a kernel struct
pointer lands on a member tagged __arena, btf_struct_walk() reports it
and the destination register becomes PTR_TO_ARENA. The member holds the
kernel address of the arena memory; the fixup pass appends the
conversion to the arena pointer form that the struct_ops trampoline
applies to __arena arguments, after a plain load or a load-acquire of
the member:

  r1 = *(u64 *)(r2 + off)
  if r1 == 0 goto +1         // __nullable members and probed loads
  w1 -= lo32(kern_vm_start)

A probed load, through a plain or an untrusted pointer, keeps the NULL
test as well: it reads as 0 when it faults, and the subtraction must
not turn that into an arena pointer. An acquire load only comes through
a pointer that cannot fault.

Stores to kernel structs are rejected as before, and with them the
atomics that write such a member. A member
inside a multi-member union is rejected too: an offset into a union
resolves to its first member, so a program reading another member there
would receive an arena pointer it did not ask for. Loads through
program-allocated objects and program BTF are unaffected, there the tag
is what the compiler emits for the arena address space.

The rewrite is per insn while verification is per path, so the aux data
records what an insn loaded on any path: an insn that loaded an arena
pointer member on one path and a different member on another is
rejected by the fixup pass, while paths disagreeing only on __nullable
keep the NULL test, which a never-NULL member can afford. As for
__arena arguments, the program needs an associated arena, which also
supplies the base to subtract.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  8 +++++
 kernel/bpf/btf.c             | 30 ++++++++++++++++
 kernel/bpf/fixups.c          | 66 +++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        | 53 +++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 951a90458d18..54481da4ed2d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -793,6 +793,14 @@ struct bpf_insn_aux_data {
 	 */
 	u64 fastcall_spills_num:3;
 	u64 arg_prog:4;
+	/*
+	 * What a load found, on any path: an __arena pointer member of a
+	 * kernel struct, which arena_member_fixup() rewrites, one that is
+	 * __nullable as well, or anything else through any pointer.
+	 */
+	u64 arena_member:1;
+	u64 arena_member_nullable:1;
+	u64 non_arena_load:1;
 
 	/* below flags are initialized once */
 	u64 jmp_point:1;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 012b6c5c3eff..538129ed2418 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7707,6 +7707,7 @@ enum bpf_struct_walk_result {
 	WALK_SCALAR = 0,
 	WALK_PTR,
 	WALK_PTR_UNTRUSTED,
+	WALK_PTR_ARENA,
 	WALK_STRUCT,
 };
 
@@ -7987,6 +7988,30 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 			if (btf_ptr_has_type_tag(btf, mtype, "nullable"))
 				tmp_flag |= PTR_MAYBE_NULL;
 
+			/*
+			 * An __arena member of a kernel struct holds the kernel
+			 * address of arena memory, which the verifier turns into
+			 * an arena pointer on load. Program BTF is not affected:
+			 * there the tag is what the compiler emits for the arena
+			 * address space. An offset into a union resolves to its
+			 * first member, so a program reading another member there
+			 * would get an arena pointer it did not ask for; the walk
+			 * marked such a union untrusted.
+			 */
+			if (btf_is_kernel(btf) && btf_type_is_arena_ptr(btf, mtype)) {
+				if (*flag & PTR_UNTRUSTED) {
+					bpf_log(log,
+						"arena pointer member %s of %s is inside a union\n",
+						mname, tname);
+					return -EACCES;
+				}
+				*next_btf_id = id;
+				*flag |= tmp_flag & PTR_MAYBE_NULL;
+				if (field_name)
+					*field_name = mname;
+				return WALK_PTR_ARENA;
+			}
+
 			if (btf_type_is_struct(stype)) {
 				*next_btf_id = id;
 				*flag |= tmp_flag;
@@ -8089,6 +8114,11 @@ int btf_struct_access(struct bpf_verifier_log *log,
 			*flag = MEM_RDONLY | PTR_UNTRUSTED;
 			ret = PTR_TO_MEM;
 			goto check_variable_offset;
+		case WALK_PTR_ARENA:
+			*next_btf_id = id;
+			*flag = tmp_flag;
+			ret = PTR_TO_ARENA;
+			goto check_variable_offset;
 		case WALK_SCALAR:
 			ret = SCALAR_VALUE;
 			goto check_variable_offset;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index bfbb0cf5c0a8..34b53ebb5841 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -882,6 +882,37 @@ static bool ext_prog_takes_prologue(const struct bpf_verifier_env *env)
  *     struct __sk_buff    -> struct sk_buff
  *     struct bpf_sock_ops -> struct sock
  */
+/*
+ * A load through an __arena pointer member of a kernel struct reads the kernel
+ * address of arena memory. Append the conversion to the arena pointer form,
+ * (u32)(kaddr - kern_vm_start), that the struct_ops trampoline applies to
+ * __arena arguments. A __nullable member keeps NULL as NULL, tested on the
+ * full kernel address, and so does a probed load, which reads as 0 when it
+ * faults. Returns the number of insns in @buf, 0 when the insn loads no such
+ * member, or an error when it does so on some paths only.
+ */
+static int arena_member_fixup(struct bpf_verifier_env *env, int idx, struct bpf_insn *insn,
+			      struct bpf_insn *buf)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	int cnt = 0;
+	u32 base;
+
+	if (!aux->arena_member)
+		return 0;
+	if (aux->non_arena_load) {
+		verbose(env, "an insn loads an arena pointer member on one path and something else on another\n");
+		return -EINVAL;
+	}
+
+	base = bpf_arena_get_kern_vm_start(env->prog->aux->arena);
+	buf[cnt++] = *insn;
+	if (aux->arena_member_nullable || BPF_MODE(insn->code) == BPF_PROBE_MEM)
+		buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, insn->dst_reg, 0, 1);
+	buf[cnt++] = BPF_ALU32_IMM(BPF_SUB, insn->dst_reg, (s32)base);
+	return cnt;
+}
+
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
@@ -1026,6 +1057,21 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
 			env->prog->aux->num_exentries++;
 			continue;
+		} else if (insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW) &&
+			   insn->imm == BPF_LOAD_ACQ &&
+			   env->insn_aux_data[i + delta].arena_member) {
+			/* an acquire load of an __arena member is rewritten like a plain load */
+			cnt = arena_member_fixup(env, i + delta, insn, insn_buf);
+			if (cnt < 0)
+				return cnt;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
 		} else if (insn->code == (BPF_JMP | BPF_EXIT) &&
 			   epilogue_cnt &&
 			   i + delta < subprogs[1].start) {
@@ -1117,11 +1163,23 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 					insn->code = BPF_LDX | BPF_PROBE_MEMSX |
 						     BPF_SIZE(insn->code);
 				env->prog->aux->num_exentries++;
-				continue;
-			}
-			if (verifier_bug_if(bpf_may_fault_on_deref(ptr_type), env,
-					    "access to a fault prone pointer is not rewritten as a probed one"))
+			} else if (verifier_bug_if(bpf_may_fault_on_deref(ptr_type), env,
+						   "access to a fault prone pointer is not rewritten as a probed one")) {
 				return -EFAULT;
+			}
+
+			cnt = arena_member_fixup(env, i + delta, insn, insn_buf);
+			if (cnt < 0)
+				return cnt;
+			if (!cnt)
+				continue;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
 			continue;
 		}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1679ffec431b..015dc1bccebe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6585,6 +6585,45 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 					  "__safe_trusted_or_null");
 }
 
+/*
+ * The member holds the kernel address of arena memory, which the rewritten
+ * load turns into an arena pointer, see arena_member_fixup(). NULL needs no
+ * tracking, PTR_TO_ARENA covers it.
+ */
+static int check_arena_member_load(struct bpf_verifier_env *env, struct bpf_reg_state *regs,
+				   int value_regno, enum bpf_type_flag flag, const char *tname,
+				   const char *field_name)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
+	struct bpf_insn *insn;
+
+	/* a helper reading the member as bytes needs no rewrite */
+	if (value_regno < 0)
+		return 0;
+	if (!env->prog->aux->arena) {
+		verbose(env,
+			"arena pointer member %s of struct %s requires a program with an associated arena\n",
+			field_name, tname);
+		return -EINVAL;
+	}
+	/* only a plain load or an acquire load is rewritten */
+	insn = &env->prog->insnsi[env->insn_idx];
+	if (BPF_CLASS(insn->code) != BPF_LDX &&
+	    !(insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW) && insn->imm == BPF_LOAD_ACQ)) {
+		verbose(env,
+			"arena pointer member %s of struct %s can only be read with a plain or an acquire load\n",
+			field_name, tname);
+		return -EACCES;
+	}
+
+	aux->arena_member = true;
+	if (flag & PTR_MAYBE_NULL)
+		aux->arena_member_nullable = true;
+	mark_reg_unknown(env, regs, value_regno);
+	regs[value_regno].type = PTR_TO_ARENA;
+	return 0;
+}
+
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs, struct bpf_reg_state *reg,
 				   argno_t argno, int off, int size,
@@ -6694,6 +6733,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret < 0)
 		return ret;
 
+	if (ret == PTR_TO_ARENA)
+		return check_arena_member_load(env, regs, value_regno, flag, tname, field_name);
+
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
@@ -7475,6 +7517,17 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	err = check_mem_access(env, env->insn_idx, src_reg, argno_from_reg(insn->src_reg),
 			       insn->off, BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
 			       strict_alignment_once, is_ldsx);
+	/*
+	 * Paths through a kernel struct pointer and through other pointers
+	 * may share the insn, see save_aux_ptr_type(). Record a load that did
+	 * not produce an arena pointer from an __arena member, the only load
+	 * through a kernel struct pointer that does, next to the one
+	 * check_arena_member_load() records, so that arena_member_fixup() can
+	 * tell when the paths disagree.
+	 */
+	if (!err && !(base_type(src_reg_type) == PTR_TO_BTF_ID &&
+		      regs[insn->dst_reg].type == PTR_TO_ARENA))
+		env->insn_aux_data[env->insn_idx].non_arena_load = true;
 	err = err ?: save_aux_ptr_type(env, src_reg_type,
 				       allow_trust_mismatch);
 	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
-- 
2.53.0-Meta

