Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF198335072
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099404; cv=none; b=AO4sO2nv4mtbps8PWmCOKH91Zidg+Vs1Ti/V5XDlgbui7qNaaT/gNsNqUR/gcZtZl/RLgmzyWKxgPhZpLlqF0j2ujCMnLPEf3rzWbWo1adB6KRjjIvk8u5W8GMzmcwds7lMM3d7ogvhsUVotsWC87ZEs04X1cPMMvD4mgKKDW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099404; c=relaxed/simple;
	bh=h2aM87LBp2ambqCZSnTPbSPCg4/IJ24tetHqkm6TuZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3azQDcDUlR979775xjTnkTpi5OmmIVKZ2HYHTy/Rwj7+xLWPCiH3xqbJpHVCuQNkJqzrNT+ldDdea72lxx7rOzudLxrgeZ98jgzetMTKiI2DBa7IVTFr4Of/hRDKxEGhhFCS21HIm8/JP7BIJjvst+E/U1qhS2ihBB9Tk2DL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1/LSmdy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1/LSmdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4385C2BCB3
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776099403;
	bh=h2aM87LBp2ambqCZSnTPbSPCg4/IJ24tetHqkm6TuZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A1/LSmdy8yQDvjhZ3UN23Bo1McCQ+BT+1wnSom64e8RPslCZBRZLZIP6DRRf0pIiu
	 AYUhIYTPlTfs63sOgeuMTapnP+rp30KAelHN3fiI7E0FL9IIN4468pLK6etoZQqowd
	 Brmmh/BJ2JTJLKuhww2KBw9Lqm+n57uNrYTJb7VSEd62ymZC4mvO1GHqDbQt1jKcNs
	 gClElEadOplATXbg2ENOVpUiy0Eeo64gftDYX8vYoWNMVxk02iYF9WT0cI6nCOI4C4
	 ftBfR9n2a7QwTBDniLN8evg6WYEqH/5xzu3IzSDok+J9OoT1JrU0gIeVjU5mbKJSbS
	 N82p1DC4TX89g==
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a05c18d3e2so43451236d6.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 09:56:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YyCKyMBGQvW35tSC2IfaYKgfOvi71rAJSfD56m6ppWXv/BomgZj
	0lrK2ExIjuLneL18Uv0Qwqd2+kWdb0684/LviSwt+Mdp9clWIpisZW8M3FdOklj+F/XSrZUcAO7
	OdHPyqz8yCahldZM2drxWS0Faz6X/BA0=
X-Received: by 2002:a05:6214:3307:b0:8ac:b2e1:3798 with SMTP id
 6a1803df08f44-8acb2e17026mr38597226d6.28.1776099402680; Mon, 13 Apr 2026
 09:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413123256.3296452-1-puranjay@kernel.org> <20260413123256.3296452-2-puranjay@kernel.org>
In-Reply-To: <20260413123256.3296452-2-puranjay@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 13 Apr 2026 09:56:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5M6-9HdYhGnerZiSnZM=VdgN-H91ND=Qop+thEASfvQQ@mail.gmail.com>
X-Gm-Features: AQROBzA1h53NIbW6wB2_ufILfMN6eHhnFaWBiPdIcTkHfEIuA00ldjcsm5gEbB8
Message-ID: <CAPhsuW5M6-9HdYhGnerZiSnZM=VdgN-H91ND=Qop+thEASfvQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, arm64: Remove redundant
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
> since commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
> management"), this flush is redundant.
>
> bpf_jit_binary_pack_finalize() copies the JITed instructions to the ROX
> region via bpf_arch_text_copy() -> aarch64_insn_copy() -> __text_poke(),
> and __text_poke() already calls flush_icache_range() on the written
> range. The subsequent bpf_flush_icache() repeats the same cache
> maintenance on an overlapping range, including an unnecessary second
> synchronous IPI to all CPUs via kick_all_cpus_sync().
>
> Remove the redundant bpf_flush_icache() call and its now-unused
> definition.
>
> Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management=
")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

We can now remove "#include <asm/cacheflush.h>".

Other than that,

Acked-by: Song Liu <song@kernel.org>
