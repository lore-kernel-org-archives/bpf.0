Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13F37187B;
	Thu,  9 Apr 2026 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722963; cv=none; b=LcP7hp94LhmdTXdRAYZs7bskdxcPnA3ZOsK8JvbD4zf/R8K0rlIFpeyGBqg/h42vQyhSC++/k6g22jlQ6kLbpMa8Q2ojMPPaGTgJwblLvzcy1Tv2L0nA/D7Mnh9ZuvzrnXsTQZ/KvtYRBhlkDGCA7bEIbeaHb5Qj6phwDMU4Hic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722963; c=relaxed/simple;
	bh=tEQLa/8haXS+/Iqw/lhgd64KpO8nYmKlsOtiLdY6YwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/qLUgSAPK/LAXU1vzG6pUqGzlV3yggVNH5LjC7ePbQMZX3UED3NH7oGOPLZAuhsJ7jQhA4Vxz5XLsPZpLGHMRGgePbf3SiEVxMBjdIgF2rcq1bdLpxxTiZYyV32Dlp2ewqKPavseQ1UcGvFfNH589WlNRUC5w2Qxn2zi0jcx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1AdIWKg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1AdIWKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40484C4CEF7;
	Thu,  9 Apr 2026 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775722963;
	bh=tEQLa/8haXS+/Iqw/lhgd64KpO8nYmKlsOtiLdY6YwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1AdIWKgfOuDJnPp0z+X5VbbR6VGXVevTY5CMaVxbW7CBwU+xh+KqYAgOjAwy7ayy
	 xzHnhxAd/NDD9PPh7UKVMBhQ9fr/XYFFQ+/GYlRiGfC+DdNPbr/HkzLVA5ThAO75nM
	 pn2hP70NYF2GNI8LRJhk/BLYgkmfk/TVZY807NSO77hk5Qt8r02RB+q8ZXCAslahwb
	 G6y0N27JcSLXE4vix5q//WRmXo0IyrN5OjHcBiDQJGfTZ+bY9izWYBaW5K/GMWypOU
	 kgK+kiHTUk7BM/QtTyJ1TXXRAJHMAdStC6LeKNMoTV6yXB4AlVpke4SVoacUGT/wLS
	 iexf5GxvRAAhQ==
Date: Thu, 9 Apr 2026 09:22:33 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Tal Zussman <tz2294@columbia.edu>, 
	Matthew Wilcox <willy@infradead.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Gregory Price <gourry@gourry.net>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	lsf-pc@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Chen Ridong <chenridong@huaweicloud.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Kairui Song <ryncsn@gmail.com>, Nhat Pham <nphamcs@gmail.com>, Barry Song <21cnbao@gmail.com>, 
	David Stevens <stevensd@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	David Rientjes <rientjes@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	wangzicheng <wangzicheng@honor.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Suren Baghdasaryan <surenb@google.com>, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <adddpxFfWIO9a2Ih@lucifer>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com>
 <acWXdvHx9mYqvT2w@gourry-fedora-PF4VCD3F>
 <CAJHvVciAmX9OFLBSahwvXL=E+3xnDsL2aE4WKfDBFqaT1Gu+Qg@mail.gmail.com>
 <acX8_XMQYA0-NGUW@casper.infradead.org>
 <6f40c513-af3e-45b6-9000-c61494a23bd3@columbia.edu>
 <70fd648a-efa1-465a-8e6a-51411dfd50b8@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70fd648a-efa1-465a-8e6a-51411dfd50b8@nvidia.com>

On Wed, Apr 08, 2026 at 05:21:17PM -0700, John Hubbard wrote:
> On 3/27/26 12:12 PM, Tal Zussman wrote:
> > On 3/26/26 11:43 PM, Matthew Wilcox wrote:
> >> On Thu, Mar 26, 2026 at 01:47:43PM -0700, Axel Rasmussen wrote:
> >>> On Thu, Mar 26, 2026 at 1:30 PM Gregory Price <gourry@gourry.net> wrote:
> ...
> > Yeah, unfortunately it's not so straightforward. As a simple illustrative
> > example, consider a file-search workload, where you search through a large
> > number of files over and over again (e.g., a poor kernel developer trying to
> > understand how the page cache works). This follows an MRU, rather than LRU,
> > pattern, and readahead doesn't help much, leading the active/inactive and
> > MGLRU policies to have similar performance (~40s runtime in a specific
> > benchmark we ran). In comparison, using cache_ext (our eBPF-based caching
> > framework), we can run an MRU policy and it goes down to 20s.
>
> That's dramatic!
>
> ...
> > It's been well-known in the academic realm for a while that there isn't
> > really a "one-size-fits-all" policy that works *best* for all workloads.
>
> I think that that point has been less clear, outside of academia. In fact,
> MGRLU (to the extent that we believed we would eventually get rid of LRU,
> in favor of MGLRU) doubled down on the idea of one size fits all. So this
> is interesting.
>
> > Yes, you can make a general policy that works *well*, but if you really care
> > about a workload's performance and want to squeeze out the last 10-20% (or
> > more) of performance, you need to be able to (1) experiment and (2) take
> > advantage of application-level insights. Being able to extend reclaim (in
> > our case with eBPF) enables that.
> >
> > We wrote a paper about this that was published a few months ago [1]. Happy
> > to answer any questions and continue the discussion!
> >
> > [1] https://dl.acm.org/doi/pdf/10.1145/3731569.3764820
> >
>
> Excellent work, I was delighted to find a well-balanced description of
> both older and more recent history of the Linux page cache there.
>
> It's helpful to read this, even if we go with a non-eBPF approach.

Yes, thanks for that, it's interesting!

But I would say for now we need to defer any consideration of bpf being a
thing until we actually get things into shape in terms of improving and
modularising the existing reclaim mechanisms.

mm has been far too keen to take features without paying down technical
debt first and it's been very costly, so before anything else, we must
ensure that reclaim is both long-term maintainable and maintained.

In terms of reclaim bpf as a concept in general - reclaim is so very
sensitive to even minor changes, and I fear that people might find
something that appears to dramatically improve matters in one scenario, but
end up with an unusable system in another.

A bad sched_ext implementation might result in poor responsiveness, but a
bad reclaim_ext implementation might result in a soft-locked system, and I
fear that it might be quite easy to do that.

In any case, we can look at all that once we are in a better place with
reclaim, which Shakeel's proposal focuses on and I'm very much in favour
of! :)

>
>
> thanks,
> --
> John Hubbard
>

Cheers, Lorenzo
