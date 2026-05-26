Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAC347BDC
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764681; cv=none; b=EkfMlpC7G8VDQpawetwr56HvgbwDrigkinyoHacjm2o9D6Y/GtU2jn8XiambVL/6jT/3NxjZBKnIzPR0dW4dCEmV3TciwBkIjl/QAlCvRsqKukKpU5ogmhUOJIZ+kMslyP4D4Xc+BKK2SP5zSl5CFnOQBilooDvUN02zYAKPfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764681; c=relaxed/simple;
	bh=SFnmnm7giEmej8+oRuOydpfaYwa2O6Q48AQaMj4Z7uI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tRlXe02xfyLJF6ePK4Wyqo0zHIaovitIcfg/qw+2MrA9K17bv+ADkj2Rf6W+qbuEmAm0DY7LihuVJKfhQo6EXGEwQSNo53iKX10nTrQ31agbF9ITJ0tuB9d0HsZd45hmSbnT2HTWAnuk/c3Ot0tP6CjqfEvV8KhDs3BXOPLEqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCK5G5x0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCK5G5x0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2865A1F000E9;
	Tue, 26 May 2026 03:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779764679;
	bh=DRH8JQpj6iQvzunzt84/p2D6H4c+ANkDI9+1z13hXIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCK5G5x0Txg2u7D/46VoVMcBWNYNz1zHpjyXphTHGaBqVO+3+PNAZOZ7zSREPTA+L
	 aIQDMnRjqdQcljGus2cDHOEpA1xStp5nbUCL9TR0MxhudUtqH2mkw8MPn6Sfn7mprI
	 o79wK6sHczmMc2ih1AgVZVyG4H+1ZIWjKgmZQoKml0ET2OtPKGztF09EFxoTY/wOrL
	 pTTLYF7+X+BCNuAh9mR8uW7qNa/HYWq4wHIep5m7iepeYvFrSpI1/0yMiDt9i83aGj
	 WHR/bTYjVT8iRm98dIxJz4NFSucqAhO3pQc/eU0N/032TPI6Tzwv7dbZ5w7XLKfs21
	 n1TGK/ILcEioQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v7 06/11] mm: memcontrol: Add BPF
 struct_ops for memory controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, bpf@vger.kernel.org, tj@kernel.org
In-Reply-To: <9e081d01a0708dcdd101af7f7bede07cf43ca21d.1779760876.git.zhuhui@kylinos.cn>
References: <9e081d01a0708dcdd101af7f7bede07cf43ca21d.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 03:04:38 +0000
Message-Id: <20260526030439.2865A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Using `cgroup_e_css` for target memcg resolution during regist=
ration allows the BPF struct_ops pointer to outlive the BPF program, leadin=
g to a critical Use-After-Free.
- [High] BPF struct_ops attach/detach does not invoke `handle_cgroup_online=
` and `handle_cgroup_offline` for pre-existing cgroups, leading to state in=
itialization failures and resource leaks.
- [High] The `bpf_memcg_charged` hook is bypassed in force-charge paths, wh=
ile `bpf_memcg_uncharged` is unconditionally invoked, causing negative acco=
unting drift.
- [Medium] Injecting `bpf_high_delay` into `__mem_cgroup_handle_over_high` =
creates an unintended 16-iteration loop when the cgroup is not over its mem=
ory.high limit.
--

commit 1665ba1b3048519410b9675f614ad883e30992b8
Author: Hui Zhu <zhuhui@kylinos.cn>
Subject: mm: memcontrol: Add BPF struct_ops for memory controller

This commit introduces BPF struct_ops support for the memory controller.
It allows BPF programs to hook into charge and uncharge paths to apply
custom delays, and provides hooks to override memory.low and memory.min
checks.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..1f726a7b22e36 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
[ ... ]
> @@ -179,15 +182,306 @@ static const struct btf_kfunc_id_set bpf_memcontro=
l_kfunc_set =3D {
[ ... ]
> +static int bpf_memcg_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *ops_link;
> +	struct memcg_bpf_ops *ops =3D kdata, *old_ops;
> +	struct cgroup_subsys_state *css;
> +	struct mem_cgroup *memcg, *iter;
> +	int err =3D 0;
> +
> +	if (!link)
> +		return -EOPNOTSUPP;
> +	ops_link =3D container_of(link, struct bpf_struct_ops_link, link);
> +	if (!ops_link->cgroup)
> +		return -EINVAL;
> +
> +	cgroup_lock();
> +
> +	css =3D cgroup_e_css(ops_link->cgroup, &memory_cgrp_subsys);

[Severity: Critical]
Could this use of cgroup_e_css() lead to a use-after-free?

If the memory controller is not enabled on the target cgroup, this resolves
to an ancestor's css, attaching the program to the ancestor and all its
descendants.=20

If the memory controller is subsequently enabled on the target cgroup, a new
css is created for it. When the program is later detached, bpf_memcg_ops_un=
reg
calls cgroup_e_css() which now returns the target cgroup's newly created cs=
s.

The unregistration loop will only clear bpf_ops on this new subtree, leaving
stale pointers on the ancestor and all its other descendants. When the BPF
program is freed, any memory charge on the ancestor hierarchy will derefere=
nce
the freed bpf_ops pointer.

> +	if (!css) {
> +		err =3D -EINVAL;
> +		goto unlock_out;
> +	}
> +	memcg =3D mem_cgroup_from_css(css);
[ ... ]
> +	iter =3D NULL;
> +	while ((iter =3D mem_cgroup_iter(memcg, iter, NULL))) {
> +		WRITE_ONCE(iter->bpf_ops, ops);
> +		iter->bpf_ops_flags =3D ops_link->flags;
> +	}

[Severity: High]
Does this bypass handle_cgroup_online() for pre-existing cgroups?

When bpf_memcg_ops_reg() attaches a BPF program, it iterates over all
descendants to set the bpf_ops pointer but does not invoke
handle_cgroup_online() for existing cgroups.

Conversely, bpf_memcg_ops_unreg() clears the pointer without calling
handle_cgroup_offline().

If a BPF program dynamically allocates per-cgroup resources (e.g., maps
or memory tracking structures), will those resources be permanently leaked
because the offline cleanup callback is bypassed during unregistration,
and subsequent cgroup deletion won't invoke the hook since the pointer
is already cleared?

> +
> +unlock_out:
> +	cgroup_unlock();
> +	return err;
> +}
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 749c128b4fad5..3494f36d792d8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
[ ... ]
> @@ -2516,11 +2522,15 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
>  	 * memory.high is breached and reclaim is unable to keep up. Throttle
>  	 * allocators proactively to slow down excessive growth.
>  	 */
> -	penalty_jiffies =3D calculate_high_delay(memcg, nr_pages,
> -					       mem_find_max_overage(memcg));
> +	if (nr_pages) {
> +		penalty_jiffies =3D calculate_high_delay(
> +			memcg, nr_pages, mem_find_max_overage(memcg));
> =20
> -	penalty_jiffies +=3D calculate_high_delay(memcg, nr_pages,
> -						swap_find_max_overage(memcg));
> +		penalty_jiffies +=3D calculate_high_delay(
> +			memcg, nr_pages, swap_find_max_overage(memcg));
> +	} else
> +		penalty_jiffies =3D 0;
> +	penalty_jiffies =3D max(penalty_jiffies, bpf_high_delay);

[Severity: Medium]
Will this force 16 useless iterations of reclaim_high() when not over
the memory.high limit?

If a BPF program returns a delay (bpf_high_delay > HZ/100), the assignment
above bypasses the penalty_jiffies <=3D HZ/100 bailout check.

Even if nr_pages =3D=3D 0, the function falls through to
if (nr_reclaimed || nr_retries--). Since nr_reclaimed is 0, this creates
a 16-iteration loop that repeatedly walks the cgroup tree doing nothing.

> =20
>  	/*
>  	 * Clamp the max delay per usermode return so as to still keep the
[ ... ]
> @@ -2746,6 +2759,8 @@ static int try_charge_memcg(struct mem_cgroup *memc=
g, gfp_t gfp_mask,
>  		}
>  	} while ((memcg =3D parent_mem_cgroup(memcg)));
> =20
> +	bpf_high_delay =3D bpf_memcg_charged(orig_memcg, batch);
> +

[Severity: High]
Does this code miss forced allocations, causing negative accounting drift?

If an allocation is forced (e.g., via PF_MEMALLOC, __GFP_NOFAIL, or the OOM
path), the code jumps to the force label, charges the memory, and returns 0
without executing the done_restock path where bpf_memcg_charged() is called.

However, when these pages are freed, memcg_uncharge() unconditionally
executes bpf_memcg_uncharged(). This imbalance will cause any BPF program
that tracks charged memory via these hooks to experience negative
accounting drift.

>  	/*
>  	 * Reclaim is set up above to be called from the userland
>  	 * return path. But also attempt synchronous reclaim to avoid

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779760876.gi=
t.zhuhui@kylinos.cn?part=3D6
