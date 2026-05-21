Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC837104D;
	Thu, 21 May 2026 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379700; cv=none; b=M+ZH6MD7+ckztiyaWi35RhYCgjpbr0CXMs2Md9TfNy3MpiQm44DjyhCS0ZRCu+YDThJkFweGAqE69W0xfoe+7H6t/DL45/BTKopli+EizkLbFjD3ZKZiyHGKGaC0YrkuGOIkexoNZ558F5XPrIfHQLtwrL0Ihukm116S0nwpOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379700; c=relaxed/simple;
	bh=tHOgJw4LiEtiedhBtOTpl7PbY5y+nleOVlpLCCJDKnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKh2dnvbndhIWubnw/+80gbrr6iuwgERd+WyAFHaJUV8GTw37VQ6my87VwePqD6+o+Y1jP/I9Ww7G4sgT349APfXdwDkixtlmYvE7EhOCZWSXzOGHuGGLwKh9btLAYtHhGxk0Z/7xGGXNtQotuK/3rLpnrLwUIBplY4N5u64NjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dyz+8TSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyz+8TSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6B71F000E9;
	Thu, 21 May 2026 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779379699;
	bh=hDLidqGjMQqXau/zhQMDT9ZD39hVA/8GKTXBF7lNGEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dyz+8TStSki0E9r6BHHxMkPECtggDpaGYWNDWhnW23pI0wib9weQ0NFF/5dCCiJAa
	 tzJ0dzkFpSbr7Ri9X1JZeIf+uVyvGX4V6Q6q+MRybiqWA06eLI6d2PMEefJAX86cMy
	 o0e9rnuXpA82Pzd+Sf0SWWsOjOSMXX4xvwY/tbHZFhu9UFI8LruJENfT3CGKcMWTDx
	 NqT1zCsh6bj4vtJvevr9XR0kCqvkaYIcCIR0gbpNUkKhj7FazmVXNz3SYFjspWsjVG
	 tjTO7cJ20oOpyp1kJbWc2THR09AHfxE+wOt16fQDpwkdTEfii4LR8ngGisdstQCPy4
	 n06/wzVuMxV0w==
Date: Thu, 21 May 2026 12:08:39 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, Josh Poimboeuf
 <jpoimboe@kernel.org>, Indu Bhagat <ibhagatgnu@gmail.com>
Subject: Re: [PATCH v15 03/20] unwind_user/sframe: Store .sframe section
 data in per-mm maple tree
Message-ID: <20260521120839.354fb4c4@gandalf.local.home>
In-Reply-To: <cd3beb08-cc63-47bc-b877-9f43112ef51d@linux.ibm.com>
References: <20260520154004.3845823-4-jremus@linux.ibm.com>
	<20260520162914.13A0F1F000E9@smtp.kernel.org>
	<cd3beb08-cc63-47bc-b877-9f43112ef51d@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 11:39:44 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> On 5/20/2026 6:29 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> > - [High] Missing `MT_FLAGS_USE_RCU` during maple tree initialization causes Use-After-Free of tree internal nodes.
> > - [High] Synchronous `kfree()` of `sframe_section` bypasses SRCU/RCU grace periods, causing Use-After-Free for concurrent readers.
> > - [Low] Undeclared identifier `sframe_srcu` causes build failure.
> > - [Low] Macro expansion of `INIT_MM_SFRAME` breaks compilation on non-x86 architectures.
> > --
> > 
> > commit ce5ec4616b79b2c0aa851c150b33143b5d3876af
> > Author: Josh Poimboeuf <jpoimboe@kernel.org>
> > 
> > unwind_user/sframe: Store .sframe section data in per-mm maple tree
> > 
> > Associate an .sframe section with its mm by adding it to a per-mm maple
> > tree which is indexed by the corresponding text address range. A single
> > .sframe section can be associated with multiple text ranges.
> >   
> >> diff --git a/include/linux/sframe.h b/include/linux/sframe.h  
> > [ ... ]  
> >> @@ -19,18 +21,31 @@ struct sframe_section {
> >>  	signed char	fp_off;
> >>  };
> >>  
> >> +#define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0),  
> > 
> > [Severity: High]
> > Does this maple tree need to be initialized with MT_FLAGS_USE_RCU?
> > 
> > Without it, the tree operates in non-RCU mode, so lockless iterations
> > might race with in-place node modifications and synchronous node frees,
> > potentially causing use-after-free of the internal nodes.  
> 
> Steven, please advise.
> 
> >   
> >> diff --git a/kernel/fork.c b/kernel/fork.c  
> > [ ... ]  
> >> @@ -1073,6 +1075,13 @@ static void mmap_init_lock(struct mm_struct *mm)
> >>  #endif
> >>  }
> >>  
> >> +static void mm_init_sframe(struct mm_struct *mm)
> >> +{
> >> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> >> +	mt_init(&mm->sframe_mt);  
> > 
> > [Severity: High]
> > Similar to MTREE_INIT above, does mt_init() need to use mt_init_flags()
> > with MT_FLAGS_USE_RCU here to prevent use-after-free during lockless reads?  
> 
> Likewise.

Looks like the MT_FLAGS_USE_RCU is for internal use of RCU. But if we use
src to protect the tree, I think it should be OK.

> 
> >   
> >> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c  
> > [ ... ]  
> >> +static int __sframe_remove_section(struct mm_struct *mm,
> >> +				   struct sframe_section *sec)
> >> +{
> >> +	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> >> +		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	free_section(sec);  
> 
> I'll move the SRCU logic from patch "[PATCH v15 05/20] unwind_user/
> sframe: Add support for reading .sframe contents" here:
> 
> 	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_srcu);
> 
> > 
> > [Severity: High]
> > Can this synchronous free cause a use-after-free for concurrent readers?
> > 
> > If an unwinder or other thread is iterating the tree locklessly and has
> > already obtained the section pointer before it is erased, freeing it
> > immediately here without waiting for an RCU or SRCU grace period would
> > pull the structure out from under them.  
> 
> This will be resolved by above and below.

Yeah, I think having this all protected by SRCU from the start will
hopefully satisfy Sashiko.

-- Steve
