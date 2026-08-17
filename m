Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15491332EA0
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943853; cv=none; b=GjMKeZHwrekVZ8qWpliIpSjKsyDQqh4uoSzTQg+8GmqbumYon+NdtVVmDv6ZUD1YbRQ3KmRpPUBAt0O9rzDQ3qr88zY8CU/mTa3m4Qoo9e+JEO9co7VcjGoK4EwhUrSjISwrJJp9Gi/SJF6a4w3JiuobG4HbQOihO7715IqAKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943853; c=relaxed/simple;
	bh=cO0BdsdmrotDMqqAEiVek2K7EB70IvOUOCbBjYSqOnA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SomkC3q3E8MP0JjxDsa1JXk+s8ZDOUcQSDXTQmyeAH/q9vBS62upQfzaqc2c34XDG2AKEmgMJhtnDY77E1g2Zw7Zzuozy8L8MA/bTsyXYpPl3txRdUAK+UvEacVka25Ws95WsnYWDt83xinBoxoaB4wSWkUaP7ZMeA6j54KSdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkpR2Xmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkpR2Xmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FD71F000E9;
	Mon, 17 Aug 2026 05:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786943852;
	bh=ovjGTYewagivl1svFPDp8nJdOB+Nvr83yK3R5vVbFxI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MkpR2Xmxuybv2SmvytTYeuRyM2xZEBQzqEaAy9HHW4r+KqSVoZJb5dQeZp5IMn1VR
	 pGyZaDsAkjmbA1iYTXf+t70BfRhSHcYeEJtAbxz1HpoQEJYRl4yPwFEgqE6GMVhBzH
	 hbRPEUAcP4xZeqxBy3rQc82sl2IOc9qUMx558QEBeHNmCHRjG/1Kd1dkBvXYlsCy3/
	 DMsdMFuvLiNaD/8wSAy4j1gETgxnAe/nQCbo/mRmTciOi3hCzzoz28Rs97NB/La4l4
	 TKX3/lTy7oA/jfTG6iGuOHisTPqEdGNHU7PraPT56UCVkOHbVYe7Upy231A5bl4gc1
	 qKXBKcsUGlVCg==
Content-Type: multipart/mixed; boundary="===============3914086702044715110=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7549f24ead00d59b53a11482de59a7858aa1fe8118b41f7449887ee9b544b0c8@mail.kernel.org>
In-Reply-To: <20260817042212.2291498-1-yonghong.song@linux.dev>
References: <20260817042212.2291498-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 06/10] bpf: Add verifier support for 16-byte returns in R0:R2
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 05:17:31 +0000 (UTC)

--===============3914086702044715110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 5b9d767895c9..2ae7cb9b30f2 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7684,6 +7684,12 @@ static int btf_check_func_type_match(struct bpf_verifier_log *log,
>  			btf_type_str(t2), fn2);
>  		return -EINVAL;
>  	}
> +	if (btf_type_has_size(t1) && (t1->size > 8 || t2->size > 8)) {
> +		bpf_log(log,
> +			"Return type of %s() has size %u while %s() has size %u, and a size above 8 bytes cannot be replaced\n",
> +			fn1, t1->size, fn2, t2->size);
> +		return -EINVAL;
> +	}

This isn't a bug, but since this check fires on the absolute size rather
than on a mismatch, the message can end up reading "has size 16 while g()
has size 16". Would it be clearer to state which side exceeds 8 bytes
instead of using the "X while Y" mismatch phrasing the neighbouring
diagnostics use?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31995069373
--===============3914086702044715110==--
