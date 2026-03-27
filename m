Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DE3D1701
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598883; cv=none; b=WGC7KJqUTs/USlGg2PJNgpJKiR9VmPaH0AkRWp8URx/Ws50rtCU+vqX2BtjV3vy9kjEhzVJDgHbYSmeydLcQVCMx8ahW/c8dQiVRKNlUxpXbz2DtGYPTyBa+94X5IVl0N5HRC2VsUEkF0uWVQKewBy2rYgLBdnjEZgikTdf2vvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598883; c=relaxed/simple;
	bh=VlMNDZEd9oFY858FimXDgi9NsDwBberSZ/4nqr8aCyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upIMkfDg0t93pbZX5axGaoJvaGA3vFj1pI2HJj5R66+7sYl2IzyReFGQ17cuZ+zMD8ukS/AbWKyHAPVrvMM5fcZWGvkjJUgr6ArDWi5Juk2wC2xsrcOJUIKmbd1GA203OOasuJbk/V0rLZTWlcbJedzQH5dYwBtGW5MdlHASECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FFMHQR19; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FFMHQR19"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483ad568d68so2640575e9.2
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774598877; x=1775203677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbAyX/dJcdcrO6MnxnxfswzmV0uXORbDrNSB9i56BJs=;
        b=FFMHQR19PEG69twpsk5MQNTBGsksv1LViHTl5a6yQimH1MrDWr/3nK12NpsjNtWoK2
         PXgtt4q8vp/X1mgSbmCJlcDv4ajRYFsYDdOirRciBwC38P8phtszIK66nzXuSeyhdIg7
         qua9WybHy+Ud+9BQ3+5rqJEe+phqqT7LsnDFQkwa+Kzssm5Ls80+EySp+A/v8aPhFQWr
         a9A7i4ksCB0d9pjEaxsUDCJXMrcou++Pz8BdRLXNzyavlVLZDuAOPP5dJhUO5k+g4FDE
         PnJXByJCvwvVwKYArlqUcBXD+ucCg4+tTKY/yk1iwPyMr8BmN8O3iQQyI3tUlDaST2yY
         l66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774598877; x=1775203677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbAyX/dJcdcrO6MnxnxfswzmV0uXORbDrNSB9i56BJs=;
        b=sfhRzeuyynvXmCc3plsJ0HkQPFttmfGVhnog6pPGG1vm/GdJV7f9Pa8TcLECBla8Ix
         0uuT6dKMuPLx0AdegCYNdPEDyQUmEqvUsFD8R7n4pNWKgCCOfwQRPJz7IhC0NrEVTgR2
         STcq2ICSl1SClD2qkdN3GsQB5YmRXDnp56kpcKXaL5hXpRZJjKuIXuD7/vrgILSK7tAY
         54vSbMmI1CqoBCrfcgQHpL6dmxdvT710ClDWQjJPi+Y7/IxG39qIPIwRYbkCNracImy1
         7+0aexyoMM6fcwn3IlrvGonp7A8IR34I+9UireBxWJEFzJchyhdz1e9S8VPRrR+aVzX2
         FUwg==
X-Forwarded-Encrypted: i=1; AJvYcCV9k9XUEv8nU3dctyw2UJuJ6FaTSsp5Z9iTODasjhIviaziNhYVZ2kRzX5aDDluiagwDhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSSxMJ04bzzZbESvuCCcNwa7fGNB6gulxUdcpS84+poGoKXTqV
	6Pr8NWKsnOkgkN2Ndh3bihqOre4SqfxGTs1xNZGAR1JPhjO1vibO/epS/lt8fT0ky7A=
X-Gm-Gg: ATEYQzwfk6McpraqK9By746JIdjluS+RG9rZvq2nrTBnrxF+bJ8kscb9I3uRYrfKBjg
	ygutR+RDLJeGYE6AzT+RCf4ZNfGocAXaGsFrbMpq6/iMOMpAJ1FN+brXCGX+EYQ7KnEcoKxmj7z
	nbIgz/GX+Kiwy1GWSxXO2fUAJFlIVEXqD9W9WQZuyy0TayO9Jn1yMUHEROoubbZofI2xwXlnCbk
	M+EVrcWOuyFfLNv3di8/MmjPbj9FxXyCNR6iQDGLdw4aO8CxrSVIvk6P5XLL3U92nbvEBW3solm
	WIl0yuAjHvqC8UbPpvxoFKkhRh6aIR/BoCvbttVuWysLLpeQwY0KmFtj0v9iRdoyiyU/1DU8yMQ
	TPB2zJtKUqDcoxey15/H9zm25/RKSWsrJnuJGfauJHBdFfvI7i4L+c0Ec4z1Xz7FoqqRHO4SQUX
	20efuwDq6CMY4EKlAnf5SLBqiBrR5wesUk7AMM/gKbYeSvqwLRMGAyPmGaoQ==
X-Received: by 2002:a05:600c:1d1e:b0:485:385f:674d with SMTP id 5b1f17b1804b1-48727f0e5acmr12813705e9.8.1774598877151;
        Fri, 27 Mar 2026 01:07:57 -0700 (PDT)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c789ecsm79068835e9.4.2026.03.27.01.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 01:07:56 -0700 (PDT)
Message-ID: <8406d210-4f68-4919-b791-c03c310a8385@suse.com>
Date: Fri, 27 Mar 2026 09:07:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory
 Reclaim (reclaim_ext)
Content-Language: en-US
To: Axel Rasmussen <axelrasmussen@google.com>,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 lsf-pc@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Chen Ridong <chenridong@huaweicloud.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Kairui Song <ryncsn@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Nhat Pham <nphamcs@gmail.com>, Gregory Price <gourry@gourry.net>,
 Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>,
 Vernon Yang <vernon2gm@gmail.com>, David Rientjes <rientjes@google.com>,
 Kalesh Singh <kaleshsingh@google.com>, wangzicheng <wangzicheng@honor.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/26/26 21:02, Axel Rasmussen via Lsf-pc wrote:
> On Thu, Mar 26, 2026 at 1:02 AM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
>>
>> On Thu, Mar 26, 2026 at 08:03:34AM +0100, Michal Hocko wrote:
>> > On Wed 25-03-26 19:05:47, Andrew Morton wrote:
>> > > On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
>> > >
>> > > > We should unify both algorithms into a single code path.
>> > >
>> > > I'm here to ask the questions which others fear will sound dumb.
>> >
>> > Not dumb at all and recently discussed here https://lore.kernel.org/all/CAMgjq7AkYOtUL2HuZjBu5dJw=RTL7W2L1+zVv=SCOyHKYwc3AA@mail.gmail.com/T/#u
>> >
>> > > Is it indeed the plan to maintain both implementations?  I thought the
>> > > long-term ambition was to knock MGLRU into shape and to drop the legacy LRU?
> 
> I think one thing we all agree on at least is, long term, there isn't
> really a good argument for having > 1 LRU implementation. E.g., we
> don't believe there are just irreconcilable differences, where one
> impl is better for some workloads, and another is better for others,
> and there is no way the two can be converged.
> 
> On that basis, I would be hesitant to add some complex abstraction
> layer / reclaim_ops to facilitate having two. It seems ilke it may
> make things a bit cleaner in the short term, but long term might make
> that end goal harder (because we'd add the task of cleaning up this
> abstraction at some point).
> 
> My preferred way would be more like:
> 
> - Look for opportunities where we can deduplicate code, but without
> adding abstraction (e.g., factor out common operations into common
> functions both impls can call).
> - Identify gaps where MGLRU performs worse than classic LRU, and close them.

I'm afraid to identify these gaps we'd have to indeed split the MGLRU
differences (as listed in Shakeel's proposal) in a way that they can be
tried separately. I recall when MGLRU was proposed, we did argue that it's a
combination of several things done differently and they should be introduced
to the existing reclaim and validated separately. But the author refused to
go that way.

> We could go the other direction, where we identify places classic LRU
> can be improved, and port particular MGLRU features over to it. I
> prefer the other way for a couple of reasons;
> 
> - My sense is MGLRU is "close", meaning as Kairui said in "average"
> cases it is substantially better, and the gaps are both fairly narrow
> / edge-casey, and very solveable.
> 
> - Leaving classic LRU alone leaves the option for existing users to
> maintain the status quo. If we start porting MGLRU features over to
> classic LRU, we may introduce new regressions and break existing
> users. Using MGLRU as our working base means we can iterate on it
> without as much risk.
> 
>> >
>> > Yes, but MGLRU is not there yet and with development pace last year or
>> > so we are not much closer than at the time MGLRU has been merged
>> > unfortunatelly.
>>
>> I'm quite concerned about maintainership, as it seems the MGLRU maintainers have
>> not been all that active, and the MGLRU to me at least is currently a black box.
>>
>> I'm not the only one who's raised this (see [0]).
>>
>> That'd very much have to be resolved and the community reassured that MGLRU is
>> _actively_ maintained before we could even contemplate it replacing the
>> 'classic' reclaim approach IMO.
> 
> Very fair concern. Time will tell but I think things are on a much
> better trajectory now.
> 
> Barry's and Kairui's work here has been great. Suren's team (Android)
> is dedicating a full time engineer to MGLRU this year, as I understand
> it. I'm planning to do the same myself. I started by spending some
> time reviewing some patches last week, and I'm hoping to send some
> patches of my own in the next month or two.
> 
> I realize just talking about it doesn't mean much, action is needed.
> I'm hoping in a few months' time everyone feels much better about the
> state of things. :)
> 
>>
>> I hope that Kairu, Barry, Zicheng and others who are interested int it resolve
>> this, however!
>>
>> Thanks, Lorenzo
>>
>> [0]:https://lore.kernel.org/linux-mm/aaBsrrmV25FTIkVX@casper.infradead.org/
>>
>> > --
>> > Michal Hocko
>> > SUSE Labs
> _______________________________________________
> Lsf-pc mailing list
> Lsf-pc@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc

