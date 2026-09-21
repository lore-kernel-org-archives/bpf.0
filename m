Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1733BB119
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020457; cv=pass; b=glTDE/dJBlWOvVY3hLUaBAvDk5cv46jdErzvKYcIQ33QsvfHds9N5btB7odzHvAyXa11UiIOGNi2NOBs7Mc6C8/h1zWka6xN5PesbEY+c7C7Ulc7ti1w+5mhIbEO8lsIdZkDpQR897Albo6mAyRgJYS/ua6eg+gg4+doI5GJmoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020457; c=relaxed/simple;
	bh=+K0x7Oa0SLCPC9/TMd/49GdUdR/oPlDXAf+dxWf8XbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ttx2pgPvt6yM5oJ0UrZRZOZDxru/ju9s1UmB0E7CliQ8vYxdZKte978gpOlHo9f0q4e4I7Y/lbtblHFFGQwJwiZl7jZ6qJ0KG4Ocav8HhMtCB9ngR3D5IoA/w1v4u+sjBtus2pqw28xvAa2YgyTI/NhKw7V02uB8GZEKe5XZ8yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV+Hzsxp; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV+Hzsxp"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60590a85cso6420214a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 12:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790020454; cv=none;
        d=google.com; s=arc-20260327;
        b=laXo0fWqxKBmRF1NYRP29w42RAYq8tRI83cu3U5MICW4rxP+D2YZsLTCILzTQCodSl
         FSFz32ufRxvUTfDcygCxKHrfK5w7KNI4N0rNmBLJIBkmJXGYcaoX0mDMpj04ceiOyMz1
         R7GUoh3QkT3aJEBNG3m5BcvIn7xr8pcltfsaCPMjGWwB1rioovhMdaQaAEvH1fQVtPCL
         4u7XNJ1wzlrqpv4RQzoAQrjjuCXLE/37lACmHAcekQA0ewJserFNunoyDNUlEyREwVBZ
         ooEGmC2/PDDrpY5jR1mBW3MdYsnSjDbVCzCWiQHdwIqiimauqMicVGrY3QlzpNvdb5IE
         KWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jcLPg4sxIMnPVu9DYBY2crfmwfHr/m7CBHhYvP1Mzt8=;
        fh=dZIwNpALj6cHjG+3IuvzXyjvjoJG0KO0vRIxGeoyGhs=;
        b=ELngknTeBdUHAfU6iJ3BzZYPBQYsapawQlqv6kDtYr4Yt+vdE4uUxhqT1wj1TM7rc9
         eCIK/8JLU17kWNRG+zTH/SZgm4DnCMvLgn+dBDjU/gbUostjyOWxEYd9YaqoLAexl3Ig
         1XwGnCDcr4XrvxNK7zSye1GJ8D+Df8snXlIf3A3rLTW1YLC1xoXQxp/Yp6whZ9EMnLoY
         lou3DpngTvK8w2r5ZOeaog+u1iJ6JxSYZS7NB6dw/7ytjqT4kH14gM59CiOk7Le7eDHQ
         ZinNOEySflWcfwVF43T3BQAz4khKR0K2Lc3ndVB6g6wsedEG9ZCQSPknmJrZaW5ooxmr
         14BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790020454; x=1790625254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jcLPg4sxIMnPVu9DYBY2crfmwfHr/m7CBHhYvP1Mzt8=;
        b=bV+Hzsxp8aJpIjHUvEz/4JSdqYpl+Oen5Dzn+8rjtxhIwX6uQEwACdmarrIsm0iOGE
         ICsrUhONONoC1ldzQr56MaJRafTmWm5FQEr0yDaH1mxR0s97H3WzYYkXBDvkx0PaMkzX
         Mqxv9Td4nnX/clgV07Egt4TqedpdzyURLjjp6srrgBoOtrVbVdGVZPUJ5G93EkLzsL/s
         WH5YGB3xOzy7M8qs51zQVZ9upZXizEjBtCcR18be8LLDmtenBSwPT+fHF/hmMpH/noy8
         xgeFOLnyKi6H4wwt8P7aT6K/nxDIC4LPoKnMmJaHYqtn7S7lnfD1zD+nWFmU3/j1RYh5
         QKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020454; x=1790625254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jcLPg4sxIMnPVu9DYBY2crfmwfHr/m7CBHhYvP1Mzt8=;
        b=nD4l44Q4l2jGy3U5l3ytOs2m4EfLNd/bykvxxd+94yMgoiKqGsJUnW8Pnc60BquvJY
         9NucWwIxtGau2Qw8bo+p0DUgT+ix+kR681ywpUcX07AeS6XXzsSClA0TmcVSdT0Mzol7
         iO/9x/rNAgf0o3C0nIFvqc8qt24m3r390ww+b+q99tVoK/WREfxpvuWEijJc7TLIIGzY
         DcfKTGlVoqo5ofOco5yl+3Kc3XIYHgR/VNLRsEmiaZV2i0X9B0JBdTd5vlzG6kjL+zVn
         ATgEkAs5y5tMEb/JuVU+5ysUwK3mBC2FOJ4D6vKnfWE9Ras0R7XyTOyyxYs0xflvieWL
         s1kA==
X-Forwarded-Encrypted: i=1; AKwUvBz5Zz/+HTLMoLTaFY85MyjSwy1VCUW6ncSHiCTzRYy2vB/VWVcxJ3G8dptxwYm9LHZM1to=@vger.kernel.org
X-Gm-Message-State: AFuF++m+PtRsrauN30iK/WgHMdty4JDfv1jkYn08t2wZmySCn2B0X1wZ
	tdS5SkoGTZcEbiv4cjae7EjWPwAnCOAJ9Cuau2tYcLxJJbtefs0iuGQbDStSTTXfe2fz+yR/Max
	12zfxLs42eNpkq9dWnJdj+o560lyumUu8f/VMMhMppx+e
X-Gm-Gg: AYBFou1eEfW+R5psYDSmSsYNz3qIO3cmW2jkS2N6dQM3txW6hCrOjm8L794TG+wNmW8
	VHQzRmbR44FxLYojpgUyHdO31dGkcQm/KUUcn04CkuZOsDhI/bAxsUfT2dZVtvdACWBiKZGtFO7
	HJOVymB+tFf/oV04SD5xKUX4shJHI4P1gqYq9qxpBiDEFyM2xCS0yoC/qzhU8F/3FpAh+PlEPRK
	lmlH14LknBjOIU7mef8IEQGYVJWS7ODhiOxXcxJ8PhmZJ3foMsalpOP9j9tNTtsiazbOYLpUUsh
	J2Il5gKh22xww0NuRRhNpHOKlF0Z7SXooZpn42UOVRjl9hMDvvN6BBNmBj1Fa/sRacujM/Wk9Da
	b1gb5
X-Received: by 2002:a05:6402:24dc:b0:6a7:ee56:8156 with SMTP id
 4fb4d7f45d1cf-6aa579ad808mr7351821a12.36.1790020453888; Mon, 21 Sep 2026
 12:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915154248.3612028-1-puranjay@kernel.org> <20260915154248.3612028-2-puranjay@kernel.org>
 <210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com> <CANk7y0gzipiJrObW0fbh0gP2DgKeZAUvCNuvaOdJrGWgE81LkQ@mail.gmail.com>
 <ede9d515-a103-461e-8244-656af641c6c9@paulmck-laptop> <CAADnVQ+bmTPScUBfOtD8Sj9H8KjAqU2-XocFsP3G2qgNA7q_Pg@mail.gmail.com>
In-Reply-To: <CAADnVQ+bmTPScUBfOtD8Sj9H8KjAqU2-XocFsP3G2qgNA7q_Pg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 21 Sep 2026 20:53:59 +0100
X-Gm-Features: AcwNN1WnN7QHPB5f7ZzrNkV-R4PXF9XQw_TXw_WLfugdc3j3gLzzQZ6PR4IytP0
Message-ID: <CANk7y0hC6kzOct8r1cDpRnXgvvqNqpfcn9JWOnicR+JisNc6+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add bpf_call_rcu() kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 6:16=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 18, 2026 at 9:03=E2=80=AFAM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> >
> > > >
> > > > I tried to fully embed structure back when implementing bpf_task_wo=
rk,
> > > > Alexei rejected that approach, because some of the structures (irq_=
work) I used
> > > > are not in our control and might change. I think this applies here:=
 `struct rcu_head rcu`.
> > > >
> > > > Link: https://lore.kernel.org/bpf/CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6=
uNGZ3OBQh4V5Zt=3DWnQ@mail.gmail.com/
> > >
> > > I agree with your analysis. Although struct rcu_head is unlikely to
> > > change but still, I will change this to a heap allocated version wher=
e
> > > we only keep a pointer and not the structure inline.
> >
> > You can always use a union, as is done elsewhere in some cases.
> >
> > That would preserve independence from the rcu_head definition, while
> > avoiding the need for memory allocation.
>
> In most of the cases kernel internal data structures shouldn't dictate th=
e size
> of uapi struct, but in this case
> struct bpf_rcu_head {
>  __u64 __opaque[8];
> } __attribute__((aligned(8)));
> is the right trade off.
> I cannot imagine how rcu_head would grow from here.
> Two pointers is what it needs and it will stay this way tomorrow and
> years from now.
> The rcu logic needs a pointer to callback and ctx. So two pointers.
> Let's not introduce memory allocation for highly improbable rcu_head chan=
ges.

I sent v5 with minor changes and kept:
struct bpf_rcu_head {
  __u64 __opaque[8];
 } __attribute__((aligned(8)));
