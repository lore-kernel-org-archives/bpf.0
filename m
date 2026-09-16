Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B0F41D217
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586975; cv=pass; b=EbmVn3UtCR0XhHny3u1VB1vCjp5uM4r3pgMFoCurUfrIEXOLQZHA5sG1zueMk5YtaX54Bz01k3wI2JOslLPTGXcU9eF7fjAguzHxOk1w3LzkzQIgqmxjB+LwOGUL23ZhrTrYBVrDO86pxqv0H7Mw4QQKXHCzE3w/6BE66wF138M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586975; c=relaxed/simple;
	bh=X0bKO65h4md/AUwTLuBudve8hzWfGFXRoDF7mDTv/C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1rNXfisc+zWY/c75JQjkMoJ5YIGrA2dY/WwGN5EFVl5DY5ZgzrZfVi65n6lob8EQYIIGfZLIPI4n/O7mpAX0DAdddmNsZbSxWJL0W7pHi1oSINMMafUzLuBHeAGVLq0J3k2N4DQwQI/sbhuecpjCQYKNWKM9Y5NJsiQEm4H1Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9MBEFwM; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9MBEFwM"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a30eb3bso52713b6e.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789586958; cv=none;
        d=google.com; s=arc-20260327;
        b=OVsYE+TtD3iel6boQHe0+xeNQcyy3g8y73KLAqFdl1p/55jxaLkl5O+QGTfrDFBgqC
         MOBW9QcjKtEfKPb/p30ajDXzNXjzOdA6/2nfm/r/XO4CR++eADYuXOGKwbkCfAcRlo93
         WyqOVBEteHW9gD+P4Up0Ub3jtP0KNPwCBO4NKkYKcr9uucMnXCqDY1eZyWZ5y217CWO+
         3vEWjWI2aFFKdSF4yRpjsVAZMyrJ3lIyxEZDAEUhiLW0J5daJbhANB8fPqaBLNaHroVw
         krEH/hL4Y7KB49agCowNbheYn5QKoMaBREq/X+UGWg6RGif4/h3hTSh8fjTlHCbmhz3z
         qtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X0bKO65h4md/AUwTLuBudve8hzWfGFXRoDF7mDTv/C4=;
        fh=thuQ6G5/Lo/OMHSRWlQ/e44tGcNnNWJuGRtiGuZLL+A=;
        b=ixCM1Dil6sd45ckTrCQFoD9VpkZUNXLSA45f7oRZ2Y8qiT9d6uIcUooHL4BtRYwh+Y
         qjguodn46upHJ7SvIowHdBr7dMkvdSSMOYTK/65QBw9xstbbHEfIjbe8SU9jlLSRlVz6
         NxKriBx4jpzoW2FjhCZYJlpl+lcD0HaDAXWQgNKMX9DtOCdRu1H6uvazcFffi1k4M7jG
         yn+fFLn+0hDzpwDrcuKd9Ovwq7k6Kw5TndptIaIkgQQ2CG6lrtVtm2ExJP28FweC5tjR
         PwEaw/xVEM8O/Dbg7kSsuXZqwXg6P5IgGCyfR2V7QgTWTlcDDPx/lD8f/3Dqu6c32Guu
         BTDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586958; x=1790191758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X0bKO65h4md/AUwTLuBudve8hzWfGFXRoDF7mDTv/C4=;
        b=f9MBEFwMyWboE7MBO69ThvN6CztqeYbP0BaguSPv3FQ1chKFY1+htzMjEDoOpr57Mz
         dV/bOHQmG8pxMi3+VFFggV5BjtspKkR3hw9JCnpLRIg6rixR+e9X2MiqtRkGveDrWlVN
         46LCUVYjXSg85Z97AskJsXeNr2z+RBuNpDiKoNRFZwRiVGcTCp011B2P7fVRb87hzqYn
         nOa2pIrm0WArV29f5P6A4KpVeYXKamcUbt4urDmAVfL1xNTEwOaKVUSesDrqL+PXzg/q
         vJlR2bX6WY11exQDIu4lpRvWIDitOWGDVE2MboEaYeQV+5Au4eBviljpjciVlOtO2QI3
         Ajrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586958; x=1790191758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0bKO65h4md/AUwTLuBudve8hzWfGFXRoDF7mDTv/C4=;
        b=v0zWs2MDoFgsbrulRc3Tx0EN3VlkXeHBEtZQ2cGQng8/6F9mCtXHYCkW+AMDp4RFi0
         ZEof9gWJuflMCgo+eyJTelj0Hh4xUbQ4G9hzf5pIXh2pIu7JK2+aKrYh/HFRG3muz9KL
         C1Ht3Im02jhDsgvV/RMVeIm1QsC++54BAY1ukJN2zMSdXVreC8iG97JTu6MQC9SREDaO
         zHJrUAqu5wy0DBtYKyQTAzXDp3tsewRsk5yVVcA29C9C23OhchGy2Hee2uYVunI3hYBs
         ocGJ8F6lpHZfEda6dFVt8AA0Cq/hBx6/XBxiU9h1ISUBLR6R0qAGzFjV0iW48xYrekxR
         Pxvg==
X-Forwarded-Encrypted: i=1; AKwUvBz8UG8C17M3vxyGPfXG5yYQCfKQ3TyOs8tdIZr7u4M06F2NsIuzVC7sxO27V8c1T/k/IZY=@vger.kernel.org
X-Gm-Message-State: AFuF++kcpkoNgPqsQUU28gxAyDhQzJ5arXpOZ3doBcWT6TSj0/yETV1e
	FBP7rJhVTwe1IvAClY47TX8pRgJ8LX9GsBl9W3zvcPuYyQC6gxIjlpWfXTWkylEwPcJpSt0BLom
	F0EMseYoC22PbuzHN2UvDbp54f8mSxTw=
X-Gm-Gg: AYBFou3fOOF1CiiOZFVa4Rn4Vvf31UoK1gAEMHa+GGFgeu0vsg6QSYe44BSSEIlh6w1
	tfqTcu12LbD3tcikT0X+iZT8sWn1pAIQ7fHeqVV+WzIzwC3qxATf0wZxgjXmqkTzD48SY954RsK
	XUZjsGw9d/1hOwirj4XRAK9Br+KvHFxW0x8Efz7UFrP6ON2ldINBnp60uORiycxPuiKPVfoavFJ
	/s4Ctksp1mfRHdLV0myVatB3cZtcl8B6saVGlsnv7heA9n7ul0KXBMS3eAdJ4ToJDmgXX3s38tw
	oaNeuq77rPTX4Lt1e0aNzs2aQC9N1zzod0DrGUPFDF3E3al+Q0ucgKA=
X-Received: by 2002:a05:6808:c412:b0:4b2:8d9e:de11 with SMTP id
 5614622812f47-4ca4dc219f6mr5873685b6e.19.1789586958406; Wed, 16 Sep 2026
 12:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916181001.201787-1-usama.arif@linux.dev> <DLGY7IFP8MOG.YFISSWRDGKR3@gmail.com>
 <874fc50f-4764-433f-8a87-595bc70c4559@linux.dev>
In-Reply-To: <874fc50f-4764-433f-8a87-595bc70c4559@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 16 Sep 2026 12:29:07 -0700
X-Gm-Features: AcwNN1WDst1cmT6BJveQWlz_V4KXaqctpiRs6Ar3jIL3hsk1lUSOIapHrHv5P-0
Message-ID: <CAMB2axNZVQr=bEQXGErSEOFrMfjn11K_ZvYErLwXQ3tUW9qPiA@mail.gmail.com>
Subject: Re: [PATCH] bpf: local_storage: avoid redundant IRQ save on bucket locks
To: Usama Arif <usama.arif@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, ast@kernel.org, andrii@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	martin.lau@linux.dev, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, song@kernel.org, yonghong.song@linux.dev, 
	yatsenko@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:22=E2=80=AFPM Usama Arif <usama.arif@linux.dev> =
wrote:
>
>
>
> On 16/09/2026 19:22, Kumar Kartikeya Dwivedi wrote:
> > +Cc Amery
> >
> > On Wed Sep 16, 2026 at 8:10 PM CEST, Usama Arif wrote:
> >> bpf_local_storage_update() takes the map bucket lock while holding
> >> local_storage->lock. bpf_selem_unlink_map() does the same; its only
> >> caller holds local_storage->lock. The outer lock is acquired with
> >> raw_res_spin_lock_irqsave(), so interrupts are already disabled at bot=
h
> >> sites.
> >>
> >> Using raw_res_spin_lock_irqsave() for the nested lock saves the alread=
y
> >> disabled IRQ state and issues another IRQ disable. The matching unlock
> >> tests that saved state before leaving interrupts disabled. On x86-64,
> >> this adds a pushfq/popq/cli sequence and a test/branch around an
> >> unreachable sti to each acquisition.
> >>
> >> Use raw_res_spin_lock() and raw_res_spin_unlock() instead. They retain
> >> preemption nesting, memory ordering and resilient-lock bookkeeping. Th=
e
> >> outer unlock remains responsible for restoring the caller's IRQ state.
> >>
> >> In the tested clang x86-64 build, this removes five executed instructi=
ons
> >> from each uncontended nested acquisition. It also shrinks
> >> bpf_local_storage_update() from 1732 to 1702 bytes and bpf_selem_unlin=
k()
> >> from 1030 to 992 bytes. The affected paths are updates that add or rep=
lace
> >> an element in existing owner storage and successful unlinks.
> >>
> >> Document the owner-lock requirement of bpf_selem_unlink_map() and asse=
rt
> >> that interrupts are disabled.
> >>
> >> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> >> ---
> >
> > Makes sense. But did you observe any measurable improvement with this c=
hange?
>
> Meta fleet wide profile shows bpf_local_storage_update() as one of the mo=
re expensive
> bpf functions in the fleet. I saw it in production when profiling a hhvm =
workload as
> well.
>
> The main argument for the patch was reduced number of instructions execut=
ed in
> this expensive path that I see in disassembly (which is mentioned in the =
2nd paragraph)
> and better code hygiene as it doesnt make sense to to save irq again. I w=
ould imagine
> this patch alone wont move the needle in application metrics, but would m=
ake this function
> cheaper (hopefully :)) fleetwide.
>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> >
> >> [...]
>
