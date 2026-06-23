Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A58F377ED2
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782255241; cv=none; b=oFyJ63PhCKZmWuiPC/T4xWVFbcqDxd2EjeV1AlwjIumzow3EJkHa63rEBNdcOguE562RqUxkrdZvsD6q+0E5M7jOoyS8TVg/hmaC3gkfxrqa0lPTApM6tseu8X7rFHfsoVlwnR+UibgvKnqEVM5zFasvVn2i4NJGRoE6U7F2WNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782255241; c=relaxed/simple;
	bh=Lj7yog85Qke2vlC0fDf2O9jwLY4c25K4y3Ykz/JsPQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mn0kqdchAqkNYGzuseMXXYZwHpMyo9Lu+zFwEjibjygEPYrzobaxWS1RDX034f9qEcTpK9+JmtnZyh0MFsvdZobKIo0drF0HA8BsIf4gtVuNo3/zXWjtY1XwxMpacfn2gY5CIJxp6/XBmaD+ISKKYo+fvB7pcEEHJDxK8HISR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU9tkf5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU9tkf5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EE31F00A3A;
	Tue, 23 Jun 2026 22:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782255239;
	bh=NXgdQSWt+mP3gEijeXAwruBy9xJ+Js2SunMfDs6myls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fU9tkf5qAbvzUoj8SJKO0cNRsCNEBnK5OksG05q4dsKGrQgQnhO9Ryh263Nu7ZuEX
	 w2nlEm48NGKwIsTi520AM+J6wwO0wDxqD+QqLxrEEDPp65FwMcaWS4nuM1r5qtoEb3
	 G0mhB7YZTtXsaf1NjJUSDfJhBpHBN7zoffv6H8Nsd2aQCuTFEqT26aMXVRGL4Aycpd
	 ZLjeD035HSOzarHHc5roK97S3r6f9LvsW+gtreuZ9jY2USvsUXNbBGRj28wYez98oh
	 JVuDWpVShi+EMT6UeJdRSDrdI0bzMa0Kk+EvSvx7pEpEmKQencyUXVLz+cVChJ6u8X
	 +b78aMTQF4YMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 09/15] bpf: Add infrastructure to support
 attaching struct_ops to cgroups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623175006.3136053-10-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
 <20260623175006.3136053-10-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:53:59 +0000
Message-Id: <20260623225359.77EE31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The `bpf_cgroup_struct_ops_foreach` macro does not filter out dumm=
y sentinel elements, leading to type confusion and kernel panics.
- [High] Strict `rcu_dereference()` in `bpf_cgroup_struct_ops_foreach` caus=
es lockdep splats or panics for sleepable struct_ops.
- [High] Array truncation during `purge_effective_progs` if the struct_ops =
type was registered without `cfi_stubs`.

Pre-existing issues:
- [High] `bpf_cgroup_array_copy_to_user()` incorrectly returns -ENOSPC when=
 trailing dummy elements exist, breaking userspace queries.
--

commit a3bccbe6dc639128f470580a5e6281248194eb4e
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Add infrastructure to support attaching struct_ops to cgroups

This patch adds necessary infrastructure to attach a struct_ops map to a
cgroup. It reuses existing cgroup bpf structures and logic to handle the
attachment, hierarchy, and ordering of struct_ops maps. It also implements
a separate struct bpf_link_ops for cgroup's struct_ops link.

> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 4d0cc65976a14..8a75a6cd73096 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -110,6 +112,18 @@ struct bpf_prog_list {
>  	u32 flags;
>  };
> =20
> +#define bpf_cgroup_struct_ops_foreach(var, item, cgrp, atype)		\
> +	for (item =3D rcu_dereference((cgrp)->bpf.effective[atype])->items;\
> +	     ((var) =3D READ_ONCE(item->kdata));				\
> +	     item++)

[Severity: High]
Does this macro fail to filter out dummy sentinel elements?

When update_effective_progs() fails under memory pressure, the kernel falls
back to purge_effective_progs(), which overwrites the detached link's point=
er
with a dummy sentinel value (struct_ops_cfi_stubs[atype]).

Since the macro yields every non-NULL element to the caller subsystem,
including these dummy sentinels, could this cause type confusion and kernel
panics if the subsystem accesses data fields on the dummy struct?

[Severity: High]
Will this strict rcu_dereference() cause lockdep splats or panics for
sleepable struct_ops?

The patch introduces free_after_mult_rcu_gp to support sleepable struct_ops,
meaning a subsystem executing a sleepable bpf program must hold
rcu_read_lock_trace() instead of the standard rcu_read_lock(). However,
rcu_dereference() rigidly enforces that rcu_read_lock() is held.

If the subsystem holds rcu_read_lock_trace(), lockdep will splat, and if
it erroneously holds rcu_read_lock(), the kernel will crash when the
sleepable bpf program actually sleeps.

Should this use rcu_dereference_check() or similar to accommodate sleepable
contexts?

> +
> +static inline bool cgroup_bpf_is_struct_ops_atype(enum cgroup_bpf_attach=
_type atype)
> +{
> +	return atype =3D=3D CGROUP_TCP_SOCK_OPS;
> +}
> +void cgroup_bpf_struct_ops_register(int atype, u32 type_id, void *cfi_st=
ubs, bool mult_trace);
> +int cgroup_bpf_struct_ops_attach(struct bpf_map *map, const union bpf_at=
tr *attr);
> +
>  void __init cgroup_bpf_lifetime_notifier_init(void);

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64572f85edc83..d591f306ace52 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -9868,6 +9872,23 @@ btf_add_struct_ops(struct btf *btf, struct bpf_str=
uct_ops *st_ops,
>  	if (err)
>  		return err;
> =20
> +	if (cgroup_atype) {
> +		if (!cgroup_bpf_is_struct_ops_atype(cgroup_atype) ||
> +		    st_ops->reg || st_ops->unreg || st_ops->free_after_tasks_rcu_gp) {
> +			bpf_struct_ops_desc_release(&tab->ops[btf->struct_ops_tab->cnt]);
> +			return -EINVAL;
> +		}
> +
> +		/* There is no need to unregister from cgroup when the
> +		 * btf_free(). No struct_ops map and its cgroup link
> +		 * can be created once its btf is gone.
> +		 */
> +		cgroup_bpf_struct_ops_register(cgroup_atype,
> +					       tab->ops[btf->struct_ops_tab->cnt].type_id,
> +					       st_ops->cfi_stubs,
> +					       st_ops->free_after_mult_rcu_gp);

[Severity: High]
Does this path accept st_ops->cfi_stubs without validating that it is non-N=
ULL?

If a struct_ops type is registered without providing cfi_stubs (e.g., if
CONFIG_CFI_CLANG is disabled), struct_ops_cfi_stubs[atype] will be NULL.

Later, if a link is detached and update_effective_progs() fails due to memo=
ry
pressure, the fallback bpf_cgroup_array_delete_safe_at() overwrites the
detached program's slot with bpf_cgroup_array_dummy().

Because cfi_stubs is NULL, it writes NULL into the middle of the array.

Since NULL is used as the array terminator, won't this prematurely truncate
the array and silently bypass all attached bpf programs that follow the
detached one?

> +	}
> +
>  	btf->struct_ops_tab->cnt++;
> =20
>  	return 0;

[ ... ]

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 081d81de18163..a808d2a31f11d 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -355,7 +407,12 @@ static int bpf_cgroup_array_copy_to_user(struct bpf_=
prog_array *array,
>  	for (item =3D array->items; item->prog && i < cnt; item++) {
>  		if (item->prog =3D=3D bpf_cgroup_array_dummy(atype))
>  			continue;
> -		id =3D item->prog->aux->id;
> +
> +		if (cgroup_bpf_is_struct_ops_atype(atype))
> +			id =3D bpf_struct_ops_kdata_map_id(item->kdata);
> +		else
> +			id =3D item->prog->aux->id;
> +
>  		if (copy_to_user(prog_ids + i, &id, sizeof(id)))
>  			return -EFAULT;
>  		i++;

[Severity: High]
This is a pre-existing issue, but does bpf_cgroup_array_copy_to_user()
incorrectly return -ENOSPC when trailing dummy elements exist?

If a cgroup link is detached under memory pressure, it leaves a trailing du=
mmy
sentinel in the array.

When userspace calls bpf_prog_query with an exact-sized buffer, the loop
breaks via "i < cnt" exactly when i =3D=3D cnt, leaving "item" pointing to =
the
dummy element.

Since item->prog is non-NULL (it is the dummy), the function evaluates
"return item->prog ? -ENOSPC : 0;" and erroneously returns -ENOSPC.

This breaks userspace queries, causing userspace tools to continually recei=
ve
-ENOSPC and attempt to allocate larger buffers, eventually exhausting memor=
y.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.3136=
053-1-ameryhung@gmail.com?part=3D9
