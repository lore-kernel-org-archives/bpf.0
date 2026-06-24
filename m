Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85F26CE39;
	Wed, 24 Jun 2026 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327296; cv=none; b=F3lAria4jjeb62pXJsTibczmjBn+87bxwCDbRhbuAyHtyxGunxsvfynHZo2PPrZAVtxvxhMnXv34Jbic/ny0SZtb0tvlprg6tquxVxW057wZKudp46z/yrKBaGDUzHcez5hdplRzcscI4NcVUjc/nAaBObrT3/K385XHllhM0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327296; c=relaxed/simple;
	bh=ff7HA0BVlXOnwb1I6pupVOPlpbraeZYrtoWeSbWOiKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heYGgmdfXnl9RedUu3RHsJxVvLM0jiw5s/uFXm4A7N56oBiWdkOVDm0r5ZB8C+prBzbqkXN0geXCFD0lM3wChxG969jp8IEErevSX6V13dwVWfUDqmtczZdgoyXFoDlOLXbM8tkQVSzvbmkjzlBOBKRBeeQv6FQjDcKNB2VJnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHGl88Ge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHGl88Ge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ED51F000E9;
	Wed, 24 Jun 2026 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782327295;
	bh=M3+t7e32H1ffuZ+bhSMMn7mtmR59hpew6Rcsdxdm41M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VHGl88Ge3dTtdpKt/7clhOtzbzCtRPNNHA+IsAgks2YqjIoBM00k2jmymHa7hkRww
	 g13GqVYw5ZOVZbMr+XaTXzyrcs80DecVvYRvM8aVe96jcF9X2dT1FN3KoCGmTP7PnO
	 qxNw9zSpufUK5ilqvHLMB0wYRqME9lx3ws3rQzaiKMzk4AQZS2d8lw37GEz9kZeFKe
	 p4dBT2P6NkcZy7QrYsuNKfFqVcXVPpHnlnM7WQIO7BUoW/vdnq1y2NPy5rnEPFDsfD
	 yvzYDab6Wfyv3tN8f0DF7+egN+Yd+sY1v9/C/HbliJpWv/y80vpTQV9EQcVmibNimV
	 9KtZfKS8/QRGA==
Date: Wed, 24 Jun 2026 08:54:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] sched_ext: Avoid flooding the log with deprecation
 warnings
Message-ID: <ajwn_sUcnUiUuf0_@slm.duckdns.org>
References: <20260624-scx_warning-v2-1-07d0d48b0d01@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-scx_warning-v2-1-07d0d48b0d01@debian.org>

On Wed, Jun 24, 2026 at 02:27:43AM -0700, Breno Leitao wrote:
> The deprecation notices for direct p->scx.slice/dsq_vtime writes and for
> ops->cpu_acquire/release() use plain pr_warn(), so they repeat on every
> scheduler (re)load and can flood the kernel log.
> 
> The slice/dsq_vtime notice is the worst offender: it is emitted from the
> BPF verifier's btf_struct_access callback, which is re-evaluated as the
> verifier explores program paths, so a single scheduler load can print it
> many times -- hundreds of lines on some hosts, dozens within the same
> second.
> 
> Switch both notices to pr_warn_ratelimited() so each deprecation is still
> reported but bursts no longer spam the log, and add the missing newline
> to the slice/dsq_vtime message.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to sched_ext/for-7.2-fixes.

Thanks.

-- 
tejun
