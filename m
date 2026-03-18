Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D183DBD4C
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844847; cv=none; b=jBxv7KGJ1a5IiUklMBdhjSRwIPcowAW4b5krl3qOPHx22CuA92KMfH4oclQzunliSX4VIcYbfRzhWUofB/39YZO58j1b9pcGMolMvUBfAQJ2BY/pL0m4Akkxq2wOOxH+RbeSS5m3gG4Aztc5ILsRm8JMiHSaNN0+d0OHT9FVnrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844847; c=relaxed/simple;
	bh=uOoIxUn3IxfMgiqqMkt9jZVMAOumnhYUoNTHGDeBOF8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QPnscy/xmebQ1T27I53/gpS/bmNYctFqvjlYn7GEQ+WtMwB0YNVl5bTCdq2q3GZQnxsldX0rUwSi6galgPCwSj3QYzjhCzfyq2Ktzgwu6RsusZskLIMTDQejUjMgivajEBQayuvHvo8phgcly0YPrA7opP2D2gFDqg/zejjsHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDogs8Jn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDogs8Jn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C37C19421;
	Wed, 18 Mar 2026 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844847;
	bh=uOoIxUn3IxfMgiqqMkt9jZVMAOumnhYUoNTHGDeBOF8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=RDogs8JnvyBRgCWzWrYBfdr704kKnz0ULAf2uNClnY4o9+7pVHP2s59vo7k7Y5kTy
	 JTSeu8Yy6gj+3Cx0prLG7E9Q6JaFpVEfv7P9ZUYD3HNNXb6tpMST53VUvSd8iCl7Hv
	 Uhl1b75mkEgIg0eysy5ySDuTETx/IZGWjQ+SbXNKmYq0WQwRm7xNWcPKXuJ/x2n1s2
	 CXqK0g5NuLOTiQV4WZLfCBvsMSdOCdmK60FyVERT6CZ1ct9k/o2oEHO/ULDzWYNGpg
	 obORK9M00FkmfvJXM932gBE0SmNBHVVGAjKQefkdR7cN/bhduBUTuCvfiuWI8ubO6e
	 EE/716rOYyjuw==
Content-Type: multipart/mixed; boundary="===============2494579703070904862=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4381f729a7ceb3180f61f4450d07e6b446b14faa78de4337b8199915646fa8c@mail.kernel.org>
In-Reply-To: <20260318141720.1894502-1-zeroxjacks@gmail.com>
References: <20260318141720.1894502-1-zeroxjacks@gmail.com>
Subject: Re: [PATCH 1/2] bpf/btf: fix u32 subtraction overflow in btf_sec_info_cmp
From: bot+bpf-ci@kernel.org
To: zeroxjacks@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,zeroxjacks@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 18 Mar 2026 14:40:46 +0000 (UTC)

--===============2494579703070904862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5548,7 +5548,11 @@ static int btf_sec_info_cmp(const void *a, const void *b)
>  	const struct btf_sec_info *x = a;
>  	const struct btf_sec_info *y = b;
>
> -	return (int)(x->off - y->off) ? : (int)(x->len - y->len);
> +	if (x->off != y->off)
> +		return x->off < y->off ? -1 : 1;
> +	if (x->len != y->len)
> +		return x->len < y->len ? -1 : 1;
> +	return 0;
>  }

Daniel Borkmann asked for a BPF selftest demonstrating the overflow
behavior being fixed here. The v2 patch does not appear to include
one. Was this feedback addressed separately?

https://lore.kernel.org/bpf/322777ed-ba0c-42a9-99b9-f567ba4f7282@iogearbox.net/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23249633514
--===============2494579703070904862==--
