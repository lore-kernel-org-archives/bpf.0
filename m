Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057923;
	b=ki0c544/VInz48iDBR646sEwEYg34S+n4yvhCj5CztiI2hyjd168a/eUVQB+6xe4vzvb
	 Xq9rcbBee3StYWyMkhlEme/jFj4f1ktejGAjSi5mpHMpeXP47E+dkUAu6YfCW2UWQrLJR
	 K0twT1heKeIB3fugmc7BELfpCJA5FRZdWZp69C/FHbt1c1rcDdK4rsAUSvLXvEpZEYAt6
	 qbgaC4rdXVriXpLoBgIgQ3x6CLuwMLpYA670J4z+jw6hNx7gB8zlAKNovKndzRV9uFLki
	 yoUURF3l75Do4CxrGhZqQ03gnb9sqhRws9o4ipJmUwtvlQoVgiWEXMy35VbwKpDki5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=RuVpHRmUREonjwCYN2VSkhj82Yn0WMXX/nTK4XVTkCE=;
	b=FRjm4p37W8riM3HhZzNWZeNMV9zxaYOHRoL1T4OhEc7OPqHTGX8HOMXhOyYRLvYc9wAh
	 xKkeS5tvwB/xbvQhsJVp1hLnXODh0a0+6xJblFS0raJ5S8+DyPheJLBrhiMUQzmDqmtxM
	 7bBr1RnRSGKqYcGpM2sikyy125ntudR2EajdXJE/u3iV7MbkljhSHjglf8cwmHWuwoF5/
	 GdF4RWQ9fej8crXfXSEGh0jrZxjGIhAK7Rcc5bEQE9xU0C5yB/e8DIjIquxa28rHk/gdZ
	 XhYPNqzvMoP20OmY2PLRN5d6p9YRTqYQ8k14ZX1RKZjrBHrHCsXN0IQAAQtGK0wDhkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HcWlzQXE;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491AF606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HcWlzQXE
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so3530664a91.2
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057923; x=1793662723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RuVpHRmUREonjwCYN2VSkhj82Yn0WMXX/nTK4XVTkCE=;
        b=HcWlzQXEVVA6TuWxNeVmqhLjlSfbb3RfrF4aUzO3POg4fnwLjVumgNI7/lIB/wJIel
         ThZAXPnMN8kZyxucQLc1aR8Cd/aHmudHW0+WvRlIvvrNQ25N/x6grc45Y8e8QbR+1R3O
         08YWhNGSDUQScRIDeTbJ7Em/caxrSKO2UyzOfH5qvhCgKfrncGEPN1LhMDpQawPTTTcD
         Of/Npt2plBU/o7mOQa52IVMoo8nt0pcTlCU9QvOhf0epQVCUDQrrI6y/ERfQ/atND8GZ
         mSh5XU+cVVjEic87yAaW1DHjS/AYutcFNVlyW9A6e47X+sDwSOMBhL+fir+o4V5HiwOh
         H38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057923; x=1793662723;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RuVpHRmUREonjwCYN2VSkhj82Yn0WMXX/nTK4XVTkCE=;
        b=TQpRWDDEz+KYCQCZ+35ST9Bp7mZhjtfy4pYonJUBWloKOkQWK8Fe4+vhDqGDfMCK3F
         1lAAhYTWWhj2m5zuzlTdKL7/OJjZem/MSb5ZQkiLUttwp3OFb7YQmRNFE+IBDwFNiQM9
         MlUVdvORAX/6ZYMt5dFxuKdutCQDb5MEdBDOnuIG1XL+L/RFSVte0ng5ZoyEhuXCgp5b
         NMfog1UQLZ3wfbWOVB6OTwjpWmCvpvHL8rnWwUSvBuru5KmLST+HthMjvleOLrsIS9TW
         TxmHj5ve84rhjjuN24B9vRuUhZKgNct+YWyqKHwrJF+7J42Tgu7z28TE+Ltk7vUNVy6V
         Xl+Q==
X-Gm-Message-State: AFq9FYKEa3n42NBSqlqTfv9HZBeOMDeOW4+4P4eT2paRKkyW1VdFfaSU
	Z5hD2/X9WuLraI1DxA9rLeiH8ufu3nv+oFuA5pSUf3lV9lOPhr5b8twr6ZcdTA==
X-Gm-Gg: AYBFou3G34oVV1fZVYQhytUhx6nV0+pr3bPlWSOol2nHeGJCkUiTTLnzhDMKibNGf/G
	5FcvuX04LnJyIXjHW4tT9EdxVBp1DPzmeb5dh7rJ3pZv6KzkyHKgIX3c+4ZhY+qLvvfX0outSI2
	ghlSA82c38wJyhcjG1kRhWikY1vhnqWsMo+Fgvj676veeascH1ZutOytdWO84mIVIrvPhN35Yah
	df7JuRY+oDC0RWweN9sQDxlT8SQ89kBa16MLIQdFPXXCiEuatko2/etz2RiNQVpmwfFgeG6bPcu
	Q9Ll0p9n8WWKHW6mAs4ELvzDAE7RIv3/9SEj7VhQp14maG6+79P1uPP0xIMdZULlVe9zR6xKgx8
	5QMJp5yzChMS3Lq1vk20cy1i3sqm6lgk1FTCsHyRFPS8hSciyv68HWvr8VnRfhJFuk/XOlfSrOJ
	N0vR2fVLjNxwq2mDWA0wJjeXZ3203uBWe+J5toWaC4fXSIh+cjitopHSWlgupypN3YS/ksPJxcD
	BYF1DByQAyNLmYn3SiASVffxodiCw9xe8ERs3aRgqG0fICivNiDoAH27uaXfZk14HxmId61VyUg
	4wb6Hq0lpwPLARrolof87jwqRboyFY8fAkHsBR35GRt33JWKCOf3fq+vQ3XHgf1lDG7gOIZc
X-Received: by 2002:a17:90b:3bcf:b0:3ac:9d83:885e with SMTP id 98e67ed59e1d1-3adeafc1f3bmr6762102a91.52.1793057922623;
        Mon, 26 Oct 2026 16:38:42 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:42 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 02/11] bpf: do not intersect with current register range on clamp
Date: Mon, 26 Oct 2026 16:38:22 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-2-f373aec9825f@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
References: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
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
2.56.0
