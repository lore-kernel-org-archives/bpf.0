Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38A30569F
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931149; cv=none; b=PFRPmrviX1qN+uvvMxl3niERwPtIdFkPMKQnAhpGKpVsNms2ixkZf951vA+VhPlNr0JvSlshZ4b90fwwqxNNZIMHF1uI+jXQIB1W4Ci0ep5HwGtJmyTfwJ8NmWdfL4qHyHmzyAJWbS4C4q4J7IE+GQTuK5GVX8/4Mph2le7q91g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931149; c=relaxed/simple;
	bh=wb3Y6cZ/s2l67WA4V7ro0ef588j27JpT6K0wFGs7Ryg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AWikWBnsJC/Mmb9IQrZoHIm622+/D7ONO6tlAZPLBQiRVYO3uVSwwjdl4i8NW5aYixugHs2N2BlpCliFIR9kdORCFpmTDTslHqejzzwdshc6NYEVEd1k2Nli1mMBwinDS/lbTVo3EWMAjGO/kBLHl0iUwoa1YXWKKO4CKcctrdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5cnJ6UY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5cnJ6UY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE171F00A3A;
	Wed,  9 Sep 2026 05:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931147;
	bh=/aenwh6yYX3lzp4b00XpQfrYNZMRmUAG+fnwk1JQuLI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n5cnJ6UYm6ccXtce5hcG+ZTonngBONP8zr5Y1WMxzi3k3geooFvxzrPXM0+r6iQVS
	 kxr1uRDqg2Rc8PURH0+imTcLcoNIyrcAnZXWqj8wb0XMJZJeJ3JpSIT7OEdiZwGZbQ
	 rnbVH1Fy+js9XaZSaP4G7WaUUlAK0s+kiewcZ5Vn6KP6lIjieEKL7peICk6kiRZNM5
	 /21YF67FSWBYjFkB/pQqGvM1aCJYhMiNRYbb8QnaUywZWQog5KlKYVIjORqabVPzQa
	 fGlGEzbGduabceTaBVguHH26C2qzY8rXDoCN/8kmcP8pZG24i2NtF6VAmisC/3za53
	 fiiavF63eRiZA==
Content-Type: multipart/mixed; boundary="===============8074503251671006206=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de3bde21197b4014718b2d2fa9ac03f1f02e053a083040ab01560287bb8bb8b2@mail.kernel.org>
In-Reply-To: <20260909042907.1734153-3-xyx2021@mail.ustc.edu.cn>
References: <20260909042907.1734153-3-xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Reject task VMA snapshot use after destroy
From: bot+bpf-ci@kernel.org
To: xyx2021@mail.ustc.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 05:19:07 +0000 (UTC)

--===============8074503251671006206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add a verifier test that obtains a task VMA snapshot, destroys its
> iterator, and then attempts to read the snapshot.  The verifier must reject
> the stale access.
>
> Also verify that an RCU-protected task pointer remains usable after
> destroying its task iterator.  That iterator's empty destructor must not
> shorten the surrounding RCU protection.  The existing iter_next_trusted
> test continues to cover a trusted-kfunc use while the VMA iterator is live.

This isn't a bug, but would it read more clearly to tie the second test
to the MEM_RCU lifetime rule from the verifier patch (the RCU CS outliving
the iterator) rather than to the destructor happening to be empty?  The
kernel-side commit gives a different and stronger reason: MEM_RCU results
are protected by the surrounding RCU read-side critical section
independently of the iterator, so they would stay valid even if the
destructor freed something.  As written, the rationale points at a
property that is not the load-bearing one.  The closing sentence about
iter_next_trusted also only restates that an untouched test is untouched,
rather than adding rationale for the change.

>
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
> diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
> index 76012dbbdb41..b8c8a3b24582 100644
> --- a/tools/testing/selftests/bpf/progs/iters_testmod.c
> +++ b/tools/testing/selftests/bpf/progs/iters_testmod.c

[ ... ]

> @@ -66,6 +87,28 @@ int iter_next_rcu(const void *ctx)
>  	return 0;
>  }
>
> +SEC("raw_tp/sys_enter")
> +__success
> +int iter_next_rcu_after_destroy(const void *ctx)
> +{
> +	struct task_struct *cur_task = bpf_get_current_task_btf();
> +	struct bpf_iter_task task_it;
> +	struct task_struct *task_ptr;
> +
> +	bpf_iter_task_new(&task_it, cur_task, 0);
> +
> +	task_ptr = bpf_iter_task_next(&task_it);
> +	if (!task_ptr)
> +		goto out;
> +
> +	bpf_iter_task_destroy(&task_it);
> +	bpf_kfunc_rcu_task_test(task_ptr);
> +	return 0;
> +out:
> +	bpf_iter_task_destroy(&task_it);
> +	return 0;
> +}

This isn't a bug, but could the destroy here move above the NULL check so
there is only one bpf_iter_task_destroy() call, matching the other tests
in this file?  The function repeats bpf_iter_task_destroy(&task_it) on
both exits, where the five pre-existing tests in this file each have a
single destroy placed after the out: label.  In iter_next_trusted_after_
destroy the duplication is load-bearing (the destroy has to precede the
stale read), but here the same coverage is available with one destroy,
e.g. call bpf_iter_task_destroy() right after bpf_iter_task_next() and
then do the NULL check, which keeps the 'use after destroy' property and
matches the surrounding style.

> +
>  SEC("raw_tp/sys_enter")
>  __failure __msg("Possibly NULL pointer passed to trusted R1")
>  int iter_next_rcu_or_null(const void *ctx)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34312299210
--===============8074503251671006206==--
