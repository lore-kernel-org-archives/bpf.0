Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770F2DCF52;
	Mon, 20 Jul 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561119; cv=none; b=KxOnPn5vuj2QOHspgMsz7p2qaC3vIGmUZto++o6MwS0yMGRi82tF3oZ5Ij0E1zMr9BRZ3uIQH8ncXtGrbRZnZXABpTQBTSAuLarMQLb0Lve4usBB66lhrmI9KCythQ3l3/7j5lzrBiBPES3I01mM7fMBnQsvLMeCuQnDCS4jFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561119; c=relaxed/simple;
	bh=hLnPVQNRGGR2PWWenBGyFj/Z3wNhcKxmrWbRi36XQiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNpp5WejHBGjeOAW8DoG/o4dDMgDfjqN9PIGlLqwnkRtQjcVfGW8wceEVcg+nUvskaVK8E7so3Y31Dbw504pFvb6ev6aKB/3kOZ1pz5d68+4ZT09wO3UmcAaZdWjbcELifQp7VXiJ4FH3edNt2g5/vRkGkYu1jGbwNpMDgFjmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJaX/lI9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJaX/lI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941361F000E9;
	Mon, 20 Jul 2026 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561117;
	bh=H6yVyiE63yXcD/fvLI3hqIkx+vFonOcuLVo15lmuJ6Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=XJaX/lI9ygdRmKcimsELCE6cxoMXHvXYspGuz9eSToSm0RMONx0IL4cHzeJh9nReI
	 ou/0IyMyJj2UEVeaoAQXQJrI8W0iasCg9pU0JCJjcKbadwrXz2VReMwu4L/l1T6rJR
	 ROxC93As7r0qhfIhwhKhvI2K5u2L6ZTk/2A7INZnibdbDVfAsC7mjuPwSx17jXTQFJ
	 eHPVUVB5PxE0YAvAoNRMZii8Z2+RDZyIBdcfW0UNcziqe1MGr2ZM1PtLMg+1XvMNX5
	 XtBf1t8rIdk6qvKbyPClHESk5vKn9jDy5FlDT/wPKMfTpMUHDnhFk0p6kXTYQ8cqdz
	 MQTsCZxp5xJNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 66ED3CE0C57; Mon, 20 Jul 2026 08:25:17 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:25:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, puranjay@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <8114f54f-b05b-489d-a3f1-7aa02d93cda0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>

On Mon, Jul 20, 2026 at 06:23:45AM -0700, Breno Leitao wrote:
> kmemleak_scan() can run for ages on large debug kernels. It was
> causing some soft-lockups which I got fixed with commit
> 3175fcfec8b16baeb ("mm/kmemleak: avoid soft lockup when scanning task
> stacks") with our beloved cond_resched().
> 
> I've got the fix above deployed in the Meta fleet, and now I am seeing:
> 
>   INFO: rcu_tasks detected stalls on tasks:
>     task:kmemleak state:R ... nvcsw: 274/274 holdout: 1 idle_cpu: -1/3
>      scan_block
>      scan_gray_list
>      kmemleak_scan
> 
> and, worse, blocks the callers waiting on that grace period. Here a BPF
> struct_ops map free, which waits via synchronize_rcu_mult(call_rcu,
> call_rcu_tasks), is stuck long enough to also trip the hung task check:
> 
>   INFO: task kworker/...:bpf_map_free_deferred blocked for 122 seconds
>      __wait_rcu_gp
>      bpf_struct_ops_map_free
> 
> Then I've learned that cond_resched() is not an RCU-tasks quiescent
> state, so, we need to use stronger primitives.
> 
> Use cond_resched_tasks_rcu_qs() at the scan reschedule points so the scan
> reports an RCU-tasks quiescent state as it proceeds.
> 
> Inspired by commit b96285e10aad ("tracing: Have osnoise_main() add a
> quiescent state for task rcu").
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  mm/kmemleak.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 85f18b17e79c4..f63dfacee7ca1 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1586,7 +1586,7 @@ static int scan_large_block(void *start, void *end)
>  		if (scan_block(start, next, NULL))
>  			return 1;
>  		start = next;
> -		cond_resched();
> +		cond_resched_tasks_rcu_qs();
>  	}
>  
>  	return 0;
> @@ -1623,7 +1623,7 @@ static void scan_object(struct kmemleak_object *object)
>  			scan_block(start, end, object);
>  
>  			raw_spin_unlock_irqrestore(&object->lock, flags);
> -			cond_resched();
> +			cond_resched_tasks_rcu_qs();
>  			raw_spin_lock_irqsave(&object->lock, flags);
>  			if (!(object->flags & OBJECT_ALLOCATED))
>  				break;
> @@ -1645,7 +1645,7 @@ static void scan_object(struct kmemleak_object *object)
>  				break;
>  
>  			raw_spin_unlock_irqrestore(&object->lock, flags);
> -			cond_resched();
> +			cond_resched_tasks_rcu_qs();
>  			raw_spin_lock_irqsave(&object->lock, flags);
>  		} while (object->flags & OBJECT_ALLOCATED);
>  	} else {
> @@ -1673,7 +1673,7 @@ static void scan_gray_list(void)
>  	 */
>  	object = list_entry(gray_list.next, typeof(*object), gray_list);
>  	while (&object->gray_list != &gray_list) {
> -		cond_resched();
> +		cond_resched_tasks_rcu_qs();
>  
>  		/* may add new objects to the list */
>  		if (!scan_should_stop())
> @@ -1708,7 +1708,7 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
>  	raw_spin_unlock_irq(&kmemleak_lock);
>  
>  	rcu_read_unlock();
> -	cond_resched();
> +	cond_resched_tasks_rcu_qs();
>  	rcu_read_lock();
>  
>  	raw_spin_lock_irq(&kmemleak_lock);
> @@ -1753,7 +1753,7 @@ static void kmemleak_scan_task_stacks(void)
>  			}
>  			put_task_struct(p);
>  		}
> -		cond_resched();
> +		cond_resched_tasks_rcu_qs();
>  	} while (pid && !stop);
>  }
>  
> @@ -1935,7 +1935,7 @@ static int __kmemleak_scan(bool full)
>  			struct page *page = pfn_to_online_page(pfn);
>  
>  			if (!(pfn & 63))
> -				cond_resched();
> +				cond_resched_tasks_rcu_qs();
>  
>  			if (!page)
>  				continue;
> 
> ---
> base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
> change-id: 20260720-kmemleak_rcu_task-6d3ea111b947
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
