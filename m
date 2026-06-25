Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84243CFF4C
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383148; cv=none; b=jjq42exEphSfJHekZiLcNjGeR31OigCweKdN9ozw0NNu99uK/Pu+dQpez/8bI6MHj/aVnjwze0OMg0af/UxkPA5GqLZG4x+Bwv5Q7SAAU6eGljXpDe3YxE0Nc0RllAVZ1Cs3BG3jykVf0UPSCmzgwpt2617tz5PWMysbdvlNNBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383148; c=relaxed/simple;
	bh=GVo2zFORq1i5WCY+svqdEMWXma1DeWDGgsbKEhEROBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXu1IhyQH1Rb5D42KWsT7BRBCfI0ZTcwTLMZq1bRVdFlkZpIx3pwmWAsmNjHr8DwEQ459fdFnisJG9d3ay4XSA6T6dB4EU3jJg74mdKVtumaxpt7Se5Gg4ZXN088riw4WoxMDJEhreSA1H0PhawezVD9j1j216GvEsuSy0gBJmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeRbKNeP; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeRbKNeP"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-842338c18e0so1554723b3a.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782383146; x=1782987946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOeBJO1ngFpkfdJ+XCR82FKC3sVOUqcYBHCd6SF1Udk=;
        b=NeRbKNePh0cvxHXm0HrvYUfUCQH6/J9Ik/Y3qKwD3YUG1wyhE8AhZyRANMi/yOGFrf
         ggHXAeGDbX2JP2r8xoJCbK0++PjTvkNOHbzJzmuq7C45s5ugWY2aaRyETydMbiBokHYY
         cm/vegnLveiZU7siosk8qPa4xidQ/g5EEo8Ux9BR4YvnRRCWQ+o2YpOwTfkcvsa4BQui
         Rnp+31g0az4leqEqvVxzDO2hSoV+wDXah1W/ODesGSjxfS6acQYaSWpVom2zKi2ZrYnO
         9psgP/drlmYWwKF89KpnIoDjzSIk2Muuat6Qbwr2MNswTZRtmM3HkVJivAweq7yN1CGU
         Sn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782383146; x=1782987946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uOeBJO1ngFpkfdJ+XCR82FKC3sVOUqcYBHCd6SF1Udk=;
        b=U6C5cfi+8ZxEZSbMMBHoHg4MN15Y3AK9WAstg3/N87zM/fhZxBvz60YCLAhdYHUhwF
         EA5ccqUU4voMXYAcD7cBU8eg7TOlAQ8oTGxTBN+hTHEtFEu7N7oHusAo53YwYky401Zv
         Zau5VFIQFIICWdzF1cvZIeclM75cFmOIRgOLyaLYyIUMTdp10ZGMbE77y9nIaNG5jtpF
         PhA/Vi13VtZvZsh9mue11XIV90hlhof8UufTrEA0bC6wdJt696MRdgAci7kwgg4cr+Or
         HwtFSWCC2aOUWt32sQ4eeQVO4bpmnxs9euCexr3Dji84VOluu8WJM9nGopJN2RSrJhTo
         uu/A==
X-Gm-Message-State: AOJu0Yy/81VxxqMGru6tmXayUsFflW/HQ6m+eeJ9JxfRGiCjnRSXruyz
	TwZgMiRYwmgNdrVQCH/E6BKP9G2l7gIW6cdFGhYUgrKGLNdeYJ4QBU6j
X-Gm-Gg: AfdE7clpjuSO8Dm0sUrJJBhsKxbOUeRXjoDKCbCieXZ6dRR/StDG3YHjcxVKxHdEHLI
	g4ZSntr74zb3dY51vg+xAG1e7/Ii1XwjnYVy0UQtsF5Z+hKldaWfAMRV6gQRYFBKrb7pngl24RO
	8akV99BQFsu9xYeud7QBkdRITpsF8jfWtu0f85tF27CQV5AzlN08ixYwbUMAR7LXnI/xuBSCAsM
	aegPZmEQ+vcn99vOOcyv0ePbEJ4PRKOg+r2+YfhtNJrHMbt0YEXaEHHNShcHUZP2RcCRyAq93cA
	qgtIIWSIDryYkTV7GvqERfittppj+azZelfF7ErBkKlZAZXNp6mC5jKgxCHZMphN6bF6dklJhuQ
	LAftwzrDAPGMJOzTs+2fKlCvw1bpW/HMkYwpBE6TLAfDce/ZkdYMDMlPvUqxCKSQqmYzRkntIHn
	UuR3b9EWkxKm4=
X-Received: by 2002:a05:6a00:2989:b0:842:708f:39a0 with SMTP id d2e1a72fcca58-845b39e15ecmr2457371b3a.8.1782383146002;
        Thu, 25 Jun 2026 03:25:46 -0700 (PDT)
Received: from [172.30.1.18] ([59.6.68.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845ba891314sm570708b3a.35.2026.06.25.03.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:25:45 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Thu, 25 Jun 2026 19:25:37 +0900
Subject: [PATCH bpf-next v3 1/2] bpf: Preserve scalar zero spills for stack
 reads
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bpf-stack-var-off-zero-v1-v3-1-a068210a761b@gmail.com>
References: <20260625-bpf-stack-var-off-zero-v1-v3-0-a068210a761b@gmail.com>
In-Reply-To: <20260625-bpf-stack-var-off-zero-v1-v3-0-a068210a761b@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6430; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=GVo2zFORq1i5WCY+svqdEMWXma1DeWDGgsbKEhEROBw=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqPQIk7dHe141odUtrmL+5fYctabCwCDG+oNTlq
 0X5/dtWcvmJAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCaj0CJAAKCRBDl0TDFa34
 awocEACsk9wrQtIN6lo+7iiO/t5u+G0SaUrvwM3WOGaWs4YunESG1RCtGbVdT4QId/n1z5F/3pQ
 W8m352JgccnfGd1AZflTSuDYcqhlnj2FxYljSjqml6nNu6p6aIRvqYNxDe3nPPyO0M7xEHoTlne
 7FRKJWPbIvBZmVoGxpRWuBOVeBwVahdxLa0WPFsXSCTEkwn1RBG6ROTOrQTqbuG8bZaodMCgVyr
 VpRpv398h2OCClGq+dxuKGmyt2ETi407zDzS/W00mv3Ys3VA5rJCJyf/Kl00WAICKvxRUZDTiwR
 tZ9zbJKxzdApeAspj22hXaednhlu3iGpUtHKntOAMNsYEiJCxfzXGsEDvsPgPAf18XEenqm0Cuw
 +UpWZS4CSO4QNgWADcY3V7cJH2ovDga5PxHKkwwzrVfpvbtiSn2q7wyBvYHzd5eKb7EL3AwGoAW
 1TjeRF6JyNSHGHLuf5aHl/y69m6gUo7huJSrup5Ahmwp4v8dYpEl9mo3JpcY2RiPz3U9jEWKaVZ
 eu44r+CTBbtxfrSZMwVwHAuHXQrdbqKKBn8UM46s2rt41HFv4mxrUQ4mnr8mDX1yN1XNu6eSbA3
 gRUa7V4DTp9FThPGxB0RrFe3Ci/NJ9A3QW126GDV5agpWTcNTEnohqrWewBkW8+nYseZnp8jOB3
 QN5clemNSmvaCjg==
X-Developer-Key: i=random6.xyz@gmail.com; a=openpgp;
 fpr=AB9274C96F151C01D3CDB790439744C315ADF86B

Stack reads can read back bytes that belong to a previously spilled scalar
constant zero. Today mark_reg_stack_read() only treats STACK_ZERO bytes as
known zero bytes, so the destination register can become unknown even
though every byte in the read range is known to be zero. This can lead to
rejecting otherwise valid programs once the loaded byte is used as a
pointer offset.

The original reproducer uses a variable-offset stack byte read emitted by
clang 22.1.6 at -O2/-O3 from a small helper-based BPF C program. Fixed
offset reads have a related mixed case as well: pure scalar-zero spill
reads are already handled, but a fixed read spanning both STACK_ZERO and
scalar const-zero STACK_SPILL bytes still falls back to unknown.

Teach mark_reg_stack_read() to also consider STACK_SPILL bytes backed by a
spilled scalar constant zero as zero bytes, and use that path for both
variable-offset stack reads and fixed-offset mixed reads. Keep the existing
pure register-fill behavior unchanged.

When a zero result depends on such a spill, mark the contributing stack
slots precise before accepting the const-zero result so pruning cannot
reuse a zero-spill state for a later non-zero spill state.

No deployed-program regression is currently known, so target bpf-next.

Assisted-by: opencode:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
 include/linux/bpf_verifier.h |  5 ++++
 kernel/bpf/verifier.c        | 54 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 11 deletions(-)

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
index eb46a81a8..1d3d18235 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3696,14 +3696,21 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
  * SCALAR. This function does not deal with register filling; the caller must
  * ensure that all spilled registers in the stack range have been marked as
  * read.
+ *
+ * STACK_SPILL bytes backed by spilled scalar const zeroes are also considered
+ * zero bytes. In that case, mark the contributing stack slots precise so
+ * pruning cannot reuse a zero-spill state for a later non-zero spill state.
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
+			       int min_off, int max_off, int dst_regno)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
+	u64 zero_spill_mask = 0;
 	int i, slot, spi;
 	u8 *stype;
 	int zeros = 0;
@@ -3713,19 +3720,33 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
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
+		if (stype[slot % BPF_REG_SIZE] == STACK_SPILL &&
+		    bpf_register_is_null(&ptr_state->stack[spi].spilled_ptr)) {
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
+			bpf_bt_set_frame_slot_mask(&env->bt, ptr_state->frameno, zero_spill_mask);
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
@@ -3747,6 +3768,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE;
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
+	int err;
 	int insn_flags = INSN_F_STACK_ACCESS;
 	int hist_spi = spi, hist_frame = reg_state->frameno;
 
@@ -3829,7 +3851,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					__mark_reg_const_zero(env, &state->regs[dst_regno]);
 					insn_flags = 0; /* not restoring original register state */
 				} else {
-					mark_reg_unknown(env, state->regs, dst_regno);
+					err = mark_reg_stack_read(env, reg_state, off, off + size,
+								  dst_regno);
+					if (err)
+						return err;
 					insn_flags = 0; /* not restoring original register state */
 				}
 			}
@@ -3874,8 +3899,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			}
 			return -EACCES;
 		}
-		if (dst_regno >= 0)
-			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
+		if (dst_regno >= 0) {
+			err = mark_reg_stack_read(env, reg_state, off, off + size,
+						  dst_regno);
+			if (err)
+				return err;
+		}
 		insn_flags = 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
@@ -3929,7 +3958,10 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env, struct bpf_reg
 
 	min_off = reg_smin(reg) + off;
 	max_off = reg_smax(reg) + off;
-	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
+	err = mark_reg_stack_read(env, ptr_state, min_off, max_off + size,
+				  dst_regno);
+	if (err)
+		return err;
 	check_fastcall_stack_contract(env, ptr_state, env->insn_idx, min_off);
 	return 0;
 }

-- 
2.54.0

