Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A929DF59
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580997; cv=none; b=vDNKhYofind7I32/igFKk9YCsSPgBbW2TXkOZEpbTyjrm6aobunmKG67nTZDAbPXe8dXaeUQFOQl4HjpaFqi7alxSMwlv6Gm8RXQZE2g2xWEH8XCBytAAqR9+zUUybIOazQTvHbaVFbPlpZgvHZsSaRGuLCAeKBrlNsknxHnsdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580997; c=relaxed/simple;
	bh=m4BA0r0vR0TWiGRCvzFGAUHxARXfu4Wud/rIjLCribE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx825dqex271TEbrxmtclBOz3h5X4SPLW1/ji00n9a9AYlHMwjlZT0Ne5u7CO4i7XU1chHA9QAs0gdUhhvNyapQM9t3CEzDMewGUx8Csv0zdxUcmOi3GgUoA/Ufy0TqUFRQLhlu9trDfpzKjjA35IF430OhFQ1yMV8gCBrj9quM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CX8rJbY+; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CX8rJbY+"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89fc4147f2eso67212806d6.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1775580995; x=1776185795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5H/LTMuHhHjt9i0cJQj2AuHwgZLtfBSzlCy+PjveH1U=;
        b=CX8rJbY+GW8NMMqmfnv4/CJ155O2uRApVBjYJ7TVkYltcwDUsy0Iq78tqBpIdzaHsU
         TOTWKre6c/5lMTmiSCl8aiFYehWPWX5mM5+4xZ3JsTktwGkgy6/b2ipXufSNjVmLaUNm
         0Yv6Oa/IGuFjWdF0A6eYSd/nzrumOeWj8hYSGZ9T8/nuULFTCGV9mac0ps+4Bq1pSWLJ
         WyRdP62dZt8BKmH1vnHaDhmVqDtXZf36EktTnOM9Pqx+wA8DkPxmnO4G+OqRa/sCn5QG
         gZK4f3WsBnNiuGMe2odb3TxiZ/faboS/T1Kx1aIJq1yFri5djzZm++g8123B1SZaf6BB
         WtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580995; x=1776185795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5H/LTMuHhHjt9i0cJQj2AuHwgZLtfBSzlCy+PjveH1U=;
        b=Xdu/wqPTQF1lV54oFh5mbw4pCfTJ8l2QqMBEJRiEf52n50uGx4U+yHZja1T6NRN/xO
         Ybw5xhOcNjUQGlyqGdMVsJvabiluVbKBkfvufnWIbccT2cGlID8IQ9w/YFQtUDAJV6Lv
         EUr5dkWxI2pvlQ4i64M/SORfweah/+eU5SkF3NFkR4h9+Lu9Zwb0bjVNqhQEjXEB9Z4u
         PIRBTQfXCIAuLXL1n4coiGYSFMVQN9QOq/KGfccdPwi/d2dry+Wa1+xL6ISvqzSwwwDr
         Nw0KN6CjeZVmI1iBUNhvobdvSxZWWKAgGEEkZtHjVIG0YX6BDI99R5Km7/8Hg3ZSw8tO
         iVYg==
X-Forwarded-Encrypted: i=1; AJvYcCWCxtSyQixwIzbpgJae3m1KcuJr5gLzMPh8Epjz6dFxtZ55Vx07LQpR5d2Bh3TNSypbjmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9EpZIsKBuDqVm306ACpWEyNSLFPe95g56FaUHZ53bPjisjEy
	jK05RDzG1fQcoi6u8anbp5U3oXj+4pspryhF/eQz7t37txasw0CN+TWTzKsQN5PBXIc=
X-Gm-Gg: AeBDieuUwSwyIi1cTjK+o9HyaGVGCslpLKtvfNMyyy1UMQNQlMqpO2xGN7zck001QBO
	R0NV1AtbPpuo3woRw6mtzEUV9YJUKs81+jIhWrJSq1bhKKSRlaHBV4U7c53l7nEuq2e/tWukXrj
	BUyBmjZwsFz0Cwd54Et61Qh9Y4ueDxfdqnod3uhOCGrf4vhKdzm+MYrr+yxtdmWXyo/RC//+cQB
	PUb4JtJ83hLI8WRXwLXEJAu8kC4P0Pmdd3ifEN8GvseX8Mt8DjDWiALdKzcBfPXiKYwI97VeG8M
	iZ7DwK/IBIY0clu1+1UQQIC1rsdohs/c62bqX8RxOFjltK/we115PRLANWg4+eSykGFim3cKR4b
	CEc2bk0zBACldFFLoro+Cb/p+BmsWqVM8GXCyZnnB9Tv//Df7k+05tfG4w8afGcDHd8A4699FMo
	oRAH4IX1v85xIwWEElKd0HcUbrZdNBCs61PaXvswh8E8cGbT5fTg+DUUg3DAIVQsVXmjCsGHhsC
	Cumz6ZjPLqE8hfJxml/cpw=
X-Received: by 2002:a05:6214:4883:b0:89c:518b:9dbd with SMTP id 6a1803df08f44-8a704da7fe5mr324190956d6.46.1775580995082;
        Tue, 07 Apr 2026 09:56:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf4b0fsm154393106d6.15.2026.04.07.09.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:56:34 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:56:31 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <adU3P9fk8h-AmEp4@gourry-fedora-PF4VCD3F>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
 <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
 <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>
 <acbgIKuwDsPvPjdF@cmpxchg.org>
 <adTonuzmUc2AzUhp@lucifer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adTonuzmUc2AzUhp@lucifer>

On Tue, Apr 07, 2026 at 12:36:36PM +0100, Lorenzo Stoakes wrote:
> >
> > And the current code structure makes it difficult to whittle down the
> > differences methodically.
> >
> > IMO modularization is the best path forward. Giving people the ability
> > to experiment with a la carte combinations of features would make it
> > much easier to actually production test and prove individual ideas.
> 

...

> 
> In a possibly, fantasy ideal world scenario *puffs on dream pipe*, it'd be
> amazing to somehow isolate the reclaim code in such a way that we could
> instrument it for testing purposes.
> 
> E.g. if it could be invoked from userland, or UML, or _something_ and then
> faked out to have a certain configuration of X NUMA nodes and Y GB of RAM
> with Z processes competing with total observability of what's happening in
> the algorithm that could allow for really robust controllable testing and
> regression tests, as well as possibly some form of fuzzing for broken
> reclaim scenarios.
> 
> *Puts dream pipe down*

*picks up the pipe*

At risk of being shot - this kind of stubbing / functional testing is
somewhat trivial work these days via <pick your favorite LLM> with
reasonably well designed interfaces.

   ( read: probably not with the current api n_n;; ).

So to get there, we'd need to agree on the refactor work and interfaces
that make it possible to model the scenarios outside a running kernel.

If we do actually want to move the core to look like:
  - vmscan.c  : core library
  - lru.c     : standard lru
  - mglru.c   : mglru

Might as well consider the functional testing question as well as we
decide what those interfaces look like anyway.

*throws the pipe into the bikeshed*

~Gregory
