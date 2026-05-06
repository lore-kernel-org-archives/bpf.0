Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412847DD74;
	Wed,  6 May 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079708; cv=none; b=E8gVfdJyHQLWtTmH7y58rZPshli+JAGXtmTxdMap7YRNZm0B7qKJ8ZedWEZg1aHUnLjbgDNlilgUIutdQCANwIzDAm9xqAdaz9kfCj85L229LWcbiGLuPjsEr1RaMrRqSBo3sCZRWtyqNrYnb8bS4n4iPKC6hHtbEDwgJXghegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079708; c=relaxed/simple;
	bh=jicNl1hmcTX1y/AzzV7/JU9n/VhdKLb1qSYDkvPDLI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLXdwhFeh8eg7f8A8Rs25sFYLWZiT/09B8OIdNbnNA8Jch9bcAVjHj0+pUtCMEf6xmsrnlgep3r0dHpkg/5QLjFlH63kKQxeJJZQEzTe0eUAK+ccH/2xy3+6w2nIYkAtgjLE9t78OKAvORo/Jh9xIwKxZl1pazARNH19LM77JK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh+yYJNr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh+yYJNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2945AC2BCC7;
	Wed,  6 May 2026 15:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778079707;
	bh=jicNl1hmcTX1y/AzzV7/JU9n/VhdKLb1qSYDkvPDLI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kh+yYJNrdmHz02L0QXgZzuHxrWx6KEuEW/UAkDu3JU+jpA5osys+QiQ4a52RuFxG5
	 xj6yEkUhtwos3gY+MJMyr7Ja9O3N4n580gyIEBA2Qqp7vjS82abj19jjvI0sGax99u
	 o6kJjnrcS3Hs/NYBiXDa02DECF7iETaQYkNWuFZ0Rq2Ga46A73l1TGu+EaUwIExFMq
	 fc3u55mEQNqutVHs+pbvDqBWD0mC9xJL+JtTlVR9/Y/H4RJOOzjXjGesfQOLaCHJZ2
	 W6lAyyjKad4G4KKj50v9TelwL0at/Tuq8AOVjXbbJI5vZ+zeusb2mJOtkFGz9imJ4N
	 HFCV0IRkpWeHg==
Date: Wed, 6 May 2026 11:01:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Indu Bhagat
 <ibhagatgnu@gmail.com>, bpf@vger.kernel.org, sashiko@lists.linux.dev
Subject: Re: [PATCH v14 05/19] unwind_user/sframe: Add support for reading
 .sframe contents
Message-ID: <20260506110142.7b2943d7@fedora>
In-Reply-To: <4e5d51f0-8f4c-4a07-9141-8b26d2c90fc6@linux.ibm.com>
References: <20260505121718.3572346-6-jremus@linux.ibm.com>
	<20260505185932.C708CC2BCB4@smtp.kernel.org>
	<4e5d51f0-8f4c-4a07-9141-8b26d2c90fc6@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 16:34:34 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> >> +static __always_inline int __read_fre(struct sframe_section *sec,
> >> +				      struct sframe_fde_internal *fde,
> >> +				      unsigned long fre_addr,
> >> +				      struct sframe_fre_internal *fre)
> >> +{  
> > [ ... ]  
> >> +	if (fre_addr + addr_size + 1 > sec->fres_end)
> >> +		return -EFAULT;
> >> +
> >> +	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);  
> > 
> > Will this cause alignment faults on architectures with strict alignment
> > requirements?
> > 
> > The .sframe format uses packed structures and variable-length datawords. The
> > cur pointer might be unaligned here, and UNSAFE_GET_USER_INC() performs
> > 16-bit or 32-bit reads via unsafe_get_user().  
> 
> IIUC this should not be an issue for x86-64, s390, and arm64.

Do we have a way to make sure that sframe support will always be for
architectures that can handle alignment issues like this? There should
be something to force this via configs or something that will trigger a
warning or bug if this is built for architectures that can't handle
this alignment.

> >   
> >> +
> >> +	fre_addr = sec->fres_start + fde->fres_off;
> >> +
> >> +	for (i = 0; i < fde->fres_num; i++) {  
> > 
> > Can this loop cause a hard lockup in atomic context?
> > 
> > fde->fres_num is a 32-bit value copied from user space without validation.
> > Since sframe_find() is designed to be called by unwinders in NMI context, an

What? No. This looks to be a hallucination. sframe_find() will never be
called in NMI context. In fact, it can only be called in task context.

> > attacker could provide a very large number of valid entries. Executing
> > billions of iterations and unsafe_get_user() calls could stall the CPU
> > and trigger the hard lockup detector.  
> 
> Please advise.

That said, we should verify that fde->fres_num is at least always
smaller than the size of the table.

> 
> >   
> >> +		int ret;
> >> +  
> > 
> > [ ... ]
> >   
> >> @@ -120,8 +449,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
> >>  	sec->text_end		= text_end;
> >>  
> >>  	ret = sframe_read_header(sec);
> >> -	if (ret)
> >> +	if (ret) {
> >> +		dbg_print_header(sec);
> >>  		goto err_free;
> >> +	}  
> > 
> > Can shdr.fre_len cause an integer overflow on 32-bit architectures during
> > header parsing?
> > 
> > If a malicious user provides a large fre_len in the header, fres_end
> > (calculated as fres_start + shdr.fre_len) could wrap around the 32-bit
> > address space. This would bypass the bounds check in sframe_read_header(),
> > allowing fres_start and fdes_start to point into kernel memory. Later, when
> > __read_fde() and __find_fre() use unsafe_get_user(), this could lead to
> > arbitrary kernel memory disclosure.  
> 
> SFrame is currently only supported on 64-bit architectures (i.e. x86-64,
> arm64, s390 64-bit).  So unsigned long fres_end should always be 64-bit.
> Do we need to add the following to the header parsing?
> 
> if (fdes_start >= fdes_end || fres_start >= fres_end) {
> 	dbg_sec("inconsistent FDE/FRE start/end address\n");
> 	return -EINVAL;
> }

I guess this wouldn't hurt.

> 
> >   
> >>  
> >>  	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);  
> > 
> > Does passing sec->text_end directly as the last parameter to
> > mtree_insert_range() break contiguous mappings?
> > 
> > mtree_insert_range() expects the last boundary to be inclusive, but
> > sec->text_end represents the exclusive end address of the executable segment.
> > If user space maps seamlessly contiguous text segments, the insertion for the
> > second segment might overlap with the claimed end of the first, causing it to
> > fail with -EEXIST.  
> 
> Addressed in previous patch.

And I just sent a patch to fix the documentation of
mtree_insert_range() to update the kerneldoc to explicitly state it is
inclusive :-p

-- Steve


> 
> >   
> >>  	if (ret) {
> >>  		dbg("mtree_insert_range failed: text=%lx-%lx\n",  
> >   
> 
> Thanks and regards,
> Jens

