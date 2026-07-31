Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E7372EF0
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528432; cv=none; b=C52eRfWuNZ6HtUeBtXCwGQqRtfU9QNM+Px/bsK7MnAak8s2H/3zcdO86n98j74L4jrHMJzJEoMGSjjzJvEvlHlCeDgMy1wi7KV3F2LXS3rzFB1EhvUa7bNFuBbxgrksfy7E+nIbUZQEzYhnPY+UNZwkTM3bgLtA6EWuBPY6mY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528432; c=relaxed/simple;
	bh=dZ5HeMLWNOM5arXMYk0DUQH+oYKXmnyPQU0ZWimVOPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQRie3zHduUXkPYRs7U3owwONM5gIjNX/cYZvKQgXrBA8d2skJrxlcSoGovaNEMabT6Nu29kOHfsoyfwK7Keo8Mi1jgtlHm7tWGWwH20MjMaRXMKEAlfriW1cJPT2LplaE93SkCvCKzBSh/RxNMC8PWxa3zrPUfumBaWKdtegq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=aivxJmcD; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="aivxJmcD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1785527963;
	bh=dZ5HeMLWNOM5arXMYk0DUQH+oYKXmnyPQU0ZWimVOPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aivxJmcDhf4WPUVeECaPu98Z9CiHXYmXWc15lMcZ6IcI2PqmW770ON2jVAHB0qXmm
	 up0PWijDrp1dTYBRfHBkjClJElKDrLwsK9tYaVH+6bW6EkhK3qdg4gXRmEGnqehs6q
	 u/2QkF6iebLCoZiz2NvdKb9qe4fwf2eFdFDE/TIE=
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 9D4515E82B; Fri, 31 Jul 2026 21:59:23 +0200 (CEST)
Date: Fri, 31 Jul 2026 12:59:23 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH] selftests: net: reuseport_bpf_numa: consider cpuless
 numa node
Message-ID: <amz-m8cu0lYc8LzR@firstfloor.org>
References: <20260730113040.75718-1-feng.tang@linux.alibaba.com>
 <20260730113738.41C901F000E9@smtp.kernel.org>
 <amv0DwQoeESq2Cp7@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amv0DwQoeESq2Cp7@U-2FWC9VHC-2323.local>

> > Will this crash if numa_allocate_cpumask() fails to allocate memory?
> > 
> > It looks like cpumask could be NULL here, which is passed directly to
> > numa_node_to_cpus() and numa_bitmask_weight() without validation.
>  
> Good point. 
> 
> If the allocation fail, will return 'false' to let the code go the
> original flow.


While it's technically true, checking for out of memory in ring 3
(or at least other checking than exit(1) on error) is usually 
useless. Most of the time when this would fail you're as likely
to just get killed by the OOM killer, as well as the harness that
called you. Maybe it could happen without that with some very tight
ulimit settings, but with that not much else will work anyways.
Also these paths are basically never exercised so likely buggy
when non trivial.

For libnuma if you set numa_exit_on_error to 1 it will always
exiting after printing an error. That includes the allocation
functions.



> > > +		ret = true;
> > 
> > [Severity: Medium]
> > What happens if numa_node_to_cpus() fails?
> > 
> > It can return a negative error value, leaving the cpumask unmodified with
> > zero bits set. Because the return value is not checked,
> > numa_bitmask_weight(cpumask) will evaluate to 0. Does this cause the function
> > to return true and silently skip testing on nodes where an error occurs,
> > rather than reporting the infrastructure issue?
> 
> From the code logic (with above change), the 'node_id' and 'cpumask' have
> both been validated, and this numa_node_to_cpus() is very unlikely to fail
> here upon reading libnuma source code.

Yes it's unlikely to fail.

-Andi
