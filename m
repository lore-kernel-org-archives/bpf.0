Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB5338597
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775427698; cv=pass; b=HImvwu8WxDx7lMKsAcZnoMm+plHl9biCBmfgaBVDbYstlseWjjCXpUiPmYOP6nHZ44wG5nQt3YzxAMyQIjfYimtE0WfGN6+gTViHoxKimMSySmMhvh2g3MXnKa7tWEstGRBNX2s7S+9RwKBXdy3YfHi8pGRiRmLBlYt+51k56tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775427698; c=relaxed/simple;
	bh=QKK6EU2jEDOISbwT7YSpyAryDWnQYAx6ztBY88B55kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P64CM/7K8ngotlkmQCWQzOWYvV0T2faX2NNmGdc3LfazYWhO5uefhFxFH7iO+36h71tDk60Zun75nRT4K3AuoDgDzcjO14kmfbWdk2Od8FpbWow1hnDxrpSenqgeHMSRjyca5JmWGyHVvzsFM73IMrbuxx1HLlMBw7OlcSDtsM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VSXD5M9v; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VSXD5M9v"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d6b393d60so1050911cf.0
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 15:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775427696; cv=none;
        d=google.com; s=arc-20240605;
        b=Bapv4L96CDEaZiB5+whfCqbQipPMGY5pY7kjK5On+t6Mj7MM1Vu3uxTiQWe2qGq/Ow
         P7LfLbttzYC5PqV8WXFw+mmVxbhxzfFj6x4Cv0rk5FvOumKAcz7xqsMxN8xxkHqeoFEA
         YEGRFWErNL+/bBy+BDb6Q1T41e+BjO6iHETVi5IWF6ZsEVs8yyWXi/BfitY55Zn1WS+l
         9DCgRQZtL+lusoMoVkH5FQDFAJIUHgJrG/pgN0DlU3q/TEMHElFYLNuXmeXwKK3C6y6o
         fLNejATjSUPIkQOHq6I6tE1XMkIUvNu8qSyn7PLkGQFThpdCVWlRKbVXG/8/oVtmcJkb
         5p0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wU5c60oO9kgud17YgZ93g7RUPb33+yt1u19+FWTCl+Q=;
        fh=MGQp2A73lKa8bk3SsmZqyXxRyPYjWMKGa1xcBapRpMo=;
        b=FKGgEW6r9Rzek3AzJc/83+MFjo0MoSGIb1ayhwOLzxowqrS4sfLLgc8J7JdRCTsHEH
         6YEO4/rLh9I0MkeJaKHcpI17IlphcMfVCo1Q9DYO0tVp/AlePJveXvCckF1manXIZkrv
         kONCzsjEK6PXzDI5/gDVfO+N7MRAK2dn8Uv/Lmqa1DlguUwCrpdVQ5sdUzTx4UzLIPhp
         8yOYT1fESnaeYpNw6lF2hG999fFaOYXYAcT8FEchjDBp1HO/XMt9/xMJUYAA3m0vSB7j
         CkUhcoP3lzD6+zeCu6icJdYZoxUiQYTyyIy8WkUDsZE7F6GkdoNlNiLgmCwiNEWDeyKl
         XWog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775427696; x=1776032496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wU5c60oO9kgud17YgZ93g7RUPb33+yt1u19+FWTCl+Q=;
        b=VSXD5M9vpnlo/QbFJRKPIdqc5IJq0M7N4kw7Il+YloKDAGXXgmbUslF/pdWLk10u8e
         LNUY75u8Mkv5z3NZ9Yn9KXMgKi/TWC9zwXe64o95xxgENvle/Jbw0DH5fiagt27UuPKd
         vETukJCPTpkhZRG2J9x+9+/iNZklYtFs85fMVmLbNTKkHWkJRYideoIIsx6yc1jLk7EW
         WM1h3BCxLOEj2JtxtiCPGFDyo3GqHPE4lSy+eagogifYuWjTuPEmYIDVNyAszm4nv0kF
         b5Jzez1d/I9IJOuyiplMy8m3LT26KJdZx0X9sBTld+ZgynFHX9eTX+FmyoNpk6+s9ewX
         82Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775427696; x=1776032496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wU5c60oO9kgud17YgZ93g7RUPb33+yt1u19+FWTCl+Q=;
        b=ZNIlfCR0Q8d48UU4SX3PgJmZXevP28rS4zybmEGlkN8O8QE39GTLSc5w8MwNxRO/YH
         uTim9Lt0wfMpkKF4NtxCE1Hi7/VYknQiZ6al4BWW4lSG6qkhURrq5TIwZ1A8Y4AqOOVF
         cjVYWOHFfZavYv0tJLW9ClNmMq5SPcSv4JMHdam2ipVrLATG3yNA1ORK2ZtJ4f4HyjC4
         si/PgRY9SoRKjBzEV/jwL0Y3wd56kefkh2eqHP1wENd0nAqTt9MST/uSVDfPxsnj2c1E
         jtyrLql2Z6R+ndX5y46O0OQJ8OW2XmcaqV3ZICseyfKirGqCta2bhQ/VXyMNS8Z2MoJ/
         4iTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBoSMxZTQ5eyeycdVX80UfXqk+hfrDJU/LXfT1/XcpumyVIQ2hs57frn+0/tXbVM0ervY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybgMVlxuRfizmJaFrgStNstrb1Ll5sttRprkt9Clb+SU4MGEXF
	+RuWE5dMnpr6PliOIfN39NWc0a3N5+j+HBFRbv13Pc+ie1Zw/M6AyckFFocMV7+0mOdWamIDxn8
	Ts4I+8+ucy/agh9Ul08eL6iO7jeT+jTgtr+zYK4l1
X-Gm-Gg: AeBDietxXsAJYR/MEXYJOiwuvo1Ca7MVL7k2ZzavalQzSO1i94+F2oQHB0BxGgpyN0A
	U/H01P5FfEW/ZwXs9nve/JGE82l1cWAEiqmhEJXNqM7s1f/gfKwkB2ddNcCW3xPxVV573HT/VW6
	WdCkgir9DUDg1tIGfinVdFK834W0o4xP/5HEYJX7jXX1R3atBMCEeu+bWLsiUX6ZvNmFbdZXAh8
	TJQVFDMWPRDLWLZGQW4YMY8IRXDztlvp1etg8C7Q+c2VdQS4pPplVtoN+PUu4uI84evoTaWmWGF
	8F19Hm9f3txYtMSqNdFvOlcUqdel3GjNriz7ow==
X-Received: by 2002:ac8:59d4:0:b0:509:21ff:cd49 with SMTP id
 d75a77b69052e-50d63ea7eecmr31659121cf.4.1775427695747; Sun, 05 Apr 2026
 15:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGcL+LFNBk-+9Z5W+8Nyj1+rxCkgR=EiQiLdHW22dSKvgg@mail.gmail.com>
 <230953f5-f64d-4f58-ad2e-f3ea9358aff0@linux.dev> <CANP3RGdf0ESYZBqrhjbZjQMQzTtms61M4DBdixP09h+EG6LP_g@mail.gmail.com>
 <CAADnVQLSBB4x7UsHsNSuEJEeckgiPp=idEY45ey3Lwafk7fTYw@mail.gmail.com>
In-Reply-To: <CAADnVQLSBB4x7UsHsNSuEJEeckgiPp=idEY45ey3Lwafk7fTYw@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sun, 5 Apr 2026 15:21:23 -0700
X-Gm-Features: AQROBzBJ359OKxswxg60I4VHX2l3NskSQEva1GjFtzgID1nC_QdmjW-lpBshbn8
Message-ID: <CANP3RGfZTXM_u=E_atoomPZXutoQJ02nOMkCCR-YBZbOm2suWA@mail.gmail.com>
Subject: Re: bpf() system call writes out of bounds of user supplied buffer
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, KP Singh <kpsingh@google.com>, 
	Neill Kapron <nkapron@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 7:00=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Apr 5, 2026 at 2:46=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goo=
gle.com> wrote:
> >
> > On Mon, Apr 6, 2026 at 3:29=E2=80=AFAM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> > >
> > >
> > >
> > > On 4/3/26 4:22 PM, Maciej =C5=BBenczykowski wrote:
> > > > Took a *while* to track this down, as it then results in random
> > > > memory/heap/stack corruption and segfaults, but:
> > > >
> > > > kernel/bpf/cgroup.c -- __cgroup_bpf_query()
> > > >
> > > >         if (copy_to_user(&uattr->query.revision, &revision, sizeof(=
revision)))
> > > >
> > > > doesn't verify this is in bounds of the uattr + length passed in fr=
om userspace.
> > >
> > > If the uattr indeed has less than needed space, then for
> > >          if (copy_to_user(&uattr->query.revision, &revision, sizeof(r=
evision)))
> > >                  return -EFAULT;
> > > the kernel will return -EFAULT to user space.
> > >
> > > Maybe userspace didn't handle the return code properly and causing
> > > user space corruption and segfaults. This shouldn't be a kernel issue=
.
> > > Maybe I missed something?
> >
> > That's not how that works at all.
> >
> > copy_to_user() will only fail and thus EFAULT will only be returned if
> > the memory area copy_to_user() is trying to copy into isn't
> > owned/mapped by the user (or perhaps is read-only protected, not sure
> > about this last one).
> >
> > Because memory is mapped in (at least) 4K pages, the memory after a
> > user buffer is almost always still valid memory.  It might be unused,
> > or it might be something on the stack - like a return address, or it
> > might be on the heap - metadata tracking, or a different memory
> > allocation perhaps entirely.
>
> true, but Yonghong's point still stands. It's a userspace bug.

how?
