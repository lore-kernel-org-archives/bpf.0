Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46663A6407
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809426; cv=none; b=YVcNz9RUpY+TuogoLcXkg3Zq16OzeKjANPb1BmaKULTb9LNXHeNdovC1Hp0p25Jc/0/9ub0aPM3scAryN9/P+HCCeCLHIUDe59Xp3cZxXtcR9ndHacDgAsyWEQOVWjBcINGlXM8XPXTC+kabjrA3+GkXXxcwoWGXPTTmah/hu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809426; c=relaxed/simple;
	bh=IfoM9T1xOdM8W8X1McjYa4aJasEgRFewu8AP1FwNcz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4QvK6yqxCc0TDOsVfZOcelegt8F56PMyEROfHeL0HinL8kpxglxxupzKR2Fp2fnHA5jagQSmnLgbzlGNfqfr0T/v9pXw67Pr7VhlWlk1xxBfoE+P4UHESknAyef5wjButTPuQone70DRPD5NyaPNT5s29s84FktqCNg6VAsqtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlNe7MbX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlNe7MbX"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso3754225a91.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809424; x=1777414224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcVDCQ0r2jAEHOWL1njreNq4j1EL9+ea24V2ROuP5aM=;
        b=FlNe7MbXSbZtvcDCLaGFNFb4cabVFfUY7mVsEEXtbK7WKsLqHylm3/fF0CmGD9a5Vy
         JShWhVm5Aggv+RTqR8xPrxuNfQ5KZOMzCjEPJBH2y3qt7WuFoEZdeXOtsMvhVKiTt/IZ
         8nlxeBb7X1a8m6Su4JBAcQRXI0tV/Ey6jmZcqSXWcl+PtmXkZJL9IujpSI4BU14fPT3s
         p51212ci9osZNTGKaTHpDZA87JhivUcHvOpResMTLa7By2oriaiB1yG2kq/Cuc99Z39S
         zmawnrMXxIphHgKUBT8rtDcXLphJwcV1HnWoFGX4bE4mPxxoieIuniw6everar6Ey+8i
         xLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809424; x=1777414224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AcVDCQ0r2jAEHOWL1njreNq4j1EL9+ea24V2ROuP5aM=;
        b=YNnAKDvNqviOpOxK4fmDjfMYRfuTzsYj4KE607Qj2ei4gyZq6WRYZu9jydGdG7E4s6
         Hp2XNEe1QLc5T9j4KuFhI7LjiKNh2ZFMJPJBzNPmUUzA+YRzhEzKJFiEutsSe7XYKzvr
         PwEOjn21OlWz/RTnX5nnKSBUhCepkgfDL7O9Ajg9gaZhoNcpEaNRgd96j3XpZbH62v2n
         NEHIX+GxlJRwhnZvfoMrCCkHrNeY+j0A4TU3BFWt9KWYK8mUhuvzGaKViUBPbnWIDMPl
         MEub6ExGmXfW0MkMwda42MeToL8RCCZ7iofP4RDKfU4lrXuJgERJXF1B1VLaYBNfBoG4
         6GZg==
X-Gm-Message-State: AOJu0YxktgpnTsuHTXXchqenCLtAfRuIzyO92n7AvpqKfzgegg9N9i8p
	HsO18K6vl9nxHmUZraTQVkJDZ/prK0GgGoWKEBIucbXeNCcJXOv5rAGQ2i3KdQ==
X-Gm-Gg: AeBDiet45296HKFIjIs6gLlePTLFOcwgu23BdrUEVwVWFNBo2sjVoGdUfA8D4o6mZ7K
	Xzp51hmogQvS45xUM5wGroDh05dPIyzwiM/D4kXT/32LRxMo7KvWqAAlPZHaVgVWgSBzgfYMpTi
	prIVjjtYoc2twhliQo1dkc5737pyGGiLZJdKRHWxaJOeXhuJPWmBBB3LDJoYPTNKxo194cUECXR
	Kwqcz9EtVwklDXgDY+H5Xis+ryJ1gMDfRnkVE5mCoyg3qZV5K/ktjPkL+cYgDSbHPoHfGYzqHeS
	lZogkVhLrya3B+4oD1XqXeE+k4gjLMH2ywvQwccpruua4XiDb8f2h4jqUtfGWoCxJwApRCi1xhe
	yvK+vhhWKZc/Ioa+yI/DIchjo3W+sLt4czEWIuE0yJIq8+ZGWBG9jd12OQ7ZVnGt5Xc1QMN5uRN
	jJ4cQv78IGJ7+BgQ4ZzP/xaND5
X-Received: by 2002:a17:90a:e7ca:b0:35d:8fdb:4f36 with SMTP id 98e67ed59e1d1-3614048a21bmr20260535a91.18.1776809423914;
        Tue, 21 Apr 2026 15:10:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm14968773a91.3.2026.04.21.15.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/9] bpf: Remove redundant dynptr arg check for helper
Date: Tue, 21 Apr 2026 15:10:12 -0700
Message-ID: <20260421221016.2967924-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
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
index 908a3af0e7c4..3ab9bc2fe0e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8405,26 +8405,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
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
-		} else if (!reg->ref_obj_id && !bpf_register_is_null(reg)) {
+		if (!arg_type_is_dynptr(arg_type) && !reg->ref_obj_id && !bpf_register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\n",
 				regno);
 			return -EINVAL;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b62773ce5219..b5fbc9b5c484 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -136,7 +136,7 @@ int ringbuf_missing_release_callback(void *ctx)
 
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dynptr */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int ringbuf_release_uninit_dynptr(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -650,7 +650,7 @@ int invalid_offset(void *ctx)
 
 /* Can't release a dynptr twice */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int release_twice(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -677,7 +677,7 @@ static int release_twice_callback_fn(__u32 index, void *data)
  * within a callback function, fails
  */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
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
2.52.0

