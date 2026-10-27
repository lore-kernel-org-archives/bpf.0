Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127896;
	b=bp4IxEHw3l1hH/q2/KPySx3itm2g3OBzw3hvuwT0qmMx7ex/2MRLGgQNllC2QP/kLhVp
	 4VgzXdtd91nk95lclVfm9JFew/wJvxd6RnAdfiKxicLaIFvah2D24KyEgTXBwad8kIULJ
	 BPOZTbfvFqRFk6G5EArKbKMQwjT3KQR1zd1+kR2JBElf1KEncnGYO67JLoAY4aXW8rQ+V
	 Eq0OEH17MaC2/PIW4FXEo3qgPrGg9xMi2rK2h6YhHxH6LZDRVcNHTrIGomAI5IP1I0wlC
	 O5vUxRuz4Vu1Hr8fCUNxlJGGJf43tpG2rJ/po2R5TbN5nb9/7eP0ARpWbufFUcq+fBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BM6tzQea2YBqwhrJyrTTQZXg/XWmrherRmScyCCvZ3A=;
	b=ceMzKjnDY8fZYWW259YJszzO9TozCY2Y4oyrvq/o2aoGFbwiFyN5b8VhrJTtgakw6LzV
	 JimLR0/xLIOUjwXy1Z9z+NjYI8/T00RRJfS+V4iqtzM8l+Lhl5UpZrNHupqTidmuegazU
	 h/Sbpje7PnPDEqpH07jqJyAfNdhrqg/Qo8zLKX0loUbA0VLOjURhqDXi4VlsTZjWFuBPZ
	 f6nBs19rpIejnDeLHhoth609lDmU9lIkAfPjgK5XLg5qtVfwe1dg1zaTPyS+OxkL3I69W
	 6iDgb8bfty5jdlL4okWVSWzHJS5FGO54c+sMabAkcPT1Xk6ZtRY5bLaQM0oDx/LrSHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aVe8/h4I";
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF4606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ABF4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aVe8/h4I
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06c60065fso226257b3a.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127896; x=1793732696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BM6tzQea2YBqwhrJyrTTQZXg/XWmrherRmScyCCvZ3A=;
        b=aVe8/h4IqCfjGuR4PwZ0XjIAxHzjqusEbY7kdBn3U43D88pZ2UvJtToCpFNh1onUPq
         gOd8+smPsteJdQlK7cMA/545ObYQ1fAMxQS0E6I6LD4lPJFzZhL9YKxivwEBTIMLBi7G
         GYFOSZHkZTZ8DjVHmICVZdzlK7gVQKeW+n83GMJJzy6lLcUoyAbD4TUa77PKmfuMF6IH
         tWdUbxWkjlwkPbydM0aEBzJKnfNAcZgemQiEbPzVk4MnIJdfqaJq5sEefPtER9XjD6qI
         gCosqa3Z2mo5H0Pe/8ttro58Gm6Y8N1fkqOKyrb1Z/nNLRkzvSHRxYA6YvCh9AKSK2Gt
         z7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127896; x=1793732696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BM6tzQea2YBqwhrJyrTTQZXg/XWmrherRmScyCCvZ3A=;
        b=lJLsZGIqOuZHajabk8XK9xsXasRT/I6370D3ZTB70YG8T83PfkVStPzkQ4no2sxALZ
         JoQW5B/PpOoR4PnY36ftzqcAoWmJu498XhgOc3tPaOh4h7UQvbFbnvhDWtz8By9ZPD+O
         HOdiEzhUkcXoqlLjaH+cdrmjKxbGBbQkbXIB/uv8mFjKasSlLQTsEGI/wjFCSMi2GJHE
         TrnwS/ipa4ENVYPstNabh/MSzueJvnmaayLm7Sza8RHWwMAsR5Ji9cXQ55zGPgqTsiSM
         403wSKnGb0nkzrGFQuCP/lfPsS5Hj32RP09HCkEdiXKqLEFNWuTfZTdwCvPGs9fMmJyf
         gBFg==
X-Gm-Message-State: AFq9FYJ5G0eWIZ4qrrzI5OJHXZql7MUCv/wvet/VFWkfHx8jm0HJgW7x
	TudOrlJXQ8IgQpsevDMdapPPotdZURiys5/pOKU3BKrR8bu9GqTYmyAcnQHQgQ==
X-Gm-Gg: AYBFou3t6xD+w6s6tez7aD3RAVsAZlOlYV8bjW9gNIzVPSIftCFhmbV6Eyh6+wqWNk3
	/MJu8OrGT7u1A6/RXRLTdkuKuK22APdl13+tLJp8f8ihC+1Qk3VpdEn6FEAaiwH0to2jpwbuCJR
	RaSIFYznLGcZ3pzsqVbL5sNH9eODZC89DQhJjzoxOQTmTMpedFFRUv/aidRXZVbBiF4L7MGA2ry
	uiom9ISfVVPleBcPN0jV+XwZpJSE/YzFvDw3CsZLeDWnBo09oSJH9LEKUq82SukYzbWzTM9axvn
	12kZyHfNi0Ih0UzvuZdDqxULIjbBjve2PEu8wd3REU7VDuaRU6sFPcvc+MW6k6b6x+OcpGxOp+1
	0EkLe+zWj7cBopej9K/1iymGRfn7pqkcYp3z5ZGC8PJvsjUYZb4hquQukCgD6LAGGDpbK72V0nR
	DuY/8kQWKm6qPLVOaVjcl2JS9gsBGmpAoec66TFANb87CSOdBbePopZ6Z0Bgdhbj8bS1qT+jneD
	DCWXfD+np6J1DYv23nePKsFv9Exuh9RSysZlMpu8qM3fVl+ENWjf/NVOHHiB1hkeXFOQzGMjOqh
	Xgbuuh3Me8qXvB0KANo09l6V774h3tbLKU6mt8zVjVJiYBOSR4VHqKCZ0mJh8pqlto5gFT4c4+v
	hIiIS2CHPSsYmRqnwLhPwEZoG
X-Received: by 2002:a05:6a00:2e88:b0:8a0:7140:7fbb with SMTP id d2e1a72fcca58-8a6e80bb031mr120957b3a.51.1793127895766;
        Tue, 27 Oct 2026 12:04:55 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a3d5bdafsm408252b3a.6.2026.10.27.12.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:04:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 17/19] selftests/bpf: Test maybe_fork_scalars() at the head of a counted loop
Date: Tue, 27 Oct 2026 19:03:12 +0000
Message-ID: <20261027190314.1440199-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The insn that forks is the head of a loop that scalar evolution counted.
The state with 0 that maybe_fork_scalars() splits off is within the state
that is kept at the head. The access is out of bounds only in the state
with 0.

Without the previous patch the verifier accepts the prog.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index df8d5309657e..05efa9f4a522 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2159,6 +2159,47 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+/*
+ * The insn that forks is the head of a loop that scalar evolution counted. The state with
+ * [-1, 0] is kept there, and the state with 0 that is split off is within it.
+ */
+SEC("socket")
+__description("maybe_fork_scalars: AND at the head of a counted loop rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and_scalar_fork_at_long_loop_head_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r7 = 0;						\
+	r6 = -1;					\
+l1_%=:	r6 &= 8;					\
+	/* r6 is 8 (current) or 0 (pushed) */		\
+	r6 ^= 8;					\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r1 = r9;					\
+	r1 += r6;					\
+	r0 = *(u8*)(r1 + 0);				\
+	r1 = *(u64*)(r9 + 0);				\
+	r6 = -1;					\
+	if r1 == 0 goto l2_%=;				\
+	r6 = 0;						\
+l2_%=:	r7 += 1;					\
+	if r7 < 100 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 /*
  * Last jump can be detected as always taken because the intersection of R5 and
  * R7 32bit tnums produces a constant that isn't within R7's s32 bounds.
-- 
2.55.0

