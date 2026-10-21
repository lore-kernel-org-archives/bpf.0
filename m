Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605240;
	b=WCvhT/DxuX9hblx1b21NsZWbevEwbr5EYUfoEKjfTkFYCtOWWQrZpb/tVxy0prJLs2cR
	 Ivres4yg5zhk2NL9ZTbIGUa/4hmq5Futm1QqS4IpS/ZjS9kGpEcGpp51HEe+2wSwrJRW8
	 feP2ylggxfHTdtQX47WsGDg06qV55uoOg8QMPAURKT2DX0KnJECYBih4ywIToaaZaZpyY
	 rhxStCRTmOkKJdM4zcATvL4sWcXbP5nehnXQOweB3YTZHPElnKtO7K0aO96HOFNP6ss3K
	 uLsiVDKcR6Yl1Xw+lESUcSN9QR3bi7mDEVgNn4j6gVZuer6lqg+DUaoUK05isUToSDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XQ6RTIQDzZVl3ISRq3nQ4do5sKJqre9jYeaeo9C515I=;
	b=ZL6VZyu+7D7lxRKS2VZTf63V2x2Bl2j6T1d7h4F0DwHke7Q/vh4Bv9ii1tVptOiP0GNA
	 7YyUT2HH1rNb5Nn66hSsmwsyKvXcFtdQ5Tbu7G7ZRTJyuhLcYHDszwks+Jj4KtKPv1XnU
	 hJbxWcVg/82n6oSFQK2rR179yaVhFjQjxuxFbEhHAS9fDAL6n4Md/unbTYVEPmo5qjUC8
	 HrRcKJya5A+bmDGDwf8sR2/JEjqLtUloOQl7er1E5/MVCmFSs7Xox7NM75disoqCiiiep
	 y2a3MvOD5wg6K3lJlV82S98jj+TWWI3V0eK0eWADbcam0wzWvz3fXQEdJjSviJQAMNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KM44vbBe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB0606A31A;
	Wed, 21 Oct 2026 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KM44vbBe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4620A1F000C5;
	Wed, 21 Oct 2026 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792605239;
	bh=XQ6RTIQDzZVl3ISRq3nQ4do5sKJqre9jYeaeo9C515I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KM44vbBeZj1qdiQGY9fISPl6Z8/PVrDdvQkhBtux6T4fgzNJIk+j2Ssp0HcuOgJtn
	 v4dXtm3ZwiWTPrDrpKA377XoT8t9aOz4pRk3PfP+szYeHvHp2Myz8/TOxf3m3YM48r
	 447UMh1UgD86APyzEqMATZVMzLf/R45bJnaWoysr/5hu7P/p9YZgxvxd7MXCV7GUEf
	 bb1cWBGizT212quBLAkCppDLHPy9W+etc4CHLzrhCBG4/aD19m+g7UtLEDdnrTaX03
	 VP+UkfXvdE/YPYNdyK5ppMTiCBe612+EPTcxWiMDIb+30Rcj+VF7F/ASJ79kUqk4YL
	 rbebhcCM0NHsA==
Message-ID: <sashiko-outbox-180533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] tracing: fgraph: use scoped_guard() for the task
 list walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261021174406.2891598-3-vineet.gupta@linux.dev>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
 <20261021174406.2891598-3-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:53:58 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tracing: fgraph: mix of scoped_guard() and goto in alloc_retstack_t=
asklist()
--

commit 7d59298fba17927bc12b63b0da1c66b0d138332a
Author: Vineet Gupta <vineet.gupta@linux.dev>

tracing: fgraph: use scoped_guard() for the task list walk

This commit replaces the explicit rcu_read_lock() and rcu_read_unlock() pair
in alloc_retstack_tasklist() with scoped_guard(rcu) and removes the unlock
label by jumping to the free label on the -EAGAIN path.

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 4c74f1a15ad48..bbf6e4e2da2d4 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1057,32 +1057,31 @@ static int alloc_retstack_tasklist(unsigned long =
**ret_stack_list)
>  		}
>  	}
> =20
> -	rcu_read_lock();
> -	for_each_process_thread(g, t) {
> -		unsigned long *rs;
> +	scoped_guard (rcu) {
> +		for_each_process_thread(g, t) {
> +			unsigned long *rs;
> =20
> -		if (t->ret_stack)
> -			continue;
> +			if (t->ret_stack)
> +				continue;
> =20
> -		rs =3D kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
> -		if (!rs) {
> -			if (start =3D=3D end) {
> -				ret =3D -EAGAIN;
> -				goto unlock;
> +			rs =3D kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
> +			if (!rs) {
> +				if (start =3D=3D end) {
> +					ret =3D -EAGAIN;
> +					goto free;
> +				}
> +				rs =3D ret_stack_list[start++];
>  			}
> -			rs =3D ret_stack_list[start++];
> -		}
> =20
> -		atomic_set(&t->trace_overrun, 0);
> -		ret_stack_init_task_vars(rs);
> -		t->curr_ret_stack =3D 0;
> -		t->curr_ret_depth =3D -1;
> -		/* Make sure the tasks see the 0 first: */
> -		smp_store_release(&t->ret_stack, rs);
> +			atomic_set(&t->trace_overrun, 0);
> +			ret_stack_init_task_vars(rs);
> +			t->curr_ret_stack =3D 0;
> +			t->curr_ret_depth =3D -1;
> +			/* Make sure the tasks see the 0 first: */
> +			smp_store_release(&t->ret_stack, rs);
> +		}
>  	}
> =20
> -unlock:
> -	rcu_read_unlock();
>  free:
>  	for (i =3D start; i < end; i++)
>  		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);

[Severity: Low]
In kernel/trace/fgraph.c, alloc_retstack_tasklist() now uses
scoped_guard(rcu) while still jumping out of the guarded scope via goto free
when kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT) fails and start =3D=
=3D end,
as well as jumping to free from the earlier pre-allocation loop:

kernel/trace/fgraph.c:alloc_retstack_tasklist() {
	for (i =3D 0; i < FTRACE_RETSTACK_ALLOC_SIZE; i++) {
		ret_stack_list[i] =3D kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);
		if (!ret_stack_list[i]) {
			start =3D 0;
			end =3D i;
			ret =3D -ENOMEM;
			goto free;
		}
	}
}

The documentation in include/linux/cleanup.h notes that goto-based cleanup
and scope-based cleanup helpers should not be mixed within the same functio=
n:

 * Lastly, given that the benefit of cleanup helpers is removal of
 * "goto", and that the "goto" statement can jump between scopes, the
 * expectation is that usage of "goto" and cleanup helpers is never
 * mixed in the same function. I.e. for a given routine, convert all
 * resources that need a "goto" cleanup to scope-based cleanup, or
 * convert none of them.

Also, on the -EAGAIN path inside scoped_guard(rcu), start =3D=3D end is alr=
eady
true because all pre-allocated entries in ret_stack_list[] have been consum=
ed,
so the cleanup loop at the free label runs zero iterations on that path.

Should alloc_retstack_tasklist() avoid mixing scoped_guard(rcu) with goto
free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021174406.2891=
598-1-vineet.gupta@linux.dev?part=3D2
