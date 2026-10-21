Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792546529;
	b=wQx3gLfhs+zoGHa3SwdzzlvJraKFSw/6liRAhNOsNBf9oCsLlKBZSe02rX08qzSYMFeZ
	 YCQ4WpV1OLbcr9P6ZHPY3VsbLEax/MoMmNmv+cVJcqBAYUyvsR1Td6eBSd+CxRngE4cjz
	 2ydZCrWodno/EiYddC9PJ49DjmqEr9vQleMr89nLO9Ct1x7VIqGJgm6gjqxdL4uPFZDnU
	 EpiO6atWqllWoAuCMjoFDItj3sAOWOZWXIXlZ798DzrBAhdJ/bpu0tA+bpFLyWRmMpe1j
	 uJXRHRY9emDDLokJAE0PPHI/anvzWlXTFrBKZoWUmEZX+mfuKnEPrKYhMyYHLcOac7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=r0MzlUmu99dGDwcqfm/ibNBk4GSBGmgiZ2BtrWViLOA=;
	b=ELie5jtOUcHl8Deuyvk2qfp5KnYSkqLGOvCNgCcfZsRYJL2P7jqKXT86dPKbhxgOeqMU
	 jToy4WFNodBBI7DDYXm8HfXYtXWaw2zTnHY1XbeQy67djTShh1KAgL7Fx0epR44XZKF4X
	 hnwg5uKKuYFyhjI6da+J8glm07FMBpRpOpvzLRmCH1O8tHTy+wNFGZRIQNwxK/cZ4G0AS
	 Ga0ogbpbhyfv4yNP5Wh8oBaGXolhDE5Ap5j/N3IagKuXiZKwpyMNGytcHwYC1evPACYMr
	 3vR5ZKfMLnBDU7xg5dxIDFSOq12Dm3uDu1qYgG68KjKfioGFxP9Vpg9m3EQAGh6LJVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LVBzTMML;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.134
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F5606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 01:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B6F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LVBzTMML
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-4a1f866310eso1088175e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792546528; cv=none;
        d=google.com; s=arc-20260327;
        b=HS0QQ0HM50F1KEiMUVNHCEQgH59DwB7+cDWYuN2ghEJwQddbXcYLcA5iIpfceRId7Y
         QRmMhZXRcNsDRm8l2XFZm8fksBTVbkRjheO6LCD5FehGx1e4zXotwajvv+tx6jGATYRw
         FfdzAeZhIbfhjDH0xr4cyZ3eE5OK4/WVBl4inGhVUsZxC4uQFuLYmXz+fZ3j9H/WZ7oh
         OvNRYEkEF53ij+byxIZskR2DlC1nZTa3Z4WFAznF4h65wPx1iynNWGImoRZI9mE/qC+8
         d3+PbmQwkOzSYkrX7xODKeHsDuPRkL0qtk/Taons5tFbxDDXIashYoRCk/eOI36d0iS6
         7DKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=r0MzlUmu99dGDwcqfm/ibNBk4GSBGmgiZ2BtrWViLOA=;
        fh=dr1zD71rY7lUeCdoiuZm0cYh0MuO4GuaAdV4qVZnVz4=;
        b=UcLt2O7bgb27/9qdP1D4jXALycI9yydMrTYcdsQ3hlg3PaBENAUbcbSgy4butAI4BN
         AjgVH6Tt/7qvSZmk/h/0i0MlCIxQ2ZHdPDGe+vX9LTc/eYSb2q0ZJ5aFT516g6vwOLcL
         zmWWeX/wG3idcJ6WD9vtBkZaXaVjewbvvuY7YDRUB5ZXPMuB3hewPZTX+mQYHBEUC1Ey
         ienbFgYRLqhplgTsxdJJm9Ny0pelTcR+n2GfhB8AXWvp+KT+dgSXiPdQYrLDcmqJ9aXI
         Eai5Xmr87lYzx1fGlTFkdXUC/x/Ffx5fYiPdWzLl01oGogqI4SxeRoLXgWTxJ3sYmyUP
         ZwNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792546528; x=1793151328; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0MzlUmu99dGDwcqfm/ibNBk4GSBGmgiZ2BtrWViLOA=;
        b=LVBzTMML1B1Ijp5vWH4f/lFzz9m2UifSoJ0O9RKazgqlBGekOZUWWVNvz9wzbApwwl
         wjdtZ0OQen6Jqi6WY/pkkeT9jcx7ZrKxntu3BVyTVZr2J21zPyOsHoU36rKEt6187DfR
         4jqJJHCXqvGEqnrS3O34KR0HS4+F9BBnNZnrq8pu2/95pMw1oN+GXurQmf1kMiJIY2lq
         jbJMmfpeHJ08Xg7ABEXPG6/39vH3PBQiQZ48yF9znNWxd4C8av//MYisIo81pUIqs+rZ
         VTf3Y2TZLAiU19oUn8qnPEWGfKp5qhZ5UeLweRwONI/kEYKJ1ZPmpefrMlVpFYoztqRe
         g4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792546528; x=1793151328;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r0MzlUmu99dGDwcqfm/ibNBk4GSBGmgiZ2BtrWViLOA=;
        b=RHbGYQ5v4WvInpgJmvFDwSQF+gSHQS6zQFbCh4fcbniM2wAU5fkU5qnXdItTIP5Es5
         MVHziAwAkC7ZHJvfSGtfJ4VsiUJN1oB9oV2F0cv+2KUtq9JhslYGQjJT+fIJ3lhVIgOz
         AlDuA+WPMxBhBbpncWVNBcYWSZkB5MrahTDuQxIzqnqJoVBLgPA8/w7dJi1JmwTtMPPg
         glbSrkIrVvMOl4c2pF6PH3rSantc/dXZKL+YPhcbFD25MQz/P2loeZYFSBa60tUYIArO
         GmhbKbUrU9+Zq1pt8gXwzDjpVBYPa/NzmLva9Hik4kQfitJgmS/8IA+k0uztFT+Mg5Px
         we7g==
X-Forwarded-Encrypted: i=1; AKwUvBxMZR7iFgvXvoBeWjtr7urLRR5ryHZaoiuPlwHOF5B/pEQ4Nre3iiJP70xDKapGbzqvQfg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPmAIu+QlNPzAtbKmtc9/5sAOLltBzZnJzLLPwZr+Wg4xofMJn
	9EYrlsQr064R3rpHIXyKK1yhzz7c7jQ+NFtLvs35+0Mwh74TJuNrPrW9/EdTKAzYwRZbvxB37hr
	0/oxpqfG/9x+NATJM17tA7S0JoXP1l0E=
X-Gm-Gg: AYBFou2j/OHxNfXveZgv9ldLGBZXOIDtiQjtf6FAIKJgSuLNQxR5hGh0CjMYhmSWbXa
	wMuyLIBNJHA87eDAjiAKEpobzzem3UwB7ibcw+qca1Jc6E2Gs1BMLi9mP8hRH6pKdXNey4WJM/T
	bQCSDiYpvHwX9pRea+EInfPOw2EY3dizlcmUvXx6ba7TvJk+Ggyefj2ELIf5oahAvW3rfz+ImBD
	v43XHZn8jlcMQTbsP7Vu5vXK7Ap4vZoMy6tAF8K0DstHj/xJja3ObH8BwAeV3Blifv1TiM3MZPj
	nIvFJnku/GabuOuDIRCKvvn6WzAPayWIh0wwYMQmerIb3n7gm4sIYPoO2cqUxDBFv8BIebaxl3K
	wiQ+EUOxuzVAIqinUIP+06uM8N7f3CUHS9gFY3wu931E7i6faoyrdxq5m4VgidUUp33or+fL4oi
	A9+jow2d2kEv+UTZ0EHN2NAyLACvsFLK9Z12XMFltlKYuOyuZOAntiHnRh2iLXEyGwjmw4SBAiB
	qroUVRHmQnF4e8=
X-Received: by 2002:a05:600c:3512:b0:4a1:e92b:ae4a with SMTP id
 5b1f17b1804b1-4a1fdb128f8mr8156415e9.21.1792546527695; Tue, 20 Oct 2026
 18:35:27 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020101229.111074-1-skokovmaksimevg@gmail.com> <DMA3L9A79PD7.DRTZ2IXQUVA7@gmail.com>
In-Reply-To: <DMA3L9A79PD7.DRTZ2IXQUVA7@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 21 Oct 2026 03:34:51 +0200
X-Gm-Features: AclHuK8E8rN-sk-UDxxRYJv__0oe0dhmBKjJkPMHD7sfP3GXdFAnEQbF_hd0HxQ
Message-ID: <CAP01T75hnCAjzDYDO86RmmnMjYVYOYptnSo4DxaH7UmTQc1KDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Cast helper IDs to the helper type in bpf_helper_defs.h
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Maxim Skokov <skokovmaksimevg@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 02:47, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 20, 2026 at 03:12 AM Maxim Skokov <skokovmaksimevg@gmail.com> wrote:
> > Converting void * to a function pointer is a GNU extension in C (gcc
> > -pedantic: "ISO C forbids initialization between function pointer and
> > 'void *'") and an error in C++, so BPF programs written in C++ can't
> > include bpf_helpers.h.
>
> What C++ programs you have in mind?
> Since today there is one as a selftest.
> C++ is far from being supported.

Yep, a ton of changes are needed to properly support it.

>
> ... and including the header doesn't get them far. bpf_for() and bpf_repeat()
> in bpf_helpers.h initialize 'struct bpf_iter_num *___p' with (void *)0,
> which is an error in C++. The bpf_iter_num_*() externs there have no
> extern "C", so the kfunc names get mangled. vmlinux.h doesn't compile
> as C++ at all: struct page has a field named private and struct device
> has one named class.

One part is adapting the headers: I've been carrying some of these:
https://github.com/kkdwvd/linux/commits/cpp-bpf-mini
(I replaced my similar bpf_helper_defs.h adjustment with Maxim's).

The other is the vmlinux.h adjustments, there are also various
btf_dump adjustments and other random misc. changes. For vmlinux.h my
approach was to append ___cpp to the keywords and relocate from libbpf
on access to actual field.

https://github.com/kkdwvd/linux/commit/3bb5bb794fa1477ed8ec05f0ffb9b3f9dd9ae3ed

Apart from that, to enable the basics, several adjustments are needed
in the compiler, at the very least recognizing C++ references as
pointers in the ABI in BTF, recognizing preserve_access_index and
fastcall attributes, etc.

>
> > Tested: the generated header compiles with clang for the bpf target as
> > C, gnu++20 and c++17, and with gcc as C; with gcc -pedantic the 211
> > function pointer warnings are gone. All 1082 selftests BPF programs
> > build to byte-identical objects with the old and the new header.
>
> Those are all C programs.
>
> It feels to me that you're scratching the surface.
> We have to see full roadmap to decide whether we should even bother
> making these steps.

Agreed, it's a fair amount of work, and needs discussion on how to
order the changes and whether it makes sense to do it in the first
place given the amount of things that'd need to change.

>
> pw-bot: cr
>
