Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7D44AB73;
	Tue,  1 Sep 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292807; cv=none; b=lfehKXuSN8hFCS1QZR6XvWLfYbDn+NYGb+EANgU5Kw6AYPaqot+rkYYXVOvY8vnKYfpxk6BfQaORTlmdNh6Vt7oBOpXDWp1p2ZhbVsZRUxRTS0E+IWPACUIGAsvtDpNCxWOmDcVr/B4nFs4j1tSwFVmMEhERd9iLeyJbdEo9gSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292807; c=relaxed/simple;
	bh=aQql2YRv/pgfDCBn1PmiE/3tmQGkR03E6PhizV1BDEA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hJrWdjUAP0J1sYXLM5WAzsmv0UolkKDId9Pj8e8YgposIp4k0ek0TVEp2OcqSJL4mUgXdnJ2Tl1KTrt8I6OqcL6J4IMK2Qv+eAftGaC5dFnwK/ftwIG094wYlsk6/V6/cqv39hkIdXWwhsUEkiQwA7XbhU547p5s4zLL+XhnfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKri+h2U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKri+h2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518FA1F000E9;
	Tue,  1 Sep 2026 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788292806;
	bh=x8ne1XM2bSRV9CT1YSQkYZkGNtakHzf4uo5sXmp698s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CKri+h2U5TQ0x3ZLArs2QcwfaZRriksEDb1ShH4pEOwejiydAykaI5uuWmiHeKM/p
	 Ph3NNni4osejfj9dbnHJJ7urjKdsKLIV1IOV+U/4tZemygQnfZl/wGjaVIaQtO/aTS
	 dpR6makm3+PNMBhd3KCF8ZLrDGmlOK+dWdHwtPL5oz1EAabNZz9vZ1xO37CQGVIDjJ
	 wOuRujqyvQ5lSD32KAXOSzFpdmTgLgQj9Tqdum8wN+g6frE+pKN2DkLz2YQX3maiOg
	 p6yhOShxBwg2/UCDuQygbjgj0aJ43NpeyZLzS7piKd+vgnHNgAA9cnGg9wyqBYUVOF
	 IgJ99aICAxzYg==
Date: Tue, 01 Sep 2026 10:00:05 -1000
Message-ID: <beadefcfd5ae112a703b2514f6eebf34@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: arighi@nvidia.com, void@manifault.com, changwoo@igalia.com,
 michalblk@google.com, liwanwu@kylinos.cn, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 2/2] sched_ext/scx_flatcg: make cgv_node_less()
 wraparound-safe
In-Reply-To: <20260901140343.764080-3-cui.tao@linux.dev>
References: <20260901140343.764080-1-cui.tao@linux.dev>
 <20260901140343.764080-3-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

On Tue, Sep 01, 2026 at 10:03:43PM +0800, Tao Cui wrote:
...
> long-running host. At the wrap instant the plain comparison puts the
> wrapped node behind everything else permanently.

Plain < puts the wrapped node at the front. The unwrapped ones get stuck
behind it. Also, each CPU picking a cgroup charges it a full slice, so the
wrap is closer than weeks.

...
> cyclic comparison is valid as an rbtree comparator only because
> cgrp_cap_budget() clamps every node to within max_budget behind
> cvtime_now, so any two nodes are far less than 2^63 apart and the
...

cgrp_cap_budget() only bounds the lag. The lead is bounded by the slice
charge plus pending cvtime_delta on re-insertion.

> Fixes: 7b742aa2c2c9 ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")

Not in mainline. The upstream commit is a4103eacc2ab.

> +	/* wrap-safe: cap_budget keeps nodes within 2^63 of each other */
> +	return (s64)(cgc_a->cvtime - cgc_b->cvtime) < 0;

Use time_before() and drop the comment.

Thanks.

--
tejun
