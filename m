Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A640FDB9;
	Thu, 26 Mar 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543217; cv=none; b=iIqAAnJJG++tzhBFe3047ca3VjdFwMomp7IKx5eUmZAiI1suA5bgjaqUOB3KjKiZ/bk7dOi1BzXAEraSH/TH0nrOs+UgCW9VA/DPEfqFW+7ZNNQoMtFDBtiIz3okiqlMXxIUilDBki87veUqWDIIIar7Fz+oDdleED0XfuNvdqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543217; c=relaxed/simple;
	bh=cYKlQ2o7FUUvHGc0tCvyTQqKxg3laNIlHyL2Hy6ob5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtJJXCgUo91hL9k760+aFWmtGPEVKXj9IiQyvve/YQNAN2asgPSNIUsobL2zt2DHwjbbWORavKVzW/c2qUn71VXi2Xoz+vmxGdD7orSrODcU200bkEsr8NXVl3E6qMGKMiaT/HYKSVSUt5Ac8hwV8Kpqn5TNtijCC34v3+axVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWe1AHWS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWe1AHWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AD7C116C6;
	Thu, 26 Mar 2026 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774543216;
	bh=cYKlQ2o7FUUvHGc0tCvyTQqKxg3laNIlHyL2Hy6ob5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWe1AHWSW+pwYbwC0VcqRbQdmlNq3VaXx1KYEsfhH6r9/QV24i8AergiggbHgGuSd
	 6M7dkjQuO2qD9gVUhDAGWRe9lp8U0vCNUayFKnEQyBfXPzG4Loaja8HMp1jITQUsm9
	 63Yd7NeYjqqMIsQDdGOuQZcm9y9pISfsqqBaxSAakjs9xH/DfI4yNRDdxBarKGtMdk
	 tMdWKCw3ZLD9A+iP+pcvn/2WHOU5PQA22Rf0crNlcDPxmHmhvelPwTDogBXIOzdy3+
	 UMlYBIu06ovaY6xJbp9X2grLD5o+bMcxiyzRq41Kn7ETRZzoDKgGtQM3bTOByydlDe
	 2QwAF7oR3ZosQ==
Date: Thu, 26 Mar 2026 16:40:08 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	lsf-pc@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
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
Message-ID: <7b7fec8f-78ac-4b6b-95ea-8509d8ca95b5@lucifer.local>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
 <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
 <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>
 <acVftLYT301ITlsO@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acVftLYT301ITlsO@gourry-fedora-PF4VCD3F>

On Thu, Mar 26, 2026 at 11:32:52AM -0500, Gregory Price wrote:
> On Thu, Mar 26, 2026 at 03:35:28PM +0000, Lorenzo Stoakes (Oracle) wrote:
> >
> > Maybe a stage 1 can be to separate stuff into another file, because that'd
> > actually be pretty easy to do for a fair bit of it, surely?
> >
> > Can use mm/internal.h to handle stuff that has to link one with other?
> >
>
> Yeah i don't think we absolutely need to jump all the way to ops right
> away, and splitting into a new file would at least give our eyes a rest
> from the ifdef spaghetti.

Yeah as I said in my reply here, I'm if(def?)fy about the ops tbh.

But we can defer thinking about that until last anyway.

>
> ~Gregory

Cheers, Lorenzo
