Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE863F7A93;
	Wed,  6 May 2026 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080902; cv=none; b=HsrXRytEN/81Zy9qf6aWEruThGWOIQg0rq+37qw7kV0mRH6NF5yt8ZbrjLb+mVfy2+rlzGwiLrkB63/iz/5CI1zymWkUyDxxKCP/Dg1YVv8qnGHzPl1sGvmCaOrMKMWZkc840JFDJs9FlKnlqNS17aXDLLM+boyFOIIlZK3H8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080902; c=relaxed/simple;
	bh=vzcG3BpMAW1pBoZX5b8qLPo2Y3fLGRHPnoY0zmiYJuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhZbQExgFArTweLsPilbVNqta2S64cAxiPyRn6UIeoqn3QJA3hmraeMv49snZV+z8TvinM0y4KdUzbOL01MWNGcuPJGPTNrObWoSrx1ijyalmr5gRFwJ4n4lZEBQ3W9WVjMhnJ48kigZSZoFPsUPRKDakdq2GVXQrgcIvQf2XZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tX3H5i6q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX3H5i6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29CBC2BCB0;
	Wed,  6 May 2026 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778080901;
	bh=vzcG3BpMAW1pBoZX5b8qLPo2Y3fLGRHPnoY0zmiYJuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tX3H5i6qsjAtqK3LFFp/R7c7f1Zuoe6+RpQs54ggN3QYDI4zicYpkILPHa/y3hVGy
	 VcbmvrhlxsVlayFkOYlBaFACG2ZfPDI9/bnxV4L1T709+E/VzSuODQYZYfllcao33s
	 U0LBzYyhVIKkmyrHpTLkebJwQxofB4ffF8KDxfGCRmSHVefaiqe0GK08l7EZTwibhn
	 0Fkne5nGkiRlQUc55BMLZD3NrI5FJK3C/6qkoArT/Uq98lQ2ddMb3S6idz3e/jMlJ0
	 JMM3GPAfFYb4l17nyHk/W0OaiskuMhi9UTeoK1gx7PGvcy5Gqkla9YEHLSus40MOCM
	 Z2CAK5EnrDL6w==
Date: Wed, 6 May 2026 11:21:35 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, bpf@vger.kernel.org,
 sashiko@lists.linux.dev, Indu Bhagat <ibhagatgnu@gmail.com>, Chris Mason
 <clm@fb.com>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v14 03/19] unwind_user/sframe: Store .sframe section
 data in per-mm maple tree
Message-ID: <20260506112135.554ca88c@fedora>
In-Reply-To: <49318ed5-8668-43fe-880d-b91bd7c3a7a9@linux.ibm.com>
References: <20260505121718.3572346-4-jremus@linux.ibm.com>
	<20260505185158.39F35C2BCB4@smtp.kernel.org>
	<49318ed5-8668-43fe-880d-b91bd7c3a7a9@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 15:50:45 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> > 
> > mt_init() initializes the maple tree with flags set to 0. Since stack
> > unwinding typically occurs in profiling interrupts (NMIs) which must
> > traverse the maple tree locklessly via RCU, does this missing
> > MT_FLAGS_USE_RCU flag allow concurrent modifications to perform in-place
> > updates instead of RCU-safe copy-on-write allocations? This could result in
> > the NMI unwinder observing corrupted tree states.  
> 
> Please advise.

Sashiko is confused thinking that unwinders happen in NMI context. They
used to, but this will always be done from task context. Hopefully
Sashiko will figure this out soon (Cc'ing Chris and Roman about it).

> 
> > [ ... ]  
> >> @@ -1100,6 +1109,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
> >>  	mm->pmd_huge_pte = NULL;
> >>  #endif
> >>  	mm_init_uprobes_state(mm);
> >> +	mm_init_sframe(mm);
> >>  	hugetlb_count_init(mm);
> >>  
> >>  	mm_flags_clear_all(mm);  
> > 
> > When a process forks, this initializes an empty sframe_mt for the child's
> > mm_struct. While dup_mmap() duplicates the parent's VMAs, it doesn't appear
> > that the registered .sframe entries are propagated to the child's maple tree.
> > Will child processes silently lose their .sframe unwind data for shared
> > libraries registered prior to the fork?  
> 
> Does this ring any bell, Steven?  I ran into it with my signal frame
> stacktracing test on s390.  I think we discussed this during one of the
> SFrame calls and it got lost.  

Oh, this is a good point. I think we need to copy the sframe mt on
fork, not initialize it.




> >> +static int __sframe_remove_section(struct mm_struct *mm,
> >> +				   struct sframe_section *sec)
> >> +{
> >> +	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> >> +		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	free_section(sec);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  int sframe_remove_section(unsigned long sframe_start)
> >>  {
> >> -	return -ENOSYS;
> >> +	struct mm_struct *mm = current->mm;
> >> +	struct sframe_section *sec;
> >> +	unsigned long index = 0;
> >> +	bool found = false;
> >> +	int ret = 0;
> >> +
> >> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
> >> +		if (sec->sframe_start == sframe_start) {  
> > 
> > Can concurrent calls to sframe_remove_section() cause a use-after-free and
> > subsequent double free?
> > 
> > mt_for_each() locklessly iterates mm->sframe_mt, and internally acquires and
> > drops the RCU read lock, meaning the returned sec pointer has no lifetime
> > protection in the loop body.
> > 
> > If two threads concurrently invoke sframe_remove_section(), both could
> > receive the exact same sec pointer from the tree. Thread A could then call
> > __sframe_remove_section(), erasing the entry and freeing sec via
> > free_section(). Thread B would then evaluate the if statement using the
> > freed sec pointer, causing a use-after-free read, and potentially proceeding
> > to free it again.  
> 
> Please advise.

I guess it's asking if we should have a read_srcu_lock()?

> 
> > Additionally, does free_section() need to use kfree_rcu() instead of
> > kfree() to prevent lockless NMI unwinders from hitting a use-after-free
> > when reading payloads?  

Again, this is Sashiko's confusion with thinking this can be called by
NMI (it can't!)

-- Steve
