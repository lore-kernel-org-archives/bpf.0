Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491766;
	b=ELeSfoD8uISwvCUMnqdT0Ds1CFdCjk68EVJvY6UOp77sySTXu2tVxZ5N5WVXXHYOtvdu
	 eNDjfSbCCbqudbF9Zo7eIPK/mRiQsVfwfWVhK0lrxjyNP66h4oyVmJ+HAujK8Ux3sc50k
	 UlNFO4yWfOdXH1hkdrbzs7JhUeQh5WXrOM44ddRJgw3FcPY/mQp/r8mdMhUGnZINr9/81
	 2jy2leCcuQnKsxqENzDbkIInjpzgDMVW2YexWJUfbx9kaNZsSnC7MdRjwZIopu3ZIhweD
	 xiecP+orCYrzmv2Gy0QBNiJLRYYNHiHOa+QogmyDi2voF3IqXHc8ThXlpsMVNx76ebw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491766;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Wanx/Y3C+0SlSQC9sDYqWym0szuF/WkjMrFohRrApNo=;
	b=0Juw1wv2reys8Z6go/cjSkMdjouGbHGoEp4om6bLfwQaiVQ9Dtb2CntLsDTEUd7pIwJv
	 Cr5xp+1Of/aWiFU0YFXCVAa9Zb41voEYNnnZ4b91lqjJhvZ8IAeks64ixgNd41BjMyycG
	 tCzm90rCh+5ZpmYx5mr+jF+1alFaN/j0pBHSgl7rDNsK1V+uvlIRmNuHTeWiG9s/NYyOF
	 ywCUthudSe6djzgfMOrwbZRANwZVN2ejajfwjreJmxPFak50HkEJX74osmBN4apElVVUV
	 hvvOTuChb43hyeoLdIPLwwurF+EPAELnIAXu3LO8/5m78onrhsmBpNvXQ5GunpezPjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5Oa7TM3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8613B606A319;
	Tue, 20 Oct 2026 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5Oa7TM3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A896F1F000C4;
	Tue, 20 Oct 2026 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491766;
	bh=Wanx/Y3C+0SlSQC9sDYqWym0szuF/WkjMrFohRrApNo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T5Oa7TM3nby70HzARWjHBQQEUhvyDMnYSKnWODFB/qM7TAf4HWluzvCMoZuIgfgIy
	 w2nKBO4fzEoENZA4IWc+qN+yQAjr5zvfQ7dniIZd5i9fHU6VSXezpYkh4VxtJAfdAd
	 R/jPBncUlO/gYqZhBR9EoNd5L/i6DYwumiLVnFxU9f1zYERkCIjC4+I7irWQs1XCyE
	 AkzJ0zp7mWH1cJu4KqrxzXJ+EuPQ0CjP3QJ+0bf/j7bCL4iOzlNm3URN/4BF/fYMlr
	 KwILvV+MnSELolXwD0MjL6cIUlXuwVAvGaVQJEuYCGS7QfLxotp409zmw49clS+fpN
	 5R83GhZiZRMJA==
Content-Type: multipart/mixed; boundary="===============8069249734330607249=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <42d40286dc3a75179629023befe798cbabc88e8c5d890f2dac1211477cc6ef7e@mail.kernel.org>
In-Reply-To: <20261020095124.928021-1-yanxia@cmss.chinamobile.com>
References: <20261020095124.928021-1-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH bpf-next v3] tools/bpf: Remove legacy BPF tools
From: bot+bpf-ci@kernel.org
To: yanxia@cmss.chinamobile.com,daniel@iogearbox.net,bpf@vger.kernel.org
Cc: yana06070@163.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,corbet@lwn.net,skhan@linuxfoundation.org,rdunlap@infradead.org,richardcochran@gmail.com,netdev@vger.kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 10:22:45 +0000 (UTC)

--===============8069249734330607249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/bpf: Remove legacy BPF tools

TL;DR: Commit message only: the changelog doesn't say why bpf_asm, bpf_dbg and
bpf_jit_disasm are removed or what replaces them. Not a bug.

>     tools/bpf: Remove legacy BPF tools
>
>     Remove bpf_asm, bpf_dbg and bpf_jit_disasm, along with the assembler's
>     lexer and parser, as suggested by Daniel.
>
>     Drop their build and install rules, feature checks and ignore entries.
>     Remove the tool-specific documentation and update the PTP classifier and
>     packet socket test comments. Keep the classic BPF instruction descriptions
>     and assembly examples.
>
>     Keep the bpftool and resolve_btfids build and clean targets, and the
>     bpftool install target.
>
>     Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
>     Link: https://lore.kernel.org/bpf/61f7315e-c835-425e-a99b-d2470ba9a875@iogearbox.net/
>     Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

This isn't a bug, but could the changelog say briefly why these tools are
being removed and what users should use instead?

The body lists what is removed (build and install rules, feature checks,
ignore entries, documentation, comments), but the only stated reason is "as
suggested by Daniel" plus the Link: tag.

The documentation hunks also drop the in-tree explanation of how to produce
xt_bpf/cls_bpf bytecode and how to disassemble a JIT image dump from the
kernel log.  A short pointer to the replacements, for example tcpdump -ddd
for the bytecode or bpftool for JIT dumps, would let the commit stand on its
own without relying on the Link:.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39405560147
--===============8069249734330607249==--
