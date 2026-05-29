Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEB364925
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019388; cv=none; b=Y6cGmfQvQmIJCQc505LOI4bRhYKtYvUKIO05x1gW/k/rSKJHw8/dkaLPJ7zprJ4Gdr1LbhlvcrWdaGz0iAVy5nqfyUv9mZTd2FyHKBPs0UwffC3+gjBVivIsZgKsMTo+7Yp9xrk+K/5xj5KfdRzM3B5wJDAlT3FYopChSwD3Zkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019388; c=relaxed/simple;
	bh=vNX0q94QJ5cQoHE6fikuIVXjqQmntQt191a0ixMZde0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7lPD4LFmdP1TniELkosVRpz35p8mAiZhpiq87txDn1lyAzWf4o2omxRcc7kSkPPxHzp0vnW4ifbNUp4Ug8Pcv8gxJplvTxj6Sj1J3td/Yj17jyozgQNbq5qyIr2XLEsvuPjg0kdmq8/XQHi/4Q19JRck1gl+J75b5Zj0Wf5wng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7DI2Evo; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7DI2Evo"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8572350022so184988a12.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019386; x=1780624186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YwDcqRVN8dmz1Un30/apqJWiI4e1R7/M4peDTSJvVc=;
        b=o7DI2Evo4hTIUfAYzOb9j9/LGGubGqyqEDcWdb17XKLkxcE7vZrQgoAWB9CF5Ixjk7
         c1o5zwK0s5z2e9n4UpbYcnTFf7AiaNwZQw59kFaLrX/MbwFR0gnNIuD2jVTOUr1CHUOy
         1GKhNRIreXgarVtdViLlvvunwOz4gGO/+Fj2KujAKOeCpuXQlNKJ8iilJ3F9uTvDNeu/
         cTMNL2UNS0EEVo+c0bRARvqQ66fkfm2bp1eqnKbJoJwwu6zZioNBStfT7Fz8KpvVaA10
         qtOSvEhxIqdpa9paXukiYfzKDgND2bJgI7f/c4T/SaQ4g7Oth6xX5EnUBCJGthK4HtaN
         2naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019386; x=1780624186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5YwDcqRVN8dmz1Un30/apqJWiI4e1R7/M4peDTSJvVc=;
        b=aH7dTzrCtB4K6dqy2Y8vL0IxVbVo78r24wrX1Cdvofy2MfgBTGUbqArYbxX+AxBB2P
         irbilHT+t75lJwMLzRuv5bRkgijZFb4+rvQWHNI4/bYshODf5Do6H52QTEGb29sLyQ6E
         WiLuddNSUpOBOekgaWy7q8KwEdM/x3BKEvflrPzi1hf/TcXlEE83d2sxkcCjWinYAXwZ
         2PdKA0UJjw9+pXnQurm7y1JRHf+ounjD1MnHw2zQRDIrckA+oAdaeAjwTa964ZkmJkc8
         48On6FQTxcAedmW2dHmMFRb0vvhI7wG+WX0JHBmklK7CM5FljiOTJFhPErbet2GMst0Q
         MjRw==
X-Gm-Message-State: AOJu0YwbdFPZm4R9XD5JpOi/2t9R/XOgddrDVYlmBNwJtaoDsv9Cwtux
	08AXpoJRsdiXSzK7ikJHU24+2uVTHqkUrXNcYIoNaiL6z/LcaayhZD7JAReyOQ==
X-Gm-Gg: Acq92OHUOok3tJpxyODt8ZQBdgReiF9GGFfgGRcqQB8Lu8jiow9FqGdR8xmyzA31r4y
	/tuh9U6j8t5DNx5NZ8mYZ7duAwrRwfISI4Y8ei0WXTCZ67tZ0T+2R4xcZD438WbcpHTyrwcbnKk
	APAm9KYYMfevdGW6H66qLPZg2+ryFaRbKkb19wVVHnGnuUhlUaYxQqOO3HFiC0At9Pino2eao5G
	5bTwlRxIwxEO3hs6hV98oqzpVkC7JSCNmlOJ0h0q6Y7v8ZRAgSK85av/Pz7fXMJz1XsXZ09QiYN
	klSxIaip1qcNdIx/aG8eA8CDI7CHk4di0DyVXPbJCUWsv99iBxYNf7I/yRV3g2ljfOtgbXYmTnO
	qIfRIsLZSaxTUS/pgzgo9BGcVRIdzdwEgtUoOFdaSMWWfjv1GL2FI1Vdx7obfpvDA3nta94eVoD
	L/hmeexTvUSD7nwnUdl1t3VWM=
X-Received: by 2002:a05:6a21:9d45:b0:35d:5d40:6d79 with SMTP id adf61e73a8af0-3b41205b148mr792846637.12.1780019386260;
        Thu, 28 May 2026 18:49:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214c931a3sm81975b3a.37.2026.05.28.18.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:45 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 06/13] bpf: Remove redundant dynptr arg check for helper
Date: Thu, 28 May 2026 18:49:29 -0700
Message-ID: <20260529014936.2811085-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unmark_stack_slots_dynptr() already makes sure that CONST_PTR_TO_DYNPTR
cannot be released. process_dynptr_func() also prevents passing
uninitialized dynptr to helpers expecting initialized dynptr. Now that
unmark_stack_slots_dynptr() also reports error returned from
release_reference(), there should be no reason to keep these redundant
checks.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 21 +------------------
 .../testing/selftests/bpf/progs/dynptr_fail.c |  6 +++---
 .../selftests/bpf/progs/user_ringbuf_fail.c   |  4 ++--
 3 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 062fdd6b7b59..3db0f1db475a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8214,26 +8214,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 skip_type_check:
 	if (arg_type_is_release(arg_type)) {
-		if (arg_type_is_dynptr(arg_type)) {
-			struct bpf_func_state *state = bpf_func(env, reg);
-			int spi;
-
-			/* Only dynptr created on stack can be released, thus
-			 * the get_spi and stack state checks for spilled_ptr
-			 * should only be done before process_dynptr_func for
-			 * PTR_TO_STACK.
-			 */
-			if (reg->type == PTR_TO_STACK) {
-				spi = dynptr_get_spi(env, reg);
-				if (spi < 0 || !state->stack[spi].spilled_ptr.id) {
-					verbose(env, "arg %d is an unacquired reference\n", regno);
-					return -EINVAL;
-				}
-			} else {
-				verbose(env, "cannot release unowned const bpf_dynptr\n");
-				return -EINVAL;
-			}
-		} else if (!reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
+		if (!arg_type_is_dynptr(arg_type) && !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\n",
 				regno);
 			return -EINVAL;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index fa0beeaad1be..40a14a5174a5 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -136,7 +136,7 @@ int ringbuf_missing_release_callback(void *ctx)
 
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dynptr */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as R1")
 int ringbuf_release_uninit_dynptr(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -650,7 +650,7 @@ int invalid_offset(void *ctx)
 
 /* Can't release a dynptr twice */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as R1")
 int release_twice(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -677,7 +677,7 @@ static int release_twice_callback_fn(__u32 index, void *data)
  * within a callback function, fails
  */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as R1")
 int release_twice_callback(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 54de0389f878..c0d0422b8030 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -146,7 +146,7 @@ try_discard_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("CONST_PTR_TO_DYNPTR cannot be released")
 int user_ringbuf_callback_discard_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_discard_dynptr, NULL, 0);
@@ -166,7 +166,7 @@ try_submit_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("CONST_PTR_TO_DYNPTR cannot be released")
 int user_ringbuf_callback_submit_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
-- 
2.53.0-Meta

