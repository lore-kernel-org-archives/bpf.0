Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A926B2AD
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782971156; cv=pass; b=gdkD07G3AyGL/uYgQCXcN1E3o/Fv+qRzCoNgZgqNaUEyZ1ubAptcYPo4XWtVSPdp45V2SYVFBAUDo39pCCD5HzkU0nQFgXfXb6OhAkPYiK2x1UkK24bTuuP85Qnw0i/3/lQpQDA6yLANjFQkTTrmRJZMZ2QofTcpzGHbFG7SYSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782971156; c=relaxed/simple;
	bh=Us3lu8rsfoACo6kmNWJ4XBU97yH87OXVkzYnIs3HwPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si6jCNGO7QmL/drk3DTPPWGYRzhqxJp4XAkezxY45Ri6mPGgsRrihezocMXAxZWOfdK49s1t98K/tZHn0eaSa2F0tR3NN9UhN+kavnw8ijybExr9l4stB31U1TzNUwCuIniCQcVDxcSY9Qm+z17Judogvd1b1oFVl8OXvvQbF7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYeqMexa; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYeqMexa"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-847a5528b33so750375b3a.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 22:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782971153; cv=none;
        d=google.com; s=arc-20260327;
        b=iH2dnXhMUJ+0XTqTjLewX1A/JlfRwsFNMNPFxyf5lYDn1crKwff0of6CZcs6gjwGob
         zLD/P8sYJ4dJhUVFYQ17YQJZxAO2ISloXhwJUoytk7opIUD4Td7Cs+1wfCNBQ1N4mn5a
         mOnpbuEQyP8cmnkLqsWVLJdqEGfOx3qZiZ/Wg2z0UAI07blotJzsjmjLFXsf3MtbhYs6
         twVRsIIwOVdVSPMy14Rtxb77GsDviQvKlOBpXP/Eq4n4CRdvvhwwxKwt8K+VYbEy+Ehg
         k0HpQCNmon7duLMp4eG6iWVKa/4n53HuWRFRhl1ohBUVGAcNa4dy/Rd6ii7AWaCfRLDQ
         4Tfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g0PcjHDH5/g1AUnjwMi1NoqoefhH/oCGnp5l0FHu/gY=;
        fh=nG4IHTex5lJUJgb9hdPEENg0CqEJqZnyjynyoYVUbnE=;
        b=oZQXr0pn3wytEC6GfsB+ujqCYFUwYd45MZgAGt0sdPeCKKwQWz0Uj68MnvrWGSNMY8
         xPgG8XSepSTDBY2Lb5v5uf1IbIk9lij5VC4JUakmM8Cp8bBr3cjipzwYUtZKIp6e8lF3
         ZO0xyVMwBA5cumQRM8BRVQ1d1Dj37bPL2IMsw+DcQvvtEp7ZJVNHfSEducwVZOi9AOFN
         SYLCykOgkVl4MVTrH6Ly7sBsrokBbeqZ8YmYhd+E5CqzwM3SC85EAS6+sA+8Z1Ny96Af
         i7SmFT9MpzzFOk6dsEF6mINW6vjzfFBKKjhKwAIbtq52VJxDMgbl475H1zlPrTfp8ggb
         ErxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782971153; x=1783575953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g0PcjHDH5/g1AUnjwMi1NoqoefhH/oCGnp5l0FHu/gY=;
        b=qYeqMexasFR58dYrwZgvIF1kYb+sNGYAh/NM64f/Z2IKKua9yGGmUT+l8M2PsTv3ZE
         aoyi7aSxfkgrrS9RPj2RSN5wZXpYT/7LP5s5PgWkx1vyCCSlyiRpq+ql+hMTPh3m+NRz
         nB0WuoHj4yXn8Tt7JUgD9A3XY3ORL23F//fQu6QGVgmHcRzanfR+ZMo/p276KNJq+Ekm
         5xrKuRmbnaiafqRvwpQfwlrA530zecQYinQaOMmQlcrvyWG7+zJMPnbboufNFzZxXNcx
         cja+LPPn64EMaCuwF/ORS68sMYbyYFRkQO+oGIq7ZZBgGj4n+664x8U9ySqBbx3sbSgu
         j3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782971153; x=1783575953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g0PcjHDH5/g1AUnjwMi1NoqoefhH/oCGnp5l0FHu/gY=;
        b=k6k4PYVGZXCCcATvx8mNY3ZXX15ZcKxkVJcPREw1w8j2Q7bgIyGQ/RPARSGtq1egNt
         DRjm0Q392DDmhu57X6UCbbkRT18mohnjldT1vzQweoFld5TlzqJ4FEU8yd9pLjRR+g58
         2Mqj7IxlB1o21KjkEt5CL+WE998G8co3z53jnri7def/8fVeOoBpGBny9QvDHrR+w23P
         kLugqWRbxq1RdqjlOwIyTv5EcrahSkMK3ZGZfjA02qbkG4Fxxm/AHz3iAMFCZT7r5Tp1
         VPncFz/9UTxinbVU5f0kd73cfxL6LvZygUN9HBMAeTnjKXRsnsptoXiZpkyyS/7rhwaV
         iWeg==
X-Forwarded-Encrypted: i=1; AHgh+RqkjaxE1mmD0t4q/gk07Te7jzTaQUgkg2e9y/gmLpFNTkDCNtXYM3r9gHf8Nga9aLl7RMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bCU8Npeom0sZqy42w+JNj8kEcRkpjcG7PP3waWFEmBLvpsMr
	96xVw/NH+SAA8Sv67bebVcdZiIohoY+/cu0fsk35OVC0yzbdpNQGjHb0t4q276WJ+ife1SuCjPs
	G3AYJhF64KiFl4KDZUgDI5UvCtBMfKtk=
X-Gm-Gg: AfdE7cnHiNMjJ/D2eAagXIbQ5e3s1AYO6RCWiu6XoCEGktZwRBppcFwhhzkos3D4wYg
	ERWkCNjPXfZLHOY4fLKXJcuu+QyM84wQM27/9oTga54CTHF+Zdh7YxeeovJK6i/8nTiuAVR8ynZ
	WDn7ecpgYk9Y8B0YHPlFkb3t83oCEETACdoSf82s25WhnXnODkQgfUsmcSQPqX6vN1tl+QHCYY1
	CAWTy09diDpIwbaukfgCHIW/tZYR75yBK9PR9Iaw9HhNvNe3Y1kCnPK1wPAh78YqmimIwDm8xv2
	N/oi46VOB9re1tW/t5J2rS5DP9/IYBuiCGJs3rbMf87PHe9rDIqSrvygpNmyTmXnAxs8TEdizWw
	ZUA2+tTMp5MqgOQ==
X-Received: by 2002:a05:6a00:4b47:b0:845:44c7:2fdd with SMTP id
 d2e1a72fcca58-847c5130544mr3668709b3a.34.1782971153059; Wed, 01 Jul 2026
 22:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702053127.23599-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260702053127.23599-1-yangtiezhu@loongson.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Jul 2026 22:45:41 -0700
X-Gm-Features: AVVi8CfJEaFhpmz9Qe-b-2hBo1s2crIx9Qi4j5yRvwaaHjxO4nI2WoWc3T7AS5Q
Message-ID: <CAADnVQJodzDppDUjSYXra-jCo3J32t7=h32bHm4tQei-+5P72w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] bpf: Reject programs with inlined helpers if
 JIT is unavailable
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KaFai Wan <kafai.wan@linux.dev>, bpf <bpf@vger.kernel.org>, 
	loongarch@lists.linux.dev, Leon Hwang <leon.hwang@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 10:31=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> When an architecture implements bpf_jit_inlines_helper_call(), such as
> LoongArch, ARM64, PowerPC, and RISC-V, the verifier skips rewriting the
> helper call offset (insn->imm) during the bpf_do_misc_fixups() phase,
> because the helper is expected to be inlined by the JIT compiler. As a
> result, insn->imm remains as the raw helper enum ID.
>
> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=3D0) or
> if the JIT compilation later dynamically fails (e.g., due to OOM), the
> core BPF subsystem falls back to the BPF interpreter.
>
> When the interpreter executes (__bpf_call_base + insn->imm) with the
> unpatched raw helper ID, it jumps into an unaligned invalid address
> space, triggering an instruction alignment fault or a memory access
> panic.
>
> To avoid modifying the BPF interpreter's complexity for JIT-specific
> paths, just introduce a 'jit_required' flag in struct bpf_prog. When
> a program contains helper calls that skip rewriting for JIT inlining,
> set this flag to 1. During runtime selection, if JIT compilation is
> not available, explicitly reject loading with -ENOTSUPP instead of
> falling back to the interpreter, safely preventing the kernel panic.
>
> Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> v6:
>   - Place 'jit_required' as a standalone u8 field right before 'stats'
>     to reuse the existing 4-byte struct hole (offset 52) based on pahole
>     analysis, avoiding the u16->u32 bitfield conversion in v5 which
>     unintentionally changed the layout/alignment of subsequent fields.

v5 had AI written all over it. v6 is not any better.
Please ask AI whether your v6 is any better than v5 ?
Then analyze replies as a human.

pw-bot: cr
