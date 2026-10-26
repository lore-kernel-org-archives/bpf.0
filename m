Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057924;
	b=pYtNEHivykw6ZWugOMljQYOizbctjRVD9aTPeLx9aBpbegCIbc3w7o3j+pycDjFQLlEb
	 uLDb33BClGfaCyp4fCgxaOl3oiORlPLQIk0bvL5ZDBqjX8jqDIqwEz771NSWVYr2OAXfY
	 gheJF3VLRZLcIprIr3bv2IY3G6HNJTwAOXAr7wT5lntoyH23CvTzFOUTZTfGriGWn2a41
	 J99gEubXbP9uAx9872mQx9vKePs01ZuPp/QappIcR0CpP9ikNqbQs2S3h8brhGp6nB8M2
	 z2XXdRLP1s3lqmYPm32CmCFM0G1eB66Amkraz9gAF3h65sqJpXh4sZx+WXcieDDywyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9jqH4GK7azWZ1JMmHhPse81HF3E/rGbXMCrBJVUazUs=;
	b=J1FxKLSCO1NhYtCa0DjZzdI4E4tMPEjKuP+U0ZglmKdVk+6oLfhP9moNg+RrhTE3QH27
	 M8ct/BHhXnJtZ91TgKLtU0UziaeSgiIyyeWV+z4Jl5rqgX4XKjAEUX9S5Dng+faj6z6uG
	 on3QEqlrPyFykPTceGEO1CWe8RF5MR0NnhOzkkiXLMnd9OQVGKME0IbrSzriR/kP7Ap0C
	 xHLER9DHQ9cVxZHZ6Ty+P9PwaGevnMpbn4tYySIJmVw7bDpMfLtw+2MbfS5nRZN58Gad1
	 HKB3EDDikWWrCxpsV9rxbm+X8FZX6fvrtOkyA/9g8pV7Fom6R6Xws+8S+GslEtqUgoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VPEPL5oS;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275B606A321
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5275B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VPEPL5oS
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2308670a91.2
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057924; x=1793662724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9jqH4GK7azWZ1JMmHhPse81HF3E/rGbXMCrBJVUazUs=;
        b=VPEPL5oSeqFsiBxuT16MP+g0G//yU+8Y2SpTU50C7zrDuMwP+bvFeyTgIxec0N777m
         pGexohVg6tPm49uB+YqcwUgMnSD6u2D60+sN96He2pLARKjUeOYfoxxz00ZamCZr0rri
         faKeSqPROBdRd0WA4jHF0zRSgUtRTuJU+Tsf1XNCLZ6hUuUDIusVCuE6EINfxltyTJd8
         VUXFIHdgFQY/ZhomB9vbkopo+pPHkWlZUgPNj4e/rNe9oLojA3SksUMrctYg5yhsgiDS
         kaPJhAGc84MRLo6C4meKvlCrgrjgjsQSjKMPVhF+hBwGz9g04i+WNJbzUDAIRbIHl5rG
         at8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057924; x=1793662724;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jqH4GK7azWZ1JMmHhPse81HF3E/rGbXMCrBJVUazUs=;
        b=W1R15u5fw4etk69HirMIL1L8vlpGzy3KoV2k+k5DmkI7RM0z2ojaAoB6YWKwYHyeZf
         BTW6Dw7NQuAq1FA5UKUp8ooBoH34KiPnU6fr8l44Kxl/TDMjmZJjYyXWFZOlrqjM1cLg
         LEOpQrT86MX9Wi3JWwfore4fpjWPNte0b/YC5DSm9kwY6mJSWMxz2ABIYRgCeeR+ypFB
         +9HCZk/vpsCgaOVRUtu+f0gpNSJPDcvi1BtPHGBn8MhXWmXzVZw9fAwf5bCefeQSEIm1
         Jjrd5iZOCQWJUucbLAlBPFPb8CPxupPXE39+90w3CCh+f5GgGvYhYAjI1t8qDHihKiUs
         Hxyw==
X-Gm-Message-State: AFq9FYLlzIqmhZfhxkYkB/b7z9zRqqcV3mTZLhikxnAZL6Q73VsuANJM
	uG6v3ou3Fv4h/kEnNtMi6qaG7a20wMvv6EcWZYATQC06ScdT/fHyA4MK+fF1dA==
X-Gm-Gg: AYBFou21+WmVwYF20iBuLtKBGrGkAEQj1US+8SGkoVV0k10MdmbjLEyhXJ+y1wX3+Pv
	8zfCzKtTNcnUr8WatadH1TvnBYDdi26gnB0DdSh03K1PkAaNdYRvBuyowjjHCu3Grnq4u13TLyi
	UaLLKWA5t+fuhqnce3U47iiCLauket8G2l7Li6f9NiuVSvvFEPCR8VveQv6CuRxsSBQu5jxOnbl
	FoWTVbomYYZ039bFcjpoKg52zvJyauHCn53tn0BDtrgTPmKdIrXAKTWCvmKKp/TXxnurbeBVfpo
	gGsgYpLHM+NtNs5ZwFsSXkOeKOkytw0iGaX+06OkEXmwxwELr214NnSuAwGCBoumrJwkZlNGEcW
	NUzCneF4xJryeoeQySinla/WdbBIeskMCNF84ftR8zm4p3UJaX1HLUlo+ATvA9erpyPVEJnCVB6
	EeNzdkw7dAdT1ACnpR7wCgaX3Ir9iRGhOrDGWr37YfvYvS0gLJ39QYbTSpaZjx13gFCz5IJt4fs
	O0j0z+/BNAeb83EW85OU43Lq290NU3u7iKhEVPQT06I2j435e/jRfR42A6fMeCdDMhH/qM3Pj+9
	gZwKhB7+kPaOIa3cRpn2pWQ=
X-Received: by 2002:a17:90b:52c4:b0:3ac:9176:e82b with SMTP id 98e67ed59e1d1-3adeae778a9mr6403234a91.54.1793057923551;
        Mon, 26 Oct 2026 16:38:43 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:43 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 03/11] bpf: avoid false infinite loop reports after changes in SCEV clamping
Date: Mon, 26 Oct 2026 16:38:23 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-3-f373aec9825f@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Clamping now reproduces the widened range at every back edge,
so induction variable ranges no longer vary between iterations.
This can produce identical checkpoint states in terminating programs,
for example:

  int main(...) {
    for (int i = 0; i < 10; i++) {
      foo(...);
      for (int j = 0; j < 3; j++)
        ...;
    }
  }

  void foo(...) {
    ...;
  }

Handle two cases in states.c:bpf_is_state_visited():
- For checkpoints inside foo(), look for active loops in upper frames
  as well. Otherwise current_loop() returns NULL and an identical
  callee state can trigger an infinite loop report.
- For checkpoints inside the inner loop, skip the infinite loop check
  when the current state is inside a terminating loop in any frame.
  That loop bounds how many times its body is re-executed, so an
  identical state on a later iteration does not imply nontermination.
  This covers the inner loop above, re-entered with a fresh entry
  state on each outer iteration, and inner loops SCEV cannot analyze.

The nested_terminating_prune test still rejects such an outer loop,
but now reaches the jump complexity limit instead of reporting an
infinite loop. Update its expected message accordingly.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/states.c                               | 36 ++++++++++++++++++-----
 tools/testing/selftests/bpf/progs/verifier_scev.c |  2 +-
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index d7df6632a5c4..a6ae86f973e3 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1358,13 +1358,33 @@ static bool need_loop_checkpoint(struct bpf_verifier_env *env, int insn_idx)
 	return top->loop_id == insn_idx && top->terminates;
 }
 
+/* Searches for an innermost loop entry starting from an innermost frame. */
 static struct loop_stack_entry *current_loop(struct bpf_verifier_state *st)
 {
-	struct bpf_func_state *frame = st->frame[st->curframe];
+	struct bpf_func_state *frame;
+	int fr;
 
-	if (frame->loop_stack_cnt == 0)
-		return NULL;
-	return &frame->loop_stack[frame->loop_stack_cnt - 1];
+	for (fr = st->curframe; fr >= 0; fr--) {
+		frame = st->frame[fr];
+		if (frame->loop_stack_cnt)
+			return &frame->loop_stack[frame->loop_stack_cnt - 1];
+	}
+	return NULL;
+}
+
+/* True if any of the loops call chain is currently in terminates. */
+static bool in_a_terminating_loop(struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *frame;
+	int l, fr;
+
+	for (fr = st->curframe; fr >= 0; fr--) {
+		frame = st->frame[fr];
+		for (l = frame->loop_stack_cnt - 1; l >= 0; l--)
+			if (frame->loop_stack[l].terminates)
+				return true;
+	}
+	return false;
 }
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
@@ -1528,10 +1548,10 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 */
 			old_loop = current_loop(&sl->state);
 			cur_loop = current_loop(cur);
-			if (old_loop && cur_loop &&
-			    old_loop->terminates && cur_loop->terminates &&
-			    old_loop->entry_state == cur_loop->entry_state) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+			if (old_loop && cur_loop && in_a_terminating_loop(cur)) {
+				if (old_loop->terminates && cur_loop->terminates &&
+				    old_loop->entry_state == cur_loop->entry_state &&
+				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					loop = true;
 					goto hit;
 				}
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 14594ba5dbfd..9074b2f043d4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3351,7 +3351,7 @@ SEC("xdp")
 __failure
 __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
-__msg("infinite loop detected at insn 6")
+__msg("The sequence of 8193 jumps is too complex.")
 __naked void nested_terminating_prune(void)
 {
 	asm volatile ("					\

-- 
2.56.0
