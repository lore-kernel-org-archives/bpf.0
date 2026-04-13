Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3834676D
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100830; cv=none; b=pBOTVO6NJdCmAEIUrV+O/8AUmDEgJdg4z/E6YIndi9gJJjUUCtQ+PhGKU8ATibicc7fGQwd9nCipbGomfBxLDsHZuYUyXmYIA57QvQFnjzk2sfr9N/qqWEQJgC9SXnV5LPrHBf1kM6TFPU9xHnn6gdQywUYvnweP/G2lXoQ1nHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100830; c=relaxed/simple;
	bh=Y1VX+P8oKWLTokXsXbxH9r3i6MRKz6cq07No9cqxGa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAfG61vkoyzoqsIO/wveQMRebjE4pPWxAPN+C5Dl1vptI4qeIxx+iRRc6dKi8wg0H1MEeqJ/Z/XDEQQ2ucPiUD30jOZ9TtNR/xVI+xH7DouJxhFn6UWecUsPpqs2/UTPWKZe5CikHNR4AvcWwjgHqi0nL9gciUkmzSdzP0/xqgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjx/j7Ee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjx/j7Ee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BD3C2BCB3
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776100830;
	bh=Y1VX+P8oKWLTokXsXbxH9r3i6MRKz6cq07No9cqxGa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hjx/j7EeQb3ovYPGcgHFrgVCclYE08OplfS9oT/yGLNHuzLisJZpRzLV3eZjrmdjB
	 hfHwN2AcfWQGGakTUlq7+7EAeGLSvhOiSYsofrjFWQaUxwcrg7lPshv6iBy3A2/hrv
	 nQZ9g23zvr9lf6q0UJF8BZYXzIoby59+URWoanrxR2P4vJanFR7EVgY+3NTgyePjyG
	 b/c+2aOcFMBIByTZz75EukZHTqr0xFgwIcuQg5Act6bDZEgIM1X2CuNlhY04AwEGns
	 lhDFafyG1ALEsyk+SoCF3Sden37R2DtH85Xu9mJgOI5djFUKG+zlj+U3iTKZS2z/TP
	 XFCypl8OUtKjQ==
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d876329bbso49830071cf.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 10:20:30 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxw+qFZXXjM9lhePFRlqjOXbqpmuepmzR7GY3HeRjm0s3+msMpy
	ViBbczB4s7dwBYDQ1S9QPo1E1Kg3LQL7olMNqc2hIb5S//S2YYWUnjMuY5QOvl+ZO9+BW3MDc5m
	VYsGMX+pdBzs8a1wt9kH3OvSdoRsr8ys=
X-Received: by 2002:a05:622a:99a:b0:50d:8905:7cc7 with SMTP id
 d75a77b69052e-50dd5750f2amr228728281cf.0.1776100829547; Mon, 13 Apr 2026
 10:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413123256.3296452-1-puranjay@kernel.org> <20260413123256.3296452-3-puranjay@kernel.org>
In-Reply-To: <20260413123256.3296452-3-puranjay@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 13 Apr 2026 10:20:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5=qtjESDr-HQkxkYKrBFjpXAf3HRYOH5ESEd8Wvv9dYQ@mail.gmail.com>
X-Gm-Features: AQROBzB08PAYs8xzmtpFMbY0dd6o-2NWqQR25UWik8u6kWpL-cfIxQiCnEnElUw
Message-ID: <CAPhsuW5=qtjESDr-HQkxkYKrBFjpXAf3HRYOH5ESEd8Wvv9dYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf, riscv: Remove redundant
 bpf_flush_icache() after pack allocator finalize
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 5:33=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> bpf_flush_icache() calls flush_icache_range() to clean the data cache
> and invalidate the instruction cache for the JITed code region. However,
> since commit 48a8f78c50bd ("bpf, riscv: use prog pack allocator in the
> BPF JIT"), this flush is redundant.
>
> bpf_jit_binary_pack_finalize() copies the JITed instructions to the ROX
> region via bpf_arch_text_copy() -> patch_text_nosync(), and
> patch_text_nosync() already calls flush_icache_range() on the written
> range. The subsequent bpf_flush_icache() repeats the same cache
> maintenance on an overlapping range.
>
> Remove the redundant bpf_flush_icache() call and its now-unused
> definition.
>
> Fixes: 48a8f78c50bd ("bpf, riscv: use prog pack allocator in the BPF JIT"=
)
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Song Liu <song@kernel.org>

ditto on #include <asm/cacheflush.h>.
