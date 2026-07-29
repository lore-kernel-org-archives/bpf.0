Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930425B0B9
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306610; cv=none; b=nwui+QnppDJxJP2qx9vp4HGvGnaxHFAXRftmNENvrlFSl11I/WB/5FLNbklZQdnZv+CufVVSMqX1cyDZwHsnc+nHpwxx4UWUQStMw3WG2D5MB84nPFCMCL7/4wJ3MpZqYUOeV8luMpwepiUbkcDp8q1zfSWDe63CTEjcCApJzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306610; c=relaxed/simple;
	bh=14l0K5+rjPfi76RaZM0/4b9a4gOoD5IXg3XYBWE9p00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJVTubGN12IOXB5pMgECtXjqgNVTwuglNgo4Ai46dclcYAW6Wo5oksz0R3RQXyy5jdxJFc/T24L/dXX2aoeGawt/WiaQnika+KYqeC64wm8YFe19LBkD1xZuHQlDGml/83mHK/8PuvLE8M8P6PIpaX3qt+frnYgr6iE1KOawPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J9s6Nsc5; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J9s6Nsc5"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15be76348eso27257566b.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 23:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785306607; x=1785911407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WcYq9jnWmzzj4qks+dqv6sujNo+aNnu+0n4wQ965fu0=;
        b=J9s6Nsc5b6K/cPEstvbXeTaPClUSB90qbufYokabmtnDppsCCCJniFEd92PBkZFfsh
         UeCNupl2kE9aTT0B6+kommw7MNAaK6T56UdMn9jHUQtXnVWWpcW0FiVIKjr59sxFrizZ
         J/YS67YLbg3WL1V04VFuevtQpJ7PoZMvhbwZOw4Vabxcn9aIBkxlV96AgHyymLZl89XA
         Pk7J8c+qup6MFzXQ9A6JxacWcomLwSpKDHKwkJE2SuGa1//V5oiV53Lb1msccdIg3l2K
         jWqtO5HHdiWCS1ycc01CkBxEVIvoQKIzH655S6RQOhb9gIG9M5V8LPgd92IuAPATqvlY
         XMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785306607; x=1785911407;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcYq9jnWmzzj4qks+dqv6sujNo+aNnu+0n4wQ965fu0=;
        b=pNMDP3sZ70Tm0yl1KQ5Dl/sYS1xENWDnfJNjmKa0qI7iDbsXAhvegwDqzmgynjgnZP
         j6ASbFFfLHHA6LVOE5gRvxEZsg6sql3SK8JXqXPRScku7KePEQpb7/3oQRfKAJXwUmD3
         LSl1qWXZdum7eIA6PidvJ09SCYyHWYpcX2Q1ybQFV4etHfhKnIJUVlecATorHail3cSH
         Gmjm1nCDeMT4bmuJdJLaMzGhYSjns9vXhI/Hzq62jmUNr1Ew4uSJP4s44Z0AFvulhquO
         ksdirimLB7mROmC6j6kfLi99hvNnyPU/pbpeIXOXSrrFEsD91mYJZUaQhVZsupwpfO2P
         iKrQ==
X-Gm-Message-State: AOJu0YwVYy+7rF92lZs26Rrgdle2z8S9HxqVTSrhJ88AJ7uxA67aU9bO
	D4wq3Nm/MfI3nRE7tMt1oFlL0cDYjBYvg0O3EXE6WSf/K9k7XL0N70Zt6J4Mj5XGtfU=
X-Gm-Gg: AR+sD13If5nLcn10wsFgVpm0b3zkGPD2cYcTF1yXdN6k0DxvLC1ThDeXZEXMxK+ONiq
	ucYRFlWG9iJd8sgh/qhie5YHe4jI6/QamiitXW9Gl+Lih0K5BAt0ci1glADPQ5nv++BobNL3b6P
	jxlhxdQ2+h57xnpNrFhYzJO1zCUTOVK8x8uXdxScs5STG9lk0B89MTDgyAkwE6Qx5py04kWp3li
	3V+GFtQASP1X0Y5yRP5VaF2HyeOl+tlwlwd715/M4CAhU8LUdtbVAxS0sxWz1W3L2Bp5qsZ3gk+
	15SULEx65vmed3XNUeWvNUC0zJVzrJNf3ujNmDnkvLUsaM8jVgIjQcodk6yXfei7L7TbXN4Tb4F
	0EVNWP9kXLZEPXvnD8WMittFCGSfxS+sSkOn7Y7rt0W9RbXKfiHibSLFqyqJ4J/RXPML5N8el+g
	8l/9G9SjwzH4AJqiw2gz1kl4cqJY5NCss2ryysV03ZKSPE35gExZYjOjVHXD9azngox7wC5QNqR
	HHtKvdPl2VzmHUJfBY=
X-Received: by 2002:a05:6938:a086:20b0:c1f:7e26:5b94 with SMTP id a640c23a62f3a-c1f7e266377mr135941966b.30.1785306606805;
        Tue, 28 Jul 2026 23:30:06 -0700 (PDT)
Received: from u94a (27-53-97-170.adsl.fetnet.net. [27.53.97.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f0edc1csm853207a91.3.2026.07.28.23.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 23:30:05 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:29:53 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Vinicius Sampaio <vldsampaio@pm.me>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, 
	shenghaoyuan0928@163.com
Subject: Re: [PATCH bpf-next 1/2] bpf: Simplify cnum contains() and
 normalize() implementation
Message-ID: <ammWxQ-PiJ-Z0z67@u94a>
References: <20260728015601.1567098-1-vldsampaio@pm.me>
 <20260728015601.1567098-2-vldsampaio@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728015601.1567098-2-vldsampaio@pm.me>

On Tue, Jul 28, 2026 at 01:56:58AM +0000, Vinicius Sampaio wrote:
> This patch introduces two optimizations one for the normalize() function
> and other for the contains() function.

Nit: is there a reason these two optimizations need to land as a single
commit?

> In normalize(), there's no need to compare cnum.base with ST_MAX,
> because any cnum with size == UT_MAX represents the full unsigned domain
> independently of base, so normalize() can canonicalize all such values
> to base 0.
> 
> In contains(), bearing in mind that a non-empty cnum represents a
> inclusive circular range in the corresponding unsigned integer domain,
> membership could be tested by checking whether the distance from the
> range base to the queried value is within the range size.
> 
> This makes the explicit wrapping and non-wrapping cases in contains()
> unnecessary, since:
> 
>         v - cnum.base <= cnum.size
> 
> is equivalent for both ordinary ranges and ranges that cross the
> unsigned wrap boundary.
[...]
> @@ -181,7 +181,7 @@ void FN(intersect_with_srange)(struct cnum_t *dst, st min, st max)
>  
>  static inline struct cnum_t FN(normalize)(struct cnum_t cnum)
>  {
> -	if (cnum.size == UT_MAX && cnum.base != 0 && cnum.base != (ut)ST_MAX)
> +	if (cnum.size == UT_MAX && cnum.base != 0)
>  		cnum.base = 0;

Seems right, or at least I could see what semantic `base == ST_MAX` is
encoding. And normalize does not deal with the empty semantic anyway[1].
Could we go even further and also drop the `cnum.base != 0`, just
relying on the `cnum.size == UT_MAX` guard solely?

>  	return cnum;
>  }
> @@ -210,12 +210,7 @@ bool FN(is_empty)(struct cnum_t cnum)
>  
>  bool FN(contains)(struct cnum_t cnum, ut v)
>  {
> -	if (FN(is_empty)(cnum))
> -		return false;
> -	if (FN(urange_overflow)(cnum))
> -		return v >= cnum.base || v <= (ut)cnum.base + cnum.size;
> -	else
> -		return v >= cnum.base && v <= (ut)cnum.base + cnum.size;
> +	return !FN(is_empty)(cnum) && v - cnum.base <= cnum.size;
>  }

Make sense, with `v - cnum.base` we are pivoting to a cnum where

  { .base = 0, .size = cnum.size }

If `v - cnum.base` is within the pivoted cnum, then `v` should be in the
original cnum as well.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://lore.kernel.org/bpf/7a5c9c3e8ef2cb86b7ae38fb4593e7337e9962c0.camel@gmail.com/
