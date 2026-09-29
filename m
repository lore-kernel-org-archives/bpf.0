Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13B3BFADE
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721422; cv=none; b=j062pg3y1K2EwKW/FBJqh++HL+2EsDOw3Rgr5KvCqWym2zJXxCI+75dQzx3HzF16hSh2TSTprnQvyna79bUqt1YOTxPYLHWJ6lGm1YcR9oTiAV5cfRTQtF3/HcXj0pDBv5pHRuPojjLwtCwr7rvroboEqm1iYCd1KdUM11k6FYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721422; c=relaxed/simple;
	bh=R7Fnzoi/6N4WQbmX5F2Hifo1ndVa8BLqCl4u81rRRFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BcG/9f/kc2EemnZoOuVuNSZjuSYURg385XonqF1mPkxPlGLN7adHSNWRi05eYUPsvgbqyFZeqGQ/V+mGadxVUtXl5ftFpnf+qraWWL/7Nv22bIKpIdQbiNpt0jV6m94tPZuVVfkVM/2sw7zvrY4oUWmizeaA7x3RbVgG2w+dKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1/BA20D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1/BA20D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197371F00893;
	Tue, 29 Sep 2026 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790721421;
	bh=RJowPVnH1l5QC+xf8S5q5vkjEi9wPCUKdiUYReMkews=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c1/BA20DnK/HPBMwUWsevwQ2LaulPvPh+ZtHKgD8yWTSI3l9PMoNUBInhkdMtn2od
	 w+Uk5d7eXaAlob8dlEL9vO2Mif6GGDqRjg/YhjDg5mGhr37JGKN29xjlDsky1XSegX
	 K3IXyaOMOkbtKF9buVeqeQIG0dOZ0IxbLGTgggW7jbKrdp52VdsjxXeY90dTSAsG9L
	 zho84ZeHgTn7NtadugRe3LWnRYM9TEue1D3V7KJ4ReONwSqH0fwf6RnflQKzhP+G6n
	 1CNgAayI+GQ3SNYKZ1sOlFHDD3w2um2kh8/MjS/hifjNPtJuzgdLsaQyxI95VaCgxe
	 Ovtb++abwu2ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 4/5] selftests/bpf: check XDP attach on a
 nested bond slave
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928223648.2739371-5-kuba@kernel.org>
References: <20260928223648.2739371-1-kuba@kernel.org>
 <20260928223648.2739371-5-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 22:37:00 +0000
Message-Id: <20260929223701.197371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: false-positive test success due to ASSERT_GE(nest=
2, 0)
--

commit 342ea5a121a99c07f3e0bd7119d434dddb04cb6e
Author: Jakub Kicinski <kuba@kernel.org>

selftests/bpf: check XDP attach on a nested bond slave

This commit adds testing to verify that attaching a BPF program to a nested
slave device correctly fails when the master device already has a program
attached. It retrieves the interface index for "bond_nest2" and asserts that
attaching to it returns an error.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools=
/testing/selftests/bpf/prog_tests/xdp_bonding.c
> index c42488e445c28..486e0f9a2adac 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
[ ... ]
> @@ -488,10 +489,23 @@ static void test_xdp_bonding_nested(struct skeleton=
s *skeletons)
>  	if (!ASSERT_OK(err, "set bond_nest2 master"))
>  		goto out;
> =20
> +	nest2 =3D if_nametoindex("bond_nest2");
> +	if (!ASSERT_GE(nest2, 0, "if_nametoindex bond_nest2"))
> +		goto out;
> +

[Severity: Medium]
Will this assertion accept an invalid interface index if if_nametoindex()
fails?

If if_nametoindex("bond_nest2") fails, it returns 0. The ASSERT_GE check
accepts 0, which then propagates down to bpf_program__attach_xdp().

>  	link =3D bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_=
prog, bond);
> -	ASSERT_OK_PTR(link, "attach program to master");
> +	if (!ASSERT_OK_PTR(link, "attach program to master"))
> +		goto out;
> +
> +	/* Attaching to a nested slave is not allowed either. Only the direct
> +	 * upper is consulted, so this only holds if every device the program
> +	 * was propagated to records it.
> +	 */
> +	link2 =3D bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy=
_prog, nest2);
> +	ASSERT_ERR_PTR(link2, "attach program to nested slave when master has p=
rogram");

[Severity: Medium]
Could a failure to resolve the interface index result in a false-positive t=
est
success here?

If nest2 is 0 from a previous if_nametoindex() failure,
bpf_program__attach_xdp() will predictably fail. Because the test expects
attachment to fail for nesting restrictions, the expected-failure assertion
is satisfied, which could silently mask test environment setup failures.

> =20
>  out:
> +	bpf_link__destroy(link2);
>  	bpf_link__destroy(link);
>  	system("ip link del bond");
>  	system("ip link del bond_nest1");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928223648.2739=
371-1-kuba@kernel.org?part=3D4
