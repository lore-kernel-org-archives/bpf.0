Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B22BFC7B
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393077; cv=none; b=exDLzBs0ORY492CuOemoN9ZzXZpIIpxVbp2qMh3vNQy+eyMOP64jdR9wA+3coDaUcPd4B5PMSU9YB6eFrNWMl4s5Coy/Ay6Nc25KdOiKv54tz94o5p+VoEM9MU7S/don14kR2ad7qCPCCRjJTu6TmA4Le/KI0Y7qI5/WwepeAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393077; c=relaxed/simple;
	bh=ccPZuaxZjN5t7AKIs29fPQ7Iji0n69tM1avTE8SyAFM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qLyOVICJM+Y1KSszXKuO7mWoEUch8LtBZVq9SDRIryUg4Ck5u4Sxgkyna004/uJQX6HOOjioqZe6WKMz25pB4uGDpUWfWXU4Bq0I3NwK5fGlaLU/F8hhV0jzGaXmWAuyvPMYAMpGX7dCPsVJKUB9NNjpTIxeQsa9rAmTNUnHYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5DpAaWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5DpAaWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591A91F00A3A;
	Thu, 25 Jun 2026 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782393071;
	bh=OzzDrAjEQrFqiiXgwAVZlk/pCr9xXnIifv+1qDqnutQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z5DpAaWAlYT/kgimjB2jpYCJeUdCKi4KwrSI9NGmavtHQQWOJhD48UOAeOBytC921
	 Tm7yYnXvWqkOe23LChM/zLKh4Mpn3ZNI+9lye6TjYY7Nkz/fMtrN/kTXpIotgxeedz
	 QrIRF6RcsoR9POWTEop82wuozgjm/1rlAABMpDMpjareY/sQAfZpQv7b92wOHE5Yhd
	 OmwB7LjQggQgL3xqq1B8lyj64/phsvza29TgeV5W3oXYj2c82u3A+mMVSpd2isbXuu
	 cvWw44qN1l1ZGjrHEXFSd0T1zyB182jVlIyYHc9ALs7viJ1+qiVGVSpPlryQFvcyKa
	 lboI3KC24RmNA==
Content-Type: multipart/mixed; boundary="===============6089853769414367073=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dd8043a6e5bf160f0fae5bb519b0d12c3c85ffb203439ee6663b4459f7a3a312@mail.kernel.org>
In-Reply-To: <20260625-bpf-stack-var-off-zero-v1-v3-2-a068210a761b@gmail.com>
References: <20260625-bpf-stack-var-off-zero-v1-v3-2-a068210a761b@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Cover stack reads from zero spills
From: bot+bpf-ci@kernel.org
To: random6.xyz@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,random6.xyz@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 25 Jun 2026 13:11:11 +0000 (UTC)

--===============6089853769414367073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> index f345466bca68..24cd0a763673 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> @@ -59,6 +59,116 @@ __naked void stack_read_priv_vs_unpriv(void)
> "	::: __clobber_all);
>  }
>
> +SEC("cgroup/skb")
> +__description("variable-offset stack read preserves spilled zero")
> +__success
> +__log_level(2)
> +__msg("mark_precise: frame0: regs= stack=-8")
> +__msg("R3=0")
> +__retval(0)
> +__naked void stack_read_var_off_preserves_spilled_zero(void)
> +{
> +	asm volatile ("					\
> +	r0 = 0;						\
> +	*(u64*)(r10 - 8) = r0;			\
> +	r2 = *(u32*)(r1 + 0);				\
> +	r2 &= 7;					\
> +	r2 -= 8;					\
> +	r2 += r10;					\
> +	r3 = *(u8*)(r2 + 0);				\
> +	r1 = r10;					\
> +	r1 += -1;					\
> +	r1 += r3;					\
> +	*(u8*)(r1 + 0) = r3;			\

This isn't a bug, but these new tests use the load-byte-then-use-as-
pointer-offset trick (r3 = *(u8*)(r2 + 0) followed by r1 += r3 and a
write through r1) that the existing tests in this file annotate inline,
for example stack_read_priv_vs_unpriv carries comments like
"/* dereference it for a stack read */" and "/* add it to fp. We now
have either fp-4 or fp-8 */".

Would a short comment on the r1 += r3 / write step here (and in the
other three new tests) help match the surrounding style and clarify
what each test is exercising?

> +	r0 = 0;						\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28170733419
--===============6089853769414367073==--
