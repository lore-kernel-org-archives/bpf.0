Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54D22157B;
	Tue, 21 Jul 2026 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784607678; cv=none; b=DJrpRC3AJ4QmKre41mBPofaDKQCNVA/hH56pSvXCRKn7xy1DVIfhWot3erct3r5SFBFq3e344L7MEJlh9EQ7g5i1xBc6xZvpDNr5Glu3WPmIzIWxn68rcMirBBZEqxxlLJxTHQSiP9xE8ghWwnSA6WDdL7LV0w34kS0JC6gjyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784607678; c=relaxed/simple;
	bh=BhDAf/hzvjT5Hxc/kltpkXT4SjaPx+kytqxgoGIDY6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP+qj65Anp8vuNSkPE22wGYDzgBgKpTd2WU3DTzuIfkuMNBzQ2Y2HzCQ/P0/ag6qaPite26WmAgXddYIYeiqjZnatC1FRh3ZTDRXOnMff++AyiMwfrVUFCm4ih6lE4pfnBSJc6UTQ2rMcChNujHMHQnMmej2uu8N0asqIdEDAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iarXXAPp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iarXXAPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A301F000E9;
	Tue, 21 Jul 2026 04:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784607677;
	bh=dMHccTkWfwnMZnE8iTx+9aXqPgPG/0UfrAZGeol7M0k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=iarXXAPpk5grgNiNHJ9+0ORfs+eqwINWGlhJV23J0hy9Oh6vOPKEQEcGJJEfpsbQJ
	 99slihQd1VusX1ACoiVNMkcamd34VXv4ji1rTbAw0kOFQpagTXV1+T4AiSFycyVNeG
	 fwRr5qcfoUkuYyl+7NvukQqJ0df6dFAYy0ff8+3BFxBLQJzhVMUbIWWrFiF+xtaEXR
	 zoYQ6qidCneViV5uuh/Ikv9xz74AZNUKqCgxSurdDPCCWK+QYfx+Rh1vo7SARh/j4G
	 CwGUo4apsDVdu77gJx8WEYfUJnWJwjWBeWjnFlRsCNFb+z73d0y3a/5SWpWBJQqwVE
	 FaewjKVP9QIIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 505A6CE0F85; Mon, 20 Jul 2026 21:21:17 -0700 (PDT)
Date: Mon, 20 Jul 2026 21:21:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>,
	Catalin Marinas <catalin.marinas@arm.com>, puranjay@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <5b83b0a0-708a-458a-bdbd-41c6d4610349@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
 <20260720153917.2e428e489cd0873ac6d4e6da@linux-foundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720153917.2e428e489cd0873ac6d4e6da@linux-foundation.org>

On Mon, Jul 20, 2026 at 03:39:17PM -0700, Andrew Morton wrote:
> On Mon, 20 Jul 2026 06:23:45 -0700 Breno Leitao <leitao@debian.org> wrote:
> 
> > kmemleak_scan() can run for ages on large debug kernels. It was
> > causing some soft-lockups which I got fixed with commit
> > 3175fcfec8b16baeb ("mm/kmemleak: avoid soft lockup when scanning task
> > stacks") with our beloved cond_resched().
> > 
> > I've got the fix above deployed in the Meta fleet, and now I am seeing:
> > 
> >   INFO: rcu_tasks detected stalls on tasks:
> >     task:kmemleak state:R ... nvcsw: 274/274 holdout: 1 idle_cpu: -1/3
> >      scan_block
> >      scan_gray_list
> >      kmemleak_scan
> > 
> > and, worse, blocks the callers waiting on that grace period. Here a BPF
> > struct_ops map free, which waits via synchronize_rcu_mult(call_rcu,
> > call_rcu_tasks), is stuck long enough to also trip the hung task check:
> > 
> >   INFO: task kworker/...:bpf_map_free_deferred blocked for 122 seconds
> >      __wait_rcu_gp
> >      bpf_struct_ops_map_free
> > 
> > Then I've learned that cond_resched() is not an RCU-tasks quiescent
> > state, so, we need to use stronger primitives.
> > 
> > Use cond_resched_tasks_rcu_qs() at the scan reschedule points so the scan
> > reports an RCU-tasks quiescent state as it proceeds.
> > 
> > Inspired by commit b96285e10aad ("tracing: Have osnoise_main() add a
> > quiescent state for task rcu").
> 
> I'll add
> 
> Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
> Cc: <stable@vger.kernel.org>

Thanks to all three of you!

This adds fewer than ten calls to cond_resched_tasks_rcu_qs(), but still
more than doubles the number of such calls outside of the RCU subsystem.

Which is most likely just fine, and in any case absolutely should not
get in the way of Breno's patch, which after all solves a real problem
in the here and now.

Nevertheless, on the off-chance that over the next few months or years
we start playing cond_resched_tasks_rcu_qs() whack-a-mole, I figured it
would be good to get a head start on writing up alternatives.  An initial
draft may be found here:

https://docs.google.com/document/d/1s3fn29SCTYVw9jak4iraNIVQR59Wk5C6_I-_eu-MfQA/edit?usp=sharing

TL;DR:  Should we get into a rousing game of whack-a-mole, alternatives
include continuing as we are, making the existing calls to cond_resched()
in turn call cond_resched_tasks_rcu_qs(), decoupling mutex-induced
hung-task warnings from synchronize_rcu_tasks(), and various
not-so-practical alternatives to RCU Tasks for trampoline synchronization.

Thoughts?  Especially thoughts on other schemes?

							Thanx, Paul
