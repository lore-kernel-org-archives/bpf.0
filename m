Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA828D830
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769748639; cv=none; b=QyOU2LsgA4EB/fR2EWlEzFGefAsqCembWhnEA//k0r6/qdVCUtpgpTlL81ZD34MyGwTAUdYgR6rFiWUCTmfKNhtI/M36BYFhaYiWpBPgfgFsrYd3uc2ceeFdWRTGzhoFs3iVLCIFwXFmRwO6CW6a5hg4Ifqbs6+fO0NuAsddv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769748639; c=relaxed/simple;
	bh=7K/XRomBO5tGOJNCNL9IdnL/8/ejIP4nyJZzLwfzat4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8c9w9V93cbG6fsTWiVYh8DiTdO7uH4urWok23uif/asdyyKISgJtcESXsqeV0IR1d+x+udnbuJW13oZAui0MsJWgf4gJA9p6g5A+itS3m5iWytbI0uO8Q1Irr7aN7KfI6SQKJmczi4Lx643+x8ZeLKLlGOElYkDH2cdJAh9GDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MTZFazTp; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MTZFazTp"
Date: Fri, 30 Jan 2026 12:50:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769748624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0LolDkIeVgydx+lUvvnJuU5rTPe49ECMjoBW0cqVvs=;
	b=MTZFazTpwQLBt1p5zzHs+rma+lbyv5QWgJkSiS9D4crkD4svGk6zMNRkBBOlfbtGIM7EBl
	x3t9H03Th8ZE0Qej3gyM1d7zBQMDVKS4xaOXnWVv32LGA+bR+zq9bmeU3zks099YfXMfZN
	kTbWJy/VQ4TwieXIANt3LxLHCreyKqM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 00/22] slab: replace cpu (partial) slabs with sheaves
Message-ID: <pdmjsvpkl5nsntiwfwguplajq27ak3xpboq3ab77zrbu763pq7@la3hyiqigpir>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <imzzlzuzjmlkhxc7hszxh5ba7jksvqcieg5rzyryijkkdhai5q@l2t4ye5quozb>
 <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 29, 2026 at 04:28:01PM +0100, Vlastimil Babka wrote:
> 
> So previously those would become kind of double
> cached by both sheaves and cpu (partial) slabs (and thus hopefully benefited
> more than they should) since sheaves introduction in 6.18, and now they are
> not double cached anymore?
> 

I've conducted new tests, and here are the details of three scenarios:

  1. Checked out commit 9d4e6ab865c4, which represents the state before the
     introduction of the sheaves mechanism.
  2. Tested with 6.19-rc5, which includes sheaves but does not yet apply the
     "sheaves for all" patchset.
  3. Applied the "sheaves for all" patchset and also included the "avoid
     list_lock contention" patch.


Results:

For scenario 2 (with sheaves but without "sheaves for all"), there is a
noticeable performance improvement compared to scenario 1:

will-it-scale.128.processes +34.3%
will-it-scale.192.processes +35.4%
will-it-scale.64.processes +31.5%
will-it-scale.per_process_ops +33.7%

For scenario 3 (after applying "sheaves for all"), performance slightly
regressed compared to scenario 1:

will-it-scale.128.processes -1.3%
will-it-scale.192.processes -4.2%
will-it-scale.64.processes -1.2%
will-it-scale.per_process_ops -2.1%

Analysis:

So when the sheaf size for maple nodes is set to 32 by default, the performance
of fully adopting the sheaves mechanism roughly matches the performance of the
previous approach that relied solely on the percpu slab partial list.

The performance regression observed with the "sheaves for all" patchset can
actually be explained as follows: moving from scenario 1 to scenario 2
introduces an additional cache layer, which boosts performance temporarily.
When moving from scenario 2 to scenario 3, this additional cache layer is
removed, then performance reverted to its original level.

So I think the performance of the percpu partial list and the sheaves mechanism
is roughly the same, which is consistent with our expectations.

-- 
Thanks,
Hao
