Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19943380FCF
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465716; cv=none; b=IsFdqKvwiwZCyj2+lbovPK/UHh7kG76MVG/bmJ4tnfKYY7ZYeQv+HLxOYSMRIyJWXdNdVh0J83lKLaMhJP/0d+rTlT8wEgd5gDD2Z+V3a9+hoBVnALbDQIWZ26lhE4U48pztvdThxYnI/tFjgFQUJGYEx1KgIYykLTPhRJBW7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465716; c=relaxed/simple;
	bh=uGm2v0Dw13LNEanVhYRN5p4BQkSAIXHct+tT0f0iWVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m44IKIa7qbcK9W5cbv4E7zk8sZzU72K7e8TKKhFu0iz8BrSctscZyjT1yLVQpmRNKEGtkYB62Zh+lmIJ72FCmrpntFpnJuLiUeCoMPDyfXnhAioCsmx1In6EWp8g/bEPwtttoCCxfTg16Wjxt1ZKY94L5eDt4ya9ll2pksm1AzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AomxRXkG; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AomxRXkG"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ffd5111f2so3330155e9.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465712; x=1791070512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fNfWWnR7VA4L2xY9bd2X7mPIjPIgJBkox8sNc1UTX/w=;
        b=AomxRXkG8xPZ7KQ2ARFziyx4ZdD9ewtMYLa67XUuLsewKqCwxrWC5XY9LmkNbXPDg7
         sIs9tdChwTS2XS3+X09EmdboGvUR7P4Ljow6sEq2KpOxSYiETIE8q4uPR3ZqdRPTCLDY
         t1IQb5gkex9M+XYH+KY+KypBcBCiPO43+s7M/CrmjZfnCAMKlFI6hhhgihhqND0YrxLO
         yQV9PD7rlS072gtKPAyE5Xyz0B/eXHQfgjhTXieG22CKh0zhPdaG4CC+olODIYmye0bc
         FuS1NKxg/D+gw8oG8kY+P0YoIxpFVZE9hlfeonzxk77zBpPIrS6idg3dOEfjEAS5hgL1
         iNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465712; x=1791070512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fNfWWnR7VA4L2xY9bd2X7mPIjPIgJBkox8sNc1UTX/w=;
        b=1XKXLnDekSJvvPb+4WBtEcCAIIQKgYfv8Fzoo9BuUUwxxgKkXpBx3+2ngsbwThqyxT
         nCbXkhMNh918fDRHH/9/RIFFWiTo36/3KvRuegA7y0o+NzKKMiefcVNuvlFx/R3KmHOx
         jJkJ/B4jwpTh+YEd3tmOxhNkx2ibI+C2j7qY1M+f5F4Up8gBOkpI0oJBtq7Q/tftpz90
         OnlQFxwbcDiMGyAII1Uigh/2muDma4ehyPZdrDXC3HLNQ018uQRwqfQvUiAG3Ye8ODqA
         E1lRifqd3bh2QHyRSVpwGIUSFYKK13cieevG0ifxp7SDuzdk51t9nBx03WHom8Jsk9yY
         HQow==
X-Gm-Message-State: AFuF++kpQP02KulBryXpJwQFiJWNnDTc1xkTR7viZphRlQg3gaL8Bb9x
	HXXzqHw8BmRLa9IuPFSwue84aSW1obZleNgSarFbDNNQUPVOU6fkgU+Uf2vvdck9
X-Gm-Gg: AYBFou0Ivlh2OpOTVRQ6q3XYdfDdpEPhfxjHwOBI84EpXyTely/29cY17hHvFJXKp8z
	0gKNQa4YnFf7wzYi1Yt1evAW5MQ8SZelCzqjS25Welt0PIF5oi/3a8BfBOJehP0wrgQQBYhWLlT
	7dsg9jDlt7K16YNq/C2hC7eO3pybDYaFWTAd00kbH89OAAFBhET3ipcBzXsFjnUbvdQ2c7Kf9dM
	FFFG6gJ9HodXm4Hcb9oWArPxlsBy9vmnhfOHukYh663utE/3xMeqO7CRXDPYM5od+6sQktEiDtj
	p4co7bnVQV30FjjVaKrzdcsjWoU36IuQU3G8o5Msy4G4RIV5Hm+TfxsX4fOzV9Dg9fu1tXzWmou
	0ZZ/XbfOMQLpBS3goYRb2fd3S+mKgIDlXTXVbU2qRZ6kkK/HqM2vCIJxnX5iL9xmEcoaVm2M+EF
	wH/zNSieg+E/JVh1QYPrFskgeAykc5T5WNoFAhn2dh5Py1VmgDrdWPsefF2vkI1puzqUMwkXk8G
	Fad2k7r1Ug6qIaN80VWhN8/jxl92m0ZEI+lILC1I6T6fmt2qJCHS83h5zp5W8nMdjruytd7FgS6
	Ak17zIBFr7WnPJaosNWEVJVybYYYhxRrtPMTHA==
X-Received: by 2002:a05:600c:8b34:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a000b647f1mr10413315e9.0.1790465712017;
        Sat, 26 Sep 2026 16:35:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018f1375sm9551305e9.8.2026.09.26.16.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:11 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 04/16] bpf: Add the typed_arena_cast instruction
Date: Sun, 27 Sep 2026 01:34:42 +0200
Message-ID: <20260926233503.3114147-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23887; i=memxor@gmail.com; h=from:subject; bh=uGm2v0Dw13LNEanVhYRN5p4BQkSAIXHct+tT0f0iWVg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWKyqysMJxbUrtRf57l53RMxP+9/N0DdWv77pJ113m vUqZ41yRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZi+5jhf/zE2OBoK5Y506fN b5g3da1YbKzrGXaBLv5PpintSyxP8jAyXKszfaVtd+j1e6MFf76tfHH3yv/dnsU6nH+CflsbHL0 pzQMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add the instruction that turns an untrusted 64-bit value into a
verifier-trusted pointer to a typed arena object:

  dst = typed_arena_cast(src, imm)

encoded as a 64-bit BPF_MOV with a reserved off value, the value in src, the
program-local BTF type ID of the struct in imm, and the pointer in dst,
which may be src. The compiler emits the instruction with a CO-RE type ID
relocation landing in imm, so the type is part of the instruction and a
cast names one typed arena on every path. The verifier registers the typed
arena for the struct on first sight, records it in the instruction's aux
data, and lowers the instruction after verification to the sanitizing
sequence of that typed arena, provided by the registry: the value is masked
with the typed arena's size less its slot size and the base is added. That
keeps the slot index bits and drops everything else, so any value lands on
the start of an object of the type. The result is trusted and never NULL.

Any value casts. A typed arena holds objects of one struct at every slot,
and a chunk nobody allocated reads as the zeroed scratch chunk, so the
verifier need not know where a value came from: a pointer loaded from the
raw arena that user space corrupted, a pointer of another type, an integer,
or a pointer to this type that arithmetic moved inside an object, which the
cast rounds back to the object. This is the whole trust model for values
that enter from untrusted memory, in four instructions on every entry, and
the reason no NULL check follows a cast.

Pointers to typed objects are stored as-is, in the raw arena, in maps, on
the stack and in typed objects. There is no handle form and no translation
on the way to memory: a load gives back the 64-bit value, and a cast makes a
pointer of it wherever the value is not trusted. A 32-bit view of a typed
pointer is what it is for any kernel pointer, a truncated scalar under the
leak rules, and storing the pointer in memory user space can read is a
pointer leak the arena's privilege already permits. The alternative, a
32-bit slot offset as the stored form, needs a conversion on every store and
a second instruction to obtain it, for no gain in what the cast can trust.

The registration validates the struct once per program: it must be a struct
with special fields, since a struct without them belongs in the raw arena,
and every special field must be one a typed arena supports, which for now is
a kptr; locks, timers, workqueues, lists, rbtrees, refcounts and uptrs are
refused as not supported. The typed arena's size comes from the struct's
"typed_arena_size:<bytes>" decl tag with the usual suffixes, 128 MiB by
default, and must be a power of two of at least a page, because the cast
bounds the value with one AND and a page is the smallest unit of backing.
The registry's answer, a slice of the typed arena region, is logged with its
slot, chunk, object count and size, so the padding a power-of-two slot costs
is visible. A program keeps a reference on each typed arena it registers
until its load fails, at which point the references are dropped before the
arena map's; a loaded program leaves the typed arena to the map for the
map's lifetime, so objects survive program reloads.

Object access, kptr fields and pointer fields come in the following patches;
until then dereferencing a typed pointer is refused.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            |  17 +++
 include/linux/bpf_verifier.h   |  19 +++
 include/uapi/linux/bpf.h       |   6 +
 kernel/bpf/backtrack.c         |   8 +-
 kernel/bpf/core.c              |   2 +
 kernel/bpf/disasm.c            |   9 ++
 kernel/bpf/fixups.c            |  33 ++++++
 kernel/bpf/log.c               |   5 +-
 kernel/bpf/verifier.c          | 207 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |   6 +
 10 files changed, 306 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f06d138b1f57..307e0e7c9445 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -945,6 +945,9 @@ enum bpf_type_flag {
 	/* DYNPTR points to file */
 	DYNPTR_TYPE_FILE	= BIT(20 + BPF_BASE_TYPE_BITS),
 
+	/* MEM is an object in a typed arena, reached through a native pointer. */
+	MEM_ARENA		= BIT(21 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -1916,6 +1919,9 @@ struct bpf_prog_aux {
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for freplace_link_cnt and prog_array_member_cnt */
 	struct bpf_arena *arena;
+	/* typed arenas this program casts to or allocates from; referenced until the load fails */
+	struct bpf_typed_arena **typed_arenas;
+	u32 typed_arena_cnt;
 	void (*recursion_detected)(struct bpf_prog *prog); /* callback if recursion is detected */
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
@@ -1991,6 +1997,17 @@ struct bpf_prog_aux {
 
 #define BPF_NR_CONTEXTS        4       /* normal, softirq, hardirq, NMI */
 
+/* The typed arena of a program-BTF struct this program registered, or NULL. */
+static inline struct bpf_typed_arena *bpf_prog_typed_arena(const struct bpf_prog_aux *aux, u32 btf_id)
+{
+	u32 i;
+
+	for (i = 0; i < aux->typed_arena_cnt; i++)
+		if (aux->typed_arenas[i]->btf_id == btf_id)
+			return aux->typed_arenas[i];
+	return NULL;
+}
+
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
 	u32			jited:1,	/* Is our filter JIT'ed? */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c775bd757706..135049628313 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -661,6 +661,7 @@ struct bpf_insn_aux_data {
 		u64 insert_off;
 	};
 	struct btf_struct_meta *kptr_struct_meta;
+	struct bpf_typed_arena *typed_arena; /* named by a cast or a typed arena kfunc call */
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
@@ -1462,6 +1463,23 @@ static inline bool type_is_ptr_alloc_obj(u32 type)
 	       !(type_flag(type) & PTR_UNTRUSTED);
 }
 
+/* A pointer to an object in a typed arena: trusted, never NULL once checked, offset within the object. */
+static inline bool type_is_typed_arena_obj(u32 type)
+{
+	return base_type(type) == PTR_TO_BTF_ID && type_flag(type) & MEM_ARENA;
+}
+
+/* An object of a program-BTF struct: allocated by the program, or in a typed arena. */
+static inline bool type_is_local_obj(u32 type)
+{
+	return type & (MEM_ALLOC | MEM_ARENA);
+}
+
+static inline bool insn_is_typed_arena_cast(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->off == BPF_TYPED_ARENA_CAST;
+}
+
 static inline bool type_is_non_owning_ref(u32 type)
 {
 	return type_is_ptr_alloc_obj(type) && type_flag(type) & NON_OWN_REF;
@@ -1824,6 +1842,7 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env);
 void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
 int bpf_opt_remove_dead_code(struct bpf_verifier_env *env);
 int bpf_opt_remove_nops(struct bpf_verifier_env *env);
+int bpf_lower_typed_arena_insns(struct bpf_verifier_env *env);
 int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env, const union bpf_attr *attr);
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4687c3310996..4bfcd0143400 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1423,6 +1423,12 @@ enum {
 
 enum bpf_addr_space_cast {
 	BPF_ADDR_SPACE_CAST = 1,
+	/*
+	 * dst = typed_arena_cast(src, imm): src holds any 64-bit value, dst
+	 * becomes a pointer to the object it names in the typed arena of the
+	 * struct whose program-BTF type ID is imm. dst may be src.
+	 */
+	BPF_TYPED_ARENA_CAST = 2,
 };
 
 /* flags for BPF_MAP_UPDATE_ELEM command */
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 0e38b9575328..38984e52ee37 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -319,7 +319,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 */
 			return 0;
 		} else if (opcode == BPF_MOV) {
-			if (BPF_SRC(insn->code) == BPF_X) {
+			if (BPF_SRC(insn->code) == BPF_X && insn->off != BPF_TYPED_ARENA_CAST) {
 				/* dreg = sreg or dreg = (s8, s16, s32)sreg
 				 * dreg needs precision after this insn
 				 * sreg needs precision before this insn
@@ -328,11 +328,13 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				if (sreg != BPF_REG_FP)
 					bt_set_reg(bt, sreg);
 			} else {
-				/* dreg = K
+				/* dreg = K, or dreg = typed_arena_cast(sreg, imm)
 				 * dreg needs precision after this insn.
 				 * Corresponding register is already marked
 				 * as precise=true in this verifier state.
-				 * No further markings in parent are necessary
+				 * No further markings in parent are necessary;
+				 * a cast yields a pointer that is safe for any
+				 * value of sreg, which needs no precision.
 				 */
 				bt_clear_reg(bt, dreg);
 			}
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d3b8b626ec0f..619f7c6a778d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3085,6 +3085,8 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	aux = container_of(work, struct bpf_prog_aux, work);
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
+	/* The typed arenas outlive the program; only the load's failure retracts them. */
+	kfree(aux->typed_arenas);
 #endif
 #ifdef CONFIG_CGROUP_BPF
 	if (aux->cgroup_atype != CGROUP_BPF_ATTACH_TYPE_INVALID)
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 36d3228d7745..b2ac521a4fb2 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -175,6 +175,12 @@ static bool is_addr_space_cast(const struct bpf_insn *insn)
 		insn->off == BPF_ADDR_SPACE_CAST;
 }
 
+static bool is_typed_arena_cast(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) &&
+		insn->off == BPF_TYPED_ARENA_CAST;
+}
+
 /* Special (internal-only) form of mov, used to resolve per-CPU addrs:
  * dst_reg = src_reg + <percpu_base_off>
  * BPF_ADDR_PERCPU is used as a special insn->off value.
@@ -208,6 +214,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %u, %u)",
 				insn->code, insn->dst_reg,
 				insn->src_reg, ((u32)insn->imm) >> 16, (u16)insn->imm);
+		} else if (is_typed_arena_cast(insn)) {
+			verbose(cbs->private_data, "(%02x) r%d = typed_arena_cast(r%d, %d)",
+				insn->code, insn->dst_reg, insn->src_reg, insn->imm);
 		} else if (is_mov_percpu_addr(insn)) {
 			verbose(cbs->private_data, "(%02x) r%d = &(void __percpu *)(r%d)",
 				insn->code, insn->dst_reg, insn->src_reg);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 37cf130ebb57..0b4636498ddc 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -876,6 +876,39 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
  *     struct __sk_buff    -> struct sk_buff
  *     struct bpf_sock_ops -> struct sock
  */
+/*
+ * Replace every typed_arena_cast with the sanitizing sequence of the typed
+ * arena the verifier registered for it. The type is part of the instruction,
+ * so a cast has exactly one typed arena by the time it gets here.
+ */
+int bpf_lower_typed_arena_insns(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insn = env->prog->insnsi;
+	int i, cnt, delta = 0, insn_cnt = env->prog->len;
+	const struct bpf_typed_arena *ta;
+	struct bpf_insn insn_buf[8];
+	struct bpf_prog *new_prog;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (!insn_is_typed_arena_cast(insn))
+			continue;
+		ta = env->insn_aux_data[i + delta].typed_arena;
+		if (!ta) {
+			verifier_bug(env, "typed_arena_cast at insn %d has no typed arena", i);
+			return -EFAULT;
+		}
+		cnt = bpf_typed_arena_cast_insns(ta, insn->dst_reg, insn->src_reg, insn_buf);
+		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+		if (!new_prog)
+			return -ENOMEM;
+		delta += cnt - 1;
+		env->prog = new_prog;
+		insn = new_prog->insnsi + i + delta;
+	}
+
+	return 0;
+}
+
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index d850a7863d2e..1ae29a08a607 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -432,14 +432,15 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 			strscpy(postfix, "_or_null");
 	}
 
-	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
+	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s",
 		 type & MEM_RDONLY ? "rdonly_" : "",
 		 type & MEM_RINGBUF ? "ringbuf_" : "",
 		 type & MEM_USER ? "user_" : "",
 		 type & MEM_PERCPU ? "percpu_" : "",
 		 type & MEM_RCU ? "rcu_" : "",
 		 type & PTR_UNTRUSTED ? "untrusted_" : "",
-		 type & PTR_TRUSTED ? "trusted_" : ""
+		 type & PTR_TRUSTED ? "trusted_" : "",
+		 type & MEM_ARENA ? "typed_arena_" : ""
 	);
 
 	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03dbc0e00398..a0069983f103 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6341,6 +6341,12 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	u32 btf_id = 0;
 	int ret;
 
+	/* The access rules for typed arena objects come with a later patch. */
+	if (type_is_typed_arena_obj(reg->type)) {
+		verbose(env, "typed arena access is not supported yet\n");
+		return -EACCES;
+	}
+
 	if (!env->allow_ptr_leaks) {
 		verbose(env,
 			"'struct %s' access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
@@ -16934,6 +16940,180 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * Every field kind program BTF can describe, and the ones a typed arena object
+ * may hold: those whose operations are single-word atomics, which is what
+ * keeps them sound while the chunk under the object comes and goes.
+ */
+#define BPF_TYPED_ARENA_FIELDS \
+	(BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD | \
+	 BPF_LIST_NODE | BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT | BPF_WORKQUEUE | \
+	 BPF_UPTR | BPF_TASK_WORK | BPF_RCU_HEAD)
+#define BPF_TYPED_ARENA_SUPPORTED_FIELDS BPF_KPTR
+
+/*
+ * The size of a struct's typed arena is a declared resource, read from the
+ * struct's "typed_arena_size:<bytes>" decl tag with the usual K/M/G suffixes,
+ * with a default. It must be a power of two, so that the cast bounds a value
+ * with one AND, and at least a page, the smallest unit of backing. The upper
+ * bound is the typed arena region, which the registry enforces.
+ */
+static int typed_arena_size(struct bpf_verifier_env *env, const struct btf *btf,
+			    const struct btf_type *t, const char *tname, u64 *size,
+			    const char **value)
+{
+	char *end;
+	u64 sz;
+
+	*value = btf_find_decl_tag_value(btf, t, -1, BPF_TYPED_ARENA_SIZE_TAG);
+	if (IS_ERR(*value)) {
+		if (PTR_ERR(*value) == -ENOENT) {
+			*value = "default";
+			*size = BPF_TYPED_ARENA_DEFAULT_SIZE;
+			return 0;
+		}
+		verbose(env, "struct %s has conflicting typed arena size declarations\n", tname);
+		return PTR_ERR(*value);
+	}
+	sz = memparse(*value, &end);
+	if (end == *value || *end || !is_power_of_2(sz) || sz < PAGE_SIZE) {
+		verbose(env, "struct %s has invalid typed arena size '%s'\n", tname, *value);
+		return -EINVAL;
+	}
+	*size = sz;
+	return 0;
+}
+
+/*
+ * Register the typed arena for a program-BTF struct the first time this
+ * program names it, and hold a reference on it until the load has either
+ * succeeded, after which the typed arena lives as long as the map, or failed.
+ */
+static struct bpf_typed_arena *typed_arena_register(struct bpf_verifier_env *env, u32 btf_id)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+	struct bpf_typed_arena *ta, **tas;
+	struct btf_struct_meta *meta;
+	struct btf *btf = aux->btf;
+	const struct btf_type *t;
+	struct btf_record *record;
+	const char *tname, *value;
+	u64 size;
+	u32 i;
+	int err;
+
+	ta = bpf_prog_typed_arena(aux, btf_id);
+	if (ta)
+		return ta;
+
+	t = btf_type_by_id(btf, btf_id);
+	if (!t || !__btf_type_is_struct(t)) {
+		verbose(env, "typed_arena_cast type ID %u is not a struct\n", btf_id);
+		return ERR_PTR(-EINVAL);
+	}
+	tname = btf_name_by_offset(btf, t->name_off);
+
+	record = btf_parse_fields(btf, t, BPF_TYPED_ARENA_FIELDS, t->size);
+	if (IS_ERR(record)) {
+		verbose(env, "struct %s has invalid special fields\n", tname);
+		return ERR_CAST(record);
+	}
+	if (!record) {
+		verbose(env, "struct %s has no special fields and needs no typed arena\n", tname);
+		return ERR_PTR(-EINVAL);
+	}
+	for (i = 0; i < record->cnt; i++) {
+		if (record->fields[i].type & BPF_TYPED_ARENA_SUPPORTED_FIELDS)
+			continue;
+		verbose(env, "struct %s field %s is not supported in a typed arena\n", tname,
+			btf_field_type_name(record->fields[i].type));
+		btf_record_free(record);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+	btf_record_free(record);
+	/* BTF keeps a record for every struct with these fields. */
+	meta = btf_find_struct_meta(btf, btf_id);
+	if (!meta) {
+		verifier_bug(env, "struct %s has special fields but no metadata", tname);
+		return ERR_PTR(-EFAULT);
+	}
+
+	err = typed_arena_size(env, btf, t, tname, &size, &value);
+	if (err)
+		return ERR_PTR(err);
+
+	tas = krealloc_array(aux->typed_arenas, aux->typed_arena_cnt + 1, sizeof(*tas),
+			     GFP_KERNEL_ACCOUNT);
+	if (!tas)
+		return ERR_PTR(-ENOMEM);
+	aux->typed_arenas = tas;
+
+	ta = bpf_typed_arena_get(bpf_prog_arena(env->prog), btf, btf_id, meta->record, size);
+	if (IS_ERR(ta)) {
+		switch (PTR_ERR(ta)) {
+		case -E2BIG:
+			verbose(env, "struct %s does not fit its typed arena: slot %lu bytes, size %llu bytes\n",
+				tname, roundup_pow_of_two(t->size), size);
+			break;
+		case -EINVAL:
+			verbose(env, "struct %s has invalid typed arena size '%s'\n", tname, value);
+			break;
+		case -ENOSPC:
+			verbose(env, "no room in the typed arena region for struct %s\n", tname);
+			break;
+		case -EOPNOTSUPP:
+			verbose(env, "typed arenas are not supported on this architecture\n");
+			break;
+		default:
+			verbose(env, "cannot register a typed arena for struct %s: %ld\n",
+				tname, PTR_ERR(ta));
+		}
+		return ta;
+	}
+	aux->typed_arenas[aux->typed_arena_cnt++] = ta;
+	verbose(env, "typed arena for struct %s: slot %u bytes, chunk %u bytes, %llu objects, size %llu bytes\n",
+		tname, bpf_typed_arena_slot(ta), bpf_typed_arena_chunk(ta),
+		bpf_typed_arena_size(ta) >> ta->slot_shift, bpf_typed_arena_size(ta));
+	return ta;
+}
+
+/*
+ * dst = typed_arena_cast(src, imm): sanitize the value in src into a pointer
+ * to an object of the struct whose program-BTF type ID is imm. Any value
+ * casts, since the lowering masks it to a slot inside the typed arena, so the
+ * result is trusted and never NULL; a pointer that already names an object of
+ * the type comes back rounded to the object it points into. The type is part
+ * of the instruction, so an instruction casts to one type on every path, and
+ * the lowering can be chosen once.
+ */
+static int check_typed_arena_cast(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
+	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *dst = &regs[insn->dst_reg];
+	struct bpf_typed_arena *ta;
+
+	/* The arena itself needs CAP_PERFMON, so the leak rules already permit a kernel pointer. */
+	if (!env->prog->aux->arena) {
+		verbose(env, "typed_arena_cast insn can only be used in a program that has an associated arena\n");
+		return -EINVAL;
+	}
+	if (!env->prog->aux->btf) {
+		verbose(env, "typed_arena_cast insn requires program BTF\n");
+		return -EINVAL;
+	}
+	ta = typed_arena_register(env, insn->imm);
+	if (IS_ERR(ta))
+		return PTR_ERR(ta);
+	aux->typed_arena = ta;
+
+	mark_reg_known_zero(env, regs, insn->dst_reg);
+	dst->type = PTR_TO_BTF_ID | MEM_ARENA;
+	dst->btf = env->prog->aux->btf;
+	dst->btf_id = ta->btf_id;
+	return 0;
+}
+
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
@@ -16993,7 +17173,9 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			struct bpf_reg_state *dst_reg = regs + insn->dst_reg;
 
 			if (BPF_CLASS(insn->code) == BPF_ALU64) {
-				if (insn->imm) {
+				if (insn->off == BPF_TYPED_ARENA_CAST) {
+					return check_typed_arena_cast(env, insn);
+				} else if (insn->imm) {
 					/* off == BPF_ADDR_SPACE_CAST */
 					mark_reg_unknown(env, regs, insn->dst_reg);
 					if (insn->imm == 1) /* cast from as(1) to as(0) */
@@ -20172,6 +20354,8 @@ static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					verbose(env, "addr_space_cast insn can only convert between address space 1 and 0\n");
 					return -EINVAL;
 				}
+			} else if (insn->off == BPF_TYPED_ARENA_CAST) {
+				/* imm holds the type ID; src is the value, and dst may be src */
 			} else if ((insn->off != 0 && insn->off != 8 &&
 				    insn->off != 16 && insn->off != 32) || insn->imm) {
 				verbose(env, "BPF_MOV uses reserved fields\n");
@@ -20580,8 +20764,26 @@ static int resolve_func_ptrs(struct bpf_verifier_env *env)
 }
 
 /* drop refcnt of maps used by the rejected program */
+/*
+ * Drop the rejected program's typed arena references before its arena map
+ * reference. A typed arena nobody else registered is retracted; one that a
+ * loaded program registered lives on for the map's lifetime.
+ */
+static void release_typed_arenas(struct bpf_verifier_env *env)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+	u32 i;
+
+	for (i = 0; i < aux->typed_arena_cnt; i++)
+		bpf_typed_arena_put(bpf_prog_arena(env->prog), aux->typed_arenas[i]);
+	kfree(aux->typed_arenas);
+	aux->typed_arenas = NULL;
+	aux->typed_arena_cnt = 0;
+}
+
 static void release_maps(struct bpf_verifier_env *env)
 {
+	release_typed_arenas(env);
 	__bpf_free_used_maps(env->prog->aux, env->used_maps,
 			     env->used_map_cnt);
 }
@@ -22688,6 +22890,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 			sanitize_dead_code(env);
 	}
 
+	if (ret == 0)
+		ret = bpf_lower_typed_arena_insns(env);
+
 	if (ret == 0)
 		/* program is valid, convert *(u32*)(ctx + off) accesses */
 		ret = bpf_convert_ctx_accesses(env);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4687c3310996..4bfcd0143400 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1423,6 +1423,12 @@ enum {
 
 enum bpf_addr_space_cast {
 	BPF_ADDR_SPACE_CAST = 1,
+	/*
+	 * dst = typed_arena_cast(src, imm): src holds any 64-bit value, dst
+	 * becomes a pointer to the object it names in the typed arena of the
+	 * struct whose program-BTF type ID is imm. dst may be src.
+	 */
+	BPF_TYPED_ARENA_CAST = 2,
 };
 
 /* flags for BPF_MAP_UPDATE_ELEM command */
-- 
2.53.0

