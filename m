Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145B2D46A1
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903803; cv=none; b=LT/2nVKNfV4e6e7Fh0Ow2SQhg8WQA6RVrs1EGiaXx0NPwefDvSX4A/r2hlzQfPULN0W9KlOHVO/uSlh4EQkWW6zC9leVNLsO5m6cwBfhsCJ/zlMZEE7/MxfmP8R8/hHE2KSt6Ka10dm7zWpjfIYehSrRRed9vdgGiTtzmaUaTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903803; c=relaxed/simple;
	bh=Y5R3aP9kAVCdTdn6XC2JbDbaR6UIDegxxHsQJsIPjtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4l2/jQ9defTYBMU2jJypgrfwy7zURNC6XeGAu01y7d9Etfu9a0hGoiIh1Zu9NPyRheXY27SFEhP+Gqmiu4f9Fhw8SHwBYzDvkoe/r+DB22gf0hmVPeReVFZB4BXdIezNUJQ92D5p6y1XaoYtSRy/yBrXk/NvlBj6U/1tfkVQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YjtRt/g1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YjtRt/g1"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b97ed4ad579so95655066b.3
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 00:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773903801; x=1774508601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asqVUVrkKsvwpjPuxD8dnEos+4P3Vr0D7SOwZp53oCQ=;
        b=YjtRt/g14WkPFCUdeTFXfx7+ypTBkh5zGlOZn67qkU8sppbk381sM0/2vqPUuu0228
         kyYVm7MFZAwK6JoIauVt7xfFjOkrztmW4YnvezAwQ7ej8VFc0kQZiOxcHQZXWD9kRJ2j
         M7fwG+19P4ojHJh4RYJezBb+AdkETqL9QmJLpGr8yEj5iYscy08VGq6DQOI2OfC+3w+F
         ys7Xhex860R4HGmLNH1nJbaOl9xoD8Dkd7PjhmAS/m557pyTy6o0ASad2+6Q8yvnsNNd
         YHnYW//RObZRgVUy3IpC7VkgtvHuR2JMbwhpQBX4Go9t1PG5rEl3yiP2h1G4n+o8dX/s
         w1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773903801; x=1774508601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asqVUVrkKsvwpjPuxD8dnEos+4P3Vr0D7SOwZp53oCQ=;
        b=UWZP6Cj3mSxh2hu2zVBhEqHJK6+85QWkMdWYSqFJu7V07pVfFJEGbj791oYMlrvzRF
         IQs1YTelufsCdCIyzvs1qFGgNCfF7jROobYOKNqK9Gk/e6Oa3LUl0Cs7ZHi9gSZr/fN5
         Lul7pgAdp2o7mwQpMAwwyhbV/0xmtq73zYHnf5gq/NLTrQ/L5N15kDpkcjupVebT7ghY
         tWJUdHI9IctCzWlRCNxTBdI/qyYeCpyG0DN0hJIFIWIvfYyhItZ7hVJeRRNFNonnYifI
         LTxHeSD4012upCYCO4N8m3/nifCzLKSigXXXIkdWQd0BkdwkZocl3PcCCIlk9Qy6WgPm
         6BEw==
X-Forwarded-Encrypted: i=1; AJvYcCXPqU4fWDiT5u6WMgiLkJ5ND5ztJv4Z9Oq/Hz76w4R1eDUpYCgYvTBvacGhKoobJYKRQso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhzUkjbIcOJ2k1YKCwB/fCSS2itXmAxsqnKrqcD5YpkbkZmG7
	MUai0X2UcFH9LQ0wKS0IHASgHiH+M9sRjXUROZ+vlxOPUqJmVd+udZK230macRv5+Kk=
X-Gm-Gg: ATEYQzxoTaQQTRByCeA9UlGEOW42wRnuHHo6OMT2aoYqSomDQaBv2mWs+h1GQ9P5GRr
	/Ev4KUQFl7aBoxiTSx03QRigpWrOavX0b/yRG1zGs5kabr+sYhhMtMaDtPx3/3GUMV2Ez4YDFCS
	O57J7XcaIlzQYoRTtuXtiOB9mwgMd3NE3geU7RDXM/B5m5VVQ0B8UxTuGQOYWfIY5WthHhAzzdG
	xPOVFVwF3SNqiLwhY6y1hoPnfRds1L9kDxY4iU0wpFnDCvGpTZrFUcRffNox89oUac6gK+azqh8
	S+0Il//qjG+PU497cseWYH2ey0bOCRFQguRRsEEmc5A8kNAxsOVwsYiKrNeZbWBr2QgDDtqCqGC
	Qb5/W/jwUJurMlrdqCUISmZWsihCPdJTADkIG6wp61gt4vbqxUoo6G2PTSWMZZH9CxcpfJDwF6m
	O1jRnhiEj81NcabI3x2Q==
X-Received: by 2002:a17:907:c1f:b0:b97:b566:f15f with SMTP id a640c23a62f3a-b97f4a5decdmr368847066b.38.1773903800503;
        Thu, 19 Mar 2026 00:03:20 -0700 (PDT)
Received: from u94a ([2401:e180:8dfc:66a:a219:10d5:f609:370a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc60ebdcasm1777307a91.9.2026.03.19.00.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 00:03:19 -0700 (PDT)
Date: Thu, 19 Mar 2026 15:03:07 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, emil@etsalapatis.com, arighi@nvidia.com
Subject: Re: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <vnpbticzhrf4ke7xo6dklqipfstg5p62ccouurkxb66maotip2@3aexbucdvrr7>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
 <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
 <aaocJ3gJr7019urU@Tunnel>
 <fd6a7d7fc0eee70b0b3053b1db34e9e986b2a067.camel@gmail.com>
 <aaoevIcblUpMyN3U@Tunnel>
 <bnw5mn5vwgezvhvzotrqcxfq5xixczjgzc2gj42565vnod5aai@rbwkdbuz5t3d>
 <abl1V9B56HSCKh3H@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abl1V9B56HSCKh3H@mail.gmail.com>

On Tue, Mar 17, 2026 at 04:37:59PM +0100, Paul Chaignon wrote:
> On Thu, Mar 12, 2026 at 02:45:47PM +0800, Shung-Hsi Yu wrote:
> > On Fri, Mar 06, 2026 at 01:24:28AM +0100, Paul Chaignon wrote:
> > > On Thu, Mar 05, 2026 at 04:18:42PM -0800, Eduard Zingerman wrote:
> > > > On Fri, 2026-03-06 at 01:13 +0100, Paul Chaignon wrote:
> > > > > On Thu, Mar 05, 2026 at 11:48:22AM -0800, Eduard Zingerman wrote:
> > > 
> > > [...]
> > > 
> > > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > > > index 0322f817d07be5d003c17dd7cedfa3aa4197678e..04938d0d431b38e086b50fe28b99e4ad2682742e 100644
> > > > > > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > > > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > > > @@ -422,15 +422,69 @@ static bool is_valid_range(enum num_t t, struct range x)
> > > 
> > > [...]
> > > 
> > > > > Don't we usually put changes to this file in a separate commit, as for
> > > > > test changes in general?
> > > > 
> > > > W/o this change the reg_bounds.c tests would fail.
> > > > So far we tried to keep selftests passing for every commit,
> > > > to help with any potential bisecting.
> > 
> > Similarly we have stable AUTOSEL tends to just pick up kernel/bpf/
> > changes and not the selftests ones. e.g. both 76e954155b45 ("bpf:
> > Introduce tnum_step to step through tnum's members") and efc11a667878
> > ("bpf: Improve bounds when tnum has a single possible value") got picked
> > for 6.18.17-rc1, but not 024cea2d647e "selftests/bpf: Avoid
> > simplification of crafted bounds test".
> 
> I can send the selftest backports to the stable ml (unless you already
> are on it?)

Requested in https://lore.kernel.org/all/xbjybmha7fdnnm5gn6p6jyppf4ud2r72rfabvej6egg545ozsu@a4qj43d3iu36/

We should be good now.

> Do you know if there's anything I could have done differently to have
> the selftests picked up? ...

In this specific case above it would to be have the selftest change
along with the kernel/bpf/verifier.c changes, all in one commit, like
Eduard has reasoned.

> Or maybe something we could change in AUTOSEL?

We can argue that the selftest was dependency that should go together,
and that AUTOSEL should pick it up, but IIRC it is design to only pick
up dependencies that comes before a commit. OTOH it would be nice to
have it try picking up selftests in the same series whenever it picks a
commit from there, but that sounds like a bigger ask.

...
