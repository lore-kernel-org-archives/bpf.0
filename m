Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC23909A8
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494224; cv=none; b=DU/H8+RM3E7S5PSuLR+6GJiIrDw8Dgmm+D+GRATxH9V0yVW7wdJERgA/YNZU1zPf0g/cSIC+BSeYR11m7TgL9aI0MFw3A+8BwpaSO7GCLFSsBuRcMuUI31Q3zrCA0RRhgewzXfN2IewatbofhykfTKu9/qBLF1ZjXPhS/c6eKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494224; c=relaxed/simple;
	bh=1FdUbl0agktx4J2BpYqBx9yT3FAHrgrXNNRBMU2q8o4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MNPcsybVRi8qlG5cxghLqKxrcU8QWEWr3Cu+UevZPImkP2n5TWLkILBwwvRWtFtAqxdYe4XWhVH8AOeTsT1Pv5ULnpRexM0ZqlGLmLm/67Rg+0UMhE0IOhSEwucOBFxr62/Dwd2TM+PlGT663bigj+Ti8gP1RewD+j/wX2lg0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dstkUYr8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dstkUYr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB842C2BCFA;
	Wed, 29 Apr 2026 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777494224;
	bh=1FdUbl0agktx4J2BpYqBx9yT3FAHrgrXNNRBMU2q8o4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dstkUYr8WtLoiZz0SM9eDHJwWx9LKgxsthDJkgqnkNQBKqHip0UDeHN/X0QXU6RPf
	 TzVdGyIoEtddrt2aefJqZDLjsmEaZWYlZnHoXtHaZ8rjgJ/5zdzvXdygKaSH2Ios7P
	 OyXFGNwSS6bGkRGlYG/Wsk2QONDBSv6bpV1w/QOmQa6WHYkV6N/2SyOyfva29skpsR
	 HSt+QyymuKlc3l8hvkotLybHFFnAaj48atMccQKzu3dZugOZJswUV43JNZayrtJyG2
	 ENa5YzCkTAlL8Rk5PdnpqHFQbVoi5TLo3pdHCy7pnZOmw4yK5LP7k4UUjx4NLy897K
	 HngYVALW7HNNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 05/11] selftests/bpf: Make skeleton headers
 order-only prerequisites of .test.d
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-5-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-5-c311f06b4791@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 20:23:42 +0000
Message-Id: <20260429202343.CB842C2BCFA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Moving skeleton headers to order-only prerequisites breaks incre=
mental builds and introduces a race condition for newly added BPF skeletons.
--

commit ac3be1ba89ba94d2363d76ee3f21b9f53e47cc23
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Make skeleton headers order-only prerequisites of .test.d

This commit changes the Makefile to make skeleton headers order-only
prerequisites of .test.d files. It aims to avoid unnecessary recompilation
and build errors when a skeleton is skipped due to BPF compilation failure.

>     Note that adding a new BPF skeleton via a modified existing local hea=
der
>     still works correctly: GNU make builds order-only prerequisites that =
do
>     not exist (the order-only qualifier only suppresses timestamp-driven
>     rebuilds, not existence-driven builds), so a brand-new .skel.h listed=
 in
>     TRUNNER_BPF_SKELS is generated even when .test.d is otherwise up to d=
ate.

Is this assumption about GNU Make's behavior correct?

If a target like .test.d already exists and its regular prerequisites are n=
ot
newer, Make ignores its order-only prerequisites completely. Because the
generated .d files only declare dependencies for .test.o and not for .test.=
d,
modifying a local header to include a new skeleton does not mark .test.d as
out-of-date.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 9a4d8bea0c18..608e6dff0392 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:		=
	\
>  $(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:			\
>  			    $(TRUNNER_TESTS_DIR)/%.c			\
>  			    $(TRUNNER_EXTRA_HDRS)			\
> +			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
>  			    $(TRUNNER_BPF_SKELS)			\
>  			    $(TRUNNER_BPF_LSKELS)			\
>  			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
> -			    $(TRUNNER_BPF_SKELS_LINKED)			\
> -			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> +			    $(TRUNNER_BPF_SKELS_LINKED)

Does this introduce a race condition or build failures for newly added BPF
skeletons?

Since the new skeleton is not generated before compilation in the scenario
described above, it could cause a missing file error when building .test.o.

Furthermore, if the new skeleton is concurrently being generated for another
test that does correctly track it, Make will not enforce dependency ordering
for the modified test. This could result in gcc reading a partially written
.skel.h file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429-selftests-=
bpf_misconfig-v9-0-c311f06b4791@suse.com?part=3D5
