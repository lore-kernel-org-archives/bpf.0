Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A742874FA
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451537; cv=pass; b=t1vSIy9EmRfSAhCq9drzpqwj16Yr4SiRd5r1Gf0WCUv85MDNfhe9aA6XHEeytACocwX/CHdCSM9lQiUmRPurzvILi8ZumC2OsOS3ioTp9TVHOWeFwKSz71gPQhMMQo8fz2CXA3SKgEfnhPZ9Wdpy62oRs2476hQE3ve2NuHtZhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451537; c=relaxed/simple;
	bh=6J3rK+PQLNsf0zS4HmXMEH16rAMvx2AYmtoTuHQA/cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtwzpZ7hPQUbZh69qu/o1GkzGuWhdHlXw/ua7LU2LkU6K6LqXn2xd2cFmUNZcFAfTFMicOXqkXk4dqWNJRQIGt5zz96yi7aUzapGDFWRe9wDsYNPyLa1I/+e5JaJZ2KCGVg3s2quBjunp+TQWRsEjKkUFQ1xP3N5LZ0iYkHugXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP7zlfpQ; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP7zlfpQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b7481f9d3so2259355f8f.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 08:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774451534; cv=none;
        d=google.com; s=arc-20240605;
        b=hNMW9rsc9WHhg1Z8sK3q5qTAziX3NZwHXwQxoB1haIeQjbD/nvSiw82Flod1vVUmcR
         7EBR4M+YzvRMrxCLSjl0IYRjina1E1QmhleeMSI8K10yhhzpEcyoQVcVJur3bq2Ms07D
         Ij7cQhhgA04aK70PnTqHs0ihlbnvj8L1QdWEHJhBASSZSFQCyJavyaIqLzvg5PArgnuI
         etKNma5RqHQF4qk8koQ84wd5MXLvJcOLkBjUF76jXnltAn/GIM6stfFcl1tlMF+ESI64
         7bMnbW38ThIpZZmrwkBSCkaNVqgHhmMW19rvs7FpFOlMgNEhp0/5Bx2DV5gqPMhFKnaF
         tLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8Ha9bsXW8GmW/gx0ZbCJlm8QKxYvQfpM0vtpt73qP8=;
        fh=ticlYEepWSm0GdaeEZLOXauO1uWIPHoGMkLap+LAGz0=;
        b=dvetW1wCTspwl+7JLW1+6D0prpdKGQOgqw01lJeAzfc7ieIIvEb8XGOMQ7komlL1z4
         JAff/z8RWtjgml3tudtTTXmiR0cExnkpH+kb30t4FcaW5jJfiOl0qz+uYdXScpHF+Q2i
         nQde9SfzOt0rcFYtGS0h6D7i3GZ4Ts21I89/sVY3oRlKjLI0FEg0oP5ikWZ8fh4Jkih2
         ii0o/ePlCzRTiNwt69J9EuL0IIFmBsrz8BMt+8l7gs67jzcPf6TF5/OwJXabCb/URXcD
         tJNIkpIDbre3JzHGhEDibFf/5yBGsg38L5H4cvKjObGEzVcSk+JQec0vTX6nVyw4T6F/
         WGzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774451534; x=1775056334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8Ha9bsXW8GmW/gx0ZbCJlm8QKxYvQfpM0vtpt73qP8=;
        b=OP7zlfpQ0sV9H0hNfsaoRzFT8ZP6JW0TZmRd7djJurD3kkDEGCtIjExy0M8NENJUYX
         u28gBPCeMbchIhBrfgjG743LZxGSvoTNJzsdXn6lr9cTdqmwcW+Vicfney+WqicOqRA0
         mwRpGBShbTsnoxwrCxgP3/73Fj7yA2JHvXWoeaTAul8YtRQHbbqCWkZjQNdmSRr8oZNs
         uTOufGjZgQqUyfSxUKEbaL/RPO8x/aqfzwLepYLXFxgYKfZvWKoMVai9Px+Mdym27+/f
         gj+SmYhu30yF6FQBVahc1kD4gvfZ92RCa2Y6K+xe8ikPG2F/kCFIkMf7e+OHbSwTA7pR
         T1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451534; x=1775056334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8Ha9bsXW8GmW/gx0ZbCJlm8QKxYvQfpM0vtpt73qP8=;
        b=MWUIq8JxbofAADiLODaeyQ2P/v7oF+dgpxvAAvspM6mKsl4hwUpUT1zppLvlAD5Rzj
         sSDbNSUZhpiN9YRS4wieRbJiulWSRiG9W7FB7vSyAYrZ3Hj8cJoqRo+47kh6CWdorOaF
         JjU81zTrWGg3kJUvkKmJLrXhqKnoId5pXs2raB6Fw90jSlukH0IrnZmYB5Q06I0nLxDk
         EG8tyQ+i1NYKI517gRhc1R/4nhj9VTfvGJ48Y09Np2av++DpRLMQyl1FitjWRRCbP6Ho
         XgArvX6zaCgz+ttV300X1zm8nGFSnkDx2s9hfd0AwaPGTrypokXVD6Bns2N4lWO4xeab
         7y6w==
X-Forwarded-Encrypted: i=1; AJvYcCUv91CM/smloClMlYtjSOizfHU6XAN95jcw+r0CQU0cLYqoGjK0/06ZqPfFXmBmCdMMaK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPPvZXAvpkO5DCcRWyOlXCD6BRmGbBFsQfBV6ls2sdLx4pfi2
	LUYB6PNkTEMKJLrNHM8TSZ9MexF7FW+9HgUZ/JblLqMgbwuektuOSLRm/vhTQO5PZRmaGl9Lo96
	/ICLlPeLy+pA1eQsMVih5ql7kIGeRiCs=
X-Gm-Gg: ATEYQzxI0k2nKQhhDYRhRhMmrOOLp4X/7IaPUXAy5aR+zcRC7eiWoQfVLQluJJU3ezB
	0KsZKvitsINKfhy/HadCfXaC74vQqPF7hw219mzf6vChlh5oPG5+cis84Mc6P+U7ocuVjJuWlK6
	8vhQKWqQPn3bT724MFonR1CKL47ZTF4TcRwJG7E1eE0HtoNoMmfIpUSwq0yRFIQPuyE70SSO/1s
	Di+j7QFhKOj3M7zlDCR6+saj9o6LfodNTV8jJGRklBifBsycP1hHydMauuXvVQa/nZeiKoKbvDh
	tCgcyiN7YQ/A0gPdI7x+YfaFn1TLuO943Oc7SVlSDhoN5xDX46tGV5BADoANr2IYHE3Mz5o6sCV
	hgO5Bq4ZQIxScutBp3OYIpA/s2w==
X-Received: by 2002:a05:6000:2502:b0:43b:50d6:4f04 with SMTP id
 ffacd0b85a97d-43b88a3db0dmr5558105f8f.38.1774451533418; Wed, 25 Mar 2026
 08:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324122052.342751-2-xukuohai@huaweicloud.com>
 <edfa617891aa2e2980ecfb8037a7a4ed069e518bbce1777e331c737024feb1da@mail.kernel.org>
 <5b24cd1d-a8cf-4c9c-a0c8-c79c10ea80e4@huaweicloud.com>
In-Reply-To: <5b24cd1d-a8cf-4c9c-a0c8-c79c10ea80e4@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Mar 2026 08:12:02 -0700
X-Gm-Features: AQROBzCPaabh8daelQqDj3MUVAnt_BoyyKMWkVTLF5Mk4FpOAwGezRlTKeSEVGw
Message-ID: <CAADnVQJ01c5wkfcc7rOi+2X6KuLJCJ6A7H3aHAz4Spxcf_hV5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 1/5] bpf: Move constants blinding out of
 arch-specific JITs
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, 
	=?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
	Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, 
	"Naveen N. Rao" <naveen@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 12:47=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.co=
m> wrote:
>
> On 3/24/2026 8:46 PM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> >> index 67eb12b637a5..8f52f4b6c3af 100644
> >> --- a/kernel/bpf/core.c
> >> +++ b/kernel/bpf/core.c
> >
> > [ ... ]
> >
> >> @@ -1507,13 +1507,16 @@ static void adjust_insn_arrays(struct bpf_prog=
 *prog, u32 off, u32 len)
> >>   #endif
> >>   }
> >>
> >> -struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
> >> +struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env=
, struct bpf_prog *prog)
> >>   {
> >
> > [ ... ]
> >
> >> -            tmp =3D bpf_patch_insn_single(clone, i, insn_buff, rewrit=
ten);
> >> -            if (IS_ERR(tmp)) {
> >> +            if (env)
> >> +                    tmp =3D bpf_patch_insn_data(env, subprog_start + =
i, insn_buff, rewritten);
> >> +            else
> >> +                    tmp =3D bpf_patch_insn_single(clone, i, insn_buff=
, rewritten);
> >
> > When env is non-NULL, bpf_patch_insn_data() adjusts env->insn_aux_data
> > via adjust_insn_aux_data() and env->subprog_info via
> > adjust_subprog_starts(). This shifts subprogram start positions to
> > account for the expanded instructions.
> >
>
> Right, but only the subsequent subprogs are shifted, the current subprog
> is not. Since we are patching the main prog when env is non-NULL, and
> subprog_start is always 0 for a main prog, subprog_start is not needed
> here and can be removed.

sashiko found other bugs too:
https://sashiko.dev/#/patchset/20260324122052.342751-1-xukuohai%40huaweiclo=
ud.com

Pls fix them all.
