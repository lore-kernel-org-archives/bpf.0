Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC972571B8;
	Wed, 24 Jun 2026 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289557; cv=none; b=now39ysVslsnMskJZOCAJRgLrL4Y9oCx81zo1QEW2Ea0nlOGMJmRPfzV1OtLwUxaEvdZju4uHozpsONMVu7ss20zB+x3ceOTo0PZGuCHV2oX9fsr5zau+/qe/vJjRG+kbJJIUp7anPN9ryG5OqiDLVFrqWLwLv4qoMXrrKgDBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289557; c=relaxed/simple;
	bh=eBO/yePEDeXk3iLmCd4SWVFTSeR7fvQhiLDH98yg4fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2iu25pq3uayUwMU+fv41+ow9F0UV9mOEFoaZmzCQEP66IkW0FVvhZ/9LD73UZ17pG4lMXV2dTtSCRCukkgDRIjsf5ptxF9WjS+/zTb4i4YFXWMSm7LUTjG6KRawHGxMwV0YxloBdMarNFcOWiurMUqeOiw93NZPi9npmzjzyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=D4odM0VH; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="D4odM0VH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z7CfbDyWZhn3cEnMkiWiKB1KlydRS3eCFOENPv2RnOk=; b=D4odM0VHZTkVQOyEMH4xvYd8fk
	64TJVmhTkzFUQJV+bByVo24er9pKGRsRD50fmT8Fjd5+NinwvQYlh45fUzEx01S/mE4KbiBLLlhh+
	ycP3wRsZHsE4opJVe87C8hpkP9/VnCWJ5u5kntDZ98UmBykmCYaSllA/NjlWGS1qzlgS9Sf+V2cpk
	xazdTobR5dwIINgo5A4/EIUjZmbm+UVsXVYo/XNdvaej3JUlpLcbbBhra5aOJS8h1zSncor4yktAY
	4LQ+0ApokWx36cRXPlRU0Cb2tE0A0YJOaa25hvR0k67x0S3LbO07enq20eiZ8vVzzowv/bAQDzZjf
	CYye2PWA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wcIvN-002IDE-1y;
	Wed, 24 Jun 2026 08:25:33 +0000
Date: Wed, 24 Jun 2026 01:25:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH] sched_ext: Print deprecation warnings only once
Message-ID: <ajuTUNjgdHjjx2dB@gmail.com>
References: <20260623-scx_warning-v1-1-14bf218f4bd9@debian.org>
 <43d5e4e0-eddb-4a7a-87df-180b9048a038@arm.com>
 <ajqr_biPOFkugwIx@gpd4>
 <ajq30ImUfS9hQV0a@gmail.com>
 <ajrDgwLnu9_FWPUp@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajrDgwLnu9_FWPUp@gpd4>
X-Debian-User: leitao

Hello Andrea,

On Tue, Jun 23, 2026 at 07:33:55PM +0200, Andrea Righi wrote:

> Hm... actually thinking more about it, the existing behavior seems fine already.

I have very few hosts in the Meta fleet that are unnecessarily spammy:

	# dmesg | grep -c "ops->cpu_acquire/release() are deprecated, use sched_switch TP instead"
	73
	# dmesg | grep -c "sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()"
	855

And they are unnecessary, given they show up many times within the same
second, like, 42x times in last second:


	# dmesg | grep "sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated" | grep 806105 | wc -l
	42
	# dmesg | grep "sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated" | grep 806105 | head
	# [806105.018400] sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()
	# [806105.042160] sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()
	# [806105.065668] sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()
	...
>
> The ops->cpu_acquire/release() warning is only emitted from validate_ops(),
> which runs when the scheduler is registered. It's not in the runtime callback
> path, so we should already get one warning per scheduler registration. That
> means we don't need a warned_deprecated_cpu_rel flag.
> 
> For slice/dsq_vtime, the warning is emitted when the verifier sees write
> accesses to those fields. It can fire multiple times while loading one sched_ext
> scheduler, depending on how many such accesses the verifier observes, but this
> also seems correct.
> 
> If we want to prevent potential log spam maybe we can just change those
> pr_warn() to pr_warn_ratelimited()?

Ack, let me transform these pr_warn() in pr_warn_ratelimted() then.

THanks

