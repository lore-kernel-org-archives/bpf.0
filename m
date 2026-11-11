Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401872;
	b=ES0f9fLJWYPOfphPYO6AV3VUtyCf48zIE7ZK5xfJx+Rox0QTH/CcwlKG4B4Vep06HpII
	 gHtMx0wFr5yRyGVyDTgaE4/VU46x1wef9Ld7KtkRl6lSZo54ABL0Eio74boyyHEe44vO1
	 SessheZyh/yPL2QFP4rMhRqmug7xa4S79X4tWuw/mTxo9C6y+jZxXggLpfrrUDlKxyShJ
	 z8WezAYpRbeZAGeIkG3xoc56neUCYSoSjdc/bsPQ3L/Th36sYZfWoRk2KTWKGy+9t6Rl6
	 85HZtDnH17chMuvQoshzsto7jpjH4B4W4dn0sZgpAbN8S5SIyiblI6OfPUBITFcbMYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=XeyXVnJBTlXJG/eAGi296N+kUZY8wzPxrrjfOJju/n8=;
	b=MUSer8+INMIa1gaNXjfPWfqy5ZI5nydJfM0VsYZf6GYpZ0cxpO9/QjBVOrHR3PuRcoN0
	 EVj+7Lc+I7WsWZk4dK0NJRnsJ/QH74XQAM0Lbf8otVyxAi1QvkPRCeDLfPqSe/J6BHI9K
	 wq2ircgIT2xGUOVlMO811AjvnTZ5NgLAmgk54GPMI2yfYJy0c7jhR5BbMI/8a0rKg4A3L
	 X84TAm9m4nXr9KernxlFLoHHGgyIm4HZhf5oSCYM9cQnW2mnavvNGEPDXeLj8IkfcJqoj
	 4ztmaSZbwRYcabYnatJNy0k11Ii9X3c/f6upUtYwSH0iVjdrckjqa33FXfPHL7/uK9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oDTznCMy;
	arc=none smtp.remote-ip=74.125.225.71
Received: from mail-wr2-f7.google.com (mail-wr2-f7.google.com [74.125.225.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DE606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 742DE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oDTznCMy
Received: by mail-wr2-f7.google.com with SMTP id ffacd0b85a97d-48e0c9bc8f9so1412690f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401870; x=1795006670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XeyXVnJBTlXJG/eAGi296N+kUZY8wzPxrrjfOJju/n8=;
        b=oDTznCMyeZCktAXBGTq8A1ze+I7eM4SCtJcDnJ+WhkpVC72dJ2xcAHSq+LYXuj9vPM
         msy0CqaavgPZSWb0VeWug4nplyjI8YW31PZfOFGlDTMiGSNXPfOPIkmNw6DW1ow8a4Bb
         TTa9xmoMzlo4tAoJsMVXiwzqrdpTP8XIwKq8L9bXwaIPFxv6r5wGTFQpFZJOvflffHbh
         lTaX7VJ2aXNbb5DO04iFOTRrtb4FGreivOl6qZetgJ1OffAkqxkC901k02sFcC4BVGqY
         cJKa8MY/hwTWyxIv9KpIPgHU3OecTZf6SDs26ESUfeaAYVXyU+a6uXvTqVezJ0vTuWc4
         26xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401870; x=1795006670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XeyXVnJBTlXJG/eAGi296N+kUZY8wzPxrrjfOJju/n8=;
        b=Zg4+AeDDWdWNGds+EuDOEyUTX+AwyOYWd6eHlT32S1c3f1v5Be8XVF4BQ8eyza3hf8
         apQC0rGDlxCfm+JSY30jLDRPRNC+6Ps/MnoneG3OpXjdgwSS71ZiqjCCmbleYz98ym7c
         +k7WGHAwHULlc4Lj5EqOVqWSBmppjPOG95ftsVMizDT+d2UNCoXjKaDkechZzPdZuo9N
         Fwb3cJ+cNARDbBxFJifo+rEeYneCb27+fIZo3bdkEtIEq8VNQ7All97d7VC1ftkIkc2e
         /4s6UR+F6MIQSVG4uZILPkdTEqlVF4HAj4jkNsmO6XbXCqlCmXvr9aU/+v25a6c4eSAu
         P1DA==
X-Gm-Message-State: APuU4Z/ogRYxxdQvM62qk55ryREDYn6gALAHD6hG1D64T5SDZom1K9eh
	VAh1iyfIwTLIyJF+JXw4+oW7O9LD5GkqqBCTjL+HMGg+8vpd5SfUjnVgR73qe4Z/BbA=
X-Gm-Gg: AYBFou2m2uKiiaYTZJ1h8sfAix/vwGU75DyDTrmbCop+L8MGDvb8MhqPwpdSf26E8f7
	RAknHG4yQF2LuMlnGcmw3jMwSyHL3t/Oq5gJyPjOEIzoIXQwkQ/EBAA4J1M+eXmiaJnyqvk3VGx
	J6qW6Jur46caTq1AC5TnUUm4CNfi3sbLyKk0nVhvcqWgXwtGB6pn45jaWtYFCN8PbCCh2S7IK/R
	DknyCuegQMAHvpl9+xIR9I6IwI4rEHZH0/NbscnvrVgaU1KtIEX/ptK06dg/gZNXpkfD2TVgelX
	UpUS0ZLYd7amPMRKF7vBIvTol4vDL426l+IQE/USdpzlnF8couJjjcTJ6knJozhLt3wfk9ODvfM
	PL6I0dNXRQf0IMvB1+tPJDfPtfVrA/9Sf1NI/GHwIjVMoAUbbOP8fW0E14an1Uv385xlB8g0X8E
	nxdK1B6ekIvQCH8w4ZLxe71f9lHlcZsnYy09MYSkbkDsgs5mdtC0uJCNCtqjPLWhRmb0eFSkY0K
	pSFAets5ECKQMmgTnlGFrLsGs6zNad3nSi7n7YTT0MMzygn3I3WR5xmjk+X2mJIfsPnyPjVm8Ia
	dIT20Kb5cF6a4tWo7pUBLdWrYIMn0aAJPk4M3zKAFCj92D5nzKFYEroLP0zALEXTQHFabit5v0q
	qO4gviyruvs5DxzmP0d6xRWdZ+S7bxL9v4n90UxMFBbwgse/dWykXa0eAVg3DyyjQoQxG
X-Received: by 2002:a5d:5f05:0:b0:48e:6092:dea1 with SMTP id ffacd0b85a97d-499ca377c20mr3714304f8f.47.1794401869535;
        Wed, 11 Nov 2026 04:57:49 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbeedsm10845473f8f.43.2026.11.11.04.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:48 -0800 (PST)
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
Subject: [PATCH bpf-next v1 12/29] bpf: Release resources in hidden slots on bpf_throw()
Date: Wed, 11 Nov 2026 13:57:10 +0100
Message-ID: <06579bd381e516e66f97d7b0c00e55d019011a7e.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=22742; i=memxor@gmail.com; h=from:subject:message-id; bh=PZc5cO6g+ACwoPNDB2ryA22L6iQiqx6su9dUrUkFR8g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzHzjiPjFF+U5LXf8z/iy+rH6+01zBb/v/KlY8nt/2 LzDHAeXdZSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAik+0Y/tfd07qSG+ysLitd 0hY+zWrxDL/9ZRycgluSdA5W+3uf8WZkeJbslS22JPmevxJTMnN7ZAHv7cv2W7m0ZdkWff2ndli SFwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently bpf_throw() is only allowed where the program holds no
resources. The frames between the throw and the main program are
discarded without releasing anything, so the verifier rejects a throw
that is reached with a reference, a lock, or a section held.

Add the runtime half of releasing the resources of these frames. A frame
will keep the handles of the kernel resources it holds in hidden stack
slots, which the verifier maintains from the next patch on. A handle is
the value that the release takes: a pointer to an object, a ringbuf
record or a lock, or the address of an iterator or of saved IRQ flags on
the stack.

A frame descriptor lists the hidden slots in the frames of one JITed
function:

 - Each entry gives the offset of a slot from the frame's R10 and the
   resource class of the handle in it. An empty slot holds 0.
 - A resource class says how to release a handle: the kind of resource,
   and the destructor or the struct meta of the object.
 - RCU read and preemption disabled sections have no handle. A frame
   counts the sections it entered in one slot per kind.

The descriptors and resource classes of a program live in a pool owned by
the main program. Each JITed function refers to its descriptor by index,
and identical descriptors are shared.

bpf_throw() releases the resources in the slots of each frame before it
walks the stack for the exception callback. The release order is the same
for all frames, so the frames are walked once per phase:

 1. locks and IRQ flags;
 2. objects whose destructor needs RCU protection;
 3. the sections, using counts that the first walk summed over the
    frames;
 4. all other objects.

In the first phase, IRQ flags that a frame saved while interrupts were
enabled are restored last. Every later save found interrupts disabled, so
a frame has at most one such set, and the locks and the other flags can
be released in any order before it.

The unwinder releases a socket with bpf_sk_release(), and the reader of a
file dynptr with the function that bpf_dynptr_file_discard() frees it
with. So bpf_sk_release_proto is no longer static, and that function
becomes bpf_dynptr_file_free().

Nothing generates descriptors yet, so nothing is released and the
verifier's rules do not change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  91 +++++++++++++
 include/linux/bpf_verifier.h |   4 +
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/core.c            |   1 +
 kernel/bpf/fixups.c          |   3 +
 kernel/bpf/helpers.c         |  17 ++-
 kernel/bpf/unwind.c          | 243 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   5 +
 net/core/filter.c            |   2 +-
 9 files changed, 364 insertions(+), 4 deletions(-)
 create mode 100644 kernel/bpf/unwind.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 17b13b16899d..e7cce9080531 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1829,6 +1829,72 @@ struct bpf_jit_poke_descriptor {
 	u32 insn_idx;
 };
 
+/*
+ * Frame descriptors: the hidden stack slots in which the frames of a function
+ * keep the handles of what they hold, and how the unwinder releases them, see
+ * kernel/bpf/frame_desc.c.
+ */
+/* Kinds of resources the unwinder can release. */
+enum bpf_resource_kind {
+	BPF_RESOURCE_OBJ,		/* bpf_obj_new() object: bpf_obj_drop_impl(p, meta) */
+	BPF_RESOURCE_PERCPU_OBJ,	/* bpf_percpu_obj_new() object: bpf_percpu_obj_drop_impl() */
+	BPF_RESOURCE_KPTR,		/* referenced kernel object: the BTF registry's dtor(p) */
+	BPF_RESOURCE_SOCK,		/* socket acquired by a helper: bpf_sk_release() */
+	BPF_RESOURCE_RINGBUF,		/* ringbuf record, also of a dynptr: bpf_ringbuf_discard() */
+	BPF_RESOURCE_DYNPTR_FILE,	/* reader of a file dynptr: bpf_dynptr_file_free() */
+	BPF_RESOURCE_ITER,		/* open-coded iterator on the stack: its destroy kfunc */
+	BPF_RESOURCE_SPIN_LOCK,		/* bpf_spin_lock() held: bpf_spin_unlock() */
+	BPF_RESOURCE_RES_LOCK,		/* bpf_res_spin_lock() held: bpf_res_spin_unlock() */
+	BPF_RESOURCE_IRQ_FLAG,		/* saved IRQ flags on the stack: bpf_local_irq_restore() */
+	BPF_RESOURCE_RCU,		/* bpf_rcu_read_lock() sections: unlock each */
+	BPF_RESOURCE_PREEMPT,		/* bpf_preempt_disable() sections: enable each */
+};
+
+/* A resource class of a program; descriptor entries refer to it by index. */
+struct bpf_resource {
+	u8 kind;	/* enum bpf_resource_kind */
+	bool sleeps;	/* the destructor may sleep */
+	bool rcu;	/* the destructor needs RCU protection */
+	u32 btf_id;
+	struct btf *btf;
+	union {
+		void (*dtor)(void *);
+		struct btf_struct_meta *meta;
+	};
+};
+
+/*
+ * The slot holds a count of sections instead of a handle, signed: the
+ * sections the frame entered less those of its callers it left.
+ */
+#define BPF_FRAME_ENT_COUNTER	BIT(0)
+
+/*
+ * One hidden slot of a frame: it holds the handle of a resource of the class
+ * the frame holds, or 0. The handle is what the release takes: the pointer
+ * to an object, to a ringbuf record or to a lock, or the address of an
+ * iterator or of saved IRQ flags on the stack of some frame.
+ */
+struct bpf_frame_desc_entry {
+	u16 res;	/* index into the program's resource classes */
+	s16 off;	/* the slot, relative to the frame pointer */
+	u16 flags;
+};
+
+struct bpf_frame_desc {
+	u32 size;	/* total size in bytes, including this header */
+	u32 nent;	/* number of entries that follow */
+	struct bpf_frame_desc_entry ent[];
+};
+
+/* Owned by the main program and shared by its subprograms. */
+struct bpf_frame_desc_pool {
+	u32 cnt;
+	u32 resource_cnt;
+	struct bpf_resource *resources;
+	struct bpf_frame_desc *desc[];
+};
+
 /* reg_type info for ctx arguments */
 struct bpf_ctx_arg_aux {
 	u32 offset;
@@ -2053,6 +2119,14 @@ struct bpf_prog_aux {
 	struct module *mod;
 	u32 num_exentries;
 	struct exception_table_entry *extable;
+	/*
+	 * The frame descriptor of this JITed function in the pool of the main
+	 * program, plus one, or 0: the hidden slots its frames keep the handles
+	 * of their resources in, see frame_desc.c. The main and sub progs share
+	 * the pool, which is freed with the main prog only.
+	 */
+	u32 frame_desc;
+	struct bpf_frame_desc_pool *frame_desc_pool;
 	union {
 		struct work_struct work;
 		struct rcu_head	rcu;
@@ -2999,6 +3073,12 @@ void bpf_obj_free_task_work(const struct btf_record *rec, void *obj);
 void bpf_obj_cancel_fields(struct bpf_map *map, void *obj);
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
+void bpf_obj_drop_impl(void *p__alloc, void *meta__ign);
+void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign);
+void bpf_rcu_read_unlock(void);
+void bpf_preempt_enable(void);
+void bpf_local_irq_restore(unsigned long *flags__irq_flag);
+void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock);
 
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
@@ -4218,6 +4298,7 @@ extern const struct bpf_func_proto bpf_ringbuf_output_proto;
 extern const struct bpf_func_proto bpf_ringbuf_reserve_proto;
 extern const struct bpf_func_proto bpf_ringbuf_submit_proto;
 extern const struct bpf_func_proto bpf_ringbuf_discard_proto;
+extern const struct bpf_func_proto bpf_sk_release_proto;
 extern const struct bpf_func_proto bpf_ringbuf_query_proto;
 extern const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto;
 extern const struct bpf_func_proto bpf_ringbuf_submit_dynptr_proto;
@@ -4508,11 +4589,21 @@ void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, const u32 *ne
 
 #ifdef CONFIG_BPF_SYSCALL
 void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
+void bpf_unwind_release(const struct bpf_resource *res, void *handle);
+void bpf_dynptr_file_free(void *reader);
+void bpf_unwind_release_frames(void);
+void bpf_frame_desc_pool_free(struct bpf_frame_desc_pool *pool);
 #else
 static inline void
 bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 {
 }
+static inline void bpf_frame_desc_pool_free(struct bpf_frame_desc_pool *pool)
+{
+}
+static inline void bpf_unwind_release_frames(void)
+{
+}
 #endif
 
 static inline bool bpf_map_is_percpu_map(enum bpf_map_type map_type)
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c18efe4bd54a..98d26a4c4a91 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1035,6 +1035,8 @@ struct bpf_subprog_info {
 	 */
 	u32 exit_idx;
 	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
+	/* the frame descriptor of this subprogram in the pool of the program, plus one; see frame_desc.c */
+	u32 frame_desc;
 	u16 stack_depth; /* max. stack depth used by this function */
 	/* bytes below the verified stack depth reserved for hidden slots, see bpf_reserve_stack_slots() */
 	u16 stack_extra;
@@ -1293,6 +1295,8 @@ struct bpf_verifier_env {
 	/* What a pointer that was read from a table of functions may point to. */
 	struct bpf_func_set **func_sets;
 	u32 func_set_cnt;
+	/* frame descriptors of the subprograms, handed to prog->aux once verification succeeds */
+	struct bpf_frame_desc_pool *frame_desc_pool;
 	bool has_callx;
 	/*
 	 * Call graph edges created by callx instructions. A bitmap of
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index d26c62326e58..2b6b4af882d1 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o unwind.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 59478a08b247..80321ab16b32 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3459,6 +3459,7 @@ static void bpf_prog_free_images(struct work_struct *work)
 	int i;
 
 	aux = container_of(to_rcu_work(work), struct bpf_prog_aux, rwork);
+	bpf_frame_desc_pool_free(aux->frame_desc_pool);
 	for (i = 0; i < aux->real_func_cnt; i++) {
 		/* We can just unlink the subprog poke descriptor table as
 		 * it was originally linked to the main program and is also
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 04d89113e596..4e46f8931775 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2047,6 +2047,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->nr_linfo = prog->aux->nr_linfo;
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
+		/* The pool is freed with the main prog. */
+		func[i]->aux->frame_desc = env->subprog_info[i].frame_desc;
+		func[i]->aux->frame_desc_pool = env->frame_desc_pool;
 		func[i]->aux->arena = prog->aux->arena;
 		func[i]->aux->arena_stack_size = prog->aux->arena_stack_size;
 		func[i]->aux->arena_stack_entry = env->subprog_info[i].arena_stack_entry;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cc6d3a6a4de0..793eb457fb62 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3492,6 +3492,8 @@ notrace void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie)
 	 */
 	if (regs)
 		memcpy(ctx.saved, &regs->r[BPF_REG_6], sizeof(ctx.saved));
+	/* What the frames about to be discarded hold is released first. */
+	bpf_unwind_release_frames();
 	arch_bpf_stack_walk(bpf_stack_walker, &ctx);
 	WARN_ON_ONCE(!ctx.aux);
 	if (ctx.aux)
@@ -5136,6 +5138,18 @@ int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags, struct bpf_dynp
 	return make_file_dynptr(file, flags, true, (struct bpf_dynptr_kern *)ptr__uninit);
 }
 
+/*
+ * Free the reader of a file dynptr, which the dynptr and its clones point
+ * at: what the unwinder does for a dynptr the program did not discard.
+ */
+void bpf_dynptr_file_free(void *reader)
+{
+	struct bpf_dynptr_file_impl *df = reader;
+
+	freader_cleanup(&df->freader);
+	kfree_nolock(df);
+}
+
 __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)dynptr;
@@ -5144,8 +5158,7 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 	if (!df)
 		return 0;
 
-	freader_cleanup(&df->freader);
-	kfree_nolock(df);
+	bpf_dynptr_file_free(df);
 	bpf_dynptr_set_null(ptr);
 	return 0;
 }
diff --git a/kernel/bpf/unwind.c b/kernel/bpf/unwind.c
new file mode 100644
index 000000000000..3b488a4bd759
--- /dev/null
+++ b/kernel/bpf/unwind.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Releasing what the frames of a BPF program hold when bpf_throw() discards
+ * them. Before the exception callback takes over, the frames from the throw
+ * up to the main program are walked once per phase of the release order, and
+ * each frame releases what its frame descriptor says it holds of that phase,
+ * see frame_desc.c.
+ */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/filter.h>
+#include <linux/irqflags.h>
+
+void bpf_frame_desc_pool_free(struct bpf_frame_desc_pool *pool)
+{
+	u32 i;
+
+	if (!pool)
+		return;
+	for (i = 0; i < pool->cnt; i++)
+		kvfree(pool->desc[i]);
+	kvfree(pool->resources);
+	kvfree(pool);
+}
+
+static bool resource_is_lock(u8 kind)
+{
+	return kind == BPF_RESOURCE_SPIN_LOCK || kind == BPF_RESOURCE_RES_LOCK;
+}
+
+static bool resource_is_section(u8 kind)
+{
+	return kind == BPF_RESOURCE_RCU || kind == BPF_RESOURCE_PREEMPT;
+}
+
+/*
+ * Release one resource by its handle, at run time: the pointer to an object,
+ * the address of a stack object or of a lock, or nothing for a section. Not
+ * inlined so that every release of an unwind can be observed by attaching to
+ * this function.
+ */
+noinline void bpf_unwind_release(const struct bpf_resource *res, void *handle)
+{
+	/* A destructor that needs RCU protection gets it here, whatever the frames held. */
+	if (res->rcu)
+		rcu_read_lock();
+	switch (res->kind) {
+	case BPF_RESOURCE_OBJ:
+		bpf_obj_drop_impl(handle, res->meta);
+		break;
+	case BPF_RESOURCE_PERCPU_OBJ:
+		bpf_percpu_obj_drop_impl(handle, res->meta);
+		break;
+	case BPF_RESOURCE_KPTR:
+	case BPF_RESOURCE_ITER:
+		res->dtor(handle);
+		break;
+#ifdef CONFIG_NET
+	case BPF_RESOURCE_SOCK:
+		bpf_sk_release_proto.func((u64)(long)handle, 0, 0, 0, 0);
+		break;
+#endif
+	case BPF_RESOURCE_RINGBUF:
+		bpf_ringbuf_discard_proto.func((u64)(long)handle, 0, 0, 0, 0);
+		break;
+	case BPF_RESOURCE_DYNPTR_FILE:
+		bpf_dynptr_file_free(handle);
+		break;
+	case BPF_RESOURCE_SPIN_LOCK:
+		bpf_spin_unlock_proto.func((u64)(long)handle, 0, 0, 0, 0);
+		break;
+	case BPF_RESOURCE_RES_LOCK:
+		bpf_res_spin_unlock(handle);
+		break;
+	case BPF_RESOURCE_IRQ_FLAG:
+		bpf_local_irq_restore(handle);
+		break;
+	case BPF_RESOURCE_RCU:
+		bpf_rcu_read_unlock();
+		break;
+	case BPF_RESOURCE_PREEMPT:
+		bpf_preempt_enable();
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+	if (res->rcu)
+		rcu_read_unlock();
+}
+
+/* The sections of a frame are counted, per kind. */
+enum {
+	BPF_UNWIND_SECTION_RCU,
+	BPF_UNWIND_SECTION_PREEMPT,
+	BPF_UNWIND_NR_SECTIONS,
+};
+
+static int section_index(u8 kind)
+{
+	return kind == BPF_RESOURCE_RCU ? BPF_UNWIND_SECTION_RCU : BPF_UNWIND_SECTION_PREEMPT;
+}
+
+/*
+ * The release order. Objects never run under a lock or with IRQs disabled by
+ * any frame, and a sleeping destructor runs after every section is left; an
+ * RCU-protected object is destroyed before the sections end.
+ */
+enum {
+	BPF_UNWIND_PHASE_LOCKS,		/* locks and IRQ flags */
+	BPF_UNWIND_PHASE_RCU_OBJS,	/* objects whose destructor needs RCU protection */
+	BPF_UNWIND_PHASE_SECTIONS,	/* RCU and preemption sections */
+	BPF_UNWIND_PHASE_OBJS,		/* everything else */
+	BPF_UNWIND_NR_PHASES,
+};
+
+static int release_phase(const struct bpf_resource *res)
+{
+	if (resource_is_lock(res->kind) || res->kind == BPF_RESOURCE_IRQ_FLAG)
+		return BPF_UNWIND_PHASE_LOCKS;
+	if (resource_is_section(res->kind))
+		return BPF_UNWIND_PHASE_SECTIONS;
+	return res->rcu ? BPF_UNWIND_PHASE_RCU_OBJS : BPF_UNWIND_PHASE_OBJS;
+}
+
+struct bpf_unwind_ctx {
+	int phase;	/* BPF_UNWIND_PHASE_*: what this walk releases */
+	int cnt;	/* BPF frames passed */
+	/* The sections the frames hold, per kind, summed by the first walk. */
+	const struct bpf_resource *section[BPF_UNWIND_NR_SECTIONS];
+	s64 nr_sections[BPF_UNWIND_NR_SECTIONS];
+};
+
+/*
+ * The R10 of a frame of the function @fn whose native frame pointer is @bp: a
+ * fixed distance from it, or, with a private stack, this CPU's private frame.
+ */
+static u64 bpf_unwind_fp(const struct bpf_prog_aux *fn, u64 bp)
+{
+	if (fn->priv_stack_ptr)
+		return (u64)(long)this_cpu_ptr(fn->priv_stack_ptr) + fn->priv_frame_off;
+	return bp + fn->frame_fp_off;
+}
+
+/*
+ * Release what the slots of the frame of @prog hold of the phase of this
+ * walk; @bp is its native frame pointer. The first walk sums the frame's
+ * counts of sections for their phase, and releases the locks and IRQ flags
+ * in two passes: the flags a frame saved with interrupts enabled, of which
+ * it can have one at most, since every later save found them disabled, are
+ * restored last, after the locks and the other flags in whatever order the
+ * frame took them.
+ */
+static void bpf_unwind_release_frame(struct bpf_unwind_ctx *ctx, const struct bpf_prog *prog, u64 bp)
+{
+	const struct bpf_prog_aux *fn = bpf_prog_frame_aux(prog);
+	const struct bpf_frame_desc_pool *pool = fn->frame_desc_pool;
+	int passes = ctx->phase == BPF_UNWIND_PHASE_LOCKS ? 2 : 1, pass, s;
+	const struct bpf_frame_desc *d;
+	bool late;
+	u64 fp;
+	u32 i;
+
+	if (!fn->frame_desc)
+		return;
+	d = pool->desc[fn->frame_desc - 1];
+	fp = bpf_unwind_fp(fn, bp);
+	for (pass = 0; pass < passes; pass++) {
+		for (i = 0; i < d->nent; i++) {
+			const struct bpf_frame_desc_entry *ent = &d->ent[i];
+			const struct bpf_resource *res = &pool->resources[ent->res];
+			u64 *slot = (u64 *)(long)(fp + ent->off);
+			void *handle = (void *)(long)*slot;
+
+			if (ent->flags & BPF_FRAME_ENT_COUNTER) {
+				if (ctx->phase != BPF_UNWIND_PHASE_LOCKS || pass)
+					continue;
+				s = section_index(res->kind);
+				ctx->section[s] = res;
+				ctx->nr_sections[s] += (s64)*slot;
+				continue;
+			}
+			if (!handle || release_phase(res) != ctx->phase)
+				continue;
+			late = res->kind == BPF_RESOURCE_IRQ_FLAG &&
+			       !arch_irqs_disabled_flags(*(unsigned long *)handle);
+			if (passes == 2 && late != (pass == 1))
+				continue;
+			bpf_unwind_release(res, handle);
+		}
+	}
+}
+
+static bool bpf_unwind_walker(void *cookie, u64 ip, u64 sp, u64 bp)
+{
+	struct bpf_unwind_ctx *ctx = cookie;
+	struct bpf_prog *prog;
+
+	/*
+	 * The RCU read lock is held to safely traverse the latch tree, but we
+	 * don't need its protection when accessing the prog, since it has an
+	 * active stack frame on the current stack trace, and won't disappear.
+	 */
+	rcu_read_lock();
+	prog = bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
+	/* the frames of bpf_throw() and of the unwinder come first */
+	if (!prog)
+		return !ctx->cnt;
+	ctx->cnt++;
+	bpf_unwind_release_frame(ctx, prog, bp);
+	/* the main program is where the exception callback takes over */
+	return bpf_is_subprog(prog);
+}
+
+/*
+ * Release what the frames between bpf_throw() and the main program hold, the
+ * main program's included, in four phases: locks and IRQ flags,
+ * RCU-protected objects, sections, then the other objects. Each phase but
+ * the sections' is a walk over the frames, innermost first, that releases
+ * each frame's entries of the phase in the order of its descriptor; the
+ * frames are released as the walk passes them, so their number is not
+ * bounded. The sections need no walk of their own: the first one summed
+ * their counts, and sections of one kind are all the same.
+ */
+void bpf_unwind_release_frames(void)
+{
+	struct bpf_unwind_ctx ctx = {};
+	int s;
+
+	for (ctx.phase = 0; ctx.phase < BPF_UNWIND_NR_PHASES; ctx.phase++) {
+		if (ctx.phase != BPF_UNWIND_PHASE_SECTIONS) {
+			ctx.cnt = 0;
+			arch_bpf_stack_walk(bpf_unwind_walker, &ctx);
+			continue;
+		}
+		for (s = 0; s < BPF_UNWIND_NR_SECTIONS; s++) {
+			WARN_ONCE(ctx.nr_sections[s] < 0, "bpf: %lld sections to leave\n",
+				  ctx.nr_sections[s]);
+			while (ctx.nr_sections[s]-- > 0)
+				bpf_unwind_release(ctx.section[s], NULL);
+		}
+	}
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c71ceb1dd4c..cf3cfc734ed4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25695,6 +25695,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (env->prog->type == BPF_PROG_TYPE_EXT)
 		env->prog->expected_attach_type = 0;
 
+	/* The program owns the frame descriptors from here on. */
+	env->prog->aux->frame_desc_pool = env->frame_desc_pool;
+	env->frame_desc_pool = NULL;
+
 	env->prog = __bpf_prog_select_runtime(env, env->prog, &ret);
 
 err_release_maps:
@@ -25731,6 +25735,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	release_btfs(env);
 err_free_env:
 	bpf_free_subprog_jts(env);
+	bpf_frame_desc_pool_free(env->frame_desc_pool);
 	if (env->insn_aux_data)
 		bpf_clear_insn_aux_data(env, 0, env->insn_aux_data_len);
 	vfree(env->insn_aux_data);
diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9f1e..9f59b1c002d6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7577,7 +7577,7 @@ BPF_CALL_1(bpf_sk_release, struct sock *, sk)
 	return 0;
 }
 
-static const struct bpf_func_proto bpf_sk_release_proto = {
+const struct bpf_func_proto bpf_sk_release_proto = {
 	.func		= bpf_sk_release,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-- 
2.53.0

