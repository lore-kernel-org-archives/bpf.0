Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC15744838E
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455789; cv=pass; b=Q1F5kLyzMmp4y6HIXAWLvgSyTEYZPtbq6gOCrPha4XwkO/K/beohvjabupvVZeB2cIanTFyTZ92/xKC6geoNU12cgDhaKFLwQkekpLmm5j8W0/zzjf8BZRFvwco46oc9RhDN9E+EKZCL5PCnx9lCKGuxQZFpz4iFeT9AGaUpUbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455789; c=relaxed/simple;
	bh=PVTZ/TFE9QwumvU0KdJW1nZ+tvoaChxUCiOMsIl6G8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhZhJR0lx5bCruPUwPmiRmRTqOMhqxnDNBmvoFeYBC/MzZgMnLxlwlPfAsUjEeu2scRqZjAMD1/2IbqaCr5rHcJTrCjRpYLsJynO42jP6SsfQePB0eisxqL3zK3E4lfrZjy2HIARWU6vphQ6FVIHk1JjkFXDbst9/KusuVxV1FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=algyEcig; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="algyEcig"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-87f4e914a45so40455007b3.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 00:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789455785; cv=none;
        d=google.com; s=arc-20260327;
        b=F07QnL1rZ/f2N9DgqAp/xSm8yUdlwmnMqDJlcjReCkBmtY17ecLCe/Cng5K0YGUfgM
         kWOlwX+NZrc241F+Fxt8ccI9DpPUOju2Cq5elbtnf72IOUEVsJT0riQbYK2Pfyznn1TG
         Sqd9bCTFlVQJJxsU01uC6ISW44Z3fBYM+5U8z0WCUN13IScXqjR4gykMScOJlju1jxeu
         EIJlmqXZg5luHjApzK2lT4K4tLQhBWJZneB7ZT4+17tmeT15EIDkw1rsXBKTHI0WMqFe
         MEY3NOp73mIsn1CIBk5bZVXMJTwYyX+tGGBjUnSQPbLD7AgC1A1cD+6tMzU0jBEI1bVg
         F+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LVe8Yd9SG/LifcamCpGGd2R919+N9Zq6nELxRSQcl6g=;
        fh=C04JRxmZvwYu9XacjSeq34vlH3FZnhtgX1KvBV2i/kI=;
        b=lW+DV2LQbTOH7/4aWt/z0vKI3zNMv3jcPaCO+orrPNrefpjRtYWPmP9eLuAFKvyxyR
         emKN6mJxA2eAJLJhu9KbYmEn//Xb5z73X2x2InEhZPYT9D2ehE72tjAHJfbWegyGtMoJ
         w17naWHdPg/FRc4wzMdvJgUTAp43ArhWWOnEQR7dz6A55Q33aTT0xrh9mTfyn6jsD74p
         tPK/xtZC3Aj+WolZ3PuLDkjhXjN5QjLAD74ydq1SvHERhzHmUYMIxtKbqhKfnhU1m0dK
         OTOYFlXhJ3p6urmAHn5YDuk9TFYpZWYcqyW/nO8X3nhBQJd50hc/di4O45aA/06bmmK7
         Vocg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789455785; x=1790060585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LVe8Yd9SG/LifcamCpGGd2R919+N9Zq6nELxRSQcl6g=;
        b=algyEcigfLae0x8dBQvguAcD/e2XUXIiPo/7C6un1+atzRXNDDVCdwEWSL0wjAsTKJ
         loG2jX1/mU1eZUNR0bbqBJcAFjTqCMsfaDISKIGj3NDY8PJjcwD83AFuZAgM4MnAbOOK
         JuBzbiW+rVogwonyr6C4Ix4nTxWhVbLPj1Ur2Ngp+QruiO8uEGgvEaVxkSocbiGX6blK
         KKva9/purFpKl4pFRfnBcvFvo4HrVD2BH/ikMmm9+0J12veghM9i7/lfwpDefj7NMRTe
         fC9kk4np3GENgeN6jkPV/t6pxySdM0VWpTkxzUDgoPMJEHZSsSuV6U3WsGsFKV2NBPJe
         n5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789455785; x=1790060585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVe8Yd9SG/LifcamCpGGd2R919+N9Zq6nELxRSQcl6g=;
        b=t6Ex1rNrPG0fZI7tp9utQ7uvnMziM7RZrBCAW5H+i8XE26/Pmx5gCRQWCqML1WBwOq
         XoRWBCvpa09NR/jlBfhcdI8BE69WyxVHuLdyZOO6pj7swesHyh8ls2FZp4veukJ8GEI0
         cYqWCfHdQqWqp0daxhUWyUfMQEg1fXv+Qwo1FX+myWQ3IW2KTY7Fd9kDmA6EyfPUpB0M
         uURU923DFyT3S7Sg4y/AQDJdktuLYFr8AfvV1N2xHqbBx71v8NYO7dwwgbcutyUZx796
         pcbhLwNKhHmaDTVXMTA/4EOx3FueaXjkfYjCVjxlPOKqOJHkTgZ3E5+cz/7NoaaxPBtZ
         dFCQ==
X-Gm-Message-State: AFuF++kJNQSDn2P8UqC/7a0eTigw1/PrVjzTYUoZw+rwxEdyfkDpHaln
	qZP913ewg0sw4ikI13bzHzLNJbbOCpzCWshL/M8Tk5VGFC9l34OfVFXNZ23M+VjIfWXGN9VRuri
	srH7afmNRGF9wh0vmB8qykD/9b0GXceI=
X-Gm-Gg: AYBFou2+Ntg5DINJl07EQWlA/jTYRSJeuemu/ZopIyK9OGn3KLVgxSrf5elWKeGBXFy
	LOKZJX96AslmXsXpFeh1foe/25dx7u9+mnFR7hb814wA5XTqUFZGG0Pu755JbVhGp5c48NZUYFA
	MTXIC1B95l8NevonwLLQy+oJR/vmKWCfjnkDZHtAPe2VCzbAZBbnps1PfkMhrMY2cOAtcpJBFjz
	WCyyafcxOM/tnOTl4bKXxbbf9y4lPhWrZfMMlEuBn0hV+sA5zA2Z244C8HfMvCumH812WE9y/i/
	E7XG9Ft96A19WuqJeFMZDnypV/YtR0/TwP11jf9mtuzAdCA1l43UsjG0f5wy21N8F1iW2GrKUFQ
	G7iCSju6shqbzQ4SFCgncQl8=
X-Received: by 2002:a05:690c:f06:b0:872:1e2e:b4c5 with SMTP id
 00721157ae682-88d1ea3909fmr19237987b3.18.1789455785192; Tue, 15 Sep 2026
 00:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911084314.3481637-1-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260911084314.3481637-1-xyx2021@mail.ustc.edu.cn>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 15 Sep 2026 15:02:53 +0800
X-Gm-Features: AcwNN1XJbrgTFH2u-O8DGAasfSBOddVh6F6Ic67FQ7q8FtrjCmCS-Gcvu5fhDmA
Message-ID: <CABFUUZEuQxLTm=4+6B3yTA90s6s_03Dw98y3im1wmmcKWsqB5w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject non-negative offsets in stack_slot_obj_get_spi()
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 4:48=E2=80=AFPM Xu Yunxiang <xyx2021@mail.ustc.edu.=
cn> wrote:
>
> bpf_get_spi() computes (-off - 1) / BPF_REG_SIZE using C division,
> which truncates toward zero. For off =3D=3D 0, this produces spi 0, the
> same index used by the valid stack slot at fp-8.
>
> stack_slot_obj_get_spi() currently checks alignment and the resulting
> spi bounds, but does not reject the non-negative offset itself. It can
> therefore validate a PTR_TO_STACK register holding fp+0 against an
> iterator stored at fp-8 even though the runtime receives the actual fp+0
> pointer. An effectful iterator kfunc can then interpret memory outside
> the BPF stack as iterator state.
>
> Reject non-negative offsets before converting the offset to an spi. All
> valid stack objects begin at a negative offset from the frame pointer.
> Add a verifier test that initializes an iterator at fp-8 and attempts to
> destroy it through fp+0.
>
> Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
> ---
> Please queue this fix for stable after it reaches the BPF tree.
>
> Tests:
>   - W=3D1 make O=3D<build> kernel/bpf/verifier.o (15071f-based candidate)
>   - make O=3D<build> -j12 bzImage modules (f77d212 baseline and candidate=
)
>   - strict clang-20 build of iters_state_safety.bpf.o (f77d212 candidate)
>   - test_progs -t iters -v --watchdog-timeout 180 --workers=3D1
>     - f77d212 baseline: 96 subtests pass; destroy_fp0_fail unexpectedly l=
oads
>     - f77d212 patched: 97/97 subtests pass
>   - panic_on_warn=3D1 and panic_on_oops=3D1; no warning, Oops, or BUG
>
> The four commits from f77d212 to this base only change sock-destroy netwo=
rking
> code and its selftests; the patch applies without conflict and verifier.c=
 is
> unchanged across that interval.
>
> A separate effectful reproducer is available privately on request.
> It was not rerun in this validation round.
> The full unfiltered BPF selftest suite was not run.
>
>  kernel/bpf/verifier.c                         |  2 +-
>  .../selftests/bpf/progs/iters_state_safety.c  | 22 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1b0b1fb628786..efbb446998848 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -567,7 +567,7 @@ static int stack_slot_obj_get_spi(struct bpf_verifier=
_env *env, struct bpf_reg_s
>         }
>
>         off =3D reg->var_off.value;
> -       if (off % BPF_REG_SIZE) {
> +       if (off >=3D 0 || off % BPF_REG_SIZE) {
>                 verbose(env, "cannot pass in %s at an offset=3D%d\n", obj=
_kind, off);
>                 return -EINVAL;
>         }
> diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/too=
ls/testing/selftests/bpf/progs/iters_state_safety.c
> index 646026430e9b5..e5bb9fe6d5e53 100644
> --- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
> +++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
> @@ -52,6 +52,28 @@ int create_and_destroy(void *ctx)
>         return 0;
>  }
>
> +/* fp+0 is not a stack slot. bpf_get_spi(0) used to alias spi 0 (fp-8). =
*/
> +SEC("?raw_tp")
> +__failure __msg("cannot pass in iter at an offset=3D0")
> +int destroy_fp0_fail(void *ctx)
> +{
> +       struct bpf_iter_num iter;
> +
> +       asm volatile ("r1 =3D %[iter];"
> +               "r2 =3D 0;"
> +               "r3 =3D 1000;"
> +               "call %[bpf_iter_num_new];"
> +               /* r10 is fp+0, one byte above the top of the BPF stack *=
/
> +               "r1 =3D r10;"
> +               "call %[bpf_iter_num_destroy];"
> +               :
> +               : __imm_ptr(iter), ITER_HELPERS
> +               : __clobber_common
> +       );
> +
> +       return 0;
> +}
> +
>  SEC("?raw_tp")
>  __failure __msg("Unreleased reference id=3D1")
>  int create_and_forget_to_destroy_fail(void *ctx)
>
> base-commit: 15071f2a1263e82150c77eeb1e94dbfc31950a8e
> --
> 2.43.0
>
>

Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
