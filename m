Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC14279794
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769409396; cv=none; b=DxWBUhVq9J+ODblkw0LeM2MmgJz73NI1GG6XXd1UJvyPksk/xUkrPnycs6gSEdNhJQAV44pn3ZjKrVPKOKwcj5GaL5dVRNInupUH0uTfZBZE32wQ0CwJ0+KzZGTyNFJYcmpJ9oeahRzLQtKNzs2dd7iwXbNZZQQp9C7UmcRAUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769409396; c=relaxed/simple;
	bh=BhTmaH1yCb9JGyncF6PT0Jp63mkuwt1uIn1/vL2DlQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJLJyRAxX3jHUyQLtCh9SiS37E7AiKI/OQGnl87CaK54zON6c+oxMyOlYGHKgi3YB6Hh0RXwVCRut+9/w/g5SVD5+gw2uQurS0qBpwwrkAER2yakFmZ6SJm6VTq1lOlwwO0Ggm3aQB+2jOshIobP5A5YRM1UW4nZU42U5eYv1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B3DI4qlQ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B3DI4qlQ"
Date: Mon, 26 Jan 2026 14:36:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769409382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pma8RaoRhbP3xu701FMXEsOkee35ycUd5xowwnvWuMw=;
	b=B3DI4qlQnKai6ga7yb/idP0heE4lJ+3GD5sAaZd0I+cbvvalOW3DtYt24T8iijU84Rs/5j
	einKdb1SAWqpZrRCgbe8Efk05xJDUf+HAGnRpxvB4svbwL14OY0+CxWabKrSdG5KnfEGTx
	+5IqYTbZ4Iu5YtSxnJ6MorKla2Kqhzs=
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
Subject: Re: [PATCH v4 06/22] slab: add sheaves to most caches
Message-ID: <7tds765fsicczreeqckiuwpny2tolotfrnbz6jhpjrch6x5pg3@5irfwnohvsli>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-6-041323d506f7@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-sheaves-for-all-v4-6-041323d506f7@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 23, 2026 at 07:52:44AM +0100, Vlastimil Babka wrote:
> In the first step to replace cpu (partial) slabs with sheaves, enable
> sheaves for almost all caches. Treat args->sheaf_capacity as a minimum,
> and calculate sheaf capacity with a formula that roughly follows the
> formula for number of objects in cpu partial slabs in set_cpu_partial().
> 
> This should achieve roughly similar contention on the barn spin lock as
> there's currently for node list_lock without sheaves, to make
> benchmarking results comparable. It can be further tuned later.
> 
> Don't enable sheaves for bootstrap caches as that wouldn't work. In
> order to recognize them by SLAB_NO_OBJ_EXT, make sure the flag exists
> even for !CONFIG_SLAB_OBJ_EXT.
> 
> This limitation will be lifted for kmalloc caches after the necessary
> bootstrapping changes.
> 
> Also do not enable sheaves for SLAB_NOLEAKTRACE caches to avoid
> recursion with kmemleak tracking (thanks to Breno Leitao).
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Also, looks good to me.

As a side node, while looking into the test results reported by Zhao Liu [1], I
ran a quick test of the current patchset with the will-it-scale mmap2 workload.
In my runs, tuning capacity up or down did indeed have a noticeable impact on
performance. Hopefully we can make this tuning even smarter in follow-up work.

[1] https://lore.kernel.org/linux-mm/aWi9nAbIkTfYFoMM@intel.com/

Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
