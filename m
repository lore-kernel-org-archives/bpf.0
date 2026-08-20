Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2447A86D
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240417; cv=none; b=Xs/tHt364QuLHBzXt/ysT+NXPZv3RzgYxxPbtWAlOWJhE6KNzsDtx/pGYY8pn2V92p9eipWH+BMnjAMtwSM0cRZ8U864epC1m+epSyWWkPwVzsSZ9khlnDGbPjnRr0ywui8FwF2Oe50ign9GCdf0PI+YLHRB8lTmjNrYmU7Z4xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240417; c=relaxed/simple;
	bh=YOYONFBlSWCOQMISgw64S1DdxIJgLf+i5wK3L0yyalI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LU1MEB6nKWaed9BoBOyeMpC1XM0Uoc9yTu1jqDhrcN3KREICH0dxkpO50XWyOHpVG3F05HsDjIbb2AenBRSBzjaU9Iw7XS4ZVd6Id3Tgqx8wWnsIb2E4t1sepTZ6GpN4B6eFoPep/H/WQp2lK6VREUTve6TIbTzP17jsWCEJlKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7ZGlwdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7ZGlwdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9E41F00ACF;
	Thu, 20 Aug 2026 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240415;
	bh=ogCChXYp0yzGjrP4+fyD0f7uNQ5jQjoKnwn1I3sno4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7ZGlwdg+9+OyxUaMBPjJZbN0HPs7Xz0lhphqLmnz2lnRXDlasmblxRZxptSV839n
	 iBUv5aa0DKRDrQe5ByR7+JsHqW113FrGG5DXNbhm1YYzXjEevU+9bZH8jDUT4nf4Xf
	 nAMzGlZ2GGwyY/uxXGDYIpmI3y1018Jr3A6TMD+Shr9Zk5/CY8BrJzicq55iOu6SU1
	 eUdnD9FYZYlJAeDGgv0OUAo0TUTthvEUOTIoMjDlsv+ytuhGpfyRFoA0io+j0HCrCf
	 WGnX4P/J1qb0lD1YTwc+x2LWr+fUyyW2rG3mi/Iju0HZHVrRyuJ01oDwIiqBOQ+S/j
	 wPDTCOZn2Xn6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] selftests/x86: add shadow stack lock test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260818225428.1983328-4-bill.roberts@arm.com>
References: <20260818225428.1983328-1-bill.roberts@arm.com>
 <20260818225428.1983328-4-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 15:40:14 +0000
Message-Id: <20260820154015.5C9E41F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The comment references a function name that does not exist in the c=
ode.
--

--- Patch [3]: [PATCH v3 3/5] selftests/x86: add shadow stack lock test ---
commit ff0ac7d8a7598f33a03169f21e6b92ce89cdf8a4
Author: Bill Roberts <bill.roberts@arm.com>

selftests/x86: add shadow stack lock test

This commit adds a test to lock the shadow stack write bit and verifies that
attempting to disable write fails with EPERM. It also ensures the write bit=
=20
remains set for the whole test suite and preserves the ability to unlock it.

> diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/test=
ing/selftests/x86/test_shadow_stack.c
> index b52c5420c1374..72e7329d89d70 100644
> --- a/tools/testing/selftests/x86/test_shadow_stack.c
> +++ b/tools/testing/selftests/x86/test_shadow_stack.c

[ ... ]

> @@ -1079,12 +1097,33 @@ int main(int argc, char *argv[])
>  		return 1;
>  	}
> =20
> +	/* Note: test_shadow_stack_lock() needs write enabled */

[Severity: Low]
This isn't a bug, but the comment refers to test_shadow_stack_lock() which
does not exist. Should this comment instead reference the test_locking()
function that is implemented and called in this patch?

> +	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS)) {
> +		printf("[SKIP]\tCould not enable WRSS\n");
>  		ret =3D 1;
>  		goto out;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818225428.1983=
328-1-bill.roberts@arm.com?part=3D3
