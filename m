Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054E3DAAB6;
	Fri, 14 Aug 2026 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740981; cv=none; b=lNnUxPQGtUCkyvrozHDthEZSkCeyUpvZ+yjlbhNzfhNQxBsr0KbGEzKlcQiZuESH6q7ifnv6bcN0eiaSFqatav0Jm2qUGVgdGcGkD0JjGFNkAn4t2pvT8TUiODTzZlw8BrMEF3H/kL1Zh/Ka4+JWNMQY30Q4drqbatqdOrtdOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740981; c=relaxed/simple;
	bh=RLf+S4xWGgtGYLC4QaFImMLxfpR0WVLOSM+dtPHBNo4=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=Kw17wYLpXOve5FBTp5o09HBdeW1qJJH1vCtEGzdEj8BxIQw6yyoPeqQIiVc1GduIhHB0pO8j91ktQAW6jVDdkV6apf1qbqGzfWwIYq+s64Vyc7IbbthIuj771TMs4Fm4UWXCpMqj5+OEk68ygHyILXB1lH1OEQWJFGmqtrbWTMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+sZha+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+sZha+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4C51F000E9;
	Fri, 14 Aug 2026 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786740980;
	bh=RLf+S4xWGgtGYLC4QaFImMLxfpR0WVLOSM+dtPHBNo4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=e+sZha+N7bxdxEVZo86Valxzhaz/7EvcbH2ba7UnxbsssKCdkIv3LX8wthlTNhiaq
	 SLSleslx1FyakSDo+BVfZjPykku8qaVe9CTacP1ypLjWlAA/8EjimVhHNkzWESrtg1
	 johxofRPqFCqjAuZK6+QjsURDGjn2RbOVUOcBYUveM8zCZeMBXZIqF/bQUTRgSdHhT
	 Wf9r5Tv3eBkmCi4CQSoFg5iguWg1x8x37Fdh0VmG9Ucs3FbnSwyuxgklYUXbzo9a36
	 +FcasCcfEMOemqMkgbILJ/ViyK79feLCIwtxzH0Mbz3KHp0aRhX5IIMR0WU6AZHTgt
	 pNtbygssDaqeA==
Date: Fri, 14 Aug 2026 10:56:19 -1000
Message-ID: <003d0a4f1c448113e18f9f5d61d00e99@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: Tao Cui <cuitao@kylinos.cn>,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	suzhidao@xiaomi.com,
	yphbchou0911@gmail.com,
	zhaomengmeng@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
In-Reply-To: <20260814144116.2767304-1-cui.tao@linux.dev>
References: <20260814144116.2767304-1-cui.tao@linux.dev>
Subject: Re: [PATCH] sched_ext/scx_flatcg: expire cached hweights on
 weight changes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, Aug 14, 2026 at 10:41:16PM +0800, Tao Cui wrote:
> fcg_cgroup_set_weight() updates cgc->weight and the parent's
> child_weight_sum but doesn't bump hweight_gen, so the hweights cached by
> cgrp_refresh_hweight() stay stale until some task activation bumps the
> generation. For cgroups whose tasks never go through a 0->n runnable
> transition (e.g. persistently busy ones), a cpu.weight change never
> propagates to scheduling at all.

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
