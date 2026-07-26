Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621863B9
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785037063; cv=pass; b=IwsOry5BlSuFZc+9Mq6yHcwMo5/cq5Nx9zOBAF6iISUOPY0Jztmn+tdzSs6FQjTGH7ppEtZly2bEWDoBQ3YZlyzdFiOmBz9JXQUskuUGr0CzP36Ngqm+lKYo9sOwxQU6AA86luYFT5hN8IgOQ4JT0X13clNmoRFwrHIqlfrJ6jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785037063; c=relaxed/simple;
	bh=fTfaM/m5eth5+/adQosBlmcjroxc67yWQ+mOFZi9wBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpEkdmN4IonQlGnPJ5/2+pcdLyc1XT3TT/uSt6sH5uTdM0umD5Y4HP6kjnNJhtpICun/02mreujbxqyCeTUToJapasFivN+A0sjR1UGuy4dSo34HWCni2SUbsNQ1dq/WWU/iOOFANyqLNBdHEUHNgr6J2onTsM1PnsBJ4NriFoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa9C95Wn; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa9C95Wn"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81f52945098so25008357b3.0
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 20:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785037061; cv=none;
        d=google.com; s=arc-20260327;
        b=saWJToQJ/3tFF2iTLoKOwrGQfAXIGcxLLVxUDsq7T8yZTXvAE5ZjJ2JscTZt8ZzexG
         Dt8MOqh80f+P4qPzmJ32WLASp0zfWlNxsOKRmEGC/0+Lxg95cChQeOvgsMLCNuchMpXp
         1dtwTqM6mZdHOMJvKrJe67J0rE6/Qp9iKLL3yY+4TGPayn5faWbO0Ca4wJi//VaABz5f
         nY0MTHdau1IK0k56oGdySZLysn/C4/XND/x41uEiVm0GP8hxCQY6Q+jm8ruVa4/FY4C1
         GbGK+iksTcYst/Xq4ugDLzgHxMgOLD8jALLe2ZktyRCFkDB9C3esAhHa8i+5UU/cnZfc
         dLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CxEX9l/T7AwZAVrm4P1IE7GYezPpkQz92l8M6dbRYJE=;
        fh=d4lZQzJj86GOXE2uBZ63/YnMA/QksEVfIk9QnceyrRg=;
        b=kzw6rtfuutM3BRmPsBCIr6F6hF44rNVXqPiu59sbzaPV9/JPaNcK3fdoBJv5OSDvu1
         +c5xAKoclfiGx9WlQ7bgZGZ+R36sMAARWbtbEdpOBNOkPPcQTHKV/m9e+ejIqzGnN5rB
         fXzQ7LJhSNQrwGoKN9rcRhss/erVNJubbwR984T6wVEgH1dkOridpV1w4UKsUbIE4toI
         G3BeRFNBK+21HtuT582o/uVCwWPdlXaK5Zw4EoX8ZI24HNh62xw/B3BaaXyMHAmx3hbn
         06thYXCkBOhZ0mkZJSKlbmT6MPpl6uD0kPB2CRjO2lHnd3xvp1K4lNXMaV7yItBupLcd
         GEug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785037061; x=1785641861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CxEX9l/T7AwZAVrm4P1IE7GYezPpkQz92l8M6dbRYJE=;
        b=fa9C95WnrHxHYrVKtKoaU5+51AgQ3f+BKAdtGuUiPLMa8vFZRwPc0TfUGlbq2uaTyS
         pGcvEd5kr9Adcj8u2KK3G79rNiBZSYGkw1wH2wawL0xTkp5HybRH1TvXR1Ygp5YxySxc
         5ye8kbKcWLNrV79JUo9fBUUc/Q0sDWzUDugFS52JFM1wcqe4zrTRblAa2OrRqm1GxMA9
         DP9iHbu0xH/+uO00DILQfaxFKxkEQDJLx6nOstnsLYY6P5alGheIr/9VnAH/9EsNmrT0
         vSvI42Pp4g9kJ1JTV0/2V6kpNWZMBXEelJb8jZYM9O2bKlXbeql+QrIFGk0m5i8OB3QD
         g44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785037061; x=1785641861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CxEX9l/T7AwZAVrm4P1IE7GYezPpkQz92l8M6dbRYJE=;
        b=brGryAPxfFXcLfYMCk352GQ96NmVLH96Nph4gLgtsHVHJDHQOu/4Bcqp8dgowHzGkv
         e12ObaUvlqHDBQkiBa9v9v7oEpESbh8ck0t/nERajHk+iUsBVcqNKid+xwBva2iqvKW8
         TK6n7w64onyLp+9dIFWFhnhjB0QpZdBT9muwn13J0LOmkiOChVGbFKNekXdB+oD1yJYx
         iVS8K/hVJOLY29GkmLQnwz+czl4Aw3umZnnqudUZVhiYPVpC2IlnE5vqRpiaE3DZlJTh
         KtSmaS3SVyaI8LhTQ64yFWusWbUnOATV9uIcaAEe2kwO2DyTNKEF7ZdSbdfHz4tO4sUD
         E49g==
X-Gm-Message-State: AOJu0YxShQmmKHboo/90nH0nGd8NUBPS3zpLK0yHJUNyb5Z+zeJWZQPL
	l3EEcNusA6S2ON/AiN2ZUYOWwNa24A/v3rJ0CGNL1rQBtC/+O4xF7k4xQw49cPhNfXNUJx43LHc
	o1eI6a6QEQRl7JrajpbzDl4kQTKgLi8U=
X-Gm-Gg: AR+sD11KNBT/kN0PVRkDXQo9IBT0x2MVHLm4O+/X9TEu59kyUoG6E21l/bEv1rRzV3i
	t5Gcbs7YqtXLU8zlFHhVDa9zI78UaaMmeGy7qlPBYWYn4rabXYQNjGNKXzFEr8BsvdHKrFa9Ftl
	UorBcN/P3V3yv5b2lOkC+ApEJ4FCM5MeOGYwLBd7cSZp4Ebny/NhHkQ+Jse2MsnK3nksSxTp9vM
	C+WZTnR7VCEoVsVb8zgELLsL0WYeWhUIO+AuATRpEqLNL2XvmpNnhum/bjL8NkDgOn7SgNmPXV/
	YnwwHF5RoPjpfMviFA4=
X-Received: by 2002:a05:690c:348a:b0:81e:a373:47ad with SMTP id
 00721157ae682-81f63a35b07mr18584747b3.2.1785037060800; Sat, 25 Jul 2026
 20:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726025242.42245-1-laoar.shao@gmail.com> <20260726030312.DF6191F000E9@smtp.kernel.org>
In-Reply-To: <20260726030312.DF6191F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 26 Jul 2026 11:37:04 +0800
X-Gm-Features: AUfX_mwt8E90lNcOVfM9z4AERgcnP9BvBrSTgl0T4KAQiDtTFQf9Yy2WrE4eLIA
Message-ID: <CALOAHbB0w+eK6Bxd+Lsb51Z5QVtnNv=4Srbb7KWcm6zAxgkTwA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: rpm-pkg: Preserve .BTF section in kernel
 modules during debuginfo stripping
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 11:03=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The patch preserves the `.BTF` section during debuginfo strippin=
g but fails to also preserve the `.BTF.base` section, causing module BTF va=
lidation to fail.
> --
>
> --- Patch [1]: [PATCH v3] kbuild: rpm-pkg: Preserve .BTF section in kerne=
l modules during debuginfo stripping ---
> commit cd09ed46074d0224c00066939452278fca769e51
> Author: Yafang Shao <laoar.shao@gmail.com>
> kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo=
 stripping
>
> This commit updates the RPM build scripts to pass --keep-section .BTF to
> find-debuginfo.sh. This prevents eu-strip from dropping the .BTF section
> from kernel modules during debuginfo extraction.
>
> > diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> > index c732415662ef2..1032f337a71cd 100644
> > --- a/scripts/package/kernel.spec
> > +++ b/scripts/package/kernel.spec
>
> [ ... ]
>
> > @@ -67,7 +67,17 @@ This package provides debug information for the kern=
el image and modules from th
> >  %undefine _unique_debug_srcs
> >  %undefine _debugsource_packages
> >  %undefine _debuginfo_subpackages
> > +
> > +# Preserve .BTF section in kernel modules during debuginfo stripping
> > +# find-debuginfo.sh (from debugedit) uses eu-strip which removes
> > +# non-allocated ELF sections like .BTF by default.
> > +%global with_keep_section %(%{__find_debuginfo} --help 2>&1 | grep -c =
keep-section)
> > +%if %{with_keep_section}
> > +%global _find_debuginfo_opts -r --keep-section .BTF
>
> [Severity: High]
> Does this also need to preserve the .BTF.base section?
>
> When modules are built with BTF distillation (which is standard on recent
> kernels), both .BTF and .BTF.base sections are generated. If .BTF.base is
> stripped, btf_parse_module() in kernel/bpf/btf.c falls back to using the
> vmlinux_btf.
>
> This fallback causes type ID mismatches during btf_check_all_metas() beca=
use
> the module's .BTF was built with distilled IDs, ultimately resulting in t=
he
> module's BTF being rejected entirely.
>
> Could we add --keep-section .BTF.base here as well to ensure distilled BT=
F
> validation succeeds?

You're right. .BTF.base should also be preserved. I'll update it.

--=20
Regards
Yafang
