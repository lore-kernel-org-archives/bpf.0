Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA9326938
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418073; cv=none; b=NtAibRF3tnsKNHel4aH2ww37lQ2zYrKFFmIbNmmPaaaL2QNX3byl9Rv3J6McR5bm07Nxf89fKBRHrF+Y6dRkA8C8QaJLwIpQpUcqSpAE6shn06v+XiSO8BngAVj0VqBpoNdaSeg844x6nk/CEeCdfw4CTxGTnG17u4xVevbAOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418073; c=relaxed/simple;
	bh=x3QfeSelEbIV8yBPd1SM7Ja8hKAhXouNpN0IA87Jw9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EPegFv9vBSroMgCkwmk+EJcpGg6su+iGfIL9WPxaxVEMdVsA3VN60Ws7mmxBiDaYYn3g50FNx26XA9bweE3m3df/tQIU4UuDSXtH4tk+SDaT6ES2WxW1B4DioPh4SbxuivBWoZRlug5gh4BRUemVZnzCLDHQY9h7IuACJTk4C24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzJGwjne; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzJGwjne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777B7C2BCAF;
	Tue, 28 Apr 2026 23:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777418072;
	bh=x3QfeSelEbIV8yBPd1SM7Ja8hKAhXouNpN0IA87Jw9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KzJGwjne8P7/j7luw4h4SpSJtb6rg9koNdKvw1kYfAHi/yHX7gqAs3HDKe2HzLipO
	 PfWLudsA3CkQZmO4mVbUFfL789ytwPWtZ3xY8UJgYtCiQ3tDP1lkqWpohxGJ2P8szZ
	 MoqAB2wb2ovjahMuHIKhfucO9hctULtgkaDR7CiS5quWiVIcIvcAS2iwt+dH08edDW
	 gmywC6zCDwfNxDpR+4OK0yxEqB2QUzvXe64CmYQZp82b2FC8ewu1Q8YLDM9KUV2UGp
	 EfHBQ4RnCm8rVbReiIzhoHe/aUnL/KtrGQeREK8WE8f+EzmdzFHxVyZX45aRseQSAZ
	 Lz67yg5uRjeYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test insns processed
 breakdown
Reply-To: sashiko@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <30df9a4d569143e1d23a7c7aefd7dca85a21e2c8.1777388107.git.paul.chaignon@gmail.com>
References: <30df9a4d569143e1d23a7c7aefd7dca85a21e2c8.1777388107.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 23:14:31 +0000
Message-Id: <20260428231432.777B7C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Asserting exact compiler-generated instruction counts in BPF C s=
elftests makes them extremely brittle across LLVM/Clang updates.
--

commit a64551619d1c16e765011f494b0528e642a29308
Author: Paul Chaignon <paul.chaignon@gmail.com>

selftests/bpf: Test insns processed breakdown

This patch updates the BPF global subprog selftests to check the new verifi=
er
log breakdown of processed instructions by adding __msg() assertions with e=
xact
instruction counts.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index 1e08aff7532e..58faf5485667 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -46,12 +46,13 @@ __noinline long global_dead(void)
>  }
> =20
>  SEC("?raw_tp")
> -__success __log_level(2)
> +__success __log_level(6)
>  /* main prog is validated completely first */
>  __msg("('global_calls_good_only') is global and assumed valid.")
>  /* eventually global_good() is transitively validated as well */
>  __msg("Validating global_good() func")
>  __msg("('global_good') is safe for any args that match its prototype")
> +__msg("insns processed 7+2+5")

Will these exact instruction counts make the tests brittle across different
LLVM/Clang versions?

Because C code compilation is highly sensitive to compiler versions, change=
s in
optimizations or register allocation will alter the number of emitted BPF
instructions. This could cause the selftests to fail unpredictably across
different local environments or when the CI compiler is updated.

Could the __regex macro be used here instead to verify the expected verifier
log format? For example, using __regex("insns processed [0-9]+(\\+[0-9]+)+")
would validate the breakdown output without relying on exact counts.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5c3514dbc879f22ba3f=
9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com?part=3D2
