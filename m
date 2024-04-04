Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0B12B95
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245365; cv=none; b=GDJiPcXPxJv0LPeN/QF85Jwry71/DiEkzysGJIEKDawROQnUTwVWv88HvE1UzE/lDGFw6ULcqdBEuL4tCb8QszWWZXr3U7kKqpYKzhJRqdOYtmEOaIQ17NxgkvfL8/FgDRUXCv/9/gwF8gOL+c19sXt5QoIbLA6VSctAFqEwjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245365; c=relaxed/simple;
	bh=YQRIFRi4bPZ7du7Reda6Iux3uecmCLl5eesFHvS4XzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3ONXnYlJpxXX5anktsMMrP52/8FoeY2TDLMey3eCLzNd8/xaQ+O78J0XD3VsVdEMJcm3Mj4KMzWwLhImT25M+vW16XCeMqvrFK5Exj4o+fDw3Xkc2eIo2nr4gyniGjBkZjigv4sxEx5868PiZzGcFVVSSSrsZ6er2LBLE1eT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dj7N7Zp/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dj7N7Zp/"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430ddb1a227so6367631cf.3
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712245363; x=1712850163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKunvuv5MoHS5FCGO5iZjXoNq8uHGAXgjEDPMRr8OY8=;
        b=Dj7N7Zp/tdf/s7s+Xj7atTvpHWUhvkjplTXPF1sFBmr1tli4TlwF2iBkNZUMddHRpB
         RY0OTDMoabymfEYoyxgd6K7t+hLWoTRUNZggRuSkYbC4zX7y5ppuyZig07ESFyXoxX2L
         qpaCWxAlZ6PG6oPccfaqfEYu54/XYRXl5k7kNqjwaJINEhrPPRqa84S8b6+9hYczTvwm
         WbJZDd/YgiRLIiGlsJRk4scTWx5mlqFFOHO8lxSxJ+VadkQ9JfikwBxFmseXyn2NHnNl
         Rmr5w/WWBm2MDSNOBIh4i0IRP/nf0642blIeCVhLRNfU2Q5KxvO9yR6KfTnPDwtpJbSp
         jmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712245363; x=1712850163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKunvuv5MoHS5FCGO5iZjXoNq8uHGAXgjEDPMRr8OY8=;
        b=cD+kuV8XVlNaIRHyNGvZO9rAEbNTz922f4I32nA670II1rHqrNgFa0CZrJLUGu5Xlu
         EOR369lp8gLQt7P45uF/eaVVnxsAc/Qv2L9GYrbC1GRjT/7Rc2hareWDsoA12gnMHN9p
         CyLwrFYYkkvJkCk0SV9KKOLZ1QfUOk7CR4fS7KDb7WhOm2pfTnmOElSZC/cyuLwLSi6t
         cBpU7BXD6xjJpjq92BZ4/RAHD2df9vwCo+5bLe8jm6tMopxITqccHHbqNzV1IuxAOeiq
         m2pbncY9735EtJbPT289ftUsbhbG9o+xNraB2CBxwBwX3R8RSXT3SRbTq6Zvxn53zWIl
         h6vg==
X-Gm-Message-State: AOJu0YwlbG6viZ2wkOpZlRyNfz8FUzA1YQzs6DXq0OkYypJchRadkIs5
	7xVJqlVYziP7NtauqNqcocEv5769x4Lc/4Qu0fntsmawj9hp29h0R96CWruebMj6tmJzFGR8Ouw
	GxbIQ3gND/Iok7rlK3MWiqoynYcg=
X-Google-Smtp-Source: AGHT+IEhcNU8otyNjzjfB4c4L7cff5dIMUwNactwwt1E+8V7ROCO/gDFTSe5E4cvF0iHJK082Z71slXV7FloG0kU9Fc=
X-Received: by 2002:a05:622a:42:b0:431:32e0:1723 with SMTP id
 y2-20020a05622a004200b0043132e01723mr5018qtw.67.1712245363115; Thu, 04 Apr
 2024 08:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2zKF-RY-Hr0SCDNttktAhdjOzgP1jLgbH6wD7+ssL4rtA@mail.gmail.com>
 <CAEf4BzbjwTVUZ154ZqEVSQe-++a=B=SD5L7SRGPGH=N58tLJKA@mail.gmail.com>
 <CAK3+h2zAF-N9s=PO3eW4GJ86Ov14rBOAZFEDqYbSeFBnss_PyA@mail.gmail.com>
 <CAEf4BzbKz2xCK6jqVnzA4uWnZKx+UteNPcZ3zFtyYe885stnLA@mail.gmail.com>
 <CAK3+h2wkbuMrcPg6E7Gh0AxbGiSKNGJ6RX=psxtBP6k9W0L6PQ@mail.gmail.com>
 <CAEf4BzYY09WnHsz3peLYMy0=A3JkivV-zxD2GjmGrQWLbhW7mQ@mail.gmail.com> <CAK3+h2zpV75MkOx49RvXyvf+DwHjHaF9e8jFj+3AG2qZQZEr8A@mail.gmail.com>
In-Reply-To: <CAK3+h2zpV75MkOx49RvXyvf+DwHjHaF9e8jFj+3AG2qZQZEr8A@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 4 Apr 2024 08:42:32 -0700
Message-ID: <CAK3+h2yUVUAVq5OZjnrRti58OM=ro6Kvb4b48fwcpHCM-M92UA@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 1:01=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.com>=
 wrote:
>
> On Wed, Apr 3, 2024 at 12:56=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Apr 3, 2024 at 12:35=E2=80=AFPM Vincent Li <vincent.mc.li@gmail=
.com> wrote:
> > >
> > > On Wed, Apr 3, 2024 at 11:56=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Apr 3, 2024 at 11:34=E2=80=AFAM Vincent Li <vincent.mc.li@g=
mail.com> wrote:
> > > > >
> > > > > On Wed, Apr 3, 2024 at 10:56=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vincent.mc.=
li@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Once I enabled the open source firewall IPfire kernel 6.6.15
> > > > > > > DEBUG_INFO_BTF, the IPfire ISO image is increased from about =
450MB to
> > > > > > > about 1.5GB, I suspect because IPfire has many driver modules=
 to
> > > > > >
> > > > > > BTF can't be that big. I think you just get all the DWARF for m=
odules
> > > > > > and vmlinux itself. DWARF is necessary to generate BTF during t=
he
> > > > > > build time, but it can be stripped out afterwards, leaving just=
 (much
> > > > > > smaller) BTF intact.
> > > > >
> > > > > ok good to hear that :).  I am new to this, how to strip
> > > > > kernel/modules DWARF after kernel/modules being built?
> > > > >
> > > > > >
> > > > > > > support as many hardware as possible, pahole generated BTF fo=
r all
> > > > > > > these modules, that could increase the size of the ISO image,=
 so I
> > > > > > > wonder if I could disable modules BTF only but keep vmlinux B=
TF, or
> > > > > > > maybe selectively enable BTF for some modules, but not other =
modules?
> > > > > > >
> > > > > > > I found this discussion [0] making DEBUG_INFO_BTF_MODULES sel=
ectable
> > > > > > > independently. I am still not sure how to disable modules BTF=
, I tried
> > > > > > > make menuconfig, still not obvious to me how to disable
> > > > > > > DEBUG_INFO_BTF_MODULES
> > > > > >
> > > > > > I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work fine, but=
 see
> > > > > > above, I don't think the BTF is a problem here, it's not stripp=
ing out
> > > > > > DWARF.
> > >
> > > I  manually change the CONFIG_DEBUG_INFO_BTF_MODULES=3Dy to
> > > CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
> > > in .config, but make oldconfig always flip it back to y, if I run mak=
e
> > > bzImage without make oldconfig, it will have "Restart config..."
> > > like below and n  flipped to y again when examining the .config
> >
> > Maybe CONFIG_MODULE_ALLOW_BTF_MISMATCH is auto-selecting it, try
> > turning both off.
> >
>
> originally CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set, so I set it to
> n, still CONFIG_DEBUG_INFO_BTF_MODULES set back to y, I also tried set
> CONFIG_PAHOLE_HAS_SPLIT_BTF and CONFIG_PAHOLE_HAS_LANG_EXCLUDE to n,
> no effect, all back to y
>

I found if I change DEBUG_INFO_BTF_MODULES def_bool to n as below
diff, it works, is this the right way?


diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc..98d7a4476d00 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -408,7 +408,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
          using DEBUG_INFO_BTF_MODULES.

 config DEBUG_INFO_BTF_MODULES
-       def_bool y
+       def_bool n
        depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
        help
          Generate compact split BTF type information for kernel modules.

> > >
> > > # make bzImage
> > >
> > >  SYNC    include/config/auto.conf.cmd
> > > *
> > > * Restart config...
> > > *
> > >
> > > >
> > > > strip -g ? I don't know how this is normally done in Linux distros.
> > > >
> > > > > >
> > > > > > >
> > > > > > > [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2tyk84ZG=
vwuCJLjesqw-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951feb931b=
294ec2d
> > > > > > >
> > > > > > > Thanks!
> > > > > > >
