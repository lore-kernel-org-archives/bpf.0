Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25F277C96
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775426437; cv=pass; b=N0Ep8ra1tOwhe76j6C5R9jNBcHi+un+9Nk89tFPy+Lk/IXmVY56SgnY3QRSytFQZyqMhaZ61z8gnpu8GbCFiGrWXzG0vfebgJQ2Pi//xkTdgZOVgfMxEjvenXfVmdGgcJkFxxJvLVEYYgdkG1+kD9QYPEpCRyQs2el70MCx+djM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775426437; c=relaxed/simple;
	bh=Ajv7iiLe04a0QyqMmbqICVVcF77wHBQNFKqr5FXfnJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orCH6OG7Fk/24qJ2hC1EucCiUGlm/Nwcl0LeuWDLjtF1BwD7CF+FMNAhlBW9uCJtt3ZaY9jicZbGE09cdoz25QEZxuGEkBw97EfNSwFmN8978ho1jIupMRImsZYxlBAkes5UhHEKL2N1FTeBoXJYxsECEIOb+1zpghEuXDMFjug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6ze3Scn; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6ze3Scn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso9663325e9.2
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 15:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775426435; cv=none;
        d=google.com; s=arc-20240605;
        b=JJDgTxsGzobeSSmMuerggq/dFus1GsMSdQMOVZU5lScVAIP8SD4pbGo7UlBZcseiVv
         sgyX/WiEDk2kYDdftoJXLgXSgIh42myQ+mwQd0W025yKztgV3cjTSFS708ukn81VIBQX
         tr1kGHDt3RNGtLkIf9LMEunXwgR8OiwaYplwqj/LtJRWwp0oqpS4sFt+au3m8kfmlMHj
         mQO3BDn0MoZWVoLDZ16k3D2OXQQ7T4HEuV7gquwgoo9tKsyItNH9CQQwJvM1uZWSyqys
         s95nXiGrWDR5zZbYr8Va+xHIvIH6kgelqIAmEeSlEycFmV2UTMTjY7AG+VwSr0i9dDyH
         PTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7xxDrpxNbce3g4n/EKsbVYMykycDV/V+JfSI5yDrvzk=;
        fh=qq13I5obe//yQcz5G1Lf0c/Ek2LxzV9nnor5EDOnDAs=;
        b=IoKuf7tTexoV4y1PfnpvBdALWtJv72V/dUhD29OxVorf+M0SNM+LZwLdlK60w1Nr5K
         7qGtClVgU4zIXrs3hrJTO7+ragNFmSiD8NI06R7CzNDy/gmfAEqvW1hEInceaZNxvk4x
         FT0Lc+sW7bg2n8lWYjDyLuANiugzZZ5zn81h/p8YRFnr1Hj2jJxGLdOUrFh66Ipops9a
         Rl22MKjAI6x5qaLjOVKlz2a9oHsz8k3oSkmd1Np2XspbmtFSOdW1psH85KQKfTPhIOst
         zaoPXyZkpWSaQIj2VYuafMT42DckV+k4b+Qy2kZaB3SluEcNQoWBx8o+H5G4htqcCGui
         7oDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775426435; x=1776031235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xxDrpxNbce3g4n/EKsbVYMykycDV/V+JfSI5yDrvzk=;
        b=L6ze3ScnjC0ZPArVdgON3IoZL6lgL05QvPxkEpUIuiAbOA7n3dKIjRgmfma/z/GCTz
         sVKUOl+T+ancVnoQ/DKiAK8ezsZc+qLP26bGF3uzzo35AYHAjWF58kFd9eh8rtXVu0IB
         zECPlDBAUiabG5tZ9S/pshQQCUIAGNQpnV+Hn8qVnAj8fktEIF6oXG9CzBif0v1rhH+t
         /unqmWBnatnIi1JdaKFPcG6LSVS1PE4QeGhugz4V+UmkPaBijBsHpnWGcVez/MkrhGs+
         0+1O+YMFCexS5jT8N3zTGoGBRkI6JAVTaGF+WMRn1mAfRbTUxnJ6oKg6wFGWx5SW+DLW
         4ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775426435; x=1776031235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xxDrpxNbce3g4n/EKsbVYMykycDV/V+JfSI5yDrvzk=;
        b=qK+4I3xbdVCtZ3YEpOXv9inFL/LCQtfp2Kofym0HfooNJEZ5Q9CgjBwObB8TNuwfN3
         GesQ4Zih6UCJlq/rfEakI1GF0QExm+/9s0UR5ZxixpmIqoKVKUW/627EorwS/4sMAeZv
         Zk0n4wZl7mdiQ8TdngwBGMaez5YqpmnoxoS+gl5shse1czxGRE6MdzC/DsNWAqT2cA3+
         49e7ojhtIRE0FYZ7iUJLV/juVtzfKHNef4RixU3WYkWYO7fWUSLISI1S+FRL7F6en+k4
         wtm4DZubKldI5Ht+cNB8d+jRsza7GNLvOqgWPrzGv13S79MUw/mOaGTlaHW28DDA4PtR
         LPLA==
X-Forwarded-Encrypted: i=1; AJvYcCX52ikGdeUlAM7+gI7+XwP1EhoJrzb0BdIhzIbooGv/IV04KQYdSsFKyojryt4VV0SHvn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhSDGKQPjulDYtmptLInMo6UyFwxCx8R7hsU6mg619ud7t6Sw
	hCdj83W5zvOSFyQFkOFMDKUTvJmMXybUEZqHaOKcdPnhQ/qEjZZGPOTZV+eDNwqZ85MgYCh5lNW
	hTzDTAc6Yl6j9eeauVzJ9Zx3kFaXV2vc=
X-Gm-Gg: AeBDiesV2GSk1mRYX0i0xDwAYhgMwN02Q8CI+uXGIFQneflBtFXoBGx46cIKaLC2x+I
	fecefSmG+ehoV6d7yCGW3qWrZrzpaqQb6BCwrLHwWttAwY/ifRTmKsF6moOoGL5t+j8L6mBRbgr
	vaQVTMYAyy4pdHKA/wR/Y6/vLlecJKr26NiXMnVzUGAA4LMmL3m1P1AezthU9X4RlYtIGRhOoeO
	DOFcrUhmwgEjJMZ4iOEzCipoHJdMf1hRo8MDroO3XgGE0+Fd/tME2Iqyr7No3AgwWicmR/ISToY
	E+Pt7crsMiYsB4r6plEurHSGt/gjAbI0DzB1vyduL1ZdHDq/D4n5YYyDe5BIk1Cu95Y=
X-Received: by 2002:a05:600c:1d1d:b0:485:3ec6:e634 with SMTP id
 5b1f17b1804b1-4889977600bmr147248085e9.15.1775426434647; Sun, 05 Apr 2026
 15:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGcL+LFNBk-+9Z5W+8Nyj1+rxCkgR=EiQiLdHW22dSKvgg@mail.gmail.com>
 <230953f5-f64d-4f58-ad2e-f3ea9358aff0@linux.dev> <CANP3RGdf0ESYZBqrhjbZjQMQzTtms61M4DBdixP09h+EG6LP_g@mail.gmail.com>
In-Reply-To: <CANP3RGdf0ESYZBqrhjbZjQMQzTtms61M4DBdixP09h+EG6LP_g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 Apr 2026 15:00:23 -0700
X-Gm-Features: AQROBzDllC2Rlyik0e1XDMo9K3pp_vo6xOlC0ZrgLNSbVZVJrc_jxG0Py0x8qu4
Message-ID: <CAADnVQLSBB4x7UsHsNSuEJEeckgiPp=idEY45ey3Lwafk7fTYw@mail.gmail.com>
Subject: Re: bpf() system call writes out of bounds of user supplied buffer
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, KP Singh <kpsingh@google.com>, 
	Neill Kapron <nkapron@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 2:46=E2=80=AFPM Maciej =C5=BBenczykowski <maze@googl=
e.com> wrote:
>
> On Mon, Apr 6, 2026 at 3:29=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
> >
> >
> >
> > On 4/3/26 4:22 PM, Maciej =C5=BBenczykowski wrote:
> > > Took a *while* to track this down, as it then results in random
> > > memory/heap/stack corruption and segfaults, but:
> > >
> > > kernel/bpf/cgroup.c -- __cgroup_bpf_query()
> > >
> > >         if (copy_to_user(&uattr->query.revision, &revision, sizeof(re=
vision)))
> > >
> > > doesn't verify this is in bounds of the uattr + length passed in from=
 userspace.
> >
> > If the uattr indeed has less than needed space, then for
> >          if (copy_to_user(&uattr->query.revision, &revision, sizeof(rev=
ision)))
> >                  return -EFAULT;
> > the kernel will return -EFAULT to user space.
> >
> > Maybe userspace didn't handle the return code properly and causing
> > user space corruption and segfaults. This shouldn't be a kernel issue.
> > Maybe I missed something?
>
> That's not how that works at all.
>
> copy_to_user() will only fail and thus EFAULT will only be returned if
> the memory area copy_to_user() is trying to copy into isn't
> owned/mapped by the user (or perhaps is read-only protected, not sure
> about this last one).
>
> Because memory is mapped in (at least) 4K pages, the memory after a
> user buffer is almost always still valid memory.  It might be unused,
> or it might be something on the stack - like a return address, or it
> might be on the heap - metadata tracking, or a different memory
> allocation perhaps entirely.

true, but Yonghong's point still stands. It's a userspace bug.
