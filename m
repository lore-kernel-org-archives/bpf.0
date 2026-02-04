Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93FD426ED6;
	Wed,  4 Feb 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770229837; cv=none; b=FWFZaL3RHlnZk1YmTwvIG67JSn2qpHleYUDy59h7/ghzvWSMeVY63vf8JiLVgoKGJX3eKuZj/hKjHc3IvHFfm75Rf3RmjOXa1HVoQ0sL3F8fC8Lp9Wpp1gJOkRwT9ndH1zEB7g3fGoLCKyR7iP3LWzt1k3lmPgjbW4uQj9u7iwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770229837; c=relaxed/simple;
	bh=OdUb25hwDf7Td6RZQE9eems/6ez37ij9pWo0A8i9afc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NbNBWg45wdoRvJjCVzKEsTJ1FIXgRoN8t77rjpUs8tSY5J2GhLjYh3qjnZa+jmrZ7vjIGmBc/l9NLlv4OceKlgmzdYzo0rTXavgM9E0cfzI9K9Kb4m9O2vhOXaRentD6U05iXTrLpqJXda9n/KXQMsOtV2HH+lgGAobQBeocKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=I0BY7Y2K; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="I0BY7Y2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1770229486;
	bh=OdUb25hwDf7Td6RZQE9eems/6ez37ij9pWo0A8i9afc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=I0BY7Y2Ka/1RFhZQ0vnJeovKXCgV64QfqBLB20+WoAG393kfyRXpGop8523cdl0VA
	 dzsVy17LbKM3hf65ipzajQZTot0/H11NeCXwD+vyWP8lZnbpMvbf/NHRoS+yVYF7YQ
	 Z/izDqFw7B8V9Orz+bH1Ur0dya3OhhPoiq7Axm1k=
Received: by gentwo.org (Postfix, from userid 1003)
	id 98963401E2; Wed, 04 Feb 2026 10:24:46 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 95C19400CA;
	Wed, 04 Feb 2026 10:24:46 -0800 (PST)
Date: Wed, 4 Feb 2026 10:24:46 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Hao Li <hao.li@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
    Petr Tesarik <ptesarik@suse.com>, David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Uladzislau Rezki <urezki@gmail.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
    bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
    kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org, 
    "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 00/22] slab: replace cpu (partial) slabs with
 sheaves
In-Reply-To: <665ff739-73d8-4996-95e0-f09c3e5b6552@suse.cz>
Message-ID: <2abde505-1e35-8d74-2806-7a3cd430e306@gentwo.org>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz> <imzzlzuzjmlkhxc7hszxh5ba7jksvqcieg5rzyryijkkdhai5q@l2t4ye5quozb> <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz> <pdmjsvpkl5nsntiwfwguplajq27ak3xpboq3ab77zrbu763pq7@la3hyiqigpir>
 <665ff739-73d8-4996-95e0-f09c3e5b6552@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Feb 2026, Vlastimil Babka wrote:

> > So I think the performance of the percpu partial list and the sheaves mechanism
> > is roughly the same, which is consistent with our expectations.
>
> Thanks!

There are other considerations that usually do not show up well in
benchmark tests.

The sheaves cannot do the spatial optimizations that cpu partial lists
provide. Fragmentation in slab caches (and therefore the nubmer of
partial slab pages) will increase since

1. The objects are not immediately returned to their slab pages but end up
in some queuing structure.

2. Available objects from a single slab page are not allocated in sequence
to empty partial pages and remove the page from the partial lists.

Objects are put into some queue on free and are processed on a FIFO basis.
Objects allocated may come from lots of different slab pages potentially
increasing TLB pressure.


