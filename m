Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C338550C
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434108; cv=none; b=rJ23GhQvUoyi8nLJ0Fkd7itJXPfEHQYqEFBWVWjW0NARxYNncqveki84CavxwObXCHSvyXDoq690ncKVuqZ3H+XF46S4pPxQrZQ/V+J0l/HVTlXKjL/1SEnFuVK9QEgUM/MNZ2usZSiYCKPqfUl1o1w/4oOdoClPCmTxQNzbsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434108; c=relaxed/simple;
	bh=46YxhYB0ua8HpKhHIiUrcnTwuYObYrgeFMVwHq/9JxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p6vyvkvjhi1Yjk6jh+4K/71smKYtcg4N8L949cPAKfcbnay3F4boMRnWImRvWV3L0bWwEfZ7S2QiFYxSuqVgdYaulyf3M15P/LgKeeMFVVVcBEGF91rMnkga0/XWf2qCGrZETO7YOopwllCDV17XedntpNTiy9GIyloteB9fC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j47Jjkrj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j47Jjkrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126711F000E9;
	Sat, 22 Aug 2026 21:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787434107;
	bh=dBpnmi4bUQapNbBxrIdQxcLC4l2KIN5HNyedpa1Zbrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j47JjkrjvU9LD2cccPgpHcX81fa30mhL72r1AY/jCYGE9gYtUORUZbseIzhTPdWUc
	 dRwT4+4/J4tvuG2kJ2y0/jvFz/jg1WGTmaD4Ze3jU19q6y839AmVA8qSk9QePml0ag
	 0xM+TbnKVltIdw6E9mB7uxq2bOYRzFz8kmYOjxM7yjMafZArHGgJyWuMd0MPS+XQQ3
	 nDTsmJ4CzIaUwd5D5DY5JE9gHV/gVL+zQ0i5z6RhFqtrlq5/ag8vU5uMkP2qT1xb1t
	 FJ1sUlikBtZt5mR4bg172DOeC/jRaGnBQ2bYWup2Uj9XdRrUSpMaCLgpjwMXgQHxMv
	 2bwZLA6h9vAbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] netfilter: bpf: disallow conntrack kfuncs for token
 programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260822210945.1003967-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260822210945.1003967-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:28:26 +0000
Message-Id: <20260822212827.126711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Security restriction bypass in `nf_conntrack_kfunc_filter` due to =
unrelocated BTF ID comparison.

Pre-existing issues:
- [High] Token-loaded BPF programs can bypass namespace isolation via `bpf_=
xdp_get_xfrm_state`.
--

--- Patch [1]: [PATCH] netfilter: bpf: disallow conntrack kfuncs for token =
programs ---
commit 392473e378423f74e738047589faa01940a34fa2
Author: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

netfilter: bpf: disallow conntrack kfuncs for token programs

BPF tokens delegate BPF and network-admin capability checks to the token
owning user namespace. Conntrack kfuncs nevertheless accept a network
namespace ID relative to the program context without checking whether the
token has authority over the resolved namespace. This patch adds a filter
to conservatively reject the conntrack kfunc set for token-loaded programs.

> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index c2df7c9482812..4075ee1efa8ef 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -532,9 +532,24 @@ BTF_ID_FLAGS(func, bpf_ct_set_status)
>  BTF_ID_FLAGS(func, bpf_ct_change_status)
>  BTF_KFUNCS_END(nf_ct_kfunc_set)
> =20
> +static int nf_conntrack_kfunc_filter(const struct bpf_prog *prog, u32 kf=
unc_id)
> +{
> +	/*
> +	 * Conntrack kfuncs accept a netns ID relative to the program context.
> +	 * The verifier cannot determine which user namespace owns that target.
> +	 * Do not let a token delegate authority over arbitrary peer netns stat=
e.
> +	 */
> +	if (prog->aux->token &&
> +	    btf_id_set8_contains(&nf_ct_kfunc_set, kfunc_id))

[Severity: High]
Does btf_id_set8_contains() work correctly here when comparing the IDs?

If the kernel is built with distilled base BTF, the statically allocated
nf_ct_kfunc_set array remains unmodified and contains small, unrelocated
IDs. Since the kfunc_id provided by the verifier is a relocated runtime BTF
ID, will this comparison always fail and incorrectly return 0? If so, this
would bypass the intended namespace isolation security fix.

Also, is the btf_id_set8_contains() check necessary? It seems
__btf_kfunc_is_allowed() only invokes the filter for kfuncs that have
already been matched against the module's relocated registered set.

> +		return -EACCES;
> +
> +	return 0;
> +}

[Severity: High]
This is a pre-existing issue, but a similar vulnerability seems to exist in
net/xfrm/xfrm_state_bpf.c for the bpf_xdp_get_xfrm_state kfunc.

net/xfrm/xfrm_state_bpf.c:bpf_xdp_get_xfrm_state() {
    ...
    net =3D get_net_ns_by_id(net, opts->netns_id);
    ...
}

This resolves arbitrary peer network namespaces without validating if the B=
PF
token has authority over them. Since xfrm_state_xdp_kfunc_set lacks a .filt=
er
hook to reject token-loaded programs, can an unprivileged token-loaded XDP
program pass a netns_id to look up and access sensitive struct xfrm_state
objects from the host init_net?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822210945.1003=
967-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1
