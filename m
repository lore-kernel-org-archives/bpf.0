Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4F313E07
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205585; cv=none; b=ZNWXjEvkh89WYyLXl7OVND0dZHqQ05eXK6eMqDNELVzx53f7GsAsm6osqYYZM/S+U+FSKy64fpuMQFaGWIHl1l+rmB+6WJzTio/fC6nKOPd4u7iuHc9TcZppTbrGT4kLVaJMYKk5p30YN4pg5hBanYIKa0139YWuVnMZOH3y4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205585; c=relaxed/simple;
	bh=WetevDgfi1kihQ5MfiOnbrBk50X6LXHGQvXVo46bZdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I65xidYh0b1y8zHkZ5EquO/JAnsDGgeTtWE3eE2chvk6NGoCNN3aUCNK9+NFEVX1QzIWs1CGLQkQ74Jxcefs1paPwXX591X6f1qP3A6ANl0DznyTuAs3qXBFdqvs6f1Y67TXfC1kuTwn3H7iUIjPlMl8aNadysvcFBOryMmM0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPfe/g83; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPfe/g83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A722AC19425;
	Tue, 14 Apr 2026 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776205584;
	bh=WetevDgfi1kihQ5MfiOnbrBk50X6LXHGQvXVo46bZdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CPfe/g83jshMTdvd86JjI0Nm+AHNL+mRqkLJSJxJ1WnlgDZw9QToFjPwZadRktGqN
	 W8ZL/nLkcNSy6+sdI0d3qo69yIGJHY1G2iyWpVsBKxcaw3onBllts1EcjGcp9X0fef
	 9gUfW9YaXHLiPzDkK4pECSQVaJo2B02kO4LJstUY15xhMw8tnyCBrbD/lg0+Zt/WbS
	 NhL6HwzBuwRz9tQ35l0LsPoY1gUgM/CMuLG8d2vWif3eMBOCfwAnqXuOurxU5yV7Ic
	 LN31/3Luyyhn8wyWwjbQugKjgGp4HyEig+jqV6QfsZ1JAS/oaHsWWaWG2cM0J3fwpC
	 LipfxTD6g2LVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/6] selftests/bpf: Test BTF sanitization
 rejection for invalid vlen
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414195019.684531-6-alan.maguire@oracle.com>
References: <20260414195019.684531-6-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 22:26:24 +0000
Message-Id: <20260414222624.A722AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Low] Leaking the BTF object on unexpected success of sanitization.
- [Low] Lack of error checks for BTF construction calls.
- [Low] Using `BTF_MAX_VLEN` as the `byte_sz` argument in `btf__add_datasec=
()`.
--

commit 9c5af444155b34aa840793bf185bc0c0aaa04f3f
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Test BTF sanitization rejection for invalid vlen
   =20
This patch adds a selftest to verify that BTF objects with extended vlen
are properly rejected by kernels that do not support the extended feature.
It simulates the lack of support using the feature cache and checks if
sanitization fails when the vlen limit is surpassed.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tool=
s/testing/selftests/bpf/prog_tests/btf_sanitize.c
> index 652b51efafc27..f41cea5a769a2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
[ ... ]
> @@ -95,3 +95,65 @@ void test_btf_sanitize_layout(void)
> +static void test_btf_sanitize_extended(void)
> +{
[ ... ]
> +	btf =3D btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "empty_btf"))
> +		goto out;
> +	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	btf__add_var(btf, "var1", 0, 1);

Are we missing error checks on these btf__add_*() calls?

If any of these allocations silently fail, the test might proceed with an
incomplete BTF object that hasn't actually surpassed the vlen limit. This
would cause the subsequent bpf_object__sanitize_btf() call to unexpectedly
succeed, failing the test for the wrong reason.

> +	btf__add_datasec(btf, "datasec1", BTF_MAX_VLEN);

Is it intentional to use BTF_MAX_VLEN for the byte_sz argument here?

BTF_MAX_VLEN is a bitmask representing the maximum number of items, not a b=
yte
size. Using a proper calculated byte size like 0x10000 * 4 might be clearer.

> +	for (i =3D 0; i <=3D 0xffff; i++)
> +		btf__add_datasec_var_info(btf, 2, i * 4, 4);
> +
> +	/* Sanitization should fail here as vlen surpasses unextended limit. */
> +	sanitized =3D bpf_object__sanitize_btf(skel->obj, btf);
> +	if (!ASSERT_ERR_PTR(sanitized, "bpf_object__sanitize_btf_should_fail"))=
 {
> +		sanitized =3D NULL;

If the first bpf_object__sanitize_btf() call unexpectedly succeeds, sanitiz=
ed
will hold a valid pointer.

Doesn't setting it to NULL before the goto out path leak the memory, since
btf__free(sanitized) will be called with a NULL pointer at the end of the
function?

> +		goto out;
> +	}
> +	/* Now switch extended feature on and ensure success. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414195019.6845=
31-1-alan.maguire@oracle.com?part=3D5
