Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD134C140
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508618; cv=none; b=PVAGJa0aXPT0fqBweRMROF7rBjryJ0Eu7vs69bDJGtAS22yHnikQnwKgWub6LR41TDK5j3E7T828rxsd5Es30JO9ieqd2uEcdHl7bGWP3kKlvMn+TtZ2zFc8u0PWhvbZO84FqnGdgnggLeJHlAZrpUxJFvXcxsarROeBVSdLOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508618; c=relaxed/simple;
	bh=xLyCrptEuCeJb2X5dVOKVaUZbQnrzf+C58tUjL+8P1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7IOpb0Lx69JUAsIHV6FdKQQqapACVqZ3G7I59RDPy3p8jpd+951rYX147/JjglLSEovCrY3PbncHlwLHkHvtkxxfVxDrSOdwoXu8i5WF+fapJI1LDsx20JIZkDA46M5vCWuiQ0njvZ4PDG5aNQcnqmy1IzBaK8kUcobV7VgOzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Imbdy8h1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Imbdy8h1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b2965d4bso418893f8f.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774508616; x=1775113416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEkg49JXBlYRGRAlbz2ESpWLIMYJu5dEQ6CVQd0qq8c=;
        b=Imbdy8h1F7Lx1gVikjdYfpWAm3DJqTLEEAePbwi4LDuP+dUVT2Muj1Eiu2z5NtfRCD
         prn03z+HQUv9/xr4LWn0EZ/KN2MIEm6/s9LpFOS8iMQ6bwiB29vaLBiF89hu3pIBKbNS
         Xemb2E988VLH2HOWu5T35r5Pk1M12kloXjzGE0v4cmX5J7sIVM5CpjaaExXe95LSOVO8
         e3WjlgfQcKAZlCbuffHa0OzGRqD3uldm4v4LuO64+XIXv4/4kgK6qgVyjlJzSNA+2n6+
         mCTbgFbDdanRrs6fGdJL+cfTIk3OzL/4E0EZqh8j7rnxJXaIyaCz+ji3N8cTHS7XVWMh
         Kyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774508616; x=1775113416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEkg49JXBlYRGRAlbz2ESpWLIMYJu5dEQ6CVQd0qq8c=;
        b=jaomuyWAhT6mmesW2iqM9x/uOa/pWa50pdelzB3PMwPsCPTqAiS3CIKU2rQLqbYNE5
         2TydhYuyfIgyc7VtZVbw9wPA8XcwW68OjC7ltut4LiyDzGUPKzdwiqrqmtYUmqwjcVJW
         puK/uPAqqL0/6fgjA70NhAdrNk+RQL+OnGdpV+/p77cULr1KATPoxXAJuqX8NHyVeG4N
         yX3GeDOR47RbvQLPgVgEQLXrsOqKLwl3D84dcgEhI6YKfyrSfJjMwKP68sXaxB+LiVJU
         E+C5/JI9vCvuNbY1oilfh4J5/uiOqjFBaL4yYfRuNFYyeXsJ6HfhNVUYUv/K+TAsiONZ
         kAWw==
X-Forwarded-Encrypted: i=1; AJvYcCWAclQDj3rGcyBHM5mwAUcP94y1i8O1+JdycaVeWZ/WklFQc9ZyJXsxMMAAArTsC/cISLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMMen280JnPtv+q93Enqy9iMguOxfiKIscZ97dry+UNNYeStq
	wr7jblj9EO5gceFjN+cApC14uMHkVfsMiYl5V62xle6IEpoK2BpdnJ2ij8UZdN40S3w=
X-Gm-Gg: ATEYQzw1nYZf+inaPCLbe/ho2id9qu1qLfpxWE7EVvNkmMIq3vb0ANNSUXO1GNn8jpo
	it8plce7zCToU5/EZuNHvjJyvRv0ceT97Ehis1BM6vWx1ZSSFR+47AOcnB5Oj3cF+H4czg9cG5t
	VM/UkwpYgFtMXfwwPLH8AKAtvALQ5ZXArWU4Mi1DYGrTPRdpp3M3i77UvoD51algjXh7WMTtKw/
	38QJ2ftI/SJ7cqztIb9NqGhsYy9n3oiwm42NBi0rqkygzMiZEWReCD5BhH8VdKM8ScLrJnJhlDt
	WKrTlVddWlsZx6qtKz4FZk5D58puKZRNKm4+tV5mXkUKDzypDb2GBbbeXBHBlu83yMjqb1l10De
	KKCGRIqHqrGi5xUjAmb4wQWrlqfXgIS9G0ZXOPq/3uLq2RS/a7fcOpkfOnkDFSeK3D+m3ksbLcU
	SrqbYuOj4nd6rAjSqAreb/hnpD/TqIvz5RkoZh
X-Received: by 2002:a05:6000:400b:b0:43b:4ef0:e13 with SMTP id ffacd0b85a97d-43b889a49eemr9597969f8f.12.1774508615797;
        Thu, 26 Mar 2026 00:03:35 -0700 (PDT)
Received: from localhost (109-81-31-149.rct.o2.cz. [109.81.31.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df903sm6070863f8f.30.2026.03.26.00.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 00:03:35 -0700 (PDT)
Date: Thu, 26 Mar 2026 08:03:34 +0100
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	lsf-pc@lists.linux-foundation.org,
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
Message-ID: <acTaRgusrxfCoKqe@tiehlicka>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>

On Wed 25-03-26 19:05:47, Andrew Morton wrote:
> On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > We should unify both algorithms into a single code path. 
> 
> I'm here to ask the questions which others fear will sound dumb.

Not dumb at all and recently discussed here https://lore.kernel.org/all/CAMgjq7AkYOtUL2HuZjBu5dJw=RTL7W2L1+zVv=SCOyHKYwc3AA@mail.gmail.com/T/#u

> Is it indeed the plan to maintain both implementations?  I thought the
> long-term ambition was to knock MGLRU into shape and to drop the legacy LRU?

Yes, but MGLRU is not there yet and with development pace last year or
so we are not much closer than at the time MGLRU has been merged
unfortunatelly.
-- 
Michal Hocko
SUSE Labs
