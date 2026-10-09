Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DCE392C46;
	Fri,  9 Oct 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565470; cv=none; b=Hu9blS9K7u02rn19wfZ3aV5tCsjWaWnifNUj3sEtVsVLK6stQMtWP2SzI8DfTOAbtj5ro+tK7WDprj/SKYbjYftQ6DFWsmD5mBWuaGVDFFG8dkFGySGXmQeo+CSZJFvumY2BYdxfejbUXe0iwgkl9YKr22dBdIzDAwYwsWWVGFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565470; c=relaxed/simple;
	bh=pRBwxZ/pTxp7drinmbnO6WjD0YWUO9pajIRsaCkGJRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VExBAqFGXoUPRPqDK0di2OXPAIwB1pqn7TiwHVZfW5SnfzFqae2EMokJlvEJPVPbfNNu0i7t6Nn1aDo5FWq+b5LVUMsHPKeP90pm4Cn0NBfm9hyHwCMyX4Skh438oDLLKQ93OFtSLrGnmlWN8muhe/9lniEPFhZXwWlhG+GAV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjXcxo5s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjXcxo5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439AD1F000FF;
	Fri,  9 Oct 2026 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565469;
	bh=pRBwxZ/pTxp7drinmbnO6WjD0YWUO9pajIRsaCkGJRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IjXcxo5sLrTtBSJR7EkoJWJY77e88/FBq0xaObIkJ8gytFU4tpsY9YddZpjtiCGsd
	 Yv8M15lrCBIrHMaI2fHrUx/MTCbn9RQSd+EyRFZBscjksdk+j08F1zjcIzxZwi8XEX
	 1u+bMyBVUYF8xZLnHLuBWOhtUQ6gcltcfnPFaBFZHrUMA29WW9OLeD7kA9nJ18LluF
	 LQpQpcea6IU0UlyakE/wazbfHT9e+xq4ueFy7q8OcrHkwJbD194frgQQN2+uHH1rhx
	 iPEuGPyeVBHFEVlu5Tz4J1GYor8Qb5ysDSQuQNPlAubMgFFo5EC8mMYSvX4v58SYnm
	 sWKyZYzFSEH0A==
Date: Fri, 9 Oct 2026 18:04:24 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2] mm/vma: keep the unlinked VMA off the file across
 unmap on mmap hook failure
Message-ID: <askcyeoKgKb6771N@gremlin>
References: <20261007101800.58d50b1b20a10738e630bfd5@linux-foundation.org>
 <20261007194708.2009-1-okerixx@gmail.com>
 <e139339c-1e55-438b-86bf-0960ad4029f1@linux.dev>
 <asjQQF_Ok1TZPm1M@gremlin>
 <271f7ba8-df38-4c8f-b59d-68b52ee998e9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271f7ba8-df38-4c8f-b59d-68b52ee998e9@linux.dev>

On Fri, Oct 09, 2026 at 09:38:56AM -0700, Ihor Solodrai wrote:
> On 2026-10-09 4:31 a.m., Lorenzo Stoakes (ARM) wrote:
> > -cc slopper
> >
> > On Thu, Oct 08, 2026 at 02:48:07PM -0700, Ihor Solodrai wrote:
> > > BPF CI caught this bug on linux-next as well:
> > > https://github.com/kernel-patches/bpf/actions/runs/37736351874
> >
> > Nice that it caught it!
> >
> > Is there a way to automatically notify patch author that when it happens? Does
> > it bisect, etc. or just green/red?
>
> For linux-next it's just green/red now.

That's still nice! We have something similar in mm. I think possibly
inspired by you guys :)

>
> We've added it to have an "upstream merge will break bpf" signal,
> because it happened regularly.
>
> For bpf list we run on every incoming patch, so regressions are detected
> quickly. Not feasible to do that for *every* upstream patch, we'd need
> much more compute.
>
> An auto-bisection is something I thought about, but never got to it.
> These days with LLMs this may be easier to set up though.

yeah that'd be awesome, but obviously a nice-to-have!

--
Cheers, Lorenzo
