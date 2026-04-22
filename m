Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BF397690
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826501; cv=pass; b=rhtq7QNOLKTR0YVJssWt5CsO2+vkIL59skIYy8DI2WMlA7RK1yhwkKeolfSf8IGEILcHr8Ipnx+kojgNwWD42R+ZSd6v5urkhy39D2VM2NMZKNcp3E8xBgsN9FG+rMmpsRciYaesBWvbNsOsO5g8CZLwYWnDURdN5Uikn6tM/G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826501; c=relaxed/simple;
	bh=5B8p+QDUxXae132Fq/olL0Df/Jc61502WZG8qooebxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZvpbKoqCx9YMQccTQewVYgS+IO3CwDmNwYG6p6pHwdx27D2wEryWa8q6H0MWkVU08chwGMz4HGqY5fWWzeYPnVOTx7M3g7Wgz1xzZLcb60DHlxKl0D2AAsuvIAEpuByUzeUjkAhVbCvWTH2Dkniymf5VuE6H2F3DZgfLTpfj1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/dtEV60; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/dtEV60"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a3fcb2c718so4143109e87.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 19:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776826494; cv=none;
        d=google.com; s=arc-20240605;
        b=lFB3ag4xnhHMLq/ZDfeb1ONJghopZGvzLDPUh2lzrDEeJMEwbrste9nR24Q/1JqPlm
         QldsEjLs/cvX8fHwJVNck47ZeFWNB3r1H0oYyb1KsOV9Jo2t3IX6wjKIcr3gRSVQlSdT
         FieePWPtcC5d0a1TKeydh5DN92T95l1hfijdFC36TahyPtMT+KZFi1tRbqkKl9yeqLCv
         vcnB5SzMYl3KJ1gINRranojX2GTAggEj3n3OlKZWFDCf/4prXTO+wdzFs/wqjzxA3R8G
         NmFBbGVgWbLvSrUJU1Cf2U+RbrPvAjMkyPF1tt6uYREVwFZ7g+ZxSg4kSxr/ca4l1jeO
         lfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OG7eT7g8H7j0h83hkzwInJ6CPJnFxfvuaf/IIwu8WPE=;
        fh=2uvtnr7QxlZP6Yi1QZq8XWEmmK0YnWOimVX3JW2nI/M=;
        b=bvBXwzbJNUFJ1wOPJ8GLxPqr5vXbyYhE/bZeo/WGdXlMz+4OtZ0VBzZlZrJ+6kDIKI
         orhhQi7NhOyT0o/lvLDPumtZ0aeSJa5vxD/mFFieE14ZxjDgrWz97G8IQ5Rn+dtPeXri
         /ZOHjz2pxO1UWhqFEbKlmYeqiPZxPyBT5n8wt0QtEjiouJ5sr+ju+HQRqf6A46+K+KHI
         TW059Mp0zQkMNbVI1XO0O4clS2uprdELOJUWQUpfO9Ge6Gn7bVNdQlOADlD253oJksyG
         fTVTAlMOSIxh6CGUm9+3VxYRcgfVu2s4OUWn9caHcSy+DSu1vid56EBcCiewXwDaKnaE
         42Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776826494; x=1777431294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OG7eT7g8H7j0h83hkzwInJ6CPJnFxfvuaf/IIwu8WPE=;
        b=D/dtEV60ZtyfzKCFbJV1Rz5c782y6UMxQu4J/EMDtymOw1ihuX4HQoVXVsnL0vwUyv
         D7VWXLxRQqIa0/DUJy7shZ596s0anxAJ7wyMoURxDwHwYuvf2na5VjkdfhhV6LJo0lCo
         QmZYB/iVwSfltbsFLNDFFKFFzIeETXEOfq/ivTAPTSoKIotLvA4v4cKkONJpa6USzCxD
         x1pmgLGigOtBA/SvnISjoO4c5OPpAUt5mA77q5TdPtFhnZYzdARsoxSVHU/lPs82/uS0
         q1ZlY/7RPvP7Qm8zsBwle9XJwfvZ1gYPER8sAV4U0wrbAQz6uKZIc5PyPA3EKsjdSSOX
         8p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776826494; x=1777431294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OG7eT7g8H7j0h83hkzwInJ6CPJnFxfvuaf/IIwu8WPE=;
        b=Zf4y+ZdV9DbStO8x8g4MSCMPW4tlqG/41gBCX8LcM/GEluUg/mZ/BmQunvfroVv6zU
         FAYGWvUcglMUKnS7plV0VCyXuUPwN3vBm1Dm2cT1HKuvekCet/RRoMwCXeg8aFMvzpqC
         xvjG2hDF7oN8KPY6Aopm23KzXvqGLL80qFGFkAQNoUnIIOjTEHP1Oxr022jM2TD4ZP5x
         bnMRca3o3VYC0ANb4hqMTG6fxI6pH4ZOrxNOmfBREVSjMVVE8cTLoJAlu0H0IfV9p1cG
         eXLCjCHrlLawQR5fym+VLkBznTfm1hhb5Qk/7uBcMtxx24WrcHw1TmO7+EoM39oz7qFC
         xtJA==
X-Forwarded-Encrypted: i=1; AFNElJ93bQJhJBWA0fRC3Z6qtTLlBZ+cBwD3XQOCo2Q9k0PJGezlUHatSSQGQDcr3sXdY/VDois=@vger.kernel.org
X-Gm-Message-State: AOJu0YzORn0/eW+s60wLCs6rmbMyjnVQmNt4ezojas5+/1PqaiyNkHRg
	+J+fIwhb9N61bgJqSthFhTQWpmy3oSJNSrSRKKrxcBZVzTTBlWH2KWA2VhMaMj8wrv74cNbFDGU
	pGWtoCeTaU2CIMohq/jd13Z4m3jD8Ihw=
X-Gm-Gg: AeBDieszFmXBfrpm8DHscsCBJERBJv2rms5jNG7/+t3EiLUuuU8NtPZUccY9CQuHMj1
	ZiT5lpjqAngDN/Asr3v1c+IHF+IscA8QV9KUPDxWJQdWCrPNFhyp751RVF87sAfunplcFuQim/Z
	kANsOUrqcqiImsSnUs8CWwqIY59n0DVjZi31Hjv668ogJuDPgCJycnVmLqBebh0D8k0dhaCYNpe
	9rbHG3SQStuGY6RTQfBfStkvd/36Xp26nooLsgrg7O0V8e2zR15lifY94sS/ZmaNZHRVrte5KOo
	2fGmV+9SDPaQUT0SV0vOcj0qn0gfzg==
X-Received: by 2002:a05:6512:108d:b0:5a4:6dd:87 with SMTP id
 2adb3069b0e04-5a4172ca7f0mr5866475e87.2.1776826494007; Tue, 21 Apr 2026
 19:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
 <20260420082805.14844-9-kerneljasonxing@gmail.com> <aeaCzchKwsp_LWyA@devvm17672.vll0.facebook.com>
 <CAL+tcoCxQ8cU+wr7eJsMH+FPMcp+vQ4J4BdSdsVqyTRqN8q9LQ@mail.gmail.com> <aef4XHnqR2cs5U1O@devvm17672.vll0.facebook.com>
In-Reply-To: <aef4XHnqR2cs5U1O@devvm17672.vll0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 Apr 2026 10:54:16 +0800
X-Gm-Features: AQROBzDfQhIVaSKFF0sXfFlijZMZ5nryThbH6nQqDrBrxgUtb9-hDG926vitTvQ
Message-ID: <CAL+tcoArQEuVPGGKEg5f82W=Ar35PxDDCtKso_O+RTogK=LT3g@mail.gmail.com>
Subject: Re: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 6:23=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 04/21, Jason Xing wrote:
> > On Tue, Apr 21, 2026 at 3:49=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 04/20, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) vi=
a a
> > > > uintptr_t cast:
> > > >
> > > >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | =
0x1UL);
> > > >
> > > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits =
of
> > > > the descriptor address are silently dropped. In XDP_ZEROCOPY unalig=
ned
> > > > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > > > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset=
 is
> > > > lost entirely. The completion queue then returns a truncated addres=
s to
> > > > userspace, making buffer recycling impossible.
> > > >
> > > > Fix this by handling the 32-bit case directly in
> > > > xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an xsk_=
addrs
> > > > struct (the same path already used for multi-descriptor SKBs) to st=
ore
> > > > the full u64 address.
> > >
> > > Is it easier to make XSK `depends on 64BIT` to avoid dealing with tha=
t? Does
> >
> > Of course, it would be super easy. Actually the initial version looks
> > like this. One line of coder is simply enough.
> >
> > > anybody seriously run af_xdp on 32 bit systems?
> >
> > But my worry as you guess is if there exists a 32 bit system? I doubt
> > it. That's why I put some effort into adding the compatibility code to
> > cover the case. Good news is that it doesn't add any side effects of
> > the 64 bit system since they are protected under IS_ENABLED condition.
>
> If someone complains, we can follow up? af_xdp is all u64 everywhere,
> including uapi, I doubt someone is using it on 32 bit systems. We don't
> test this part on 32 bit systems on nipa either..

Great! Then it saves me some time :)

Thanks,
Jason
