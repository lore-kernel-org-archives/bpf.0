Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA92B175A8A
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001871; cv=none; b=ktORNL/gu2HgCT2/3cUmUqCVuN/yzC1Kz16QITBCwS/bFfUHv76nGOFHdRSQgt31BUwHYQc0UHNuheA/wwlDPB71xK3O6HAgbDV4/t3tvjzsk++m59GX7+JNcliFO24gyzpM7Pu81e2F1rB+j0z1wwxf/SpDQU364tPFT6nRv4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001871; c=relaxed/simple;
	bh=pN7OxqKd1nt3cs3dfJoJdDtSUTpPLtUJiv8W7ySThHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aEHzzhzI6GnNbb/Oi/P9T4N991vng1q1BAaeS6B5VhMyG1Guy+6/36GdarWsMreVfzxyOwEOfnTLBQF+gv5AUed2/TecLmW9uK/zfNkroxzAu8Flhi8Z/nckdMEpwS7p3XKmyWQOE//pl/p4Qfh/Vp+dx62QI+xXz7pvgSWCRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTaV42Wv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTaV42Wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B00C19425;
	Fri, 24 Apr 2026 03:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777001871;
	bh=pN7OxqKd1nt3cs3dfJoJdDtSUTpPLtUJiv8W7ySThHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZTaV42WvIQsEO4pTppbOBMPgJRrVc0FeOgecGIHM6+x6gslgmpEs2r/UDxV3JpT9l
	 utuYDslpYnhiJPRLP0WPE3nDAKL+sJrbwu92IlOjQWq7WogwuASeSdCUvwYKvRmJjw
	 7edhM3GkH28K5TXQ1IPR5Ih28+jt5PWxrqdDDhKb2e6KVYXbDFB0PtL6a0RQhl4nbc
	 juDJxbSkJdi3GHyBE5rSAuRyO6KsMEOqSBZQzxwJRNBSGEUOpuCRIQ6nSr4ePfyins
	 ClnNMI7ee5tV4JtPbU+NzpYmwcTYx7lNK5RqczNiQRjBBUnS4TT5lce5GA0KorVGyF
	 536sDyAsHemCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, tcx: reject offloaded programs on attach
Reply-To: sashiko@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260423033609.252464-2-jiayuan.chen@linux.dev>
References: <20260423033609.252464-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 03:37:50 +0000
Message-Id: <20260424033751.61B00C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Incomplete fix: Offloaded programs can still be attached to softwa=
re paths via BPF_LINK_UPDATE
- [High] Missing device-bound validation in TCX and Netkit attach paths
--

commit ea2bbf8a59b47b06842fc8c920b0debcc1bed553
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, tcx: reject offloaded programs on attach
   =20
An offloaded prog's bpf_func is replaced by bpf_prog_warn_on_exec(),
since it's supposed to run on the NIC, not the host. But tcx doesn't
check this and happily attaches it to the software path, so the first
packet hits the WARN.

Closes: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@hu=
st.edu.cn/

> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
> index 02db0113b8e7c..86f4636d5a677 100644
> --- a/kernel/bpf/tcx.c
> +++ b/kernel/bpf/tcx.c
> @@ -16,6 +16,9 @@ int tcx_prog_attach(const union bpf_attr *attr, struct =
bpf_prog *prog)
>  	struct net_device *dev;
>  	int ret;
> =20
> +	if (bpf_prog_is_offloaded(prog->aux))
> +		return -EINVAL;
> +

The commit message mentions using bpf_prog_is_offloaded() instead of
bpf_prog_is_dev_bound() so that dev-bound-only programs keep working for TCX
and Netkit.

XDP validates device matching in dev_xdp_attach():

    if (bpf_prog_is_dev_bound(new_prog->aux) &&
        !bpf_offload_dev_match(new_prog, dev)) {
        ...
    }

The kernel relies on attach-time validation to guarantee safety for hardware
metadata kfuncs, as documented in bpf_dev_bound_resolve_kfunc():

"We rely on bpf_dev_bound_match() check at attach to render this program
unusable"

If a program is device-bound, shouldn't we still verify it is being attached
to the correct device?

Without a similar bpf_offload_dev_match() check here in the TCX and Netkit
attach paths, could a user attach a program bound to device A onto device B?

Could this cause driver-specific kfuncs to execute on device B's SKBs while
blindly assuming device A's internal data layout, leading to out-of-bounds
memory accesses and kernel panics?

>  	rtnl_lock();
>  	dev =3D __dev_get_by_index(net, attr->target_ifindex);

[ ... ]

> @@ -315,6 +318,9 @@ int tcx_link_attach(const union bpf_attr *attr, struc=
t bpf_prog *prog)
>  	struct tcx_link *tcx;
>  	int ret;
> =20
> +	if (bpf_prog_is_offloaded(prog->aux))
> +		return -EINVAL;
> +

While this prevents offloaded programs from being attached initially, do
we need to protect the link update paths against this regression as well?

It appears tcx_link_update() and netkit_link_update() pass the new program
directly to bpf_mprog_attach() without validating its offload status:

kernel/bpf/tcx.c:tcx_link_update() {
    ...
    ret =3D bpf_mprog_attach(entry, &entry_new, nprog, oprog, NULL,
                           link->flags, 0, 0);
    ...
}

If a user creates a valid link with a standard program, could they use
BPF_LINK_UPDATE to replace it with an offloaded program?

Similarly, does bpf_xdp_link_update() lack the bpf_prog_is_offloaded() check
present in dev_xdp_attach(), allowing it to install an offloaded program in=
to
an SKB or native mode XDP link?

If an offloaded program is attached via these update paths, its bpf_func is
replaced by bpf_prog_warn_on_exec().

Would executing this on the host datapath trigger the WARN(1) panic this
patch intended to fix, potentially allowing a local DoS if panic_on_warn
is set?

>  	rtnl_lock();
>  	dev =3D __dev_get_by_index(net, attr->link_create.target_ifindex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423033609.2524=
64-1-jiayuan.chen@linux.dev?part=3D1
