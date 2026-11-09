Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212826;
	b=LM36u1jDuibyD6IPOL7r+X9+qG/JVBYiIL4gI1QZ5ezdGtLST3i34/d6Li+Ezf8D0nNl
	 4MrhHtBtpUQXI3k6rCh561pxqTsoBqsbn+fBSciiq8/2pm1H3qUB1oqori1Enf13NPRmP
	 bDTfT3TVUYthafrfXhIN8mvAdFGzjkMMFpPB4AW2BybDztI3S2Pyaj/EbpPfMPstq9mvu
	 xROuX2z5EQ4EMnYjE44KWSAW/72frCMAyFkFnALDCVS0Q1dAq+5mLhdhPTZhgVn0ZXVWJ
	 e11EZl8Y0jdPwkJ/XlTQVHJVJpvUnaYlfxgl9XI55b/OkIVX8hDZZSVrPn6QpaN6CnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AGeptgeWQKstDRZ6WhP7hNb8ulL3Tryl7XUgDrXOQgo=;
	b=VVpXKxalE8ETlHs7fJ7QHqR1JUEMtzNH/gqA7I+PXpukhYWwJIR6PvUSv71S5X89T1TP
	 lszoU6dL97ExYrOr96x39O/ZwY8eUiS/oDu3sCKN85j0DW/og7EZ3TABOmbWpRz+RUhTa
	 rYfSQsOiDQaYcajspGBMSuVRRrLHbI8k0b53QdUNipbNe+3o3K4B9Uty0y6egofNpFcpc
	 IBshViRkjOfMCxZVImo25KA9PVdRz87+aZ6f7hWUBUkC++gg1HzXUpJdmHH1Z23VrHKh3
	 jHs7vJ7lW5CWO6FeszBeOsvc62tnUSlNOd0IwZQVqRnLS+fEpm+oVDXxDBQb7SFKiAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZM49RaB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A0606A33C;
	Mon,  9 Nov 2026 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZM49RaB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD721F008A1;
	Mon,  9 Nov 2026 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794212825;
	bh=AGeptgeWQKstDRZ6WhP7hNb8ulL3Tryl7XUgDrXOQgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RZM49RaBjoTUrgYef2hsyoyz6aGV3hhPJvIouWL1z6+HXwL/wmad/wq76/YnGeOBz
	 N7/32leH8E6ieRwlW61b/Af4sBiQ7vUFuPrucs3ob0+/vx7q1XrmqOlH+IMt0w6A2R
	 0spSjZDh/ByCRsvFbj/Bs1Bm9mh7Peas0Ca82uGq98eTXE9pZ1xysubZMkswiflQgJ
	 uMjOMSo6uGoaaiK36Dd0VjCcG5GQ5gYvwaLulY3N4uWJOF+MIlx7mFvksoNWul/rfp
	 wl0P6Fv5kTeZdkqfRIKfl1puOnCEWIs3c6hIZ2JxzpWZ6pF6MG6N6m+sQu8MB8PfnJ
	 nNdvePVu35u+g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 2/2] tracing: fgraph: use scoped_guard() for the task list walk
Date: Mon, 09 Nov 2026 17:27:02 +0900
Message-ID: <undine-1794212822033915371-351c4118961c4f82@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261021174406.2891598-3-vineet.gupta@linux.dev>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev> <20261021174406.2891598-3-vineet.gupta@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 21 Oct 2026 10:44:06 -0700, Vineet Gupta <vineet.gupta@linux.dev> wrote:
> alloc_retstack_tasklist() open-codes rcu_read_lock() and unwinds it
> through an unlock label. Use scoped_guard(rcu) instead and let the
> compiler emit the unlock on every exit path.
> 
> The -EAGAIN case now jumps straight to the free label rather than to
> unlock; leaving the guard's scope releases the RCU read lock on the
> way, so the unlock label has no remaining users and is removed.
> 
> No functional change: objdump of fgraph.o shows identical call targets
> and counts, including the three __rcu_read_unlock() sites the compiler
> emits for the exits from the read-side section. A PROVE_RCU +
> DEBUG_ATOMIC_SLEEP build with the -EAGAIN path forced several thousand
> times is clean.
> 
> The preceding patch deliberately left this alone so that it stays
> straightforward to backport. This is the follow-up.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> Tested-by: Vineet Gupta <vineet.gupta@linux.dev>

This looks good to me. 

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks.

> ---
>  kernel/trace/fgraph.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 4c74f1a15ad4..bbf6e4e2da2d 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1057,32 +1057,31 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  		}
>  	}
>  
> -	rcu_read_lock();
> -	for_each_process_thread(g, t) {
> -		unsigned long *rs;
> +	scoped_guard (rcu) {
> +		for_each_process_thread(g, t) {
> +			unsigned long *rs;
>  
> -		if (t->ret_stack)
> -			continue;
> +			if (t->ret_stack)
> +				continue;
>  
> -		rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
> -		if (!rs) {
> -			if (start == end) {
> -				ret = -EAGAIN;
> -				goto unlock;
> +			rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
> +			if (!rs) {
> +				if (start == end) {
> +					ret = -EAGAIN;
> +					goto free;
> +				}
> +				rs = ret_stack_list[start++];
>  			}
> -			rs = ret_stack_list[start++];
> -		}
>  
> -		atomic_set(&t->trace_overrun, 0);
> -		ret_stack_init_task_vars(rs);
> -		t->curr_ret_stack = 0;
> -		t->curr_ret_depth = -1;
> -		/* Make sure the tasks see the 0 first: */
> -		smp_store_release(&t->ret_stack, rs);
> +			atomic_set(&t->trace_overrun, 0);
> +			ret_stack_init_task_vars(rs);
> +			t->curr_ret_stack = 0;
> +			t->curr_ret_depth = -1;
> +			/* Make sure the tasks see the 0 first: */
> +			smp_store_release(&t->ret_stack, rs);
> +		}
>  	}
>  
> -unlock:
> -	rcu_read_unlock();
>  free:
>  	for (i = start; i < end; i++)
>  		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
> -- 
> 2.53.0-Meta
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
