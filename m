Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AE4414
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777830085; cv=none; b=aq9ZbWhvD5fkk/WcQGVI2TAy89w874K9lG+J8zI8eiQGPRlnwptAeDSchsd7BsZDw+0ag/V9j5iJt0wgpwf70PPSTKfiTzJJ0qDDgfv40d/Hmqv3REbk+xQQQtDERAtJE4k6ISQ7d5g8TWrPJuv3azfGdH3dsuNf6BsWtq+J6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777830085; c=relaxed/simple;
	bh=xFU957lW7JQjvH1qtYhVuHleJZ+Qfpg5UFMeJ7fVkGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lw4PjqZyDLIYTfb9n9UpXPhSEZGVDfkAQbERLVhB832y/X16JCSTU5kBoglBIhVIfN8f4S9Nx9kVvH4eppTh47kdlHSTHv/SapAULy32i0U6hX4Qy7wMvQOcA65e5mk5blqQ4PnQK/tiRO4b6so9+g1C7eeZoh/2fFsdRAcu3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur0JwNxx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur0JwNxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C949C2BCB4;
	Sun,  3 May 2026 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777830085;
	bh=xFU957lW7JQjvH1qtYhVuHleJZ+Qfpg5UFMeJ7fVkGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ur0JwNxxuMWL8DYc6gRt7cx1RY7xAVz5ek42YzVoOyQw9o/+o7s+rZXPDjMRAQ7dB
	 rulsbSL3IxKbaDill36DD0Wk+YOmrt0XJqE0OLBZ+Goma7VJDR6rgwwYDwQjwmlxPd
	 sCppmAA5OieCJvfsyW89tyOAVp9yNPvXEfxPzRbHyNlLdcVNwpG6s4vpBUM5Vzs9nm
	 5Po5Uspj5HcTkotEif+DPj9stFojjpNtWtT13i9HLdLIip7T6X9wCzCQvo2/qiL+bj
	 2dsJ0rQmGIlUcUxiRoWo1c9C5LiInOufmffuGvLBEq/K0/Anh4LyESEWMJAyqkbE+q
	 m50/gCWMTgwOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] mm: introduce bpf_mthp_ops struct ops
Reply-To: sashiko@lists.linux.dev
To: "Vernon Yang" <vernon2gm@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503165024.1526680-4-vernon2gm@gmail.com>
References: <20260503165024.1526680-4-vernon2gm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 17:41:24 +0000
Message-Id: <20260503174125.2C949C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Use-After-Free vulnerability in `bpf_mthp_choose()` due to imp=
roper SRCU locking.
- [High] NULL pointer dereference of `link` before validation in `bpf_mthp_=
ops_reg()` and `bpf_mthp_ops_unreg()`.
- [High] Newly created cgroups silently bypass the hierarchical BPF mTHP po=
licy.
- [High] Silent registration failure leaves the cgroup hierarchy in an inco=
nsistent state.
- [Medium] The BPF program can only restrict allowable THP orders, not expa=
nd or select new ones.
- [Low] Compilation failure due to dereferencing an incomplete type and a n=
on-existent struct member.
--

commit e5c9c74b11f76b4de7ba4ef8ff94c10bae978e16
Author: Vernon Yang <yanglincheng@kylinos.cn>

mm: introduce bpf_mthp_ops struct ops

Introducing bpf_mthp_ops enables eBPF programs to register the
mthp_choose callback function via cgroup-ebpf.

> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2949e5acff35..80ec622213df 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
[ ... ]
> @@ -291,6 +292,11 @@ unsigned long thp_vma_allowable_orders(struct vm_are=
a_struct *vma,
>  				       enum tva_type type,
>  				       unsigned long orders)
>  {
> +	/* The eBPF-specified orders overrides which order is selected. */
> +	orders &=3D bpf_mthp_choose(vma->vm_mm, orders);

Does this inadvertently prevent the BPF program from enabling or selecting =
new
orders? Since the return value is applied using a bitwise AND, it appears
restricted to only disabling existing orders rather than customizing them as
described in the commit message.

> +	if (!orders)
> +		return 0;
> +
>  	/*
>  	 * Optimization to check if required orders are enabled early. Only
>  	 * forced collapse ignores sysfs configs.
> diff --git a/mm/bpf_huge_memory.c b/mm/bpf_huge_memory.c
> new file mode 100644
> index 000000000000..e34e0a35edac
> --- /dev/null
> +++ b/mm/bpf_huge_memory.c
[ ... ]
> +unsigned long bpf_mthp_choose(struct mm_struct *mm, unsigned long orders)
> +{
> +	struct cgroup *cgrp;
> +	struct mem_cgroup *memcg;
> +	struct bpf_mthp_ops *ops;
> +	int idx;
> +
> +	memcg =3D get_mem_cgroup_from_mm(mm);
> +	if (!memcg)
> +		return orders;
> +
> +	cgrp =3D memcg->css.cgroup;
> +	ops =3D READ_ONCE(cgrp->mthp_ops);
> +	if (unlikely(ops)) {
> +		idx =3D srcu_read_lock(&mthp_bpf_srcu);
> +		if (ops->mthp_choose)
> +			orders =3D ops->mthp_choose(cgrp, orders);
> +		srcu_read_unlock(&mthp_bpf_srcu, idx);
> +	}

Could reading cgrp->mthp_ops outside the SRCU critical section lead to a
use-after-free regression?

If a thread is preempted immediately after ops is read:

    ops =3D READ_ONCE(cgrp->mthp_ops);
    <preempted>

Another thread could execute bpf_mthp_ops_unreg(), set the pointer to NULL,
and complete synchronize_srcu(). The original thread would then resume,
acquire the lock, and dereference the freed ops pointer.

> +
> +	mem_cgroup_put(memcg);
> +
> +	return orders;
> +}
[ ... ]
> +static int bpf_mthp_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link =3D (struct bpf_struct_ops_link *)l=
ink;
> +	struct bpf_mthp_ops *ops =3D kdata;
> +	struct cgroup *cgrp =3D st_link->cgroup;

Can this cause a regression if link is passed as NULL? st_link is cast from
link, and st_link->cgroup implicitly dereferences it before the validation
check below.

Additionally, struct bpf_struct_ops_link is defined privately in
kernel/bpf/bpf_struct_ops.c and does not contain a cgroup field. Will this
cause a compilation failure due to dereferencing an incomplete type and a
non-existent struct member?

> +	struct cgroup_subsys_state *pos;
> +
> +	/* The link is not yet fully initialized, but cgroup should be set */
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	cgroup_lock();
> +	css_for_each_descendant_pre(pos, &cgrp->self) {
> +		struct cgroup *child =3D pos->cgroup;
> +
> +		if (READ_ONCE(child->mthp_ops)) {
> +			/* TODO
> +			 * Do not destroy the cgroup hierarchy property.
> +			 * If an eBPF program already exists in the sub-cgroup,
> +			 * trigger an error and clear the already set
> +			 * bpf_mthp_ops data.
> +			 */
> +			continue;

Is it intentional to return 0 at the end of this function when we skip over
descendants that already have mthp_ops configured? This appears to leave the
hierarchy in an inconsistent state while userspace assumes the registration
was fully successful.

Furthermore, is there a missing hook in the cgroup creation path? Since this
loop only applies to existing descendants, any newly created cgroups will
have their mthp_ops field initialized to NULL, allowing tasks moved there to
silently bypass the BPF program attached to their ancestors.

> +		}
> +		WRITE_ONCE(child->mthp_ops, ops);
> +	}
> +	cgroup_unlock();
> +
> +	return 0;
> +}
> +
> +static void bpf_mthp_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link =3D (struct bpf_struct_ops_link *)l=
ink;
> +	struct bpf_mthp_ops *ops =3D kdata;
> +	struct cgroup *cgrp =3D st_link->cgroup;

Does this code similarly dereference link before it can be validated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503165024.1526=
680-1-vernon2gm@gmail.com?part=3D3
