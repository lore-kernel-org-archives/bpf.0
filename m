Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A13845B0
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 06:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910050; cv=none; b=ohJrtVgHN3+q7/Rt0kFrY6sOqgI4Y5+mgD4PmX6yghhopo5NxsgNwOFatx2eaZU+4drNsayU6FQpADuftIM7S33odZLBd0Kltk3fzULEcJQqbXWbcLDHn3maeY6k4emu2S0VBrndi2CkLcQ+kziGXztkUgn0ul9MN6Rr1fdfAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910050; c=relaxed/simple;
	bh=L0atkMpBU/Vwjgksb/Ro5TZG60S5Z6IHXOQ82u70Xc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jvXeVAE4ntzzZ/vv+QeJKGTlw+bE2OettNWiKHUTxV3urSGcjGHvub0romWCAR8MCZ0Iv5B9qSQG3kwcgzXixbIKXTnfZhWIJbSjq+235NgnfufjU6aoE9+kM4HzwdEs0nMly28jkLvVfb6C3F4295jIvSJqLLr/MZ/ZzCz5JmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNfwULNC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNfwULNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2411F000E9;
	Wed,  5 Aug 2026 06:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910049;
	bh=MKHvBHq9VgXDr5ZnBCOuuLU+rU1z8yOUzgcKvmiqsQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nNfwULNCWCJjt8ZwhlWGk848RguxWxgpnXQHLNxNqR7TaQmGqbmHM2alT9dP0LKrK
	 FAjmagv5MIChZ9NmTr6v0gWl+VP/IEfcB7r2NYYFdWzcFaOCt4ipwHT1ci/cy7nUVw
	 aFy/QNZJz/r1jm40hfw+ZjKdHpojeqnVLaqTueONRMWI2auuNvuzcahEGbubXwSDte
	 arZmsgrVngQSiUVPv/db1BOBuZWgqDO9pf42/5LkwUfeNqES79ECJQ6jEhfYQFtTUf
	 jAGX/rXU+gxjlj2mtfE1ml6989vVOOR8M+1UuWqzW7o30FeTnBDoutz4KtBz9THVfo
	 MHFGhm0YvBD6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Fix stack out-of-bounds write in cgroup
 link update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanghyun Park" <sanghyun.park.cnu@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805052858.2390918-3-sanghyun.park.cnu@gmail.com>
References: <20260805052858.2390918-3-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:07:27 +0000
Message-Id: <20260805060728.4E2411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch selectively limits the `expected_attach_type` mismat=
ch check to `BPF_PROG_TYPE_CGROUP_SOCK_ADDR`. This leaves `BPF_PROG_TYPE_CG=
ROUP_SOCKOPT` unrestricted, allowing an attach type mismatch that leads to =
a verifier bounds tracking bypass and a NULL pointer dereference, which can=
 be exploited for Local Privilege Escalation (LPE) or to cause a kernel pan=
ic.
--

--- Patch [1]: [PATCH bpf-next] bpf: Fix stack out-of-bounds write in cgrou=
p link update ---
commit 842ffd1efbee299eada62f99bf59a538fc141873
Author: Sanghyun Park <sanghyun.park.cnu@gmail.com>

bpf: Fix stack out-of-bounds write in cgroup link update

This commit limits the expected_attach_type check during cgroup link
updates to BPF_PROG_TYPE_CGROUP_SOCK_ADDR programs. This aims to fix
an out-of-bounds write while leaving update policies for other cgroup
program types unchanged.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index d2da5063d8f81..65bf25deac4f1 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1055,6 +1055,10 @@ static int __cgroup_bpf_replace(struct cgroup *cgr=
p,
>  	if (link->link.prog->type !=3D new_prog->type)
>  		return -EINVAL;
> =20
> +	if (new_prog->type =3D=3D BPF_PROG_TYPE_CGROUP_SOCK_ADDR &&
> +	    link->link.attach_type !=3D new_prog->expected_attach_type)
> +		return -EINVAL;
> +

[Severity: Critical]
This is a pre-existing issue, but by explicitly restricting this check to
BPF_PROG_TYPE_CGROUP_SOCK_ADDR, does it allow BPF_PROG_TYPE_CGROUP_SOCKOPT
replacements to completely bypass attach_type validation?

If a user loads a BPF_PROG_TYPE_CGROUP_SOCKOPT program with an expected
type of BPF_CGROUP_GETSOCKOPT and another with BPF_CGROUP_SETSOCKOPT, could
they use bpf_link_update to replace a GETSOCKOPT link with the SETSOCKOPT
program?

The verifier expects bpf_get_retval() to return [-MAX_ERRNO, 0] for
SETSOCKOPT programs. If attached to a GETSOCKOPT link, could another program
on the hook set a positive retval, allowing the mismatched program to read
this value and bypass verifier bounds tracking?

Additionally, if a GETSOCKOPT program runs on a SETSOCKOPT hook, it maps
the return value to a dereference of ctx->current_task:

kernel/bpf/cgroup.c:cg_sockopt_convert_ctx_access() {
    ...
    *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, curre=
nt_task),
                          si->dst_reg, si->src_reg,
                          offsetof(struct bpf_sockopt_kern, current_task));
    *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct task_struct, bpf_ctx),
                          si->dst_reg, si->dst_reg,
                          offsetof(struct task_struct, bpf_ctx));
    ...
}

Since current_task is not initialized in=20
__cgroup_bpf_run_filter_setsockopt(), would this result in a NULL pointer
dereference when accessing current_task->bpf_ctx?

>  	hlist_for_each_entry(pl, progs, node) {
>  		if (pl->link =3D=3D link) {
>  			found =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805052858.2390=
918-3-sanghyun.park.cnu@gmail.com?part=3D1
