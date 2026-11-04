Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786104;
	b=21NXCh5mfW34Pa60N2zBs9z1jw6/0POqAyGirkdvXeHvU6EfJwibgz/n8QMyJOAf5Rb8
	 Z4c8Hg3zN0qbsyYxkQh3BkgoNKmylxzRR4W4Tus0lXrgI6I8UeVg4Qnhhgm4MS0ToLhGC
	 2Iz0r0xV6+cGtNjSsAKtea/t+GclVzKrTinDvFMJU/o63TXiS+Frc9mUIaHu0o+xJkxwT
	 HtBHLyzP24HGaoLWEvFhM8LAggnewpetXxb3zSRUzRjnZjGtwkR0yGEX6dBJVjenh2BpO
	 TXbbXDWLXfXFx14Q7FMvppIyD2CoQHEE64iIgtvwdRMh/ykqN+yYsnmGTEIG1FRvznQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786104;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7S4gJgJJUabrpB6VRwq4SCe6ojSm3qa1EXPFVgqVgUc=;
	b=4ANAQGFIIcg7dJhpiua/Sam8dpkjzE4ooHKextkhAOylEHCSZBZLP72KIhdC0xLfURRa
	 gqbUpYb1rDM/9i530BOeJuwK09/zy+Wp9X9qd7qExWLD1+Aqn+fnUdwFqFj0BmqNH3Abd
	 Pn9mzifcJ3pRbftiIX6nGnsXNjWMz2OhOxDSAh7pCT7TwukR316oVvQKWtoZv/AyHmrmI
	 onKEPkBndanCCFc0tQca37ycnpHPJ/3a8orwvIKVXwvSz0kwn7lWy/ntwZvZ9VZYV62QF
	 FqCN9bg0NFjjSY+14/hqeQdPHbFlpf8Kt4V/fitwIJqbS3sapyQpsbDQWO1QK7t5k0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3H3whoU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAD606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3H3whoU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22071F0093A
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 09:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793786103;
	bh=7S4gJgJJUabrpB6VRwq4SCe6ojSm3qa1EXPFVgqVgUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N3H3whoUPIS4XVnOUkJ/nDq0kerw2hmhnX6FZG9zM/0PnnG52q8Y9eUXvk2u6X6Vx
	 tE6lKwbZuaYis0bcmNrMMz618HT6CaSrhhFRMtfhxEb2OUL5J50tUy7VLE9GqCE1ll
	 QXSRMqB1a6reS6WaXFxCw5CGUlr3dJo0MKRaIo6HJ8fgwlOJ0vxP/3y6XrJPylHHI3
	 YOsem5mQqT6tRdEMSYWZ+hvzQ9SSwjNJyyn+rHG7qvizWaSpOSk3WsxfuruMiY6ERG
	 48hsOCW+Th2qfvd2sACPO69ShOsEetXoY99XA1NB44Qdjc0Yh5YQlG5JFEJaKJbsYK
	 OKGtAZV7HMqKg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso439461a12.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 01:55:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByYg34aqb95zh/8h3Pb5ieY9FjaBgyoqXLgN1ce+4RcA20PvoZk4c4WAhlT+F/OTKQkbzw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bBlUCn8Zq55Uq++sY8+ytdlCLctBzkrbYoCTIWmE/+/tRhEfl
	es2KxIaqUaC5JQWdKz+WC3bHT2E8GT5GTOboLdk4Y8y85UFXERhLZaUz0zILflukqfaCi9B2uu9
	iksrbNzSM/D3UTmWw9IdtFw1kL9c+/IU=
X-Received: by 2002:a05:6402:a510:20b0:6b4:201f:17b6 with SMTP id
 4fb4d7f45d1cf-6b4d3374079mr8567339a12.6.1793786102316; Wed, 04 Nov 2026
 01:55:02 -0800 (PST)
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
 <8b00e5a7-4e60-19bd-7953-f76dc71e15ec@loongson.cn> <CAAhV-H52bqRD1SyrZsvMkNbCpGiM5DPSGPARiasZ8G3XsE5Tgw@mail.gmail.com>
 <6446c385-623c-d4cf-5a07-0c2276c6f50c@loongson.cn>
In-Reply-To: <6446c385-623c-d4cf-5a07-0c2276c6f50c@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 4 Nov 2026 17:54:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4m-cokYz19HHAoDeLAjRGp4T=vwDOJaJEcHXZDW15rkQ@mail.gmail.com>
X-Gm-Features: AclHuK-tyGt7dKynXW9DKY0ZRtsdV6cnh8v5lndrM8_P4nSQD_OrvjPPBDK8wfA
Message-ID: <CAAhV-H4m-cokYz19HHAoDeLAjRGp4T=vwDOJaJEcHXZDW15rkQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] LoongArch: BPF: Make arena support depend on SCQ extension
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 2:58=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> On 11/4/26 12:29 PM, Huacai Chen wrote:
> > On Tue, Nov 3, 2026 at 10:24=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
>
> ...
>
> >> So, the current patch has no problem IMO.
> > OK, then I think we can use:
> >
> > return __is_defined(system_has_cmpxchg128) && system_has_cmpxchg128();
>
> If CONFIG_AS_HAS_SCQ_EXTENSION is not enabled, system_has_cmpxchg128()
> is not defined at all. If we change the code to follow your suggestion,
> something like this:
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
> index d7ea515045ec..d124632b0fa9 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -2495,11 +2495,7 @@ bool bpf_jit_supports_arena(void)
>           * atomic cmpxchg; this is provided by not only hardware SCQ
> extension
>           * but also assembler support on LoongArch.
>           */
> -#ifdef system_has_cmpxchg128
> -       return system_has_cmpxchg128();
> -#else
> -       return false;
> -#endif
> +       return __is_defined(system_has_cmpxchg128) &&
> system_has_cmpxchg128();
>   }
>
>   bool bpf_jit_supports_fsession(void)
> ```
>
> We will encounter a fatal build error:
>
>    CC      arch/loongarch/net/bpf_jit.o
> arch/loongarch/net/bpf_jit.c: In function =E2=80=98bpf_jit_supports_arena=
=E2=80=99:
> arch/loongarch/net/bpf_jit.c:2498:55: error: implicit declaration of
> function =E2=80=98system_has_cmpxchg128=E2=80=99 [-Wimplicit-function-dec=
laration]
>   2498 |         return __is_defined(system_has_cmpxchg128) &&
> system_has_cmpxchg128();
>        |
> ^~~~~~~~~~~~~~~~~~~~~
> make[5]: *** [scripts/Makefile.build:290: arch/loongarch/net/bpf_jit.o]
> Error 1
>
> Even if we change it to use IS_ENABLED(CONFIG_AS_HAS_SCQ_EXTENSION),
> something like this:
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
> index d7ea515045ec..1b87b1e4262e 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -2495,11 +2495,7 @@ bool bpf_jit_supports_arena(void)
>           * atomic cmpxchg; this is provided by not only hardware SCQ
> extension
>           * but also assembler support on LoongArch.
>           */
> -#ifdef system_has_cmpxchg128
> -       return system_has_cmpxchg128();
> -#else
> -       return false;
> -#endif
> +       return IS_ENABLED(CONFIG_AS_HAS_SCQ_EXTENSION) &&
> system_has_cmpxchg128();
>   }
>
>   bool bpf_jit_supports_fsession(void)
> ```
>
> It still fails with the same error due to the macro visibility:
>
>    CC      arch/loongarch/net/bpf_jit.o
> arch/loongarch/net/bpf_jit.c: In function =E2=80=98bpf_jit_supports_arena=
=E2=80=99:
> arch/loongarch/net/bpf_jit.c:2498:59: error: implicit declaration of
> function =E2=80=98system_has_cmpxchg128=E2=80=99 [-Wimplicit-function-dec=
laration]
>   2498 |         return IS_ENABLED(CONFIG_AS_HAS_SCQ_EXTENSION) &&
> system_has_cmpxchg128();
>        |
> ^~~~~~~~~~~~~~~~~~~~~
> make[5]: *** [scripts/Makefile.build:290: arch/loongarch/net/bpf_jit.o]
> Error 1
>
> Therefore, using the explicit #ifdef block in the original patch is the
> only way to ensure toolchain compatibility and compile-time robustness
> here IMO.
This is OK:

return cpu_has_scq && __is_defined(system_has_cmpxchg128);

It means two things:
1. CPU supports SC.Q;
2. Kernel defines system_has_cmpxchg128.

Very clear.

Huacai

>
> Anyway, I will modify the patch subject, update the commit message
> and code comment to make it more clear.
>
> Thanks,
> Tiezhu
>
