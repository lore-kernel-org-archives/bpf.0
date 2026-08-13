Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058B3806A6
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655463; cv=none; b=TBjw0EkhciyFPgdeoFv44zLXdN4eGOLqU5uLP9IIQDhpCU85zRBpoq2BBlJ+3/t2NYo7TmURlpqAUm2K/HTtc16vno1GpoRiSE5uTKlD6eWCFmyBsjGK7mVfYKWnou4QtkV5oRMvz+eTlQlZR1G1Lu6IlOXJBuYOLYv/AlzrjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655463; c=relaxed/simple;
	bh=RAkYgSiYVWwMGpCN36yp1GN12qTRxut3olq1By17cXE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d1Iik9J8mNjpv2/h6n28Dh1fhWKIdkSKDbJ9MZXWlk32wn1yJOpjrcy6qhoDP7s3VOwRZvDje6cLEVxpXUmZ5vG+9OOK17cYgriZlrzbCNYap7Fa7zyKwPGFyHrXcLpkynJnLbVqSA9ejhOafSowdzubMq8dWm1VNtRXnA+U4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnPw61ts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnPw61ts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688891F000E9;
	Thu, 13 Aug 2026 21:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786655462;
	bh=YLH6EZv+OYsPg4dGWN7T5WAyKXOjrek1Bu+8OyAYvIs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SnPw61tsTTKhZ3mgKUAaIiQDVlorrFaq2XxZuzmTfKHqIo2wGIUe1XDA8fXYnFC0Y
	 4zMzYzAaDZWfVMy4Y+si1slRaxrc1lsM8HHffOmBNc0vOxcbF+nWGmn3I0wr0CWIbU
	 u6N+F8pWcXesBpHCs4pVZarGFL7sJtvGJntUmZCJcWj1fyMSSZ2eA1QSo08D9gsjF7
	 fe4IBmXZCIAgsNL7Vx1GBold6JjV1kZrQ31bnG1MCDtO2s0VrowLbfxSKL+3sjwpVV
	 N4Plsdjn0b0SPv1zPunuXWkBVrNA0FkwnuBSS3S7eMHDlp+vZYWhdH3fA9WCV305o2
	 CHxh3M3qT2JjA==
Content-Type: multipart/mixed; boundary="===============7723164624494569263=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2435b43ae3c7dfdfac13b28256ec34050ed7a7d6b358337263b2c52003476ece@mail.kernel.org>
In-Reply-To: <20260813200256.1996809-1-yonghong.song@linux.dev>
References: <20260813200256.1996809-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 09/11] selftests/bpf: Add C tests for 16-byte returns in R0:R2
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 21:11:01 +0000 (UTC)

--===============7723164624494569263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c b/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c
> new file mode 100644
> index 000000000000..83b1a3751988
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c

[ ... ]

> +struct pair {
> +	__u64 hi;	/* R0 */
> +	__u64 lo;	/* R2 */
> +};
> +
> +union upair {
> +	__u64 halves[2];
> +	struct {
> +		__u64 lo;	/* R0 */
> +		__u64 hi;	/* R2 */
> +	} parts;
> +};

This isn't a bug, but struct pair puts hi in R0 while union upair's
parts puts lo in R0 - was the inverted naming in the union deliberate,
or would matching the struct's order (or first/second) make the R0:R2
mapping easier to follow?

> +
> +static __noinline struct pair make_pair(__u64 a, __u64 b)
> +{
> +	struct pair p = { .hi = a + b, .lo = a - b };
> +
> +	return p;
> +}
> +
> +SEC("tc")
> +__load_if_JITed()
> +__success __retval(0)
> +int aggregate_ret_struct_c_test(struct __sk_buff *skb)
> +{
> +	__u64 a = skb->len ^ MIX_A;
> +	__u64 b = skb->len ^ MIX_B;
> +	struct pair p;
> +
> +	p = make_pair(a, b);
> +	if (p.hi != a + b)
> +		return 1;
> +	if (p.lo != a - b)
> +		return 2;
> +
> +	return 0;
> +}

[ ... ]

> +static __noinline union upair make_upair(__u64 a, __u64 b)
> +{
> +	union upair p;
> +
> +	p.halves[0] = a + b;
> +	p.halves[1] = a - b;
> +	return p;
> +}
> +
> +SEC("tc")
> +__load_if_JITed()
> +__success __retval(0)
> +int aggregate_ret_union_c_test(struct __sk_buff *skb)
> +{
> +	__u64 a = skb->len ^ MIX_A;
> +	__u64 b = skb->len ^ MIX_B;
> +	union upair p;
> +
> +	p = make_upair(a, b);
> +	if (p.parts.lo != a + b)
> +		return 1;
> +	if (p.parts.hi != a - b)
> +		return 2;
> +
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277
--===============7723164624494569263==--
