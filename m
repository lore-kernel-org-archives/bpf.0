Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CF37AA9F
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731243; cv=pass; b=mloIlOxpH51JclSIJMqP0t8TcsEZ/c0stQrYkPkE4PjsSMbsW1nswRNPQU/zeDBW+PMKTkz2WyP7HnOyqWIqJqxVJTGWu5js549oaPPh8dYGybyfJdYVAtv7PjDUo+7eTctoPAKSLJ5UGXj2XFTW/KQj9znTykhZofABXAFhzhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731243; c=relaxed/simple;
	bh=XYYQ1CkouFoNOt0Tx/Cg7S0bHa+2ABhuSVPr6hCz5wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCYQIKpgox7ajW8XzbvcFh0wi7hjqAATaJPldEBWjO/oIMATntpZcri+ZByYFS3yc4B3gV/9NMZTa3ipA08XgY+8My9FgQeAYHbcL23h6pF1uhYqih1A7at0YxAFBO0Q0gkLjBCfItqBARSUpL4ynUaZsXWOMO6ZqNGeNCOHWNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBULqHFG; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBULqHFG"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so1015444a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 03:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775731241; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZv6C4sYEVgqxyk9oK2vo3glWfRSr/Kq8WK9p/AcByQHWxUuBfwhEEs35a5707mh4I
         hftgGl0l+s+1MVphCpWr6bqsMNXwPePn4iQC05QnrmMl58MyXOOh27baWRekzhgMrkCN
         THhWFrjUd3rcUHeSYjNRKXpAxixIRi0lUlA245p6B4pKNBId6UtA2e6U2EPUnCQNx/f+
         cIBJB5mv9p3T0NrXz6j0tol9zPXNHadBqEyqjCvKiQVtk50jCxn9cxq9x1qG4OpN1Q/A
         8UDpA3GGuABnvrehjlWJq6b4cVamYvH3M++30jZ/rJgDwXg1xmKkls/bamdALmQXKstW
         5GFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XYYQ1CkouFoNOt0Tx/Cg7S0bHa+2ABhuSVPr6hCz5wY=;
        fh=gAD2g8rCWF1nFJFjqtSy7Lo62gUfV8G3i5MZqVBB2T4=;
        b=XOkNL9S2HYRFU5aVVPs3NXFsLSo1qsWrSjru7ytOaWo7yXB8B124i0qsWawBx3Ue2J
         jEXW5IvbQT9sPhZLkoDmR+uq5AS6gN+R8CCOSmdHPsPlQv7+33hwgN5R5GW7lek8pObP
         l2QLhsHgjDKc4eNthUcblPbtCBzkHZ06eFTdfTYYnDrScwUAVqrSyxMDr3gLySRuRnhz
         eD3+416qumXsoqVZSuqIhMPKm9ClQxELURF88Ni/mppbmLxC68cSAQWKL/qcnJ2Vx22C
         +/W9I8zzp4QlDyyk9aQQuvfnkOHzgASnwTAdv/hJbiAN39PzmSXLSd2lpPNY1PPkpS5o
         XoKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775731241; x=1776336041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYYQ1CkouFoNOt0Tx/Cg7S0bHa+2ABhuSVPr6hCz5wY=;
        b=tBULqHFGf8HqfVrbttOCcfUC1PpD+hSuY9mzAlDCKKQZN52ZSts+Z1/TxneX5j73vd
         eP6FaGJ/dDarNTsr0AX5w1AoxcSy7PkaqTdN7gbcAjCnCIjLdey1525VJ1LbpL/Y8gIv
         WYwwCDBpeQixiExu9jGUYnkkl79KAJdxI4YtEVE6Drq0OGkj7l7wUtT+YyZKpBCG+bsw
         zYHFHdRiY5mDsQbhLmnpXBsDY9MJ6ZgpcY/c/RdWqLPn1TDJp0p3uDm8BfL6u+KisBD/
         4FH47mAzRcsDcjmz7krkVvvXE+wLEAQwu6QyGQpBIeyV+ciEW9uU/ubBtxqHssxdVXQw
         QhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775731241; x=1776336041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XYYQ1CkouFoNOt0Tx/Cg7S0bHa+2ABhuSVPr6hCz5wY=;
        b=Ef3regBu7E8tiy8JRTg7jrEvO8h6gluPej5Ft4cjgyEpDx+lwR39xGJGaKqYcQyWtT
         p99jJ7L9mRehT/Xt8v+zTYj4Rsta0SJdH/70klToMADpVIUE3aJI/22iwOe5KMypCZIx
         J8JkFMvbf2sKuISkS/gTLZd2x6L3wuzEYMeedO/sYxblh6E8Hbw+7NXC62ASTBT1Tsbj
         +cJTGJ+/dGCaS1qJ3lQS7scCjF5d1zZ6O6vvcxDgplmVL/+R4KBsSnKH7dWLMVZ59+Xk
         dKAHWaMZ9vSeiRtH9fyUylejK9kjSwSwNQ2e1YeqW1BVaCAPRGJCFh0SS2mrtMD9ncjm
         0CAA==
X-Forwarded-Encrypted: i=1; AJvYcCXy0xJZSqpTWAkPcnOgm7S/ms5DJDP6eM/UR6NLXdqtz3fv0oo/FpEHci2PiAlUj5wP1pU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6sO61XVCVaQzOYtsi3h9BApxqRhjI/Ind9qiRXFAUFDvTU9mV
	cRQKP5W07e8/LgK+hV5e6uE0OKJz7chH/P4e0nyefCnecnfuwtFiEYKJDdteXQQ7dbJkXTsWLBs
	VIO8deGUEyPTz9/NXtFekoXGdX918drg=
X-Gm-Gg: AeBDietOvrmZJ2se8hvyp6+KqwP1L68wRnM2ztIEIu0H9faWU2O/KIgHeRaVHgZPuZq
	HHgicdIqJWbJzvDuyqkqUKfTcmrOdX6nN3JMg+5YsTdOJ5qLhAh0wjZwqNsIT2+WBs0WK6ZBAYz
	Bvh2ek6Dt9r629hnKRk2WhPyVsgbGfANPO1Tmogid2uNRygpsXWz1wx60b5v5ReVPTBHx53S3fO
	a+9/XYqC+xqpnZWBT9eyJjW8RcrXffgdV7HATgjYUhd0Arnk3Z51TSvuVzz0R8URTZAAbBfeESu
	HMfbL+frEMHwprmj4Pl5p+M=
X-Received: by 2002:a05:6402:280d:b0:66e:bad4:3f52 with SMTP id
 4fb4d7f45d1cf-66ebad4406bmr8374447a12.2.1775731240738; Thu, 09 Apr 2026
 03:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-9-emil@etsalapatis.com>
 <CAADnVQKnHXg0YnuLvzfXjszMaqugpMNWD5=ipffWS4GVNg6rFQ@mail.gmail.com>
 <DHO7PDYZAY17.1I9BCM8TQWIJP@etsalapatis.com> <CAADnVQLdhjd_owgNxxyP_ozk2R6NX_UR-ZgnpF=2PFnUJYNp9g@mail.gmail.com>
 <CANk7y0gqT0CdTp5-_+YgbYjmoS4pwKcXutpGD-_XJMX2ZLCpeA@mail.gmail.com>
In-Reply-To: <CANk7y0gqT0CdTp5-_+YgbYjmoS4pwKcXutpGD-_XJMX2ZLCpeA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 9 Apr 2026 11:40:28 +0100
X-Gm-Features: AQROBzC35j1V_0eazGGIzfy9FG5hVORFXmXM4tFbHrkjjAx-NtILjsY8fMURsyU
Message-ID: <CANk7y0j7FewAW=vima2kKPeoABcYvnyA_f47Px9t+KdMyW0G7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 8/9] selftests/bpf: Add buddy allocator for libarena
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 11:25=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Thu, Apr 9, 2026 at 3:34=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Apr 8, 2026 at 5:53=E2=80=AFPM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
> > >
> > > > BUDDY_CHUNK_ITEMS is used like NULL ?
> > > > The header is u32 + u32. Is it really worth saving 8 bytes?
> > > > Use two proper pointers?
> > > > How many headers are there?
> > > >
> > >
> > > This is to make memory corruption harder and keep ASAN effective.
> > > The headers are actually embedded only in free blocks, so they're
> > > not taking any extra space. However, turning them into pointers means
> > > that for 16 byte blocks they occupy the very beginning of the block.
> > >
> > > When the previous block has an off-by-one it immediately corrupts the
> > > allocator freelist. Worse, if the header is at the beginning of the
> > > block then we can't catch the corruption with ASAN: The header must
> > > stay unpoisoned since we have to read/write it while the block is fre=
e.
> > >
> > > Since these are arena pointers maybe we can store them by turning the=
m
> > > back into address 0 scalars to both be able to do regular pointers an=
d
> > > pack them into 8 bytes?
> >
> > that probably will be even less readable.
> > Ok. let's keep them idx for now.
> >
> > btw, please trim your replies.
> > gmail sucks in viewing/replying to long emails.
> >
> > >
> > > By the way, we're calling bpf_arena_alloc_pages without the lock beca=
use
> > > allocations of the order of ~1MiB fail when we take the lock (which i=
s
> > > fine imo, it makes sense that the nonsleeping path isn't able to sati=
sfy
> > > large allocations).
> >
> > That's weird.
> >
> > Puranjay,
> > that shouldn't be happening. What's causing this 1m issue?
>
> Emil,
>
> On the system where it fails to allocate 1MB in a non-sleepable
> context, how much total RAM does that system have?
>
> We have had problems like this when system memory is low, there is
> high Zone Lock Contention, see:
> https://lore.kernel.org/all/CANk7y0jsWjt4VMbCza7TOLLXSVtGA=3DMDNVj3roTrwG=
=3DZMhcG3w@mail.gmail.com/
>
> If you have more than 4G of memory and it is still failing then I will
> spend more time debugging the exact reason and see what we can do
> about it.
>
> Thanks,
> Puranjay

I tried allocating 1M memory on arm64 which means 16 pages (PAGE_SIZE
=3D 65536) and I couldn't make it fail, if you share the exact scenario
where it is failing, I can debug it better.
Let me try to change page size to 4KB and see, that would mean 1M =3D
256 pages and more calls to alloc_pages_nolock(), maybe it fails then.
