Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794853878;
	b=AGKOPAKcqdFDkHmK9bWHDuKfYp5eCpAzzatWT615jGQSGuQ06c1dbm0icUnN2ARAC+Nc
	 rPbW6fu1e5k8K/GML0IRyQm8e4Xr3ctiJdST9qyumzoS4H92hq/WDIFOQ9JZQjcoGEf+i
	 LYjtFnWRy0iexJWV44lDaISy4HBp4bCa8WoN3oLsuykwWS8gZGyH0/xFQB+anlVGsr6Es
	 wBfEpDuSClIIwuesxaPQ7/SgvmI+K5gASGigolrkRUCAVVJ0Gm4F4MSojofWuA2Zczs7K
	 ErwCbG53GPOJPbNTmWbk5mVqVQabCtFDJzdFySP25QPxu791tPzHEt4KNUk+p1YWeiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=13+u0g0+oDlzUbJhGCsHPWLuoZRTBcZlGfDcseo9APc=;
	b=VFzSaoC8bjta77f0xTTJD2PsDHGzJtvyxZq8juQcbj+OWPeXIALULI4Pz6uNQMUcPZUX
	 U8jgnKsFU4dz4A3grDtpwlO9dt//hZrnNCOcSvsZrnEm2TayQ+ZS6IVK/T9pcXKMMExv6
	 qv+W75U57Z6EwTIIGMBe/7Az9q8gw3Hf+NNwlIRGZICyFX+E2+ppDd+3Xg9dw8Ia0vBN8
	 r5pvdunIK92TyLBOhyfIu6Cbmp9ijiMzWjBggx73ppIr1mxk7GjkLbZBAq0e5JR+vX8Tf
	 MjFcW6qpVZecwKC7zZfa9hHEROhxgRYicHkvEN33i4WofVlo6HbIlWRxWYoxxGskqZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZzAV1qVS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C1606A32C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 18:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B5C1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZzAV1qVS
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so1714825e9.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 10:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794853876; cv=none;
        d=google.com; s=arc-20260327;
        b=k/Ad4iDWaH35s0YmZFiQy1BmRO2ZTZ/c9QlTohtX37js1HSITUcKnE1r3Jzfa4T66s
         FGoRBQenc/8+u2nODtuvlKaioSKdZMvNDGetDIHhO4Ec7V8gZpCcOT4p5f7KHzmjSsFH
         J5t601p/+fgttq1lgoyvoNOLGuVCCaIhh8wajLvnzjzKDiTc8RwC9SxtYfVDscUFuFf4
         OafuGTl6oPbhKsUtyvtkRGKFnkLyza4x2QXpFGnhGj8LVhuHt1ubGXZwLehQVB+AKjp4
         DhMPVj2H33ropnpg73mVfwLD84kWgttGc18QADrY87AlA1KnR2Tztlw4Qpj0EQjw2L7a
         IrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=13+u0g0+oDlzUbJhGCsHPWLuoZRTBcZlGfDcseo9APc=;
        fh=nZI9M7L3wt9Prswc8Z5IYEm20vJZzoUZmNuBHErrBwg=;
        b=hy8q85dPfWPemS4bsDf9stBKCttVAHilDidzpT5TqOCWMSbpU/9BLEOmixnYzpAcae
         B74n41c9ylQ7M+6x6lBiBLs7GjFFvR8AxCHhyLiDEVJRpVN0O4Ub/aW1asXxq9tBt5wz
         u6YH4kWelQW52+z14Z9a2iHIhrfzGsG2nPgDIUkfUeo0ut19/YQZEuNvYLTvzo6okKpz
         5N2M0pxnqOUvDbbDvw7yosG7l66NGjaPYZQmqia7RfvH4vJt4+1zO2J/uhNVtTLyQk6a
         cQcON0akUj4g3lxLEh141G0Dn/YZCbAD3hdhlfPNs4/GnxkuYmy18dzaZdE98qjk/rxT
         L6kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853876; x=1795458676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=13+u0g0+oDlzUbJhGCsHPWLuoZRTBcZlGfDcseo9APc=;
        b=ZzAV1qVSVfuzgmNbZoOKoRVJW1PcFYJThO/T4EE3lha/hH2M1tUDD4Zif5X8jXruyJ
         3c9MEB4oyQ9nsiuGY9QQ7SbuGV79WzKRklCAL/g2efhn41bFFTc92sakvMsjOlrXA8AA
         Von4j35nxID+//wFZC4/3tBOONdYcHeiLUNAIEyUHdXNHaBSyfWbSXm5Kt7vjgajkFVL
         wtxoq3FlKLshkKyG+lYd/l908C9u3yX7N2wpaa6yJfvd0aWPC+f6Z5BHz1TcvH4wPbts
         F7/a/1eqWTSkdPwsb2K738idNL3QdkCqFSVLvEM3BrCfIb5sgWZQtLV2f/oBwaHSt9bq
         q+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853876; x=1795458676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13+u0g0+oDlzUbJhGCsHPWLuoZRTBcZlGfDcseo9APc=;
        b=LQ6ExpgmjcDL/P9+XxKblhVeI+rAcCBJGsrTK957A6ondNGp2rE/WCYH7bfh2kJwlI
         aT+gRiKgFqVnRs2OqI95yLzHjGpkLXYAMGp4aZPOXews9WS8/Xo6gjl47DG8dxQ83HMZ
         86BviiisXDew/CwmjHaJ4Uc1jhWAzPZuXlXTZKVGyQdi2M4/08Z+Ju3O79UhfWqw2Tci
         i0jyrsvANf+NBJx1+KigEeDZmaVU9VmcfXyWeI3Xo7OXxWNz2exArCGv72+HvCNmkH7r
         wW5bjhYMJJ0ZCR1QSF97xNJJiSqGomqltTdHHGF4p/nP5SMkBWfRkd6QhQCIdMLeQRtd
         rJzA==
X-Forwarded-Encrypted: i=1; AL+hErECnliEiztHKUwnlZ4SQCAB2uu2b7In7BH6XlOy0FaQ88oj35Hn0JU3cs7uofoTXvH4Ogg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zJXC0G86p/nxXhGXW25posqP4BrwDS+L1NaD12DAs8AkcMhi8
	tRGDi3wzJIWiSY1o03rF1YmwtGQWvijSc+cTbyQ6r5bQGND4PdzcxtMA/pCIZxIcCV3Rkzs7XpY
	xh8Q7qpONqKl0QS9Ct4QmwJVN+XtsUeA=
X-Gm-Gg: AYBFou3uMFcwfm5Gq5CdDMxHShR+FMwvLiivifTNtsL9+T3yI9ottJNGjMKm/zpWTWO
	bTucjNK9wNqmA5cP03ZozRPXXIPSzEwQGfG4OKzvDjPO81rihCEsn0OWfOAzMtlElf3ugKxYA55
	KMBulbYDwWO+ABIcCWr16SYJB37cWibjEXoWHhcnCTvkEjyk896RWp1/eaBUafK+aZmPA0MOeQu
	zQr1P6TvX3hvUwDIvYG8luzBRlebL6qEX+++rI7SSZkVnAtAVd+CqWas31vsKE1N3+8kfmsVJpT
	V50n51l6u3kjTfo9Sa1RSaWHhDTDynCrS5EZo4AR2c/LcCJBaXnYD6BYnWb+ywX41q4RGOWcLdg
	ASJqF01of5HMiyvzRr6gN7R1dculhhR1lzy0UZZC/tGYIi7Bv8Q8BkXXw/ctMgKWEY3u0c+LG9t
	BMyaP8BPBhhw7OKxPJN0Q=
X-Received: by 2002:a05:600c:3ac6:b0:4ba:7a0:7b67 with SMTP id
 5b1f17b1804b1-4bb783aeb29mr8252075e9.3.1794853876371; Mon, 16 Nov 2026
 10:31:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794269506.git.memxor@gmail.com> <DMUHWUF1OF82.3VM2D2YIBY40V@gmail.com>
In-Reply-To: <DMUHWUF1OF82.3VM2D2YIBY40V@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 10:31:04 -0800
X-Gm-Features: Aa3M54qhYew7E_m2iR65kDcczhQJIgtrj34vBgaYScrVh6U549xPXqWUOex_yBA
Message-ID: <CAEf4BzYAS8V=XcULjRvL=v0ffn6T_HOQVAxDkBy4mC+mwaQ_Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/20] BPF kthreads and waitqueues
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 4:09=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 09, 2026 at 04:27 PM Kumar Kartikeya Dwivedi <memxor@gmail.co=
m> wrote:
> > A syscall program parks the same way, in the user thread that runs it.
>
> I'm missing something. What's the point of bpf kthreads if only syscall
> progs can do them?
> It feels less intrusive to start smaller and allow parking of
> user threads from syscall progs only... for now.

I had a slightly different idea at the back of my mind, I wonder if
that could fly.

What if we allow creating dedicatd "BPF kthreads" that would have
"exclusive" BPF ringbuf (because it needs to be single consumer) in
front of it, and for each submitted ringbuf record that kthread would
run an attached BPF program. Associated BPF link will keep kthread
alive until destroyed/detached.

This will allow multiple BPF programs to communicate with each other
by submitting BPF ringbuf records and basically doing async data
processing. With this capability it's conceivable to have a pretty
sophisticated kernel-resident implementations of services like
memcache/redis. These BPF ringbuf submissions can come from any
context, of course, not just other BPF kthread programs. So network
packet arriving on some socket could be "offloaded" to be processed by
a BPF worker program.

Kumar, Alexei, thoughts?

>
> kthreads have no limits it seems. memcg is probably not aware.
> I didn't check all release mechanisms and cleanups.
> I'd think syscall prog can signal to user space to create a new user
> thread and start bpf syscall prog there.
> It's less flexible, but at least the ownership of threads and their
> resources are clear and contained.
> We kinda do bpf_wq() already, so one car argue that bpf can consume
> a bunch of cpus too, but wq is really for short term work and
> the rest of wq machinery will yell if bpf is abuses it.
> Here kthreads suppose to be long lived. It feels too amitious
> to let bpf lose on them. Let them be user threads for now?
>
> pw-bot: cr
>
