Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D7279329;
	Thu, 26 Mar 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512141; cv=none; b=b7JO+qOFibjNqNeDHypcKA3gAZHLJ+BmkgP4mXRvRZfU7PSD3niKQ8YL2xOos0E5GHUzNmXUd1NXywUIYPC6qLaZqDln+cuWhUrHy/2mu3ycfkVx8xt8GufBHqs0lgdnaE2FyD9zzGHBjmvk40hyxBq3nu66sApFd1wNknQPOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512141; c=relaxed/simple;
	bh=A48kUkO1TtrycoKeHx6/YYvUwwXAqNBRegZ4mzWsWV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABluFPLwFnK5JfuLHHxrdaZ6SIYahtKNLmBJGxXWIoP3WbfmqQGaH4+4US1aZJw03w9yoXLd6PHRuO5s29VHl62Bo/ONXhEXijccBL8Elhs27CdtXncxMDWEcx9z4f2hAXM0x58NDj+5hKuMghPHB/c9bzzb1q5xRR6hI7l0BkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT5Q7FdA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT5Q7FdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF66C116C6;
	Thu, 26 Mar 2026 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774512141;
	bh=A48kUkO1TtrycoKeHx6/YYvUwwXAqNBRegZ4mzWsWV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AT5Q7FdAlt3PjmHZzDskG9ydXKEAAtzJIYmfbCnqz4kza5CM8AFrdE85fKpjjpwaL
	 Fz9NS3JMR46gZG5WOmxUP+m5ol0ITjKrkBLpYaITOCWuvUtvlKoQEt2i1TmNgJ/5kT
	 /vi2HHCpuLyAfLcrIv1VF8ZsQRsxuZfS9Hh5aAW7+I6XJHo62HxOFe2X3k7t2y+kbd
	 anSt8hYP/MrBl7AOcj1nDnufgSjSZIu6bGXfQ9Q/f0ItuTNirDMGrO63KUZUNRjO2Z
	 2LP7Gpg2SrePNK7jtESKiWS6TcJFkG1iMO13I1S/ZMPZJ4ikkWCDcS1pdefCZXu+R3
	 SviBOW7FWSV/w==
Date: Thu, 26 Mar 2026 08:02:12 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, lsf-pc@lists.linux-foundation.org, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Chen Ridong <chenridong@huaweicloud.com>, 
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
Message-ID: <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acTaRgusrxfCoKqe@tiehlicka>

On Thu, Mar 26, 2026 at 08:03:34AM +0100, Michal Hocko wrote:
> On Wed 25-03-26 19:05:47, Andrew Morton wrote:
> > On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > > We should unify both algorithms into a single code path.
> >
> > I'm here to ask the questions which others fear will sound dumb.
>
> Not dumb at all and recently discussed here https://lore.kernel.org/all/CAMgjq7AkYOtUL2HuZjBu5dJw=RTL7W2L1+zVv=SCOyHKYwc3AA@mail.gmail.com/T/#u
>
> > Is it indeed the plan to maintain both implementations?  I thought the
> > long-term ambition was to knock MGLRU into shape and to drop the legacy LRU?
>
> Yes, but MGLRU is not there yet and with development pace last year or
> so we are not much closer than at the time MGLRU has been merged
> unfortunatelly.

I'm quite concerned about maintainership, as it seems the MGLRU maintainers have
not been all that active, and the MGLRU to me at least is currently a black box.

I'm not the only one who's raised this (see [0]).

That'd very much have to be resolved and the community reassured that MGLRU is
_actively_ maintained before we could even contemplate it replacing the
'classic' reclaim approach IMO.

I hope that Kairu, Barry, Zicheng and others who are interested int it resolve
this, however!

Thanks, Lorenzo

[0]:https://lore.kernel.org/linux-mm/aaBsrrmV25FTIkVX@casper.infradead.org/

> --
> Michal Hocko
> SUSE Labs
