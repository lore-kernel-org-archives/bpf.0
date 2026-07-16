Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7934887B
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186620; cv=none; b=fwWgpNr5yvAdWXCuFZkPvI3XAs60Ch007ZGCGRK0FZ6u4jbBYc2COr/uRVOLu2KOLiusuEHBlqOGNkeLvylSjnV2PgzlkFBfj/1Ccpb1WUaePycoOCSI9vluuJfieXJNTZeyXQKJTvlcWr4zNWPcZEqJGHYTjGmD9D+vip/reRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186620; c=relaxed/simple;
	bh=HK1D2V1zvP4RHhn9FKgCQkc+wbtdV0oG5PMWOAbJ9N4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aEFOVae7sMkEhZ83RO71U6JwSbLprJdDe2SfHll3IJJi0NeQ5F4hczfMoTDZrGBU73gxv2zFkCxxb2rku0VDu3YjsMX/lBv2Cx2PKiEqD/CBRa38/E0aDuVTPhOMFdd2w+ckzY/5eN3zG/q6E8TDfOitvURyNJQ8Y7XMx9clcNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmwWWdvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmwWWdvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD721F00A3A;
	Thu, 16 Jul 2026 07:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784186606;
	bh=rF6TDn+VwttH/dmmrx4vrLo9j7QlOq14T4ld+k3Rs5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fmwWWdvXYFeo3dnolf5iqivfXvgmz88Ivxi2wuqMRIA2u8rgAW3Ph8ac4jC2eRHwX
	 VzPvMKJEYlBW8s9cwl0lqGBOuL2pjHb1v2b8iNoF+fx11+dW59NednNVVeSj/X16rA
	 MRXFHcyHyXzuO5R8zIDC2YzmvjlcnLeG48ANILUJTEa9X3tzASXFkMVtQQBDxde6NQ
	 walonQ6DSJgU4bvjR10wxoI6aaamJA885NpbHeXSg7mR6JiWhB1HRI1saXo4tTt+ry
	 OtAs8PnQrVMTkFSUCbZLAbQsFYXd6jQ174uwNB8FlKPhJ2FB20YLEclQbMJu5L2tx0
	 Bpnng2TdR3ZKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libarena/selftests: use ARRAY_SIZE macro in
 st_asan_buddy.bpf.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "longlong yan" <yanlonglong@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716071110.560-1-yanlonglong@kylinos.cn>
References: <20260716071110.560-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:23:26 +0000
Message-Id: <20260716072326.8FD721F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit introduces the `ARRAY_SIZE` macro into a BPF program wit=
hout defining or including it, causing a compilation failure.
--

--- Patch [1]: [PATCH] libarena/selftests: use ARRAY_SIZE macro in st_asan_=
buddy.bpf.c ---
commit 70521e8b40248839f7100def222aa4fb06724c32
Author: longlong yan <yanlonglong@kylinos.cn>
libarena/selftests: use ARRAY_SIZE macro in st_asan_buddy.bpf.c

This commit replaces manual array size calculations with the ARRAY_SIZE mac=
ro=20
in the asan_test_buddy_oob and asan_test_buddy_uaf functions to make the co=
de=20
more compact.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_asan_bud=
dy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.b=
pf.c
> index 3266a28f53d76..9c94a5167a503 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
> @@ -163,7 +163,7 @@ __weak int asan_test_buddy_oob(void)
>  		return ret;
>  	}
> =20
> -	for (i =3D zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++)=
 {
> +	for (i =3D zero; i < ARRAY_SIZE(sizes) && can_loop; i++) {

[Severity: Low]
Does this cause a compilation failure when building the BPF selftests?

It appears that ARRAY_SIZE is not defined in this BPF program or its curren=
tly
included headers. Would we need to define ARRAY_SIZE locally in this file, =
or
include a header that provides it specifically for BPF environments?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716071110.560-=
1-yanlonglong@kylinos.cn?part=3D1
