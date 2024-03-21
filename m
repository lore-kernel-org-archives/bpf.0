Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E212C522
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037114; cv=none; b=JqlMp778wobr0zEG177QpOdAn0W2Sdxk1iI2AxJPmwXm9CaySqm11TPIsPHQu2zb59hJGaqPzxt2A1di1IPXvh2ALeG++mU+A6cbopyTQ4wCaFsH1dB+Cn0Qdod6x9g/OzxIvzAj0SSHorS2m07+9crjsZ8WriKYRPu2zr7xZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037114; c=relaxed/simple;
	bh=uRR3RhIWHht6XQ82nfDI9DQbPLbN4KIgQkGSxand+i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYtdcmm3OHGzPwYAD/8Vh9u1a8P2i2XfSn14ujA8frgsCEBLU4Zjz9AFuw0dBvhnc9lRtSV1vD+Wtu0faieK31J9/gHlaxswTpfTXEqT00Ey2LlBQDYTUh6eSDpIJSnmVrivFp5sltQRYG/tQ3jLHVmQf+pnTekr+A+1IKX7Q2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOLyraXy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOLyraXy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29fb7e52731so884824a91.2
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711037112; x=1711641912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fU/qMDwLiZG3bvaLCSz+2WeUqNExRwnLkwbVkQz0uQ=;
        b=FOLyraXy1fhHlmxHi5+BZCEJdD+E4j5rNarRVfaZKlM0LG5wuYW4f0VVClOB08/vbL
         EGYtEYSUyAfBNzTqkOYI49GikorIt/vWZO1so13QmCfhvV+f6U70r29+XZu0RJV3J0g8
         YnSdquR2kAMEcJpAwTNi8CxucJR9ZIXu5qIN756dKMenSYvBDz+bG38vy+kMmr2LAM+P
         8o4dQSsZkS7d/IiqmmXij4SrRMKt6Vd9x+ik30ABWbnoji3VlEU3bJHJOlJOkdfoEHYm
         r5YGCuR+9TBpwxThFdnrESDhRUtGmdRUyOtTMJ++3Fqt7Sl6RoH/egR66ydJvjuytTH3
         MZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037112; x=1711641912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fU/qMDwLiZG3bvaLCSz+2WeUqNExRwnLkwbVkQz0uQ=;
        b=n3Mu7pQsNTynhDKJaWGF6/A2YqIJPrNtMnnbgpY6wDkqF4hHGOSXGOdb9m7VgF/LTl
         hQwjyapCpZ9qexnhpowyGoQYybYtwHuELzsrVew5TY/N27VaKaHvOQshrJqh4981bqRo
         kSPv9TRhiQBnrKwB34Iuo629vdmFuXbUfcpDoS8Au7K7q5iVGaJsCNhh9nWB0mVAEbLw
         S9I1wBt43F1FSg+yXkn3qe+AzZiHbOD/HLDHROaN0mG9YCTLIZR9E8HXitw5XyXIVI1S
         yNT8G6SsW2uPQaTEMi40WUy6TSa/hg/J1ht5Tr+6Rgv+aUDktoS4QhkmxaClr1Hw0gsa
         CH7g==
X-Forwarded-Encrypted: i=1; AJvYcCV07E9Vjo36DC9++hdwYQ0HMeCo748f4wW6WDXCacDxa8S81zDjJgx28Im8ivMQ2N9emqJc0dJNTjgnTkDgPgsWDW10
X-Gm-Message-State: AOJu0YwcEWo2XoK33OEuNUT1mt9a4sskaMAGCmLXt7nwpPLqXXCiXnPY
	VHhp5auBodxoeETJ2WLhaKMOt+3YHVQ9xPnkdukPjFtR1c1p2u54Dv/DVyoV9+lytq8Ono9nySb
	ecqm9/B/QhGRX7pvS134fYVs3DTs=
X-Google-Smtp-Source: AGHT+IELaFS5DAP3nCCN2XLSxp2/BPB2biv603xs+shnI3s12g/aguG235kMQJNTtJQYP7Tz3AwCIXuIvzBULAd3las=
X-Received: by 2002:a17:90a:cb0a:b0:29b:2d64:68e5 with SMTP id
 z10-20020a17090acb0a00b0029b2d6468e5mr9827945pjt.31.1711037111750; Thu, 21
 Mar 2024 09:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320200610.2556049-1-andrii@kernel.org> <CAADnVQK6v47nqE+0BGGFXFp+_5_Tbj23=H24yDJJo+MihQJYdg@mail.gmail.com>
 <CAADnVQLCJRkBPejM3o_D5j6OjGmrqS53f_F5f3OsaykMJi+LFg@mail.gmail.com>
In-Reply-To: <CAADnVQLCJRkBPejM3o_D5j6OjGmrqS53f_F5f3OsaykMJi+LFg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 09:04:59 -0700
Message-ID: <CAEf4BzZGWRTC138TAgPxYfM6iQu1-AEcEC3MpSmoynnct-+onw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: mark kprobe_multi_link_prog_run as always
 inlined function
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 20, 2024 at 11:55=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Mar 20, 2024 at 1:06=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > Dump of assembler code for function kprobe_multi_link_exit_handler:
> > >    0xffffffff8122f1e0 <+0>:     add    $0xffffffffffffffc0,%rdi
> > >    0xffffffff8122f1e4 <+4>:     mov    %rcx,%rdx
> > >    0xffffffff8122f1e7 <+7>:     jmp    0xffffffff81230080 <kprobe_mul=
ti_link_prog_run>
> > >
> > > This means that when trying to capture LBR that traces all indirect b=
ranches
> > > we are wasting an entry just to record that kprobe_multi_link_exit_ha=
ndler
> > > called/jumped into kprobe_multi_link_prog_run.
> >
> > I don't follow.
> > If LBR was configured to trace indirect branches then this direct jmp
> > shouldn't be recorded.
> > If LBR is capturing stack frames (those should be call/ret instructions=
)
> > then this jmp also won't be recorded.
> > If LBR is actually capturing all indirect, direct and conditional
> > jmps, and calls then saving an entry won't make a difference.

I was imprecise with my wording, sorry. It's not "indirect branches",
it's any change of linear execution of code. So any jump (conditional
or not) and any call add LBR record, as you mention in this case.

This is the --lbr=3Dany option in retsnoop, which is used to "look" into
the last function that fails to see which condition (out of many)
caused an error. Very sensitive but extremely useful mode, so
minimizing the amount of wasted LBR records is very important.

Not sure why you are saying it won't make any difference? I'm working
on some other changes to eliminate a few more calls/jmps/branches. It
all adds up.


> >
> > Maybe it's an LBR configuration issue on the retsnoop side?
>
> furthermore.
> This 'jmp kprobe_multi_link_prog_run' is not any different than
> "goto" in C code and other unconditional jmp-s within functions.
> Something doesn't add up that this particular jmp stands out
> from other similar jmps before and after. From cpu pov
> the tail call jmp is the same as jmp within a function.
