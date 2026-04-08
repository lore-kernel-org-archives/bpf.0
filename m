Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D722370A;
	Wed,  8 Apr 2026 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630945; cv=none; b=sdf2Q8tYg1UKnWfW5yqELU4uBUJ6osrn3jLQOq1JaL6JZJtszuX5yF9RsGUvFM/urkAHpty7gKoLKbdesshIE7lGpA7BIoupx83GgvXyi8E06PSmjZI0tYgyFWgz1Xoxkw+YEbUj9kRa45UigYeCNAAKYkTQ43cPh7Q0sNwTtd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630945; c=relaxed/simple;
	bh=Jf27xk2PEb+D+m73rLzzPti70YoNYsdCvSbCyz5KRkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td+Xf/8pXJLn/1ed8nDgh5OhbiybwDxAXiazdXlNIZsbEZaJDHs69TznzAuJaamnXHyEvGsYxLrdAkcZf/tHVi3JlQdG2jifdTxnZ6Q966g8PJSAV3dqTA5G6uHvbIBkpyH3quQ5qu31W4vbxTIt4Ba2uvipch00X3K2gYtWkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4NFTZAU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4NFTZAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DA8C19425;
	Wed,  8 Apr 2026 06:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775630945;
	bh=Jf27xk2PEb+D+m73rLzzPti70YoNYsdCvSbCyz5KRkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4NFTZAUGXJlYJi1cB1XvfzxzdGTopyBo3L3YcY86XA142N96ZrAP2E8Z7cICnhLE
	 6AeES82rZ1GsQxLKVt6MkUHPfg+P7aIRFJgyQpgbmVrbSsa7jW85ipzT5C6LDcS0XP
	 gRoSDzQgopOYGZbbOnFfFufWbjcN0mV7jrsb6rLPGUY7f4w4xUxlKOoWXKNQODNu2E
	 mZd3Qix7Buh60T4+rmK4cx3a5t4M4Pm5adIEofTwJpiX1TKY3djbBbAAYSinFuRLaI
	 RP+58r0yTBQ6QMvYP/COqOMpaf/w8MiS5qx3fyLn/tFDdAP7Z2ZdXxVtxUdC6c2c//
	 HJbDftmUH6B0w==
Date: Wed, 8 Apr 2026 07:48:57 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, lsf-pc@lists.linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Chen Ridong <chenridong@huaweicloud.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Kairui Song <ryncsn@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, Barry Song <21cnbao@gmail.com>, 
	David Stevens <stevensd@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	David Rientjes <rientjes@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	wangzicheng <wangzicheng@honor.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Suren Baghdasaryan <surenb@google.com>, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <adX5txC9tGPR-iyX@lucifer>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
 <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
 <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>
 <acbgIKuwDsPvPjdF@cmpxchg.org>
 <adTonuzmUc2AzUhp@lucifer>
 <adU3P9fk8h-AmEp4@gourry-fedora-PF4VCD3F>
 <adU8VnzlLw9JUHB3@lucifer>
 <adVPAS4PP7wK0Pxq@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adVPAS4PP7wK0Pxq@gourry-fedora-PF4VCD3F>

On Tue, Apr 07, 2026 at 02:37:53PM -0400, Gregory Price wrote:
> On Tue, Apr 07, 2026 at 06:30:55PM +0100, Lorenzo Stoakes wrote:
> >
> > > somewhat trivial work these days via <pick your favorite LLM> with
> > > reasonably well designed interfaces.
> >
> > Though to be honest, I did ask Claude to do this with some code before and was
> > really impressed with how quickly it came up with something.
> >
> > Buuut I've generally found the code LLMs produce... terrible? Really terrible?
> > So I think you'd want there to be some level of human improvement there.
> >
> > And in any case, maybe doing things this way will struggle to really represent
> > real world cases (lock contention etc.) but OTOH, being able to simulate a high
> > memory pressure environment with certain parameters even without [the rest of
> > the kernel] interacting might still be super super useful for diagnosing issues.x
> >
>
> There is a concern people start looking at these tests as signal for
> performance regressions - which is neither meaningful nor useful
> (unless you fundamentally break list iteration or something).
>
> But for trivial cases, you'd at least like to know under strongly
> controlled aging and reclaim scenarios that anon/file memory is
> reclaimed in a balanced manner - just as an example.
>
> If something breaks THAT assumption, you know there's a logic issue.

Yeah and you could assert a lot of things like this, for me the real value would
be in extreme circumstances which might otherwise be hard to simulate.

But it'd be testing very specific things rather than 'how does an actual kernel
behave in this situation?'

>
> Likewise with comparisons between LRU and MGLRU.  It might be easier to
> identify the behavioral divergences that way.
>
> But i fear the whole page-table walk thing makes all of this a
> non-starter.  That's turns into stubbing out like rmap and such.

It could grow exponentially yes :) it was hard enough isolating the VMA logic...

>
> ~Gregory

Cheers, Lorenzo
