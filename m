Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC62DB788
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531326; cv=none; b=AZNU6Aq/5eXBL9+ZF7RsVvjlKqkOjll1PAKcFSnM8kzJDEpAJqSwqHTNsFV/ucKERM9xNw06FjM4LJmMhKVV+KFG9KAgp6RhwUR5jIWn5m/Zvob0GAQUN6adlwMf3HvHyvnFo0L/FYvx7uLBGncy+DZW7hKn+ff0pM2QxVeRnvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531326; c=relaxed/simple;
	bh=L8EoGwprAqtnl8hCwQNLvJmnb1g7R00Tbw4WhWLcYrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+M7YUfY75IwhsZM0AJDVtbvrMU5YwCfXPcXeDpqUVaYVGzNUetMEZy5g8kBSsANN9g5Ts042IxceofdZklGFx0QYhI1zwC/gh+bB3IEkKvR7en87DFD5tJmVG2Unj7I6H9pVRTTlodPU5gUxFDzDj8d6nchToTcQULmurO/FZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h0EIdrTA; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h0EIdrTA"
Date: Thu, 26 Mar 2026 06:21:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774531321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7kEkchvazcsGs35ThyHSvMh3kjT1N0Pp0rpILZyG9Y4=;
	b=h0EIdrTAKnJzT+1v/qT86u21TaY0qsvEnymktOBVOaDiDhSyEVXlTGEmWqT+decQ/iKCA7
	By+oFvK6smxPXJP02S0+FzFJlfBB0mt0a+q4VXFFGtWGPEUgoTfFU/A8PtvMfJLSKPoE2V
	c7rpnN3LB71UlPV/WY/WNdwuiOwzO0o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lsf-pc@lists.linux-foundation.org, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
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
Message-ID: <acUxJpJDzA7Bibob@linux.dev>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 25, 2026 at 07:05:47PM -0700, Andrew Morton wrote:
> On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > We should unify both algorithms into a single code path. 
> 
> I'm here to ask the questions which others fear will sound dumb.
> 
> Is it indeed the plan to maintain both implementations?  

I think in general the plan/wish was to have one implementation but the current
state shows that we are far from where we wish to be.

> I thought the
> long-term ambition was to knock MGLRU into shape and to drop the legacy LRU?

That might be the ambition but I don't think there was an agreement and there
weren't any efforts to do so. Traditional LRU has been battle tested for decades
and thus there were concerns/skepticisms about this ambition as well.

To me, the right way is to take step-by-step approach with clear evaluations and
comparison on unifying or selecting a component from one over the other.
