Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44D366DAF
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770456; cv=none; b=njf/b60UhqDuREIrvFW1+jWF2fEWSuNf2J9nxUXdmmLgafuwriaaLPClkd17400xWn2tNScVd5ne0ikUgLlXgGRRQVTwkUdfwkKlNuCoaAwLjI4v779BiY039mt6Cu8XvAjofH6ZEM7XkzZyAiVhvFdkWiPRHzv90boNnVrohzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770456; c=relaxed/simple;
	bh=ApFOdlBINJb6va8ZKtBcDC5VeijkDCocJzYJuCxeRqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ+PViLl383L281ORapf+4V+rp1XmX0h8bJe+QwLFzgDMtKcfS9TtykE3WINCRty2k23QMgtjYT3udrqdkbm8kX8eA/2qKlgQCfhl59YO4xOTgqi9N8FP96snzjoyiDtcMVJ7nNXMizLD6pbejyUT7ERmhtaUCQMLqynGSCpKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C8q9MBjT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C8q9MBjT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48371bb515eso129808815e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 20:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772770453; x=1773375253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97am08PEFiYrGBVCLZm5BCcjDnoj5HOJeRGMjdOli7I=;
        b=C8q9MBjTr8UGJYbhtn1wMNuifSj1jclcVr2JNX76hcQB2A07Wre/4QwrFILsTlYqNR
         PjMxP3rYisuX8eq4hRHq7dmWainGtq3FnRxAlMECLZnkH3rwvPXP8hxAfyq1qU0Tj1zo
         MEvL1GlzaIApAKSvP7Y+v9TN8lrTLcdfQmaQ8+1y7QO3QZ/6BvMhTUXKMzRA2gElafsK
         MldI33gauTK//ap3DFWQmapxzDSxmyTsGmnbGr5QtF3BeIifNypqj40SSOl3HFpZQQE4
         TpBQENOavAv9qvam9Gu0aiPl0QYv2C70HnK5d40T2vFkUp15X+haUZ7CIk0bl3QPGRqd
         su8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772770453; x=1773375253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97am08PEFiYrGBVCLZm5BCcjDnoj5HOJeRGMjdOli7I=;
        b=uHjtdiYdz7mOq48I2oAA6pMd9VMLxvxsY4Y7UVmxnxRknbLuB6RyRFiDVbnPgAF0iJ
         HxbawJla0Fi1PlH8Z5sv9TkR3hOFi91J8SVX4oKOL5Fap0JNCfOe+21n2w5E9CMuFhJm
         vMsi92a1LoaBoHRCcI0D+ADYeOih8rdnL11wBd2Kj1z2uYgQ4OvnaTA5j5KF/L5dILd9
         2t5JyZ4Tpi16f4092Z6/MaGQ554rVI7xjqkt1z3HmLBMmt/JXbmufARFZqfR5A9sCqxY
         xZaR6WYCo0LFQRH8khS0GYrzbbsv0ngrJgCGZhr11M9yNb161qEFZvuD1hy1PfUuEmSK
         0Iig==
X-Gm-Message-State: AOJu0YzVnLijgOxIf/CcW769dT/SHAQgaqzKg/azafGO6iZjXcIkddR6
	qLz9WJOCtQ9NNWa6Hjtk8cysBIcLutTNMEWnRM0G88/uRDXqnbzGozuufLm6NdoJ77A=
X-Gm-Gg: ATEYQzy+lh1ypyxbCJEDkK7bEhqb4fZjCxnRNXLg8Zz608T0+YiNKnt8r+OjPUonDxQ
	6XLtpbxY15GNC8st8WVYDON7/Dz8cxsOh9Kj8x1zcF1j2VHeIoRlNzm+wcRufqZd7QRalNwLv/N
	weUSnsYPNfwaIoyQbgi13pIyPmnUh+DOiPngZwAmaoASGs6DxS6eU+BxWkn1VRRSHrJ97FxWZwZ
	oqmTSsLhviDHHNyWPZAOzEXZe1Z9TLVAzWGLbE43iGP69+zDtedTYd0MKd8LyxseGwISYe6GZW4
	PN90O6Vrqee4jGaPxOfLKGuxgcUdbpSNWemqh4j9gAQcnDJl0/2ZGcgmyao6upLgKlYkV+aQTPr
	a6U6PgpAOhGmMW/+UIE4XKJhbyAZZKdDn7JGXjIJIj9Zf8qW5hBu3tGF69KjL6ObeHREymzZnXJ
	XUhd6atH/zJSjOA4a5a4csa6vcezY+eg==
X-Received: by 2002:a05:600c:4e8d:b0:483:a2ce:f461 with SMTP id 5b1f17b1804b1-4852691902bmr7839605e9.4.1772770452923;
        Thu, 05 Mar 2026 20:14:12 -0800 (PST)
Received: from u94a ([2401:e180:8d04:ef14:c2ab:34a8:92f4:47b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ccb6csm3652985ad.92.2026.03.05.20.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 20:14:11 -0800 (PST)
Date: Fri, 6 Mar 2026 12:14:01 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
Message-ID: <nuuegl23fabz3whjszvzwd67m4l2dzu62w6onl45rjdauweyif@6gqzd2kzne7u>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aac2GMpnpoAKD4jX@mail.gmail.com>

On Tue, Mar 03, 2026 at 08:27:20PM +0100, Paul Chaignon wrote:
> In commit 5dbb19b16ac49 ("bpf: Add third round of bounds deduction"), I
> added a new round of bounds deduction because two rounds were not enough
> to converge to a fixed point. This commit slightly refactor the bounds
> deduction logic such that two rounds are enough.
> 
> In [1], Eduard noticed that after we improved the refinement logic, a
> third call to the bounds deduction (__reg_deduce_bounds) was needed to
> converge to a fixed point. More specifically, we needed this third call
> to improve the s64 range using the s32 range. We added the third call
> and postponed a more detailed analysis of the refinement logic.
> 
> I've been looking into this more recently. To help, I wrote a high level
> sequence of all the refinements carried out in reg_bounds_sync. u64 ->
> s32 means we used the u64 ranges to improve the s32 ranges.
> 
>     /* __update_reg_bounds: */
>     tnum -> {s32, u32, s64, u64}
>     /* __reg_deduce_bounds: */
>     for (3 times) {
>         /* __reg32_deduce_bounds: */
>         u64 -> {u32, s32}
>         s64 -> {u32, s32}
>         u64 -> s32
>         s64 -> s32
>         u32 -> s32
>         s32 -> u32
>         /* __reg64_deduce_bounds: */
>         u64 -> s64
>         s64 -> u64
>         {u64, s64} -> {u64, s64}

Nit picking: my mind read the above with bashism and at first thought it
expands to the following:

        /* __reg64_deduce_bounds: */
        u64 -> s64
        s64 -> u64
        u64 -> u64
        u64 -> s64
        s64 -> u64
        s64 -> s64

But on a second look I do get that we're {u64, s64} means we're
combining knowledge in both u64 and s64.

>         /* __reg_deduce_mixed_bounds: */
>         u32 -> u64
>         u32 -> s64
>         {s32, s64} -> {s64, u64, tnum}
>     }
>     /* __reg_bound_offset: */
>     {u64, u32} -> tnum
>     /* __update_reg_bounds: */
>     tnum -> {s32, u32, s64, u64}
> 
> From this, we can observe that we first improve the 32bit ranges from
> the 64bit ranges in __reg32_deduce_bounds, then improve the 64bit
> ranges on their own in __reg64_deduce_bounds. Intuitively, if we were to
> improve the 64bit ranges on their own *before* we use them to improve
> the 32bit ranges, we may reach a fixed point earlier. Said otherwise, we
> would need to move the *64 -> *32 refinements to the beginning of
> __reg_deduce_mixed_bounds. (The logic would then also better match the
> function names, but that's secondary.)
> 
> After testing, this small refactoring does allow us to lose one call to
> __reg_deduce_bounds.
[...]

I poked at this patch with CBMC[1] because I was curious how much worse
off it might be compared to the old one, but the first counter-example
CBMC give me actually shows that it is possible for the new version to
perform better despite loosing one call to __reg_deduce_bounds.

Given that it is possible new version perform better (at least for one
case, with caveat that such case may not be representative) with one
less  __reg_deduce_bounds, and that we used to do just two rounds of
__reg_deduce_bounds anyway, I believe this patch is good.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>


The improvement seems to come from making sure *64 is the tightest
possible first (with __reg64_deduce_bounds) before using the knowledge
there to improve *32.

The counter-example that I got enters reg_bounds_sync with:
(I have no idea if this represents an actual register state that is
possible to encounter, and it is rather suspicious that that smin is a
value that is not within tnum/var_off)

  reg.var_off.value=2
  reg.var_off.mask=0x8000000000000001 (10000000 00000000 00000000 00000000 00000000 00000000 00000000 00000001)
  reg.smin_value=0xfffffffd80000000 (11111111 11111111 11111111 11111101 10000000 00000000 00000000 00000000)
  reg.smax_value=2
  reg.umin_value=2
  reg.umax_value=19
  reg.s32_min_value=2
  reg.s32_max_value=3
  reg.u32_min_value=2
  reg.u32_max_value=3

Where combination of umin & smax gives the tightest possible range of
u64=[2, 2]. Both old and new was able to arrive to this conclusion in
__reg64_deduce_bounds, but in the old version that range gets thrown
away in the final block of __reg_deduce_mixed_bounds:

  if (reg->s32_min_value >= 0 && reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX) {
    reg->smin_value = reg->s32_min_value;
    reg->smax_value = reg->s32_max_value;
    reg->umin_value = reg->s32_min_value;
    reg->umax_value = reg->s32_max_value;
    reg->var_off = tnum_intersect(reg->var_off,
                      tnum_range(reg->smin_value, reg->smax_value));
  }

Here the old version will put s32=[2, 3] into *64. Where as the new
version not affected because s32 was already at [2, 2] thanks to
__reg64_deduce_bounds coming before u64 -> {u32, s32}. The end result is
that in old version we get

  old_reg.var_off.value=2
  old_reg.var_off.mask=1
  old_reg.s32_min_value=2
  old_reg.s32_max_value=3
  old_reg.u32_min_value=2
  old_reg.u32_max_value=3
  old_reg.smin_value=2
  old_reg.smax_value=3
  old_reg.umin_value=2
  old_reg.umax_value=3

While after you patch is applied we get:

  new_reg.var_off.value=2ul
  new_reg.var_off.mask=0ul
  new_reg.s32_min_value=2
  new_reg.s32_max_value=2
  new_reg.u32_min_value=2
  new_reg.u32_max_value=2
  new_reg.smin_value=2
  new_reg.smax_value=2
  new_reg.umin_value=2
  new_reg.umax_value=2

Haven't check whether Eduard's latest u32/s32 bounds refinement patch
makes any difference. Likely not.


We also likely want to retain *64 knowledge final block of
__reg_deduce_mixed_bounds with min_t/max_t as precautionary measure, but
that is orthogonal to your patch here.


1: https://github.com/shunghsiyu/reg_bounds_sync-review/
