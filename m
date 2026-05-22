Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA47394E80
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468958; cv=none; b=sTgWQw3TAUXOdXES+2cQrb0Efe/QUAHNrptVT50R8g+JLWA/nNtFk/7uI/JDfnMOhrmVX3yEDIprtNMBHrqzJkBnV5miovUQKxzdm5JhlKV35LchitAXgU3Zuf1D8QjgNlE9/e4aKBIsfkxLHCnovetlG/S1b+yvHLOINZ6FvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468958; c=relaxed/simple;
	bh=BNs/kQ3D6p9wr54RydtHF6/T+lbc2mWf5pFC0YObKHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t9/B/EvP34/xmYymN4seih75+/2ckc4WsUsoA85qes501oCxlyROklZ0ewapfOW2MnUtCLS/IRNLoA9So+7HFv+1nxc4GTl+6x5achyilGNAlR6S5LudyeZeFghyKZM/YrmQSyp2FQoJa7uA7/8d3kIWYCgUrL3+2giDILg+I0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRJpkrd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRJpkrd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528C71F000E9;
	Fri, 22 May 2026 16:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468956;
	bh=Ayj34Z/QHiLpxj5bVYhLWRNjV/dZ3xl/BAu9iqx8PDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MRJpkrd+P7s69owa0KFKeU3GDQyPMBKH0qG0cQlIC6WCoNBzOG/zN+8nWE7vHEtce
	 bF/kHfXBPcKaEVZXaAO9kpq2szpGN7JjXQyViUFim1F5zbLvxWhnl5A3YZ+dTCbGO8
	 0zkRcbaAHs25K++lynpKGWfBI7uTxQmZYe3B7sGo5ruzyqeXjGqvIgCIIrEtbkasoS
	 QtfX7ooFiS8Fu1/AuxAKhiK+BhpsNTwcBOjMSo+VIpC6BzMpbZ2/gERO7ixhPGHXvr
	 zJobgOCKYxgwKfRJG3Z9gUYiDnCKdh9EONMJGvv/b16Xvhb/LiamAcpDkRU3k6TEUG
	 /SLv7WYezMO2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Fix preorder-unaware index in
 replace_effective_prog and purge_effective_progs replace_effective_prog()
 and purge_effective_progs() compute the target index in the effective
 program array by sequentially walking the hlist (pos++).  However, since
 commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs"),
 compute_effective_progs() partitions the effective array: preorder programs
 occupy indices 0..preorder_cnt-1 and normal programs occupy indices
 preorder_cnt..end.  The sequential hlist walk does not account for this
 partitioning, so when BPF_F_PREORDER programs coexist with normal programs
 the computed index diverges from the actual position in the effective
 array. In replace_effective_prog() this causes BPF_LINK_UPDATE to overwrite
 the wrong slot: the freed program pointer remains in the correct slot while
 an unrelated neighbor is clobbered. Fix both functions by searching the
 effective array directly for the target program pointer instead of
 computing an index from the hlist. This is correct regardless of array
 layout since it matches by pointer identity.  For purge_effective_progs(),
 resolve the effective prog from the link when the direct prog pointer is
 NULL (link-based detach path). Fixes: 4b82b181a26c ("bpf: Allow
 pre-ordering for bpf cgroup progs") Signed-off-by: Himanshu Anand
 <anand.himanshu17@gmail.com>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Anand" <anand.himanshu17@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522162248.55586-1-anand.himanshu17@gmail.com>
References: <20260522162248.55586-1-anand.himanshu17@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 16:55:55 +0000
Message-Id: <20260522165556.528C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Replacing or purging BPF programs by direct pointer comparison in =
the effective array incorrectly targets the wrong program when the same `bp=
f_prog` is attached multiple times.
- [High] `purge_effective_progs()` passes an absolute array index to `bpf_p=
rog_array_delete_safe_at()`, which requires a logical index.
- [Low] Multi-line comments do not follow the mandatory BPF subsystem comme=
nt style.
--

commit 3ec87c2281e918de9e836230ea5c1ffd6604e516
Author: Himanshu Anand <anand.himanshu17@gmail.com>

bpf: Fix preorder-unaware index in replace_effective_prog and purge_effecti=
ve_progs

This patch modifies replace_effective_prog() and purge_effective_progs() to
use direct pointer comparison instead of sequential index computation when
locating target BPF programs in the effective array. This is done to correc=
tly
handle the partitioning of preorder and normal programs introduced in a
previous commit.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b61..437e1e873bf8e 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -923,15 +923,12 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,

[ ... ]

> -found:
> -		BUG_ON(!cg);
> +		/* find the old prog in effective array by direct pointer
> +		 * comparison, since compute_effective_progs() partitions
> +		 * the array (preorder progs first) and the hlist walk
> +		 * order does not match the effective array order.
> +		 */

[Severity: Low]
This isn't a bug, but multi-line comments in the BPF subsystem should have =
the
opening /* on its own line.

>  		progs =3D rcu_dereference_protected(
>  				desc->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
> -		item =3D &progs->items[pos];
> -		WRITE_ONCE(item->prog, link->link.prog);
> +		for (item =3D &progs->items[0]; item->prog; item++) {
> +			if (item->prog =3D=3D old_prog) {
> +				WRITE_ONCE(item->prog, link->link.prog);
> +				break;
> +			}
> +		}

[Severity: High]
Can this overwrite the wrong program slot if the same BPF program is attach=
ed
multiple times in the cgroup hierarchy?

The BPF link API allows the same program to be attached multiple times (sin=
ce
find_attach_entry() skips duplicate checks for link-based attachments), whi=
ch
means item->prog could have duplicate pointers in the effective array.

A linear search might match the first occurrence belonging to an entirely
different link, associating the remaining programs with the wrong
cgroup_storage or bpf_cookie.

>  	}
>  }

[ ... ]

> @@ -1078,11 +1068,9 @@ static void purge_effective_progs(struct cgroup *c=
grp, struct bpf_prog *prog,
>  				  struct bpf_cgroup_link *link,
>  				  enum cgroup_bpf_attach_type atype)
>  {

[ ... ]

> -		/* no link or prog match, skip the cgroup of this layer */
> -		continue;
> -found:
> +		/* find the prog in the effective array by direct pointer
> +		 * comparison instead of computing index from hlist walk,
> +		 * since compute_effective_progs() partitions the array.
> +		 * Use target_prog which resolves link->link.prog for
> +		 * link-based entries where prog is NULL.
> +		 */

[Severity: Low]
This isn't a bug, but multi-line comments in the BPF subsystem should have =
the
opening /* on its own line.

>  		progs =3D rcu_dereference_protected(
>  				desc->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
> =20
> +		for (pos =3D 0; progs->items[pos].prog; pos++) {
> +			if (progs->items[pos].prog =3D=3D target_prog)
> +				break;
> +		}
> +
> +		if (!progs->items[pos].prog)
> +			continue;
> +
>  		/* Remove the program from the array */
>  		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
>  			  "Failed to purge a prog from array at index %d", pos);

[Severity: High]
Does this pass an absolute index to bpf_prog_array_delete_safe_at() when it
expects a logical index?

The loop computes pos as an absolute index by walking progs->items, includi=
ng
any dummy programs. However, bpf_prog_array_delete_safe_at() passes the ind=
ex
to bpf_prog_array_update_at(), which explicitly skips dummy programs, treat=
ing
the index as logical.

If the array contains dummy programs from previous fallback purges, could t=
he
absolute index exceed the logical index and cause bpf_prog_array_update_at()
to overshoot the target and return -ENOENT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522162248.5558=
6-1-anand.himanshu17@gmail.com?part=3D1
