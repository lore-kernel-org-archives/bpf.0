Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5B26AC3;
	Thu, 26 Mar 2026 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528294; cv=none; b=W54fP0OdA/MgKNdGj2Zgqiov6Ksxeg8ZQ6zRy4DvvZs/f8C+1YHCkaf8XNb5c6HRaGOkbeZoLI5RZuB2JSgveZcDcUuQpflWiQ+O3uy/NnXKMLteLYx+oMsb0MBEOqaKxUnLfJKhM8k3At5awIT+58yuApyL5+rc9pcDZkK8iRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528294; c=relaxed/simple;
	bh=mYVRjum22wCN7KHGtoG+3bBzHU9b1WB0/yHYlJYiUEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EK2gaqyjqNpLLm9ASSC+Ep9E+si7UvvoaDIRl6Fig/5ltidgAcQlS3grlQ4wY1u51UrdPRoK6qkZUhGyPiONyIRacbs6YgUwTRYuQYC3qIv9p8NQteC+MoBYvrSlDnQ7pmk+RQG0Z7/guf/AfpF/INtBD7Y9nG6YOQ3AjFCiqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO+CcAyy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO+CcAyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A38C116C6;
	Thu, 26 Mar 2026 12:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774528294;
	bh=mYVRjum22wCN7KHGtoG+3bBzHU9b1WB0/yHYlJYiUEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YO+CcAyyd+UxqKox1MoYb7gIA63PVa6WuBrt1uGObsCwB9tACMuiCvYfP/vltuVVa
	 jcRyyEOUWCnrYb8lEB61MAp4aRGLsEhm6o0nXJla2YhUQRP4VYkOlKDT/6A8nAdhvJ
	 2UhYM039ed67DUo+KSak6g+0IP4ICnn6PsXO68kBZO6v89sVc7Ip3YojYC531gyH1U
	 MGaazJyZWIRsllwO5f3xVDWsHO9UjmGpCqH8bTYbWTHU+dKgdyjtpqieO8JL3DzHkn
	 kZALWT1p4urNNNloM/U15eRnhwhluAF6W3Yg1o+jn7L2JRFoF3EjLuXIL4VE9AwMIp
	 wwVWUHhLAN3pQ==
Date: Thu, 26 Mar 2026 12:31:25 +0000
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
Message-ID: <f617acf0-6bb6-4ea0-85c2-d6f377a2a574@lucifer.local>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <CAMgjq7A01C+wyHxytZfVFVvaJ+gUNqkKvYN61_Peo911YaBHOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7A01C+wyHxytZfVFVvaJ+gUNqkKvYN61_Peo911YaBHOw@mail.gmail.com>

+cc Gregory

On Thu, Mar 26, 2026 at 08:06:13PM +0800, Kairui Song wrote:
> On Thu, Mar 26, 2026 at 10:05 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > > We should unify both algorithms into a single code path.
> >
> > I'm here to ask the questions which others fear will sound dumb.
> >
> > Is it indeed the plan to maintain both implementations?  I thought the
> > long-term ambition was to knock MGLRU into shape and to drop the legacy LRU?
>
> I personally also agree on that, so far I'm not aware of any major
> issues with MGLRU except some corner cases that are not hard to fix.
> Once these are done, I don't see the need for more complexity.

Well... :)

What about the issues Gregory raised here?

https://lore.kernel.org/linux-mm/aaXM7xNSJaJBsety@gourry-fedora-PF4VCD3F/

>
>
> > And that Linus has expressed such a desire, but my googling fails me.

Yup I know, and it'd be ideal to have a single approach, but we definitely need
a little more assurance this time that it's the right choice :)

In any case I do agree with Shakeel that de-duplicating the code and 'stealing'
good ideas from it for both flavours of reclaim at least to start with is a good
way forwards.

Once we've done that, we can work towards eliminating the 'classic' reclaim if
the data supports it.

Thanks, Lorenzo
