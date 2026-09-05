Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04C367F41
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625737; cv=none; b=NvGTJhpJUAetegf9+epdtnwC0bV9FNOpaDYgzFy7x0OWOal1KQsv9gGrQOUVmhAA5RH/Q3+hBUfff9kyFuXCT51g7jzjlAjHFP0DIlVi/yt77Y/AGiESK23pAAKOA6jPI4wxiVqEMCwk8ERS1wS86/hoZhhu/lEs4jFlViXVwfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625737; c=relaxed/simple;
	bh=Sd+WtO5DRtPYTABH6V2gV0Ob5SWHGcjMM8zwwK0oVWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+FiKNVN9ffDHJm/5yyVYbTXlPs3nw0p1Z860MZA8IgvjkquF40vDYz77HEmGD/uw3nkGsiDhJuXZKkItULwpVdYN/7cjLWL+Hg4F3Tx+GFXVa0grQEAA8lETxzYYWFzfiHNNidr+RKSHMTTClc1yL+FB2FyjPo9V7qBFhSeFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ltwn0ZqS; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ltwn0ZqS"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Sd+WtO5DRtPYTABH6V2gV0Ob5SWHGcjMM8zwwK0oVWY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788625732; v=1; x=1789230532;
 b=ltwn0ZqSyKoRR5xXKfHHetKn+HuOUpB7/GQ6bJ3jn+ULrBDg6H+3/YhSmIbHOrqLbjRFl+VP
 peAAGzb4T8nPgLVAB1+XQeppyQY7qad8dDQnYNrKdxkrczP9EGVY1W4zQvnsSC/8QnK6UyYIkQH
 szlq2TYnpR0647s+ar+46HXU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6a082eb6d975864f;
	Sat, 05 Sep 2026 16:28:52 +0000
X-Mizu-Trace-ID: 6a082eb6d975864f
X-Migadu-Flow: FLOW_OUT
Date: Sat, 5 Sep 2026 09:28:46 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hui Zhu <hui.zhu@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v7 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
Message-ID: <apxB5tyglnSbqmEu@linux.dev>
References: <cover.1788516769.git.zhuhui@kylinos.cn>
 <7d8b77dc99ffe99a7bef874a257472fdaaf07e1c.1788516769.git.zhuhui@kylinos.cn>
 <20260904110308.4473cde499e91aab14dbd5fc@linux-foundation.org>
 <DL7CEX9EX781.23V26M3600JEI@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL7CEX9EX781.23V26M3600JEI@gmail.com>

On Sat, Sep 05, 2026 at 01:23:39PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri Sep 4, 2026 at 8:03 PM CEST, Andrew Morton wrote:
> > On Fri,  4 Sep 2026 18:20:19 +0800 "Hui Zhu" <hui.zhu@linux.dev> wrote:
> >
> >> @@ -159,6 +160,74 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> >>  	mem_cgroup_flush_stats(memcg);
> >>  }
> >>
> >> +/*
> >> + * Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
> >> + * current->reclaim_state, so a nested call would corrupt the outer
> >> + * reclaim state. Reclaim windows are marked with PF_MEMALLOC;
> >> + * reclaim_state is also checked because it is installed slightly
> >> + * before PF_MEMALLOC.
> >> + */
> >> +static bool bpf_in_reclaim_context(void)
> >> +{
> >> +	return (current->flags & PF_MEMALLOC) || current->reclaim_state;
> >> +}
> >> +
> >
> > Would life improve if try_to_free_mem_cgroup_pages() didn't do that?
> > If try_to_free_mem_cgroup_pages() (or some variant of it) were to
> > permit nesting?
> >
> > 	rs = new_thing(current, &sc.reclaim_state);
> > 	...
> > 	set_task_reclaim_state(current, rs);
> >
> 
> My understanding is that given the current restrictions on where this kfunc can
> be called, this is mostly a defensive and shouldn't be firing (?). Given that,
> we can probably revisit this when such reentrancy is necessary, even though I
> doubt it would be the case in the future. It will at most be invoked from a wq
> callback or a kthread, so should be fine.
> 

If with the current restrictions, this recursion can not happen then let's not
add this check here. We never want recursion/reentrancy here.
