Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC731815D
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145674; cv=none; b=bfxHJMI7yBn4UNQ03eaL9UmpTwKdg7vGN8PSkvZALhJSA3pKhHRSyMYyEPYam/kiJXuL2gExQesymB4MefsgkLcZJP/r21/1udT2mNfXRdLI5M/5Aga4Jp2ED44DPgwdRXsbJHTEhx9xcTS7WcTZDYTfzldOEynOS3K8Cp3QRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145674; c=relaxed/simple;
	bh=4q2GOm1N4IpIGCfMcBHRTAsYMJPr9WGSOlAlYUvlfq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic9czV0GgCZmpoG0kqI5cghNIKTFkGaBZngcFewfL5t60ukVB4v//POXRx6zKJymlc9cwOOs3fu1TjZYnQz9Gh2gGmcQNB7TH0NWvSZnZdxSyqaXxzrPPXu9XYsZPiFte2U+8dGjzaqrRH/+VfK/drZF8aZsFfPJURrh2+hp8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xjxliwVI; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xjxliwVI"
Date: Mon, 18 May 2026 16:07:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779145670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43OgO2OF5H7R43ZRhOnt2E+DP2ym+ONP1Bx6PELiuxQ=;
	b=xjxliwVIsTVqpRoDu9W+fAcJvEIbnG0t9OxUSP3cg6HlVZskMXA6QNBB3X+o63maJnj+9H
	vQQpAkHZJLWuVQeW3/Q+dnNPwK0iZCHLtZh5RB6IjW9L7VqDpSoR1Z3e5L3ctzgQX44gzj
	TpYT2Lwyz6vbUVd12Ys23u5fpg93vfw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Qing Ming <a0yami@mailbox.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yosry Ahmed <yosry@kernel.org>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/rstat: validate cpu before css_rstat_cpu()
 access
Message-ID: <agubZePrBmStHxhH@linux.dev>
References: <20260515122952.59209-1-a0yami@mailbox.org>
 <20260516070849.106141-1-a0yami@mailbox.org>
 <64f59b64664f769661a8b8cd587c85f8@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f59b64664f769661a8b8cd587c85f8@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, May 18, 2026 at 09:36:36AM -1000, Tejun Heo wrote:
> Hello,
> 
> > Qing Ming (1):
> >   cgroup/rstat: validate cpu before css_rstat_cpu() access
> 
> Applied to cgroup/for-7.1-fixes.
> 
> In hindsight, we should have added a separate kfunc wrapper from the
> start instead of tagging css_rstat_updated() with __bpf_kfunc directly,
> which would have avoided the rename. Oh well, it is what it is.

Is it frown upon to change the kfunc signature or remove __bpf_kfunc from a
function? I am assuming we can but better not to, correct?
