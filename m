Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF44218BA
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518588; cv=pass; b=UzT8uoMMVEl/CqIXHN83zfSs9RKnbYC+ZnSxWwB+G6+qENSSwijCISz7Y5OYyyaXwO3dQFuykqfhWX9Edp5gI4OzVUxC47DKczC/5uEhWQA9GevFZxkq5AvDuZ16z0CS8v2NybuKGvygE//yQliFJNMpgtRLmAKMXZfBQ0J6Vkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518588; c=relaxed/simple;
	bh=EIRtWQzGXXHZ8qZiB8cXYpRodTfsTbrOzIV44XAbX5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bk6TuHZjU0Ae+0/uuaC0aBbWUPyjoB3iVQ0hrQ1VsT5x5q6OrwatNP2tlr29/A5i6hjdraHsZg0s6GL5YzAFGA/ibyUdLa2MuK/F9Pq9mYZZbaTrsCYqWqpqA7Q9Z2TY3hQQZ7TKd+2E+FDH+J277hPTZ9T7h/3pHPq5zjbSoeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpjiwuxS; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpjiwuxS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b4583f0a1aso29162435ad.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778518586; cv=none;
        d=google.com; s=arc-20240605;
        b=hypNMT+LvaR7a7hjcb4AaX9xK6fUK+sn+IH1JbtotLWMgCn6Czgb0j7Mh/dQ3uuehB
         Qv6hyfR6zQurb+elDz3Bh8eBmwCKEGY8fDaC2fFsxODmFAtPHqlH2rtPxnmiI02UtrUc
         z3zzFfUP4qRJ/da5OIKXRw9HHlo5vjWoCFEygeJSqyHOtgy8sFd46V7nipbNqQ2HQnt4
         tALsOSr0nbaabqxstHrTPE6t1NojA8K9cOUqlrgI/8SzLOzmQfWaH0le2SiPYZt9CGXV
         nv6OdWaWJsN5S0kN2jmLcUbjVP909fphM1nUyT5zmZSwSxN2Tt160QvRzFX28/9lMIG0
         zLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0CvEziVo2wtfpfqqcjJyEXvbgqMPtrtrISbGQRY7AY=;
        fh=UQBI7b4jboy/EgkC7umXsZcGzgc/inC1igvr4DPS5JY=;
        b=C594YvDq/SZMgkfeRAlAdHPujZLdQniPZdMwCawJqzFuA/5mJyghReupT0wWBA6gMz
         dR+bIAoWcUDhstaC+Haqfg+hE5CjpvfldIo0V85LgGFFbXMlNhdXs0BVNf83rS5Hryk7
         Q6mfIkkgr3QHqmmgrFnNmJBPb6kUhCCVjGmSwPE1ddMpjS6TkFWJIjQY0dyYuEzVdMlC
         4R3q2mUz/CV+OD7hcIb2ECSz5hOUVs9NNRhwsJCQXbZRpc38cnDzr6l5QZ8FPZw4SdjD
         nr5UAYZ5cQHgp7LnMmNk+QUBjCj3zV0/1lQNd0TnJY2mKiNOwp3arqaDAlhZfe627P0q
         nVsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518586; x=1779123386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0CvEziVo2wtfpfqqcjJyEXvbgqMPtrtrISbGQRY7AY=;
        b=DpjiwuxS+ljDNpIaTdrC8/Qjr4gdOoikid0c6ZlHv9JEkMOd3JIJaNOHIw5B2Shv9R
         ZTqjUkHJubNAs71KM5sHUJ8mtXF5nLC6Am4vdMLPYEK5i0w0qUl7A+xzXxGhzM77XLG0
         Y7iMpG5OGIM8dJe30Ym2gKwEQTdWqDypEW6xdf1x6BGUnzHSBnwtWu/CwXASUS6shuwr
         H5Q/2f/BIdZekcC/Nk0YwWzcXLnKrXy+JfD6N72PzKzuEkESSHdFo/VtIDFGd+lOdsXv
         /ZtzCFwotn8A41g5vXhbnRDWS05p19J5jaDDF+ri1rWk3fD2J7GSHG+cT4ALndCBvuIa
         +omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518586; x=1779123386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0CvEziVo2wtfpfqqcjJyEXvbgqMPtrtrISbGQRY7AY=;
        b=Z273HAXfc6hZpBsTpKr9+zhnCLsAyMr2EbAUOKA2okx7FMosOvxG1dPDOxkNkurs5H
         +3A7KhqAr3sP5QrAgmv0k6UzEiPS5yaaZKbcInHyzhFv0LXHyFOJNAorvh6Oz+A74wH+
         uzIrATUvDqGfuJNH/lsxZXM/eOho602Vj0m/Q7qsABHAm9SIbKvf2Xy+0nOnyh/7MASD
         oEenhlGeedGjwEBURvb1/DjYy37Xvct8suAwdFpxG2WziCaE+Te5nT1cUvB3Oa8pq8Wj
         a/LoGpM+ewkTByAqgPledcOx+qCD1M3UC6+YQlZaLw1Hea3tnm6IJb5dNAN8fa6Qd2Tu
         PIRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gZ5VFd6vgqqQSRBKTETPRKrfL/bEnC3GRoB4hnKIeNaltb1J+7pa7xheWid9gUa/OY/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgeL40hFIVaZ/HR5402hcRgCavvGmrCKdnkWST+CxTUCqZO/i
	JSL/t76yFQ94ybXvZdg/XjD8VvcoihY9r2pPrAD4RD7DwmJ2SwjelBqUZMHPXqx9K3HfRXK6c/s
	fWSn8ORDEYjBsqfxDuT+lbLP9G5vBgM4=
X-Gm-Gg: Acq92OF6x5jk7wZI2SFH3ioapoBWf5aTaXQovTTG8l8S5UMHFtjSV373bx8AOGEZ5Kl
	hxTXVUZjArEKau0MIAH7F0wUoJoUSz72zlG4pcPJPnFYqi5mTAiFiFUZN1Xl1256Z3IZEnSz7Bj
	FShEhwPa5y30b27g4uZguwk4fzM6QV5u5cf8ly8BPEYANZ7jvs+LaYBQ5kCNZuj0bE9dAHAbOv7
	kZ9DhWlsuutUw4eaTIOSnKXYIP+NReagIoLjzwTzJC2B02Bcc1Vyaw3iekyNV52Qx3ZxPTQSilD
	2kpDnlxIsOE+xShKoPEG1VKRDkEccmBt7A==
X-Received: by 2002:a17:902:e54d:b0:2b2:5857:583e with SMTP id
 d9443c01a7336-2bc7ac400d7mr112472675ad.31.1778518585881; Mon, 11 May 2026
 09:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-1-andrii@kernel.org> <agHreV1m7MRKUtbh@redhat.com>
In-Reply-To: <agHreV1m7MRKUtbh@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 May 2026 18:56:13 +0200
X-Gm-Features: AVHnY4IdO7unJN91UoR5H_CqGoMmaWgoA533Lznx8M5T4GehEiGBvA85JRGPrqQ
Message-ID: <CAEf4BzZSSsUKGje1mOTOxrRxGfw4sVfyVmKrono1rOdDq1iFHQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5 optimization
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, jolsa@kernel.org, peterz@infradead.org, 
	mingo@kernel.org, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 7:45=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 05/08, Andrii Nakryiko wrote:
> >
> > +static bool resolve_uprobe_addr(unsigned long ip, unsigned long *probe=
_addr)
> >  {
> > -     struct vm_area_struct *vma =3D vma_lookup(current->mm, ip);
> > +     struct uprobes_state *state =3D &current->mm->uprobes_state;
>
> it seems that there is a problem, with or without this change...
>
> Lets forget about this patch for the moment, I am still trying to underst=
and it.
>
> What if register_for_each_vma() calls install_breakpoint(vma) and
> vma->mm !=3D current->mm ?
>
> In this case install_breakpoint() path will call __is_optimized() and the=
n
> __in_uprobe_trampoline() which does vma_lookup(current->mm). This looks
> obviously wrong ?
>
> And unless I am totally confused, this patch "inherits" the problem...
>
> No?
>

Yes, sashiko called this out as well. I'm going to pass mm explicitly
into is_optimized and all the way to resolve_uprobe_addr(), easy fix.

But we should have a stand-alone easily backportable fix for this even
without my changes, yes. I can add it as pre-patch or send separately.

> Oleg.
>
