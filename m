Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14FC3F210E;
	Fri,  8 May 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253562; cv=none; b=Qq0xz0LbGWpPloaQZ3sKEONAbeSSIJRZDpjVuwGnIJ/B9Gl0OS/LIsIZ4Po8ITcf6ZNIAwk++T6nDRJi9mHMLGPUMuN+L9j4iUOPMvxl5K2aZwWeE7Lmccw2oOOLgpl8bmTO1l1xZcU0wqmYvIz2772H1+BhlUTorq9KRtXWDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253562; c=relaxed/simple;
	bh=ayrSpaUd3jG15AzEI0ud7gi0YPalJbLy8LxSW3JuGQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Krnx8uV+OiMDu7AV+ydhBjvBK9cbt0BieKdswFT8BDYeu88LK54/tJD3igvpdvhLrHNFfxWrBTO4+qbtcPOMeUmG1N2/VwzfkYFYssX0iXR06nWNy4onCDTBCYEXTIovBLmrTJBLhrWXFDZ17PULzRsvLbjtch+jwsWyV1OILnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3eWI000; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3eWI000"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFF4C2BCB0;
	Fri,  8 May 2026 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778253560;
	bh=ayrSpaUd3jG15AzEI0ud7gi0YPalJbLy8LxSW3JuGQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3eWI000z94PR68LyY4hiZnPifWrTnGZg74C5npodbzso+uPu8+KdyUYefGOHSkZq
	 hIY2VEi1WHHo5VHKMXIqDc82lONbUitDa3WWQ7LUGVGETrYthgUub2OzmdB3/VSKXe
	 a4pKlXM0TQ+ZS+NNDpcwrlFgPUf3IQP35rpGLgVSIG1YCmBlQytyCvdhqN/SpxYyhM
	 K6WQrtxqDIKHFMHUFPQ7y1k7ygtmP+3Oul4Q3j1XGATw6mG+i+c2mLm9zW3Rttpe4I
	 a9ofKGu0D3D0C6Np5WpwrhM2B0A0hAPxWlaEBryjE6UF7P88EHdRhtBVmrv1edDG1R
	 fFuJPcKJkJyfA==
Date: Fri, 8 May 2026 16:19:11 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, roman.gushchin@linux.dev, 
	inwardvessel@gmail.com, shakeel.butt@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	surenb@google.com, tz2294@columbia.edu, baohua@kernel.org, lance.yang@linux.dev, 
	dev.jain@arm.com, laoar.shao@gmail.com, gutierrez.asier@huawei-partners.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v2 1/4] psi: add psi_group_flush_stats() function
Message-ID: <af3-BqtzYTpnog-s@lucifer>
References: <20260508150055.680136-1-vernon2gm@gmail.com>
 <20260508150055.680136-2-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508150055.680136-2-vernon2gm@gmail.com>

On Fri, May 08, 2026 at 11:00:52PM +0800, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
>
> Add psi_group_flush_stats() function to prepare for the subsequent
> mthp_ext ebpf program.

This isn't a great commit message, you're just saying you're adding a function
then what you plan to use it for, not anything about the why of adding it.

>
> no function changes.
>
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> ---
>  include/linux/psi.h |  1 +
>  kernel/sched/psi.c  | 34 ++++++++++++++++++++++++++--------
>  2 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/psi.h b/include/linux/psi.h
> index e0745873e3f2..7b4fd8190810 100644
> --- a/include/linux/psi.h
> +++ b/include/linux/psi.h
> @@ -22,6 +22,7 @@ void psi_init(void);
>  void psi_memstall_enter(unsigned long *flags);
>  void psi_memstall_leave(unsigned long *flags);
>
> +void psi_group_flush_stats(struct psi_group *group);

Feels a bit iffy, exporting an internal management function?

>  int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
>  struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
>  				       enum psi_res res, struct file *file,
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index d9c9d9480a45..76ffad90b0b5 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1242,11 +1242,35 @@ void psi_cgroup_restart(struct psi_group *group)
>  }
>  #endif /* CONFIG_CGROUPS */
>
> +/*
> + * __psi_group_flush_stats - flush the total stall time of a psi group
> + * @group: psi group to flush
> + */
> +static void __psi_group_flush_stats(struct psi_group *group)
> +{
> +	u64 now;
> +
> +	/* Update averages before reporting them */
> +	mutex_lock(&group->avgs_lock);
> +	now = sched_clock();
> +	collect_percpu_times(group, PSI_AVGS, NULL);
> +	if (now >= group->avg_next_update)
> +		group->avg_next_update = update_averages(group, now);
> +	mutex_unlock(&group->avgs_lock);

If we do need to factor this out, maybe worth making the mutex lock/unlock a
guard(mutex)(&group->avgs_lock) instead?

> +}
> +
> +void psi_group_flush_stats(struct psi_group *group)
> +{
> +	if (static_branch_likely(&psi_disabled))
> +		return;

Is it actually likely if you're calling this function?

And the caller doesn't care even if PSI is disabled?

> +
> +	__psi_group_flush_stats(group);
> +}
> +
>  int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
>  {
>  	bool only_full = false;
>  	int full;
> -	u64 now;
>
>  	if (static_branch_likely(&psi_disabled))
>  		return -EOPNOTSUPP;
> @@ -1256,13 +1280,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
>  		return -EOPNOTSUPP;
>  #endif
>
> -	/* Update averages before reporting them */
> -	mutex_lock(&group->avgs_lock);
> -	now = sched_clock();
> -	collect_percpu_times(group, PSI_AVGS, NULL);
> -	if (now >= group->avg_next_update)
> -		group->avg_next_update = update_averages(group, now);
> -	mutex_unlock(&group->avgs_lock);
> +	__psi_group_flush_stats(group);
>
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>  	only_full = res == PSI_IRQ;
> --
> 2.53.0
>
