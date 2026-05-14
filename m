Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D99135A53
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778796925; cv=none; b=mm3PqycsK6zNO144L/xmbZLl0FK3ocaxX9eGwR4OCuUf/6ed/2qffGTjRgkch6bPy9B1t5rw9wcEJ4QdabZZO3KIlumMQXA2EegvJ0kTt/vdFdjiTmiXXFgdX1DZTv5cVfWDTa860Ze7rkYRK9NCOrmeFDSqRQcXKlZCUmEn5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778796925; c=relaxed/simple;
	bh=kguxQd2EaBSCNhXX888BknLBdmLImd/k5tFAmQ6TXMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru7fwNQGc0WoTEo5FfDvwwQam4Cn5wrMxC+vn2xp60F2nXJuH2p3eENztovRJjiq6jovYaM0R4Tz8G+oubIQ1odyLcjQy9Gsmw6iflS/i01icy83rBW3fKaEcc4Z3Ug+5+9+gQLmmyXsfMyhUMMSMdPEYbnVJcyXi3xyn487lt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUrhoMZ9; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUrhoMZ9"
Date: Thu, 14 May 2026 15:14:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778796912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8outOJgRp0I60QMRn87oyuvVge//gsMrrKDEA8RIHYU=;
	b=qUrhoMZ9h9aKKWGC5yBpJ4BZmZIQOjlOF+54w+dAPuhRXcBDnYi7Jpj3G/U/TCBCOBzQlX
	G7jZIEzgTeGFg62/bBYJVo0bpCp2NPNF/WhqLA64eRxBdz1BLO8scXJWinAYv57FNKiJN8
	+KfjXKNAVsNlVw+pF8MJCBHivIB5iGk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf v4 2/3] bpf: Avoid faultable build ID reads under mm
 locks
Message-ID: <agZG6XF41paiPjgm@linux.dev>
References: <20260514184727.1067141-1-ihor.solodrai@linux.dev>
 <20260514184727.1067141-3-ihor.solodrai@linux.dev>
 <agYzuDIJszA_7rp3@linux.dev>
 <8b83f690-c962-48e5-a557-dea03e4cdf2d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b83f690-c962-48e5-a557-dea03e4cdf2d@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, May 14, 2026 at 02:31:58PM -0700, Ihor Solodrai wrote:
> On 5/14/26 1:47 PM, Shakeel Butt wrote:
> > On Thu, May 14, 2026 at 11:47:26AM -0700, Ihor Solodrai wrote:
> >> Sleepable build ID parsing can block in __kernel_read() [1], so the
> >> stackmap sleepable path must not call it while holding mmap_lock or a
> >> per-VMA read lock.
> >>
> >> The issue and the fix are conceptually similar to a recent procfs
> >> patch [2].
> >>
> >> Resolve each covered VMA with a stable read-side reference, preferring
> >> lock_vma_under_rcu() and falling back to mmap_read_trylock()
> > 
> > Why trylock()? Why not just reuse the mechanism introduced in [2]? That is
> > abstract out the mechanism introduced in [2] in mm core and reuse it.
> 
> v1 used mmap_read_lock() as the fallback, but Puranjay pointed out [1]
> that stackmap can be called when the caller already holds
> mmap_lock. 

Can you exapnd on the scenario where caller already holds mmap_lock? Is this
code path can be taken from bpf programs and bpf programs can be attached at
functions/code-paths already holding the mmap_lock?

> So I changed to trylock since v2, similar to non-sleepable
> path.
> 
> AFAIU this means that the common mechanism needs to support trylock
> behavior as in stack_map_lock_vma() in this patch.
> 
> Do you think this is worth factoring out of stackmap.c?

Do you think we will need similar handling at more places in future
(particularly in bpf world) then it makes sense to factoring out now? Otherwise
we can wait until we are sure.

> 
> [1] https://lore.kernel.org/bpf/m25x611s17.fsf@kernel.org/
> 



