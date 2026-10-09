Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9DA4B2044
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542947; cv=none; b=b1IiyTpf2caaIDaqQZmiOvEr5e8ZpNm/bBHWVbM/m4ZhK6zp1F2W/hQKdO3lm8rxOJPZnKKKX+sR1geBsAgQ6GAlp/oz2SJdn8MVqM9VT6BpMiJBrg46/RyRkz2vN7y9WJHbazc4LWEiCN2wsrOprTOO2do64lvrvYYdpowTiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542947; c=relaxed/simple;
	bh=mgFJfHbD1InAUCkddOWg8iN6kf9nYgqwFvUM1dbbAHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHpiUnUBOkeuKJl7bf3C6lRAmL+7687kbAH5D4hTyFCwUTULnTp6uP/UnhbQNgr/0FEU7JXY4gXdnDVzfNO4tjTYdOUoYknC6YvVd0kun3/D2T7gk+4wububFrYif6/hve4P1Q0eMGAyDpFt5k7jyxmJ782I+NDx1dcBRxZ3rcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVh3ghtk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVh3ghtk"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ccc7a6070b4so2100456a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542934; x=1792147734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jrEyNzb8FVS3+vu6by6fFMKCl8d9KG/iJyMimmFL3f0=;
        b=jVh3ghtkpqSxeQ9K3ZUc+BhCEuA6+Xv8svp27+R1hqw+my/6TtqtdwUIN+tVOIWs9P
         pAPkLhtZ9kkhzbpacbfe4ZMlElLhaZJ8ezD51K3auCoLS043QS78pzGb0ggKjQr6DVdp
         T7Bhocncc/hc/2RE1SXUsqCWwqGlFnL/d4+xb3ElZIEvrMtyZEL351ATg876iUZIM1kx
         1D+oUas0Ry4wuWz3dvAGXq/NuD7uUomyyYKuM9/ib9xZjIis77FtIJ7Uphp57T7HgM/d
         irwa23sM9IX9qQ1BI5gKfZ96W2lfMQEF/mWmAr9UQsiD/WqYYC/8Ohe/8fSqBkVXbBtB
         ehSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542934; x=1792147734;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jrEyNzb8FVS3+vu6by6fFMKCl8d9KG/iJyMimmFL3f0=;
        b=vrsuaGWNYDJOOEeRJIq7xJvOR+JH2V7i3IOMHbP+/5T6CUiGhH5XNK12jn1m9/wnoB
         wAHmygjxJ7WS2OYcNTbfMt6o/UR8qUzSzL7Ci5mhav06MFAxTzn5IXbSZM/lBlEc1juu
         tf8P/sCwic/W34wuTsByzTTEvqoPzrcjTqwor3w/+7Ip4hN9d2O/oBavDSruiBhoDW1b
         o4VXgPSfikLoTGUH9H2qNBq1jUCQp51UJX/EESeXqPdkxNrWqDJd5nkaQ6IYzl3ym98I
         E+DTg47V1Mbd9JoVcYO94SLzmwQsiIcdTOwVnPUKOJ1zIEW9xVpiEYWv9YSBLKnqcST8
         0IXQ==
X-Gm-Message-State: AFq9FYK0Ytoxoh9kmyqKz5nmYb2vE1jURaPSLdC7ouKCINWEXimK6EaE
	rVFnGTTQlYg7aqSdcRNXQa0ciogVO4CcoA/pjP/R4+vpz09CLsMaLU0yQ/Nr/vWy
X-Gm-Gg: AYBFou0FaVBXX3eUgPOrc1NeDuac1bsKnBb0BbqRnda6BSCuj4hmgoJCZ44G1ZsHJlK
	FZ+q/vO6UHLguv2SeqoMu+bDyWc/4jyrr/Wv2Pff5KuHe4JjRUHmDoYxzTK+inkSXk6n33j1xwX
	JNh5a3Xly75vunsqQY8v8XJLO2/jMtHxskQNMVegAFrG7UPe2Ur+qbKRF81FCl1Cpfy77hH2XQB
	lzjSzXFBQ5/KgN2BPPHfddjUuFt5XEqn6Dx7oB/uA7ezR1pI4MlW0SujBnwF8eZAerr3CGYLf7W
	jVvTOQlcpAg88DOvvE0yq5XGMESn72jXP1XJRTSzaqji4fq61Wv+LgyTaGlUAGwX1M/qxYI1BjQ
	8raHSwHVa4g2uUtYAReKkuI+K0pBct6+vIErZjl0kcGfqLr7zHDmn/MkKVhpMqrdQ9QeJuDXHav
	lhyaMZ7/E1rNBDDZcXCFi+1CEApwElyhpPNec899v+4WFLUT5EI+3s3cfblTES+jwqInxPXDnBc
	U2zH/XjbXXRtek=
X-Received: by 2002:a17:90b:4a50:b0:3a8:bb56:f450 with SMTP id 98e67ed59e1d1-3ab3a9f2760mr1509105a91.41.1791542934370;
        Fri, 09 Oct 2026 03:48:54 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 47/51] selftests/bpf: tests for register base/step state pruning
Date: Fri,  9 Oct 2026 03:48:05 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-47-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
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
 .../selftests/bpf/progs/verifier_bounds_step.c     | 181 +++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
index 3a0d22aa4fb8..c9ee1c7efcbb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -360,4 +360,185 @@ __naked void step_movsx_bounds_on_line(void)
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
+	: __imm(bpf_get_prandom_u32)
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
