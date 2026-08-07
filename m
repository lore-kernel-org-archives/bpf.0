Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AF3AE19D
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087433; cv=none; b=iYDZc7dcxhxhc6vCM0jKFr6n+29+z3QfTCF05mbZa4ZVwl4EwS2cB6G5oNhhsUk4y4ZN1ZS+9XaUvyzZnwekPy3+JDfG5Y0v2xiL5y9dTMVO6tSY3ltwb2SFdL9Gx332fUnDV25/ltS034RqOkOHMJYS22EkWJRLzJlGAvjZDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087433; c=relaxed/simple;
	bh=Idw1Y4rUNh+0MXK8OITctjw5POdj3yagguibE+c+jOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n39UQuBAbzpqQQPTBI4fWX8YUmdAfGVn2ciPCXKpvC/cWxDo9H+VLMcjLrjlx7KbLQimtOAf5Pynvab7YAXw8k0AM0Q0DzqFdzvMT6RdF+hjLSzrKDyPZswbxCVGf268S47MNeTYZ+PYiwnO2O1hX0dPG/irYdL6QYSXx3DyRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSsBUQ7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSsBUQ7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BF11F000E9;
	Fri,  7 Aug 2026 07:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786087431;
	bh=0gHENSt/gv59RFqRi2RVrtdqa/g7TkjLRJ4BkTaXnzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DSsBUQ7UoaFI8vZGJBGulY1kognEaMs30Rc5dvRlAs3d7Fbf7+f3E7/SIa9mZzMmL
	 1mS+VfPr/YyoX4a0FpZTuGW1voCa87GzTzHrRaeH1TFOPsDMhsAtidOGALbr7wWXAG
	 zJz0COx2ZxTHtUEJtBDN8zYy7bngahvXtulLFUE23L8Rse/K0Wr6SlMi83v7EaGZwy
	 Ww0WgQnYIWHKtlSOXhaDvmGkHDpNPgR8r5VPhyqSute9ks6qI13R104ae6/7+u9j2B
	 wyoNhP2+XizOpS38M7K51FfX4WjzA1ROn5DR/3xRjJM1GTanxi/k4bdumS5gKaNR6K
	 LMOrdpEBh4lrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/4] mm/bpf: Add
 bpf_try_to_free_mem_cgroup_pages kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: mkoutny@suse.com, hannes@cmpxchg.org, bpf@vger.kernel.org, tj@kernel.org
In-Reply-To: <5cd3efa9a4c614ba0b03cf4a3bd459dea67a9f61.1786086076.git.zhuhui@kylinos.cn>
References: <cover.1786086076.git.zhuhui@kylinos.cn>
 <5cd3efa9a4c614ba0b03cf4a3bd459dea67a9f61.1786086076.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 07:23:50 +0000
Message-Id: <20260807072351.74BF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Recursive invocation of try_to_free_mem_cgroup_pages() via bpf_try=
_to_free_mem_cgroup_pages() clobbers current->reclaim_state, leading to a k=
ernel crash or corrupted slab reclaim accounting.
--

--- Patch [1]: [PATCH bpf-next 1/4] mm/bpf: Add bpf_try_to_free_mem_cgroup_=
pages kfunc ---
commit df416a25d32f502ac37a07ea5346f80fe7a52345
Author: Hui Zhu <zhuhui@kylinos.cn>

mm/bpf: Add bpf_try_to_free_mem_cgroup_pages kfunc

This commit exposes the memory cgroup reclaim interface to BPF programs by
adding the bpf_try_to_free_mem_cgroup_pages kfunc. The wrapper translates
the swappiness argument before delegating to the core reclaim path.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..3f7a5c97e1355 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
[ ... ]
> @@ -159,6 +160,61 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct m=
em_cgroup *memcg)
>  	mem_cgroup_flush_stats(memcg);
>  }
> =20
> +/**
> + * bpf_try_to_free_mem_cgroup_pages - attempt to reclaim pages from
[ ... ]
> + */
> +__bpf_kfunc unsigned long
> +bpf_try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> +				 unsigned long nr_pages,
> +				 gfp_t gfp_mask,
> +				 unsigned int reclaim_options,
> +				 int swappiness)
> +{

[Severity: High]
If this kfunc is called from a sleepable BPF program that was triggered dur=
ing
memory reclaim (e.g., via an fentry hook on a function like shrink_slab), c=
ould
it corrupt the reclaim state and crash the kernel?

Looking at the underlying try_to_free_mem_cgroup_pages() in mm/vmscan.c, it
unconditionally overwrites current->reclaim_state and sets it to NULL upon
return:

    set_task_reclaim_state(current, &sc.reclaim_state);
    ...
    nr_reclaimed =3D do_try_to_free_pages(zonelist, &sc);
    ...
    set_task_reclaim_state(current, NULL);

If the outer reclaim path resumes and attempts to dereference
current->reclaim_state (such as in set_mm_walk() or clear_mm_walk() in MGLR=
U),
wouldn't it hit a fatal NULL pointer dereference?

Should there be a mechanism here to prevent nested reclaim calls, or should=
 the
underlying function save and restore the previous reclaim state?

> +	int *swapiness_ptr;
> +
> +	if (swappiness > SWAPPINESS_ANON_ONLY)
> +		return 0;
> +	else if (swappiness < MIN_SWAPPINESS)
> +		swapiness_ptr =3D NULL;
> +	else
> +		swapiness_ptr =3D &swappiness;
> +
> +	return try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask,
> +					    reclaim_options, swapiness_ptr);
> +}
> +
>  __bpf_kfunc_end_defs();
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786086076.gi=
t.zhuhui@kylinos.cn?part=3D1
