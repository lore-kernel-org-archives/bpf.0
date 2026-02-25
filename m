Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D931327F
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045701; cv=none; b=IEeu6iD6UA9PqSZV29O41yJsUJrjRfBahyehOwRf9/ffjcAwDwAzWr8E0korAvt4T7xqE3KMSJbaWeBKfiwHwWEqReZyMN1CrffTa0giH9dD51Nha2JCqVwrDo2WRbbVaNqfZR2lKKcoDk/T23Pmt9Jhb4pXQPMKtuM2zuRYIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045701; c=relaxed/simple;
	bh=kbXoqr2dSvgOS97uIoHCsMeiargMQmFZmEbNLUxRv0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP9QsBl+I/8rpj3fSLcVClwstL5q9QBQ3m8cUYDscIxY9MUMRMtVwXhr9h6O919Q/JZ9UHwrDUFw9IkvNM6F8zpvLy3c50I0lwRBiIYGwRPq//FEwM67gl52KowCjxTXG6D9RXdfw9uDgg8oz1zIOkJBHx+qLimNxP3oDHEJxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrO638+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrO638+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D081C116D0;
	Wed, 25 Feb 2026 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772045701;
	bh=kbXoqr2dSvgOS97uIoHCsMeiargMQmFZmEbNLUxRv0s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CrO638+otdOm+PBWQgiwXLTdVI/7iHWnGTYbp46m+teftBM3AZ1WeH08p9P0nSnhZ
	 Weo4DM7HTlOA69ZbG2/up3gXzFw47Z0iiAodye2tQIMU81H+Rg6ePl0FS7v4K2CvaG
	 AOut6QofA8iGBGMoHQO7SPqcM+YLRTStkfVHOsFu4vqlpFq0ovzkMQXQJtgUx8szZz
	 msRCQgsnj9e3ATALP5myhE0VaZmJ2u5bVTQZh+XuOaATHkZbkrR1uIkhso9WL89LN1
	 GXV55lygVoYAn9Co2R7cVDetATzchyzI1lyw8qEHf90oObiTTDqKJyAXwS9YzINtt5
	 XY9ktM2YDlnbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 17077CE0A7F; Wed, 25 Feb 2026 10:55:01 -0800 (PST)
Date: Wed, 25 Feb 2026 10:55:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>, kkd@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 3/4] bpf: Retire rcu_trace_implies_rcu_gp()
 from local storage
Message-ID: <723ef969-40fa-411d-9e40-32514131de46@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260225185121.2057388-1-memxor@gmail.com>
 <20260225185121.2057388-4-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225185121.2057388-4-memxor@gmail.com>

On Wed, Feb 25, 2026 at 10:51:20AM -0800, Kumar Kartikeya Dwivedi wrote:
> This assumption will always hold going forward, hence just remove the
> various checks and assume it is true with a comment for the uninformed
> reader.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Just be *very* careful with backports.  ;-)

							Thanx, Paul

> ---
>  kernel/bpf/bpf_local_storage.c | 37 +++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 0825a92dcd6d..84fe6364c75d 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -107,14 +107,12 @@ static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
>  {
>  	struct bpf_local_storage *local_storage;
>  
> -	/* If RCU Tasks Trace grace period implies RCU grace period, do
> -	 * kfree(), else do kfree_rcu().
> +	/*
> +	 * RCU Tasks Trace grace period implies RCU grace period, do
> +	 * kfree() directly.
>  	 */
>  	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
> -	if (rcu_trace_implies_rcu_gp())
> -		kfree(local_storage);
> -	else
> -		kfree_rcu(local_storage, rcu);
> +	kfree(local_storage);
>  }
>  
>  /* Handle use_kmalloc_nolock == false */
> @@ -138,10 +136,11 @@ static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
>  
>  static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
>  {
> -	if (rcu_trace_implies_rcu_gp())
> -		bpf_local_storage_free_rcu(rcu);
> -	else
> -		call_rcu(rcu, bpf_local_storage_free_rcu);
> +	/*
> +	 * RCU Tasks Trace grace period implies RCU grace period, do
> +	 * kfree() directly.
> +	 */
> +	bpf_local_storage_free_rcu(rcu);
>  }
>  
>  static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
> @@ -179,10 +178,11 @@ static void __bpf_selem_free_rcu(struct rcu_head *rcu)
>  /* rcu tasks trace callback for use_kmalloc_nolock == false */
>  static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
>  {
> -	if (rcu_trace_implies_rcu_gp())
> -		__bpf_selem_free_rcu(rcu);
> -	else
> -		call_rcu(rcu, __bpf_selem_free_rcu);
> +	/*
> +	 * RCU Tasks Trace grace period implies RCU grace period, do
> +	 * kfree() directly.
> +	 */
> +	__bpf_selem_free_rcu(rcu);
>  }
>  
>  /* Handle use_kmalloc_nolock == false */
> @@ -214,10 +214,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
>  
>  static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
>  {
> -	if (rcu_trace_implies_rcu_gp())
> -		bpf_selem_free_rcu(rcu);
> -	else
> -		call_rcu(rcu, bpf_selem_free_rcu);
> +	/*
> +	 * RCU Tasks Trace grace period implies RCU grace period, do
> +	 * kfree() directly.
> +	 */
> +	bpf_selem_free_rcu(rcu);
>  }
>  
>  void bpf_selem_free(struct bpf_local_storage_elem *selem,
> -- 
> 2.47.3
> 
