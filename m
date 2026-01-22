Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400F338F5B
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054092; cv=none; b=ELN5yOAPpK7Iy0kxvGDDicraftOME5KyOciY8h33bKmSI77JsPgft6SwHqDcnXuY2PpRD0oHJKMlT/HrV8m7nD0LCCWsrVg5WHZj+6+a7yHM0WSWqakFRJ1DTmW1TD4qal1sXuMY3JAuiZWP1BTxK9kA6v6k6xwT46519jtYe3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054092; c=relaxed/simple;
	bh=FjIc/wy3VmbfZIt1ZBnrVbJHuMms9we+lnnm4Nf3Hhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6kt+uDzsZH8wuLadAKK3aKfs9gy57j9zoGFNpJYLgR8VYvC0fHptik50jHKnlSVKb4qeQJ7wQNDSfGu8FsF0O7ge6E2W0H6ZUdCJPYrn9v8iFhLvRLivJyDas6tdo7r3S9pQ96sV7S183OAnhuQDhsF0Ov14K9pKyHEt3Pg0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q9wgSQgA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q9wgSQgA"
Date: Thu, 22 Jan 2026 11:54:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769054074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vw444WMHV1aHVgp9YPBVa4B3NTBF6Yg7X7f7oG/aDTQ=;
	b=Q9wgSQgAUaAxbYPOPHC/7e626j5x0IAyk83MJrhyfQBagKBGM1/HedPrIHJ4/5P9RFaM/p
	cYa8LFP72WuoDnZ+ZxZXDiSBXmqrpYKnQ62Xpj/EkRhWr+pKC2F6qY96wvKvOwg6Zl6urx
	TDBrlYggwJZMqqLUE7u4pUwlXUg/91I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 18/21] slab: update overview comments
Message-ID: <ki4y2wnhznq5s25hic2j25ohgxzjae3y7pkjjjkle75hp34e25@juljp5mukkfz>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-18-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-18-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:38PM +0100, Vlastimil Babka wrote:
> The changes related to sheaves made the description of locking and other
> details outdated. Update it to reflect current state.
> 
> Also add a new copyright line due to major changes.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 141 +++++++++++++++++++++++++++++---------------------------------
>  1 file changed, 67 insertions(+), 74 deletions(-)
> 

Looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
