Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDA5482DA
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169252; cv=none; b=LuqUyQivyonJ73daGZnSa2O2Ni2WCp659lVO1NFuPzhz+eZCPix3b4GrDC/HHJDbv086LHn7Icip4q9TZeQELpsQle3ID08Jik7OtdIsMupE8V8Y8QwZINkFEYiKVlKfN8RdTW/C+ZJZ56KuVk6xWaODy1SU+mGgsPpMOO381jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169252; c=relaxed/simple;
	bh=ee97qXnkLil9SMbWt0YjdKE+e9gOL3tefzisTFPRrkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPEXO5uCYcLYTYpG9ytIVKaBa9fpQMEPXSXkg1tx77yNdYVaL7EP6SY2a66nL6eNhxJmbHK+e+gCGkIY4YDOeiSkXExOLGgFoSKJDmQHnrd7+0+w9Lf43TTlriDxu9QL2irq+FjQtA929a8RhlY+VoiPMWe7I4iLbpa4EfY6CM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ac/ykCsK; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac/ykCsK"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c4f23f3eeaso24254b6e.1
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712169250; x=1712774050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mczpwjE+Cm7aUFs+ZgjFzL+9l5sheLPG+sUGY5/o+iI=;
        b=ac/ykCsK+jPhIfmPTB4+zmZilBMtb6vPMc+y+vdja7gp4qKRmapCazkrn+lAy9iNrC
         CIkh3Nf8MsJVvGMVPNur53QH1ia1q/Qh6q6VvrHJpoFpb0x2xzzdkUkIz4fWQBrnRaYd
         qlBO8w82eIpVofEJGsXqyb7BOw/uIZK0I7xYGt3Cj/iwg/VlOhr7HOPNk3ji7v6Bx2/p
         RtTNkY6h3b29IcASBZw+fceo1xqLk2IXYF87zZ5faUSG9zihz66X5TReUx7QwVnraIdd
         7Jh/4cybfDHJ+4Jsb5C+IZmwgXI2k6MMdgXUDr6FAi+sMD/MhxH0AicKNxgEqb/7Mhe1
         IlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712169250; x=1712774050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mczpwjE+Cm7aUFs+ZgjFzL+9l5sheLPG+sUGY5/o+iI=;
        b=El1ywXgkLYxDac7KpZ3iyrQItJsFUtWxPyoL9DA5VkUpomz3cj6T/ohLQyqzJyZOdn
         W5SOeBKUpQS29c1p39nPLeQkAvXgpmohge4eoo82VWGXfSdqqAVK4YO4C9oO+/uW+ltf
         6pMzSADCjtALUWMo0fVgf38/PLbJzfLIq6ET9omiAWROsiFdWkIilWuPngZJKmgADTXs
         lTLkQBJ6WJSDvQLMyXP15+gboHGDjJaX0JhiA+YpvKu9ILHTW4Gvn0W/hTsLBcDM0M7u
         zCrz/+to7CqVRl7/zVc7yY1+uPfOQNYD3GGWT9/mICWXTrgkAZ82dvpwKlIyvW655PZ9
         fBvg==
X-Gm-Message-State: AOJu0Yylewr5KWp9l01wFlBs4xf2/PazkOLagdfTMkaTrWkXKjHPmL10
	Ho/f/I3gYWdHd2wk/YAJ+z/xNvwkBHlBm8mzPnalxGu4r5bjxszYuEdnVH8ZDechrG1iA+5EuPB
	HcKFoiaktEgZk8qzLNeX/oxZeppgk52DA
X-Google-Smtp-Source: AGHT+IHIw2h1OP2Pp1u0/WxqHGATOSOVmJKQf9uYAHLE2YYx/OI57pRSpaOAPAD1SgcO/JMgvtPPxiLnfAZPZgpegw8=
X-Received: by 2002:a05:6808:120b:b0:3c5:d2fb:ed8a with SMTP id
 a11-20020a056808120b00b003c5d2fbed8amr313396oil.35.1712169250500; Wed, 03 Apr
 2024 11:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2zKF-RY-Hr0SCDNttktAhdjOzgP1jLgbH6wD7+ssL4rtA@mail.gmail.com>
 <CAEf4BzbjwTVUZ154ZqEVSQe-++a=B=SD5L7SRGPGH=N58tLJKA@mail.gmail.com>
In-Reply-To: <CAEf4BzbjwTVUZ154ZqEVSQe-++a=B=SD5L7SRGPGH=N58tLJKA@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 3 Apr 2024 11:33:59 -0700
Message-ID: <CAK3+h2zAF-N9s=PO3eW4GJ86Ov14rBOAZFEDqYbSeFBnss_PyA@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:56=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.c=
om> wrote:
> >
> > Hi,
> >
> > Once I enabled the open source firewall IPfire kernel 6.6.15
> > DEBUG_INFO_BTF, the IPfire ISO image is increased from about 450MB to
> > about 1.5GB, I suspect because IPfire has many driver modules to
>
> BTF can't be that big. I think you just get all the DWARF for modules
> and vmlinux itself. DWARF is necessary to generate BTF during the
> build time, but it can be stripped out afterwards, leaving just (much
> smaller) BTF intact.

ok good to hear that :).  I am new to this, how to strip
kernel/modules DWARF after kernel/modules being built?

>
> > support as many hardware as possible, pahole generated BTF for all
> > these modules, that could increase the size of the ISO image, so I
> > wonder if I could disable modules BTF only but keep vmlinux BTF, or
> > maybe selectively enable BTF for some modules, but not other modules?
> >
> > I found this discussion [0] making DEBUG_INFO_BTF_MODULES selectable
> > independently. I am still not sure how to disable modules BTF, I tried
> > make menuconfig, still not obvious to me how to disable
> > DEBUG_INFO_BTF_MODULES
>
> I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work fine, but see
> above, I don't think the BTF is a problem here, it's not stripping out
> DWARF.
>
> >
> > [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2tyk84ZGvwuCJLjesq=
w-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951feb931b294ec2d
> >
> > Thanks!
> >
