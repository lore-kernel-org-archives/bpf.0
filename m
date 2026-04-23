Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6A1A6838
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776952896; cv=pass; b=FCVkuwE2xIKuaunBWcp7K/V+aYUpg1aXDIgcTPZoqOfzp1zNyjS2IHZrWK/XGcWZGvg3mZkyJ0NYvlfQif66TMgaBJkLac6mquU9lDHC+yu1cESLI5I4OS1j5cv6YHjtiItcvl0fA/PFx+rp4wPWoAnBHMBbNv4YOLHZE9CeFqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776952896; c=relaxed/simple;
	bh=jPFmCZdGs9NfeZpSRP16IyvwHvPcV0EjFuT4U0J50zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiLbfR9fLdHjXkDvMNnjZY0jPYPbTnhfKQSs0ZQG4Gd4VsHrCI8OUAA1F6ueBZiYJG3ynJEnYPqVw8lANRUmsh51eotLbZfVeBYR5YRwh0bd7ZWFv5QLVgqqXaGUh6+5VlSVRHgucMpYVxt5DBd89+6nV68ybv/iqhBE67sqI64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+xqOIn4; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+xqOIn4"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-441209fb77eso2177509f8f.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 07:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776952894; cv=none;
        d=google.com; s=arc-20240605;
        b=RoPn8y0Hv0mGF++wEulK4kAY/C4leaIrvGYZYfXtcldwjZW+w2tZNw6Kq1nroDXaJs
         A/I7X4hdaBhdd5Mj7/vcmqOyQF0BDl1CE3vIEBYRMo0K5b8BHAEcAGkPnreW4LJCFSrs
         zcsxktXgnjwqe/bLtyKrm61rbM/jlAxL9NrdwY1xknjlUFS23Blwy+zZYCrx+DNLzagB
         EyhBUkOQEJ3RCFjhiO86LvOLQIBgUNmHVsJIvsYWNc/qPGwgWGo79wFZR7CDYvGPQ79B
         MTsJM+J2USyL68YYsjyPCJsuWBFcTNhE2G3Pehn0pd5TZEqkqoClF0Z5u1C6CGPbxnAU
         CwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jPFmCZdGs9NfeZpSRP16IyvwHvPcV0EjFuT4U0J50zI=;
        fh=x1SYwYPMJXFrnInNh/AP+zrvH3EJh4IzbA79VnZABEQ=;
        b=iCnHZ8DuYxC50ou4Ge953O9GvbrQr7PfidEloPHc/6h7SFKEW5XJH8ssvQU5c08crl
         YmGXrVoiXejizw4B2IMvwM2Tj0RPUp/RWpQKT0QNq+Y00OYqwSINeBIq77MBYBZ++1zD
         F4N4s+nqMw5WH+rrZlCjr+pWYNVUNvRzulI5IlqyXTni7QPXugvzAviRGNdxA+i1/MuQ
         5rR+Lvc4UfENKGmDvZsAxg8CGzPguyTq+MKayO09zF8gM5v5Ixiel1u0gCd87mbqWV2+
         p5t1nnD8fS3+6bIJZv5cvRJqV0PCfxTRE/ccHuFpK8exkYIZCUnmC3dj8qm6nr/z7UEG
         t0rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776952894; x=1777557694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jPFmCZdGs9NfeZpSRP16IyvwHvPcV0EjFuT4U0J50zI=;
        b=A+xqOIn4HMtHSgGFbFQb5lElQ6DTeMVw+qExWn/1gKdLKZCtnv+GhywBY5UTdQBQqx
         64fiLVRTiaT/c2bJ75kKGY8Pax2xF2xOw4Ip3Esnt+rs4oNN97f78LOim3QiJPvI7kHY
         wuyTOrqdwUxfj/noX8Eln4jECMRgBrHeRID3YwyFhdeLbSPbc918je5cHOaAsJQe+jCo
         HyPaFdN5sARmfJcu9361aFipL4zC6zyTbRoaxAM+cCNxdsawLC2biztqLr5hdWaPGkTe
         d+Dq+/qYjaEpffrfpy04Pn8BWVXc48tJF6/7S6cVrKNgJzJTxb4SgcPmDr3RlKZfw6Vk
         wCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776952894; x=1777557694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPFmCZdGs9NfeZpSRP16IyvwHvPcV0EjFuT4U0J50zI=;
        b=gRPyJuW0fT6O5kVr3u/hSI6xx03HqwVrg3pbMchTW4RyRv66uppUjgC78mnQvS+63n
         1zeeYGhpskaW5KZADIekMr2ty+q2taxaHvkAJfUCgdb1wO0wO+KlbOMwocEmH/OnYlTM
         YLIU5mIbsnoNmLF3hibmyxitgFqkYcb4hB2wRAqEXW085SY1v7hRYjeSVfqS5lOkIajX
         WtsPaG6AX5jBIFCLzBYAw+JQtyvf5SydSkgIFnV4Z4QHfby43Ltxq/tl5tRTdUDmD0lU
         PANggPJMVGtUfPO7F0wteC+ID0UB6ktktk0Ro7nKxnV+gOdH3ycOmDrPTsfC/l1he6Yb
         RY5g==
X-Forwarded-Encrypted: i=1; AFNElJ+XXIuS0QGW8kIHMqwRyWi6Ss/T7WzKHApdW1iiQzs39kLaD2/o4PHWLN39KPJcgby+aO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRIcxYPkszXWYfCvqQQGV7ghEfGZ3vYt5gzn+D5Hg1jhZ7Ipj
	HjAtF7/2KwPJ15VIc0H8LXa6DZShmIaxiTOufcGfZqzbqORpAIwm9fYzXOykiBSClZkKxLLzniH
	NyCr6fjR3Tdzu1fNQG7OioOm+8hLHgf8=
X-Gm-Gg: AeBDiesC+L67lee1KSE4SV0uvMCnG9/tzYLULSlpyQN5kBkeRXLh0nUYuZ5dD4VNTJi
	jOB0v5iJF7i5yJGx1+ikulRV9Hw4G9AOES29IcI8p8Xc0WOdHbidbGr3ab/h6EXD/GT7z+1ZCtG
	Op16iNrcQ3BF2+5cTTxmYnEjfSluq3F8qI82BYWyRp66ifj/c/EU8vVRr4TGjhI/hSCtcuC3GDD
	45D61NDiv6u36RIEMmm+YgjKuMn+PwdXAxVsPqXT3BvW+7XaDxyj8pnc1aqqcAMN6ed4Wmrh8PZ
	2Zs6evxxknyVzSox5GZJAMA/eygyTdoDGWiVkc+H/hcjHzr2rhwbZlIC1/ed6K5X85OsyJOX8L+
	k1SkdWh9a1Fb6ywMdGAtsxFQ6uQG3qrtmyqVfu9SopbfqvIal1R4tGWV2TJXryWqgJ0HX
X-Received: by 2002:a05:6000:41e5:b0:43f:dd8e:869a with SMTP id
 ffacd0b85a97d-43fe4032b3cmr38139314f8f.3.1776952893348; Thu, 23 Apr 2026
 07:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421165037.4736-1-emil@etsalapatis.com> <20260421165037.4736-7-emil@etsalapatis.com>
 <aenb_fGyhCxiNBPY@google.com>
In-Reply-To: <aenb_fGyhCxiNBPY@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 23 Apr 2026 16:00:56 +0200
X-Gm-Features: AQROBzApQTWFxwkmdPzwkAyWE35EYHwLtjAcFkV9PTY-Tt7WhY8FkiH7WGE0blM
Message-ID: <CAP01T75q0_9k2W46_ibNrbYeZwpQO-nO=ysqX1Do+CHd+rE8Hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 6/8] selftests/bpf: Add buddy allocator for libarena
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Apr 2026 at 10:44, Matt Bobrowski <mattbobrowski@google.com> wrote:
>
> On Tue, Apr 21, 2026 at 12:50:35PM -0400, Emil Tsalapatis wrote:
> > Add a byte-oriented buddy allocator for libarena. The buddy
> > allocator provides an alloc/free interface for small arena allocations
> > ranging from 16 bytes to 512 KiB. Lower allocations values are rounded
> > up to 16 bytes. The buddy allocator does not handle larger allocations
> > that can instead use the existing bpf_arena_{alloc, free}_pages() kfunc.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> The implementation of this BPF arena backed buddy allocator looks
> rather solid. I noticed that we have a single global lock being used
> here to synchronize metadata structure modifications. Have you thought
> about how this might be a high contention point, particularly when
> dealing with systems with incredibly high CPU core counts? Did you
> consider possibly making use of localized per-CPU caches for the most
> common/small allocation sizes or something like that? This is
> something that definitely crossed my mind when I was initially
> thinking about implementing something like this a while back. I
> understand that this is an initial implementation, so it doesn't
> necessarily carry all the bells and whistles, but I was curious to
> know whether this had also crossed your mind and what your thoughts
> were on it.

Yes, both reentrancy protection and a per-CPU caches are things Emil
is planning to work on next.

>
> [...]
