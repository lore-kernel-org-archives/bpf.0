Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DF29427
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115236; cv=none; b=UlGMY0f8hk/KGKFkftXGJJL6iVtZChyw/3dOWlGl9Ca9gN+EzpsKW0DPkLYcofBDTrfgwxOWc5HvEh4MMcijj1SShQC2V33tUl6iYNsGlC3H4uLSooIHC0MgacnL1DUn5nnSSt6BS97ZLRUwf2JX74fE6IwHa6HIFuN+8/Pli2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115236; c=relaxed/simple;
	bh=5mDoYVZpYWVxWQIUitRUqpVraA3mr2Y9VJPbW6GPodo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmerGeK9aGDzmh5mTkY2yYNN4WUsWs2SVibomonJtmLFzySuay9ynZXAz4El5GJlqspwxmBrbi59obNJZgkaSHMo/uZMiHH6tHLanikGRfF4mVPWn1aavbWPawFyM421zDFxyvc71EPRxaw6ZbBIFK+XTm7/qmdH0NJSokm69bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX5+irjN; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX5+irjN"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6962a97752eso43422286d6.2
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 20:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712115234; x=1712720034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5qzBHlym22MrCJOJi4pE+rRT4ToMlkqsNExU+5IiB4=;
        b=nX5+irjNLf3nemtOIIxNpmsElVMh3gNN8byonBrKicFagoGvgkXrTw9/VyMWgymNlo
         wnEQk6m3zNRNVJSlPqtbOp7oEB5hrAm9akmCq0Ri8hK6AaO9ZX+sA5lJzAEfr0DHlusm
         Gu3GzUHiT7uyt4SXYQ1UBwYiaGXFqHAcrIgRR5TnRWuFBjzHpY5pqEkGPOyoIOie4IRL
         Hbg4AvueOyKo83l1j34A5wzqs5XHfmeKR0n7uzXhm71J8zaT1u+y9Z2sCH6KYPFqctcX
         76S26yJefN/LkkaDUkjx5u6kS7XVhoQG/Dec2IaNJ+BuOG5wEzF3DXX8ZkGDTfW7uMGW
         s+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712115234; x=1712720034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5qzBHlym22MrCJOJi4pE+rRT4ToMlkqsNExU+5IiB4=;
        b=LWznhF1m0gTOUyU1RVI3QkA46KQcx29ofUXYaV+UDjFLmBYDzLvSDoDoGTh9A8ilB1
         16d4r9r1IyXguW9jpqiJNpflLssFJCKks6pewVpRIil4uC2VB9+4R33oh+Vl0sjxo8KC
         xz8Kf9oIgxqw4yD6HBQr10Qcafmj46AI9BpvPEb02OE0+RW2axPpzfn6DcGni45NJop3
         YHqjCh6uy2nIREThx5jxMETWS2xBbPuJUP8fJKu85KHBsJY3Rz7Jd8phgqCLR4QN4Mol
         i6QN1cMtUEU1XkXQv2F2luuOxP6ZxCRE3F3SbRF349C9daRgBdXcWmPE+n+z0LEpJ2ox
         Y48w==
X-Forwarded-Encrypted: i=1; AJvYcCVSLLO/hOi1QZ+yJ08LqARTmztLi3wHvTTpuqoE1hfmKSDU0AOfSA1vYQONfcCSwmB6JBuA2jtw43MR7MIsdneO4u2M
X-Gm-Message-State: AOJu0YxB0bY+HWjRfbya4cWimOqcfPPD4Wbj4yI3Dk6pPkAfe5o+qLBa
	Iz+iAiP9hUXC0jP6kOhQ7nFnj5puZixl993HFZG7362rIlFLXmj+8tciHnSvMxBBEk6pd1W6dlj
	FdxAKA03md2ZPfR2GB1f6cfzYNjObA8QYUCa27wTz
X-Google-Smtp-Source: AGHT+IGW8P+8J8sz7kLB7WSf6yuLYqtgQj7Lp3wJWevHCCNcKHPpm4sjez0ZGN4QETxHM39zG4/ZXrIBRpIFoV8DuCo=
X-Received: by 2002:a0c:fcc1:0:b0:696:7d37:1a6b with SMTP id
 i1-20020a0cfcc1000000b006967d371a6bmr14704903qvq.56.1712115233855; Tue, 02
 Apr 2024 20:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331034154.16284-1-laoar.shao@gmail.com> <CAEf4BzZnLNg9dKF1knkPohzP+4cw_4W9QhUuXQaNA88pGwiLLQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZnLNg9dKF1knkPohzP+4cw_4W9QhUuXQaNA88pGwiLLQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 3 Apr 2024 11:33:17 +0800
Message-ID: <CALOAHbCn9dNb+bkO7kL0bcov2yU69gbJgJSpi8A5__209X-q4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/2] bpf: Add a generic bits iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 1:22=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Mar 30, 2024 at 8:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
> > added for the new bpf_iter_bits functionality. These kfuncs enable the
> > iteration of the bits from a given address and a given number of bits.
> >
> > - bpf_iter_bits_new
> >   Initialize a new bits iterator for a given memory area. Due to the
> >   limitation of bpf memalloc, the max number of bits to be iterated
> >   over is (4096 * 8).
> > - bpf_iter_bits_next
> >   Get the next bit in a bpf_iter_bits
> > - bpf_iter_bits_destroy
> >   Destroy a bpf_iter_bits
> >
> > The bits iterator can be used in any context and on any address.
> >
> > Changes:
> > - v4->v5:
> >   - Simplify test cases (Andrii)
>
> hm... I think you oversimplified them :) Your negative tests are good,

I misinterpreted your earlier comment :(

> but there is now no "positive" test that shows that iterator functions
> properly. I'd suggest to add few positive tests (still within
> RUN_TESTS framework) using __retval (grep for other use cases using
> it) to check actual values.
>
> I think you need to validate that iterator works for:
>
> a) bit mask  smaller than 8 bytes (and also maybe number of bits that
> are not multiple of 8, e.g., have 20 bit bitmask, but set entire
> 32-bit value to 1s, check that you get only 20 iterator next()
> returns)
>
> b) a typical case of having 8-byte bit mask (you can have some
> irregular pattern of bits, like 0b1111000111001101, and calculate a
> sum of bit positions, returned for __retval check. This will catch
> endianness issues, if there are still any.
>
> c) another typical case where bit mask is > 8 bytes (same idea with
> position sum would work, but probably just counting number of bits
> would be enough)

Thank you for providing such a detailed explanation. I will take some
time to carefully consider it.

--=20
Regards
Yafang
