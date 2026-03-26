Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5B2BEFF6;
	Thu, 26 Mar 2026 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531595; cv=none; b=BiAlnaGpODOnKBlBcmy2QlPmO7svbh3RQ5qQhpWKBQP4mCWkPBZ7A45OzMPW8uTVQgPeOcJH1drqskt5el89Chh42QtZB8E982iCEi9+/WpO1ssL0f/GaLHO1Gu1n81pyZHoHbugXBqp57s877uzIyaib6hr1u2clm+BQJ2/UBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531595; c=relaxed/simple;
	bh=+t2roIXPHd/zg2sRt/a9JSIXkg7Ja3ZrOkaN/rOmFxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G82RQn4K2bDQ5+sOrrse7DwrTMmGP7RGQs4YvjAGjD34y6KbHQvMMbrBV7YADLmN1pj3c0FiMU+C9aesfumMoW/KaMDWbbxsR/6JcDIkdeVHCkciqnXnF9zT/sfek27Lgwdc3J7axmc7Ghn2vexyKkXFi4N65do0L8HxFZ1uJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6kLPKW/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6kLPKW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC849C2BCB1;
	Thu, 26 Mar 2026 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774531594;
	bh=+t2roIXPHd/zg2sRt/a9JSIXkg7Ja3ZrOkaN/rOmFxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6kLPKW/wu7lT6Gl+/BozP2EIuDsxk+6x09dOqsfDuPImN49ON+VXfVbT/qLoiJoF
	 8C7Gs1A6MVWE1yLKvb3fha9zYZyaTWSQ6hnb0YItnIaXsOeiCY2TwRQVWYtQT+caE6
	 HyvNSZpcy1qJMjy2aeGJp+Kj9EM3CPD2CDZGNoiYqxfeuPQdKDJmSOAGve1ld3VZUT
	 AXie0ESVuKCWpzx7GHdSLR/GUIsKzsnf74t7tQQVZ26USbLfzd8/G7PXOY+ej+P2Jm
	 2FZkxXLjUJIE96I8eCQU3WxKCHYwnzRFnDVC29uJo4Br+yfOUT/GtW9b/YHnk0GQ2q
	 ShzPaM+04PIPQ==
Date: Thu, 26 Mar 2026 13:26:26 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, lsf-pc@lists.linux-foundation.org, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Chen Ridong <chenridong@huaweicloud.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, Gregory Price <gourry@gourry.net>, 
	Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, David Rientjes <rientjes@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, wangzicheng <wangzicheng@honor.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Suren Baghdasaryan <surenb@google.com>, Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <e98ccaa6-52c0-46b8-b089-ac9dc4baa023@lucifer.local>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <CAMgjq7A01C+wyHxytZfVFVvaJ+gUNqkKvYN61_Peo911YaBHOw@mail.gmail.com>
 <f617acf0-6bb6-4ea0-85c2-d6f377a2a574@lucifer.local>
 <CAMgjq7BfuYsxhhf-XqKH4B622NGP-9bmriSP2eMiygH9ZJMANw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7BfuYsxhhf-XqKH4B622NGP-9bmriSP2eMiygH9ZJMANw@mail.gmail.com>

On Thu, Mar 26, 2026 at 09:17:17PM +0800, Kairui Song wrote:
> On Thu, Mar 26, 2026 at 8:31 PM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >
> > +cc Gregory
> >
> > On Thu, Mar 26, 2026 at 08:06:13PM +0800, Kairui Song wrote:
> > > On Thu, Mar 26, 2026 at 10:05 AM Andrew Morton
> > > <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > > We should unify both algorithms into a single code path.
> > > >
> > > > I'm here to ask the questions which others fear will sound dumb.
> > > >
> > > > Is it indeed the plan to maintain both implementations?  I thought the
> > > > long-term ambition was to knock MGLRU into shape and to drop the legacy LRU?
> > >
> > > I personally also agree on that, so far I'm not aware of any major
> > > issues with MGLRU except some corner cases that are not hard to fix.
> > > Once these are done, I don't see the need for more complexity.
> >
> > Well... :)
> >
> > What about the issues Gregory raised here?
> >
> > https://lore.kernel.org/linux-mm/aaXM7xNSJaJBsety@gourry-fedora-PF4VCD3F/
>
> Hi,
>
> Thanks for linking Gregory's mail.
>
> I'm not quite sure I fully get what the concern is, I'll try to
> address the main points I see. Regarding the bi-modal distributions,
> it's very workload-dependent, and the reclamation still performs well
> with that distributions. So I think that's not really a problem?
>
> The heuristics are a bit confusing and intertwined (gen number as
> flags for atomic update and avoid LRU lock, tight coupling with
> generational aging, etc.), decoupling them cleanly without hurting
> performance is tricky, and the current approach has worked
> dramatically well. Cleanup the code structure might be helpful?
>
> Many distros have been running MGLRU by default for years now and the
> feedback (plus our own production experience) has been very positive.
> There are indeed some known rough edges, under-protected file cache,
> ineffective swappiness, flag usage, etc. some of which I listed here
> [1]. I believe they're all fixable, and once addressed MGLRU should be
> a solid base.
>
> Right, I realized after re-reading that some of these really are not
> really easy to fix or improve... sorry for my earlier reply, guess I'm
> too sleepy today and not thinking clearly :P, my apologies.
>
> [1] https://lore.kernel.org/linux-mm/CAMgjq7BoekNjg-Ra3C8M7=8=75su38w=HD782T5E_cxyeCeH_g@mail.gmail.com/

Thanks, well that's good to hear.

I broadly agree with Shakeel's proposals for the incremental improvement of
the LRU code, and I think that and fixing MAINTAINERS (*ahem*) will
seriously help move us forwards with this.

I wonder also if we shouldn't have a document on this somewhere in the
kernel to lay out the differences, improvements, how the gen numbers work
etc.?

Cheers, Lorenzo
