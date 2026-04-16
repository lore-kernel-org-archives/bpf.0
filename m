Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729E3B47C1
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348198; cv=none; b=TO+f2Az7N7VbZRBEmomFyowGE6Y19OVY4c0HvTEP+C76+11Iihrp/4yHe5b2d4tLB7XoAWDOTmUlR7PFiv2VzvoxHCVzGPBPnj0zLthfn1yorpjdEqF36iHf+P/lWb83AMGIRgDtxvPmVVwFqCFsfazMZzsnRjp+XDpuuOV7gwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348198; c=relaxed/simple;
	bh=Rc0nHgFqyKK6noXq+bsHK12NAMgtqrnQ+R/qdZygFOI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ut0Ifd0xln164IdXA1DQ9sNEbCWxHgwdWSbCOATTBdqH/VS3MDAr8OUEmG6R502NQbN3GVnB7gwsedpDAZ41GNEtGnDeItKYxeA3RmKmzg7F5pZfELZhHIuNDX5kc3J6WchqHypYABytQMB8IX5H8cwKfPfzqCJWYMNhYGx4fQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsKf1wnw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsKf1wnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8B0C2BCAF;
	Thu, 16 Apr 2026 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776348198;
	bh=Rc0nHgFqyKK6noXq+bsHK12NAMgtqrnQ+R/qdZygFOI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZsKf1wnwldLkTbhRpflUdOY4G2/i6yhSQZEDlV7yiwbTSYdu1zwPuCITOFj8qtqVM
	 nRRYyyewj4hl+xZVnziiS6iXvWj/nFWqQ7/fiRqYuI0heiWiuEqPN1sKgFcSOhzEnH
	 cRmiN/uDTDZ0GdBawgZBT8F2aJ+vmfWbAdWDIGamHgOcuT5YL8zeFBHq5m4pnqQ/u6
	 S2hiNtsRLNut/TArHSw7U4lhsKyBlYr1NMUSXjsSwaaFLVzt0oF8VFHXj6Fpq1rdz0
	 zM8t3aqHyU5E2G8vG2S5h7FOpobGixisTJ1u2H00wjafZM8fWlDblpxx9XMgH2MA1s
	 b1kSQpRA1xBMw==
Content-Type: multipart/mixed; boundary="===============3561077641524916323=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <359bf9b7aa048d9fa626961b925c1b7545e520b088f59560b050e9bc9ac92f27@mail.kernel.org>
In-Reply-To: <cf4061f2e91d271f1f44160a0b87a87ec6df5428.1776344897.git.paul.chaignon@gmail.com>
References: <cf4061f2e91d271f1f44160a0b87a87ec6df5428.1776344897.git.paul.chaignon@gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/7] selftests/bpf: Test for empty intersection of tnum and u64
From: bot+bpf-ci@kernel.org
To: paul.chaignon@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,harishankar.vishwanathan@gmail.com,eddyz87@gmail.com,koike@igalia.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 16 Apr 2026 14:03:18 +0000 (UTC)

--===============3561077641524916323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index c1ae013dee29..151c7a479a6b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -2184,4 +2184,29 @@ __naked void tnums_equal_impossible_constant(void *ctx)

[ ... ]

> +	if r6 s< r1 goto +2;								\
> +	/* On fallthrough, r6's u64=[0xe00000002;0xf00000000] */			\
> +	/*                      tnum=(0xe00000000; 0x1ffffffff) */			\
> +	if r6 s> r2 goto +1;								\

Are the inline comments placed correctly? According to the
verifier log in the commit message itself, on fallthrough of the
"if r6 s< r1" instruction the state is:

    R6=scalar(smin=umin=0xe00000002,
              umax=0x7fffffffffffffff,
              var_off=(0x0; 0x7fffffffffffffff))

The u64 upper bound at this point is 0x7fffffffffffffff, not
0xf00000000. The values u64=[0xe00000002;0xf00000000] and
tnum=(0xe00000000; 0x1ffffffff) only appear after the
"if r6 s> r2" fallthrough. Should these comments be moved below
the "if r6 s> r2 goto +1" instruction?

> +	/* On fallthrough, r6's tnum=(0xe00000001; 0x100000000) */			\
> +	/* It doesn't intersect with the u64 so the condition is always false */	\
> +	if w6 == 1 goto +1;								\

Similarly, tnum=(0xe00000001; 0x100000000) is the state on the
true branch of "if w6 == 1", not on the fallthrough. The commit
message verifier log confirms this:

    from 8 to 10: R6=scalar(...,
        var_off=(0xe00000001; 0x100000000))

Would "on the true branch" be more accurate here than "on
fallthrough"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24513066291
--===============3561077641524916323==--
