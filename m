Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D637F756;
	Thu, 26 Mar 2026 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490750; cv=none; b=C232d/Wl4tTWfkEU5iDxiLpU8JqJwFQKX26OE4nsHtB27SI887gzRThttt02Jur/l+blHasvu28VZP1ITJT0d1YfWbMoz4NihZwATOjgIM3xq06rCnYGv8NSRe3IuSuI4VCMAR1FpRHt1DxNPUk/Jg8DGK2p7bsFy8/R70W+24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490750; c=relaxed/simple;
	bh=mtEUOAMPeIXBSy2/Sy+n9/8l/Xxu4HKjYU1IeLBTV3g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mKjfanO5taor8WjwEmG5Pludbborc45agc74wms9TivX/wM5jwfgJv5C9PIG64vx5A/hHWRcCiYwkY7S2mXmYPBC8Y1EmkuonPiX+5GcOR36KLVW61D1DoouFFNHKIk+NBs8AchHL36FdiDmQjvx2VxgR3wwOxLiObCfikI3E70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=waC01LrU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="waC01LrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C22C4CEF7;
	Thu, 26 Mar 2026 02:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774490749;
	bh=mtEUOAMPeIXBSy2/Sy+n9/8l/Xxu4HKjYU1IeLBTV3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=waC01LrUKtqwDboD0zEDswPZcsahgJD1uLbD/7QjzJzzupbiu24URsshBggUB+xzA
	 Xrq67mNtGKsN/bJW1vRyA05MrAoNr2Xty77pcDVoobqjk5SDSLH1JCH9qudptSfdM/
	 fl+dNzCqfgdEIDKfvIf4iWkOKR7YfkAYa0jTA1/w=
Date: Wed, 25 Mar 2026 19:05:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, Qi
 Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <ljs@kernel.org>, Chen
 Ridong <chenridong@huaweicloud.com>, Emil Tsalapatis
 <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, Kairui Song <ryncsn@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, Gregory Price
 <gourry@gourry.net>, Barry Song <21cnbao@gmail.com>, David Stevens
 <stevensd@google.com>, Vernon Yang <vernon2gm@gmail.com>, David Rientjes
 <rientjes@google.com>, Kalesh Singh <kaleshsingh@google.com>, wangzicheng
 <wangzicheng@honor.com>, "T . J . Mercier" <tjmercier@google.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, Suren Baghdasaryan
 <surenb@google.com>, Meta kernel team <kernel-team@meta.com>,
 bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory
 Reclaim (reclaim_ext)
Message-Id: <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
In-Reply-To: <20260325210637.3704220-1-shakeel.butt@linux.dev>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> We should unify both algorithms into a single code path. 

I'm here to ask the questions which others fear will sound dumb.

Is it indeed the plan to maintain both implementations?  I thought the
long-term ambition was to knock MGLRU into shape and to drop the legacy LRU?

And that Linus has expressed such a desire, but my googling fails me.


