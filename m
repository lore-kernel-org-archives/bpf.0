Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41D389119
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678346; cv=pass; b=INcE3uJVd7SjrHhVOYNJ5DQWAmEftSz1OMiVGixckipN76enHZV2FzH4RtQMn5iGBh7xWU4x8qCOf5ULPzMPj6583kVWE02NjqWNU+BN5txAEVIrZGKl4oChcLDpeL3qDzgruGyTSxygXCTa3npKIPH92VWvfEfT5iZehrQNtOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678346; c=relaxed/simple;
	bh=l646A2DJpxLHWhUlafz8BAEG81Z7/Fla7mihDT7/3U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+bEaQzTxOu31moeE1YZdpY2nuFwTXCv1dADrVY/1PT5dcRHJX9vSpiiaAWnOxwQsFJ4YfI7miIXGEoEGjwg+WERQdrTsl+NRwavdyLqc6JFbiQWGeHbnaSlocaS4ZWpzCgmQvcWb6Kfy2rPoFfrGLPPqvhVNpdNF1fbuZvzAQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efzBtQvQ; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efzBtQvQ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67652913ecaso650537a12.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 02:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776678343; cv=none;
        d=google.com; s=arc-20240605;
        b=G/zJpSS+XcLmVJBj0AbyOcadDWSLfxOImzE+YpKhp2NCJxua1aNNgMkr7sfeZNqqIQ
         lM2QZkeS6lEMTuSwXYQxAEjpaBO+or0wNFHsoBpCGG2kG+k6OVBE4ZsKdV6WnDMg7cs6
         cxx9VUB9sm2zpxrcq1hv8pKaYCmF/vvBFpHBLSex9d4qWxiiGHOct1GPaZtz+ocRQo/6
         LiCNkdYjKdvNnM0KeSHFyo3mSFzTsmk6v4gBDCsvQSFegHs0+kR50zJv30d+V/DUkaUN
         gimVgqCfYBqQ3jouTvfr8mRIZG9ndSuBN0vo30LvwwNR0axb+S0QdMzo7VgL8NVPKmG/
         P/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eIcJ6CqEDeaEo1s5ZWWP73X1NftkDojmRTKRu5MMU38=;
        fh=HXbcEZHbWInpzx0obK2KGWIsFkdCHM0Z/NTfXl8r8k8=;
        b=Y6U6mw19UZEjEg6Dpey+DaOQFaFzgwopyMHQRw+eyrPsv5QHoaPObcgE9e7KePefKJ
         Z04mrOhMsc/TDa+xabCRP8XCZZ2FqgGeAKLtz8V7bI0S2WAux8juWduJZuE4A334SyDA
         ygIfexJ1b3LVzBXepGnQxf7qpEYQNkcVCwtr07SQwGz6UqSXeLHMNxJ3a9q4WDwZ+LGE
         UNGmMq1QSDZVaOZ+G60jTyZLSqlk34mADfYJE7cuNT8RofyAioe6n9rqr1BMo01+0FB6
         2FMaukZhI7e2lncBeHqxqJryN+cKU4LGCf2IJ6ZJeNkWDFrFi480s6i0Z1wugUyD1C5k
         VqnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776678343; x=1777283143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIcJ6CqEDeaEo1s5ZWWP73X1NftkDojmRTKRu5MMU38=;
        b=efzBtQvQGjs22n+Lt1tWagzUh7hzaMa0SWD28DbCbcju4nR4LXYikcwXJ/+Ln0QJgm
         pYAGJJHmDamE8CoCP1e87/z2a+I0uVOqLmyN4wOFG7EGUXZdczEsWiVbO4tgU1J9oTG1
         Q1BmZUnEZK+j/K6I8zG6NvFtwpZFUEG+tULYuR7oOj21GBFtiZ2SYcc+OAzgXekcACHX
         OPbwZGKbbyRAozDMz/PkHjaggPmeuw9SV+YzAyd9Up5c2UOOeoNrS02wD22znhMKMlMJ
         e/rQTd0vs5Ilj0BBRgY+J6nLGp0d5toXopzN9NhsVJFzdDfYhvE3xzp592yQb4+jkRBZ
         e1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776678343; x=1777283143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eIcJ6CqEDeaEo1s5ZWWP73X1NftkDojmRTKRu5MMU38=;
        b=paY+o7Gw15zVCHQFeng9Gtv4tcZLh5o6FPkSB0bak3016nlFZwBxqFCGQm6ZP5jdoM
         V4Dvdzvksrm+6niUnJyU2urkCWkbxksajMwqqt020lXh2o+YUo1nrMBjrzbKAHfBCNak
         vXZWOZdjVGQL6LkSdRvR1YqGGszhPq07w9N9PmCQbENSJU6Sx1x+0ug1Q72APsANCeJM
         xo9S73gyavMvkTAda0E08aKffuW1J5uVDGIM3E+sxSdFBEPJ6oP9wao+av6Hb3kL0rWt
         VRgRwDPuMCZ/nQE9XZUBQ4vqSoWxHa1jaXbKPOlxT6K+jMP7W9/WW6xp184v1cWnm8cq
         J/TA==
X-Gm-Message-State: AOJu0YziBbpCboz48QzzJEeHaxvzSQzG3Xd1Qf45gzjL6KeFICw3Bu8n
	6Wq0PfFpun4mETlxdoywHaPaP/aMJy/QmgHtj2WByJnEXqbGxUfmwx28SRk+Lw5y/Ku3n4L+ojS
	GdKx8PaSmLeeFnvzd15mmg3LUFuFPjd7ck+Onyo4=
X-Gm-Gg: AeBDietKf97toSRpv4ptFEPBY6DPqt7X5e/Rxw2KwpQlVVueE1a5CY3adAtnfn/SGYW
	Ph5s8fQLSVBMwEkjtx1sxbC19xXHNKSqG57w/QKgK+yXmYTdwb3dvP/Bpv+CvZj4J5RuDxGUpP8
	kcPO7BsX/vp+TP+PDHJ8b0e18MJWR3tP+ee2ZnmbaT+ZQ4Ah/sH/L/Q0x25TO4oitbtNqHeve3q
	vxNiuNByvSVbjw0wckdBFiZ0h+9yoZUHdg9cQJt10NmiIWgek+XeybFsWlRCN08tGlpzyej92pF
	HmhZHeNtBgmyHikCI1PAuNt/zIn1MU6YUg==
X-Received: by 2002:a05:6402:e9c:b0:66e:f4c0:c348 with SMTP id
 4fb4d7f45d1cf-672bfd97735mr5039586a12.7.1776678342874; Mon, 20 Apr 2026
 02:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418131614.1501848-1-puranjay@kernel.org> <20260418131614.1501848-7-puranjay@kernel.org>
 <e1e83e9e-8161-4096-8163-21ff3c9ae629@huaweicloud.com>
In-Reply-To: <e1e83e9e-8161-4096-8163-21ff3c9ae629@huaweicloud.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 20 Apr 2026 10:45:30 +0100
X-Gm-Features: AQROBzB3Y7MTXfX5XtHwO64lamo5aSsQawkFcAuMPPUv96bWzMjCmnl32Ikcd60
Message-ID: <CANk7y0hiGg-M6DY2p605je64Yna+C1jrKS1W+k-x8eWn+nmyhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 6/6] bpf, arm64: Add JIT support for cpu time
 counter kfuncs
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 5:03=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 4/18/2026 9:16 PM, Puranjay Mohan wrote:
> > Add ARM64 JIT inlining for bpf_get_cpu_time_counter() and
> > bpf_cpu_time_counter_to_ns() kfuncs.
> >
> > bpf_get_cpu_time_counter() is JIT-inlined as:
> >
> >    ISB                       // serialize instruction stream
> >    MRS Xn, CNTVCT_EL0        // read architected timer counter
> >
> > The ISB before the MRS is required for ordering, matching the kernel's
> > arch_timer_read_cntvct_el0() implementation.
> >
> > On newer CPUs it will be JITed to:
> >
> >    MRS Xn, CNTVCTSS_EL0      // self-synchronized (ISB not needed)
> >
> > bpf_cpu_time_counter_to_ns() is JIT-inlined using mult/shift constants
> > computed at JIT time from the architected timer frequency (CNTFRQ_EL0):
> >
> >    MOV Xtmp, #mult           // load conversion multiplier
> >    MUL Xn, Xarg, Xtmp        // delta_ticks * mult
> >    LSR Xn, Xn, #shift        // >> shift =3D nanoseconds
> >
> > On systems with a 1GHz counter (e.g., Neoverse-V2), mult=3D1 and shift=
=3D0,
> > so the conversion collapses to a single MOV (identity).
> >
>
> ISB triggers pipeline flush and instruction refetch. Since it is a really=
 heavy
> operation, I think We should collect performance data to verify whether t=
he
> jited instructions are actually faster than the original bpf_ktime_get_ns=
().

Okay, I will get data, but shouldn't we still have it as future CPUs
will have CNTVCTSS_EL0 and will not need ISB.
