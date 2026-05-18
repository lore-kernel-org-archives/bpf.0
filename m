Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD03126C2
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146775; cv=none; b=XUN3MPZr2lLIjHMIZ9R5wLHe4tEsfst/iIVAPGKOEZwk04TQ5WdWQ0ymdCEjBZcHs/6WVbBlRsqsJKa3/3mI2ibh3oI9uSt1Cm/1JMBavrsNnSpsAjwt/mr5YZKKCfcLFxpU3T2k7quzsdBWpmXIVGuECqqZDxHDwdJYXZNLtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146775; c=relaxed/simple;
	bh=0kYTwvcQTSXqGCDcUvwL/fysNGrf0hmcI8+XhRcCZRQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Yg13DPKepRlLU8H42sxCz+L+QU+UMdZWhpOZ/f5D+Q4onjYUUpu+8N+1ex/iC5fRrkeDv++wjdJav6itzQ5rO4GrM8I8xxE1D+WR36wgoNi4K/sy5Sw2iug6w1+OqWcbf29cbFYQRGAk6gWoWGdWVZlv7xdRaAKVbK/qusHj0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS2i8Cme; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS2i8Cme"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65e170f1ca5so2981466d50.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779146773; x=1779751573; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJpF8zNQx3fuLJ61e34VmvRInkcEmUUj8JXY5zhxM5M=;
        b=YS2i8CmeIMKZGmw1wt3gOYQOO/ga3y/EioMEEgV6o4U1uEpymU3ZGD3HX+UgW1p8zB
         JzpjskpL3N/4ijrI/prJ+SGGhVM4PoQfmwuxNOeO/cnMJv8wNvxA4QLL4ADq03NQdDIz
         nn4tVtMCQs2ZV1R3BAGd2wKFoeAC9pY/vueKnRNLLW61zB1IJ5gGFIuZqahz5UJ73g0P
         kyqDJkMVKJYsq1ZXY46iswuXnjzeai5/v5Z6whfe8GNmQeytEPiIYo4fiodukvUrwxq6
         jycrPsGrGHbNGHQelkDfjnTYleC3RepBrP7GjYA5KaQiNh8MlrqH3uz8eli4UMUJ7T4d
         fOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146773; x=1779751573;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJpF8zNQx3fuLJ61e34VmvRInkcEmUUj8JXY5zhxM5M=;
        b=bscT1h8zkSzO6aQjbPqQ6bWWFNUAL8iVueebyS4qPDrjj6mGoflRIxb/JdX5ewxkGr
         U7WN0MeaKiXQX0kBcbKN3kY0LLbA89rFUgKysHSWrsbfp9n4WQgBMf2jDc89I0hgB5WP
         qdjbSeaPhOu6a6vYGDu/FlCbr5NS95l0Zyc9Yd1/l8m+Ba60kSoaW0BNWeTc+TqHu0MH
         ydZGAUIAG+nsrJGfiVnnGwvnADb3exjOyTDu83iLVw6Qw7XOj7rUkDqpMOAdB881eKi8
         R+TzaiKVsaWI2aqZj5MIO34+aRPTUjva2WeZHGQd8XoXWzYldhftIDP65EiQQCS09QSi
         /7gg==
X-Forwarded-Encrypted: i=1; AFNElJ8Ze0ovT1zboZ44t1VJef02LhcI7aJaG6zRgyo3fWpave7ybMfH1rKwZX4UHx6AKse640k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDsp5E1ZNoGlGF4/70L/DGJkDkinYX24QKzFniR8R755a4Ye2
	YTmaSdRdX2O16+glGqrnTHIG9NbKaRpIIL+43IRH2xjOAqmoBjDBmKYg
X-Gm-Gg: Acq92OEMw7a3h/Nfg2TvfRFa7ajMxLPrGmDby1jivRFFRS3BUgdCtX0AvAklalI06EL
	X72IArbUEe4somfYaE3NyR+MaO1PSfemA9dbRA2vgpsQ1RHL+8TMiIcsklSvG5xXL4onm8t9Ogo
	OdTsZhNq7r/XHgg2IVpfuwUf3SNa97vnwYwz9X1MC6q9nvu3k41gM3fyGqu8RPE14vDjLLa+LxX
	NZrjZIlBmDBjmos3MRg0ZWzQwgS/1x3H+jAx+49xNNHkUAIc+bwK8FDVnJJF3gR0XkmykuUBafr
	hLhvekbUR2B4xPTGo1ryheLcTo9uk1wgph+qXbNLwv5WmhjtHlDg8ijtu1MZ1T31sxskqZEnGL+
	3Ds6XgbETgL1+ss6WFVlp/Ck46xnJcuowukCSXUnxtcWM9DSurTTmk7oNOp8a7t8GGGzlbV7zqr
	b5zAi491L85osA6okCkoqGp+jbAlms8uZ1KGf3cwEofmTk0buy9GI34vRJcCMGSmkb7+swHRz/o
	M+Ipvr6y/61ggzLGQ==
X-Received: by 2002:a05:690e:14c9:b0:65e:438e:c025 with SMTP id 956f58d0204a3-65e438edademr10259078d50.19.1779146773245;
        Mon, 18 May 2026 16:26:13 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:52::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0aa51sm7022713d50.12.2026.05.18.16.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 16:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 16:26:11 -0700
Message-Id: <DIM6W7GRZK2N.14AH43S1XTFCG@gmail.com>
Cc: "David Vernet" <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>,
 "Changwoo Min" <changwoo@igalia.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] sched_ext: Sub-allocator over kernel-claimed BPF
 arena pages
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>
X-Mailer: aerc
References: <20260517211232.1670594-1-tj@kernel.org>
 <20260517211232.1670594-8-tj@kernel.org>
 <20260518072042.GP3102624@noisy.programming.kicks-ass.net>
 <agtt2dEjS4Qg7a_P@slm.duckdns.org>
In-Reply-To: <agtt2dEjS4Qg7a_P@slm.duckdns.org>

On Mon May 18, 2026 at 12:51 PM PDT, Tejun Heo wrote:
> Hello,
>
> On Mon, May 18, 2026 at 09:20:42AM +0200, Peter Zijlstra wrote:
> ...
>> Should this really be part of scx rather than be part of the bpf-arena
>> thing proper?
>
> It's just a layer on top of arena. If bpf folks are okay with it, I don't
> see why it can't be a common utility thing on the bpf side.

Well, this gen_pool based allocator of arena memory is a temporary hack.
It's ok for rare allocation like in this at scx init time, but not suitable
for active arena management. We don't need to expose it beyond scx.
Having said that the fast and generic allocator for arena is definitely nee=
ded.
This break through with scratch page and bpf_arena_handle_page_fault()
cannot be overstated. It is a huge improvement for kernel <-> bpf interacti=
on.
Not only kfuncs can now read arena without ugly __get_kernel_nofault(),
but we can reuse mm/slub.c to manage arena memory!
The key idea is simply this:
get_freepointer() {
  if (s->flags & SLAB_BPF_ARENA)
    return (void *)(s->arena_kern_vm_start | (u32)(unsigned long)ptr);
}
I'm sloping a prototype.
