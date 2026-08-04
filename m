Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8523385A1
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879299; cv=none; b=KGwqTvwmk5XmGYC3j+MpsOaSuRimGBgjuiCQ0v3UPHIzyFLn61PRIP3l/3oIzSTyVwZnbhggB6tRmj5d+9F/i3oMq47wbTApQrshqzdmV1Lr6k9AdnTRqOm0pnQhPThoMM5rO+PfLPcI6JiJKhN1JxaHi6n0R/NgQX+zxyoCYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879299; c=relaxed/simple;
	bh=CbKiR5Exv8rPxEahQ4Ci8R3R3USsie4he3WFHYZ/7fM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C2VQpoUN2qRMQ41nFP6yetLvCxe+UYqAVqBN3z7DxuV3b2Mq0Dgun3VO5npbWalxp54b56uqrZa474Bv7cPqm19+BjajfVRtcrSYH+1snmK+JsXytoQLJpgJ7mZarRlNk07ZOsZwg1fv+aDZFzkyxc/0AXH/ZJFiPDQdmOgyp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqygBXNw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqygBXNw"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso280739a91.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879297; x=1786484097; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S8o9b0WV+H7dmuJeUNEMwsxpTlG0+LSVH6bZanLEqNg=;
        b=MqygBXNwIa8/X7smeMOLBvsHN+nocMu2+gxxKkvAhDU0tZhRzYVEa2XCEyaooe5kwR
         JH3tfyvphka1g5yWjsSe0TBn/0MmhlbA69pNs7Dynf+jAd8R9R0Fcg78GmdICt6F/P52
         3IgY7m4PZ7D5M4Wn8vv11F2xPhaGjhKLT6pBJFh58IX3kv2l6D7VSN3Exm+55gBIWt04
         p1Pfd/GFgPPoEigr4cZ1v8RIyAXUMlvO8BWd3RMNZd0Ex7kf2V4PZM9aeaeZhEP7skuC
         QVTCV03yP2MzfbsnMEtyWH3ZYHO/i4ou+9vuexJ0ymsrvdH3d8dPoPLxxa28KTKfiE71
         yf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879297; x=1786484097;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8o9b0WV+H7dmuJeUNEMwsxpTlG0+LSVH6bZanLEqNg=;
        b=Z3BBJ5TLiq7WgH7mpICNXy/CLwyLihNq30MyMR/axHwcf5BLP0wJ88tzPUfQ9dHjIh
         rrE3+GichSyp+pL3PI2ymo3Y7irsbh/nfZfVx4kTKnlqGKnZnsxbK/ySKx8QahftcJm3
         sQvLwEWQm+srYX3FfGj/QVB1SMoYFdjXJY3CVfcgZFhlai2lbvzJNvkmqteEgPAV3nLO
         qRvDKJhNlMWaRdlr5gcV4m5OYSdFtF8ZpFGw9QM1WDRIbpJXO7bUkot7VTa6SQ8Kqxv3
         isOYl3YTlzsTNjFBohMx+cH+CSTDwHQN7JKrAFfvjOvHwU49S6V0GgcOiVQ6GdgC2OJ5
         uZFQ==
X-Gm-Message-State: AOJu0Yw6RmZR3EXS8Zxy1lMJ4zp0rcDIXy4mCwAkhUaftL53Ymi48CHx
	fvuiA/9uLNGEqRM7B4BbM+AkqyGfztXy6W81/2XbQgDmsA6ZmydxwoMO
X-Gm-Gg: AR+sD11EPuYBWt+lzs1CJy4QFUKYkf78db6DjD3DQ7cQhTvBj7M3QXWsiAvrLvgMiN9
	l8lrXBLm2rhbyuRQkZwlYnBy+kZN3HI5LWq1e4CqJDtFayaL5lW3obcPjVXReEoHNR6FhpEEF/Z
	qlEiN61qL/jG5Ow2sXgPmU85gdOXIOHuIonZW+agUCSVufIOejrZELgVHCZ0huAbHTZDJP87rzF
	7RCyp1XfIeI5NHz9q0dELuXKZ4Jz/BBe+DdrFMrO1h7T3PNjgy9cI9hneIR5GXHld3JIOjJz628
	fsRYg0dmLe6elr+dvgmxjAocdeD9nSdCuwhEkTra82qfj0XcZfZJWJyHgmr8Kivl66iu+AfDtz4
	U7fNOhRnW5EKGe9QVvG4ksXzZVKI8vdWGt5d7I5hd8iScQUysxSSAwad2x+pIKuASghKTfbt2VC
	Ps1qO+pma0yxLHxOcDccia9OYSDnYlriqAmImESulfBS4HTeWevr+lYxivmO5b5r/M5FFpMhjCw
	q8GNpMOWP1YEMNE
X-Received: by 2002:a17:90b:5251:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-3903c5920a9mr1735427a91.14.1785879297460;
        Tue, 04 Aug 2026 14:34:57 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903927dddbsm558542a91.9.2026.08.04.14.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:34:56 -0700 (PDT)
Message-ID: <4d20aecf677f4aec3e8e70106d4bdbcb01902e69.camel@gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from
 suffixes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi	
 <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Tejun Heo <tj@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>
Date: Tue, 04 Aug 2026 14:34:54 -0700
In-Reply-To: <6c9500d4-7401-44f0-93a6-88a827026ae0@linux.dev>
References: <20260803125518.2279340-1-memxor@gmail.com>
	 <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>
	 <DKGENYO9FITK.1M51V4BULBSYT@gmail.com>
	 <8dc173dc3d051d338916c72cae070238718fd196.camel@gmail.com>
	 <6c9500d4-7401-44f0-93a6-88a827026ae0@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 14:19 -0700, Ihor Solodrai wrote:
> On 8/4/26 1:22 PM, Eduard Zingerman wrote:
> > On Tue, 2026-08-04 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
> > > > On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
> > > > > [...]
> > >=20
> > > >=20
> > > > So while I understand the reluctance to add KF_ARENA_ARG3..N, I don=
't
> > > > think we want to introduce and support yet another mechanism for ar=
ena
> > > > argument annotations. If we do, we'll be stuck with a mess of
> > > > supporting two/three ways of doing the same thing for the foreseeab=
le future.
> > >=20
> > > I think one major difference is that KF_ARENA_ARG* things were mostly=
 for
> > > annotating the vmlinux.h with the right address space label before, b=
ut didn't
> > > carry any semantic meaning for the kfunc's type checks.
> > >=20
> > > That changes with these suffixes though. The pointer will be translat=
ed when
> > > passed into the kfunc. IMO it would be odd to diverge for this partic=
ular case,
> > > since we use suffixes for every other case where we constrain the inp=
ut type of
> > > the kfunc argument or give it special meaning.
> > >=20
> > > We also want to have similar annotation on struct_ops callbacks, wher=
e we also
> > > use suffixes, so it seemed better to keep it consistent.
> >=20
> > I agree that we should follow the principle of least surprise here and
> > use suffixes, as everything else uses suffixes as well.
>=20
> Ok, I understand the motivation. Let's say we use the suffixes.
>=20
> Should this enable getting rid of KF_ARENA* flags then? For the
> purposes of generating address_space(1), we can also just check the
> name suffix, no?

That would be ideal, yes.

> >=20
> > And yes, the __arena and KF_ARENA_ARG* annotations have different
> > semantics:
> > - __arena means that user space arena address is passed as is
> > - KF_ARENA_ARG* means that a user space address is converted
> > =C2=A0 to a kernel space address before passing.
>=20
> Also I am a little confused about whether we *need* to be able to
> express two distinct meanings of "arena pointer" or not?
>=20
> My understanding is that "arena pointer" is a feature of an arg type
> that has a single meaning: the pointer has one base in BPF world, and
> a different base when executed in the kernel.
>=20
> The things that are missing is auto-conversion (Tejun's RFC [1]) and more
> comprehensive support of PTR_TO_ARENA in the verifier.
>=20
> This is still only one "arena" annotation per arg. Do we actually need
> the proliferation of __arena, __arena__nullable and/or __arena_kern,
> __arena_user? Can't we have a single defined semantics of how arena
> pointers are supposed to work?
>=20
> I can imagine something like follows:
> =C2=A0 * arena pointers can not be null, check for nulls
> =C2=A0=C2=A0=C2=A0 before passing from BPF prog to the kernel

We are deliberately lax when handling arena and don't do any kind of
value tracking there. So e.g. the following won't work:

  if (foo->ptr) {
    ...
    kfunc(foo->ptr);
  }

Unless compiler decides to keep foo->ptr in a register. I'm not sure
whether enforcing non-null here from the verifier side is the right
call.

> =C2=A0 * arena pointers are converted to the kernel space for
> =C2=A0=C2=A0=C2=A0 kfunc/struct_ops callback by the verifier
>=20
> With the documented and enforced semantics like this one way of
> annotating and one annotation should be enough.
>=20
> What am I missing?

At the moment we have two consumers:
- Planned sched_ext related kfuncs that need kernel space pointers.
- Existing kfuncs with KF_ARENA_ARG:
  - bpf_arena_alloc_pages
  - bpf_arena_free_pages
  - bpf_arena_reserve_pages
  They, take a user space address. Looking at the code is appears that
  all three can be changed to handle kernel space address.
  On the other hand, neither of these *needs* the passed pointer to be
  converted to a kernel side arena pointer. So that would be just some
  useless work.

So there are two valid use cases.

...
