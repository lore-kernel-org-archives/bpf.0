Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742643A7E9
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121154; cv=none; b=Htl5DJPLl4Virw/pfxcnSNHyFjyGu+J+r126Tv2gz/njuqTxWgTR0e7hlEDUBqdJTvzvHnU7DEWM2d6qkQvgzBp85CwT3KVgk2g+ZZu/2+tm1/TWsN5o3RHt9x5EwSLf0ftGfsAp4zI72FbqRQBbdRKY3YqJk8k8LUxsi4UXMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121154; c=relaxed/simple;
	bh=oafXXg4h14So48HC4vVjdQ1HUbGEKnjSaRPiCygMuHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCd6LUKADOMeg1Az9ApMOFk3FOLKdZOfjUoXVVllB7CEuXRCdEQNXRHAcWQYfj4LW8GYv2pJWVHfPvDWM+nO5BODTGER7397V+D7RWfToLwUqV0xJgrJwJa4ZiHGwyT5vkLtGKLvVJsd+7bNmXHz/QM4wNzlmk/kUpQvE5mb+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igpOYsTp; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igpOYsTp"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-88826f3ff80so256512b3a.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121152; x=1791725952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kfhZNrHByAgRuSHJSyl3+ND3VBktsxkCR/euRUMPZXA=;
        b=igpOYsTpiAopIgK52MK0X92ACQeIwOtZm8mW5H6DkEvLvQCHR/HlxJ0S5K5d0wzaKr
         RJRWBjV/NG7txlToaFHmgsIrBTYSK0tFMGQ0RezNQ9RUvUVOrs1xxEkPJI3c0/vQAJCZ
         q5G+QFP2XF8Vl/MNeea5ptSpvZndj48mzmelBfORgJDnwmDUqcUQ7Y45JTXX37nQ21wT
         tgAuerN6k7x6t/ko9ezq5ylIA/hZtvL5dLqJZF+mpPZoVuM4CUvrApUjda4GgZs1VI3i
         x/hB/VH69MIPSkUDXESsmifBsjXhlRXWi+zS7mlWCB9ZA3j5b5wuBMTGv7ZwOUN7uH6V
         oZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121152; x=1791725952;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfhZNrHByAgRuSHJSyl3+ND3VBktsxkCR/euRUMPZXA=;
        b=YpmKOudGO3RGyxUDMTslExS0YqGNCnZitgpZzV4Q+UEmFNyDJK3QHrSB4BmZc2qrXj
         g0nBFI+5vRBVT9JUGsNYZsAPgCrzqOQ7RIzPstDw4ngvyWTaXhwVZI84vcCYmORWwA3y
         LdSAo7iPjB4b45Z1SaSI36pTJaKZiKNdPEyyeNumZ8nMNiQgigsg9hROjvFJxhnlapBn
         pw1htatmEKh8cqSFmZlvn/fbWnissgwZXNYke+TZQ/yPMOJ8c3Q9rGpVsy5v6sZX6MFZ
         l0Dl6TXxhScwZFGpjH6H/Ay0CMjv+T27wXZPc21yh/IkduLWDNswNlyRRJJmdVvEI49V
         2o6A==
X-Gm-Message-State: AFuF++n139BxhzXbpLuRzAT3FYQiZyti87SAVin+n4y3PINW7zH2/hTy
	QZj7fWIr9t2orxP7C1op+E8hzoJrnsCB/b3j4LdVdTc4ywxzwLusgmZpJwWbEQ==
X-Gm-Gg: AYBFou0fHpeY3aD9IfVpQe1kJhA5SUYnUZXNJH3jAwKF4SC0nCVV75tzSmYLaZyRBTQ
	cTQ7ubdqTKrXIJWyy61mLvCletd0gGOfo3/AE405FAdSW3ARilH1PXDAHEkoHw1JWuf1r3mW8hO
	IwMsfBBv3EyUqd6ul+AtQqzAx5d+VYtlLlS3rpUu44xlIzjU1P4cQMTfI9bOktYjxSlsH6MJNUO
	LTUBafe+i+i9MZJBZdEPiGh845/weSy7pASHmXI1Vc9/ykT9LsJaNvLXjMfeYSRVR6vsypHLfWZ
	Z6F9XzO37qTD79D+pESKNeCLZwocf+sjEOJegHzpEGOztxZ0uiq6gAdQUnh7E4fekivRoLs8aVN
	Ni+Vdqwd40fTDV1Cqh0mkZlsGoNtYWjBvjUmrkIySvh0Oq6ROuyeNEGeA9EueBd7lsagPCNuM8F
	6cP2YEVFZpwR7mGjDDcQoJkhkxU6kXxP9A0GgfzA4dAhBd5ioAIvTJMHodhNWk90iZqtvZ02SK6
	MQGw2hh2JmYbks=
X-Received: by 2002:a05:6a21:e10a:b0:3de:b120:bb8f with SMTP id adf61e73a8af0-3e0bcf9e418mr8168524637.50.1791121151586;
        Sun, 04 Oct 2026 06:39:11 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:11 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 39/43] selftests/bpf: tests for register base/step state pruning
Date: Sun,  4 Oct 2026 06:38:21 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-39-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Tests for the base/step reasoning in states.c:range_within():
- step_prune_hit_multiple: prune a step-4 range contained in a cached
  step-2 range when the scalar is used to address the stack.
- step_prune_miss_non_multiple: do not let a cached step-2 range hide a
  step-3 path reaching division by zero.
- step_prune_hit_const_on_line: prune constant 6 against a cached
  base-0, step-3 range.
- step_prune_miss_const_off_line: do not prune constant 7 against that
  range even though its bounds and tnum admit the value.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds_step.c     | 183 +++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
index 079e34820a8f..f1d8e36b39e3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -287,4 +287,187 @@ l_out_%=:						\
 	: __clobber_all);
 }
 
+struct step_val {
+	__u8 data[1024];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct step_val);
+} step_map SEC(".maps");
+
+/* Old register [4..130, step 2] should prune cur register [8..68, step 4]. */
+SEC("socket")
+__success __log_level(2)
+__msg("7: (27) r6 *= 4                       ; R6=scalar({{.*}}umin32=8,{{.*}}umax32=68,{{.*}},step=0+4)")
+__msg("10: (27) r7 *= 2                      ; R7=scalar({{.*}}umin32=4,{{.*}}umax32=130,{{.*}},step=0+2)")
+__msg("11: (25) if r0 > 0x2a goto pc+1")
+__msg("from 11 to 13: safe")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void step_prune_hit_multiple(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r6 &= 0x0f;					\
+	r6 += 2;					\
+	r6 *= 4;					\
+	r7 &= 0x3f;					\
+	r7 += 2;					\
+	r7 *= 2;					\
+	if r0 > 42 goto 1f;	/* can't predict */	\
+	r6 = r7;		/* step=2 explored first, step=4 explored next */ \
+1:	r0 = r10;					\
+	r6 = -r6;					\
+	r0 += r6;					\
+	*(u8 *)(r0 + 0) = 7;	/* force r6 precise */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(step_map)
+	: __clobber_all);
+}
+
+/*
+ * Old register [0..189, step 3] should not prune cur register [0..30, step 2].
+ * Bounds and tnum containment allow pruning; step divisibility must prevent it.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("6: (27) r6 *= 2                       ; R6=scalar({{.*}}smin32=0,{{.*}}umax32=30,{{.*}},step=0+2)")
+__msg("8: (27) r7 *= 3                       ; R7=scalar({{.*}}smin32=0,{{.*}}umax32=189,{{.*}},step=0+3)")
+__msg("9: (25) if r0 > 0x2a goto pc+1")
+__msg("17: (95) exit")
+__msg("from 9 to 11: R6=scalar({{.*}},step=0+2)")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void step_prune_miss_non_multiple(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
+	r6 &= 0x0f;					\
+	r6 *= 2;					\
+	r7 &= 0x3f;					\
+	r7 *= 3;					\
+	if r0 > 42 goto 1f;	/* can't predict */	\
+	r6 = r7;		/* step=3 explored first, step=2 explored next */ \
+1:							\
+	r2 = r10;					\
+	r6 += 1;					\
+	r6 = -r6;					\
+	r2 += r6;					\
+	*(u8 *)(r2 + 0) = 7;	/* force r6 precise */	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Constant current register lying on the cached line: cached is {0,3,6,...}
+ * (step 3, base 0), current is the constant 6. range_within() takes the
+ * constant branch: imod(6, 3) == base 0, so cur is on the line and the
+ * (precise) state is pruned -> "safe".
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("14: (27) r1 *= 3")		/* cached path: step 3 line */
+__msg("16: (b7) r1 = 6")		/* current path: const 6, on the line */
+__msg("17: safe")			/* pruned at join: imod(6, 3) == 0 */
+__naked void step_prune_hit_const_on_line(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[step_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l_out_%=;			\
+	r7 = r0;					\
+	r1 = r6;					\
+	r1 &= 0xff;					\
+	if r6 > 0 goto l_cur_%=;			\
+	r1 *= 3;			/* old: step 3 */	\
+	goto l_join_%=;					\
+l_cur_%=:						\
+	r1 = 6;				/* cur: const on line */	\
+l_join_%=:						\
+	r0 = r7;					\
+	r0 += r1;			/* r1 forced precise */	\
+	r2 = *(u8 *)(r0 + 0);				\
+l_out_%=:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(step_map)
+	: __clobber_all);
+}
+
+/*
+ * Constant current register NOT on the cached line: cached is {0,3,6,...}
+ * (step 3, base 0), current is the constant 7. imod(7, 3) == 1 != base 0,
+ * so range_within() fails and the join is traversed again. A power-of-two
+ * step is avoided on purpose: with step 3 the tnum is loose enough to admit
+ * 7, so imod() is
+ * the sole check that rejects it. No failure shape is possible here: 7 is
+ * within the line's bounds and tnum, and the cached line path already
+ * verifies the whole outro, so an eager prune could not miss an error.
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("14: (27) r1 *= 3")		/* cached path: step 3 line */
+__msg("16: (b7) r1 = 7")		/* current path: const 7, off the line */
+/* not pruned: current continues past the join with the constant offset 7 */
+__msg("19: R0=map_value({{.*}}imm=7) R1=7")
+__naked void step_prune_miss_const_off_line(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[step_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l_out_%=;			\
+	r7 = r0;					\
+	r1 = r6;					\
+	r1 &= 0xff;					\
+	if r6 > 0 goto l_cur_%=;			\
+	r1 *= 3;			/* old: step 3 */	\
+	goto l_join_%=;					\
+l_cur_%=:						\
+	r1 = 7;				/* cur: const off line */	\
+l_join_%=:						\
+	r0 = r7;					\
+	r0 += r1;			/* r1 forced precise */	\
+	r2 = *(u8 *)(r0 + 0);				\
+l_out_%=:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(step_map)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
