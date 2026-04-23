Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27B378826
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938712; cv=none; b=hxNS5HS5Kfup4MSobeU5NxgEBN2L+0Sntjld73tYUfnukPWnACfOuJqB+OLUC5Wz30qGSnRxgQO5XvHRjvbbZFa79NkpIxNk7zcQUSOm53GjqFd2fqDYQa5V2rW8IySCVrZUUwyWNSm+Wh1VTzvwvmRxTAlKGAcNvmgQcaeBZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938712; c=relaxed/simple;
	bh=i1zkuOfK2oa60zamft2ydH2wOZPL7jVwfZn3W8QrczY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onwX8EvrhQU4hrmhEoV9CZSh+5c6c0kT/NcHLsmyGN2CRiow+aou4C+LDfa0uAFCAtQ0sIaN1ETTkqNgAQmCqlrj3ozaugEC/kW/3Qq5FQwS8JWgRxOVPYaqE243uq3n/++OxqzbXPcstFeacsHTpFplRahBwVcuRKpcZhxtM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI56fI0J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI56fI0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E0BC2BCB5
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 10:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776938712;
	bh=i1zkuOfK2oa60zamft2ydH2wOZPL7jVwfZn3W8QrczY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BI56fI0JWqhYIOV4jr6a4CGNeLHtGRYeaJtvSzU2IdPkmYCt4JhOzd+glu41b1gV6
	 47LdApGPFXc7XbYOcGFNMW4iUtDmGUrdNPKPoWyMRT7B1KYeoiYasMK5YKQZpoq/F9
	 TJraiW8L3CDESN8eTRx/u6f/PHkDo0N84gogsP9Kwpgc/swS0cizcTi2QHWpBKa+3c
	 1FoUbCMw3k6MtUF8zlhAMPbAUp6qw5PXRHg0Sz5oFi1McglZMTu/6UUR0IRHzCcFNX
	 2kaX0IV719INEInrVNAwoM5WwtX2arTflxZvSCMpOqQeuWdNDuvVTPAOoTSg1bD/Q6
	 4ZsuiwHQXP4xA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba51e69988aso843449566b.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 03:05:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Wp2HS8zpUzN8CMSpvEvmiR/Iw7m0fwUw/oUrx1+5KLcDB3ClPbFvCEBZ323Jf8Ajvj+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9EpaJoWq+QTg+RbakZbfUCi1rXhYa1f1n3sV344uhMt5sQI7
	OvB3tAmo0MoDkuZ0LeUtlQ8oxmRMsa9OhFDmV66FbAgdLM3IV5s5i6g0cJWQiU1u0EIwpkx76/j
	l+Z7qkpaCVpE31QqVOX/Di6N2koGTxlY=
X-Received: by 2002:a17:907:9484:b0:bac:6b01:8925 with SMTP id
 a640c23a62f3a-bac6b018b2bmr96646266b.22.1776938711131; Thu, 23 Apr 2026
 03:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422232407.3862942-1-chenhengqi@outlook.com>
In-Reply-To: <20260422232407.3862942-1-chenhengqi@outlook.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 23 Apr 2026 18:05:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6sL7xO4+rLpWphuBkwoChMDb-7RiFuFaWmK62QeXbD7Q@mail.gmail.com>
X-Gm-Features: AQROBzAVHDkmi1gh8ADEhpZiygd4AOvh3N2wjkUzubnaYiehT2gnF4DtSTbc45U
Message-ID: <CAAhV-H6sL7xO4+rLpWphuBkwoChMDb-7RiFuFaWmK62QeXbD7Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] bpf: fsession support for LoongArch
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, menglong8.dong@gmail.com, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied with small modifications, hope it still works well.

Huacai

On Thu, Apr 23, 2026 at 7:24=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> From: Hengqi Chen <hengqi.chen@gmail.com>
>
> This small set implements fsession support for LoongArch.
>
> Patch 1 introduces a helper named emit_store_stack_imm64().
> Patch 2 implements fsession support.
>
> changelog:
> v1->v2:
>   * rebase against latest loongarch-next branch
>   * drop patch 3, selftest is enabled by default
>   * add Reviewed-by tag
>
> Hengqi Chen (2):
>   LoongArch: BPF: Introduce emit_store_stack_imm64() helper
>   LoongArch: BPF: Add fsession support for trampolines
>
>  arch/loongarch/net/bpf_jit.c | 99 ++++++++++++++++++++++++++++--------
>  1 file changed, 79 insertions(+), 20 deletions(-)
>
> --
> 2.43.5
