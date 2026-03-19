Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF1340A51
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773894540; cv=none; b=VXS+1CGBv23eUBzomq40QljbEUBwLvJPZbV3wyhUc+IIGedrPOx38ChoNFsnm20m44u8RVZna0nAuD72J92TDGoj7sbaIXj1if0PxFafbkdarf1hwG9x4u+mOd2QG9HY06VjhFTKsG9GuV1QuGfXOjngTqrxGwIg0maRLL3F0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773894540; c=relaxed/simple;
	bh=JHVFf+G+l3lQAQW5eIciTPXzNHkqZN8dA4Z6qVY1ifs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GaE3YAcydo5R1DY4mdIKxRf66ENZQgnv6Ah1G+qxfgxtStJ8F+ZCJ87ieGo+dnWhFOYUSYSzPCEsOrbrAXRaOysOukVWA9+gcf2fuysnZxp5q+PRIsmJl6TQLqGhjr6z24h3A5/Xtkme9sfSuJwovOt2G2eGoLaDsm1bfUJydCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOQxG3aB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOQxG3aB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C27C19425;
	Thu, 19 Mar 2026 04:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773894540;
	bh=JHVFf+G+l3lQAQW5eIciTPXzNHkqZN8dA4Z6qVY1ifs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=aOQxG3aBMna8zHeG7Tyg2DUkj+9eLQVB7WZVar1AiSi10GT9I0XaaSLPOgc0o07SG
	 ppfWk/uTqKMpbW2MzpVRyS/NaENWrqtiRktvwsMQ2WHg8ZU+ZHXsOu4H+bs3LSnXhX
	 8WAAbVw5D2+BFTuLqeAqh1yGFZpE2gLCigVGkniBzoB/JfrY/nT15/KdnsqTgxnQwL
	 nXlHfaQhnaJo03k9LRbsdezgtbMgSLhHVoiUxwatzu+gH0M8xQnjj5aVn6ZDDf4nNC
	 0mYeaBIDteXvPkiPJ4tq9a5Y7wf8cnpS+/a6GVmqnBGUbdBz39fmIBybk2miVWUW6O
	 d6atsRxS+kRdA==
Content-Type: multipart/mixed; boundary="===============1740023787032212595=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <758c5306b84153bd9b184141054c9d23468bc24b3974d2bddeda4493541d82ee@mail.kernel.org>
In-Reply-To: <20260319034736.10569-1-zeroxjacks@gmail.com>
References: <20260319034736.10569-1-zeroxjacks@gmail.com>
Subject: Re: [PATCH] bpf: fix out-of-bounds write in bpf_bprintf_prepare with %pI4/%pI6
From: bot+bpf-ci@kernel.org
To: zeroxjacks@gmail.com,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,andrii@kernel.org,bpf@vger.kernel.org,zeroxjacks@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 19 Mar 2026 04:29:00 +0000 (UTC)

--===============1740023787032212595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/test_snprintf_ip.c b/tools/testing/selftests/bpf/progs/test_snprintf_ip.c
> new file mode 100644
> index 000000000000..44cc4d74c5e2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_snprintf_ip.c

[ ... ]

> +	/*
> +	 * Test 4: near-overflow scenario.
> +	 * Fill bin_args with scalar args (%d), then use %pI4.
> +	 * Before the fix: tmp_buf overflows by 8 bytes.
> +	 * After the fix: correctly returns -ENOSPC or fits exactly.
> +	 *
> +	 * We use fewer args here since BPF_SNPRINTF macro has a limit,
> +	 * but this validates the format string parsing path.
> +	 */
> +	near_overflow_ret = BPF_SNPRINTF(NULL, 0,
> +		"%d %d %d %d %d %d %d %d "
> +		"%d %d %d %d %d %d %d %d "
> +		"%d %d %d %d %d %d %d %d "
> +		"%pI4",
> +		1, 2, 3, 4, 5, 6, 7, 8,
> +		9, 10, 11, 12, 13, 14, 15, 16,
> +		17, 18, 19, 20, 21, 22, 23, 24,
> +		&ip4_worst);

The comment says "we use fewer args here since BPF_SNPRINTF macro has
a limit", but this call passes 25 variadic arguments (24 integers plus
one pointer).  The BPF_SNPRINTF macro only supports up to 12 arguments.

The ___bpf_narg() counting macro in tools/lib/bpf/bpf_helpers.h handles
at most 12 arguments, and ___bpf_fill is only defined for ___bpf_fill0
through ___bpf_fill12.  With 25 arguments, ___bpf_narg overflows and
the expansion references ___bpf_fill13, which does not exist.

Won't this fail to compile?  The argument count would need to be reduced
to at most 12 (11 scalars plus the %pI4 pointer, for example) for the
BPF program to build.

Additionally, this commit fixes an out-of-bounds write that has been
present since bpf_bprintf_prepare() was introduced but does not include
a Fixes: tag.  Should this have:

Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23279168532
--===============1740023787032212595==--
