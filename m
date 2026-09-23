Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2AB40926E
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156007; cv=none; b=bZjPpcasD0OA5yyZ96g/n8OYQMG6tnohxd4zsxUV7bR5X/ZjoL0bSWBfKpLh1Qdx/nuYzGcilmJBPxpk3g/VM08Jw0ijgJQZfmHcGTkqWBhyxClzlkDwUvdOke+hIrbtAxZ9Ln8M1wcIdo5ZQjSGaFc1lbcJX1/QJhjrxFrNWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156007; c=relaxed/simple;
	bh=M2ONZLnONLv4S7GwXgmJTqWe9M2qNOleVsZQVg0pFKs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DchD6+p1uxBHzFCflkX7/k0dcQA5nqZJJkrFyoPcZ6fJ4McbGIavNu8IYM94IvZxCnPpGB8dT+Q1glqizfAyfObbQZNhw1soTR8asHpYW8LBMXLJ4aoqRi8xEK4GoPx05kAD905rTFVzy8I8BvcvtAYCnlQVyasNh/8WVkFd7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaJFEI1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaJFEI1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028711F000FF;
	Wed, 23 Sep 2026 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790156005;
	bh=NJnUnIVBtQGext0+8sI7klbYVOuogC8VSuSB5sg50Ok=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aaJFEI1LETuYyHynhpTNUAuufEnqW1mYZiCKH2yNbTl/vFnGHDrpwBofbhhix264Y
	 1VHh4MUP4L3DA+ImX9hvdK7AYcHFKPueVumek3VyYmw7pQ7b7Q0C0T5FJ9eqkM17k7
	 6H9Utayd7iwKgUM1wsaxF4EXfncbRQA9vEFa+focwthdCOs1J8eOgPoSRZHjFc7l60
	 R4jJmWfec9aSkmCvZ/5+iuMRRAa7Ke9x3GZaVUxNxjE9WdmaWurT1aya2dkwbUo3ep
	 eZqjwmfuCS67ZZSAUbCsnMoKQq0RcJhr9Sh+HVKjnRZbyGIXdzptzVYMCJpjxo48GQ
	 /hv6PeSQVZsZQ==
Content-Type: multipart/mixed; boundary="===============8141474796212962744=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <efee986c519785db11732f93c7552e9061e4efd40486e7e0b26c4c31ca68ed84@mail.kernel.org>
In-Reply-To: <20260923084201.2437625-4-memxor@gmail.com>
References: <20260923084201.2437625-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Test fastcall rewrite with indirect stack accesses
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 09:33:23 +0000 (UTC)

--===============8141474796212962744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> index a73b837553fb..5f54f542a622 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> @@ -502,6 +502,167 @@ __naked void bad_helper_write(void)
>  	: __clobber_all);
>  }
>
> +/*
> + * Load these programs without running them: removing the fastcall spills must
> + * not shrink the stack below an output buffer that has no explicit accesses.
> + */
> +SEC("tc")
> +__log_level(4)
> +__msg_unpriv("subprog 0 (helper_uninit_stack) main {{.*}} stack 64")

This isn't a bug, but would it read better to scope this comment to the
first two tests and give each of the remaining cases its own one-liner,
the way the jump-pattern tests further down in this file do? As written
the comment says the stack must not shrink, which is the opposite of
what helper_zero_size_buffer asserts (it expects "stack 0").

The comment accurately describes helper_uninit_stack and
helper_uninit_stack_caller, but helper_reads_fastcall_spill is a map key
whose only initialization is the fastcall spill,
callee_reads_fastcall_spill is a load from the caller's frame, and
helper_zero_size_buffer checks that the rewrite is still applied and the
stack does shrink to 0.

> +__xlated_unpriv("*(u64 *)(r10 -8) = r1")
> +__xlated_unpriv("...")
> +__xlated_unpriv("r1 = *(u64 *)(r10 -8)")
> +__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
> +__success_unpriv
> +__naked void helper_uninit_stack(void)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35840155529
--===============8141474796212962744==--
