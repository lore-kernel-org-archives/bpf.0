Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BB5474F
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787194066; cv=none; b=cHdUXbRvM3VHzC5Cn6pQZ+Np38cef2q4JfwsxX7D0bIVu1P43dVpkV6LS2e5ELXg6Ga/NIV7xERgWnrw/feT4djgc0vnunWUqrjzJ85aesgBFqXdBiSTIrvCLcC3iO3DsjM6wgKD+IUKbxZ6ux2YLItwPrMhg5+tql2XjmmvbvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787194066; c=relaxed/simple;
	bh=fYdPbrkuYbMb9+FM3rd/5UbcokKpgrUu58OGyFkoIUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DNY//tt++78ScOZJpTs3tJ8Ni2vJEqXw7PlVw2ySh+5tSKgHFYRSpM2pIgwf3b9g43rYrqRaYFZm1ps86g8BCxwizikK/FJAJPKaK+FPZC/SaJAFuD9jtqgQalpPvF+D9vbC5//zK2bQVcaQy15us9i6WeDT0N8/wHrspCLkBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onsl8R9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onsl8R9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FC81F000E9;
	Thu, 20 Aug 2026 02:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787194065;
	bh=TcBkB1JS2XnvDsHqejMZYnMqkq9mcPQ+Mris4tr4aow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Onsl8R9RZwFEWPXq0Fy6hgkWH+ObOtVp+yOEfOlm+gVcLckV33gMx7SUC4eQDGyG6
	 8JAjM3i2t3cVl3qkHqFuWKnG9wz6aLlrr8GknWFENxD+bKHy0E8NRkCCMqtyo1miJb
	 HluJIgBAQlMqMPQfvvnNUGvNmoxEYAobvEDxhlJxTQ2zIxDLxzCw/O3JLfT/BK5kLv
	 /U9lXHGECEIyQ7+ilS+aD5GH8jPumWShkIj5l/9zQJ2nPTfd7Ia0LRHQ/08p1mrIN0
	 ZzwOHa8Uzeai+IP8mBvVRWUWQR1na5L7YMsu2BGFjnNdz8nGkgvooK1n6SUVMjyYOU
	 0byiQ+7f9we7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/4] selftests/xsk: add UMEM users refcount
 and centralize socket teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tushar Vyavahare" <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819024443.781764-2-tushar.vyavahare@intel.com>
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
 <20260819024443.781764-2-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 02:47:44 +0000
Message-Id: <20260820024745.07FC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Shared UMEM TX sockets fail to create due to partial UMEM view l=
acking the libbpf UMEM handle.
--

--- Patch [1]: [PATCH net-next v3 1/4] selftests/xsk: add UMEM users refcou=
nt and centralize socket teardown ---
commit ec175a3b2fa035fe1d6886d51e8d51aa7aaf1d62
Author: Tushar Vyavahare <tushar.vyavahare@intel.com>

selftests/xsk: add UMEM users refcount and centralize socket teardown

This commit adds a reference count to xsk_umem_info to track shared UMEM
ownership and centralizes the teardown path to ensure sockets clean up
properly across all error paths.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 38ce6060b8fac..fbec8afaadc99 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -1508,8 +1529,15 @@ static int thread_common_ops_tx(struct test_spec *=
test, struct ifobject *ifobjec
>  	}
> =20
>  	umem_rx =3D test->ifobj_rx->xsk_arr[0].umem;
> +	/* Non-owning view used only for TX buffer arithmetic; the sockets belo=
w bind to
> +	 * the RX-owned UMEM, so the handle, cq and refcount stay in one place.
> +	 */
>  	umem_tx =3D ifobject->xsk_arr[0].umem_real;
> -	memcpy(umem_tx, umem_rx, sizeof(*umem_tx));
> +	umem_tx->num_frames =3D umem_rx->num_frames;
> +	umem_tx->frame_headroom =3D umem_rx->frame_headroom;
> +	umem_tx->buffer =3D umem_rx->buffer;
> +	umem_tx->frame_size =3D umem_rx->frame_size;
> +	umem_tx->unaligned_mode =3D umem_rx->unaligned_mode;
>  	umem_tx->base_addr =3D 0;
>  	umem_tx->next_buffer =3D 0;

[Severity: Medium]
Will this cause shared UMEM TX sockets to fail creation because the libbpf
UMEM handle is not copied over?

Since umem_tx is now constructed manually instead of using memcpy(), the
umem_tx->umem field is left NULL. When xsk_configure_socket() is called lat=
er
in thread_common_ops_tx(), it passes this NULL umem->umem pointer to
xsk_socket__create(), which causes it to fail.

Also, does leaving the users refcount zero-initialized on this umem_tx view
conflict with the stated goal of keeping shared sockets pointing to the same
reference count?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819024443.7817=
64-1-tushar.vyavahare@intel.com?part=3D1
