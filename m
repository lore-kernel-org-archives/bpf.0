Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792577;
	b=d+SFsoB3guHgNxfUhJILpashx2sN7sxyyCauS2XCUJYEqF69cDJUSVkXhVNXuiTkmgHv
	 QKhe5gXEKZraEzAIIj9tI/Mswhm570wePNRoJCLI3HEu14N4doCAEHGUtx3mm2y2Gx9u0
	 0+dE7cKcRa2sSjpM0w+akFXEZG2912F8Ll1rlSlVfCb2qLTsoZr3Vy2L2BZNluTxtADOJ
	 7/93OxLRApLd0WuV1ald+7zXyTa2GlTonH6ESlui/s+0DjpKRMEBu6y2F5O4wByg1FxUA
	 BqpR3O+uGnEyEco+CKBybcl/eo3JIk2pFV9wnIkPXq1Ri/uReNrn6tpjdY64IDVkZqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792577;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W+D7wI9NSxYwB7FLUJeElN3wPz2OZ57FW2nIA3DB6qs=;
	b=kEY+vw27PP+X81qS2r2rW20MP62amohRcf8ArdGTBa5ccthxUtrizMOQkb/nya+epmaf
	 Gn1dKKcTufUujU3FXuGtviQYRz4KfffjcviguFB2IlffyqqQuLzXikY+IrGORzSJfMxYV
	 6kartIade88rmmmuOxwMBbief4itXhOyhFYVus17yDVqNNvG2EvwD57gWtdI/ZC4th+Nc
	 go6zvJHax1dh1DB2pDvDqhrtGad7cj8Y9GiXtjxFC6QTJBjCOLslEsEAo4Y8KDwGw6ff+
	 e69+fsx/2reR8AQm4gMwx1VerECuUXjEiDfz11AELklQ9DGHdnBzdH09j0Ck4BQktSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BY0Pd2uf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A758606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BY0Pd2uf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF6B1F00A16;
	Wed,  4 Nov 2026 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793792576;
	bh=W+D7wI9NSxYwB7FLUJeElN3wPz2OZ57FW2nIA3DB6qs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BY0Pd2uff+kccmHyIlXjwaFl78SzeKGLHCG0mRAmm6O/a7Ch0rdb4rWqt+YwKaWVP
	 qyxlZHOmHFlep0LSG+U4jmm0gvH0FV8pMTSUFng6o4hFLG/BJCy1EEPEK7R+/qy80E
	 jEaWDG0ZJWffNFCbLkR8mhl0Qzq47sNd5Y2/KGWiSkHKdNIESdv16Z/iBfre+utSrj
	 NsSg76t0KT20XyjA0Ij98y8FGqNZicMvHaSsqoLDewSD0KdAGTuci+lSYLw34Ul/Eg
	 J5cb7pBaQKPqq1Ob3+ylowoyVgAlREpBvHjYE7lR5Zn3+UggKaxVCXmw+ePFeFfS1P
	 skQIOMuFufyjQ==
Message-ID: <sashiko-outbox-197204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test local storage max
 value size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jonathan Bastari Thamrin" <thamrinjonathan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261104-local-storage-max-v1-2-c836731bd184@gmail.com>
References: <20261104-local-storage-max-v1-0-c836731bd184@gmail.com>
 <20261104-local-storage-max-v1-2-c836731bd184@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 11:42:56 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: non-standard multi-line comment above find_max_value=
_size()
--

commit 1da8998ccd74b6171959f2da642b888d3db302bd
Author: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

selftests/bpf: Test local storage max value size

This commit adds a selftest in task_local_storage.c that uses binary search
to find the largest value size accepted for a task storage map, verifies the
size is at least 4096 bytes, and checks that an element of that size can be
stored.

> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> index 5b2b56cc3a4f3..c7e9fa6743b93 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> @@ -495,6 +495,91 @@ static void test_uptr_map_failure(const char *map_na=
me, int expected_errno)

[ ... ]

> +/* Return the largest value_size the kernel accepts for a local storage
> + * map, or -1 on an unexpected error.
> + */
> +static int find_max_value_size(void)

[Severity: Low]
This isn't a bug, but in BPF selftests, should the multi-line comment above
find_max_value_size() in tools/testing/selftests/bpf/prog_tests/task_local_=
storage.c
place the opening /* on its own line with the comment text starting on the
next line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-local-stor=
age-max-v1-0-c836731bd184@gmail.com?part=3D2
