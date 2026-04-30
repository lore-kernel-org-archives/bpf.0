Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D1383C96
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777588293; cv=none; b=t6YkvjJY+VFcNy/BIgNkqDHLTEdUDBB0S/dmruuOuwZcf/a9axK+6PiFDcMzQ23iQNdJkVM3jIH1rMhzizb/o39c+y4n0bOl6umc0jUPXijAYuTSFn8mvqVCgjr0M+bydNUaSfNhG3mdlt0WryXTy5miMp827CJAVcs+X/4itDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777588293; c=relaxed/simple;
	bh=ZUgtzHBVwCLIR/ZL7cLRWvgvef4rlL6c+WywzLm7+zQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=klWayFLRD+WCkIsRRP35XyR7BbuemvWz441vb5S2IOpmfbBB4q6SHyDR0jWxJ1qW44moKw051EvrUqOZ/8mcnhnO3RlYkneUcm+TjHCOCKxJ2tvYduEJkd8lYPIopm+5nNJovRlIWINLfx1ik5g48AxtQy/zXLwBumTgSOKpH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9pkqkBo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9pkqkBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5B8C2BCC4;
	Thu, 30 Apr 2026 22:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777588292;
	bh=ZUgtzHBVwCLIR/ZL7cLRWvgvef4rlL6c+WywzLm7+zQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=T9pkqkBoqcryN162h0ym3FHQvxKPd8qG2P6+Boxj6cZHO+S7hxQzqKeWlPsu1D4q7
	 gYElw5fnt5gmFT5rBwb+KrHAJdxELFco/lY8z9BY+GRQMayECMcmEcyTPujBxPLJm1
	 F3K7AQzxY9jmAhCEp+r4EDEVf+YL6pNC/Mw1NZ243O6vbzfTTcEFMh6Anhi+88525h
	 lwHz7a2CHXNOgVBo0YfToJuO0fyCjwXz6pcBEutvGv6TI2wXr2KDNDiet5carWNaFR
	 FsSRRZlJvY35mNJpR3Rt+6OkRlspuGXms/FuFuBnQ/+SUBEkWQI2WlOReYSvimNBRe
	 otj497TnsMU8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 5/7] selftests: bpf: cover wrapped sk_msg ring
 chaining in ktls TX path
Reply-To: sashiko@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429222944.2139041-6-kuba@kernel.org>
References: <20260429222944.2139041-6-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 22:31:32 +0000
Message-Id: <20260430223132.BE5B8C2BCC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Test fragility due to hardcoded fragment count allows silent fal=
se positive passes
- [Medium] Flawed splice() return value validation masks setup failures
- [Low] Usage of ASSERT_TRUE() for pointer validation instead of ASSERT_OK_=
PTR()
--

commit ff8ec72cdd60f8b61132bc64e2221ed120c71020
Author: Jakub Kicinski <kuba@kernel.org>

selftests: bpf: cover wrapped sk_msg ring chaining in ktls TX path

This commit adds a regression test for an off-by-one error in
tls_push_record(). It uses a BPF program to drop bytes and splices
data to force an sk_msg scatterlist ring to wrap and trigger the bug.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tool=
s/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c

[ ... ]

> +static void test_sockmap_ktls_tx_wrapped_chain(int family, int sotype)
> +{
> +	int c =3D -1, p =3D -1, one =3D 1, prog_fd, map_fd;
> +	int pipefd[2] =3D { -1, -1 };
> +	struct test_sockmap_ktls *skel;
> +	char byte;
> +	ssize_t n;
> +	int err, i;
> +
> +	skel =3D test_sockmap_ktls__open_and_load();
> +	if (!ASSERT_TRUE(skel, "open ktls skel"))

This isn't a bug, but should this use ASSERT_OK_PTR() instead of
ASSERT_TRUE() for validating the skeleton pointer? ASSERT_OK_PTR()
is specifically designated for checking pointers in BPF selftests
and properly handles both NULL and ERR_PTR values.

> +		return;

[ ... ]

> +	/* packetized pipe so each splice frag becomes its own sg entry */
> +	err =3D pipe2(pipefd, O_DIRECT);
> +	if (!ASSERT_OK(err, "pipe2"))
> +		goto out;
> +	err =3D fcntl(pipefd[0], F_SETPIPE_SZ, 17 * 4096);
> +	if (!ASSERT_GE(err, 17 * 4096, "F_SETPIPE_SZ"))
> +		goto out;
> +
> +	for (i =3D 0; i < 17; i++) {
> +		byte =3D 'A' + i;
> +		if (!ASSERT_EQ(write(pipefd[1], &byte, 1), 1, "write to pipe"))
> +			goto out;
> +	}

Will this silently fail to wrap the ring if the kernel is configured
with a CONFIG_MAX_SKB_FRAGS value greater than 17?

The test relies on 17 fragments to fill the ring, as the default capacity
for NR_MSG_FRAG_IDS is MAX_SKB_FRAGS + 1. However, MAX_SKB_FRAGS can be
configured up to 45. If the capacity exceeds 17, the 18th byte sent later
in the test will just be placed at index 17, so sg.end will never wrap to 0.

Would it be more robust to dynamically determine the fragment limit by
reading /proc/sys/net/core/max_skb_frags instead of hardcoding 17?

> +
> +	/* drop the first 16 bytes so sg.start advances to 16 */
> +	skel->bss->apply_bytes =3D 16;
> +
> +	n =3D splice(pipefd[0], NULL, c, NULL, 17, 0);
> +	if (n < 0)
> +		ASSERT_EQ(errno, EACCES, "splice errno");

Could this splice check mask potential test setup failures?

If the BPF program drops 16 bytes as expected, tls_sw_sendmsg() will
return the remaining 1 byte, making splice() return 1. The n < 0 check
evaluates to false and is bypassed.

However, if the BPF program fails to drop the bytes due to a setup issue
or future regression, splice() will return 17. The n < 0 check is still
bypassed, but the full sk_msg ring will be flushed. The subsequent
1-byte send() will then start a new ring at sg.end =3D 1 instead of
wrapping the existing one.

Should this strictly assert the exact expected return value, for example
using ASSERT_EQ(n, 1, "splice returns remaining byte"), to guarantee
the ring state is set up correctly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429222944.2139=
041-1-kuba@kernel.org?part=3D5
