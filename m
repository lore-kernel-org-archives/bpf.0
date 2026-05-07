Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505693EF0D3
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172007; cv=pass; b=qmfVl2x1fwOtXq72aSa2SC4fa1aUfFuVEdrIUmdOb+FK0C5DS5IOSi1dLGLLfvFObIeF5euPzmrEv4VUlfszLe16LR4s3frsrckiOb09fSgZoeC5Lpzqt4Ce5HnBDQSJl/6psHcdzmNgNPRqHIo3zrJ8AcFn6BBeFKOmeCyg664=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172007; c=relaxed/simple;
	bh=neZWo1d95jMObk+Mq9iA2YgiLPmeCkXblbp2n4ngm/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8BAwT9WcTgrlCLdBCYbgSpVb2T3Wemoz3H+dy6AWOE/wGixlytQ4/a+7b48bSmOu9fEvAwjQ0Tz+pI8ShjTcZ3Uf9vxhqItbOIoSse8zFbp83NGNgIj913PTLC+X/Jqyr9X/n/xjBRAUJxVtrBFnmaRiycgVMHnHZt+BPZLECI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4lq6rfW; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4lq6rfW"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-464bba3a9easo524771b6e.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 09:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778172005; cv=none;
        d=google.com; s=arc-20240605;
        b=Q2W2TPbHuq5gYKE3Oc3uj3nGkpINtgJ/o9/LjrbvPxECQvVtpI9d8jKrxMMvQjQ7Em
         k4lhL5EONg5l25DLsVICMmifjMmBt/984uhj5gzZrEo/JbhSbCBwbLvBQ2CtQiM4r81W
         5M/ykvn3gLdP0ejKRPbpdO0kR000s+9zMCib02UvQNMCmPAd3bl231DyDJP6PFLjDG6a
         UopQ/yTArDXuYKVBCyXy9eFcm3RUcMI9D/mZVh+iH91ibsjFHYB+qclB2xKOdqpCVhxf
         KiZXIlQXfIskIwvJWDmUlN8LmlFXWOq5JEyRPTzHoXtGGbWpjbPfT/aWJTQV1hoz05uE
         B7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cL2xjIbgJnPDP2NFUP39tmdTnRCHmmDy2YZbxZdDJ9k=;
        fh=O5Bn3kbbar8RECngQoKCKzXN2DySSAe8J0hRrj9z46U=;
        b=j2zQDQUdcMYjmjGMpXAvK+ceTqkPX/9MCZhzSMXzUBYF52x37o6FrvMU8n1iebgKsv
         sk7V+MqS+JxiWSVHxx1hDQ3HuTOZbQRL76j5s3hK8i89CLs0Yu0jG5eArwzuNQVnOA41
         ooLWsqAFIRdZ9d5Q8sHagU48zc+z0A7uC0clYlb4NUHBZ+JUaHWSDcAQ+J0qD8b4exlW
         IZ+cH2FjufBSVI2QNb8uE0Ff3gzhl6Acjd+xO/H2G8/VwExlNMu8PIDHOpwsYSwIweao
         XSF8x/xdNe95JZloBUd3rS52LbUvk8OwEl20KO+gnID4rttzNuZrDlRz5BsVstHG2uh+
         n06g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778172005; x=1778776805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cL2xjIbgJnPDP2NFUP39tmdTnRCHmmDy2YZbxZdDJ9k=;
        b=r4lq6rfW6Eefzv+zchm4KzKnYRFs65KOUEfq55WEUSK/a15PNG3t1QsqYuyeqROjXC
         qMciPMrmnVSZFIwn/XiIH11ehs8gVLaV4leJfD6erUM+PcnBvfEEg3525mBGT1/F6ccf
         0vXV8YeEWJYOfpMqh+u+gTWsAm3USkcU7fh9gW7tXXb3TZ0z+/ukupiB7lt2WOb6v28h
         Zhsf3p4Z9S5rBDk+CMFHj24/Ny6FOnp6UEzY+AmObsmBzP0eP5raMqUJTr4hxgTev7Gz
         HYgX/rsjQYXlVHJWGOtAnOaTq5olqWMQrk6K27zQoPkG6luArkOmKheCWyk3wSZ78Yqv
         nVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172005; x=1778776805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cL2xjIbgJnPDP2NFUP39tmdTnRCHmmDy2YZbxZdDJ9k=;
        b=fUjE85lUcKwT0ea7F9iMR6CBBvgSRGgmpF34GRXQ4u7iWpl4ndptmTLaXI0DFxxqCi
         LEnVVXoy7MhSz7iAb+UKmmqB2hFsbqPlm4H5Do1eKHuoCeD9Zd32z2HpEbzlAp63TN4k
         u2Nxd0G7rWKl9Z/lKx9VK82cd/Q0kBBazzAqSu0YfE58jE+wueoXd1VM25Yuruc6PtpS
         ucKsfQlbgs2WuwrZtYBdWQHeiExivQasn47fY6VRURkMRG6VX61gSgEVOjGw2qt0mhfN
         GUnv3sXlSGQkaSGPR5YHdrzmaUohm5rlKspThx3AVBGTdMT7v8qZ2o/vXzHJJfAlvbuH
         RzOA==
X-Gm-Message-State: AOJu0YwK5SC41ZJ5DXWecvuGht73nbWso1Xeh+wsZ/ZfoDW2MP99lG5W
	7SQPyXE/ETglttZGJFEenU2psFRxBnOZel71hRlLjSd4hoO0HWrNy9uH+lCoM5+Nz9hgCAr1YzF
	Ylc9ySJPDrJzVdZy4upMCV0Br+JsuWcA=
X-Gm-Gg: AeBDietMzezW1anAwI7oe4WDTVAlOdRi9Q/m/9pPBUVQzqph0RtYr4HldUPfL7ilqbL
	8qZbKKD2YoPRiaJXY4cQTMpGYIPzm630uehkmlM4BdsWlH9TvvD1Y4hL7lAsNrmn3FKTNwghBhT
	QMd0bqiiHlAgzZlAvtDmfep3mnJjgwVYDaPPLjubv7202vU6MqgGRcKLypfOnJrla4rLx1zIOf5
	yZk0GlKmrmu3QcTkPiXVbolIyF+Z5qz6blTYjUsoPC9xTPJFmaucuQqH6EbOWU0SLXyFACVNG9m
	iHbgjrV7SV1A6if1bJJ6YzU2Rg==
X-Received: by 2002:a05:6808:e68f:b0:47c:b363:63a1 with SMTP id
 5614622812f47-4804248fda4mr3976559b6e.31.1778172005164; Thu, 07 May 2026
 09:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506150547.767315-2-paulhoussel2@gmail.com> <20260506210856.C6C29C2BCB0@smtp.kernel.org>
In-Reply-To: <20260506210856.C6C29C2BCB0@smtp.kernel.org>
From: Paul Houssel <paulhoussel2@gmail.com>
Date: Thu, 7 May 2026 18:39:53 +0200
X-Gm-Features: AVHnY4KluGJV2dpVBdNXTV0Hg2Ce2_n33pswA2MVg9JGwnflCjSFevzotiRxEY4
Message-ID: <CA+aJb_1vFaSvBjsZbi_EYhGfiefCruaEaLqgagX6HAGfLFxqGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: render CGROUP_LSM_NUM configurable as a KConfig
To: Paul Chaignon <paul.chaignon@gmail.com>, sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, I agree I'll set the minimum value to 1 as I don't see a
motivation to would want to restrict per cgroup attachments if BPF LSM
is already allowed if CONFIG_BPF_LSM is set. I would like to have your
thoughts on the upper bound. 300 is currently higher than the actual
number of total LSM interfaces and would be considerable memory
overhead. With CONFIG_CGROUP_LSM_NUM=3D10, cgroup_bpf has 1024 bytes
since MAX_CGROUP_BPF_ATTACH_TYPE=3D38.

```
$ pahole cgroup_bpf
struct cgroup_bpf {
    struct bpf_prog_array *    effective[38];        /*     0   304 */
    /* --- cacheline 4 boundary (256 bytes) was 48 bytes ago --- */
    struct hlist_head          progs[38];            /*   304   304 */
    /* --- cacheline 9 boundary (576 bytes) was 32 bytes ago --- */
    u8                         flags[38];            /*   608    38 */

    /* XXX 2 bytes hole, try to pack */

    /* --- cacheline 10 boundary (640 bytes) was 8 bytes ago --- */
    u64                        revisions[38];        /*   648   304 */
    /* --- cacheline 14 boundary (896 bytes) was 56 bytes ago --- */
    struct list_head           storages;             /*   952    16 */
    /* --- cacheline 15 boundary (960 bytes) was 8 bytes ago --- */
    struct bpf_prog_array *    inactive;             /*   968     8 */
    struct percpu_ref          refcnt;               /*   976    16 */
    struct work_struct         release_work;         /*   992    32 */

    /* size: 1024, cachelines: 16, members: 8 */
    /* sum members: 1022, holes: 1, sum holes: 2 */
};
```

While with CONFIG_CGROUP_LSM_NUM=3D50, it has 2024 bytes, indeed adding
25 bytes per increment to CONFIG_CGROUP_LSM_NUM (8 + 8 + 8 + 1 per
slot for effective, progs, revisions, and flags):

```
$ pahole cgroup_bpf
struct cgroup_bpf {
    struct bpf_prog_array *    effective[78];        /*     0   624 */
    /* --- cacheline 9 boundary (576 bytes) was 48 bytes ago --- */
    struct hlist_head          progs[78];            /*   624   624 */
    /* --- cacheline 19 boundary (1216 bytes) was 32 bytes ago --- */
    u8                         flags[78];            /*  1248    78 */

    /* XXX 2 bytes hole, try to pack */

    /* --- cacheline 20 boundary (1280 bytes) was 48 bytes ago --- */
    u64                        revisions[78];        /*  1328   624 */
    /* --- cacheline 30 boundary (1920 bytes) was 32 bytes ago --- */
    struct list_head           storages;             /*  1952    16 */
    struct bpf_prog_array *    inactive;             /*  1968     8 */
    struct percpu_ref          refcnt;               /*  1976    16 */
    /* --- cacheline 31 boundary (1984 bytes) was 8 bytes ago --- */
    struct work_struct         release_work;         /*  1992    32 */

    /* size: 2024, cachelines: 32, members: 8 */
    /* sum members: 2022, holes: 1, sum holes: 2 */
    /* last cacheline: 40 bytes */
};
```

Above a certain threshold the memory overhead is too high indeed,
causing a crash on my VM. Probably caused by the raised stack concern,
exceeding CONFIG_FRAME_WARN=3D2048. I therefore propose capping at 50 to
be below FRAME_WARN. In practice eBPF-based tools may exceed this
limit of 10 but I don't see use-case requiring the attachment of all
LSM hooks. For example, Aqua Security's Tracee uses 24 LSM hooks[1],
and the recently announced MetArmor requires at least 14 LSM hooks if
they choose to trace the following events with LSM programs: execve,
bind, connect, accept, sendmsg, recvmsg, namespace creation, open,
kernel module loading, bpf, ptrace (covered by 2 LSM interfaces),
mount, and pivot_root (see slide 8 in [2]).
I would therefore propose to set the maximum value to 50 or 100 (where
cgroup_bpf is 2024 bytes long), what do you think Paul C?

[1] https://aquasecurity.github.io/tracee/latest/docs/events/
[2] https://lpc.events/event/19/contributions/2172/attachments/1845/3945/LP=
C%20
conference%20-%20Carl%20v2.pdf




On Wed, 6 May 2026 at 23:08, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Increasing CONFIG_CGROUP_LSM_NUM to its maximum value (300) caus=
es an excessive stack allocation in cgroup_bpf_inherit(), which will trigge=
r a FRAME_WARN build failure and risks stack overflow.
> --
>
> commit 33800a93ec2833bc433c78926307347450251cdb
> Author: Paul Houssel <paulhoussel2@gmail.com>
>
> bpf: render CGROUP_LSM_NUM configurable as a KConfig
>
> This commit makes the maximum number of concurrently attachable per-cgrou=
p
> LSM hooks configurable at build time via the new CONFIG_CGROUP_LSM_NUM
> option. It allows the value to be tuned from 0 to 300, replacing the
> previous hardcoded limit of 10.
>
> > diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup=
-defs.h
> > index c9e6b26abab6d..9ab5ca3dbaba3 100644
> > --- a/include/linux/bpf-cgroup-defs.h
> > +++ b/include/linux/bpf-cgroup-defs.h
>
> [ ... ]
>
> >  #ifdef CONFIG_BPF_LSM
> >  /* Maximum number of concurrently attachable per-cgroup LSM hooks. */
> > -#define CGROUP_LSM_NUM 10
> > +#define CGROUP_LSM_NUM CONFIG_CGROUP_LSM_NUM
> >  #else
> >  #define CGROUP_LSM_NUM 0
> >  #endif
>
> > diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> > index eb3de35734f09..050af0b72651d 100644
> > --- a/kernel/bpf/Kconfig
> > +++ b/kernel/bpf/Kconfig
>
> [ ... ]
>
> > +config CGROUP_LSM_NUM
> > +     int "Maximum number of per-cgroup LSM hooks"
> > +     depends on BPF_LSM
> > +     depends on CGROUP_BPF
> > +     range 0 300
>
> If this is configured to the maximum value of 300, could this cause a
> regression by overflowing the kernel stack in cgroup_bpf_inherit()?
>
> In include/linux/bpf-cgroup-defs.h, MAX_CGROUP_BPF_ATTACH_TYPE scales
> dynamically based on CGROUP_LSM_NUM. At 300, MAX_CGROUP_BPF_ATTACH_TYPE
> grows to 328 (28 base hooks + 300).
>
> In kernel/bpf/cgroup.c, cgroup_bpf_inherit() computes NR as
> ARRAY_SIZE(cgrp->bpf.effective) and declares a local stack array:
>
> kernel/bpf/cgroup.c:cgroup_bpf_inherit() {
>         ...
>         #define NR ARRAY_SIZE(cgrp->bpf.effective)
>         struct bpf_prog_array *arrays[NR] =3D {};
>         ...
> }
>
> On 64-bit architectures, this array of pointers would consume 2624 bytes
> (328 * 8) on the stack. Does this exceed the standard CONFIG_FRAME_WARN
> limits and risk build failures or runtime stack overflows?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506150547.76=
7315-1-paulhoussel2@gmail.com?part=3D1
