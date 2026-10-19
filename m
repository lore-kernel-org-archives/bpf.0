Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972DF4483B7
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380275; cv=none; b=mtSRSPnMXowl1ybW4x9rINjKpIw7+CW2EEB3+q7IeCBLwpojeyLqOgXJGPBfDFxS5m+y4GUrIRkv5rlmg0vpDWAbbQDHGQfbKxgQYWF8fWxPbSTkK5Sq+r+ewIuSMAzYwmrGqcXcUPjwf5OAIywhdWRY97eCqqdKzJQ4+LOZFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380275; c=relaxed/simple;
	bh=9qy2WBk+yRlHHELXHOCgK+ve7aTih/oxUJWY3JDoN90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLebXzSmIbFlG758ljPsm2L79CxsWEltmV08TIRimk+aOOhQcY8BaWOEvUO61mFyofNa2GEj/iSCan5Bkn5luUAWmGxZTEJAy1mEwHQvVi5ofIfXorMkHhRX2hL9wlj82XhmV0t9UJX9eyb+7Wem0E9bPgxUvf8s+094ca3vBBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTZSR1cc; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTZSR1cc"
Received: by mail-oo2-f5.google.com with SMTP id 006d021491bc7-7033e26cb19so942208eaf.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380272; x=1792985072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2206A9Kk8E1YjcwZHBKPgUQKdM1dlDAoajIUR3g7vhw=;
        b=OTZSR1cc/1Hab5nlVo0/lIN5rkFgXYruhxP+ara/Nn6f3l+1pxQ5Ef+2U2po2LJJQd
         LIkkW/HSOrWARDdH/QCN2CyiASRZ0/NF51gPf8zYAMFlenf52J0fvM/NQxXSGByS9xf4
         BZ1galj9vV4b3Wk0M9f4f8u6zcNTKnHHHqz6D7i25JS62TNKE5+fEVsQ7uzgAfU/TP3s
         +z9UJwjci9Kbt3Fn7RpQb30P3AsX5Y6cfs3dg+HQlpxvHAuCT5Gnx+LrJR4QuSvlwYvW
         V5ntF15FAyXGWNGy6GCh5FINsBHKYE6q2UGpgebXfMaIkdtYO1tJqlge5GvN5ERhsgFb
         JfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380272; x=1792985072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2206A9Kk8E1YjcwZHBKPgUQKdM1dlDAoajIUR3g7vhw=;
        b=q0XGp9pm08YJM/+FLS9MBBgxSKbXMnxqBdG9g/L3MEe5LUKKuTkeCKutNO37aJD5VC
         nFMydZninOpsooq7dvQet6Qio7iYgOd7ByPBReLVdBwelfqRlF3yrZe2woLAhbqefUSE
         mwKmWlVvuLVmi0pYrO8xD3brodu/7sM++JwlL5CzMJRlHE/oaojmZbPY80jnY0fxMBFT
         8yZVNx4cIAnN2nHE0IvdLSuFxXwOrOW1sxZvaIGYKooQaEKugPYWjDONDGCjUr5S5l9l
         kvHxi+E+gfsKnpzuRZoes2/RCh1n47EIcsUPHDzgYcAhnQ5Gedq+QwGdMr6MS3By0UmQ
         K93w==
X-Gm-Message-State: AFq9FYIhwpcxVOsWYLCFDK7bH4jiymc/lZFEkw28R/okXzo/C2xItDIj
	1Dbrhq0U8qtz46u3HMZi4ZoRnqE0UrpwNyH3i/lp/ypElk01EqDacD542o0LXmMJiD8=
X-Gm-Gg: AYBFou3dFLohPL9lGIA4xhqYgK174zoAGfttuFOGCInJf0WvSRYLTNeJz6du3/ysWr9
	TyX2v0Lkcs5JSdG0h/JXBYyLVkRFmXcKJdH9s3n4Jy3GRFC+XwL7ILYWzZYIF/xpiQ3aBtXr0T0
	fWEQXHR8QDpkxaLRENv7Ha0GC3gktkw5JbAiPxDExjWFd0NcTe+l6FMpRqgX3DX0DdZ3tC/gVae
	+BDDTsgFrx4RezHCFILuqXcCaE1aS7ZRluRFJ+boD2Btz8Bbc7Yj1w9z7+t/CxluBvOo7/OqN+r
	QRCXSSChXWUGVsnbfuzYkZO3XQHJ/iqNpoffNRoS3qEvWkFeBPOKj1T+X5krvqJsCC83/cK7/+w
	3FssRwVLcdJXEqmoCRzdBAiPgxxN9zNHZteDxA1A98QDn0DihXyRY7/WcKTAvEJV7SneGmDE0ab
	oC5j5u6S7BYITorRxIHPQtQHiGH1l/rTBEjXxFmnmtpCKCdBMV++xCWcVl+tzBzJ/hs4rw24EIr
	1GQeGOnI3uNbPgQ8lYgf3gHXKwmlzgFUekt9eIJOu+csk5IEJyMfjEwE8N6MpOmTwpsKuqUqLuC
	imLd
X-Received: by 2002:a05:6820:a50e:10b0:6dc:e1c3:b2ab with SMTP id 006d021491bc7-70357ca87ffmr2787115eaf.76.1792380272337;
        Sun, 18 Oct 2026 20:24:32 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018fd92933sm7316751eaf.9.2026.10.18.20.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 07/16] bpf: Turn loads of __arena pointer members into arena pointers
Date: Mon, 19 Oct 2026 05:23:47 +0200
Message-ID: <20261019032401.2302823-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11734; h=from:subject; bh=9qy2WBk+yRlHHELXHOCgK+ve7aTih/oxUJWY3JDoN90=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr+4MJxatMK89NcaFmnVih19rfTzpPXWbacrlNbM13G/1 PuPsKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwES++zL8FZpttZxXyu2zasVejQD9dO Pjvt8f7PzJfGObZrTFxZI5dxgZlj9W8VxxuuTtGU2TqQLnH/EtzHZ/aivwxKrXfO3ix2++cQIA
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
index 7a72bb06fe56..b0379e56c405 100644
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
index 713f14d73b06..c7f266760ca3 100644
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
@@ -1020,6 +1051,21 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
@@ -1111,11 +1157,23 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
index 5d5ef7e8509a..f4f77a3d319b 100644
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

