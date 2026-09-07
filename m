Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EE8372058
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760022; cv=none; b=gAn6eFTkf8xJsR9PH+pw6QXAefRvRNVYGcMb5oBNRMdW3QcB62jDIDrhfFsd/jT5Pe5/MgE/zszfFdCjQqnJ9xq4I/tQCESjcu6jPHA5hnw4a6quDm7fM1IRK/m8+Gix2ZpSckP9Hk3/DuAla3buV1tRPh0GUMqXd6a3alvwIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760022; c=relaxed/simple;
	bh=mltRRpfbfBR91iaGUJ6P2WJ7YIwsS2ogQdOOkijyb/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P0RCAsDIfb8/YmfCu30tavl5SRNQV9rBw4OVTdp3KIuWVPWrPKC4TsDIxpu5MMGIX+1XqnwI+lBj2jiSaYKLNl092KNFaCZSIpSiFfR38JNG+StmjGo8gKtgy/J1HI2sk9cMZNNCdQaFnL8RuUYkZj48djwDfooj5ySRxiEnMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFUa2WDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFUa2WDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738DF1F00A3A;
	Mon,  7 Sep 2026 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760020;
	bh=DFCNb5x4writyirvTHURZuYZW5eGt3HeQ8CUw7BzCdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFUa2WDLCMmrgjL8LitrHc7O2OmGRvchv/mrVLJM/CuZlgvDVspjuud6QF9wVN/Vb
	 7CCfxd0cBPiy+AdJ32WJOTvMPpDQFu4GEBaBzwxSzkmFWIQV3bmmkJ4UXaQkZwaPAP
	 xcQzhWL2aPrjKJNL3eBSagdhDfBMZe8+/ywfegrryhVvA1sRrZOC5/eN7UddQ2ox+E
	 0yBcKBSc0VtpNwmUdm3jHjUZlIeu+IsabPfsK9zANSG5E8r6eph5NR2BFG1jMXACXV
	 IFoKod0KGQCWHlvaMb9yHY6/xnmeRKFmlSmalT1ZH0VJLuQ95HYk1iqqn9arEe+Hif
	 fJY8orHnt24IA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: cover the exception callback
 using its own BPF stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260907054235.473103-3-donggeunyoo.kernel@gmail.com>
References: <20260907054235.473103-1-donggeunyoo.kernel@gmail.com>
 <20260907054235.473103-3-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:46:59 +0000
Message-Id: <20260907054700.738DF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the required BPF kernel comment =
style.
--

commit 6cf0d756f3e18b0c62e71081cda78a62eb981a75
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

selftests/bpf: cover the exception callback using its own BPF stack

This commit adds a test to verify that an exception callback can safely
access its own BPF stack slot. It introduces a subprogram that throws an
exception and uses a callback that passes a local variable's address to
bpf_probe_read_kernel().

> diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testi=
ng/selftests/bpf/progs/exceptions.c
> index c8d716fbd4191..2b01b45cef06a 100644
> --- a/tools/testing/selftests/bpf/progs/exceptions.c
> +++ b/tools/testing/selftests/bpf/progs/exceptions.c
[ ... ]
> @@ -212,6 +212,35 @@ int exception_throw_subprog(struct __sk_buff *ctx)
>  	return 0;
>  }
> =20
> +u64 exception_cb_stack_src =3D 0x1234;
> +
> +/* The address handed to the helper has to be this callback's own stack
> + * slot, not one from a frame that is already gone.
> + */

[Severity: Low]
Could we update this comment block in exception_cb_stack() to follow the=20
preferred BPF multi-line comment style?

The BPF subsystem guidelines require the opening '/*' to be on its own line
for multi-line comments:

/*
 * The address handed to the helper has to be this callback's own stack
 * slot, not one from a frame that is already gone.
 */

> +__noinline int exception_cb_stack(u64 cookie)
> +{
> +	volatile u64 val =3D 0xdead;
> +
> +	bpf_probe_read_kernel((void *)&val, sizeof(val), &exception_cb_stack_sr=
c);
> +	return val;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907054235.4731=
03-1-donggeunyoo.kernel@gmail.com?part=3D2
