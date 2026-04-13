Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529728505E
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097463; cv=pass; b=ghEB5c4PFCPEDk+F9VFGYThWVJy2OWQAb0qDdkC5MVI3cgwqltJ0/qH6PfOxJXhKeeL+AnG96EDuXhDY3SzkG9l7IwshEek8LMTonCBcyFTuBKx9FFM2Z6ey6dT4mNCohusRFsfba06ADGTDd0S3ku21lz0W1ldyth7Wgqh+hL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097463; c=relaxed/simple;
	bh=2PN5Vv1ilajgBEzhHfBSuQGH4DAyq8VFBRLf2mjofns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHRHoHoO3BcTxBDvBhl2UgD0tyj6hHMpdz4ho0Tt+cTjoYwDS3qMpyiVw3jNQDgsqsuaFckx2VCJZzdZ3t/21LFPJwQTMCN28ZrfrBCojOlofxTlw8Pls1FuYlb3VpXEQpv4AAZUdY6qcGQnUT31ZBecj0BCx7X6V65/LDNfJRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVxxnmTc; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVxxnmTc"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d7605ec91so1235482f8f.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 09:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776097461; cv=none;
        d=google.com; s=arc-20240605;
        b=SHPCHXRjG2L2fEdLtpRtsffrAZAdkmIBCHDGNCNWINN9yltxyafrZ/XVTsKh+zoOV6
         SGjrhlOcIDKMB2cl6sYhcEM8EE5RotcOo21XT+A9d4puCWk+a+yWSG6TuxMR/erUKuKO
         CpNuPowkmu4IcJiZFNhZuhEfcFEd9HLbmf/sEZ5WuUALLUKbUhV8EPomXSZNENdeOXY6
         mfAp0QugoRcxbyr6Yh0B3cWEUnBkV9uD/lQPKoTXAxpShk8x68nFTO0nMtNr4od1zmmn
         gXzuG+oiuSBUM2t6LNs6M8EnWgBNDGcRdnJLBlkeVjjzqQp1+f8dmiWFU8iH/zGiy+/m
         CDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r15c7hlYV2dqCExL10ZfLkMhQXvvr2vYzt289+mZWyU=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=UwjsVnYvkaVCRA0woFV7QJ0UivyCWgEMBJkzMoO04qHc/zv6dsVyJFMxdhLke1rka1
         oe7w6wNRRNne3r3tIV+JvqCMe+KXaPrHeMdkQlSnhR3gria+rHEjNPGheIO38wMvRMMz
         4ZvmeMMrd8VZqLRYj68DflUpl02ABKU3uzdLwvHMeuWAmj4kRhAzNuQkFIYYP8cwuE3W
         m2Jh3FQ0FEL5wLAd1fJsy4X/X8CwjKhfwLLTf/cEd+M73we0/lV7OJpJAx3h3DkGG+o0
         X+woNZ7pzKRAzCp+ys41ZMwiJLoYUEyn6uQNoRi4PO2eWlwT9MWYOOkXCt0p8zF0zP3i
         OoSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776097461; x=1776702261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r15c7hlYV2dqCExL10ZfLkMhQXvvr2vYzt289+mZWyU=;
        b=OVxxnmTcssk5FywPsbLvhxddKzhuK8ElRz4x5sJ+wVyQ/Qne1dXfl2qEZ/afkwkEFd
         sH4fMLPERFaytircHA8Rzu/jX2/mQRY8Iv7rgiInKg2KrN0H19P9Q0hW7k+/Ve8378Lu
         Czad1MSVzuvzSIX9A1s+i9TpcRf/SwoWGtlQgUAghK2Pr6cx5FVbuFwvmvr9v1Pn2+ef
         +rX+c1Hb7F0Xat2gHDRr2HmDRusJY49eU701+xzb2llrlXHt1ykTHbYgjbaq3cYvnwrP
         WEq9pZWDjwhiNKzj6a6aR+GHLSdtH/PNdG++nNfaZLcvJ3tM19coalWLVjM8yFQnnrn9
         DNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776097461; x=1776702261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r15c7hlYV2dqCExL10ZfLkMhQXvvr2vYzt289+mZWyU=;
        b=ZU6q82HCvgFUzJp5Bec8p80Uh5ByUe188NPnudqC8yWeyt+lEtqF9iDMGO0Z7nRrtS
         PgyYiU7lhInYWzWCsF2vwYgZe+ZFcTOITUURyCvWjFvoNRg/haOiNtcTqgw6Y0wQSpIO
         DuMXXozz2Lc6rTvxIuArNzlcWiXhOIKkp9I5S9n/u2Uwan751EF6carhqOJkICRn5ziY
         xROzVr0VfHvLSYUgORV6l3Bcm5qwpNtWkcMFV3v9pwJJ3dkeVOQGRuVaX+Ogpz8HWBCN
         nSK6bwConiD+BC3gItBIwrw6mxbrrgesobJsmDnEsot15RHZjeQPG9Mw8OHXZqbJlSHH
         Bqqg==
X-Gm-Message-State: AOJu0Yy5M5GODxzlj3cxth6c0UD/BFd6tNv+l54gnwmAJAuKH9/MVds8
	9xvlzCDtmHiAZA7G4junqE1mL1382y50/YPgQCFXH7UWMs/zjZIx92X844Y8E4wucXyHMStMJH/
	olZN1NTjWsQqo2euCWX7AqE5GJ2Rndec=
X-Gm-Gg: AeBDietj7nMlnUNZiKc+KGw2/M8Yte+60e0GCLLRULsNq/8IzXITBf7srQ0p7HGql5k
	9unPSaoPtoJ7Ch93+w7IGz7/fAO5WBs+Wx6AMA8xRV6Wpqt28/860se8DNSYzGYoOWHwpL83oxM
	p0eJL52sGnPg2c1RHkBHPdMyDvzZH5gkeHr+9x1H+A/xCV2qbEjR4XkeCTd6SDb8z4Hefw/fv6Y
	8uLQHuYfyTcZMuLLd0ASWgjDYqxN77YAFkL09647HDOEVpw3qXaS6AvDLdsxSDrYeuNDLJhtSea
	OWHr1hxnv+pYeQMVDZ0gVf0jyrRsp7Nh/DrQKDTZQ6rHd39Wnj/raiGgCM4OMf7sx8/5IYy/bNG
	QQ0DCqm/49t2+omQA2vpBFHWhoWR2wGNSWwCu
X-Received: by 2002:a05:6000:1ac5:b0:43d:4df5:3de with SMTP id
 ffacd0b85a97d-43d642c5029mr21013675f8f.31.1776097460532; Mon, 13 Apr 2026
 09:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
 <CAADnVQJ-rW+MkrrtaAoVvExNYX9rEc+=zSw+phzCgv9QtaAX8w@mail.gmail.com> <a103c612-2639-4578-8d8b-48ac72e96c63@gmail.com>
In-Reply-To: <a103c612-2639-4578-8d8b-48ac72e96c63@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Apr 2026 09:24:09 -0700
X-Gm-Features: AQROBzCthRXTheQbrnXhkq_QDVkkLF5BBYqUE_7FXsSocPx5DlMwmiTMP4eoccI
Message-ID: <CAADnVQKK8KvPAtO5f5ndmBXOWxYbGMrnUiCap9tuf6HNCG1akQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 03/18] bpf: Implement lookup, delete,
 update for resizable hashtab
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 3:52=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/13/26 12:10 AM, Alexei Starovoitov wrote:
> > On Wed, Apr 8, 2026 at 8:10=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >>
> >> +static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
> >> +{
> >> +       struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab=
, map);
> >> +       /* Using constant zeroed params to force rhashtable use inline=
d hashfunc */
> >> +       static const struct rhashtable_params params =3D { 0 };
> >> +
> >> +       return rhashtable_lookup_likely(&rhtab->ht, key, params);
> >
> > How does the asm look like?
>
> You can see how asm looks like below. An interesting thing is that gcc
> inlines jhash2, but not clang, which costs a lot of performance.
>
> gcc:
> lookup 20.675M =C2=B1 0.090M events/sec (approximated from 32 samples of =
~48ms)
>
> clang:
> cpu00: lookup 15.882M =C2=B1 0.530M events/sec (approximated from 32 samp=
les
> of ~62ms)
>
> I think inlining is also consistent for htab and rhtab (either both
> inline or both do not inline).

Try other hashes. I recall somebody from isovalent experimented
replacing jhash with xxhash and/or siphash in hash map and had nice
improvements for certain key sizes.
