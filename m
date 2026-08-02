Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88941A285
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785656879; cv=none; b=mTIV8AVSfEwMXRP2ZwYbtJqVHUDQ+4v2AUiCZ/jvet02NL3ZazAGbwZH58dHsNuyWwxQMZSheqTDfCBKe37W4r1JV3DfVz3AGuiyDTYg5FOYuNsWk1waPK/giC/wdc+hg+vfpa6q5TOAEKY1nVYzbB05yRJqUFS1CxOHPAD0VDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785656879; c=relaxed/simple;
	bh=XjPQ/xZWThddxTJkuGLtSU3m012G+3vFPGZbmTmZY5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+xqfOKT8PaDdMMwvavnziWusZWfeeVQ01VWyQi9rW108Rdt7U9Wu4bIqtlD5vx4OW41SDqjSqGicNCF6KBZkV19WwtZGbMoK9kx3rPaOupGM238IUJ6zPf71iSGNmEPOQg51H/0yAnbADrSIEUNbOmYQPcs0GMOY12SpVB2J9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kdtd+QI3; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kdtd+QI3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785656868; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=/NS4NnWVSUKGBz+I/sNmTYwrW0tng0AM1n4B2vTPhSI=;
	b=Kdtd+QI3f+xGc8p0C/D7L2kMRYyTNqyCgpU4KMm2Ad20CpGkxRgaWHghAHK7h1da6YL4GYPfM2Za65+4O+xSWwyBvW40qdB9yp2+4uB/n+k/NjoXNMuMQHUlAQ+sCPupSNw0Fm+xvyEDRoFbNozc30tLolod4MfR0QLM24zlefs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X8BjgAK_1785656867;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X8BjgAK_1785656867 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 02 Aug 2026 15:47:47 +0800
Date: Sun, 2 Aug 2026 15:47:46 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andi Kleen <andi@firstfloor.org>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH] selftests: net: reuseport_bpf_numa: consider cpuless
 numa node
Message-ID: <am72IsHVw_CuO_RJ@U-2FWC9VHC-2323.local>
References: <20260730113040.75718-1-feng.tang@linux.alibaba.com>
 <20260730113738.41C901F000E9@smtp.kernel.org>
 <amv0DwQoeESq2Cp7@U-2FWC9VHC-2323.local>
 <amz-m8cu0lYc8LzR@firstfloor.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amz-m8cu0lYc8LzR@firstfloor.org>

On Fri, Jul 31, 2026 at 12:59:23PM -0700, Andi Kleen wrote:
> > > Will this crash if numa_allocate_cpumask() fails to allocate memory?
> > > 
> > > It looks like cpumask could be NULL here, which is passed directly to
> > > numa_node_to_cpus() and numa_bitmask_weight() without validation.
> >  
> > Good point. 
> > 
> > If the allocation fail, will return 'false' to let the code go the
> > original flow.
> 
> 
> While it's technically true, checking for out of memory in ring 3
> (or at least other checking than exit(1) on error) is usually 
> useless. Most of the time when this would fail you're as likely
> to just get killed by the OOM killer, as well as the harness that
> called you. Maybe it could happen without that with some very tight
> ulimit settings, but with that not much else will work anyways.
> Also these paths are basically never exercised so likely buggy
> when non trivial.

Good point.

> 
> For libnuma if you set numa_exit_on_error to 1 it will always
> exiting after printing an error. That includes the allocation
> functions.
 
Good to know that!

> 
> 
> > > > +		ret = true;
> > > 
> > > [Severity: Medium]
> > > What happens if numa_node_to_cpus() fails?
> > > 
> > > It can return a negative error value, leaving the cpumask unmodified with
> > > zero bits set. Because the return value is not checked,
> > > numa_bitmask_weight(cpumask) will evaluate to 0. Does this cause the function
> > > to return true and silently skip testing on nodes where an error occurs,
> > > rather than reporting the infrastructure issue?
> > 
> > From the code logic (with above change), the 'node_id' and 'cpumask' have
> > both been validated, and this numa_node_to_cpus() is very unlikely to fail
> > here upon reading libnuma source code.
> 
> Yes it's unlikely to fail.
 
Thanks for confirming it!

- Feng

> -Andi
