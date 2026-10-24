Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800246;
	b=AkhaPxvcWqK5c34jUcA311piqbFC7nyk+bgmnUNwlC2npmk/D8viYan1+n8k9TDwjLe5
	 4SAP10Ql6FIojmPNu7lYrkv7W/9y+zMppmgNB4k9uiyRHlvvkZbnXOpj3+IPxkrOLlvPu
	 HejIA3r5uMs5di8sufUfUYrQEfAzj7YLeE2RiXHkgHA39B2kfibp0BIdebvDP3/e7AP0R
	 pjioECUoEn2vIYL9qcSQPvl+4+xg5NhQG9BdzSJYbOcXag081BAP6hn5rprIF/kSAfPVh
	 ExzfU6v3q4dnPzNuuqDVFrrtw7e9dbFl9ggePAKPp8zRxBleA8peJy63BO9MeMIqF5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dRHkV3IgHrpSjRIDO+hB1KBrpo27+gi3FMBmmDxTM7E=;
	b=nxMdjBkVVp7lV9I6ed1gJl6K+I/o2ZOOj6/AAnjSNCSx83cm8IsSNRiJ2vb0WELiQBKz
	 qsFt5OJx2lFfD4cMVmQ5i3membwXP+0UgJZ4tSncRhQjT8byNFp5e3peibaywYOf5PnFh
	 8Yl4PKuN/DzCwFfYARUFN25f9ggfREqO8riF0mlcVF51KxLlvlQx9nKsgPdb8jBnJ756L
	 R7On5KP/P1WAxqjSmWUJQNcoOLXnqMyev6L9tEdhDuqG0sQnjiG3ONEufqns2Wf+gturS
	 fNIap3iyNS5cs4m48ls9e77JngsreFsUhZcbybFea06UKHRR2CeBmIVbUUvhJA5faPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nkL91K6a;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18E606A324
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A18E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nkL91K6a
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so831910a91.2
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800246; x=1793405046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dRHkV3IgHrpSjRIDO+hB1KBrpo27+gi3FMBmmDxTM7E=;
        b=nkL91K6a312oc4rpr1vRrCOgE2HuVw5gyxp1W5FYmAewHjLXAinAgZ1stkzvOjvUdq
         X9kJlePuDshbwYQhKHCCpySjousYIqWSknshTAnWHfOBJfunkJVJfj6EfMixi+Qw43Nr
         S3iZ4USsvC1OWyrv63gSIZfO/LK3Ht9eLkIzP7f3tOTkjKSSCVo3YDyiXXj3VuE2WKHI
         jSfS4GWOhENQubDGVQUl6MdylQ8gjgmJr93FHENfKIrnyH4t4lho4xm2Dy2Oqj151Qxj
         ohOvRylFlhmucmK9eVZTDxNQudk2PbweP37yfAysmqHLg+BQexporXrO0Yyw/ARZHlEU
         axkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800246; x=1793405046;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRHkV3IgHrpSjRIDO+hB1KBrpo27+gi3FMBmmDxTM7E=;
        b=ntEpLtXVQ7JjBpY2x5r1X+XVKLO8crMherQ1GpBySb80RWfUpkmUoXwAsjNIqF/1EP
         xJhVdvEvA+tujVOCOupyG+kDnGz1Lu1/ED1Cb1p3KI4GSiRtNKws5eN3q56heK46bHPC
         Ig3aIKgh7WNQi7r979FE1uDCf5KU9kopAT9tLSHOSNUG5EAQZs8vfiIjlqtFWO2Kf9Yn
         7K+S3hKjhNxbaCl0GlIwGdWt7YLxgbCtgqZeHGK5rf0YrMTOQpy7itmy8x072yWBJOsG
         MyrZ7fHf/+r+FN+cfPgrGnHm+ITZIM8wiPq20RVODwfO6Zke+USoeu7wCWWpWfARPktx
         6CUg==
X-Gm-Message-State: AFq9FYJg2RxHz9A0dPgRIIIfaljvRHgebl730zgj+IAv+R+XMhPMvk3i
	t8ypwxBSIxGGmaQh0fciuz046+ewnmm19yxhdD5w4M/d8jrADolq5kz6JyAlqw==
X-Gm-Gg: AYBFou1/WHbQ/LBkLc+tEfM3K9p9viN+3ozCCju8YY0lq9/5vt+unC/6SGwkFWrLEAT
	ljYcInHeyevrn9OKsC7u3tpeDqzPuskJ0WhuN3VlWouExBCHZ7yaZTsIJiR8jxQPjAhVX3dn/N5
	y4DDgLh3C7LaJ9U31WWwj/SKJ+HtyqBKRyphjRdtEZG926ByPuwIMRIVX9gc4huclyq+YkHolmD
	CK36eNrxWd8XeR46YSWpdJdKKRHl3W9U8/EHDps32fbceY1oRJ8EPliMGEY7L96FOI7kaG7KOYE
	uRQkEMkIbtwKwcBz5lAB+goeGFE+/h2BxrJoIOVbAMPSY6vhx2EhoisHB0ITZRkAdU9BxDiGzJL
	VFy0OILNBv5WlIFgs8uViT9kc8ktZltiHeaMLebSafmuMSIFNspdjlTLrvdB/J6awfySkasXBRD
	bVKKVpRkS4SIG8F1CqSXJy+2dRRdWxZM2wnPoZubCJjiHULsf2npQS2ZfI6gT3+HIxlp7iB+Mqi
	CN0ubRFy9uLDYY0tyyEthc7hQ3pQMH06FeNsHDiNhNROuJnAdLDWX/cNw8ApOuIZ+EYU6dFusIj
	GAu97N8WjPNN0b6g4Q==
X-Received: by 2002:a17:90b:4d8c:b0:3ac:a521:95e with SMTP id 98e67ed59e1d1-3adead4f7ebmr732875a91.47.1792800245556;
        Fri, 23 Oct 2026 17:04:05 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 02/11] bpf: do not intersect with current register range on clamp
Date: Fri, 23 Oct 2026 17:03:44 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-2-d43a07eda7af@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

scev.c:bpf_clamp_scev_regs() is called each time verifier returns to a
loop header via a backedge. It's purpose is to re-establish computed
variable ranges for registers with linear SCEVs.
It can be defined as:
- For each register R with linear SCEV compute:
  - loop_range(R) := entry_range(R) * iterations_count
  - range(R) := range(R) ∩ loop_range(R)

Such formulation is necessary to avoid ranges over-approximation in
examples like below:

        r1 = 0;              SCEVs: r1 = (linear r1 1)
        r3 = 0;                     r3 = (linear r3 1)
  loop:   r3 += 1;
          r1 += 1;
          if r1 < 5 goto loop;
        r0 = 0;
        exit;

- At loop entry r3 is widened to be in a range r3 ∈ {0,1,2,3,4}.
- After increment it becomes r3 ∈ {1,2,3,4,5}.
- On a second iteration the bpf_clamp_scev_regs() forces r3 to become
  r3 ∈ {1,2,3,4}. W/o clamping logic r3 range wouldn't shrink
  preventing loop from converging in states.c:states_equal().

However, intersection logic might lead to assigning an empty range to
a register, as in example below:

        r1 = 0;           verification
        r3 = 0;               path
  loop:   r3 += 1;              | <---------.
          if r3 != 5 goto +0;   | r3 ∈ {5}  |
          r1 += 1;              |           |
          if r1 != 5 goto loop; '-----------'
        r0 = 0;
        exit;

- At header r3 ∈ {0,1,2,3,4}.
- While exploring the branch `if r3 != 5 goto ...` with r3 ∈ {5}.
- On a second iteration:

    r3 := {0,1,2,3,4} ∩ {5} = ∅

Which stops verification with the following error:

  verifier bug: scev clamp produced empty range for r3

Technically this means that the current verification path is
impossible at runtime and should not be traced further.

This commit mitigates the above by removing the intersection logic,
the function is now defined as:
- For each register R with linear SCEV compute:
  - range(R) := entry_range(R) * iterations_count

This is still sound, provided that SCEV expressions loop execution
counts are correct.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/scev.c                                      | 6 ------
 tools/testing/selftests/bpf/progs/verifier_scev.c      | 2 +-
 tools/testing/selftests/bpf/progs/verifier_stack_ptr.c | 7 ++-----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index f9e2ca6a5a12..d67e793d7a18 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2896,12 +2896,6 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			continue;
 
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
-		bounds.r64 = cnum64_intersect(reg->r64, bounds.r64);
-		bounds.r32 = cnum32_intersect(reg->r32, bounds.r32);
-		if (cnum64_is_empty(bounds.r64)) {
-			verifier_bug(env, "scev clamp produced empty range for r%d", r);
-			return -EFAULT;
-		}
 		if (log->level & BPF_LOG_LEVEL2) {
 			bpf_log(log, "loop header at %d, clamping ", insn_idx);
 			log_reg(env, r);
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 661ce9ca8f93..14594ba5dbfd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1592,7 +1592,7 @@ __msg_next("  r0=(+ r0 -1) / (linear (+ r0 -1) -1)")
 __msg("loop header at 1, header_count is 3 ")
 __msg("loop header at 1, widening r0 to 1..3 step 1")
 __msg("1: R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3)) loop_stack=1")
-__msg("loop header at 1, clamping r0 to 1..2 (s32 1..2) step 1")
+__msg("loop header at 1, clamping r0 to 1..3 step 1")
 __msg("processed 5 insns")
 __naked void post_cond_jne_neg_step(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 7fa7bc207850..dc176f407c36 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -601,11 +601,8 @@ __flag(BPF_F_TEST_STATE_FREQ)
  */
 __msg("loop header at 3, widening r7 to -72..-16 step 8")
 __msg("R7=fp(smin=smin32=-64,smax=smax32=-8")
-/*
- * back-edge state is clamped to the remaining iterations and pruned
- * at the header, because [-64, -16] is within the widened [-72, -16]
- */
-__msg("loop header at 3, clamping r7 to -64..-16 (s32 -64..-8) step 8")
+/* back-edge state is clamped to the widened range and pruned at the header */
+__msg("loop header at 3, clamping r7 to -72..-16 step 8")
 __msg("from 5 to 3: safe")
 __msg("processed 9 insns")
 __naked void stack_ptr_subrange_in_loop(void)

-- 
2.53.0
