Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC05392827
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376967; cv=none; b=co7zkCPzqf0JpW0N+WkjY0rEuQ7szcJfi3PhTajxmUP5ziYrFXl0FZ6ETgThk/JwesOeBq/vE6zTqJ/jjUSz+Y7BBsEoElDdOh8192jzL6xu52GCq3x1IPSDH87WappdvSqS2LD5k52O4I/7Qai5bPmMtYE2Q1T9G1h/HtdRbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376967; c=relaxed/simple;
	bh=jy4Q3CUvktfn8+VAW0w3P8Xq8m5PLzowEM5TQE8oNLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btVcSfEXywydCuVWxoQI7GZE5i5K93dev6R5btDb0GltiHBBVeJTz2j//QW2rVrIy0hyTVoQ8nufLECvsULOqugw3NbYwlCBq8e4vca6u2o/CrSHOYmimEbB+pRBAdnwoIV2EhYIqPE8v2/SWXd5s3IGd2VtGICuntr+7EU8JDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOR2D8ga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOR2D8ga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C62C19425
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770376967;
	bh=jy4Q3CUvktfn8+VAW0w3P8Xq8m5PLzowEM5TQE8oNLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gOR2D8gah7tPFdqCVM2lLqGUwLBe8mb7P8jpg62WJF//xgVMkTMami+8Edpb87qDs
	 nTuxoklE19h1cmxJrMQHi9MoO8JbKb9C+GVrviLxq2rP1NOVMNMfO7tT2atKZRRl0Z
	 pzgYBWsizLwZHoFBNSukOJd0Ak9nxse3AlRbvrKLprmOERcSbqtILCZ+++ck5oSoX6
	 SF49Ie2nnauhUH+VvSs/nu2SpNISBTMa2K6g67Vw12dgmBSZaf0GW43n8FC8OtUSHJ
	 Z9p+VBfIz01Hcpu/NLxhaywVIow+XKqNNKixvp7RzH3ozoLs4CBbJqX992QUjZEZON
	 5oLy+igf6Ptvg==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c9eedc2363so197511285a.1
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 03:22:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVRcTPYDlrMKxaX4bCqYx73Q/wHKHE1VTbZbyd1NCCiQHb9nX6XUyQYfvJSeUILy51bE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPxkF+LvSYdO49cTdieMRg9sFR/LZdAqQ7687V3Y8HAEWAE80X
	FgqID3HVS8bROZaRP/O5GolxOCskujoDsNLJs94c4ppNP/VZtt14WpYn/0tQ3lyT89b/RgpQgry
	NCrLbLfMLE9eeEozmYaOpSIBJ4X3U+io=
X-Received: by 2002:a05:620a:1926:b0:8ca:2baa:76e with SMTP id
 af79cd13be357-8caef9df080mr272076585a.19.1770376966398; Fri, 06 Feb 2026
 03:22:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203055231.1088479-1-dongml2@chinatelecom.cn> <20260203055231.1088479-3-dongml2@chinatelecom.cn>
In-Reply-To: <20260203055231.1088479-3-dongml2@chinatelecom.cn>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Fri, 6 Feb 2026 12:22:35 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNizNFc0j_eUNFR3_kO8diQzbjce8oLzBEOK2sWnG=rGhg@mail.gmail.com>
X-Gm-Features: AZwV_Qi-cIeIbB3tOT4yAHDZ8Q5KmenkkMoVK9VhYOy6pdcKzr_V1uBLBKbKtek
Message-ID: <CAJ+HfNizNFc0j_eUNFR3_kO8diQzbjce8oLzBEOK2sWnG=rGhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf, riscv: add fsession support for trampolines
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, pulehui@huawei.com, 
	puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, jiang.biao@linux.dev, 
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Feb 2026 at 06:53, Menglong Dong <menglong8.dong@gmail.com> wrote:

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index e4f45e2e7e2f..f10418ff6a9b 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c

> @@ -1042,10 +1067,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>          *                  [ ...               ]
>          * FP - args_off    [ arg1              ]
>          *
> -        * FP - nregs_off   [ regs count        ]
> +        * FP - func_meta_off [ regs count, etc ]  always

Nit: Please remove the "always" comment. It's not helpful.
