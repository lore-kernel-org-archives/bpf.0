Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51216566C53;
	Tue, 29 Sep 2026 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709905; cv=none; b=cktKvgoGe3lpAmtdlQZkPBjwGf502D1LDBPZGAPHSYl2I11hZAe5kJmSl56rMlFKlPRsM7+DlBhIjK1eWikhBACmNtuY9Aa2VkxGRv92ldo8+CuoqztxEW1i8vrsIxQcw28nXax359Zl4YwvhS2jRWuUswvXXLewwvSORvPrYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709905; c=relaxed/simple;
	bh=YpVkw7xPpOTZe7PrRB9vYQcuDFdlpzpqyM0i2DHRCH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5WFBteJg6GbD+HObkJHyug2/8rIuKuUGk/ZIG7kGgh2i46oGWbLluIjBhVixZHoDoyDPf0VVLZSlb7HPDmYA1YOVWCJqE011DZjxlC1jPbG6f7fYKzOPTn98OxZr+Pb8Uh5FuE3xo7xe1bYFWwgRjomRqj4tlfNHdGh5c5tQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YID+rB8x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YID+rB8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AC01F000FF;
	Tue, 29 Sep 2026 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790709903;
	bh=/L11jNXsHZIT6aH1fo02FiVZj0vopibIiBuH4+iamIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YID+rB8xmlOy/NbjJLtfDaab4iB49iMG6q3NmALjCh35sT6haS5rSGhZoHzw9qRIG
	 oK6wtuz/4ZOvoNgtm2pKJMH7Ghbm77YiBx0LKrh/tIgiuCrQZAslyO4GqHriOYod//
	 3rsXieQfOEW7zehaffPAC3LUUX9Pa1i/XtWPILunJAERfw3Fxx1/cnP8+MJscLwT0G
	 q+bdMtyP2ubFrtYSe+h+jtTpqjXPQLVjBgXVCxuvDvjbGj6f/tYddrjO26WfA9ULMd
	 VAdqnrWt1bKrFcf+8Ei9Jpkpl+U3yK5RWpzUmovcnosWfr1HxpXlv+YPO3XiKCDhJ0
	 vWtSInjgqknww==
Date: Tue, 29 Sep 2026 09:25:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Work around pahole 1.32
 dropping scx_bpf_task_set_lazy_resched() from BTF
Message-ID: <arwQjsHCGl5lF7LR@slm.duckdns.org>
References: <7c139810be5ffc9764ed4236efc28794@kernel.org>
 <arwPVufx2ZUOc_sp@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arwPVufx2ZUOc_sp@gpd4>

On Tue, Sep 29, 2026 at 09:19:50PM +0200, Andrea Righi wrote:
> First of all thanks for figuring this out, it was really annoying, I've been
> holding pahole to 1.31 because of this.
> 
> I also looked a bit and it seems to be triggered specifically by the bool type.
> This is with clang 22.1.8 on x86_64 without barrier_data and only changing the
> type:
> 
>   bool  movl %esi, %ebp    -> dropped by pahole
>   u32   movl %esi, %ebp    -> ok
>   u64   movq %rsi, %r15    -> ok
> 
> With u32 the generated code is identical to the bool case, but clang keeps the
> RSI entry range, so pahole is happy.
> 
> Should we just change lazy to u32 (or use a u64 flags) instead of using
> barrier_data()?

I mean, bool is the right and I'm hoping clang can be fixed and the
workaround seems to work, so keep it as-is unless there are other reasons to
change it (e.g. this becomes a wider interface taking u64 flags or sth like
that)?

Thanks.

-- 
tejun
