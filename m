Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE353AE18A
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289087; cv=none; b=FYtdfhw/s6argHEGZoRQiO0tPm3WjYPKxFLfJmnHGE3A9mw8RPYddobFbI5zMe+Wbt2KqFkc7EgnIpp6PzQYJLlKlu+s9ghQwIas1OyXiOpJ7TNcES9Dy30ifr2Pl72y7NiL/xUHRbUQi/XcAswFxgh/dy1Fl5agc7pBiQVkXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289087; c=relaxed/simple;
	bh=9gM/4xByliyVbQh64JtmQqQbQNSZGElI9YMilfgv3Lo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t6O43hPND5bsPkNjN42LBRP/keVaQ0l8j+OaS0NP5a5iVOoYmN1v/wCldt6WBwDkYN4+3cvIAOhtIzN8sOq7vyK+Up1RxF65loMYk57wIvsXC/84Dn1uSX8cvXlR6FSBY6z6JPBiaFfbnpGk9OGJCmt3KofK0+oe4NFnRyg7xO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+pmIL5b; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+pmIL5b"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486b96760easo4161875e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774289084; x=1774893884; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1t4cs6EWMGxQQQI5ee9Fd+bm+fyswG2Iln+MofycWU=;
        b=N+pmIL5bNYwcjtvfMp8151nTKnYgRF0Wxihud7Ea26hdTWs/rcTCnQ8Y5Hvy28pX+7
         iguZM0yGIuLH5/HVuPDf1XKYztxNGGamIt7/AuFRPN8NgyFH596dsSZXFrVtoA+nD3PE
         6nVX5aLG14KjSiT+4axBd/zS5aYfFjm+lerwKrvFfcKBVn7+aOtAcHQM7MkM0iMi0clX
         3TUSCn5eOtU1lLy2yGLwxgQdOY8O+NW6mfnZtJzvTeLw2mRLpxx3iysYM1hnSDIRwrN7
         xLClSIIsxPkhVEFyPitdoBu7KS69hjSrcTf+3Q3mP/QJldimkv6cMOld3qgieEtdEuUo
         rHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774289084; x=1774893884;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1t4cs6EWMGxQQQI5ee9Fd+bm+fyswG2Iln+MofycWU=;
        b=oSKhQq40joNvbOsuSKA8WhGwRsrt7VRSd+tSxMwuAjOK+8Ihk6U7g16gnt/6IHOJfk
         mVx9NKfLMxwrv5QVxwTL4FXFWnqu/uOxjP+MExQM6cjURkKPZRCIYJqdcqO3cyj/8DVU
         rvbc3cJVcMpKazHsCpFW8Ydtl8lxkayJWzN3LWYCa5IvTDphI4rhRpnuXFBfONeBJyFp
         6a92bNoDC4t43rUt0e16NDJ3r6rXHf21mVbKN3PxLTH5tS2MqvhVNfn11VWHmGzhom9F
         OmnWmdfrDPYQrftDj7X+NAouWSFLQJ34U7vSTzpNckghwJf97D8jJKjbJ2fktRKFNCpj
         2XGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtxbBspRApFARUDKapDCGlqDwkN6yk7R0cQgVjwxy99T+FHJTEIROS68uubHP+oKSiFFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRglfYz7UoGdortQNcXvR7Ht1QDgrHbX1ARXDZAiLxc+qALDI
	qEpqWwpekQlCvwOJbJFOwO5MUxTBtxnvxZpW2k9TKGxSESGmrjvrqgKNJ3FX5i43
X-Gm-Gg: ATEYQzw7mIV8HG8Ev52wRCf8UHQxi0Gs1R+FNGDlUWwIGFGsL4/j/z9gUedhWJUdj1A
	ir0SxgxgV7CW14LDBkytzAFAHfNgA0A6yWop9Va5bZIxQQlwFpCnTII77/CpZdZDRt5vvxMTnDt
	dK16/aaYh1uSM+7Fy9uKnA0TPiWuKJ2NWwHCzZGKLyHnIe+j6jp4E3nXVg5VFRXz47V/E0h3hys
	Soqc7UmBTVEM3bEdrHgOtEswMR3wJ+WcpAnoPoEeWsN1r7UCiwr7Wnyeu0ANlUoupaNK7NCZ6cT
	Xp6S/Dhql728QbhajJCI5ofVTaw2osHPBE0dwW9FE8wii6bGoLcT8Yqk8pLuxvcAObGKwiVTgBu
	3DNAKce+xrrlzhUoESZZYxg6AojwBW1xEAEsqTc6zV0KrKMGm25cTQhLztwoldnCq02mIQFpz8r
	9We7YOSr36RtpLygE=
X-Received: by 2002:a05:600c:37cc:b0:487:36c:f5ab with SMTP id 5b1f17b1804b1-487036cf67fmr133369765e9.10.1774289084106;
        Mon, 23 Mar 2026 11:04:44 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:a228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d923fsm480264265e9.1.2026.03.23.11.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:04:43 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 6/6] selftests/bpf: Remove invariant
 violation flags
In-Reply-To: <e6da1ecc47f206f9fb6dabcf735b34382dffd885.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <e6da1ecc47f206f9fb6dabcf735b34382dffd885.1774025082.git.paul.chaignon@gmail.com>
Date: Mon, 23 Mar 2026 18:04:42 +0000
Message-ID: <87fr5qjubp.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Chaignon <paul.chaignon@gmail.com> writes:

> With the changes to the verifier in previous commits, we're not
> expecting any invariant violations anymore. We should therefore always
> enable BPF_F_TEST_REG_INVARIANTS to fail on invariant violations. Turns
> out that's already the case and we've been explicitly setting this flag
> in selftests when it wasn't necessary. This commit removes those flags
> from selftests, which should hopefully make clearer that it's always
> enabled.
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
BPF_F_TEST_REG_INVARIANTS is included in testing_prog_flags() from
testing_helpers.c which is used for loading verifier test programs, the
change looks good.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>  .../selftests/bpf/progs/verifier_bounds.c     | 24 ++++++-------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index 818efa08404d..1ebc99d75862 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1066,7 +1066,6 @@ l0_%=:	r0 = 0;						\
>  SEC("xdp")
>  __description("bound check with JMP_JSLT for crossing 64-bit signed boundary")
>  __success __retval(0)
> -__flag(BPF_F_TEST_REG_INVARIANTS)
>  __naked void crossing_64_bit_signed_boundary_2(void)
>  {
>  	asm volatile ("					\
> @@ -1148,7 +1147,6 @@ l0_%=:	r0 = 0;						\
>  SEC("xdp")
>  __description("bound check with JMP32_JSLT for crossing 32-bit signed boundary")
>  __success __retval(0)
> -__flag(BPF_F_TEST_REG_INVARIANTS)
>  __naked void crossing_32_bit_signed_boundary_2(void)
>  {
>  	asm volatile ("					\
> @@ -1536,7 +1534,7 @@ __naked void sub32_partial_overflow(void)
>  SEC("socket")
>  __description("dead branch on jset, does not result in invariants violation error")
>  __success __log_level(2)
> -__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
> +__retval(0)
>  __naked void jset_range_analysis(void)
>  {
>  	asm volatile ("			\
> @@ -1572,7 +1570,7 @@ l0_%=:	r0 = 0;				\
>   */
>  SEC("socket")
>  __description("bounds deduction cross sign boundary, negative overlap")
> -__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
> +__success __log_level(2)
>  __msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=smin32=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,umin32=0xfffffd71,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
>  __retval(0)
>  __naked void bounds_deduct_negative_overlap(void)
> @@ -1616,7 +1614,7 @@ l0_%=:	r0 = 0;				\
>   */
>  SEC("socket")
>  __description("bounds deduction cross sign boundary, positive overlap")
> -__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
> +__success __log_level(2)
>  __msg("3: (2d) if r0 > r1 {{.*}} R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
>  __retval(0)
>  __naked void bounds_deduct_positive_overlap(void)
> @@ -1649,7 +1647,7 @@ l0_%=:	r0 = 0;				\
>   */
>  SEC("socket")
>  __description("bounds deduction cross sign boundary, two overlaps")
> -__failure __flag(BPF_F_TEST_REG_INVARIANTS)
> +__failure
>  __msg("3: (2d) if r0 > r1 {{.*}} R0=scalar(smin=smin32=-128,smax=smax32=127,umax=0xffffffffffffff80)")
>  __msg("frame pointer is read only")
>  __naked void bounds_deduct_two_overlaps(void)
> @@ -1713,7 +1711,7 @@ SEC("socket")
>  __description("conditional jump on same register, branch taken")
>  __not_msg("20: (b7) r0 = 1 {{.*}} R0=1")
>  __success __log_level(2)
> -__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
> +__retval(0)
>  __naked void condition_jump_on_same_register(void *ctx)
>  {
>  	asm volatile("			\
> @@ -1748,7 +1746,7 @@ SEC("socket")
>  __description("jset on same register, constant value branch taken")
>  __not_msg("7: (b7) r0 = 1 {{.*}} R0=1")
>  __success __log_level(2)
> -__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
> +__retval(0)
>  __naked void jset_on_same_register_1(void *ctx)
>  {
>  	asm volatile("			\
> @@ -1770,7 +1768,7 @@ SEC("socket")
>  __description("jset on same register, scalar value branch taken")
>  __not_msg("12: (b7) r0 = 1 {{.*}} R0=1")
>  __success __log_level(2)
> -__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
> +__retval(0)
>  __naked void jset_on_same_register_2(void *ctx)
>  {
>  	asm volatile("			\
> @@ -1800,7 +1798,6 @@ __description("jset on same register, scalar value unknown branch 1")
>  __msg("3: (b7) r0 = 0 {{.*}} R0=0")
>  __msg("5: (b7) r0 = 1 {{.*}} R0=1")
>  __success __log_level(2)
> -__flag(BPF_F_TEST_REG_INVARIANTS)
>  __naked void jset_on_same_register_3(void *ctx)
>  {
>  	asm volatile("			\
> @@ -1822,7 +1819,6 @@ __description("jset on same register, scalar value unknown branch 2")
>  __msg("4: (b7) r0 = 0 {{.*}} R0=0")
>  __msg("6: (b7) r0 = 1 {{.*}} R0=1")
>  __success __log_level(2)
> -__flag(BPF_F_TEST_REG_INVARIANTS)
>  __naked void jset_on_same_register_4(void *ctx)
>  {
>  	asm volatile("			\
> @@ -1845,7 +1841,6 @@ __description("jset on same register, scalar value unknown branch 3")
>  __msg("4: (b7) r0 = 0 {{.*}} R0=0")
>  __msg("6: (b7) r0 = 1 {{.*}} R0=1")
>  __success __log_level(2)
> -__flag(BPF_F_TEST_REG_INVARIANTS)
>  __naked void jset_on_same_register_5(void *ctx)
>  {
>  	asm volatile("			\
> @@ -1877,7 +1872,6 @@ SEC("socket")
>  __description("bounds refinement with single-value tnum on umax")
>  __msg("3: (15) if r0 == 0xe0 {{.*}} R0=240")
>  __success __log_level(2)
> -__flag(BPF_F_TEST_REG_INVARIANTS)
>  __naked void bounds_refinement_tnum_umax(void *ctx)
>  {
>  	asm volatile("			\
> @@ -1907,7 +1901,6 @@ SEC("socket")
>  __description("bounds refinement with single-value tnum on umin")
>  __msg("3: (15) if r0 == 0xf0 {{.*}} R0=224")
>  __success __log_level(2)
> -__flag(BPF_F_TEST_REG_INVARIANTS)
>  __naked void bounds_refinement_tnum_umin(void *ctx)
>  {
>  	asm volatile("			\
> @@ -2002,7 +1995,6 @@ __naked void bounds_refinement_multiple_overlaps(void *ctx)
>  
>  SEC("socket")
>  __success
> -__flag(BPF_F_TEST_REG_INVARIANTS)
>  __naked void signed_unsigned_intersection32_case1(void *ctx)
>  {
>  	asm volatile("									\
> @@ -2020,7 +2012,6 @@ __naked void signed_unsigned_intersection32_case1(void *ctx)
>  
>  SEC("socket")
>  __success
> -__flag(BPF_F_TEST_REG_INVARIANTS)
>  __naked void signed_unsigned_intersection32_case2(void *ctx)
>  {
>  	asm volatile("									\
> @@ -2076,7 +2067,6 @@ __naked void refinement_32bounds_not_overwriting_64bounds(void *ctx)
>  SEC("socket")
>  __description("dead branch: tnums give impossible constant if equal")
>  __success
> -__flag(BPF_F_TEST_REG_INVARIANTS)
>  __naked void tnums_equal_impossible_constant(void *ctx)
>  {
>  	asm volatile("										\
> -- 
> 2.43.0
