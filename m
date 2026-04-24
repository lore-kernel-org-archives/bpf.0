Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3893DBD70
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040366; cv=none; b=t5ONEEm6FJZEDEfoTlwNt1qHbAz/9n9IzBy0EZfuu2+yk7xlWphpyIIXtuJUq54b/co6d55qFwNUf50uoJi8Br/L+R++KRM4O3uVP1K77aIeLswVSi3jJp4snfkphwcwzIPbED8zpadmEvZIUelQT6VMDc4Y7ZoAaRe54NQtchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040366; c=relaxed/simple;
	bh=sR29cvVWWj1zEvLPCnOluGKLlUo6GPJZv7ipVNXVONw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gopqhzNz1mtsFMJrBZ38wvtrihPJvVwy7I3L4p0CDsL0mEy/Dv3ULsnzHZOiHyQ9PNpHQMbx2Pre49jiTu1QK9DeO2IFA1jedhPNPftVhEQAfu92GzcCiWuuYcnmhctRyVdaRIcLJ3PzsmIK86rZxLfDNIzc30NwsyPPG6Zpb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=igpKv7ta; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="igpKv7ta"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6055a0414d7so1998095137.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777040364; x=1777645164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zV0Gq4Db+XurRwmLehRl8plU7HsCQBBchm2UxZdn8eA=;
        b=igpKv7tavJsOoMZy48+l67X+sKqw4fGrLFlfTwBT8xEv50hjj/UwxHNUnf6A7XM62x
         6SO9kz0XzK1vDDn1Fw1/WKyMSl4z+tC1/eqSsCRIpe2RiqDq2/uHMMKjUOH7fnKEYoV6
         m4GWv5P5pMeL4gPkHQV4216zlJVaxS4kVcC3kwsVW/FfqTCKIaVt8hiEaaf9iO4v0gdB
         YeTTXCdYGuPMDVBEYlVxdNnSGim+WPSH2z22x/JCLWF1KqQHsC2FqQnEEao6vrYN1GCO
         +UtOJC3nva1hzI0OMrjCuvSu0Q9pxqVbXYH4JVx7vv1Ysw6H7gkDMjw7KhsYQ+vfetw1
         spWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777040364; x=1777645164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zV0Gq4Db+XurRwmLehRl8plU7HsCQBBchm2UxZdn8eA=;
        b=sqV4heg1277z3XnSq3JCAsAE3g88oXtwZZGV8OpAqTeMZCUHL5nNl/X1oveg6q/yo8
         h9IdgFN+TiWMhS3cndDZRvnA3ndt/beCNwLtS2sDrtxgkBTaEOvU4nbK/KFxG664BJ9/
         HdoPRwQSqYBzsIyOirn6ZnV5DkQbNFZfwVLm91SQmUuoET3YuIKGoTWdiq9lCiXX0FLh
         Phm/ZbcUUv8OaDHZv/gPujzQCe6hy+i04g3Y2A4oixbVXzGJyLLBMlSMbiRDuNs96QhV
         uLa1rN/GFCE0+UF/ioUQABkMOG3rWjw9NLwLFwJWgs0+ceKAO1ZXjQfRhu7BTjhKTK2e
         ihMA==
X-Forwarded-Encrypted: i=1; AFNElJ9T8W0IN69fALcKGqVV/cgO8Jw2c20iz0i7euRiwY9f8yUdo05ykBP5r6PuG62KkwJb/ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNYzXaFiGvovVBrNgCaFSseSENFvwm6KZgUSM95c754uGXZOh
	9JYc8E2vwUqvs89Nn2uIGQbCgnai2uRQj5jYGT2Pm3/zMJC8fYwgQ8y+ILojR640iwc=
X-Gm-Gg: AeBDietkm+a/snpi0HA9UnVtSv4LtPAqBDHE97WgG1Fh0Co796HhltPXi5i6RuQuLU/
	/mV/WhDc7DE7/vOIiO2UnMnSDOkKsllJQv3zVxdvjrRCoJePhxHwQLUtdV+ynfc/0ydzIxyYWjO
	VIr9wWiIfs66Tc8UAuJ/L1w025kc0JzovVrBa2Wt9LjJ0ibGmP4M+WswTJrtE9WBdrpEYKnGkhr
	/bbl+o6z5/LLYR780LmgF/Q/URl0Czu25neu+Yct2y1Hdtt0oohfY/INyyKc8ygYJUSFxl4l2ik
	F+B/NVX5CEFJhA40ThoUF49DB86UfL63F/8pbl2LYAdtx4DCLdWgVS0xH1ZVze+7LQyh8QV56Oo
	hfwAoU1xI70LKjDgjpYrV7GA2sMHIVhPuJ7kFzgz4/BsNyvhijqLsewvG8KN1f3lIHj9DQqhw1B
	/eezA/1XBcYjQez6hf27JHGw67n2SiO2cZFEjXHHf8UBfOajWXiX0HNy+PliL7uZge/YHLvTfwY
	y6kJhCMGDJXLaXq
X-Received: by 2002:a05:6102:6cd:b0:602:6784:3eef with SMTP id ada2fe7eead31-616f90e6f07mr16856701137.28.1777040363554;
        Fri, 24 Apr 2026 07:19:23 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac81a9dsm186723106d6.21.2026.04.24.07.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:19:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGHNK-00000002j9p-04Ph;
	Fri, 24 Apr 2026 11:19:22 -0300
Date: Fri, 24 Apr 2026 11:19:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260424141921.GA3611611@ziepe.ca>
References: <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <20260423140950.GE172828@unreal>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423140950.GE172828@unreal>

On Thu, Apr 23, 2026 at 05:09:50PM +0300, Leon Romanovsky wrote:

> > > Leon mentioned that different firmware revisions would have different
> > > parameters for a given opcode, and that one would need to inspect
> > > those parameters to properly filter the command.  Is that not true, or
> > > am I misreading or misunderstanding Leon's comments?
> > 
> > They are ABI stable, so there will be rules about future changes that
> > old software can follow to ignore or reject future things it doesn't
> > understand.
> 
> It is wishful thinking and applicable only to mlx5 devices. No one
> promises that other devices follow same ABI rules.

Well, I will definately kick them out of fwctl if they don't.

Jason
