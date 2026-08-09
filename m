Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949351A6800
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 04:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786248574; cv=none; b=HDBEC8TOv+0n2kp8ck1aFiTgeEmkkmYyzrtzAySIs1SYbPeaishe/tHm2F5/yc5l0bTibS2rIRiaBITN9PAt+Uq6ihflE96qCQR/eKZLl5zQ58NrMTBYnPlBOUoFgxpLRKgONsyIvfLUK8Qq7xodEi7gFL0ireUrQPnb/lVOVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786248574; c=relaxed/simple;
	bh=jU/j2rUIXe272yLidlHK69K9vHmOcR5rtahgU5rQ/y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wevzgt1DjQi1YfZnAZSUtX5nuqGPstAzHz4uYZeCdmYdI539sFUxDkG0XGP3shcsdt7rBAyQQRSX4EMPOLxnX/87lfS2IGo13Io1vjIN5pFjq1PhY1o9njxr7iNQDBnGF64W9aaK6J7uuRRj6pQDl5lVEZoMwVyjeXPPzG8r5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnVdlnMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnVdlnMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8F81F00A3A
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 04:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786248573;
	bh=pB3sQ7DJLZcngz+lrTTuMa4GxvzLNukpO5ld/ZUbobg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fnVdlnMbVY9FzhNQjrc3pzxQfgkLauHiHOhsJUvDzCqukA+loD1aV/QSQh4uBZQnx
	 0OKnS+jZhGpBGnzvnHtGognY9IFW+kYYQGDX0/UBrPTr0STRkD4wvVjbNlrko4Y9Ad
	 n33Jt0esLnjIIBaAU6ltnVgg7+LXl+100gsOvI1y/wbPpfXfR/aOTXrKxspPALZAs3
	 WoDjf4BYY3mqg+ZnqPCJIavJ+XCQz4b9dEvQZ9JWzsv/4ScAtHGTy8+9J3uL4v8xYi
	 oN0SPjbI8QpgeNk/9tBprXKPuGVxHVB+o4vU2vKWj8mOQTUNf64S5lI2oPtmtPfKOA
	 a8aB4JWbCua5g==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so130620866b.0
        for <bpf@vger.kernel.org>; Sat, 08 Aug 2026 21:09:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoJPmCB+xJLazqx6b6arxOPkIRxIfjBbaGmO+JcEHCbmWBe26swIkvA4bF2jZBJHxSRvsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7cBz2VL14BN2pQLzAXn5FSZvPH79uavMzEvrRHHEOLCy+WOVa
	p18rGXztKP1sK2clNKww+sMoDBYNSBovYeuM9PrSka2G6mDJ1xC/SdCsMRXbPE/Tr71Bn73Y8HJ
	bChnpAsLswLfOtEv0N0M6S+g64D8hhsw=
X-Received: by 2002:a17:907:1c2a:b0:c20:223e:940a with SMTP id
 a640c23a62f3a-c2087572807mr576000566b.21.1786248572018; Sat, 08 Aug 2026
 21:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804153938.16129-1-dongtai.guo@linux.dev> <936e5942-5722-c86e-2c5b-c048199ed6e6@loongson.cn>
In-Reply-To: <936e5942-5722-c86e-2c5b-c048199ed6e6@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 9 Aug 2026 12:09:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ORtPmvFxByTgY2LOVbUNnv4KS+j1N+AbvHXabbAhQ4w@mail.gmail.com>
X-Gm-Features: AUfX_mxO4KWRsZ8fMgJqkZeDEl0vHV-6qVX50wOy9LwGfkWGrj329fN3YTQg0f0
Message-ID: <CAAhV-H4ORtPmvFxByTgY2LOVbUNnv4KS+j1N+AbvHXabbAhQ4w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] LoongArch: BPF: per-CPU address resolution and
 timed may_goto
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: George Guo <dongtai.guo@linux.dev>, hengqi.chen@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kernel@xen0n.name, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, guodongtai@kylinos.cn, 
	bpf@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 8:23=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> On 2026/8/4 =E4=B8=8B=E5=8D=8811:39, George Guo wrote:
> > These are the first two patches of the LoongArch BPF JIT feature work,
> > sent on their own to make review easier. The remaining pieces
> > (per-program private stacks, exceptions/bpf_throw, sign-extending loads
> > and atomics on arena pointers, and the matching selftests) will follow =
in
> > a later series.
>
> The patches apply cleanly on top of Chenguang's series.
>
> The following selftests passed on LoongArch:
>
>    # ./test_progs -t cpumask
>    # ./test_progs -t percpu_alloc
>    # ./test_progs -t iters
>
> Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Applied, thanks.

Huacai

>
> Thanks,
> Tiezhu
>
