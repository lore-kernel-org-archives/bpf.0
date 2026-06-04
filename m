Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72903A6EF7
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780543508; cv=none; b=ozmLpN5MWUMxHkmNuwSOWFoW0uKWdoimaEPqpXoVGyARfptp+zIE6iYoyZXWxC3MEFvsTuiO9z2BkjM6cfAboADq5i6pa1ptxlDLX1wEcsV8vIWIgd6WTQsMs+vA032cNEZn6GGfCLMfcJcpUJGxClGOxdQ9JbEyORP7ShdvSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780543508; c=relaxed/simple;
	bh=s5wiO7NsEKCms9Tg+qXkJbmkxBZ/PfexB9EvL7tdl8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gpVPiR8RMhT7k/tCpOemXnSm8b2ryAUqgZBc0AUqGTWNc81spI3kk4vxZL+0YEFiXjBs7sDiXupCpesHJubpl14LVNFnIGfIItny6og7SUtZqs6qgOzbyNIb9FTh13tfU4JbvJWtdWyD7cmkJq8//wMx4bDjx5Huis4+lYSyPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O81VtBOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O81VtBOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0F71F0089A;
	Thu,  4 Jun 2026 03:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780543507;
	bh=lCc3HgUAzMHYmFcFG2sWpkmOqPPYTrlk5kS2ZVQ5rpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O81VtBOFKbmEvJ8SdXHU8GlPolANdVKrXdxuYi/DDzmsMtlw7dgckgeINA01dJshG
	 w9CI7UYuYoroVt2Ldz0gr63ac3Wf0fY5DyWiYQ6WLTd9iq5FrAL0pOcLYdd8zZXiMH
	 KKw5Qnxbr5rU1cDD+toPCBIj2H8WJnI7nTZRKvtRy47ySGlD+e/ZRHSrvxp+7WsFDG
	 rmEAasNfJZnfkWST1CW2oqVOfu8rEhJ+room8/8VuLbb0EFmTIZs/QY8GTSe6VHEwO
	 V2KQIDWyrScaExPbqZc9zRxnlzKyn83JwHvXJS+oEFm44LEgUDJo4WT0ul84WfDrTr
	 Hd0wA33eP+k/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Add ARRAY map type to
 token tests that use struct_ops global data
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604031033.806727-3-chenyuan_fl@163.com>
References: <20260604031033.806727-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 03:25:07 +0000
Message-Id: <20260604032507.6E0F71F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a test logic asymmetry by adding `BPF_MAP_T=
YPE_ARRAY` to the positive test `obj_priv_btf_success` but omitting it from=
 the paired negative test `obj_priv_btf_fail`.
--

commit 86da58cc137440e9870bfb020bfbb8bab233e69a
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Add ARRAY map type to token tests that use struct_ops global=
 data

This commit adds BPF_MAP_TYPE_ARRAY to the allowed map types for the token
permissions of three positive subtests: obj_priv_btf_success,
obj_priv_implicit_token, and obj_priv_implicit_token_envvar. This allows
their skeletons to successfully load since they require ARRAY maps for glob=
al
data.

> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
> index f2f5d36ae00a4..1812de87bedb8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/token.c
> +++ b/tools/testing/selftests/bpf/prog_tests/token.c
> @@ -1214,7 +1214,7 @@ void serial_test_token(void)
>  		struct bpffs_opts opts =3D {
>  			/* allow BTF loading */
>  			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD=
),
> -			.maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
> +			.maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_MAP_TYPE_ARRAY),

[Severity: Medium]
Should the negative test obj_priv_btf_fail also receive this update to its
map permissions?

Looking at obj_priv_btf_fail() earlier in the file, it is designed to verify
that lacking BPF_BTF_LOAD properly prevents BTF loading. It currently uses
only bit(BPF_MAP_TYPE_STRUCT_OPS) for its map permissions.

If a kernel regression incorrectly allowed BTF loading to bypass the token
restrictions, wouldn't obj_priv_btf_fail still fail during map creation
because it lacks BPF_MAP_TYPE_ARRAY, thereby silently masking the BTF load
enforcement regression?

>  			.progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
>  			.attachs =3D ~0ULL,
>  		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604031033.8067=
27-1-chenyuan_fl@163.com?part=3D2
