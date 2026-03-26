Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CDC3ECBDA;
	Thu, 26 Mar 2026 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540933; cv=none; b=LBvh2yW34FA2nW64UWQ5bLwA7D0FTNQ22wf3+BnbpjIh51N1jRPG+WG1jZ0AJPdUUP4q7z0F/u7lS/0UOuvNveJq1ImdRAAKk7DKGokJ1ZT/M18jVrgn8uZIFkM5wnD8mA/JxgEFUYDyOHkcmaWcBrxrezdbwjY3vbl4O4hxrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540933; c=relaxed/simple;
	bh=pcAbrX6ODf5LOs8xw/Oiha79DxbZoZEzxKqFT7yoPLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noBsaN9nuWgB6UsS+ePSOhcwSQ1dtp211ixY5KgsGyqC0ak6uA/yQmVb6NCWHfGkXtQ09C7N8QkmnfTveprjFCqAOGwPmVLJ7qcl+TnS7oHPmU441ucHxQpmoF4OeqoniLQ3fRKDQkuC2agiUyq6gWechWyP8qNj5z7jxJ4owi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ1sFFnM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ1sFFnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726C1C116C6;
	Thu, 26 Mar 2026 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774540932;
	bh=pcAbrX6ODf5LOs8xw/Oiha79DxbZoZEzxKqFT7yoPLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZ1sFFnMrIcG1KY87J3HWMSgnEVbgJj9T0BRYhN6Pvv2jsqhhpqyM4PZ76QJRWxTr
	 FGtkM2KAuoNaa2BWv3UuEqqi6X4BOlIduTFT9qtPkieg8bJslfcz30+HKrIevkOojX
	 k8D+dZ73hpWP8GKlSE1zJatC1KcL0KS+EMVqRCTXESQ3j4m9j/hab4p5A9dzGAQAzX
	 cpdWlzdtQeRO9OVaX29evsZ7vRB6ypGLuqv9pEXJC5Otb9m7kSwphAxpXPqFwaaRHM
	 6BFw3Ml2ZY1kUUamiOQXWaP+RWwXp8qVGe8KXNScRboWM8mMio8QV8Co0q9GIH/oPb
	 rWmInPRY03lBg==
Date: Thu, 26 Mar 2026 16:02:04 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	lsf-pc@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
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
Message-ID: <17b13155-b795-4e00-b9b8-9ab324c72aed@lucifer.local>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAMgjq7B_twv3xhd5VmMJxngAknf9YaLAiwGYpdi6H2n1cXD3-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMgjq7B_twv3xhd5VmMJxngAknf9YaLAiwGYpdi6H2n1cXD3-A@mail.gmail.com>

On Thu, Mar 26, 2026 at 08:37:06PM +0800, Kairui Song wrote:
> For many other typical workloads under stress, MGLRU performs
> significantly better too (e.g. database, build kernel could be more
> than twice as fast), it would be a huge loss to leave it unmaintained.

BTW press X to doubt on it doubling kernel build times :)

Cheers, Lorenzo
