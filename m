Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113F45517F
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706462; cv=none; b=VHCEfclLAZ1nyLKGUBI1XD+unIbnX9zIzj1LeuEtM3N/4bOfLZk/IQxE+TfD0tabIqohEsE8TVGULIOEwUSIINxqsjdmAar91ErDX8vk5Qg/MVn43aFUbESjM+YCLxFRu2HrZJ+iTCqppUzFYeEpvLJIuuXh2+sjkrioYTY5GlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706462; c=relaxed/simple;
	bh=t91dhOvO2JXtz0a4EQIMofUlUoMyjLkYe/rwEhyJbXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=syxUN3ThF4bQdDDSis2BM/jaOdNZfrHif83wc5Rt7tHnmGjMbmVf5jGSXFNeLImQ0whKN4+QPgDzR38Jl4ut6HJ9VGYT0Lq3KCS1pJBYg8IvmSL3x6fPGoE93LAlxfQf4DvMoC5MdyMYbQ5LoLqhPHzI3bw1mqDBRnBjfsHCImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ofc0c8co; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ofc0c8co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34C61F000E9;
	Fri, 14 Aug 2026 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786706458;
	bh=6yQwOXysvDquOgZZWNCZd9QmEr5FjZQaqX4MdSHSHVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ofc0c8coj3pz2Y+UPDyMMHbOpmYdgqyjzMw7JiqxBfkt6UDdWvoTc789ZfZKCKTbb
	 DRVyi9mwRKeawXQt9dIRyjtSmkKb5bbznl5tCQg9CIX7Ja0diwgeeGgaXfOIoV+u/Z
	 MZwdkkWrjuX2YuAeupshEjLqj15GL2ky53e8IWQB86YbyYBsBjIXeYSwJoba2VNCLH
	 LuSa+ZiYG9wrvtDkUe6c20hDCBKBYfvewocUIVkZ04Mvek2kbQi06kUCDfyAqZC2KC
	 wD/Yy/lHTMf1pjmka1egrv9D8RkGtuxhhZFgQBDr9jsA+Bnc51WZs593xnkGvX8AIj
	 tqdZGgDvcDAQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for bpf_sockopt
 is_compat field
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813112039.247862-2-maze@google.com>
References: <20260813112039.247862-1-maze@google.com>
 <20260813112039.247862-2-maze@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 11:20:58 +0000
Message-Id: <20260814112058.A34C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Reading the 4-byte padding at offset 44 in `struct bpf_sockopt` tr=
iggers a `verifier_bug` WARN_ONCE because `cg_sockopt_convert_ctx_access()`=
 lacks a translation case.
- [Low] The `getsockopt: read ctx->is_compat` selftest omits the `.io_uring=
_support =3D true` flag, reducing test coverage.
--

--- Patch [2]: [PATCH bpf-next 2/2] selftests/bpf: Add tests for bpf_sockop=
t is_compat field ---
commit 007892bbe60c0ee959b9f1a3e6944cb7ea0af571
Author: Maciej =C5=BBenczykowski <maze@google.com>

selftests/bpf: Add tests for bpf_sockopt is_compat field

Sync tools/include/uapi/linux/bpf.h with the addition of the is_compat
field in struct bpf_sockopt and add test cases to prog_tests/sockopt.c
to verify context access permissions.

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index ffd96e8b920bd..15f712b5b1645 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7616,6 +7616,7 @@ struct bpf_sockopt {
>  	__s32	optname;
>  	__s32	optlen;
>  	__s32	retval;
> +	__s32	is_compat;
>  };

[Severity: High]
Does this addition leave a 4-byte padding at offset 44 that causes a
verifier bug?

Because struct bpf_sockopt contains 64-bit pointers, adding is_compat
makes the fields 44 bytes, expanding the struct size to 48 bytes due to
alignment padding.

In kernel/bpf/cgroup.c, cg_sockopt_is_valid_access() permits accesses up to
the full struct size (48 bytes):

	if (off < 0 || off >=3D sizeof(struct bpf_sockopt))
		return false;

However, cg_sockopt_convert_ctx_access() lacks a translation case for this
implicit padding at offset 44. If a BPF program reads offset 44, it yields 0
instructions, forcing bpf_convert_ctx_accesses() to emit a verifier_bug
WARN_ONCE.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/tes=
ting/selftests/bpf/prog_tests/sockopt.c
> index eaac83a7f388b..c7dd22d0e3f84 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> @@ -215,6 +215,49 @@ static struct sockopt_test {
[ ... ]
> +	{
> +		.descr =3D "getsockopt: read ctx->is_compat",
> +		.insns =3D {
[ ... ]
> +		},
> +		.attach_type =3D BPF_CGROUP_GETSOCKOPT,
> +		.expected_attach_type =3D BPF_CGROUP_GETSOCKOPT,
> +
> +		.get_level =3D SOL_IP,
> +		.get_optname =3D IP_TOS,
> +		.get_optlen =3D 1,
> +	},

[Severity: Low]
Should this test case include the .io_uring_support =3D true flag?

The "setsockopt: read ctx->is_compat" test configuration further down inclu=
des
this flag, but it is omitted here. Adding it would validate io_uring execut=
ion
on the new getsockopt hook.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813112039.2478=
62-1-maze@google.com?part=3D2
