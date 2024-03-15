Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A502DDA9
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 04:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710478607; cv=none; b=Z55g1u9r38j9lWNWoNyKV2rAwrYuNM5YOzuEEr5JzWF0Ae2yTalpHsWb1zahDnQULPLwAAkSEWVco6QaBgSihO8tIKIV9kCy/SDLzA8wxi2EklVw9TR9H1osylVFLFvKHtKE5PK9GGKPYYzquI72vQsd3S7cvygNCOEIPeOP4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710478607; c=relaxed/simple;
	bh=2rocUyWTKKK5kr0G+34181lMOM/owh61q4ew8+fVh64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8ZxIUZjXNrxIQ7zqp8LhlrpMUirl25fyHsMYNdlrirj6KI0B//6o/TjH/+ZyFYXTRRvUSWS3nRozYSxzISJ4t3XmS5wdNHH0BVvni4Pfn7U3kJIFyVCiq8O6wXI/ijmthZRqkm3y4yC31HYRCv+dH0HMYzm3ot8AMsY0krxtPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbRYKBqp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbRYKBqp"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dddbe47ac1so13670165ad.1
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 21:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710478605; x=1711083405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EdRIFJNA4qPSWVh3dlm4Ipu0Sr9tno+9r2KvgGHdjk=;
        b=bbRYKBqp3XqBX7GxonWJ8/q14gdI9PWJzgj0GIMca83nZTfTezY9ahH656lNuiuHyE
         d+b2k6RtbnLsGoeCWPOVcK5dwKcoRc+LjvfRc40dEglPx8Ovdph9k57vVBLdVwzIB94Q
         Hc/3mxJrM8mNO4Kts3Nog6SxpR7OoDTsrSo+QpmNJ00AvXCfy0zBhI+w4G/deFWWYQp2
         LQ4nVqwBrvmtee6PociRtPQvyTlBrEIgozeCpy2B2sAkXIluIOddziY4o8VE2qO3Vzir
         ctWLCT/1+SK9YgP6FyOXV51i+43bopcJdxAs/Vh7Pwbo+GM2WI+W28AoNvmBzuh3dfWc
         38Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710478605; x=1711083405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EdRIFJNA4qPSWVh3dlm4Ipu0Sr9tno+9r2KvgGHdjk=;
        b=SxuDKD9kRFz1lhF71R0vK9Xm8NCtZlVkil1sme27M+41MnVd1R5Bdyy8PEZfjR5+23
         IXKGI3+Ck9l527YPDuggAjjtBRDTbnnOpuPIldqY25wIf9bjVhcimkRQukTK6Ruziptp
         oOm2j6nlVWfO4mZF5uKHTueJx9pMpQgfpb2MDYwtecFrlCQFdlg7Kam+K73RQuRHIHoD
         HADSPB65MAjVNM7UTICi45DGxEdKROHTapaVPm7nhOWJ4iOQD/6jY0s4U+Fppx3W+/ws
         CfvCfN51FNCfVTGkrVIYRE/b7KbmgGAm7n2Y+tUpZVHe3h69agJYh1py5ZQsMwJObpR1
         Gz6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4uLqRFQuTsA3YFafSTab6Nc3EA+Vl/IAIBjaXuEYdHKhypp14qLMrT9/dOPh2qzeF5RA6BVpGPzeKeMZKxaYV9rfx
X-Gm-Message-State: AOJu0YxNpCP61XGHHacm7bwkB7EyDqD2lNfIYFHjyGmtMqa+nyAd6Sp0
	wDxcCB9rsfoBzRkTsW8XlpHNz2IyQBJGInXtXLu+ANNqJoRnq3AKPm9Web491+Jo1lgl19wGg/h
	NzwJ3KpZ9pmCNRUb9RH6EHH0B2QjQ0oo+
X-Google-Smtp-Source: AGHT+IGHLUijRGtb1xyIBlFq86EZ/QHwHLHrq3xJj9tFay28rWOWD6KdJibMK7B2OQHEWAmC7B/GCrw85hHRd5pzimY=
X-Received: by 2002:a17:90a:e601:b0:29d:e2dc:bf5d with SMTP id
 j1-20020a17090ae60100b0029de2dcbf5dmr3792879pjy.16.1710478604849; Thu, 14 Mar
 2024 21:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312222303.2305873-1-andrii@kernel.org> <CAADnVQLBciwQ22GE1z6Sf-r+V8JRDfMjMVQWburR_pPgLj9XZA@mail.gmail.com>
 <CAEf4BzYwpFh9LTHW2s9G=mgyKcPZO9Knu_EYrgwPb1h=SByuXg@mail.gmail.com> <CAADnVQLaAP-aw9KAe1cvsYOTxf7=_SB0qNdbZv-cGb83pxUyuQ@mail.gmail.com>
In-Reply-To: <CAADnVQLaAP-aw9KAe1cvsYOTxf7=_SB0qNdbZv-cGb83pxUyuQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Mar 2024 21:56:32 -0700
Message-ID: <CAEf4BzZ6vHCdQZLx5rWfoq-7ixKX5OhUAT1Sf47v=5xsMTFikw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: scale benchmark counting by using
 per-CPU counters
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 14, 2024 at 8:56=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Mar 14, 2024 at 7:33=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Mar 12, 2024 at 3:23=E2=80=AFPM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> > > >
> > > >
> > > >  static void trigger_base_measure(struct bench_res *res)
> > > >  {
> > > > -       res->hits =3D atomic_swap(&base_hits.value, 0);
> > > > +       res->hits =3D sum_counters(base_hits);
> > > >  }
> > > >
> > > >  static void *trigger_producer(void *input)
> > > > @@ -42,7 +72,7 @@ static void *trigger_producer(void *input)
> > > >
> > > >  static void trigger_measure(struct bench_res *res)
> > > >  {
> > > > -       res->hits =3D atomic_swap(&ctx.skel->bss->hits, 0);
> > > > +       res->hits =3D sum_counters(ctx.skel->bss->hits);
> > > >  }
> > >
> > > It was zeroing counters before.
> > > Do you need to zero them now?
> > >
> >
> > sum_counters() does zero them out, it does the same atomic_swap(0).
>
> I simply missed the swap in there.
> Could you rename it to sum_and_zero_counters() or
> something, so it's obvious?
> A helper that says 'sum_counters' isn't expected to have such side effect=
s.

Yep, sure. I should have called it sum_and_reset_counters(). BTW, I
have since added another set of benchmarks to measure fentry/fexit and
kprobe/kretprobe throughput, but this time minimizing the amount of
syscalls. I'll bundle both together and send them as v2. This new
benchmark would definitely be bottlenecked on counting, so it depends
on these distributed counters for better counting.
