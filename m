Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A23BCD0E;
	Thu,  1 Oct 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851079; cv=none; b=kd4l7fAxtnStb/86ubPRRc9kcDMwu4qgR966dt5bi8AZmvQmBAudwT6qE/OF6Eq0uKo+dCLzaSqsLCCrVr/78me/VloaNn3IyD3A/uqBObiLUqYtCharv6O0o09FtmE/F8wFlU4v1KSQSt88WRUGo7EayRm7W0Mfshb4Vp35qk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851079; c=relaxed/simple;
	bh=hDaozcCR4RN1nJEoUk7pYsmyoc606N1f2ytFwIN6pU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B7CU18rU6q0IcyPvCNWowahn5uU9aB6LMG+7PCaZmfpb1XoeqvzKtuvprsiZjbNnhh0tyvfqZ3ZIJCwiQpa8oNnBAZkn2pgESqL9xcaVN2oZCM10ISpUiSGMzaecKT5nqjcZf+j+VIqJXqlTxJKwOdEkOcZfjWRY65KfU+piOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlJPqMAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlJPqMAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653961F000FF;
	Thu,  1 Oct 2026 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851072;
	bh=As3SLFsTTd3BkmHYiCD2iWsyZrxMnUXWbkatlHucL9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DlJPqMAgPjswboeJf2ZIyMb3gQ6nXatEo55osqdNvVcFDqljtXE77eRNkSofmCbPj
	 XY72PX/+SX+8Fo7J73MaKaH6Zh6+cSbR8vwy0YqASElxUrRfGuz+nCFye/tdTvf1nQ
	 le/N6yXhpL9jf4h5uikRXqm7fy3o2BFPASx5uixhD9yWq8o/5NUMrTsGFw7xZm7HQX
	 EncNejZrT3GOjd0gkbk6rVQVmgxel6UmaSg8PIXWYlMyyJZD4jzTuhQCtH7woNU2G/
	 DeT82FckWr5JICgiAOQYsIVFenK7UzOfo4oLU1DPMkiZ9NaXo4R/od+rLQhSIzOKyV
	 V+1i2pkN0RQwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261001102909.1152572-2-vineet.gupta@linux.dev>
References: <20261001102909.1152572-1-vineet.gupta@linux.dev>
 <20261001102909.1152572-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:37:51 +0000
Message-Id: <20261001103752.653961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tracing: mixing goto and scoped_guard in alloc_retstack_tasklist()
--

commit eacae2b1226bb2d8684604b5c37e3ec9f073cb80
Author: Vineet Gupta <vineet.gupta@linux.dev>

tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT

This commit updates alloc_retstack_tasklist() to allocate return stacks
inline using GFP_NOWAIT within an RCU read-side critical section,
replacing the fixed-batch preallocation loop. It also replaces the
open-coded rcu_read_lock() and rcu_read_unlock() with scoped_guard(rcu)
to handle RCU protection implicitly.

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 40d373d65f9b9..efb5d260334e0 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c

[ ... ]

> @@ -1057,26 +1060,37 @@ static int alloc_retstack_tasklist(unsigned long =
**ret_stack_list)
>  		}
>  	}
> =20
> -	rcu_read_lock();
> -	for_each_process_thread(g, t) {
> -		if (start =3D=3D end) {
> -			ret =3D -EAGAIN;
> -			goto unlock;
> -		}
> +	scoped_guard (rcu) {

[Severity: Low]
Does this code mix goto-based error handling and scope-based cleanup in the
same function?

The alloc_retstack_tasklist() function still contains a goto free error
handling path earlier in its body, and a free: cleanup label at the end.
Adding scoped_guard() here violates the kernel cleanup subsystem guidelines,
which state that for a given routine, usage of goto and cleanup helpers
should never be mixed.

Since returning directly from within the scoped_guard() skips the free: loop
at the end of the function, it forces manual reasoning about whether that is
safe. This is noted in the new comment about keeping the start =3D=3D end c=
heck
in step with the exhaustion logic.

Is it possible to convert the initial return stack array allocation to use
scope-based cleanup as well, or revert to open-coded RCU read locks, to
avoid mixing the two patterns?

> +		for_each_process_thread(g, t) {
> +			unsigned long *rs;
> +
> +			if (t->ret_stack)
> +				continue;
> +
> +			rs =3D kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
> +			if (!rs) {
> +				/*
> +				 * Returning from inside scoped_guard() drops
> +				 * the RCU read lock, but skips the free loop
> +				 * below. That is only safe because start =3D=3D
> +				 * end here, which leaves that loop nothing to
> +				 * free. Keep the two in step if this
> +				 * exhaustion check ever changes.
> +				 */
> +				if (start =3D=3D end)
> +					return -EAGAIN;
> +				rs =3D ret_stack_list[start++];
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001102909.1152=
572-2-vineet.gupta@linux.dev?part=3D1
