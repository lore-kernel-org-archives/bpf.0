Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC43A6B9A
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433168; cv=none; b=BG8ld/wuUX65D4PP3CBZWROGuuVVLHHAf8NWeh6E0NxMGb7nfvYR2nD1MOPiOjUvsaDssF32LV8GpMBjOxRynbiwo6vUo5EUax7HRmcoVlbyfbLywc3rWt0K6cVMgyqAF9iAHERq4llNujiDUYC3iZFxkJBo4PPRp9KQqcNinPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433168; c=relaxed/simple;
	bh=56YJvxnpYyYfg81ANO3ilgJFa3WxjMdZE+mFn/2xP14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H0pDodJQD9fIffKjBzZqej3wf7Chps7ufCuBfzcC/Rw/YsPtHOcPYH8kdi+fFmPbJblaVMaD/0YIeRUqXE26ZePBz6OI/WBJ8d2SQASi+RdYAU9ykZZ0G+vm0PeWjYBc8E0XobPDZ+WuPcdRJ3Op0nLQoTD3OcLBodaegkHjtkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaS3WcfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaS3WcfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EDC1F000FF;
	Sat, 26 Sep 2026 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790433166;
	bh=+HnTUDnE2MaIndim0re07l058s2jmfLg2u4CuYPgMb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oaS3WcfMd2PB1kMDp6jwdsShAPrNyvJhURZ1n/zLCs+tjoxzZcchoZXVi4DdDx3PR
	 izQ/VJMh4JZsWp7F1mfwufkAflmgTHfth+/zk67Ez9k4AlIldLNvjtq2htDE6GQqE9
	 hqtqsJmOEowgNkBeuLJCOgH94NMgjEUpP4sILMK0B9p0rGtvSI0inv37tSxtJROcwR
	 pAEYVKYls49yM+b3BAft6olX2O0dqOyw9OQW9bCL+397SSnpjznmOX7xJsE+QetoYU
	 xAZIXNm1n0O4GpswhWA7g9ZT0UfEYpmro1S+b/DezVrnYnNCw4l//x/co9WmkJthdS
	 0b9pEF1spZoHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 28/36] selftests/bpf: test for stack-pointer
 subrange pruning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926-scev-minimal-rebase-v1-28-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
 <20260926-scev-minimal-rebase-v1-28-c8e5ab5ba79f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:32:45 +0000
Message-Id: <20260926143246.49EDC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: incorrect multi-line comment style
--

commit 928bc76d46def360ecb11c2c10278100fdf80716
Author: Eduard Zingerman <eddyz87@gmail.com>
Subject: selftests/bpf: test for stack-pointer subrange pruning

This commit adds a test case to validate widened stack pointer subrange
relations in regsafe(). It checks that a widened stack pointer with range
[-64, -8] is treated as a superset of [-56, -8].

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_ptr.c
> index 3e0bea9819cab..5da8b9a6018cf 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
> @@ -586,4 +586,37 @@ __naked void stack_check_size_512_with_may_goto(void)
>  }
>  #endif
> =20
> +/* Verify that old PTR_TO_STACK state is considered a super-set of
> + * new PTR_TO_STACK state when new variable range is a sub-range
> + * of the old range, e.g. old [-72, -16] vs new [-64, -16].
> + */

[Severity: Low]
Does this violate the BPF subsystem multi-line comment style? The BPF=20
subsystem requires multi-line comments to have the opening /* on its=20
own line, with the text starting on the next line.

> +SEC("socket")
> +__success
> +__log_level(2)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +/* r7 is widened to [-72, -16] at the loop header (insn 3),
> + * the loop body sees [-64, -8] after 'r7 +=3D 8'
> + */

[Severity: Low]
Should this comment also be updated to start the text on the line following
the opening /* to match the subsystem standards?

> +__msg("loop header at 3, widening r7 to -72..-16 step 8")
> +__msg("R7=3Dfp(smin=3Dsmin32=3D-64,smax=3Dsmax32=3D-8")
> +/* back-edge state is clamped to the remaining iterations and pruned
> + * at the header, because [-64, -16] is within the widened [-72, -16]
> + */

[Severity: Low]
Would it be better to adjust this comment block as well to ensure the openi=
ng
/* is placed on a separate line?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-scev-minim=
al-rebase-v1-0-c8e5ab5ba79f@gmail.com?part=3D28
