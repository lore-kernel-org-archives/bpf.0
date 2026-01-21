Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF142EEAF
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977792; cv=none; b=NSHkFkIUy5N4UmRNJDAel6oP/3WtSE/C65L/18vPZh9nDZOYwkK5aH/fptBgULOtc8F7GQPsiMjbsUBbFYmsFBZc0p56bwXct2nYflwcESb/2NExQlNx6Y9ZYi2ARAEufQGNdLMIi/Tu57+bNPjAaX2RClUZY4f583pGKIxoR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977792; c=relaxed/simple;
	bh=4T+I3aAEvkOtNB6vsmZwp0HlQrhhlZKLH4b4hoEuLaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8e7MGyvOgQNBV+DrpuJDbGSeD6is0HDFSkyMobQWlHjO/E7lFSbFVBbEBxzB002R1AvCoiroanE4rohh+EAKmV5lWvjLtlVA+Yx+XN/rTVQ2SXSsWV4F5qk983Z6STA66+xPaA4impsSd6UZKHk8Nx6OzmRjMU+znMy9cF7YAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PmisL8fV; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PmisL8fV"
Date: Wed, 21 Jan 2026 14:42:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768977788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGJUEukW1YF975sFGms4Vf9mUEAliFTKB8iTKnSd2tA=;
	b=PmisL8fVwidYRQ+1wKoRmywBHe1c9OlAG1/f/voGSFPxt6M1UjYLJ1L+RfuwuIPbNtUL7P
	QxFnWHe3Llnl25im/zg0TMUTItqt6dBizeIPepolof21zfnIeVPrxVDabKRkeBoXCMaBZV
	VFl+rVnVrirg3EbJZ77csqQzMU/XIQ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 16/21] slab: remove unused PREEMPT_RT specific macros
Message-ID: <v6govsosryla4nzgzbfo3eeiziabn2tdprzhg3zcpoxkxq622f@2ra34j7326mn>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-16-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-16-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:36PM +0100, Vlastimil Babka wrote:
> The macros slub_get_cpu_ptr()/slub_put_cpu_ptr() are now unused, remove
> them. USE_LOCKLESS_FAST_PATH() has lost its true meaning with the code
> being removed. The only remaining usage is in fact testing whether we
> can assert irqs disabled, because spin_lock_irqsave() only does that on
> !RT. Test for CONFIG_PREEMPT_RT instead.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 

Looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
