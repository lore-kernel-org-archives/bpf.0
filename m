Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AF23EAB4;
	Thu, 26 Mar 2026 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530822; cv=none; b=NIzVKSJ1rnpuUCzNNmPAMufc7V3jTjOKvS0WoHO2RCPYq2pcQS4p5qF3AGaVW3/BAaCKlduBBTfjbui8qHw1lmyjXOFMjHMqX+hDIlFldU44wQWOc7mIFK7zPaDQJens3fJF3JDTiOGaamYHc1CI88UH8spGMTTcp02HE4m7hNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530822; c=relaxed/simple;
	bh=RppesdMGtLvcCeXRbqBSvK537/hNj9FmRtkPlUC+DG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGc2SYcwJexaSgaYnGKrd/wIqLRLU4qV+ExhQfwGWziDIawycKOUxV1SYSeJAt+yBQ0l6exy/qNHtWucZ36XN7yYww6njNJEh0cw2PtMahfXUOE7Tk6UPBL2CUiUj9es3RS0zPNCATH2Qolnxy2u4t6BaBS0koT2ru38+/y/Me8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiC58gz+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiC58gz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F88C19424;
	Thu, 26 Mar 2026 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774530821;
	bh=RppesdMGtLvcCeXRbqBSvK537/hNj9FmRtkPlUC+DG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tiC58gz+NaUzy0dkhSAVFvJ0rieCKXkEj83kW8t5GOW4pYIMWHPH/bmZB5udX3CDn
	 dhNHc7sPEWPELCAcZy1WbT2gnXyr1kzwNHf9I/CbMHk3qgOXJGwstWU//+3XnxYg3l
	 VX4MSeLsUl21Ek1NQkrcozZPsMaJyRjNuqXorN7nTATkCVnHTSaV+nJr7aHVKfimFt
	 EYWCM01LbEN42OeWXfNTwNiuEFe7z3vUHuoP5Edf2tchpJ3wttooo15PIYMOPt76qE
	 Cqp9YfoAzYyiMwB3+8jDtE84GbrC46FbS6WeRVSd1iOtjJTHjz6h8VG1pa2fXjujRT
	 TZjhROjZ5reSA==
Date: Thu, 26 Mar 2026 13:13:33 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	lsf-pc@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
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
Message-ID: <67f1588e-a094-413c-9746-9c28bdf6cc56@lucifer.local>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAMgjq7B_twv3xhd5VmMJxngAknf9YaLAiwGYpdi6H2n1cXD3-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7B_twv3xhd5VmMJxngAknf9YaLAiwGYpdi6H2n1cXD3-A@mail.gmail.com>

On Thu, Mar 26, 2026 at 08:37:06PM +0800, Kairui Song wrote:
> On Thu, Mar 26, 2026 at 4:02 PM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >
> > On Thu, Mar 26, 2026 at 08:03:34AM +0100, Michal Hocko wrote:
> > > On Wed 25-03-26 19:05:47, Andrew Morton wrote:
> > > > On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > > We should unify both algorithms into a single code path.
> > > >
> > > > I'm here to ask the questions which others fear will sound dumb.
> > >
> > > Not dumb at all and recently discussed here https://lore.kernel.org/all/CAMgjq7AkYOtUL2HuZjBu5dJw=RTL7W2L1+zVv=SCOyHKYwc3AA@mail.gmail.com/T/#u
> > >
> > > > Is it indeed the plan to maintain both implementations?  I thought the
> > > > long-term ambition was to knock MGLRU into shape and to drop the legacy LRU?
> > >
> > > Yes, but MGLRU is not there yet and with development pace last year or
> > > so we are not much closer than at the time MGLRU has been merged
> > > unfortunatelly.
> >
> > I'm quite concerned about maintainership, as it seems the MGLRU maintainers have
> > not been all that active, and the MGLRU to me at least is currently a black box.
> >
> > I'm not the only one who's raised this (see [0]).
> >
> > That'd very much have to be resolved and the community reassured that MGLRU is
> > _actively_ maintained before we could even contemplate it replacing the
> > 'classic' reclaim approach IMO.
> >
> > I hope that Kairu, Barry, Zicheng and others who are interested int it resolve
> > this, however!
>
> Hi everyone,
>
> Right, I think we are starting to make good progress on improving
> MGLRU recently. For the last few years we already have some commits
> stashed downstream to enable that on our fleet, most of my effort in
> upstream is spent on other parts like SWAP, really looking forward to
> making MGLRU better upstreamly.
>
> Yesterday I was still discussing with CachyOS folks about their usage
> while working on that series for MGLRU cleanup and dirty flush
> optimization, and got some nice feedback later from their chat server
> that MGLRU's TTL resolved their thrashing issue very well. With
> classic LRU they needed a le9 patch downtreamly.
>
> For many other typical workloads under stress, MGLRU performs
> significantly better too (e.g. database, build kernel could be more
> than twice as fast), it would be a huge loss to leave it unmaintained.
>
> Barry also provided some really helpful ideas about MGLRU like
> readahead handling. We are also seeing other vendors and people
> contributing to MGLRU like Leno and Baolin recently. Things are
> looking promising.

Guys, can I please make a plea then for you guys to AT LEAST become
reviewers in MAINTAINERS please:

MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)
M:	Andrew Morton <akpm@linux-foundation.org>

Well Andrew is Andrew :)

M:	Axel Rasmussen <axelrasmussen@google.com>

git log mm/vmscan.c has 0 results.

Axel has however engaged in discussion on
https://lore.kernel.org/linux-mm/20260318-mglru-reclaim-v1-0-2c46f9eb0508@tencent.com/
recently for example, but not much in 2025 afaict.

M:	Yuanchu Xie <yuanchu@google.com>

git log mm/vmscan.c shows 1 result from August 13th 2024.

Yuanchu has engaged in some MGLRU discussion also recently, here and there.

R:	Wei Xu <weixugc@google.com>

git log mm/vmscan.c shows 2 results from October 2024.

Wei doesn't look to have engaged in discussion on MGLRU recently.

L:	linux-mm@kvack.org
S:	Maintained
W:	http://www.linux-mm.org
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
F:	Documentation/admin-guide/mm/multigen_lru.rst
F:	Documentation/mm/multigen_lru.rst
F:	include/linux/mm_inline.h
F:	include/linux/mmzone.h
F:	mm/swap.c
F:	mm/vmscan.c
F:	mm/workingset.c

It doesn't really feel like MGLRU is currently maintained at all, quite
honestly.

So I think we need people to step up here.

Thanks, Lorenzo
