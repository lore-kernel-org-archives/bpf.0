Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D83876A4
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460022; cv=none; b=Mniz9/Nw312P4zOv0ZAFyr+ThjhJrSXcpL7C4oSt4ZV0YA6EHLonfOIXAaTwdgIyxhEYq9J1wKpuIAB105P4bQcYMWDSuNd0ZndAsQrfciDt6+gnqmqkJYtxIYddjs4NFoXfTG7QslV1R3K/z76oktHqM0Ma1BcbnyPjfrLccV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460022; c=relaxed/simple;
	bh=Qy1WQPyESiOhAWnLFCEN0YIk1kYz5dOKPx/yzCSBwsk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj0cvlyF01Is7gLCg6fxyLra06nyyGJ1Y64xcYABQY4iJ63TyCsuh5Hl0xzYtq0+mcNoUqOlwgpo8fnV1gTHnpv1gcYb+WzGMW+vJs+mL/5tgKfEVlsmw3TY4dlV9zu4ZzlUo50qGWX4SiCcbQoyEZl3DrpOeD05y58JyP+doyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE/3z16y; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE/3z16y"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso161335e9.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789460019; x=1790064819; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1aXv/QuntaY+V4oyEEzb+gi6VoNLvN7s/jnHI0pKvxg=;
        b=LE/3z16ye4bb6qEaIvxhAzM0BujCI01M4DOZEKUEReuWLWAOAr+AsS+flIpSZBeqpJ
         raKNYRptOv91hphQIoBpG3b5PkVAi3JuX12VR27YZJQf2IXkR/r1N83s9+nAnBaRibJ7
         yfoQ5B4v1eGIvpyF1LIdrM5RPQ9mhFKvjPICxMZvHLa5aOuyfRG5/SHm+1eM99ePUR2l
         yAObOo5dnUXF6F8n2Vw8FsCYKXSVunzanCHbk68sU3EoVa7/Ih35uTCDtxwrnKOqaWyz
         pwDcd6jDNh5+rGMdIXUH4HZDTmEWpXmHpN9vS/x+1Y7XNxuWyJXBxph9h2NlaF22RMir
         OVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789460019; x=1790064819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1aXv/QuntaY+V4oyEEzb+gi6VoNLvN7s/jnHI0pKvxg=;
        b=tlJE4kByFzBKlm2DOJMqm2WuFwJHNTHinqdJT9mWecnM7DrYSX9sMEtX4uEq2ihdyI
         D6AiQapiNQxtIejwXwzPIvKSCqW7mUtZzzBlLxPS4KNavp+fMMFYE6r74L3wiIkgxOzo
         ckJKoRCE9oEtEbgdaK7rPmt9dfbmq6VdDXwbeDXJS7hJIxXfV/CyXECWHGAjeDdRT2nX
         NBIMBzx3bFYp99ES9lsnKDhZqPwkCmLyGVqmriLeHGqdLCT4kSQJwROxBOKVqzfBXneI
         incIK0JaCbcw5EPGMKXJ6Eg5cvKGAhwYeZIdRV6+om9N/O3vZ70SlBdSOlNXeA++DXDh
         tedA==
X-Forwarded-Encrypted: i=1; AKwUvBxcLMF8GS1QkO9pUrpP758kwD742tjTc1AbcVtnhdZW2fV1Xnhyj66csy/gP204hjh53MY=@vger.kernel.org
X-Gm-Message-State: AFuF++m85lPihECuE5eV8JZUDtQIWgceFQkiq3SweJsgrXGLP3n2IK3f
	MXwIg6ifUxkcoNGQtVxdLygOzS/Qc39pGgYgUNGSADIoqzlzo7ywb5fy
X-Gm-Gg: AYBFou3oeUamlWQUXc6IK2UlLTNgTxIjrKas4HWMtZdJm796s3XMmbc/giQ21ZdsLBC
	No4v+wOa4WpTn54FGI/vIGdzlokSyG9BWgJY2Z4w9IzITPe+ccWx5f2W0a9+YVHVyPD+CN0erv1
	AQyDhN+0rIqFkcPR9kmK3pnkrzJrBGwWZ1/k75LQ6oaf4BnxW3qGA2HYU85iQsfdVlUXmPctsTb
	Nm9V9EoKTkaphEklM/uYLLpoCSbS8gS6TDgw+IZv8nPjXo4XrqxQEM+Y3zyO+1mo4eiCcg20Gf2
	okPblcrLtc9wATj4Kbx1Fdyhbiy15A+9874UH/urGzGdWK7B6EU2StfchqFd5CLNdUukG9ZMCs1
	3ZygkxfPwvck/hv8PW/QbfFlVruUkDCihU5xxjOs7FfiA/KFdJy2xpPraL9ScppO93RPlvP3lTc
	DZf7TIqwxYuaR8zLc+oK4JceBVhHst81evrROG9IkzhuhT
X-Received: by 2002:a05:600c:c173:b0:49e:799a:8951 with SMTP id 5b1f17b1804b1-49e82214b48mr1820155e9.11.1789460018923;
        Tue, 15 Sep 2026 01:13:38 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6a8d5asm47662215e9.9.2026.09.15.01.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:13:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 15 Sep 2026 10:13:36 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, ihor.solodrai@linux.dev,
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	mcgrof@kernel.org, petr.pavlu@suse.com, tj@kernel.org,
	kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
	nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org,
	yatsenko@meta.com, atenart@kernel.org, ojeda@kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 01/18] btf: Extend UAPI to support BTF
 location (inline site) info
Message-ID: <aqj-MIrooVpronCx@krava>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-2-alan.maguire@oracle.com>
 <aqRVysZxIpP5lSOT@krava>
 <eb560e37-0eb1-4f11-a9c8-866562b178ed@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb560e37-0eb1-4f11-a9c8-866562b178ed@oracle.com>

On Mon, Sep 14, 2026 at 03:29:21PM +0100, Alan Maguire wrote:
> On 11/09/2026 20:26, Jiri Olsa wrote:
> > On Tue, Sep 01, 2026 at 05: 57: 40PM +0100, Alan Maguire wrote: SNIP > + > +/* > + * BTF_KIND_LOC_PROTO specifies location prototypes; i. e. how locations relate > + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed
> > 
> > 
> > On Tue, Sep 01, 2026 at 05:57:40PM +0100, Alan Maguire wrote:
> > 
> > SNIP
> > 
> >> +
> >> +/*
> >> + * BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations relate
> >> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by a
> >> + * a vlen-specified number of __u32 BTF type ids which specify the associated
> >> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
> >> + * location.  The type should either be 0 (no location info) or point at
> >> + * a BTF_KIND_LOC_PARAM.
> >> + */
> >> +
> >> +/*
> >> + * BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
> >> + * containing location site-specific information;
> >> + *
> >> + * - function (func)
> >> + * - location prototype type id (loc_proto)
> >> + * - address offset (offset) relative to kernel base address
> >> + */
> >> +
> >> +struct btf_loc {
> >> +	__u32 func;
> >> +	__u32 loc_proto;
> >> +	__u32 offset;
> >> +};
> > 
> > would it be possible to include btf id of the immediate parent function?
> > we have use cases for tracing just inlined function called from particular
> > parent
> > 
> > I thought we could use the location offset for that, but because inline
> > functions could be nested, this seems like hard search.. also we do not
> > know the size of the inlined code, so not sure how reliable it'd be
> > 
> > I checked the dwarves code and I wonder we could instead store parent
> > function (struct inline_expansion) during dwarf decoding and use that
> > later to get parent function FUNC_ID and have:
> > 
> > 	struct btf_loc {
> > 	     __u32 func;
> > 	     __u32 parent;
> > 	     __u32 loc_proto;
> > 	     __u32 offset;
> > 	};
> > 
> > wdyt? thanks,
> 
> hi Jiri,
> 
> So in the case of encoding the immediate parent it is quite expensive -
> my concern is that adding it as an extra field is another 4 bytes per BTF
> location, and because there are a lot of inline sites that would mean
> somewhere in the region of 4 * 500000 = 2Mb extra. This is the tricky part
> with this stuff; even small per-site tweaks really add up.

ugh right..

> 
> Is the immediacy of the parent-child relationship a dealbreaker for your
> use-case? As you say the offset can tell us the function B was inlined

it's one of the use cases, but it's still useful without this

> within the bounds of uninlined function A, but it won't tell us if it was
> via function C. The other thing that complicates this is that an inlining
> doesn't always have a size; it can be inlined in a non-contiguous manner.
> So in some ways maybe the best we can do anyway is to be able to say a
> function was inlined in a particular uninlined function?

I guess we could get that info from dwarf, it'd just be simpler 
having that in BTF

thanks,
jirka
