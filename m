Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CC341AD6;
	Wed, 22 Jul 2026 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701181; cv=none; b=E2xwCJjerUlnbOShXD6DVJl8bOBnUzbS99uOj8s/I3tElLqSDULhVAggVmkMTiDm74tjGOcVeE944cT1XOcQu13tn3/nj0fSjhG3nqzJ+xKMo04k7Yia7JCT56ndj4IxeTRXpsEp51lZMQDx1auc58rT3ADZIzg/FusgqAlCKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701181; c=relaxed/simple;
	bh=sTovb3jlHmMmpacyIEycqdjDJrdtEJ4opsDA6DZw6oI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uu4xmddgv5/X/3fCCtdWgl8NrNTbgdIW17ejC7BoEj7gmFNr3I+cpp0mhmOnSTbWwOGNtjCLEq03y9XxfNLqBWuHDDhzKMkWs4qTl7Zc6wnc5u48Rx7zzSViTEeL6rhVaKlorzbIYAe5Ia/6hXuJu3IzaYY2yxfxinH1IdCRGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4XAbMye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4XAbMye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7A31F000E9;
	Wed, 22 Jul 2026 06:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784701177;
	bh=AEh4CLLahb9Ms3Mqn7fXlHzTRN7mIHaMYarLA5wmEL4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K4XAbMye85KnDNriuWSmnUtbR/InR4ASMSlBmx0eGGM0HqHnvCR27UMsE1rLZeoQE
	 aJ+jBXVAeEFQ+LEmYAjjNkhs1+4IcK9zAymwoVZGHMk2W8NklQYquUx2gnwt1Pf7wW
	 CAuJfhRYCntrawYilZgfoPiGPxrvr7wQqPaa303FhQoQ4WEsUl8WVYadtrL7WUaX8V
	 kFxbft/LStA0RaivqDYDWH7yvjyjCteo9kGgC8Gq4LeOdVCaDSX2mcBW6PeKsMutNm
	 p39YLSWYBc6RqvoXdg6YiDxX/gBvedZ+dn1277ZS05C86fCCAGxrLf2S0vDZizIrSG
	 s8gu1xf1cnjFA==
Content-Type: multipart/mixed; boundary="===============7886987547029329891=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <455026ad71596cb0ff71074ef232644d1cd4d623cccbd0f695fa275aaf5ed972@mail.kernel.org>
In-Reply-To: <tencent_60882E4BE4F247C5F6D564F41BF1C3004805@qq.com>
References: <tencent_60882E4BE4F247C5F6D564F41BF1C3004805@qq.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
From: bot+bpf-ci@kernel.org
To: rtoax@foxmail.com,vmalik@redhat.com,andrii@kernel.org,ast@kernel.org
Cc: rtoax@foxmail.com,rongtao@cestc.cn,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,ishiyama@hpc.is.uec.ac.jp,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Jul 2026 06:19:36 +0000 (UTC)

--===============7886987547029329891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee..85afff60365c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4195,6 +4195,79 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
>  	return __bpf_strnstr(s1__ign, s2__ign, len, true);
>  }
>
> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
> +{
> +	int dlen = 0, slen, space, copied;
> +
> +	if (sz == 0 || dsz == 0)
> +		return -EINVAL;
> +
> +	while (dlen < dsz && dst[dlen] != '\0')
> +		dlen++;
> +
> +	if (dlen >= dsz)
> +		return -E2BIG;
> +
> +	space = dsz - dlen;
> +
> +	slen = bpf_strnlen(src, sz);

This came up in the earlier review of the series: the length of src does not
need to be computed here, since strncpy_from_kernel_nofault() already bounds
the copy by sz.

  https://lore.kernel.org/bpf/3e73aeb2-afce-4ae9-9163-51e4dc1ded01@redhat.com/

That bpf_strnlen(src, sz) call was dropped in an earlier revision and has
returned in this one.  Is the separate src length scan still needed here, or
can strncpy_from_kernel_nofault() handle the bound on its own?

> +	if (space <= slen)
> +		return -E2BIG;
> +
> +	copied = strncpy_from_kernel_nofault(dst + dlen, src, sz);
> +	if (copied < 0)
> +		return copied;
> +	else if (copied == 0 || copied == 1)
> +		return dlen;
> +
> +	/* The copied character count includes '\0'. */
> +	return dlen + copied - 1;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29894636510
--===============7886987547029329891==--
