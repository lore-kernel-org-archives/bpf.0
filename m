Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA538E8D0
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079495; cv=none; b=tbqWgaPEtgbYY2FSOD8ewWTlHom2ogOQXqZyxAg8iRWXclyVo+nUrq5ORFTlpJvSko2G/hQd4Hm2K7IwPnQrdoARN7JfjqNyo9n9Y+HeOm890g5fW3Yz+uk7xPyvOdv1J6g+NC/MmsXf004kjmLtKUU9qhy465VGr1E1Jc/wos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079495; c=relaxed/simple;
	bh=arOitrUvoQpyMayR+2UJvYVotUoZjBQ3eJm+3jBWIHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaqTcteoK1+40lIXEk5lImWh37c7L3lI4Pt/b/7CeKxwvFPJSfeiXZyh1UYSS+Gh/JPX1It+F/ZGhUGfUPVlvvvSMaPpfUidazXLfZNBFMyTmgxI1c+K/fD2DHvqJjXfoM0vQKbpyoh4jdtqRbhXOdhZzYdW8HYSUN3R3xfw4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cCDtYZgj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cCDtYZgj"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6913160c9ddso8696487a12.2
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781079491; x=1781684291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm9g/9CbPSE+LhxFqqPgqsgNubJjBYqhfBKaF7JWbVE=;
        b=cCDtYZgjhJ5y5Tg3C3mvlgR+Epxt8ksJAwK3rzLOcxd8JfC/ldLDynekJoRV0DJ3Jj
         QjgOD+4Cz2riIVrieLeVNNesB6wypQOAB11XZrTzAjJHEb9VLU17ln8nLsgCszZEAY33
         L5IuLAUEuvd4OD7Oh/Z9kHLX9vBGxI70ohQfE5PbQQ2CBrvtcTQfJHxGZud2LQnQ98S2
         bJ/a2RU/sGe+/j1946ecZoLEfbpo8YJ17pUTVwvV/N5vEKYd90z4gt1KOBf+KJSw7czj
         UvJqrI1u0k6vWW1cfyRmXPpc8CVDqjbNSGvolvwvg7Si4hOQwl26FW66iJb530w8TFAu
         kQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079491; x=1781684291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dm9g/9CbPSE+LhxFqqPgqsgNubJjBYqhfBKaF7JWbVE=;
        b=Ks68xvlodeyLJKZUX8tfQf3vVArftz0ecznTjXefPbnlsNmm6Zn/jkJS4pWwjH112g
         sfdtwML47MZHdOUKGEVjcbLxmUmQrvtSZ3OASrQrOUtsQxK9U7h7rb/nIl3GYfJnvfgU
         AJAa2+ix4Gh/s6Pekz+eg8TjUcyk/mx0Tj825oONwDgMIOIsSQ/5F9tfyqbtTARfKicZ
         i7SFJQBN+QVzexpwO4RsgE2Eat0WyIBfypHFDeFQfRZHdgoyq9/eW3jTymWFdlIJ7UIy
         DzHjIEkldAhpZfwkWEhI4Of5NGOGVaZqpLY2bwpQpTocym5Fu7cVne9AM1PgZjY6d9n2
         ACVw==
X-Gm-Message-State: AOJu0YyGkYaf+RZjzQNJtfWUTUVhJS+PfsVxTRG09KNxUhw/ra5Q+5+V
	omDoVYWl0eXq+dQSWKm2SFJvMDSnfPu6xKaRJXQIYPqgb/ai1DceJfKF4iDNxvDdsyc=
X-Gm-Gg: Acq92OGaiS1a20T8CummehRh6pBZER/MbIh0e5KL/TZNG07oz1p6TBXaOg9t3q8R3AA
	Gy4BGwSB0jL/O2tYgEBwlyS2iPxkxXaCJtpk8CkBOkT4oJIbH/rWtbndmjLQKWjLtRG9kxU+EwY
	yk6uM3OWczka1s6eVQg7S3S2UW3mI1cuHovW/gD3QfZCvgvE9jfEOUfLv0gCH87NHHYHkQuVEbL
	0S/uxo4mhtECLfuFSfXAiwntJPppCKaqj9h4Iq6utZ6gr5cxgmcMwaiLFSZc2iBZRBHAausOiFm
	PMWUdg6cSnCHQdPCXwX9vA6oPTLeHU5Bg86FfhHDAajlVWcNnN7K/xoiaoXpcCj8qAVdM5eYbVn
	iEEEIzzYzzQfXozXhmw1M0d/R6gDA4NftERqK8X13oyqzTM+lJ1jFKU1MAapuBV+NdvP4FGPvcE
	my4PoFyxTWj885Nrt+lEqTkCKwmSOt7DcQYuy2Si9xDFrQyBxi0Lzc7A==
X-Received: by 2002:a17:906:6a1f:b0:bf0:32ea:6240 with SMTP id a640c23a62f3a-bf373eebea6mr1418349266b.34.1781079491137;
        Wed, 10 Jun 2026 01:18:11 -0700 (PDT)
Received: from u94a (27-51-18-213.adsl.fetnet.net. [27.51.18.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37621852b31sm2010591a91.6.2026.06.10.01.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:18:10 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:18:02 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>
Subject: Re: BPF CI for Stable
Message-ID: <aikYGA9To89q3Jd2@u94a>
References: <aiJ2X7ut4lky47aV@u94a>
 <a45e6e99-fcb8-4a7b-8012-8c7e88ea7598@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a45e6e99-fcb8-4a7b-8012-8c7e88ea7598@linux.dev>

On Fri, Jun 05, 2026 at 10:12:14AM -0700, Ihor Solodrai wrote:
> On 6/5/26 12:45 AM, Shung-Hsi Yu wrote:
[...]
> >   Is it possible to get BPF CI for stable in its own repository under a
> >   GitHub organization (e.g. libbpf/stable-bpf-ci)?
> 
> Hi Shung-Hsi,
> 
> I think a better home for the BPF CI targeting stable kernels is
> kernel-patches org [1] for a couple of reasons. First, repos in the
> kernel-patches org have access to hardware - generic runners provided
> by Meta and s390x runners provided by IBM. Second reason is that this
> org hosts source of truth repos for most of BPF CI code, even though a
> big chunk of it lives in libbpf/ci.
> 
> Let me know if this makes sense, and I'll create a new repository and
> grant you write permissions there.

Make sense, let's have it in kernel-patches org.

[...]
> > Technically BPF CI for stable can also simply be merged back to
> > libbpf/libbpf
> 
> No, that's a bad idea.
> 
> >, but that felt less ideal because:
> > - kbuilder-debian container image currently doesn't work when testing
> >   stable kernels (I haven't look at reason of failure, might not be hard
> >   to fix)
> 
> Technically, it's not a hard requirement to use the container.
> It makes the build jobs a little faster and a little more reliable, but
> it was crafted for bpf-next testing, which may not be ideal for stable.
> If necessary you could develop a separate "kbuilder-stable" container, but
> it's up to you to decide whether it's needed.

Understood, I'll stick with Ubuntu 24.04.

> > - actions that tests stable kernel will be mixed with actions targeting
> >   libbpf itself 
> > - BPF CI for stable will have to contain version-specific tweaks (e.g.
> >   [4])
> 
> This is fine and expected. It is of course great to be able to reuse code,
> but practically speaking, I think in this case it may be more work to
> keep the common parts compatible with both stable and bpf-next workflows,
> than maintaining two diverged CI trees.
> 
> The rule of thumb should be this: if you can use a libbpf/ci action, do
> it. If there is something very specific to the workflow, keep it in place.
> Don't be shy copy-pasting yaml fragments that work for you, it's fine.
[...]
> > OTOH we can also try kernel-patches/bpf-like approach and have a
> > kernel-patches/stable, providing proper, fully-fledged BPF CI for stable
> > that tests incoming patchset to stable (not sure if Daniel was asking
> > about this during the session). But I find this to be much more work.
> 
> We don't have to do this work right away (or ever).
> 
> First let's set up the kernel-patches/stable (or whatever the name) with
> the implementation you already have.
> 
> We can enhance and improve it when there are cycles and willingness to do
> so in the future, 

Sounds good to me, let's go with kernel-patches/stable. Thanks!

> > The current approach of applying queued patches from stable-queue[5],
> > while comes with quite some delay between the moment patch is proposed
> > to stable mailing vs the moment said patch gets tested, seem like a
> > workable compromise.
> 
> This can be automated by the way.
> Check out linux-next sync on current BPF CI, it's straightforward [2].
> There is a job periodically syncing a branch, and the CI pipeline is
> triggered on push.

I'll looking this, thanks for the pointer.

Shung-Hsi

> [1] https://github.com/kernel-patches/
> [2] https://github.com/kernel-patches/vmtest/blob/master/.github/workflows/linux-next-sync.yml
[...]
