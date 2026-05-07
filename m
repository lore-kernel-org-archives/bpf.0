Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044983F65FB
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159969; cv=pass; b=RNJVjQL4EJYy2V39tcdzb/MdzN+KN7Hin7lB0MA0/SXpADIQtkZGaxNOKWwsmNA8ngPl+Elbpn2qgc4u6mVDb9bmiOW/RdLdVKXZjllghoEQP5CgC4bwWUY2gNFUT71D8CJ9ICO7rRmjD3I5NlpYWtXEnZHdclfperStJlgpqas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159969; c=relaxed/simple;
	bh=1F2+tW/N9SM7xS8wfCjqkfgFfUaRfsYxVVc2jH3J+AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUBNWMjFXkmFV9IztoByLgkGnJ4O+XuDfI+KaMXanFxK24bNy1b5Wvin0w/4GNC5Ux2DURLTriITLcg0kXpLquWQeOPZZXWm3RVkJn8rep0qmu0/K85yO7PKt1MKRp9Em0csRrlPS9JFwYBkxsxaFrO9C0e8LBXwHSB1A3LcN40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIAoWlF0; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIAoWlF0"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7b37d84a6b3so7640027b3.2
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 06:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778159967; cv=none;
        d=google.com; s=arc-20240605;
        b=FrmrgDcqVjippxj9ZY5FFsu+sE27oqxSayttqYFPu+B+xIslnRW8qymVlX2bvxuTll
         ovJMwiQEr+JETW1nZLvSZUKn4nE1mpQdqkLIC5zfhJXsq0yuyXu2f5YzKIKeAPZIOV7O
         gONXQoLdMu6rGOwzgJZDdbBXDgnXaghCHvNQ/NjxF4fVaFnOzqH30nDOiN/dJP5iAurH
         NP8BpsClIFKX7H4ftJgp+yMOSyxMJxEjf/VIZ4qSh9pLTVvmQkP/id0y1cqRRQkRhUL3
         vB4ZMRucc6pWlIeBiW3HtNyjOPcNn0AHYfVhyzpPOuO4/easU6nX8Ccp+pkK+4KmRDus
         rpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJsNWGNnboxuwp5GaleyBNu7wVTMMyud/VuzWCCNevo=;
        fh=C9cUJVDXM2vMBWxDNvPaOJa0fxo4thp2O2GpWUH7MA0=;
        b=g6wNFlCr/CN5MxRF4/h1YoRgVHNVD39R91jlTxOlaDmJY0lYFypQa3G7Rnb0iVRusw
         2r+jl7FjgC4Mm2i7zKCVss0ajVnkKYrf3xmSz+KUg/ZMpJjWCuGVldgbnbArbv886lwt
         898g3Jos0gWjRDP4E0Cp/8uNblGn3Rs5VY77LsPvCSwpV22KXDST5PxrN0xvqTPgTK8A
         uHr2/qNLorobT+cIsnqDxe8ntpgchP6hudW2px6wkZJY1cSOZHU4OUovnULOC0czPlNh
         Clw4kkiIE3ObHw1lBMFfsKJkm6uxqJQLmBut7A8kwM4t8EaP1hooildNQZmtAK02L7+p
         9GhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778159967; x=1778764767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJsNWGNnboxuwp5GaleyBNu7wVTMMyud/VuzWCCNevo=;
        b=nIAoWlF0QAnkrmo+DbQuRx2v2fjPTRzX9f8t4+v8oTP8BbOAE7IFW9WHNi957d1xwv
         4Q4Ik34I3B3FWY+Cgf/O8eiHbVfS9378YZq4Q7OrjWtOtZSNHrTeBX2zyedzvqvTTUNe
         rBHnjQS6jBRWe4gmZbHgtuFJTu68GXZ+n8rctyxKqK6MlL7BJp9Co9rbh6+OsEpfgJp2
         gHfqhxHqbpZ5VaWhENFZDFRos1m5pECJcCPjItAN6OHE4Mc0JvHZeedxFFv7ORpZuz+f
         mkT/62N3oR2nD0YaRyL8TiZjsTf1L26Vx3Q9c00xeCO7oalFsJJdqTCbNSiX5txLDQC7
         8Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778159967; x=1778764767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJsNWGNnboxuwp5GaleyBNu7wVTMMyud/VuzWCCNevo=;
        b=J9HJkWiSX0kl4k+bBnI3rx0q8ucig1ugSB3KV+PYAMsTsWXnks/S2r8yKFy4ii/9Fg
         Lc7yg58hklWmC0g06paBK8aMFPKY6IrKc5v/zMwaYemRQodvc/HNFVFU7TVVig1S2HnF
         g0E7vc3wl0IGMcFThZfUyDKqoHN49xkuuqnoalsyNHelFIIfsfN1d9ZFzsoQvaCvIKLr
         eQLcAP1GyRgFeppcbZvYJCYij+jqpf5c+moddv8Fb2HQO0PX5FL9RFhDKi4eE3ejQvk/
         D7b+bU3hSj6lS0dkYYjcICSOFoHrXF+gCHLRkRGUUkmpPcx/ahVfruaFQPJIZT0Pk7/I
         3IcA==
X-Forwarded-Encrypted: i=1; AFNElJ8jdnNM/YqKUT4gz4NXke1qfGPYyDOw1wjl1R4PqKy7nFJFvvPMTMCSlfI0F0Ev4JsLACM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZ68FZtn0rmDK/1AN91SI0/X3d4dBmUMZZjRcodas4LBuXkNI
	iGc/L8wfW+89vJ0ve0bmmvMDlRSd0XNaa/A8g4yZeoDWHVrFNVOGLMeYV+rYPpTPY0MKQVWjhs5
	dfB+/icvfOZrsuvE73anj4HyJVTe7CYs=
X-Gm-Gg: Acq92OETqoY35wBw5GbXIth1sUHyeb2XTXrJc9h1vBK6rNHOZ/nh7mtIjy2zx5veY5u
	tVcO5dp7LHBfiZimNTl7CrT5J8z5SbC5Z61kNB/U8WCiiTBiPeV2Df9oFh/kyUkp++x9g2eXC4N
	1ZATzqeAzpX3T2NcT7M4PS1osZRK5M2Yo8G95y7lnoXsDY9MQ6SDUXUa8GqANDgSIRVE1MNT3lP
	+XWJkibmf0g33nccO+iS5eqtL5LqXzFkcxrVeACsHAuakn0Fzi1y7do+w6/wfUk6H6sQv4JtQX6
	CCeBCn4431se1oewNH0r3B54EnY7NndFSCAmLVAFywb6GbpZjIE=
X-Received: by 2002:a05:690c:e3e9:b0:7bd:5af9:f0a2 with SMTP id
 00721157ae682-7bdf5da8d19mr85075527b3.14.1778159966849; Thu, 07 May 2026
 06:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165024.1526680-1-vernon2gm@gmail.com> <CALOAHbBx6GuZjj9_EdrAPCsiLJekAiqOVsWQ0muNJh18Nxaqtg@mail.gmail.com>
 <CACZaFFPXo_f_2M7y4NfQ=sWddS4Kwo5guFTqZcLmm4Z8COWocQ@mail.gmail.com>
In-Reply-To: <CACZaFFPXo_f_2M7y4NfQ=sWddS4Kwo5guFTqZcLmm4Z8COWocQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 7 May 2026 21:18:50 +0800
X-Gm-Features: AVHnY4LaEHa2dX9PW99UK0yFlSgEhPhckpxDi__PrvtTYbMZ_56jvjXDiqmJ4Sc
Message-ID: <CALOAHbDQyUARbWudg3e94p7QyUF3Jgi3Y+NgPiSjfw=euENsjg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: introduce mthp_ext via cgroup-bpf to make mTHP
 more transparent
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, surenb@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	baohua@kernel.org, lance.yang@linux.dev, dev.jain@arm.com, 
	Vernon Yang <yanglincheng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 8:51=E2=80=AFPM Vernon Yang <vernon2gm@gmail.com> wr=
ote:
>
> On Thu, May 7, 2026 at 11:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Mon, May 4, 2026 at 12:52=E2=80=AFAM Vernon Yang <vernon2gm@gmail.co=
m> wrote:
> > >
> > > From: Vernon Yang <yanglincheng@kylinos.cn>
> > >
> > > Hi all,
> > >
> > > Background
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > As is well known, a system can simultaneously run multiple different
> > > scenarios. However, THP is not beneficial in every scenario =E2=80=94=
 it is only
> > > most suitable for memory-intensive applications that are not sensitiv=
e
> > > to tail latency. For example, Redis, which is sensitive to tail laten=
cy,
> > > is not suitable for THP. But in practice, due to Redis issues, the
> > > entire THP functionality is often turned off, preventing other scenar=
ios
> > > from benefiting from it.
> > >
> > > There are also some embedded scenarios (e.g. Android) that directly u=
se
> > > 2MB THP, where the granularity is too large. Therefore, we introduced
> > > mTHP in v6.8, which supports multiple-size THP. In practice, however,=
 we
> > > still globally fix a single mTHP size and are unable to automatically
> > > select different mTHP sizes based on different scenarios.
> > >
> > > After testing, it was found that
> > >
> > > - When the system has a lot of free memory, it is normal for Redis to
> > >   use mTHP. performance degradation in Redis only occurs when the sys=
tem
> > >   is under high memory pressure.
> > > - Additionally, when a large number of small-memory processes use mTH=
P,
> > >   memory waste is prone to occur, and performance degradation may als=
o
> > >   happen during fast memory allocation/release.
> > >
> > > Previously, "Cgroup-based THP control"[1] was proposed, but it had th=
e
> > > following issues.
> > >
> > > - It breaks the cgroup hierarchy property.
> > > - Add new THP knobs, making sysadmin's job more complex
> > >
> > > Previously, "mm, bpf: BPF-MM, BPF-THP"[2] was proposed, but it had th=
e
> > > following issues.
> > >
> > > - It didn't address the issue on the per-process mode.
> > > - For global mode, the prctl(PR_SET_THP_DISABLE) has already achieved
> > >   the same objective, there is no need to add two mechanisms for the
> > >   same purpose.
> > > - Attaching st_ops to mm_struct, the same issues that cgroup-bpf once
> >
> > Hello,
> >
> > The primary hurdles preventing BPF-THP from being upstreamed are:
> >
> > - Uncertainty regarding the stable API
> >
> >   It remains unclear whether the following API is sufficient for
> >   BPF-THP requirements:
>
> Thank you for pointing this out. I will add it to this issue list in
> the next version.
>
> At the same time, I also encourage everyone to actively provide
> relevant real workload scenarios. I will conduct related analyses and
> develop the mthp_ext to address them, so we can determine which ABI
> can satisfy the BPF-THP requirements.
>
> >   unsigned long
> >   bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type typ=
e,
> >                                             unsigned long orders)
> >   {
> >       return orders;
> >   }
> >
> > - Ongoing integration of cgroups and struct-ops
> >
> >   Work is still in progress to integrate cgroup support with
> > struct_ops (see also
> > https://lore.kernel.org/linux-mm/87cy439x8a.fsf@linux.dev/).
> > We should wait for this infrastructure to land before introducing
> > new cgroup-based struct_ops.
>
> This work can be carried out in parallel with integrating cgroup
> support with struct_ops. I will focus on addressing real workload
> scenarios to further clear/stabilize the BPF-THP ABI.
>
> > >   faced are likely to arise again, e.g. lifetime of cgroup vs bpf, dy=
ing
> > >   cgroups, wq deadlock, etc. It is recommended to use cgroup-bpf for
> > >   implementation.
> > > - The test cases are too simplistic, lacking eBPF cases similar to re=
al
> > >   workloads such as sched_ext.
> > >
> > > If I miss some thing, please let me know. Thanks!
> >
> > BTW, it would be better to include the original authors in the CC
> > list, especially since their work is cited in your commit message. ;)
>
> OK, I will CC the relevant authors in the next version.

Hello Vernon,

I believe it would be best to hold off until David provides guidance
on the future direction. While I am not currently active on BPF-THP,
we are still looking for the right opportunity to upstream it. The
primary difference is that your implementation is cgroup-based;
however, we also plan to switch to that approach once Roman=E2=80=99s work
lands.

I don't mean to imply that BPF-THP is solely my project, but I suspect
you will eventually arrive at a similar implementation to what I=E2=80=99ve
developed. So far, I haven=E2=80=99t found a more efficient API than the
following:

  unsigned long
  bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
                                             unsigned long orders)
  {
       return orders;
  }

--=20
Regards
Yafang
