Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6266F324B33
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452464; cv=none; b=Xa6Nwhk6pbLg7XJwQNtdfu+io0jI+nELd2RFDDXIfs/09I9ijfEEpWCBr4kgOnK6Mlak5R8uRwV8M6zZJCLoD9qRwEWYQeW/WFJtJ/50q24Zpl7sy5aD0jyi8Kdcn2Vsmrp7ILgqP8I6GRcPlS98g4vO5Uvms76DGiMDg2LIB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452464; c=relaxed/simple;
	bh=B4lT78+Ob3GHAqdYMDmsHdEJi21Wzg+dNW40VuzMsho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s3448w46RFp5wvYeu2l6HbtLzDiZQVTrJ6p4UJ2p1mjp/lw+0nPhtu/FFpQOF4+ieDzLXwtOqDdGpdynmZtfgCz9nllfTaoiCjxN1Pm+l+f0DT+S58jWCVeVTikVXuMbZyc8xUKrVKAP0Rxi3k19YpNyxS10Bu5BeLN+6+vmKNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfP5bTBE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfP5bTBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9047C19425;
	Wed, 29 Apr 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777452464;
	bh=B4lT78+Ob3GHAqdYMDmsHdEJi21Wzg+dNW40VuzMsho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EfP5bTBEZkXLZzhYy7evMiJUpEN72CedgeGK2J3gZ19w1j1tfrMKBpnEKXY+0o3nI
	 whiDTN6/aiL1b9tBZWR7P5we68Ef1kQEsaiJuxub6CnpwBVypwPq9RYbdmiq511NHs
	 SHAtj1AKmLRVc9lt0jWHL774rcTnuPZBB4leznrPe8mQkWk0Gu2SJDb+ylevz0m2O3
	 oxUxxx4wRjaYJxKh5T1pNDD6P8PYEo7p3FNYC1Iy3F3ixJVFfiSXY++00lf5Fgakl4
	 xSjM5syNAyV7YV8znDYBmeQsExBop5kBCGpAbd4vV8qmvfO30VVSMy4SFfV9hwfStt
	 L756v7IHVG1Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] selftests/xsk: Introduce mmap_size in umem struct
Reply-To: sashiko@lists.linux.dev
To: "Tushar Vyavahare" <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428080317.702124-6-tushar.vyavahare@intel.com>
References: <20260428080317.702124-6-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 08:47:43 +0000
Message-Id: <20260429084743.E9047C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Meaningful code and commit message mismatch regarding `mmap_size=
` computation, failing to resolve the over-unmapping risk.
--

commit 88aa7962c655c10bde2c97d706550190e3d87126
Author: Tushar Vyavahare <tushar.vyavahare@intel.com>

selftests/xsk: Introduce mmap_size in umem struct

This commit stores the finalized mapping length in xsk_umem_info as mmap_si=
ze
when the UMEM mapping is created. The intent is to use this exact value dur=
ing
teardown instead of recomputing it from the frame geometry.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index ba4768f83eb6..ba1bcfc6b74b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -1594,6 +1594,8 @@ static int thread_common_ops(struct test_spec *test=
, struct ifobject *ifobject)
>  	if (bufs =3D=3D MAP_FAILED)
>  		return -errno;
> =20
> +	umem->mmap_size =3D ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE;
> +
>  	ret =3D xsk_configure_umem(ifobject, umem, bufs, umem_sz);
>  	if (ret)
>  		return ret;

The commit message states that this change "removes duplicated size
arithmetic in cleanup and guarantees that munmap() uses the same canonical
size that was established at setup time."

However, looking earlier in thread_common_ops():

	bufs =3D mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);

The size passed to mmap() is just umem_sz, without the hugepage rounding.

By setting umem->mmap_size to the rounded-up value here, does this still
duplicate the size arithmetic rather than using the exact mapping metadata?

If standard pages are used and umem_sz is not a multiple of HUGEPAGE_SIZE,
could this cause munmap() to use an inflated size and inadvertently unmap
adjacent memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428080317.7021=
24-1-tushar.vyavahare@intel.com?part=3D5
