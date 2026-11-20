Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160734;
	b=f2+sD/uAA6EvvFwq17YSq3vKp372jTnTQ0WsUej5enY0Gx00OaOqlo592YW7r53G+eCg
	 nX17lwhhG0geyAt5KGcxjPFoEv7dOMsgrCxH2RgmbzlhlztQpDdbXTSnIUb+Vj1d2DZCM
	 VKd2VV85vgVLDZMZyfz7UuouyuouCbxFWvbb5f2/jAkvRJop1x3zMBpjLoD5lDa/t6/XO
	 IUpqa5SgijP33eOmnuYbLX2yxSbaWfmfmlIVlqDrH6PJ28obJvvVwZCfE9Mc0VrMcjJYt
	 YNaTyqKhQI46jqAnNN5+tK2J+Xt/pI++SmUGGUne6SNOefQ/bp4OLCFm8lwwRgucAHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y6qaPOIp+L5f63Rxa7piu7dujGNKPdpveFlfq/b6VmM=;
	b=B9DnCGtKb2j8Mi+6Djr5sLvezIWMS5hXSDYd1WwCo8TcjyfpAyfN0uYVrjJQk5PqVoOT
	 aVLhXjfYlwD8YqY5VqbeKKC17JdesbdtM/fJLV4yahsF0pspIyc7SrhV/g6CrBWfxeR9n
	 Su41A4qBqygayc5lWaGWA+UPLFKiDYA4nsjRylsTwFpH1Pd8Z43u/v2uqgHFXFc05I2t6
	 t2hRP3TWcCGyLLmstmUpvhKzkXvhyshP5E7GcC8Nzwp4tH06Ut6xTM892bkpRl08SzlW9
	 C+fjX/7Fp0BKBBUsd3YKBG27pnXtD53bP+QrXI3J+JyqH/GtYCtRZh4kiaK+LQAZobQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rvll4PO/";
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB292606A32A
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB292606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rvll4PO/
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so616075a91.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160733; x=1795765533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y6qaPOIp+L5f63Rxa7piu7dujGNKPdpveFlfq/b6VmM=;
        b=rvll4PO/Cf++f3NrzKQ/xzxoOJ/ddNmmJrBaZIrVpu7tWJ3APaMn9JjqD1I7zy2cgk
         aGQXLTjRNvpL4buSJ+NFoQj7CpnI9gaLAAQ5+2xwECFZDYbQt0dwvwjuCG4rFcqA9qWu
         XjLpL7kMnuLwexnd0EX78GlIQK+AlVYjpqAVgGD7O5xh0dAZSM8bq+enitmjxbXkRJLu
         bicaIAPL8xwSU0c48QjUJ13JGUNmmNx06HEhmkpwhbIIxZBLqrBgrSKqfyipt+plFkVo
         HLcMlEnX2PHqMhWgcEJd6MZrwCZvF5W7XIayBO8vdjm6xAaiWMyGSlE3VHcfDzyq4znT
         vSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160733; x=1795765533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y6qaPOIp+L5f63Rxa7piu7dujGNKPdpveFlfq/b6VmM=;
        b=ez4rsanpezDtCIYMIVSmwKhGOrHxJA4dU+00EpI5axqpb7my53+dy6fT6AslVZB4fA
         +ULVX49nYcTW9ZTCwZzn2TYQ+c8h1y2mKpxlo1ID5xrbfkN7/7t3/hpsGPWdnZ7X82fP
         rRiCrJYk8Git1KhHJ3JyvL/fbpon8avVNiTM84ENH2xTdaLowTZS0DdASrr9a4Ml57bu
         tSC9BizI0dv6Xv86IQ9HYpUQERfo8++jKEpzWktKTU4usoO5zmt9/ee09wrcZZ+GFg9q
         EMFOUyqkRn2B9vyo+91V2PQOeYsFXcEDCiNoMofU7c0KG2jP65izTs/PXqxLU5rx/PX1
         xUcA==
X-Gm-Message-State: APuU4Z+ZoGLC00y5w9eOg0w5fWZbBK+EqrVDT1pBh1EohSxBZWBNylRr
	jKpvw5mLe9aGkO4/UNTuIocEOV4UAlR3cwGAWY5rXEYZeDXmeLnuSV0JlsX1ng==
X-Gm-Gg: AZFdTZeFGLsBCv43qagHC+DY20wH29t3usyj2E2qB/CX8dwmhpjIfT1lXsGVvyIfdIE
	jLhsI2LuTKN32SZppD7l4KFnmx/0MsPHcV4bq6uQu1xIO37ch+ahyc+vl4iwGMbQTzcamv33EgF
	p9IQFAGImwOERijSATcDNL7FdfY5mwpx2tcdhHYTNUIHPJK5mHeiTjMDe++VcB8WyvCZE7YFwLq
	Sxs07QiXtnKsZ4sENSCzClpMZbByZJNrA3+qugo2SxbIYl0LqFfmxoHGURPCeiCVmX5FJRS6OAH
	jZER24XW5DCFZQe7asoAdKf5R9TK113AOZuowsQ85bmbXcPnnsR2gpxPHangNdhwqL66maG6ESD
	1UpX/HK6RVvEzYVlCcuw5uCBCWjSXIpUSQIOTNmKL6dvKNyKx5Y/XynJWGJFODw9CcNFBhvwC/p
	NuHbUyOHSMXU7DxPe0LFMmbTgcYXR3wgT4g41qxBzAmkY3Fny9WqJUHg2dl/Bh/mOvIWC0ykBfY
	U2SrOphvvtTsdkVMLmfAVdkTD/U5RaE/bg/UY2ZzmJ4KVv3KC4HJlxNz8ohK5XSgUcZKSFI6mVI
	mJAlgZDdt2/R5qpzFmP3jRElXpCkzDzJtYFsqP/53Tj8Dyauu8kA/WZ/RYXRhfo0ERWrWIkzvYN
	Wi8rOZ4NRuxtiIMFQkeOG3SaTSLEPKkCjW/FSPF5Uk5GeJwiG1fShC89vNNFrBMWZce6UUnmg8v
	8=
X-Received: by 2002:a17:90b:2f8f:b0:3ac:9f24:44be with SMTP id 98e67ed59e1d1-3b41c92a3dbmr2069176a91.29.1795160732835;
        Thu, 19 Nov 2026 23:45:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm6323524a91.12.2026.11.19.23.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:45:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 10/49] bpf: Reject a program with a call that needs two rewrites
Date: Fri, 20 Nov 2026 07:41:42 +0000
Message-ID: <20261120074430.2704488-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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
index e40e4be6cf8..8d20ed2a5fd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -794,6 +794,9 @@ struct bpf_insn_aux_data {
 		u64 obj_new_size;
 		/* remember the offset of node field within type to rewrite */
 		u64 insert_off;
+		/* {this,per}_cpu_ptr() with prog percpu alloc */
+		u64 call_with_percpu_alloc_ptr;
+		u64 call_num;	/* any of these, or the offset of a refcount */
 	};
 	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
@@ -805,10 +808,10 @@ struct bpf_insn_aux_data {
 	u64 needs_zext:1; /* alu op needs to clear upper bits */
 	u64 prevent_zext:1; /* alu op cannot be zext (already used with 64-bit scalars) */
 	u64 non_sleepable:1; /* helper/kfunc may be called from non-sleepable context */
-	u64 call_with_percpu_alloc_ptr:1; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	u64 cast_arena:1; /* addr_space_cast of an address in arena */
 	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
 	u64 loop_guard:1; /* may_goto is added in front of this instruction */
+	u64 call_recorded:1; /* see record_call_fixup() */
 	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e43a3dd9a39..8de65e5a3a6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12409,6 +12409,36 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
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
@@ -12981,8 +13011,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				return -EFAULT;
 			}
 			returns_cpu_specific_alloc_ptr = true;
-			env->insn_aux_data[insn_idx].call_with_percpu_alloc_ptr = true;
 		}
+		err = record_call_fixup(env, returns_cpu_specific_alloc_ptr, NULL);
 		break;
 	}
 	case BPF_FUNC_user_ringbuf_drain:
@@ -15361,9 +15391,10 @@ bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_i
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
 
@@ -15371,7 +15402,6 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 		return 0;
 
 	if (is_bpf_obj_new_kfunc(meta->func_id) || is_bpf_percpu_obj_new_kfunc(meta->func_id)) {
-		struct btf_struct_meta *struct_meta;
 		struct btf *ret_btf;
 		u32 ret_btf_id;
 
@@ -15447,17 +15477,21 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
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
 
@@ -15544,6 +15578,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const struct btf_type *t, *ptr_type;
 	struct bpf_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
+	struct btf_struct_meta *struct_meta;
 	const char *operation;
 	int err, insn_idx = *insn_idx_p;
 	u32 i, proto_slots, ptr_type_id, ret_nregs = 1;
@@ -15661,8 +15696,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	     /* is_tracing_prog_type() for now doesn't cover non-iterator tracing progs. */
 	     (prog_type == BPF_PROG_TYPE_TRACING && env->prog->expected_attach_type != BPF_TRACE_ITER
 	      && !env->prog->sleepable))) {
-		struct btf_struct_meta *struct_meta;
-
 		struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
 		if (struct_meta && btf_record_has_nmi_unsafe_fields(struct_meta->record)) {
 			verbose(env, "%s cannot be used in tracing programs on types with NMI unsafe fields\n",
@@ -15778,10 +15811,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -15900,7 +15934,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		ret_nregs = mark_kfunc_ret_regs(env, regs, t->size);
 	} else if (btf_type_is_ptr(t)) {
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
-		err = check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc_btf);
+		err = check_special_kfunc(env, &meta, regs, ptr_type, desc_btf);
 		if (err) {
 			if (err < 0)
 				return err;
@@ -16005,9 +16039,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

