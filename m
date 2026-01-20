Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB35428473
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912219; cv=none; b=ONQ93eElWvJw/CD9ytLsW04l5miNmwMxI0LCsH4+64bqcraovPQyNtmNZ2d4fOPWP34vFCtaJFz0NafWsPjxvW8I6yzGtPD0QjPUjh+0m2XzMLzUontHE5kZkbVSxHQvFX2yOu9x3SnBBNzVK6ye36G6X9ClgzwrcnbdM4YEBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912219; c=relaxed/simple;
	bh=EdkYy/yitIwxiDNqRPvAGET/weq3aXQUB28w9DdLQFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivS+TJ3toVpDaRh4itgkKgU+jqcx7zYTgPMAUGQjbJtUG3JineVSx9Sq3q+M6Wz6psvVVKJZrQH5kSXJL0ipmpVg7BNgP2pJxNL+nRcV9ZBpM2NqSUGrxSn/Xgee3RmCUCZ/yxjmTsmFmdnBveYZaYwI4AyMO/guD8p0pEUYfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NI327+VQ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NI327+VQ"
Date: Tue, 20 Jan 2026 20:29:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768912213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0l4DlrcsAB29u1FZ8RfgxXvBj6CMA+nJmNa7xiJio4=;
	b=NI327+VQJIHG1zdsqPYDP34eJKeq1vGM3Imfe1ya5cYV9LGeL4FNkuH5xbaO5h1Tle7MYg
	1SaP3y8IfLINQWehfNv+OPn1a19C/9NcyKahvpWb1Pi60s5n6vjTliZ/0U0hVwwe00fbbO
	1xrFwiCqzk9HWXoIAM5hvVr8G5ARbzc=
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
Subject: Re: [PATCH v3 12/21] slab: remove the do_slab_free() fastpath
Message-ID: <yejhiw37av3o23z6s4oewlmhip3iqxxkkfcjp2jhlo4qf7nm23@hojkan5ym5cv>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-12-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-12-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:32PM +0100, Vlastimil Babka wrote:
> We have removed cpu slab usage from allocation paths. Now remove
> do_slab_free() which was freeing objects to the cpu slab when
> the object belonged to it. Instead call __slab_free() directly,
> which was previously the fallback.
> 
> This simplifies kfree_nolock() - when freeing to percpu sheaf
> fails, we can call defer_free() directly.
> 
> Also remove functions that became unused.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 149 ++++++--------------------------------------------------------
>  1 file changed, 13 insertions(+), 136 deletions(-)
> 

Looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
