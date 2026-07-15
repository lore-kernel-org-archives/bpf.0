Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04930E0F2
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124917; cv=pass; b=hIfmhLKmWeoBm0NqV52FnIkeERmrMJ8NGQ0FzYVYKyuk/yDwAp1D9/rrlOwge9SGhl0IDBpOQlLva4po9/GnTwcCOhHiGiHy9X399jksjIW/TfNP3nbTwRO4LI6nPuQIM5HY/rI/VJEAowr8BI9NnkdRMI3Mob9ymGHGzzBgnA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124917; c=relaxed/simple;
	bh=3jlx9K3PTRTeXtJ8eCOM0V565imsMR/YcQD5yDCtp7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDJU2Y6TpQmuxD81CD5T9rRZTpUek4ivix4pAScS2NiJU2hyH2n+RTXa9UuerR7zcCyxY9SeUm4TCzGayj+JkdYChn1vXoavyYzfEIRLzs+wbx2Y88sv3tly6RcCqWl4WW3fcckIfbFSwoojYJnxK9J0HVnge7qSMfCTAGJGRHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9MZRiXD; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9MZRiXD"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15d111ca99so544638366b.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 07:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784124914; cv=none;
        d=google.com; s=arc-20260327;
        b=TDY+zcFMyj0quZMAKTsaW9kmZl2sVjwu2We6w/AY/qzMMT1vlb9Qu3adUPYMFDpgFb
         D9QqaNVXrSL5PJ3VFD0Kmy9Xp1MnsY3Mv+W/e2qqgt5tH77gvPq6ZLYC82SOmTFvhrdO
         ZhSLYeoUTITyrRggv+IlJcgG0WZa0GCIjimvr9NhiOa9qY4QZltvlNPG+RO3iGqhpCLr
         42WBZ3gi8xi87BVOE1mU60brUj7BAl9VR0pu869zthDROmKIN+rB816hR7U5BLvAWN1S
         xLFh3VRoZ5MNH8bmrBagjbKFjRAiD6ggzUdSXgk2/UCyfN29MGK1DTsP82++x/6Zwd8r
         NPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VzWsCGHOO4wHgSTGr+f5wTvekW1mXjLFtc2AiKIYkRg=;
        fh=hH6VPZuvf9Ty0H4cTGc1bJWbvmhaxFGff3DypXIY//I=;
        b=sqJVtIqEcvmxDZZqoahcYRmtppX7jsrWfBLWrf/YX38x97wdCMeQLKKRYh1SPqkexo
         GWYJ/7zl9EQxqdhEkJ85r+Woc/6aNUYb2rjrVwmtAXCZ00CSh2y8PZ7Z8aZgLBZEvVRA
         QBRtFFszdfXd9tPIr9uiRlLBYUqLlTUFGLJi9JMG0XUOZUswavNc3gKoGLQ4ADd7Hxnj
         grLUF63O62SJVeAsUuZ+ie7lvxDAHUBa4JB+7Mu/HAKyWBAp0yc7qSBuAW5Rg6Uo7UVv
         pmu8MEnDbGg9h0YqGRcymgPEjQPAQhHkzTrfyjnxklHvvV3Te5cycT55FZ5Y/MMjxJ0j
         dyGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784124914; x=1784729714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VzWsCGHOO4wHgSTGr+f5wTvekW1mXjLFtc2AiKIYkRg=;
        b=g9MZRiXDbDlDkWjIaZ9LHTOwdxW20oemBs+tUAflk8iDdgqTBp4krPubGawmXPHO+K
         hoFVdgG5FXYyR4A3OXNqtWHv6myLCa8B8sDl0e3jdUGEP86+L+A7vm/AclcSONstAUEO
         hPLOXI77K8WKHptTvpGMICROL5b7bNvcMDQyo/I9HUlyaLH0g048SWD65cAikD9hE4w4
         Xixt58JXzTB/oHVyyureB7tNlETvPMsMTgkg8wNgDOEVwIXCx+yWuDj8/9P8ANkrvy4/
         Gh/y/t09IHF1uimKyLif7UbvbyFgMY3bTE8XwdGDm8oP4mo/GdUIpsjq3VJ0KP4KHV8B
         i8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124914; x=1784729714;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VzWsCGHOO4wHgSTGr+f5wTvekW1mXjLFtc2AiKIYkRg=;
        b=TRtnL7TUbwLJl1ctxPC/41mFUuGZY4S+rBR2z7Rp8b7r7rniGFs+YY6oqVy8nMWgwD
         Wjk9EAgamhmdYleU74YVQDkIyoKqHJauD1tRoU+d8liWxpOvcJ78uqIKQUGwK/cA5OJP
         Xqb1drkdsqWQRTAIjHCceJDF4Fsbb3bG6NT4EdSnJJaP2BKgp2BkY75MqLxZcC7mUe/2
         iiob9tSRgjGm9lHQYpxOlgxvJjgI4G7eYxT+FDx/EE7JR0D/lSz/UuuL8wHV4Gtu+4tH
         wdSB5TjbVeTARdEr4Xi3jPQBPIM7a07sAlohdeLWyIe1Qyb25a+4TMhsZLSlEJfMcv2M
         fIVA==
X-Gm-Message-State: AOJu0Yx0eaG3HKhkgVkgmlMHDHEEsaDhNFIiZg62O1yu0a5Wyy9MrR42
	USvAXahox5E4qZbCO07AFO3UTh006VABoGY65wWvQupft9QdVDltPLQClh+IYQ06GJvZaS9BHOF
	JnWxRzTm0NiRuJLtSjwhkWcwf8u4v1Is5tuH41FU=
X-Gm-Gg: AfdE7cl2EjzPMe2Hd6xI2vvP8M0DoILqeWEfQEi8+Kd8bouO6iKkORcJ6YQrsLoWvJo
	qh3o293YiLKM+iWFWJzZIE/Bqp517qB19QZR+ct3SumNVfZ1notHFl/RlnyBAIaq38W7cCDoWga
	tf/JuXiphHMi2IBXQSPdthp0U8b0KxGo0j8DxHF8p+f8NkvfnGe0OwfYaV40W5NaKdmBGvxgLhy
	ME25q+n/pt+O4TdJNQCMzAtmhlJJoHl274Z1u8eDVy7jFC5y9iNKP87DEb0n84kQJNWM4GdKf//
	sYTIt1qyhfhS
X-Received: by 2002:a17:907:7285:b0:c0e:e136:5dc9 with SMTP id
 a640c23a62f3a-c16794123b0mr190490766b.37.1784124914100; Wed, 15 Jul 2026
 07:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715130430.318421-1-puranjay@kernel.org> <ffb90c46-6bb4-438f-8915-6983a931d3e1@linux.dev>
In-Reply-To: <ffb90c46-6bb4-438f-8915-6983a931d3e1@linux.dev>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 15 Jul 2026 15:15:00 +0100
X-Gm-Features: AUfX_mzAskEzwSfrVsPydtF9YPXnqD2PinD599TCsVj--GPI3qeBl8OQv8XC8AM
Message-ID: <CANk7y0iv3td_3E8b8TZg1EvaEv-dPPVRGnrNXAE85qZqoWqN8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] bpf: Inline the numeric open-coded iterator kfuncs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:11=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 2026/7/15 21:04, Puranjay Mohan wrote:
> > The bpf_for(i, start, end) macro is BPF's open-coded numeric iterator. =
It
> > expands into calls to three kfuncs: bpf_iter_num_new() to set the itera=
tor
> > up, bpf_iter_num_next() once per iteration, and bpf_iter_num_destroy() =
to
> > tear it down. The verifier emits these as ordinary kfunc calls, so a
> > bpf_for() loop pays function-call overhead on setup, teardown, and =E2=
=80=94 most
> > importantly =E2=80=94 on every single iteration via bpf_iter_num_next()=
.
> >
> > All three kfuncs are tiny and only touch the 8-byte on-stack iterator s=
tate
> > (struct bpf_iter_num_kern { int cur; int end; }). That makes them good
> > candidates for inlining, the same way several other special kfuncs are
> > already open-coded in bpf_fixup_kfunc_call(). This series replaces each=
 of
> > the three calls with an equivalent inline BPF instruction sequence:
> >
> >   - bpf_iter_num_new(): keeps the (s64)end - (s64)start overflow check
> >     (emitted with sign-extending moves) and returns the same
> >     -EINVAL / -E2BIG / 0 results as the kfunc.
> >
> >   - bpf_iter_num_next(): the hot path. Since cur and end are int, the
> >     kfunc's (s64)(s->cur + 1) >=3D s->end test reduces to a signed 32-b=
it
> >     comparison of (s->cur + 1) against s->end, so the inlined code uses=
 a
> >     32-bit compare with no sign extension.
> >
> >   - bpf_iter_num_destroy(): a single 8-byte store zeroing the state.
> >
> > The emitted instructions are plain BPF and remain valid for the
> > interpreter, so interpreter fallback stays correct and no jit_required
> > marking is needed.
> >
> > Patch 4 adds a bench_bpf_for benchmark, modeled on the existing bpf_loo=
p
> > benchmark, that runs a bpf_for() loop with an empty body so the
> > per-iteration iterator cost can be measured directly.
> >
> > Results (./bench -p 1 --nr_loops 1000 bpf-for):
> >
> >   +--------+----------------------+----------------------+-------------=
-+
> >   |  arch  |       inlined        |     kfunc calls      |   result    =
 |
> >   +--------+----------------------+----------------------+-------------=
-+
> >   | x86-64 | 12884 M/s (0.078 ns) | 5812 M/s (0.172 ns)  | ~2.2x faster=
 |
> >   +--------+----------------------+----------------------+-------------=
-+
> >   | arm64  | 546.1 M/s (1.831 ns) | 545.8 M/s (1.832 ns) | neutral     =
 |
> >   +--------+----------------------+----------------------+-------------=
-+
> >
>
>
> The bench results are excellent on x86-64.
>
> However, after looking through patch #1 and patch #2, hmm, they seem
> quite complex.
>
> Alexei suggested that the kfuncs could be inlined by the kernel disasm
> approach [1]. With that approach, it should be possible to inline many
> kfuncs and helpers on both x86-64 and arm64.

Alexei was talking about inlining in the JITs, but here we are
inlining through the verifier which means it works out of the box for
every JIT.

Let's see what others have to say, if there is consensus then I will
try out other approaches.

Thanks,
Puranjay
