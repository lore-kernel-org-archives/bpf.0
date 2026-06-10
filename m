Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E843FC5CB
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089677; cv=none; b=I7Qr+VZ4WI9i/Eq4vjp7/nHH0emYDQ26zAPZ86QUunfu23r7JSKisL8UPlryVOkAw+VwQLPSzKk8LLZkRzFGqDsQ13ZRUbp7+awIqKEItGI4l9fX0AEl089J0Tp6Tvk1y4PJMkWecJZNHKOgkktEM5Fft79XP8GVFrvnvz6nNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089677; c=relaxed/simple;
	bh=YU92ggE9mgKnVwD7wcdTzwb9dfGSdahNfsH03uMMwvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ0+ixU6rYuvincGwxichiqcI/dJMUcmTu+2+Owefbnbu1x0e9Mt35gX7/AzS0ypIMCFpIgV6SAnlWZw6gmgYydm2g5MCWtDbn4OJH+7n7pu/3tjReLlUIEuhTpjOPdtF9DImvkFnia/kgRb22vwCVRA+Xt8Yg7ZraOhU9cCGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Urpy9hJP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Urpy9hJP"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso51923975e9.0
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781089666; x=1781694466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2xFKemTcNqDKWbMAco7gWqN5DRX//N3aPore6Oyn3c=;
        b=Urpy9hJPX8dCBKSgI8PGcBpgbUgv/kcLWj1e+8jToL9nxKAxtbM1dWMSclT4NOikkX
         llGkgM2l2tnin6nNuUyNdL5vZpUj6d5IvFHrUyAdccKKYRvHesP5u3umefrZlZhiE11/
         vtWfukwrY/AYfb2HUDUVrEMwZhmHbeddsaVd+a2e2HArZBZN+zRboVJG+VXMvLybxf6l
         4QEdWTOzpn+cYD1Ygb0VGHYkNaZwAw1xFT0XI2bYY49qGBue3q+Ro57dWyLf0sUaA3yT
         lbzlHgDJ0qoiZadcEslNScNidJEU0MY0znBh50jKbUFOVw+Z4z+LhLgXYHF/StXqTR9X
         tTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089666; x=1781694466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2xFKemTcNqDKWbMAco7gWqN5DRX//N3aPore6Oyn3c=;
        b=oc/+8n9yOeERvr2x/bfIL/URwAdIvf7TdsqUCgKfD2d+pSN0tpRX9Q54Ie2mVOTtIJ
         gi1XlUB6TLoR3vKuz7GVyrOfIkofZ0zLvefGgpJFfiC58vO3uwyhuMrVL8sG8NSGjzmJ
         /aJq9E1PUl1hr4yaBnwNQBftqgPnLTX5dNCBq+jBZHSakmoICTyLuOC7Gnq2cBRuLVcu
         V+UWHhoddmfeO+NzPw7WKOkCN1raf5WaXmj0qvB5qqkTWQezSsBmRz7mrpQ/4e3y36Ji
         xxXGXOzD0h27qPAYvT5/1eT4+SuNzvZQxepGMBzmajQzEIFKwYt/Ut8KvRS7qoiqsoum
         T3Zw==
X-Forwarded-Encrypted: i=1; AFNElJ+16v93m83OdQl+nh6u1iVHsVYsysPTIVo1ScA1BV19/djjqlbGIcx8ShMAVijXI+wZCg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0JELrPOUQndWU1BkFmEoih+1h2L6Y8Yq7Bi0VAzlyXRzvA9tk
	4BRklA3Y1baP17emNo9BMucR6yPtahDZW/urM760o6B/5hscqKoqMF9eCvjGnZpIkbg=
X-Gm-Gg: Acq92OE6QG7Ji+d5954G+lSh+kIoc+7vnOjoGK3U0XtXOFie7bnzYVbpGMApviqx6JV
	X60YqntXhC4BEqSb8lu/3Ufn664b2mjYiGMt//T1ruRQn9sBKa1+kx3JhnJMlpStABRNd1HkhMv
	Yr955S4HrdeUURFjf5awZPR9R/Ir1Z5IKaaqQlAxTlWzdEzNy7c7wd1PhHzm+yFqa102vuIG117
	g+VaRBI3xqzfRGNDRw/n1VuSOlomKKdnPGaaF5T+sEPzRim7qvYpC5/HIRvmJLqrleWqC87Zj6J
	DpKoSs9DBOE4viQPMIjFmn+buzwjj5yOHekH3UHkV/rAAXhjafgoGASLBLRnmY51qfMIfFtGVi/
	76cukmL7BvxewbN2vwiX1S4zbqNO9LG14LR75jwIm37TbIzSuwel8AMhQHrhBGPsYasupZumFeX
	E3InCGMKqr1T/bWqYuFSY3Y8gRFADkegzvPcwl/+7/YPfbuHarXfF1EOrpKUHUNMif
X-Received: by 2002:a05:600c:c3ce:20b0:490:bf3d:c7de with SMTP id 5b1f17b1804b1-490c2d08eddmr224460995e9.10.1781089665637;
        Wed, 10 Jun 2026 04:07:45 -0700 (PDT)
Received: from u94a (27-51-18-213.adsl.fetnet.net. [27.51.18.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c245dd3b5dsm117117925ad.81.2026.06.10.04.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:07:44 -0700 (PDT)
Date: Wed, 10 Jun 2026 19:07:38 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, zhuyifei@google.com
Subject: Re: [PATCH bpf 0/2] bpf: fork state when comparing sign crossing
 ranges with zero
Message-ID: <ailAgHo123u37P-P@u94a>
References: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
 <14c9e9e95a07b6de94a142394c69b81d6587998b.camel@gmail.com>
 <5c8e69ea-df49-4604-8431-56e1b478402c@linux.dev>
 <DIVKCTZ3SFXS.X30XCLLTRMQS@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIVKCTZ3SFXS.X30XCLLTRMQS@etsalapatis.com>

On Fri, May 29, 2026 at 07:53:08PM -0400, Emil Tsalapatis wrote:
> On Fri May 29, 2026 at 7:02 PM EDT, Ihor Solodrai wrote:
> > On 5/29/26 3:44 PM, Eduard Zingerman wrote:
> >> On Fri, 2026-05-29 at 01:13 -0700, Eduard Zingerman wrote:
[...]
> > Hi everyone,
> >
> > Apparently libarena_asan tests are currently skipped on BPF CI,
> > because they require clang 22 [1], which is not yet enabled there.
> >
> > I'll work on adding clang 22 to CI, but in the meanwhile please make
> > sure to test libarena locally with clang 22 if your changes are relevant.
> >
> > [1] https://lore.kernel.org/bpf/20260426190338.4615-6-emil@etsalapatis.com/
> 
> We actually need Clang HEAD since that's the release with address
> space-specific support, is it possible to add it to the CI instead of
> 22? Alternatively we would have to wait for the Clang 23 RC in July.

Theorecially possible, the LLVM infrastructre at apt.llvm.org does
provide LLVM 23 snapshots (e.g. [1]), the problem awhile back was that
the infrasture had issues[2,3] so can't be used to install anything
newer than 21.

Just check again, and [2] seem to have been resolved[4]. While the
problem with installation script[3] thats left could probably be worked
around by adding the apt repositories directly.

1: https://apt.llvm.org/unstable/pool/main/l/llvm-toolchain-snapshot/
2: https://github.com/libbpf/ci/commit/af3742c19566425bf8fa3bd8425ea65917c55401
3: https://github.com/llvm/llvm-project/issues/180163
4: https://github.com/llvm/llvm-project/issues/179148#issuecomment-3963668474
