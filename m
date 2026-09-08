Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15C29D27D
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880777; cv=none; b=XVYibIfPNJEoEa8MgE56GkUH0p+bCBe7stGdCSRbczAPEVgAPWrlX6KK9eI/tX0anvWejcxAZ30CuUQXZ65OWM0Ogrd0z+o7rn+M4F1eGbUEFwAk9M1pvAXWkFVXeJjLUwrByQPZPPAmd7BTEhJhFX7UHb8jBtqFQ6yznEiBAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880777; c=relaxed/simple;
	bh=y/jv6JpvXNi/QvS7h2WrvA66++fvEXjeZbo2+lngKU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlnGkuZ4HJKoNRp3xBgMYfT3gU1RDUq34ck6WzTP257CmBt1Ub0SVtAAQo1dSY/UxMMKQLOAY7n2DgmDfCYLs2wZ8az8YeQhgh+JoTIhJZzXDKK66T+S+4Y6CMQCqjjJbgW8yKxnXtl/dD23X377a3+LxdZrBBtNJ3wtYfUA/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4/F8lgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4/F8lgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461191F00A3A;
	Tue,  8 Sep 2026 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788880764;
	bh=Tfe17aixhvDSsE3PKQcSvkElxpa5kSQe179rMsz+WHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q4/F8lgyoCXV+Ofrpzb2rHUBqUUDlUXDNxRl+LST4A+AtuwXNoCdxEOfPleHe4D7z
	 8ZXeMyxnDQIW0zpKu8mb39D9UdQPcJ6/DkFlaG7eLOtaB6jYNx9XDEMRStuXlZMQMk
	 x49KI4tH7ostIdBzJT/ed8Q8mDzcIMTS+MlDcVHjcYXNw1Do/KSox3dKnKBHvg5sl/
	 EL92Oy9ul6DdjapKSw8IEakrBwmGLHA4SMHWoDQdRrRqFrmWzUx/ves4jmYiB7SvTJ
	 XoYI3+piHq3WBXSjixCJ9l1BCaxETu4KhjL7qhCGIzcrNERv0sIMb2VU0Cyzwky5l0
	 zMg994GeuRaiw==
Date: Tue, 8 Sep 2026 18:19:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next] bpf, x86: Use global buffer for trampoline size
 generation
Message-ID: <aqAndUVLnR3sOOlk@kernel.org>
References: <20260907160538.922450-1-jolsa@kernel.org>
 <DL9CKPXX2OFG.2EK0RAZUT2PMV@gmail.com>
 <ap8d2AhD7Ax13rJ8@krava>
 <CAADnVQL-vs02PyTOQE9wYK+S988hG7cUMq+DAiD=X1K5+E=zmw@mail.gmail.com>
 <ap_-tAGAqguRdFUn@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_-tAGAqguRdFUn@krava>

On Tue, Sep 08, 2026 at 02:25:24PM +0200, Jiri Olsa wrote:
> On Mon, Sep 07, 2026 at 05:13:29PM -0700, Alexei Starovoitov wrote:
>
> > > > > +static void *trampoline_size_image;
> > > > > +
> > > > > +static int __init init_trampoline_size_image(void)
> > > > > +{
> > > > > +   trampoline_size_image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
> > > >
> > > > I think I asked it earlier... why does it have to be execmem ?
> > > > Can it be normal page?
> > >
> > > ugh sorry I forgot.. the page/image needs to be in execmem range
> > > for emitting call/jmp otherwise the delta won't fit in 4 bytes
> > > and it fails on emit_patch is_simm32 check
> > 
> > ahh. I see. Please mention it in the comment and
> > also use bpf_jit_alloc_exec(PAGE_SIZE).
> > 
> > execmem_alloc(EXECMEM_MODULE_DATA...) was working by accident.
> > The VM ranges could have been different.

On x86 it's not an accident ;-)
But would be a surprise if this is copied to another architecture.
 
> bpf_jit_alloc_exec returns read only page so I'd use bpf_jit_alloc_exec_rw,
> but it was recently removed in:
> 
>   c7a2a3618290 x86/bpf: Make arch_bpf_trampoline_size allocate from EXECMEM_MODULE_DATA
> 
> so I ended up with:
> 
>   trampoline_size_image = execmem_alloc_rw(EXECMEM_BPF, PAGE_SIZE);

This will work, but it will permanently damage 2M mapping in the module
address space.

execmem_alloc_rw() takes a page out of the ROX cache and resets that page
permissions to RW. This splits the large mapping of the 2M cache page and
since this is a permanent allocation, that chunk will be forever mapped
with 4k pages.

execmem_alloc(EXECMEM_MODULE_DATA...) does not use ROX cache, so it won't
take a page out of ROX cache and reset it's permissions.

Since this is anyway x86 code and on x86 the ranges for data and code are
*always* the same, I'd keep execmem_alloc(EXECMEM_MODULE_DATA...) and add a
comment.

> jirka

-- 
Sincerely yours,
Mike.
