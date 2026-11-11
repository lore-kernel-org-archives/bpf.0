Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401876;
	b=MOq9xmdwWI3KBR9loVBy5ptGi2GmpoDaIeSBpJtJA+JoaisjDmjsuuKTH6yC5+VU1McF
	 nanD30xFxOT2NKhjwbCPF9p4rFcP2jU49ID2aqO7PXYkx5JteeKo7ASDPiEilLoBQDxtc
	 kt2GVC7Zhrso58ctIsoLNwKDhDBJSSDriBTRlg8fY5a4Lse+4C7ZLZ72sx6ASw53nAfuC
	 9ENyURiddwGEmCCP63pJSfsnQt98aSRtY1EixtTqGeVFb88rnXBHOUiLnofTYXtIXoU6V
	 HfPzoFsNsE/cYdnNKSifIuj6LWv2qbmoE1vTFs/EQbWoyzkgLCEHLlpsaW01dgIclKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=KOK5iAaJWGPhpzyxfjhYi59vZ8olB5VnMmASz/Sklio=;
	b=S9sScCuP+jKlQsosR9VmxNM7vj9M5GpyIBvd3ssCKEr6lYh9p61t1spQAEFf41jabgfL
	 w5P1hwa1ThszbjsZ5eBtWMY0Rjl0R0AV5ReoQYXg2wxROFnkXFa0JkrcsqZ7/qpPIiVWr
	 wRalyaW/TTk5bpyLGEBfACIXkPJFqKBEjLac3K/WfQJC7UhsAj0qlAm/CNmH53WKlFbqi
	 BFh2PaECFPfM2wUxPi0uxoLeMr2EYvDs8XyNRYhgVG7xFYG95n7M+LJD4PQfsbUhxRfYZ
	 xxeJmaBEfZDVpleDkvfHfk/rbae1HlgikCOG9tqGKFUA5MO2kabsYtRWhdCVUYhr/AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=monotqx7;
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A5606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 320A5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=monotqx7
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4ad5d6045d4so14760325e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401873; x=1795006673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KOK5iAaJWGPhpzyxfjhYi59vZ8olB5VnMmASz/Sklio=;
        b=monotqx7hEHhNS12pWktKhmZuzVT4L7afJSGvTQweHFdYJ4t3m8tKgwUJM3ie/pRed
         jC3gZ+58glB1mApPeWvpsxPvYHonY3JrCSn71feguP+4TeRf/ffQkomC6sIMgd9Krge8
         5D4TdSOWeCQRxxwJYi7yDD8Pv+806EdBLuvDifH8oHxC7ze0ARQ15QyFYjAR6YE6pJfz
         oUPBZ6Kaf3Tbo6ih2FMEgR35gWexnDeNEL1Yz8a3mn0v2rDO0x6Inf5rrw0r1G4+Mr6K
         rjj2c3txkDbp4WXNC4x3nVUDSj0BEQMSY94/Teb8ULSNr0G/tNMaWTbCqVWM9mCnRip7
         Qu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401873; x=1795006673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KOK5iAaJWGPhpzyxfjhYi59vZ8olB5VnMmASz/Sklio=;
        b=NI8Puh+cyJNr9AIaRNPBKHZgGIAiqxTiN5T6T96loLFvSDjuKQNKeQsh8E4e++UhDw
         mgjYOItaUi9KrBbrBvmMXaBTHMk+I9c7nJIIvk8G+wwsXjhZbKHfVo6ve+Drw7R3DjfV
         +gFrRjFfRxG/hyKBvroFl2QrRcMAIA1pdjjlA7XL5vdG32VH4Lga5gUmM3lZBy8+NILr
         ub2VRMKUwku7f64XySrfRXyLT/ggAyz3ZDK1IzP15tgIVwtPZmWPon0LmfJeFHqCxuye
         sXJkOf2oWNZKagzOZhVfGir0u8pM8kfFTyguHWYLxH7J1jsviAdrz7qxwZT0G43oTlwz
         Z3Tg==
X-Gm-Message-State: APuU4Z9+Vda5OfjcphBwsyeIWGFQg0cPBUOKhMuQNYb9KtBYfUJF6rmU
	PyxFJp2bl60b5edW6dbXUEF0kjRFJxIuSsB/TWw+egGFAqc+O2L50xNioOa7A0e1XEA=
X-Gm-Gg: AYBFou1uJQMcZ/4X9Jh4nsnf+baCv9wyFkjsroWY7DDGXLGNGOzW3ORY5otwKgXjufM
	4gw1B4suKmRSv8f0V8S0m8ElkaO7NPDX6hBwxbI+rLgghUZWPC+Ier/fo8GCL/iYlIv4GWm61JD
	FPd8890EWXfEWdRgiVv4ZDFBKffYIA7cIaSdwTf8VghU/h74vHRyFfcPxVPN95HafyiNC/AsNpm
	DezDfXNzhGxyhb7ix5aZ/PKqUfMWbGamWA/NtHGmq61yBl5K88PTQaleKXspModsT8gXDl4lN7O
	b5cu2+VWJab9VP9bC0GZg7D+uz+Ma8e4w4Q8xnDDl/RG904g+bYxwk3xNGgqVol9sgDDgPPA5XC
	xfZyN5r9Krqvpa1ilswIwpffw9fN5OObLrZRJKmnRY1nyQG0CRMurbtZhkvpC2I7lSLiPNAk9xw
	afF/byHkONa8I4/kRV88aLFqq3dZjyUzBikNfKQVPjkPePmjHn0u0lM+aYe8lwWoSmQKHyagNUQ
	QcB7w2mB3cvoO5lZZ9dXRzb9rzGcwkG0SQr30cpqHGhZWSvslF2jXokxUZ0GdSKgSAYY1Dw4uj3
	bR6B7d4RjJB0whAkiKmjmcBPO6LeYOaCu+Xn9myBl1Tn5ctmlPsOIq6i/XD8zodrAGbn8qpaAvF
	A5a+eR9lcT8X9qluSt9ppbqTUl6Pc8ZBcvAdX9q5pS/qIKJYB7UV8Efa4K/WZ396LmcvtMQmtZH
	6yTS5lywxIgThAvA==
X-Received: by 2002:a05:600c:3549:b0:4a2:8c5:5e5 with SMTP id 5b1f17b1804b1-4ba0939d23emr41750345e9.7.1794401872635;
        Wed, 11 Nov 2026 04:57:52 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0951fe22sm62251625e9.3.2026.11.11.04.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:52 -0800 (PST)
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
Subject: [PATCH bpf-next v1 14/29] bpf: Describe held resources at throw sites
Date: Wed, 11 Nov 2026 13:57:12 +0100
Message-ID: <579fd63756665e448169cef577835f8dbef30329.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=61548; i=memxor@gmail.com; h=from:subject:message-id; bh=dpapd/nafpQcnyCwmDU3UWbZ9zCdIKKwphu0XqefxhM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzIJqrg/5Kiza309ebytdsFXw259nb2ZIWus0CUvG5 agtEQ3oKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwER0qhkZ3jFNOrrR48fu1Zwu v70EHG8EC4dHa3yKjng6Zf3knRP3qzH84TheG7/SuvVlWnbO6WfCt36d/Wh6qLnLzojho7am2N7 7TAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently every call that acquires a resource in a program that throws
keeps the handle in a hidden slot of its frame. This costs a stack slot,
a store on acquire, and a compare and a store on release, whether or not
a throw can find the resource held.

A frame can only be unwound at a call it has not returned from:
bpf_throw(), or a call to a subprog that may throw. Such a call is a
site. Often the frame already keeps its resources on its own stack at a
site, in the same location on every path:

 - an iterator and saved IRQ flags are objects on the stack;
 - a reference is spilled, or is the first word of a dynptr;
 - the frame is in the same number of RCU read and preemption disabled
   sections.

Add a descriptor per site for these. On every visit to a site, the main
pass records where each frame of the state keeps its resources:

 - at bpf_throw() and at a call to a global subprog that may throw: for
   the frame that makes the call and for each of its callers, at the
   call it has not returned from;
 - at a call to a subprog that is verified on its own and may throw: for
   the frames of the caller. Such a subprog has no pointer into their
   stack, so its throw finds them as they are at the call.

After the pass, each acquisition is one of three cases:

 - No site finds the resource held: nothing is kept for it.
 - Every site that finds it held does so on every visit, with the handle
   in the same location: the site descriptors give that location.
 - Otherwise the handle is kept in a hidden slot, as before.

Sections work the same way. A subprog counts its sections in a hidden
slot only if the visits to one of its sites disagree on the number of
sections. Otherwise the site descriptor gives the count, which is
negative for a callee that left a section of its caller.

A referenced argument of a struct_ops program is described like any
other reference. Its hidden slot, and the load and the store at program
entry that fill it, remain only for an argument that some site cannot
describe. Locks always take a hidden slot when a site finds them held.

Two things limit which stack slots a site can describe:

 - The verifier forgets the contents of a dead slot where paths join, see
   bpf_clean_verifier_state(). A reference spilled in a slot that is not
   read again would then be unknown at the site, and nothing is read
   after bpf_throw(). So a slot that holds a pointer to a resource held
   by its frame is kept even when dead: it stays in the state, and a
   state can stand for another only if both have the same contents in
   it. Stack liveness itself does not change.
 - The slots that the spills of a bpf_fastcall pattern go to hold
   nothing at runtime once bpf_remove_fastcall_spills_fills() removes
   the spills. They are never described.

At runtime, each JITed function has a table of its sites that have a
descriptor, sorted by native offset. The verifier builds the table from
the instruction index of each call when the function is split off for
the JIT, after constant blinding has moved the instructions. The x86-64
and arm64 JITs fill in the native range of each call. The unwinder looks
up the return address of a frame, minus one, and releases the resources
listed in the site descriptor together with those in the hidden slots of
the function.

A descriptor entry now says what kind of location it describes: a slot
or a spill that holds a pointer, possibly into the object, a stack
object, a slot that counts sections, or a constant count. Iterators and
file readers are flagged to be released before the references of their
frame, in both descriptors of the frame.

The rejections for a program that throws do not change, with one
exception: an instruction that acquires a resource only on some paths is
rejected only if the resource needs a hidden slot.

A subprog that calls through a function pointer it was passed can throw
without containing a throw or taking the address of a function. Mark
every subprog that contains a callx as one that may throw if any function
whose address is taken may throw, so that the frames of its callers are
visited at the call.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c |   1 +
 arch/x86/net/bpf_jit_comp.c   |   4 +-
 include/linux/bpf.h           |  64 +++-
 include/linux/bpf_verifier.h  |  61 +++-
 kernel/bpf/cfg.c              |  23 +-
 kernel/bpf/core.c             |   1 +
 kernel/bpf/fixups.c           |   8 +-
 kernel/bpf/frame_desc.c       | 603 +++++++++++++++++++++++++++-------
 kernel/bpf/join.c             |   3 +-
 kernel/bpf/states.c           |   8 +-
 kernel/bpf/unwind.c           | 156 ++++++---
 kernel/bpf/verifier.c         |  22 +-
 12 files changed, 780 insertions(+), 174 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 418bda24020c..801b507a4644 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2902,6 +2902,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		 * reasons, expects to point to the next instruction)
 		 */
 		bpf_prog_update_insn_ptrs(prog, ctx.offset, ctx.ro_image);
+		bpf_prog_fill_frame_desc_sites(prog, ctx.offset, ctx.ro_image);
 out_off:
 		if (!ro_header && priv_stack_ptr) {
 			free_percpu(priv_stack_ptr);
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9170cbe3fa16..2c2d571b21c4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -4932,8 +4932,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	}
 
 	if (!image || !prog->is_func || extra_pass) {
-		if (image)
+		if (image) {
 			bpf_prog_fill_jited_linfo(prog, addrs + 1);
+			bpf_prog_fill_frame_desc_sites(prog, addrs, image);
+		}
 out_addrs:
 		kvfree(addrs);
 		if (!image && priv_stack_ptr) {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e7cce9080531..e8eda32bc05d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1864,29 +1864,66 @@ struct bpf_resource {
 };
 
 /*
- * The slot holds a count of sections instead of a handle, signed: the
- * sections the frame entered less those of its callers it left.
+ * What an entry of a frame descriptor names, relative to the frame pointer:
+ *
+ *  - by default a location that holds the handle of a resource of the class,
+ *    or 0 when the frame holds none. The handle is what the release takes: the
+ *    pointer to an object, to a ringbuf record or to a lock, or the address of
+ *    an iterator or of saved IRQ flags on the stack. The location is a hidden
+ *    slot of the frame, or a slot of the program's own stack that holds the
+ *    pointer whenever the frame is at the site of the descriptor; the pointer
+ *    may then point adj bytes into the object;
+ *  - with BPF_FRAME_ENT_OBJ the resource itself, an iterator or saved IRQ
+ *    flags the frame has on its stack whenever it is at the site;
+ *  - with BPF_FRAME_ENT_COUNTER a hidden slot that holds a count of sections,
+ *    signed: the sections the frame entered less those of its callers it left;
+ *  - with BPF_FRAME_ENT_COUNT no location: the count of the sections the frame
+ *    is in whenever it is at the site.
  */
 #define BPF_FRAME_ENT_COUNTER	BIT(0)
+#define BPF_FRAME_ENT_OBJ	BIT(1)
+#define BPF_FRAME_ENT_COUNT	BIT(2)
+/* Released before the other entries of the frame, which it may be using. */
+#define BPF_FRAME_ENT_FIRST	BIT(3)
 
-/*
- * One hidden slot of a frame: it holds the handle of a resource of the class
- * the frame holds, or 0. The handle is what the release takes: the pointer
- * to an object, to a ringbuf record or to a lock, or the address of an
- * iterator or of saved IRQ flags on the stack of some frame.
- */
 struct bpf_frame_desc_entry {
 	u16 res;	/* index into the program's resource classes */
-	s16 off;	/* the slot, relative to the frame pointer */
-	u16 flags;
+	u16 flags;	/* BPF_FRAME_ENT_* */
+	union {
+		s16 off;	/* the location, relative to the frame pointer */
+		s16 count;	/* BPF_FRAME_ENT_COUNT */
+	};
+	s16 adj;
 };
 
+/*
+ * A frame has two descriptors: the one of its function lists its hidden
+ * slots, and the one of the site it is at, the call a throw found it in, what
+ * the verifier found in the same place on every path to the site.
+ */
 struct bpf_frame_desc {
 	u32 size;	/* total size in bytes, including this header */
 	u32 nent;	/* number of entries that follow */
 	struct bpf_frame_desc_entry ent[];
 };
 
+/* A call of a JITed function that a frame may be unwound at. */
+struct bpf_frame_desc_site {
+	u32 off;	/* native offset of the first byte of the call from prog->bpf_func */
+	u32 end;	/* native offset one past its last byte */
+	u32 desc;	/* index into the descriptor pool of the main program */
+};
+
+/*
+ * The sites of one JITed function, sorted by off. Until the JIT fills it, off
+ * holds the index of the instruction in the function and end is unused.
+ */
+struct bpf_frame_desc_sites {
+	u32 cnt;
+	bool filled;
+	struct bpf_frame_desc_site site[];
+};
+
 /* Owned by the main program and shared by its subprograms. */
 struct bpf_frame_desc_pool {
 	u32 cnt;
@@ -2127,6 +2164,8 @@ struct bpf_prog_aux {
 	 */
 	u32 frame_desc;
 	struct bpf_frame_desc_pool *frame_desc_pool;
+	/* The sites of this JITed function that have a descriptor, freed with it. */
+	struct bpf_frame_desc_sites *frame_desc_sites;
 	union {
 		struct work_struct work;
 		struct rcu_head	rcu;
@@ -4589,6 +4628,7 @@ void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, const u32 *ne
 
 #ifdef CONFIG_BPF_SYSCALL
 void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
+void bpf_prog_fill_frame_desc_sites(struct bpf_prog *prog, const u32 *offsets, void *image);
 void bpf_unwind_release(const struct bpf_resource *res, void *handle);
 void bpf_dynptr_file_free(void *reader);
 void bpf_unwind_release_frames(void);
@@ -4598,6 +4638,10 @@ static inline void
 bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 {
 }
+static inline void
+bpf_prog_fill_frame_desc_sites(struct bpf_prog *prog, const u32 *offsets, void *image)
+{
+}
 static inline void bpf_frame_desc_pool_free(struct bpf_frame_desc_pool *pool)
 {
 }
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5cbac24102f4..ca50c85006d7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1052,7 +1052,10 @@ struct bpf_subprog_info {
 	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
 	/* the frame descriptor of this subprogram in the pool of the program, plus one; see frame_desc.c */
 	u32 frame_desc;
-	/* hidden slots: the counts of the sections the frame entered, by kind; 0 when it has none */
+	/*
+	 * hidden slots: the counts of the sections the frame entered, by kind; 0
+	 * when it has none: it enters none, or its sites say how many it is in
+	 */
 	s16 section_off[2];
 	u16 stack_depth; /* max. stack depth used by this function */
 	/* bytes below the verified stack depth reserved for hidden slots, see bpf_reserve_stack_slots() */
@@ -1064,6 +1067,11 @@ struct bpf_subprog_info {
 	 * are used for bpf_fastcall spills and fills.
 	 */
 	s16 fastcall_stack_off;
+	/*
+	 * Where the longest pattern ends: its spills are removed as well, so
+	 * the slots below hold nothing at run time, see frame_desc.c.
+	 */
+	s16 fastcall_stack_end;
 	bool has_tail_call: 1;
 	bool might_throw: 1;
 	bool can_unwind: 1; /* has unwind_exit */
@@ -1247,8 +1255,10 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
 #define BPF_RES_F_CTX		BIT(3)	/* a __ref argument the kernel passes the main program */
 
 /*
- * A call that acquires a resource, see frame_desc.c: the handle of what it
- * acquired is kept in a hidden slot of the frame that runs the call, one slot
+ * A call that acquires a resource, see frame_desc.c. When a frame can be
+ * unwound while it holds what the call acquired, and the sites it can be
+ * unwound at do not all find the handle in the same place of its stack, the
+ * handle is kept in a hidden slot of the frame that runs the call, one slot
  * per acquiring call.
  */
 struct bpf_res_acq {
@@ -1259,6 +1269,41 @@ struct bpf_res_acq {
 	s16 adj;	/* R0 points that many bytes into the object: the node of a list */
 	s16 obj_off;	/* BPF_RES_F_DEREF: the dynptr, relative to R10; BPF_RES_F_CTX: in the context */
 	s16 off;	/* the slot, relative to R10 */
+	bool held;	/* some frame holds what it acquired at a site */
+	bool slot;	/* and some site cannot say where: the handle is kept in a slot */
+};
+
+/* How many places of its stack a site remembers a frame keeping one handle in. */
+#define BPF_RES_LOC_MAX		3
+
+/*
+ * A site: a call a frame can be unwound at, bpf_throw() or the call of a
+ * subprog that may throw, and what every visit of it found of the frame that
+ * runs it. A site has a descriptor of its own for what the visits agree on,
+ * see frame_desc.c.
+ */
+struct bpf_res_site {
+	u32 insn;		/* the call, as the main pass named it */
+	u32 visits;
+	s16 sections[2];	/* the sections the frame is in, RCU and preemption */
+	bool sections_vary[2];	/* the visits differ: the frame counts them in a slot */
+	u32 desc;		/* its descriptor in the pool of the program, plus one */
+};
+
+/*
+ * Where the frame at a site keeps the handle of what an acquisition acquired:
+ * the slots of its stack that every visit holding it found the handle in.
+ */
+struct bpf_res_loc {
+	u32 site;	/* index of the site */
+	u32 visits;	/* how many visits of the site found the frame holding it */
+	u16 acq;	/* index of the acquisition */
+	u8 cnt;		/* the places left */
+	bool obj;	/* they are the resource itself, an object on the stack */
+	struct {
+		s16 off;	/* relative to R10 */
+		s16 adj;	/* the pointer there points that many bytes into the object */
+	} at[BPF_RES_LOC_MAX];
 };
 
 /* A call that releases what an acquisition acquired: the slot of the acquisition is cleared. */
@@ -1319,8 +1364,13 @@ struct bpf_verifier_env {
 	u32 res_rel_cnt;
 	struct bpf_section_insn *section_insns;
 	u32 section_insn_cnt;
+	struct bpf_res_site *res_sites;
+	u32 res_site_cnt;
+	struct bpf_res_loc *res_locs;
+	u32 res_loc_cnt;
 	int release_regno;			/* the argument the current call releases, or -1 */
 	u32 frame_desc_slots;			/* hidden slots that hold handles and counts */
+	u32 frame_desc_sites;			/* sites that have a descriptor */
 	u32 frame_desc_insns;			/* instructions keeping them up to date */
 	u32 frame_desc_bytes;			/* descriptors and resource classes */
 	bool describe_frames;			/* frame descriptors are generated: the program may throw */
@@ -2280,11 +2330,16 @@ int bpf_frame_desc_record_release(struct bpf_verifier_env *env, int idx);
 int bpf_frame_desc_record_ctx_arg(struct bpf_verifier_env *env, int idx, int argno);
 int bpf_frame_desc_record_section(struct bpf_verifier_env *env, u8 kind, s8 delta);
 int bpf_frame_desc_record_exit(struct bpf_verifier_env *env);
+bool bpf_frame_desc_keeps(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			  int f, const struct bpf_reg_state *reg);
+int bpf_frame_desc_record_site(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			       int insn_idx);
 int bpf_frame_desc_record_return(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 				 int idx, int callsite, const struct bpf_reg_state *r0);
 int bpf_frame_desc_resolve(struct bpf_verifier_env *env);
 int bpf_frame_desc_emit(struct bpf_verifier_env *env);
 int bpf_frame_desc_build(struct bpf_verifier_env *env);
+struct bpf_frame_desc_sites *bpf_frame_desc_sites(struct bpf_verifier_env *env, int subprog);
 void bpf_frame_desc_reset(struct bpf_verifier_env *env);
 void bpf_frame_desc_env_free(struct bpf_verifier_env *env);
 int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index bbcf42eae9d9..fad8affe7fbf 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -535,22 +535,41 @@ static int visit_func_ptrs_insn(int t, struct bpf_verifier_env *env,
 static void close_callee_effects(struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insn = env->prog->insnsi;
+	bool changed, taken_throws = false, throws;
+	struct bpf_subprog_info *sub;
 	struct bpf_func_ptr *ptrs;
-	bool changed;
 	u32 cnt, j;
 	int t;
 
 	do {
 		changed = false;
+		throws = taken_throws;
 		for (t = 0; t < env->prog->len; t++) {
 			if (bpf_pseudo_call(&insn[t]) || bpf_pseudo_func(&insn[t]))
 				changed |= merge_callee_effects(env, t, t + insn[t].imm + 1);
+			if (bpf_pseudo_func(&insn[t]))
+				taken_throws |= bpf_find_containing_subprog(env, t + insn[t].imm + 1)->might_throw;
 			ptrs = insn_func_ptrs(env, t, &cnt);
-			for (j = 0; j < cnt; j++)
+			for (j = 0; j < cnt; j++) {
 				changed |= merge_callee_effects(env, t, ptrs[j].xlated_off);
+				taken_throws |= bpf_find_containing_subprog(env, ptrs[j].xlated_off)->might_throw;
+			}
+			/*
+			 * It is not known which function a callx calls: the subprog may
+			 * throw when a function whose address is taken may. The marks
+			 * above are for the subprog that takes the address, which need
+			 * not be the one that calls through it, and the frames of the
+			 * callers of the one that does are unwound, see frame_desc.c.
+			 */
+			if (taken_throws && bpf_is_callx(&insn[t])) {
+				sub = bpf_find_containing_subprog(env, t);
+				changed |= !sub->might_throw;
+				sub->might_throw = true;
+			}
 			if (bpf_is_ldimm64(&insn[t]))
 				t++;
 		}
+		changed |= throws != taken_throws;
 	} while (changed);
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 80321ab16b32..66815fd8f856 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -295,6 +295,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		mutex_destroy(&fp->aux->dst_mutex);
 		kfree(fp->aux->poke_tab);
 		free_percpu(fp->aux->timed_may_goto);
+		kvfree(fp->aux->frame_desc_sites);
 		kfree(fp->aux);
 	}
 	free_percpu(fp->stats);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 984d6287241a..0dfb33bb8bb8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2047,9 +2047,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->nr_linfo = prog->aux->nr_linfo;
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
-		/* The pool is freed with the main prog. */
+		/* The pool is freed with the main prog, the sites with func[i]. */
 		func[i]->aux->frame_desc = env->subprog_info[i].frame_desc;
 		func[i]->aux->frame_desc_pool = env->frame_desc_pool;
+		func[i]->aux->frame_desc_sites = bpf_frame_desc_sites(env, i);
+		if (IS_ERR(func[i]->aux->frame_desc_sites)) {
+			err = PTR_ERR(func[i]->aux->frame_desc_sites);
+			func[i]->aux->frame_desc_sites = NULL;
+			goto out_free;
+		}
 		func[i]->aux->arena = prog->aux->arena;
 		func[i]->aux->arena_stack_size = prog->aux->arena_stack_size;
 		func[i]->aux->arena_stack_entry = env->subprog_info[i].arena_stack_entry;
diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
index b0db3feeb9b0..b09cd868d8d9 100644
--- a/kernel/bpf/frame_desc.c
+++ b/kernel/bpf/frame_desc.c
@@ -1,18 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Frame descriptors: the hidden stack slots in which the frames of a program
- * that may throw keep the handles of the kernel resources they hold, for
- * bpf_throw() to release, see unwind.c.
+ * Frame descriptors: where the frames of a program that may throw keep the
+ * handles of the kernel resources they hold, for bpf_throw() to release, see
+ * unwind.c.
  *
- * Nothing is inferred about where a program keeps a reference. The handle of
- * a resource is written down when the resource is acquired: the pointer a
- * call returns, the address of the lock, the iterator or the saved IRQ flags
- * a call takes, the record or the reader of a dynptr. Every call that
- * acquires has a slot of its own in the frame that runs it. The handle goes
- * into the slot around the call, and the call that releases the resource
- * clears the slot when it holds the handle the call takes. The sections a
- * frame enters, RCU read and preemption disabled, have no handle and are
- * counted in a slot per kind.
+ * A frame is unwound at a site: the call it has not returned from,
+ * bpf_throw() or the call of a subprog that may throw. The main pass visits a
+ * site with every state a frame can be in there, and records what the frame
+ * keeps in its own stack on each visit: the iterators and saved IRQ flags it
+ * holds, which are on its stack, the slots a reference it holds is spilled
+ * in, and how many RCU read and preemption disabled sections it is in. What
+ * every visit finds in the same place goes into the descriptor of the site,
+ * and costs the program nothing.
+ *
+ * What the visits of some site do not agree on is written down when it is
+ * acquired, in a hidden stack slot. Nothing is inferred about where the
+ * program keeps it. The handle is the pointer a call returns, the address of
+ * the lock, the iterator or the saved IRQ flags a call takes, the record or
+ * the reader of a dynptr. Every call that acquires such a resource has a slot
+ * of its own in the frame that runs it. The handle goes into the slot around
+ * the call, and the call that releases the resource clears the slot when it
+ * holds the handle the call takes. The sections a frame enters have no handle
+ * and are counted in a slot per kind. The slots of a subprog are listed in
+ * its own descriptor.
+ *
+ * What no frame holds at any site needs neither.
  *
  * A slot belongs to one frame and holds one handle, so a program that throws
  * keeps to what that can express:
@@ -24,9 +36,10 @@
  *    returns one, and is in the sections it was called in.
  *  - A frame holds one resource of an acquiring call at a time.
  *
- * The main pass records every call that acquires or releases and which
- * acquisition a release may be of. The slots are reserved and the
- * instructions that keep them emitted after the pass.
+ * The main pass records every call that acquires or releases, which
+ * acquisition a release may be of, and the visits of the sites. What needs a
+ * slot is decided after the pass: the slots are reserved, the instructions
+ * that keep them emitted and the descriptors built then.
  */
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
@@ -245,6 +258,35 @@ static bool reg_ref_off(const struct bpf_reg_state *reg, int id, s16 *off)
 	return true;
 }
 
+/*
+ * Does @reg, a register of frame @f of @st or one spilled in its stack, point
+ * to what the frame holds a reference to? A site names such a place, see
+ * ref_locations().
+ *
+ * The program may have read the pointer for the last time while the frame
+ * holds the resource still, at the latest in front of a bpf_throw(), which
+ * nothing follows. A state forgets what is dead, see
+ * bpf_clean_verifier_state(), and no site could name the place then. So such
+ * a place is kept: it stays in the state, and a state stands for another only
+ * when both have the same in it. What is dead otherwise is forgotten as it
+ * was.
+ */
+bool bpf_frame_desc_keeps(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			  int f, const struct bpf_reg_state *reg)
+{
+	s16 off;
+	int i;
+
+	if (!env->describe_frames || reg->type == NOT_INIT || reg->type == SCALAR_VALUE || !reg->id)
+		return false;
+	/* a frame above may hold it for now and give it back, see bpf_frame_desc_record_exit() */
+	for (i = 0; i < st->acquired_refs; i++)
+		if (st->refs[i].frameno >= f && st->refs[i].acq && st->refs[i].id &&
+		    reg_ref_off(reg, st->refs[i].id, &off))
+			return true;
+	return false;
+}
+
 /*
  * Is @slot the stack object of reference @id: the first slot of an iterator,
  * of a ringbuf dynptr, which tracks the record's reference as its parent,
@@ -498,9 +540,9 @@ static bool acquires_sometimes(const struct bpf_verifier_env *env, u32 idx,
 /*
  * The kernel holds a reference for the __ref argument @argno of a struct_ops
  * program, refs[@idx], and the program releases it or hands it back: the main
- * program holds it from its first insn, in a slot its entry fills from the
- * context. An argument of a type the unwinder cannot release gets no slot,
- * like any such reference.
+ * program holds it from its first insn. When it needs a slot, the entry of the
+ * program fills the slot from the context. An argument of a type the unwinder
+ * cannot release is not recorded, like any such reference.
  */
 int bpf_frame_desc_record_ctx_arg(struct bpf_verifier_env *env, int idx, int argno)
 {
@@ -691,6 +733,162 @@ int bpf_frame_desc_record_return(struct bpf_verifier_env *env, struct bpf_verifi
 	return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
 }
 
+/*
+ * How many sections of @kind frame @f of @st is in: those entered since it
+ * was called, less those of its callers it left. A frame is entered with the
+ * sections its callers are in, which entry_*_locks counts, less the ones the
+ * frame or its callees have left since, which *_released_below counts.
+ */
+static int frame_sections(const struct bpf_verifier_state *st, int f, int kind)
+{
+	const struct bpf_func_state *frame = st->frame[f], *callee;
+	u32 entry, now;
+
+	entry = kind ? frame->entry_preempt_locks + frame->preempt_released_below :
+		       frame->entry_rcu_locks + frame->rcu_released_below;
+	if (f == st->curframe) {
+		now = kind ? st->active_preempt_locks : st->active_rcu_locks;
+	} else {
+		callee = st->frame[f + 1];
+		now = kind ? callee->entry_preempt_locks + callee->preempt_released_below :
+			     callee->entry_rcu_locks + callee->rcu_released_below;
+	}
+	return (int)now - (int)entry;
+}
+
+/*
+ * The places in the stack of frame @f of @st that hold the handle of @ref,
+ * which the frame owns, in @loc: the stack object the reference is of, or
+ * the slots a pointer to the object is spilled in. A lock has none. The slots
+ * a spill is removed from again, see bpf_remove_fastcall_spills_fills(), hold
+ * nothing at run time.
+ */
+static void ref_locations(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, int f,
+			  const struct bpf_reference_state *ref, struct bpf_res_loc *loc)
+{
+	const struct bpf_res_acq *acq = &env->res_acqs[ref->acq - 1];
+	const struct bpf_func_state *frame = st->frame[f];
+	s16 adj, lim = env->subprog_info[frame->subprogno].fastcall_stack_end;
+	const struct bpf_stack_state *slot;
+	int k;
+
+	loc->cnt = 0;
+	loc->obj = false;
+	if (ref->type & REF_TYPE_LOCK_MASK)
+		return;
+	for (k = 0; k < bpf_stack_nr_slots(frame) && loc->cnt < BPF_RES_LOC_MAX; k++) {
+		slot = bpf_stack_slot(frame, k);
+		adj = 0;
+		if (spi_off(k) < lim)
+			break;
+		if (stack_slot_is_object(slot, ref->id)) {
+			/* the handle of a dynptr is its first word, as when it was created */
+			if (slot->slot_type[BPF_REG_SIZE - 1] != STACK_DYNPTR) {
+				loc->obj = true;
+				loc->cnt = 0;
+			}
+		} else if (ref->type != REF_TYPE_PTR || (acq->flags & BPF_RES_F_ARG) ||
+			   !bpf_is_spilled_reg(slot) || !reg_ref_off(&slot->spilled_ptr, ref->id, &adj)) {
+			continue;
+		}
+		loc->at[loc->cnt].off = spi_off(k);
+		loc->at[loc->cnt++].adj = adj;
+		if (loc->obj)
+			break;
+	}
+}
+
+/*
+ * A throw may find frame @f of @st at the call @insn. Record what the frame
+ * keeps in its stack there, for the descriptor of the site: the visits of a
+ * site have to agree on it, since the site has one descriptor.
+ */
+static int site_visit(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, int f,
+		      u32 insn)
+{
+	struct bpf_res_loc cur, *loc;
+	struct bpf_res_site *site;
+	u32 i, j, k, n, s;
+
+	for (s = 0; s < env->res_site_cnt; s++)
+		if (env->res_sites[s].insn == insn)
+			break;
+	if (s == env->res_site_cnt) {
+		site = kvrealloc(env->res_sites, array_size(s + 1, sizeof(*site)), GFP_KERNEL_ACCOUNT);
+		if (!site)
+			return -ENOMEM;
+		env->res_sites = site;
+		site[s] = (struct bpf_res_site) { .insn = insn };
+		env->res_site_cnt = s + 1;
+	}
+	site = &env->res_sites[s];
+	for (k = 0; k < ARRAY_SIZE(site->sections); k++) {
+		int cnt = frame_sections(st, f, k);
+
+		if (!site->visits)
+			site->sections[k] = cnt;
+		else if (site->sections[k] != cnt)
+			site->sections_vary[k] = true;
+	}
+	site->visits++;
+	for (i = 0; i < st->acquired_refs; i++) {
+		const struct bpf_reference_state *ref = &st->refs[i];
+
+		if (ref->frameno != f || !ref->acq)
+			continue;
+		env->res_acqs[ref->acq - 1].held = true;
+		ref_locations(env, st, f, ref, &cur);
+		for (j = 0; j < env->res_loc_cnt; j++)
+			if (env->res_locs[j].site == s && env->res_locs[j].acq == ref->acq - 1)
+				break;
+		if (j == env->res_loc_cnt) {
+			loc = kvrealloc(env->res_locs, array_size(j + 1, sizeof(*loc)), GFP_KERNEL_ACCOUNT);
+			if (!loc)
+				return -ENOMEM;
+			env->res_locs = loc;
+			cur.site = s;
+			cur.acq = ref->acq - 1;
+			cur.visits = 1;
+			loc[j] = cur;
+			env->res_loc_cnt = j + 1;
+			continue;
+		}
+		/* the places this visit finds the handle in as well */
+		loc = &env->res_locs[j];
+		loc->visits++;
+		for (k = 0, n = 0; k < loc->cnt; k++) {
+			for (j = 0; j < cur.cnt; j++)
+				if (cur.at[j].off == loc->at[k].off && cur.at[j].adj == loc->at[k].adj)
+					break;
+			if (j < cur.cnt && cur.obj == loc->obj)
+				loc->at[n++] = loc->at[k];
+		}
+		loc->cnt = n;
+	}
+	return 0;
+}
+
+/*
+ * A throw may find the frames of @st where they are: the current one at
+ * @insn_idx, bpf_throw() or the call of a subprog that may throw, and each of
+ * its callers at the call it has not returned from. The frames that called a
+ * function verified on its own were recorded when they called it.
+ */
+int bpf_frame_desc_record_site(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			       int insn_idx)
+{
+	int f, err;
+
+	if (!env->describe_frames || st->speculative)
+		return 0;
+	for (f = st->curframe; f >= 0; f--) {
+		err = site_visit(env, st, f, f == st->curframe ? insn_idx : st->frame[f + 1]->callsite);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * A round of the main pass is dropped, see do_check_all(): what its paths
  * recorded goes with it.
@@ -702,6 +900,8 @@ void bpf_frame_desc_reset(struct bpf_verifier_env *env)
 	env->res_acq_cnt = 0;
 	env->res_rel_cnt = 0;
 	env->section_insn_cnt = 0;
+	env->res_site_cnt = 0;
+	env->res_loc_cnt = 0;
 	for (i = 0; i < env->prog->len; i++) {
 		env->insn_aux_data[i].res_none = false;
 		env->insn_aux_data[i].res_none_r0 = false;
@@ -713,10 +913,14 @@ void bpf_frame_desc_env_free(struct bpf_verifier_env *env)
 	kvfree(env->res_acqs);
 	kvfree(env->res_rels);
 	kvfree(env->section_insns);
+	kvfree(env->res_sites);
+	kvfree(env->res_locs);
 	kvfree(env->resources);
 	env->res_acqs = NULL;
 	env->res_rels = NULL;
 	env->section_insns = NULL;
+	env->res_sites = NULL;
+	env->res_locs = NULL;
 	env->resources = NULL;
 }
 
@@ -752,20 +956,6 @@ static int acq_subprog(struct bpf_verifier_env *env, const struct bpf_res_acq *a
 	return bpf_find_containing_subprog(env, new_of[a->insn]) - env->subprog_info;
 }
 
-static bool subprog_has_section(struct bpf_verifier_env *env, int subprog, const u32 *new_of, u8 kind)
-{
-	u32 i;
-
-	for (i = 0; i < env->section_insn_cnt; i++) {
-		const struct bpf_section_insn *si = &env->section_insns[i];
-
-		if (si->kind == kind &&
-		    bpf_find_containing_subprog(env, new_of[si->insn]) - env->subprog_info == subprog)
-			return true;
-	}
-	return false;
-}
-
 /* An upper bound of the insns put around one call for one acquisition or release. */
 #define RES_INSNS_MAX	6
 
@@ -809,22 +999,37 @@ static int emit_acquire_after(struct bpf_insn *buf, const struct bpf_res_acq *a)
 }
 
 /*
- * Reserve the hidden slots, once the pass has seen every frame: one for each
- * acquisition, in the frame of the subprog it is in, and a count of the
- * sections of a kind for a subprog that enters or leaves them. The subprogs
- * are numbered as they are now and looked up again whenever they are needed,
- * since removing a dead one renumbers them.
+ * Decide what needs a hidden slot, once the pass has seen every frame, and
+ * reserve it.
+ *
+ * A frame is unwound at a site, and the site has a descriptor for what every
+ * visit of it found in the same place of the frame's stack. So an
+ * acquisition needs no slot when no site finds a frame holding what it
+ * acquired, and none when every site that does finds the handle in a place
+ * all its visits agree on, on every visit. The others get a slot in the
+ * frame of the subprog they are in. Likewise a subprog counts its sections
+ * of a kind in a slot only when the visits of one of its sites differ in how
+ * many the frame is in.
+ *
+ * The subprogs are numbered as they are now and looked up again whenever
+ * they are needed, since removing a dead one renumbers them.
  */
 int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
 {
 	u32 i, k, orig_len, *new_of;
-	int s, ret = 0;
+	int ret = 0;
 
 	if (!env->res_acq_cnt && !env->section_insn_cnt)
 		return 0;
 	new_of = insns_of_pass(env, &orig_len);
 	if (!new_of)
 		return -ENOMEM;
+	for (i = 0; i < env->res_loc_cnt; i++) {
+		const struct bpf_res_loc *loc = &env->res_locs[i];
+
+		if (!loc->cnt || loc->visits != env->res_sites[loc->site].visits)
+			env->res_acqs[loc->acq].slot = true;
+	}
 	for (i = 0; i < env->res_acq_cnt && !ret; i++) {
 		struct bpf_res_acq *a = &env->res_acqs[i];
 
@@ -833,6 +1038,8 @@ int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
 			ret = -EFAULT;
 			break;
 		}
+		if (!a->slot)
+			continue;
 		/* some visit of the insn has nothing a slot can hold where this one has */
 		if (!(a->flags & BPF_RES_F_CTX) && acquires_sometimes(env, new_of[a->insn], a)) {
 			verbose(env, "frame_desc: insn %d acquires a resource on some paths only, or one of a type that cannot be released\n",
@@ -843,11 +1050,19 @@ int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
 		ret = bpf_reserve_stack_slots(env, acq_subprog(env, a, new_of), 1, &a->off);
 		env->frame_desc_slots++;
 	}
-	for (s = 0; s < env->subprog_cnt && !ret; s++) {
-		for (k = 0; k < ARRAY_SIZE(env->subprog_info[s].section_off) && !ret; k++) {
-			if (!subprog_has_section(env, s, new_of, k))
+	for (i = 0; i < env->res_site_cnt && !ret; i++) {
+		const struct bpf_res_site *site = &env->res_sites[i];
+		struct bpf_subprog_info *sub;
+
+		if (verifier_bug_if(site->insn >= orig_len, env, "site at insn %d", site->insn)) {
+			ret = -EFAULT;
+			break;
+		}
+		sub = bpf_find_containing_subprog(env, new_of[site->insn]);
+		for (k = 0; k < ARRAY_SIZE(sub->section_off) && !ret; k++) {
+			if (!site->sections_vary[k] || sub->section_off[k])
 				continue;
-			ret = bpf_reserve_stack_slots(env, s, 1, &env->subprog_info[s].section_off[k]);
+			ret = bpf_reserve_stack_slots(env, sub - env->subprog_info, 1, &sub->section_off[k]);
 			env->frame_desc_slots++;
 		}
 	}
@@ -961,9 +1176,9 @@ static int emit_items(struct bpf_verifier_env *env, const struct res_item *it, i
 
 /*
  * At the entry of each subprog: its slots and counts start out empty, and
- * the main program takes the references the kernel passed it from the
- * context, which R1 points at. The insns go in front of the first one, which
- * a jump to it skips.
+ * the main program takes the references the kernel passed it that it keeps
+ * in a slot from the context, which R1 points at. The insns go in front of
+ * the first one, which a jump to it skips.
  */
 static int emit_entries(struct bpf_verifier_env *env)
 {
@@ -984,7 +1199,7 @@ static int emit_entries(struct bpf_verifier_env *env)
 		for (i = 0; i < env->res_acq_cnt; i++) {
 			const struct bpf_res_acq *a = &env->res_acqs[i];
 
-			if (acq_subprog(env, a, new_of) != s)
+			if (!a->slot || acq_subprog(env, a, new_of) != s)
 				continue;
 			if (a->flags & BPF_RES_F_CTX) {
 				buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_1, a->obj_off);
@@ -1009,7 +1224,7 @@ static int emit_entries(struct bpf_verifier_env *env)
 }
 
 /*
- * Keep the slots and the counts up to date, through the patch list. What goes
+ * Keep the slots and the counts there are up to date, through the patch list. What goes
  * in front of a call is patched in with the call, so that the jumps to it
  * land on it; what follows it is inserted in front of the next insn, which a
  * jump to that insn skips, as it skips the call.
@@ -1030,13 +1245,19 @@ int bpf_frame_desc_emit(struct bpf_verifier_env *env)
 		ret = -ENOMEM;
 		goto out;
 	}
-	for (i = 0; i < env->section_insn_cnt; i++)
-		items[n++] = (struct res_item) { new_of[env->section_insns[i].insn], i, ITEM_SECTION };
+	/* what has no slot is kept by nothing */
+	for (i = 0; i < env->section_insn_cnt; i++) {
+		const struct bpf_section_insn *si = &env->section_insns[i];
+
+		if (bpf_find_containing_subprog(env, new_of[si->insn])->section_off[si->kind])
+			items[n++] = (struct res_item) { new_of[si->insn], i, ITEM_SECTION };
+	}
 	for (i = 0; i < env->res_rel_cnt; i++)
-		items[n++] = (struct res_item) { new_of[env->res_rels[i].insn], i, ITEM_RELEASE,
-						 env->res_rels[i].reg };
+		if (env->res_acqs[env->res_rels[i].acq].slot)
+			items[n++] = (struct res_item) { new_of[env->res_rels[i].insn], i, ITEM_RELEASE,
+							 env->res_rels[i].reg };
 	for (i = 0; i < env->res_acq_cnt; i++)
-		if (!(env->res_acqs[i].flags & BPF_RES_F_CTX))
+		if (env->res_acqs[i].slot && !(env->res_acqs[i].flags & BPF_RES_F_CTX))
 			items[n++] = (struct res_item) { new_of[env->res_acqs[i].insn], i, ITEM_ACQUIRE };
 	sort(items, n, sizeof(*items), item_cmp, NULL);
 	for (i = 0; i < n; i = k) {
@@ -1097,20 +1318,150 @@ static bool resource_goes_first(const struct bpf_resource *res)
 	return res->kind == BPF_RESOURCE_ITER || res->kind == BPF_RESOURCE_DYNPTR_FILE;
 }
 
+/* Add @d to the pool of the program, or free it when the pool has it: its index plus one. */
+static int pool_add(struct bpf_verifier_env *env, struct bpf_frame_desc *d)
+{
+	struct bpf_frame_desc_pool *pool = env->frame_desc_pool;
+	u32 i;
+
+	for (i = 0; i < pool->cnt; i++) {
+		if (pool->desc[i]->size != d->size || memcmp(pool->desc[i], d, d->size))
+			continue;
+		kvfree(d);
+		return i + 1;
+	}
+	pool = kvrealloc(pool, struct_size(pool, desc, pool->cnt + 1), GFP_KERNEL_ACCOUNT);
+	if (!pool) {
+		kvfree(d);
+		return -ENOMEM;
+	}
+	env->frame_desc_pool = pool;
+	pool->desc[pool->cnt] = d;
+	env->frame_desc_bytes += d->size;
+	return ++pool->cnt;
+}
+
+/*
+ * The descriptor of a subprog that has slots: the slot of each acquisition in
+ * it that has one, which holds the handle of what the acquisition acquired or
+ * NULL, and the counts of its sections.
+ */
+static int build_slots(struct bpf_verifier_env *env, int s, const u32 *new_of)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[s];
+	struct bpf_frame_desc *d;
+	u32 i, k, n = 0;
+	int res;
+
+	for (i = 0; i < env->res_acq_cnt; i++)
+		n += env->res_acqs[i].slot && acq_subprog(env, &env->res_acqs[i], new_of) == s;
+	for (k = 0; k < ARRAY_SIZE(sub->section_off); k++)
+		n += !!sub->section_off[k];
+	if (!n)
+		return 0;
+	d = kvzalloc(struct_size(d, ent, n), GFP_KERNEL_ACCOUNT);
+	if (!d)
+		return -ENOMEM;
+	d->size = struct_size(d, ent, n);
+	for (i = 0; i < env->res_acq_cnt; i++) {
+		const struct bpf_res_acq *a = &env->res_acqs[i];
+
+		if (!a->slot || acq_subprog(env, a, new_of) != s)
+			continue;
+		d->ent[d->nent++] = (struct bpf_frame_desc_entry) {
+			.res = a->res, .off = a->off,
+			.flags = resource_goes_first(&env->resources[a->res]) ? BPF_FRAME_ENT_FIRST : 0,
+		};
+	}
+	for (k = 0; k < ARRAY_SIZE(sub->section_off); k++) {
+		if (!sub->section_off[k])
+			continue;
+		res = resource_of_section(env, k);
+		if (res < 0) {
+			kvfree(d);
+			return res;
+		}
+		d->ent[d->nent++] = (struct bpf_frame_desc_entry) {
+			.res = res, .off = sub->section_off[k], .flags = BPF_FRAME_ENT_COUNTER,
+		};
+	}
+	res = pool_add(env, d);
+	if (res < 0)
+		return res;
+	sub->frame_desc = res;
+	return 0;
+}
+
+/*
+ * The descriptor of site @idx: where the frame at the site keeps, in its own
+ * stack, what it holds that has no slot, and how many sections it is in when
+ * its subprog does not count them. A site that has nothing to say has none.
+ */
+static int build_site(struct bpf_verifier_env *env, u32 idx, const u32 *new_of)
+{
+	struct bpf_res_site *site = &env->res_sites[idx];
+	const struct bpf_subprog_info *sub = bpf_find_containing_subprog(env, new_of[site->insn]);
+	struct bpf_frame_desc *d;
+	u32 i, k, n = 0;
+	int res;
+
+	for (i = 0; i < env->res_loc_cnt; i++)
+		n += env->res_locs[i].site == idx && !env->res_acqs[env->res_locs[i].acq].slot;
+	for (k = 0; k < ARRAY_SIZE(sub->section_off); k++)
+		n += !sub->section_off[k] && site->sections[k];
+	if (!n)
+		return 0;
+	d = kvzalloc(struct_size(d, ent, n), GFP_KERNEL_ACCOUNT);
+	if (!d)
+		return -ENOMEM;
+	d->size = struct_size(d, ent, n);
+	for (i = 0; i < env->res_loc_cnt; i++) {
+		const struct bpf_res_loc *loc = &env->res_locs[i];
+		const struct bpf_res_acq *a = &env->res_acqs[loc->acq];
+		u16 flags = loc->obj ? BPF_FRAME_ENT_OBJ : 0;
+
+		if (loc->site != idx || a->slot)
+			continue;
+		if (resource_goes_first(&env->resources[a->res]))
+			flags |= BPF_FRAME_ENT_FIRST;
+		d->ent[d->nent++] = (struct bpf_frame_desc_entry) {
+			.res = a->res, .off = loc->at[0].off, .adj = loc->at[0].adj, .flags = flags,
+		};
+	}
+	for (k = 0; k < ARRAY_SIZE(sub->section_off); k++) {
+		if (sub->section_off[k] || !site->sections[k])
+			continue;
+		res = resource_of_section(env, k);
+		if (res < 0) {
+			kvfree(d);
+			return res;
+		}
+		d->ent[d->nent++] = (struct bpf_frame_desc_entry) {
+			.res = res, .count = site->sections[k], .flags = BPF_FRAME_ENT_COUNT,
+		};
+	}
+	res = pool_add(env, d);
+	if (res < 0)
+		return res;
+	site->desc = res;
+	env->frame_desc_sites++;
+	return 0;
+}
+
 /*
- * The frame descriptor of every subprog that has slots: the slot of each of
- * its acquisitions, which holds the handle of what the acquisition acquired
- * or NULL, and the counts of its sections. The unwinder releases what the
- * slots of a frame hold in the order of the entries, within a phase: the
- * iterators and the readers of file dynptrs come before the references,
- * which they may be iterating over or reading. Identical descriptors share a
- * body in the pool of the program, which takes the resource classes over.
+ * The frame descriptors of the program: one for every subprog that has
+ * slots, and one for every site that says what the frame at it keeps in its
+ * own stack. The unwinder releases what a frame holds in the order of the
+ * entries, within a phase, but for the iterators and the readers of file
+ * dynptrs: they come before the references, which they may be iterating over
+ * or reading. Identical descriptors share a body in the pool of the program,
+ * which takes the resource classes over.
  */
 int bpf_frame_desc_build(struct bpf_verifier_env *env)
 {
-	u32 i, k, n, s, orig_len, *new_of;
 	struct bpf_frame_desc_pool *pool;
-	int res, ret = -ENOMEM;
+	u32 i, orig_len, *new_of;
+	int ret = -ENOMEM;
 
 	if (!env->res_acq_cnt && !env->section_insn_cnt)
 		return 0;
@@ -1121,66 +1472,88 @@ int bpf_frame_desc_build(struct bpf_verifier_env *env)
 		goto out;
 	}
 	env->frame_desc_pool = pool;
-	for (s = 0; s < env->subprog_cnt; s++) {
-		struct bpf_subprog_info *sub = &env->subprog_info[s];
-		struct bpf_frame_desc *d;
+	for (i = 0, ret = 0; i < env->subprog_cnt && !ret; i++)
+		ret = build_slots(env, i, new_of);
+	for (i = 0; i < env->res_site_cnt && !ret; i++)
+		ret = build_site(env, i, new_of);
+	if (ret)
+		goto out;
+	pool = env->frame_desc_pool;
+	pool->resources = env->resources;
+	pool->resource_cnt = env->resource_cnt;
+	env->frame_desc_bytes += env->resource_cnt * sizeof(*env->resources);
+	env->resources = NULL;
+out:
+	kvfree(new_of);
+	return ret;
+}
 
-		for (i = 0, n = 0; i < env->res_acq_cnt; i++)
-			n += acq_subprog(env, &env->res_acqs[i], new_of) == s;
-		for (k = 0; k < ARRAY_SIZE(sub->section_off); k++)
-			n += !!sub->section_off[k];
-		if (!n)
+static int site_cmp(const void *a, const void *b)
+{
+	const struct bpf_frame_desc_site *x = a, *y = b;
+
+	return x->off < y->off ? -1 : x->off > y->off;
+}
+
+/*
+ * The sites of @subprog that have a descriptor, for its JITed function, or
+ * NULL when it has none: each by the index of its call in the function, until
+ * the JIT has put the call somewhere, see bpf_prog_fill_frame_desc_sites().
+ * The insns of now are not those the pass named the sites by, and the insns
+ * put around a call name the call as well.
+ */
+struct bpf_frame_desc_sites *bpf_frame_desc_sites(struct bpf_verifier_env *env, int subprog)
+{
+	const struct bpf_subprog_info *sub = &env->subprog_info[subprog];
+	struct bpf_frame_desc_sites *tab;
+	u32 i, idx, n = 0, orig_len, *new_of;
+
+	for (i = 0; i < env->res_site_cnt; i++)
+		n += !!env->res_sites[i].desc;
+	if (!n)
+		return NULL;
+	new_of = insns_of_pass(env, &orig_len);
+	tab = kvzalloc(struct_size(tab, site, n), GFP_KERNEL_ACCOUNT);
+	if (!new_of || !tab) {
+		kvfree(new_of);
+		kvfree(tab);
+		return ERR_PTR(-ENOMEM);
+	}
+	for (i = 0; i < env->res_site_cnt; i++) {
+		const struct bpf_res_site *site = &env->res_sites[i];
+		const struct bpf_insn *insn;
+
+		if (!site->desc)
 			continue;
-		d = kvzalloc(struct_size(d, ent, n), GFP_KERNEL_ACCOUNT);
-		if (!d)
-			goto out;
-		d->size = struct_size(d, ent, n);
-		for (i = 0; i < 2 * env->res_acq_cnt; i++) {
-			const struct bpf_res_acq *a = &env->res_acqs[i % env->res_acq_cnt];
-			bool first = i < env->res_acq_cnt;
-
-			if (acq_subprog(env, a, new_of) != s ||
-			    resource_goes_first(&env->resources[a->res]) != first)
-				continue;
-			d->ent[d->nent++] = (struct bpf_frame_desc_entry) { .res = a->res, .off = a->off };
-		}
-		for (k = 0; k < ARRAY_SIZE(sub->section_off); k++) {
-			if (!sub->section_off[k])
-				continue;
-			res = resource_of_section(env, k);
-			if (res < 0) {
-				kvfree(d);
-				ret = res;
-				goto out;
+		idx = site->insn < orig_len ? new_of[site->insn] : 0;
+		for (;; idx--) {
+			insn = &env->prog->insnsi[idx];
+			if (env->insn_aux_data[idx].orig_idx != site->insn) {
+				idx = env->prog->len;
+				break;
 			}
-			d->ent[d->nent++] = (struct bpf_frame_desc_entry) {
-				.res = res, .off = sub->section_off[k], .flags = BPF_FRAME_ENT_COUNTER,
-			};
-		}
-		for (i = 0; i < pool->cnt; i++)
-			if (pool->desc[i]->size == d->size && !memcmp(pool->desc[i], d, d->size))
+			if ((BPF_CLASS(insn->code) == BPF_JMP && BPF_OP(insn->code) == BPF_CALL) || !idx)
 				break;
-		if (i < pool->cnt) {
-			kvfree(d);
-			sub->frame_desc = i + 1;
-			continue;
 		}
-		pool = kvrealloc(pool, struct_size(pool, desc, pool->cnt + 1), GFP_KERNEL_ACCOUNT);
-		if (!pool) {
-			kvfree(d);
-			goto out;
+		insn = idx < env->prog->len ? &env->prog->insnsi[idx] : NULL;
+		if (verifier_bug_if(!insn || BPF_CLASS(insn->code) != BPF_JMP ||
+				    BPF_OP(insn->code) != BPF_CALL, env,
+				    "site at insn %d is not a call", site->insn)) {
+			kvfree(new_of);
+			kvfree(tab);
+			return ERR_PTR(-EFAULT);
 		}
-		env->frame_desc_pool = pool;
-		pool->desc[pool->cnt] = d;
-		env->frame_desc_bytes += d->size;
-		sub->frame_desc = ++pool->cnt;
+		if (idx < sub->start || idx >= (sub + 1)->start)
+			continue;
+		tab->site[tab->cnt++] = (struct bpf_frame_desc_site) {
+			.off = idx - sub->start, .desc = site->desc - 1,
+		};
 	}
-	pool->resources = env->resources;
-	pool->resource_cnt = env->resource_cnt;
-	env->frame_desc_bytes += env->resource_cnt * sizeof(*env->resources);
-	env->resources = NULL;
-	ret = 0;
-out:
 	kvfree(new_of);
-	return ret;
+	if (!tab->cnt) {
+		kvfree(tab);
+		return NULL;
+	}
+	sort(tab->site, tab->cnt, sizeof(tab->site[0]), site_cmp, NULL);
+	return tab;
 }
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index ba1176dc868e..4ec834e31dff 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -16,7 +16,8 @@
  *
  * Inputs have to be at the same insn and cleaned with
  * bpf_clean_verifier_state(): dead registers and stack slots are the same on
- * both sides then, but for dynptrs, iterators and irq flags: they stay.
+ * both sides then, but for dynptrs, iterators and irq flags: they stay. So
+ * does what a program that may throw keeps for it, see bpf_frame_desc_keeps().
  */
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 8f357fee6104..33cf3376f276 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -129,6 +129,7 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 }
 
 static void __clean_func_state(struct bpf_verifier_env *env,
+			       const struct bpf_verifier_state *vst,
 			       struct bpf_func_state *st,
 			       u16 live_regs, int frame)
 {
@@ -168,6 +169,11 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 			    stype == STACK_IRQ_FLAG)
 				continue;
 
+			/* a throw finds what the frame holds through it, see frame_desc.c */
+			if (stype == STACK_SPILL &&
+			    bpf_frame_desc_keeps(env, vst, frame, &bpf_stack_slot(st, i)->spilled_ptr))
+				continue;
+
 			/*
 			 * Only scalar spills can be degraded to raw stack bytes
 			 * when their high half is dead. Pointer spills need the
@@ -209,7 +215,7 @@ int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 		u32 ip = bpf_frame_insn_idx(st, i);
 		u16 live_regs = env->insn_aux_data[ip].live_regs_before;
 
-		__clean_func_state(env, st->frame[i], live_regs, i);
+		__clean_func_state(env, st, st->frame[i], live_regs, i);
 	}
 	return 0;
 }
diff --git a/kernel/bpf/unwind.c b/kernel/bpf/unwind.c
index 3b488a4bd759..b8845d7a0220 100644
--- a/kernel/bpf/unwind.c
+++ b/kernel/bpf/unwind.c
@@ -3,7 +3,7 @@
  * Releasing what the frames of a BPF program hold when bpf_throw() discards
  * them. Before the exception callback takes over, the frames from the throw
  * up to the main program are walked once per phase of the release order, and
- * each frame releases what its frame descriptor says it holds of that phase,
+ * each frame releases what its frame descriptors say it holds of that phase,
  * see frame_desc.c.
  */
 #include <linux/bpf.h>
@@ -11,6 +11,57 @@
 #include <linux/filter.h>
 #include <linux/irqflags.h>
 
+/*
+ * Convert the instruction indices of the sites of a JITed function to native
+ * offsets. offsets[k] is the first byte of instruction k relative to image
+ * and offsets[prog->len] the end of the function, as for
+ * bpf_prog_update_insn_ptrs().
+ */
+void bpf_prog_fill_frame_desc_sites(struct bpf_prog *prog, const u32 *offsets, void *image)
+{
+	struct bpf_frame_desc_sites *tab = prog->aux->frame_desc_sites;
+	u32 i;
+
+	if (!tab || tab->filled)
+		return;
+	for (i = 0; i < tab->cnt; i++) {
+		struct bpf_frame_desc_site *site = &tab->site[i];
+
+		site->end = image + offsets[site->off + 1] - (void *)prog->bpf_func;
+		site->off = image + offsets[site->off] - (void *)prog->bpf_func;
+	}
+	tab->filled = true;
+}
+
+/*
+ * The descriptor of the site of @fn that @ip is in, or NULL when the site has
+ * none. A frame is at the call it has not returned from: @ip is the return
+ * address less one, since the return address may be the first byte of the
+ * next instruction.
+ */
+static const struct bpf_frame_desc *bpf_unwind_site(const struct bpf_prog_aux *fn,
+						    const struct bpf_prog *prog, u64 ip)
+{
+	const struct bpf_frame_desc_sites *tab = fn->frame_desc_sites;
+	u64 off = ip - (u64)(long)prog->bpf_func;
+	u32 l = 0, r, m;
+
+	if (!tab || !tab->filled)
+		return NULL;
+	/* The sites are disjoint and sorted: find the first one that ends after off. */
+	r = tab->cnt;
+	while (l < r) {
+		m = l + (r - l) / 2;
+		if (tab->site[m].end <= off)
+			l = m + 1;
+		else
+			r = m;
+	}
+	if (l == tab->cnt || tab->site[l].off > off)
+		return NULL;
+	return fn->frame_desc_pool->desc[tab->site[l].desc];
+}
+
 void bpf_frame_desc_pool_free(struct bpf_frame_desc_pool *pool)
 {
 	u32 i;
@@ -142,50 +193,81 @@ static u64 bpf_unwind_fp(const struct bpf_prog_aux *fn, u64 bp)
 }
 
 /*
- * Release what the slots of the frame of @prog hold of the phase of this
- * walk; @bp is its native frame pointer. The first walk sums the frame's
- * counts of sections for their phase, and releases the locks and IRQ flags
- * in two passes: the flags a frame saved with interrupts enabled, of which
- * it can have one at most, since every later save found them disabled, are
- * restored last, after the locks and the other flags in whatever order the
- * frame took them.
+ * Release what the entries of @d say a frame holds of the phase of this walk,
+ * the entries that go @first or the others; @fp is the R10 of the frame. The
+ * first walk sums the frame's counts of sections for their phase, and
+ * releases the locks and IRQ flags in two passes, see
+ * bpf_unwind_release_frame(): @late selects the flags saved with interrupts
+ * enabled.
+ */
+static void bpf_unwind_release_desc(struct bpf_unwind_ctx *ctx, const struct bpf_frame_desc_pool *pool,
+				    const struct bpf_frame_desc *d, u64 fp, bool first, bool late)
+{
+	bool locks = ctx->phase == BPF_UNWIND_PHASE_LOCKS;
+	void *handle;
+	u32 i;
+	int s;
+
+	for (i = 0; d && i < d->nent; i++) {
+		const struct bpf_frame_desc_entry *ent = &d->ent[i];
+		const struct bpf_resource *res = &pool->resources[ent->res];
+		u64 *loc = (u64 *)(long)(fp + ent->off);
+
+		if (ent->flags & (BPF_FRAME_ENT_COUNTER | BPF_FRAME_ENT_COUNT)) {
+			if (!locks || first || late)
+				continue;
+			s = section_index(res->kind);
+			ctx->section[s] = res;
+			ctx->nr_sections[s] += ent->flags & BPF_FRAME_ENT_COUNT ? ent->count : (s64)*loc;
+			continue;
+		}
+		if (release_phase(res) != ctx->phase || !(ent->flags & BPF_FRAME_ENT_FIRST) != !first)
+			continue;
+		if (ent->flags & BPF_FRAME_ENT_OBJ) {
+			handle = loc;
+		} else {
+			if (!*loc)
+				continue;
+			handle = (void *)(long)(*loc - ent->adj);
+		}
+		if (locks && late != (res->kind == BPF_RESOURCE_IRQ_FLAG &&
+				      !arch_irqs_disabled_flags(*(unsigned long *)handle)))
+			continue;
+		bpf_unwind_release(res, handle);
+	}
+}
+
+/*
+ * Release what the frame of @prog holds of the phase of this walk; @bp is its
+ * native frame pointer and @ip the address it returns to. The frame is
+ * described by the hidden slots of its function and by what the site it is at
+ * says of its stack; the entries that go first, an iterator or the reader of
+ * a file, of both come before the references they may be using. The locks and
+ * IRQ flags are released in two passes: the flags a frame saved with
+ * interrupts enabled, of which it can have one at most, since every later
+ * save found them disabled, are restored last, after the locks and the other
+ * flags in whatever order the frame took them.
  */
-static void bpf_unwind_release_frame(struct bpf_unwind_ctx *ctx, const struct bpf_prog *prog, u64 bp)
+static void bpf_unwind_release_frame(struct bpf_unwind_ctx *ctx, const struct bpf_prog *prog,
+				     u64 ip, u64 bp)
 {
 	const struct bpf_prog_aux *fn = bpf_prog_frame_aux(prog);
 	const struct bpf_frame_desc_pool *pool = fn->frame_desc_pool;
-	int passes = ctx->phase == BPF_UNWIND_PHASE_LOCKS ? 2 : 1, pass, s;
-	const struct bpf_frame_desc *d;
-	bool late;
+	int passes = ctx->phase == BPF_UNWIND_PHASE_LOCKS ? 2 : 1, pass, first;
+	const struct bpf_frame_desc *d, *site;
 	u64 fp;
-	u32 i;
 
-	if (!fn->frame_desc)
+	if (!pool)
+		return;
+	d = fn->frame_desc ? pool->desc[fn->frame_desc - 1] : NULL;
+	site = bpf_unwind_site(fn, prog, ip - 1);
+	if (!d && !site)
 		return;
-	d = pool->desc[fn->frame_desc - 1];
 	fp = bpf_unwind_fp(fn, bp);
 	for (pass = 0; pass < passes; pass++) {
-		for (i = 0; i < d->nent; i++) {
-			const struct bpf_frame_desc_entry *ent = &d->ent[i];
-			const struct bpf_resource *res = &pool->resources[ent->res];
-			u64 *slot = (u64 *)(long)(fp + ent->off);
-			void *handle = (void *)(long)*slot;
-
-			if (ent->flags & BPF_FRAME_ENT_COUNTER) {
-				if (ctx->phase != BPF_UNWIND_PHASE_LOCKS || pass)
-					continue;
-				s = section_index(res->kind);
-				ctx->section[s] = res;
-				ctx->nr_sections[s] += (s64)*slot;
-				continue;
-			}
-			if (!handle || release_phase(res) != ctx->phase)
-				continue;
-			late = res->kind == BPF_RESOURCE_IRQ_FLAG &&
-			       !arch_irqs_disabled_flags(*(unsigned long *)handle);
-			if (passes == 2 && late != (pass == 1))
-				continue;
-			bpf_unwind_release(res, handle);
+		for (first = 1; first >= 0; first--) {
+			bpf_unwind_release_desc(ctx, pool, d, fp, first, pass);
+			bpf_unwind_release_desc(ctx, pool, site, fp, first, pass);
 		}
 	}
 }
@@ -207,7 +289,7 @@ static bool bpf_unwind_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	if (!prog)
 		return !ctx->cnt;
 	ctx->cnt++;
-	bpf_unwind_release_frame(ctx, prog, bp);
+	bpf_unwind_release_frame(ctx, prog, ip, bp);
 	/* the main program is where the exception callback takes over */
 	return bpf_is_subprog(prog);
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4d85a42a18d5..cbe99c346731 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3727,6 +3727,7 @@ static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
 	 * fastcall_stack_off to a value smaller than any possible offset.
 	 */
 	subprog->fastcall_stack_off = S16_MIN;
+	subprog->fastcall_stack_end = S16_MIN;
 	/* reset fastcall aux flags within subprogram,
 	 * happens at most once per subprogram
 	 */
@@ -11847,6 +11848,18 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 			inherited_id(state, callee->stack_arg_regs[i].map_uid);
 	}
 
+	/*
+	 * A throw of the function finds the frames of the caller as they are
+	 * now: it has nothing that points to their stack.
+	 */
+	if (env->subprog_info[subprog].might_throw) {
+		err = bpf_frame_desc_record_site(env, state, insn_idx);
+		if (err) {
+			bpf_free_verifier_state(&entry, false);
+			return err;
+		}
+	}
+
 	account_current_path(env);
 	env->subprog_info[subprog].on_its_own = true;
 	err = bpf_flow_call(env, state, &entry, subprog, insn_idx);
@@ -20836,6 +20849,7 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 	else
 		subprog->keep_fastcall_stack = 1;
 	subprog->fastcall_stack_off = min(subprog->fastcall_stack_off, off);
+	subprog->fastcall_stack_end = max(subprog->fastcall_stack_end, off);
 }
 
 static int mark_fastcall_patterns(struct bpf_verifier_env *env)
@@ -20846,6 +20860,7 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
 	int s, i;
 
 	for (s = 0; s < env->subprog_cnt; ++s, ++subprog) {
+		subprog->fastcall_stack_end = S16_MIN;
 		/* find lowest stack spill offset used in this subprog */
 		lowest_off = 0;
 		for (i = subprog->start; i < (subprog + 1)->start; ++i) {
@@ -21072,7 +21087,8 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 	 * for exceptional exits.
 	 */
 	if (exception_exit)
-		return PROCESS_BPF_EXIT;
+		return bpf_frame_desc_record_site(env, env->cur_state, env->insn_idx) ?:
+		       PROCESS_BPF_EXIT;
 
 	if (env->cur_state->curframe) {
 		/* exit from nested function */
@@ -23742,8 +23758,8 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		env->max_states_per_insn, env->total_states,
 		env->peak_states);
 	if (env->log.level & BPF_LOG_STATS)
-		verbose(env, "frame descriptors: slots %u insns %u classes %u bytes %u\n",
-			env->frame_desc_slots, env->frame_desc_insns,
+		verbose(env, "frame descriptors: slots %u insns %u sites %u classes %u bytes %u\n",
+			env->frame_desc_slots, env->frame_desc_insns, env->frame_desc_sites,
 			env->frame_desc_pool ? env->frame_desc_pool->resource_cnt : env->resource_cnt,
 			env->frame_desc_bytes);
 }
-- 
2.53.0

