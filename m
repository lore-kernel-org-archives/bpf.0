Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD53A1A22
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549325; cv=none; b=VnpgW01BJ6eJEJlZ3Vd7/2YuYRlinpAxQAFTxmxVLs3N8kaOBwNS2X394lRH/HhLgJ3K/Gj6X3k+xHZUY6K/sYDQm6KW/nHYtd0Rj3s87KCT6HB5RccCprpGadYwLyhM7V5Fa2L1MXbOwx629eHPr/1OS+iDzeOMBen7zn7BbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549325; c=relaxed/simple;
	bh=7EXjGkFx4L5lHlRVIwhTPY2u5SuH89NSy9t32RzKXEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjKQzA106iYYkIggr71qb4EpMu1wlOwIj5PIgSjqyrO14eFU6fT+PD8Q0vWSkrsNEhGnQSR51nKZ+WkTxFz2++Co8TIYGdjqE9yTQFcdGde7Un6IXOooWbGSEtPn5o/GxQnM1J9Nex4da2Y+2NnIy182HGjLy0I6i9hKPp4K7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XIlwPLqA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XIlwPLqA"
Date: Thu, 26 Mar 2026 11:21:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774549320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E2NCU4uykscWRD1sM4fvveSE6frF1GrPo7z442+61WY=;
	b=XIlwPLqAxSnVEZ5NKymCtuPS5yNb5S+yyBfPCsHHWs0WwI5SWGWCvZcgdDwjrq/tIzPyrn
	2NO5NMIiyWB0G8Ibj+l/ZkotaMqEO8HXPIk6cDDEE5bF+uZsJeYXSG3NzzLVy0PFd/kL8w
	tCW97Wdko+vK86sQq7FYQBArnDXY5/o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Kairui Song <ryncsn@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Nhat Pham <nphamcs@gmail.com>, Gregory Price <gourry@gourry.net>, 
	Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, David Rientjes <rientjes@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, wangzicheng <wangzicheng@honor.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Suren Baghdasaryan <surenb@google.com>, Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <acV39ErpINby9rpn@linux.dev>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <acTcStxrTCWAN6Dt@tiehlicka>
 <acUzMdxCDfbuyv9J@linux.dev>
 <acVPlB1Y8IR-RKCg@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acVPlB1Y8IR-RKCg@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 26, 2026 at 04:24:04PM +0100, Michal Hocko wrote:
> On Thu 26-03-26 06:44:07, Shakeel Butt wrote:
> > On Thu, Mar 26, 2026 at 08:12:10AM +0100, Michal Hocko wrote:
> > > On Wed 25-03-26 14:06:37, Shakeel Butt wrote:
> [...]
> > > I think we should focus to make a single canonical reclaim
> > > implementation work well. I.e. we deal with most (or ideally all) known
> > > regressions of MGLRU. 
> > 
> > Here we disagree on the approach or steps to reach the single canonical reclaim
> > implementation. MGLRU is a plethora of different mechanisms and policies and it
> > never went through rigorous evaluation for each of those mechanisms and
> > policies individually. To me that needs to be done to have one solution. 
> 
> If my recollection is correct from the LSFMM (2022) there was a promise that
> MGLRU architecture should allow to add extension and eventually
> supersede traditional LRU. If we do not see that happening then we
> should re-evaluate current MGRLU approach. I do not think we want to
> build reclaim_ext architecture on top of the current code. Or are you
> suggesting to achieve MGLRU through reclaim_ext?

My main objective is to unify the reclaim i.e. one reclaim algorithm/mechanism
and then (later) provide a framework where folks/kernel-engs/researchers can
experiment with new techniques/algorithms without changing the core reclaim.

Regarding MGLRU, after unification something from MGLRU remains which does not
makes sense to put in the core reclaim, that can be provided through the
framework. For reclaim_ext, I just like the name, looks fancy :).
