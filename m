Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207866;
	b=ErMPceOojpKGVI3O5vpMZni8Z9CBPCCN/WrH+OF7CEHcT8kuffjh17EFRNn1c1HkHeiO
	 ft7QF5+fpoH39n8BJ3kl5LdIs55cDGA0cdS1UdnfF4bYbIx2XjXsI73nxC42Qsypb5kOg
	 rXTUUCDmwIdJE8blI6V1hEF0sbHTkq1DnEIKj8nyPH2p8C/94o6e57LS+sAP4lFrbOLWG
	 FLsegZ8zgeBYxLRP5twXR+D9AiLBGIcYAibo1xQyvT7sDgX26Lv6BmVNP9p0BYy+hJq8j
	 dd7m0F/OGPQt5DrfzBAmIjoAbrO5ksnW1QD/gz1Q5w9OuXPQKPIa4L/igLcTkNNDghQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gwHOA6dYifOAFVPV2KNBKQQYqG2UuVE+PnaQ7VaCQRE=;
	b=pM8HbT5sMCc3Vx+fdELWdY8FA2twgrCzqxaB1CQM30h4Y9CwGa39cVmtvT8r+QhIvycG
	 7Gg5CGBoSti0Mf/GQUFgHHb9xFL/1m1iUrDT6kVHh8RXGrxB7SNts7MTDyDc86fW86HpL
	 V4OyxVNdR9yt+TV+7A9UxdEOBSLhzFOz6PKVMeUaZizl2gvsyQBuDc6dvYwb2UhXGTM12
	 7freVdY7tIOE/1XJ/abfTyzSkhmda4gLtRxikGupLlQdL8k5JlsjhDoIbVR+9NB1a6aGM
	 KUGy2sZalhtyfXsUYX6nUZvlF86NomswOH8dTkzv9J77Jw9G83/k8VTlOK670pUxA/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eY53lg0+;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8B606A686
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7A8B606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eY53lg0+
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so658709a12.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207863; x=1795812663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gwHOA6dYifOAFVPV2KNBKQQYqG2UuVE+PnaQ7VaCQRE=;
        b=eY53lg0+OD4RNR/J0pBdMhN3vcLnLVzdRkoSJYOWojGOA3GZzonQGuXRwJeWei82Ma
         WTj3WmBLnLITTYYNP7Uvu7IOJLvNidYwBMbs0NfiB5ZbcCP9JTqDjM2jV0Al2jXs/uHV
         gjVqbU5SSrjXPOXCpC1L6NrFLYpUZQUUAXjrjCstL5JZFjPbK2VA4FPNQ1zKocl9iTkW
         HstNR/9ju0ZkafM+51gt42DR8WU0D6Z3KGGLitBZ5bBbCVyTUqTbNLqTFeC71LTJodjQ
         cZleIXYHleYQrsHgWSDV/E1AlJ6Ok5943ubatLcgJmNCn587qRW5dMTjcGgeHBQOVbU0
         ncdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207863; x=1795812663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gwHOA6dYifOAFVPV2KNBKQQYqG2UuVE+PnaQ7VaCQRE=;
        b=BRN0y0la5Ft7WsLwQ7caVFeTYre3AXBddpaAmHNNI/4Imt4oQXnXfBFUcaLEL8cJR+
         YcbwBzoC3D6pr2kdnY6T2wyGBlgaXPOKOAoyqlFG/7pe/FKgCeSIEaD62iz1Xc0x6Ork
         mMvR2zkSQ7npBgHke7Z8vfLNDUzD9CnxUY7GFyHrlV9fc+4R8Hw0SXItvwe006dYWC2C
         Ji1N6/aBJh2BvBXQ7l8mLkvcY5LRTvIEQbJt7/nasKH5oOEUW4gh+zsg+9TtS+bbThHL
         Iq1+Y0S8crPu1oi0bhUWGajnWqS5DebT+P6lEnkL5xN6uEw0lixRurbGh2RRu9QtSGv4
         atag==
X-Gm-Message-State: APuU4Z+PulEM9n1SojCeC4BPwZGOSWCUoPRh+z75agfIU5jL+ze+sbyw
	/MEK65abKUAafkjy5dPYh3Gw0foEIrwl8jPdpp7h30AMjkg9gmRwb5C+8+XkJA==
X-Gm-Gg: AZFdTZcv1uMc/0hcJLrExalwVKWU1ETTATfH1XE7mza0kxySkspbmf0SUQHxvWDmHTt
	o6gRZVIrSUx63dOL6+QuVMsj07lNBbDn/9HZbpSWVky2HhBZD6kxmnOE+zy32dAqz0+cux9TDu7
	wfI1KrvV/EGnZ9TyY9DFchwzAC+UwoaMzlqwcvWsbZdKohaasm/djHMrMyncfyuuneOMs/ClNkv
	1L8xWoPcvh5AlPfg3SuK5maTY8xZi6bUELAlR9AaB0Yf5cgiY/T4gAAlwPsol8pVMUExzC+BTwX
	mtbFLIWw80TOAovZToFErHANAkAZCmOvWOJDxnlDtr/bKXJXe+vTLulDg2rmblZUN87zTDONNFu
	Liuef8egXOxyo8Hs9H/76pPTYiow81II38yUDeWwHMHv3fhPX/C8LQNjuX9KhgKro7clzx7Ki4k
	t8LGaDrIHAvmuBsWQvObAJy6U5Cu943hEyAy5mkMctANtrTjRH/VyY2zpcqrrcyGreM2QvkfubH
	+IY4WILRLy9HzktET4OBCfUsHNAOJ/7Q7kEPhAPxHFnQ660ay8PFqlzXOXxDrZpR+nfGzvJNjLr
	9ERK88bqz/GRiWUtpdl1r6zaeEmfSDzIgBprdBzNFxba35AU3vY92lOFWHel1ezAeWiMXTwAaB1
	n2/ml8+HUp6u2/xvyf3wY9qLDOuoxTBk0QWjcdAes6FNXuNAm6VvZzByoZv0uAOjWscspOJ0Q0g
	==
X-Received: by 2002:a17:90b:1802:b0:3b0:c11a:9026 with SMTP id 98e67ed59e1d1-3b41c95fa0cmr4162099a91.55.1795207862823;
        Fri, 20 Nov 2026 12:51:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm5554624a91.6.2026.11.20.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:02 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 10/49] bpf: Reject a program with a call that needs two rewrites
Date: Fri, 20 Nov 2026 20:49:18 +0000
Message-ID: <20261120204959.614908-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

Some calls are rewritten with a number and with the special fields of
a type: bpf_obj_new(), bpf_obj_drop(), bpf_refcount_acquire(), list
push, rbtree add, per_cpu_ptr(). One state sets them for all states.
That is wrong if another state has another type:

  if (...) p = a; else p = b;     a has a kptr, b has none
  bpf_obj_drop(p);                one btf_struct_meta for both

With the fields of b, the drop of a leaks the kptr. With the fields of
a, the drop of b frees a kptr that is not there.

record_call_fixup() notes the number and the fields of the first state.
It fails if another state has other ones. Two types with equal fields
can share a call, see btf_record_equal(). bpf_refcount_acquire() reads
only the offset of the refcount, so only that has to be equal.

This rejects programs that load today. A compiler can make one call of
two calls in the source. The fix is __attribute__((nomerge)) on the
declaration of the function. A static function can get two types from
its callers. The fix is to inline it. The log says so.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  5 ++-
 kernel/bpf/verifier.c        | 73 ++++++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f7c36629e1f..eb05063c6d8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -840,6 +840,9 @@ struct bpf_insn_aux_data {
 		u64 obj_new_size;
 		/* remember the offset of node field within type to rewrite */
 		u64 insert_off;
+		/* {this,per}_cpu_ptr() with prog percpu alloc */
+		u64 call_with_percpu_alloc_ptr;
+		u64 call_num;	/* any of these, or the offset of a refcount */
 	};
 	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
@@ -851,10 +854,10 @@ struct bpf_insn_aux_data {
 	u64 needs_zext:1; /* alu op needs to clear upper bits */
 	u64 prevent_zext:1; /* alu op cannot be zext (already used with 64-bit scalars) */
 	u64 non_sleepable:1; /* helper/kfunc may be called from non-sleepable context */
-	u64 call_with_percpu_alloc_ptr:1; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	u64 cast_arena:1; /* addr_space_cast of an address in arena */
 	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
 	u64 loop_guard:1; /* may_goto is added in front of this instruction */
+	u64 call_recorded:1; /* see record_call_fixup() */
 	u64 guard_edge_dropped:1; /* an edge of may_goto from here was dropped */
 	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 36492294485..80b4a2a3e93 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12421,6 +12421,36 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
 	return reg_bounds_sanity_check(env, ret_reg, "retval");
 }
 
+/*
+ * The call is rewritten with @num and @meta. One call has one rewrite:
+ *
+ *   if (...) p = type1; else p = type2;
+ *   bpf_obj_drop(p);                      <- the check fails if the special fields differ
+ */
+static int record_call_fixup(struct bpf_verifier_env *env, u64 num, struct btf_struct_meta *meta)
+{
+	struct bpf_insn_aux_data *aux = cur_aux(env);
+	struct btf_struct_meta *first = aux->kptr_struct_meta;
+
+	if (!aux->call_recorded) {
+		aux->call_recorded = true;
+		aux->call_num = num;
+		aux->kptr_struct_meta = meta;
+		return 0;
+	}
+	if (aux->call_num == num &&
+	    btf_record_equal(first ? first->record : NULL, meta ? meta->record : NULL))
+		return 0;
+	bpf_diag_program_structure(
+		env, env->insn_idx, "one call for two types",
+		"Use one call for each type. "
+		"If the call is in a static function, inline that function. "
+		"If a compiler merged two calls, mark the callee with __attribute__((nomerge)).",
+		"This call gets objects with different sizes, special fields or offsets, "
+		"or two kinds of percpu pointers.");
+	return fixups_differ(env, "same call cannot be used with different types");
+}
+
 static int
 record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		int func_id, int insn_idx)
@@ -12992,8 +13022,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				return -EFAULT;
 			}
 			returns_cpu_specific_alloc_ptr = true;
-			env->insn_aux_data[insn_idx].call_with_percpu_alloc_ptr = true;
 		}
+		err = record_call_fixup(env, returns_cpu_specific_alloc_ptr, NULL);
 		break;
 	}
 	case BPF_FUNC_user_ringbuf_drain:
@@ -15372,9 +15402,10 @@ bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_i
  * < 0 - not fall-through to 'else' branch, return error
  */
 static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
-			       struct bpf_reg_state *regs, struct bpf_insn_aux_data *insn_aux,
-			       const struct btf_type *ptr_type, struct btf *desc_btf)
+			       struct bpf_reg_state *regs, const struct btf_type *ptr_type,
+			       struct btf *desc_btf)
 {
+	struct btf_struct_meta *struct_meta;
 	const struct btf_type *ret_t;
 	int err = 0;
 
@@ -15382,7 +15413,6 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 		return 0;
 
 	if (is_bpf_obj_new_kfunc(meta->func_id) || is_bpf_percpu_obj_new_kfunc(meta->func_id)) {
-		struct btf_struct_meta *struct_meta;
 		struct btf *ret_btf;
 		u32 ret_btf_id;
 
@@ -15458,17 +15488,21 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 		if (is_bpf_percpu_obj_new_kfunc(meta->func_id))
 			regs[BPF_REG_0].type |= MEM_PERCPU;
 
-		insn_aux->obj_new_size = ret_t->size;
-		insn_aux->kptr_struct_meta = struct_meta;
+		err = record_call_fixup(env, ret_t->size, struct_meta);
+		if (err)
+			return err;
 	} else if (is_bpf_refcount_acquire_kfunc(meta->func_id)) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
 		regs[BPF_REG_0].btf = meta->arg_btf;
 		regs[BPF_REG_0].btf_id = meta->arg_btf_id;
 
-		insn_aux->kptr_struct_meta =
-			btf_find_struct_meta(meta->arg_btf,
-					     meta->arg_btf_id);
+		/* The call reads only the offset of the refcount. The other fields can differ. */
+		struct_meta = btf_find_struct_meta(meta->arg_btf, meta->arg_btf_id);
+		err = record_call_fixup(env, struct_meta->record->refcount_off,
+					cur_aux(env)->kptr_struct_meta ?: struct_meta);
+		if (err)
+			return err;
 	} else if (is_list_node_type(ptr_type)) {
 		struct btf_field *field = meta->arg_list_head.field;
 
@@ -15555,6 +15589,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const struct btf_type *t, *ptr_type;
 	struct bpf_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
+	struct btf_struct_meta *struct_meta;
 	const char *operation;
 	int err, insn_idx = *insn_idx_p;
 	u32 i, proto_slots, ptr_type_id, ret_nregs = 1;
@@ -15672,8 +15707,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	     /* is_tracing_prog_type() for now doesn't cover non-iterator tracing progs. */
 	     (prog_type == BPF_PROG_TYPE_TRACING && env->prog->expected_attach_type != BPF_TRACE_ITER
 	      && !env->prog->sleepable))) {
-		struct btf_struct_meta *struct_meta;
-
 		struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
 		if (struct_meta && btf_record_has_nmi_unsafe_fields(struct_meta->record)) {
 			verbose(env, "%s cannot be used in tracing programs on types with NMI unsafe fields\n",
@@ -15789,10 +15822,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	if (is_bpf_list_push_kfunc(meta.func_id) || is_bpf_rbtree_add_kfunc(meta.func_id)) {
-		id = regs[BPF_REG_2].id;
-		insn_aux->insert_off = regs[BPF_REG_2].var_off.value;
-		insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
-		ref_convert_owning_non_owning(env, id);
+		ref_convert_owning_non_owning(env, regs[BPF_REG_2].id);
+		struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
+		err = record_call_fixup(env, regs[BPF_REG_2].var_off.value, struct_meta);
+		if (err)
+			return err;
 	}
 
 	if ((is_kfunc_call(&meta, special_kfunc_list[KF_bpf_dynptr_slice]) ||
@@ -15911,7 +15945,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		ret_nregs = mark_kfunc_ret_regs(env, regs, t->size);
 	} else if (btf_type_is_ptr(t)) {
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
-		err = check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc_btf);
+		err = check_special_kfunc(env, &meta, regs, ptr_type, desc_btf);
 		if (err) {
 			if (err < 0)
 				return err;
@@ -16016,9 +16050,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (meta.btf == btf_vmlinux) {
 			if (is_bpf_obj_drop_kfunc(meta.func_id) ||
 			    is_bpf_percpu_obj_drop_kfunc(meta.func_id)) {
-				insn_aux->kptr_struct_meta =
-					btf_find_struct_meta(meta.arg_btf,
-							     meta.arg_btf_id);
+				struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
+				err = record_call_fixup(env, 0, struct_meta);
+				if (err)
+					return err;
 			}
 		}
 	}
-- 
2.55.0

