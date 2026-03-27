Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A5D369967
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581748; cv=pass; b=V+rS4xxm+PGDOOSnhQT6cmOuBW4qDZYb/2lZIY0OOsUi6cnQMBfN6HuAtm7xvesVOcpvtUBhSBG1yNGVxuC27CQTQi0iUDnc5t/+bhqTRF89C5KSA9IPe8GPiuJosfJqUglg+NJXD5tycSMVd9s7SVCiv2rYS0k4PNU8PIBGKMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581748; c=relaxed/simple;
	bh=gvqMYj9cCw3Fx06UAlVD5eKzQ6zaEaSVj63b115XbJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rExGhHVen+LSkxf3rN4Wl6NtjSYdrfaUj3BhsoaqPTDyUIO9ARmvbfUpNq69cJdI8ID5x28vWzc6MBldGwHt3Ju5r0eUOAvJAoGv41XVsUrum+uQiG1DaIZdr4XRKDxkndhfkvYQktLokyF4UWJI2DVluBBD0hgjLCaK3/7Txts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh15klKA; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh15klKA"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-486b9675d36so14631565e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774581745; cv=none;
        d=google.com; s=arc-20240605;
        b=Eeq44E2zMb5SefC8Iw6cgnAl0KS7ay4hWRXBbDKgH8/KnhlmjZkNJKoE0TqIMqH1K8
         JPcvdGgCePZFHud0Jqynz48rPbEANHoaDOL2wQneico8l9la6hNQsY7fGJObnM9t6XYY
         vzidPEXtTqA8fr2Jgil4ndvJhFQ26xu630c4BfNSh4SBbDu7MlpBMeD9WCy1Wrt/WSwS
         9wnLpCW0ln/m3cPQK4R1sT7Ix2oTWHUHbN9KtRytflrS1iDL+T6za9mdZzdbmKVq3rJl
         1PRTvmqqq8WqBe53ILNx7qP19qHk+GzMaqrV8olBM/Yd0sZxr61S2WF2wRExR7VKRy2f
         KmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gvqMYj9cCw3Fx06UAlVD5eKzQ6zaEaSVj63b115XbJg=;
        fh=D1wtG+kWMm07WgcReuiaEH+Eb/a3IKeUnaj4T3L1iqI=;
        b=XfRbyprne6E3o0MMkOrNBaNnfAjB6DZOR9nJxqTB64ybB7rvVOZr1zGMMMjZWQl/sy
         IN6SNfgII0R/Y1AEZz5XekW6OMwNpybsVK4bPwO8GtJRGImsJC+Mz3770Xqc1qbFZr5S
         UIqvGphlXcNWekGo3AhyPUJ5t9ux8NNSfJzLjHvE6y6yoxgHg/O5HnXRPUw5c5G5E8Lz
         3KL4PxMC3XLLVp3wFLWlWlLdcL1cyN/ia3bexj1Iu1XpXE8NpoPPD73redlcCBgjzvXD
         20xBieatpJsBl94CPmlOlE4G5po6VIY/0tlBcsp5nW8tgiSRSdyPrWFQPWM/VfeQ6N6o
         VQ0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774581745; x=1775186545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gvqMYj9cCw3Fx06UAlVD5eKzQ6zaEaSVj63b115XbJg=;
        b=gh15klKArYK2LjZQV/fMNIuNz3pOoGdAghyTK0Fs2jfFi6P7Zl3TFqkIFIaNnKhV/j
         ZIV9+TcO5Bg2gcspGw8iPlR1TaQVrpADcAMlTS+cjoKDFsBNcBThcvM8axkxvOK9HmsZ
         3oVGsveux8mdhLlBP7TO0DnJPH9Oh6V8gFwo+kdFmJN5NW3HdQfsYHhdYgrxAJt7mbSX
         3hlZfKSVmOPwnjHC61rVqy3nlYAaVCH90QhKq1xKq6hLOQTYNPpjzUymVrlGmFIE4OM+
         ntkkuXAbA8Sfig4VOfh43uf864ZgRLwXTVKFDyIaUdcdo7s1t+vDssbOdFn7wezVBUFL
         +7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774581745; x=1775186545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvqMYj9cCw3Fx06UAlVD5eKzQ6zaEaSVj63b115XbJg=;
        b=jLg5Mx3xsAizqDCUrbOxqIlNrk6ATNJ6qzZaFWXDbuAfeauiBWoDlK0QfSpXPiXUsO
         eu2vPhWCT2iQOlIRdg+ODyU5Rvb00keSuGsrZZrbBlv/J2DPe/vBeJ454EmyiQSVlG2R
         cLEmwx58D0+8Tx5OkT6rcPiGgI8M2O75o8jGe57cAyEV6JQMzJPCacuHZEKyFBKqupbC
         E5D647+rIJjLL7ONYCo8r/nxCp/MEJwTY8gbkgxj56BHfXKduiLJZO4oeiv75UgXNbCI
         6oyXNfrFjOnwX64YXWvsDNbncePwC8TR8EV1qv2nDzsN/luUnwgVaTE8da7dJLh+UWB0
         cjHg==
X-Forwarded-Encrypted: i=1; AJvYcCUynH1XOWQ7xD5LFchPyYoXo4LihLEiu6bSRVHpTvLdlHRFj4c+ChTqmt2ieia1BoQiac0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26TtL+PoX2lzEcJinhCODHtDUL1OrXqlC+NLNc41wAoJO+7nd
	BCOdB45BleLyYQy2xVOVgYqoimCW6lEGRsLi9jlFwetVz1SBFc6UM3uFFRd/5pfnzxvYEjeD1Nd
	RObR3dY8GTJH7EtNCtcqdpmouI7TNqdk=
X-Gm-Gg: ATEYQzydq/5DpDd/qaxibhSHGamKPpJ0w79Datw/036O5h4+Ehbm8gd0i5cNkmtcjZZ
	j8O8yX6NylIcWZeU1alYyjFKV5/AMwbqbUdaAsOReqxGEqehvFVQvNkUmurGiqc1FV/d0yG2wpD
	+skfeXDBD8AJ5o5f/JYUVW+K5o1iCSnsNskXulTndDW6mY2HUpi0UAsqHFn1f7PC55o17jKXbYN
	f4GvAJW45Tr0MOujRM4sZ3MSmNbFwAknpYOWeqQPlW/mb0rdJIEKMdyRQhkDKviw7+ejk/vBuVJ
	OEwKfu/exZsPItoK5SwpBpQnxsUiwc4rph1nmpct/sEwunTiecTmeQOL5KqlJ+fO8QRuOvE=
X-Received: by 2002:a05:600c:19cf:b0:487:1108:48bc with SMTP id
 5b1f17b1804b1-48727ec7695mr14594875e9.17.1774581745345; Thu, 26 Mar 2026
 20:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org> <87qzp6ipc7.fsf@gmail.com> <CANk7y0jkEKYviXGG2je80Q26MK4nfE4p=wfb_ukDuHGKSy2Qiw@mail.gmail.com>
 <87o6kaioju.fsf@gmail.com> <87ldfeiodk.fsf@gmail.com> <CANk7y0iXJ1sTn5eMrUosvbwnLrSwGtxyirgTpFwdDVWN0tHb5Q@mail.gmail.com>
 <CADucPGTNHas6gJu=ybWyZ5X2s6bOO_ar2eg9PFv6TRv-=NA-Zw@mail.gmail.com>
In-Reply-To: <CADucPGTNHas6gJu=ybWyZ5X2s6bOO_ar2eg9PFv6TRv-=NA-Zw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 27 Mar 2026 04:21:49 +0100
X-Gm-Features: AQROBzB9qBsr8WmPryX23efOoOs9kxGyiBQk4lNxbor6uJogqwdbu8oLuXBr_tA
Message-ID: <CAP01T7712ZmLy2YaViHtZ=2RqtF4i_F49Vyb_UC8NgQcYX8j5g@mail.gmail.com>
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update path
To: Aaron Esau <aaron1esau@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 03:54, Aaron Esau <aaron1esau@gmail.com> wrote:
>
> Puranjay Mohan <puranjay12@gmail.com> writes:
>
> > Yes, if all the users have BPF_F_LOCK then it will work because the
> > re-used element will have the same lock and everything is serialized.
> > But this reproducer is trying to show that the elements are being
> > re-used, which they are.
>
> Updated reproducer attached. All operations now use BPF_F_LOCK (updates,
> re-add after delete, and lookups), so value access is serialized via the
> element's embedded spin_lock. The value size is ~4000 bytes. Torn writes
> are still observed (3 in 2.7M).
>
> With full spin_lock coverage, the only remaining unlocked write path is
> alloc_htab_elem() -> copy_map_value(), which copies into a newly
> allocated element prior to insertion. For this to race with a locked
> reader or writer, the reader must be dereferencing a stale pointer to
> memory that has been freed and reallocated -- a use-after-free.
>
> The root cause is bpf_mem_cache_free() in htab_elem_free(), which
> immediately returns memory to the per-CPU freelist rather than deferring
> via RCU. This allows reuse while the syscall path is still within an RCU
> read-side critical section. Preallocated maps do not have this problem
> because freed elements remain within a pool of valid htab_elems.
>
> Switching to bpf_mem_cache_free_rcu(), as Puranjay showed earlier in this
> thread, eliminates the corruption.

As I said, the reuse is intended behavior. We won't be switching to
bpf_mem_cache_free_rcu().
This is mostly for performance reasons, in case you're perplexed as to why.
That said, we could do copy_map_value_locked() if map_flags &
BPF_F_LOCK to fix this particular case.
Such that if the value is being reused we will still have serialization.
