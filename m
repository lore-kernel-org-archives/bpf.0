Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6B1EEA5F
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194238; cv=none; b=AAmZBGwy30yHsqj3hryc/uEwvzn6qQue3JhtprOD73V/bDoWeUQK2V6IZ09FLV/56JSz3TzYKGfOCp10XHAj5QWvyGQulZ9fcd9qn4Cbl9UHEJNiDYMFqbW4b3ZXzH0N1oaMIMhqE1utxRhURK+yN0NKSonsp4bG7wR8DSuEOMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194238; c=relaxed/simple;
	bh=2MozqaAuZsfOHOdZKXPvMULPKCVFJoCz7YrdBNYFszM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6syIAIwFQhh2DsBru3ZBKVETUIRdXMv5vq82t/sQRQ2rGMRbN6FRt4WP3O0Z0axwgdwdfEbirU0Gdl3lDSIGJWORTBxBqIieV6Ns4f7BeFO+30yB/5w5FNXstSzrLqw96VsLXQgX+rNG2WeEPfrUBewWkbDYLXa2Vfj+h2buVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSBIrUsv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSBIrUsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815A9C4CEF1;
	Fri, 23 Jan 2026 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194237;
	bh=2MozqaAuZsfOHOdZKXPvMULPKCVFJoCz7YrdBNYFszM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSBIrUsvblWpjQeJo+aebDA2Ie1oXxflOzW0l4tjRwNP48fKUQGVEaa3sH2J24eco
	 71lwkP4SIcOIHCi53uHYeihQ7lilxfISFLkDrYzkLRihXMfuaQZx1mHqCp6ZGr1DNN
	 huID5my76latTYb92h9rFA3W5KFlrh60vJWn/ofeiDWYpe3ecsF2taowYoylcbvjkK
	 oLdyy5s3EQ3m/czb4fmUHTsH61KXlUDreFab0qt2zCQEldzJGqraFil8jwF4KcO45A
	 LMk8ePzcxlVkHLthOj2B4JuOCzpqOLPlVZRx+c1rBi8TkLYhd93xTmUTVFwWTnjLO0
	 xjS2oSY7yPAwg==
Date: Fri, 23 Jan 2026 08:50:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
Message-ID: <aXPC_KMX_rvO14lR@slm.duckdns.org>
References: <20260121135444.187001-1-mattbobrowski@google.com>
 <CAADnVQ+8f1mK1+L9S6uDbo0n53zs9VeUhZr5eTg0+jXppRAhcg@mail.gmail.com>
 <aXNWLU7ay1HHmg6S@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXNWLU7ay1HHmg6S@google.com>

Hello,

On Fri, Jan 23, 2026 at 11:06:21AM +0000, Matt Bobrowski wrote:
> Would your stance change if Tejun agreed to mark css_next_child() as
> exportable, or simply agreed to it being used from BPF cgroup
> iterators?

FWIW, I don't think there's any issue to exposing css_next_child(). This is
a part of the fundamental structure of cgroups and I don't see it changing
in any foreseeable future. That said, I wonder whether it'd be more flexible
to expose css_rightmost_descendant() which allows skipping the current
subtree during pre-order traversals. However, this has higher complexity for
traversing just immediate children as it would have to skip each child
subtree.

Thanks.

-- 
tejun
