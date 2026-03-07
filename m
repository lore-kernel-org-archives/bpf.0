Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720237E2F7
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865890; cv=none; b=PfG5T55h4bpUIvPgzrBdem+0woZI4inPbXXToRFPpxhvi4c8jWQa55MlXarrIRvUdSsxE9TXdMfzdJNjSWJTRa1ejXeZfZO0SA5ecdyH+HByp09GbzAK5T59CJYy25oKet+CXkIWSKiB2/z+VKTh+f5GhDQtdO69BjpotpIwFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865890; c=relaxed/simple;
	bh=220J2NF5yCyk7tRF95PoeS+Bz3Vq8x488ZxOVCO6gxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bph7NFaVPTchEDvpyRdrUKsvUonZZyiCR4WOxnSIacZf3WycGlc19gdWOipEVY92u/pyVHXFBEQuibQT8KuwpPrZlUTGdMJCeB0j6c13gklpkVAhaRMyyEflnAZZaHHv8ZTIxLM7lww3ylWDOw8cTQxUgDXNm2bz5Rl/g6Gg9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1Qv9R1f; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1Qv9R1f"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829865a8471so2697399b3a.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 22:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865888; x=1773470688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etdBLDx36dMtVbyrSAhU63rVIi5uq5aFdbc/ugTsJBw=;
        b=K1Qv9R1fN1e+kaWl38fkUKUgv9e9uS7dCpWSR1Ur4bpDneOKZzgqhLmJtCcIoXg9wL
         Q2leoUWiAeHWoNTnuuq6ebnKMGYcjpE7kTIaXr8DEnmhB9CvvUmRYsK7D7Lgf6uTP/LO
         2zv0JXIsYukWYnhwl/pz9rCIBmtHLn0kvAfDTCbhb33efEJ1oMAnWz4kl89ViZxP7v2v
         EqOfNICGGdPP0ehFIXQMYGGvz5ZgsiygaUtYTfCCs5DMtM4KiU6ikXApcZrGO/G2rjXy
         M21q3n01ca3SjC+OGES61RrnOh6Q28MFlXqeuwqMb0ooxdJNCrwP9jincr7Lnvt0odOK
         MRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865888; x=1773470688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etdBLDx36dMtVbyrSAhU63rVIi5uq5aFdbc/ugTsJBw=;
        b=peYjP9GjIrX96JcfgnMC/AqLbN8AJNthHlZ6w0SqwRMmwc/F+2rHx9NtJQn8Epmx3o
         UEAd3Q8et0Lm0lmuA1OCj5QOeNnojB1tHSjmKNJwyDq/x1eadx49c1i5NE1ct/etmuqv
         Q9Aeq7r1/yaYBEzTiFXRRlIb+xlL28F+jvnU4AkDNm1rbhCe5GTTM6Ie057vHF+RgMR5
         Mw2J6jX3kM6tEZaTb9stgIsDA7CCJUOwh3ZKXdYFqIqn0tPps78bGK4/+DQrbPz2Zt9M
         nFi7KgHYLK9PJTFNsz6jT7ZBEcAcld249oHD+83wYyVzAAeKpFalqfY4XjV5U2H4Np5I
         OecQ==
X-Gm-Message-State: AOJu0Yx6bwQvk5MCGAK2m2qfuerwVyPeAuPEQTduYlMJI4o59SAVXxn2
	ybnC/JMTBYbT+SmK7y+mBGPEbUgN7YOJ4LR8CEW6rpxgY/j1nFr8DNJz/HgBaw==
X-Gm-Gg: ATEYQzzsYdYGoLhA/3xyI5rxBo+NAiSozatuy1xMGOWvySNuTohe95irzDunvDpO4Qy
	QV8vIpglf3B/m4pyifzxqtM4Xo09h98qChpUREk2Z6+stbOLPoYxLvxRxDXSDKg4WtIvlOUVZ0s
	fmAj+rpWd66rLlEFQxvPRJryWLv7zD5xlzZKdfTg04nBaS1vk2AHzYTWSqr/GCImyk88fIf9MKK
	YV52TU4Hr7fl1bWzZ92XIWO/YxSt50RLWhUPjcUt/8DxwhofyjP5lbj5fOzoTgYSTjcaXnJdAig
	DKWLBF1oTGuKyzQZBPFoNVyJra1nLtp0GM65gm4EFl7sEzGG1IIgQEeP/bqsK4b9jJRQThN9AEo
	oukW3+A3lpfOtdTEghSxAtFqvaAGv7vrHGWk2ivPN63WFFpTpZRiNweIls6F3ZCqqklceSWlRLw
	j8VBNzkVET+iYD
X-Received: by 2002:a05:6a00:1c87:b0:81e:d7c3:2f3a with SMTP id d2e1a72fcca58-829a2f5a754mr4012267b3a.46.1772865888530;
        Fri, 06 Mar 2026 22:44:48 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4676187sm4391941b3a.27.2026.03.06.22.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:48 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 07/11] bpf: Remove redundant dynptr arg check for helper
Date: Fri,  6 Mar 2026 22:44:35 -0800
Message-ID: <20260307064439.3247440-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
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
unmark_stack_slots_dynptr() also error returned from
release_reference(), there should be no reason to keep these redundant
checks.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 21 +------------------
 .../testing/selftests/bpf/progs/dynptr_fail.c |  6 +++---
 .../selftests/bpf/progs/user_ringbuf_fail.c   |  4 ++--
 3 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0436fc4d9107..80b9ef6f329f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9737,26 +9737,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 skip_type_check:
 	if (arg_type_is_release(arg_type)) {
-		if (arg_type_is_dynptr(arg_type)) {
-			struct bpf_func_state *state = func(env, reg);
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
-		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
+		if (!arg_type_is_dynptr(arg_type) && !reg->ref_obj_id && !register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\n",
 				regno);
 			return -EINVAL;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 5e1b1cf4ea8e..631e37500ec6 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -135,7 +135,7 @@ int ringbuf_missing_release_callback(void *ctx)
 
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dynptr */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int ringbuf_release_uninit_dynptr(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -649,7 +649,7 @@ int invalid_offset(void *ctx)
 
 /* Can't release a dynptr twice */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int release_twice(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -676,7 +676,7 @@ static int release_twice_callback_fn(__u32 index, void *data)
  * within a callback function, fails
  */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int release_twice_callback(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 54de0389f878..e8f4ae86470f 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -146,7 +146,7 @@ try_discard_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("cannot pass pointer to const bpf_dynptr, the helper mutates it")
 int user_ringbuf_callback_discard_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_discard_dynptr, NULL, 0);
@@ -166,7 +166,7 @@ try_submit_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("cannot pass pointer to const bpf_dynptr, the helper mutates it")
 int user_ringbuf_callback_submit_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
-- 
2.47.3

