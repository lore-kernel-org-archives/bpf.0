Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447447FAE5
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937619; cv=pass; b=FTqpLYYBx7AYCaFApM4W6lbf+5Pu6++WGOD7xs6X2Ww3cMZ+8LbqUGRuBgpD0fNU6c9wrPsb8tPV4DEL6mOJa+WfY4YWB9iKgj7r5p684Qu8UzkIs8OHjYfCEcYCspBc3aNGaURERjhdE5h7fXNuwlN/GoVO0TkdRd1QjWb0X4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937619; c=relaxed/simple;
	bh=vavxIjTwCBZOVb/LPQjm56SKHMFhwdOAoimT94wdeSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6G4m11xZOxVyuGctRdpRTvD0ggB3Qrafvt9mG6ggTYOS9XA03RpIwDZhP5JmbBLie2YqFBjQSOO/q3hi+bw8XwcRm2J7D+dIRzGKMrWxuHLa76HCRdluKFIYc7QPyYCyTuxNotu/3YqcxTSf28eRCDzw3X9ZxljDc0TDlq/j9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkEFhlab; arc=pass smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkEFhlab"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e3f641442so215243066b.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790937615; cv=none;
        d=google.com; s=arc-20260327;
        b=gW7SUToxAlmN643xsGX/qbQO2Q85hqttmE10yrGYQZVFnTp38Ok1g+rCjO4u5VvCNd
         8QggIQJ/Tbehc3VAIqUPcSyDlsHi2IwOH0dNKWlzRhwny23efuB7FushykgOSGf81eVc
         tgbL4Zp3oiPWXxauW3X4mOf4rK+C98viw/nUJq783T5Mld6/fDw+GcMHvEtBCdqrLANF
         3VDNhwA9Cbife9pNRWHkT9O6vRPAD8A8gZxatPozujk+vSGLgZuAZC5hzMY8pJtOUQ1r
         wGxxvPD8N0O3divRFPoVI1HFb4AT5pkMADfE1SjuU24/9QjuVUN/B/54Ls6du5Ty5Wnw
         oXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aluc5VLd/GgszPlfBHVygLWYzMV/6IhocC43q7cYG8Y=;
        fh=ynVuAC6BTFSX7fybUcYkvt3g71RzTr49vvoShUINrKI=;
        b=psK5+aPDzYeC/1mf6I8aS1uNrLnZZLR6QNFupBBB7WOZid+dEYkDPiV3dF7Gh/Vwp5
         UjGqBDb/lMe3XF1QzFAmWKZkMjPui4RVl4KALu1bRSHMMKIRoIzTZxUrOkXrGOG9gH5R
         Hybul1nNGyoBixBZfBf3oHofUbYs6aDDQKhQ+dRs04XPFpFvCoDm7H+ZnpzH9hPykFOs
         2b4n2wpyr8UhQR/1TPDHSxNA4pF4f0fjnLonvDuDtRG+4folZs9s1I5HadN+DbEj5dhd
         5IAdlgkrYDZ8mAorgR5aUKhcKOCC/GbgkrdBdANfJ7bMH7TZy4SE46HV5IkZZ/LxdWVV
         DYOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790937615; x=1791542415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aluc5VLd/GgszPlfBHVygLWYzMV/6IhocC43q7cYG8Y=;
        b=IkEFhlabPmFpC1Tlwe3N7oLA3hJDj3T7AQ70M6wl+fP3IlYD9uM3UaGbLJ8V2jExHC
         4Apj90P/6wYOEpvy6d5Bp5qhHtpWRHf+6pl+EMJAk1mXZGNO0QQYGQ//aMVwqarlXTcR
         JUAHvlUAQIizVuK4fedrvnh3DTTdXZ5BiguAEP6wMhrk+ity0fihM+SV2l+FqFnqrFTb
         msPw81jE8PvJ5mhl2LGSJZEOu3/HcYSWIYyGRCloexk3XwBH5Zf9D0AZuR4hqD3olMyO
         JWx1NdZ9x3nkE3KgBLOh0SpSclsweMY0nG18Rbz8lR7aOICJJtnOUZGeQI9hE2OmcJcb
         5zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790937615; x=1791542415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aluc5VLd/GgszPlfBHVygLWYzMV/6IhocC43q7cYG8Y=;
        b=zxGutObsKBqLYeF2s62Fo08VFziMoUdiBLgGUfP+qfg0owMZ4bm2IXtV1RPVaaHXrD
         oFgpin6LXtgM8ou6J3B9J4aVMxgEe+iKAtbs5yCnikmzEMzSV7h5yvjkqeafFAjE8iGY
         0nYB6fzheQtk+qXvoIIUFUL16MfBDjg7QEeXq6N5ezkpl13WyQo/Xtqw66tv/4sQ9URi
         VQ4zF/Y4KeZMuobWM+rWFXvwKs1PFvOL/fdMrxUwmCWx/5DVWq8dWSXb89LxqdGp2z5s
         jx2Gw0GEqWB9dJEsHDoNiijCxCcjm8sVQMLiA2ZIDQdAXNJo8gW6DiRjTn7h0JxAHwDW
         ftMw==
X-Forwarded-Encrypted: i=1; AKwUvBxqmjY0hh4iESU3JdAEyR1iLZy71xafVuJXCX2cJVGyqsfmkQe1Tkk8NJRgaZJaLRmxCng=@vger.kernel.org
X-Gm-Message-State: AFuF++mubetVV6kssErGSh3gcEGR9YEHhRLtZatHlHOXcnCfUrp2sXDz
	YnlMGczD8dD3ruktpvQywLtl+pumuWQTwcS27+s2634W8dVp/liO9wgZcxcETdmBClFotw+ukjg
	D1+otIfLU398lQy8kKToJdQNK0BxhEq4=
X-Gm-Gg: AYBFou0cJrAJRIgDUybmJtputeKcbzAdRxa+DQ6vG6XOfiLwro3F2twa7U4on1DD6LJ
	85ekUXWU4EayGCIjHyhJFkZ7/D9xc5co3fnE7hLxTFyFMMwkRWxQq8Wuusp3YNG6x1dbp7VzQhJ
	diQG5yXU4ZA+FmdHlIPGW2J1mcF1XWeCW3I7TPa7KJryALHGeccFqFDW2DfKWMEdIjwn7X7AHAK
	N80mMDukwOMj/Com/jL3ErpJlpwOh0xV5aPvwLR3wWF8zK3qA5OgNPxYsnmY88N3hI2OlzkbGFs
	8PTcrnMJW0i3DIgN7VTohDwUOxOFBHYJPDq5tp5z90Gfgu97RdwaZLMOG5JYaaE+jA4pXJ0m
X-Received: by 2002:a17:907:6ea4:b0:c2e:3546:516c with SMTP id
 a640c23a62f3a-c2e4b25913dmr200400366b.43.1790937614670; Fri, 02 Oct 2026
 03:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002044050.1277356-1-thepacketgeek@gmail.com>
In-Reply-To: <20261002044050.1277356-1-thepacketgeek@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 2 Oct 2026 12:40:02 +0200
X-Gm-Features: AclHuK9AVhCdx3zsz00yoixuqBqUrOwteFjJfeQNP6U0nNJc_amJox9UNxz5jVQ
Message-ID: <CANk7y0iNFFyHW5zfTOeX23K+gozOOKgEWWWyG7Uty9Jo+VC-Yg@mail.gmail.com>
Subject: Re: [PATCH] bpf, arm64: Fix text_mutex critical section in bpf_arch_text_poke()
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Breno Leitao <leitao@debian.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 5:40=E2=80=AFAM Matthew Wood <thepacketgeek@gmail.co=
m> wrote:
>
> Widen the text_mutex critical section in bpf_arch_text_poke() to cover
> the page permission changes made while updating a bpf prog's plt target.
> When a long-jump trampoline is attached to or detached from a bpf prog,
> the plt target at the end of the prog is currently updated before
> text_mutex is taken, by temporarily making the page writable:
>
>         set_memory_rw(page);
>         WRITE_ONCE(plt->target, plt_target);
>         set_memory_ro(page);
>
> Leaving this outside text_mutex assumes the page belongs only to the
> prog being poked, whose pokes are already serialized by its trampoline
> lock. Commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
> management") broke that assumption; it switched the arm64 JIT to the bpf
> prog pack allocator, which packs programs into small chunks of large
> shared allocations, without updating bpf_arch_text_poke(). Since then,
> unrelated progs (and their plts) commonly share a page. Two CPUs
> attaching to or detaching from different target progs in the same page
> hold different trampoline locks, so their permission changes can
> interleave:
>
>         CPU A                           CPU B
>         set_memory_rw(page)
>                                         set_memory_rw(page)
>                                         WRITE_ONCE(plt_B->target, ...)
>                                         set_memory_ro(page)
>         WRITE_ONCE(plt_A->target, ...)  <- permission fault
>
> This was hit on a 64K page arm64 machine:
>
>   Unable to handle kernel write to read-only memory at virtual address ff=
ff80008f46d5f8
>   FSC =3D 0x0f: level 3 permission fault
>   pte=3D00c00200ea5a0783
>   pc : bpf_arch_text_poke+0x214/0x238
>   Call trace:
>    bpf_arch_text_poke+0x214/0x238 (P)
>    __bpf_trampoline_link_prog+0x1c8/0x470
>    bpf_trampoline_link_prog+0x64/0x90
>    bpf_tracing_prog_attach+0x318/0x4a8
>    bpf_raw_tp_link_attach+0x104/0x258
>    bpf_raw_tracepoint_open+0x6c/0x90
>    __sys_bpf+0x134c/0x3e10
>
> Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management=
")
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 475e70653454..66fab0bfd3da 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -3338,12 +3338,20 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_po=
ke_type old_t,
>                  */
>                 plt_target =3D (u64)&dummy_tramp;
>
> +       /* pages of the bpf prog pack are shared between progs, so the
> +        * set_memory_rw()/set_memory_ro() window below must be serialize=
d
> +        * against other pokers too.
> +        */
> +       mutex_lock(&text_mutex);

Thanks for finding this and fixing it.

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

Alexei,
I am not worried about the comment style, can we merge this?

Thanks,
Puranjay
