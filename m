Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F374BE1;
	Tue, 23 Jun 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233131; cv=none; b=cAOBcMQkP2WluPf8/atFlYUwYJD012hULksZ2Sp/hyWu0LYo2zNLwOipVDRRHA9UM6+1SJhHG3dnh8ylZs8dk0bK5WKwWI88Bv2puYmzFza6C+FfRJ9ftcJ+rfzgxFJHx/SXObfOqeU8ybNl3hgk++LVooeeV9UKRabWUWmRbnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233131; c=relaxed/simple;
	bh=OB4gy1VhVKPRilh54Umn5yheDd5l4iqEv0z10dGaxq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPnuW12glvBQecMvGSYJ6G3HUoJdl3+NBFYW6R76syd77FXY8O3+IuVdfZoMG+f3BgECLTeq490KPIE+jZorLA8HLEcPE4r45QaLsrQ1MiYN4IjaUMFnDNeQYfOzuVXMl42LmWTfh42nFD2hh29HuEFASBBRNtoqMKeZIl+8nAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=LPx8puZn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="LPx8puZn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z4VBSdFnEmU7R8FtoA9ZcQo8w65eyGrO4vC7iwPTymI=; b=LPx8puZn2cCuh9hU5DVgH5XaIw
	csOrO2zX5fJetXSp1HSaUF8og9RhAWlNnevkSsx5XdYUedvFAFor/lsIKkhDUXdcP/FAY0TPn2MYi
	IKMrjKxtWMvHcrfWwjBDIeAlvovTL4aDSbTecTR47qeRxTP3ym0xSibVf+YmYfG5yrcDc+lsHAckP
	P/6rxfm1x1q1T4FXO566iKVOyCMYn3gkhZRxQ/NR7bT+4EfkMt0lcOmfijskm2LkTS4xDRNjVXfqj
	6xhwWLQWoDy5No6U7BWTz1VDU+9VJvXAg+6aAQWNsg0UvEbvEI/9xAeZwki/y4WKaU0koUPOYSNX/
	HyxAvmlA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc4FM-001mzC-0H;
	Tue, 23 Jun 2026 16:45:12 +0000
Date: Tue, 23 Jun 2026 09:45:06 -0700
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
Message-ID: <ajq30ImUfS9hQV0a@gmail.com>
References: <20260623-scx_warning-v1-1-14bf218f4bd9@debian.org>
 <43d5e4e0-eddb-4a7a-87df-180b9048a038@arm.com>
 <ajqr_biPOFkugwIx@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajqr_biPOFkugwIx@gpd4>
X-Debian-User: leitao

On Tue, Jun 23, 2026 at 05:53:33PM +0200, Andrea Righi wrote:
> Hi Breno and Christian,
> 
> On Tue, Jun 23, 2026 at 04:45:55PM +0100, Christian Loehle wrote:
> > On 6/23/26 15:38, Breno Leitao wrote:
> > > The deprecation notices for direct p->scx.slice/dsq_vtime writes and for
> > > ops->cpu_acquire/release() use plain pr_warn(), so they repeat on every
> > > scheduler (re)load and flood the kernel log.
> > > > The slice/dsq_vtime notice is emitted from the BPF verifier's
> > > btf_struct_access callback, which runs once per write access and is
> > > re-evaluated as the verifier explores paths, so loading a single
> > > scheduler can print it several times. The cpu_acquire/release notice is
> > > printed on every scheduler enable.
> > > 
> > > Switch both to pr_warn_once() so each deprecation is reported a single
> > > time, and add the missing newline to the slice/dsq_vtime message.
> > 
> > I guess this should be warned for once per BPF scheduler like
> > sch->warned_deprecated_rq
> 
> Yeah, I agree. The thing is that we can load multiple different BPF schedulers,
> and we'd want to get these messages for each of them. So ideally we need
> something like sch->warned_deprecated_rq.

Agreed, pr_warn_once() is too coarse - it mutes the notice for every
scheduler loaded after the first one since boot.

For ops->cpu_acquire/release() this is easy: the notice comes from
validate_ops(), which has the scx_sched, so I'll gate it on a
per-scheduler warned_deprecated_cpu_rel flag, just like
warned_deprecated_rq.

The slice/dsq_vtime notice is the one I wanted to ask about. It's
emitted from bpf_scx_btf_struct_access(), the .btf_struct_access
verifier callback.

That runs at program load/verification time, before the struct_ops is
registered and the scx_sched is allocated (that only happens later in
scx_enable()). Any idea on what to do in this case?

Thanks,
--breno
