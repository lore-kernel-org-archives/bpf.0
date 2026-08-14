Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B3335C1BD
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689056; cv=none; b=NIzQLy1Z11h7W4RUdf06gLwQF3hHqEpTdObPdPlpAOrMp/AE5SeZ4e9976h6Obg1kuTzFhCHXHtwJqt1CqruVmSbqyiTIAYI33mV+zF5b8HXs8W7dYpm6hgRppjzUFTFaIc2NmOHpqxOcMcz8tnQm4z9cD5HYAtnRtuyb4gNXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689056; c=relaxed/simple;
	bh=ajESy7Uu1Dm3sS8pTXAkHOcrzRalXc9GtwJP/702nWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NwVY1BqPi0DlQk/IIruT7dUOiUX4bpstPkpPtFXnRHSNWZRhfe7aDkHzqg914wEaxPBFAeozGCVexZleJj+iLPU9dZMzUgQAaaSm4utVvyubP4lnckYsDejnNWNYBgVebDnZDOholUpHxjTE0SMT4LAxb3SjdnhsJk49iM0x27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXWTZINR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXWTZINR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0871C1F000E9;
	Fri, 14 Aug 2026 06:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786689055;
	bh=tHNm+jKpWJ7d2t2yFPxDZaXGo84JWIO37SqWTvFdSgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IXWTZINR85CkQ9yCyz131zR9YXUa/I7uS+j6qGYoHhM82IsJhPQ+AtuyxWgIu6fBC
	 QuRcSPFJDhQCYou7h5MUsXtZoviaeQgH5YbNhO7w8/y8qJoWhY40JvYrz5aPZzHsOo
	 VFpMi6qMssxxpBLs91u1v5qc4YkX2aaxGsKhQcgZskl1lPlFPl7WEi6G9wfS9esQ2n
	 bAkZAEeq9gLeqMk20dTYKZ6LBJ98KLuUlE4tBSFY6Pi/6D6yTJYp9W3a9t8osqO6sp
	 NCUD4Yd3CMthSoC2L6Nd3qU+SAMNSAc8GQp2EeZ+gEiAFwSJT1l0u4+MAYRGwBqg5W
	 117SFc/U+ynug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/5] selftests/xsk: add UMEM users refcount
 and centralize socket teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tushar Vyavahare" <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813062754.360131-2-tushar.vyavahare@intel.com>
References: <20260813062754.360131-1-tushar.vyavahare@intel.com>
 <20260813062754.360131-2-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 06:30:54 +0000
Message-Id: <20260814063055.0871C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Duplicated refcount_t via memcpy breaks shared UMEM ownership, c=
ausing a double-free.
- [Medium] Stack-allocated structs in ifobj_zc_avail() cause a memory leak =
when xsk_umem__delete fails.
--

--- Patch [1]: [PATCH net-next v2 1/5] selftests/xsk: add UMEM users refcou=
nt and centralize socket teardown ---
commit ae6d3807f03b65dcec34132aba330f0371725f42
Author: Tushar Vyavahare <tushar.vyavahare@intel.com>

selftests/xsk: add UMEM users refcount and centralize socket teardown

UMEM ownership is currently implicit, with freeing spread across multiple
error paths, which has led to leaks or use-after-free bugs. This commit
makes ownership explicit by adding a refcount_t users field to struct
xsk_umem_info. It centralizes socket teardown so the last socket to go
away frees the UMEM.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 38ce6060b8fac..d0c2d0efb97f5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -101,6 +101,7 @@ int xsk_configure_umem(struct ifobject *ifobj, struct=
 xsk_umem_info *umem, void
>  		return ret;
> =20
>  	umem->buffer =3D buffer;
> +	refcount_set(&umem->users, 1);

[Severity: Medium]
Will this lead to a double free of the shared UMEM?

In thread_common_ops_tx(), the umem structure is copied using memcpy:

	umem_tx =3D ifobject->xsk_arr[0].umem_real;
	memcpy(umem_tx, umem_rx, sizeof(*umem_tx));

Since this duplicates the new refcount_t users field, the reference count
between the TX and RX UMEM structures is decoupled.

When the test tears down, both TX and RX sockets will independently
decrement their separate UMEM refcounts to zero, causing
xsk_umem__delete() and munmap() to be executed twice on the same pointers.

>  	if (ifobj->shared_umem && ifobj->rx_on) {
>  		umem->base_addr =3D umem_size(umem);
>  		umem->next_buffer =3D umem_size(umem);

[ ... ]

> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/sel=
ftests/bpf/xskxceiver.c
> index 7dad8556a722e..a86eaf141e931 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -117,12 +117,12 @@ static void __exit_with_error(int error, const char=
 *file, const char *func, int
> =20
>  #define exit_with_error(error) __exit_with_error(error, __FILE__, __func=
__, __LINE__)
> =20
> -static bool ifobj_zc_avail(struct ifobject *ifobject)
> +static bool ifobj_zc_avail(struct ifobject *ifobj)
>  {
>  	size_t umem_sz =3D DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE;
>  	int mmap_flags =3D MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> -	struct xsk_socket_info *xsk;
> -	struct xsk_umem_info *umem;
> +	struct xsk_socket_info xsk =3D {};
> +	struct xsk_umem_info umem =3D {};

[Severity: Medium]
Could this result in a memory leak if xsk_umem__delete() fails?

The xsk and umem structures are now allocated on the stack. The new cleanup
logic in xsk_delete_socket() defers cleanup if xsk_umem__delete() fails:

	if (refcount_dec_and_test(&umem->users)) {
		if (umem->umem) {
			int err =3D xsk_umem__delete(umem->umem);
			if (err) {
				...
				/* Keep ownership explicit so a later cleanup pass can retry */
				refcount_set(&umem->users, 1);
				xsk->umem_ref =3D true;
				xsk->umem =3D umem;
				return;
			}

If xsk_umem__delete() returns an error, xsk_delete_socket() returns early
and defers munmap() by leaving state in the structure.=20

Because the structs are stack-allocated, they are destroyed when
ifobj_zc_avail() returns. The deferred retry can never happen, meaning the
mmapped memory is permanently leaked.

>  	bool zc_avail =3D false;
>  	void *bufs;
>  	int ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813062754.3601=
31-1-tushar.vyavahare@intel.com?part=3D1
