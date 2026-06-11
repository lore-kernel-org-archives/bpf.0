Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA71363097
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160486; cv=none; b=pAnCgKyq6sDXEZeyqFrfxoSsd8zwfCzAPaZ221Ek9FxTkChHZXwiuV7sUtLN9KJRNTXuNe1hy00Zb1E7e/jFbhjtnejZRuW+axgQBrceodpfg0mqHKPO3GMxhyrIUU0qpeqYPGeT6pYd6CXh1wTaZ8ez5tDzSdFvZrmCXc+v/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160486; c=relaxed/simple;
	bh=ta/gSKNvGoanoIlYiNOUoI1vgzNbOnFIlXHsHy7guYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0RqLc9i4GDOjnpsv+gYZeY1zW/yMGw4f6DXOuCljLYb4SGSsctSr9TB5ZQrzH4OJohWv4S3OovBF4jJexbBVo/Rz+3zvuzXAf1uHPIj36h78vGt6fxEtDrQEDm4I/sGYw0qa/QLr6M7x+94NI15FAtfl9c4/XhJKIVQR4ck3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FLcDG9Cr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FLcDG9Cr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490af320e2aso83715885e9.2
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781160484; x=1781765284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAKTHXTGuL4/wSXAiskSC+BGLHaNjyNvdmJF1qOpYQQ=;
        b=FLcDG9CrgtP22lbv+GPacljZ4jk+JmpEwrIpiiQehpTGXE3RWGNmM3OHHdwdju9+JD
         mUP1Ek4PSOXazw7MOk66I4yOR1twi48Map7j6nXueFy2E90ZLkP0mSuUql8cu3iouP3k
         wkRpvX5igByT+ZIyE37wk2YTiODrS8UgnC8zZVhB+Cvmxj8lRKOVm6l9Yeaq1MmWGxcf
         xVXHdz7KJGpq6TmIgaJSWpx8RfHeLFXxydf8xbbc71HX0j5fB997/DZryt3o+mBy5O1I
         5TqDOKpQiTwI+/RuHSNvHsbm5vCjz5z11LA1lmnB8mUN2PRDn17YcWAE9vWdfMU7P2lG
         og4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781160484; x=1781765284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAKTHXTGuL4/wSXAiskSC+BGLHaNjyNvdmJF1qOpYQQ=;
        b=WCiFloLNOIhdJx5mGdc5ZAgzRkOD8zP8p5t/rLDoBFdOepgZ/JiIZtYe7ACGK/keZN
         KHpj94qDprr2FzzpgQEAo46zEq4vt7wKjQoqL6SQ0/IJB9lWyqnovtiO4muI9uj0QbAB
         JjzDKzSQ+79NRFAdnNrbXn06K73qLwSk1Ks6B6Og2eZSeZSxFc3uLjIMCe0apr7THb24
         abbq4NHe/43zDZWvglxWwF1mhldNlySM06l/jmhrzy4K+sbNATHYDFNyZ9xgA+lWDtWr
         HDa7wNIWSDXK4/wTjgB0kmDHpb6S/eRBAyzj+3SknDzDHb/LAtQ09fzRpcYuEDe7DRN7
         gyqA==
X-Gm-Message-State: AOJu0YyHf2B8kpapb98zq+InNdbbLmFRwe4/+WJxh1RXqMsYKJulCLJV
	xLukamJcA6q5T8v/C+vleQ0HPk6IP3saWo+qBWd7ccv4ZQWlc5RzEVjJxl69YJARo20=
X-Gm-Gg: Acq92OFnMml/xP44dz+8Q1OTHgb+1Fjf3Xa4GR+3x+QN9Ni7UZExkCxeJ0XrcqrMPOc
	NUAYn7OmbZSBf8FAX4QyA6MfbySNFOMP89/4lcEc7YCV+cr+Xe2fwg3rIBuLBTQ9nUcrPvBHydo
	8KlLeIujDpq3tTarF9ZRzPDDYQo0pvwTRNf18cbQAikPjmcyCY9PxnyY2SAhmFjtJBPtU/QwdFk
	4/K4J/BYxjurK7mWQ7K+FfkFcvSGbsbFwFOl/FgNncmmklQvxT0oAV85FhFKfOfN4KejSZ/KkDs
	PFd3iE1mvf10Cw5HUTBHhGlmFoeJeExdz1rbaeRn6JFz8ypv4TnMMR0mUiyoAnfh5yx4YrwHmjW
	/GpJwagQJeKJ2Ygp41x+qlMOFKSGYiK1ohGW2DQubyqtPcPhBnXKWhjikYjjWH+/eJadbFbM1VP
	I7BDwjVkTk/HgMOAcNX1fH5CW4uktTgXBFEGX3HZValTplisogEuTcIVsCqbA5cfIg
X-Received: by 2002:a05:600d:6447:20b0:490:c7dd:7cc2 with SMTP id 5b1f17b1804b1-490e561edccmr10410125e9.24.1781160482422;
        Wed, 10 Jun 2026 23:48:02 -0700 (PDT)
Received: from u94a (27-51-16-188.adsl.fetnet.net. [27.51.16.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa404fsm263800475ad.37.2026.06.10.23.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:48:01 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:47:48 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	menglong8.dong@gmail.com, eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, 
	tamird@kernel.org
Subject: Re: [PATCH stable 6.6.y v2 0/3] bpf: backport scalar not-equal
 tracking fixes
Message-ID: <aipWPPxNu_dELdd0@u94a>
References: <20260607170959.823755-1-jt26wzz@gmail.com>
 <aiaTZCQLWy-96M9O@u94a>
 <CALgi0X=aCS0kxLgqkoOXzwLh_2eNP14BvDk3TCciQP1bFpH5xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALgi0X=aCS0kxLgqkoOXzwLh_2eNP14BvDk3TCciQP1bFpH5xw@mail.gmail.com>

On Wed, Jun 10, 2026 at 11:46:18PM +0800, Zhenzhong Wu wrote:
> > More importantly, 'bpf: make the verifier tracks the "not equal" for
> > regs' does not address root cause of the issue, it merely mask the issue
> > by making the two states different enough that the two is no longer
> > equal, which works for the Rust specific case you have, but won't work
> > if the value was slightly different (e.g. "r0 == 1" followed by "r0 !=
> > 1").
> 
> Thanks for spelling this out. I now see that I did not fully
> understand the point behind your suggested bpf-next-with-d028-reverted
> check.
> 
> I was treating the not-equal refinement and the linked-scalar precision
> issue as two ways to break the same failure chain, and chose the
> d028-based path because it was smaller and easier for me to reason
> about. With the `r0 == 1` variant, it became clear to me that this only
> fixes the zero-valued branch shape from my original reproducer, while
> the underlying linked-scalar pruning issue remains.
> 
> > Could you give backporting the full "bpf: track find_equal_scalars history on
> > per-instruction level" series[3] a try? For 6.6 it should be doable, and
> > hopefully for 6.1, too, but not too sure about earlier ones. If you prefer I
> > work on it I can also give it a try later this week.
> 
> Sure, I will prepare v3 based on that series for 6.6.y, and then work
> on the 6.1.y adaptation separately.
> 
> I tried applying the series starting from 6.1.y and still hit some
> issues that need adaptation. 5.15.y and 5.10.y appear to need more
> surrounding verifier changes, so they may be harder, but I will still
> try to work through them. If I run into anything I am unsure about, I
> will raise it earlier.

Thanks. Yeah besides the requirement of having to backport 6.6 before the same
patch will be accepted in 6.1, personally I find it much eaiser to backport to
newer stable to build understanding, before moving on to older ones; hopefully
you'll should find starting with 6.6 first helps, too.

> > As for the selftest, it would need to be send separately and by itself
> > to bpf-next, and picked up there, before it can be backported to stable.
> > I suggest you look at [4] and have your test placed similarly, and
> > mention that your test specifically test a Rust/Aya pattern.
> 
> Thanks, I will send the selftest to bpf-next separately. I will also
> change the test to use the `r0 == 1` / `r0 != 1` shape, so it covers
> the broader linked-scalar pruning issue instead of only the original
> zero-valued case.

Actually I thought it is better that you keep the `r0 == 0` / `r0 != 0` shape,
the reason is that it seems to be the pattern produced by the compiler. But now
that I think about it, using that shape in bpf-next means that impossible path
will get min=1 due to the not-equal refinement, and thus precision won't matter.

In that case using the `r0 == 1` / `r0 != 1` shape is probably better indeed.

> Thanks again for the detailed explanation. I have only recently started
> digging into the verifier implementation details, so this was very helpful!
...

Happy to help!
Shung-Hsi
