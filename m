Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E246DFEF;
	Tue, 21 Jul 2026 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660863; cv=none; b=nodpX8sl00Gv37KwJUd7BDZ/1yDghbiNO3RZJbDG52U2PO8rB6lsacPlJZYkuj0mIm1mO1OTQg4Cj2JhQUXdjEsiQC/BiAaEbfe5WchGBbye5OnzqvjmpwCsS0httNJK5jUb82O278+7KwrpcNxdpDZ/d0M80kU8ONp4kyTUOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660863; c=relaxed/simple;
	bh=B6H0dfI1Bfm8ZqPcG2Tee6C0L+Yzj0OJFP4Cat5i0mU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XyqIJwPxlYaO0emQYUqrb32zYbRnfozICTQ0wfWqADLSpQQxzW2nhtlgsbYRxNxwW6UPuqm8ZBTI1Pym5W+j+A5YVl47e2YnXpP0cnXYVQ8RDgtEh2xdoF2dhiSBuVdgVyT7ntxLvs+KtBPd0xHLAl/7sMahfyUXzKtYcMaSXKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nquRc6Iw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nquRc6Iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1958D1F00A3A;
	Tue, 21 Jul 2026 19:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660862;
	bh=BThJVpsPx9rlSedh6BZlmIHSLIxFXwN802rpP5uDBHM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nquRc6IwDPapmyfojvVM8oavN1mOCCWnXXK2FeGAkqnRisiSH/0MoCU5FHc/pKJBa
	 zea26J59q0WCT6FJeJ4sTjIYUJXWjb5bExomJSgidAEsK5s8ERAVLJ9NVDDY5L8+UB
	 SfnWwwIedLpesDQMmELlZ1Z/b+qWOxoR+3jtmVco1BKcZKW3tT57nZ4yLvIgR9zOvn
	 lswcv2q6oIP5HDV491HuCFF1dh0z8sX2FwJy1XOiYrOU3XMhD1JkNsJOPnW+3UOzWm
	 KDFSC0MJPXvqV7EEEGRlKMkA7TL9pK6V1elC5KLYPEyDex77l2zhnFe2aFNChHY213
	 JTpAv0usZs9KQ==
Content-Type: multipart/mixed; boundary="===============8817995826463365865=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ab9cca706e5ba59673b2d5c2e060ee88d90f403bea9873adfdb55664cb84deb@mail.kernel.org>
In-Reply-To: <20260715-riscv-bpf-timed-may-goto-v3-2-cf2a9c3d843f@kylinos.cn>
References: <20260715-riscv-bpf-timed-may-goto-v3-2-cf2a9c3d843f@kylinos.cn>
Subject: Re: [PATCH v3 2/2] selftests/bpf: enable timed may_goto tests for riscv64
From: bot+bpf-ci@kernel.org
To: jiangfeng@kylinos.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,jiangfeng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Jul 2026 19:07:42 +0000 (UTC)

--===============8817995826463365865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> index fb4fa465d67c..c26727bef66f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> @@ -660,6 +660,7 @@ __naked void may_goto_interaction_x86_64(void)
>
>  SEC("raw_tp")
>  __arch_arm64
> +__arch_riscv64
>  __log_level(4) __msg("stack depth 24")
>  /* may_goto counter at -24 */
>  __xlated("0: *(u64 *)(r10 -24) =")

[ ... ]

>  __xlated("12: exit")
>  __success
>  __naked void may_goto_interaction_arm64(void)

Now that this test supports both arm64 and riscv64, should the function
name be changed to something more generic like may_goto_interaction()?
The arm64-specific name seems misleading when the test covers multiple
architectures.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29858413299
--===============8817995826463365865==--
