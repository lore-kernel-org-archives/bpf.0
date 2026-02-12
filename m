Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AFE2580D1
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 18:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770921444; cv=pass; b=hkJTHw9iBW2F8mB9C6H2061iKL2ZN6UxyLRMVC6826tAGnVBDU3T98J+ur0hN+gnUy6IdXT7QEUWZYNWyu3hptdjfzLX6S4fpaN/R/WKsbN6OXSzG9+wMGRrTqIWFdXnW5/ihSAwUwWObzHgU0d58nuZSdAvlnH6BCx7Agv+RIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770921444; c=relaxed/simple;
	bh=8RSIkLh4GsoooN/yb1oGir5mc9kJx1x8aBpmeC22QhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyvTl2I/7McwCjqYpizwBUevELhwe0ThmgeUrpb3EyK65dlAY+TR4CyVAEiUeMQxmkJ/G5kXK/hr3aA8vJC6pLMmAXr6M4YqS6qVdhGAYsEIWfLUY0cvGEd3RHLo+fj1CySINmPs+S1q/ruh6sZZbP1ZBtPfDq3QowaKmZi7e/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b77Wba/m; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b77Wba/m"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso1251245e9.1
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 10:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770921441; cv=none;
        d=google.com; s=arc-20240605;
        b=K6NJXFcBsETyMzlTwEXItuF4XuT/8RdXQH0RrG076lbmZn/uG67PLl/D6ObFehXGEW
         hXRVLGOxBW2Mqk/GU/XI/aDo98OKB3MdnE4iDCvJtvJAvgRhurGcKWuMJeEJhbZoGO8K
         zck25Lx+0yQcZunBPxoO61/K9oetWII7cfj9Hu4O7DPYlqMZb6DGtdIBC+hWnQgiEBnv
         oYLVhE6pnTK16zmwb6XpwtBPYZAQwBwoz/Fn0/0yNd3glY9mnqPmxEJjA+LV7dvWtCt+
         qzCYOXI8DgKHGOKtzvwXbAhDD3ArblJlu60rxT1Mz9g6fU5rPiG+uSesX1FNPzgRCbNm
         7eSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WLnTkMoihnLKB9Wj8wWo21U9EDR8kDp4XW1jqwP0b5c=;
        fh=ZLGt8C9NED3BoUXhQbDdKP85091iG5xiWdPX4KHcZLY=;
        b=MS9B8fRB+DTavzKTZMEouWlqGqiKHot9UWL8mW9A3ibFfjmC9vL7HADdO9H/SUa7HC
         FI6mobjwaeibvxSQENvgzRTmtOS1rPjCi1GJuwoa4YOeTlN2Tz+9owmKrpH6HrPNulHZ
         4nt9/3hHmu+Yh9UEHki6dCiToydLrab44pdKzzWfHAzJHam1mnQ9o2gm0bm8q/UPcltW
         CMXgCSQYSDDNrpmTirLyiVfnx69gVG9WKdi5TnicA10mgVzPwRKABWGMDU+JLExkzGG5
         HDqx0MPrLskyCNeJin9z9/86q8Vvzh3bj5ZVYkey7kOYJt5cQs0DWUbu2dZ68oxer0ut
         IPvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770921441; x=1771526241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLnTkMoihnLKB9Wj8wWo21U9EDR8kDp4XW1jqwP0b5c=;
        b=b77Wba/mziic6qB7uGMNXbXpJc7nNoJBDh8Jit1CjeMPcVf5adEtb7vnXpWnUi1MH9
         1cQmL+kcf1az9pl7CN3vIq06T3u/teZdKXqHFaDePC3oR6Etl/Tj/t8ye+NSuXbgV5bI
         +33tL1THI4Ep3eGxaf+qRhG51Cfqxqzl9KCIpXPull0zSC7TawIxWBY5LfsgCcDtw2TO
         CNtiovfkWa9CsRri1/yiGtq2l/HfG4oDWsOuUqrh+KRP8qZ6jzToRAtVCDT9IACQ87LO
         7dE9FhXR2vjTVr3nAGJmAowku3lg0PkoFFFadISBczQouNBPeZon1Z/LtttRupIWyypP
         RhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770921441; x=1771526241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLnTkMoihnLKB9Wj8wWo21U9EDR8kDp4XW1jqwP0b5c=;
        b=FunLl1Ehr7ykVg9QMRwy0G6mPkquv8xVziTbZbZfyaZdVqo0HBMGKR9MUY0h9Fk+7A
         VXmfb4jWlDaVMpxjOjbpK15NlvLP2VNRHHnP0N9CTit3B7mSxCsD/DB+H0pbWNH2L/K6
         Jm/EEsKQKRrbD1GB8Z881e2aCAv7kXUqFMpakmCZxhsAdDZ05tjsWh8vA+TP35fdFaCa
         U4ykXdEQfxHj64iU5BROcuSIexuw3JzRXwZxWqjkMQx2uUUy7mrnuNrvte/m427aOrXn
         MdzXASUA3but77RM3jY/9DJcYUnEQoy/4vg215M3CtqlYGqEORd88WRPF11+oz97WRM8
         fdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZEKJ4qP62TKp/C1WlEZlNb7U1MfamMW6714lg0HfRNLEC92qB4zrl2RUDbcGCUZNCiT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9pk1oMTndSjWglVuNHxUGn6It+ypcLxj8LLVzirTXkYQA5BIF
	7yeb7j0UcDefZZE8xjnQ15w5jDlM37mBscih2tiHlQFTiLTawUOeWVv1qTr2m3C4CzBCr3UvlNq
	Txn4o4ZEIjOsRJ4JZwLRgSJ2Wb1LGIc8=
X-Gm-Gg: AZuq6aIm950lEpED8LeJpg11BS/UrJpieIm9n8WzaJTK2TjhDbT5Xg9CqsVg+hyPS7e
	3m3SPG1ifAC6rdawbtSTU0s8Q/Ss7WmiYzgu8bQ8Ubi2g7SfGcncOBbzjivP1xMnsLVzyyISzGw
	MdK22JhIbqumzOCnVl+PrN/Bc00/lYX/Mb8K0pji25qNSFS+oO7Rc1O4ANToa1i6CJ7FjEdTlu8
	xnUR1eXm3uRF6FETWXTsbMKC/dXaBjd/AT6fAC/SIm2Yc6GGsk4dt9CAbaXmBzzmt9GR/SXPgrd
	CvzpZ28oWITe7JnwPin9jAR2BAJYftUeujDuh0xmdDZi4tLPbn9fQxkz58qTY7ovr0iCGqQ5qBU
	eleLcntpj
X-Received: by 2002:a05:600c:4584:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-4837103f325mr1212805e9.25.1770921441384; Thu, 12 Feb 2026
 10:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aY3+Raf8eZqipCd6@e129823.arm.com> <CAADnVQ+D7v+sGFFyTfSxFSEEcnGV111NeSaVtASYHfP-mDnV4w@mail.gmail.com>
 <aY4Vipl+4rGa+u6D@e129823.arm.com>
In-Reply-To: <aY4Vipl+4rGa+u6D@e129823.arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Feb 2026 10:37:10 -0800
X-Gm-Features: AZwV_Qh2H9arrkEzFgzvlw2KMGFV_EufEVAdwcgyUIVoqVCpCV_6wxWLmvz8MGY
Message-ID: <CAADnVQ+ad1Eu34hS21HNLgzA5eeFHMvQmoC33xKpP0z247MaHA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] eBPF isolation with pkeys
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, david@kernel.org, 
	ryan.roberts@arm.com, kevin.brodsky@arm.com, sebastian.osterlund@intel.com, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 10:03=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> =
wrote:
>
> Hi Alexei,
>
> > On Thu, Feb 12, 2026 at 8:24=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.co=
m> wrote:
> > >
> > > Hi all,
> > >
> > > I would like to propose the topic of eBPF isolation with pkeys at the
> > > upcoming LSF/MM/BPF summit.
> > >
> > >
> > > Background
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Today, eBPF programs provide powerful capabilities to extend kernel
> > > functionality without requiring modifications to the kernel itself.
> > > These capabilities are largely enabled by the eBPF verifier, which
> > > enforces memory safety and other constraints to protect the kernel.
> > >
> > > However, vulnerabilities in the verifier have repeatedly demonstrated=
 that
> > > eBPF programs can also become a serious attack surface.  In several c=
ases,
> > > flaws in verifier logic have allowed malicious eBPF programs to bypas=
s
> > > safety guarantees and compromise kernel security.
> >
> > eBPF was restricted to root for many years, so the above is simply not =
true.
> >
> > > Representative CVEs include:
> > >
> > >      - CVE-2020-8835   [1]
> > >      - CVE-2021-3490   [2]
> > >      - CVE-2022-23222  [3]
> > >      - CVE-2023-2163   [4]
> >
> > None of them are security issues. They're just bugs.
> > Like all those found by syzbot.
> >
> > > An RFC series is planned for around Q2 2026, and the experimental
> > > implementations for eBPF isolation with pkey and pkey-aware memory
> > > allocators have already been completed internally.  Using these
> > > implementations, we verified that eBPF programs running under isolati=
on
> > > successfully execute several sched_ext applications provided by
> > > tools/sched_ext, as well as some bpf kselftest cases.
> >
> > The stated goal is wrong, hence not interested in patches
> > or discussion at lsfmm.
> >
> > arm has a nice hw feature. Sure, but this is not a place to apply it.
>
> That is correct =E2=80=94 this is a verifier bug.
> However, the concern is that such a bug can lead to a security incident.
> Not only root, but also users with CAP_BPF who are allowed to
> load eBPF programs could potentially trigger additional security issues
> through such bugs.

Again. They are not security issues. cap_bpf is effectively root.
Just like cap_perfmon in tracing space is a root.
