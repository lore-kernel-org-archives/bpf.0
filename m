Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883249;
	b=CjeGwZER2YQY1X6AkZ0GrI2DX6tBmAgY1DMOJofC0B6DVMZfgY7WeH8U1wYkm7rHNfHv
	 NlgaH7ZitG0kQ9o1rPuNH4Q8C6uz/aGmMM7qMVzfprIjXRUmF6/p+G2MyaVgEW5ciCwzw
	 r+xKY2/KDu95q5KiuANyKPsLjNoo7pjse26cHYtQCa+jezcQ+4VqKsncUHRrmk7qFivvE
	 4pYLhwGFa1pNF+lIQZklytjL42tUi7kkb14+4ouIMSi4N98+A6YYhbAAqJis61oMWnyB9
	 SSMQ+o6WfRMBdoTkzdG3hGwcNpoW4A0lOri66PAsAP+17RTwfxt6hs6kbz+ewBQs/jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883249;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=iXsYh5eKf2FQ1EzlHzZPVEQunxEDxjb2JXoXRWEV9kE=;
	b=TQOAVVUeXa+2ICFJZ0mvo4XholD8sRZW0g2pGNsw74OoTzamuJcyRnjT8D4Jm9EA/eF6
	 askhrcusYRP2Gkxta/Kcwi9jV3Fc/b5WtYwNLudeYD8OsLnMg0dfaSUG3zzI/Zju8hghT
	 RxEk6ICMer40ME9Yo+9okwCALGdFcoWjJmEKxhBffp+Vlb3eSrwIJeFBZjb9tbfleZPpV
	 A1QVMOHs6pAjky4EfEtrGvRmHQZgpeprV8oSd/H62/Bii+qUwmNub7x4/smMgXSqRr8zv
	 xLNrEc2l/9fbP7R1CvbueAusZ+jJ+asz7xAxkK1veM6pkCvR31M34Anw953CIGHrVJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lW+GzrJ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11A606A332;
	Thu,  5 Nov 2026 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lW+GzrJ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75101F000C1;
	Thu,  5 Nov 2026 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883249;
	bh=iXsYh5eKf2FQ1EzlHzZPVEQunxEDxjb2JXoXRWEV9kE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lW+GzrJ2hExjQcQuQGvfimJnDYhZHsGJ7nMKh/LQgmxa8KDt2UzGcBBKSw9vDfzoP
	 I7G5AODeFf0OpbUJclCJwMELS3HcHd/atBLCXHFEU/FxNEUPLvyBnn45dcIzl/RWgD
	 sDjlojgksQi60VftrZIrS9bYi79vsoirNmmrh+TMqnz8o/4CMvvizmjI6tiJO+f4YX
	 IlSzesfAhCQ1b9C7LjyRcI2mL4snYlCdPgNC4Uc0lcQN97pGj5SLvKk0Sb/8MdrcfW
	 8nqWNVhozaXQzvrPLa5VG3F1Ap2G0rh4IsLmThV+PnGHF5JGZ8ZfLQ3EfXq4Zp4QJI
	 /nHeDBB7l8shg==
Content-Type: multipart/mixed; boundary="===============5493733059592945753=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c49c7edc3d7c652c11ffbf19c76c3daf33427252cd007a9304c749453af47b8d@mail.kernel.org>
In-Reply-To: <20261105121642.38019-1-abhishekkhade69@gmail.com>
References: <20261105121642.38019-1-abhishekkhade69@gmail.com>
Subject: Re: [PATCH] bpf: Add network namespace boundary inspection kfuncs
From: bot+bpf-ci@kernel.org
To: abhishekkhade69@gmail.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,abhishekkhade69@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 12:54:08 +0000 (UTC)

--===============5493733059592945753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add network namespace boundary inspection kfuncs

TL;DR: The new kfuncs sit inside the CONFIG_CGROUPS block but their
BTF_ID_FLAGS entries don't. With CONFIG_NET=y and CONFIG_CGROUPS=n,
resolve_btfids may fail the link or kfunc registration may abort, possibly
dropping other kfuncs.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2991,6 +2994,77 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_NET
> +/**
> + * bpf_task_is_init_net - check whether task belongs to initial network namespace

[ ... ]

> +__bpf_kfunc bool bpf_sock_is_init_net(const struct sock *sk)
> +{
> +	if (!sk)
> +		return false;
> +
> +	return net_eq(sock_net(sk), &init_net);
> +}
> +#endif /* CONFIG_NET */
> +

[ ... ]

> @@ -5151,6 +5225,11 @@ BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  #endif
> +#ifdef CONFIG_NET
> +BTF_ID_FLAGS(func, bpf_task_is_init_net, KF_RCU)
> +BTF_ID_FLAGS(func, bpf_task_get_netns_inum, KF_RCU)
> +BTF_ID_FLAGS(func, bpf_sock_is_init_net, KF_RCU)
> +#endif

Are these three kfunc definitions compiled when CONFIG_CGROUPS is not set?

The definitions sit inside the existing CONFIG_CGROUPS block, which is
closed by the "#endif /* CONFIG_CGROUPS */" after bpf_task_get_cgroup1()
and friends, but the BTF_ID_FLAGS() entries are guarded only by
CONFIG_NET and come after the CONFIG_CGROUPS #endif.

With CONFIG_NET=y, CONFIG_CGROUPS=n and CONFIG_DEBUG_INFO_BTF=y, the
functions are not built but generic_btf_ids still names them.  Then
resolve_btfids prints "unresolved symbol bpf_task_is_init_net" for each
of them, and the vmlinux link can fail when CONFIG_WERROR is set.

Without CONFIG_WERROR, the set8 entries keep BTF id 0.  At boot,
kfunc_init() calls register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
&generic_kfunc_set), and btf_check_kfunc_protos() sees btf_type_by_id(btf, 0)
as the void type and returns -EINVAL:

    if (!btf_type_is_func(func))
        return -EINVAL;

The "ret ?:" chain in kfunc_init() then skips every later registration
(SCHED_CLS, XDP, STRUCT_OPS, SYSCALL, CGROUP_SKB, the dtors and
common_kfunc_set).  Could that drop kfuncs such as bpf_obj_new(),
bpf_task_acquire() and bpf_rcu_read_lock() on such configs?

Should the new definitions be moved after the CONFIG_CGROUPS #endif, so
they match the scope of the BTF_ID_FLAGS() entries?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42028225169
--===============5493733059592945753==--
