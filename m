Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937B152DE8
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168063; cv=none; b=FL0/Z3LuiMAlT0AB8Hj+sxuhDrTfPiA0/5t/m9bmqGlQw9khX3b2LNp06PwOZvppaKZRdMYqNEZsrSLzU3on4xAd/kslzzFq9Us8qZUQ9LSpiuZo5BPTS0utRWlLOkMt/ZgrUWVNkmQdWsjFtjCpEIlJ5sGqvDSpCvVPFRsJh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168063; c=relaxed/simple;
	bh=upaqSdVcVS679ouGxNomw5QnWepowZp7MDSv1IZgkJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJuBPcBizB++RKUX9LZliqSz8Yikg4hqrVtTU9WERkXQ1+8uISHKfsCMpMCq1RI2EmXyXrL4+w7oLHs1d0hnesGVHGkJ016gx/pC8gx8snyhDTHxQbs15vFxZ/tM/HwG+M2YKpL+8UlSaOuxsxNyTaAIS4lAzGE17gy5V4aPMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR9b4Rfj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR9b4Rfj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41624fe40b2so1110195e9.1
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712168060; x=1712772860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/EDEJLM4NywAdaEzLThrdNCPCKbyQv/M+95Unv9u8I=;
        b=eR9b4RfjlM1iZnxtAoiFzqe5bpB7wSa3akLqG/SQTy1Qt8z850IF5XCMsANf7uUhKK
         /4eqhQUm84gtZW75wHIlLv1MVrmEHwAFJCW6eJFXK2+dlw7hZEm/8fLvBD9UuNCHGr3W
         ydlhigyYeE0iEnthgJZTl8WISV5CFJCyltXhzd4jO/GtlhlvM09/UOT0a7aKcwc+J88P
         X09qKya9U860dqJaRak+scIdhFnJlW359x/imNsQk2fUAFUzRlCaLxIQHG6UW9/Kiaql
         mnZYRF+zZPYFpaMZ/0VkynUsTOMv93aKK0eG64P0BE2yvg/PuGoZqx0kILq3HMPNyhYz
         FWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168060; x=1712772860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/EDEJLM4NywAdaEzLThrdNCPCKbyQv/M+95Unv9u8I=;
        b=Kejagn2+TqLnQg+Yzhn54dpuMRcLrwW9/Om0HwCujrGu5OXXFJPupG2cWxjImvY4eO
         C3h9T+zy3GMUaK8W9O3T8/SfC0NrN4L9yZiq5IkCBfFMcC17iw6zqBotm0IEm2Q3/KTu
         IC+R2TaddXIbS+R+eeY7zsVmi8knMe9bzd2wZtHqEqo06+2u5pgtMJ9ef/DrBreMMogD
         AfBl+F6MHzMgRW3wYnpR5jWu1Dg/5xi6O+I+2WncSOrSBwwNp9VK+MIfxDAnq6lDlTmA
         o9E/huMhrBul8KWlmL/isVoFGKB0zq58yYKd+vHvEFP+xeTEFv26lwHo1Mhayp8qEWpQ
         NmBg==
X-Forwarded-Encrypted: i=1; AJvYcCV3ECh84yLOUZAuraHbAIVn5snWPApMPBM4th1lJHf+5/tuZMIbC0nVtLjvfWH2BPjQIARvf6AaLkWiGN7c+s2AMMLa
X-Gm-Message-State: AOJu0Ywusl8Z73Fh7nnGZm6MjQT/AA7Z4GkgHqHP2HVzWzy9WWslSflt
	UXaEUSFjR7FWa+r87bPEJVbdEQSnulto6gN6eZwf8Jf/UgCO8Ij6ZewEC05dsC2OFXwMBy3QUta
	1yBWa8VTnLNx513gBXR/IFhxZdaM=
X-Google-Smtp-Source: AGHT+IF7UafD0dgyBmC2TI6SRvVQk0Rbx+pqAg72CVtK+2aib8rYRPqWkgMGXlYZnYZEY4fHb8dabTtHd5ZxiNNEcIY=
X-Received: by 2002:a7b:cbd1:0:b0:414:9538:7da7 with SMTP id
 n17-20020a7bcbd1000000b0041495387da7mr344643wmi.23.1712168060311; Wed, 03 Apr
 2024 11:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org> <CAADnVQLDBhypHuyS4UXnsMYGP7xCLWGBB9jdXuiqG+ddoX95Mw@mail.gmail.com>
 <CAEf4BzZdJnR+crpz2QWODPOxi3VHazyBAY7EH-EyL_fQgNXA1g@mail.gmail.com>
In-Reply-To: <CAEf4BzZdJnR+crpz2QWODPOxi3VHazyBAY7EH-EyL_fQgNXA1g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Apr 2024 11:14:09 -0700
Message-ID: <CAADnVQKXkk1sQSG7VSXK9Ya6sTK4RVzZQW0eK9j0rNtchbGBYA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:04=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 3, 2024 at 10:41=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 1, 2024 at 7:13=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > Add a new BPF instruction for resolving per-CPU memory addresses.
> > >
> > > New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, wi=
th
> > > insns->off set to BPF_ADDR_PERCPU (=3D=3D -1). It resolves provided p=
er-CPU offset
> > > to an absolute address where per-CPU data resides for "this" CPU.
> >
> > Fixed the typo s/BPF_DW/BPF_X/ while applying.
>
> Oops, thanks!
>
> >
> > I'm still a bit worried that there is no BUILD_BUG_ON
>
> BUILD_BUG_ON is problematic, because those gen_lookup callbacks are
> compiled on 32-bit arches just fine (just not used). I'm totally fine
> adding extra checks as a follow up. Let's just agree on some
> consistent approach her?
>
> See [0] for the verifier check I mentioned. I can
>
> a) add #ifdef guards around all current gen_lookup callbacks to only
> build them on 64-bit arches
>
> or
>
> b) add runtime checks inside get_lookup to return -EOPNOTSUPP if
> architecture isn't 64-bit.
>
> I don't particularly care which one, I care that it's done for all
> callbacks if we are doing this. Please let me know your preference.
>
>   [0] https://github.com/torvalds/linux/blob/master/kernel/bpf/verifier.c=
#L19942-L19946

Ahh. BITS_PER_LONG =3D=3D 64 check is for a different reason,
but that works. It won't be lifted any time soon,
so not worried any more about that assumption inside gen_lookup.
Let's keep things as-is.
