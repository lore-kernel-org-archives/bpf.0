Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B21A9F97;
	Tue, 18 Aug 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067297; cv=none; b=SO9QnE7yY6mV1/HerL/9pGAfZT8aPbkjFbkseOpMywzP594Esi/9uB1kmxFfII4wqS4AYKVtfGGqcs+stZ0eDhFMYU6VZo4mLHamDspOdpwSLcQW3qoMkyv7IZuqktXOJ0ulNyyMwziK4GMsdo0WP5MnGP+2nNxL8Fb0LkD9Clo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067297; c=relaxed/simple;
	bh=JpAaPOY70HIcSi3nKGHxEDnVDNYXyksYjrD53OZASAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR0Z2ogho12Vq4wF/18iv2i+Le0pkbCVyWXiNPOFZ8XR9kFKDUWcgx1NYCao7EcZJe4qF1fpDlI7FXcOqnFDb2O2NY7HGcg0id+PGQS5TKKTy7sRMBpSwcMxNfK9FO0mayzi5P9+WjERfm1B2slmCJkxkPcOU/IUlHzVFgWxSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRDOH9kS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRDOH9kS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84F01F000E9;
	Tue, 18 Aug 2026 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787067295;
	bh=wQT+N69ZymfY7ZN2tdlfFkx7UUxCxJ9id+UmuF60iuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MRDOH9kSzQ/U6Uu6GIbkphfibKvvhLTLxEGEYM6zOy6l0+8qyd5quejxPvqG+eXmr
	 2qzI+AkRYCxhxijzuYGTGri4rH2bV1syJTke4CMLVr3Q0gRNYpwDoMsFHR5tbvZHPV
	 MaVyOiFpEJhNVp9MV5L9afSyu5steEiIuHQ7pRGIhCXcwqmjvThHlMf2HToErjLPR/
	 mfnFGdv1XIta5vfGzSTCp+twXyrF5chaLALXeH2jS10Xf6J9Vai5jkf/xj06tJ1hdG
	 yYGfH56owmsfz0Vmkgd+8LhAnpm0gHGAFoQ7LLUpKOA6ZOwkk9cUFuVFTYsbYEEmLf
	 glQ2D7SKO5E0Q==
Date: Tue, 18 Aug 2026 05:34:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH RFC] sched_ext: warn when cpu.max is set but the BPF
 scheduler doesn't implement bandwidth control
Message-ID: <aoR7ngyE44epfzXO@slm.duckdns.org>
References: <20260818135328.174152-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818135328.174152-1-cui.tao@linux.dev>

Hello,

On Tue, Aug 18, 2026 at 09:53:28PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> The kernel stores cpu.max bandwidth parameters in the task_group and
> passes them to the BPF scheduler via ops.cgroup_set_bandwidth() and
> scx_cgroup_init_args, but does not enforce the quota itself. If the
> loaded BPF scheduler doesn't implement the callback, cpu.max is
> silently ignored -- the cgroup gets unlimited CPU regardless of the
> configured quota.
> 
> Of the example schedulers, only scx_qmap implements the callback --
> and only to bpf_printk() the parameters, so no in-tree scheduler
> actually enforces the quota. Measured with scx_simple: a
> cgroup with cpu.max = "50000 100000" (50% of one CPU) and one
> busy task used 9946ms of CPU in 10 seconds with nr_throttled
> remaining 0.
> 
> Print a one-time warning when a finite quota is configured on a
> cgroup while the active scheduler lacks the callback, so users and
> container orchestrators know the quota is not enforced.

We had something similar with cpu.weight and it created more annoaynces than
helping anything. cgroup bw control isn't the only thing the BPF scheduler
may skip to implement. It can also choose to ignore e.g. nice levels
completely too and there's no way to detect things like that. Documentation
is probably the right way to handle this.

Thanks.

-- 
tejun
