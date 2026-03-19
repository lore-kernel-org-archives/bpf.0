Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B32D1907
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949287; cv=pass; b=VX6+M1HQP3zWZF9uUBpsDJv7S5fxqFvOj/pIed6dSf2YUVbuCJeytp/SmS/JlhCDOl9lgUVdpssPdz3Lzw3Ic2ZkeyG6LSie/rkYWL86VKpy4lufD8vB8MIeW+7R2YTQ4fQkN/BQJYXvw+u2ZkvLHy6G9NLuSA5svXtMMZlbaDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949287; c=relaxed/simple;
	bh=6RkfNooWQ3RtbmOJISriZuXy5CNbl2A+bN9OqOlIT90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/kgOX3NbMJFVRuciQtxYuI2rGQf46e54Vy+ekuY/lstQKDusWsiZNAHzPoRQTEceATB/JDc3x6/soTF3D1Y5QBPdWDUDMqseVCWOXEnGRbOFvH6iV/vXcgHoXwR4ySNeuErTkFaMPZkr5br5rak42AnXOjUwtVO04NHsqbcJTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D24MuoVk; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D24MuoVk"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66132b22182so1909624a12.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 12:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773949284; cv=none;
        d=google.com; s=arc-20240605;
        b=MsPFa90Wubiz9fJFZrjlGrGKHdTrbTF9EbfpSrNik42kzHxp3Hks5QYmetiX5+HOZp
         0H7/imlfBtBjVwcrBj4jwAmK3+EJAwkPekaX6lC8I8DkaM/ZWS8AwA6nK90Hpn4FmoG3
         216SImRyzI9XZzgzg2lhvPNVRF4I6/mjF0/wfCDzVkcwghC4/fstf5Z0aWMtAarMGiD4
         l2Ehv0ALmDa+16Pe8SqYxTNXKENw9b1wXQGpHkzJmzrorbAVVJD3fSr6d8D8xc9gOFB+
         U+LqJ1toAmX6GPLNU8dkc5ON6OnMnElz6GRaAMLmgr3NEmi/i6HRvkwTJ/xkYzOSBzyv
         /Iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MjA0DcEZGbQ0Ai653Ac4hiBqqXAUZ7Eel5EV5vCTd4M=;
        fh=KkDgA9XQlbYUyitv/GsxKZ32SasDjJpVoxOzyT0nJvE=;
        b=B1oiwIOKVTzjDqdE+qf6rd9Izd+YXzCaUxn9+fIbymq1s7eVWXt8LnsRtRsnIoD6H1
         IxYELsydHLHfZnz2GtQavUfst0bFq5ahih4ncW7r1BZAmkk6Y+ZrXdMuTSarOSwNteUA
         HdghlvzMItpUYFlKckB37FC2wGox8RawzoAsDCdCKKddKo4xGaehd3SklWbTZKDmOFi7
         hGPNLp+PMyTuFpkezc8J2wv+bM3T/EnsMzzQzdBNaDI66AoU025yDaXYIoHMIB18BJch
         SXIwa+N7vY5RyMk7RaZnYKtQGrSanXxLRg/5HqH1TIoVtKDipI0TKPXfIXfr2EHPRRri
         OAwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773949284; x=1774554084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjA0DcEZGbQ0Ai653Ac4hiBqqXAUZ7Eel5EV5vCTd4M=;
        b=D24MuoVkiBhnBoMcNZlYCFJ5e9zEyxA82oJLg8c+dpfSAPUvvCAfT7mvCyJJro51HK
         krazZD34npSSirEEn5GOlEBrMfitPd4mk6fyMATw8vtvv3G+8MvqhaqHvKLuGl3HLBif
         4uR8IsXhTuFCNBWkgP9Y241ougu/9QQKQHw0fWBVTFpfCYn+v1MceXiB95RMQgvRcVJ3
         sX9hNvCM6xHCaekjwmbUQya+lqIpyWR2hqmzhpO2331wk7zrJgSXpEMrmTFDE4M6WzK5
         hHfVxski/i5igf0mGPa0hwymtgSuOhtd8k/2WRCcfE9F2utpwRV5kWaJyyFgq4MSXqr0
         UYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773949284; x=1774554084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MjA0DcEZGbQ0Ai653Ac4hiBqqXAUZ7Eel5EV5vCTd4M=;
        b=oEzppUBKGLZEobmzrKNbKWLcvUUymBOKY1mKj3zm66Xf3ScKW5ZHl5MKOmFzQld9zX
         l2RU/jsGybUibHcA4HOE+KRjnnZC9l1SD5zJqJAqWzZh7o0TJkhSMFiRAJq5TnocARD3
         BS8X8OZm33FrOaZBJBDT1Zhurpi6atnsk8Eud0r428Pz5NZuXZO5Hz9yau1qbLvd/inG
         uU6RtBAONJwtO5fWqix4WZ2PlDynoRmpsVIn8rh1CULPw23nS7NYwKBK4g3GCXGPRIIQ
         A0ERU2+TJm+dXg+aBohOuxySPC5Y/VgAael/P0OGlgAoMlly3ATBERJXRakFYMfpS6fc
         js1w==
X-Forwarded-Encrypted: i=1; AJvYcCVUI2wc/7nA75r1Fl5HCqautQECRHjnvcwdH/VxtWiVN4iXx+Zbjw6Kd2wZTGuQK8Bhsnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLqbX2UzNuFckg0h4Ac2GRcdXaPRVMCVoZI5ZQBc5TXi5x7Iw
	qbfSiDSFlWleYt3r109Svj5QhuFDi0/SJBVGd/atpGlDEDLI8apDQ4bdIgzP64+FEkh83g3ClLI
	0n9Qi7hhRb39RKt4a8lrKDzbbdjONwg==
X-Gm-Gg: ATEYQzwQQcfpXZ4ElY/2sSkXs6lZNIWCiqDYhvFZZt+MwX6cikFktqSsEOelEU/j78t
	2/k7lvBAR0ksSUDO4bwV4OwKWx+hnmiqNUqYP6QOmz9ERR0xZ3Bborwxv2f6tKCuAxE38WhpTFX
	H9b2Ls6CtlR0+sR6N2w3zstkFDNtGU3++bGnp52zFHemdWpyysktkh6MGkcpc8dnbAA9TvZJsU+
	l3iYf5sdVKhuZ6Z2zvyPN9i6AiNfQb4yAfZNy+VfcasmXDyB+B0ndXjXRfDjM/Gjsi30hkGvGq2
	Nqjp
X-Received: by 2002:a05:6402:4492:b0:665:f31:3197 with SMTP id
 4fb4d7f45d1cf-668c9100c9dmr618168a12.1.1773949284205; Thu, 19 Mar 2026
 12:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch> <CAP01T76ZazpBriekA+82aAFHKSoa+XvnvOOnQRz3XBTvBErygg@mail.gmail.com>
 <CACkBjsb4tNgiVKR02R=dkqd6kNWfnyHyFgPMuNwx5f2EUL7tJw@mail.gmail.com> <432750df75b5ce808f6b9ae9cd7ab3288a653b13.camel@gmail.com>
In-Reply-To: <432750df75b5ce808f6b9ae9cd7ab3288a653b13.camel@gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Thu, 19 Mar 2026 20:41:13 +0100
X-Gm-Features: AaiRm51aVzAkQUOpChRSrFkHoVqR9Twu0NWTbc78kpbKw3vLxNRpFNxydJ5uxtM
Message-ID: <CACkBjsb3p3LcusEiQNccA=tzNv7bc0LYvH8ogy6rVrt3PZthnw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Simplify tnum_step()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com, 
	martin.lau@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 6:38=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2026-03-19 at 10:06 +0100, Hao Sun wrote:
> > On Thu, Mar 19, 2026 at 9:18=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Wed, 18 Mar 2026 at 19:21, Hao Sun <sunhao.th@gmail.com> wrote:
> > > > [...]
> > > > in case anyone is interested:
> > > >         [1] https://pastebin.com/raw/czHKiyY0
> > >
> > > IMO it is worth it to include this proof inline in the commit log,
> > > since links are fragile.
> > > It's not that big, and I think it's more useful to have it inline tha=
n not.
> > >
> >
> > The only concern is that the proof mainly uses `bv_decide`, which does =
not
> > provide much insight. But it's not big, I will inline it.
>
> I agree with you, not sure it would provide much signal, tbh.
> As far as I understand `bv_decide` means: SAT-solver, please do the magic=
 :)
>
> A more interesting discussion would be to have some model-checker
> based tests in the selftests, but Alexei was not excited last time we
> talked about that.
>
> If we have enough interested people, we can pick a checker and
> maintain a "shadow copy" of relevant functions and data structures in
> some repo e.g. on github + current proofs/tests. To have a starting
> point for future changes.

I actually have an early prototype for this (developed a few months ago):
https://github.com/SunHao-0/eBPF_verification

The tool extracts the **unmodified** functions relevant to range analysis f=
rom
`verifier.c` and `tnum.c` into a self-contained `range_analysis.c`
file (no kernel
dependencies). The extraction is done with a simple approach: maintaining
a list of functions of interest, then extracting by lines. The
extracted code can
then be verified independently.

The specification is defined in `verifier_spec.c` linked with
`range_analysis.c`,
cmbc and bitwuzla are used for bounded model checking. The workflow is
simple enough for the original goal.

But the solver later became a bottleneck as the target function grows large=
r.
This required more modular verification, breaking down the verification
granularity. Nevertheless, it's a practical setup.

I am recently more interested in a Lean4-based solution: we can embed a
very small subset of C (large enough for the verifier's algorithm) as DSL
into Lean4, so that we can still use the same code. Then we can define
the spec for the function (similar to the theorem provided in the link), an=
d
prove the soundness (even other interesting properties) using Lean4
tractic mode, which is more powerful (and becomes necessary once
the property is nontrivial). AI can certainly help with writing the proof:)=
.
Future changes can then go through the proof; one interesting point
is that we only need to review the spec, Lean4 checks the proof, and
the trust here is Lean4's kernel, relatively small and robust.

If either of the above is of interest, we can certainly develop and maintai=
n.
