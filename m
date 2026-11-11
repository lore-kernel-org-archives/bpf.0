Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401876;
	b=YS4YrJ+ZIy2Lbj3mD7OrQ/rIIER0xbTjBxK83SPyiUM2TgfxmqYds+gMnr8VBThlFnJe
	 TAlG1q9C4q0wdUEmtRJsf4YC49vQIRzLMKOKlqKvEDWt1zIF+QJPBwX+6zj+dddG6GHT9
	 yJl1lPsyf5HQJBPt2rgHUEdQo1UwhDQrmMWVIfwjgB0Yj+MYxHb80s46Fy4Op4PuBiKs+
	 PC5m4MXQFsTsvIMwZT7zListRMwxX5bBzRnX87q+eZmqBRnfODZS75Ya3mMFJjW5ZR8yp
	 CRnOLSq9NJOyEay5MHILrsLSPhdajuN+Nga15KE7D2AV6+bbcKlOqzSqdcrceAd0kgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=BQPWVogzr4xCofrlaTgvuIgeGacboN/bg9Igu3iSTVA=;
	b=UvwkDRoVGv0iJq11jV9JiS0p0zmp8wKyNNbMndadMuCAYwWLyq+2sMyXwIFHNP3g2ibU
	 2hsqVw4UhBcr51sIpO+YxnroU8fELXA915k8E11S7RMET0NoawHJYpwQMl1Xq4DclbLBm
	 NtgmicReMFcm2X586w0jguIPaJ3x6OFh0XQK4KYZfyLMBlZ3mFQZ9HwR6LQTRWxUgZEGT
	 AuBTnMD7v4U26Q0Bb5EaacQJTg9+WVn5CXxd0BngcOizj3RLf/+2Yvj+gZ7JoCS1f1uyj
	 tmz2+E2SH91QRjZRdlC6IKib5VGjo4AJeIbhh+01v+4J6GBJwsfG0sVOrgo6VIJgsLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMw+dWBH;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618E606A32A
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3618E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMw+dWBH
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a611dcb60dso7330225e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401873; x=1795006673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BQPWVogzr4xCofrlaTgvuIgeGacboN/bg9Igu3iSTVA=;
        b=eMw+dWBH/NJK4MrGfZhnfGHZkDX7AvJq3AxYpw6ej9BwlCPIb5Al0blf3LGx09H2gn
         6Rw8ORq/dAFo6cDpn7YoV6F37jMyMIxLi2adZME8k7BZ7y1GQTbsBV+z1tdD1kPvSLYc
         GiaC47HMa6ArHi7sd3mEeUr6hQPhcfVpTFZp+gg+flII8MQx5IOYUwW+Gn2OOtyDyllA
         ac0RHIsmRul765pJjgq4jwSFYdKZVEmHgYAJtJmA810SzNqJLTXb6sFvW1AnPWniUQHx
         1SYQYAPk03T3B5J4ZY/IRTI3Pwj05yA0x+r/r2TefpvBjQhVAu7i5D4TXWRkbbj/lyk3
         VODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401873; x=1795006673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BQPWVogzr4xCofrlaTgvuIgeGacboN/bg9Igu3iSTVA=;
        b=MAyP2b/5mf694AR77Tem2bdeJpGKMS8Nd4IeTYe9TnGYUxOlFsRArWxERPOo5eBpI9
         MH6sOnOxavv4+F/ZiE4J8L0jHJzfqPK5NchJmubAFXZ5gfeAblRwHrnbpamFBZJQ9hUv
         HVg3eaOQfGf0o9bMUreV7Byhfi7cjuJbygXmsrBdrOIPV2KXK4Lm8dGbTPKPPCklrxyj
         KdyVR0mfRVkUDFFZvFjQSu6up9yJdAk9voJlj87sxMuT0jjc2XLFLBW3W+BviUKVsVt3
         UvDh6VxcyJ0m/ZzT7lXkgGK40AU1QfNXZjHZwpHWJN9WD4Ocf8um0HrXYsAjzSr4eKRN
         FdXw==
X-Gm-Message-State: APuU4Z/QpFLm35KGzgobgB8ut/EF42aCoMFqrtBEBKW1Jxs53C1fhdQL
	cWGbGayjniqz2Bkj3Luzk2gd9R8SuBEsxtVJZxgRqLKo9tfbiTwMJ9rJMWXJBRxH94o=
X-Gm-Gg: AYBFou1K0h3ZE5QYJgjE67N7w8OO+vkSyIX5XJTe1bMa93D3jYAtj9Cgvs51YmEwu0T
	L9x7z+/FFKCJtUKeetBsSn/LwLDibLlaVBqRwqRHtgQ6ds4Bn74qyOSpb575W5tvdOWn7OYBeha
	mkMyo2o20fiU/BEjJnIBKffOBeRFRjUvfw+GcOox+SBPkU8FFQ2l2mpS+sq9zmqOPXCvJ0m0QXr
	sth5n0KW275QPLEKnJXYpjAoEa3nnNNdqdDI0eFvtDdpZf0BCxcNvl+2/KYm4WULD71/zYU9iFz
	4yPq2TeqvO9OH+DJXTHxpYRuCFNB/Zme83XGXephR42vSPX6RR6/iLexr6HMYjjZxUPkItpnFqc
	bSmcu8NTMUNyHCyIF4onC5YovGD3fmwCMWCOnVzYaZvsFoqWCg0sNA6YzWYh6JujkKVYW+HDp5n
	Fulle9YKYdb8I+n4X0DpWMc6A6eG0CMBo+c8lxH85u+TvgwknKfN/vhDmELwUz0sUJhPvARDxC9
	1Mzk1e2vHzziko9kTzJ2+On/LWXCD2bNV5gJ5qJmuBGOPHTPlbI3eYBNzq41wA4UKcye+Gew8Cj
	Ul85BfqhAitWLzARKQbRIXXjlbuFVICglPcgAAU0UPO1b7sCbzTh08pdRDFDC2XYJCn6yU/lmLC
	+pcAUQd/1Pm4h2qJBY9bnBKqXnTLTkLdYIUikSsn7/CF4NZ3V/7LQAqfP36wWmqqVLqnH
X-Received: by 2002:a05:600c:4505:b0:49f:fd40:80fa with SMTP id 5b1f17b1804b1-4ba093c1a9bmr37374185e9.34.1794401871149;
        Wed, 11 Nov 2026 04:57:51 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c30b1sm10968555f8f.46.2026.11.11.04.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:50 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 13/29] bpf: Track held resources in hidden stack slots
Date: Wed, 11 Nov 2026 13:57:11 +0100
Message-ID: <0b8d0a69ecb9f74ed3e3645bc7dccbc022a83cc2.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=89276; i=memxor@gmail.com; h=from:subject:message-id; bh=uAWZu2QOOvwv/HvqIi6qTVA+QNghqZe0ist63+OkPEQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzILvtgvWSi5Y2CURuCk3uP+A4Kuta2zfeu/x3Xa0x i3E70V8RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZSv5/hfzLL58rcxddllm0r YGxubD0gcHA2V2O9p8bn35N37JrBcp7hn5pG0sRCwWsPnDqOmprGlr74Y/8zscmArfSAZe7FCjt 2FgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently nothing generates frame descriptors, so bpf_throw() releases
nothing and the verifier rejects a throw that is reached with a
reference, a lock, or a section held.

Add the verifier half. In a program that may throw, every call that
acquires a resource gets its own hidden stack slot in the frame that
makes the call. The verifier inserts instructions that keep the handle of
the resource in the slot while it is held. It makes no assumption about
where the program itself keeps the handle.

The main pass records, per instruction:

 - each call that acquires a resource, with the resource class and the
   location of the handle: R0 or an argument register;
 - each call that releases a resource, with the register that holds the
   handle and the acquisitions that it may release;
 - each call that enters or leaves an RCU read or preemption disabled
   section.

After the pass, the verifier reserves the slots and patches the program:

 - A handle returned in R0 is stored after the call. A pointer into the
   object, as bpf_list_pop_front() returns, is first adjusted to the
   start of the object.
 - A handle passed as an argument, the address of a lock, an iterator or
   saved IRQ flags, is stored before the call, so that a throw from
   inside an iterator loop or a critical section finds it. If the call
   can fail to acquire, the slot is cleared after a failed call.
 - A releasing call compares its handle with the slot of each
   acquisition it may release, and clears the matching slot before the
   call.
 - The handle of a dynptr, its ringbuf record or file reader, is loaded
   from the dynptr on the stack after the call that initializes it.
 - A function that enters or leaves a section counts it in one slot per
   kind.
 - A subprog that returns a reference in R0 returns holding it. The call
   is then the caller's acquisition, like a call to a kfunc that returns
   a reference.
 - The referenced arguments of a struct_ops program are loaded from the
   context when the main program is entered.
 - The slots of a frame are zeroed at its entry.

The frame descriptor of each function lists these slots, and bpf_throw()
walks them.

A slot belongs to one frame and holds one handle. A program that throws
is therefore rejected when:

 - a callee releases a resource held by its caller, or leaves a section
   that its caller entered;
 - a subprog returns holding anything other than one reference in R0, or
   in different sections than it was called in;
 - a callee creates an iterator or saves IRQ flags on its caller's stack;
 - a frame can hold two resources acquired by the same instruction;
 - an instruction acquires a resource only on some paths, such as a
   lookup that returns a socket from a map of sockets and a plain value
   from another map, or resources of different classes on different
   paths;
 - an object is released while the lock inside it is held;
 - a reference has no destructor that the unwinder may run: its type has
   no cleanup destructor registered, or the program may not call its
   release kfunc.

Later patches lift most of the first five.

The unwinder destroys iterators and restores IRQ flags on the program's
stack, so they must be intact at a throw:

 - A program that throws must not overwrite an iterator or saved IRQ
   flags on its stack.
 - A verifier state can stand for another only if the stack objects of
   both are in the same slots. This already holds: a stack object stays
   in a state whether or not it is read again, and is always compared.
 - An iterator that needs RCU protection must not outlive the RCU section
   it was created in.

States are now also compared by the owner frame, the resource class and
the acquiring instruction of each reference, since the instructions
inserted for a release depend on them.

Frames are described only where the JIT reports
bpf_jit_supports_exception_cleanup(), and only in a program where some
subprog may throw. Other architectures and programs keep the existing
rules. A throw from a callback stays rejected.

exceptions_fail has programs that expect a throw with resources held to
be rejected. That still holds where the JIT does not support the cleanup,
so restrict them to s390x, the other architecture with exceptions that
the test loader can select. Two others throw from a callback and are
still rejected here, but by that rule: update their expected message and
restrict them to x86-64 and arm64.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  |   84 ++
 kernel/bpf/Makefile                           |    2 +-
 kernel/bpf/fixups.c                           |    2 +-
 kernel/bpf/frame_desc.c                       | 1186 +++++++++++++++++
 kernel/bpf/join.c                             |   18 +-
 kernel/bpf/states.c                           |   23 +-
 kernel/bpf/verifier.c                         |  296 +++-
 .../selftests/bpf/progs/exceptions_fail.c     |   16 +-
 8 files changed, 1584 insertions(+), 43 deletions(-)
 create mode 100644 kernel/bpf/frame_desc.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 98d26a4c4a91..5cbac24102f4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -333,6 +333,14 @@ struct bpf_reference_state {
 	 * function verified on its own hold, which are not in the state.
 	 */
 	s8 frameno;
+	/*
+	 * The resource class the unwinder releases it as, plus one, see
+	 * frame_desc.c; 0 for a reference the frames keep no handle of, which
+	 * a throw may not be reached with.
+	 */
+	u16 res;
+	/* The acquisition whose slot holds its handle, plus one, see struct bpf_res_acq. */
+	u16 acq;
 	union {
 		/* For REF_TYPE_PTR */
 		int parent_id;
@@ -908,6 +916,13 @@ struct bpf_insn_aux_data {
 	u64 jump_target:1;
 
 	unsigned int orig_idx; /* original instruction index, initialized once */
+	/*
+	 * Some visit of the call acquired nothing a hidden slot can hold where
+	 * another may have acquired a resource, see frame_desc.c.
+	 */
+	bool res_none;
+	/* Some visit of the call left an R0 that is not a resource. */
+	bool res_none_r0;
 	/* registers alive before this instruction. */
 	u16 live_regs_before;
 	/*
@@ -1037,6 +1052,8 @@ struct bpf_subprog_info {
 	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
 	/* the frame descriptor of this subprogram in the pool of the program, plus one; see frame_desc.c */
 	u32 frame_desc;
+	/* hidden slots: the counts of the sections the frame entered, by kind; 0 when it has none */
+	s16 section_off[2];
 	u16 stack_depth; /* max. stack depth used by this function */
 	/* bytes below the verified stack depth reserved for hidden slots, see bpf_reserve_stack_slots() */
 	u16 stack_extra;
@@ -1224,6 +1241,42 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
+#define BPF_RES_F_ARG		BIT(0)	/* the handle is the pointer the call takes in the register */
+#define BPF_RES_F_MAY_FAIL	BIT(1)	/* acquired only when the call returns 0 */
+#define BPF_RES_F_DEREF		BIT(2)	/* the handle is the first word of a dynptr on the stack */
+#define BPF_RES_F_CTX		BIT(3)	/* a __ref argument the kernel passes the main program */
+
+/*
+ * A call that acquires a resource, see frame_desc.c: the handle of what it
+ * acquired is kept in a hidden slot of the frame that runs the call, one slot
+ * per acquiring call.
+ */
+struct bpf_res_acq {
+	u32 insn;	/* the insn as the main pass named it; the argument with BPF_RES_F_CTX */
+	u16 res;	/* the class of what it acquires */
+	u8 reg;		/* R0 for what the call returns, else the argument that is the handle */
+	u8 flags;	/* BPF_RES_F_* */
+	s16 adj;	/* R0 points that many bytes into the object: the node of a list */
+	s16 obj_off;	/* BPF_RES_F_DEREF: the dynptr, relative to R10; BPF_RES_F_CTX: in the context */
+	s16 off;	/* the slot, relative to R10 */
+};
+
+/* A call that releases what an acquisition acquired: the slot of the acquisition is cleared. */
+struct bpf_res_rel {
+	u32 insn;
+	u16 acq;	/* index of the acquisition */
+	u8 reg;		/* the argument the call releases */
+	u8 flags;	/* BPF_RES_F_DEREF */
+	s16 adj;	/* the argument points that many bytes into the object */
+};
+
+/* A call that enters or leaves a section, for the count of its frame, see frame_desc.c. */
+struct bpf_section_insn {
+	u32 insn;
+	u8 kind;	/* 0 RCU, 1 preemption */
+	s8 delta;
+};
+
 /* Initialization of a hidden stack slot, emitted in the subprogram's prologue. */
 struct bpf_stack_init {
 	u32 subprog;
@@ -1258,6 +1311,19 @@ struct bpf_verifier_env {
 	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
 	struct bpf_stack_init *stack_inits; /* hidden slot initializations, see bpf_stack_slot_init() */
 	u32 stack_init_cnt;
+	struct bpf_resource *resources;	/* resource classes of frame descriptors */
+	u32 resource_cnt;
+	struct bpf_res_acq *res_acqs;		/* see frame_desc.c */
+	u32 res_acq_cnt;
+	struct bpf_res_rel *res_rels;
+	u32 res_rel_cnt;
+	struct bpf_section_insn *section_insns;
+	u32 section_insn_cnt;
+	int release_regno;			/* the argument the current call releases, or -1 */
+	u32 frame_desc_slots;			/* hidden slots that hold handles and counts */
+	u32 frame_desc_insns;			/* instructions keeping them up to date */
+	u32 frame_desc_bytes;			/* descriptors and resource classes */
+	bool describe_frames;			/* frame descriptors are generated: the program may throw */
 	int exception_callback_subprog;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
@@ -1929,6 +1995,7 @@ u32 btf_func_arg_align(const struct btf *btf, const struct btf_type *t);
 
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
+bool bpf_nmi_unsafe_prog(struct bpf_verifier_env *env);
 int bpf_compute_const_regs(struct bpf_verifier_env *env);
 int bpf_prune_dead_branches(struct bpf_verifier_env *env);
 int bpf_check_cfg(struct bpf_verifier_env *env);
@@ -2202,7 +2269,24 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 /* Functions in fixups.c, called from bpf_check() */
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len);
 int bpf_reserve_stack_slots(struct bpf_verifier_env *env, int subprog, int nr, s16 *off);
+int bpf_adj_moved_insn(struct bpf_insn *insn, u32 delta);
 int bpf_stack_slot_init(struct bpf_verifier_env *env, int subprog, s16 off, s32 imm);
+
+/* Functions in frame_desc.c */
+int bpf_frame_desc_record_acquire(struct bpf_verifier_env *env, int idx, int regno, bool after,
+				  bool may_fail);
+void bpf_frame_desc_record_none(struct bpf_verifier_env *env, const struct bpf_reg_state *r0);
+int bpf_frame_desc_record_release(struct bpf_verifier_env *env, int idx);
+int bpf_frame_desc_record_ctx_arg(struct bpf_verifier_env *env, int idx, int argno);
+int bpf_frame_desc_record_section(struct bpf_verifier_env *env, u8 kind, s8 delta);
+int bpf_frame_desc_record_exit(struct bpf_verifier_env *env);
+int bpf_frame_desc_record_return(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+				 int idx, int callsite, const struct bpf_reg_state *r0);
+int bpf_frame_desc_resolve(struct bpf_verifier_env *env);
+int bpf_frame_desc_emit(struct bpf_verifier_env *env);
+int bpf_frame_desc_build(struct bpf_verifier_env *env);
+void bpf_frame_desc_reset(struct bpf_verifier_env *env);
+void bpf_frame_desc_env_free(struct bpf_verifier_env *env);
 int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env);
 int bpf_optimize_bpf_loop(struct bpf_verifier_env *env);
 void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 2b6b4af882d1..da4d62466645 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o unwind.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o frame_desc.o unwind.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 4e46f8931775..984d6287241a 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -553,7 +553,7 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
  * insn was moved down by delta insns inside its own patch. Operands relative
  * to the pc that point in front of the old position did not move with it.
  */
-static int bpf_adj_moved_insn(struct bpf_insn *insn, u32 delta)
+int bpf_adj_moved_insn(struct bpf_insn *insn, u32 delta)
 {
 	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
 	s64 off = insn->imm, off_min = S32_MIN;
diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
new file mode 100644
index 000000000000..b0db3feeb9b0
--- /dev/null
+++ b/kernel/bpf/frame_desc.c
@@ -0,0 +1,1186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Frame descriptors: the hidden stack slots in which the frames of a program
+ * that may throw keep the handles of the kernel resources they hold, for
+ * bpf_throw() to release, see unwind.c.
+ *
+ * Nothing is inferred about where a program keeps a reference. The handle of
+ * a resource is written down when the resource is acquired: the pointer a
+ * call returns, the address of the lock, the iterator or the saved IRQ flags
+ * a call takes, the record or the reader of a dynptr. Every call that
+ * acquires has a slot of its own in the frame that runs it. The handle goes
+ * into the slot around the call, and the call that releases the resource
+ * clears the slot when it holds the handle the call takes. The sections a
+ * frame enters, RCU read and preemption disabled, have no handle and are
+ * counted in a slot per kind.
+ *
+ * A slot belongs to one frame and holds one handle, so a program that throws
+ * keeps to what that can express:
+ *
+ *  - A frame releases what it acquired itself. A callee cannot reach the
+ *    slot of its caller, so it may not release what its caller holds.
+ *  - A frame that returns holds nothing but a reference it returns in R0,
+ *    which the call acquires for the caller like the call of a kfunc that
+ *    returns one, and is in the sections it was called in.
+ *  - A frame holds one resource of an acquiring call at a time.
+ *
+ * The main pass records every call that acquires or releases and which
+ * acquisition a release may be of. The slots are reserved and the
+ * instructions that keep them emitted after the pass.
+ */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/kallsyms.h>
+#include <linux/sort.h>
+
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
+
+/* Intern a resource class; descriptors refer to it by index. */
+static int resource_intern(struct bpf_verifier_env *env, const struct bpf_resource *res)
+{
+	struct bpf_resource *tab;
+	u32 i, cnt = env->resource_cnt;
+
+	for (i = 0; i < cnt; i++)
+		if (!memcmp(&env->resources[i], res, sizeof(*res)))
+			return i;
+	if (cnt >= U16_MAX)
+		return -E2BIG;
+	tab = kvrealloc(env->resources, array_size(cnt + 1, sizeof(*tab)), GFP_KERNEL_ACCOUNT);
+	if (!tab)
+		return -ENOMEM;
+	tab[cnt] = *res;
+	env->resources = tab;
+	env->resource_cnt = cnt + 1;
+	return cnt;
+}
+
+/*
+ * Resolve the destructor of a referenced kernel object through the BTF
+ * destructor registry, and check that the program could have called the
+ * matching release kfunc itself: that is the context in which running the
+ * destructor is legal. A class interned for the type already has it resolved.
+ */
+static int resource_registry(struct bpf_verifier_env *env, struct btf *btf, u32 btf_id,
+			     struct bpf_resource *res, const char *what, bool report)
+{
+	const char *name = btf_name_by_offset(btf, btf_type_by_id(btf, btf_id)->name_off);
+	struct btf *dtor_btf = btf;
+	const struct btf_id_dtor_kfunc *dtor = btf_find_dtor(&dtor_btf, btf_id);
+	const struct btf_type *t;
+	u32 i, *flags;
+
+	for (i = 0; i < env->resource_cnt; i++) {
+		const struct bpf_resource *r = &env->resources[i];
+
+		if (r->kind == res->kind && r->btf == btf && r->btf_id == btf_id) {
+			res->dtor = r->dtor;
+			res->sleeps = r->sleeps;
+			return 0;
+		}
+	}
+	if (!dtor || !(dtor->flags & BPF_DTOR_CLEANUP)) {
+		if (report)
+			verbose(env, "frame_desc: no cleanup destructor registered for %s %s\n", what,
+				name);
+		return -EOPNOTSUPP;
+	}
+	flags = btf_kfunc_flags(dtor_btf, dtor->release_btf_id, env->prog);
+	if (!flags || !btf_kfunc_is_allowed(dtor_btf, dtor->release_btf_id, env->prog)) {
+		if (report)
+			verbose(env, "frame_desc: release kfunc of %s %s is not callable by this program\n",
+				what, name);
+		return -EOPNOTSUPP;
+	}
+	res->sleeps = *flags & KF_SLEEPABLE;
+	t = btf_type_by_id(dtor_btf, dtor->kfunc_btf_id);
+	res->dtor = t ? (void *)kallsyms_lookup_name(btf_name_by_offset(dtor_btf, t->name_off)) :
+			NULL;
+	if (!res->dtor) {
+		if (report)
+			verbose(env, "frame_desc: cannot resolve the destructor of %s %s\n", what, name);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static bool helper_ok(struct bpf_verifier_env *env, enum bpf_func_id func_id)
+{
+	return env->ops->get_func_proto && env->ops->get_func_proto(func_id, env->prog);
+}
+
+/*
+ * Does @reg point to one of the socket structs of vmlinux BTF? A referenced
+ * one is the cast of an acquired socket by a helper such as
+ * bpf_skc_to_tcp_sock(), which carries the socket's reference under the
+ * struct's type.
+ */
+static bool reg_is_sock_btf(const struct bpf_reg_state *reg)
+{
+#ifdef CONFIG_NET
+	int i;
+
+	if (!btf_is_vmlinux(reg->btf))
+		return false;
+	for (i = 0; i < MAX_BTF_SOCK_TYPE; i++)
+		if (reg->btf_id == btf_sock_ids[i])
+			return true;
+#endif
+	return false;
+}
+
+/*
+ * Classify the reference a register holds, @report why it cannot be. A
+ * reference of a type that no destructor is registered for, or whose release
+ * kfunc the program may not call, has no class: the frames keep no handle of
+ * it, and a throw may not be reached while it is held.
+ */
+static int resource_describe(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
+			     struct bpf_resource *resp, bool report)
+{
+	u32 flags = type_flag(reg->type) & ~PTR_MAYBE_NULL;
+	struct bpf_resource res;
+	int ret;
+
+	memset(&res, 0, sizeof(res));
+	switch (base_type(reg->type)) {
+	case PTR_TO_BTF_ID:
+		if (flags & MEM_ALLOC) {
+			if (flags & ~(MEM_ALLOC | MEM_PERCPU))
+				goto unsupported;
+			res.kind = flags & MEM_PERCPU ? BPF_RESOURCE_PERCPU_OBJ : BPF_RESOURCE_OBJ;
+			res.meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+			/* where the program may not drop the object, the unwinder may not either */
+			if (res.meta && bpf_nmi_unsafe_prog(env) &&
+			    btf_record_has_nmi_unsafe_fields(res.meta->record))
+				goto unsupported;
+			/* the types without fields to destroy are freed alike: one class */
+			break;
+		}
+		if (flags & ~PTR_TRUSTED)
+			goto unsupported;
+		res.btf = reg->btf;
+		res.btf_id = reg->btf_id;
+		/* A socket cast to one of its structs is still what bpf_sk_release() takes. */
+		if (reg_is_sock_btf(reg) && helper_ok(env, BPF_FUNC_sk_release)) {
+			res.kind = BPF_RESOURCE_SOCK;
+			break;
+		}
+		res.kind = BPF_RESOURCE_KPTR;
+		ret = resource_registry(env, reg->btf, reg->btf_id, &res, "object", report);
+		if (ret)
+			return ret;
+		break;
+	case PTR_TO_SOCKET:
+	case PTR_TO_SOCK_COMMON:
+	case PTR_TO_TCP_SOCK:
+		if (flags || !helper_ok(env, BPF_FUNC_sk_release))
+			goto unsupported;
+		res.kind = BPF_RESOURCE_SOCK;
+		break;
+	case PTR_TO_MEM:
+		if (flags != MEM_RINGBUF || !helper_ok(env, BPF_FUNC_ringbuf_discard))
+			goto unsupported;
+		res.kind = BPF_RESOURCE_RINGBUF;
+		break;
+	default:
+		goto unsupported;
+	}
+	*resp = res;
+	return 0;
+unsupported:
+	if (report)
+		verbose(env, "frame_desc: cannot release a reference of type %s\n",
+			reg_type_str(env, reg->type));
+	return -EOPNOTSUPP;
+}
+
+/*
+ * The class of the iterator in @reg, the first slot of an iterator. An
+ * RCU-protected iterator is destroyed before the sections of its frame end,
+ * unless its destructor sleeps: that runs after every section, which is
+ * the only place the program could have called it.
+ */
+static int resource_of_iter(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
+{
+	struct bpf_resource res;
+	int ret;
+
+	/* nothing may release it once its RCU protection ended */
+	if (reg->type & PTR_UNTRUSTED)
+		return -EOPNOTSUPP;
+	memset(&res, 0, sizeof(res));
+	res.kind = BPF_RESOURCE_ITER;
+	res.btf = reg->iter.btf;
+	res.btf_id = reg->iter.btf_id;
+	ret = resource_registry(env, reg->iter.btf, reg->iter.btf_id, &res, "iterator", false);
+	if (ret)
+		return ret;
+	res.rcu = (reg->type & MEM_RCU) && !res.sleeps;
+	return resource_intern(env, &res);
+}
+
+/*
+ * Does @reg point into the object of reference @id, @off bytes in: the node
+ * of a list or a tree is popped and pushed that way, and the object it is
+ * in is released.
+ */
+static bool reg_ref_off(const struct bpf_reg_state *reg, int id, s16 *off)
+{
+#ifdef CONFIG_NET
+	/*
+	 * bpf_skc_to_mptcp_sock() gives its result the id of the subflow it
+	 * was passed, and the result is the socket of the connection.
+	 */
+	if (base_type(reg->type) == PTR_TO_BTF_ID && btf_is_vmlinux(reg->btf) &&
+	    reg->btf_id == btf_sock_ids[BTF_SOCK_TYPE_MPTCP])
+		return false;
+#endif
+	if (reg->type == SCALAR_VALUE || reg->type == NOT_INIT || reg->id != id ||
+	    !tnum_is_const(reg->var_off) || reg->var_off.value != (u64)(s16)reg->var_off.value)
+		return false;
+	*off = reg->var_off.value;
+	return true;
+}
+
+/*
+ * Is @slot the stack object of reference @id: the first slot of an iterator,
+ * of a ringbuf dynptr, which tracks the record's reference as its parent,
+ * or saved IRQ flags?
+ */
+static bool stack_slot_is_object(const struct bpf_stack_state *slot, int id)
+{
+	const struct bpf_reg_state *reg = &slot->spilled_ptr;
+
+	switch (slot->slot_type[BPF_REG_SIZE - 1]) {
+	case STACK_DYNPTR:
+		return reg->dynptr.first_slot && reg->parent_id == id &&
+		       (reg->dynptr.type == BPF_DYNPTR_TYPE_RINGBUF ||
+			reg->dynptr.type == BPF_DYNPTR_TYPE_FILE);
+	case STACK_ITER:
+	case STACK_IRQ_FLAG:
+		return reg->id == id;
+	default:
+		return false;
+	}
+}
+
+/*
+ * The frame and slot of the stack object of reference @ref, if it is one:
+ * the object may be in the stack of another frame, created through a
+ * pointer to it.
+ */
+static bool stack_object_find(const struct bpf_verifier_state *st,
+			      const struct bpf_reference_state *ref, int *frameno, int *spi)
+{
+	int f, k;
+
+	for (f = st->curframe; f >= 0; f--) {
+		const struct bpf_func_state *frame = st->frame[f];
+
+		for (k = 0; k < bpf_stack_nr_slots(frame); k++) {
+			if (!stack_slot_is_object(bpf_stack_slot(frame, k), ref->id))
+				continue;
+			*frameno = f;
+			*spi = k;
+			return true;
+		}
+	}
+	return false;
+}
+
+/* The class of the sections of @kind, 0 RCU read and 1 preemption disabled. */
+static int resource_of_section(struct bpf_verifier_env *env, u8 kind)
+{
+	struct bpf_resource res;
+
+	memset(&res, 0, sizeof(res));
+	res.kind = kind ? BPF_RESOURCE_PREEMPT : BPF_RESOURCE_RCU;
+	return resource_intern(env, &res);
+}
+
+static int resource_of_kind(struct bpf_verifier_env *env, u8 kind)
+{
+	struct bpf_resource res;
+
+	memset(&res, 0, sizeof(res));
+	res.kind = kind;
+	return resource_intern(env, &res);
+}
+
+/* The offset from R10 of the stack slot @spi of a frame. */
+static s16 spi_off(int spi)
+{
+	return -(spi + 1) * BPF_REG_SIZE;
+}
+
+/*
+ * The class of the resource refs[@idx] the current insn acquires, and how the
+ * insn has its handle: in R@regno @after the call, the pointer the call
+ * returns, which may point @adj bytes into the object, or in the register in
+ * front of it, the pointer the call takes to a lock or to a stack object. The
+ * handle of a dynptr is the record or the reader, the first word of the
+ * dynptr at @obj_off, so that a clone releases it as well as the dynptr it was
+ * created in. -EOPNOTSUPP for a resource the unwinder cannot release, -EXDEV
+ * for a stack object in the stack of another frame.
+ */
+static int acquired_class(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			  const struct bpf_reference_state *ref, int regno, bool after, u8 *flags,
+			  s16 *adj, s16 *obj_off)
+{
+	const struct bpf_func_state *frame = st->frame[st->curframe];
+	const struct bpf_stack_state *slot;
+	struct bpf_resource res;
+	struct bpf_reg_state reg;
+	int objframe, spi, ret;
+
+	*adj = 0;
+	*obj_off = 0;
+	if (after) {
+		reg = frame->regs[regno];
+		if (!reg_ref_off(&reg, ref->id, adj))
+			*adj = 0;
+		reg.var_off = tnum_const(0);
+		ret = resource_describe(env, &reg, &res, false);
+		return ret ? -EOPNOTSUPP : resource_intern(env, &res);
+	}
+	*flags |= BPF_RES_F_ARG;
+	if (ref->type & REF_TYPE_LOCK_MASK)
+		return resource_of_kind(env, ref->type == REF_TYPE_LOCK ? BPF_RESOURCE_SPIN_LOCK :
+								   BPF_RESOURCE_RES_LOCK);
+	if (!stack_object_find(st, ref, &objframe, &spi))
+		return -EOPNOTSUPP;
+	if (objframe != st->curframe)
+		return -EXDEV;
+	slot = bpf_stack_slot(st->frame[objframe], spi);
+	switch (slot->slot_type[BPF_REG_SIZE - 1]) {
+	case STACK_DYNPTR:
+		*flags |= BPF_RES_F_DEREF;
+		*obj_off = spi_off(spi);
+		return resource_of_kind(env, slot->spilled_ptr.dynptr.type == BPF_DYNPTR_TYPE_FILE ?
+					     BPF_RESOURCE_DYNPTR_FILE : BPF_RESOURCE_RINGBUF);
+	case STACK_IRQ_FLAG:
+		return resource_of_kind(env, BPF_RESOURCE_IRQ_FLAG);
+	default:
+		ret = resource_of_iter(env, &slot->spilled_ptr);
+		return ret < 0 ? -EOPNOTSUPP : ret;
+	}
+}
+
+/*
+ * The acquisition of insn @insn through R@reg: the same on every visit, since
+ * the insns that keep its slot are emitted once. Returns its index.
+ */
+static int acq_add(struct bpf_verifier_env *env, u32 insn, u16 res, u8 reg, u8 flags, s16 adj,
+		   s16 obj_off)
+{
+	u32 i, cnt = env->res_acq_cnt;
+	struct bpf_res_acq *a;
+
+	for (i = 0; i < cnt; i++) {
+		a = &env->res_acqs[i];
+		if (a->insn != insn || a->reg != reg || (a->flags ^ flags) & BPF_RES_F_CTX)
+			continue;
+		if (a->res != res || a->flags != flags || a->adj != adj || a->obj_off != obj_off) {
+			verbose(env, "frame_desc: insn %d acquires resources of different types on different paths\n",
+				insn);
+			return -EINVAL;
+		}
+		return i;
+	}
+	if (cnt >= U16_MAX - 1)
+		return -E2BIG;
+	a = kvrealloc(env->res_acqs, array_size(cnt + 1, sizeof(*a)), GFP_KERNEL_ACCOUNT);
+	if (!a)
+		return -ENOMEM;
+	a[cnt] = (struct bpf_res_acq) { .insn = insn, .res = res, .reg = reg, .flags = flags,
+					.adj = adj, .obj_off = obj_off };
+	env->res_acqs = a;
+	env->res_acq_cnt = cnt + 1;
+	return cnt;
+}
+
+/*
+ * refs[@idx] is what acquisition @acq acquired, held by the frame that owns
+ * it: its handle is in the slot of the acquisition, and the slot holds one.
+ */
+static int ref_set_acq(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
+		       int acq)
+{
+	struct bpf_reference_state *ref = &st->refs[idx];
+	int i;
+
+	for (i = 0; i < st->acquired_refs; i++) {
+		if (i == idx || st->refs[i].acq != acq + 1 || st->refs[i].frameno != ref->frameno)
+			continue;
+		verbose(env, "frame_desc: a frame holds two resources of insn %d at once, which is not supported in a program that throws\n",
+			env->res_acqs[acq].insn);
+		return -EINVAL;
+	}
+	ref->res = env->res_acqs[acq].res + 1;
+	ref->acq = acq + 1;
+	return 0;
+}
+
+/*
+ * Record that the current insn acquires the resource refs[@idx], whose handle
+ * is in R@regno @after the insn, the pointer a call returns, or in front of
+ * it, the pointer to a stack object or to a lock the call takes. A call that
+ * @may_fail, a resilient lock, has acquired it only when it returns 0. A
+ * resource the unwinder cannot release gets no slot, and a throw may not be
+ * reached while it is held, see bpf_reference_state::res.
+ */
+int bpf_frame_desc_record_acquire(struct bpf_verifier_env *env, int idx, int regno, bool after,
+				  bool may_fail)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+	struct bpf_reference_state *ref = &st->refs[idx];
+	u8 flags = may_fail ? BPF_RES_F_MAY_FAIL : 0;
+	s16 adj, obj_off;
+	int res, acq;
+
+	ref->res = 0;
+	ref->acq = 0;
+	if (!env->describe_frames || st->speculative)
+		return 0;
+	res = acquired_class(env, st, ref, regno, after, &flags, &adj, &obj_off);
+	if (res == -EOPNOTSUPP) {
+		/* the insns of another visit must not take this for a resource of theirs */
+		env->insn_aux_data[env->insn_idx].res_none = true;
+		return 0;
+	}
+	if (res == -EXDEV) {
+		verbose(env, "frame_desc: insn %d creates an object in the stack of another frame, which is not supported in a program that throws\n",
+			env->insn_idx);
+		return -EINVAL;
+	}
+	if (res < 0)
+		return res;
+	if (regno < BPF_REG_0 || regno > BPF_REG_5) {
+		verbose(env, "frame_desc: insn %d takes the handle of a resource in no register\n",
+			env->insn_idx);
+		return -EINVAL;
+	}
+	acq = acq_add(env, env->insn_idx, res, regno, flags, adj, obj_off);
+	return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
+}
+
+/*
+ * The current insn is a call that acquires nothing on this visit and leaves
+ * @r0. It may acquire what R0 carries on another visit, as a lookup does in a
+ * map of sockets and not in another map: the insns that keep the slot of that
+ * would take this R0 for the handle, see bpf_frame_desc_resolve().
+ */
+void bpf_frame_desc_record_none(struct bpf_verifier_env *env, const struct bpf_reg_state *r0)
+{
+	if (!env->describe_frames || env->cur_state->speculative)
+		return;
+	if (r0->type != SCALAR_VALUE || !tnum_equals_const(r0->var_off, 0))
+		env->insn_aux_data[env->insn_idx].res_none_r0 = true;
+}
+
+/*
+ * Did some visit of insn @idx acquire nothing a slot can hold where
+ * acquisition @a has a resource? An R0 that is no resource matters to an
+ * acquisition whose handle is R0: one that takes its handle in an argument,
+ * a lock for one, stores the argument.
+ */
+static bool acquires_sometimes(const struct bpf_verifier_env *env, u32 idx,
+			       const struct bpf_res_acq *a)
+{
+	const struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+
+	return aux->res_none || (aux->res_none_r0 && !(a->flags & BPF_RES_F_ARG));
+}
+
+/*
+ * The kernel holds a reference for the __ref argument @argno of a struct_ops
+ * program, refs[@idx], and the program releases it or hands it back: the main
+ * program holds it from its first insn, in a slot its entry fills from the
+ * context. An argument of a type the unwinder cannot release gets no slot,
+ * like any such reference.
+ */
+int bpf_frame_desc_record_ctx_arg(struct bpf_verifier_env *env, int idx, int argno)
+{
+	const struct bpf_ctx_arg_aux *info = &env->prog->aux->ctx_arg_info[argno];
+	struct bpf_verifier_state *st = env->cur_state;
+	struct bpf_reference_state *ref = &st->refs[idx];
+	struct bpf_reg_state reg = {};
+	struct bpf_resource res;
+	int ret;
+
+	ref->res = 0;
+	ref->acq = 0;
+	if (!env->describe_frames)
+		return 0;
+	reg.type = info->reg_type & ~PTR_MAYBE_NULL;
+	reg.btf = info->btf;
+	reg.btf_id = info->btf_id;
+	if (resource_describe(env, &reg, &res, false))
+		return 0;
+	ret = resource_intern(env, &res);
+	if (ret < 0)
+		return ret;
+	ret = acq_add(env, argno, ret, BPF_REG_1, BPF_RES_F_CTX, 0, info->offset);
+	return ret < 0 ? ret : ref_set_acq(env, st, idx, ret);
+}
+
+/*
+ * Record that the current insn releases the resource refs[@idx], before it
+ * is released: its handle, in the argument the call releases, see
+ * bpf_verifier_env::release_regno, leaves the slot of its acquisition in
+ * front of the call. A frame releases what it acquired itself: nothing tells
+ * a callee where the slot of its caller is.
+ */
+int bpf_frame_desc_record_release(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+	const struct bpf_reference_state *ref = &st->refs[idx];
+	const struct bpf_func_state *frame = st->frame[st->curframe];
+	u32 i, cnt = env->res_rel_cnt, insn = env->insn_idx;
+	int regno = env->release_regno;
+	const struct bpf_res_acq *acq;
+	struct bpf_res_rel *r;
+	u8 flags = 0;
+	s16 adj = 0;
+
+	if (!env->describe_frames || st->speculative)
+		return 0;
+	/* the lock would be unlocked in memory that may be gone by then */
+	for (i = 0; ref->type == REF_TYPE_PTR && i < st->acquired_refs; i++) {
+		if (!(st->refs[i].type & REF_TYPE_LOCK_MASK) || st->refs[i].id != ref->id)
+			continue;
+		verbose(env, "frame_desc: insn %d releases an object whose lock is held, which is not supported in a program that throws\n",
+			insn);
+		return -EINVAL;
+	}
+	if (!ref->res)
+		return 0;
+	if (ref->frameno != st->curframe) {
+		verbose(env, "frame_desc: insn %d releases what another frame holds, which is not supported in a program that throws\n",
+			insn);
+		return -EINVAL;
+	}
+	acq = &env->res_acqs[ref->acq - 1];
+	if (regno < BPF_REG_1 || regno > BPF_REG_5) {
+		verbose(env, "frame_desc: insn %d releases a resource whose handle is in no argument register\n",
+			insn);
+		return -EINVAL;
+	}
+	if (acq->flags & BPF_RES_F_DEREF) {
+		flags = BPF_RES_F_DEREF;
+	} else if (!(acq->flags & BPF_RES_F_ARG) &&
+		   !reg_ref_off(&frame->regs[regno], ref->id, &adj)) {
+		verbose(env, "frame_desc: insn %d releases a resource R%d does not point to\n", insn,
+			regno);
+		return -EINVAL;
+	}
+	for (i = 0; i < cnt; i++) {
+		r = &env->res_rels[i];
+		if (r->insn != insn || r->reg != regno)
+			continue;
+		/* the argument is taken the same way whatever it releases */
+		if (r->flags != flags || r->adj != adj) {
+			verbose(env, "frame_desc: insn %d takes the handle of what it releases differently on different paths\n",
+				insn);
+			return -EINVAL;
+		}
+		if (r->acq == ref->acq - 1)
+			return 0;
+	}
+	r = kvrealloc(env->res_rels, array_size(cnt + 1, sizeof(*r)), GFP_KERNEL_ACCOUNT);
+	if (!r)
+		return -ENOMEM;
+	r[cnt] = (struct bpf_res_rel) { .insn = insn, .acq = ref->acq - 1, .reg = regno,
+					.flags = flags, .adj = adj };
+	env->res_rels = r;
+	env->res_rel_cnt = cnt + 1;
+	return 0;
+}
+
+/* The current insn enters (@delta 1) or leaves (-1) a section of @kind: counted by its frame. */
+int bpf_frame_desc_record_section(struct bpf_verifier_env *env, u8 kind, s8 delta)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+	struct bpf_section_insn *si;
+	u32 i, cnt = env->section_insn_cnt;
+
+	if (!env->describe_frames || st->speculative)
+		return 0;
+	for (i = 0; i < cnt; i++)
+		if (env->section_insns[i].insn == env->insn_idx)
+			return 0;
+	si = kvrealloc(env->section_insns, array_size(cnt + 1, sizeof(*si)), GFP_KERNEL_ACCOUNT);
+	if (!si)
+		return -ENOMEM;
+	si[cnt] = (struct bpf_section_insn) { .insn = env->insn_idx, .kind = kind, .delta = delta };
+	env->section_insns = si;
+	env->section_insn_cnt = cnt + 1;
+	return 0;
+}
+
+/*
+ * The current frame returns to its caller. Its slots and its counts of
+ * sections go with the frame, and nothing moves them to the frame it returns
+ * to, so it returns holding nothing but a reference in R0, which the call
+ * acquires for the caller, see bpf_frame_desc_record_return(), and in as many
+ * sections as it was called in. The entry counts of the sections are lowered
+ * as the frame leaves its callers' sections, see release_context_state(),
+ * which counts those apart.
+ */
+int bpf_frame_desc_record_exit(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+	const struct bpf_func_state *frame = st->frame[st->curframe];
+	int i, held = 0;
+	s16 adj;
+
+	if (!env->describe_frames || st->speculative)
+		return 0;
+	if (st->active_rcu_locks != frame->entry_rcu_locks || frame->rcu_released_below ||
+	    st->active_preempt_locks != frame->entry_preempt_locks || frame->preempt_released_below) {
+		verbose(env, "frame_desc: a subprog returns in other sections than it was called in at insn %d, which is not supported in a program that throws\n",
+			env->insn_idx);
+		return -EINVAL;
+	}
+	for (i = 0; i < st->acquired_refs; i++) {
+		const struct bpf_reference_state *ref = &st->refs[i];
+
+		if (!ref->res || ref->frameno != st->curframe)
+			continue;
+		if (ref->type == REF_TYPE_PTR && !(env->res_acqs[ref->acq - 1].flags & BPF_RES_F_ARG) &&
+		    reg_ref_off(&frame->regs[BPF_REG_0], ref->id, &adj) && !held++)
+			continue;
+		verbose(env, "frame_desc: a subprog returns holding what R0 does not carry at insn %d, which is not supported in a program that throws\n",
+			env->insn_idx);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * A subprog called at insn @callsite returned to the current frame of @st
+ * with @r0. The reference refs[@idx] it returned holding is the caller's
+ * from here on, acquired by the call like the reference a kfunc returns; with
+ * @idx < 0 it returned holding nothing, and what it left in R0 must not be
+ * taken for a reference by the insns another visit has follow the call.
+ */
+int bpf_frame_desc_record_return(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+				 int idx, int callsite, const struct bpf_reg_state *r0)
+{
+	struct bpf_reference_state *ref;
+	s16 adj = 0;
+	int acq;
+
+	if (!env->describe_frames || st->speculative)
+		return 0;
+	ref = idx < 0 ? NULL : &st->refs[idx];
+	if (!ref || !ref->res) {
+		if (r0->type != SCALAR_VALUE || !tnum_equals_const(r0->var_off, 0))
+			env->insn_aux_data[callsite].res_none = true;
+		return 0;
+	}
+	if (!reg_ref_off(r0, ref->id, &adj)) {
+		verbose(env, "frame_desc: the subprog called at insn %d returns holding what R0 does not carry, which is not supported in a program that throws\n",
+			callsite);
+		return -EINVAL;
+	}
+	acq = acq_add(env, callsite, ref->res - 1, BPF_REG_0, 0, adj, 0);
+	return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
+}
+
+/*
+ * A round of the main pass is dropped, see do_check_all(): what its paths
+ * recorded goes with it.
+ */
+void bpf_frame_desc_reset(struct bpf_verifier_env *env)
+{
+	u32 i;
+
+	env->res_acq_cnt = 0;
+	env->res_rel_cnt = 0;
+	env->section_insn_cnt = 0;
+	for (i = 0; i < env->prog->len; i++) {
+		env->insn_aux_data[i].res_none = false;
+		env->insn_aux_data[i].res_none_r0 = false;
+	}
+}
+
+void bpf_frame_desc_env_free(struct bpf_verifier_env *env)
+{
+	kvfree(env->res_acqs);
+	kvfree(env->res_rels);
+	kvfree(env->section_insns);
+	kvfree(env->resources);
+	env->res_acqs = NULL;
+	env->res_rels = NULL;
+	env->section_insns = NULL;
+	env->resources = NULL;
+}
+
+/*
+ * The pass named the insns of the program it verified. The insns of a patch
+ * all name the insn they replaced, and its aux data went to the last of them,
+ * see patch_list_adj_aux(): map every insn of them to that one, the call
+ * itself when insns were put in front of it. Returns NULL without memory.
+ */
+static u32 *insns_of_pass(struct bpf_verifier_env *env, u32 *orig_len)
+{
+	u32 i, len = env->prog->len, n = 0, *new_of;
+
+	/* a hidden subprog was appended to the last insn, and its insns name that one */
+	if (env->hidden_subprog_cnt)
+		len = env->subprog_info[env->subprog_cnt - 1].start;
+	for (i = 0; i < len; i++)
+		n = max(n, env->insn_aux_data[i].orig_idx + 1);
+	new_of = kvcalloc(n, sizeof(*new_of), GFP_KERNEL_ACCOUNT);
+	if (!new_of)
+		return NULL;
+	for (i = 0; i < len; i++)
+		new_of[env->insn_aux_data[i].orig_idx] = i;
+	*orig_len = n;
+	return new_of;
+}
+
+/* The subprog an acquisition is in: the main program for an argument of the context. */
+static int acq_subprog(struct bpf_verifier_env *env, const struct bpf_res_acq *a, const u32 *new_of)
+{
+	if (a->flags & BPF_RES_F_CTX)
+		return 0;
+	return bpf_find_containing_subprog(env, new_of[a->insn]) - env->subprog_info;
+}
+
+static bool subprog_has_section(struct bpf_verifier_env *env, int subprog, const u32 *new_of, u8 kind)
+{
+	u32 i;
+
+	for (i = 0; i < env->section_insn_cnt; i++) {
+		const struct bpf_section_insn *si = &env->section_insns[i];
+
+		if (si->kind == kind &&
+		    bpf_find_containing_subprog(env, new_of[si->insn]) - env->subprog_info == subprog)
+			return true;
+	}
+	return false;
+}
+
+/* An upper bound of the insns put around one call for one acquisition or release. */
+#define RES_INSNS_MAX	6
+
+/* In front of a call that takes the handle in an argument: the handle goes into the slot. */
+static int emit_acquire_before(struct bpf_insn *buf, const struct bpf_res_acq *a)
+{
+	int cnt = 0;
+
+	if ((a->flags & (BPF_RES_F_ARG | BPF_RES_F_DEREF)) == BPF_RES_F_ARG)
+		buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, a->reg, a->off);
+	return cnt;
+}
+
+/*
+ * After a call that acquires: the pointer it returned goes into the slot, as
+ * a pointer to the object, and so does the record or the reader of the
+ * dynptr it created; NULL when it acquired nothing. A call that may fail has
+ * acquired what it took only when it returned 0.
+ */
+static int emit_acquire_after(struct bpf_insn *buf, const struct bpf_res_acq *a)
+{
+	int cnt = 0;
+
+	if (a->flags & BPF_RES_F_DEREF) {
+		buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_FP, a->obj_off);
+		buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_AX, a->off);
+	} else if (a->flags & BPF_RES_F_ARG) {
+		if (a->flags & BPF_RES_F_MAY_FAIL) {
+			buf[cnt++] = BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 0, 1);
+			buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, a->off, 0);
+		}
+	} else if (a->adj) {
+		buf[cnt++] = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_0);
+		buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 1);
+		buf[cnt++] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, a->adj);
+		buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_AX, a->off);
+	} else {
+		buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_0, a->off);
+	}
+	return cnt;
+}
+
+/*
+ * Reserve the hidden slots, once the pass has seen every frame: one for each
+ * acquisition, in the frame of the subprog it is in, and a count of the
+ * sections of a kind for a subprog that enters or leaves them. The subprogs
+ * are numbered as they are now and looked up again whenever they are needed,
+ * since removing a dead one renumbers them.
+ */
+int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
+{
+	u32 i, k, orig_len, *new_of;
+	int s, ret = 0;
+
+	if (!env->res_acq_cnt && !env->section_insn_cnt)
+		return 0;
+	new_of = insns_of_pass(env, &orig_len);
+	if (!new_of)
+		return -ENOMEM;
+	for (i = 0; i < env->res_acq_cnt && !ret; i++) {
+		struct bpf_res_acq *a = &env->res_acqs[i];
+
+		if (!(a->flags & BPF_RES_F_CTX) &&
+		    verifier_bug_if(a->insn >= orig_len, env, "resource at insn %d", a->insn)) {
+			ret = -EFAULT;
+			break;
+		}
+		/* some visit of the insn has nothing a slot can hold where this one has */
+		if (!(a->flags & BPF_RES_F_CTX) && acquires_sometimes(env, new_of[a->insn], a)) {
+			verbose(env, "frame_desc: insn %d acquires a resource on some paths only, or one of a type that cannot be released\n",
+				a->insn);
+			ret = -EINVAL;
+			break;
+		}
+		ret = bpf_reserve_stack_slots(env, acq_subprog(env, a, new_of), 1, &a->off);
+		env->frame_desc_slots++;
+	}
+	for (s = 0; s < env->subprog_cnt && !ret; s++) {
+		for (k = 0; k < ARRAY_SIZE(env->subprog_info[s].section_off) && !ret; k++) {
+			if (!subprog_has_section(env, s, new_of, k))
+				continue;
+			ret = bpf_reserve_stack_slots(env, s, 1, &env->subprog_info[s].section_off[k]);
+			env->frame_desc_slots++;
+		}
+	}
+	kvfree(new_of);
+	return ret;
+}
+
+/* What is kept at an insn of the current image, in the order it is emitted in. */
+enum {
+	ITEM_SECTION,
+	ITEM_RELEASE,
+	ITEM_ACQUIRE,
+};
+
+struct res_item {
+	u32 idx;	/* insn of the current image */
+	u32 rec;	/* which section insn, release or acquisition */
+	u8 kind;
+	u8 reg;		/* ITEM_RELEASE: the argument the call releases */
+};
+
+static int item_cmp(const void *a, const void *b)
+{
+	const struct res_item *x = a, *y = b;
+
+	if (x->idx != y->idx)
+		return x->idx < y->idx ? -1 : 1;
+	if (x->kind != y->kind)
+		return x->kind - y->kind;
+	if (x->reg != y->reg)
+		return x->reg - y->reg;
+	return x->rec < y->rec ? -1 : x->rec > y->rec;
+}
+
+/*
+ * In front of a call that releases what one of the acquisitions of the @n
+ * items from @it acquired, in one argument: the slot that holds the handle
+ * the call takes is cleared, one slot, since two references to one object
+ * have equal handles in a slot each. No slot is touched when the call takes
+ * NULL or what another acquisition acquired. R0 is free in front of a call.
+ */
+static int emit_release(struct bpf_verifier_env *env, struct bpf_insn *buf,
+			const struct res_item *it, int n)
+{
+	const struct bpf_res_rel *r = &env->res_rels[it->rec];
+	int i, cnt = 0, reg = r->reg, per = r->adj ? 5 : 4;
+
+	if (r->flags & BPF_RES_F_DEREF) {
+		buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, r->reg, 0);
+		reg = BPF_REG_0;
+	}
+	for (i = 0; i < n; i++) {
+		s16 off = env->res_acqs[env->res_rels[it[i].rec].acq].off;
+		bool last = i == n - 1;
+
+		buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_FP, off);
+		if (r->adj)
+			buf[cnt++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, r->adj);
+		buf[cnt++] = BPF_JMP_REG(BPF_JNE, BPF_REG_AX, reg, last ? 1 : 2);
+		buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, off, 0);
+		/* past the slots that follow: the last one has no jump */
+		if (!last)
+			buf[cnt++] = BPF_JMP_A((n - 1 - i) * per - 1);
+	}
+	return cnt;
+}
+
+/*
+ * The insns around the call @n items from @it are kept at: in @buf, those in
+ * front of the call, the call, and those that follow it. Returns how many
+ * follow it, and in @before how many come in front.
+ */
+static int emit_items(struct bpf_verifier_env *env, const struct res_item *it, int n,
+		      struct bpf_insn *buf, int *before)
+{
+	const struct bpf_subprog_info *sub = bpf_find_containing_subprog(env, it->idx);
+	int i, k, cnt = 0, after;
+
+	for (i = 0; i < n; i++) {
+		const struct bpf_section_insn *si;
+		s16 off;
+
+		switch (it[i].kind) {
+		case ITEM_SECTION:
+			si = &env->section_insns[it[i].rec];
+			off = sub->section_off[si->kind];
+			buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_FP, off);
+			buf[cnt++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, si->delta);
+			buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_AX, off);
+			break;
+		case ITEM_RELEASE:
+			/* the acquisitions one argument may release what was acquired by */
+			for (k = i + 1; k < n && it[k].kind == ITEM_RELEASE && it[k].reg == it[i].reg; k++)
+				;
+			cnt += emit_release(env, buf + cnt, &it[i], k - i);
+			i = k - 1;
+			break;
+		case ITEM_ACQUIRE:
+			cnt += emit_acquire_before(buf + cnt, &env->res_acqs[it[i].rec]);
+			break;
+		}
+	}
+	*before = cnt;
+	buf[cnt++] = env->prog->insnsi[it->idx];
+	after = cnt;
+	for (i = 0; i < n; i++)
+		if (it[i].kind == ITEM_ACQUIRE)
+			cnt += emit_acquire_after(buf + cnt, &env->res_acqs[it[i].rec]);
+	return cnt - after;
+}
+
+/*
+ * At the entry of each subprog: its slots and counts start out empty, and
+ * the main program takes the references the kernel passed it from the
+ * context, which R1 points at. The insns go in front of the first one, which
+ * a jump to it skips.
+ */
+static int emit_entries(struct bpf_verifier_env *env)
+{
+	u32 i, k, orig_len, *new_of;
+	struct bpf_insn *buf;
+	int s, cnt, ret = 0;
+
+	new_of = insns_of_pass(env, &orig_len);
+	buf = kvcalloc(2 * (env->res_acq_cnt + 2), sizeof(*buf), GFP_KERNEL_ACCOUNT);
+	if (!new_of || !buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	for (s = 0; s < env->subprog_cnt && !ret; s++) {
+		const struct bpf_subprog_info *sub = &env->subprog_info[s];
+
+		cnt = 0;
+		for (i = 0; i < env->res_acq_cnt; i++) {
+			const struct bpf_res_acq *a = &env->res_acqs[i];
+
+			if (acq_subprog(env, a, new_of) != s)
+				continue;
+			if (a->flags & BPF_RES_F_CTX) {
+				buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_1, a->obj_off);
+				buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_AX, a->off);
+			} else {
+				buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, a->off, 0);
+			}
+		}
+		for (k = 0; k < ARRAY_SIZE(sub->section_off); k++)
+			if (sub->section_off[k])
+				buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, sub->section_off[k], 0);
+		if (!cnt)
+			continue;
+		ret = bpf_patch_list_insert(env, sub->start, buf, cnt);
+		env->frame_desc_insns += cnt;
+	}
+	ret = ret ?: bpf_patch_list_commit(env);
+out:
+	kvfree(buf);
+	kvfree(new_of);
+	return ret;
+}
+
+/*
+ * Keep the slots and the counts up to date, through the patch list. What goes
+ * in front of a call is patched in with the call, so that the jumps to it
+ * land on it; what follows it is inserted in front of the next insn, which a
+ * jump to that insn skips, as it skips the call.
+ */
+int bpf_frame_desc_emit(struct bpf_verifier_env *env)
+{
+	u32 i, k, n = 0, len = env->prog->len, orig_len, *new_of, max = 0;
+	struct bpf_insn *buf = NULL, *insn;
+	struct res_item *items = NULL;
+	int ret = 0, before, after;
+
+	if (!env->res_acq_cnt && !env->section_insn_cnt)
+		return 0;
+	new_of = insns_of_pass(env, &orig_len);
+	items = kvcalloc(env->res_acq_cnt + env->res_rel_cnt + env->section_insn_cnt, sizeof(*items),
+			 GFP_KERNEL_ACCOUNT);
+	if (!new_of || !items) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < env->section_insn_cnt; i++)
+		items[n++] = (struct res_item) { new_of[env->section_insns[i].insn], i, ITEM_SECTION };
+	for (i = 0; i < env->res_rel_cnt; i++)
+		items[n++] = (struct res_item) { new_of[env->res_rels[i].insn], i, ITEM_RELEASE,
+						 env->res_rels[i].reg };
+	for (i = 0; i < env->res_acq_cnt; i++)
+		if (!(env->res_acqs[i].flags & BPF_RES_F_CTX))
+			items[n++] = (struct res_item) { new_of[env->res_acqs[i].insn], i, ITEM_ACQUIRE };
+	sort(items, n, sizeof(*items), item_cmp, NULL);
+	for (i = 0; i < n; i = k) {
+		for (k = i; k < n && items[k].idx == items[i].idx; k++)
+			;
+		max = max(max, k - i);
+	}
+	buf = kvcalloc(max * RES_INSNS_MAX + 1, sizeof(*buf), GFP_KERNEL_ACCOUNT);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < n && !ret; i = k) {
+		u32 idx = items[i].idx;
+
+		for (k = i; k < n && items[k].idx == idx; k++)
+			;
+		if (verifier_bug_if(idx >= len || env->prog->insnsi[idx].code != (BPF_JMP | BPF_CALL),
+				    env, "resource kept at insn %d, not a call", idx)) {
+			ret = -EFAULT;
+			break;
+		}
+		after = emit_items(env, &items[i], k - i, buf, &before);
+		/* the call of a subprog in front of it does not move with the call */
+		ret = bpf_adj_moved_insn(&buf[before], before);
+		if (ret)
+			break;
+		/*
+		 * A callee that unwound returns right after the call and goes where
+		 * the unwind_goto says: nothing may come between the two.
+		 */
+		if (after && idx + 1 < len && bpf_is_unwind_goto(&env->prog->insnsi[idx + 1])) {
+			verbose(env, "frame_desc: the call at insn %d acquires a resource and may unwind, which is not supported in a program that throws\n",
+				idx);
+			ret = -EINVAL;
+			break;
+		}
+		if (before) {
+			insn = bpf_patch_list_add(env, idx, buf, before + 1);
+			ret = PTR_ERR_OR_ZERO(insn);
+		}
+		if (!ret && after)
+			ret = bpf_patch_list_insert(env, idx + 1, buf + before + 1, after);
+		env->frame_desc_insns += before + after;
+	}
+	ret = ret ?: bpf_patch_list_commit(env);
+	ret = ret ?: emit_entries(env);
+out:
+	kvfree(buf);
+	kvfree(items);
+	kvfree(new_of);
+	return ret;
+}
+
+/* A stack object may use a referenced object the frame holds as well: it goes first. */
+static bool resource_goes_first(const struct bpf_resource *res)
+{
+	return res->kind == BPF_RESOURCE_ITER || res->kind == BPF_RESOURCE_DYNPTR_FILE;
+}
+
+/*
+ * The frame descriptor of every subprog that has slots: the slot of each of
+ * its acquisitions, which holds the handle of what the acquisition acquired
+ * or NULL, and the counts of its sections. The unwinder releases what the
+ * slots of a frame hold in the order of the entries, within a phase: the
+ * iterators and the readers of file dynptrs come before the references,
+ * which they may be iterating over or reading. Identical descriptors share a
+ * body in the pool of the program, which takes the resource classes over.
+ */
+int bpf_frame_desc_build(struct bpf_verifier_env *env)
+{
+	u32 i, k, n, s, orig_len, *new_of;
+	struct bpf_frame_desc_pool *pool;
+	int res, ret = -ENOMEM;
+
+	if (!env->res_acq_cnt && !env->section_insn_cnt)
+		return 0;
+	new_of = insns_of_pass(env, &orig_len);
+	pool = kvzalloc(struct_size(pool, desc, 0), GFP_KERNEL_ACCOUNT);
+	if (!new_of || !pool) {
+		kvfree(pool);
+		goto out;
+	}
+	env->frame_desc_pool = pool;
+	for (s = 0; s < env->subprog_cnt; s++) {
+		struct bpf_subprog_info *sub = &env->subprog_info[s];
+		struct bpf_frame_desc *d;
+
+		for (i = 0, n = 0; i < env->res_acq_cnt; i++)
+			n += acq_subprog(env, &env->res_acqs[i], new_of) == s;
+		for (k = 0; k < ARRAY_SIZE(sub->section_off); k++)
+			n += !!sub->section_off[k];
+		if (!n)
+			continue;
+		d = kvzalloc(struct_size(d, ent, n), GFP_KERNEL_ACCOUNT);
+		if (!d)
+			goto out;
+		d->size = struct_size(d, ent, n);
+		for (i = 0; i < 2 * env->res_acq_cnt; i++) {
+			const struct bpf_res_acq *a = &env->res_acqs[i % env->res_acq_cnt];
+			bool first = i < env->res_acq_cnt;
+
+			if (acq_subprog(env, a, new_of) != s ||
+			    resource_goes_first(&env->resources[a->res]) != first)
+				continue;
+			d->ent[d->nent++] = (struct bpf_frame_desc_entry) { .res = a->res, .off = a->off };
+		}
+		for (k = 0; k < ARRAY_SIZE(sub->section_off); k++) {
+			if (!sub->section_off[k])
+				continue;
+			res = resource_of_section(env, k);
+			if (res < 0) {
+				kvfree(d);
+				ret = res;
+				goto out;
+			}
+			d->ent[d->nent++] = (struct bpf_frame_desc_entry) {
+				.res = res, .off = sub->section_off[k], .flags = BPF_FRAME_ENT_COUNTER,
+			};
+		}
+		for (i = 0; i < pool->cnt; i++)
+			if (pool->desc[i]->size == d->size && !memcmp(pool->desc[i], d, d->size))
+				break;
+		if (i < pool->cnt) {
+			kvfree(d);
+			sub->frame_desc = i + 1;
+			continue;
+		}
+		pool = kvrealloc(pool, struct_size(pool, desc, pool->cnt + 1), GFP_KERNEL_ACCOUNT);
+		if (!pool) {
+			kvfree(d);
+			goto out;
+		}
+		env->frame_desc_pool = pool;
+		pool->desc[pool->cnt] = d;
+		env->frame_desc_bytes += d->size;
+		sub->frame_desc = ++pool->cnt;
+	}
+	pool->resources = env->resources;
+	pool->resource_cnt = env->resource_cnt;
+	env->frame_desc_bytes += env->resource_cnt * sizeof(*env->resources);
+	env->resources = NULL;
+	ret = 0;
+out:
+	kvfree(new_of);
+	return ret;
+}
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index cc4494aef187..ba1176dc868e 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -462,6 +462,10 @@ static bool join_func(struct bpf_join_state *js, struct bpf_func_state *fd,
 		    fa->entry_rcu_locks != fb->entry_rcu_locks ||
 		    fa->entry_preempt_locks != fb->entry_preempt_locks)
 			return false;
+		/* a frame that left a section of its callers hands its count over, see frame_desc.c */
+		if (env->describe_frames && (fa->rcu_released_below != fb->rcu_released_below ||
+					     fa->preempt_released_below != fb->preempt_released_below))
+			return false;
 		if (!join_loop_stack(fa, fb))
 			return false;
 	}
@@ -523,7 +527,7 @@ static bool join_func(struct bpf_join_state *js, struct bpf_func_state *fd,
 }
 
 /* Things that can't be different in two states that are joined */
-static bool join_check_state(const struct bpf_verifier_state *a,
+static bool join_check_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *a,
 			     const struct bpf_verifier_state *b)
 {
 	int i;
@@ -546,6 +550,16 @@ static bool join_check_state(const struct bpf_verifier_state *a,
 	for (i = 0; i < a->acquired_refs; i++) {
 		if (a->refs[i].type != b->refs[i].type)
 			return false;
+		/*
+		 * The frames of a program that may throw keep the handle of a
+		 * reference in the slot of the call that acquired it, in the frame
+		 * that holds it, see frame_desc.c, and the result keeps those of
+		 * 'a'.
+		 */
+		if (env->describe_frames &&
+		    (a->refs[i].frameno != b->refs[i].frameno || a->refs[i].res != b->refs[i].res ||
+		     (a->refs[i].frameno >= 0 && a->refs[i].acq != b->refs[i].acq)))
+			return false;
 		switch (a->refs[i].type) {
 		case REF_TYPE_PTR:
 		case REF_TYPE_IRQ:
@@ -632,7 +646,7 @@ int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst
 	js->npairs = 0;
 	js->pairs_overflow = false;
 
-	if (!join_check_state(a, b))
+	if (!join_check_state(env, a, b))
 		return 1;
 	err = bpf_copy_verifier_state(dst, a);
 	if (err)
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index efc0870b85c2..8f357fee6104 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -562,8 +562,8 @@ static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *
 	return true;
 }
 
-static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *cur,
-		    struct bpf_idmap *idmap)
+static bool refsafe(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
+		    struct bpf_verifier_state *cur, struct bpf_idmap *idmap)
 {
 	int i;
 
@@ -590,6 +590,19 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
 		    old->refs[i].type != cur->refs[i].type)
 			return false;
+		/*
+		 * The frames of a program that may throw keep the handle of a
+		 * reference in the slot of the call that acquired it, in the frame
+		 * that holds it, see frame_desc.c: a state doesn't stand for one
+		 * that holds the reference as another class, in another frame, or
+		 * from another call. What the callers of a function verified on its
+		 * own hold has no slot in its frames.
+		 */
+		if (env->describe_frames &&
+		    (old->refs[i].frameno != cur->refs[i].frameno ||
+		     old->refs[i].res != cur->refs[i].res ||
+		     (old->refs[i].frameno >= 0 && old->refs[i].acq != cur->refs[i].acq)))
+			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
 			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idmap))
@@ -695,6 +708,10 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	    old->entry_rcu_locks != cur->entry_rcu_locks ||
 	    old->entry_preempt_locks != cur->entry_preempt_locks)
 		return false;
+	/* a frame that left a section of its callers hands its count over, see frame_desc.c */
+	if (env->describe_frames && (old->rcu_released_below != cur->rcu_released_below ||
+				     old->preempt_released_below != cur->preempt_released_below))
+		return false;
 
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
@@ -748,7 +765,7 @@ bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state
 	if (old->unwound != cur->unwound || old->changed_pkt_data != cur->changed_pkt_data)
 		return false;
 
-	if (!refsafe(old, cur, &env->idmap_scratch))
+	if (!refsafe(env, old, cur, &env->idmap_scratch))
 		return false;
 
 	/* for states to be equal callsites have to be the same
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cf3cfc734ed4..4d85a42a18d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -205,13 +205,14 @@ struct bpf_verifier_stack_elem {
 
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id);
 static int __release_reference_nomark(struct bpf_verifier_state *state, int id);
+static void set_release_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
 static int release_reference_nomark(struct bpf_verifier_env *env, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
 static int invalidate_reference(struct bpf_verifier_env *env, int id);
 static u32 reg_lifetime_id(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
-static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env);
+static int invalidate_rcu_protected_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static bool is_tracing_prog_type(enum bpf_prog_type type);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
@@ -812,6 +813,10 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	mark_dynptr_stack_regs(env, &bpf_stack_slot(state, spi)->spilled_ptr,
 			       &bpf_stack_slot(state, spi - 1)->spilled_ptr, type, parent_id);
 
+	/* a referenced dynptr is a stack object the unwinder discards at its address */
+	if (dynptr->type == BPF_DYNPTR_TYPE_INVALID && dynptr_type_referenced(type))
+		return bpf_frame_desc_record_acquire(env, env->cur_state->acquired_refs - 1,
+						     reg - cur_regs(env), false, false);
 	return 0;
 }
 
@@ -1076,7 +1081,9 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 		mark_stack_slot_scratched(env, spi - i);
 	}
 
-	return 0;
+	/* a stack object the unwinder destroys at its address, which the call takes */
+	return bpf_frame_desc_record_acquire(env, env->cur_state->acquired_refs - 1,
+					     reg - cur_regs(env), false, false);
 }
 
 static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
@@ -1094,6 +1101,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
 		if (i == 0) {
+			set_release_reg(env, reg);
 			err = release_reference(env, st->id);
 			if (err)
 				return err;
@@ -1202,7 +1210,9 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 		slot->slot_type[i] = STACK_IRQ_FLAG;
 
 	mark_stack_slot_scratched(env, spi);
-	return 0;
+	/* a stack object the unwinder restores at its address, which the call takes; irqsave may fail */
+	return bpf_frame_desc_record_acquire(env, env->cur_state->acquired_refs - 1,
+					     reg - cur_regs(env), false, kfunc_class == IRQ_LOCK_KFUNC);
 }
 
 static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
@@ -1239,6 +1249,17 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 		return -EINVAL;
 	}
 
+	/* the frame descriptors take the flags out of their slot, see frame_desc.c */
+	set_release_reg(env, reg);
+	for (i = 0; i < env->cur_state->acquired_refs; i++) {
+		if (env->cur_state->refs[i].type != REF_TYPE_IRQ ||
+		    env->cur_state->refs[i].id != st->id)
+			continue;
+		err = bpf_frame_desc_record_release(env, i);
+		if (err)
+			return err;
+		break;
+	}
 	err = release_irq_state(env, st->id);
 	WARN_ON_ONCE(err && err != -EACCES);
 	if (err) {
@@ -3715,6 +3736,25 @@ static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
 	}
 }
 
+/*
+ * A frame of a program that may throw keeps the address of an iterator and of
+ * saved IRQ flags it holds in a hidden slot, and the unwinder destroys or
+ * restores what is at the address, see frame_desc.c: the program may not write
+ * over one. Without a throw, the leak such a write leaves refuses the program
+ * at its exit.
+ */
+static int check_stack_object_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
+				    int spi)
+{
+	u8 type = bpf_stack_slot(state, spi)->slot_type[BPF_REG_SIZE - 1];
+
+	if (!env->describe_frames || (type != STACK_ITER && type != STACK_IRQ_FLAG))
+		return 0;
+	verbose(env, "cannot write over %s in a program that throws\n",
+		type == STACK_ITER ? "an iterator" : "saved irq flags");
+	return -EINVAL;
+}
+
 static void scrub_special_slot(struct bpf_func_state *state, int spi)
 {
 	struct bpf_stack_state *slot = bpf_stack_slot(state, spi);
@@ -3784,7 +3824,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			env->insn_aux_data[insn_idx].nospec_result = true;
 	}
 
-	err = destroy_if_dynptr_stack_slot(env, state, spi);
+	err = check_stack_object_write(env, state, spi);
+	err = err ?: destroy_if_dynptr_stack_slot(env, state, spi);
 	if (err)
 		return err;
 
@@ -3886,6 +3927,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	    (!value_reg && is_bpf_st_mem(insn) && insn->imm == 0))
 		writing_zero = true;
 
+	for (i = bpf_get_spi(max_off - 1); i <= bpf_get_spi(min_off); i++) {
+		if (i >= bpf_stack_nr_slots(state))
+			break;
+		err = check_stack_object_write(env, state, i);
+		if (err)
+			return err;
+	}
 	err = destroy_dynptrs_in_stack_slots(env, state, bpf_get_spi(max_off - 1),
 					     bpf_get_spi(min_off));
 	if (err)
@@ -8472,6 +8520,11 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			verbose(env, "Failed to acquire lock state\n");
 			return err;
 		}
+		/* the unwinder releases the lock at the address the call takes; a res lock may fail */
+		err = bpf_frame_desc_record_acquire(env, cur->acquired_refs - 1,
+						    reg - cur_regs(env), false, is_res_lock);
+		if (err)
+			return err;
 	} else {
 		void *ptr;
 		int type;
@@ -8518,6 +8571,14 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 				"Release nested locks in the reverse order they were acquired.", lock);
 			return -EINVAL;
 		}
+		/* the frame descriptors take the lock out of its slot, see frame_desc.c */
+		set_release_reg(env, reg);
+		lock = find_lock_state(cur, type, reg->id, ptr);
+		if (lock) {
+			err = bpf_frame_desc_record_release(env, lock - cur->refs);
+			if (err)
+				return err;
+		}
 		if (release_lock_state(env, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
 			bpf_diag_lock(
@@ -8533,8 +8594,11 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 		 */
 		invalidate_non_owning_refs(env);
 
-		if (!in_rcu_cs(env))
-			invalidate_rcu_protected_refs(env);
+		if (!in_rcu_cs(env)) {
+			err = invalidate_rcu_protected_refs(env);
+			if (err)
+				return err;
+		}
 	}
 	return 0;
 }
@@ -11108,11 +11172,32 @@ static int __release_reference_nomark(struct bpf_verifier_state *state, int id)
 	return -EINVAL;
 }
 
+/*
+ * The current call releases what its argument @reg holds or points to: the
+ * frame descriptors take the handle from that argument, see frame_desc.c. An
+ * argument passed on the stack has no register.
+ */
+static void set_release_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
+{
+	const struct bpf_reg_state *regs = cur_regs(env);
+
+	env->release_regno = reg >= regs && reg < regs + MAX_BPF_REG ? reg - regs : -1;
+}
+
 static int release_reference_nomark(struct bpf_verifier_env *env, int id)
 {
-	int err;
+	struct bpf_verifier_state *state = env->cur_state;
+	int i, err;
 
-	err = __release_reference_nomark(env->cur_state, id);
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_PTR || state->refs[i].id != id)
+			continue;
+		err = bpf_frame_desc_record_release(env, i);
+		if (err)
+			return err;
+		break;
+	}
+	err = __release_reference_nomark(state, id);
 	if (!err)
 		bpf_diag_record_ref_release(env, env->insn_idx, id);
 	return err;
@@ -11213,9 +11298,13 @@ static int invalidate_reference(struct bpf_verifier_env *env, int id)
 
 static int release_reference(struct bpf_verifier_env *env, int id)
 {
-	if (find_reference_state(env->cur_state, id))
-		WARN_ON_ONCE(release_reference_nomark(env, id));
+	int err;
 
+	if (find_reference_state(env->cur_state, id)) {
+		err = release_reference_nomark(env, id);
+		if (err)
+			return err;
+	}
 	return invalidate_reference(env, id);
 }
 
@@ -11232,21 +11321,34 @@ static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 	}));
 }
 
-static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
+static int invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
 {
 	struct bpf_stack_state *stack;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 	u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
+	bool iter = false;
 
 	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, clear_mask, ({
 		if (reg->type & MEM_RCU) {
+			iter |= stack && stack->slot_type[BPF_REG_SIZE - 1] == STACK_ITER;
 			bpf_diag_mod_begin(env, reg, NULL, BPF_DIAG_MOD_WRITE);
 			reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL | NON_OWN_REF);
 			reg->type |= PTR_UNTRUSTED;
 			bpf_diag_mod_end(env);
 		}
 	}));
+	/*
+	 * Nothing may destroy an RCU protected iterator once its section ended:
+	 * not the program, which is refused when it leaks one, and not the
+	 * unwinder, which destroys what a frame holds at a throw, see
+	 * frame_desc.c.
+	 */
+	if (iter && env->describe_frames) {
+		verbose(env, "an RCU protected iterator may not outlive its section in a program that throws\n");
+		return -EINVAL;
+	}
+	return 0;
 }
 
 static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 id)
@@ -11776,6 +11878,10 @@ static int exit_func_on_its_own(struct bpf_verifier_env *env)
 	if (err)
 		return err;
 
+	/* what the function returns with is its caller's from here on */
+	err = bpf_frame_desc_record_exit(env);
+	if (err)
+		return err;
 	account_current_path(env);
 	err = bpf_flow_exit(env, state, env->insn_idx);
 	return err ?: PROCESS_BPF_EXIT;
@@ -11896,6 +12002,16 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 		if (caller->refs[i].type == REF_TYPE_PTR)
 			caller->refs[i].parent_id = fresh_id(env, idmap, caller->refs[i].parent_id);
 		caller->refs[i].frameno = caller->curframe;
+		/* the call acquired it for the caller, see frame_desc.c */
+		err = bpf_frame_desc_record_return(env, caller, i, call_idx, &frame->regs[BPF_REG_0]);
+		if (err)
+			return err;
+	}
+	if (nheld == caller->acquired_refs) {
+		err = bpf_frame_desc_record_return(env, caller, -1, call_idx,
+						   &callee->regs[BPF_REG_0]);
+		if (err)
+			return err;
 	}
 	caller->active_irq_id = fresh_id(env, idmap, caller->active_irq_id);
 	caller->active_lock_id = fresh_id(env, idmap, caller->active_lock_id);
@@ -12620,7 +12736,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
 	u32 i, nregs;
-	int err;
+	int err, handed;
 
 	callee = state->frame[state->curframe];
 	r0 = &callee->regs[BPF_REG_0];
@@ -12702,9 +12818,26 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	invalidate_stack_slices(env, callee->frameno, INT_MIN, 0);
 
 	/* What the frame holds when it returns is the caller's to release. */
-	for (i = 0; i < state->acquired_refs; i++)
-		if (state->refs[i].frameno == callee->frameno)
-			state->refs[i].frameno = caller->frameno;
+	err = bpf_frame_desc_record_exit(env);
+	if (err)
+		return err;
+	for (i = 0, handed = -1; i < state->acquired_refs; i++) {
+		if (state->refs[i].frameno != callee->frameno)
+			continue;
+		state->refs[i].frameno = caller->frameno;
+		handed = i;
+		/* the call acquired it for the caller, see frame_desc.c */
+		err = bpf_frame_desc_record_return(env, state, i, callee->callsite,
+						   &callee->regs[BPF_REG_0]);
+		if (err)
+			return err;
+	}
+	if (handed < 0 && !callee->in_callback_fn) {
+		err = bpf_frame_desc_record_return(env, state, -1, callee->callsite,
+						   &callee->regs[BPF_REG_0]);
+		if (err)
+			return err;
+	}
 
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit.
@@ -12723,9 +12856,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	account_processed_insns(env, callee, caller);
 	/* clear everything in the callee. In case of exceptional exits using
 	 * bpf_throw, this will be done by do_check_block() for extra frames. */
-	free_func_state(callee);
 	state->frame[state->curframe--] = NULL;
 	invalidate_outgoing_stack_args(env, caller);
+	free_func_state(callee);
 	return 0;
 }
 
@@ -12877,6 +13010,14 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 	for (i = 0; i < state->acquired_refs; i++) {
 		if (state->refs[i].type != REF_TYPE_PTR)
 			continue;
+		/*
+		 * The unwinder releases what the slots of the frames hold, see
+		 * frame_desc.c: every reference but one of a class it cannot
+		 * release, which no slot holds.
+		 */
+		if (exception_exit && bpf_jit_supports_exception_cleanup() &&
+		    (state->refs[i].res || state->speculative))
+			continue;
 		/* Allow struct_ops programs to return a referenced kptr back to
 		 * kernel. Type checks are performed later in check_return_code.
 		 */
@@ -13093,6 +13234,8 @@ static int release_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	if (bpf_register_is_null(reg))
 		return 0;
 
+	set_release_reg(env, reg);
+
 	if (release_dynptr)
 		err = unmark_stack_slots_dynptr(env, reg);
 	else if (convert_rcu)
@@ -13534,6 +13677,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return id;
 
 		regs[BPF_REG_0].id = id;
+		/* the unwinder releases the pointer the call returns */
+		err = bpf_frame_desc_record_acquire(env, env->cur_state->acquired_refs - 1,
+						    BPF_REG_0, true, false);
+		if (err)
+			return err;
+	} else {
+		/* the same call may acquire on another visit, see frame_desc.c */
+		bpf_frame_desc_record_none(env, &regs[BPF_REG_0]);
 	}
 
 	if (func_id == BPF_FUNC_dynptr_data)
@@ -14931,8 +15082,11 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (err)
 			return err;
 
-		if (!in_rcu_cs(env))
-			invalidate_rcu_protected_refs(env);
+		if (!in_rcu_cs(env)) {
+			err = invalidate_rcu_protected_refs(env);
+			if (err)
+				return err;
+		}
 	}
 	return 0;
 }
@@ -14958,14 +15112,15 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 	return 0;
 }
 
-static void ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 id)
+static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 id)
 {
 	struct bpf_func_state *unused;
 	struct bpf_reg_state *reg;
 	int err;
 
 	err = release_reference_nomark(env, id);
-	WARN_ON_ONCE(err);
+	if (err)
+		return err;
 
 	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
 		if (reg->id == id) {
@@ -14974,7 +15129,7 @@ static void ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 id)
 		}
 	}));
 
-	return;
+	return 0;
 }
 
 /* Implementation details:
@@ -16001,11 +16156,24 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name);
 
+/*
+ * A tracing program may run in NMI context, where the destructors of some
+ * fields cannot run: bpf_obj_drop() is refused there on a type that has them.
+ */
+bool bpf_nmi_unsafe_prog(struct bpf_verifier_env *env)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
+
+	return is_tracing_prog_type(prog_type) ||
+	       /* is_tracing_prog_type() for now doesn't cover non-iterator tracing progs. */
+	       (prog_type == BPF_PROG_TYPE_TRACING &&
+		env->prog->expected_attach_type != BPF_TRACE_ITER && !env->prog->sleepable);
+}
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
 	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
-	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	struct bpf_reg_state *regs = cur_regs(env);
 	const char *func_name, *ptr_type_name;
 	const struct btf_type *t, *ptr_type;
@@ -16123,10 +16291,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return err;
 
 	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
-	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_type(prog_type) ||
-	     /* is_tracing_prog_type() for now doesn't cover non-iterator tracing progs. */
-	     (prog_type == BPF_PROG_TYPE_TRACING && env->prog->expected_attach_type != BPF_TRACE_ITER
-	      && !env->prog->sleepable))) {
+	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && bpf_nmi_unsafe_prog(env)) {
 		struct btf_struct_meta *struct_meta;
 
 		struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
@@ -16183,6 +16348,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	preempt_disable = is_kfunc_bpf_preempt_disable(&meta);
 	preempt_enable = is_kfunc_bpf_preempt_enable(&meta);
 
+	/* the descriptors may count the sections of the frame in a hidden slot */
+	if (rcu_lock || rcu_unlock || preempt_disable || preempt_enable) {
+		err = bpf_frame_desc_record_section(env, rcu_lock || rcu_unlock ? 0 : 1,
+						    rcu_lock || preempt_disable ? 1 : -1);
+		if (err)
+			return err;
+	}
 	if (rcu_lock) {
 		env->cur_state->active_rcu_locks++;
 		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_RCU, true,
@@ -16199,8 +16371,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		release_context_state(env->cur_state);
 		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_RCU, false,
 					env->cur_state->active_rcu_locks);
-		if (!in_rcu_cs(env))
-			invalidate_rcu_protected_refs(env);
+		if (!in_rcu_cs(env)) {
+			err = invalidate_rcu_protected_refs(env);
+			if (err)
+				return err;
+		}
 	} else if (preempt_disable) {
 		env->cur_state->active_preempt_locks++;
 		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_PREEMPT, true,
@@ -16217,8 +16392,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		release_context_state(env->cur_state);
 		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_PREEMPT, false,
 					env->cur_state->active_preempt_locks);
-		if (!in_rcu_cs(env))
-			invalidate_rcu_protected_refs(env);
+		if (!in_rcu_cs(env)) {
+			err = invalidate_rcu_protected_refs(env);
+			if (err)
+				return err;
+		}
 	}
 
 	if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
@@ -16247,7 +16425,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		id = regs[BPF_REG_2].id;
 		insn_aux->insert_off = regs[BPF_REG_2].var_off.value;
 		insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
-		ref_convert_owning_non_owning(env, id);
+		/* the node goes to the list or the tree: the second argument is released */
+		set_release_reg(env, &regs[BPF_REG_2]);
+		err = ref_convert_owning_non_owning(env, id);
+		if (err)
+			return err;
 	}
 
 	if ((is_kfunc_call(&meta, special_kfunc_list[KF_bpf_dynptr_slice]) ||
@@ -16461,6 +16643,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			if (id < 0)
 				return id;
 			regs[BPF_REG_0].id = id;
+			/* the unwinder releases the pointer the call returns */
+			err = bpf_frame_desc_record_acquire(env, env->cur_state->acquired_refs - 1,
+							    BPF_REG_0, true, false);
+			if (err)
+				return err;
 		} else if (is_rbtree_node_type(ptr_type) || is_list_node_type(ptr_type)) {
 			ref_set_non_owning(env, &regs[BPF_REG_0]);
 		}
@@ -20864,10 +21051,12 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 	 * prepare_func_exit to handle the case when
 	 * state->curframe > 0, it may be a callback function,
 	 * for which reference_state must match caller reference
-	 * state when it exits.
+	 * state when it exits. An unwinder that releases resources
+	 * leaves locks and sections too.
 	 */
 	int err = check_resource_leak(env, exception_exit,
-				      exception_exit || !env->cur_state->curframe,
+				      exception_exit ? !bpf_jit_supports_exception_cleanup() :
+				      !env->cur_state->curframe,
 				      exception_exit ? "bpf_throw" :
 				      "BPF_EXIT instruction in main prog");
 	if (err)
@@ -21155,7 +21344,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 				      insn->imm != BPF_FUNC_spin_unlock &&
 				      insn->imm != BPF_FUNC_kptr_xchg) ||
 				     (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
-				      !kfunc_spin_allowed(env, insn->imm, insn->off)))) {
+				      !kfunc_spin_allowed(env, insn->imm, insn->off) &&
+				      !(bpf_is_throw_kfunc(insn) && bpf_jit_supports_exception_cleanup())))) {
 					verbose(env,
 						"function calls are not allowed while holding a lock\n");
 					bpf_diag_ctx_active(
@@ -23335,6 +23525,12 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 				goto out;
 
 			aux->ctx_arg_info[i].ref_id = ret;
+			/* the kernel passed it: the main program holds it from its entry */
+			if (!ret)
+				continue;
+			ret = bpf_frame_desc_record_ctx_arg(env, state->acquired_refs - 1, i);
+			if (ret)
+				goto out;
 		}
 	}
 
@@ -23475,6 +23671,7 @@ static int do_check_all(struct bpf_verifier_env *env)
 		bpf_vlog_reset(&env->log, min(log_pos, env->log.end_pos));
 		for (i = 0; i < env->prog->len; i++)
 			env->insn_aux_data[i].seen = 0;
+		bpf_frame_desc_reset(env);
 		for (i = 1; env->prog->aux->func_info && i < env->subprog_cnt; i++) {
 			sub_aux = subprog_aux(env, i);
 			memset(sub_aux->called, 0, sizeof(sub_aux->called));
@@ -23544,6 +23741,11 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		env->insn_processed,
 		env->max_states_per_insn, env->total_states,
 		env->peak_states);
+	if (env->log.level & BPF_LOG_STATS)
+		verbose(env, "frame descriptors: slots %u insns %u classes %u bytes %u\n",
+			env->frame_desc_slots, env->frame_desc_insns,
+			env->frame_desc_pool ? env->frame_desc_pool->resource_cnt : env->resource_cnt,
+			env->frame_desc_bytes);
 }
 
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
@@ -25485,6 +25687,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = bpf_check_cfg(env);
 	if (ret < 0)
 		goto skip_full_check;
+	/*
+	 * A program that may throw keeps what its frames hold in slots the
+	 * unwinder releases, see frame_desc.c, where the architecture has the
+	 * entry the unwinder needs; elsewhere it throws holding nothing.
+	 */
+	for (i = 0; bpf_jit_supports_exception_cleanup() && i < env->subprog_cnt; i++)
+		env->describe_frames |= env->subprog_info[i].might_throw;
 
 	ret = check_unwind_insns(env);
 	if (ret < 0)
@@ -25600,6 +25809,21 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
 
+	/*
+	 * The pass has seen what every frame holds and the stack is final:
+	 * reserve the slots the frames keep their handles in and emit the insns
+	 * that keep them up to date, with the insns still those the main pass
+	 * recorded.
+	 */
+	if (ret == 0)
+		ret = bpf_frame_desc_resolve(env);
+	if (ret == 0)
+		ret = bpf_frame_desc_emit(env);
+
+	/* Account for the slots reserved by frame descriptor resolution. */
+	if (ret == 0)
+		ret = check_max_stack_depth(env);
+
 	/* instruction rewrites happen after this point */
 	if (ret == 0)
 		ret = bpf_optimize_bpf_loop(env);
@@ -25641,6 +25865,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 								     : false;
 	}
 
+	if (ret == 0)
+		ret = bpf_frame_desc_build(env);
+
 	if (ret == 0)
 		ret = bpf_fixup_call_args(env);
 
@@ -25756,6 +25983,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		kfree(env->func_sets[i]);
 	kfree(env->func_sets);
 	kvfree(env->stack_inits);
+	bpf_frame_desc_env_free(env);
 	bpf_diag_free(env);
 	kvfree(env->idoms);
 	kvfree(env);
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 22503cf62e9f..f02882224a03 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -133,6 +133,7 @@ __noinline static int subprog_lock(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__arch_s390x
 __failure __msg("function calls are not allowed while holding a lock")
 int reject_with_lock(void *ctx)
 {
@@ -142,6 +143,7 @@ int reject_with_lock(void *ctx)
 }
 
 SEC("?tc")
+__arch_s390x
 __failure __msg("function calls are not allowed while holding a lock")
 int reject_subprog_with_lock(void *ctx)
 {
@@ -149,6 +151,7 @@ int reject_subprog_with_lock(void *ctx)
 }
 
 SEC("?tc")
+__arch_s390x
 __failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_with_rcu_read_lock(void *ctx)
 {
@@ -165,6 +168,7 @@ __noinline static int throwing_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__arch_s390x
 __failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_subprog_with_rcu_read_lock(void *ctx)
 {
@@ -181,7 +185,8 @@ static bool rbless(struct bpf_rb_node *n1, const struct bpf_rb_node *n2)
 }
 
 SEC("?tc")
-__failure __msg("function calls are not allowed while holding a lock")
+__arch_x86_64 __arch_arm64
+__failure __msg("cannot be called from callback subprog")
 int reject_with_rbtree_add_throw(void *ctx)
 {
 	struct foo *f;
@@ -196,6 +201,7 @@ int reject_with_rbtree_add_throw(void *ctx)
 }
 
 SEC("?tc")
+__arch_s390x
 __failure __msg("Unreleased reference")
 int reject_with_reference(void *ctx)
 {
@@ -216,6 +222,7 @@ __noinline int global_subprog_may_throw(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__arch_s390x
 __failure __msg("Unreleased reference")
 int reject_global_subprog_throw_with_reference(struct __sk_buff *ctx)
 {
@@ -248,7 +255,8 @@ __noinline static int subprog_cb_ref(u32 i, void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference")
+__arch_x86_64 __arch_arm64
+__failure __msg("cannot be called from callback subprog")
 int reject_with_cb_reference(void *ctx)
 {
 	struct foo *f;
@@ -270,6 +278,7 @@ int reject_with_cb(void *ctx)
 }
 
 SEC("?tc")
+__arch_s390x
 __failure __msg("Unreleased reference")
 int reject_with_subprog_reference(void *ctx)
 {
@@ -417,6 +426,7 @@ __noinline static int rcu_lock_then_throw(void)
 }
 
 SEC("?tc")
+__arch_s390x
 __failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_subprog_rcu_lock_throw(void *ctx)
 {
@@ -425,6 +435,7 @@ int reject_subprog_rcu_lock_throw(void *ctx)
 }
 
 SEC("?tc")
+__arch_s390x
 __failure __msg("bpf_throw cannot be used inside bpf_preempt_disable-ed region")
 int reject_subprog_throw_preempt_lock(void *ctx)
 {
@@ -435,6 +446,7 @@ int reject_subprog_throw_preempt_lock(void *ctx)
 }
 
 SEC("?tc")
+__arch_s390x
 __failure __msg("bpf_throw cannot be used inside bpf_local_irq_save-ed region")
 int reject_subprog_throw_irq_lock(void *ctx)
 {
-- 
2.53.0

