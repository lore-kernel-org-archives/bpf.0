Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEAE37E5D8
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172831; cv=pass; b=IZWzRYA7y9GEBlCa70a4M6Nsxy1Xwsx5OGsfuTrcWNkzGjjdFvKI4rMWkoqGIxrAGN/iM9H48p116Cd5+S3i462lyrIyYn0E3Bm8VmDnyjrEoJBzY4kWp+0GIafoafYU8kjz8UZKyQWX4v9GH8V400WgItttltu8XC1oY7BeRW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172831; c=relaxed/simple;
	bh=uSlajszt+v1CRapk8IvXExaGgd62+VPOnKY9eJlACNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7KX2XBkcs5JEceUdckktLIV4F8Fp7Nm3c0VsoEYrPIheZPOHqfN+Ijie2BLSbio9HDhVr0lRTFLnyT3tpMJ+/tTbLDjfL7Dy+NgT9GKclSSVvIVGrUOEqE57ZvYfVouWu38oa3maib0L/wAxPnW+8mbUUKjzCEaJZZ07S8Krcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRIGpHlP; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRIGpHlP"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c247f6687dcso24995166b.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 10:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792172827; cv=none;
        d=google.com; s=arc-20260327;
        b=HhbkUuDRXJ6BuBvzMeiQxrO2oAAFWK8HJzBkkrnvOwXreC4dVMF09BKRk5IDLOhArV
         c9XKCyhsEx6hMJmCqGQtQ7yZm7P85AHjx7vFvHyBNxo2k9f1B4jO14deDb+1/16PUpX+
         CRXCvuCx24kovSxMQeUew2b8HZHhcKbYaNyyfJNE1NqDsHn/3iGxZVAaQVHD02XNW3kh
         YqFJJLjvR7J9etgd9sqQXuKXl6Mnk5lEn85a84A6+mwTZ7imDJFuzAEFEKsjTZSjR3HB
         uW5BeY5tSk0/ga8PvwEYWxYRKumLIvMFPPdrkETYp+D+oYjYJ3U748LacsUmk682Kt1n
         6Diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHgUB10P5VN5xvPA6XcNoyN3ZPY0VdZiK74UugihdkE=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=AzltejSX03PTDtot2Oy9ogkf2X/J5mlGUpj/mG4OhmdGHiUkX97W9iEd4Msh4/AxQR
         E04bzMwgr2od1bv2d4W8tclJ3Q2SDVODrgucgLG2zrGVNtkyy5SrrsbAc6mxevIiL1RH
         wTDfbXy0Hqim+Br5W8pusUhQkLH85nAutWLlbvzHiAgUmJr6j9najpbrcKdKSAMSpsa9
         pmGia+X4ywanw9jLj3EGs93H2o02lkbko5cZw+7xgXs/AG3A0ivHPkR2a+udBBH5CngX
         2E2ZO7biLn+UObeSse1mA9vl2HbbWZc8cItIWDKHfs2JHZ1Dy2usHeZO7YhYQn/xs3ME
         o04Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792172827; x=1792777627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gHgUB10P5VN5xvPA6XcNoyN3ZPY0VdZiK74UugihdkE=;
        b=nRIGpHlPxMhWV/THVMm3IBlwR3bfOEwh0WeBlMGp8vJQ8+Da+srESzJN96aL5amosH
         mGiPF5TK4ZpUXHLodmU0kLCoqgBnddoxfqlGVd3OopxStSlyHXjCupPeEuB7RwOzAQAw
         eb2lzIgJqza7C8iY1p7bIPreeNFrkbpQ/KUilglmeNuyUGnZEv+D/Y/CQ6oZeFOOmjaY
         x6TDTSNkN+h7jlC6MLewl1bqtBiv26lTJelPtmIZR7mH3iPCeQngRB5ZjCGBUKEOGp8r
         Ks3GSz/E70M5D12BorOWv3YfpWXa+BwJYLYror4Hj9GWHUnSpyWJlNtbSY4vHNQjcdaf
         21VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792172827; x=1792777627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHgUB10P5VN5xvPA6XcNoyN3ZPY0VdZiK74UugihdkE=;
        b=IOw++qg72Y1jMg81uskhfphhFzZEwTq966/Xn6Tghjj38CbWRob8a1Hm54Bmf8/ORk
         r9+XyruxQm1zvC4ixN9q5rryjFV0RvpunfBETPwnLXqi6h7MxvFAjvxUTV2mp4qtFMLO
         RPeWOnNIf0tR5pjDjXTrdUo29XckbnwSAAYYLPfdoYzijC9taIP+mYTBVdzlrpuaMCbw
         azKdcUXfzlygf9LWOeG2f+g0TpElcA27aAH/SvQi+AxWgbg5kHHsET/hGqHtzDVNa5bo
         DAtVmyAst74kN9pi8FCcbSOpyovAyQb3s4Ww2YAT41w/g1s/5pJB7nYJA1I8kI1J3ci7
         b0xg==
X-Gm-Message-State: AFq9FYLN25qySi3m1MOPLZZncah2ENcGEcHoNfx++Lrbdpo6ufxmRAZv
	Gy/pbTImgB0Ts6xBJ5dNBE1+ZzVWHNr0c7jl1UqksPE9l7YW7JrQ7jbt0wLPCW/7SLiO0SYcw3x
	47rQ2tiajyGPJpJdQ5LbTglxC5rsC1KwoA2/LMVBz3w==
X-Gm-Gg: AYBFou3B1SA6bOwWbTSvdKc/1Ev0tqkj53R36DyIOcd3rVr0eZ8eIYPZCVRo+2Z0vQU
	GUqfEp3KclvDzw3Nm46PqqU36OPhH4FVHlAAf2or6SENKujluj+hT1+s7w9l0DfFkNSxusj4LzE
	whjIYACQ9OgmXGZGykotWF8g4TyK/GwZz8rFiXhoyTVA8P5pLJ/lTjAvH9aXp4/tupm/ErbtdAV
	Dx4vAcH4t137r36ktZBOVB8youOdKOf0/PNHKfkslgdvCG8inb71/kZYHbwTH4/Zm/uCjwOjNCn
	FsPf8b05apDEWonXtfWvEXYaMQ4vjiGkHMfQXjfPkkVIY0jVP5sk8H5KXp0wXegHUqYhg3JplN+
	gEQ+2MSCt6Ilu
X-Received: by 2002:a17:907:2d10:b0:c1f:983f:d8a with SMTP id
 a640c23a62f3a-c419e6488bamr43994566b.24.1792172827241; Fri, 16 Oct 2026
 10:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016171319.1623447-1-puranjay@kernel.org> <20261016171319.1623447-3-puranjay@kernel.org>
 <sashiko-outbox-174717@kernel.org>
In-Reply-To: <sashiko-outbox-174717@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 16 Oct 2026 18:46:52 +0100
X-Gm-Features: AclHuK-9FKtfzxO3GrmHQgPK304wDgBltpq3vhcsxnC8jVAUThtsVhUdr7o1auQ
Message-ID: <CANk7y0h6hXXihv_x3O81uFyifQtQaupAhmJPZxCQF6tpqcLP6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] selftests/bpf: Test fetching AND/OR/XOR
 atomics in arena
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 6:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] selftests/bpf: uaf test silently passes on ARM64 instead of skipp=
ing
> --
>
> commit a4f52eddc0e670a7a41a5b1939916ca84274f849
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> selftests/bpf: Test fetching AND/OR/XOR atomics in arena
>
> The arena and/or/xor tests never exercised the fetching form of the
> instruction. Commit 2897b1e2a2f4 ("selftests/bpf: Fix arena_atomics
> failure due to llvm change") deliberately switched them to
> __c11_atomic_fetch_*() with memory_order_relaxed, which clang lowers to a
> non-fetching locked instruction when the result is unused, because
> x86-64 could not JIT the fetching one against an arena.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/t=
ools/testing/selftests/bpf/prog_tests/arena_atomics.c
> > --- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> [ ... ]
> > @@ -160,6 +199,18 @@ static void test_uaf(struct arena_atomics *skel)
> >               return;
> >
> >       ASSERT_EQ(skel->arena->uaf_recovery_fails, 0, "uaf_recovery_fails=
");
> > +
> > +#ifndef __powerpc64__
> > +     /*
> > +      * A fault clears the fetched register and leaves the address alo=
ne. The
> > +      * powerpc64 JIT does not clear the register of a faulting atomic=
 yet.
> > +      */
> > +     ASSERT_EQ(skel->arena->uaf_r1_after_dst_r0, 0, "uaf_r1_after_dst_=
r0");
> > +     ASSERT_EQ(skel->arena->uaf_r0_after_dst_r0, skel->arena->uaf_r0_b=
efore_dst_r0,
> > +               "uaf_r0_after_dst_r0");
> > +     ASSERT_EQ(skel->arena->uaf_r0_after_src_r0, 0, "uaf_r0_after_src_=
r0");
> > +     ASSERT_EQ(skel->arena->uaf_reread, 0, "uaf_reread");
> > +#endif
> >  }
>
> [Severity: Low]
> Does this test silently pass on ARM64?
>
> In the uaf program in arena_atomics.c, the fault testing logic is compile=
d
> out when __TARGET_ARCH_arm64 is defined:
>
> #if defined(ENABLE_ATOMICS_TESTS) && !defined(__TARGET_ARCH_arm64) && \
>         defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>
> Because the BPF program does nothing on ARM64, the global variables
> (uaf_r1_after_dst_r0, uaf_reread, etc.) remain untouched and hold their
> zero-initialized default values. The host runner here unconditionally
> asserts that these variables equal 0, which makes the assertions
> tautologically succeed on ARM64.
>
> Could the BPF program export a flag so the userspace runner can explicitl=
y call
> test__skip() when the test is unsupported, instead of silently passing?

The suggested work is correct but the underlying issue is not
introduced by this patch, so should be done separately.
