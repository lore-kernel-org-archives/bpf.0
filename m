Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554DD44A70E
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167203; cv=pass; b=mOiZzEtA9K1HJXjK8/eu3LH69rrrEgGkKWdqCk89Ek9GZyFsmUmEAJaVtYo6zUQ/lNIlIYReRqDJfY2rcWBxeJENdxoa1iiqITz144hsFsKPm/HY3E5nBq5eu3EaT/sg98bF6Am0SNLEFpr3C5pLUPFCcircPwDz58uMRH5jzBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167203; c=relaxed/simple;
	bh=7SvODCkDb/PUktMcToXV+MZ//XeQ5qOuRTno5s3DkMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X39LZDldyE641Ym9vsv6VK0DwDMzeIi3GQGXWQP1w3Qq4OKUhotymuAAFvpGnNH0D6GWl9eaGCB7VPI40+p4Y/0+syi4wnMtney4nPWGMAY18olTNcLY1Y1Q3KhSU2L23VufChvjEs22j6k4jW8vjETzU9q1+o+hnTy+f/UsG8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhyFfQQ3; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhyFfQQ3"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso7675921fa.2
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 08:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167198; cv=none;
        d=google.com; s=arc-20240605;
        b=YZu72TzlnK+h9iUqrkSvQ2ESGD6UNgfs52pFf3bubXgXtxW7+z5wJuFVtpudBr4XfT
         RDlHEr3AbOtZ3+gTRa7iSpDpJuOTksSuD3rv6uMSgVAkgI+vchpWgGt5MyFedsKsWJ4P
         1P+GYkiao1RpgX3TBAS/pv0M5fIfY/XxUY6TrFaMGdNaixyQD5lcXErKCPpN+vCD/fNE
         gEtbDajC14Yx66Hb3cDsJyxoq27EWGFmtt8xGGeq/8k0q5sylv0S2LNqi0en8V0u9irE
         gg9XaocybAr0Guc61LKsdnPp9BqzzgYU0M2AbHof6OJSTWwYQ3kesdXOwdgRTUgvYf3k
         0XDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xvZ4FuEr6FesLFXFPQKMY7rVCvVG3A7RqmeTMe4SIiQ=;
        fh=AQKWz5TOKLtVz3LmcW563P4PbW/MyCzZ9GQB1HSwgB8=;
        b=CzWL94osYiGiZ6mDIeTndpROduoA/Kvu+5zxH6zwOknid0rn1VHfQmfglEF9UMKGVu
         bfM1icV8LRhk+c1kHv5ql8JdyT4voB8nUuIXA+TtLuG05CoubDGw5MCSEAcQ6bquzZZy
         IachndCK4mV+jZRQbFSVzr/f4VjzNELhMyZdGffoD3Ed0/8euG0zS06QEbnLtM2Pl49l
         8KDc9pT7w+h9jFOG70/Sh/O+Wug0wzksuP35l47qiJlQxw1FDRxmYVKTe1nZ2F4pPs7F
         sZF2SckEFSuHYAZVarTmqPtpYAzKdDGteZt0+8HnFQFwq6iHucQ9H3Z6vT82Yhw1ul4w
         jTjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778167198; x=1778771998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvZ4FuEr6FesLFXFPQKMY7rVCvVG3A7RqmeTMe4SIiQ=;
        b=AhyFfQQ37mzc0ps42YgERjCLc9D/qVJ3BCDIw0ylsU53Os3uuTwwcMHnWInMPIXyJ8
         GJomgmWy+VE1LlDQL/ZOVcML9I1MdJb+22kR3NSM/jKjwWfEfGksRzeYD2vmpWAg7Re2
         zir9RILEjmVANMvHT7FrbbhJ9U5XCnaWGEtYot5pMLnVPfNxy6wQmvNoctE9+1fuHok2
         brZC/TGOKoKooK2V5TVrytgdAqCNT49auv6ZCk6RWqVSRDe8c3KYsr42ROEdpAl69WrP
         5x1cobKWw/lpriDqGJLg1K4BoxhLrhQBzRJxcKdA2noOkIQcH6KdE1+9rBDA3cyNO/Wt
         rhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167198; x=1778771998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xvZ4FuEr6FesLFXFPQKMY7rVCvVG3A7RqmeTMe4SIiQ=;
        b=DPODg8pRhvgnNsr2pzHnLmMFkm/D+sTlQ6pS6Fbc8VvFTl+XaBRwDM+HA8ZwtoPZrA
         8CtZv0sHMwjkM51xA55P5e0LbvQilNu6J1OYAvBO+HoeurYK2T6OpzVO+QE+TwqHU8AL
         HxKAEVt0fTbYaAW2uBmE0WOaJNuKdN6y11kvTjCBOYr0soJI7h2FYHTz7a7M8zW6G0dF
         PFUmN/96czJiV7kXkOTg+OPWakG7uYwboyWSeLcZV+UokidQsFRmB1g6efeMim6P8K8v
         iH0EpzqyyYVN661tuJFvI2NYEsdc9gbQWjVBrx08/Y5C978qeSTpFVTfJsh4LLBWoOhe
         ac4w==
X-Forwarded-Encrypted: i=1; AFNElJ/ofviNtcQHQbo3xIRXQ9vDXOFpzwQvA7fOO5gCKqDh+sr9PW8HSuvo21aO7SF8/Sxxz8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpIDKTy7Lxm8Ftls/UlloL3t4o11gnqSwghpeEQj3vqmNNmpYJ
	8Z42QzEX8TIOAefkznO0wLFQMP1iKMw8QQVxg9B7UDnW9wx4f5R+OaKiS3ozLFklte4WEA9KQqY
	wS9as0hNrAUMjvYnhJHG5xiBSeeLGd+8=
X-Gm-Gg: AeBDietCcPQJJO6XuurkugiZ8vYdoLuxj5WYMk/IRuwLKI27WPOMlt8npsT1AOEDARm
	Lhk/trsXnDp4uIhOiXaGfvdWAvjclMvK1DTx1C5P3ULT4yVyzR9CLu455OawRW2eAP8DkmM8AOT
	eBSk3ya9CA6sCOkYSXAqfh87mA+W4pylzRmtFzSddt7INu6UA65B5BwsIzsHzXTivwro/5mrNky
	c4vy9Jq+JQY+QqJJi3IbaK2CdXokWgLjXpiSvKUqhXCYNSboOTfxlPmTlwy0MYQkD5/UMP/XbYW
	DMn2Sb5haNZAFzeUWp2/e+230Bk=
X-Received: by 2002:a05:651c:35c6:b0:38a:6537:6f51 with SMTP id
 38308e7fff4ca-393c40a513fmr36502871fa.5.1778167197354; Thu, 07 May 2026
 08:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165024.1526680-1-vernon2gm@gmail.com> <CALOAHbBx6GuZjj9_EdrAPCsiLJekAiqOVsWQ0muNJh18Nxaqtg@mail.gmail.com>
 <CACZaFFPXo_f_2M7y4NfQ=sWddS4Kwo5guFTqZcLmm4Z8COWocQ@mail.gmail.com> <CALOAHbDQyUARbWudg3e94p7QyUF3Jgi3Y+NgPiSjfw=euENsjg@mail.gmail.com>
In-Reply-To: <CALOAHbDQyUARbWudg3e94p7QyUF3Jgi3Y+NgPiSjfw=euENsjg@mail.gmail.com>
From: Vernon Yang <vernon2gm@gmail.com>
Date: Thu, 7 May 2026 23:19:45 +0800
X-Gm-Features: AVHnY4KHF6zAOGVDKs5Hct5iRRfpwWPlE8f88WUSoHr5Q9e_GpVW0c3a6W-w61w
Message-ID: <CACZaFFMS0KcmBbEMc-ZC9C9VHaQtZbcGpujhfmKR4Yx=eGsFWg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: introduce mthp_ext via cgroup-bpf to make mTHP
 more transparent
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, surenb@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	baohua@kernel.org, lance.yang@linux.dev, dev.jain@arm.com, 
	Vernon Yang <yanglincheng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 9:19=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Thu, May 7, 2026 at 8:51=E2=80=AFPM Vernon Yang <vernon2gm@gmail.com> =
wrote:
> >
> > On Thu, May 7, 2026 at 11:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Mon, May 4, 2026 at 12:52=E2=80=AFAM Vernon Yang <vernon2gm@gmail.=
com> wrote:
> > > >
> > > > From: Vernon Yang <yanglincheng@kylinos.cn>
> > > >
> > > > Hi all,
> > > >
> > > > Background
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > As is well known, a system can simultaneously run multiple differen=
t
> > > > scenarios. However, THP is not beneficial in every scenario =E2=80=
=94 it is only
> > > > most suitable for memory-intensive applications that are not sensit=
ive
> > > > to tail latency. For example, Redis, which is sensitive to tail lat=
ency,
> > > > is not suitable for THP. But in practice, due to Redis issues, the
> > > > entire THP functionality is often turned off, preventing other scen=
arios
> > > > from benefiting from it.
> > > >
> > > > There are also some embedded scenarios (e.g. Android) that directly=
 use
> > > > 2MB THP, where the granularity is too large. Therefore, we introduc=
ed
> > > > mTHP in v6.8, which supports multiple-size THP. In practice, howeve=
r, we
> > > > still globally fix a single mTHP size and are unable to automatical=
ly
> > > > select different mTHP sizes based on different scenarios.
> > > >
> > > > After testing, it was found that
> > > >
> > > > - When the system has a lot of free memory, it is normal for Redis =
to
> > > >   use mTHP. performance degradation in Redis only occurs when the s=
ystem
> > > >   is under high memory pressure.
> > > > - Additionally, when a large number of small-memory processes use m=
THP,
> > > >   memory waste is prone to occur, and performance degradation may a=
lso
> > > >   happen during fast memory allocation/release.
> > > >
> > > > Previously, "Cgroup-based THP control"[1] was proposed, but it had =
the
> > > > following issues.
> > > >
> > > > - It breaks the cgroup hierarchy property.
> > > > - Add new THP knobs, making sysadmin's job more complex
> > > >
> > > > Previously, "mm, bpf: BPF-MM, BPF-THP"[2] was proposed, but it had =
the
> > > > following issues.
> > > >
> > > > - It didn't address the issue on the per-process mode.
> > > > - For global mode, the prctl(PR_SET_THP_DISABLE) has already achiev=
ed
> > > >   the same objective, there is no need to add two mechanisms for th=
e
> > > >   same purpose.
> > > > - Attaching st_ops to mm_struct, the same issues that cgroup-bpf on=
ce
> > >
> > > Hello,
> > >
> > > The primary hurdles preventing BPF-THP from being upstreamed are:
> > >
> > > - Uncertainty regarding the stable API
> > >
> > >   It remains unclear whether the following API is sufficient for
> > >   BPF-THP requirements:
> >
> > Thank you for pointing this out. I will add it to this issue list in
> > the next version.
> >
> > At the same time, I also encourage everyone to actively provide
> > relevant real workload scenarios. I will conduct related analyses and
> > develop the mthp_ext to address them, so we can determine which ABI
> > can satisfy the BPF-THP requirements.
> >
> > >   unsigned long
> > >   bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type t=
ype,
> > >                                             unsigned long orders)
> > >   {
> > >       return orders;
> > >   }
> > >
> > > - Ongoing integration of cgroups and struct-ops
> > >
> > >   Work is still in progress to integrate cgroup support with
> > > struct_ops (see also
> > > https://lore.kernel.org/linux-mm/87cy439x8a.fsf@linux.dev/).
> > > We should wait for this infrastructure to land before introducing
> > > new cgroup-based struct_ops.
> >
> > This work can be carried out in parallel with integrating cgroup
> > support with struct_ops. I will focus on addressing real workload
> > scenarios to further clear/stabilize the BPF-THP ABI.
> >
> > > >   faced are likely to arise again, e.g. lifetime of cgroup vs bpf, =
dying
> > > >   cgroups, wq deadlock, etc. It is recommended to use cgroup-bpf fo=
r
> > > >   implementation.
> > > > - The test cases are too simplistic, lacking eBPF cases similar to =
real
> > > >   workloads such as sched_ext.
> > > >
> > > > If I miss some thing, please let me know. Thanks!
> > >
> > > BTW, it would be better to include the original authors in the CC
> > > list, especially since their work is cited in your commit message. ;)
> >
> > OK, I will CC the relevant authors in the next version.
>
> Hello Vernon,
>
> I believe it would be best to hold off until David provides guidance
> on the future direction. While I am not currently active on BPF-THP,
> we are still looking for the right opportunity to upstream it. The
> primary difference is that your implementation is cgroup-based;
> however, we also plan to switch to that approach once Roman=E2=80=99s wor=
k
> lands.

LSF/MM/BPF has just concluded, I think David will soon share some new
directions with us.

If it is merely about converting to cgroup implementation for
per-process version (I have already completed development based on
cgroup-bpf), there is no need for you to start from scratch. You can
directly test whether mthp_ext addresses your real workload scenarios.

Based on the current patchset, we can collaborate on development, as
our shared goal is to get this done right.

--
Cheers,
Vernon
