Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6937FF50
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473688; cv=none; b=uKJF5fWPiG+OUAV9nOZc0EuwA5JGHlZXpHiXdFg+aTKu/Yj3lv9cjph2igEGANvZfqhggPOdgAMwAjYkKVezB595wMiQEuXnn9LKSY9+9sIxZ60gpXIowa9VCvtCl6Cf8mrya7dMZx5VOR76pDK3AwIlDi372gqccIhS9r9BOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473688; c=relaxed/simple;
	bh=FCZw9H1LeQRjzAZDIg1I7rGn/z4Eyck+VTUqSqAhJ3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mewC/Y7F2QGrPJLYWiyNdNPyYTO+QLVhww69imXnuv3y3ypNl5TBpFylHR846QEKj4FqYyIPcpvHqtZB6CrKYL8qT6ETLbj9xQfGn/h7z2GF5oqgnk/7yAztPv4oynJC7p8ExwWZ628nXQ4GlgB2ey9n1kaUQwkHhF20XN/zSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQLZ3zi9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQLZ3zi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099B91F000FF;
	Tue, 15 Sep 2026 12:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473687;
	bh=FMdYesXm6VdodJXlkftS4RL3Xd46LHVvQfdT8QY3/q8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WQLZ3zi9McVFiozYf3KzsBbi41gXzqxIEuYPIVjSnn96qhxFlgkRRycYrW8aypwRY
	 yPXgrk7Z1cTfamvFIeToSDMwadE7/hpptjt1Q4NglfzWSqhuFfhP112QBHQhzAI40N
	 AkS2zxqW+hihTjARCpglhsokL1hoeGgN3LRFGUXbZeKYnXnuKrdVuNjWRPFsFHUdkx
	 v3t0GtvaJaA7EIBb4oeRpHbz1BfWEE4FRRdQ9+ydyY4Sg+AKAkdJgGlOR269p8QzvW
	 PSmA36KGeYPQE04vyH7ocUkcoVnB0ypODAtHa6MoJpCrXk+uHN/bnzMH7lVKooC4iN
	 lF5CLfBu5TLgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Add bpf_call_rcu() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915114240.3269184-2-puranjay@kernel.org>
References: <20260915114240.3269184-1-puranjay@kernel.org>
 <20260915114240.3269184-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:01:26 +0000
Message-Id: <20260915120127.099B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: build failure due to missing bpf_call_rcu_tasks_trace implemen=
tation
--

commit 06a7a5ada7a6b07d90668fb28558d25075dfcf41
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Add bpf_call_rcu() kfunc

This commit introduces the bpf_call_rcu() kfunc to allow BPF programs to
queue callbacks that execute after an RCU grace period. It adds the
necessary BTF fields, map validations, and verifier support to safely
invoke these callbacks.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cdf..f91c997bc8445 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12526,6 +12583,8 @@ enum special_kfunc_type {
>  	KF___bpf_trap,
>  	KF_bpf_task_work_schedule_signal,
>  	KF_bpf_task_work_schedule_resume,
> +	KF_bpf_call_rcu,
> +	KF_bpf_call_rcu_tasks_trace,

[Severity: Low]
Will this cause a build failure? Looking at the addition of
KF_bpf_call_rcu_tasks_trace to enum special_kfunc_type in
kernel/bpf/verifier.c, the kfunc is added to the special list here, but the
actual implementation of bpf_call_rcu_tasks_trace does not seem to be
included in this patch.

I understand the implementation is added later in the series in commit
d37bdb9e0af5ddd44775e974f01a56e73c98e9d3 (bpf: Add
bpf_call_rcu_tasks_trace() kfunc), but shouldn't each patch be
self-contained and compilable to preserve git bisect functionality?

>  	KF_bpf_arena_alloc_pages,
>  	KF_bpf_arena_free_pages,
>  	KF_bpf_arena_reserve_pages,

[ ... ]

> @@ -12619,6 +12678,8 @@ BTF_ID(func, bpf_dynptr_file_discard)
>  BTF_ID(func, __bpf_trap)
>  BTF_ID(func, bpf_task_work_schedule_signal)
>  BTF_ID(func, bpf_task_work_schedule_resume)
> +BTF_ID(func, bpf_call_rcu)
> +BTF_ID(func, bpf_call_rcu_tasks_trace)

[Severity: Low]
Does exposing this function to resolve_btfids without its implementation
present in this commit break the build? Since the symbol is missing in
vmlinux at this point in the series, resolve_btfids might fail to find it
and cause a regression during compilation.

>  BTF_ID(func, bpf_arena_alloc_pages)
>  BTF_ID(func, bpf_arena_free_pages)
>  BTF_ID(func, bpf_arena_reserve_pages)

[ ... ]

> @@ -12690,6 +12751,12 @@ static bool is_bpf_rbtree_add_kfunc(u32 func_id)
>  	       func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl];
>  }
> =20
> +static bool is_call_rcu_kfunc(u32 func_id)
> +{
> +	return func_id =3D=3D special_kfunc_list[KF_bpf_call_rcu] ||
> +	       func_id =3D=3D special_kfunc_list[KF_bpf_call_rcu_tasks_trace];
> +}
> +

[Severity: Low]
Can this check for special_kfunc_list[KF_bpf_call_rcu_tasks_trace] be
deferred to the commit that actually introduces the function, so the
verifier checks remain strictly aligned with the available features?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915114240.3269=
184-1-puranjay@kernel.org?part=3D1
