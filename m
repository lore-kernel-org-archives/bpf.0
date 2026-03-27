Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E912DC359
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774641194; cv=none; b=MspWf+vhUi07oOgq2vDb4ZyxgyYzMciUtKFBn5sVwKGA4EfTz1YvP9NahbCPQm/yeYKc/V2yujYtTL8XNYsYhRVJrf53Tvz01OmzwsfpCV10S8p8uSBSElzptG2OcWokT/OqnJst+NU5c1M4bcWB2ZGXGHI9ARLRY0a8OATuar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774641194; c=relaxed/simple;
	bh=GEDJYkft/OmVVsV+DTZZJESwv5gAYjzclww29/nA0QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHAG2OZypjXjOAypKyZm4YXV7MXxqWIZK3Nyi0ms4xLcRwzhIux4AUU+Fv87l02PBBGQcEOMoXHSLLSH5DMROvyEnqRm2cpR4/JbJZCxUHcAur32shwCNCwOIdZcuKntTcMDcOfxg+qBXMy1QRuQj6Z38mlhJZjnmKZ7nw0Inw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=VVwz4gkn; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="VVwz4gkn"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899a9f445cbso28630866d6.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1774641188; x=1775245988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sprVlPGXU/l7BB3P7Z9OXglgjV345FzoAVG09a2hhrs=;
        b=VVwz4gknqGe+VL5Cey4QObyH3ZDYIvL/eFh7A+PpdJYXnaf6JTbCvU4c2NaVDcAgU1
         1qj0mSy6gqzksGLhPOgJwYYxw2sx29jf0Y6mIR9DP49q9Wfj9QMg9SW8VHdGYPuo5Exc
         0yMwQDVQVLQ6ehHrOxtRVtjbMMuhDe6bYuH1drxwMqycot2XpS2BMd2xfQw5G//W2e7+
         oBmrjo6XprYW8BkhE31YMJTHc4gy+8ICmuQe7GiPKFhcybmsmjTqFleMHHkM8xBn6zJB
         /YIsOpHElOqsWJDZxi1WoDRQl84bxB/D8wjkfb4HeJWfws6bjWPlgDaxNLeHVBFO1rhG
         ZwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774641188; x=1775245988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sprVlPGXU/l7BB3P7Z9OXglgjV345FzoAVG09a2hhrs=;
        b=k0Iw2k5NLmWD2edoS+Rj2vTatylQyyqSO1smCBQ6l6bEylVyX/jc5JatvdFutQeVeb
         6pYZYeMvAw0oZna1s8SyoiyCZRgekfWem8wIdInIZIyMj827awLq86adpuV1BQXnoGN/
         dE9fvcudAIn8EoEeog7L1QuYPJIJnr15l0EPZfrPbSVkWRxmvd60mWmOQzPwjSIKZ7Y3
         Q3zBkC+USs0+ZaxagZqVmBkDt4HVrcY9t7q6Pv93vzwizvPd2zT3LkG1xGirkyqwq38j
         /oBbth7CDkRs3fVpwsvZLG9iZ1ofKaX90xD2PVMYPaOJiMU8HCpEmcrPlmdQXcAt2xuw
         MAgA==
X-Forwarded-Encrypted: i=1; AJvYcCWBzGuEqzEDXL/YIo377LD068/zoFcSMFyAUJJJ1G/rw5hMjvWR3PdOnSPlO5Cb6H16A1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YycPzYqiOJeIoGc7J2QwIfr70khFWAbyGylNfJmjwwc67Cn3lV3
	NPz3/RIU5P2jyyxvVcSSb5jsqFrXUT1FH9dVr65bwoDHLssNeGdNoUG999Znb3OQfaI=
X-Gm-Gg: ATEYQzxGPKziNRZqg8ykBqgAyEDT8UHHrTr+U8dsvW2ImvTUnfLRM4RlBTRStm4WbJH
	9HQ9ixmcN71hoDLqM3OvqtuUAIsunr44gFsyHcWK1WnD7CP5dFz/kCJ6diK6yU9JuKzlrjfFgxy
	D9fqkA96R3oi3p5olzO8535BXKC0vz2fuKOjQXGciv/SUVQVQAFkMER/Mfs1jWrZjN26ukHDfJB
	SPOE/RTPLJrRDocNWINyBOu/8kkbfsAu/9seG96KRCtOZVn0iMLvJ1Jhg3aTnPGpIOLJHvNtb8Z
	g9yw4ehObRkHOMJYFvzhnNAr8yizYNqGX2l9ohpjci30vc95Jc7f6MKCQiSAuv7TqKNTr9QCU5M
	Pfw1LReHJRK9JixQgbkP41fMI81CQ2B6RgMrQZyHNmtbgpNtkj71U/8VNhrMlSeajRbUwgLlw/A
	sWOqNeAWzNQD7JC0MlU+7UJ29O8qFwNQiL
X-Received: by 2002:ad4:5deb:0:b0:899:ea9e:31c2 with SMTP id 6a1803df08f44-89ce8fab7d7mr48646526d6.58.1774641188243;
        Fri, 27 Mar 2026 12:53:08 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf866653sm553286d6.35.2026.03.27.12.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:53:07 -0700 (PDT)
Date: Fri, 27 Mar 2026 15:53:04 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Gregory Price <gourry@gourry.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	lsf-pc@lists.linux-foundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kairui Song <ryncsn@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>,
	Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>,
	Vernon Yang <vernon2gm@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	wangzicheng <wangzicheng@honor.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <acbgIKuwDsPvPjdF@cmpxchg.org>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
 <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
 <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>

On Thu, Mar 26, 2026 at 03:35:28PM +0000, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 26, 2026 at 10:24:28AM -0500, Gregory Price wrote:
> > ... snip snip snip ...
> >
> > > >
> > > > How Do We Get There
> > > > -------------------
> > > >
> > > > Do we merge the two mechanisms feature by feature, or do we prioritize
> > > > moving MGLRU to the pluggable model then follow with LRU once we are
> > > > happy with the result?
> > >
> > > Absolutely by a distance the first is preferable. The pluggability is
> > > controversial here and needs careful consideration.
> > >
> >
> > Pluggability asside - I do not think merging these two things "feature
> > by feature" is actually feasible (I would be delighted to be wrong).
> >
> > Many MGLRU "features" solve problems that MGLRU invents for itself.
> >
> > Take MGLRU's PID controller - its entire purpose is to try to smooth out
> > refault rates and "learn" from prior mistakes - but it's fundamentally
> > tied to MGLRU's aging system, and the aging systems differ greatly.
> >
> >   - LRU:   actual lists - active/inactive - that maintain ordering
> >   - MGLRU: "generations", "inter-generation tiers", aging-in-place
> >
> > "Merging" this is essentially inventing something completely new - or
> > more reasonably just migrating everyone to MGLRU.
> >
> > In terms of managing risk, it seems far more reasonable to either split
> > MGLRU off into its own file and formalize the interface (ops), or simply
> > rip it out and let each individual feature fight its way back in.
> 
> But _surely_ (and Shakeel can come back on this I guess) there are things that
> are commonalities.

There are some commonalities, but MGLRU was almost maximalist in its
approach to finding parallel solutions and reinventing various wheels
with little commentary, explanations or isolated testing.

For example, MGLRU took a totally different, ad-hoc approach to
dealing with dirty and writeback pages. It's been converging on the
LRU mechanism. This process has been stretching out for years, with
users eventually running into all the same problems that shaped the
LRU implementation to begin with. Yes, you need to wake flushers from
reclaim. Yes, you will OOM if you don't throttle on writeback.

There are many other divergences like this that complicate the picture:
- Cgroup tree iteration, per-zone lists to implement node reclaim.
- Divergent anon/file balancing policies.
- A notably different approach to scan resistance.

Many of these were not part of the main pitch at the time, but they’ve
created sizable technical debt that we’re now forced to reconcile.

I think MGLRU's NIH-attitude towards the problem space set it up for
running into past lessons again and learning the hard way, just like
with writeback.

The good thing is that there are some integration efforts now, even if
they don't come from the people that promised them. And some of them
do exactly the targeted, rigorous tests on a per-component basis that
is needed to sort it out (and was asked for back then).

But there are many workloads, many hardware configurations, and many
cornercases to cover, so this will take time. The end result doesn't
just need to be fast for some workloads, it also needs to be
universal, robust, easy to reason about and predictable.

Based on the current differences and how unification has been going so
far, I think it's premature to claim that we're close to deleting one.

And the current code structure makes it difficult to whittle down the
differences methodically.

IMO modularization is the best path forward. Giving people the ability
to experiment with a la carte combinations of features would make it
much easier to actually production test and prove individual ideas.

A nice side effect of this is that entirely new ideas would also be
easier to try out.

I think a good start would be to keep the common bits - "library" code
like shrink_folio_list() list and shared facilities like kswapd - in
vmscan.c. Move LRU and MGLRU specifics to their own files.

Then as much as possible extract and generalize functionality into the
common code so it can plug into both. For example, collecting accessed
bits from page tables instead of rmap chains should really not have to
be specific to one. Nor how the cgroup tree is iterated.

It might be possible to make N lists a natural extension of 2 lists,
so that the tracking datastructures themselves can be shared. With
minimal parameterization from the policy engines.

If we can get to a place where the only difference is how reference
data is interpreted and causes the lists to be sorted - you know, the
actual replacement policy - that is a much more manageable gap to
evaluate and argue about. Or swap out to try entirely new ones.
