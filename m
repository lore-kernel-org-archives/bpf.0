Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473394;
	b=2VcIAWv8DsWaXlx0+yyMtAq2wlSki+CN3QP+lufUPkQSYQT3f3ShkfrqvhF4ZbHbegit
	 DSxTGDwPYk16oJwR78X03Juppwv9dLIw/V0AJrnwgnFzxv6qN3Syg5X+RYkgkNjAMHg2K
	 1by+eKO8DFlzRk4AYW8pACAaJCV8NaRb2qTEpisMWrAkXTv2I2vtYycfZ96Y4A70npN1S
	 DaEm0rwwEzAM0loc7jN4iy6LRZIdStFRLGT5LNg64gchi+32jhJfBKL4tv/Vv2tYB9nqd
	 17XG4BZIO3u25MnWh5qw8lhF9AkEZR+mdaeNKQYv3kXljERfGfkyhI8yrPDFryYki9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473394;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ccawv05a/NUZlg2wvKw2dP2vcDgQtoIjSCOrla/bg3U=;
	b=tWTqdzlJwsyWJPpzMoizy20SzTDHCkIxUGIAL6+wnYThcB6Xu8fQ0Vhrt8WEKroVso0I
	 JE8W5RBtieKfRlAWEQpGY/kHNGMq7DZb+8z4qgFJZgR7YpGJHu+h+8LJ1JsfHsSgiQLJg
	 P9wvisPmhxb4pkuww6dAQj0XwTDsuLTPpGgOiRM7vRHUkasUqMocEjPvxpgjubnU9QPSP
	 U/G4uotw3YmlyW3tIwCY/RLioXy/hL3x4rY8B5jReVhXMhDrkYkGt3gyYoHBupH3wVQxK
	 BJVEfxzVTyYg/0jwsu0gnSJGbYbcFW2v/JJwUK/8+0gzTCckMup2QE3TzPRKcgZ+oMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQUI4Ttw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C54606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQUI4Ttw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398E51F000C0;
	Mon, 23 Nov 2026 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473394;
	bh=Ccawv05a/NUZlg2wvKw2dP2vcDgQtoIjSCOrla/bg3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQUI4TtwH6gg07KO5+uxEHk2XNs+MQ2K6MezNJZ2SyNr/dB4kA3ZIEGq0zd+laxU9
	 uj+sju90TbveNSzTgluWZJU17VZbFvjSqdKx0YJViA/Q+AkQiuFSpqLZDUCU0UT/GY
	 CB3qLUBYCORwv/vlQHxqWkf9tcmruT49qBKgNBnpc6KuaAkJBaK5WZkPqHHlLvwYtf
	 iilunpSyq04wpcU44pcs1br/UWNKsIfDpgL3gyJinEM3VIL7qu2EgHyUnzk+hFCEmO
	 ETJ6Ul9RmcAHsLY4mdISpiRbtjwH+YBREyrQ8nbPQc7fyzCOY+FBxd23VTcYQbYNhO
	 wnNmwOW4XJsDw==
Message-ID: <sashiko-outbox-230150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Test detection of function
 argument relocation support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <almagui@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123223227.745345-7-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
 <20261123223227.745345-7-almagui@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:36:33 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: non-standard multi-line comment style in
  func_args_core.c
--

commit 636af5484ed5c26ea73ebeb02b695ba9f266ad9c
Author: Alan Maguire <almagui@kernel.org>

selftests/bpf: Test detection of function argument relocation support

This commit adds selftest checks verifying that bpf_func_args_supported()
returns 1 for function argument structs in fentry, fexit, LSM and LSM
cgroup programs, and 0 for structs lacking the bpf_func_args tag.

> diff --git a/tools/testing/selftests/bpf/progs/func_args_core.c b/tools/t=
esting/selftests/bpf/progs/func_args_core.c
> index 4656a6c642d10..cf2785d9349f9 100644
> --- a/tools/testing/selftests/bpf/progs/func_args_core.c
> +++ b/tools/testing/selftests/bpf/progs/func_args_core.c
> @@ -32,11 +32,23 @@ struct fentry_test3_args {
> =20
>  __u64 t3_a, t3_b, t3_c, t3_b_alias, t3_ret;
>  int t3_missing_exists =3D -1, t3_bad_type_exists =3D -1, t3_missing_flav=
or_exists =3D -1;
> +int t3_supported =3D -1, t3_untagged_supported =3D -1;
> +
> +/* without the bpf_func_args tag, as for libbpf or kernel versions witho=
ut
> + * support for function argument relocations; no kernel type has this na=
me
> + */

[Severity: Low]
This isn't a bug, but BPF coding style puts the opening /* of a
multi-line comment on its own line with the comment text starting on the
next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123223227.7453=
45-1-almagui@kernel.org?part=3D6
