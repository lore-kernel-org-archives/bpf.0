Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6B32A3D7
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812249; cv=none; b=irfp9RF6actZ8jqVS7fx+nsVd+nmQUVVLj/usb5vIavVHvZRP4eYXfdAjM028L9QV9nhwF0pXIj7HJ8FhP11wfkrOUiOVqNCn5nbNk8YqhaNUUH0YOpYkymNbEkKJnjE56uniXXmkbkfB/rxlsO4wSSk5/vYfs33WCDMs8IMZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812249; c=relaxed/simple;
	bh=I0jkMOMquZY0M5vGY8G1HRzpJL2Yir5EazVFzf8krMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0Lmq+b5Udvb8sY0y0EkKi3vo3gkIdG2Cfro1wobNkx1jLWrjlPy0f7+G7/SQ+fTJZHGyRHmNa6MLVXAVr3kyi2gfPTk8R8wIaCB8M3G0D4JAWBzP908F9gO/fw1MOQUl1Fhqz9ZRQCduvNs+WTZxQvs+4GadFQZDT6CLcIXdpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rzkv4mKv; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rzkv4mKv"
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-8217177c5daso368321a34.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812247; x=1792417047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UwhCsphk0kqjirW11zH1Su+0cvHiQR3NOj/4/YWs2k=;
        b=Rzkv4mKvaS1/30C9D+faeSDAgIYomsRhwffhw4z8SsIKS/k1r52xkDi/m4lOTKCO85
         XWMLkR7JglKOPxY0+yttpd+s0dRxURQw0i1266jS05rzO8JP492QrsObMn1ZmwRym3DX
         OKmpSC/ABQPojdNIl52FKryk12wtUttC4fpX0nV+J1jeM17A2RvH927HAMjJ6QjR7b/R
         ojn/5Qp3vSarhyFf+uu35wRiKY4Xuu6Dw59sw4Q2P7HJbxlAPqcr/3qWA9EMf7RaDJ22
         hmLioOjVTjENMRkKOBMVFhAyCFxTY1iozdc66YruBDt7BcsajKjlkobrV7NcTVj4l4S7
         6Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812247; x=1792417047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2UwhCsphk0kqjirW11zH1Su+0cvHiQR3NOj/4/YWs2k=;
        b=jpylutHUoqGcY+XLHsottQyvY3ww+9vYFX98jwmdk1HloAnPvPIpGPTWxTBZ2Ap7WI
         4jA0/Ipn2tpi/a3Vm4e5HGPUcGGksrISldMFLPMSLwK2bc0mkhNxQX8NeIyeGZhGTNzm
         u7E1aa4MWVb2GDsJ3lIuAtXdEocVw7LV8AnroaiifYsZeKqsTudVi2rjX9okXawWhC7S
         VnxF8gYccxJugxGHM6UPKZaswXuuw07MNwv6QjeEiZVmCGIBjWY8oQGZVgEkgkfHCkWU
         dWCFyau2vtLTcwid+0XjNUhFRzzJJ6ln9Ls3NBNlys35CNT3YPKRTeOo8hLKwxT5B9KI
         fx2w==
X-Gm-Message-State: AFq9FYKK+1pq07FcEW7gcNZRd1PLFUkvpcnWZFZURUBUKjvaIsUvH0PM
	5Rw0P0IzvxG1eTolbScIvd/lPfOlZA8zLuq99RSQ0DE73bDgtk2XeOa154r26Je+d2k=
X-Gm-Gg: AYBFou1HKIyOdL0tk9RFSJ8LrhbPmTdTolm1fMGLV6+OUpeJIm3lmFY+tGns/Yb+lsF
	e0XGR96l5ONwzi8uL9+S7an6/yjVguAfc3J+fgsxC8peq2VOO3mgPcORjcFZLHSUd4J9tpH4lgF
	5KOiPdDZAgeFH8sKb0hhslwSyIrOJyZKJXfFyLaZNoHROjWT34a/KFfiUzjyt0HV5stvcH10Jac
	9DVpRpkecEDz3/cxAf2pgI4mpyY9VCwFB7dssiQKa/mFO4kaysjko6lui7xXesgp/gxtWA2UwA9
	PVAEmOYtNpR8eFRktAek05OiIr1xy49dnDgCSqEpN45VukIOL9yZttdFlPud8JlHn/dapMww4tX
	LDbdA6h0JCrJoNcIDxWKC5QqWHDdDq1jS8wegrpp8+LzoRML1l1e7XIUyfQyeWpuIKAHj7wIoBw
	91QKYuiZtb2sLCHswK7aWheBMKP7MiWvgKMQIwzEd3CKLW9j4bFt6D/dCeao1htfm77jOhntlYx
	u14bSeUzjPpUaIFCxQJ+YeJGFVzEBMV0CLdnpn0rDiB6pWNNvaj723odgsc4IsRPnWAZeoYNVpa
	pmxPLA==
X-Received: by 2002:a05:6808:1a1a:b0:4f8:65de:7293 with SMTP id 5614622812f47-50c4ed420bdmr9398766b6e.15.1791812246995;
        Mon, 12 Oct 2026 06:37:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c120686sm11513919b6e.16.2026.10.12.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 03/10] bpf: Turn loads of __arena pointer members into arena pointers
Date: Mon, 12 Oct 2026 15:37:00 +0200
Message-ID: <20261012133711.4030594-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012133711.4030594-1-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9409; h=from:subject; bh=I0jkMOMquZY0M5vGY8G1HRzpJL2Yir5EazVFzf8krMI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMwzU74zild8psNz2ZIFMn/UzwdsM5I3nubLWVy5Zr7quf d3ZvRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZS/oiRYVkvj2zs1iN5mq4iybuuem zTO3JvyU+VkDTeIg6rFc1rNjIyrFt8/bmHs4WDqYlZVdemLfUrkv8t8zxbtHjlsVjD/b/tWQA=
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
 kernel/bpf/verifier.c        | 41 +++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 54cb6d3d0653..fb949b58c231 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -791,6 +791,14 @@ struct bpf_insn_aux_data {
 	 */
 	u8 fastcall_spills_num:3;
 	u8 arg_prog:4;
+	/*
+	 * What a load through a kernel struct pointer found, on any path: an
+	 * __arena pointer member, which arena_member_fixup() rewrites, one
+	 * that is __nullable as well, or any other member.
+	 */
+	u8 arena_member:1;
+	u8 arena_member_nullable:1;
+	u8 non_arena_member:1;
 
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
index b2fa7e8bedf3..bbb653df6b6f 100644
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
+	if (aux->non_arena_member) {
+		verbose(env, "an insn loads an arena pointer member on one path and a different member on another\n");
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
index 70fd44a6e1c5..a24a2bab802b 100644
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
@@ -6661,6 +6697,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret < 0)
 		return ret;
 
+	if (ret == PTR_TO_ARENA)
+		return check_arena_member_load(env, regs, value_regno, flag, tname, field_name);
+	if (atype == BPF_READ && value_regno >= 0)
+		env->insn_aux_data[env->insn_idx].non_arena_member = true;
+
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
-- 
2.53.0-Meta

