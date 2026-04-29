Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01045208D0
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452462; cv=none; b=ZhTl5YC2X54n6tuch/DpnGtTDdR95zeiAfMK3BHr1/X7BybZb5OFRptqRgfT1IEXG+qeHVsTgWFLPAljv2XPkVuFYHtgqvn/V4RDbjUNgDS6FH3PK8yM9fE45LvT9W3LxBHA/FaVz+PTJD0rXgSjMjTqGv683Xvs5kig42JTDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452462; c=relaxed/simple;
	bh=v36WNi3oXnzjVFke+3aEg47VX4Z7I8DAxpZ0H2Jv3uE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JfB5tsO7QsN7DYhwSRZm7U7skoBd8eerf+T8P96eblgjBmL6Z7DR57qJNS4vmGIJ99dZ7/Q3Uf1n7e7WyKwxaeMZOoa0Qw4Eh9q/VjCnU1xeXjLb+/9Nqf2vbJsOXq3SRuLleBYoy+GpjQ5dvPGsAtMh5EoX+2fIwbtoHhWEjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Usb0Y9Sm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Usb0Y9Sm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848E9C19425;
	Wed, 29 Apr 2026 08:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777452461;
	bh=v36WNi3oXnzjVFke+3aEg47VX4Z7I8DAxpZ0H2Jv3uE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Usb0Y9Sm2BWVX+nJl4XWyL6k4BunNtNDzrPoze19+S4db+mY7Q4hlpPRllWXi4Avr
	 E/egDZTBvJcjsxg9opJWNIChZKd3WDuw5cPaH8afoTClfRZy+YIpI7Ss7TMiWylc9s
	 GawASJIRHUexSBc290F7qtKvJEhBksacIhd9NheCREQApim7KqIgUWG5XVLmeT5dUo
	 qhzq/3aq0PmZO2C0YCmEjXFqU4i73FZCj/yJO06DQB4prbgtmX+HOy6s58a5ilKoMs
	 yWNy411T9O+wb9juv3axyz0JViudy9noxtGTBWNYn/vq80qOEVE9dKqifJoYYx+9yi
	 6pHPBSemyDwrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] selftests/xsk: Introduce helpers for setting UMEM
 properties
Reply-To: sashiko@lists.linux.dev
To: "Tushar Vyavahare" <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428080317.702124-2-tushar.vyavahare@intel.com>
References: <20260428080317.702124-2-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 08:47:40 +0000
Message-Id: <20260429084741.848E9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Infinite recursion in test_spec_set_unaligned helper leading to =
stack overflow
--

commit 48ddf9c071b166e4cce598b12dfc3870867c0fe6
Author: Tushar Vyavahare <tushar.vyavahare@intel.com>

selftests/xsk: Introduce helpers for setting UMEM properties

This commit introduces helper functions to set UMEM properties in the xsk
selftests. This centralizes the setup logic across tests and prepares for
future refactoring.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index 7950c504ed28..d5cd8f590b25 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -303,6 +303,22 @@ static void test_spec_reset(struct test_spec *test)
>  	__test_spec_init(test, test->ifobj_tx, test->ifobj_rx);
>  }
> =20
> +static void test_spec_set_unaligned(struct test_spec *test)
> +{
> +	test_spec_set_unaligned(test);

Does this cause an infinite recursion leading to a stack overflow?

It looks like the helper calls itself instead of actually setting the
umem->unaligned_mode properties for the TX and RX interfaces. I see this
is fixed later in the patch series in commit 71e22f338d62 ("selftests/xsk:
Eliminate umem reference from ifobject"), but it seems it breaks the tests
at this commit.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428080317.7021=
24-1-tushar.vyavahare@intel.com?part=3D1
