Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D79347BDC
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625783; cv=none; b=DbB83caX28nEhDOrUOVoFhMyKYlVZKJuw5NsJtRZXk2qZdz2/jVWbth7+DoT+iUqv2tieY8Kn0rbC4Yi3cMH9ln9okRaK3liRA+118ShooGuLEDaupyQdRThM3ba8Ys26x3nkiNfjh6gK1sKQRbkOMypD8aBsPM6rR+FlL3t4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625783; c=relaxed/simple;
	bh=9AXSD3v37Xj2DgbX8V7nhth08mwPilLiRATPcmYWccA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SnP/+14eprvnErhKAFIE2fvzNYJ7f/LuD13P2bS5ZCqpc3ihCdXOB8FtLiNXbSKzWFfGx3yKh6gSZXHNAaRpiaajUNt8oDHVpo25e515vR6ldFm34tVu24DIe1u71FR4xip0MQCezaoG/ahmzh9kKUUS4AERDy99lBWsRDxoZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ3PeDL7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ3PeDL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFAA1F000FF;
	Thu, 17 Sep 2026 06:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625781;
	bh=/pK0Lx5z3Z07D1obKvFu7qh3+hdrhIiquOTDmJeMgHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YQ3PeDL7KKimFz3yK2w3JBIgGEeswLY9MLy2EH3uVlZ3iXM5rEeplq33NgsREzKPB
	 Mbdj1ek5rOCKOoFYEUnX939i18Cs6qou438BbPuw7uvSQmAQlk/xvoLAscd7Y8Eqqd
	 tpYpAR0u7WhRVqOijygo2jQxOZDy6q0xvEe/3y7pl0iiYGmN5a0vcN8osX3rM96q42
	 Vz0B1uDwqAj7isrDLQCiQPYFhCTvSzkD1KM69eRaCoSRecF5+IBXemng6dZWC3m6mJ
	 F0s1tVkXQBRURsIQ1E0fIwIMgLExsijpJk5kZoPEmH4xh5TXJeaFJqHKpMJE1MDZbd
	 jJMsBnwyl/w0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 19/20] selftests/bpf: Cover the exception
 cleanup shapes the chain does not reach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917055823.3935111-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055823.3935111-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:16:20 +0000
Message-Id: <20260917061621.6DFAA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comments violate BPF subsystem style
--

commit 621c13df81280f1c0c32e09255ce8c64860bd768
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Cover the exception cleanup shapes the chain does not reach
   =20
The end-to-end test walks one call chain with a pad in most of its frames.
This adds the shapes that chain does not reach: a callee called from both a
covered and an uncovered site, a pad that reads its frame's callee-saved
registers, a tail-call-reachable callee, a tail call that is taken, an
extension standing in for a covered call, a pad in the main program's own
frame, a record covering bpf_throw() itself, a record covering only a
nounwind call, a throwing subprogram named by a BPF_PSEUDO_FUNC, a region
ending on a 16-byte instruction, a pad that reloads from and writes to its
own frame, a pad two frames up, a pad that calls a subprogram which tail
calls, an extension carrying a table of its own, and a pad terminated by
_Unwind_Resume rather than bpf_unwind_resume.

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> index d1e45b765af26..ffc0b95191681 100644
> --- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> @@ -212,6 +212,9 @@ static void test_shapes(void)
> =20
[ ... ]
> +	/* The same call site either way: the subprogram's throw unwinds into
> +	 * this frame and runs its pad, an extension's stops at its own boundar=
y.
> +	 */

[Severity: Low]
Does this multi-line comment in test_shapes() violate the BPF subsystem sty=
le?

The style guidelines prefer the opening /* on its own line:

	/*
	 * The same call site either way: the subprogram's throw unwinds into
	 * this frame and runs its pad, an extension's stops at its own boundary.
	 */

[ ... ]

> +	/* A tail call that is taken: the walk ends at the target, so the cookie
> +	 * comes back from there and this frame's pad does not run.
> +	 */

[Severity: Low]
Could this multi-line comment in test_shapes() also be updated to start the=
 text
on the line following the opening /* to match the preferred BPF style?

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.=
c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> new file mode 100644
> index 0000000000000..f5eb2ff15c896
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> @@ -214,6 +214,9 @@ static __used __noinline __u64 tc_thrower(void *ctx)
>  {
> +	/* Never taken; its presence is what makes this frame, whose spill the
> +	 * walker reads, tail-call-reachable.
> +	 */

[Severity: Low]
Is this multi-line comment in tc_thrower() formatted correctly?

The BPF subsystem style requires the opening /* on its own line for multi-l=
ine
comments.

[ ... ]

> @@ -311,6 +311,9 @@ static __used __noinline __u64 tc_taken_callee(void *=
ctx, __u64 x)
>  {
> +	/* Never true at run time; the verifier cannot know that, and its
> +	 * unwind out of here is what keeps the caller's pad alive.
> +	 */

[Severity: Low]
Should this multi-line comment in tc_taken_callee() also be adjusted so the=
 text
starts on the next line after the opening /* marker?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917055645.3926=
444-1-yonghong.song@linux.dev?part=3D19
