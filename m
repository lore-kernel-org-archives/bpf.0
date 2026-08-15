Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E2364038
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781692; cv=none; b=PmWGLLpihYzp82wf0MIGmS4yNkLemkvyIEvMJkrWw9EbS8u1V+oOYVzxML4WnRgptUBsAfJXWgSuH/C6Hg046M4WjEdm5K/8HlOcukxQHqvVJf9skrPaM7HP/MhT6ut9Cm62qTxqA6QSJ6CJ8evSIpwS7OiW+uLesreyag8sv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781692; c=relaxed/simple;
	bh=2Mbb3rqo+7D4eBEitPJ7Dob7q/8LRmkWODUrxF8WWCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aR88kAPGtzZ8oA/i2rzLT/BSAb7CdJFaKpO3R1DzrzBhN47fZya7Qyqpq5Cfpm5t3bb9GnmCt8WJwe4pkBthbowMwSY7aOdogO0GYUelyZRkHPGD1uIo+J+rLWs42clVA5b07+PMlgV/fvHDwsNH2t8yjn6GYYoJleAKhY6F6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBpoQH/m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBpoQH/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B921F000E9;
	Sat, 15 Aug 2026 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781690;
	bh=n2mxxW/MWUA984nBfm8G5nGPaFEQvtnDypLTFn9r/pY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBpoQH/m0Zut5GJbMqtf48lwGm3gub0jUq4gUvyM41HkZ4n/F0qxIYo3VbNKbc5OV
	 pq28ZvBP9hhLINOu9e/M4bqFNFmvTe8+F9GsrswN9I117emwXMHSVjsk+VotapAxaW
	 et5Y+1640BX30gJgJ/3dsHfOzakpn2/TTkVd4HaopuCauuuhUH6b6N+8pApTGR7BJe
	 Gyuh+nJl2X+rRC3h39n4t40x0ufjll5YoZX1uQSSJMabAG7/xV3TBi0BDrgBGFJaSG
	 kekMjvfR+hkEA3AJLmTQaLrCLWmdkzIza9oTltnTs3wj+GsVcotvVoBbGs2hkHtUVD
	 XFudZZ7UwmIEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 04/14] selftests/bpf: Add tests for
 bpf_dynptr_from_skb_ext
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-4-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-4-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:50 +0000
Message-Id: <20260815081450.57B921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] A Use-After-Free (UAF) read/write vulnerability exists because=
 `bpf_dynptr_from_skb_ext` with `BPF_SKB_EXT_F_CREATE` can force a copy-on-=
write (COW) reallocation of `skb->extensions`. This drops the reference to =
the old extension buffer, potentially freeing it. However, the verifier doe=
s not invalidate existing `PTR_TO_MEM` pointers to the old extension buffer=
 obtained via `bpf_dynptr_slice()`, allowing BPF programs to access freed k=
ernel memory.
- [Medium] The new test `test_skb_ext_basic` implicitly uses hardcoded netw=
ork namespace and interface names (`TAP_NETNS` and `TAP_NAME`) by calling t=
he `test_tuntap` helper. This will clash with the existing `test_xdp_contex=
t_tuntap` test when run concurrently via `test_progs -j`.
--

--- Patch [4]: [PATCH net-next 04/14] selftests/bpf: Add tests for bpf_dynp=
tr_from_skb_ext ---
commit 4d32fa867b7073dd6ac590aca746b7f46b659dce
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Add tests for bpf_dynptr_from_skb_ext

Cover the bpf_dynptr_from_skb_ext() kfunc and the dynptr interface
to skb_ext with TC-to-TC tests on a tuntap device:

- write/read via bpf_dynptr_read and bpf_dynptr_write
- write/read via bpf_dynptr_slice and bpf_dynptr_slice_rdwr
- clone read via bpf_dynptr_clone
- error paths: no allocation without F_CREATE, invalid flags, read-only
  enforcement without F_CREATE
- double allocation: data from first alloc survives second skb_ext_add

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 448807676176c..fd340e5538a34 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -693,3 +693,55 @@ void test_xdp_context_lwt_encap(void)
> =20
>  	test_xdp_meta__destroy(skel);
>  }
> +
> +void test_skb_ext_basic(void)
> +{
> +	struct test_xdp_meta *skel =3D NULL;
> +
> +	skel =3D test_xdp_meta__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
> +		return;
> +
> +	if (test__start_subtest("tc_write_read"))
> +		test_tuntap(NULL, /* xdp */

[Severity: Medium]
Might this new test cause a race condition when run concurrently?

The test_tuntap() helper creates a network namespace using a hardcoded
string:

tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c:test_tuntap()=
 {
    ...
	ns =3D netns_new(TAP_NETNS, true);
    ...
}

If test_skb_ext_basic() and other tests like test_xdp_context_tuntap() are
executed in parallel worker processes via test_progs -j, will they clash by
attempting to create and delete the identically named network namespace,
causing spurious test failures?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/te=
sting/selftests/bpf/progs/test_xdp_meta.c
> index 08b03be0b891c..43840ee32d359 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
[ ... ]
> @@ -689,4 +690,188 @@ int helper_skb_change_proto(struct __sk_buff *ctx)
>  	return TC_ACT_SHOT;
>  }
> =20
> +/* Write to skb_ext using bpf_dynptr_write helper */
> +SEC("tc")
> +int tc_skb_ext_write(struct __sk_buff *ctx)
> +{
> +	struct bpf_dynptr meta;
> +
> +	if (!is_test_packet_tc(ctx))
> +		return TC_ACT_SHOT;
> +	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))

[Severity: Critical]
Can the use of BPF_SKB_EXT_F_CREATE lead to a use-after-free regression?

When BPF_SKB_EXT_F_CREATE is used, bpf_dynptr_from_skb_ext() can force a
copy-on-write reallocation of skb->extensions:

net/core/filter.c:bpf_dynptr_from_skb_ext() {
    ...
	ext =3D skb_ext_add(skb, SKB_EXT_BPF);
    ...
}

This drops the reference to the old extension buffer, potentially freeing i=
t.
However, the verifier does not currently treat bpf_dynptr_from_skb_ext() as=
 a
packet-changing kfunc:

kernel/bpf/verifier.c:bpf_is_kfunc_pkt_changing() {
	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_xdp_pull_data];
}

If a BPF program obtains a direct pointer slice to skb->extensions via
bpf_dynptr_slice(), then calls bpf_dynptr_from_skb_ext() with
BPF_SKB_EXT_F_CREATE on a cloned skb, the old extension buffer could be fre=
ed.

Will the verifier fail to invalidate the existing PTR_TO_MEM pointers to the
old extension buffer, allowing the BPF program to access freed kernel memor=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D4
