Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F207F3CAA49
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172695; cv=none; b=rCYXUlSksEvLjizY0qMUpI2kJjrPQ1xw5VL6uEzZ5oI7BG3s2B9YjKuWQKJk2f1MSZkBXYYhmFLd8O+/pvo/6Cqfmjdcc7N1zeuO/ggTnKU9lpHjqNw8gDbog87q+VQD84Y0bkZSRkDjxreNdQ/3WnQMZMxCWe+krGBc+hgYHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172695; c=relaxed/simple;
	bh=0JqGj+0SYcjs265lh5fKkT/DLXFDwGgLJyf8WKteLwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XKq7SmHgame9/NBwylUsd7Xp4ql1IAUP8/bPErRCTwqCHTLvhpmKXBCtcGix//9c3Hiwq4JtNY1u1fmcHxjp3klBK/XQlYCHjczcju3XnyjD5DYhwk/jJwCJqNdXz3S9jfw3rZ8TmHfcVrn7F3+Rrl2BRs3zqqeU/B4BPM/Ax4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCDlHYBG; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCDlHYBG"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2c0c2a68d01so52063315ad.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781172690; x=1781777490; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEHLsjJ++YbF5BMtiZ2F3yyTv5ibuthDDlfDb6LLLmA=;
        b=NCDlHYBGcI7EyHpUGmrP4AQab55rj9nOlm9gVgG18thT0FYoNp/4tTO1owrSixzp4P
         cuOTlDm9wF6V5XP5fgFhEosft87ikol0SH3/ann4GViW4/ePBnZdUTB7OGVgp5yIA4EP
         5s8RrXJGacKElSeeGIi6cuZC51NOL1jEc/5r2tco8nHMtVHVj9O4scc8jE1d4552DmeX
         77rrj60oVimAMYMMkgZq/M+cVrJDA1DmNjlqRDBpBNOL/BzBLVz5+DiEjSLYZaXrvaum
         q9k0ut7Q+p+Mi+fSMx2tmW7J9Ydb1IhTIMDDYY4W6YS60DuXAUKTh1+z01+n8EL8uXm+
         GZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172690; x=1781777490;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEHLsjJ++YbF5BMtiZ2F3yyTv5ibuthDDlfDb6LLLmA=;
        b=QA/uCMukDDQR+Va8/nCsZbBNwtTkGTwLeTVVX6FCevlwMJXHyi4BIhAoclTs5x6CqT
         a3IEa8Do89rZO6BbVhYuu61yc6ZyO8/9F0utA6ssCF2EVaM9XhVeeTFuWCDJUaIwiDJQ
         4OpgVlloVS7nEZwjaamGbxMB1gIOB+aZk3L75Sr3/S9AFJwjaYrW8oy2SEb4zHFi3uzL
         MLkkyUFqWPWXKvtfqXmrqS8yBLvddGiMpyAE/1fD6sZSdrjTFIbRTr44E2P5CvFPe+44
         0NvXvi5WoGB+vxaulRJL8YSPw5RXkFTZ4+J93mwpVDQMbJe5W63By5KuYdq8uvGLNt8a
         PCuA==
X-Gm-Message-State: AOJu0YwEIxJo/bBG79EULF2bYGjfu9EcQutXUP1bV8cS7zd6Dl7vmkOK
	HdokeR5m2HuP0/J+S3hbc7p4DjcRo+rZiN4k5Q8M7akwNY7IzN874GHdhV+9n+HImJX59g==
X-Gm-Gg: Acq92OH2U9Jtm+B1YIBIz+hsk7LiMZ90H4a0EnLA63YTtaWmFI0pizlo1oYkwMgmdUE
	sa6w+GwwUWcnkCmNBMu5RzKMFDj8T5UUKnyBaDQV9LsorpSO83g5TzwKFXeZRNcObviGpGvRixt
	bmgNqjNBLx1CjUir5IxJfSm1gaOb7hsYVDIxe3MdGluZuWNjdwg4EieXi5KNrYp0mx0HqdWLJ5f
	4N6C+VqHH4MyrNjsu5ACJqJR3q8nzRWjhsFbTQFyJ8B4lvhfVgddCcNmeHO2b1IYD57sWZ+BF+J
	iMmAeuv3V1LVjuzkCCQd5I9vzBQ8xW29ces2+h0hoLQ7k95AuPs433ItpN0TkHQZ64tMGvldQ0A
	aOuzWv5izKvEyjuItkUNu2Wflf4EhXGKXz8dLibZ6ppGdttJ5ItEcSCVnt+Op4+VUM/zp5AXJ1h
	b2Vm+YGdMSNdG4bQXYSSUQIkXw7HrIDyHlAUJE5NtXzCq//Dhqwc0=
X-Received: by 2002:a17:903:3886:b0:2c1:6715:a4ea with SMTP id d9443c01a7336-2c2f3254f81mr25383955ad.30.1781172690259;
        Thu, 11 Jun 2026 03:11:30 -0700 (PDT)
Received: from [192.168.0.6] ([223.131.147.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa072asm272299185ad.34.2026.06.11.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:11:29 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Thu, 11 Jun 2026 19:11:24 +0900
Subject: [PATCH bpf] bpf: Track spilled zero scalars for var-off stack
 reads
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-bpf-stack-var-off-zero-v1-v1-1-0ec407376147@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBAAv0L27CYtFQ5+xXhoyxYWE0p2oTES/
 m7V40wyc4CSMCncmgOECivnpYK9NBAnv4yEPFSG1rS96a3BsCbUzccnFi+YU8I3ScZi0V39YEN
 0oXMOar8KJX793neoGTz+UvcwU9y+VzjPD0oPN56CAAAA
X-Change-ID: 20260610-bpf-stack-var-off-zero-v1-34ad1bc3b533
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Woojin Ji <random6.xyz@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8817; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=0JqGj+0SYcjs265lh5fKkT/DLXFDwGgLJyf8WKteLwo=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqKonOv0DOBgJ1NXrh8NtUDLJOIS8Ll1jFGmqN/
 9TDMjzY+oyJAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCaiqJzgAKCRBDl0TDFa34
 a5wfD/9XFMkALnzbeJnhATtSPA3rRuXLDYn8MKnsvfwRqy8V8IXF+ooV4BLCmqB0FFZTxXfJe1n
 IMP9yNwLnV1pIXBpqjwHcGYy756ukAR3KPKEMaksTetKHchwsDlORhJnCvwHtoF7dHMIwDBFgN2
 bxodEdCBnJxLbMu/+mc6SbYkR+7z0u6tWnKSnMpou2qEek7yQEUrmDTy/CGNlPLIKc0xdtqd2EN
 jU3ldea4laOsCymAsw2b2+OmLX6fhQlxj7rZ++XdVL0bYxYJkLyG/IwlWyHyypYgS8oYQyOV0/R
 BZvdn2GGu5qZQ593rvCJz+BR5uoGHWxrYpDmgThOcrd+mtXgs0HBSSjT3maDZgU1ztiwsZ3WnNn
 5CdJFfHTj+beczZwb8qfePaWHpse5/svsizvxpakdiX1qcB5YQfkJ/xRxihWzKk5MnWsIoyqu//
 eUrGysEPVge7Cjdgtvbwmf+y0aWy5fN1PGFQADwAIA1rjEePCM1WnpJLpOJdesEDCegsicQWost
 pMjct8m3JVl7Skq8BAHQOOui9TSEqW2M7QNtjYvjqRib4agTafKxqAmL/AzZiFKun45ebJ+db6V
 0o5tGYAWDEzjnqD9uixpyAu0AewRoA80hccKSm/i+8M6x23d8xINXFBIppgLSukwE04R0+wzPHI
 3SibtTqtWJqXuog==
X-Developer-Key: i=random6.xyz@gmail.com; a=openpgp;
 fpr=AB9274C96F151C01D3CDB790439744C315ADF86B

mark_reg_stack_read() currently treats a variable-offset stack read as
known-zero only when every byte in the read range has STACK_ZERO type.
This loses precision for stack bytes that are represented as STACK_SPILL
but come from a spilled scalar const zero.

Fixed-offset stack reads already preserve such partial reads from a
spilled scalar zero as const zero. Variable-offset stack writes also keep
a spilled scalar zero intact when a zero write overlaps it. The read side
is therefore inconsistent and can reject otherwise valid programs: a byte
read from a spilled zero becomes an unknown u8 and may then make a
stack access through that value appear out of bounds.

Treat STACK_SPILL bytes backed by a spilled scalar const zero as zero
bytes in mark_reg_stack_read(). When such a spilled scalar is used to
prove the destination register is const zero, mark every contributing
source stack slot precise before state pruning can use an explored
zero-spill path for a later non-zero spill path.

This has to be done eagerly for variable-offset loads. Fixed-offset stack
fills can record one source stack slot in the jump history and propagate
destination precision back to that slot later, but a variable-offset load
may source bytes from multiple stack slots. Seed precision backtracking
with every zero-spill slot that contributes to the const-zero
classification instead.

Add verifier selftests for both sides: accepted programs that read a byte
through a variable stack offset from spilled zero scalars, including a
multi-slot range, and a rejected program that would be accepted unsafely
by a naive implementation that promotes spilled zero bytes to const zero
without tracking the source spilled slot precisely. Use
BPF_F_TEST_STATE_FREQ for the rejected test so it does not depend on the
current verifier checkpoint heuristic thresholds.

Tested:
  ./test_progs -t verifier_var_off

Assisted-by: opencode:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
 kernel/bpf/verifier.c                              | 52 ++++++++++---
 .../testing/selftests/bpf/progs/verifier_var_off.c | 88 ++++++++++++++++++++++
 2 files changed, 130 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd..c4b89fbd9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4058,14 +4058,21 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
  * SCALAR. This function does not deal with register filling; the caller must
  * ensure that all spilled registers in the stack range have been marked as
  * read.
+ *
+ * If the const-zero classification depends on spilled scalar zeroes, mark the
+ * contributing stack slots precise so pruning cannot reuse a zero-spill state
+ * for a later path containing a different spilled scalar.
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
@@ -4075,19 +4082,38 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
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
+			for (spi = 0; spi < MAX_BPF_STACK / BPF_REG_SIZE; spi++) {
+				if (zero_spill_mask & (1ull << spi))
+					bpf_bt_set_frame_slot(&env->bt, ptr_state->frameno, spi);
+			}
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
@@ -4109,6 +4135,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE;
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
+	int err;
 	int insn_flags = insn_stack_access_flags(reg_state->frameno, spi);
 
 	stype = reg_state->stack[spi].slot_type;
@@ -4235,8 +4262,11 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			}
 			return -EACCES;
 		}
-		if (dst_regno >= 0)
-			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
+		if (dst_regno >= 0) {
+			err = mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
+			if (err)
+				return err;
+		}
 		insn_flags = 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
@@ -4291,7 +4321,9 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
 
 	min_off = reg->smin_value + off;
 	max_off = reg->smax_value + off;
-	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
+	err = mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
+	if (err)
+		return err;
 	check_fastcall_stack_contract(env, ptr_state, env->insn_idx, min_off);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index f345466bc..2d4878270 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -59,6 +59,94 @@ __naked void stack_read_priv_vs_unpriv(void)
 "	::: __clobber_all);
 }
 
+SEC("cgroup/skb")
+__description("variable-offset stack read preserves spilled zero")
+__success
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+__retval(0)
+__naked void stack_read_var_off_preserves_spilled_zero(void)
+{
+	asm volatile (
+	"r0 = 0; "
+	" *(u64 *)(r10 - 8) = r0; "
+	"r2 = *(u32 *)(r1 + 0); "
+	"r2 &= 7; "
+	"r2 -= 8; "
+	"r2 += r10; "
+	"r3 = *(u8 *)(r2 + 0); "
+	"r1 = r10; "
+	"r1 += -1; "
+	"r1 += r3; "
+	" *(u8 *)(r1 + 0) = r3; "
+	"r0 = 0; "
+	"exit; "
+	::
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("variable-offset stack read preserves spilled zero across slots")
+__success
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+__retval(0)
+__naked void stack_read_var_off_preserves_spilled_zero_across_slots(void)
+{
+	asm volatile (
+	"r0 = 0; "
+	" *(u64 *)(r10 - 8) = r0; "
+	" *(u64 *)(r10 - 16) = r0; "
+	"r2 = *(u32 *)(r1 + 0); "
+	"r2 &= 15; "
+	"r2 -= 16; "
+	"r2 += r10; "
+	"r3 = *(u8 *)(r2 + 0); "
+	"r1 = r10; "
+	"r1 += -1; "
+	"r1 += r3; "
+	" *(u8 *)(r1 + 0) = r3; "
+	"r0 = 0; "
+	"exit; "
+	::
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("variable-offset stack read tracks spilled zero precisely")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("invalid variable-offset write to stack R1")
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
+__naked void stack_read_var_off_tracks_spilled_zero_precisely(void)
+{
+	asm volatile (
+	"r6 = *(u32 *)(r1 + 0); "
+	"r6 &= 1; "
+	"r0 = 0; "
+	"if r6 != 0 goto "
+	"+"
+	"2; "
+	" *(u64 *)(r10 - 8) = r0; "
+	"goto "
+	"+"
+	"2; "
+	"r0 = 1; "
+	" *(u64 *)(r10 - 8) = r0; "
+	"r0 = 0; "
+	"r2 = *(u32 *)(r1 + 4); "
+	"r2 &= 7; "
+	"r2 -= 8; "
+	"r2 += r10; "
+	"r3 = *(u8 *)(r2 + 0); "
+	"r1 = r10; "
+	"r1 += -1; "
+	"r1 += r3; "
+	" *(u8 *)(r1 + 0) = 0; "
+	"r0 = 0; "
+	"exit; "
+	::
+	: __clobber_all);
+}
+
 SEC("cgroup/skb")
 __description("variable-offset stack read, uninitialized")
 __success

---
base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
change-id: 20260610-bpf-stack-var-off-zero-v1-34ad1bc3b533

Best regards,
--  
Woojin Ji <random6.xyz@gmail.com>

