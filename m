Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83D2EDD70;
	Thu, 26 Mar 2026 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532565; cv=none; b=g0CdnYvHkk8q39Vlextf4mHtWYpakn3nFk1MS8nm4z5dOJB8JKGPMRplsfSiDZ4xo9Y4qGQFkzuJyGXdhTt5CGCOsZShoJJZH2Ul2XlqXXvpwzLIqV12AOEzCP4ENPecf8Cd3JJBRV+sTSvW8GRvXl4DuZ3IEJJR8Ks5RqGyL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532565; c=relaxed/simple;
	bh=aqeaVyOgj2nhbWGaqNG8pdXcUvJ3CJyTuuyl/s9Mc8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISC1NXFZ7zfapwjOfy+StLd9wV1GRk3Pi3z8BWbaK1JYN4+d4udfPuEUSA+v9wc+hGB2TJwbfnRyiREayLq7O34UJ2Cd9m7q17KVQTC17HwFJj1qh8vuJHihnNVoi9Z+OUTJ6OQq7Ly2lQihrWKihOGGjZQDVevn8t1htZmorz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV5ljdU2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV5ljdU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4449C116C6;
	Thu, 26 Mar 2026 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774532565;
	bh=aqeaVyOgj2nhbWGaqNG8pdXcUvJ3CJyTuuyl/s9Mc8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kV5ljdU2Wlclco25t1YBWfkmbtNb8y5Yi56M5iUA09lTbuQX6gK8atvoEY3qoPku/
	 UVfi34mtvWbnQ8f4MEPq+UdWzHEcHVC3df6ldOkrnV8We3h2oGHjGobdaN/B0fjgDD
	 kz/x1kP7/HtIcvP9AmZZtDC8Q5F3naLPxqHX1Lzn+m9CSuYCh/4Y/BBndrfQbvpwD+
	 8MCfggugpwG93/9MBrNYPJCKTEe98O20LnYwgTWLagqtpDz8x/THLxcYaULLgJ4w6a
	 CTnat6u3U+wX98CDuB6VZjqa03cbOOYuFYUwtO86iQ+FNIVAcyqJjMZ+3ZU2Jafx37
	 kqFy5mXfAEDkw==
Message-ID: <b340e43f-2e08-4a77-8176-e49667387e85@kernel.org>
Date: Thu, 26 Mar 2026 14:42:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Kairui Song <ryncsn@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 lsf-pc@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Chen Ridong <chenridong@huaweicloud.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Matthew Wilcox <willy@infradead.org>,
 Nhat Pham <nphamcs@gmail.com>, Gregory Price <gourry@gourry.net>,
 Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>,
 Vernon Yang <vernon2gm@gmail.com>, David Rientjes <rientjes@google.com>,
 Kalesh Singh <kaleshsingh@google.com>, wangzicheng <wangzicheng@honor.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAMgjq7B_twv3xhd5VmMJxngAknf9YaLAiwGYpdi6H2n1cXD3-A@mail.gmail.com>
 <67f1588e-a094-413c-9746-9c28bdf6cc56@lucifer.local>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <67f1588e-a094-413c-9746-9c28bdf6cc56@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/26/26 14:13, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 26, 2026 at 08:37:06PM +0800, Kairui Song wrote:
>> On Thu, Mar 26, 2026 at 4:02 PM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
>>>
>>>
>>> I'm quite concerned about maintainership, as it seems the MGLRU maintainers have
>>> not been all that active, and the MGLRU to me at least is currently a black box.
>>>
>>> I'm not the only one who's raised this (see [0]).
>>>
>>> That'd very much have to be resolved and the community reassured that MGLRU is
>>> _actively_ maintained before we could even contemplate it replacing the
>>> 'classic' reclaim approach IMO.
>>>
>>> I hope that Kairu, Barry, Zicheng and others who are interested int it resolve
>>> this, however!
>>
>> Hi everyone,
>>
>> Right, I think we are starting to make good progress on improving
>> MGLRU recently. For the last few years we already have some commits
>> stashed downstream to enable that on our fleet, most of my effort in
>> upstream is spent on other parts like SWAP, really looking forward to
>> making MGLRU better upstreamly.
>>
>> Yesterday I was still discussing with CachyOS folks about their usage
>> while working on that series for MGLRU cleanup and dirty flush
>> optimization, and got some nice feedback later from their chat server
>> that MGLRU's TTL resolved their thrashing issue very well. With
>> classic LRU they needed a le9 patch downtreamly.
>>
>> For many other typical workloads under stress, MGLRU performs
>> significantly better too (e.g. database, build kernel could be more
>> than twice as fast), it would be a huge loss to leave it unmaintained.
>>
>> Barry also provided some really helpful ideas about MGLRU like
>> readahead handling. We are also seeing other vendors and people
>> contributing to MGLRU like Leno and Baolin recently. Things are
>> looking promising.
> 
> Guys, can I please make a plea then for you guys to AT LEAST become
> reviewers in MAINTAINERS please:
> 
> MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)
> M:	Andrew Morton <akpm@linux-foundation.org>
> 
> Well Andrew is Andrew :)
> 
> M:	Axel Rasmussen <axelrasmussen@google.com>
> 
> git log mm/vmscan.c has 0 results.
> 
> Axel has however engaged in discussion on
> https://lore.kernel.org/linux-mm/20260318-mglru-reclaim-v1-0-2c46f9eb0508@tencent.com/
> recently for example, but not much in 2025 afaict.
> 
> M:	Yuanchu Xie <yuanchu@google.com>
> 
> git log mm/vmscan.c shows 1 result from August 13th 2024.
> 
> Yuanchu has engaged in some MGLRU discussion also recently, here and there.
> 
> R:	Wei Xu <weixugc@google.com>
> 
> git log mm/vmscan.c shows 2 results from October 2024.
> 
> Wei doesn't look to have engaged in discussion on MGLRU recently.
> 
> L:	linux-mm@kvack.org
> S:	Maintained
> W:	http://www.linux-mm.org
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> F:	Documentation/admin-guide/mm/multigen_lru.rst
> F:	Documentation/mm/multigen_lru.rst
> F:	include/linux/mm_inline.h
> F:	include/linux/mmzone.h
> F:	mm/swap.c
> F:	mm/vmscan.c
> F:	mm/workingset.c
> 
> It doesn't really feel like MGLRU is currently maintained at all, quite
> honestly.
> 
> So I think we need people to step up here.


Ans some serious cleanup of the entry to reflect who is actually
involved nowadays, if at all.

Master of MAINTAINER updates, I assume you'll take care of that?

-- 
Cheers,

David
