Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803DA35E1A2
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881702; cv=pass; b=eHqyITORNRiQOyAEaUrxwNsL0lyf5HN+2//9KV1qYR3hnR0FNFIJjG6n+dDBEFqUuNP+pYp85getxfPNNwLvV3Cv1KSz+H0/O1OLMqlW2xpQo4rRkp/5Uc+93j5JSh6lnEKDpmzUh/SxUIWH5tpukZb65kBxh1X1HQ8X5S4oJ8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881702; c=relaxed/simple;
	bh=d+Rr+wRAUtrbxWmrTvWo9Sp1dRXAX8PUIXaXiSwQ3Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxVqOhoLDGMWMP0zmwjFBol4c9FZJIwhiWc9IhvJmJz9EPRrRvw7HVsikO+Scy/C1g38B+55HJCbMjPDtyMw7BRXVF/Qqzief4u9rUOGFbRYQIiBrZKYJmdS/CB+07oKJAwnTiXDObe5pji2PCzgGpkxGXLTjAA6L8Pj2uX2D9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIqdPtC4; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIqdPtC4"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-444826c16ffso173850f8f.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 14:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778881700; cv=none;
        d=google.com; s=arc-20240605;
        b=jpURvORP24Ea8i3ZrrHJGm2/qn1xbxkCd+ByAaYmzKrlpVJhgftuaTXhho0nPcVaGe
         MYlZYzNKMnKNBxB4oA+MZkGoSTn4GLJJ8G6cjaqMCRjdS9eqZ6182aqCJPy2lWa5Mb5v
         TSZTzu4oiU3A6YqUIkmVQMoHjGBzqQfgb+T/otX+dsnaEX0ElbRrE0iDQQ1QNEnGJ2a6
         kVTMmkqNNge6fdBClSoLs4+yAuxzVcl/Mb3RxcukRywBLGN+y/vTVgJWGBhZPCnN4OXz
         NPEGuxgE7gCRcQVzswLRsrFr7NbrJf1GDicQtcS81fPH2Q8B+PUjFBQv4UD9jVkuLRDU
         Ih/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lhOkDKdskB4tlgXFXEHhRRqKf+auvU/CSw68Mcvkly8=;
        fh=YQh1UbVv5jwFCNp0EeoACiJTqAynUNE5HyrjJNLKjWw=;
        b=kCNVnD3WG6SMAyLv1pY9d7uO3UV6lhvTl4f09UdfbsRML5EbQwOFmvmfQsXQo1Q/In
         kdCCAK5W7bXm4icJSNSbTUCj/duqGYUY7el0PiCvUYooyZqmS7ypQnpwlasYNVQyGOj0
         QMNb/UufiAeipY8RKaQgaafvYAC5CgslPdT6JAgRen44tzRFYE7kMIhnyygD0JnReb1Y
         Ad2Ivd1AujPFzwe2FldO/m53nVy8M9PTIedq0zxJd2NJ5OyhWwyQ5hJaH6JHTNpZOdwi
         +BHRajztXp0aeDPBUSUCkdYkIZzHdMMAVE1PuDDEREW+HyfTqQo7J7T44gIQbnaDxn2C
         vCKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778881700; x=1779486500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhOkDKdskB4tlgXFXEHhRRqKf+auvU/CSw68Mcvkly8=;
        b=JIqdPtC4l+id9nxxg8LVXks6lWBr3D4x1o//l0AqZYx8P9PiU7kxpMDgdERkYJ3m5R
         xig7wsFAM5BQPsdpdm9G1P6Z+KMQ1/jTtyvuDSfmrUJp4bkEkkpuT1+IwAdFfRXgfdly
         NLkA4PcwIque9Cxg/iNU79NWct9hf/yTLQSesHoFaH2sdCqRMNo58fOh1jJxP2eXIdnk
         HErS9kPkG9QuzBJwM9VwnI6rskerqiQyO/YLyDicdGXOog8EFfLzd7q/zsf8qDE6elpK
         HJe1oCQF+vQjgjUlFd/E7MAUI+8zbVy8uxzDGFWZwGL3YGO72PLvdqEJbmsOWMzvDiBO
         jDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778881700; x=1779486500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhOkDKdskB4tlgXFXEHhRRqKf+auvU/CSw68Mcvkly8=;
        b=Jg4T0qs7MOiLokYGpvZW4YoEiBiX1lN4JJuxmvjp/gY3LiwjiEeVcr0tZygz1A0zMA
         6TGOCy4Ksov4IM1sEGorRpAPMgmkkaFrTMgVS3iByd/qRNrwrXEjnj9ghKDrlvDjElBf
         dvDfeAlYawOqt88RHJjJZIMdlXkSVCi5XPBEXdaPtNfMLk8SPgimGMLlSCRnosR+pzm4
         zRVULVEaYDP8B4RsfpajPY5Id0JAwWRKUiH4elTzmL2zaISJAIVYZ4WyGdIgPScyvy2+
         iptCPR/77fRLQZXk0lX1dNMBjKapmC34nZlgUcY8N7NMpggmCNtSU/sL25c+Jnp0KQGE
         W7Wg==
X-Forwarded-Encrypted: i=1; AFNElJ9lzcilCZcHgXBtTZl/RYQzQdyjWMAwHIvwO4rRFud+W3G/8k/GsuEsXex58jt2Bje3MYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2yxBXd8yNZ5K5Ng2lOG9hLPurc5L1SL3OTwCFZL1mUEtO2Bys
	txmQTo9wGnTRFzWhJLZW9WX5sf8W8Ng7JRWdmF7YSYacS6us+/t135dtEWtotKl3adNd0jSTXVH
	AbxAv85WqWDumLy6oq6yHRe853YS4CJA=
X-Gm-Gg: Acq92OHH4B4RxJmDKVSj+GMsCMYj96zGAobz06jGWXS3dnAk2arxIIxGypdrdHEURLQ
	aZNoJELfHG7iXpB/mSG0+oyAIHgd33y0aNgfehok+5ttjTo7atjf0ZkQI9rtsPvBOTq8Dv1xumH
	2UAUD7S8mwpb7fAxdlVUN2uVclADchWpa4hDOjJ7FkcEKDAyJiz5qRhCkG4o+qIP3m8wtZT5LYR
	f7AYV0g9hGi3HscCdmRuqZchk/uDYbahXQHVpUeCHfWfBHBKURyRH0XbN697Nbxy7rwd5s7Vfey
	GHf51rV9CLSiuRiKPIMmi8FTzMtnm1Oz316qpcQXQzjLGnaP/Et+8leUVrpgUdg2KOumWB95tQB
	NpMfn2CBu3zcD1+WB3DGzIMI8VA==
X-Received: by 2002:a05:6000:1845:b0:44a:47a4:ce91 with SMTP id
 ffacd0b85a97d-45e5c58d4b5mr7902117f8f.25.1778881699730; Fri, 15 May 2026
 14:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504194653.52760-1-lucasp.linux@gmail.com>
In-Reply-To: <20260504194653.52760-1-lucasp.linux@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 May 2026 14:48:08 -0700
X-Gm-Features: AVHnY4LjDpfh3rZnWFDJmmZQB00bBBWaOat8tqlK3nw9usIZPEQGLb1_lSDb9pM
Message-ID: <CAADnVQ+Ce6HwrscuTxJCN17NQ6Ks=LR41F4U25fJ1PuAvQek-A@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: add SPDX license identifier to parse_simple.c
To: Lucas Poupeau <lucasp.linux@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 12:47=E2=80=AFPM Lucas Poupeau <lucasp.linux@gmail.c=
om> wrote:
>
> Add the SPDX-License-Identifier tag to replace or complement the
> existing license text. This follows the Linux kernel's move to
> standardize license identification.
>
> Reported by checkpatch.pl.
>
> Signed-off-by: Lucas Poupeau <lucasp.linux@gmail.com>
> ---
>  samples/bpf/parse_simple.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/samples/bpf/parse_simple.c b/samples/bpf/parse_simple.c
> index 4a486cb1e0df..b57ac5baca30 100644
> --- a/samples/bpf/parse_simple.c
> +++ b/samples/bpf/parse_simple.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2016 Facebook
>   *
>   * This program is free software; you can redistribute it and/or

checkpatch should have told you that this is wrong way to add SPDX.
Also there are lots of there .c in that dir without SPDX.
Fix them all in one patch.

pw-bot :cr
