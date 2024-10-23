Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EF39ACC
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729645090; cv=none; b=GRsOqYcXF5qhp7KP8EDwUT1XHtwHX1SJDemENYVZUKxxpiShmfjC6wyLjXJOj93IKn9/VKzGv1mO4Hi65k9fY7puIz0iOJYWgD51ckjc2P+7V50DvaowwKyLNk02M2je/Y/eieJEDRUsD49VoDct7b5xRSwqsy+rUa2RyMKuo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729645090; c=relaxed/simple;
	bh=zG0QnAFh3PI/FdtpAFmYEpRjqtYn6Yz3wRKPbvOwEFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG4CV4frrNxhFAB9Jzdqbs9ZPdcQXFKKjKoWqlHXoUgChcuoGWxmoUHxNCq9o4BcQhhrkcFQqpZ5/8iQnw/Nvs0HjQjnAw2j7DYuvbf9y4hifGbGx57zwsfnRgF+aJ6eqE1Rh3nHOPY85GObi70dQUI0uQdGutjcIJN+ir0xJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=URhTwlBv; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="URhTwlBv"
Date: Tue, 22 Oct 2024 17:57:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729645086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIhG4Nub/27TKSQIaMpr/BUBLqYCkfJlFCf4zPWje50=;
	b=URhTwlBv44lgRGyh4PCa8XtKj0YbC/9GMp4Cs2Eq5+MLAoj/HIcKsgYcsjq8+8tQxrs4EA
	WmOP81M2GcKuRaiatrkfiMYjUVIXH3CvYDCExbPIGMBdx1cY8o3eL9NP130p1oSF5pLR73
	UVWAOkWj+CVAKyqKDO5RNgSsCbGoYOQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kui-Feng Lee <thinker.li@gmail.com>, kernel-team@meta.com, linux-mm@kvack.org
Subject: Re: [PATCH v5 bpf-next 06/12] bpf: Add uptr support in the map_value
 of the task local storage.
Message-ID: <2ngvjjbgow7bhsr5bpcyosxrzkbaux6mrvtvh2ru6wrzujtoki@7vpyhef5vux5>
References: <20241015005008.767267-1-martin.lau@linux.dev>
 <20241015005008.767267-7-martin.lau@linux.dev>
 <pu7v27kmibjeqmmom3xbkcgq5w3okk5bgfrponpcmioxrncq7y@3ebhucmwyxsz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pu7v27kmibjeqmmom3xbkcgq5w3okk5bgfrponpcmioxrncq7y@3ebhucmwyxsz>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 22, 2024 at 04:07:50PM GMT, Shakeel Butt wrote:
> On Mon, Oct 14, 2024 at 05:49:56PM GMT, Martin KaFai Lau wrote:
> > From: Martin KaFai Lau <martin.lau@kernel.org>
[...]
> > +
> > +		err = pin_user_pages_fast(start, 1, FOLL_LONGTERM | FOLL_WRITE, &page);
> > +		if (err != 1)
> > +			goto unpin_all;
> > +
> > +		*uptr_addr = page_address(page) + offset_in_page(start);
> 
> Please use kmap(page) instead of page_address(page) and then you will
> need to kunmap(kptr) on the unpin side.
> 

This is needed only if you plan to support your feature for HIGHMEM
kernels though. Otherwise you can error out for PageHighMem(page).
