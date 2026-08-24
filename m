Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883E40910F
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579734; cv=none; b=CyTjx21TQtFvsUWlvLv77SybWMTf+7DAXXHhGZ2onvjxeJ3suy62O2tARX080Lrnso/lHYvUxWQ8kuQt5dhkO5lM39+P/KMt3Cevg4dy3jvKWxEGVHOyym4zro8g7R0OXGXdTazVGyb169CGRTQGeF2qxN+lMFrUqJnOHkQDCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579734; c=relaxed/simple;
	bh=AtV5dw9gRgzyoEMLu4aQ6z8qH/ZAjeT6K0W7X0N0QpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9aQ7wOZBmvrhDzBOfXnV/BHWD3uPXTZ6GEJ3Dd/PRF3gSM28IO3MKWG3DAv6eaeUfp4lj0o8i1IztUl1om5XOfZh56SNvLPkYarKL4VGTQ+iIr7MJP8ZVtKDIkU2uUFVSDAmeOhcgOMBbX1mpxr6trX/6x8sU0UqppyGlPMKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gk3oVLNd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gk3oVLNd"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so4900322a12.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787579731; x=1788184531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CTafZFi/HQ0yZlxsyK+vRPH1tJjqwxxSL7Z2p9md19o=;
        b=Gk3oVLNdg9sPcTeTPaOI0tht4nhck5axKM1DeQuNL18EmW+J9jhndSWdbFo0PGlkkg
         sTfPPD5nlme/H2W2dlyQqR3edVGFS29nLk3jHeeFL0tKTjMCIzEXQ4AasvHZfnjVxygK
         UCYJDzs7ppk+Xdkr6ct+TieArEpSPlIUoPGY5AtYkGpO+IukTB7NS8yUxopFjB4rBZ4L
         kichaxb4K9dOsE7qLVtGaHNEmlm7dRY2XOQJgaDl8Pr8ItEoUHlkSTbIXl+9FrXl+wAc
         1HWwoFQ2K3Dmfcyn1m/6yTrJMNpGsSLyr5g5MMG10X0bTzCkOOiejNCHl2JIBcfrdCAZ
         kPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579731; x=1788184531;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTafZFi/HQ0yZlxsyK+vRPH1tJjqwxxSL7Z2p9md19o=;
        b=ewbpn3bUY9u0I4LDMMw0g11lToabpjqV7jN/w5tKyl/4y6FFWLHoucvDBvJgZ5nTxg
         rsUvTCwprg1KWoJT8aEdXXC38DIbeznMZMvMKTL2CqfyQQXKtbNvrgQcKjD3Po2URXr8
         dvDm6lm20kksg+TzHRb0/2CTBFGTA3M7ECDJ6JIFStGmrOVNXZzbx2wFwRbDmodR3IPf
         gCE2KqwQJohE+L21k7a53mx7SYGGHSuKxCaLmevrfq5S4RYwVkmAye/u9j1N2YTZGepM
         Hm6QYPcp/6h3o+SPGTsBEVn7ARbeyTs4tGwc9MYivp+7a7KhgIigxtA0lz06crcnr4Nx
         3H8A==
X-Forwarded-Encrypted: i=1; AHgh+Ro/Lir3OfyuhXUdd2KhHopZ2LN1heinht9UkQ7d43xlr/GQj/pKcegZxrQE8UeiafGYi6c=@vger.kernel.org
X-Gm-Message-State: AFuF++kDSXY88yMg6552PgGnNl0oToz0HKrXJAG68LzJOYJYUwkrjdj5
	ngDLg9sd5/F7hE7QP7g+ourLSXQ1KCPXs0spddqvFgH5r8f0LUqb+bwDAUe9V/HVOAY=
X-Gm-Gg: AR+sD11S54miQs7SmiVchJH/RPKB5cm34il794yQf3OQ1LxzlFWL3OirKaksR4f1hdD
	DiSGO7Mz4oYiTfCkdo/aFXS1F+ygVtmB7cNox7w2gec7icXzA9jqs7Y1EYq+cfJBtgErlZi+B23
	JQZRI3aSiv1wBwLYJAuDsBNdmdgkC7kQx8RL3NGd8c9PlYamGs4vZKiAMgHOZNnnZcP5UjIjBFR
	fCJQzOZadsRNa28XuMGfCi4vXM86h06XAIbuSndYyfmZWkSG//y6IWZx4saXhMDxRwDGZpJoO20
	ojCwnRmponH6vgYLGreMiV7aQ4VL1o7YVRzmvCf4wrYjnMYTs9i08bvFRqvsLIS8Xk6afz/VRbG
	50+tZkB1mpLJK7UyO2L0DLwjM1fdVqKLdXVFMAGu2ANiiGbEhWUCvBDmlcRtVVFlSvHBtMduNLz
	snrh2mbCsgoxdY7J6iLjQ+zWbqDGnUTQBUn9HtitVHFqlqly8BjtoQRb8G2Yd0vEcJVXzxY4ha6
	g==
X-Received: by 2002:a05:6402:a5c3:20b0:6a4:e8e:9e26 with SMTP id 4fb4d7f45d1cf-6a42f1e08cdmr21176932a12.10.1787579731218;
        Mon, 24 Aug 2026 06:55:31 -0700 (PDT)
Received: from localhost (109-81-81-112.rct.o2.cz. [109.81.81.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199ad5sm8980194a12.18.2026.08.24.06.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:55:28 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:55:25 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add a sleepable page allocator for
 map memory
Message-ID: <aoxNTXWCCndiuewO@tiehlicka>
References: <20260821050250.35112-1-jiayuan.chen@linux.dev>
 <20260821050631.39784-1-jiayuan.chen@linux.dev>
 <aow4YNCDa0gDwbfj@tiehlicka>
 <de12ff1b-2f7c-4efe-ba1f-95e0b8d259f2@linux.dev>
 <aoxAo6gDK00PeCzG@tiehlicka>
 <DKX77B18XF28.LG3DX8NUFQGI@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKX77B18XF28.LG3DX8NUFQGI@gmail.com>

On Mon 24-08-26 15:11:57, Kumar Kartikeya Dwivedi wrote:
> On Mon Aug 24, 2026 at 3:01 PM CEST, Michal Hocko wrote:
> > On Mon 24-08-26 20:44:18, Jiayuan Chen wrote:
> >>
> >> On 8/24/26 8:26 PM, Michal Hocko wrote:
> >> > On Fri 21-08-26 13:06:12, Jiayuan Chen wrote:
> >> > > bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
> >> > > conservative guess for BPF program context that is always false under
> >> > > PREEMPT_RT. So even a caller that really is sleepable gets the
> >> > > non-blocking allocator, which never reclaims and never engages the OOM
> >> > > machinery.
> >> > I thought one of the main motivations was reentrancy. As you cannot
> >> > really assume the context bpf_map_alloc_pages is called from there is an
> >> > extra care needed so that this doesn't re-enter the allocator from bpf
> >> > program called from allocator path and deadlock.
> >>
> >>
> >> Agreed, bpf_map_alloc_pages() is designed to be safe to run in any context.
> >>
> >> The commit message should be precise.
> >
> > How do you achive any level of safety for the _sleepable version? Vast
> > majority of the kernel is sleepable but that doesn't mean this is safe
> > from the mm reentrancy POV.
> 
> I think it will only be invoked directly in the arena map fault handler, which
> runs in task context. If an interrupt occurs and tries to allocate pages,
> can_alloc_pages() will return false and it should pick the _nolock() variant
> which is safe against reentrancy.

So you rely on callers to know what they are doing. If that is the case
and generally acceptable by the BPF community (no real saying from me
in that matter) then make sure all that is properly documented. Because
sleepable context is not merely enough.

-- 
Michal Hocko
SUSE Labs
