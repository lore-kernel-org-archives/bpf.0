Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD422E5B2A;
	Sat, 11 Jul 2026 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783787303; cv=none; b=qUhtzbCCWeYEpYnenXyYlqDsbv0w1PtgqEr7SYDakSBwFxeCG7tklRd85zGcwB3Jx61g1rJ3zu0oJCt1ih7liYUU3MPXGvvlBByw/YkQ7CSLZYuZKBajXQ1AzNVME6ehaK1ez+4bdJu1ud9zJ5dvPwnGmJvKcUEkgLRl6BkCXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783787303; c=relaxed/simple;
	bh=Qlcontc5P9jwATUrhWzSGCyzurvFHTeJmSifRu4UlFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewJO/+JVhd935wridYih6prEdfrL6C9K5WJnO5TsUcnNV8p5uw7xOIWGYkE3OF+ezJEREG4F0mD/6x2IDpKlJdV0HdiLqgX4P7q5Oac15txGwirdZWLt0eYmngkb6WF0vXiSKGcyE0InOQZ8Fnbl6lXtgFWPugDwR3RkMTHlSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSOPxUnG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSOPxUnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B321B1F000E9;
	Sat, 11 Jul 2026 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783787301;
	bh=kjYNMbsoYWSalAADobS+vBgXHekFbY+/fN2behqHN08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dSOPxUnGn8/O7MdrRpqPgmvWsV2+oUSsofHOFbrIepWPD7oon3ZKPMBQ7Lw3/eQ6v
	 M8us8ZOxkq83qYc3QGnhAG6qqFvCqlgox7MF78TLsMCRmZO9cyU22p31nS4wjS0E0A
	 js8enJIBkX/aBkHMl0BqmiqBBXegp96t02Uy5KTZttspnY30DMjmy+xStNwgVEo0Ct
	 iS0o0YZarDSBV3BUmIXbbpXq4ZC2nvGksG4CSR8n9zG2Go7fnWPBjigO5gKPmOIRLW
	 4Yj5SwO6c91WlCa7+OE3yqj5REdX93nUPqRMbvRv1LfJtjMEDly4zf+QeoMyBihNi/
	 PVNHqDLIdpdZw==
Date: Sat, 11 Jul 2026 19:28:16 +0300
From: Mike Rapoport <rppt@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: dispatcher: allocate
 bpf_dispatcher->rw_image with vmalloc()
Message-ID: <alJvIEa2tKPPqhfz@kernel.org>
References: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
 <20260711-execmem-x86-rox-bpf-v0-v2-1-bfd956d35119@kernel.org>
 <20260711095505.0CC961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711095505.0CC961F000E9@smtp.kernel.org>

On Sat, Jul 11, 2026 at 09:55:04AM +0000, sashiko-bot@kernel.org wrote:
> bpf: dispatcher: allocate bpf_dispatcher->rw_image with vmalloc()
> 
> This commit changes bpf_dispatcher->rw_image allocation to use vmalloc()
> instead of bpf_jit_alloc_exec() since the rel32 offsets are calculated
> against the final image, removing the need for the temporary buffer to live
> in the module address range.
> 
> > diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> > index ea2d60dc1feeb..d85b3e8ad2e4e 100644
> > --- a/kernel/bpf/dispatcher.c
> > +++ b/kernel/bpf/dispatcher.c
> > @@ -148,7 +148,10 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
> >  		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero, false);
> >  		if (!d->image)
> >  			goto out;
> > -		d->rw_image = bpf_jit_alloc_exec(PAGE_SIZE);
> > +		/* d->rw_image doesn't need to be in module memory range, so we
> > +		 * can use vmalloc.
> > +		 */
> > +		d->rw_image = vmalloc(PAGE_SIZE);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but since we are changing the
> allocation here, does this code leak uninitialized kernel memory into the
> executable dispatcher image?
> 
> vmalloc() does not zero-initialize the memory, and neither did the previous
> bpf_jit_alloc_exec() call. When the architecture-specific code generates the
> dispatcher instructions into this buffer, it only writes a few hundred bytes.
> 
> Later, bpf_dispatcher_update() copies exactly 2048 bytes from this partially
> uninitialized temporary buffer into the executable RO+X dispatcher image:
> 
> bpf_dispatcher_update()
>    ...
>    bpf_arch_text_copy(new, tmp, PAGE_SIZE / 2);
> 
> Could this overwrite the safe int3 trap instructions placed by
> bpf_prog_pack_alloc() with random bytes from the uninitialized kernel memory,
> potentially creating unintended ROP/JOP gadgets? Would it be safer to use
> vzalloc() here instead?

This one seems real unless I'm missing something in how that memory is
initialized.

I'll change vmalloc() to vzalloc() to make this better, but the proper fix
to either initialize ->rw_image to invalid instructions or copy only the
actually generated part is out of scope for this set.
 
> >  		if (!d->rw_image) {
> >  			bpf_prog_pack_free(d->image, PAGE_SIZE);
> >  			d->image = NULL;

-- 
Sincerely yours,
Mike.
