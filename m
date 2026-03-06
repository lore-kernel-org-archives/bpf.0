Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8F2E9730
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840988; cv=none; b=Uxfy8YyAsMYrmcAyy/ZOUlKSl+Af/YZFhpu+gNMyjUE3K4N3+cZ/tuTGnCj4t6E67t6hvjzwdCx8oOhKx/MVfF2GRwhy83sIREAcdm2cm9H9P8qFwXCgF4BTZYPrHamm2FerVdXYGPOwEV8Gey1wsMntiSmQlXxUpubZhPWRmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840988; c=relaxed/simple;
	bh=1T62JRKx3U1aGy+50DETLMude1ac2jMp6eYNpFKB23k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0D1BrfcB+6vDx1jDH8/zB3o+XOHjQvvahh57hCYikYQU38kD8tUsZAXTjvMC07AMR5f2fp/Ku5dhWlcStzmUxr4ZLmXZkVpsp24gwSPGQHKuQwa49l2kpojpPp91GojGIi1TeZwKzRyAKT6tQwezXCTSMxVTz5vnNekSWY7Lks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjPui0B3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjPui0B3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso5296535e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 15:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772840985; x=1773445785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2IY1G8HPBFrEMoOvdZ2rv66LWJUYFAoGvPpSQVjtr3E=;
        b=HjPui0B3vURAkrvDAZvPilCeEQXvSEPiDcTizuDpMxzcOKzpjO9TTmShOdG1ZzKQCA
         OUDc2i2/LTp35YMdDCESCZYXMJxlq/FlCvAXX42joFCdgpCkL2W6DZwUIx6Q8khHQA3W
         6kt/ul0rbgoe8lYNcuADp8aGZ0V6Guqog/QlMmxKSyVhqvFu1fdAz6Es/SZAiEvpWYax
         Hbt8xp7kc7GhjE8CuYf9K3cOi4gWJ0yK4p1ZvhD88uSGcxYR8kVljmu/pGhw/Q4Xnp11
         8o1ReFo1theIusl6vx+AtPE7IH8A+JbcaB4jET75MTwP6SiBgpL2Bo0wZ85SypKk37bv
         FQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772840985; x=1773445785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IY1G8HPBFrEMoOvdZ2rv66LWJUYFAoGvPpSQVjtr3E=;
        b=haxwoWxMpVDJPmKFZ9/iae9sM/ha9+Q0oJbiyyiHOgny4l6nlpgsa5DaRfIM4SK/IG
         bhAHhy58Jvvzpbg9gVaKkqiq9Dp1H7Rz0fVjsooPsG3NiZ/Kjy9PkKtVUjPw7qigg2VM
         Vr35v3TBbIuRSmcZum8fQdmqxhl1Tuovfb2i1HZwZm8ZT6msqEu0Isj5+a7BFBz4YiW0
         ToIbm07Lgh42+WQejPpWyf3b/2800S0XP5aMAUPNVoigkmvgrYZl5o9gjyD2qF1Hp2sm
         E5YygawHXyGdCprpkwEpoYMwl7gKANqcyjejbXqISOX1+ZPS72HSER19kGjMHAarWNuX
         zvYQ==
X-Gm-Message-State: AOJu0Yy8wxOr85C9MWwhj1VBi951QBePYClDk4FF8ZF6QxqwlZqvGSkw
	B4yF6CH6Un0mUb6gbLyrAE4N4xe8+BB8YrvOGFOwes8rGmKWIvxHUkjj
X-Gm-Gg: ATEYQzzmsAgqSz06AGaApy83M2Pd6ummFcj0l4xMyj7FLg3ZkVduN5O58Dj1hvJFl4+
	KBGlDduwsX12yl6K5mn9bBI3M6D83fXHqEA44p0LOjMx0lWHzwM5H6r5Oof4Qyf0tBrG3P8FZui
	xjQnBcipSR953ALLgNtVplauJI67jKdxMcMPxoW0aYAe+r2FqcaznFKMMyRXHeF0KsweKypwqxm
	jgeo6tm6pYy+EFmd1cU7x4ZeoWEhkwjHpczDZCao7adSQQ7xIkHqnlJRQXWabXHhgavyl7CD94E
	UDBujhcjFJo+Qmibcr0nV+PaS+NJWyXQJfFwUEY6slnKZuU0KXbb/O7i9uqa9om6lt4KiXLDETT
	KnPtc6QA6YMjzPD64Ck4nup6V7s6XANwzuZS5Nk+wL/bKzNMr1E5hsEnt2jxitCJuZ+srDVtSwu
	qw5WhiTj4+q5VlBQNktPucenypGdJCNgHkw9b41maLNxUR7tIkt48bQJhhliENb6vYLSRR3vNZe
	ABSF0d8F+a/olazZEWvRbjQdrgZieykIbC4UpfWAz4d9LiFzq1PV3u6BxwBOplsjSmzMnhgFX/f
X-Received: by 2002:a05:600c:1e24:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-48526978dccmr67809745e9.35.1772840985034;
        Fri, 06 Mar 2026 15:49:45 -0800 (PST)
Received: from Tunnel (2a01cb089436c000a341eb7e94b4f969.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:a341:eb7e:94b4:f969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba66sm5942958f8f.20.2026.03.06.15.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:49:44 -0800 (PST)
Date: Sat, 7 Mar 2026 00:49:42 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
Message-ID: <aatoFpl2eJpS3MoF@Tunnel>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
 <nuuegl23fabz3whjszvzwd67m4l2dzu62w6onl45rjdauweyif@6gqzd2kzne7u>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nuuegl23fabz3whjszvzwd67m4l2dzu62w6onl45rjdauweyif@6gqzd2kzne7u>

On Fri, Mar 06, 2026 at 12:14:01PM +0800, Shung-Hsi Yu wrote:
> On Tue, Mar 03, 2026 at 08:27:20PM +0100, Paul Chaignon wrote:
> > In commit 5dbb19b16ac49 ("bpf: Add third round of bounds deduction"), I
> > added a new round of bounds deduction because two rounds were not enough
> > to converge to a fixed point. This commit slightly refactor the bounds
> > deduction logic such that two rounds are enough.
> > 
> > In [1], Eduard noticed that after we improved the refinement logic, a
> > third call to the bounds deduction (__reg_deduce_bounds) was needed to
> > converge to a fixed point. More specifically, we needed this third call
> > to improve the s64 range using the s32 range. We added the third call
> > and postponed a more detailed analysis of the refinement logic.
> > 
> > I've been looking into this more recently. To help, I wrote a high level
> > sequence of all the refinements carried out in reg_bounds_sync. u64 ->
> > s32 means we used the u64 ranges to improve the s32 ranges.
> > 
> >     /* __update_reg_bounds: */
> >     tnum -> {s32, u32, s64, u64}
> >     /* __reg_deduce_bounds: */
> >     for (3 times) {
> >         /* __reg32_deduce_bounds: */
> >         u64 -> {u32, s32}
> >         s64 -> {u32, s32}
> >         u64 -> s32
> >         s64 -> s32
> >         u32 -> s32
> >         s32 -> u32
> >         /* __reg64_deduce_bounds: */
> >         u64 -> s64
> >         s64 -> u64
> >         {u64, s64} -> {u64, s64}
> 
> Nit picking: my mind read the above with bashism and at first thought it
> expands to the following:
> 
>         /* __reg64_deduce_bounds: */
>         u64 -> s64
>         s64 -> u64
>         u64 -> u64
>         u64 -> s64
>         s64 -> u64
>         s64 -> s64
> 
> But on a second look I do get that we're {u64, s64} means we're
> combining knowledge in both u64 and s64.

Yeah, it's not a very formal write up. I just used it to have a
high-level of the sequence of refinements. I'll switch this to u64+s64
in the v2; hopefully it's a bit clearer.

> 
> >         /* __reg_deduce_mixed_bounds: */
> >         u32 -> u64
> >         u32 -> s64
> >         {s32, s64} -> {s64, u64, tnum}
> >     }
> >     /* __reg_bound_offset: */
> >     {u64, u32} -> tnum
> >     /* __update_reg_bounds: */
> >     tnum -> {s32, u32, s64, u64}
> > 
> > From this, we can observe that we first improve the 32bit ranges from
> > the 64bit ranges in __reg32_deduce_bounds, then improve the 64bit
> > ranges on their own in __reg64_deduce_bounds. Intuitively, if we were to
> > improve the 64bit ranges on their own *before* we use them to improve
> > the 32bit ranges, we may reach a fixed point earlier. Said otherwise, we
> > would need to move the *64 -> *32 refinements to the beginning of
> > __reg_deduce_mixed_bounds. (The logic would then also better match the
> > function names, but that's secondary.)
> > 
> > After testing, this small refactoring does allow us to lose one call to
> > __reg_deduce_bounds.
> [...]
> 
> I poked at this patch with CBMC[1] because I was curious how much worse
> off it might be compared to the old one, but the first counter-example
> CBMC give me actually shows that it is possible for the new version to
> perform better despite loosing one call to __reg_deduce_bounds.
> 
> Given that it is possible new version perform better (at least for one
> case, with caveat that such case may not be representative) with one
> less  __reg_deduce_bounds, and that we used to do just two rounds of
> __reg_deduce_bounds anyway, I believe this patch is good.
> 
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> 
> The improvement seems to come from making sure *64 is the tightest
> possible first (with __reg64_deduce_bounds) before using the knowledge
> there to improve *32.
> 
> The counter-example that I got enters reg_bounds_sync with:
> (I have no idea if this represents an actual register state that is
> possible to encounter, and it is rather suspicious that that smin is a
> value that is not within tnum/var_off)
> 
>   reg.var_off.value=2
>   reg.var_off.mask=0x8000000000000001 (10000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001)
>   reg.smin_value=0xfffffffd80000000 (11111111 11111111 11111111 11111101 10000000 00000000 00000000 00000000)
>   reg.smax_value=2
>   reg.umin_value=2
>   reg.umax_value=19
>   reg.s32_min_value=2
>   reg.s32_max_value=3
>   reg.u32_min_value=2
>   reg.u32_max_value=3

Thanks a lot for the review and the detailed analysis! I also initially
doubted that it could be reproduced in a program, but gave it a try
anyway. The v2 includes a selftest that reproduces this (with a
slightly different value on smin). I added you as a co-author; please
give me a shout if I shouldn't have.

The tnum does look suspicious but my intuition was that it doesn't
actually matter to the reproduction. So it's just a matter of reaching
those *32 and *64 values. The v2 selftest details how to get to that,
but the difficulty was mostly to find the right sequence of bounds
checks to not trigger refinement too early.

So this demonstrates that the patch not only avoids one round of bounds
deduction, but does so while improving precision in some cases! I wasn't
expecting that. Thanks!

[...]

> Haven't check whether Eduard's latest u32/s32 bounds refinement patch
> makes any difference. Likely not.

Eduard's patch shouldn't make any difference as the u32 and s32 ranges
are equal and therefore one can't be used to improve the other.

> 
> 
> We also likely want to retain *64 knowledge final block of
> __reg_deduce_mixed_bounds with min_t/max_t as precautionary measure, but
> that is orthogonal to your patch here.
> 
> 
> 1: https://github.com/shunghsiyu/reg_bounds_sync-review/
