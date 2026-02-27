Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCB3BB4A
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159621; cv=pass; b=EPFcmx74RFXBo5cw9pVUs/sIj6s4MrosKM1ybfu3R27/ud1KDpMkYZhH6WzUvAB0b1m0zJ8JydyAAH/c5Xsur6tSUV2dc/FRBL4eJa2K1OWW0qfB7X00jpVT/Oq07dHVCriMbLi3tge/vg4yUqkKtiDjaWyS/QzOWPt67jhWj30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159621; c=relaxed/simple;
	bh=TI5U69BTvXdd8B3j/P+6kOx4GTn64SxT9ZsLTc6q2Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcO+teSOpXvUdQ7WiugAfBj3jWH0rQCy0DNmmhprrQVVH56Ecwq/dl9NFksqQABYl0cUPQaMsIHNQhXuNyAimfuVjJxoupmhuJLx/bI4wUHavtXmvCmhlcxeLIG0F95vTKtC1HvA6daOSXjOId8ZKLbH2/PcXifkgA8k2J4EO44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JB3tARVV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PN/aGxc3; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB3tARVV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PN/aGxc3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772159618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZhniSNkbfOkNF4qC2hYeVFLUMtmUrZtxX5b9EmLi/c=;
	b=JB3tARVVj3rYS2CtcDk9auEcDTwbYka92so2G9Qta70NCAYVzESIeSrXIGcQ+4EDeu7tcb
	SvI7i6BPAJ7Pg8pz3ZZ3bF8hbCJjVnia3YavzP09oiGY+Yrn7ADEphuUPV1G1Uv6sMr/AR
	ZFRSuTZqEiwMWk2O4sxgeDynjWKhYx8=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-73loaUjFNayMkLv15OeUzw-1; Thu, 26 Feb 2026 21:33:37 -0500
X-MC-Unique: 73loaUjFNayMkLv15OeUzw-1
X-Mimecast-MFC-AGG-ID: 73loaUjFNayMkLv15OeUzw_1772159616
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdd327d970so633179eec.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 18:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772159616; cv=none;
        d=google.com; s=arc-20240605;
        b=FV/ig8O2X3nr6M+h/AICrSgaOlZv3gissva/Zv3OLWIoupGGKDaNjGyQoTeckRB1Qh
         JtsGQdDofYJsGDpW1LgIewd7Ye/au2riEHGG/qfyA/Kk+O8DaZjPs5DPWWAvt1l4CYiw
         AaW60rmvPASLq4g54NWhN23ioJNz++hNdxwh8YBBPE2wqW6ZuFdmjtk82Fi/kfkji7dI
         SBiNW6+bqvPpD4CYCVvon5ZcenHeMCmDlRTiMHxoBSJkamkqC22KAK+dP6An9Sc5OPDb
         7XFjSTPZTaila9dpWZAzQRBbsnM+X6va3w2x7ePNu8uF9hf9cNj3dgfPOfESbJTrBLki
         YTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HZhniSNkbfOkNF4qC2hYeVFLUMtmUrZtxX5b9EmLi/c=;
        fh=v/cKISnTI2mdPOFYMesC74ndQZzC8jK3QmetgQOOIz8=;
        b=fu78hiILu39+Dssz2erv+F1znX0zhjgrfVbMbLV5k5WPCNQichn9sC8UsZPcWdP9jg
         0IwpFo2h3/jLnIFVzn4UEJksyDSSK8qzkGAAk+mXZWhA1ucT0t8wgaqxuhV41a/irH1z
         qOuVagwchLT2hHl0dDUjx64wCqcfvsMzktsQYQMiTaRWVe1rNmGmc4kcRLAFrfa1u8r5
         sXj4UTyUSjss1G5h1cmHQs0nGH2SXhouGaWbLZyytEx5SvDcf75zdd+tuWBSxt2XR0WW
         RB0vvb2+0/zGCNhPhkUHBH2FR0DmWuGddGzveTRdq0hJO6iYtiXICe3dqQT1lHPQamqI
         G/Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772159616; x=1772764416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZhniSNkbfOkNF4qC2hYeVFLUMtmUrZtxX5b9EmLi/c=;
        b=PN/aGxc3cZfyTmsbky37OZBLftI112gtPdEio2UKZn76acYzJN3M+fBl6myDracVX5
         1neFh598gLvSxcSwusyGaaG2Sgr1RQEdBxK4gy99NI1Y37nB4nZanpJxXSC4KRY08Vl1
         YpnzbZfyoO7E5kpt+x+/vf3pmZ3LpnX1XPJejA/z7Fg7wGB7LJaJJUCxLyycK6LiSvLI
         fk0qYzY0+LFuwaKOl2QtiMxRkgLpVK+aTYzZAd+f7UuAlX5x2JhqIU0x/XQoQGVuGTaT
         aEB394sweptLqyLsA11OOOY9q6mKiGvHoEG/sc2HExTQgsh5xNyROYEXVD6O7onkv5XB
         ahiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772159616; x=1772764416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HZhniSNkbfOkNF4qC2hYeVFLUMtmUrZtxX5b9EmLi/c=;
        b=oyaEfBR8YDyBY3IVX8KGj2Ba4zP4UFsDcpmQefBS+WoovNafDjI12QSUM2UtEbsbXS
         OavWSKnu9jG3EeAro4CHS00Pju91/i7caZVWxwOUOMqD1jG50FaqMUu0slRLYJDjfrNA
         pxnS/qQpsLLA1ZaylLj1JnHDyNeQOWqElNRd5aIxuLShc1TMv3nveMRvEPykjly1ftJ7
         8yFdSQKUV0f8P01RF86Jfng8yoMJkpgB8SxNE96yTJ6iMhqpaILEvFMDvt5HjaMHudfR
         pSOVJyVcZfF0Kr6RMkE+7LdwZYp4BIWpjXbk64uVUbtxp9XU49XXuh8EofEMkPlhlzwx
         Suzg==
X-Forwarded-Encrypted: i=1; AJvYcCXRZC9vBC290jZd/KA9u/P27zOSvauVlSuPUEZUSON7XCRCnZMAm90olMPVmx1ojmoNtaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzritTDkDpNF2T33iJaqHrs37s8zL48fkA6RqzRgaBp6lGSzXct
	IChbYJ/dmrq7kjxUjeO8RH+UHWHxKwx7m21FcpQFqMvNGDaJ3f7npe6R7Lg36+kW93QFomIjM57
	jkC4joWjISh7wA/RVqT2WjP41TIEE1qM3TK2vpQ9+KTm9z98BE3ECJF4fAO61UuZhvADMS8JnOV
	SiASJUcEIfE7blRliht7QYYCGT/McK
X-Gm-Gg: ATEYQzzCUeFuqEtyGRhgIVbLAvq93IcC5R3rFBWQYNAnFso6M+rXumJsclQzH5gEnXu
	P9gt4NJzhoZZ4g8obnfaVlzjdvKDKZfEjDQ/vwTLJi2Jjw+9e/LmsV9J7T2Wi0XTtZWY8WYCeDO
	XP45bpWl3jizjFeagz8WbZcomk8HvNqBki2RfcvvR2u/MXwTSBRwjEMjRI3OriorwLQZIJq1nFs
	JRfxS8=
X-Received: by 2002:a05:7300:cd86:b0:2ba:7c92:82fb with SMTP id 5a478bee46e88-2bdd0eccf46mr1356278eec.5.1772159615881;
        Thu, 26 Feb 2026 18:33:35 -0800 (PST)
X-Received: by 2002:a05:7300:cd86:b0:2ba:7c92:82fb with SMTP id
 5a478bee46e88-2bdd0eccf46mr1356266eec.5.1772159615443; Thu, 26 Feb 2026
 18:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119032424.10781-1-piliu@redhat.com> <20260119032424.10781-3-piliu@redhat.com>
 <20260226143710.42ba1843@rotkaeppchen>
In-Reply-To: <20260226143710.42ba1843@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 27 Feb 2026 10:33:24 +0800
X-Gm-Features: AaiRm51sv1BDNshyMBDK5hf7V7z9_aThj1MpWelhNhiRBiqIEooTA6HtBrVxGwk
Message-ID: <CAF+s44TxkHPfGpiuD+RSGUCZ-WASOSUneObeEenYNFyCgdogQg@mail.gmail.com>
Subject: Re: [PATCHv6 02/13] kexec_file: Move signature validation ahead
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 9:37=E2=80=AFPM Philipp Rudo <prudo@redhat.com> wro=
te:
>
> Hi Pingfan,
>
> On Mon, 19 Jan 2026 11:24:13 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> > Move the signature validation at the head of the function, so the image
> > can be unfold and handled later.
>
> besides what the bpf-bot already mentioned.
>
> What do you want to achieve by moving signature verification in front
> of probing the image? Do you want to avoid calling
> arch_kexec_kernel_image_probe twice? It would be great if you could add
> the reasoning why the change is needed to the commit message in the
> future. Not only to make review easier but also to document it for the
> future.
>
Here I made a mistake. I think the UKI case and the convention case
should be handled separately. For the UKI case, signature verification
should be applied to the UKI envelope but skipped for the unpacked
kernel image since it has no signature.


Thanks,

Pingfan

> Thanks
> Philipp
>
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > To: kexec@lists.infradead.org
> > ---
> >  kernel/kexec_file.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index eb62a97942428..0222d17072d40 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -231,18 +231,19 @@ kimage_file_prepare_segments(struct kimage *image=
, int kernel_fd, int initrd_fd,
> >       kexec_dprintk("kernel: %p kernel_size: %#lx\n",
> >                     image->kernel_buf, image->kernel_buf_len);
> >
> > -     /* Call arch image probe handlers */
> > -     ret =3D arch_kexec_kernel_image_probe(image, image->kernel_buf,
> > -                                         image->kernel_buf_len);
> > -     if (ret)
> > -             goto out;
> > -
> >  #ifdef CONFIG_KEXEC_SIG
> >       ret =3D kimage_validate_signature(image);
> >
> >       if (ret)
> >               goto out;
> >  #endif
> > +
> > +     /* Call arch image probe handlers */
> > +     ret =3D arch_kexec_kernel_image_probe(image, image->kernel_buf,
> > +                                         image->kernel_buf_len);
> > +     if (ret)
> > +             goto out;
> > +
> >       /* It is possible that there no initramfs is being loaded */
> >       if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
> >               ret =3D kernel_read_file_from_fd(initrd_fd, 0, &image->in=
itrd_buf,
>

