Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19C373C10;
	Fri, 27 Mar 2026 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603784; cv=none; b=RQjgrhnuNaq2eNWtF1sKNsYv+GzTszLsl26zmMVwXaTUY2/s9n/7xdGzyYnTZgdRi09GiBxakKbIwnzyFua1hkIv7hVjaFBHzZ+7dZDZfhJ6vNbyfAo6MYIhh4tYUD5xi8kabjzP0F787TW2I9hbzU3BeMTMezG+l/ZgJLjK9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603784; c=relaxed/simple;
	bh=vTQoXBzSoGbvJfIlwkPLr8sIT5gradTLmH5Adve2H7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D29QJW08sV9iV1oNksbL2kczztreINkD8dO6QIeVXxx9nSgXy2Y94LgMRprxt5suC7qW+muNgUyQDaGEZI4P2JyKIC7Y85SC2+a3CcB8O9XFbW3/MGGEQZdnJ4URWrU/r6CuDhDZxabAmsnilCn5w4SqR8GhT6PzT4h2EFlpAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjlZkKE8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjlZkKE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551F9C2BC87;
	Fri, 27 Mar 2026 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774603783;
	bh=vTQoXBzSoGbvJfIlwkPLr8sIT5gradTLmH5Adve2H7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjlZkKE8ImyH5aLAYpVnl1L7USQiezExCFUH077Y1cCHroDKKUm0fOOJgLUl0w05y
	 LEjQKSwSWuyBS7wNJPO3VqJJstpV2//IQOToWFz83ZZFdFt6zXknDX2lZUPNuSunI0
	 CYfa3dEVNG10jP1Y+3Vu1Vtg4IMovwJbaLVQm7YSZMp8E4OMYFFryxsbA8g2aKaxTO
	 NKWebKSqKv2FDLLqa0gwzzBkqd+Oxqr9hogIj4TH7j3u3VsahyPcyMp3KowI9QptDR
	 altB6XDNGS0Rh5lhLj5DMQBk/5mwjnYgBobt9ksxFvAIHcuVIJGsCHIAFpGntQdsfv
	 ViLKWi/j02lfg==
Date: Fri, 27 Mar 2026 09:29:33 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Vlastimil Babka <vbabka@suse.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, lsf-pc@lists.linux-foundation.org, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Kairui Song <ryncsn@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, Gregory Price <gourry@gourry.net>, 
	Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, David Rientjes <rientjes@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, wangzicheng <wangzicheng@honor.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Suren Baghdasaryan <surenb@google.com>, Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Towards Unified and Extensible
 Memory Reclaim (reclaim_ext)
Message-ID: <bd7099a1-aa15-4c58-875e-1e00624a57ea@lucifer.local>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com>
 <8406d210-4f68-4919-b791-c03c310a8385@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8406d210-4f68-4919-b791-c03c310a8385@suse.com>

On Fri, Mar 27, 2026 at 09:07:55AM +0100, Vlastimil Babka wrote:
> On 3/26/26 21:02, Axel Rasmussen via Lsf-pc wrote:
> > On Thu, Mar 26, 2026 at 1:02 AM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >>
> >> On Thu, Mar 26, 2026 at 08:03:34AM +0100, Michal Hocko wrote:
> >> > On Wed 25-03-26 19:05:47, Andrew Morton wrote:
> >> > > On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >> > >
> >> > > > We should unify both algorithms into a single code path.
> >> > >
> >> > > I'm here to ask the questions which others fear will sound dumb.
> >> >
> >> > Not dumb at all and recently discussed here https://lore.kernel.org/all/CAMgjq7AkYOtUL2HuZjBu5dJw=RTL7W2L1+zVv=SCOyHKYwc3AA@mail.gmail.com/T/#u
> >> >
> >> > > Is it indeed the plan to maintain both implementations?  I thought the
> >> > > long-term ambition was to knock MGLRU into shape and to drop the legacy LRU?
> >
> > I think one thing we all agree on at least is, long term, there isn't
> > really a good argument for having > 1 LRU implementation. E.g., we
> > don't believe there are just irreconcilable differences, where one
> > impl is better for some workloads, and another is better for others,
> > and there is no way the two can be converged.
> >
> > On that basis, I would be hesitant to add some complex abstraction
> > layer / reclaim_ops to facilitate having two. It seems ilke it may
> > make things a bit cleaner in the short term, but long term might make
> > that end goal harder (because we'd add the task of cleaning up this
> > abstraction at some point).
> >
> > My preferred way would be more like:
> >
> > - Look for opportunities where we can deduplicate code, but without
> > adding abstraction (e.g., factor out common operations into common
> > functions both impls can call).
> > - Identify gaps where MGLRU performs worse than classic LRU, and close them.
>
> I'm afraid to identify these gaps we'd have to indeed split the MGLRU
> differences (as listed in Shakeel's proposal) in a way that they can be
> tried separately. I recall when MGLRU was proposed, we did argue that it's a
> combination of several things done differently and they should be introduced
> to the existing reclaim and validated separately. But the author refused to
> go that way.

It's unfortunate we were ok with going ahead with this anyway, I hope in the
current mm culture we'd simply say 'ok series doesn't land then'.

It feels like the 'merge by default' stuff has been both a process _and_ a
culture fail for a while honestly.

We are managing arguably _the_ most core part of the kernel (I know people will
argue on that but at it's at least up there :) and almost certainly _the_
subsystem with the most direct route to exploitable security bugs, but we've
been running it with some of the loosest merge criteria in the entire kernel.

It's patently insane.

Things are changing however!

Cheers, Lorenzo
