Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F7318EDF
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772761261; cv=pass; b=a+Me5iYHHImvJA9K53JXv/RlIEqOvYZ/GTHdVQdJRZ74YmvomQM+PTR6ouCCW+2NIUcm0vW5aaJ+lxI9GilB56otmo1Mi8p/rq+U3HBWwHNZqu6oLwZUT6btM6G9F5G2DVi22IWbys/RMaTafnwz/XiPQeXGtf5BBIvsoNV/zXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772761261; c=relaxed/simple;
	bh=nd6GaIamOft5XM/KgOAcyqUwrHPLKA5D7BRm536zHiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO9UtEvAmOWR5ceoTXFx1woXjHxGZ4RNyCFCtEajyDCa+rosCUmjT10MoZKzZoxYAyEPLdZ2jW7ML1baV2ZVSJG5QP1sd4pPolA4L8Kd5kLXJxXbW5KkQZ7sbIwlwe/FrdGZyQTEy2F6VbYtMg2PIc8gX7MRoBK8ihMtfJ/q+gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU2zeK0g; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU2zeK0g"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439baf33150so3894190f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 17:40:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772761258; cv=none;
        d=google.com; s=arc-20240605;
        b=kaIFhe6yEMreuOf2qtXdbD7XxJ8FsohNyuvMyIFNPtAnQi6PswqAQDQWbMhsOPlaJO
         CrZO5X7rMf+2WDNCo/IVXOGAFlS6CKpzcK3WPEKAxTJqpRGD76RACFBKYAbBzjNHqC7F
         ghUJBWTWbhkCJCeDrehrF6xj38SD3fX5Iw6ba08lX1qJ9uiSveLr8wEPF0+p9H3lFt8V
         ppBGQ/NbkbPhnaqizD4XFMOn+8n0GNnBOTJexDxWUR5wSxg5cA2SdUU5FE1IlTX3IUcN
         kYrmbGRZq/SNPaLUACAtRFa1a/fe5gncCwpjturEbikaADsV5GnyQPPMuSVnKNSsK2hO
         pZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Uxac+KWCW7u/QZS/HLCt2EBa5IbxQyv7Xs4Uc4uzHU=;
        fh=jhbPt5d3fG5TZrWtfmrNrIGO7twvlnNMjiWgxaidJCM=;
        b=bKvpWzZjmdNowLxtKcuukOqU/jU2pkEYRmP7KkfVzlxMoGcYOR9FZb4ALbRg1gu5KP
         o0T4dP7qOmfbMa9id8WHOyYI657iSXlglZ6ZAHqCuhTH2/5Ah33yhrR8i+FvGSXcHgGC
         SYT8kfEkJ8kdM5V1zVpAlZBt3CE9tBYuhdKsfZ8C3IyBYD2UbzAovfpakE53GRHTfZ7u
         ZGZA4uICohPzzK+kno7gn7hXA1mNcTkS1ics/nhqdHnR4JWFW50/TBII8tSnlQNAm0PQ
         2Nv/Pzr4IfgMHwAH+WCcvfS8bolWpbyvxMVLeWmLlchX0SFTlpaP7jz3A95hJ5Vv2JXU
         +m7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772761258; x=1773366058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Uxac+KWCW7u/QZS/HLCt2EBa5IbxQyv7Xs4Uc4uzHU=;
        b=BU2zeK0gViQ8E9eDYFwxyl/MmzVTnfUsUooBT2EsrwxDpJFr0HnlSUeDPccvFjZPUy
         FyVuhFeeirKnLoZJis+Dnn9DyvksVBhmliwyvj4Ly2ztmDj7NVmRlQvSy+n66fHxrvJJ
         f0l6hSfyp+3bcfAlofRY+E3EPPlCaHSh30AJKqEVsDX0nuCWh14poOqa91f8jI9T4HrD
         3PiTVoZcldhQLj8mhkrf1xqXWl0n6dKNyItIssTQAdEdm0WLMGXsn0hrxed2Z+ywEbQA
         02/00p5aARtDI23GVNPjG+rWMEmHMUXe40H+NKOXCYB4+dRhM+AhJDQ4rqMJ5oWenJ5w
         6ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772761258; x=1773366058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Uxac+KWCW7u/QZS/HLCt2EBa5IbxQyv7Xs4Uc4uzHU=;
        b=hcugpYu0ilgt76zzL7bsssAvjaYSXr2qpRBG4I5+JCxfM6RQroGT3uS8JtN99qewwT
         eip/m1LQk6rzaAdqttcA++qW6BVJDnSFwr813FipgfIKL7+mHtlW8oQBB2GB398PlIVV
         hI1rIW0l0esar5FIcyK5YA01p8N9UtQTaaMP8abj9P5rbZ7KMY5LND2iHQrfmmldp0HW
         GX5ctIxBnCdNc69UcZWUNmjvymz0E8W5j4qTZNTBTy2P6isHaw9jN8m+amvitACUM2i2
         4XozHrNEeRRkcQH4Ou8OAA0aPIoLYGET27FnSXmp+hcscH9PUVLEAH3dzOjqcq7KaWIs
         UEiA==
X-Forwarded-Encrypted: i=1; AJvYcCVuaR8Nnde37BhDhgK3VUi73lWfkzroI0i7uZRX1rOcdGYKtl0M7CuUyxGz5YpKZqDKHhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdxawxY7oyGOqxSesC4+nLSWdjlfX3kd8aAHQ7QWkmAgAgM+V
	EUg+b0uhPgpxf4yfX6QAEYW5e508OahCR+wURdpimDQ7xJSetFuUAPmVNVHDhNvazMGD1046lsw
	/YP1/YiG87U8PrA0FMuybXgC2ov3qZpY=
X-Gm-Gg: ATEYQzxeyuhW/LR6o+H4qZYE5EsL2njzDAT/UTHs4SlfrbSVSYXzob3xj9TuJntkY5H
	WKVapxHAYJZCJdT6YruIXHjlwWsABRFPCEswWKNo8oPOUk18YH85r8KL2jYcM4ri46y5OrzK2YB
	ZJxY8X8+8iaPsLPCpkBb5KyMYXSMd4k/fOJ2aGejXGUqhLC2sZ28BcVK9AkQDzcNajXUHCbPtBa
	c5erxUnmWD4g9wHJjhQVGj45wmPTxlPwXdnZ83QGO/RbGLRQ/StfiGfuMyC9y78yE1kkLu/EiIa
	DKM87JGB3Vzyh7JfRxhUwtFuWW75DEEdhbTM8Y3Z0EI35i3C2t89PBPGv5dbgO9CQOeyPYKrP45
	oF/JMGyJmTDFnpP/Nwjf92GVuIb8b9bMO+1xW
X-Received: by 2002:a05:6000:1a8d:b0:439:b69b:3c8d with SMTP id
 ffacd0b85a97d-439da363768mr545905f8f.13.1772761258188; Thu, 05 Mar 2026
 17:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305222132.470700-1-varunrmallya@gmail.com> <12848362.O9o76ZdvQC@7940hx>
In-Reply-To: <12848362.O9o76ZdvQC@7940hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Mar 2026 17:40:46 -0800
X-Gm-Features: AaiRm51vEkGnLJ6mxjn5smhsPO9kg2uz9vQgb_fU3--4Fn4QGcpDSSwu3E-Nprk
Message-ID: <CAADnVQL7BpNh_WuR3bPKuVPeKLOgnkY+MUwDG2WgN1ZPtD734w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix const qualifier warning in fexit_bpf2bpf.c
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Varun R Mallya <varunrmallya@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard <eddyz87@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 5:16=E2=80=AFPM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 2026/3/6 06:21 Varun R Mallya <varunrmallya@gmail.com> write:
> > Building selftests with
> > clang 23.0.0 (6fae863eba8a72cdd82f37e7111a46a70be525e0) triggers
> > the following error:
> >
> >   tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c:117:12:
> >   error: assigning to 'char *' from 'const char *' discards qualifiers
> >   [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> >
> > The variable `tgt_name` is declared as `char *`, but it stores the
> > result of strstr(prog_name[i], "/"). Since `prog_name[i]` is a
> > `const char *`, the returned pointer should also be treated as
> > const-qualified.
> >
> > Update `tgt_name` to `const char *` to match the type of the underlying
> > string and silence the compiler warning.
> >
> > Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/t=
ools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > index 23d933f1aec6..92c20803ea76 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > @@ -111,7 +111,7 @@ static void test_fexit_bpf2bpf_common(const char *o=
bj_file,
> >               struct bpf_link_info link_info;
> >               struct bpf_program *pos;
> >               const char *pos_sec_name;
> > -             char *tgt_name;
> > +             const char *tgt_name;
>
> I have been suffering from this build error too. So,
>
> Acked-by: Menglong Dong <menglong.dong@linux.dev>

Looks like this patch was lost. Pls resend.
