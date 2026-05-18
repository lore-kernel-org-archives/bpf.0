Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456783876A4
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125545; cv=none; b=hvPe9pmckRPvaZXjS+Xq58YFR3BsafyP2cN13DlUufSnprlgBykw2MZg4BM/7NJjV7PNbY3a4dhfP063a/L72nsf8dyvBvzw6u5GquEeh/M8uFhAGRF44bVE8ggdogY/ytrp/9uUYeRbR+SnkIgplO7rad2xmDkchtUOzODfGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125545; c=relaxed/simple;
	bh=qDnq4eaGNFK2SGI02BmVW/3CM1ybPuWfyYB5cPPAe50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDTcEXOK/H0f4anTGGbGh8YSKxBhG3H9XTKHes6uP8Z1vsH9FWOP8CWeOVrpqybmd1z3LO1Kqxz3/qwYQp9WjTOP9sNoCR//6HaTmxJpT/JF55UO9L/PMaaZBURwiQCx5Wl1Z7BQphUphtwCQXNUAVD2cmSYR0ljyzJpdce9xFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd2FbRgk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd2FbRgk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso20184895e9.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125543; x=1779730343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYV0zqL6HYPOKYxx4HDUjaYd9lPJSBdXFVS13R+/0Hw=;
        b=fd2FbRgkNTfsOimTfq3JNO/3GxA94QltooDJJTU2/3BOt9EWHGqxIjFcNo+ai3sDvn
         uhXI55kg2XqWwM1zMJUMDsegLPxmpWASH9MjnPluY7bWWp9yQ/n8B2593JurJIuYDGF0
         2Qf0mZX98wtwOCNnhppVgx+B7j0JDduwrhZ44S9j7gBlpbHrwdhg1/ixPrnC552Wstle
         PliRnAGMVpdAt4bqo7vywuvTGZLByRLjRIp8GFNwakwUVnxI2TdnqWj1XCkRG3ZAEcFz
         KP4hc5nx/NpApV674Qom2td7WgfbtNXaSIdbjePpr4NqHj0CaPZ04yPNqLrpQPQpK48d
         wuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125543; x=1779730343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYV0zqL6HYPOKYxx4HDUjaYd9lPJSBdXFVS13R+/0Hw=;
        b=S0JxmqCVFN9ru3dvIR1LnXznaAgPX2ofHxYCbqOwA+5FYp55ZSA8h5BgjMUeYPFMkq
         8hy3rRdU8V527JyMPu15UH4HPbnP806uAOVxEy6A+VJOweM8UxYUpCljvipZy/I6513u
         ZEFYFFrtzIYL6zSHY8It+0rAYpCWWkb4BDEooddgy2RuWW5GC5oil/QYwUan/GrzvB30
         lIWiVhWhRCa37W6uYS/4gfqU6ol3mSdZR1fyV0Ka/Co3trVLfyzsP6W6J+wwMH7uPiku
         H51TdwGXoKW6Kx4X+IO+9OPi9sInES79X1bNL9wjWwYdNv7PT6lXB6Df6Kk3B8JihUjG
         flxw==
X-Gm-Message-State: AOJu0Yzh5SFYBJ7I3NphRdmmrGBgvlWIhK3DGeFL5ay9HBqbWa863187
	f9HKNTWIj4yROWoBVwM2eocvRg1w+ePl+FWZAWpiVVFfvg59KLqLpbQQ
X-Gm-Gg: Acq92OEl0vFXUvhRFIcJqTqxNKq/JOszOhPYKV23tY9UDFTwY+UYUuZ3Wx2aiuGGWz1
	WuMZdGTmdFLnI6Q2yNiTjMB+0uENkGbtqG4eLbgWNTb9Q2o7zNeZ3OY84kTh4JAL86v8tc7gH5u
	8RPS5FWaFxmkgfQeDAhtc8zl8TE3qrNJW5ExQmPcB6NnWbOlKZa0+oSF+0dzCls/LP3B4HREQUp
	Z2wkyBL81YV3XzFNZgvICrVI1BFnbigv+JLJZsRvD4mt1+Bk4/Y0mDDr4YSJigYtVe0n/XcM2ue
	KQGhu00GAL9cJP6jC9rThkTlqXDKekDjo2OzBpBktJEqZdt3x1mKiy7BhM3IVaPozskyqegWBNq
	XHN87fqk+a5RF6X1ZMUFZ6r8ObngMvk8UaYkz6ipJACtStBEqGope9TmBd9jZm0rLbUpgDDyevK
	78q5SiQJXmkBhye4TnDT8DmMC0aH58S/Sc4k5RzMf4K5YYbJ08+rozJmxUYr3hIn5utVlFWqm5u
	CkI577J3kiiHIeLIbgzMkriOcms1BqdSSONLh3c8nwbZ34L6j1UjhHyXnDGP20ewdGPyyK1lNAN
	lbA5h9+yOFw4sODXgTsoSWvdiARXND+PWBoWKNQ8Pg==
X-Received: by 2002:a05:600c:4f8a:b0:489:ad:7b5b with SMTP id 5b1f17b1804b1-48fe62f8c6bmr248825185e9.24.1779125542488;
        Mon, 18 May 2026 10:32:22 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0002302090c50a60b9.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:230:2090:c50a:60b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767ee0sm36480002f8f.1.2026.05.18.10.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:32:21 -0700 (PDT)
Date: Mon, 18 May 2026 19:32:20 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix test for refinement of
 single-value tnum
Message-ID: <agtNJGOp-jwGrQiL@mail.gmail.com>
References: <be2dc2c3d85120286e60b3029b3338fff339f942.1779121582.git.paul.chaignon@gmail.com>
 <86c3b9ef65bb65d98d90fb341c3ff0c278053fe2bf77f118084af3ff500c6e64@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c3b9ef65bb65d98d90fb341c3ff0c278053fe2bf77f118084af3ff500c6e64@mail.kernel.org>

On Mon, May 18, 2026 at 05:09:21PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > index a3e4c0945137..bc038ac2df98 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > @@ -1892,25 +1892,25 @@ __naked void bounds_refinement_tnum_umax(void *ctx)
> >  /* This test covers the bounds deduction when the u64 range and the tnum
> >   * overlap only at umin. After instruction 3, the ranges look as follows:
> >   *
> > - * 0    umin=0xe00     umax=0xeff                              U64_MAX
> > + * 0    umin=0xe1      umax=0xf0                               U64_MAX
>                               ^^^^^
> 
> The comment says umax=0xf0 but looking at the code change below:
> 
> >   * |    [xxxxxxxxxxxxxx]                                       |
> >   * |----------------------------|------------------------------|
> >   * |    x               x                                      | tnum values
> >   *
> > - * The verifier can therefore deduce that the R0=0xe0=224.
> > + * The verifier can therefore deduce that the R0=0xe1=225.
> >   */
> >  SEC("socket")
> >  __description("bounds refinement with single-value tnum on umin")
> > -__msg("3: (15) if r0 == 0xf0 {{.*}} R0=224")
> > +__msg("3: (15) if r0 == 0xf1 {{.*}} R0=225")
> >  __success __log_level(2)
> >  __naked void bounds_refinement_tnum_umin(void *ctx)
> >  {
> >  	asm volatile("			\
> >  	call %[bpf_get_prandom_u32];	\
> > -	r0 |= 0xe0;			\
> > -	r0 &= 0xf0;			\
> > -	if r0 == 0xf0 goto +2;		\
> > -	if r0 == 0xe0 goto +1;		\
> > +	r0 |= 0xe1;			\
> > +	r0 &= 0xf1;			\
>                    ^^^^
> 
> After r0 |= 0xe1, the register has umin=0xe1. Then after r0 &= 0xf1,
> the mask 0xf1 allows bits 11110001, which permits both 0xe1 and 0xf1.
> This creates a u64 range of [0xe1, 0xf1], not [0xe1, 0xf0] as stated
> in the comment.

That's correct. But after instruction 3, on the fallthrough path, we can
also deduce that R0 != 0xf1 and our existing refinement logic can thus
tighten the u64 range to [0xe1; 0xf0]. The comment is therefore correct.

> 
> Should the comment be updated to umax=0xf1 to match the implementation?
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26047251229

