Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77A4A5C53
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145251; cv=none; b=BSlFIzvnZw9FhXZocaqFGUf04P3MF4WZPpII7DUrcefZVoN6UBjQnyZkaE+105JHhgCkpPXZ/xH0dOYtpIVK8LkkqCMcC2o2cUjF7Zo60GxHdaXNFdpRSi9Hh4yoFn2WnIojwoBrDZC5MBtvHsW/gQ6V2WcgknmeihVOi+dBzqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145251; c=relaxed/simple;
	bh=VsXMwijNuJUyBcKpQ+KcLDgwgxbnhof9iVwCgvNPQZg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GHigC3XmTnXAGsg3/hegPcA/BhAMmiQKGNxu0YNmImE2WFaik/xd2i0ifwk9djVPGPN7JZ4r4xKvUqnrFMah8k7aAfRkwpHSFPIluSHoEZxR6BrpfaxgzEv9JkEN1XT8OUpQaAeeDWABc8b0E57kxT7X5KpD9UQAdrPSbSBIwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvEp3JbQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvEp3JbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA98F1F000FF;
	Fri, 11 Sep 2026 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145248;
	bh=cBhmPTPbdaTJsvFqPKltaGV2PcI8nBP4sOy23/zdJzg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gvEp3JbQWg6DRsAG1p8Hof5ftzIjw/5EehYgm9hwi7+mk+9Q8T9h58444ObUdYyRH
	 UJsRNyRXroGNeApCF69xRpNN07zbHctBfHfZGy1+Blm5YMUEz20tXBJcwFDLUEsqYd
	 mAQOeoWmbg8rsd9dlqpCo0GefF9FcB1Ido5Cas2bLfG+vbeGM0w7oADux82zgBxS/X
	 4xXVL8BkLtJYzUbv2e8XJISP5xpG5zNMCAKEPrho80a6puGaqZ4kX1gYmZKw361djf
	 sc4SZKokqdzHRIN1YBNdbwKhT0eC+t3mvzhriqexT84+2DVqPoTO6VO9Js7UigF5d/
	 OlGI2WDI7ZZuQ==
Content-Type: multipart/mixed; boundary="===============8134328812421978661=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d6ca13c4e7f5b00fdc9bcea63467374b84e1e8facd74e2322f8e92f3d06a7a24@mail.kernel.org>
In-Reply-To: <20260911155025.2012309-1-yonghong.song@linux.dev>
References: <20260911155025.2012309-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 14/15] selftests/bpf: Add tests for by-value kfunc arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 16:47:27 +0000 (UTC)

--===============8134328812421978661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
> new file mode 100644
> index 000000000000..8b0e7aed1ff1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c

[ ... ]

> +SEC("tc")
> +__arch_x86_64 __arch_arm64 __load_if_JITed()
> +__description("aggregate kfunc argument: struct at the tail")
> +__success __retval(0)
> +int aggregate_arg_kfunc_tail(struct __sk_buff *skb)
> +{
> +	u64 a = 1, b = 2;
> +	struct prog_test_pair_arg s = { .lo = a, .hi = b };
> +
> +	if (bpf_kfunc_call_test_pair_arg_tail(1, 2, 3, 4, 5, s, 6) != a + b + 21)
> +		return 1;
> +	return 0;
> +}

Do these tests actually verify that arguments end up in the correct slots?

Looking at the test pattern: bpf_kfunc_call_test_pair_arg_tail(1, 2, 3,
4, 5, s, 6) expects 'a + b + 21', but the kfunc returns the sum of all
its arguments unweighted:

tools/testing/selftests/bpf/test_kmods/bpf_testmod.c:
    __bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_tail(
        u64 a, u64 b, u64 c, u64 d, u64 e,
        struct prog_test_pair_arg s, u64 f)
    {
        return a + b + c + d + e + s.lo + s.hi + f;
    }

The check is invariant under any permutation of values across argument
slots. It will catch a value that is lost, duplicated or garbage, but
not a value that ends up in the wrong slot.

Concrete case in this test: aggregate_arg_kfunc_tail is the one case
where x86-64 moves an argument down into a still-live register (BPF
slots a..e -> 0..4, s -> 6,7, f -> 5, so f travels through
BPF_JIT_ARG_TMP). If the scratch handling swapped f with s.lo, the
callee would read s.lo = 6, f = a, and 1+2+3+4+5 + 6 + b + a still
equals a + b + 21, so the test passes.

The same holds for the two halves of every 16-byte argument:
'(u64)(v >> 64) + (u64)v' and 's.lo + s.hi' are symmetric, so a hi/lo
swap of an __int128 or of prog_test_pair_arg is invisible in all nine
value tests.

The commit message states "Every test checks the value the kfunc
returns, so a misplaced argument shows up rather than passing quietly."
Does this hold if the values are commutative?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527
--===============8134328812421978661==--
