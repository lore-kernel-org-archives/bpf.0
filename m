Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD473B961F;
	Thu, 16 Jul 2026 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194063; cv=none; b=ksCrfiQs679EDl4q42SbVpn3pxL3IupkOWWZHaBawbtFaDFDefHpKKArn8JaX19oHliZWPciAnJMSZauGLUwdRdbVJh+3pE61Mp2aGjW0ZMNqTMguTMOf5D8TLurnGd5eJYinptQ4z0o4w5AlBx3guOVTpnJ78Cht1galQ6M0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194063; c=relaxed/simple;
	bh=fb9SFGiUnX3DSVzhwdv4dPiqCE5303qGfQjWmQWZFqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBFshI4/NDwu1LdoG6ZQYpOvvnYbJb6BrnUriQ+z/3w5REeQ0S2cHGFKTHIDcDcENpQUYXRALaBqGJ6bP0XUjS0u91jxhvl992AqUb1ss6B2iX91F6/tebuUI0pmctkUAwV4jAdWT/4G23ELdYCcQlIU37EpfD4f9MOu59nQC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdU0Zxqp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdU0Zxqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F199F1F000E9;
	Thu, 16 Jul 2026 09:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784194062;
	bh=e1pLUdEOcpHhfpM0bieyJNPiOmCspJyDP//QgQOB/Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MdU0ZxqpLOFYtunR+VjMCeRfvjxgPIX4jtKxnOuK80noT2kz9PY7ow0H2FtcAfKcN
	 hQC8+c8vkepTHMXLRiAGdGc3VHFuatHmdpmAVUPiQe/GhirXfpqbmaik7ovyhor6tp
	 cgeSR58gKHH2MvdFzRLCY214dEdOOwT7/t6BJqht89hYKjN5kxQ0shzlv8yiCeBPVL
	 XaDrXlZ1SzpsIAA1YSV9GjxdGPiX9NFVg+MbGWtqIK+U6okdQXQSTzUXqq43aQ0ACy
	 N4hydiwwvtQdzsj/wdlFbpfqDnTQTA/HdHBhDXbqWF2TDYRFskk0OaQRsQCk8kSAOL
	 vdlPdfRLXAOOg==
Date: Thu, 16 Jul 2026 12:27:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, andrii@kernel.org, luto@kernel.org, bp@alien8.de,
	daniel@iogearbox.net, dave.hansen@linux.intel.com,
	eddyz87@gmail.com, mingo@redhat.com, memxor@gmail.com,
	peterz@infradead.org, song@kernel.org, tglx@kernel.org,
	emil@etsalapatis.com, jolsa@kernel.org, john.fastabend@gmail.com,
	martin.lau@linux.dev, hpa@zytor.com, yonghong.song@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v3 1/5] bpf: dispatcher: allocate
 bpf_dispatcher->rw_image with vzalloc()
Message-ID: <alikAx7_8tp_ryky@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-1-4e76158c01c5@kernel.org>
 <7cce7d9ee2d24519db79c652aee2e4e562a8139dac923e5cefb4d5edfd4f6407@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cce7d9ee2d24519db79c652aee2e4e562a8139dac923e5cefb4d5edfd4f6407@mail.kernel.org>

On Thu, Jul 16, 2026 at 08:52:25AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> > index ea2d60dc1fee..79f0c222c583 100644
> > --- a/kernel/bpf/dispatcher.c
> > +++ b/kernel/bpf/dispatcher.c
> > @@ -148,7 +148,10 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
> >  		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero, false);
> >  		if (!d->image)
> >  			goto out;
> > -		d->rw_image = bpf_jit_alloc_exec(PAGE_SIZE);
> > +		/* d->rw_image doesn't need to be in module memory range, so we
> > +		 * can use vzalloc.
> > +		 */
> > +		d->rw_image = vzalloc(PAGE_SIZE);
> 
> This isn't a bug, but for multi-line comments under kernel/bpf/ the opening
> /* is expected to sit on its own line, so would this read better as:
> 
> 	/*
> 	 * d->rw_image doesn't need to be in module memory range, so we
> 	 * can use vzalloc.
> 	 */

This really contradicts what I see in the code :/
 
> >  		if (!d->rw_image) {
> >  			bpf_prog_pack_free(d->image, PAGE_SIZE);
> >  			d->image = NULL;
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29482648692


-- 
Sincerely yours,
Mike.
