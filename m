Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401876;
	b=SDD3NbxaTw8Es2/2apUQ2/3LoU9bqAkKJKb0whpy/2r15acLvwkKIiXQ496lhCcwhHjX
	 1BCH6CrFI7FI1G1JM9B/7SQLa3cN2EZlc+SM/OaHY1Jf0j54AZL5WywJvl4RA8Yy3P3J/
	 GEUxe3+GUjrfALSuNeN/cKq6n6Z54GM9nKhHtyEzjq9yQk+IwoYEhH+kBBhLr558GQKCl
	 4OG2yHtDoDg6pvsrPVK5JuQOSgY7bbeH3HccDNxDxpJXh5LEy2dfK60HprFyeuVkXg61Y
	 hhgtT5SUPNzgmrPcE7dyXRxqR9T5TdW0j5OLBkmyEBvtI540zGt3jozU6OZXhCfMM8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=oydPTwytd59gzgKtyzlQezK0KC+epwAqIOAASLXdQjQ=;
	b=gdfOjvSagu9qZzvbJQNIsl7OO4MqoH9K00YHIS5bLNqkInRdByKZx705AMQ/s3IhU+JJ
	 nigaM1Ls6MGwYxyAPkG5P7EGgmLWtHscwZ37knXDY8gqez9m9JHonJXYpNdwqTV7TdOBQ
	 H5hiHZZCbFgZjOlQaDad/KLRXL4//TyDGItKJSCl8iduhBa2wm3Dpu3/RH+GrKRilOZU1
	 fSGBDsw7qvUBhFvtsN3c9qlpVvA5ePyaKQjUUUb/shSYsCuhZILWuL/RRXfHmJDVQf1uU
	 IKMl6AACGiFP6zrFTFJT3PTEnUBjTQsL+GkNLZC8etoQSQh8PsGj8+Po3yekC8OBHng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2i19blK;
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AD606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F1AD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2i19blK
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4b4e4d13850so11196655e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401874; x=1795006674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oydPTwytd59gzgKtyzlQezK0KC+epwAqIOAASLXdQjQ=;
        b=i2i19blKipxiJ/n+J2NSTRARNAoc/HoXevuKbit6qo+w77TXYqCiKv0HSu0WhIBEDA
         JGe9CedqHH1rLaHskLtYG5G994MsnbeYNzgNII97SshpFcgtlnvHN40/lBWqE2T9NiJf
         w3QGIwQO9w5z5jHBcBSXvMdB1PpUtw0gQPmRLlay4Pb5xWvUkoyynN+PSzHyIFIHNT7g
         NJXsdv+okXgNrAhUi2VBtuu9ydGPpPZFCvjxWuonm7GjUtbL2aszL6t30ISvycFEVxSc
         9mhmG8aCaFguaFjsNPQ2j65G+usDuy48RCCe8O4pNWXfGTh3sMdT2iv6OhgRfy9PC9Kv
         6c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401874; x=1795006674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oydPTwytd59gzgKtyzlQezK0KC+epwAqIOAASLXdQjQ=;
        b=QfajEyYs1Ws48IHNFSPJ39SL9V4CinTg69McDEjrkUnOt+QYPDHeSH7QB5q6PyFuEp
         mkmV5lYzlJWdtcOTLAW7UqGJzy11mIBzYznb9DgU69Rs/AWiXXl5XpJYaK3MVb92qqrg
         WQXp7C/6iep3sSFVcfqrYlHQH5pIsw15yo8zbRZ8rBBLStlvn9oXkRSSR8Jjiy9mreAa
         zrFXB9rLpyjaqM2MS99qe2agyJNrPVkjOlfDTQ/W/DSAQpYV8OKUf2t4MXF33KHsjrW+
         O0c8MDo3lvALo0s5kkR2Ec9PvGTQAIixsydXYK1ze2UvVxd7WjIeYot4432XAgx981Ht
         2fcg==
X-Gm-Message-State: APuU4Z9qXoNmNhiler8fhVMjzbojs1s00DFtbomOyJe5z60/+9ZWjMRu
	GqpHglj9aFnoXWjhRWmP2IZTQx/6snIwQ6YuPsLWTh7PkFm/NuWqEF9mh2ywyJ5r97g=
X-Gm-Gg: AYBFou01iuB37z3xg25ruG8nOtex4ZtHNKwsWjB6N6v+qixah5U1pXfXyW8vZJGej2D
	3O5UoBBnhW71R4hpdzjhTAIfgYPdoWUPylQ+EeWF3WvY9EWuHwPadMjXGt7lMcla8l7dz0rN3Mv
	eFnVK0kwKWuI6o+WNNKwaElX6cXNXFsdWe+bbuzknRfQAQ7NJ4cGnfbFPvWXJ0yjV9qcj2afzF1
	NdIua4RaUKco+XzpkKFI/A4ngta3thcekwKmFzy3fOVM/5zyRVgim1vHalgOnfV0S5OVVnC16Ux
	zxhhUF8fL3+GBHSFMmAHmuiFnqnxAlyEvbkhntGFBVH0mmOgmn7QeOXBBraJbmlqrv5w9PtmndW
	iQ3tbRJFN1fAehNLtgFfeHPJPcVstCwS37fZXw1ffwWLUrtCdkEszeci+Qf/IT1EqMLURuDXQZc
	gDxmEBdiKE09i+22BR6GzoLdfFkOJ5ShNWcqgDYdHe5cz3yEOtBjiN5f8CRN8hh0S/u6f1yfrzY
	9HlCEWzSWEDgkz6GhOGTUWsQ7Zes00IO2hbeP3A0oPZvkLp0/jFvyzVjYA06XXufgwrfIhbyOva
	DYefoh2Z6UxalR8jWKoare7PPwlb/J6J5tTPOnQpQZ6W5xjTKasIKjAlSkExnez5I388OUNo1LQ
	sCDC1EjZ6rBsuutXrCKyaug0T7D3D72VT4MUXbfdMxrG7o0d1TkGTtYhQ4ZeBG0AEfG+LKpyBOo
	jWldpRhPyEeuO6rg==
X-Received: by 2002:a05:600c:8b34:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4ba093775a9mr42927925e9.7.1794401874334;
        Wed, 11 Nov 2026 04:57:54 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fef1d0sm135244765e9.13.2026.11.11.04.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:53 -0800 (PST)
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
Subject: [PATCH bpf-next v1 15/29] bpf: Describe handles in registers at throw sites
Date: Wed, 11 Nov 2026 13:57:13 +0100
Message-ID: <cd23f7c9bbe266852c979693ad25d72fdfc95616.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=25241; i=memxor@gmail.com; h=from:subject:message-id; bh=lWrmvfBi4jNan3e7yp2Xc4SoUuL0xDd1j72r52HgP/s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzAI7raQdFt227oc/nSxTqL1WyDz5uMCzBedDH37Wi 2z33ynRUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkUhzEyTJQODFzY/WKWgaGL Ome0R9Z/h9SHBt2RLft+XZ458cCuAwz/Q7PXlm9SNalcM+f0i1D3zojZkUsNM5M3dkrdv7nrIjM nKwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently a site descriptor can only give locations on the stack. But a
compiler keeps a reference that lives across calls in R6-R9 unless it
runs out of them, and leaves it in whichever register it was in at a
bpf_throw(), which does not return. Such a reference takes a hidden slot,
with a store on acquire and a compare on release.

The unwinder has the registers of the throw site from the native entry
of bpf_throw(), and recovers the callee-saved registers of each frame for
the exception callback, see bpf_throw_caller_regs(). Do the same in the
walks that release resources, so that they have the registers of the
frame being unwound:

 - In the frame that called bpf_throw(), R0-R9 are the values that the
   entry captured.
 - When the walk moves from a frame to its caller, R6-R9 keep their
   values, except for those that the prologue of the frame saved, which
   are loaded from where it saved them. R0-R5 are unknown from then on.

Add BPF_FRAME_ENT_REG for a descriptor entry that gives a register, and
have the verifier record registers at a site along with stack slots:

 - R6-R9 of every frame in the state;
 - R0 and R2-R5 of the frame that calls bpf_throw(). R1 holds the
   cookie. For this, the site is recorded before the call clobbers the
   caller-saved registers.

A register is described like a stack slot: when every visit to the site
finds the handle in it. If both hold the handle, the stack slot is
preferred. Locks and stack objects are handled as before.

The verifier forgets the contents of a dead register where paths join,
as it does for stack slots. So a register that points to a resource held
by its frame is kept like such a slot: it is not cleaned, a state can
stand for another only if both have the same contents in it, and a join
keeps it only if both sides have it. Register liveness does not change.

The program no longer uses such a register, but inserted code must not
reuse it either. The expansion of a timed may_goto keeps the address of
its count in a dead register: make it pick one that no site describes.

Registers are described only on architectures with a native entry,
x86-64 and arm64.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  11 +++-
 include/linux/bpf_verifier.h |  14 +++--
 kernel/bpf/fixups.c          |   3 +-
 kernel/bpf/frame_desc.c      | 103 ++++++++++++++++++++++++++++-------
 kernel/bpf/helpers.c         |   2 +-
 kernel/bpf/join.c            |   3 +
 kernel/bpf/states.c          |  10 +++-
 kernel/bpf/unwind.c          |  29 ++++++++--
 kernel/bpf/verifier.c        |  13 ++++-
 9 files changed, 151 insertions(+), 37 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e8eda32bc05d..b157863cb952 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1873,6 +1873,11 @@ struct bpf_resource {
  *    slot of the frame, or a slot of the program's own stack that holds the
  *    pointer whenever the frame is at the site of the descriptor; the pointer
  *    may then point adj bytes into the object;
+ *  - with BPF_FRAME_ENT_REG a register instead of a location, which holds
+ *    such a pointer whenever the frame is at the site: off is its number. The
+ *    unwinder has R6 to R9 of every frame, and R0 to R5 of the one that
+ *    called bpf_throw(), where the architecture captures them, see
+ *    bpf_arch_throw_entry();
  *  - with BPF_FRAME_ENT_OBJ the resource itself, an iterator or saved IRQ
  *    flags the frame has on its stack whenever it is at the site;
  *  - with BPF_FRAME_ENT_COUNTER a hidden slot that holds a count of sections,
@@ -1885,12 +1890,14 @@ struct bpf_resource {
 #define BPF_FRAME_ENT_COUNT	BIT(2)
 /* Released before the other entries of the frame, which it may be using. */
 #define BPF_FRAME_ENT_FIRST	BIT(3)
+#define BPF_FRAME_ENT_REG	BIT(4)
 
 struct bpf_frame_desc_entry {
 	u16 res;	/* index into the program's resource classes */
 	u16 flags;	/* BPF_FRAME_ENT_* */
 	union {
 		s16 off;	/* the location, relative to the frame pointer */
+		s16 reg;	/* BPF_FRAME_ENT_REG */
 		s16 count;	/* BPF_FRAME_ENT_COUNT */
 	};
 	s16 adj;
@@ -4631,7 +4638,7 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 void bpf_prog_fill_frame_desc_sites(struct bpf_prog *prog, const u32 *offsets, void *image);
 void bpf_unwind_release(const struct bpf_resource *res, void *handle);
 void bpf_dynptr_file_free(void *reader);
-void bpf_unwind_release_frames(void);
+void bpf_unwind_release_frames(const struct bpf_throw_regs *regs);
 void bpf_frame_desc_pool_free(struct bpf_frame_desc_pool *pool);
 #else
 static inline void
@@ -4645,7 +4652,7 @@ bpf_prog_fill_frame_desc_sites(struct bpf_prog *prog, const u32 *offsets, void *
 static inline void bpf_frame_desc_pool_free(struct bpf_frame_desc_pool *pool)
 {
 }
-static inline void bpf_unwind_release_frames(void)
+static inline void bpf_unwind_release_frames(const struct bpf_throw_regs *regs)
 {
 }
 #endif
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ca50c85006d7..158e7eddc19f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1273,8 +1273,8 @@ struct bpf_res_acq {
 	bool slot;	/* and some site cannot say where: the handle is kept in a slot */
 };
 
-/* How many places of its stack a site remembers a frame keeping one handle in. */
-#define BPF_RES_LOC_MAX		3
+/* How many places a site remembers a frame keeping one handle in. */
+#define BPF_RES_LOC_MAX		4
 
 /*
  * A site: a call a frame can be unwound at, bpf_throw() or the call of a
@@ -1292,7 +1292,8 @@ struct bpf_res_site {
 
 /*
  * Where the frame at a site keeps the handle of what an acquisition acquired:
- * the slots of its stack that every visit holding it found the handle in.
+ * the slots of its stack and the registers that every visit holding it found
+ * the handle in.
  */
 struct bpf_res_loc {
 	u32 site;	/* index of the site */
@@ -1301,8 +1302,9 @@ struct bpf_res_loc {
 	u8 cnt;		/* the places left */
 	bool obj;	/* they are the resource itself, an object on the stack */
 	struct {
-		s16 off;	/* relative to R10 */
+		s16 off;	/* relative to R10, or the number of the register */
 		s16 adj;	/* the pointer there points that many bytes into the object */
+		bool reg;
 	} at[BPF_RES_LOC_MAX];
 };
 
@@ -1374,6 +1376,8 @@ struct bpf_verifier_env {
 	u32 frame_desc_insns;			/* instructions keeping them up to date */
 	u32 frame_desc_bytes;			/* descriptors and resource classes */
 	bool describe_frames;			/* frame descriptors are generated: the program may throw */
+	bool describe_regs;			/* and may name registers, see bpf_arch_throw_entry() */
+	u16 frame_desc_regs;			/* the registers that some site names */
 	int exception_callback_subprog;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
@@ -2332,6 +2336,8 @@ int bpf_frame_desc_record_section(struct bpf_verifier_env *env, u8 kind, s8 delt
 int bpf_frame_desc_record_exit(struct bpf_verifier_env *env);
 bool bpf_frame_desc_keeps(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			  int f, const struct bpf_reg_state *reg);
+u16 bpf_frame_desc_kept_regs(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			     int f);
 int bpf_frame_desc_record_site(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			       int insn_idx);
 int bpf_frame_desc_record_return(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 0dfb33bb8bb8..b02ba82f5d10 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2985,7 +2985,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		if (bpf_is_may_goto_insn(insn) && timed_may_goto) {
-			u16 live = env->insn_aux_data[i].live_regs_before;
+			/* a site of a program that throws reads a register the program is done with */
+			u16 live = env->insn_aux_data[i].live_regs_before | env->frame_desc_regs;
 			int reg, save_off = 0;
 
 			/* a register that is dead here holds the address of the count */
diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
index b09cd868d8d9..5cb837688f90 100644
--- a/kernel/bpf/frame_desc.c
+++ b/kernel/bpf/frame_desc.c
@@ -7,11 +7,16 @@
  * A frame is unwound at a site: the call it has not returned from,
  * bpf_throw() or the call of a subprog that may throw. The main pass visits a
  * site with every state a frame can be in there, and records what the frame
- * keeps in its own stack on each visit: the iterators and saved IRQ flags it
- * holds, which are on its stack, the slots a reference it holds is spilled
- * in, and how many RCU read and preemption disabled sections it is in. What
- * every visit finds in the same place goes into the descriptor of the site,
- * and costs the program nothing.
+ * keeps where on each visit: the iterators and saved IRQ flags it holds,
+ * which are on its stack, the slots a reference it holds is spilled in and
+ * the registers that hold it, and how many RCU read and preemption disabled
+ * sections it is in. What every visit finds in the same place goes into the
+ * descriptor of the site, and costs the program nothing.
+ *
+ * The unwinder has the registers of a frame where bpf_throw() has a native
+ * entry that captures those of the throw site, see bpf_arch_throw_entry(): R6
+ * to R9 of every frame, which are callee-saved and recovered from where the
+ * frames above saved them, and R0 to R5 of the frame that throws.
  *
  * What the visits of some site do not agree on is written down when it is
  * acquired, in a hidden stack slot. Nothing is inferred about where the
@@ -287,6 +292,25 @@ bool bpf_frame_desc_keeps(const struct bpf_verifier_env *env, const struct bpf_v
 	return false;
 }
 
+/* The registers of frame @f of @st that are kept, see bpf_frame_desc_keeps(). */
+u16 bpf_frame_desc_kept_regs(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			     int f)
+{
+	u16 kept = 0;
+	int i;
+
+	if (!env->describe_regs)
+		return 0;
+	/* the registers a site names: R6 to R9, and all but R1 of the frame that throws */
+	for (i = BPF_REG_0; i < BPF_REG_FP; i++) {
+		if (i == BPF_REG_1 || (i < BPF_REG_6 && f != st->curframe))
+			continue;
+		if (bpf_frame_desc_keeps(env, st, f, &st->frame[f]->regs[i]))
+			kept |= BIT(i);
+	}
+	return kept;
+}
+
 /*
  * Is @slot the stack object of reference @id: the first slot of an iterator,
  * of a ringbuf dynptr, which tracks the record's reference as its parent,
@@ -757,14 +781,26 @@ static int frame_sections(const struct bpf_verifier_state *st, int f, int kind)
 }
 
 /*
- * The places in the stack of frame @f of @st that hold the handle of @ref,
- * which the frame owns, in @loc: the stack object the reference is of, or
- * the slots a pointer to the object is spilled in. A lock has none. The slots
- * a spill is removed from again, see bpf_remove_fastcall_spills_fills(), hold
- * nothing at run time.
+ * The registers the unwinder can read of a frame: R6 to R9 are callee-saved,
+ * so it has them for a frame that is in a call as well. The others it has for
+ * the frame that calls bpf_throw() only; R1 is the cookie there.
+ */
+static const u8 site_regs[] = {
+	BPF_REG_6, BPF_REG_7, BPF_REG_8, BPF_REG_9,
+	BPF_REG_0, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5,
+};
+
+/*
+ * The places of frame @f of @st that hold the handle of @ref, which the frame
+ * owns, in @loc: the stack object the reference is of, or the slots of the
+ * stack a pointer to the object is spilled in and the registers that hold
+ * one, see site_regs; @throws when the frame calls bpf_throw(). A lock has
+ * none. The slots a spill is removed from again, see
+ * bpf_remove_fastcall_spills_fills(), hold nothing at run time.
  */
 static void ref_locations(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, int f,
-			  const struct bpf_reference_state *ref, struct bpf_res_loc *loc)
+			  const struct bpf_reference_state *ref, bool throws,
+			  struct bpf_res_loc *loc)
 {
 	const struct bpf_res_acq *acq = &env->res_acqs[ref->acq - 1];
 	const struct bpf_func_state *frame = st->frame[f];
@@ -792,20 +828,31 @@ static void ref_locations(struct bpf_verifier_env *env, const struct bpf_verifie
 			continue;
 		}
 		loc->at[loc->cnt].off = spi_off(k);
+		loc->at[loc->cnt].reg = false;
 		loc->at[loc->cnt++].adj = adj;
 		if (loc->obj)
-			break;
+			return;
+	}
+	if (!env->describe_regs || ref->type != REF_TYPE_PTR || (acq->flags & BPF_RES_F_ARG))
+		return;
+	for (k = 0; k < (throws ? ARRAY_SIZE(site_regs) : 4) && loc->cnt < BPF_RES_LOC_MAX; k++) {
+		if (!reg_ref_off(&frame->regs[site_regs[k]], ref->id, &adj))
+			continue;
+		loc->at[loc->cnt].off = site_regs[k];
+		loc->at[loc->cnt].reg = true;
+		loc->at[loc->cnt++].adj = adj;
 	}
 }
 
 /*
  * A throw may find frame @f of @st at the call @insn. Record what the frame
- * keeps in its stack there, for the descriptor of the site: the visits of a
- * site have to agree on it, since the site has one descriptor.
+ * keeps where there, for the descriptor of the site: the visits of a site
+ * have to agree on it, since the site has one descriptor.
  */
 static int site_visit(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, int f,
 		      u32 insn)
 {
+	bool throws = f == st->curframe && bpf_is_throw_kfunc(&env->prog->insnsi[insn]);
 	struct bpf_res_loc cur, *loc;
 	struct bpf_res_site *site;
 	u32 i, j, k, n, s;
@@ -837,7 +884,7 @@ static int site_visit(struct bpf_verifier_env *env, const struct bpf_verifier_st
 		if (ref->frameno != f || !ref->acq)
 			continue;
 		env->res_acqs[ref->acq - 1].held = true;
-		ref_locations(env, st, f, ref, &cur);
+		ref_locations(env, st, f, ref, throws, &cur);
 		for (j = 0; j < env->res_loc_cnt; j++)
 			if (env->res_locs[j].site == s && env->res_locs[j].acq == ref->acq - 1)
 				break;
@@ -858,7 +905,8 @@ static int site_visit(struct bpf_verifier_env *env, const struct bpf_verifier_st
 		loc->visits++;
 		for (k = 0, n = 0; k < loc->cnt; k++) {
 			for (j = 0; j < cur.cnt; j++)
-				if (cur.at[j].off == loc->at[k].off && cur.at[j].adj == loc->at[k].adj)
+				if (cur.at[j].off == loc->at[k].off && cur.at[j].adj == loc->at[k].adj &&
+				    cur.at[j].reg == loc->at[k].reg)
 					break;
 			if (j < cur.cnt && cur.obj == loc->obj)
 				loc->at[n++] = loc->at[k];
@@ -872,7 +920,9 @@ static int site_visit(struct bpf_verifier_env *env, const struct bpf_verifier_st
  * A throw may find the frames of @st where they are: the current one at
  * @insn_idx, bpf_throw() or the call of a subprog that may throw, and each of
  * its callers at the call it has not returned from. The frames that called a
- * function verified on its own were recorded when they called it.
+ * function verified on its own were recorded when they called it. The
+ * registers of the frame that calls bpf_throw() have to be those it calls it
+ * with: the state is the one in front of the call.
  */
 int bpf_frame_desc_record_site(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			       int insn_idx)
@@ -1030,6 +1080,18 @@ int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
 		if (!loc->cnt || loc->visits != env->res_sites[loc->site].visits)
 			env->res_acqs[loc->acq].slot = true;
 	}
+	/*
+	 * A register that a site names holds the handle from where the program
+	 * read it for the last time: the program is done with it, but nothing
+	 * that is inserted later may use it, see bpf_do_misc_fixups().
+	 */
+	for (i = 0; i < env->res_loc_cnt; i++) {
+		const struct bpf_res_loc *loc = &env->res_locs[i];
+
+		for (k = 0; !env->res_acqs[loc->acq].slot && k < loc->cnt; k++)
+			if (loc->at[k].reg)
+				env->frame_desc_regs |= BIT(loc->at[k].off);
+	}
 	for (i = 0; i < env->res_acq_cnt && !ret; i++) {
 		struct bpf_res_acq *a = &env->res_acqs[i];
 
@@ -1394,8 +1456,9 @@ static int build_slots(struct bpf_verifier_env *env, int s, const u32 *new_of)
 
 /*
  * The descriptor of site @idx: where the frame at the site keeps, in its own
- * stack, what it holds that has no slot, and how many sections it is in when
- * its subprog does not count them. A site that has nothing to say has none.
+ * stack or in a register, what it holds that has no slot, and how many
+ * sections it is in when its subprog does not count them. A site that has
+ * nothing to say has none.
  */
 static int build_site(struct bpf_verifier_env *env, u32 idx, const u32 *new_of)
 {
@@ -1424,6 +1487,8 @@ static int build_site(struct bpf_verifier_env *env, u32 idx, const u32 *new_of)
 			continue;
 		if (resource_goes_first(&env->resources[a->res]))
 			flags |= BPF_FRAME_ENT_FIRST;
+		if (loc->at[0].reg)
+			flags |= BPF_FRAME_ENT_REG;
 		d->ent[d->nent++] = (struct bpf_frame_desc_entry) {
 			.res = a->res, .off = loc->at[0].off, .adj = loc->at[0].adj, .flags = flags,
 		};
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 793eb457fb62..648443e8f009 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3493,7 +3493,7 @@ notrace void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie)
 	if (regs)
 		memcpy(ctx.saved, &regs->r[BPF_REG_6], sizeof(ctx.saved));
 	/* What the frames about to be discarded hold is released first. */
-	bpf_unwind_release_frames();
+	bpf_unwind_release_frames(regs);
 	arch_bpf_stack_walk(bpf_stack_walker, &ctx);
 	WARN_ON_ONCE(!ctx.aux);
 	if (ctx.aux)
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 4ec834e31dff..180b0a96029c 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -663,6 +663,9 @@ int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst
 			u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
 			u32 cnt;
 
+			/* the registers both keep for a throw are joined, see bpf_frame_desc_keeps() */
+			live_regs |= bpf_frame_desc_kept_regs(env, a, fr) &
+				     bpf_frame_desc_kept_regs(env, b, fr);
 			/* not the states that get to the head through a call of the function */
 			frame = a->frame[fr];
 			cnt = frame->loop_stack_cnt;
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 33cf3376f276..5a773bfb9e84 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -215,6 +215,8 @@ int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 		u32 ip = bpf_frame_insn_idx(st, i);
 		u16 live_regs = env->insn_aux_data[ip].live_regs_before;
 
+		/* a throw finds what the frame holds through them, see frame_desc.c */
+		live_regs |= bpf_frame_desc_kept_regs(env, st, i);
 		__clean_func_state(env, st, st->frame[i], live_regs, i);
 	}
 	return 0;
@@ -691,9 +693,10 @@ static bool loop_stack_safe(struct bpf_verifier_env *env, struct bpf_func_state
  * the type in the current state is meaningful.
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, u32 insn_idx)
+			      struct bpf_func_state *cur, u32 insn_idx, u16 kept)
 {
-	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
+	/* and the registers that @old keeps for a throw, see bpf_frame_desc_keeps() */
+	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before | kept;
 	u16 i;
 
 	if (old->callback_depth > cur->callback_depth)
@@ -781,7 +784,8 @@ bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state
 		insn_idx = bpf_frame_insn_idx(old, i);
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
-		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx))
+		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx,
+				       bpf_frame_desc_kept_regs(env, old, i)))
 			return false;
 	}
 
diff --git a/kernel/bpf/unwind.c b/kernel/bpf/unwind.c
index b8845d7a0220..473897c3aff7 100644
--- a/kernel/bpf/unwind.c
+++ b/kernel/bpf/unwind.c
@@ -179,6 +179,13 @@ struct bpf_unwind_ctx {
 	/* The sections the frames hold, per kind, summed by the first walk. */
 	const struct bpf_resource *section[BPF_UNWIND_NR_SECTIONS];
 	s64 nr_sections[BPF_UNWIND_NR_SECTIONS];
+	/*
+	 * The registers of the frame the walk is at, when the entry of
+	 * bpf_throw() captured those of the throw site: the callee-saved ones,
+	 * and R0 to R5 while the walk is at the frame that threw.
+	 */
+	const struct bpf_throw_regs *entry;
+	struct bpf_throw_regs regs;
 };
 
 /*
@@ -212,6 +219,7 @@ static void bpf_unwind_release_desc(struct bpf_unwind_ctx *ctx, const struct bpf
 		const struct bpf_frame_desc_entry *ent = &d->ent[i];
 		const struct bpf_resource *res = &pool->resources[ent->res];
 		u64 *loc = (u64 *)(long)(fp + ent->off);
+		u64 val;
 
 		if (ent->flags & (BPF_FRAME_ENT_COUNTER | BPF_FRAME_ENT_COUNT)) {
 			if (!locks || first || late)
@@ -226,9 +234,13 @@ static void bpf_unwind_release_desc(struct bpf_unwind_ctx *ctx, const struct bpf
 		if (ent->flags & BPF_FRAME_ENT_OBJ) {
 			handle = loc;
 		} else {
-			if (!*loc)
+			/* no descriptor names a register that was not captured */
+			if ((ent->flags & BPF_FRAME_ENT_REG) && WARN_ON_ONCE(!ctx->entry))
+				continue;
+			val = ent->flags & BPF_FRAME_ENT_REG ? ctx->regs.r[ent->reg] : *loc;
+			if (!val)
 				continue;
-			handle = (void *)(long)(*loc - ent->adj);
+			handle = (void *)(long)(val - ent->adj);
 		}
 		if (locks && late != (res->kind == BPF_RESOURCE_IRQ_FLAG &&
 				      !arch_irqs_disabled_flags(*(unsigned long *)handle)))
@@ -290,6 +302,8 @@ static bool bpf_unwind_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 		return !ctx->cnt;
 	ctx->cnt++;
 	bpf_unwind_release_frame(ctx, prog, ip, bp);
+	/* the walk leaves the frame for its caller, which has R6 to R9 as it left them */
+	bpf_throw_caller_regs(bpf_prog_frame_aux(prog), bp, &ctx->regs.r[BPF_REG_6]);
 	/* the main program is where the exception callback takes over */
 	return bpf_is_subprog(prog);
 }
@@ -302,16 +316,21 @@ static bool bpf_unwind_walker(void *cookie, u64 ip, u64 sp, u64 bp)
  * each frame's entries of the phase in the order of its descriptor; the
  * frames are released as the walk passes them, so their number is not
  * bounded. The sections need no walk of their own: the first one summed
- * their counts, and sections of one kind are all the same.
+ * their counts, and sections of one kind are all the same. @regs are the
+ * registers of the frame that called bpf_throw(), or NULL when the
+ * architecture does not capture them.
  */
-void bpf_unwind_release_frames(void)
+void bpf_unwind_release_frames(const struct bpf_throw_regs *regs)
 {
-	struct bpf_unwind_ctx ctx = {};
+	struct bpf_unwind_ctx ctx = { .entry = regs };
 	int s;
 
 	for (ctx.phase = 0; ctx.phase < BPF_UNWIND_NR_PHASES; ctx.phase++) {
 		if (ctx.phase != BPF_UNWIND_PHASE_SECTIONS) {
 			ctx.cnt = 0;
+			/* every walk starts at the throw site */
+			if (regs)
+				ctx.regs = *regs;
 			arch_bpf_stack_walk(bpf_unwind_walker, &ctx);
 			continue;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cbe99c346731..b32c5a4f844f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12217,6 +12217,10 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				verbose(env, "failed to push state for global subprog exception path\n");
 				return PTR_ERR(branch);
 			}
+			/* a throw of the subprog finds the frames as they are at the call */
+			err = bpf_frame_desc_record_site(env, env->cur_state, *insn_idx);
+			if (err)
+				return err;
 			return process_bpf_exit_full(env, NULL, true);
 		}
 
@@ -16477,6 +16481,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			if (err < 0)
 				return err;
 		}
+		/* with the registers the frame calls it with, which the call clobbers */
+		err = bpf_frame_desc_record_site(env, env->cur_state, insn_idx);
+		if (err)
+			return err;
 	}
 
 	bpf_diag_record_caller_saved(env, regs);
@@ -21087,8 +21095,7 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 	 * for exceptional exits.
 	 */
 	if (exception_exit)
-		return bpf_frame_desc_record_site(env, env->cur_state, env->insn_idx) ?:
-		       PROCESS_BPF_EXIT;
+		return PROCESS_BPF_EXIT;
 
 	if (env->cur_state->curframe) {
 		/* exit from nested function */
@@ -25710,6 +25717,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	 */
 	for (i = 0; bpf_jit_supports_exception_cleanup() && i < env->subprog_cnt; i++)
 		env->describe_frames |= env->subprog_info[i].might_throw;
+	/* the unwinder has the registers of the frames where bpf_throw() has a native entry */
+	env->describe_regs = env->describe_frames && bpf_arch_throw_entry();
 
 	ret = check_unwind_insns(env);
 	if (ret < 0)
-- 
2.53.0

