Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931A1DED4C;
	Fri, 30 Jan 2026 04:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769747961; cv=none; b=PsNIgBYF93GCeRBlgco+MOXXaSEF2qSneYwpUYh2Z7CTBoCFWltcmbHQcdaCEWzgEsb0UarnkaD/xUMCnJ42kgNYZiPoze/7C/kA4SkyX/fWKZK24/KmNRgls2mR8qVsIRGv3qCw5Utj58sxYs4KvrKyo8gAzwJr3HjhOGANT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769747961; c=relaxed/simple;
	bh=i0/RMvNJN0vX2RrWxT3RyzeRpFynfqNNOrY82mACOUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqfPQjADRww+Lo70Z05G6Cw/qn5/1xz9hzIYSGRChjkaa9VkOVbZOoanynUUX6Rr7ldNKw4rztnm0sLTlE2lor9t4+kQBhMmyuRVw66BaT/vURuO7xyjBfLNJIig/Bh6EFnb9CGCl1zASU+FcRx5/2HR+D/YyQt6VWjkfcK+xXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OyHEYLJr; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OyHEYLJr"
Date: Fri, 30 Jan 2026 12:38:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769747957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HsyA5AueEdtbE5hLH2TKuJN9cYQD6jVv3ixFrefE5Z8=;
	b=OyHEYLJrU7YL+ous1MuVbFqxbTC9AgOdi+zr9SgRBQ0J+yhB9u5LyChDx2m8LX3y5uWqrD
	kxxDwarn2Wtwe0xjrmEr5ir7cVGS1SeDHn8LlrEt8UzMT1YsquMsjknofLMGX/V+5cjHbq
	gImY6uj7JHdOqkh1a/x8gFC8a0C1c0Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 00/22] slab: replace cpu (partial) slabs with sheaves
Message-ID: <k3ntrr6kyekjwh2yeawk2pvtiilnoltsxipdzdgzaby2cdon6c@yknpymvklz4y>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <imzzlzuzjmlkhxc7hszxh5ba7jksvqcieg5rzyryijkkdhai5q@l2t4ye5quozb>
 <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz>
 <aozlag7qiwbdezzjgw3bq73ihnkeppmc5iy4hq7zosg3zyalih@ieo3a4qecfxg>
 <aewj4cm6qojpm25qbn5pf75jg3xdd5zue2t4lvxtvgjbhoc3rx@b5u5pysccldy>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aewj4cm6qojpm25qbn5pf75jg3xdd5zue2t4lvxtvgjbhoc3rx@b5u5pysccldy>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 29, 2026 at 11:44:21AM -0500, Liam R. Howlett wrote:
> * Hao Li <hao.li@linux.dev> [260129 11:07]:
> > On Thu, Jan 29, 2026 at 04:28:01PM +0100, Vlastimil Babka wrote:
> > > On 1/29/26 16:18, Hao Li wrote:
> > > > Hi Vlastimil,
> > > > 
> > > > I conducted a detailed performance evaluation of the each patch on my setup.
> > > 
> > > Thanks! What was the benchmark(s) used?
> 
> Yes, Thank you for running the benchmarks!
> 
> > 
> > I'm currently using the mmap2 test case from will-it-scale. The machine is still
> > an AMD 2-socket system, with 2 nodes per socket, totaling 192 CPUs, with SMT
> > disabled. For each test run, I used 64, 128, and 192 processes respectively.
> 
> What about the other tests you ran in the detailed evaluation, were
> there other regressions?  It might be worth including the list of tests
> that showed issues and some of the raw results (maybe at the end of your
> email) to show what you saw more clearly.  I did notice you had done
> this previously.

Hi, Liam

I only ran the mmap2 use case of will-it-scale. And now I have some new test results, and
I will share the raw data later.

> 
> Was the regression in the threaded or processes version of mmap2?

It's processes version.

> 
> > 
> > > Importantly, does it rely on vma/maple_node objects?
> > 
> > Yes, this test primarily puts a lot of pressure on maple_node.
> > 
> > > So previously those would become kind of double
> > > cached by both sheaves and cpu (partial) slabs (and thus hopefully benefited
> > > more than they should) since sheaves introduction in 6.18, and now they are
> > > not double cached anymore?
> > 
> > Exactly, since version 6.18, maple_node has indeed benefited from a dual-layer
> > cache.
> > 
> > I did wonder if this isn't a performance regression but rather the
> > performance returning to its baseline after removing one layer of caching.
> > 
> > However, verifying this idea would require completely disabling the sheaf
> > mechanism on version 6.19-rc5 while leaving the rest of the SLUB code untouched.
> > It would be great to hear any suggestions on how this might be approached.
> 
> You could use perf record to capture the differences on the two kernels.
> You could also user perf to look at the differences between three kernel
> versions:
> 1. pre-sheaves entirely
> 2. the 'dual layer' cache
> 3. The final version

That's right, this is exactly the test I just completed. I will send a separate
email later.

> 
> In these scenarios, it's not worth looking at the numbers, but just the
> differences since the debug required to get meaningful information makes
> the results hugely slow and, potentially, not as consistent.  Sometimes
> I run them multiple time to ensure what I'm seeing makes sense for a
> particular comparison (and the server didn't just rotate the logs or
> whatever..)

Yes, that's right. This is important. I also ran it multiple times to observe
data stability and took the average value.

> 
> > 
> > > 
> > > > During my tests, I observed two points in the series where performance
> > > > regressions occurred:
> > > > 
> > > >     Patch 10: I noticed a ~16% regression in my environment. My hypothesis is
> > > >     that with this patch, the allocation fast path bypasses the percpu partial
> > > >     list, leading to increased contention on the node list.
> > > 
> > > That makes sense.
> > > 
> > > >     Patch 12: This patch seems to introduce an additional ~9.7% regression. I
> > > >     suspect this might be because the free path also loses buffering from the
> > > >     percpu partial list, further exacerbating node list contention.
> > > 
> > > Hmm yeah... we did put the previously full slabs there, avoiding the lock.
> > > 
> > > > These are the only two patches in the series where I observed noticeable
> > > > regressions. The rest of the patches did not show significant performance
> > > > changes in my tests.
> > > > 
> > > > I hope these test results are helpful.
> > > 
> > > They are, thanks. I'd however hope it's just some particular test that has
> > > these regressions,
> > 
> > Yes, I hope so too. And the mmap2 test case is indeed quite extreme.
> > 
> > > which can be explained by the loss of double caching.
> > 
> > If we could compare it with a version that only uses the
> > CPU partial list, the answer might become clearer.
> 
> In my experience, micro-benchmarks are good at identifying specific
> failure points of a patch set, but unless an entire area of benchmarks
> regress (ie all mmap threaded), then they rarely tell the whole story.

Yes. This make sense to me.

> 
> Are the benchmarks consistently slower?  This specific test is sensitive
> to alignment because of the 128MB mmap/munmap operation.  Sometimes, you
> will see a huge spike at a particular process/thread count that moves
> around in tests like this.  Was your run consistently lower?

Yes, my test results have been quite stable, probably because the machine was
relatively idle.

Thanks for your reply and discuss!

-- 
Thanks,
Hao

> 
> Thanks,
> Liam
> 
