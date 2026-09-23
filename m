Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2233E49D9
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790198942; cv=none; b=CpdqUTxtOsW+dZbjU/9eoCXoyXeTQiY5DNsYWsVjg3a8Uhx3nEafFbXt+RXbfwFw9Up3veWSu54P+90oJsIKYDyOddnbokarOHzUbV7Wk97tEvRodtqqYbKNVCIvIHLXcAGuHAx6M6y8aakr3hjUr/4o5iUnMs7KVk5AHqsFZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790198942; c=relaxed/simple;
	bh=Hcx+TbiSyZ06XaWdzx7ntmGDoavFroa+xd8aK4z0n7s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=BoT+ZJj7dscoI+lrFNLEkd5A1UmyKnD+CgX5IF/poKENQ+IW3duCFE1QEpxu7vHpc71J9DA+yYu++PW8/S1FCCgQyJugAvSn8aSxnFkg9HLKnr5AedN64mwpJE/uKfZ3o7sm07mJUGFwWvQ2Rzr1KvW9bK7NOXu5/vpkKDRct7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbpEdoCZ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbpEdoCZ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ec6188so6879595ad.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790198940; x=1790803740; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jJFE1Y7PJhPok+AeZ7Zn2U5TClLq5FTw8KPyr1E7W2o=;
        b=ZbpEdoCZQEtM2Fu98n1fmH8YA5ILez6I+eRl2FDFT9eFTdPm54pqzYfYeUhaxqDqE+
         WhdyNL2jaICxatzThJi3qpyRSUNQEQZQbmbNTKrwoNy4iEE+itKIRwOcjpW5bsDF2/1P
         saFL8zT3PAjSnJhq27C+4mW7j9tVAYjZ1GYCS7irNZzRvmPd8snedt7b4bEzGJhh3J2t
         Tl/ed1jIBmBNKPzCR/zF6RQFKvwYHz3zc2c5CuUTg+KONux8GvFvn5wd1sBKsS+yf2Dw
         QKlKZ3gmtbjCtEV2NUckwH5oX6FaZuAoveChgB1oPekS/Vj+yhcn+QZ2K1AQAFT2Vzlv
         Cpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790198940; x=1790803740;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJFE1Y7PJhPok+AeZ7Zn2U5TClLq5FTw8KPyr1E7W2o=;
        b=GNYel4EhbO+/8y9JZLiUc6zmcvgSFym/1mzyYcYt7/G1whbbarRhDKGxRKOZNcgxwl
         m5LwdKwS66ESowpAoHXp/a3WvXIqP//OrYL8oOXWSy4FirOyAY4OFO8k7JuCUjY3Lqmm
         l8fwk7IJ8jGA0mb68ntiKeJVi/sHrY2MlYbPhDI+jgMBSmgcrtoXqSFieTHPKrxJQ0fq
         Kt5XuRpyKDxwWfbYasqJnr+bFp3E5s1qfYp6552AcDd58Movo19tF1DDm5kx3/bsvG+U
         6thDrd6IscZhtQYaVtJqprkT+Ox49mktUPgSIpYBPDjzobrENdppcKtrSG5HAlclNfMI
         2RkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzn2fyM+6dqRu+86qYrO4DhYItPv6wt4ruSZs3lBl3vJmPMrYKcy6YPeNx84F0ePrja+kE=@vger.kernel.org
X-Gm-Message-State: AFuF++nLEzeeb89fBtsil+xwPn3hc69nGuo4b8fH1vLrDSiegXrCveEF
	KUxDYthtGBegkSGvpd5FSwm6hkqZbkX0TEW1tmoHU+fZI4ZkA/UQwMex
X-Gm-Gg: AYBFou2UU2gf077c2bvv1TePgbRe764wrSEZZ+EnYObAQV+A75o2av/dGeiPil4wqNf
	PsfGG6i2LGPmFZt/omcjCimvIe5yYdg8Q1Jo1cpB0+I0Vm3HDe4fgKrM/7hQ/vy9D0Z0zn+LtWF
	14U43Bmw4+ft4N9bzTGkZ/LOwl/rpg2lMU3YpfdykLFcivezk1U/oX0Qnn0capt1N4Q3LyuBF+D
	pxPzaXck9LIUU0tu0g3ur3mrkMnbJta8j3jiSWsp/uKo+D2P31egL3CuWEhu/7GgLa29XV+K9pd
	oNsyKYCh1goDMM2pyRyPW9ljNZUeja+Cw5wKekazx/4+VxVBpEabUjPYa1xZNKwcoVbLj1Glfxj
	LoU54HDqBQf9lZulVgLiCa6s9AzkMKVUD0x8I1c3hbOXHyx3CQRN/6ArJZbci2rR++Ii+sEU3Xl
	0DSVBzGdBuzCLNpvvdKToSU9z3NnC1UVZzA6zBE4+/ETLRqXWb2V8BOJnjdFNCdvgywTJGLQc2B
	f8hql6YIen32E5u05ikc/0JbIHptq8VoObkVDXkKytga0VE6Ux/ft7gWk1y336sWVKyd0Gf+0bW
	A9M=
X-Received: by 2002:a17:903:ac3:b0:2dd:c100:4258 with SMTP id d9443c01a7336-2df7e2639f9mr3030355ad.60.1790198939789;
        Wed, 23 Sep 2026 14:28:59 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df71957de5sm13111825ad.74.2026.09.23.14.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 14:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 21:28:58 +0000
Message-Id: <DLN0K7231LF2.1UNIBGA546C90@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045922.2417689-1-yonghong.song@linux.dev>
 <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
In-Reply-To: <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>

On Wed Sep 23, 2026 at 4:26 PM UTC, Eduard Zingerman wrote:
> On Tue, 2026-09-22 at 21:59 -0700, Yonghong Song wrote:
>> A cleanup record need not cover a call an exception can unwind out of: a
>> frontend is free to emit a region around a helper or an ordinary kfunc,
>> both nounwind here. Nothing marks a call site then, and that record's
>> landing pad is reached by nothing at all -- leaving bpf_check_cfg() to
>> refuse the program over code its own frontend had no way not to emit:
>>=20
>>    0: call bpf_preempt_disable
>>    1: call bpf_preempt_enable      record =3D { begin =3D 1, end =3D 2, =
pad =3D 4 }
>>    2: r0 =3D 0
>>    3: exit
>>    4: r1 =3D pads_ran ll             landing pad
>>    6: r2 =3D *(u64 *)(r1 + 0)
>>    7: r2 |=3D RAN_NOUNWIND_REC
>>    8: *(u64 *)(r1 + 0) =3D r2
>>    9: call bpf_unwind_resume
>>   10: exit
>>=20
>> The range [1,2) holds one call, and it is a kfunc, so an exception canno=
t
>> come out of it. mark_call_sites() marks nothing, nothing pushes an edge =
to
>> 4, and 4 through 10 are reachable from nothing: "unreachable insn 4". Th=
e
>> pad is dead, which is correct -- no exception can ever arrive at it -- b=
ut
>> the program is fine and has to load.
>>=20
>> Walk every pad the table names that the edges did not reach, the way the
>> walk is already re-seeded at an exception callback. From there the pad i=
s
>> code like any other: do_check() never enters it, because no call site
>> dispatches to it, so the dead code sweep removes it along with everythin=
g
>> else that was not reached.
>>=20
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>
> Yonghong, in v4 you said that rustc does not generate dead landing pads.
> Why do we need this patch?

It's not dead. commit log is incorrect.

I bet C code that caused such asm didn't mark bpf_preempt_enable as nothrow=
,
so compiler correctly emitted exception table.
Now commit log argues that this helper doesn't throw in reality.
Well, too late, the mistake was made earlier.

I don't like the unwind approach taken by later patches in the series.

imo the following is cleaner:
- do not repurpose bpf_throw() for this new thing.
  Introduce new kfunc that will do the unwind, let's name it bpf_unwind() ?
- replace all 'call bpf_unwind_resume' with NOP by the verifier (or may wit=
h bpf_exit. tbd)
  Technically rustc or llvm can do that too, but it's cleaner to do in the =
verifier.
- In bpf_unwind() walk all exception tables and replace return addresses
  in corresponding frames to landing_pad_ip-s.
- just return from bpf_unwind().
  restoring callee saved registers will happen automatically by correspondi=
ng
  frames and there is no need to search exception tables at each step.
  That's what typical eh unwinder does, but it's doing it due to C++ logic
  that is more complex that Rust. For Rust unwinds we don't need all that.
  The above algorithm will do.

Also please add an example where [ip_start, ip_end] range is more than just=
 a call
insn. I mentioned it couple times as the reason why 'invoke' aka 16-byte in=
sn
approach doesn't work.
I'm pretty sure I saw such IP ranges generated by rustc.

