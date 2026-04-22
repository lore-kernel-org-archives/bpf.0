Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEED38655A
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845209; cv=none; b=XgmbRhzvf2prcwciipBdrhLukw5LZSLHMPeJCFVhlPOIpLPxJw/nkZ0yWUkLGUKVtAPczEe0rPOVqzgYWbVuDsGU1kn9sky799H5jgmMifcqVWQJha785S/ZV103NA002jAZ5DshuxfHsBoexTzDobd0eUowkkvWz9o3veqZ/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845209; c=relaxed/simple;
	bh=xGdXSbBjTf15y6ybsKmPKKU0hCILADX3goOTyjY5gxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIBqxw0CPIOlgDCfmY7vV1EtYThLN90+nfgtVhvFY8KETO7h3nWGrFzqTlse189Nn822dS+DuuYbenZ7QZMIfYWvcXCQBRNrQSUe2uOKLvseW3YMfN6dkI6cGEnp0iubyB5XRneIxE4YWXWpy5HipgegQl3uOZDm+b/PJ7linzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si4BJJeq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si4BJJeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79585C19425
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776845209;
	bh=xGdXSbBjTf15y6ybsKmPKKU0hCILADX3goOTyjY5gxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=si4BJJeqOXBvd4cwIJR75+oBlvuZRysfK3065bBsIvvPP0ycUho2pF7xliovJ6e42
	 OYsYbI2qnNM6DBft7/V1XatWHPBQf5zcYrULXcA4pgF3splBjS9e4dRLmIP8T1LjPq
	 Lnm+lnB+XquI7uye1DC6SIqri6DOdXSzS2tmHuRZroA6B9Og8QgE/kYlAz4wEW1SgB
	 VxNnYAVGSrqwzKfTZWQymJuyzmMFLhgGue1r0EpxLP7LPGrH1HmRtqWe0U2STUHc4H
	 at4HZUYxASKWdto0YWE85gJeI84teFAqEWl+uTetS4dsiXwIIAK2fCIdRBigHRcWsn
	 x0JdNicm1rBow==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8f97c626aaso807793166b.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 01:06:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/5NeYVfZ9ut7Pd1f8LlM96pJNpCtCcWTX4/mtxwDcQsfnEmJiY4j3r/P7oh8eMBiTrgQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65CUl9QcL13oS2TsDLcfXd+VW+BAWXFJkqrGDcghsIi6/AHJ9
	zP86ex6MsrfyMrQK/K3pF1WSupJftdcBpbFfdh7Q8Y5YeUvxwrlN+6p+Zkkan0i90MQ1Zt2/Ph7
	p8DLdJhw/kL8glGnIctCWv4kRzZWwjms=
X-Received: by 2002:a17:907:9342:b0:b9d:e301:20db with SMTP id
 a640c23a62f3a-ba41de2e49amr1039184066b.25.1776845208106; Wed, 22 Apr 2026
 01:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224073515.1273-1-yangtiezhu@loongson.cn> <CAEyhmHQVTzOohJUAL5FfP39pY=8q=ui7LYE3Z4+n1s71GK3Shw@mail.gmail.com>
In-Reply-To: <CAEyhmHQVTzOohJUAL5FfP39pY=8q=ui7LYE3Z4+n1s71GK3Shw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 Apr 2026 16:06:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7PXGyTotvTnw6PKYUdVYzeWVHf5CxP_WxvC5cAdtqBFw@mail.gmail.com>
X-Gm-Features: AQROBzCGMhCXwTFrM0gvqE-GLzjI99mAClONjTv_9kWrMnRqLJTDgPda4rEYdJw
Message-ID: <CAAhV-H7PXGyTotvTnw6PKYUdVYzeWVHf5CxP_WxvC5cAdtqBFw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] LoongArch: BPF: Support more features for trampoline
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 5:55=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> On Tue, Feb 24, 2026 at 3:35=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.=
cn> wrote:
> >
> > This series is based on Linux 7.0-rc1, tested on Loongson-3A6000,
> > the main aim is to support small struct arguments and 12 function
> > arguments for LoongArch BPF trampoline.
> >
> > Tiezhu Yang (3):
> >   LoongArch: BPF: Open code and remove invoke_bpf_mod_ret()
> >   LoongArch: BPF: Support small struct arguments for trampoline
> >   LoongArch: BPF: support 12 function arguments for trampoline
> >
>
> For the series:
> Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
> Tested-by: Hengqi Chen <hengqi.chen@gmail.com>
Applied, thanks.

Huacai

>
> >  arch/loongarch/net/bpf_jit.c | 109 +++++++++++++++++++++++------------
> >  1 file changed, 71 insertions(+), 38 deletions(-)
> >
> > --
> > 2.42.0
> >
