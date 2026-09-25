Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7581DDF0;
	Fri, 25 Sep 2026 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341745; cv=none; b=qxELOqeKvias8HrticSU+MHCdvxSBbx4eV8voIoCmdFp1EUljaYkTD89qe1FEQk4pJLZU39Xf0n4m3HdJFq+jR2/N6gygcSw+I7modM2TGanstxHBjijKgeYXyUPb4JG0252/rbmuS7Lea6vvvpXz5ebtSUd8vtV3rez6FFPD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341745; c=relaxed/simple;
	bh=7NzpQMoLjBgi9FTHgnoDpAFQfJI+cQHIFUOOAKCjDN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl6DWsTShApEqk0p5D50yKFzNQQ+AND8bSqO8dgNMkInTgwsWgqGqNhQPWwNpNFTBdFi+hkCrskCOLMPWW166pY1cNp3jxzl2H5qPkNsG9LO2gPBMVSC2utD+cXQx+9MgoPv2DSkHfwJheCbojk7qlgNo49AcMFmYwelUhzMMnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEhQN4GA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEhQN4GA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13D61F000FF;
	Fri, 25 Sep 2026 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341743;
	bh=lnAneDTOhSK7ryzvQCKB6l+o67HIxRHTdOaZupVyATY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZEhQN4GAOPhASTFcl0yG0oHUXqD+yfoiSdvt6qFToohSp1gkqe+tnbg5iw2UDNT95
	 ZcTR0q54BV1+jxFdsZZbUjWnn6U7ji9okb8mXoNvwK1G4FHK6hQ3k8TMhP4a7c1jhS
	 T+e/RyqP6dtNMTzhASmm0jZBz9+BngBBa3qdzeQW5INRn1QDAfgFXHuI56ZuXWYFu+
	 /3c3SUnBXjfc7jtPGEZJXVUDq+x5sgBZtJlkw0WCJy5ERckiqON21t+2sryUSijJ0Z
	 b4xZyZ7B9Kx2+O9uc9/wK/umZA42u1V33/nhxuZzRCy0vTcIulghVKUP/wPvt0/OCJ
	 j/UQ3LmDVli5Q==
Date: Fri, 25 Sep 2026 14:08:58 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: akpm@linux-foundation.org, tasos.papagiannnis@gmail.com, 
	linux-mm@kvack.org, liam@infradead.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/nommu: Reject wrapping ranges in access_remote_vm()
Message-ID: <arZwZYUNmUUaoJmW@gremlin>
References: <20260909064231.18693-1-tasos.papagiannnis@gmail.com>
 <20260909001341.6a7c3556259f7cf9a79c1da7@linux-foundation.org>
 <m2cxum423s.wl-thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2cxum423s.wl-thehajime@gmail.com>

On Thu, Sep 10, 2026 at 05:11:03AM +0900, Hajime Tazaki wrote:
>
> Hello,
>
> On Wed, 09 Sep 2026 16:13:41 +0900,
> Andrew Morton wrote:
> >
> > On Wed,  9 Sep 2026 09:42:31 +0300 Anastasios Papagiannis <tasos.papagiannnis@gmail.com> wrote:
> >
> > > The NOMMU implementation of access_process_vm() rejects address ranges
> > > whose end wraps around, but access_remote_vm() bypasses this check even
> > > though both functions delegate to __access_remote_vm().
> > >
> > > Move the wraparound check into __access_remote_vm() so it applies to
> > > both entry points.
> >
> > lgtm, thanks.
> >
> > > This is originally reported in [1].
> > >
> > > [1] https://lore.kernel.org/bpf/4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org/
> >
> > Ah, bpfbot scored one.
> >
> > Sashiko might have found more issues in there:
> > 	https://sashiko.dev/#/patchset/20260909064231.18693-1-tasos.papagiannnis@gmail.com
> >
> > I'll optimistically cc Hajime Tazaki, who has been doing some NOMMU
> > work recently.
>
> I got a similar review (from Sashiko) that current use of
> !vma->vm_file isn't appropriate and should use vma_set_anonymous().  IIUC
> that case happens only (I may miss something) with /dev/zero (via
> mmap_zero_prepare()).

That's no longer an issue as MAP_PRIVATE-/dev/zero is truly anon now.

>
> I also had a patch but am currently waiting for Lorenzo's input for
> his work on /dev/zero, which mentioned in his reply.

Sorry, I just added a script to find call outs in neomutt :)

As above.

>
> https://lore.kernel.org/linux-mm/an8BlTgk7sc5vFJ1@lucifer/
>
> Thus 3 comments of Sashiko (all about vma->vm_file) can be addressed
> in future, and are not needed an immediate fix.

You can use vma_is_anonymous() now.

>
> I wish to ask this to Lorenzo too.
>
> -- Hajime

--
Cheers, Lorenzo
