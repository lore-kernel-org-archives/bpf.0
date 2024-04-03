Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F3153BF0
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170561; cv=none; b=F4gjz/9CIWfHNRy94bTRh16YNL16UIYkYObm+DO+/2ZmESQ97zqAumyD8wtUOOwrNTVgd1KqU/4ukUAaUNP6TfZvLkmONdU5tyN8WJlZPywIoteXZlStRoDgI+I3VDLsv6YFaFbNvUqcjPYFHm+iy+y6K6vhdncsdG2585SuUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170561; c=relaxed/simple;
	bh=LNDmr1GQkcFH3eIArYUYce5JFSVbuRjTstSff0H6EHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edzOHn8uZWCcVGo96VwaCvFZEtwo/nlXdoZw/dfPAPuMTL+gW4+xubMp3WIbkWEt669KWxADiDlVX4W/1QNzhUfzWi3nMP+xXoCl5S3TOH4j7OXWD3NC9+1C0eCOb7YGAT37h4kR79drcsknmeixfwI5ZgZ4r8cLor9ISPiReJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOMOLnT6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOMOLnT6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e27c303573so891285ad.3
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712170559; x=1712775359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miekgjP8tpUquwxBmLd06ucd5y9D2bGhtiuXTe3lFAk=;
        b=WOMOLnT6RiHDQBY5vl0J63ScEliVP2eHdq7OUMGgqyEc94BKaCrPj3WFzLFBxUpcOW
         NAlbAotHnBc/80atoqOGqjP7e00Is5XF6lNL/u4Lo9ZN60PbWCvm7m2m8w4Zr3aC9Z8J
         M1/VxezipOdq1yfhkG3wVPqPSAK7tT2o2p6E52+5iTfEupQcXrogmeTrpBTq6TX72xIk
         pp0QW7u1raR/zJQooO5JksEw9M3lm+QHxgsIHgRBbyTQjQbEx+HMKYsx46x04rDy4dVL
         rOGuECfLnHVVRbnH1Ay9JPeV5n08/OZGLUDZa8YycYZ6W4A7KdX8CPQvGPNE0nStT2j2
         H5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712170559; x=1712775359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miekgjP8tpUquwxBmLd06ucd5y9D2bGhtiuXTe3lFAk=;
        b=uTrE7OVotyPCsBcXScszdHNTLjFA0a5fHoopL1Kb7zC+WKuWCFeVp4vwb4qP/QegLa
         RnuBxMpRugwSpNeZHA+AWkxNmV5MhTKSie/IPjvaPljpkeAuQVBqEe7Q9SmGyGwDSzGl
         BCADy6/ArmrpGKjj+m9DDSeGfGTtTQBPCPYW0ZEQifR5DZhGfKUgjCJxk+r9dxmIUnaW
         wMjPKxUNAfeQufUzyFw/j/G3a6RryiKPvAdT0QlrsIDjFywJ6H5Zp39H3nAV4j8xUXc7
         B+SpwkPdY/eHyB4O7J2eLWrPZwWLRScwe+G4OAscz1daU59KkFl2jK0l+XnE6sAkCJ5I
         w1kA==
X-Gm-Message-State: AOJu0Yw8vxHjcRjRyBM8O1mPXNvzSx4vSmPOKuRp0DttrZknY7aBYY3g
	7+BwrOspdsGM5x6LhQQyB0XHO9zPgh5JyFRtTGqrJGA8Q7hYAr4Hkw6TvZd/1fAyFpYabUX6pzx
	nMUjms2Wfr2ji2IAp9M54sPCVRPf7p3WQ
X-Google-Smtp-Source: AGHT+IF59ENtHFS1oeL27nPfp707qqGtYbhEb9Sjh/AXKeHmY82bOLtPToWPfR4vJVsYyppd4GVqniKNG2PCWeewXR0=
X-Received: by 2002:a17:90b:364c:b0:2a0:4fe5:e4f3 with SMTP id
 nh12-20020a17090b364c00b002a04fe5e4f3mr408657pjb.2.1712170559477; Wed, 03 Apr
 2024 11:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2zKF-RY-Hr0SCDNttktAhdjOzgP1jLgbH6wD7+ssL4rtA@mail.gmail.com>
 <CAEf4BzbjwTVUZ154ZqEVSQe-++a=B=SD5L7SRGPGH=N58tLJKA@mail.gmail.com> <CAK3+h2zAF-N9s=PO3eW4GJ86Ov14rBOAZFEDqYbSeFBnss_PyA@mail.gmail.com>
In-Reply-To: <CAK3+h2zAF-N9s=PO3eW4GJ86Ov14rBOAZFEDqYbSeFBnss_PyA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 11:55:47 -0700
Message-ID: <CAEf4BzbKz2xCK6jqVnzA4uWnZKx+UteNPcZ3zFtyYe885stnLA@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:34=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com=
> wrote:
>
> On Wed, Apr 3, 2024 at 10:56=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vincent.mc.li@gmail=
.com> wrote:
> > >
> > > Hi,
> > >
> > > Once I enabled the open source firewall IPfire kernel 6.6.15
> > > DEBUG_INFO_BTF, the IPfire ISO image is increased from about 450MB to
> > > about 1.5GB, I suspect because IPfire has many driver modules to
> >
> > BTF can't be that big. I think you just get all the DWARF for modules
> > and vmlinux itself. DWARF is necessary to generate BTF during the
> > build time, but it can be stripped out afterwards, leaving just (much
> > smaller) BTF intact.
>
> ok good to hear that :).  I am new to this, how to strip
> kernel/modules DWARF after kernel/modules being built?
>
> >
> > > support as many hardware as possible, pahole generated BTF for all
> > > these modules, that could increase the size of the ISO image, so I
> > > wonder if I could disable modules BTF only but keep vmlinux BTF, or
> > > maybe selectively enable BTF for some modules, but not other modules?
> > >
> > > I found this discussion [0] making DEBUG_INFO_BTF_MODULES selectable
> > > independently. I am still not sure how to disable modules BTF, I trie=
d
> > > make menuconfig, still not obvious to me how to disable
> > > DEBUG_INFO_BTF_MODULES
> >
> > I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work fine, but see
> > above, I don't think the BTF is a problem here, it's not stripping out
> > DWARF.

strip -g ? I don't know how this is normally done in Linux distros.

> >
> > >
> > > [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2tyk84ZGvwuCJLje=
sqw-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951feb931b294ec2d
> > >
> > > Thanks!
> > >
