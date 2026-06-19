Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC363221D89
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781851586; cv=none; b=UoREnHgxb9kL5OgieL9x+xUYV0x6Qz46QijvwLHV/LBE7lKYeAlgaWi5MHzCRuSsduONPApVfuX7Z9hTtkxcFLanOjXObN1kGTs5gLeMGwjEGZfzFlnnt0Qr+yn9JpNLbCIUZ6NL0NeqdDOd8RRrkwTEsEy2ZAnBOgXK50IQclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781851586; c=relaxed/simple;
	bh=1UPR8XVZA24E4kuqGgMUHQM0nJnduAPjvH3duicUoSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t1B/XN3zWEDbDpgIeKgvyZES372b/CK5KofCnIpFFSdFySxHquYoQmVUlpAOvNmRVcwdrOZYTRMNRIdSPnB5L972zRfm3hoojgbhJ678RdXOgKYyQEa58bLt69fuNuOsoCAFbOgXldGVfEhYcwaB8fnKCz6LAfCZD16tO67OVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpX28YMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpX28YMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545CE1F000E9;
	Fri, 19 Jun 2026 06:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781851585;
	bh=laz9YaWPOVRhY+no+0W67KehZ/G8Eg+nS/bcsWOvp+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EpX28YMxlaaK9YtxfFZPedIEFxeT4Ms1laHogul2cmMAidxH2GEqFR8JpdVRP2Xbd
	 tCPOslanAEorRtmN9Qs6mybHQRHqe8C/xISEd1gzEjgKl94lj3oW1bN5VCTpt0umHP
	 8nB3FbW79PhhsqtFMlW0WbFLp981Eo5ub1PkjR5H7SrVk6u1RcV/6AmTmBdlj5SVWX
	 VzKKyIc5H3R+Vq9UmOXYiFomZf6K204G1nTRj43yJBX7HVLZRJ+Yy/8zpUW/cDxCNQ
	 eeGf04HOBZuA5kRlzKBq2XNHk3u0CvF/Q93UYsoVBgYXR3jM/2bgwLuDdOAuIUU47t
	 mAPfeVj9tR3xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix effective prog array index with
 BPF_F_PREORDER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619063520.2690547-2-ameryhung@gmail.com>
References: <20260619063520.2690547-1-ameryhung@gmail.com>
 <20260619063520.2690547-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 06:46:24 +0000
Message-Id: <20260619064625.545CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but replace_effe=
ctive_prog() erroneously uses the logical index returned by effective_prog_=
pos() as a direct physical index into the effective BPF program array. If p=
revious detach operations failed to reallocate the array and left dummy_bpf=
_prog elements in place, the physical index does not match the logical inde=
x. This causes bpf_link_update() to overwrite the wrong program slot (e.g.,=
 the dummy) leaving the original program untouched in the active array whil=
e its reference is dropped by __cgroup_bpf_replace(). Once the RCU grace pe=
riod expires, this leads to a Use-After-Free when the kernel executes the f=
reed program.
--

commit f837441f68b1fdb520696422a141ec421e2d50ae
Author: Amery Hung <ameryhung@gmail.com>

bpf: Fix effective prog array index with BPF_F_PREORDER

This commit introduces a shared helper effective_prog_pos() to accurately
determine a program's position in the effective array by replaying the
placement logic. This fixes an issue where preorder programs caused
replace_effective_prog() and purge_effective_progs() to access incorrect
slots, corrupting the array or causing a use-after-free.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 83ce66296ac19..4355ccb78a9c6 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -960,27 +1006,15 @@ static void replace_effective_prog(struct cgroup *=
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
> +		pos =3D effective_prog_pos(desc, atype, pl);
> +		if (WARN_ON_ONCE(pos < 0))
> +			continue;
> =20
>  		progs =3D rcu_dereference_protected(
>  				desc->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
>  		item =3D &progs->items[pos];
> -		WRITE_ONCE(item->prog, link->link.prog);
> +		WRITE_ONCE(item->prog, pl->link->link.prog);

[Severity: Critical]
This isn't a bug introduced by this patch, but does replace_effective_prog()
erroneously use the logical index returned by effective_prog_pos() as a dir=
ect
physical index into the effective BPF program array?

If previous detach operations failed to reallocate the array and left
dummy_bpf_prog elements in place, the physical index would not match the
logical index. This could cause bpf_link_update() to overwrite the wrong
program slot (e.g., the dummy), leaving the original program untouched in t=
he
active array while its reference is dropped by __cgroup_bpf_replace().

Once the RCU grace period expires, could this lead to a Use-After-Free when
the kernel executes the freed program? Should this instead use
bpf_prog_array_update_at(progs, pos, pl->link->link.prog) to correctly hand=
le
the presence of dummy programs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619063520.2690=
547-1-ameryhung@gmail.com?part=3D1
