Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDE315D43
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569515; cv=none; b=PCqfpeYlMAiFusKtSmb90hw+7qneHhL4G/8jG1gct9Zb3/RaJQf72/RMVFozoweKbNvMlpCijNz/j7uK3bq5gBSPYJ+Vxv2U/hDMhBltEuJNsVesnKFwbC6X0JMDVSOzxjdYceJUjEE36NIYvVxwcfRC2Z2q27PcGEDj/HhP2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569515; c=relaxed/simple;
	bh=lyfQsLW0guqksZ4IM/P9yGFVgChcCJWmIh6cOHfUMDw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EaqzggoMt5gI/yLCSdmUeqLqnOW74GcVQLneE3/DBF39yFxXYYXdIp2lU9M0fQA+WVkaR6q4YV6Z1ku76WM9cwGwbjySeiasjtE3ONfJ6/Z6o4XAAOcip86k/5W7ZLZpxmU234Q10HKZyI95zQd71DzYyv7u+vIhc0Fvlkv+sRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWtzCi61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWtzCi61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DA31F00A3E;
	Sat,  5 Sep 2026 00:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569512;
	bh=uJpYAUR1ovF06Zh8mraqNoqJhKCZBDqcsI5ISfcwVkA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gWtzCi61jUbDnMR5UMarlPvnLvUdKLWosFM/bU/tlSdk/mjp3aYmBLdvb6d2nMDYI
	 /FoO6UKWyz1wWorbi6UhTbPpfkHcA8yAprwmge8dGDRgHBvKUAun/Q+DI3upSSR0vD
	 VVAAHII8pu6PaUgsz0VhoyaF/RixjWFZt+IMyPJ5nOEvkkGIcSf3Um9/vZrg6ZEDpe
	 4JPs7mIfvjzKbA4NBjWJJVrzCcHqc5u8E9+sOrFrX/+7siwSYsU9VFpM8+7yKucJnE
	 0GTZvuUaB4R8RbxHMZwz+sj+fXEn4Vp9zaC0YK2jdzF+APHg9fnMc8FymPRIDE4vJK
	 f6tfyCbo510+w==
Content-Type: multipart/mixed; boundary="===============0621486934584521735=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22f2e55a2c2d6a4091c76c38f250ceeb02cf7d82cb0afffc8c56d68a6aee2a16@mail.kernel.org>
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-4-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-4-0f5a360ff15d@gmail.com>
Subject: Re: [PATCH bpf 04/10] selftests/bpf: precision of a NULL global subprogram memory argument
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 00:51:51 +0000 (UTC)

--===============0621486934584521735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
> index 3e290b07f672..fb7dfa1246ef 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
> @@ -676,4 +676,36 @@ __naked int null_mem_arg_zero_size(void)
>  		: __clobber_all);
>  }
>
> +__weak int subprog_mem_arg(int *p)
> +{
> +	if (p)
> +		return *p;
> +	return 0;
> +}
> +
> +/*
> + * Verification takes two paths: with r1 being scalar zero on path (1)
> + * and with r1 being some other scalar on path (2).
> + * Check that the verifier does not use checkpoints created
> + * on path (1) to prune path (2).
> + */

This isn't a bug, but this five-line comment above null_mem_arg_global_subprog
appears to be a verbatim copy of the comment above null_mem_arg_zero_size
earlier in the same file. Since the case just above already spells out the
two-path/pruning rationale in the same words, would a one-line back-reference
read better here, similar to how later patches in this series handle it?

> +SEC("?raw_tp")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__failure __msg("R1 type=scalar expected=fp")
> +__naked int null_mem_arg_global_subprog(void)
> +{
> +	asm volatile (
> +		"call %[bpf_get_prandom_u32];"
> +		"r1 = 42;"
> +		"if r0 > 42 goto 1f;"
> +		"r1 = 0;"
> +	"1:"
> +		"call subprog_mem_arg;"
> +		"r0 = 0;"
> +		"exit;"
> +		:
> +		: __imm(bpf_get_prandom_u32)
> +		: __clobber_all);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33932783420
--===============0621486934584521735==--
