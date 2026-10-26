Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057929;
	b=SlTQAhzAXQ1WsUpVzJIMMSAAzuhHckwC+Aa7I50pwv8fX7C9ErT4bS1jO/sym4m2XVcd
	 KrfZE7iKchG3EEGm3RKg0pFqPtQCoxTlJ9Ar7ktmdn/5CJXmWW4cFZy+ylJfj83a4ERrN
	 pEQWlkuBwVw8ZrINarMeewcH6JXLbjfSrnsVNkRO2kzTOEvqT4WCV9qmpoT7PZjJeakdx
	 yNk3QEnLK+lqiICqkqCGNMmkO6pC7PVcqzLARtm3h8CeDVB0X8pqg3SgaxRDShzcRrDK+
	 5jRkK2KMYlvGaxtzxITCocvHBsBElTDHoeUqP8gOkXSOunr3ntMU16WsBbJBH9TRXgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/cGSnGY8pcfoHjULtiXxiadFRDRlApEY2QlnaOhO6hw=;
	b=JQepehfPEvEqmfXMclyugZ50Wbn/U/Ns7NCBA+RstNTlWHhKfdO+0ZARA2uyLEFU0npk
	 Jpyw7YeAvRlPqij6aMoR/VAj+YvwhpQ/XD7Q0gDU3x30IgLyKUR0rzCHzVJzO24POQafe
	 dvis0gznt3q9urt6+a3XgQPug5KBQ7A/ze4LfspoxuaGuwh+FDChrPRl3gXB2WOwUR4hH
	 s8gSK9HHB4Qh0pmpkUkpMGcF9BFILEhby4JddNr0jWW22beXxaRbGX0jt5uLQPbnC7VHB
	 EHOpjEpL/HcjF1rh+oJdkf7b5KyPGh0uWwALRcgqGoCpWLKERtlKJrgGJyzQV3RdPoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eZ17bKDo;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC172606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC172606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eZ17bKDo
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2367339a91.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057928; x=1793662728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/cGSnGY8pcfoHjULtiXxiadFRDRlApEY2QlnaOhO6hw=;
        b=eZ17bKDoKrzF4LEpjdS2WviEr/TL+xy4ofmU4jNoqM2OLZZLlFlBvuL4tTw1IJcT+u
         6B/pB1EjPSgze4Wz3EyBB6HWllsQSz4XRXIdHRwf7gPzHhfoWBg0ftmRtoAQsYYpNHGT
         JbZbaPwoF+SisPPyClZh8tmRglZkFjDCXpDXAE6hgr/tIMypKx70z9BanpiB2ZPW/hmF
         x8oDm3yv1YCpci86UIHkG2zH3P5uRvx+PqPH+XsUTkHKmBG4zAs6x+8FsedhThkjjzi5
         9gsP336QVWMlFPNqioQSEr1YjzbpmLPXistO6yws281+eLQ3EqwqE1i8bYt8iP4yuWLP
         J/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057928; x=1793662728;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/cGSnGY8pcfoHjULtiXxiadFRDRlApEY2QlnaOhO6hw=;
        b=nSSfm8NjuKE8KI8fFg03o8xMkGeyRdOv6uEuf5yk2cxeqgSkBMYhVbkBIsOOjEx0qc
         Zp58qKvL8Bq6djugq94Y+kUn8zUsL2po5XnflhXVbkoH+1iOSpnWucePRXe9a5YkG1sw
         TtWQN8jnL7aBjWoS8sLP476oM+tGFAVdb0J/H3NiKq4oX18Qx1ZlojYBPEXNXWLK36eY
         gveXs1qoonf4xj0gIkQnceZAUfWRLD6QbsOHLJZidkznnaTTWcbM4NTOTGfwaLjuHKhs
         WT1aRbj1KkQ3G0W/cITv0dA6UF0I5NJKLoV3+MtlbfLfd6GDd3DrYfmIVTxGUrrdOhck
         nx2Q==
X-Gm-Message-State: AFq9FYKWGv0rX4llWxX4a/4GZ8Lih3z/UbteAnA6zRU3DPYOJlMs3C86
	AH+UgOoF3sRmrTGw0MyzzYha0sAK91fFFuxP8Al9th7+SHclQNNU4azP73R+Yg==
X-Gm-Gg: AYBFou1fN2+G1xaYBp1KLktZDt8OS53h4xP0HA+mPLOAenabcsOVlr5VR1PCiJgr67o
	+orRda6fahPZWXKsSNulfi5V284iMawV4uQ9+BwzDiSfuisSiDq9VcNmQn70o2LGKecbYdPZwEt
	KSZYdCmCAZISqaaXl9levCptFKbYUO/xId9hcEmxpk5gGTyXXiEXBut9xAZ/vBk/qDCW2hYAFNU
	F2v2IhRW4u7i1C3yXjVntLg09mpLBp59qUT90bHZblTxGa7+3qdi7+S2n9R/0PT5MsQ3ylR7HgU
	ZhrZp+YN5zp3BH+d3pqIWURa+MOjIeICLmBZOJjwSlv0OfgETJji8Ia4NGIyLWRPqB8W7dKNSDa
	UHkP/gFeOb45nRNCxo60tywPQZjrk4L3seakUmKGAfvAxifb1KlV212C2kcFnbm56vwdrDSCYzT
	WzZmd2e2WkPbBga6ze8XTiLygIF0Q2VhYzsVr9Q4i9HSPzVOWjY4lY/3TBNEk7cRyVlUZUiz4Qp
	WndxkTPHdlBBdTY2VyNR9qYkJhzIxzOyMdfvlEFT9+FwEuCqleflEPayEvrsJJtjpQ9OqMysqQZ
	2sx/yfTLAvVZjFUAVz9mgeA=
X-Received: by 2002:a17:90b:6c7:b0:3ac:9d26:551d with SMTP id 98e67ed59e1d1-3adeb10f4cfmr6795214a91.50.1793057928277;
        Mon, 26 Oct 2026 16:38:48 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:48 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 09/11] selftests/bpf: cases for SCEV interaction with infinite loop detection
Date: Mon, 26 Oct 2026 16:38:29 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-9-f373aec9825f@gmail.com>
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

Add three test cases exercising state pruning after loop counter
clamping. All turn a 32-bit stack spill into STACK_MISC during the
first iteration. This prevents a state match at the outer loop header
on the next iteration, while allowing states to match further inside
the loop. All are falsely reported as infinite loop w/o changes in
patch [1].
- clamp_callee_state_pruning(), a callee overwrites the upper half of
  the caller's stack slot. States then match at the callee's exit,
  where the current frame has no active loop.
  Verify that current_loop() finds the caller's active loop.
- clamp_nested_loop_state_pruning(), the overwrite happens inside an
  inner loop. Exercise matching states when the inner loop is entered
  again on a subsequent outer iteration.
- clamp_nested_unrolled_loop_state_pruning(), same as above, but the
  inner loop is not recognized by SCEV and is unrolled with a precise
  counter, so its entries are never marked terminating.

[1] bpf: avoid false infinite loop reports after changes in SCEV clamping

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 98 +++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 4e58dd475b88..39603c8bf083 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -2567,6 +2567,104 @@ __naked void no_widen_any_stack_origin(void)
 "	::: __clobber_all);
 }
 
+__naked __noinline __used static int scrub_slot_callee(void)
+{
+	asm volatile ("					\
+	*(u32 *)(r1 + 4) = 1;				\
+	call %[bpf_get_prandom_u32];			\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The callee turns the caller's fp-8 into misc, so the states at the call site
+ * differ between the first and the second iteration, while the states inside
+ * the callee are identical. Verification fails with an infinite loop error if
+ * states.c:current_loop() does not search upper frames for active loops.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 3, widening r6 to 0..9 step 1")
+__msg("loop header at 3, clamping r6 to 0..9 step 1")
+__msg("12: safe")
+__naked void clamp_callee_state_pruning(void)
+{
+	asm volatile ("					\
+	w1 = 1;						\
+	*(u32 *)(r10 - 8) = r1;				\
+	r6 = 0;						\
+1:	r1 = r10;					\
+	r1 += -8;					\
+	call scrub_slot_callee;				\
+	r6 += 1;					\
+	if r6 < 10 goto 1b;				\
+	r0 = *(u32 *)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * The inner loop turns fp-8 from a spill into misc. On the next outer
+ * iteration, the states inside the inner loop match its first invocation.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 3, widening r6 to 0..9 step 1")
+__msg("loop header at 4, widening r7 to 0..2 step 1")
+__msg("loop header at 3, clamping r6 to 0..9 step 1")
+__naked void clamp_nested_loop_state_pruning(void)
+{
+	asm volatile ("					\
+	w1 = 1;						\
+	*(u32 *)(r10 - 8) = r1;				\
+	r6 = 0;						\
+1:	r7 = 0;						\
+2:	*(u32 *)(r10 - 4) = 1;				\
+	r7 += 1;					\
+	if r7 < 3 goto 2b;				\
+	r6 += 1;					\
+	if r6 < 10 goto 1b;				\
+	r0 = *(u32 *)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * Same as above, but the inner loop is not recognized by SCEV and is unrolled
+ * with a precise r7. The states at its header still match between the outer
+ * iterations and must not be reported as an infinite loop: the path between
+ * them crosses the back edge of the terminating outer loop.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 3, widening r6 to 0..9 step 1")
+__msg("loop header at 5, can't compute iterations count")
+__msg("loop header at 3, clamping r6 to 0..9 step 1")
+__naked void clamp_nested_unrolled_loop_state_pruning(void)
+{
+	asm volatile ("					\
+	w1 = 1;						\
+	*(u32 *)(r10 - 8) = r1;				\
+	r6 = 0;						\
+1:	*(u32 *)(r10 - 4) = 1;				\
+	r7 = 1;						\
+2:	r7 *= 2;					\
+	if r7 < 4 goto 2b;				\
+	r6 += 1;					\
+	if r6 < 10 goto 1b;				\
+	r0 = *(u32 *)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
 /*
  * r7 starts as 1 + 6*k and invariant r8 as 1 + 9*k (0 <= k <= 3).
  * The (any r7 r8) union must preserve base 1 and step gcd(6, 9) = 3.

-- 
2.56.0
