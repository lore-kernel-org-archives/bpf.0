Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80598324B33
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452463; cv=none; b=K1rviqIfFKmklTdUtIXJZECUuoa2BtV7Lk7kfpUiFU9F9fD/RRAxTHCmWlgosa0NhDxeQVwDu5cVYpT7jOfRbxkTn2j/12s5ZO0LM4ZgIaYzwulW6lxlszMjH6Ac9ZUWf+BgpTk1MxvCjU2CnQOES750k0ka6N7cEo7QYunIYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452463; c=relaxed/simple;
	bh=pBdwXTVLrK0oFQD6bArWR5dRqCiEOTRuDCX6+n2Z/GE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b/q2ktLRiNyYtd/qad7FV/QR1tyZwdxKh7qIv7lh590BZ3t/Dmz7LHJ9KVAQQEyVqlyds2S0uKjjdIvus2aBifClvrNuF1bo9f5wqHpE+97aLjNVDLR4f2sTWROOnXb3VjSrKDlq5+TMai8GMmL72F8RqnEMBS9mP0Lb5jji47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Trg9Cb7j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Trg9Cb7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F87C19425;
	Wed, 29 Apr 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777452463;
	bh=pBdwXTVLrK0oFQD6bArWR5dRqCiEOTRuDCX6+n2Z/GE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Trg9Cb7jOw1h+y+oQPv0rr0JNtzYbISI34h7gXc696AR7jpY+xZU6hSEdt6xLQbEe
	 jxV+HDFyNp6jIe/+9YHXTBmfZOtEU54sH3yCVyWE+hrxQvaYGxpD9CFLKN4AMPGBAk
	 n9OP3wc9vdYGJpD6xrpnIk7B1JmnRewBZQkdIMdl9GBqWu+0Y5bnc3rRWZn702VPQB
	 axFwD1jl/woQL/VygDPc5rMjPeavaexgva/WFrZyzqBlJujcI2Wv+KeaHEqQv+z/Mz
	 P/wJaRpx1SPQiC1gG8Xc9MGSlkUVDPBwMDqQ/f8b7r9IOobvQ6MDjEVsxngFVrWorO
	 3/xL9swIe9oHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] selftests/xsk: Use umem_size() helper consistently
Reply-To: sashiko@lists.linux.dev
To: "Tushar Vyavahare" <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428080317.702124-5-tushar.vyavahare@intel.com>
References: <20260428080317.702124-5-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 08:47:42 +0000
Message-Id: <20260429084743.22F87C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch misses an open-coded calculation of the UMEM size in `=
testapp_unaligned_inv_desc_4001_frame()`, failing to fulfill the commit mes=
sage's claim.
--

commit 55b162869fca46ad80bf9c4d74237ed3830d1f8e
Author: Tushar Vyavahare <tushar.vyavahare@intel.com>

selftests/xsk: Use umem_size() helper consistently

This commit replaces the remaining open-coded calculations of the UMEM
size with the umem_size() helper in test_xsk.c to centralize computation.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index ea229ea446ca..ba4768f83eb6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -1581,7 +1581,7 @@ static int thread_common_ops(struct test_spec *test=
, struct ifobject *ifobject)
>  	int ret;
>  	u32 i;
> =20
> -	umem_sz =3D umem->num_frames * umem->frame_size;
> +	umem_sz =3D umem_size(umem);
>  	mmap_flags =3D MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;

Since open-coded calculations are being replaced here, did this miss the
calculation in testapp_unaligned_inv_desc_4001_frame()?

tools/testing/selftests/bpf/prog_tests/test_xsk.c:testapp_unaligned_inv_des=
c_4001_frame() {
    ...
	page_size =3D sysconf(_SC_PAGESIZE);
	umem_size =3D test->ifobj_tx->xsk->umem->num_frames *
		test->ifobj_tx->xsk->umem->frame_size;
	assert(umem_size % page_size > MIN_PKT_SIZE);
    ...
}

Checking the subsequent patch in the series ('selftests/xsk: Introduce
mmap_size in umem struct'), it appears it does not resolve this missed
calculation either.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428080317.7021=
24-1-tushar.vyavahare@intel.com?part=3D4
