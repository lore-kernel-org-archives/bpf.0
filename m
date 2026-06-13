Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9103DD525
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349389; cv=none; b=KzZmoTpcnwgLP3MEi0I9Zdn0cd3yMitk7xuipLEh9zBq213ahtplwGZvcbQ06GsyriurIVJU4zBW2aN+kJTP8IJBND733QDSX/8D0sqX38sBmxG+FilAa7WOVBc7XU6+qCBr//+1QVudFnxI+CRIzWwzOxY5HM8KMJ85lcVuDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349389; c=relaxed/simple;
	bh=GtJXp76xU7ReBbX/CT+TF5ObJIG0CjF4LXDrLPNg0+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IE6WluGIibsZzVLPDSjQdw8+Mqmy9i4yU81CL0IyrPNwtcXHiCPyqboN9P3Yskrm/TducPksWnYJAYGUJ/4wj+ooc+cX3w46i0sSfsaTkTgWMYfb/417lcMcm8w+InurVeila5ooAI5W882LZY6dK95S4vXNhQQEthy3kqu0GDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrLHIbgO; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrLHIbgO"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2c40397e746so9470515ad.3
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781349387; x=1781954187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqw1qjNhYVz6aZWtsdwZY1nSMGndTJnN6VJBlQl9zis=;
        b=TrLHIbgOw/zzKR1+PiNsxPABs9BAMoGuUGMkV7+1RrERlwuk3Sj67mcB6iGAdeS1MG
         quCiLJgEXBY7xrXbv9iKKWTNIFnj9tVxSEK/LtfXnjHORH3oMoD6Uyp5cT0M1xvdMqie
         QO4ZS9di8orBdPvBpKJmZoRKZqmsyf6mcmSkSUDIo6EOra4XwLKwHzD+/8tej8InQRWd
         N9PdUUgCxDlTFnUcQzIyK7301sqTXDzFHwMMb42HXleOHxwczQhhHSsWIeCgmaFEj86f
         hwSRekI2Q5G1prkmBng2LA5nW8USktxhn6jaN5KtWR4MQcpeJ4j7sDc9wv2TPA8SjMc+
         Fa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781349387; x=1781954187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqw1qjNhYVz6aZWtsdwZY1nSMGndTJnN6VJBlQl9zis=;
        b=mB7pXbM83Awfx6cvQQO4EKzRjpGktDzt/COEm8b0rlbH8ejOB2e7wBaQoK/G3w2uGx
         p4VEyT6pscWk4zyd1UcNDPgjrDAfvaQ726g3PN5p7PmgbsaePwHqH+plO5mfySQbtfcm
         ptSukM9nJ7hrsUGf57qvjwidH9S0s6ki9yJ9MOwwaV7heEPuUZJ08BARuUq9G0vibRRD
         F6sVZeNYbhp1q09anwFOrPA39lajWoi0hRVoBN3RQGtdPAADuVNQvBt/AX+H0Mc9zEk6
         B532LgtY8nalih4f5PHBUAPQK8Wc6fVanVlZrQ3jj3APHOgtezEayJMUv5EIwYLjPiNJ
         mNjA==
X-Gm-Message-State: AOJu0Yyf0h0aRNHBP3GWh4/8Xw7kP79vQ2aYLu7QDDsVTEFvzWtwuBgP
	XmeeXRgItIb0I9dL/IYJzUm+hfyRttrgfjGDMZLkVO9jVMTZ646yAeHD
X-Gm-Gg: Acq92OHPp6YwcWY+IU2FxcOGrKBSKJG/LEKHSUbL/C4OJujTNq/TCN4CIeydG3ViY91
	JWP94N83syYeYwLBCTIM9/4+E0fKUI1nnarAj2TB8+X03LRKiueiroKauXuhgHFm2xdZaG/UswI
	oY/3bsVUBaZFidjkjBUhsS+JAJm8ciZq1fc/xHj8e12ZIQdQ/vSEMOM/aytF3BvssaEMiYJhpYj
	M4jIsgj4udms4kqWwhv7tLH5JmDyfpAu4+PG/5aWko6sIQhVlabaN0CGnl+RJm0AqqKCUVwIKfP
	ibmDRuFTX4cGv+Rj5CiGYnkU+sRz2YFJYxWVw4Q+Xm58XW9lWFeKWoCxL3IAaAqn9Q00H6NGNrv
	NdlKQ0kbBCpFn7gUj41V9c0awKFV9O/LlRaKp2lpbIY+gvsHy26SeCvjvMKtjcudB+jqUr+naVb
	EIdtJ22Ov7pE5JVb6TN8D/LR3L7Biw
X-Received: by 2002:a17:903:41cb:b0:2c2:8659:da43 with SMTP id d9443c01a7336-2c410411a71mr78610765ad.4.1781349387138;
        Sat, 13 Jun 2026 04:16:27 -0700 (PDT)
Received: from [192.168.0.30] ([175.204.13.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm45215975ad.36.2026.06.13.04.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 04:16:26 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Sat, 13 Jun 2026 20:16:18 +0900
Subject: [PATCH bpf-next v2 1/2] bpf: Preserve scalar zero spills for
 var-offset stack reads
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-bpf-stack-var-off-zero-v1-v2-1-a324af0f00ea@gmail.com>
References: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com>
In-Reply-To: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, Woojin Ji <random6.xyz@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6122; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=GtJXp76xU7ReBbX/CT+TF5ObJIG0CjF4LXDrLPNg0+k=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqLTwFUe4cYCCWXmhyCyurFLU/FAi6eXcVXIdPB
 lMHnLJ4e0uJAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCai08BQAKCRBDl0TDFa34
 a7rzEACdekUx7ZAqSQFmSfJrFoizLUUTifR68BKTC22ias4Vs08PpU9QtPJPdJO4L99pKq+aBA8
 kiWaSS7e00hEimIJkSUzTpWm9PIq18Xd4SWlS+ZwX2pUfr0Gm2wW6QHNEKjcjLFTOQfy54RT+9W
 Pz3aBc6FkcXjSmvEXWXzReeyzjvI/nI6HQqLuOWWNJuFR2LO+3JHraWHKlx8FNPHYwFa40oYrBD
 OQgzeBIM7OAc6G5PWHLfB2Dgl9g0OgmR7BA6qybsYXRY6TBfNpvWYsUSnZRTJKJP3qcbWpMjvTp
 10aEHMciqzKKzMGtRWMPeWaNeYhso2/ADFc1UhgXIdGiFpN9tyTfnT+K3FtEWd8MZgREnvccs6F
 5DPNnyijr5N/n+Us1KxGFxJ0J0hfFDQavzm4ArkT9oTFG0Iq62JL5czzSQmuq8/5QcSQVR7R+kd
 U5x9TQ9GAbFnclw8ep7VVSggKhycrD/3NFPBUI4E85O9zpyhygCw2TZvEsq19L6p9Z1nF28PZ/4
 4oxL3G4Ku6RQVKI9l4VngW795E35PMd7LALU/aRFzqhgKMU2g8qI1ZjxiPpFQZxdLmujCqAHNwk
 lRgZp+IXV/7CTI+wzwwS6NrMNe5iS96FddNsE5nvktebimSOtKMBngJreZsT11Ls9Y1Qcv9LYSg
 +WQpH5AtnfZGy9Q==
X-Developer-Key: i=random6.xyz@gmail.com; a=openpgp;
 fpr=AB9274C96F151C01D3CDB790439744C315ADF86B

Variable-offset stack reads can read back bytes that belong to a
previously spilled scalar constant zero. Today mark_reg_stack_read()
only treats STACK_ZERO bytes as known zero bytes, so the destination
register becomes unknown for such reads even though every byte in the
read range is known to be zero. This can lead to rejecting otherwise
valid programs once the loaded byte is used as a pointer offset.

This pattern is not limited to hand-written verifier tests. clang
22.1.6 at -O2 and -O3 emits it from a small helper-based BPF C
reproducer; the resulting program is rejected before this change and
accepted afterwards. No deployed-program regression is currently known,
so target bpf-next rather than bpf.

Teach the variable-offset stack read path to also consider STACK_SPILL
bytes backed by a spilled scalar constant zero as zero bytes. When a
zero result depends on such a spill, mark the contributing stack slots
precise before accepting the const-zero result so pruning cannot reuse a
zero-spill state for a later non-zero spill state.

Keep fixed-offset stack reads out of this eager precision marking path,
as the new behaviour is only needed when filling a register from a
variable-offset stack byte range.

Assisted-by: opencode:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
 include/linux/bpf_verifier.h |  5 ++++
 kernel/bpf/verifier.c        | 55 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d57b339a8..c2e665044 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1242,6 +1242,11 @@ static inline void bpf_bt_set_frame_slot(struct backtrack_state *bt, u32 frame,
 	bt->stack_masks[frame] |= 1ull << slot;
 }
 
+static inline void bpf_bt_set_frame_slot_mask(struct backtrack_state *bt, u32 frame, u64 mask)
+{
+	bt->stack_masks[frame] |= mask;
+}
+
 static inline void bt_set_frame_stack_arg_slot(struct backtrack_state *bt, u32 frame, u32 slot)
 {
 	bt->stack_arg_masks[frame] |= 1 << slot;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb46a81a8..46cadb83f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3696,14 +3696,23 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
  * SCALAR. This function does not deal with register filling; the caller must
  * ensure that all spilled registers in the stack range have been marked as
  * read.
+ *
+ * If requested, STACK_SPILL bytes backed by spilled scalar const zeroes are
+ * also considered zero bytes.  In that case, mark the contributing stack slots
+ * precise so pruning cannot reuse a zero-spill state for a later non-zero
+ * spill state.
+ *
+ * Returns an error if precision backtracking fails.
  */
-static void mark_reg_stack_read(struct bpf_verifier_env *env,
-				/* func where src register points to */
-				struct bpf_func_state *ptr_state,
-				int min_off, int max_off, int dst_regno)
+static int mark_reg_stack_read(struct bpf_verifier_env *env,
+			       /* func where src register points to */
+			       struct bpf_func_state *ptr_state,
+			       int min_off, int max_off, int dst_regno,
+			       bool mark_zero_spills)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
+	u64 zero_spill_mask = 0;
 	int i, slot, spi;
 	u8 *stype;
 	int zeros = 0;
@@ -3713,19 +3722,37 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
 		spi = slot / BPF_REG_SIZE;
 		mark_stack_slot_scratched(env, spi);
 		stype = ptr_state->stack[spi].slot_type;
-		if (stype[slot % BPF_REG_SIZE] != STACK_ZERO)
-			break;
-		zeros++;
+		if (stype[slot % BPF_REG_SIZE] == STACK_ZERO) {
+			zeros++;
+			continue;
+		}
+		if (mark_zero_spills &&
+		    stype[slot % BPF_REG_SIZE] == STACK_SPILL &&
+		    bpf_is_spilled_scalar_reg(&ptr_state->stack[spi]) &&
+		    tnum_is_const(ptr_state->stack[spi].spilled_ptr.var_off) &&
+		    ptr_state->stack[spi].spilled_ptr.var_off.value == 0) {
+			zero_spill_mask |= 1ull << spi;
+			zeros++;
+			continue;
+		}
+		break;
 	}
 	if (zeros == max_off - min_off) {
 		/* Any access_size read into register is zero extended,
 		 * so the whole register == const_zero.
 		 */
 		__mark_reg_const_zero(env, &state->regs[dst_regno]);
+		if (zero_spill_mask) {
+			bpf_bt_set_frame_slot_mask(&env->bt, ptr_state->frameno,
+						       zero_spill_mask);
+			return mark_chain_precision_batch(env, env->cur_state);
+		}
 	} else {
 		/* have read misc data from the stack */
 		mark_reg_unknown(env, state->regs, dst_regno);
 	}
+
+	return 0;
 }
 
 /* Read the stack at 'off' and put the results into the register indicated by
@@ -3747,6 +3774,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE;
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
+	int err;
 	int insn_flags = INSN_F_STACK_ACCESS;
 	int hist_spi = spi, hist_frame = reg_state->frameno;
 
@@ -3874,8 +3902,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			}
 			return -EACCES;
 		}
-		if (dst_regno >= 0)
-			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
+		if (dst_regno >= 0) {
+			err = mark_reg_stack_read(env, reg_state, off, off + size,
+						  dst_regno, false);
+			if (err)
+				return err;
+		}
 		insn_flags = 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
@@ -3929,7 +3961,10 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env, struct bpf_reg
 
 	min_off = reg_smin(reg) + off;
 	max_off = reg_smax(reg) + off;
-	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
+	err = mark_reg_stack_read(env, ptr_state, min_off, max_off + size,
+				  dst_regno, true);
+	if (err)
+		return err;
 	check_fastcall_stack_contract(env, ptr_state, env->insn_idx, min_off);
 	return 0;
 }

-- 
2.54.0

