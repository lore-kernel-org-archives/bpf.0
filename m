Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753323504B
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226591; cv=none; b=CAx0TJFyD+5NU7h2NUCLQJp5LCTddA2kO3Nko4z8npH4MJTmriiZ/xjLRzFIYKE+PljtUyKi1/WBWrRQqzeaRkKtUl9VYhvSqUwbU9haCqZCmgm9UQM6cBKzZMf/tim5Jrs3tfKLjfzQQkXCmfe8yJnFLoCDctdln4mKlGPRGpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226591; c=relaxed/simple;
	bh=FBo6xa/0WF76NDQUlUFVN26XuvptmORxD4iOP72bDkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bKji1fGoe7bFPOQpbeo2fnrvMHO4mnNJl8hLOXHrEcqfQ/eOFaffk9EHZuzjPTQZStRdLD6d2cCRu6YAvxk5f6LUXufez3ArXiLvvd9ELnGQ5potMZgptoB1jmyCdVBhJ9rC7KeVOX2ToRLcFxShot4uXBMH6vc01PoKClEsgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLqN+1sp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLqN+1sp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d712281f8bso47483455ad.1
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 18:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788226588; x=1788831388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CIDsmTEKH+H7uyhxZ9nnV3xFA1lkHDscV2x5uB/yaxw=;
        b=lLqN+1spY2O6htVGe881U0OjjcA3B0SDG/V9vCHndf0+hQVzfUsIynEMym55W2gv4X
         V+3uF9q2PQY30Z9gabQqb8BDiqWKTPSLm8EYoKSvz9G/WHQYTvGNAUAoo8YN9ER6DDGE
         E0DfxzAVv7Wq8yC4mKOzoWJO8JEHY3AIFC3wqer+sHrlevlsH8uHYuGdXpTtY5UixFSw
         P2oyTm9uzTbzvyNHkeHyzpNv25ZjC5ooEeZUIZBQAVm93eNHk0gmQJIKf9Ls2MLuH5jN
         vOWUXhakjAQ078UFWKKrWlZBTxeJOtdbKya6FxhlCr4kmCmYVV3VwIGX3czCFwnFj6VF
         Lfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788226588; x=1788831388;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CIDsmTEKH+H7uyhxZ9nnV3xFA1lkHDscV2x5uB/yaxw=;
        b=natdPnMVLKS2QU40Xv3NfLoTsbxmAh5tjeJLIYJQ3smSodjBQ1XMUlcu1j9DlmUHDt
         Yg2v7p7kAxEwVbjMKeJa7BV3nIoBYL+/Zze4D1yk7G8t2R52rS6PpNWmgkRQUOBRdDF2
         jmW2L3dMeBv/3UChUo1ID4vSfzQxHRxcboShUx77zmqhGrBEEsdmO+Wrp6guRhz6oHed
         TNB4fSBxEDRQEYSzc+zP6bfdA2o2bsEC9AYL7seXee1g1JKlryBBVWalWN4VLeRhwwA5
         XvrVGSSpG0MQio6s4KcKts8yChVJLL2uvzn5m42kjnz23NS6R7d7J9NqnvTCC8S6fB/J
         8JHQ==
X-Gm-Message-State: AFuF++lV7cs4YycrYu+enPBL6VXgQePucnpDY2b85IHIa2rRZaI4eiO+
	0Bv/V1wr3+8pihyVQ+EYkAmELT/szMJyGxjUkejXUhivJJZqQmo8nAgx6AvaYZ0Y
X-Gm-Gg: AYBFou0upJ/9Yja5ZirREFkPHxymiEn5/h9pMV3pVgEEIT2qEnSt4owaxpooM6xT448
	IDVDnUS/NRQAcfOKynormoj59ZwNHXp0CLhsPuTRw7LoTqJAfpZer+y/LJnjex2BmnsQ4K/Ffcr
	denZWQqzRaIPP/ABjzzujcbTn/tpLc8gUn0rx8i2Vd+GjR4YyT3zoGvaejGmv8GzatId/pyEIbF
	Fw3MV6suctV+p1Jau0eFj6mS1Q+8CCFhNiz+Hy0FydCU/v+I23BmOwLFI7zZ3u70XiGIUV0INX6
	MtWYP1L6FYwxI9ym/N1bVcPJXMyKn/6X9M61Q9QHssxmcxcsCKJRFIRA0GlmpRTDxLDvX5FL/0w
	OzTGmrzV8HNRrf2CbSB31AlF0F73PQzhk3FPvCw1vr50VuvAtY0cFMfiRV8N61wO70cgs3AlWO9
	U9rKljz/bmM9GCO/6IBBQXg73B04s9gjJq74o8AS5QWjxRs9c7cMdBE9RXSTNzj9E8buTcRWdau
	AJYh8sHC9mfHICM
X-Received: by 2002:a17:903:37cc:b0:2cf:8131:75f4 with SMTP id d9443c01a7336-2d94a8d4abbmr64791905ad.11.1788226588333;
        Mon, 31 Aug 2026 18:36:28 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75963bc14sm42825005ad.32.2026.08.31.18.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:36:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	npc@anthropic.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 1/2] bpf: backtracking shouldn't clear outer frame R1-R5 for callbacks
Date: Mon, 31 Aug 2026 18:36:09 -0700
Message-ID: <20260831-bug-015-backtrack-cb-args-precise-v1-1-68a8e2a821e0@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When processing calls to bpf_loop() verifier marks R1 (and R4) as
precise. R1 tracks loop iterations number and because of the
'callback_depth < R1' mechanics in check_helper_call() must be marked
precise. However, precision propagation for R1 was broken,
when bpf_loop() call was verified on a second iteration.

Consider the following verification trace:
- main: bpf_loop(nr_loops, callback ...)
- callback: BPF_EXIT
- main: bpf_loop(nr_loops, callback ...)
- ...

While the first visit of the call to bpf_loop() propagated R1
precision as expected, the second call to mark_chain_precision() in
the check_helper_call() set R1, but it was immediately reset when
backtrack_insn() processed preceding BPF_EXIT in the loop deleted in
this patch.

Because of that, the second visit of the call to bpf_loop() injected
checkpoint with R1 not marked as precise. Which could trick the
verifier into accepting unsafe programs. See the next patch for an
example of such program.

Commit is structured in a way to minimize conflicts when
'bpf' would be eventually merged with 'bpf-next'.

Fixes: ab5cfac139ab ("bpf: verify callbacks as if they are called unknown number of times")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/backtrack.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index a2b18a9f1694..4fe906510673 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -520,37 +520,34 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					return -EFAULT;
 			}
 		} else if (opcode == BPF_EXIT) {
-			bool r0_precise;
+			bool from_subprog_call, r0_precise;
+
+			/* BPF_EXIT in subprog or callback always returns
+			 * right after the call instruction, so by checking
+			 * whether the instruction at subseq_idx-1 is subprog
+			 * call or not we can distinguish actual exit from
+			 * *subprog* from exit from *callback*. In the former
+			 * case, we need to propagate r0 precision, if
+			 * necessary. In the former we never do that.
+			 */
+			from_subprog_call = subseq_idx - 1 >= 0 &&
+					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);
+
+			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
 
 			/* Backtracking to a nested function call, 'idx' is a part of
 			 * the inner frame 'subseq_idx' is a part of the outer frame.
 			 * In case of a regular function call, instructions giving
 			 * precision to registers R1-R5 should have been found already.
-			 * In case of a callback, it is ok to have R1-R5 marked for
-			 * backtracking, as these registers are set by the function
-			 * invoking callback.
+			 * In case of a callback from bpf_loop(), R{1,4} in the calling
+			 * frame would be set as precise and that is correct.
 			 */
-			if (subseq_idx >= 0 && bpf_calls_callback(env, subseq_idx))
-				for (i = BPF_REG_1; i <= BPF_REG_5; i++)
-					bt_clear_reg(bt, i);
-			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
+			if (from_subprog_call && (bt_reg_mask(bt) & BPF_REGMASK_ARGS)) {
 				verifier_bug(env, "backtracking exit unexpected regs %x",
 					     bt_reg_mask(bt));
 				return -EFAULT;
 			}
 
-			/* BPF_EXIT in subprog or callback always returns
-			 * right after the call instruction, so by checking
-			 * whether the instruction at subseq_idx-1 is subprog
-			 * call or not we can distinguish actual exit from
-			 * *subprog* from exit from *callback*. In the former
-			 * case, we need to propagate r0 precision, if
-			 * necessary. In the former we never do that.
-			 */
-			r0_precise = subseq_idx - 1 >= 0 &&
-				     bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]) &&
-				     bt_is_reg_set(bt, BPF_REG_0);
-
 			bt_clear_reg(bt, BPF_REG_0);
 			if (bt_subprog_enter(bt))
 				return -EFAULT;

-- 
2.53.0
