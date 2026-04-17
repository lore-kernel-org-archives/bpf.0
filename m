Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95C3B27CA
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776419832; cv=pass; b=haMTJs2iGd2NvBUvqhPrqmvhV/1ZqBBI6RUrZTfBSB5WSLcHK8HYSoIHV8f9IV8vW4pB6+vdypTKnchCm/777C2HzJbwbEWHYJhmRkodjP8m3DSc1Wy3LIqrczcG5VYBkpkr7ZLddM2KMfxMdk3/PUItr4WM4lVo3m8s1qNVF0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776419832; c=relaxed/simple;
	bh=awdxFotAPUKjWNfQk/gRj05LSGaoQJqtJG38v61RS6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmIIHGoNMJnWrH/xu0BBX/dnJLQm3g4JDrTcGOODwCoWcpodJJbtbVxrRi5nC4eFQJ3z4XlfSrAl1m5AjsJ8ExHF5Z4Ln5VEtg1cktKaaq4RwgLx51vpdtUYMbmbCIBFCWMtL87Un0JiP/oZlppSyTa4HZhY4FuxfdWagGVzs4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeOrqlxD; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeOrqlxD"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c11eba219so63459466b.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 02:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776419830; cv=none;
        d=google.com; s=arc-20240605;
        b=FJe/Ml1voNFXEInWAKpdc8SEBlklBGvrqhXrd++RzlpYQ6N59PwOEDc18kzLUzSa07
         roScKAOVPj4iXaf6e0R1gGUZFupv2dHrcDqEonEvUSUuQhFFdg+NBFYGh7SN+PRNUGE1
         6XtME23l1sBtKVY7JqmyhXoKpDSIHGTot6JDUJq2/6EyNcEAoAsZl+CyETbrSaId777c
         bhGW90oF7GsR2s6ikzO1aEGzrqoN0Zd6C/0r28ql0vURyxHrTMKhuPZSUTXXlecxenfr
         vHfTFIVyR+PE9A+tateTMR/fjEp21d3We2v8J97HvveJ/DOAHAWKUOZlTMCoHnF95wGv
         lwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5sUOm2MLj1MQYYA/qqDz9DI4c9PmTLrZLgDBTzv/awU=;
        fh=KfwUbpNWQyvBcPkTNJa3wKbvby5c+r9hQ/k37W13UIM=;
        b=SFXjo6evyz8b9AGXXJ39GGpsKAaFA21E77Hmhl5/28Ifcb7PciYXpMrT4iCvlMOyG4
         QGxXzicIZCqw4dunSpnAzJ0CR3VX+WavNwYTAw1+Yj+4Rtuf+0dIPRyD+cfNS85gmqNZ
         pIzF2S32xND5Z2vAHqmKxwW2kpEbJoK3yMfg1oHuocMukhMs0/TAjzYqh203TRZaTUlO
         q5LwRwQRNOve0pWl3cHfupV+q/ZR6JUnD9gdgnCTHT30nFbOnQbXVhPJsV9v8x7pQKJA
         f20MJxt259AxbYghutGfLsDFo4T4uBAr+CmN/uMBVr3OloIUKrEJ+fbe3Rr39mna1l2z
         ntFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776419830; x=1777024630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sUOm2MLj1MQYYA/qqDz9DI4c9PmTLrZLgDBTzv/awU=;
        b=GeOrqlxDGnN0VmVxVS87J2oYWMuqirRqvaGXKr9NloCx04As7goYrgIuOj6bUIgElw
         3fSzR2zTtNfvFtMcef4ZyT9I3XgDCOCSULIZhYSUmG8Abe9E0UWnTT6tyvjtAXKSEIEe
         FNILr6TynlxV6fj5GqHmvhwkHs/2Ps19lKeA/WE9o6BI1o6b4sjUrmcGQ2cwlgXbJrI2
         t/4UU8uACzNsnGn1a9q+AqndiPnPyxnhgBwHp6K43aMq+K5kr2K3OoqPmFURMWOXhOJf
         qhV/1C6eikk/cbCvA03s/I0GC6f5XLxihrtMAL4gToTbqi+pXxUNBhoWViLg7YGAdQHR
         +PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776419830; x=1777024630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5sUOm2MLj1MQYYA/qqDz9DI4c9PmTLrZLgDBTzv/awU=;
        b=UNFZ1mtKq350bf6qCjQK9lT7xT+c5CkH08Fw0NLjTT7qlYAHZ2j4k5GcrpXHejTLLB
         6R0iW8IR/NKasjwZ7mVGRf9uWHhNeD/Xx3NADAHYBDTbsgSes7HI5NfMda1StwrgWEnW
         54DkXFQh5WfDyNy5zUbhYkCJjvOLzVBRP2EXEEwJi6cLGDcWKj5k5XTvREKe/O9Fpulo
         RDG9j1EjejB4GO3PIdJiT+exJiM638qIBxlnkjh2GoXP0YC4aa8Rn6K6fNeJdMnp18O5
         V2xn3HVVEDZU3LbW37V1XPEibGyqycdcyyIND9JKcns2cUnjuc6zhaYhppttmWU+1R1H
         Rdfw==
X-Forwarded-Encrypted: i=1; AFNElJ9BZOPVhO5NUtKBGU1d7cJnYgkvswf2V/Vo0owsXBK3QJPNgGHPBdPj0vwqYTg8r32tJaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6C1WRMAMqJr3Fbvfd2MT6gWICDhoYf2CaVp9HF/whr+dUzHV
	0uZFzyAX//xVYf33d/jV8QR2wEqCO5HhfHAo4InLA9p6Ini817W/H6EkXa1GUwmduibRS7Zt3Ej
	J2se5scD6aivlQvSmj3vk+mvJTDpLPAs=
X-Gm-Gg: AeBDietQiNZXA/fENi2Cwr2n2VTc31oMxHQerBBXKhA71GZHEF83EddqOWBg7E3vYzw
	1l+n3l4h9zOt60G8oCIlUMIXiLeUjigCVcYQjOEeIlKxg5gN4c/4Ig4UA16I5ti3/ZSlfFLhqmA
	58xHz4faWedNDPDhvN4mLPvUMGm2u6CzrXirrGy4WXb0iHeB0IXLH2xgHg52YHR/BvtZU4GAhOG
	KDMF/ULp8CmhF8egXftD5FVjs+efpT/1mTInF2BY6MCaj9r9fD2VPsTfmWKqdncC2OfOaSzuCoP
	PCy1r8NKtADl6L11Lx+ypZwWbel1rTBCAA==
X-Received: by 2002:a17:906:4fc5:b0:b97:aea3:86dc with SMTP id
 a640c23a62f3a-ba419074424mr123979566b.15.1776419829469; Fri, 17 Apr 2026
 02:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b63e9174-7a3d-4e22-8294-16df07a4af89@pengutronix.de>
 <96a56535-6016-402e-ad25-237427c2caaf@iogearbox.net> <CANk7y0h8F2rhosKzHuf7eewuwCofjNLut0pQ=v-gehHdMcT0Bw@mail.gmail.com>
 <afb5bbb7-3ad7-4632-9909-4c003f8ea44a@pengutronix.de>
In-Reply-To: <afb5bbb7-3ad7-4632-9909-4c003f8ea44a@pengutronix.de>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 17 Apr 2026 10:56:55 +0100
X-Gm-Features: AQROBzDiKWsG2EEI_U8DZZf_VnoSK31q9I1olKG6jj0qFJFMAbtUNCRbAC8L7Gw
Message-ID: <CANk7y0h42MFVGpTwNxGPRnUbW6r7uB8EqWR-PGWAd7UJVLqSOw@mail.gmail.com>
Subject: Re: XDP BPF JIT memory leak on armv7
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 10:47=E2=80=AFAM Jonas Rebmann <jre@pengutronix.de>=
 wrote:
>
> Hello Daniel,
> Hello Puranjay,
>
> On 2026-04-16 16:36, Daniel Borkmann wrote:
> > I don't have access to arm32, but it looks like its completely missing =
the
> > ability to do BPF to BPF calls.. you would need something like the belo=
w
> > (uncompiled / untested).
>
> Applying your Patch to latest master leads to a paging error [1] and
> segmentation fault in xdp_program__attach when I run
> ./xdp_pass_user -d lo
>
> > I think the problem is that BPF to BPF calls are not supported but the
> > JIT doesn't reject them as well, so the best way to fix this would be
> > to do:
> >
> > diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> > index deeb8f292454..91fef10e88bc 100644
> > --- a/arch/arm/net/bpf_jit_32.c
> > +++ b/arch/arm/net/bpf_jit_32.c
> > @@ -2047,6 +2047,8 @@ static int build_insn(const struct bpf_insn
> > *insn, struct jit_ctx *ctx)
> >          /* function call */
> >          case BPF_JMP | BPF_CALL:
> >          {
> > +               if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> > +                       goto notyet;
> >                  const s8 *r0 =3D bpf2a32[BPF_REG_0];
> >                  const s8 *r1 =3D bpf2a32[BPF_REG_1];
> >                  const s8 *r2 =3D bpf2a32[BPF_REG_2];
> >
> > This will cause the memory to be freed properly.
>
> This works for me and resolves the issue.
>
> Tested-by: Jonas Rebmann <jre@pengutronix.de>

Thanks for testing, let me send the patch to the list.
