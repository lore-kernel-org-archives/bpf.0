Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6E31197C;
	Mon,  7 Sep 2026 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789699; cv=none; b=XddrIWlXO5GEq4c/T3LLlVMiTWNN+SjiksfsAFz4TtITNuF3HcKBoNpwgQ66a/PY/nJsMSz5xytUGxhzSDVEb1EL2X4N6BzBv256qArE+jsKJtgcOZLIcw7SCVXN6pGDmo8PzOm4gI/uf0glynb1nEKSbMh2B599k7dFmss6MMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789699; c=relaxed/simple;
	bh=7kJIDjYW8q33BgxlHYzic8uH2Wmk+MD3jfErTIt51hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFwi3e4eY10h6FENDdfJOD8lv5Ur9LtRT2aRMieXFyZdk1b0gQYz8VwpuVX+jD17cacEL3uzRnqVeJuw3YBHLXJi6KXb/U9Jq1J8AukyKq+3rS6p3wENnnn+saZ37wOkTe6MaFc6hzI3LnYZgsnL5TBeHgU92zYXkikDunMlN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZDItgF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZDItgF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E131F00A3D;
	Mon,  7 Sep 2026 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789697;
	bh=CT/PRZLhit2fRIl3/YwuJ8bKg1BMJtfb23DmTmMzVEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gZDItgF5lu7ObJAVqpHDntSxEo5tnQSW97w+OS3wzeszJHbYiCLfnRHHpSFXM9pSd
	 agr+j+4sQa8+BXS0SCLYyA5/yGk6soH2cY4y44jMqgxnRDm5+u0+B7HQHKCwPu9YgP
	 OwwBtmiqO9gxxGTzNrEIn+8/do2+xJw6XuCOFijbQ7nS61OMGxNQ2o/Vp+amWYf8zV
	 p/tXJKpLX7czlW1NVpT5cOKHcnUrynpMW7OxkgfmCIIUsjrqbPA53GwVtjOiG8QcYS
	 I0Q+7FlF/WKakyEpCFfKJ7oe1btbCA7Km89/UDdOpKf1uIEI0XBsirEGbFRHzkmjmN
	 3cK2HvEfdSQHA==
Date: Mon, 7 Sep 2026 15:01:30 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: david@kernel.org, akpm@linux-foundation.org, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, kpsingh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matt@bobrowski.net, memxor@gmail.com, 
	song@kernel.org, sun.jian.kdev@gmail.com, utilityemal77@gmail.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next v4 1/7] mm: Add copy_remote_mm_str()
Message-ID: <ap7CocZyy6K9QYMp@gremlin>
References: <0e4edfd3-0c82-42e0-ad09-19ff8b8d1511@kernel.org>
 <20260907134101.424017-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907134101.424017-1-tasos.papagiannnis@gmail.com>

On Mon, Sep 07, 2026 at 04:41:01PM +0300, Anastasios Papagiannis wrote:
> > We have this check in copy_remote_vm_str(). Why are we performing the check now
> > twice?
>
> > It should either go only into __copy_remote_mm_str(), or if there a reason to
> > have it before get_task_mm(), it should go into copy_remote_mm_str(). Same
> > applies to the memory.c case.
>
> Yes, this makes sense. I will fix that.
>
> > What's more annoying is that both implementations of copy_remote_vm_str() are
> > identical, and both implementations of copy_remote_mm_str() are nearly identical
> > (just dropping the gup_flags for nommu). I'd like to avoid duplicating code for
> > nommu.
>
> > If we could export __copy_remote_vm_str(mm, addr, buf, len, gup_flags) for both
> > cases, we could instead provide a single implementation for copy_remote_vm_str()
> > and copy_remote_mm_str() e.g., in mm.h? (I'd prefer somewhere else, but we don't
> > seem to have a good git for memory.c + nommu.c shared stuff)
>
> Another idea can be:
> mm/memory.c: MMU implementation of __copy_remote_mm_str()
> mm/nommu.c: NOMMU implementation of __copy_remote_mm_str()
> mm/internal.h: declaration of __copy_remote_mm_str()
> include/linux/mm.h: declaration of copy_remote_mm_str() and  copy_remote_vm_str()
> mm/util.c: shared implementation for copy_remote_mm_str() and copy_remote_vm_str()

I mean copy_remote_vm_str() is tiny, so maybe just inline it in mm.h?

get_task_mm() is available from include/linux/sched/mm.h anyway so it's not a
problem to use that there.

>
> This allows us to remove the duplicate code. Does this sound reasonable?
>
> > Now, that's also not completely nice, as I don't want us to EXPORT
> > __copy_remote_vm_str() ... given that these functions are "#ifdef
> > CONFIG_BPF_SYSCALL" could we EXPORT_SYMBOL_FOR_MODULES?
>
> Now copy_remote_vm_str() is EXPORT_SYMBOL_GPL. In this series, we use
> copy_remote_mm_str() without the need to export that. Why do we need to
> consider exporting __copy_remote_vm_str()?

I don't think that's a problem, because all copy_remote_vm_str() is is:

- get_task_mm() (already GPL exported)
- invokes __copy_remote_vm_str()

It already requires that the caller has pinned mm, and I guess the one key
difference is you can't pass some stupid parameter like NULL mm and have it
break.

But if you're kernel code you can NULL ptr deref without anybody's help so :)

The other concern would be accessing a remote mm but... that's literally the
whole point of the function and we already export that.

I guess the other thing is mm copy_remote_vm_str() is only available if
CONFIG_BPF_SYSCALL is enabled but that's pretty much any sensible kernel config
so meh doesn't matter really.

>
> --
> Thanks,
> -Anastasios

--
Cheers, Lorenzo
