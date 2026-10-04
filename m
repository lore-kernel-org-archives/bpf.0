Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241E042640B
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123889; cv=none; b=EwUz1hj1pnA2QDtZof07JiNzSiqcPkqFfTVrCVJ6wZqBPMqZoBteBGrVapRZwN4Wy6cqEAWC8yiIyCgB2/zjZBRMdeRl4JigeblVQ3XZfMlvo6gRrCw5TXEKzO53YUIUtUMV01igaR66SojMGbxnlzxERznwdyVRcNk3mTBYOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123889; c=relaxed/simple;
	bh=l64r4znobteugP7bPHeeFodzGAESnnbVOksi5pRJjKk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WdqdvdTmDQIp5sQXfsHJKadUePyBooWQenAc6Vm57c+YdVb/zPZF/1IHAGcUq5DYSgWXMzAcBe/Oa47/11lcF1efgBJXXZrvJPeYXtqQCmNXKrOCjmhKWqVDn7PF6XGUlQre+DJB31/HiFSxtygf//qsA9xmU9u6M48zHZKQZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1LzRVAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1LzRVAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749A51F000FF;
	Sun,  4 Oct 2026 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123887;
	bh=RibLr1hVmNhuy/l1SXmopiQGHeJFO/wjPpiw0Z1r50w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=C1LzRVAfrsANKwM2MZG1Tbg3klESzmn1W/bRIxdQ0NKZN5hUvqIwnusoEKd5jzQeW
	 Q28I8aEjLNeLiOMt7Uh9bwwMIjBEJA2WQUnxp3CpCgEha/oFiVfH6MHgxI9eMqQCWd
	 4Gw3KRaPeepnxMHP/StO11nVfFf31udCDtwc08bWzt5rgbjbg0yMV0xgofNPqzdfAi
	 IZ380rwBho2ysBgcEr1i0feeSnlWu+0AXCEMsJL4XKUsvrGwz9Jv0LDnMGO3SAbGEi
	 MQg4nrMj0GJJ99rjo97KDK8sx9l6HVKAq7344zIcrBLXnEreccZQyCGoFlS5QeQXgV
	 m99A0N9dRJVVw==
Content-Type: multipart/mixed; boundary="===============2983103081386283220=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0c504833af9f00f5936cfe83a93da17ab167da7ce6c10e4530840fa8ce9f7822@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-35-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-35-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 35/43] selftests/bpf: tests for may_write stack-liveness tracking
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:24:46 +0000 (UTC)

--===============2983103081386283220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: tests for may_write stack-liveness tracking

TL;DR: Test comment issue only: a new comment in verifier_live_stack.c says
one dynamic callback writes through ctx, but neither callback appears to
write. Comment or callback code should be fixed.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> index 0e6f25a09b5d..a06156c18c9e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c

[ ... ]

> @@ -2271,11 +2339,19 @@ static __used __naked void merge_leaf_read(void)
>  	::: __clobber_all);
>  }
>  
> -/* Same bpf_loop instruction calls different callbacks depending on branch. */
> +/*
> + * Same bpf_loop instruction calls different callbacks depending on branch.
> + * One callback writes through ctx. With no unique callback, all frames must
> + * be marked as possibly read and written, including at enclosing call sites.
> + */

The new comment says "One callback writes through ctx", but do either of
the callbacks write?

The callbacks this test reaches through mid_dynamic_cb()'s bpf_loop call
only load through ctx:

    static __used __naked void dyn_cb_a(void)
    {
    	asm volatile (
    	"r0 = *(u64 *)(r2 + 0);"
    	"r0 = 0;"
    	"exit;"
    ...
    static __used __naked void dyn_cb_b(void)
    {
    	asm volatile (
    	"r0 = *(u64 *)(r2 + 0);"
    	...

The comment above them also describes these as "Callback A/B: read parent
stack through ctx", so the new sentence contradicts both the code and the
neighbouring comment.

The new may_def expectations do not depend on what the callbacks do, since
analyze_subprog() calls mark_stack_read_all() and
mark_stack_may_write_all() for every frame when find_callback_subprog()
returns -2, and never analyzes the callbacks.

Should dyn_cb_b() be changed to store through r2 (for example
"*(u64 *)(r2 + 0) = 0;"), or should that sentence be dropped?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============2983103081386283220==--
