Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402A3909A8
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425445; cv=pass; b=AQRTdxwWFtb+U6pKTp/PaZUgpxbm8pSfKQOJJnwHauTb/BWrE0m49aWa8xOG8z1nZfFP8Uxs0gVrDmo6yKVWL2hLfPgjkL2KqK4fG9aMlJl/eKoTLhgnIm9p8vX4UIS5V69S4x9bVuxnAsKzsghGRRM91pxBjQDXvwyX2LXxHz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425445; c=relaxed/simple;
	bh=LTosCI4MVQmESVRw/t4QUQTFgJ4QedotPsW98iUcDow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2m+4evc6mlqM9HRuiZepKbaIXSrW/fS22B+ny59HYxtnYab0RBydVzsHgyDSSxqw7ExFWo1Vbh0CfN3axI4SwxB+MRvluB3FNabK7ybjUXhVkUHZ0dx3C2XHXf7U0Wp0YLWHWmF79YkoPBKK2X5AYQ5AqT0MXOhQ4CtDwDRrGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAS/ML6C; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAS/ML6C"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-668e55bd36bso5263260a12.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 00:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774425440; cv=none;
        d=google.com; s=arc-20240605;
        b=D1zQp6VPKeUiozgpTKoHy4E4Ob2D+4wQGbAmV0hkcp3AaBgtmRGAZFZrjgybQLvVYz
         rFaO+JjgtP687KLVMJA0ig701Cr0keWskIlryODILhQaCgiPkZ7siMRG17EzDZhtDvhC
         ssZvezUCy4bayDrBV6RChJLJw1oLf5IMS/2RBOqg9nUkeDAqg74kguARxLC9WiOLBqvp
         yeon8yD7BgcbruwHl9lsao+lG5XWvlyT+4VjE+0COQMQ8G/q/1pcjOEyqmL2qoJdoqF5
         Zw5vjiLc/qKl+CMbrqCTE2CQNMKvg+ZzUyiLTvSAfPf90LUtfw/LOw/jR5pjkcrl/mlm
         LzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LTosCI4MVQmESVRw/t4QUQTFgJ4QedotPsW98iUcDow=;
        fh=MzQw727DZdU0eLzHP+Oo4eivrktVMYdhliwxrlJ0MD4=;
        b=edSAam9IOtBEbXS6VOvDb75qBHQwDIIho/heksGK3Sr39U5lnDUvhZFiqYHfYWAZGf
         twIDdfQbH/av2RKRtNVV26Pu6AxTI+W781ac6s8+TIyr1gppZMjtowSpQFQEODYgR6ac
         od3b2TPNlUt4pj/tCz0IaVJYpt5gj+5FXfc/3wbP1konL40lbfl1jHqhPQQdCCZj756V
         I33Hbd+zywMCmszr0C93mSV0dIVT7MPxXi4EDxNiVGOWHt91ksC6L19wttf+vY2lquxA
         N/eceKIUN0SIL+FPdadJeeSaBpKzWVDAfv/j9U41o2xlr7sqMhjVI2Y8CgUU0mi+3z82
         urLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774425440; x=1775030240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTosCI4MVQmESVRw/t4QUQTFgJ4QedotPsW98iUcDow=;
        b=VAS/ML6CsKbAkj6yuNjsMyepGu9dLARDr5yRGeYtiaztISvzYyB2bMXntVBc4Wz+SG
         m4wygj3lsQGa0h9J/x25U62cHKACgTkoENJ8jJ0K0KIiwFsrD0dBEScUxRxGg0AJyXD0
         pmeVgMISSjR5kX+LyW/bEpkOJ6su/ofJ1JHUIl74TS1ueytidW90NhRYFZ/hPrUfJvuu
         e8UZGeAT21DHbk7Xjsw0jlGWLpUvB4zFadofMxC27QX4hcLfgmzo9tQpre20lT2gXO6A
         PEymQXm6UqgFDJuNVvFc7Sqez6ErNPtCc8hvRGD90s33vGahruso/m7qyCdbo4viaBCs
         EKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774425440; x=1775030240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LTosCI4MVQmESVRw/t4QUQTFgJ4QedotPsW98iUcDow=;
        b=hIsbtb+EnrdSK/X6wdF9mfSW+ud0hAVfy4BkqrWfiJcnF2ielsqGAeG98b0rhe6dNd
         HsEVdkEw1nY6bJbrvHgM234uoSsoWRZGDjFe9KacIq+2qWulWvjwTK455mGEv//eCkZa
         53eNTEDJ7+v0f8E2BRNEp7jWa0+7wCiWLDSoBoZW1RrxOhkD5UmuU9w9zjjEmnHMhXoB
         68B1kYDWk6bISijz6w17m58Nb7ej+vR09Zzy/BpxWgcfiA1GiG2bLdMJP2UGb1qqw/6K
         zDUvR8uUxrTxD4JEnPiN13v2KoGe3HiFhS9MYR1IWrAwntyLoo1ycTzmCE+GzIQL8vPE
         YgVA==
X-Forwarded-Encrypted: i=1; AJvYcCXi7vIEjPJ3sINF25u0UA28Axwy1VT6CtlXs+XVW/tOOuAeLtWP4HOjnphUuTAuxPnlh0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhETx0+wgxQwcl5e/6cJEXhiQdmLsGGQwPau+5e3kb0LZiRI1U
	Y0mMEValehxmSt0rwQMdx+m0lNoxDrQQPDim9X3DzhxO09MAQmQ/g1FgVWqSZyIt+Z6tzrSExAz
	5dkdH6QNGCzkNHAf+uCaJ3rbPviwc3A==
X-Gm-Gg: ATEYQzz8mEiXynCz4mV0ovQgxNZVrv4dz30vtM3FhDTYSJhfJB2iGTeqf8xF0AXQlNw
	djkkJpmWS12mnAQzVFBthvoDJFtCj4i9LhuEturxpnPp8Vp/0v8QrC+NBgYrQd7LPz83WfCDvfg
	gnimwMvGbZlGAhkWoX4pPT7Bs/ocMAUyWl5p/cTlR9NmkrfKUWT+9tj7BMx13wMoX6qlhyMDvn2
	y16EZImyfkmz1cDalbApIMk4zU8r9AyF9gE6ooTbh6PUGFjyzZCLL34A4ObjvS8USlm1kM+mQ8U
	RbQp+yqZdlC6TJfC79S2GWpwnA==
X-Received: by 2002:a05:6402:26d6:b0:669:b5be:120f with SMTP id
 4fb4d7f45d1cf-66a82593953mr1781063a12.0.1774425439994; Wed, 25 Mar 2026
 00:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320162336.166542-1-hao.sun@inf.ethz.ch> <177436741379.1084685.742970732574986773.git-patchwork-notify@kernel.org>
 <CAM=Ch04dJEf0_1+NeO1AJOBwKhQ5hcQsionMyyxuu1h7Nmj_pg@mail.gmail.com>
 <CAADnVQKAb-igkV-7htfqMxFhui+utF24T70pbeWd4mwcXWQ4pQ@mail.gmail.com> <CAM=Ch05c5ptrNHjKHWppynU_1rfsfZsiLwK111h4phrs_u77PA@mail.gmail.com>
In-Reply-To: <CAM=Ch05c5ptrNHjKHWppynU_1rfsfZsiLwK111h4phrs_u77PA@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 25 Mar 2026 08:57:08 +0100
X-Gm-Features: AQROBzCGBJa7258_COXowKUS9hywiOP09cP0s4QN4wc4o8E8JTgwMgd4WL2cxSM
Message-ID: <CACkBjsbRMH1AJTL6Jnro_fng3XRdz7T8i5vVzXr-Afb3Apzrnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Simplify tnum_step()
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, patchwork-bot+netdevbpf@kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 10:57=E2=80=AFPM Harishankar Vishwanathan
<harishankar.vishwanathan@gmail.com> wrote:
>
> On Tue, Mar 24, 2026 at 5:36=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Mar 24, 2026 at 2:33=E2=80=AFPM Harishankar Vishwanathan
> > <harishankar.vishwanathan@gmail.com> wrote:
> > >
> > > On Tue, Mar 24, 2026 at 11:50=E2=80=AFAM <patchwork-bot+netdevbpf@ker=
nel.org> wrote:
> > > >
> > > > Hello:
> > > >
> > > > This patch was applied to bpf/bpf-next.git (master)
> > > > by Alexei Starovoitov <ast@kernel.org>:
> > >
> > > Hello, I see this was applied. Just a heads up that I still had a few
> > > concerns regarding the
> > > commit message and code style in my last reply. I think it was my
> > > mistake to include
> > > the Reviewed-by while still requesting changes.
> > >
> > > Hao, would you like to send a follow-up for those, or should I put on=
e together?
> > >
> > > Or Alexei, do you think it is okay as is? If yes, we can just leave i=
t be.
> >
> > They read like nits to me.
> > New code is definitely cleaner.
> > As a follow up better craft a targeted selftest and explain
> > your points in selftest comments.
>
> Yes they were definitely nits. Makes sense to keep the
> code clean.
>
> The logic is sound and verified, so I'm happy to leave it as-is.
> If I find the time to put together a targeted selftest down the road,
> I'll send a separate patch!

Hi Harishankar,

Thank you for reviewing the code and verifying its correctness, which
gives additional confidence.

I kept the commit message concise, as I felt it was sufficient to describe:
simplifying the problem to finding the submask and treating d=E2=80=99s mas=
k bits
as a counter that we increment by one. Once this perspective is clear,
the rest of the logic should be relatively easy to follow.

That said, please feel free to refine the message further, e.g., adding a
selftest and referencing it from the code.
