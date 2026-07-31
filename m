Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288C72E7367
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459734; cv=none; b=PrZYYUR7RA/wd15M/aUt7Z5dQJ7D4vzkNPGQmjkpAwds/qS6uwtJEhYf0ZKy6staqKvElVN2RmP6N8R07V1mUWnSIAtVJvt3u4AVOnttg9+rdVlPGGVSdmfzDo1HVxeWmSWnq/z9amvC8ZxjfOhJBMpI4ic7kTQuoaHlzrDYXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459734; c=relaxed/simple;
	bh=HOz4uN4n+bL54A4PkKqrJDZWDdQ6XJWD8wfPEva1sUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2SA0c8DWxC5tbSpBan5gxzpUMu2Vps+ErJJad+QAg6u5wLmXG4rbpPYOTlUFv/YP0i9uLeqkuieOlwgYQirmViJT70VDp6mBROM6bDg+fpW8lCnTDRh6j8CHOr1fr7ywPVGse5jlLeWyeukAdR94rLftFiU9IkqTVLh/dkKt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=maKEzPYA; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="maKEzPYA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785459728; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=V2Uhm2DyoVU7u3oHG6Ka3Uwg6kU8mde481VD3EZjD/k=;
	b=maKEzPYAkHdKDqO9/FS9UEpc/1XeDXnvljGtsWXepHRIetrq1Y8YpjWN1+O5kFMhvrnXeYaP6Ud6Td4+Yhsr388sWgYXWdqcU0rw9dCqo8ECpPfgIEwN32zYhovDPLkOjYU0O3rdD3SJC3zJZF7HrGTlcZeOf1cuH0lWqY4l/bQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X86N8GH_1785459727;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X86N8GH_1785459727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 09:02:08 +0800
Date: Fri, 31 Jul 2026 09:02:07 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] selftests: net: reuseport_bpf_numa: consider cpuless
 numa node
Message-ID: <amv0DwQoeESq2Cp7@U-2FWC9VHC-2323.local>
References: <20260730113040.75718-1-feng.tang@linux.alibaba.com>
 <20260730113738.41C901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730113738.41C901F000E9@smtp.kernel.org>

Thanks for the review!

Add Andi

On Thu, Jul 30, 2026 at 11:37:37AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Missing NULL check for cpumask allocation in is_cpuless_node()
> - [Medium] Missing return value check for numa_node_to_cpus() leading to masked errors
> --
> 
> --- Patch [1]: [PATCH] selftests: net: reuseport_bpf_numa: consider cpuless numa node ---
> commit 806931cbf2ad9438843e4d30f69b4887e641f7d2
> Author: Feng Tang <feng.tang@linux.alibaba.com>
> 
> selftests: net: reuseport_bpf_numa: consider cpuless numa node
> 
> This patch addresses a failure in the 'reuseport_bpf_numa' selftest on
> platforms with CXL memory where one node is cpuless. It introduces an
> is_cpuless_node() check to skip memory-only NUMA nodes during the binding
> test.
> 
> > diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
> > index 8ec52fc5ef41b..197dbfc475f65 100644
> > --- a/tools/testing/selftests/net/reuseport_bpf_numa.c
> > +++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
> [ ... ]
> > @@ -104,13 +104,35 @@ static void attach_bpf(int fd)
> >  	close(bpf_fd);
> >  }
> >  
> > -static void send_from_node(int node_id, int family, int proto)
> > +static inline bool is_cpuless_node(int node_id)
> > +{
> > +	struct bitmask *cpumask;
> > +	bool ret = false;
> > +
> > +	cpumask = numa_allocate_cpumask();
> > +
> > +	numa_node_to_cpus(node_id, cpumask);
> 
> [Severity: Medium]
> Will this crash if numa_allocate_cpumask() fails to allocate memory?
> 
> It looks like cpumask could be NULL here, which is passed directly to
> numa_node_to_cpus() and numa_bitmask_weight() without validation.
 
Good point. 

If the allocation fail, will return 'false' to let the code go the
original flow.


> > +	if (!numa_bitmask_weight(cpumask))
> > +		ret = true;
> 
> [Severity: Medium]
> What happens if numa_node_to_cpus() fails?
> 
> It can return a negative error value, leaving the cpumask unmodified with
> zero bits set. Because the return value is not checked,
> numa_bitmask_weight(cpumask) will evaluate to 0. Does this cause the function
> to return true and silently skip testing on nodes where an error occurs,
> rather than reporting the infrastructure issue?

From the code logic (with above change), the 'node_id' and 'cpumask' have
both been validated, and this numa_node_to_cpus() is very unlikely to fail
here upon reading libnuma source code.

Thanks,
Feng

> > +
> > +	numa_bitmask_free(cpumask);
> > +	return ret;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260730113040.75718-1-feng.tang@linux.alibaba.com?part=1
