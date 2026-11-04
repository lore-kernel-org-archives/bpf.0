Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766558;
	b=SaITTjrYHcurENyLulRbSDhpRW3aUmKGSX3oYDPwg1Ui6gDZzvbPFF38aB8ww/OMcpet
	 v4DioBPLslK/9XXRA9iquZpMFNSAyBx39jmlUCgUx9L61n1XJ4NrLzsT4JlJv2kIROMfN
	 mL/LAHdW/WyLoBP/7UrhdocEFxPgKRJstZtQE038nOcGdO6regRwV9iEZQl9Egr8RaEc2
	 UX7ibLeBN3Ndl6rAM1D+gkk1vH+lpqfdSdeFrXALFl1TOE9qKU6DIFLGbLfrBCpr8uFZ+
	 0eo9SGwsn7j3T1eEbswXg1c7GyZVWmfclWK5ehxCYoB76C9XyBhZxdrPb4Q7mtGuotw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766558;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LDYMmvOBK4q7hJhqT63nAAwc74NWaz+sOAw95hHamsE=;
	b=w7eHW/b3UaKYCP9lzHLHKtTRRbesY9DBqExC/NMJaBDfzogQEBe5B1bmT9YRyGFeQdP0
	 zX3K8eoDE3yBj/vvfMxO3lxNvGYKW7RDou4W6dBN+Y/MhbAPpCGkEIqYVgLloZixVHp/d
	 j9LAcKkiRs5oZu/FigBuPBMmxlbLCJgTgefbAqOy54FKXw1LFKOMHQcPJdd3aorpVaOm7
	 uE1w0NTaDlIPSk88ovvckSlgzYP9tSeHSxGIuKP467sBgkA8yFfJpO8Jz2VSXk80koDSD
	 7AysfMu6L684bBgnW5DiGeDALkOJ50MPhD8SFsRnvwX87lgkC1gQhbjiRJ0DeJarXNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dW6chahP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E1606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dW6chahP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858F81F00A02
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 04:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793766557;
	bh=LDYMmvOBK4q7hJhqT63nAAwc74NWaz+sOAw95hHamsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dW6chahP08DaTLrno2PMUuGgwQ/4coLGO3CdiftLMvEPvr05H6+yxLv3TRl1crL4b
	 vji3Orp/ErBdyNMDf4D7nsmsHZXw7Fze+BT4svVV4PXCOeOlTaPpK9GMIUUsOyO1lQ
	 Y0q91CeJSCb8hI5deySIaPtmuGhpa/uXErJ4XEOskgLu9lt+YCyiD3L1RKqii5VSKL
	 YqJUgyo91RVlDa+TpArSTT7DL1EBObiEnMlB1HFGCXgquMWL8dgeO0LP34KI9jZFLf
	 aY93lUjphdRQ4NMcTFr9BBn2sXrDF+vacdkS3bFV2kj94WBCU2NYag5/8r9YXBT/Hf
	 1KI8u1mRnk/xA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so281066a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 20:29:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxbEpfVb+Cd7lwkPHE/ipkAcpUcJKmhGh+9kyed7drDcV/d2VxMHR6QAMmuc8IhaiD1JSA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hNpPsOu7wLeeaVkmkblUwIaYbiL2QKIXxeNLkmrsewSIN29pz
	EiqtnmN2h9xlUyw/rkXwkJz5uzp54MAgeOI2i+5coipofL0TvlKnM6P+y4XF4vSIkpGc9KYUc77
	CvVQc5iInGskGH+Z0ltU5efTG+eyTDf4=
X-Received: by 2002:a05:6402:90c:b0:6b4:1629:b1aa with SMTP id
 4fb4d7f45d1cf-6b4d3370d2bmr11376191a12.2.1793766556207; Tue, 03 Nov 2026
 20:29:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102072808.23080-1-yangtiezhu@loongson.cn>
 <20261102072808.23080-2-yangtiezhu@loongson.cn> <CAAhV-H52mbZJX2vkgG_h=XfwHoio=asLjFdhTJwUYqDp4V5JMg@mail.gmail.com>
 <8b00e5a7-4e60-19bd-7953-f76dc71e15ec@loongson.cn>
In-Reply-To: <8b00e5a7-4e60-19bd-7953-f76dc71e15ec@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 4 Nov 2026 12:29:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H52bqRD1SyrZsvMkNbCpGiM5DPSGPARiasZ8G3XsE5Tgw@mail.gmail.com>
X-Gm-Features: AclHuK-f4gMcp2qAOufsbV572BaO2w6ixQ0D3tlSSirFRvRGjI9TObJIDPst5n8
Message-ID: <CAAhV-H52bqRD1SyrZsvMkNbCpGiM5DPSGPARiasZ8G3XsE5Tgw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] LoongArch: BPF: Make arena support depend on SCQ extension
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:24=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2026/11/2 =E4=B8=8B=E5=8D=8810:20, Huacai Chen wrote:
> > Hi, Tiezhu,
> >
> > On Mon, Nov 2, 2026 at 3:28=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson=
.cn> wrote:
> >>
> >> When testing bpf selftest "jit_insns/cast_to_user", there are differen=
t
> >> behaviors on different Loongson machines.
>
> ...
>
> >> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit=
.c
> >> index 3ab039d0afb6..01c12da168ee 100644
> >> --- a/arch/loongarch/net/bpf_jit.c
> >> +++ b/arch/loongarch/net/bpf_jit.c
> >> @@ -2489,7 +2489,15 @@ bool bpf_jit_bypass_spec_v4(void)
> >>
> >>   bool bpf_jit_supports_arena(void)
> >>   {
> >> -       return true;
> >> +       /*
> >> +        * The arena range tree uses kmalloc_nolock(), which requires =
128-bit
> >> +        * atomic cmpxchg support, provided by SCQ extension on LoongA=
rch.
> >> +        */
> >> +#ifdef system_has_cmpxchg128
> >> +       return system_has_cmpxchg128();
> >> +#else
> >> +       return false;
> >> +#endif
> > You can "return cpu_has_scq" directly.
>
> This was my initial thought too; it is simpler, but unfortunately
> not enough here.
>
> The 128-bit atomic cmpxchg arch_cmpxchg128() not only depends on
> the hardware SCQ extension, but also requires assembler support,
> which was addressed in commit c8b8f3c50f48 ("LoongArch: Only use
> SC.Q when supported by the assembler").
>
> Therefore, using #ifdef system_has_cmpxchg128 as in the current
> patch is necessary to handle toolchain compatibility properly.
>
> Here is a simple diff to verify this scenario. On a 3A6000 machine
> with hardware SCQ extension, if we hack bpf_jit_supports_arena() to
> return cpu_has_scq directly, but force AS_HAS_SCQ_EXTENSION to 'n'
> to simulate an environment without assembler support, the original
> test error "libbpf: map 'arena': failed to create: -ENOMEM" still
> shows up because the underlying slab allocator lacks the flag
> __CMPXCHG_DOUBLE.
>
> ```
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index b5ed4881d3c0..6f572d24d2c3 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -336,7 +336,7 @@ config AS_HAS_LVZ_EXTENSION
>          def_bool $(as-instr,hvcl 0)
>
>   config AS_HAS_SCQ_EXTENSION
> -       def_bool $(as-instr,sc.q \$t0$(comma)\$t1$(comma)\$t2)
> +       def_bool n
>
>   config CC_HAS_ANNOTATE_TABLEJUMP
>          def_bool $(cc-option,-mannotate-tablejump)
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 8cc78efe722d..1e8049937851 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -2490,15 +2490,7 @@ bool bpf_jit_bypass_spec_v4(void)
>
>   bool bpf_jit_supports_arena(void)
>   {
> -       /*
> -        * The arena range tree uses kmalloc_nolock(), which requires
> 128-bit
> -        * atomic cmpxchg support, provided by SCQ extension on LoongArch=
.
> -        */
> -#ifdef system_has_cmpxchg128
> -       return system_has_cmpxchg128();
> -#else
> -       return false;
> -#endif
> +       return cpu_has_scq;
>   }
>
>   bool bpf_jit_supports_fsession(void)
> ```
>
> So, the current patch has no problem IMO.
OK, then I think we can use:

return __is_defined(system_has_cmpxchg128) && system_has_cmpxchg128();

Huacai

>
> Thanks,
> Tiezhu
>
>
