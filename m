Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF636489880
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533902; cv=none; b=XT8teTPSDvBi3bRKB5N6vlbd4S6A3/Qvl83tJL1OgULZ4i3zWwLC/2k7k3SOUQEdA+jBQPFCbb8vkt3TMXiKukuMDZ1HBe1NthIIW9x4Bih2MbBiC42c32fg3noptqxSm/iWMN4yY308CuAXKTF686Ue0IGwuNdQ8zjXtb+Ihq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533902; c=relaxed/simple;
	bh=5yymTRsDeWV96GVI5Zr/FeQhkll+/4LUkJU/GB1avgw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qwd8mC/r5TNc0MbyIz3QdfnHSoz5VbqrbVDzT3EgUeg6ZuTEC7TugUebaqY2/y//MW5yw/V2xbKznGKFbPiCA1kR9Hkv42MJPtwJ7sZMyfPtpq5MB4zrWndauYwpNGwWHZVG3uiDb63A1ycGeqhdA5xClrTQnfEv2psT1dKH8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k55cph3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k55cph3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC951F00AC4;
	Fri, 31 Jul 2026 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785533900;
	bh=kLPZnKrG6CTUfcnq81OUJQYrrSjdL6mCYCb4FAZu5dY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=k55cph3A9GhiBv4C3LqSCAOq4NKRKQX04/4WZecmEBdwOtVDzJ+06hpNHJpI2XBPH
	 m2wtUmXgASlWcXToYUPPTewpia0HdCcOakCrtxNFl7TABu6HTJ+yAFq6TdYE3CA8V/
	 HrxCXtYBZ8tmtOZhk+SrdXsppgzsYccP6CIuoD0U1lw6CMwRjxkUEYVb/WvknXd/i+
	 Q3z2cn6rRqgdFRv9iViKeHlkjiUn84AHd+DvgvjVIRG7jHoj3wFrTg9aD/NdC2upn9
	 NMQQqPn7v5EqF14QvhcbkJV8zSncjlRDVQBiQNc6Q4SvzlTLONQelbvVxrzzQqUdLp
	 3QAyvs4cJV1QQ==
Content-Type: multipart/mixed; boundary="===============4348476322274397925=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f2e2ab963398c775f5eed7438c6c4054d61e3da6e0a7ae731b56813ad016ab1@mail.kernel.org>
In-Reply-To: <20260730102129.15209-2-vldsampaio@pm.me>
References: <20260730102129.15209-2-vldsampaio@pm.me>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Simplify cnum contains() by removing redundant branches
From: bot+bpf-ci@kernel.org
To: vldsampaio@pm.me,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,vldsampaio@pm.me,shung-hsi.yu@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 21:38:19 +0000 (UTC)

--===============4348476322274397925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
> index a90e317e3578..ac1f62a0195d 100644
> --- a/kernel/bpf/cnum_defs.h
> +++ b/kernel/bpf/cnum_defs.h

[ ... ]

>  bool FN(contains)(struct cnum_t cnum, ut v)
>  {
> -	if (FN(is_empty)(cnum))
> -		return false;
> -	if (FN(urange_overflow)(cnum))
> -		return v >= cnum.base || v <= (ut)cnum.base + cnum.size;
> -	else
> -		return v >= cnum.base && v <= (ut)cnum.base + cnum.size;
> +	return !FN(is_empty)(cnum) && v - cnum.base <= cnum.size;
>  }

[ ... ]

>     We've also run some benchmarks to compare the performance of the new
>     implementation, for example, for empty ranges, overflowing ranges
>     non-overflowing ranges. We've run the tests with O2 optimization.
>
>     Results:
>
>             | Test                 | contains    | contains_new |
>             | -------------------- | ----------- | ------------ |
>             | empty                | 1.511 ns/op | 1.479 ns/op  |
>             | non-overflow inside  | 1.156 ns/op | 1.270 ns/op  |
>             | non-overflow outside | 1.053 ns/op | 1.258 ns/op  |
>             | overflow high side   | 1.469 ns/op | 1.257 ns/op  |
>             | overflow low side    | 1.469 ns/op | 1.270 ns/op  |
>             | overflow outside     | 1.478 ns/op | 1.256 ns/op  |
>             | singleton inside     | 1.049 ns/op | 1.256 ns/op  |
>             | singleton outside    | 1.051 ns/op | 1.254 ns/op  |
>             | full range           | 1.053 ns/op | 1.256 ns/op  |

This isn't a bug, but would the changelog be tighter without the
benchmark table? The deltas look like measurement noise and several
rows show the new version as slightly slower. The substantive part is
the equivalence argument showing why 'v - cnum.base <= cnum.size' works
for both wrapping and non-wrapping cases. If the numbers are meant to
demonstrate no performance regression, would a one-line summary be
clearer?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30534991827
--===============4348476322274397925==--
