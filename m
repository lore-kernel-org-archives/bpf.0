Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB82DECA1
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124924; cv=pass; b=qtoa2m0GfNRFut2wXbz2olMvuyvCWYWEU3mLcsceuX+pMzsjhSg1NUSFFxAEfk66lqVJXyLmSFiO20q0/F1xJSOy+hn6nd8nIUMdV9a4OJ66VgvJ/jcd3fJbeI2z5jFDcoQqNXhK0c3mSru9vA3ADMNsHZybTE1cinlBATdQyoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124924; c=relaxed/simple;
	bh=pbA9io0SzkBc/98EVnEzLNsgW1FolpjPWE5S+KN9P14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTn6UOQfsTr4JYW0HSG0z3AtkkRmLedKsDpluH7VxD9wuDsLq275DO/iqK4TpRFRB6SynukykhnWIyN1gVtvaQqSPxI2nR+BTEExbav5PLw1wF3dDHaU06ypZAcnGBSlaq1djCUA9jOnd89DnBtKPdqOkNU8ZaQWZ2YHtijBwp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs/EMucp; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs/EMucp"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bdc947aaa3so3340617b3.0
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 20:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778124921; cv=none;
        d=google.com; s=arc-20240605;
        b=NHpCo95gbla+2mPxmNCfUp6OFli5Q7zBiYhKBA6fsB9J7f1iJO8NtpFh+Uv+99G4KC
         AVjZrLJeYW001Qy+9l5wOe3FFh8biEp2alVxBX9vz+cyj5lcqTez9hW8R9y172u2EZeR
         eJsQBJ2wTEQvWW2ylMQq0jXGJiAM/QHAWrtQQbFomnfjO9kubVZcmApadET0GhCDK2sK
         sUIe7LvKHEIUDlWKOtpkdLtCDg4ZOFVsVl9EOZhCtH9+7f50u/rQ7PMU9nP/+fhDXEiF
         4aUyl1ohOzU/R1f0jv68MoFgUAQSPa98upxDiyxCwuF7QfOyjDn/fs0kzm8iVjb8/Awk
         wuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WsoDCCOTvCGKVlqoF36XX5WM89UtK6Mekm3tMCaOG0Y=;
        fh=EceAX2KroPNANiIrfMOybjWeWPp0Jyjwba7DWCxs3F8=;
        b=HvvQL+ed2u/B4OtRBkI+FCOa6vj4OQ/XedOIaf1j3lz8fTf//uoaZ6+4O3IxBeEEEs
         GIn+N6cVKKfm+Aj3V+fgQCyzlzllmQJuRCJ4WPqgrI+CjvTS35cfcccSLYGw95bypOsw
         6hwndNUoTcjblQZFg5UqyqEX6Y5kOXRstHBZzvOeBjNT1cOMcx7cGy0DcNRgtJx+pG+i
         NupZl9e7WbaHGvqR9+1OUuQwxMq2mdVF6gEgyAogH69F8OkEkpiUN7odVVIBp0jUMeiO
         Zo8P5TqzKkpvdLFeaP7trD/MUsJW0lrXHSgCAFFkf0WsCIwypktM9DSgDG6u75XL4sJL
         hm5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778124921; x=1778729721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsoDCCOTvCGKVlqoF36XX5WM89UtK6Mekm3tMCaOG0Y=;
        b=Xs/EMucpDnwp453QNqJrTLgPqIOffgiciFHgbRfwv1oHHNNJunC3WjiUZBunE0zjxG
         0uFIIiScJkdKaHHRojeVsdop749Zok0y+UjEbfOLXG77e9jm6psk6vYAI9PzdBTry1WT
         Oy2vpMPWC+Wf6HWV38SqQzKYcVmWITRaxNGItZJK9bw6kTJ/bAXTvItytzaBLOVFWdiT
         ivqKBh2aq3l9WHVncfwPmUhZ64Ql//Ha4uhCtqQ/xMYipmo5hwDWaf6fPCIydaqYvLLu
         UCemKO5NzMFqMGPajI+NvqXqaxbtj21vmMYVWdQVH36L4pMcQ9vsT+U367zxzjRCrIXe
         e+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778124921; x=1778729721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WsoDCCOTvCGKVlqoF36XX5WM89UtK6Mekm3tMCaOG0Y=;
        b=g/dCQCZMew8IS8yDx7DBLewkTu+D1GtMA3/c+UuRUrnpg4FnuFRrJS5vCK0BYvjryx
         x9XN/Tpt3etPgfU39GnCsyyJbX2seqw3zivFfBYbTUYaf86eDnYONBe+dsUZlh+OMuXz
         BW2f9ty3t4wx5UP+f6Jpd71m9q09V/kBYUIfVHWlGms7R4I/SBxZOJywzl1Wu4xmRMQ4
         vpuDDI98ruW2FmkrNHGwLZdu84Y7HDqW9QkMYxUYDdMsiJCveDawqJ+8LIeMX5gEOR/o
         r+9uEWfUTvagGit4McAn54LqxvMJcHZJArXYqv0HGmkDZsZc0VteAXn9a/sRzmIN3q4z
         yBwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9U2buWGsowcW9wRxR3fRFPB0KyW1bW/GKqxrPcusY3fQHnE2YpRDAT011Z47MVcD+sZ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHrvkKDTFBVefapgELHRLMyiXDdoHyeA5QL8x6XC2fgOoIwcp
	6zlaGHfik755+vz5SNHhO9N2qSaK8MBenioG1ui047xkTw8XTDhubMV28/sC677FcvXC+W5UBjM
	5bRARxCQx2fb71nS5fYJsqTnSzTT16Znf+Q==
X-Gm-Gg: AeBDieuYNvqqvrVXj4nUvlOnCuaeKNmKOlHaOtlASJoKTkG43/HhC/+YNAzCW3jjzXw
	R8cZ1y6pI5zAUOXVlEc0wqc0P9IILguKcUOUub+mp5NhboSFggrNpSzSnjaDaJvDyXF1Br5FGRP
	xPKxXl9woMwNoKIRx8u4Ez+SGfafDlbTvMqNpBH7cXBXHqGJLwrgXB0OjU7ILW1LFXjyeOjclMm
	yKtXU99VTRZvuc3kqYHdQuaztuFznPIK1h4rCyDk1FwPS5Lib7lDQTHjTJfWGYR6UvOUwKo+zvM
	SgYpikM1EsAs/rdvFwmIsrZfDxrX6XjkfGvBHiaHXhSqSLFjpHE=
X-Received: by 2002:a05:690c:360a:b0:7ba:ee75:f115 with SMTP id
 00721157ae682-7bdf5d8d6eamr75144787b3.4.1778124921401; Wed, 06 May 2026
 20:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165024.1526680-1-vernon2gm@gmail.com>
In-Reply-To: <20260503165024.1526680-1-vernon2gm@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 7 May 2026 11:34:45 +0800
X-Gm-Features: AVHnY4LDeDA3KXnwe-H_2b98P4hejFpflhbuT3yJizJRa8ybxM-qzZLe9Z0VQ9o
Message-ID: <CALOAHbBx6GuZjj9_EdrAPCsiLJekAiqOVsWQ0muNJh18Nxaqtg@mail.gmail.com>
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

On Mon, May 4, 2026 at 12:52=E2=80=AFAM Vernon Yang <vernon2gm@gmail.com> w=
rote:
>
> From: Vernon Yang <yanglincheng@kylinos.cn>
>
> Hi all,
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> As is well known, a system can simultaneously run multiple different
> scenarios. However, THP is not beneficial in every scenario =E2=80=94 it =
is only
> most suitable for memory-intensive applications that are not sensitive
> to tail latency. For example, Redis, which is sensitive to tail latency,
> is not suitable for THP. But in practice, due to Redis issues, the
> entire THP functionality is often turned off, preventing other scenarios
> from benefiting from it.
>
> There are also some embedded scenarios (e.g. Android) that directly use
> 2MB THP, where the granularity is too large. Therefore, we introduced
> mTHP in v6.8, which supports multiple-size THP. In practice, however, we
> still globally fix a single mTHP size and are unable to automatically
> select different mTHP sizes based on different scenarios.
>
> After testing, it was found that
>
> - When the system has a lot of free memory, it is normal for Redis to
>   use mTHP. performance degradation in Redis only occurs when the system
>   is under high memory pressure.
> - Additionally, when a large number of small-memory processes use mTHP,
>   memory waste is prone to occur, and performance degradation may also
>   happen during fast memory allocation/release.
>
> Previously, "Cgroup-based THP control"[1] was proposed, but it had the
> following issues.
>
> - It breaks the cgroup hierarchy property.
> - Add new THP knobs, making sysadmin's job more complex
>
> Previously, "mm, bpf: BPF-MM, BPF-THP"[2] was proposed, but it had the
> following issues.
>
> - It didn't address the issue on the per-process mode.
> - For global mode, the prctl(PR_SET_THP_DISABLE) has already achieved
>   the same objective, there is no need to add two mechanisms for the
>   same purpose.
> - Attaching st_ops to mm_struct, the same issues that cgroup-bpf once

Hello,

The primary hurdles preventing BPF-THP from being upstreamed are:

- Uncertainty regarding the stable API

  It remains unclear whether the following API is sufficient for
  BPF-THP requirements:

  unsigned long
  bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
                                            unsigned long orders)
  {
      return orders;
  }

- Ongoing integration of cgroups and struct-ops

  Work is still in progress to integrate cgroup support with
struct_ops (see also
https://lore.kernel.org/linux-mm/87cy439x8a.fsf@linux.dev/).
We should wait for this infrastructure to land before introducing
new cgroup-based struct_ops.

>   faced are likely to arise again, e.g. lifetime of cgroup vs bpf, dying
>   cgroups, wq deadlock, etc. It is recommended to use cgroup-bpf for
>   implementation.
> - The test cases are too simplistic, lacking eBPF cases similar to real
>   workloads such as sched_ext.
>
> If I miss some thing, please let me know. Thanks!

BTW, it would be better to include the original authors in the CC
list, especially since their work is cited in your commit message. ;)

--
Regards

Yafang
