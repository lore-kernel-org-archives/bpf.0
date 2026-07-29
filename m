Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7D395AE6
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357622; cv=none; b=Fi1K/Hl6RuVLdMCohg2gNK0blSiWD949LVc7pvvCf7ag6qqXO+NqpUMafKJcerIT6oozj6bb8g2r83/kre2oxn0w39znevWwDlx32H96SYBJj8Pi0jWmXgs4AnlZXtn8S9Mg4XNCR23ISmlGm4N6TIzpUo1TiU5xTGvXMJPnX/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357622; c=relaxed/simple;
	bh=OeCxYs4/4boB7lpYprQLhuixNJeIPogCX9Nr0jJaosg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZWQRqzC7OVPq5ogLFzY6qd7kvshx0NAhXSXhqNON0oDypS8QW3RVsoFIaBCAmWI4y8zsRScINmu2Qu5FmMGy0LUNLttmu0QC+/phW//X0hCxwr1Ve/AeQ61wixfeFgPi0J/VPqiOByL75tzmVUTcrPXwa8Sz0LSCrGxylm61B74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmV7crPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmV7crPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49971F000E9;
	Wed, 29 Jul 2026 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785357611;
	bh=ryYT9sh6Pi2QC2DxYxrNW3hK2NisHQwWDpCxl7WjIBU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CmV7crPdPD7MwOIbHtn58NVOtzCxisTuAgIrYXAVvWtyRxGRRh6QzH4dUxUo7hj95
	 BKNBe5qKp8edlJokcXrpAFMmoleoULhmLKl8Lr8BHJ33/ZtxjPje0gE8RP49OzaT+3
	 TG4KyrsmTSQNA82IMuY6JMq12Wq0KQ6GVlN7kbczsD0QxymkcseqIdltkqRj+VKQYq
	 iiuhNKV4LpXXLaUm7uqskztbyYJgbNri2gWvKyVDRiuuk/anteRsosaI3oxe50CGwx
	 BtFCIv8cLDwISjNmzH50+GHXYyB1+rOHe4DPfK8Pf8dUSMK+5QWWB8xt0KMDpPcz91
	 wvm9qNii8quSQ==
Content-Type: multipart/mixed; boundary="===============5758622113819775467=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0e15ace88b847a4a307530925c47c092b8182c820ba512f48a1da3e9a463b3a6@mail.kernel.org>
In-Reply-To: <20260729194932.292368-2-vldsampaio@pm.me>
References: <20260729194932.292368-2-vldsampaio@pm.me>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Simplify cnum contains() implementation
From: bot+bpf-ci@kernel.org
To: vldsampaio@pm.me,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,vldsampaio@pm.me,shung-hsi.yu@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Jul 2026 20:40:10 +0000 (UTC)

--===============5758622113819775467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Simplify cnum contains() implementation
>
> This patch introduces a optimization for the contains() function.
>
> Bearing in mind that a non-empty cnum represents a inclusive circular
> range in the corresponding unsigned integer domain, membership could be
> tested by checking whether the distance from the range base to the
> queried value is within the range size.
>
> This makes the explicit wrapping and non-wrapping cases in contains()
> unnecessary, since:
>
>         v - cnum.base <= cnum.size
>
> is equivalent for both ordinary ranges and ranges that cross the
> unsigned wrap boundary.
>
> We've also run some benchmarks to compare the performance of the new
> implementation, for example, for empty ranges, overflowing ranges
> non-overflowing ranges. We've run the tests with O2 optimization.
>
> Results:
>
>         | Test                 | contains    | contains_new |
>         | -------------------- | ----------- | ------------ |
>         | empty                | 1.511 ns/op | 1.479 ns/op  |
>         | non-overflow inside  | 1.156 ns/op | 1.270 ns/op  |
>         | non-overflow outside | 1.053 ns/op | 1.258 ns/op  |
>         | overflow high side   | 1.469 ns/op | 1.257 ns/op  |
>         | overflow low side    | 1.469 ns/op | 1.270 ns/op  |
>         | overflow outside     | 1.478 ns/op | 1.256 ns/op  |
>         | singleton inside     | 1.049 ns/op | 1.256 ns/op  |
>         | singleton outside    | 1.051 ns/op | 1.254 ns/op  |
>         | full range           | 1.053 ns/op | 1.256 ns/op  |
>
> You can check the full implementation of theses tests on this repository:
>
>         https://github.com/OpenSourceVerif/open-verified-artifacts/tree/cnum-refactor-verif/cnum/benches
>
> Lean4 proofs showing that the new implementation preserves soundness of
> this operations are available at:
>
>         https://github.com/OpenSourceVerif/open-verified-artifacts/tree/cnum-refactor-verif/cnum/lean

This isn't a bug, but since the table shows the new form slower for the
non-overflow and singleton cases, would it read better to describe this as a
simplification (one uniform branch-free predicate instead of a wrap/no-wrap
split) rather than an optimization?

This isn't a bug, but could the changelog wording be tidied on the next spin:
'a optimization' -> 'an optimization', 'a inclusive circular range' -> 'an
inclusive circular range', 'theses tests' -> 'these tests', and 'soundness
of this operations' -> 'soundness of these operations'?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30487300521
--===============5758622113819775467==--
