Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9A7082D
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781821880; cv=none; b=cmmeg9/Wfypw9bP0H2vFEGtatAz+EY5svlgCn9fHGuFgiji7IWB7025v3bPlXpE8wsGFQhJnFklffLkN1cJx+oCeS3TluJ7NXi/ZlzVAVD2mT0OA2rTHc4ziCsPyAAsJCJVJyyK9k8NWe5oIf7KVvPa7SIVTQezp1BzGsUf1W6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781821880; c=relaxed/simple;
	bh=zzbdkV6CMWC+N+cTSj5yrg8yIhWjp8RmGM6rDjNR+f4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VJsjeSHhGFomNRmsbdGViHtyPDdyPYAXGdSSRe7hQwIVKmoJdBKV+p+2ASibRFMF8zo6f5y0iIF4cdAiwck3QYY+fX09GXbr75uUBdSjzMTHqku7gFAd6RC0a2DCOzVqP4MyjJ0b67l+UydQbynwlm7mCBNqOjgfrbrUf8Duw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMxbYiM4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMxbYiM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4696B1F000E9;
	Thu, 18 Jun 2026 22:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781821879;
	bh=JXHtDWaqr/U2LTwBHyEh/QIDuuTUVNO9J2RJ/ktiq/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kMxbYiM4QXxzmQUpDePfF+yGKT43Ml3Roqx5Ac6tIh2Wb6ztxJcp3TZGq9+SiSsGS
	 quLl8Hna1tmUgZ42MIZ2xPzfEr5nQjQC28hEti1W2G5VclGnoDkULYNxsL53Wq4U//
	 QCdlcX4D3pdj6qP6r4Sthkag9xjN63/eR9XZEfy3auxH2oNmcsb7jzLEHaTMKx+H+n
	 BCr+OMp9B7LZAK9gGHlu2vRbF/vutId6BCqnSUmEO5m6BTsxJuWX2RHOpUsVY0K6gv
	 5yLjYwmOX+bXgTYODN0u2KACRpsvkgrZOALXkG4Yunq0AGA/Oh54t3qI8ZtkAoiNi+
	 eKl+X9NH2SUhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix effective prog replacement with
 BPF_F_PREORDER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618221919.2919512-1-ameryhung@gmail.com>
References: <20260618221919.2919512-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 22:31:18 +0000
Message-Id: <20260618223119.4696B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete fix leaves `purge_effective_progs()` vulnerable to =
an incorrect array index calculation, leading to a Use-After-Free.
--

commit 66001d04979b50f447c6655c1c7db45dc464ee71
Author: Amery Hung <ameryhung@gmail.com>

bpf: Fix effective prog replacement with BPF_F_PREORDER

The patch fixes replace_effective_prog() to handle BPF_F_PREORDER array
indexing. By introducing effective_prog_pos(), it properly replays
compute_effective_progs()'s placement instead of relying on a linear count.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 83ce66296ac19..b12e44ec5d8cb 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -960,22 +1006,10 @@ static void replace_effective_prog(struct cgroup *=
cgrp,
>  		if (percpu_ref_is_zero(&desc->bpf.refcnt))
>  			continue;
> =20
> -		/* find position of link in effective progs array */
> -		for (pos =3D 0, cg =3D desc; cg; cg =3D cgroup_parent(cg)) {
> -			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
> -				continue;
> -
> -			head =3D &cg->bpf.progs[atype];
> -			hlist_for_each_entry(pl, head, node) {
> -				if (!prog_list_prog(pl))
> -					continue;
> -				if (pl->link =3D=3D link)
> -					goto found;
> -				pos++;
> -			}
> -		}
> -found:
> -		BUG_ON(!cg);
>  		pos =3D effective_prog_pos(desc, atype, link);
>  		if (WARN_ON_ONCE(pos < 0))
>  			continue;

[Severity: Critical]
This is a pre-existing issue, but does purge_effective_progs() still
compute the array index using the naive linear increment that was removed
here?

Looking at purge_effective_progs() in kernel/bpf/cgroup.c:

	/* find position of link or prog in effective progs array */
	for (pos =3D 0, cg =3D desc; cg; cg =3D cgroup_parent(cg)) {
		if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
			continue;

		head =3D &cg->bpf.progs[atype];
		hlist_for_each_entry(pl, head, node) {
			if (!prog_list_prog(pl))
				continue;
			if (pl->prog =3D=3D prog && pl->link =3D=3D link)
				goto found;
			pos++;
		}
	}

Since purge_effective_progs() acts as a fallback when
update_effective_progs() fails, could this incorrect array index calculation
lead to a use-after-free?

If bpf_prog_array_delete_safe_at(progs, pos) overwrites the wrong program
slot, __cgroup_bpf_detach() might later call bpf_prog_put() on a program
that is still active in the effective array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618221919.2919=
512-1-ameryhung@gmail.com?part=3D1
