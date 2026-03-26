Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C737E2F6
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509135; cv=none; b=pY2QqXubS+1FjO77FTuteA4AP3HABvfV8xQorutv1sQvYEfOWWPxUsv0h+5kXJoYiOnNv6Mv1eus6QZ+4TY5J/o267EUNxoyD5T7XVJ05hjh5S0pLNvoed9HMWKliJCUeoBYE4IoAY/hgb7dbukJD7tUhlUnQijXv36ouxfUZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509135; c=relaxed/simple;
	bh=je6fVXQQCNMzDWDuKBS0sFm2G6QMB8sNPqvTxydZrQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLdq8eO9ptq9hln62Owq25UEIRxMI42xheqV0amdXEbvf17g7dX8n/i8JBQUiNKTXoXiu/6H0gOcXjbSb48K6T/jkZIPEPA50icio4wa5JGAZzdgMBczG8ZVLs/EsL7lvUjaktBWunyaFCqViZmk09pw3uWs536mWNYXPDduNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KbXe7sSQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KbXe7sSQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486b96760easo6377585e9.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 00:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774509132; x=1775113932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGB0D2sZA54TniG5EwCWeLwF5KVbzKrKiN8v1Y36amY=;
        b=KbXe7sSQ5R6JYZDfKCeS8NZP9jJbfdnzuELQY5mH8DJIzB2+0jbWL7w210v9SghH0H
         46TCRut72fEat9BJHRbX1qz6rb289IfSA6VVKLtOmdgpY3Ku3JpXmSN/jpukHBAxVOwP
         mfmO0sjlgVmQvtGVtFlr0VN6n8G9dtDboMmaErkPW1mOMfZIFMaJO9D32bVtG5hsKrop
         z/MtCreYlGBVchY9xBDLVRh5aJDQJQ5yIkDiW7O+UBiHqqTzJyY16OlrDl/yT0P17sky
         akc7Mt2Wsi1QHTizZEZO5iLqjh3P90bi72JIb1LdQqUy9dKLutmnwNPy0e5iagcDuEt3
         drZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774509132; x=1775113932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGB0D2sZA54TniG5EwCWeLwF5KVbzKrKiN8v1Y36amY=;
        b=rEGh5w5JYAfrw/0FWp1Hk472a1Nv3bvjjnyGoTK1EuUnpLHqBBmS77zCVXiB/4yF8p
         hpAdxW/soRoHcMq/cwDpcsFVbz13Cpitnx9FnUTwiO3I5ns/Lc1s9j1LkEP4thXnEi7x
         P2MLhpQ/EEaJ/pk0BDbMPr3eYGHrKz6hLqAVK+YFjsxOCE80gm5IvgmeFp/DDzcxUah6
         khpSjrvaG9Hufrq498ImGVrxysdy921anE4CuVdQhpkfZnk3B3aOvB+ScDWImHmOF+2c
         AW3+L96qhdnsDvjGvFa18NPV14uUJTjTY5CArf6zQ7WF/64Ivg6N/rFMdpumTYbvEKtr
         1zkA==
X-Forwarded-Encrypted: i=1; AJvYcCUyRXvHBlCBK1FshSUYjGUTF7h1elwiRSG/vvZEw0JvRD4SOwEW2Hukb3Ui5xYbUY0rMZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWTwZhfI0y02W2JHy2nTHTPWX+q7WJpznHYaKqGsIXMWhYNoh
	v9W5FPU7sJTeDDszInzop8sPXCdzeF6wplD5L8fslFRff0LsHVhyjiHZSt5tGAXmLe4=
X-Gm-Gg: ATEYQzyOzdpPVCACn8CtXv4lWy97C9zS+mE17cobT5Yg4xOGnlnm6afLYYo2bF3X1Mj
	Eh2dT7VO2nDdK4GfOUHwlrV31ItsFGGNq4ecgqSW6mmXGD5OW6lZAXBqElOQgHOqHSP1J97UbtP
	q1tEwNzGxMf5nbC3xDucglozz0hZK2uqHTwmPgkD7RTUFtetWcpgKRLjVo1HRovuSxOpuOEZrDz
	b6uaczcuV/C4TRTe5ELaqUuq+AQFBgZpVymOlwQeR/ytmyVJq3Mn7ZaYVMNdpqA11IKsoL9/tTf
	9jtug4sWtKWhbM0mV5S1pUy49eSfvurfXk35XxEcCSK+G7gvd9pWutl7Vm5HOdfqQsOPp6yYPjf
	pw9VBl8ijSbD9tI7qvXmfbjtfXy0w6JjfK77m8qIgOVnMoSJy8EfdJ82Mp02B3r9DHcyvR/H7NG
	JvaG/7YPTFkxxhNCh1kJB40nLt5IMrX/5bh4BfX8NKO4VDj0E=
X-Received: by 2002:a05:600c:6308:b0:487:169:9f64 with SMTP id 5b1f17b1804b1-48715fea9afmr90965615e9.12.1774509132376;
        Thu, 26 Mar 2026 00:12:12 -0700 (PDT)
Received: from localhost (109-81-31-149.rct.o2.cz. [109.81.31.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb7f45fsm11137625e9.2.2026.03.26.00.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 00:12:11 -0700 (PDT)
Date: Thu, 26 Mar 2026 08:12:10 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kairui Song <ryncsn@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>,
	Gregory Price <gourry@gourry.net>, Barry Song <21cnbao@gmail.com>,
	David Stevens <stevensd@google.com>,
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
Message-ID: <acTcStxrTCWAN6Dt@tiehlicka>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325210637.3704220-1-shakeel.butt@linux.dev>

On Wed 25-03-26 14:06:37, Shakeel Butt wrote:
> The Problem
> -----------
> 
> Memory reclaim in the kernel is a mess. We ship two completely separate
> eviction algorithms -- traditional LRU and MGLRU -- in the same file.
> mm/vmscan.c is over 8,000 lines. 40% of it is MGLRU-specific code that
> duplicates functionality already present in the traditional path. Every
> bug fix, every optimization, every feature has to be done twice or it
> only works for half the users. This is not sustainable. It has to stop.

While I do agree that having 2 implementations available and to maintain
them is not long term sustainable I would disagree with your above line
of argumentation. We are not aiming to have the two in feature parity
nor they are overlapping in bug space all that much.

> We should unify both algorithms into a single code path. In this path,
> both algorithms are a set of hooks called from that path.

Isn't this the case from a large part? MGRLU tends to have couple of
entry points in the shared code base (node/memcg scanning code).

> Everyone
> maintains, understands, and evolves a single codebase. Optimizations are
> now evaluated against -- and available to -- both algorithms. And the
> next time someone develops a new LRU algorithm, they can do so in a way
> that does not add churn to existing code.

I think we should focus to make a single canonical reclaim
implementation work well. I.e. we deal with most (or ideally all) known
regressions of MGLRU. In the initial presentation of the MGRLU framework
we were told that the implemenation should be extensible to provide more
creative aging algorithms etc.

> The Fix: One Reclaim, Pluggable and Extensible
> -----------------------------------------------
> 
> We need one reclaim system, not two. One code path that everyone
> maintains, everyone tests, and everyone benefits from. But it needs to
> be pluggable as there will always be cases where someone wants some
> customization for their specialized workload or wants to explore some
> new techniques/ideas, and we do not want to get into the current mess
> again.

I would go that way only if/after we are done with MGLRU unification and
after we will have depleted the potential of that approach and hit cases
where we cannot implement new extensions without going $foo_ext way. TBH
I am not convinced "make it pluginable to solve hard problems" is the
best way forward.

-- 
Michal Hocko
SUSE Labs
