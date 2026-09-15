Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D40409280
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488437; cv=none; b=A6ZW72U+/xyDOpL9Ay7x6GDmwbxbdMp59G8OXpOlJG4JNtEK7/D8b5GPBR+RhLtxiP3yeFhjQ5CoVvtzL8SUAneKVAUSsFCAzzRf6v++Vd1/nUtL8G6n5rAowgWTrwcSxnpInWyYMALjLVX/lFhXgFPAIAkc7qEFhwEQt5Yxn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488437; c=relaxed/simple;
	bh=+CwFx4/bfG7AkbNnAlK9gj5kGFMcAy38ywIvzWAUG0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pr/pByna6TavQjLofPweUn7gjuo3DVRH1poPfczK9RQ/ZH+FYACJMnQT6wsYJD+g3ZnQqPO4OEo70rNAu3B/IpDrKWnDQ1+Cn9Ovi7wpGS7VcWC3w8Pi2RVQoiCQg5bCeTKChrNuO7XMDvRkTaD28CwxRfkcerY5IEfW3Kit5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESbkJQsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESbkJQsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420FA1F00893;
	Tue, 15 Sep 2026 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789488435;
	bh=mj8tEZ8d79xlIWSklPZsKWyfRVkDEENguR1rYPNgor4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESbkJQspWYqSWG45zVJjKpAEDbBEMhEpwL6zWRl5VN3j5rnEAxGsiR89MZi5FIfx8
	 5+cas+2ofRDB4EwtGG67bDWpdPC4TeUGlB48JEZipnqqk6uSDZ/3xygqixQ7uH5d4F
	 e1dE+S4vvpm65aV2XJvBI3NLxCxrqZIxbUd1woXJQj7oPU5vBRj+oHZPrNcK9a12We
	 jp9V41SDbVoM/QQDbMirnfgSra++lPMD61AgJipv09/0UC8GEb2/3k5SiMpwKV/9eK
	 eIsY8a9R52tQt28Je2KHzMOhE3g9Y4NDjgyhVymXOqNK/vInpm9K2S7ZCm4hrxjUCt
	 GVrYEymsvgJWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add bpf_call_rcu_tasks_trace()
 kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915154248.3612028-4-puranjay@kernel.org>
References: <20260915154248.3612028-1-puranjay@kernel.org>
 <20260915154248.3612028-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:07:14 +0000
Message-Id: <20260915160715.420FA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: NMI deadlock via call_srcu() in bpf_call_rcu_tasks_trace()
--

commit 04163bb602a2cdfd9c0dc0db4f4484868a98025b
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Add bpf_call_rcu_tasks_trace() kfunc

This commit introduces bpf_call_rcu_tasks_trace(), a new kfunc that defers
reclaim until after a tasks trace grace period. It builds on the existing
bpf_call_rcu() machinery, but routes the queuing through
call_rcu_tasks_trace() to wait for sleepable BPF programs.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -4744,13 +4733,50 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head =
*rh, void *map__const_map,
>  		return -EBADF;
>  	}
> =20
> -	rhk->callback_fn =3D (bpf_callback_t)(void *)callback;
> +	rhk->callback_fn =3D (bpf_callback_t)callback;
>  	rhk->map =3D map;
>  	rhk->prog =3D prog;
> -	call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> +	if (trace)
> +		call_rcu_tasks_trace(&rhk->rcu, bpf_rcu_run_callback);

[Severity: High]
Does this code risk an NMI deadlock?

call_rcu_tasks_trace() is a wrapper for call_srcu(), which acquires the
per-CPU sdp->lock. If this kfunc is called from an NMI context (such as a
BPF tracing program attached to perf_event) while the interrupted context
already holds the sdp->lock on the same CPU, wouldn't this cause a deadlock?

> +	else
> +		call_rcu(&rhk->rcu, bpf_rcu_run_callback);
>  	return 0;
>  }
[ ... ]
> @@ -5045,6 +5071,7 @@ BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLI=
CIT_ARGS | KF_SPINLOCK_SAFE)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_call_rcu, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, bpf_call_rcu_tasks_trace, KF_IMPLICIT_ARGS)

[Severity: High]
Could we restrict the execution context of this kfunc?

Since bpf_call_rcu_tasks_trace() is registered here without any context
restrictions, it permits use in NMI-context tracing programs, which exposes
the potential deadlock with call_srcu() mentioned above.

>  BTF_ID_FLAGS(func, bpf_dynptr_from_file)
>  BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_timer_cancel_async)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915154248.3612=
028-1-puranjay@kernel.org?part=3D3
