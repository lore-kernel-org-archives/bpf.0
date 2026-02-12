Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4326FA6F
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770918264; cv=pass; b=sHAWSJfC7lqSlGNgtT0EIPniZ0RO96iaycxotbTIO/gmIDBGu87dkHnjb7bLlto4C8l7m8K/CBrVES+8u3qj/WYCAUN4w5ne8OCMGfBcl0spssafp6b1TSq6bF8pYyBcXy4q2IV5Q6Mq15vRU1QwJa0h9abR6OeyYMrBgl3pCSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770918264; c=relaxed/simple;
	bh=ckwsFsrtzMifi8mp6Op5CdeLWKGNZ53TOr+sUNWqTdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbnFQ6d4s6CtTdLqaxZtWAZnh1BSpspP50YlRK+EXhrhlIIu+1qgt46ga0OUMtyMAUszeOQseyZUGZOrl9hdKiu7N5Of9Lpc/QO8lbDseReS0kXjg0J7z+XSGtNjSjcy5xGh5WasWRx7eJAmumBX5NVCLevrlK72Dy6JI26NEKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksL86KHd; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksL86KHd"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so884415e9.2
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 09:44:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770918262; cv=none;
        d=google.com; s=arc-20240605;
        b=HtkH7NZlPNsy4fAoL3/1YPBpqaN70V2KLvcQWER5T4Bgk/d6tN0IJphp8NpsgetrjL
         D5gSI/HzmSMemkBIaECNXTEFXBtKM3UVxjVI6xhSdeS1nEiO1r8SMW8VBwHgI57wQ86m
         q1KUXDr4UVFtTRXEzuCSyLpRihg2jigEWPxJ1z6NdHd7vPUEoO6zKBYMEbBQYfsn5kjW
         AhIIrW0OiFeiYP9Ho+bujk0gqebIKsVA80dl/QyXhRTMEd5ZXscGG0UXZHqJ1MmFPGsx
         zLKJhr1gf/ucGcGmcpaqUmlx18D9SYrsA51T+nFDkq8zetfBMlYd/a6Y6oheg9G0IdBf
         LRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QFFjrxG71DJpPae2K/LJY4449yAyo95qp5kuW3/y324=;
        fh=e3FcfBx0KYoX71hSMvUmxWaZ6F9c8JRQj/HiAPXU91w=;
        b=KB8NjlrohVhaiRF/zx/ItQOPP7ewCBmwMwj2LHKMotrAaiyxGsUYK2CXSTYJH/YCJS
         pPUNLwHT+cq2I0LwHPxp4+W9ABVZeoi+vLu0ki06P7YGJhHKEC/HhYOVjC0vP6N4fM+V
         wXDe+/TJNmukzTR6/zHZOeato4AA1MUBqfoRSc2NmgYV5sYpTwuNcxDYIreajMJjhAZ5
         E484R/0T+X10ETelPqe7nHhT7ufZGmwK4xdq2HbOztfxDk+XFvGJW4jviXSN9gZ4SBqL
         e4nThJwyUbRrDtXu+CuSngy9JCwL8NbSAzhT79bDOLIbWE/7pKE9LBhjc9b1XBCp8jr+
         sXPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770918262; x=1771523062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFFjrxG71DJpPae2K/LJY4449yAyo95qp5kuW3/y324=;
        b=ksL86KHdAvroWYWvfys7GOwHrh+Y2kUesTi2uveN1IzKLtaQMifW3dn58sHQU/wlPW
         rGw2Lu/gnhjhC2M/P/6zRuvpnAZHZWgb2fFFW6A/cXWC0/CvyConlIsZ+RGGVQn3i5RK
         YqTaqHJWz58Li5C5nhHMzebqkC7tkKmJ61bE8CZR55uWqXOuqTWT+A2RmzmQe2KSf45y
         gGdCUrhSGCRu4dOoRGand5BVUGjBG2DPs1L3nImogHAqsGu7aqiTsTReHw7XiHwQsBmF
         bPo7fjdHiGC0ovRUawD+kaxidAnlOdm0mAMcMVA4yPiEDkPPBRV3l9DBvTorzF9U5rR1
         Eq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770918262; x=1771523062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QFFjrxG71DJpPae2K/LJY4449yAyo95qp5kuW3/y324=;
        b=UvPineyua6FiGmfopAr8k0M0f2Zfe9bbk49M+/Ln6Oj7O7tunX/iLN11b+C+dd8c5u
         j0VSyLwZu8OQVwgNeVniLWyPnAC7PYLEmxLkjMy+VGvV8R1MBpAwpUCY2i+U/TGkYkj2
         mpBDAHNxMXG7bR9CssydRMrG3Hy887+cpCAP/sRfh+Spq4smHK7EJp6C+TWxyisX4ceU
         Tus0YixoSMsrnDcOrk2js1yMSTG+ATqjhONc9XAnPwdTcutMbQrNUKT+GemSUSmVKrWm
         PMvlrk+8yrIS4Dsj1dsA/QfckYmRPbK8YXEvXSoUPiEfPzsMoA73nTlYwbtzERO7He/y
         /huA==
X-Forwarded-Encrypted: i=1; AJvYcCUQhbwbHl+PRg7iahhLiolV+HNQSxZkTVvND1lQiMKeEMAlChNL/QgwLs+2z4AA9U16bf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlaGdE9w8Grkw6o7LzOLWMRlxHMH8yFaDov4aEcQjC/qaW3UN
	5GGJcI6CjPhPgunRFJPy30WEMllf65HSJnaNMSO253zx3ibwX0viLPfsL9fcrLKkO6moOCy2Btj
	lssBRzLcdSZJscbDXuB8m4CpckS4KCW0=
X-Gm-Gg: AZuq6aIwPpsDaH+q9Gctqb8sJryJ6DI3F/g5A98dW/BHComOWarVNE7T70YYH+sv4Kt
	FLzUo4quJUdq4no4KArT5erMBuViayUP9rGPQPcza05GTMDInAzsyNzUeO0aKNCyuhN7TMwQuPC
	60bY5BqtC4nHyNn5lwFbmqN9RmIxZmfzMiqE8AnRD6eX63SOVjM5enuOYr/Dy02hJgbbvrMWR+w
	GlQxYU7o8POCXtckzMTy1hkGIj6YHzMkl8glK7AmHDoaYCBgW6OzIUJvnCSPhkf2ARx355WvsDO
	5KAb9gscL9nvXeGw8B4IWzKxixqsmBclmK/zpBFpDG0+6V6wV6QYX6VqMQVk+vTWoU8hxN5y3SO
	hD4Hv9GglfFGEL5C0YjU=
X-Received: by 2002:a05:600c:3548:b0:477:7a53:f493 with SMTP id
 5b1f17b1804b1-48367159cc1mr42571855e9.23.1770918261616; Thu, 12 Feb 2026
 09:44:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aY3+Raf8eZqipCd6@e129823.arm.com>
In-Reply-To: <aY3+Raf8eZqipCd6@e129823.arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Feb 2026 09:44:09 -0800
X-Gm-Features: AZwV_QhQb3K_2kIegArK5OmwapFG8qQD-DB5OVXdcFX_fAH3CfXObNoqOzuPBt4
Message-ID: <CAADnVQ+D7v+sGFFyTfSxFSEEcnGV111NeSaVtASYHfP-mDnV4w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] eBPF isolation with pkeys
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, david@kernel.org, 
	ryan.roberts@arm.com, kevin.brodsky@arm.com, sebastian.osterlund@intel.com, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 8:24=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> Hi all,
>
> I would like to propose the topic of eBPF isolation with pkeys at the
> upcoming LSF/MM/BPF summit.
>
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Today, eBPF programs provide powerful capabilities to extend kernel
> functionality without requiring modifications to the kernel itself.
> These capabilities are largely enabled by the eBPF verifier, which
> enforces memory safety and other constraints to protect the kernel.
>
> However, vulnerabilities in the verifier have repeatedly demonstrated tha=
t
> eBPF programs can also become a serious attack surface.  In several cases=
,
> flaws in verifier logic have allowed malicious eBPF programs to bypass
> safety guarantees and compromise kernel security.

eBPF was restricted to root for many years, so the above is simply not true=
.

> Representative CVEs include:
>
>      - CVE-2020-8835   [1]
>      - CVE-2021-3490   [2]
>      - CVE-2022-23222  [3]
>      - CVE-2023-2163   [4]

None of them are security issues. They're just bugs.
Like all those found by syzbot.

> An RFC series is planned for around Q2 2026, and the experimental
> implementations for eBPF isolation with pkey and pkey-aware memory
> allocators have already been completed internally.  Using these
> implementations, we verified that eBPF programs running under isolation
> successfully execute several sched_ext applications provided by
> tools/sched_ext, as well as some bpf kselftest cases.

The stated goal is wrong, hence not interested in patches
or discussion at lsfmm.

arm has a nice hw feature. Sure, but this is not a place to apply it.
