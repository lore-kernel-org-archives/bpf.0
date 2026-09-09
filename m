Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146E357D13
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947353; cv=none; b=GR7RDKRGoH38rgDUZo6IFU4l2n/62cgNqzYA4tJkwEGTHg2vFSNcO+ESffPEEluwZtUz6v6EvKBbiFBd/qHbkCYZ4YJWTqdCChbX+CVqy43s22a9hR9ycavDf12gjlmxmNx+m23fdG+WV+ZhomwW+/nONtQqV4lgjqqbOIIKREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947353; c=relaxed/simple;
	bh=8B3f38OD9JQKRalt4moBMoXGR1eABwXouJQWxV5FfXQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9Sl4D3vHqtzeLlOXVJ/WZPG70YJhjfSRhruDyplkhfZvlExmWi0tcxy5vicqWsyGDlQVv8GkF5d9QwuRqhOcEMnSFVw0sG+ZLTgiNLamjVZVOxnr7yVH4K68Rajd2sK5YBAZV2cFST5PNAGf9pZDagBMaoTjyRtYDv0f9gMt58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o59dfmJ6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o59dfmJ6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso59997015e9.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 02:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788947349; x=1789552149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XNVHjcV94uMOb2jl2DZ1u3SvlPAyyAxd9Q61Z0dhJRE=;
        b=o59dfmJ6nb1nxdhkjAVsKxghfhKdWDGZm9oeNpG3pazDiZFbfoVFfvOsKVfEvmNpt/
         F1isanyf9ogeJjCDGI+fuNfRxpibteEJsCj6v1s4D73fB4cNyxoWc1IjbKOWFOYGSM+7
         3cOWOKYBcERM2C6M80EmvGyJSg5mj04APyfT4F6krzxvU7dNhCEmU9FLgQHnLsZq3rVh
         D49TtAa0Qh3NM2GkPH4Tp7LZB7rmHgnGdFlUeeIFhTv93oTKTuVriYFQ/gKU2A5zbUKS
         ij8TOATeidOG3VtKBoepSfWjRwclXtDyE4Y2HYCD1DtnNZAo42iLbelkZVubkKYesp5e
         Yh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788947349; x=1789552149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNVHjcV94uMOb2jl2DZ1u3SvlPAyyAxd9Q61Z0dhJRE=;
        b=pNtJzSRi69deZ5hvyDUm5x7saCZ5iH+olhS6VdGbzAx0uwYvLZ7dG2ecSehNA6QtkZ
         YeAo+spJLOJq7JnoqY9EX8ko40y8AbM5FFRZy4TnNv0Ph+mqVJvhv/gC179Hz7p9KpO8
         XxIDxVZqnbNVR/veSZsBa6S+V31YFaHBOILDN9nC3gylcBsbjcuW97Ya11qlp4VOj2a6
         Wnb2Xr0Cb+lqkcXb+ICzZ0n9uKoC5dgcaL+G+s+83wXXrDd4YIDhSWn7YQcwqnRA8nqv
         dE+qxlgi4/wH2FI2NiiJCna6zA1vOTQh8Dp+OrNGYiXysLzqlIh1p1zmPM5ayobleD8J
         dWfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqONcEsBtn+oSCpIvrIPIggV8XLaj41jtm3xYCH18iIzsJKhHDgiGXbqfuoYmp5q4ScG4=@vger.kernel.org
X-Gm-Message-State: AFuF++njR3vNG8cFGSrGTvwzRHgNOP5ZDRUDlGrnsr/N7L/erP3qSICi
	yprL7ud5jOWiPx8LzuLIQt11wdQjymE2WPU0fZ/WF9LNrhgGSZV0TYsD
X-Gm-Gg: AYBFou3OoRoT8UMc6y5lomxoWUJnO2/HxEaJlY0G3i969USyAyJ1KbOvDTpZZECwBMr
	d2TLuRXoPtARFDFLto+8lPW38Quu+z9LYloQisiN1NwSRUC0tUB34iKc9YHrvPe0TW8LrMVM0nT
	blKiQ/1h0gvEWY/e8cROS6FF3+ghFrOqhawUI11yibTckVqUB6O5Znv11oU271u4KV1/QDNQcRy
	bzyHdL1WFPaTkXiiBnrVpbOZOMX1Gxnjlc1ZzgAS16CPIwXBy2RTg6N9VD1086/V9exrTV/Jhf/
	Cday9QkEeG2NAqOIUgawi/SB+kwmSVraPvNThI7Hhw/AEq+D7eKxlDjP9r895FRSiqT+TKGP/YI
	qqZt7lgw8U6xuX/3ibLYqt8puj80UmOM9Sbapb01ojYP/zs9dJUq408laFIE+vAZ8zCAaQ7J/kt
	B9ITOQIfSGxvbYJwILREr67KNeKcy8N5fMR7XiY7rATDL24DVnV4YAoS/7lg==
X-Received: by 2002:a05:600c:6383:b0:49c:f4ff:e872 with SMTP id 5b1f17b1804b1-49cf820507cmr305267355e9.5.1788947349165;
        Wed, 09 Sep 2026 02:49:09 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07a23e85sm347134255e9.5.2026.09.09.02.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:49:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 9 Sep 2026 11:49:07 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next] bpf, x86: Use global buffer for trampoline size
 generation
Message-ID: <aqErk9S-bWpQCVRL@krava>
References: <20260907160538.922450-1-jolsa@kernel.org>
 <DL9CKPXX2OFG.2EK0RAZUT2PMV@gmail.com>
 <ap8d2AhD7Ax13rJ8@krava>
 <CAADnVQL-vs02PyTOQE9wYK+S988hG7cUMq+DAiD=X1K5+E=zmw@mail.gmail.com>
 <ap_-tAGAqguRdFUn@krava>
 <aqAndUVLnR3sOOlk@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqAndUVLnR3sOOlk@kernel.org>

On Tue, Sep 08, 2026 at 06:19:17PM +0300, Mike Rapoport wrote:
> On Tue, Sep 08, 2026 at 02:25:24PM +0200, Jiri Olsa wrote:
> > On Mon, Sep 07, 2026 at 05:13:29PM -0700, Alexei Starovoitov wrote:
> >
> > > > > > +static void *trampoline_size_image;
> > > > > > +
> > > > > > +static int __init init_trampoline_size_image(void)
> > > > > > +{
> > > > > > +   trampoline_size_image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
> > > > >
> > > > > I think I asked it earlier... why does it have to be execmem ?
> > > > > Can it be normal page?
> > > >
> > > > ugh sorry I forgot.. the page/image needs to be in execmem range
> > > > for emitting call/jmp otherwise the delta won't fit in 4 bytes
> > > > and it fails on emit_patch is_simm32 check
> > > 
> > > ahh. I see. Please mention it in the comment and
> > > also use bpf_jit_alloc_exec(PAGE_SIZE).
> > > 
> > > execmem_alloc(EXECMEM_MODULE_DATA...) was working by accident.
> > > The VM ranges could have been different.
> 
> On x86 it's not an accident ;-)
> But would be a surprise if this is copied to another architecture.
>  
> > bpf_jit_alloc_exec returns read only page so I'd use bpf_jit_alloc_exec_rw,
> > but it was recently removed in:
> > 
> >   c7a2a3618290 x86/bpf: Make arch_bpf_trampoline_size allocate from EXECMEM_MODULE_DATA
> > 
> > so I ended up with:
> > 
> >   trampoline_size_image = execmem_alloc_rw(EXECMEM_BPF, PAGE_SIZE);
> 
> This will work, but it will permanently damage 2M mapping in the module
> address space.
> 
> execmem_alloc_rw() takes a page out of the ROX cache and resets that page
> permissions to RW. This splits the large mapping of the 2M cache page and
> since this is a permanent allocation, that chunk will be forever mapped
> with 4k pages.
> 
> execmem_alloc(EXECMEM_MODULE_DATA...) does not use ROX cache, so it won't
> take a page out of ROX cache and reset it's permissions.
> 
> Since this is anyway x86 code and on x86 the ranges for data and code are
> *always* the same, I'd keep execmem_alloc(EXECMEM_MODULE_DATA...) and add a
> comment.

sgtm, if there's no objection I'll add comment to init_trampoline_size_image
and send new version

thanks,
jirka
