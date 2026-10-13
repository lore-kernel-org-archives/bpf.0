Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223C3B2FC0
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879636; cv=none; b=cjLhBf9nHVX8AuXeEdDAw4yvcWznIvu5XiDSH3b9fsO5g2/BIZ7gPQ3ZfRSsOG5WXfI2yE3ZPeGn0ez6Ma6fgs2TuZ8sczsjCuUZm3b6vDq1lT54Nr7dP9d2zFp0pHPDQ4xVfS6ZUF8sK4qZD0B7d4kRiDLnWMcnxHxUtRGlLs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879636; c=relaxed/simple;
	bh=Y22eynbr3JIivgp5mTMIlikWhVqio86vpChf+hKKD+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P28va65uE0nfNCwz1whaNyO3Bbt98xTYswCgPJe3JSMfPVZOsqOSgYLTPh0QVuWhqR8tRzm8XRmyd6z39Ykpwm2T2hs9F5n2zf4o8DpBAulsBD56gBsaQz3d4iwFDHS0Ieu/udCXJylqh/ddICvAKXOX3+qTi7kzxGEr0ZDrRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeiZsMCC; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeiZsMCC"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4f3f1adebb0so950664b6e.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879634; x=1792484434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qsx2Z8wUsorYwQOmm80lGAsKgs9sFR6ufp64ImLw/to=;
        b=XeiZsMCCqMVIsm7GPSB6LEq/cy3CeEh7CjjzWc12h+ILiY7wZbn40vzIUdw5OcvJ41
         T9+sfL7bep51nQJ9AIwWNigcsSJbhvu7j4LNo2Jjm5tNxOT2K/WM9zkIvOvLuNgvv3sr
         lKVCJ4LXl3PSPnLhzKdE+vnT5D6SaQVf9Dimevkz0xjQkUk6IVe1sN+mtwymBgtfkWZf
         kVodz+ra/9vKQ0497IDZ22SoEAQrkr1Y12+EBmM9uZPqyOpWxneYKrLdV0qA74e0Atlq
         2if55KOgNdY4x7k28rFXkgeYXXDFPtehOceYN6zJCvcHr+VpyaUVUNvtva6/dHXQNfhf
         W5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879634; x=1792484434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qsx2Z8wUsorYwQOmm80lGAsKgs9sFR6ufp64ImLw/to=;
        b=PRhxY5vbhyauHP0pUPhFoDTbtHeDN//wgYN93VowaTllRhgMY/Pq0SDknJnmW8mMz7
         BpxwEcOMSt1mIQn0AMJv55tK9hXnpsjpG5BJrOWlHCe+1O7htQ3EeiPrnvIMxOcf29SJ
         cunA4b6eX0BOeDF9iZwEzjPpxKlFE7vkm1Cu+owQxcx2cV50tutuxNEv2iIpjraBzv67
         s1ndU/LvBPZoXptl1agIZUKBOM8iY7rnpMq0LVWp+c/qQiuXTXaa8DJTvsIUrmuGTfMv
         FT+fCYFtat9EPypKjDKfxdGmLNA5cpLlHMe6Kn9k/xU59QWc1124AMn+AYbTEJ9FaodN
         Ai7g==
X-Gm-Message-State: AFq9FYJj2LP2UcsN4toMJKo643MIAwIUjfBARk7hHArnDC038iJOGlHQ
	C5KTPB1zvB/IXGkqLW1SFU5jyxrK95CxFXomazAmVlS5BHBX/ImtB2+Gj8PRGaADH/A=
X-Gm-Gg: AYBFou0FGyXI54DSMsLBs2RPItHrHyOYiQYMAfGb4XBkltDzjbO95Qyc8qCDkS5i2WX
	F/nE5YcnF6Wt4TSQV6HgjFKQrFtnxJRlt6/hv15UgtsZTzV7XmZtclElmWtBH0tbJ5BATzJAuCv
	XTKx5MfzTVKiipo9onsihilb0lkXm7sHgW+k2FwirOhTiC5+bmcvhQrLihlSpCJE17v1FEIHdwG
	OcrJh0ViIaPzPpIsfM4s5dgz1Xi4Nx9U6t0cEWRSAUl8nm3LcFxmJt+t1z70Sg9428HAfVSEQVZ
	upodOAbHZd9qJFqwEeAhyyFZ/jBIPw0VBreqNSpwiPRr7vLKHzlxojBWngeIx5M0Wd14lCpDx0p
	4ONYtEbVIZwzFrmjBbJl9VzmCEfwkFCbSdvF61KYDrTYQcOceD6CzP2wf4VfjrEDBm0fwk6Mx53
	ubRI9HDr2LKHtbnG182K/qT3dwXVDiEPJK2+oCx6EsODm7dlZLyJojg4O5oefHQqAu/4PtFkPrQ
	x4Zw+haLl7TlmGluZOSfzx9OvLWFrjlr3aqsPzxmiMkUjh2uZpl2gHNM3XnnS2IhsJCt7epjtXR
	a80vPQ==
X-Received: by 2002:a05:6808:1a1b:b0:4d6:9293:9b54 with SMTP id 5614622812f47-50c5b17f974mr9928762b6e.60.1791879633632;
        Tue, 13 Oct 2026 01:20:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5283bc29ef6sm497598b6e.18.2026.10.13.01.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 05/13] bpf: Turn loads of __arena pointer members into arena pointers
Date: Tue, 13 Oct 2026 10:20:00 +0200
Message-ID: <20261013082012.1107446-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10349; h=from:subject; bh=Y22eynbr3JIivgp5mTMIlikWhVqio86vpChf+hKKD+o=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy3ndZss2ZexluScma3d56u2nDLGPpvjrLaz6K6tsvzB0 w/prHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIo5uMDN+FtXZtuZTCvlTwi5yx/7 W/7qsPp2UU18TtE9ggJG6++g4jw/Pkcz4tdezGOVaHTu47ZOAx52K/r9udNWK1YtzqRttFGAE=
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
  if r1 == 0 goto +1         // __arena __nullable members only
  w1 -= lo32(kern_vm_start)

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
 kernel/bpf/btf.c             | 30 ++++++++++++++++++++++
 kernel/bpf/fixups.c          | 50 +++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        | 50 ++++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 54cb6d3d0653..eb9300221c4a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -791,6 +791,14 @@ struct bpf_insn_aux_data {
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
index bcbd49c7ca0b..b992027b60b0 100644
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
@@ -8077,6 +8102,11 @@ int btf_struct_access(struct bpf_verifier_log *log,
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
index b2fa7e8bedf3..3c95b6c8bbbc 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -870,6 +870,36 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
  *     struct __sk_buff    -> struct sk_buff
  *     struct bpf_sock_ops -> struct sock
  */
+/*
+ * A load through an __arena pointer member of a kernel struct reads the kernel
+ * address of arena memory. Append the conversion to the arena pointer form,
+ * (u32)(kaddr - kern_vm_start), that the struct_ops trampoline applies to
+ * __arena arguments. A __nullable member keeps NULL as NULL, tested on the
+ * full kernel address. Returns the number of insns in @buf, 0 when the insn
+ * loads no such member, or an error when it does so on some paths only.
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
+	if (aux->arena_member_nullable)
+		buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, insn->dst_reg, 0, 1);
+	buf[cnt++] = BPF_ALU32_IMM(BPF_SUB, insn->dst_reg, (s32)base);
+	return cnt;
+}
+
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
@@ -1093,11 +1123,23 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
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
index a9c47441fba9..d9ba42b50d89 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6552,6 +6552,42 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
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
@@ -6661,6 +6697,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret < 0)
 		return ret;
 
+	if (ret == PTR_TO_ARENA)
+		return check_arena_member_load(env, regs, value_regno, flag, tname, field_name);
+
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
@@ -7439,6 +7478,17 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

