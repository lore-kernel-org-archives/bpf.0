Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731E509EFB
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107717; cv=none; b=hUad72IASCSZoBFX5VIGZ0RYrYM+313q2vZtAbnPgUr6OjfB5iktN7fnqTs0TuOP+6gOtTELPrbLBT0iPyZf5vyeNVQIKqjkx7BFGDRNc7Nxzo0FczT9kRclEPGt7kmFjJ3QlM/PKDhuDGtHFlhDiWBHOnIv+bQoAqfPZP3VLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107717; c=relaxed/simple;
	bh=C76DSz0kyLViuhN3zhLUgUhWf6198NbRXmomIz+3yYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnlRCOtRbWQfYPxeGd4bOuCS92Wqsj97NjJsbPPUOnRcC6Hc74GOmVgsACXxagNmuZTjTyXnDf/WTYOVpGR0DKaumOqtSUNPQRmOYPLQQijbTsmFAdHudLpTecafZ3QVxn7m9LOWjCWPplGTZNVEoyAHzIHdsiyThbpHBlCct+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd99SaXF; arc=none smtp.client-ip=74.125.231.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd99SaXF"
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-47bb3ddaaf6so2667637fac.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107714; x=1792712514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1vM0bJkC5QSknrzOghn7pYec2lg8rcy6db6rk8aeirc=;
        b=Vd99SaXFEoaL5JHghOZimrjqPwmA26lOrI8HKexY1A+y3dFPqZ0JibRZ97sRhhRw1O
         f4wVnyXLPZ3oCw2N3rnP3DY4VS2PnUrGtaf4MnmJlr0xeeT+Wtf/efuLgnisS4OIsq5Y
         316UIzzbsYkXR+lwJIM/oHd1bPyihLdnGL2JZCJLeDykxsFSoT7pPzRvv6kjATcZ6ON9
         nK7qP3sN6Wb0HuM51iY6gfBEUwiRttUSzO3EX5g3dY1eedaVre99oeCyK0lchQO2CdKg
         aYXf6nPqJZOT0L4E0jFsHDGy7/XIdaY0MW1ssNpCZta69jkL+7AJcNrvDtEnZsLnHVI/
         JehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107714; x=1792712514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1vM0bJkC5QSknrzOghn7pYec2lg8rcy6db6rk8aeirc=;
        b=e/CkzD5bgkTGjr7nOqlzbUEBPZZLBjDgfyRG5xWp2QP1gUTAHEdzVdoX7BorrqGpBH
         E7woqQJkl/0reJ/w9I6B9xbRo2fEGhRT5xeBeHwQbm5gXyBxGiRtD1IXikbwXhmq+IHL
         Tck6P6zMxDxWNkMfRAiOHKhGu3V8P2JPCypsIMScwriMsVuzUfFUJDufjBYDL19EP/Ef
         RyJOkq5GisvETHYFpf5HVnycBSsoi2BE/hYXSJV2Bio5xXwlXI9ZZj9EdBKGpjM49TS+
         uCCtSwta8UCBz2zZb0/SLF1MBSMjKKBqCpFaefcn7ZiCpm5jZY4mo9h9yRlxsnre3rlj
         9xMw==
X-Gm-Message-State: AFq9FYLynDwJ5YFSaL5xA2BoFAGboRCWFuf5ahrCSC/ZEGpZq3XpypMa
	dsUYFTs5cV6tW6IsWdWV0McPQGI9NmjNWYtHsVzvM1SNsGiwj3ig7lmIXBlx9IRo85U=
X-Gm-Gg: AYBFou32JT/VyNWIxh8E+dOfhBSTn3UW2BYnEk7uHBxSKcSdR2a5IWbnE6GvHvwFLdD
	94k3tUm2SewqxfSCItUfgxS7QdEG+iG+qsvpBtR0C791yfT4F/mWEsibrlcad41sR2S32LP3w/Q
	Bxa/lnABcNaLe5oFgClBzNZpsqXMbDGm9ZjlCk/LLsEmtycRlQee1cl93VQf1RsdXFmOT+LAzSm
	xWgyE0ayi9DcoUBAFnNC5eaAsg1BucPxG1CCgPS4Ly+bid93/fop0MccuZh7D7LRxk6j4oy+iA5
	ocA4NBDNoZlMBHyIS6GwWGwSjIEfLaws0XT0Is/zgcvyM5MZeB9QJfLSy57bfGSxjXboop912JJ
	mcUM+rlnjcJjDtxK+x1YbHaFHuUWWN7DFo5nczI5MrJIbXuPNwMEJjNhWAd+9/wPIGb+DAJBOAQ
	IKE827z6BsegpAfMCZkeswI/nhpmWuu08xRRvkWc692G16850XWAllr9VlkNzm4BUP4KcCOdvSZ
	VOrKiKFCp+vdlj94iZXi8x7T8+xVckmWQ2zX2MrqZRorpGDM4Tym8xD5H8DOHkKXQx4VXQn8HAd
	ZU9a8g==
X-Received: by 2002:a05:6820:f00a:b0:6dc:83de:fcac with SMTP id 006d021491bc7-6ef0fdb10c1mr17265421eaf.40.1792107714053;
        Thu, 15 Oct 2026 16:41:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a6358dfdsm415199a34.20.2026.10.15.16.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:41:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 07/15] bpf: Turn loads of __arena pointer members into arena pointers
Date: Fri, 16 Oct 2026 01:41:13 +0200
Message-ID: <20261015234125.3152346-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10669; h=from:subject; bh=C76DSz0kyLViuhN3zhLUgUhWf6198NbRXmomIz+3yYw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3OsdJnuWNh7es0LrwJuKA7MYp/mLKJ2/3F948oN1k8Pe GU+ndJSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAiHi8Z/jtU66X2T3fh2bJznVFS0K KoOwcu89adF0lfo3TLY9b1lPcM/+MqpVf3iB5NbDi/ZN5X+7kVNz4V8oiFS133LnB6a/pkGx8A
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
applies to __arena arguments:

  r1 = *(u64 *)(r2 + off)
  if r1 == 0 goto +1         // __nullable members and probed loads
  w1 -= lo32(kern_vm_start)

A probed load, through a plain or an untrusted pointer, keeps the NULL
test as well: it reads as 0 when it faults, and the subtraction must
not turn that into an arena pointer.

Stores to kernel structs are rejected as before, and so are atomic
loads of such a member, which the fixup pass does not rewrite. A member
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
 include/linux/bpf_verifier.h |  8 ++++++
 kernel/bpf/btf.c             | 30 +++++++++++++++++++++
 kernel/bpf/fixups.c          | 51 +++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        | 50 +++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 791398e14962..af59166a3b27 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -788,6 +788,14 @@ struct bpf_insn_aux_data {
 	 */
 	u8 fastcall_spills_num:3;
 	u8 arg_prog:4;
+	/*
+	 * What a load found, on any path: an __arena pointer member of a
+	 * kernel struct, which arena_member_fixup() rewrites, one that is
+	 * __nullable as well, or anything else through any pointer.
+	 */
+	u8 arena_member:1;
+	u8 arena_member_nullable:1;
+	u8 non_arena_load:1;
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3c01618694a4..0650b32aec08 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7695,6 +7695,7 @@ enum bpf_struct_walk_result {
 	WALK_SCALAR = 0,
 	WALK_PTR,
 	WALK_PTR_UNTRUSTED,
+	WALK_PTR_ARENA,
 	WALK_STRUCT,
 };
 
@@ -7975,6 +7976,30 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
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
@@ -8078,6 +8103,11 @@ int btf_struct_access(struct bpf_verifier_log *log,
 			*flag = MEM_RDONLY | PTR_UNTRUSTED | (tmp_flag & PTR_MAYBE_NULL);
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
index b2fa7e8bedf3..dcc4111343ca 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -870,6 +870,37 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
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
@@ -1093,11 +1124,23 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
index b4d9ad3ca966..7199674f6a46 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6554,6 +6554,42 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
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
+	/* only a plain load is rewritten */
+	if (BPF_CLASS(env->prog->insnsi[env->insn_idx].code) != BPF_LDX) {
+		verbose(env,
+			"arena pointer member %s of struct %s can only be read with a plain load\n",
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
@@ -6663,6 +6699,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret < 0)
 		return ret;
 
+	if (ret == PTR_TO_ARENA)
+		return check_arena_member_load(env, regs, value_regno, flag, tname, field_name);
+
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
@@ -7434,6 +7473,17 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

