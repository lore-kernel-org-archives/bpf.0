Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518338DC79
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788587784; cv=none; b=acY2VmdgGfyOIAGrTdryU55RLW+vjBG2ubBaLRQqjjQdkvPFyE5743oLrMZ0sqU/DUjjTLPXXqwWHhyr2mkeTPEuS/Oc9Wb3ZprgLtysG+pUldFd5JUkNNjG9QJrPb/wsk7jsu1X3RP96XfMIPQES+bPZYJX29s6GqxoAt35950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788587784; c=relaxed/simple;
	bh=5J0/tLoJ0hPoJDtGlDy225FbMONZPc+PxaNejPvpmgc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=c0z2576LsYz2ZD/viBLJigsuXTFczIvQrvVBBMBeQ39pMAvqQEBbBPhHboFrZXy5CYtGBWnkCXbEAv9yVkWHwmWYhFzOnt4bmpXVzYsDRkhdf2Z4yd62J/nPHA2eoHIAYiGcpVhtwWYEyRbc/tcfA8OgbeK7j7GOhdbtZz6AHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnU3yj6+; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnU3yj6+"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso7739985e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 22:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788587781; x=1789192581; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DErHoq9A+qfWlaDw5ATm8uO9TlTcQmGS0EfdQCaIaZs=;
        b=gnU3yj6+zgHULmCriA1589/kiPlBYkqqGtvCz0+wMBsXqCyjzvHDybEOuSNze4IhNJ
         tlZ7KGJjIpdvZzhtCsy5bIhm+34NyoT59B2Yp3RSk3JJZhFJYuOC7zSVsCyf/iryQzv7
         nxIBdgErfm+naVAKKO4YM2qF7aIkQbATwMOKqAv9QDykqrQeis0okDuwAKmj9QYcJtOI
         Ucrx1mEHTVAxXrbvkdLnsCWEqHyJSB6yzvMd/op8JnMKCunkvfpo6hdcUf1C/R8gvLi3
         QQs5YzLdPEZEsHR8ZFZ9HNEF7ZEfIZ8Yij1nXDLON/XLql5qHLR/c+JIKmtq+2EWlvc2
         0l1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788587781; x=1789192581;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DErHoq9A+qfWlaDw5ATm8uO9TlTcQmGS0EfdQCaIaZs=;
        b=D0exiWOUmyCP+s71wsAaQUuj36/ok7upq1wlutD6kRTTik5mIXpY1NkVJxUI+LmEfQ
         RreIRw+ubfjeO5u8i7pteg1sUod57+Jm8wLzEZ8z//ZMgjgAWsn7g+UTLSeRv2yV+uGw
         RGEoMt7snVyxY9NDazUhX7rjs3lync02Dm64t3UL3ISLu8alZOFBLRSqXFuilb234Evz
         ZwPFp8nL3mwP0rM/n5+pnLdpsmz+iwNBZUpOtg7IbyWtOJjODjlu6LKK4wiI3Ib3QR92
         tx7q8AZK4MJSetJY7LM4KK1nM0dNVAmdk0eMYU2LN1LJng/r8VMW24+NYZr1fxpJsNLA
         eTMQ==
X-Gm-Message-State: AFuF++mZr3oTm0FIH6TpDRVKWC9Oz3xESXdDI4A2sRswzUyq+JIhl3uA
	MRP8mJVDZvbDBoFAnuMNu13w1WXBDMWDJQ5FO1/WLi9RI6aPJ5wU0BRR
X-Gm-Gg: AYBFou0wq/TfzqbkyvL6BYe8yjtYBLx1cwM1KWzHm7QUOEv+FeQVKGdGlmz/QJc0Sa5
	3xmKDB30UxPc4fS3sOoqIOfKEqyUt2i8H55EUTDNk82sbTVndsMdZ2DMkx2eT75gnbJSvnGcjRd
	O7ehvDqbpo+P8mIyVhoIbgGXwV7FcmtFykRWXgYqfG8FXFkmL9mKGKezYXIGU+IZ7ROSz46SFqh
	AVDbuDKu7g7HarjrPInornMVIsGECJhXusC3EOvboiLnL21XQEaVIOIw/HEuGxEKTwMDG2oX7EQ
	x17reon63w7Dgpsub+LcaAZmYWgmrTESlnmmWXYNuLJtB9KKwxMu4NYg0EEGBgaMG0EOzBVxS5o
	uUu5PZKqRK+flizFOTy3maoRoppMXMKoCHKGvgfmQBuzdfs89Q4+oQDIraqUVbFIMTMhbIrvq7h
	tP9EJLNDKLOEtez21hlZbwn8rKorC0TBOCbH//zELjBQrTgk3cba27ukkXX50/q/IwdxDnFCxmZ
	FaazoF6hJBm4vDm6JolVmWBP//l43G0itsPF9/jtqlj/0rmuWeJG6yANge1MduOxDYPFHwPSAzP
	DTPwtMb7i2a7SGdPi09c9Z1edaY=
X-Received: by 2002:a05:600c:8b09:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49cf823f57fmr202579595e9.10.1788587780908;
        Fri, 04 Sep 2026 22:56:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm227465215e9.1.2026.09.04.22.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 22:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 07:56:20 +0200
Message-Id: <DL75GB02N34V.3IAIUPZPJO4YW@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v1 1/2] bpf: Reject non-scalar bpf_loop iteration
 counts
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260905014735.1452988-1-memxor@gmail.com>
 <20260905014735.1452988-2-memxor@gmail.com>
 <20260905015702.5ED241F00A3D@smtp.kernel.org>
In-Reply-To: <20260905015702.5ED241F00A3D@smtp.kernel.org>

On Sat Sep 5, 2026 at 3:57 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Missing negative bounds checks for enum array indices in memcg B=
PF kfuncs (bpf_mem_cgroup_memory_events and bpf_mem_cgroup_vm_events).
> --
>
> commit 3f8d69cede626ae022617ccb30f54b8f41f90edd
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Reject non-scalar bpf_loop iteration counts
>
> This commit fixes a verifier warning and subsequent panic triggered when
> pointer values are passed to the bpf_loop() nr_loops argument. It
> introduces ARG_SCALAR to ensure generic helper argument validation
> rejects pointers before loop inlining and precision processing.
>
> Link: https://lore.kernel.org/bpf/6a9ad24c.b5d4176b.238c3e.0001.GAE@googl=
e.com/
>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 3a7eb2185c354..591dfab3e706c 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -894,6 +894,7 @@ enum bpf_arg_type {
>>
>>  	ARG_PTR_TO_CTX,		/* pointer to context */
>>  	ARG_ANYTHING,		/* any (initialized) argument is ok */
>> +	ARG_SCALAR,		/* scalar argument */
>
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the additi=
on
> of ARG_SCALAR and how the verifier handles scalar arguments, a pre-existi=
ng
> missing bounds check was noticed in the memory cgroup kfuncs.
>
> Could negative enum values passed by untrusted BPF programs cause an
> out-of-bounds read in the memcg BPF kfuncs?
>
> Looking at mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events():
>
> 	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
> 		return (unsigned long)-1;
>
> 	return atomic_long_read(&memcg->memory_events[event]);
>
> And similarly in mm/bpf_memcontrol.c:bpf_mem_cgroup_vm_events(), which
> exposes validation logic from mm/memcontrol.c:memcg_vm_event_item_valid()=
:
>
> 	if (idx >=3D NR_VM_EVENT_ITEMS)
> 		return false;
>
> 	return !BAD_STAT_IDX(memcg_events_index(idx));
>
> Because the BPF verifier enforces scalar types but does not validate enum
> ranges, a BPF program can pass a negative integer as the event parameter.
> The bounds checks use signed comparisons without a lower bound (< 0) chec=
k,
> so negative values will bypass the validation (e.g., -1 >=3D 4 evaluates =
to
> false).
>

My understanding is that since enum values are non-neggative, the enum type=
 is
treated unsigned by default. But I think it might make sense to just cast
explicitly since Sashiko keeps repeating this concern and it is probably cl=
earer
for a reader (I forgot enum values would be unsigned when all enum constant=
s are
non-negative myself).

> Can this lead to an out-of-bounds array access on kernel memory when the
> negative value is used as an index into memcg->memory_events?

