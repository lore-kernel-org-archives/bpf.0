Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217D36C0B7;
	Fri, 27 Mar 2026 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583068; cv=none; b=Vrsdad7o635yW2fhhcI4DZPsd6/X9lyiqH0z8NBW729W+/CV5+x5Vpv3iD+yc8HuJNAU+2TxlGCBeCH6ijkLKitwpproK+09FLfq6IzzYC5IX2g7uhTmQOcc3kjGEefPhA4+Wp6EzCkF9I8aNdIxFt3K1SHlDhRS6WFJjfbprXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583068; c=relaxed/simple;
	bh=k6LVW3/dcSnDm3GGLT4O4TO5qK6qty4b6SWpXNLayns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5Lmgmq78eV5L5NZhowVZgu9sYfAVg6AG/im1enkD8YfgNxSwVP9Oh5uGEROI9JF4tX4GAFBJCm4GBq/d+yMdxUNVjtSfAeLJzWPnkh4Z/lAfwxSr0G0aeGRqyHv575oJNVEOthlHaIjS7HsbLYYfYTu2gsvOAoXxNc6YlaBFfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hlczufxN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hlczufxN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=uC5wa+w/5eoxaApxqhDaCeYHRfJbuuXOURYYn2lEhQQ=; b=hlczufxNIvXLMlmIiFl9i47mdX
	7SEQtVhjDtRkwWvMKNMqYZ5K9u4DBL/ORazKXpkPRrtZZ63GMhyCMZB8xwaei3Od9oNzoOs1FDQZq
	jH1zUR7jfQ7ilooMsm6Hm7G8IXhbFxk3KjCWIUtc4FsnORAbFtjCvZe9btqvNTBVvnkZcJ3naVf9p
	5WUmFukgHZFHn8y1WSAvoucQ6nZi0wlW1DI3D4r2TXIYEjs8XjZ8WanaEek7ZqwEULAtqzHd6wwKA
	KWcE1hw+507N/PNzDAigbVJJ3tOZFshvcvFZC+ezncbUlUI2YActuDD+Jzn/Y7wwX4eOQrzTi9q0G
	srnCPHXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5y73-00000001Ce2-3bZB;
	Fri, 27 Mar 2026 03:43:58 +0000
Date: Fri, 27 Mar 2026 03:43:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Gregory Price <gourry@gourry.net>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	lsf-pc@lists.linux-foundation.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kairui Song <ryncsn@gmail.com>, Nhat Pham <nphamcs@gmail.com>,
	Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>,
	Vernon Yang <vernon2gm@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	wangzicheng <wangzicheng@honor.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Tal Zussman <tz2294@columbia.edu>
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <acX8_XMQYA0-NGUW@casper.infradead.org>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com>
 <acWXdvHx9mYqvT2w@gourry-fedora-PF4VCD3F>
 <CAJHvVciAmX9OFLBSahwvXL=E+3xnDsL2aE4WKfDBFqaT1Gu+Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVciAmX9OFLBSahwvXL=E+3xnDsL2aE4WKfDBFqaT1Gu+Qg@mail.gmail.com>

On Thu, Mar 26, 2026 at 01:47:43PM -0700, Axel Rasmussen wrote:
> On Thu, Mar 26, 2026 at 1:30 PM Gregory Price <gourry@gourry.net> wrote:
> >
> > On Thu, Mar 26, 2026 at 01:02:02PM -0700, Axel Rasmussen wrote:
> > >
> > > I think one thing we all agree on at least is, long term, there isn't
> > > really a good argument for having > 1 LRU implementation. E.g., we
> > > don't believe there are just irreconcilable differences, where one
> > > impl is better for some workloads, and another is better for others,
> > > and there is no way the two can be converged.
> > >
> >
> > I absolutely believe there are irreconcilable differences - but not in
> > the sense that one is better or worse, but in the sense that features
> > from one cannot work in the other.
> 
> Right, agreed. I mean a case where we have workloads A and B, such
> that there does not exist an implementation that can serve both well.
> If such workloads were "common" to me that would justify a reclaim_ops
> / pluggable abstraction layer. My thesis is that they are "not
> common", so I'm a bit skeptical the abstraction is worth it.

That isn't what Tal was telling me at Plumbers.  Adding him to cc so
he can dispute you in his own words, rather than my clumsy paraphrasing
of what he said.

