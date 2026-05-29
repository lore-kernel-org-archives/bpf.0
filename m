Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707A23AB81
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780025960; cv=none; b=QfhvrRGaBFQxtIACYrhdnLUSDN6XSv1HMVNwmux/w/yae4/QlyuU/idQiwrKS2+A3T89VDjPMb3LSq1CxCIBmA/jBWPUnbRfPxzMQTS9EIcAInTPIuirl88z7j0VgT9rLWT3zvzFG5IgtGyeqE0ep/fHda02yNvgLGtP33KAgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780025960; c=relaxed/simple;
	bh=EsU7D5gJlfNLArD5V4XdMdViURutUCyLIiaZLd+kpxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E+3xXN+mbnT4+GCeaoJETC1BHNJolZdyJkXpIqy+NeVBVB33fl43tKMqqO6QAk6DHsgUpY1gwgiY8FsBoFIILeEDh0SzwAqFO5IOrejHN7WHgEQKjQqUfuSvg55leeE5JndJW0oLP+F46y8tYu5rmnue2t7fkY7iPfyDTq6R6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+zMib8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+zMib8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9B41F000E9;
	Fri, 29 May 2026 03:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780025959;
	bh=G2G5rSiG91DoSTJjv2yf8+4rsrNgJqLe6zMEYwtzsdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C+zMib8SeKRhWAM6K1FuFnhF8KZmmzV/Ay3aQAVQZW1qRQKawWJGT6qeZaD/keTDr
	 8h8/BzoSvUN9wjU8PSL5UNDUynGydkGPpZ9OLnMSxjy6RuKSiLdlZ0EyPh4e3VKsCY
	 wnQYX7yW0a/T/x1EMee0urL/RyUboNYOTzfGH2Uwp0Lb8tmq6gl9fBkwJPLzr78n4G
	 1bGG690CeuPFlZVKduttYybiYbOh0CkWBFDPBjmU+Le6W6LEgdXO1nKTdhxi18cNog
	 foUpjHEyOBqxJwJTyVc9im6DGhouaJJECHu5biPRBhFEwFtWpaP3np4ZYmOgASz6qf
	 yEn+PELnRfBKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: fix token tests for
 bpf_object__prepare() probe_loading
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529031604.888137-1-chenyuan_fl@163.com>
References: <20260529031604.888137-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 03:39:18 +0000
Message-Id: <20260529033919.2E9B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch masks a libbpf bug by inappropriately expanding token =
privileges in tests, defeating the purpose of testing fine-grained token de=
legation.
- [Medium] The patch silently adds BPF_MAP_TYPE_ARRAY and BPF_PROG_LOAD per=
missions to test options without documenting them in the commit message.
--

commit f600b2d49f35c6ad7110d3da0ab207e0df841447
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: fix token tests for bpf_object__prepare() probe_loading

This patch modifies BPF token selftests to add SOCKET_FILTER, TRACEPOINT,
and ARRAY map permissions to various subtests. This is intended to fix test
failures caused by libbpf's internal environment probe loading.

> The bpf_object__prepare() function internally calls bpf_object__probe_loa=
ding(),
> which attempts to load SOCKET_FILTER and TRACEPOINT programs to verify th=
e BPF
> environment. Without these permissions in the token, the probe fails and =
causes
> the tests to fail.
>=20
> Fix the following test cases by adding SOCKET_FILTER and TRACEPOINT permi=
ssions:

[Severity: Medium]
The commit message explicitly mentions adding SOCKET_FILTER and TRACEPOINT
permissions. However, the patch also adds BPF_PROG_LOAD to the obj_priv_map
test, and BPF_MAP_TYPE_ARRAY to several other tests.=20

Could the commit message be updated to reflect all the changes being made,
or should these undocumented changes be removed?

> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
> index f2f5d36ae00a4..25a76e09a3c96 100644
> --- a/tools/testing/selftests/bpf/prog_tests/token.c
> +++ b/tools/testing/selftests/bpf/prog_tests/token.c
> @@ -1168,8 +1168,13 @@ void serial_test_token(void)
>  	}
>  	if (test__start_subtest("obj_priv_map")) {
>  		struct bpffs_opts opts =3D {
> -			.cmds =3D bit(BPF_MAP_CREATE),
> +			/* BPF_PROG_LOAD is needed for bpf_object__probe_loading */
> +			.cmds =3D bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
>  			.maps =3D bit(BPF_MAP_TYPE_QUEUE),
> +			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
> +			.progs =3D bit(BPF_PROG_TYPE_SOCKET_FILTER) |
> +					 bit(BPF_PROG_TYPE_TRACEPOINT),
> +			.attachs =3D ~0ULL,
>  		};

[Severity: Medium]
By adding BPF_PROG_LOAD, SOCKET_FILTER, and TRACEPOINT here, does this
defeat the purpose of the obj_priv_map test?=20

This test appears specifically designed to verify that a token restricted to
only BPF_MAP_CREATE can successfully authorize map-only operations.

If bpf_object__probe_loading() causes the entire object load to abort with
-EPERM when a confined token is used, isn't this a functional bug in libbpf
rather than a test issue?=20

Should libbpf be fixed to handle probe -EPERM gracefully (or skip probes for
objects without programs) instead of expanding the token privileges in the
tests?

[ ... ]

> @@ -1213,9 +1232,13 @@ void serial_test_token(void)
>  	if (test__start_subtest("obj_priv_btf_success")) {
>  		struct bpffs_opts opts =3D {
>  			/* allow BTF loading */
> -			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD=
),
> -			.maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
> -			.progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
> +			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) |
> +					bit(BPF_PROG_LOAD),
> +			.maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_MAP_TYPE_ARRAY),
> +			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
> +			.progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS) |
> +					 bit(BPF_PROG_TYPE_SOCKET_FILTER) |
> +					 bit(BPF_PROG_TYPE_TRACEPOINT),
>  			.attachs =3D ~0ULL,
>  		};

[Severity: Medium]
Is there a specific reason BPF_MAP_TYPE_ARRAY is being added to the
maps allowance here? It seems unrelated to the probe loading fix described
in the commit message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529031604.8881=
37-1-chenyuan_fl@163.com?part=3D1
