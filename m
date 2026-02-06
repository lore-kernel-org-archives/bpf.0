Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0832D33AD90
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376837; cv=none; b=F2lqlUarz6aDjYKlh68POv+THxrNqQ40QvOjmb8w7LcKun5+XMd9s41lEDlx/dl2zcdaTy0OH1ck2shzngVqE26T6c1RNf5e6IyU2Z41g/qGUr0fnp2RE5nY8u+87kLUp/7jNHB/+4iAw5LdjH39j+/j3n88HLtTWGwfVwCa18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376837; c=relaxed/simple;
	bh=+0Zf81B1zwL2wSz5t/L+Z6ELV13gCyGdVzUjKB9M1Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv0EVPe3JCVHbGVib87a7zGlmsbTWXiiJwIvbu5v5tMVDwsC1Tu/4tyYM9c59V1XEltF2voBG6Y4QwwIOTg8XZwlfbMnCxtuHT2uK7efr9D+Og68Gnlqoqe4yXAm9jzYVkGNvGQVKK4EMKReKGS1lMbmSt/hfR8f2V9T2HF6asI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1JlEi4+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1JlEi4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A602AC2BCAF
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770376836;
	bh=+0Zf81B1zwL2wSz5t/L+Z6ELV13gCyGdVzUjKB9M1Uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X1JlEi4+A/BeE46ROFljUPd0gcDPYROCoJCjtCsyzL/EyJwE1SXQKEeY/NMgm9oHB
	 tFZVuQtUzi7hA3PUKNhDiIViyUp0SHxDcKC/kad62VbEnK6hZ2YaisS4ZTHDtdj65G
	 kBz1ROeebJds0quSurtgOAfPwElV9F6/ZWDEGMuoIL98Wp1SfgHANduYrB7kLe/zYT
	 LCiBGqCkdbbG9poTc2PiI91mq/n0IQVub0BdL31xr+2p3j7VSUDabS36spR2Q9H/u8
	 OCIe44z8pn3/3R329cWpfN4puIJAmKalHWNuOou4TnJZYmdkcnTi+3jCAdL/pS5hI8
	 jKNpjf9qkJg4w==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c532d8be8cso170799985a.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 03:20:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZ06i8sPulWdquDtkCCAvTDihcARCiEhZLX3tOm5WnrQXV9WEYV9HBmujgJEnIzomklc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7pKk4xLT6DIGKOIDRW4GI1mPA3gdojaItCR/89mjDciopmJh
	GU5eDaEefi7o6WU+ZIqhqWJFLiGF8zVr5DBth+cKPJZuFSrTzwkzIwbB/vORqc8/O8VKF8a+qni
	YCfFTsoh8ggUzk2FXKIGbpRIL5uzKo7M=
X-Received: by 2002:a05:620a:458f:b0:8c6:a034:9224 with SMTP id
 af79cd13be357-8caefeb5124mr294393085a.47.1770376835715; Fri, 06 Feb 2026
 03:20:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203055231.1088479-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260203055231.1088479-1-dongml2@chinatelecom.cn>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Fri, 6 Feb 2026 12:20:24 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNh63kg7QNOVhn4As1nGBLDLEy72zaiz0i2+CZKe=f9WuA@mail.gmail.com>
X-Gm-Features: AZwV_QjCrScYWjPV5ppNztAa4kuGugsdR88HnW_ml3c8dytE-xCI9Xjh09UuXZQ
Message-ID: <CAJ+HfNh63kg7QNOVhn4As1nGBLDLEy72zaiz0i2+CZKe=f9WuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: fsession support for riscv
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, pulehui@huawei.com, 
	puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, jiang.biao@linux.dev, 
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Leon Hwang <leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for working on this!

On Tue, 3 Feb 2026 at 06:52, Menglong Dong <menglong8.dong@gmail.com> wrote=
:
>
> Implement bpf fsession for the riscv architecture.
>
> Menglong Dong (3):
>   bpf,riscv: introduce emit_store_stack_imm64() for trampoline
>   bpf,riscv: add fsession support for trampolines
>   selftests/bpf: enable fsession_test on riscv64

I'm happy with either addressing Leon's comment with a follow-up, or
spinning a V2.

For this version plus Leon's nit as a follow-up, or a V2:
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> # QEMU/RVA23/DT
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
