Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336633;
	b=nerHpTXui6zfp50ggFO71WuIpbCe5dfvQSOsi/M1Jh93G3SGBitR01IjXMuTHxAViV9Q
	 x3EMd9LkmWSRrjIM+34JnrlhJ/eaQOxij5mNOXGOOI3SLu1GOUgCw6m3Zl74khTYvw+S6
	 P1BN9FBEjpbVnBUkrwFoVTcRodrJ+5X17MhPqiLOf31hfFquwf852GDMwGiVpV8g+Xe/r
	 0nh+rmbxH++rupkavw5MdTgXPQcLEfBZEcimfC1HIuHiImW8IMVIZZzucYwmqFRS+PNoK
	 tn5rTbj4ktSw6+7ATHV/ibbxxOm/PCmVR0u53iATyVYb+Y/+ptFwvt2gDxmJ/G0kaOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336633;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=93NL5yz+3QKPP5WELcAqJ61iCYkDaiarObF4tACg0WU=;
	b=pD+J9YOFB9jHlhamQgan89GJFCnDB/Jov0Y7W6Uz6CY8+Y+8GziVZaundhum5vNdvI5I
	 cMyRWJgLEbAv5P40vFDoXeDATLZCckCXTeKsmrAMuZvbrYh6iuFmkYlqoZwO38ybekuSR
	 F+7IlhGsD3h/Lotb0AVRrgKxqCFwf5llHL59yYYruTTjrWBo4MESvNWpnNgQI+Vx+t0T+
	 zEWSTNF9AgHz15ETQaz/lRpeWgFpdFELNv/rvgcgrcIAT29C/XHb3BYiERPUtoHaUsjK3
	 7evSwoMqwUuxin03IzeuqIcIkpNRXpV+Ev2OApzixdroEKf5mNBUcAZvTrXbQ32JLZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/CvgNXe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA17606A320;
	Tue, 10 Nov 2026 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/CvgNXe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BAE1F0089F;
	Tue, 10 Nov 2026 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336632;
	bh=93NL5yz+3QKPP5WELcAqJ61iCYkDaiarObF4tACg0WU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=j/CvgNXeoUgqLZbrh25fy8ki9qZYw3Ufq4lajRGkx6SWO/wog1Pl8/P17915Lpwgx
	 f6p82JXImsJNa7ttmfWZ+k7NI96v08BpNVwEEVyfGSFbzmoeXJuroYUZv9WtxLSZKF
	 fKFeMAyOfLl5a1ME4MMeJitPVneUY6HOG/cjb0h59wdA6ZY8en6G8FT1LOAyG1GDD8
	 /hHQYllNxqukw46KtvzuAN6x5mNSrx+px2ATIFldjDj2zjioSsSXGDBa8nId5ZNRUk
	 SUDLirtkOkXuiGOgInk8jKbW6EVfMQNKVnMnABY70zYAoPWLFeYb4wmUCjQQVD7VdP
	 ZyHsz5/wDs6SQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38FB3CE0AD8; Tue, 10 Nov 2026 10:50:32 -0800 (PST)
Date: Tue, 10 Nov 2026 10:50:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf] bpf: Report RCU-tasks quiescent states in do_check()
Message-ID: <a8891e73-226b-4baa-ab7c-59ed23919efd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261110-bpf-verifier-rcu-tasks-qs-v1-1-99e8f798a6dc@debian.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-bpf-verifier-rcu-tasks-qs-v1-1-99e8f798a6dc@debian.org>

On Tue, Nov 10, 2026 at 04:18:32AM -0800, Breno Leitao wrote:
> I am seeing rcu_tasks stalls in the Meta fleet on debug kernels (KASAN,
> kmemleak, lockdep), where a task loading a BPF program stays in the
> verifier for over 20 minutes:
> 
>   INFO: rcu_tasks detected stalls on tasks:
>   000000000cc1a43d: .. nvcsw: 4/4 holdout: 1 idle_cpu: -1/91 task:GlobalCPUThread state:R  running task  pid:175256 tgid:169948 ppid:1
>   Call Trace:
>    __create_object
>    __kmalloc_node_track_caller_noprof
>    krealloc_node_align_noprof
>    copy_array
>    bpf_copy_verifier_state
>    bpf_split_cur_state
>    do_check_common
>    do_check_main
>    bpf_check
>    bpf_prog_load
>    __sys_bpf
> 
> The main loop in do_check() only calls cond_resched(), which is a no-op
> on PREEMPTION kernels. Involuntary preemption is not a Tasks-RCU
> quiescent state, so the loading task never reports one and stays a
> holdout until bpf_prog_load() returns. Meanwhile every
> synchronize_rcu_tasks() caller waits, e.g. ftrace_shutdown() of a
> dynamic ftrace_ops.
> 
> Upgrade it to cond_resched_tasks_rcu_qs(), which reports a quiescent
> state even when cond_resched() does nothing. The need_resched() check
> goes away, as cond_resched() does it already.
> 
> Fixes: 3c2ce60bdd3d ("bpf: adjust verifier heuristics")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/bpf/verifier.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e4700fda66b9f..232551fd7cefdd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20627,8 +20627,7 @@ static int do_check(struct bpf_verifier_env *env)
>  		if (signal_pending(current))
>  			return -EAGAIN;
>  
> -		if (need_resched())
> -			cond_resched();
> +		cond_resched_tasks_rcu_qs();
>  
>  		/* reset current history entry on each new instruction */
>  		env->cur_hist_ent = NULL;
> 
> ---
> base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
> change-id: 20261110-bpf-verifier-rcu-tasks-qs-bb523c1febe9
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
