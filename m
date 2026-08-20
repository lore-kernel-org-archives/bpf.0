Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09313486E69
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261322; cv=none; b=BW7jGGAZ51PbiSR8kLzEM/lZkd674Y2j4GOoTSEBV1yeWV65FLGmw+HwIx0BDJQhmWl+tLhUbdPUCaMGm5pdFpyNzHQPeinyKn20rU/iTfG1faSSTR0SWGv+1t+ZQob4PCB0nZqcPI6QkxkToPT1Fd+v7cST2juhyprXe6h6PBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261322; c=relaxed/simple;
	bh=AcQr+oaQcouJMFo+yfMS6b251bxyLXpgdJLEwi+GHxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VPjdg9iKvMK+Pn7VqnzHSNiLOvF6XFCZY68OjyPmtAveEPlCyitGSxQ6kOPLu2j0FaYzeTyK1mdW6hObTngScMmL38uIdujG0ydgTJWWVooJWWrJ2yAj55k4v/hhPLbMKFkNNSy4uc6eLeEiPWEX5lXu420dVerojFFlXONQgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyuXLmDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyuXLmDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD15E1F000E9;
	Thu, 20 Aug 2026 21:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787261320;
	bh=HT35Jqu3tMdKrjmWpd/bm/H6sxdr0hePs1hewUhardw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NyuXLmDa6c74RlRJ3pIxZVDXeoYcg4QLgOR81fZe19gBvN4UCEkq7kGqv5+KMuzzo
	 ODmjMfM7baAH6O2Q6jp/wbqkC0QBcyH/LvYNRIzoLEsW/7mt8wsnD7Z+mtXIqfQ+Zv
	 JJEZK2mGHgTx1Wy8RWYrzKe0pbgmlopGHYRIi/fowuSANut2lUVO+bjrFZUp/5vZn6
	 KrPXr9zPnguEZysIOBypHnPZOS/jt8u9+6fsh/fmWQPOz4YIlCVxAr3iNNlbihnkFx
	 oRZfol+ppsnbaFAdk9ZSimU9PBwl9faVJURReII/jERZSM3kclRmefn+RZ1KYVxn9O
	 E44hCQjOg6RbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] cgroup: add BPF kfuncs to read a cpu cgroup's
 stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: bpf@vger.kernel.org, hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com
In-Reply-To: <20260820211758.3393984-2-ziyang.meme@gmail.com>
References: <20260820211758.3393984-1-ziyang.meme@gmail.com>
 <20260820211758.3393984-2-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:28:40 +0000
Message-Id: <20260820212840.AD15E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `bpf_cgroup_base_stat` kfunc is exposed to all BPF program typ=
es but unsafely acquires a non-NMI-safe lock and unconditionally enables ha=
rdware interrupts, leading to IRQ state corruption, NMI deadlocks, and PREE=
MPT_RT panics.
--

--- Patch [1]: [PATCH v3 1/4] cgroup: add BPF kfuncs to read a cpu cgroup's=
 stats ---
commit 41558082c4ece37f910c5109f3537477a7ba8820
Author: Ziyang Men <ziyang.meme@gmail.com>

cgroup: add BPF kfuncs to read a cpu cgroup's stats

This commit adds BPF kfuncs for reading CPU cgroup statistics. It registers
css_rstat_flush() and bpf_cgroup_base_stat(), allowing BPF programs to read
CFS bandwidth counters directly.

> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index de816a43db9f0..5db72504a8a5a 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c

[ ... ]

> @@ -752,10 +752,49 @@ void cgroup_base_stat_cputime_show(struct seq_file =
*seq)
>  	cgroup_force_idle_show(seq, &bstat);
>  }
> =20
> -/* Add bpf kfuncs for css_rstat_updated() and css_rstat_flush() */
> +#ifdef CONFIG_BPF_SYSCALL
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_cgroup_base_stat - Read a cgroup's base statistics
> + * @cgrp: cgroup to read from
> + * @out: zero-initialized output in nanoseconds
> + *
> + * CPU time is adjusted as for cpu.stat.
> + */
> +__bpf_kfunc void bpf_cgroup_base_stat(struct cgroup *cgrp,
> +				      struct cgroup_base_stat *out)
> +{
> +	if (cgroup_parent(cgrp)) {
> +		__css_rstat_lock(&cgrp->self, -1);
> +		*out =3D cgrp->bstat;
> +		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
> +			       &out->cputime.utime, &out->cputime.stime);
> +		__css_rstat_unlock(&cgrp->self, -1);

[Severity: High]
Does this code unconditionally enable hardware interrupts when called from
arbitrary BPF contexts?

Since this kfunc is registered under BPF_PROG_TYPE_UNSPEC without context
checks, it can be called from tracing programs (like kprobes or perf_events)
that may run in NMI context or with interrupts already disabled.

If it executes in an interrupt-disabled context, __css_rstat_unlock() will
unconditionally re-enable hardware interrupts and violate the caller's lock=
ing
assumptions:

kernel/cgroup/rstat.c:__css_rstat_unlock() {
	...
	spin_unlock_irq(lock);
}

Also, could calling this from an atomic tracing context cause a panic on
PREEMPT_RT, since spinlock_t is a sleeping lock there?

> +	} else {
> +		root_cgroup_cputime(out);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820211758.3393=
984-1-ziyang.meme@gmail.com?part=3D1
