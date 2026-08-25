Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5A1C84AB
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787689064; cv=pass; b=Umd6kAztI6UBkxkJk6vytBzd3tvlV1a04aTxwWWZ6ZaNRWjEsJW/VLec32sj1zmd6BonwL4IUBoxmIPIa0LwMshUcRY4oPjg3atAqBDluxR0LAWwcc2d4DtHMykzjKRZFeSQal3vhVOElm3IQsqjjiJQwmACpmcouUOrzeCtQ5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787689064; c=relaxed/simple;
	bh=gsK9EquHUCTCUctLlW+W6DQK6qMNpIH9wwEQLrIuhKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cy2R/YXJRiEI6FeEV4zaIbZJDP4WDBp3ouLL2PVjlOAv3ovYTC0vvUyz8iyPDpL5shrMxi+VKtbdjJqDwXJvZZ1LOCedWRoluJFKKxPLr7XiDMno4g2Fmyzbu55yiRqmkfb+4QfNz+Fk1xGGM5RQD6wzV3ZHkQYboMaa2t7Vlfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFS9TQ3J; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFS9TQ3J"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-85377c8bc96so221419b3a.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 13:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787689062; cv=none;
        d=google.com; s=arc-20260327;
        b=TTj0mzR2X9sfCi1yOj7sX7Ijjt9QIU92XjvwILqEE68368rSrRXO2b9pXBMOsp3CfF
         C9ivclhKcJVAW6GABBSEIY0+Q5C9xOpeZS/U05kqnyB5IVQ+GcfVkc7MtbwkN1T2BfdM
         3XjGQwOSPCYkP0tDykQppvzD3gAN3XscFd4IlSx9dq7M2sZUp+ZzpLI1afpNLgjO3NrS
         +LvYc8wWFs3N7ZgzSU7UxvhYHIuCpSTpOlbJYkNBZqcACOCHHPP7pVCE+yhhzb469KWI
         16LCfCRMs8VQVAzLbOwLk4SjXFJrwEPULksnlu7DXGUjr25HG8gwla05hOMD2iQfxtbS
         1s7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dLj5tFbsVzyfDXo+huHpotVXFR8uK9xfqZioaQh04Iw=;
        fh=aOx9SLYhgPng7QfgSUpuJjHcM34M584z4lEY0zfLgfo=;
        b=HUuWmFdtf/fvCRkSW9ZkJEanwTAtBpWpbNj6Y47pxMJ481vugz7lVthO5NFwcChM54
         yb/kvxLXrgqMB2mdGQ+VxSh1uNaRSlHHAmDWkqzc4gkSEmyiagN7vjwg/Mo007K3F94w
         LG+3xQnafNOgR/OEO7U8tvVMpb2469Zo+uXl8zvDUjBacu5Sy58KuAJWSHokO1WiaIPf
         Yu/hfL8NrswHY54cySOJiyPsb3JIKCON0C+8nmFRjHxlUj+m6zzUmCwgVdtzvOlHnxsd
         Ju5X+j3KhLzvZkGZud3gpjzAm1SD4xoRU30eQwZg5RDKj2LPAVvcelJaI14o6LNPEc/W
         on8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787689062; x=1788293862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dLj5tFbsVzyfDXo+huHpotVXFR8uK9xfqZioaQh04Iw=;
        b=YFS9TQ3JsB0SX8lZe6o02PUI9dOSXR1531Tw4yxI9bHKnl00MsfJSwKGjfJlcA9Z1y
         Jn7Gi6nOO7B+hjEvb49DwHMi1YCS/P2aiYIceQsh+8o3jcY7J4avi/nFq30mXO6wjkJR
         140kNJuDkM2PZr//syS7BwYagpFpYQN+7yqt9fmqfN1pWYRXyCstknNOYlV/nBIN3qXQ
         PmCcEIqBM/owQitzArovaLnduOxI8QQnesGYSlft0NonxnM+foD3j59qatEnmHQfGaX/
         +4Rkm1gyJOMThqD1NtXVTJ9EqsEsZs30rqiLdOIamfGXTPaof3zwMY/LEb4A08RzzFdU
         dFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787689062; x=1788293862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dLj5tFbsVzyfDXo+huHpotVXFR8uK9xfqZioaQh04Iw=;
        b=sFHdNaOZ34v8WR3t4chH2yMxbXl/AUJN1gwxndUZNQMVp31oPJoQ0eZ5dM8Bj0/xaX
         hhq57SsRPaCOa5GGNkoi5Vlq6NqNZ1mMh9oTVpHwDlalg00PlWQtjF6jmtBzYsbYceB2
         nYf1kRI5nedMdkEoDviwFlScaZTd2qL4UJWr1rGayQNq5NgM01VJqkgw4ahcrmqM/Tii
         WlGXY3olZGTNK3FQ3ylJYkBdxGy0I/fhi631LwtJ7SfDFZUgphYomdWzcNNI/35H8fjR
         qCcZ3WVLJ+WHhtUE40rh8odLD798Z9quqXoPnm0wjqVbuyxnDeFBAjRbWyuXRWI87+Px
         ejGA==
X-Forwarded-Encrypted: i=1; AHgh+Rpsncu6KyMhh5SQktkQ1DAHHaxkMSEhmSLoGN1zmfPrk3TDKKok9XVyg9mdnmKcWkhloFI=@vger.kernel.org
X-Gm-Message-State: AFuF++k443nrbPJvrIvTLrToVZHPRhBhs8D5WxP2wr682MQ11eQsq5qi
	cWH30/oxWi3E+LztWsdOP/Q0tXpNtX+sZLSHGAIAZ9gvTZ2QnOOZYs2DUvOd9Q75mtfnVbkN8YV
	jTUfyvrIfxh5r6ngHWnxh2uycbl6GOxVkwYVE
X-Gm-Gg: AR+sD11MdMlZUL86YP9KlRujOLtLkv8FU4y2j20hOoqRWP4tXfzF+gje/5GEahbvdpo
	DkE5bXlNvjUrMsX/uvE1CnbwB8mTXOStAT7xkgTOgGfWjVTdKBheMoAFZ1UkP9qM8+iEvw7WC2d
	GZ7zaBMySdq6W8Y+s3OlZrFgbAyQm4+CfU+PUlRqx3ozGOu6ccyEooAgxkapuMSP92zVeaYhM+F
	tYsrZClEsIK75bSdhmxKVrQs/nK1i04vc7Bb2OZED74AJatHnyiFWpdio3yLoqyj54CzpIuBLBy
	d6Bo+/JrCz8lCGBaK+11rwKnAJ/3ysf+vcVou66P6bSU0IzZh5XshWWVz5e2qEz4vmgdmZFcLnD
	NMQ8umdlXfJYeFzaGVvJmZ7Fxn4mD2kGvY5C7Fevg/EQTZek=
X-Received: by 2002:a05:6a00:bb8b:b0:84a:29a7:f650 with SMTP id
 d2e1a72fcca58-8536eb1c497mr2831738b3a.0.1787689062518; Tue, 25 Aug 2026
 13:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824141532.604269-1-tw19881113@gmail.com> <20260824142447.035571F00A3A@smtp.kernel.org>
In-Reply-To: <20260824142447.035571F00A3A@smtp.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Aug 2026 13:17:26 -0700
X-Gm-Features: AcwNN1VCQHSw3nU6QhSo-1ZByqeidn6E6Wdw3NzuiX-CFo6mIVp4fAwsj6X4kbY
Message-ID: <CAEf4BzYRftm_bbr8wsc2JKkxegYuMEuOPyRp79knU0ZnjH7TDQ@mail.gmail.com>
Subject: Re: [PATCH] libpf: Fix for the compiler sanity checking
To: sashiko-reviews@lists.linux.dev
Cc: Tw <tw19881113@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 7:30=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Medium] Latent undefined behavior due to signed left-shift overflow in=
 the `BTF_INFO_ENC()` macro.
> - [Medium] Latent undefined behavior due to signed left-shift when settin=
g retprobe bit in `attr.config`.
> --
>

let's fix these as well while at it, otherwise this will come up again
(however silly this undefined behavior really is)


and please make patch subject more specific, "compiler sanity
checking" is a bit to generic

pw-bot: cr

> --- Patch [1]: [PATCH] libpf: Fix for the compiler sanity checking ---
> commit 6bb550337600fb1ee129a0b5ed1c50e66620bbc5
> Author: Tw <tw19881113@gmail.com>
>
> libpf: Fix for the compiler sanity checking
>
> This patch fixes an undefined behavior issue during libbpf compilation.
> It resolves a ubsan warning about left shifting 1 by 31 places in an int
> by casting the integer to a u32 before performing the shift.
>
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index 4c46d34fc055d..222d2f1c0ed3a 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -259,7 +259,7 @@ static inline enum btf_func_linkage btf_func_linkag=
e(const struct btf_type *t)
> >
> >  static inline __u32 btf_type_info(int kind, int vlen, int kflag)
> >  {
> > -     return (kflag << 31) | (kind << 24) | vlen;
> > +     return ((__u32)kflag << 31) | (kind << 24) | vlen;
> >  }
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but since you are fixing the
> shift in btf_type_info(), should we also apply this fix to the BTF_INFO_E=
NC
> macro in this same file?
>
> tools/lib/bpf/libbpf_internal.h:
> #define BTF_INFO_ENC(kind, kind_flag, vlen) \
>         ((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN)=
)
>
> The !! operator results in a signed int. If a caller provides a non-zero
> kind_flag, shifting it left by 31 places into the sign bit will also resu=
lt
> in undefined behavior. Would it make sense to cast to __u32 here as well?
>
> [Severity: Medium]
> This is another pre-existing issue, but I noticed a similar left-shift
> that could cause undefined behavior when setting the retprobe bit:
>
> tools/lib/bpf/libbpf.c:perf_event_open_probe()
>         if (retprobe) {
>                 int bit =3D uprobe ? determine_uprobe_retprobe_bit()
>                                  : determine_kprobe_retprobe_bit();
>
>                 if (bit < 0) {
> [ ... ]
>                         return bit;
>                 }
>                 attr.config |=3D 1 << bit;
>         }
>
> Since bit is read from sysfs, if a future kernel update returns a bit ind=
ex
> of 31 or higher, would 1 << bit overflow and incorrectly configure
> attr.config? Should this use 1ULL << bit to safely set the 64-bit config
> field?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824141532.60=
4269-1-tw19881113@gmail.com?part=3D1
>
