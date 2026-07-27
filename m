Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE63BD63C
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785126353; cv=none; b=sYDPYYoFZHdtCPQlwMsYTvuoyF8KNXLWMdafddenwP4X3DVNYtdUOdorWoa9ILZeoYLWJBRZXhD5vrywTzmh3TfnOjJWD5Xprdy1QdYRrN25DsUepGX/7PCDJAlPFfZQ9ytarNfT8vnL7lOcNlk/ZtJicSfz0j2ZcjIuiUai2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785126353; c=relaxed/simple;
	bh=BmecPjwXE0g3LVvgD0gIsyctVAEVhKzbfQpXZKpRGxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8ZTSFgV2bMW72otWjIxnjqrUaVH6jrP4CnVyxe6fTBrJ+nwyoHxMcOMPSW6SoenK6qTQx/u+D9PbTpDq8bRXHbjx06ETeLMQ+zvSWEK1UZzdG8hH8Kkjz9w7I8INk02he7brbzJga/3Ue+SHOLbcVO+zc3Ls5QvEaeAsNIh2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDACPeTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDACPeTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182DF1F00AC4
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 04:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785126352;
	bh=DSdoq66NS4mLpngWsgXUV33SUbyEXoCvLVhEEJHKSEo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MDACPeTu842gSbBLAenyljL6FHGYTW5pmhPm4et/q3N//x+XwJ3YyTHPbzRhs4wa3
	 iZ856JUjbdyJnLCA1mKwjkIM4+L+jgUkzICFbrj6X+abG8UpJDdboVhCTv2xf+IP+O
	 QTl0w2hkM9vi9XqohS5kGH+DcOzVK68SS3Ej0nDXLm9+i+uG6LwvnZgQG1QK8Qz3hk
	 xtLK0tdp6Bqwo9mXPwBp0OcTbemXMyQ+PTS1Ga9PbNeOGAIagTGanXxd1GXbkyE4KU
	 NRvaFAcTrjRNBpMfiC0CyIHuGkSDAgvPQEoYQPzBIYMBsIbmorjFSXsrAMPv7e/hmY
	 foMtuopizADyw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69fc856b00eso1184737a12.2
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 21:25:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpWsjvvmDaUr9aFLIF5df4c/+pV5yr731gv7r+gx7fXwXr3+mqcyEdqnOydCL2r8MnZgKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUSBjWqjmH//NccUT7Z2z6sDwDSBFyxfKCYsxFunf0lDeBjymi
	DNw00l0LAYPU2rqxcRNV9zvgSSLZur/6pYh6c/6651do2iuyT4od6avXi9w0ibKbsDg2oflYxdn
	aknOireT1m1URqiw1KjmtPeY4dnmGr1Q=
X-Received: by 2002:a05:6402:90b:b0:698:3e99:815b with SMTP id
 4fb4d7f45d1cf-69fc119090bmr3108624a12.37.1785126350613; Sun, 26 Jul 2026
 21:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711100956.4351-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260711100956.4351-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 27 Jul 2026 12:26:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Pc2qzFYRp2WbsChWuN4orvmq4YGTc2cxDWmO=S825Wg@mail.gmail.com>
X-Gm-Features: AUfX_mx9aZopj85iVSKfRjgkFJ-iSl24CvZPnt86045kqxbl-tA4xRYJcv6Mo2A
Message-ID: <CAAhV-H4Pc2qzFYRp2WbsChWuN4orvmq4YGTc2cxDWmO=S825Wg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] LoongArch: BPF: clean up for build_insn() paths
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Sat, Jul 11, 2026 at 6:10=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Based on 7.2-rc1, tested on a Loongson-3A6000 physical machine.
>
> Remove redundant or dead code, and eliminate the unnecessary runtime
> check.
>
> Tiezhu Yang (3):
>   LoongArch: BPF: Remove redundant zext jumping in move_imm()
>   LoongArch: BPF: Remove dead move_imm() call in BPF_NEG path
>   LoongArch: BPF: Split unconditional branch JA paths statically
>
>  arch/loongarch/net/bpf_jit.c | 10 +++++-----
>  arch/loongarch/net/bpf_jit.h |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> --
> 2.42.0
>
>
