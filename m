Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5E347BDB
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786196671; cv=none; b=ebcBKWMWv2/Ebv4TXvnLojERoNzuzuf/ITdOyVPLzm+7Wh9fq2bdkzVRzj785NuSWu4QP/gSDdgXsW2mkrgiYsIjBJA91nDjYQQ64L64whTr4GcF7Hp98oajhSmZk5DaQYq1c4WN1hk2fLGyypEWRyXDsgeEHr8TTdJM/EDH0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786196671; c=relaxed/simple;
	bh=tlvqYi1HkdffhLG6FlL+LqcqnTV3Fm5yvNHZ6wYvias=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LrjyHzJ9HM3d8Yy73hjwEwh3s8EiWwly4L9820Lu6Ecj4EYwmUquNl/+LGBaJDPCEjGozt80RvHJ0iNpDcdG7Zs40ZM0Slndhl/wgDxNLQN8Ve3TTFlk8JubyVj9XGSsRpcbSUvOAAuF/ZUsEsaHBoT+kOhSM26/Gg8rwjycwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5BfVFD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5BfVFD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C421F000E9;
	Sat,  8 Aug 2026 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786196670;
	bh=KpFDGuzOZfEBOhhB+3JUxuKTcUqPHJzp5wYCoiskgs4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S5BfVFD2PeXxlJg0kYWo4EZVd2w9mtGG1tJuggSwA8e93rraObTYxvhZTuYFz1UuV
	 Mh+BybCVaEejfXF1bZ8fE8k+4gHmj/D9eIcf5kBNEfrSAgt1pfDKhFIyfF8UuVtX7t
	 TiYjiYO237cpo01W0GSB/jXpDYz/SxDzx8ovUKjy1hqsVmJokXWVX15Zps3uM4GYrP
	 ptcdTuHf6mPCVJPtTg+1g0YUOdWydtgZbldd9OfO/hUpl9BGUXVEfec8X59jr/97St
	 n8ZRSSYqIQrb162LELYJwUgX9tcixN+VDfbJP4tKZNf+KT00Qbol5gUE9cbg7w1U8h
	 AngzV51bS1ItA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/5] selftests/xsk: add UMEM users refcount and
 centralize socket teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tushar Vyavahare" <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260807134209.3794735-2-tushar.vyavahare@intel.com>
References: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
 <20260807134209.3794735-2-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:44:28 +0000
Message-Id: <20260808134429.D6C421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Premature UMEM destruction during batch teardown of partially co=
nfigured socket arrays causes `xsk_umem` file descriptor and memory leaks.
--

--- Patch [1]: [PATCH net-next 1/5] selftests/xsk: add UMEM users refcount =
and centralize socket teardown ---
commit 99dd730a09377ba26c180094a39cc7721ae72648
Author: Tushar Vyavahare <tushar.vyavahare@intel.com>

selftests/xsk: add UMEM users refcount and centralize socket teardown

This commit introduces a reference count for shared UMEM users in the XSK
selftests and centralizes socket teardown in xsk_delete_socket(). It
replaces manual UMEM teardown functions with a unified batch deletion
approach to avoid leaks or double-releases during error handling.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 6eb9096d084c0..43ab61faad024 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -1702,12 +1718,71 @@ void *worker_testapp_validate_rx(void *arg)
>  	pthread_exit(NULL);
>  }
> =20
> -static void testapp_clean_xsk_umem(struct ifobject *ifobj)
> +void xsk_delete_socket(struct xsk_socket_info *xsk)
>  {
> -	struct xsk_umem_info *umem =3D ifobj->xsk->umem;
> +	struct xsk_umem_info *umem;
[ ... ]
> +	/* Always decrement refcount for this socket's UMEM reference */
> +	if (refcount_dec_and_test(&umem->users)) {
> +		if (umem->umem) {
> +			int err =3D xsk_umem__delete(umem->umem);
> +
> +			if (err)
> +				ksft_print_msg("xsk_umem__delete failed: %d (umem still busy?)\n",
> +					       err);
> +		}
> +		if (umem->buffer && umem->mmap_size)
> +			munmap(umem->buffer, umem->mmap_size);
> +		umem->umem =3D NULL;
> +		umem->buffer =3D NULL;
> +		umem->mmap_size =3D 0;
> +	}
> +}
> +
> +static void xsk_delete_socket_batch(struct ifobject *ifobject, u32 count)
> +{
> +	u32 i;
> +
> +	if (!ifobject)
> +		return;
> +
> +	for (i =3D count; i > 0; i--)
> +		xsk_delete_socket(&ifobject->xsk_arr[i - 1]);
> +}

[Severity: Medium]
Could this result in a premature UMEM destruction and a subsequent file
descriptor leak during partial setup failures?

Since xsk->umem is pre-initialized for all array slots in
__test_spec_init(), uninitialized slots will still have a non-NULL
umem pointer.=20

If setup fails halfway through (e.g., enable_busy_poll() fails for i =3D 0 =
in
xsk_configure()), the batch teardown iterates backwards from test->nb_socke=
ts.
When it reaches an uninitialized slot (like i =3D 1), it will see the
pre-initialized umem pointer and decrement the refcount.

If this brings the refcount to 0, it prematurely attempts teardown. Since t=
he
valid socket at i =3D 0 is still active, xsk_umem__delete() returns -EBUSY.
However, the code still proceeds to munmap the buffer and set umem->umem =
=3D NULL.

When the loop finally processes i =3D 0, the refcount is already 0, so it s=
kips
calling xsk_umem__delete() entirely, permanently leaking the UMEM and its
file descriptor.

Is there a way to distinguish between a pre-initialized slot that never too=
k a
reference and a successfully configured slot?

> +
> +static void xsk_delete_all_ifobj_sockets(struct test_spec *test, struct =
ifobject *ifobj)
> +{
> +	if (!ifobj)
> +		return;
> +
> +	xsk_delete_socket_batch(ifobj, test->nb_sockets);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807134209.3794=
735-1-tushar.vyavahare@intel.com?part=3D1
