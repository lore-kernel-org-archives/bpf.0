Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98B4A263C
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542916; cv=none; b=cLQ2kgn/vsa9QLFz0YrcTIlbm9cxjMbAxpZA43cugh5eFHDUciCV1EndDwMEQ5+pBxrhAVzTOh/yn7Eq13ymRusEqfzeRXTBQS8R2wtWl7egOBg7FHQxWaMmGa+g63PS973j6oGa0mR6CzeMbauv8m0luDC6vjmYf58t2e1Vb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542916; c=relaxed/simple;
	bh=6V61tebFGob07wFLsAj3jEMkzJhVtlKSG0EeaKoAgHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rToF8QnYQGDCJx231lYl50XUxHsXTHCLPgAHq/QuutjMmOmkt/N/rApEpXIu9IW+aPvgJQNfqayitmO9SeVEzufSU/xhCfyo+s+Qh/sIfU7TGqbD+JgSuMR1tp4JsZd1btMqe7mS/uy68VK8WxLwQEA2012l4bChzJoLFIj1elE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCtCN6gN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCtCN6gN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d6d28aa26cso30637415ad.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542904; x=1792147704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mhkIFp2G/gfdsmhxskXUOEGulX5UGaS14ZS1T0vbLTA=;
        b=MCtCN6gNrrBy7SJ6N0y08s6of51nAeJKXoTZk7Hzj1LTG5Z6+Yi9gJxs7EvgnYwG+C
         Vo/XPmuhNS6evSAb79DL/LGgM3WLOSRTdhSWpqOVhLetThybBjp+EuXOCGldIk4jq6Xt
         DIuFXa7Rgt1r31yHl33TMUbbfF4SwnA2ILtw8pgXhFg6Z3Y6QGX/QWvEXfF2K7U9I57x
         unMM8euTjBKOUp8p4fuXVzr18yeoeEvGK9IUUd9aRLs6IiA+Fk8eRb3neGAlMiG6wQsL
         BTh7WGu1lkZxHdGvhmzZzkFYOTRrrPnY+tTBp08EMe4gXK6gXZ/UJC0tdj8clJiBW9+C
         sXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542904; x=1792147704;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mhkIFp2G/gfdsmhxskXUOEGulX5UGaS14ZS1T0vbLTA=;
        b=PPQzIVHTOVM50UN29q3VqAa6yfrDuEWvLvxUZL0gPf2S7S7cnHdO5Exvq49mXqpQkd
         FovA7rr92V7qH26BdUylLeVZbJG5z+f9QVz0RiIBNqaT/vS/ds9/0BjTQ/e497tYuasK
         V/CJ2ikIpiKLxhk35qJB5nMW0BnCS9FCMCeiALzh/YqC/nfhM6Q2lKKXxCAUfitFcdJS
         mPrcMP00BAyqgdPDhD77hG/Aw/4TuFNZFf8RA9o2F9zN1T3xzklbCPbvrZJ499TI2b3n
         4zdMqjz8bJ6gJkE5q80FqaUSNIcj3SNV1jnLg9u9s3FX9hRiKTK/4unG2VJWzwrYByAE
         Xq0Q==
X-Gm-Message-State: AFq9FYIqLaPFKB336FhYtHiwCD6oSBdQTrUvaMEXWwXVkrQ82uhpeV8X
	PmndDgbhN++yPp1fphzYqVltxMQ1W0vZDVcC1ndb8ZFetdXGAoXkqZ1Rah8Q2tE+
X-Gm-Gg: AYBFou1GlfmlvFk9r9OfN7XX6sudmiu8vtkXf9x2NmjQl8NtRI0aMVH4gEOgHe5whXA
	0aNd8PR7Jk21AtynyTCiwibliGRr3ga1uDiRa0r9bDBncOYy7CPTH//gLfmnDuGIGPPgMPfOb+w
	x0H+b5kXsheXZsW3pUMjoZDRQ0p+s8TFCzrEWlnb9utDRRUiS3zzdpkhjPGypEsjFsRqu4RDAy7
	4+BABC6JYYvVGfYkhGHzO/IAqeiH/E3GixW+a889a7eqd6TNPVwVeUTyoqzbuiYEhh0NNUwFk4X
	JI4YV6IemUISox+ZnXxdxIEbhPyN7WrLqagNmSY/9ybDN1lLiS8xL6aANhbEKFdn02nJYQP8yz0
	lcYf+5axnT+qIOBtaai0NPZ+hFzb0J3HjhxgP5kidsthpCZqPAFSgt5u1SR118w23Wjv4kR2rX0
	wDWL5rQBVOgNVLk18f3pk/doe/eJAQrReweS3B/+7PA1rAfBYKoBo6UcRbjYuwsVzXO69exmgXr
	kvtVExY85l02lw=
X-Received: by 2002:a17:90b:2ec4:b0:3a0:cb48:df6b with SMTP id 98e67ed59e1d1-3ab3a955ad2mr1341005a91.34.1791542904284;
        Fri, 09 Oct 2026 03:48:24 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 09/51] bpf: fix arg_track_xfer() for atomic stack spills and fills
Date: Fri,  9 Oct 2026 03:47:27 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-9-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Track spilled stack pointers through 64-bit atomic accesses:
- BPF_STORE_REL spills the source register.
- BPF_LOAD_ACQ restores the spilled value into dst_reg.
- BPF_XCHG and BPF_{ADD,AND,OR,XOR} | BPF_FETCH restore it into src_reg.
- BPF_CMPXCHG restores it into R0.

This prevents missing stack accesses through pointers recovered by these
instructions, matching the main verifier's spill/fill behavior.

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 91 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index ce74e3f16eef..52c39bbee6b1 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1357,6 +1357,29 @@ static bool can_be_local_fp(int depth, int regno, struct arg_track *at)
 	       (at->frame == ARG_IMPRECISE && (at->mask & BIT(depth)));
 }
 
+/*
+ * Model 8-byte reads through @reg, including load-acquire
+ * and the old value fetched by atomic operations.
+ */
+static struct arg_track arg_track_deref(struct bpf_verifier_env *env, struct bpf_insn *insn,
+					struct arg_track *at_out, int reg,
+					struct arg_track *at_stack_out, u32 nslots,
+					int depth, u32 *callsites)
+{
+	struct arg_track *ptr = &at_out[reg];
+
+	if (can_be_local_fp(depth, reg, ptr))
+		return fill_from_stack(insn, at_out, reg, at_stack_out, nslots, depth);
+	if (ptr->frame >= 0 && ptr->frame < depth) {
+		struct spill_snapshot *parent = env->callsite_at_stack[callsites[ptr->frame]];
+
+		return fill_from_stack(insn, at_out, reg, parent->at, parent->slots, ptr->frame);
+	}
+	if (ptr->frame == ARG_IMPRECISE && !(ptr->mask & BIT(depth)) && ptr->mask)
+		return *ptr;
+	return (struct arg_track){ .frame = ARG_NONE };
+}
+
 /*
  * Pure dataflow transfer function for arg_track state.
  * Updates at_out[] based on how the instruction modifies registers.
@@ -1438,56 +1461,42 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		for (r = BPF_REG_0; r <= BPF_REG_5; r++)
 			at_out[r] = none;
 	} else if (class == BPF_LDX) {
-		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
-		bool src_is_local_fp = can_be_local_fp(depth, insn->src_reg, src);
-
-		/*
-		 * Reload from callee stack: if src is current-frame FP-derived
-		 * and the load is an 8-byte BPF_MEM, try to restore the spill
-		 * identity.  For imprecise sources fill_from_stack() returns
-		 * ARG_IMPRECISE (off_cnt == 0).
-		 */
-		if (src_is_local_fp && BPF_MODE(insn->code) == BPF_MEM && sz == 8) {
-			*dst = fill_from_stack(insn, at_out, insn->src_reg, at_stack_out, nslots,
-					       depth);
-		} else if (src->frame >= 0 && src->frame < depth &&
-			   BPF_MODE(insn->code) == BPF_MEM && sz == 8) {
-			struct spill_snapshot *parent =
-				env->callsite_at_stack[callsites[src->frame]];
-
-			*dst = fill_from_stack(insn, at_out, insn->src_reg,
-					       parent->at, parent->slots, src->frame);
-		} else if (src->frame == ARG_IMPRECISE &&
-			   !(src->mask & BIT(depth)) && src->mask &&
-			   BPF_MODE(insn->code) == BPF_MEM && sz == 8) {
-			/*
-			 * Imprecise src with only parent-frame bits:
-			 * conservative fallback.
-			 */
-			*dst = *src;
-		} else {
+		/* Only an 8-byte BPF_MEM load can be a fill, see arg_track_deref(). */
+		if (BPF_MODE(insn->code) == BPF_MEM && BPF_SIZE(insn->code) == BPF_DW)
+			*dst = arg_track_deref(env, insn, at_out, insn->src_reg,
+					       at_stack_out, nslots, depth, callsites);
+		else
 			*dst = none;
-		}
 	} else if (class == BPF_LD && BPF_MODE(insn->code) == BPF_IMM) {
 		*dst = none;
 	} else if (class == BPF_STX) {
 		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
-		bool dst_is_local_fp;
-
-		/* Track spills to current-frame FP-derived callee stack */
-		dst_is_local_fp = can_be_local_fp(depth, insn->dst_reg, dst);
-		if (dst_is_local_fp && BPF_MODE(insn->code) == BPF_MEM)
-			spill_to_stack(insn, at_out, insn->dst_reg,
-				       at_stack_out, nslots, src, sz);
+		bool dst_is_local_fp = can_be_local_fp(depth, insn->dst_reg, dst);
+		u8 mode = BPF_MODE(insn->code);
+
+		if (mode == BPF_MEM || (mode == BPF_ATOMIC && insn->imm == BPF_STORE_REL)) {
+			if (dst_is_local_fp)
+				spill_to_stack(insn, at_out, insn->dst_reg,
+					       at_stack_out, nslots, src, sz);
+		} else if (mode == BPF_ATOMIC && insn->imm == BPF_LOAD_ACQ) {
+			if (sz == 8)
+				*dst = arg_track_deref(env, insn, at_out, insn->src_reg,
+						       at_stack_out, nslots, depth, callsites);
+			else
+				*dst = none;
+		} else if (mode == BPF_ATOMIC) {
+			/* BPF_XCHG, BPF_CMPXCHG or BPF_{ADD,AND,OR,XOR} | [BPF_FETCH] */
+			struct arg_track old = none;
 
-		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-			if (dst_is_local_fp && insn->imm != BPF_LOAD_ACQ)
+			r = bpf_atomic_load_reg(insn);
+			if (r >= 0 && sz == 8)
+				old = arg_track_deref(env, insn, at_out, insn->dst_reg,
+						      at_stack_out, nslots, depth, callsites);
+			if (dst_is_local_fp)
 				clear_stack_for_all_offs(insn, at_out, insn->dst_reg,
 							 at_stack_out, nslots, sz);
-
-			r = bpf_atomic_load_reg(insn);
 			if (r >= 0)
-				at_out[r] = none;
+				at_out[r] = old;
 		}
 	} else if (class == BPF_ST && BPF_MODE(insn->code) == BPF_MEM) {
 		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));

-- 
2.53.0
