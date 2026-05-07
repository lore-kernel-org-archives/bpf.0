Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC623ED131
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158272; cv=pass; b=FngmlU0j/NRf8E0YxLvJ58EXJrN3saWbTC7TxN2oMqAOwEAaM6ttj5tQXh1kHiRrl5wJdSXsoF/Gpv74SFETDutj/QTiTk4a9hm61cj1bKaWn0cRQOxEMNTlElZ6RKPyxrIjNWfR2hqaQPd+JkK8pJiv8avGZiKLJzOi9NkUMZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158272; c=relaxed/simple;
	bh=s7OI6HHvsHxfWxRGFkKSojNp0di6rdJD2TS4haeyN80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4G/ZKb9gmmyMd6CrWah96wCEHOJpDs8qGLLlrQ87n0QBAZ/wFSb8Mp/99p51z1Le4GGMIclXZ30Lh8rT6qRe1ggrmJPFviUkfA/wzm/6XeArp9l105l2TdfY+W5P4/ORwLANpVpyIm36xeG6koYvkX50Kn248qcuUGM7jjPdOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnnFCLSq; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnnFCLSq"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e7d983f79so6698971fa.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 05:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778158269; cv=none;
        d=google.com; s=arc-20240605;
        b=OJJMnyUi6ZeDs+xegE49iNxmFQsNL20lkfJS57+aumr3s9g7NFXfbpl08qKG2mgmRm
         aURB+qs7I/LSXY8CJIC0iogceDIVHUykBqUC87p0TRQb8mJEkUraEVMmoWQ7EDONRVoS
         VdZY29rr+rKm737o3VYmPxf+FucG2dGDLO6IbgIiw391TSognwbmZsOjhTwUcygo8/l/
         +JLLNycRVI6sh+c4XcyXz8TPMP0zE14E8h5VJSDvg2CmQFdiTfkqnqKKYCFhqLLxwVRt
         LPagtZD+LWWBBrgje6KCKa6FXILHLMWSjSsnIS/KFLxRIuvlWp/jUJWdeiCur4xWJUPL
         bgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ds5Hpu/+KbdWRemu357hxe1/OrpLRLixtQ7C6d78k58=;
        fh=T8cIjgFuaM/QWjTbAPWoAk2XfyhVXQaKLW2UXQQ0eEM=;
        b=LOpbU4yiXW29HcrMK/Zn88kFpKyFrNotnJhLdBmoag8zEvsItdlHwQJo8GCf4AT4DN
         2U4vLanhmV/PML7QZlhEC/X7plXT7Nk08mRddBFmIn9VyoHXQurOeh/22T8Mpg7aotSe
         e/Gl6lbb/Koe0+ayu7xNcz5ivpQshXnm2QScPZfAhBKBEj9TwR9jhGxxSRhA9IEJ/7bQ
         11+R+xst7AMRLqY4ojoXRwlB2P6oAorT5IvCR/Jnb4AUg71fVXqK0UQVe0yNmkj60KKB
         XnwIADk14Uhk2gWs05wKhyJ8bXaBu8g+OiBdYKo1v6cwU6PpZwifjJAfF2ehMK7eOxNf
         0ngg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778158269; x=1778763069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ds5Hpu/+KbdWRemu357hxe1/OrpLRLixtQ7C6d78k58=;
        b=KnnFCLSqtLNRVKj7CjYItzW9lpMIGcQcBY+XI9uFuvHuAObupcFkpIOJs8XpBIb1zi
         OhIQ9E5QlQbQ72CbR+zE3C1V1ImG4vX+dvKcbx2/awMl9eandpDuCIBYehm3FwAVv4mt
         VTR8ee6Od6jt2gB62IJWmYJ85DLiCoXO/cizfLQMqPDeXnnnGOlhnnuFP95D/4Ypn7C0
         Czeileqz54mCvuNaSy/TeRJ4L3KZGoXNJ2sDbHC33Cu1PG4QnTKj9gMG3jFlCDzh6Sjr
         PC7klSHPld1hYirt2+9PoBRK4dNEujoHcKqE0yNtqxosnHipwfy+0Rs3yGBg7FSQdRTW
         N8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158269; x=1778763069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ds5Hpu/+KbdWRemu357hxe1/OrpLRLixtQ7C6d78k58=;
        b=N6msB78d/5myCoxsqmmo5yvd8rjHivly54xXbP51aknvU55wF0vB9hN+NEG6zS29m5
         sdicZnmlxkyQCZyeAUIvuT0Xh3ax5l3pWc4z31FB0kNLK+gU7aLbjtgb4tCH+EHGREsx
         tvKCz47cQvLqRK3OUPcduQfnPnXFVBJrCF8lnaDonT8lHB6cDgTKff/in+F4PQU0eaaZ
         EH28ERxSBpezSAfrAhG8TJ5AbUvfK/dF2NICI7WsliUd1FGTOmah54awQKpMMqMXbXvU
         iCGA1aM5bXsMHvUgBLhSFi5vEetInzwdYNYVgZVq9t50luDsr5mnziCnF0q97/n9wj1k
         B1vA==
X-Forwarded-Encrypted: i=1; AFNElJ9nqU2xqyYMMJsmekNLJucWJyvHhq4XX1qrvjm7uCJ/pbJlHdpMALtlVYIGX/yMWsfdHFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPuUCgUydIpo5vxOejYfkTvnET4dAJYsvzW6ljtUSx8U5rWJt
	EqdIMfNNqGuYiAlJVNMcrz/ohvmTQPPXD4sk8zLfbrbfmgtmWRGEqzhfSip9grzLuuYuCs0ls0y
	37D/GZBoNKf6swOAfea4+Sw6eJEvrc5A=
X-Gm-Gg: AeBDievvOl70JvU4HyAEj05gbvo7NgkrB9UdbB3rbmD6UzOJz1IYHmQHfz7KSt82Ej2
	oEZEpmiT/nGzgx2jRIWNkNeohA9wa8rlNvS8wvf14o2Jmrxj4nzPRiaLgS4t2FrOsDpbCnuT8pb
	1HJRN4ZYvKE76wd1Tvgjw/0Nz421Iy9xSrDlr2+QqmElkPEAUYgTSXDSnJaSXmau/wrJB0g7XvA
	5iFqwUC/oRHCds9tUDatnDq+FlMFXfjRWUw5Pghyu8662KX0MDjY9AFVHm3/ej+xmbD83qo2F5g
	4K8hQeLHJBcrMJM=
X-Received: by 2002:a05:651c:3247:20b0:393:9ee6:1b7b with SMTP id
 38308e7fff4ca-393c41e25d8mr22404801fa.22.1778158268499; Thu, 07 May 2026
 05:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165024.1526680-1-vernon2gm@gmail.com> <CALOAHbBx6GuZjj9_EdrAPCsiLJekAiqOVsWQ0muNJh18Nxaqtg@mail.gmail.com>
In-Reply-To: <CALOAHbBx6GuZjj9_EdrAPCsiLJekAiqOVsWQ0muNJh18Nxaqtg@mail.gmail.com>
From: Vernon Yang <vernon2gm@gmail.com>
Date: Thu, 7 May 2026 20:50:56 +0800
X-Gm-Features: AVHnY4Jj1qd88WzmY0wwoWnVGCaZldc6eM9kX1Z-bW7EzXfkIO3E-JQPWwtzWk4
Message-ID: <CACZaFFPXo_f_2M7y4NfQ=sWddS4Kwo5guFTqZcLmm4Z8COWocQ@mail.gmail.com>
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

On Thu, May 7, 2026 at 11:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Mon, May 4, 2026 at 12:52=E2=80=AFAM Vernon Yang <vernon2gm@gmail.com>=
 wrote:
> >
> > From: Vernon Yang <yanglincheng@kylinos.cn>
> >
> > Hi all,
> >
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > As is well known, a system can simultaneously run multiple different
> > scenarios. However, THP is not beneficial in every scenario =E2=80=94 i=
t is only
> > most suitable for memory-intensive applications that are not sensitive
> > to tail latency. For example, Redis, which is sensitive to tail latency=
,
> > is not suitable for THP. But in practice, due to Redis issues, the
> > entire THP functionality is often turned off, preventing other scenario=
s
> > from benefiting from it.
> >
> > There are also some embedded scenarios (e.g. Android) that directly use
> > 2MB THP, where the granularity is too large. Therefore, we introduced
> > mTHP in v6.8, which supports multiple-size THP. In practice, however, w=
e
> > still globally fix a single mTHP size and are unable to automatically
> > select different mTHP sizes based on different scenarios.
> >
> > After testing, it was found that
> >
> > - When the system has a lot of free memory, it is normal for Redis to
> >   use mTHP. performance degradation in Redis only occurs when the syste=
m
> >   is under high memory pressure.
> > - Additionally, when a large number of small-memory processes use mTHP,
> >   memory waste is prone to occur, and performance degradation may also
> >   happen during fast memory allocation/release.
> >
> > Previously, "Cgroup-based THP control"[1] was proposed, but it had the
> > following issues.
> >
> > - It breaks the cgroup hierarchy property.
> > - Add new THP knobs, making sysadmin's job more complex
> >
> > Previously, "mm, bpf: BPF-MM, BPF-THP"[2] was proposed, but it had the
> > following issues.
> >
> > - It didn't address the issue on the per-process mode.
> > - For global mode, the prctl(PR_SET_THP_DISABLE) has already achieved
> >   the same objective, there is no need to add two mechanisms for the
> >   same purpose.
> > - Attaching st_ops to mm_struct, the same issues that cgroup-bpf once
>
> Hello,
>
> The primary hurdles preventing BPF-THP from being upstreamed are:
>
> - Uncertainty regarding the stable API
>
>   It remains unclear whether the following API is sufficient for
>   BPF-THP requirements:

Thank you for pointing this out. I will add it to this issue list in
the next version.

At the same time, I also encourage everyone to actively provide
relevant real workload scenarios. I will conduct related analyses and
develop the mthp_ext to address them, so we can determine which ABI
can satisfy the BPF-THP requirements.

>   unsigned long
>   bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
>                                             unsigned long orders)
>   {
>       return orders;
>   }
>
> - Ongoing integration of cgroups and struct-ops
>
>   Work is still in progress to integrate cgroup support with
> struct_ops (see also
> https://lore.kernel.org/linux-mm/87cy439x8a.fsf@linux.dev/).
> We should wait for this infrastructure to land before introducing
> new cgroup-based struct_ops.

This work can be carried out in parallel with integrating cgroup
support with struct_ops. I will focus on addressing real workload
scenarios to further clear/stabilize the BPF-THP ABI.

> >   faced are likely to arise again, e.g. lifetime of cgroup vs bpf, dyin=
g
> >   cgroups, wq deadlock, etc. It is recommended to use cgroup-bpf for
> >   implementation.
> > - The test cases are too simplistic, lacking eBPF cases similar to real
> >   workloads such as sched_ext.
> >
> > If I miss some thing, please let me know. Thanks!
>
> BTW, it would be better to include the original authors in the CC
> list, especially since their work is cited in your commit message. ;)

OK, I will CC the relevant authors in the next version.

--
Cheers,
Vernon
