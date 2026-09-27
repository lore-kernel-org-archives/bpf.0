Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF83BCD2E
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540815; cv=none; b=PbcaTgdF3bHpXsqbRIJNiLLiGmrv5WfKPyFRdW57mM5qSWR6LqIYjFzr4TmW9DZLrp4asxCwX4CsG8mFe+VUiWEDDBGs/84is/MaihUOA9Siy6pZg+ibT7y2Awey7Gz4SewsCNsT/YeF+D1CqV6ABc3Qtr1931G9R/Q4NulLvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540815; c=relaxed/simple;
	bh=klhtB2S7CYRriVd6b/vLuELRxhiwW4EmaDWW4sxlQHo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DQdLe6gCffxE0mr36zgPRKkD8A7l4lf/du8ByMPAHB7a6Ff9yBiHsxPsghxFE8M5nFnlkfo+cUHUeXawYfbBwVYsjM1atONBX7XaaJts5y4GyVH0O87JN2arKL4lgl8d5Sa8OjEet+Sl80B4OVpgGLHySsuciyXCbdoCuZx9v90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ/k65cZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ/k65cZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468361F000FF;
	Sun, 27 Sep 2026 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540814;
	bh=LMTJlp32q4tqsAkXZF8x6leuhW8+1Tc08+gDk3HY97Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TQ/k65cZgjxEZ4ML01uoxewwQgfvdZm0/tSvhAN5eqrfHEc0rEo9iiHoOyxE9a9DW
	 uBsYkMzy8du6NDtxryu3EsFiNISGvXSKoBnJL1Ln5LzWkqbi7Ua4TqMTTSwDczTp2w
	 hY5qsi1lXs4YApCtqjuB8X7NBYdBuSzxLly7gayf+tLoo5+GblsmjCxEjnuBClPrEL
	 l2w7DLUahx5gHU1mKiSzWc7pBwi+0j2d/o79RxDkQ0P4cp8W+JGL5rkBpgJagMymE9
	 ZpLhkhYsDLXQsBdJTxSPZu6hAzE/6KNdD9SGRG1e84aHpodCyjbKuLY8XFPo4Y+J19
	 6uWJ8eBlltkoA==
Content-Type: multipart/mixed; boundary="===============4796668457213806794=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b6ff0f4a91de2a23e3a57f7d0ba5de9d5d773cb600f9fed6dc1fc35f47711270@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-28-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-28-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 28/36] selftests/bpf: test for stack-pointer subrange pruning
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:26:53 +0000 (UTC)

--===============4796668457213806794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: test for stack-pointer subrange pruning
>
> Validate changes from:
> "bpf: allow subrange relations for PTR_TO_STACK in regsafe()".
> Add a test case that checks that a widened stack pointer with range
> [-64, -8] is considered a superset of a stack pointer with range
> [-56, -8].
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Do the ranges in the commit message match the test?

The changelog says the test checks that a widened stack pointer with range
[-64, -8] is a superset of one with range [-56, -8]. Those numbers appear to
be the example from the regsafe() commit 0516ad0f46c2 ("bpf: allow subrange
relations for PTR_TO_STACK in regsafe()").

The test itself starts r7 at fp-72, and the loop header runs 8 times (r6 =
0..7), so the verifier widens r7 at the header to [-72, -16]. The back-edge
state is clamped to [-64, -16] and pruned against that. The test's own
comment and __msg strings say this:

>  * of the old range, e.g. old [-72, -16] vs new [-64, -16].
>  __msg("loop header at 3, widening r7 to -72..-16 step 8")
>  __msg("loop header at 3, clamping r7 to -64..-16 step 8")

I traced this against bpf_widen_scev_regs()/linear_bounds() (-72 + 8*(8-1)
= -16) and bpf_clamp_scev_regs() (cnum64_intersect([-64,-8], [-72,-16]) =
[-64,-16]). The comparison the test exercises is [-72, -16] vs [-64, -16],
not [-64, -8] vs [-56, -8].

Could the changelog be updated to match the ranges the test checks?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============4796668457213806794==--
