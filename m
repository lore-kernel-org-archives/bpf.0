Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A654F4D05
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292712; cv=none; b=iPDTju+KS6kqyFOxvlxQ3c1v3wlw1C6AZQu1L3tsq4dtKq37ZEthV75VxyI7ONiQo0jPOarFqjYxeGI4m9wFKBj1REs6J1yZjuPFJBBHFEf/SWg22Jgk3bKcx+PYVaWBwB4lYwa1fkwimt+mxhH2kF40P0DfogrXor1rsd2t/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292712; c=relaxed/simple;
	bh=IVfMuRzxGDmCVTIheJm/qnDr+P6oJYEYAlWF+pK3pCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJADn0KP16ZVmhM6g8ma/gaWIQNq9AaA9efIK27OC1jTkeIsqnzD1Q9WRBysejRcDMm/q+/KANrlZoRl+iZrnes9uWuuqUMbyhYkx1v2hSENnRKVWWizEaHWfdh1mkPKG52ED4uTb/wN6pYR0AllarAVKoyIDsJZTM6arHMPBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5GIbNWl; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5GIbNWl"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8748f34b1f2so194925b3a.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790292711; x=1790897511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZRW+3amvJncC3g3cvagPKWDH9UB3H/FxtAo+Q6e5kY=;
        b=E5GIbNWlPCN/GGwV5Isxli1K5QHVyIMS8elb+QKeCrO2jVOMC8fxlbwo7mMszl7BlR
         gHPzdxPJrA1+hRjhVZrAFa9ST7E+xAWRAWxctMVXhYpVA/jgF0TF4xINgTWJtQC9FZSL
         0fW+tjtZbkID8aUeSFRu/o14dqpntwv4+Emh8DVNj+ss5PyQF//qGA4B5VYrLmaa7E8a
         +LNr5bh1JQvNq0v36N5GWaGkBGDi4RnKT2D0ZgsIoJ+fsnr23b4RiqBKsjiE4xslKW0E
         XuEWkV3mX/i32o7OVDxH5VPoxeWO/VrvAvoDOljjRJH7lu7FlsXGnyMRZ5A3ZNerYtWv
         +Y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292711; x=1790897511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NZRW+3amvJncC3g3cvagPKWDH9UB3H/FxtAo+Q6e5kY=;
        b=FSu4E2sYzX6qZukpyP3OrE0TP2LZ4AteM0KBcIjt7dWLY7dt0OHYptRlrgE4TU+FY9
         vHIobrg4fR2Ux52SFU6Txf7+cSR6t8JfIzy14w/WBMBWsLyzCstRj1I0scVGRCaAm1UZ
         NKHe8/FiT7kCFKGr5Z+rxAH8JW8Z8JpqRcKSxsptJerlgFZ8IYBjwq8epp9M6NcGBLUp
         FZ5ft1qkD94X7K5lkjCt5vF+u9ya7EOK1CvWDscGNSZz7LjFNnc6UoLc21MnFDrgUDkf
         LIcx2p0Fd8+UABnlvLVyIe+PLMqNk63gPES5EqIa+hqE81FzFS62fFyK9GeRvmZ3jNLQ
         OOzw==
X-Gm-Message-State: AFuF++lAmOuQSY+DxdcXVG19FAn2++GOm0NidD5OM1cupyrR63VWPSwc
	423IgAGN6GF4uGstUlwtAbW97tyVIZFgCi+iqSl3djXePxEK1aJtN5Eus0OuSw==
X-Gm-Gg: AYBFou18heuUylNIMs0L4rIS9LqxGslAR8cu9Egs0Lr/KgLmlWE7Kaqzx6G/mGjWqiW
	szmJwiw7jWg1KbtoiBE3W6rXfD1HlP+mi3wPfqU9Pwa6KyXGPa/SUGuCO35qjQiDYgaAj2/UzfL
	L/FsmXWbDA4WZCaqtg6KLXJyvf3sD/xiRaysNwvmMkk14pFv1DZk7FcRkB3pxiAJbJRoyDFRvAL
	m0VTv10/6Cwy74z3nZ6P3/z6S3JRnlm1tDFXZb1ta3+SCOCJr8ElmHj1NxHW92IeHLjwUBAy5tf
	kkX/DSIgJW3PTbVwt0wSjw/WgTnLfxJJr7RXq0QN7dPmeTe34SfteKccPXZ/XdNv4D861JQJ1Lg
	eyUM+qSdrq1sA9sIlguzJyZegSCRNQOprv3Ye5E9f0WZSimTB1R1kh42N5/d2DSxMxML9WQitMA
	U8pfWY1bfSLZRSemELIJa71mCr3SwAmw8grRQxaCN01YO36lyHNqnhJ9t6P7aoYMdzGqxfTFyq9
	Tbv0GTn5OfT6z8JECnS7qdcQA7qqcP5p4QtuicYyQ9HpXHAwEk0z+5yvnYby7GNXn7CFmOq5Ibz
	AHWq7X1xpi0pH1iPsJSlO1QzdoNYp1dqayQk0fVJw8Q=
X-Received: by 2002:a05:6a00:8005:b0:878:34e7:9a36 with SMTP id d2e1a72fcca58-87e9b995d09mr3609252b3a.47.1790292710383;
        Thu, 24 Sep 2026 16:31:50 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea8894d7sm254726b3a.26.2026.09.24.16.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:31:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 5/8] bpf: Fix overflow of jump offset in may_goto expansion
Date: Thu, 24 Sep 2026 23:31:27 +0000
Message-ID: <20260924233130.1213812-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
References: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

may_goto is expanded into 'if AX == 0 goto off + 5' when it's timed,
off + 2 when it's not and off - 1 when it jumps backward. The sum is
stored into 16-bit off without a range check, so may_goto +32763
turns into:

  if r12 == 0x0 goto pc-32768

and the prog jumps backward when may_goto expires.

Emit 'if AX != 0 goto +1; gotol' when the offset doesn't fit and
compute the offset from the number of insns in the expansion.
JITs that don't support gotol will reject such prog.

Fixes: 011832b97b31 ("bpf: Introduce may_goto instruction")
Fixes: e723608bf428 ("bpf: Add verifier support for timed may_goto")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 68 +++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index ae9713d292df..e9c2d6c06218 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1690,6 +1690,30 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	return 0;
 }
 
+/*
+ * Expand may_goto: load the count from the stack, jump to the target of
+ * may_goto when it is zero, then the tail that updates the count.
+ * Use gotol when the target is too far for 16-bit offset of a conditional jump.
+ */
+static int may_goto_expand(struct bpf_insn *insn_buf, int off, int stack_off,
+			   const struct bpf_insn *tail, int tail_cnt)
+{
+	int cnt = 0;
+
+	/* Forward jump has to step over the tail */
+	off = off >= 0 ? off + tail_cnt : off - 1;
+
+	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
+	if (off == (s16)off) {
+		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
+	} else {
+		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
+		insn_buf[cnt++] = BPF_JMP32_A(off >= 0 ? off : off - 1);
+	}
+	memcpy(insn_buf + cnt, tail, tail_cnt * sizeof(*tail));
+	return cnt + tail_cnt;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -1967,6 +1991,18 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 		if (bpf_is_may_goto_insn(insn) && bpf_jit_supports_timed_may_goto()) {
 			int stack_off_cnt = -stack_depth - 16;
+			/*
+			 * AX is used as an argument to pass in stack_off_cnt
+			 * (to add to r10/fp), and also as the return value of
+			 * the call to arch_bpf_timed_may_goto.
+			 */
+			struct bpf_insn tail[] = {
+				BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1),
+				BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2),
+				BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt),
+				BPF_EMIT_CALL(arch_bpf_timed_may_goto),
+				BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt),
+			};
 
 			/*
 			 * Two 8 byte slots, depth-16 stores the count, and
@@ -1983,22 +2019,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 * after subtraction, rinse and repeat.
 			 */
 			stack_depth_extra = 16;
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off_cnt);
-			if (insn->off >= 0)
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 5);
-			else
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
-			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
-			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
-			/*
-			 * AX is used as an argument to pass in stack_off_cnt
-			 * (to add to r10/fp), and also as the return value of
-			 * the call to arch_bpf_timed_may_goto.
-			 */
-			insn_buf[4] = BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt);
-			insn_buf[5] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
-			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
-			cnt = 7;
+			cnt = may_goto_expand(insn_buf, insn->off, stack_off_cnt,
+					      tail, ARRAY_SIZE(tail));
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -2010,16 +2032,14 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		} else if (bpf_is_may_goto_insn(insn)) {
 			int stack_off = -stack_depth - 8;
+			struct bpf_insn tail[] = {
+				BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1),
+				BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off),
+			};
 
 			stack_depth_extra = 8;
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
-			if (insn->off >= 0)
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 2);
-			else
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
-			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
-			insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
-			cnt = 4;
+			cnt = may_goto_expand(insn_buf, insn->off, stack_off,
+					      tail, ARRAY_SIZE(tail));
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
-- 
2.55.0

