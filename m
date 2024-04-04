Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C895208C7
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261355; cv=none; b=j3R5nahJBiKXQg/zRznbW98y+eJeS9cWeCVFrgjVTOdWEvtzR+LShwChEdT+0jG6TzUeCoEo+BOoGlGuIJEpXXUnN4jcNf3urgYQURSQYl6HL8SWUWLQLv6vtmayLLpYV34uu30cgmtKfNno7na3K6xIbUSHm0YJtL0tIJfQ7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261355; c=relaxed/simple;
	bh=7SyhCWOx2TNxIi6XNROQF6tSTtaedAsptTIpqW/wxp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhjS+QgRCOI0kLPvCVMQ7bVgtty5F6FD93HG1IGAXeEoFo/7c8EzzNU9Ui97lVfvFbShfla1Jag2p8t/2XDJ7d4gPv0H46UjIG/qxMbYp83I7tO5lGhUK3/1TQGOXiz6IfRWVmxVWCS4nLy95OBzAU2ZqGd+FFhx81TnCxvFht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5bvhAmz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5bvhAmz"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso1152918a12.2
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 13:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712261353; x=1712866153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r32DMQp82P31zoRpo8If0ufV8b4eJVGXfVzXwfAkMNY=;
        b=C5bvhAmzk/dD9cY3QLAu0dyKjiL6mUYq6AY8Dc56BQUIdcd/FAEnQwxS9PQnsvOHsR
         YiEe25u+kBXvqn5SfJYCpnr4xfnzPnlPwyzdmZJQIEylLg3619r6j48WdD1ninEHwjNO
         1Fo6erDkqlWqDeTI6v9wqaSzvzAYfb6oIvgHnTtwjS0LHrPJp4umRZdtGV/r2vB/gqCV
         LmNt6Fm0QG26hD2C2TkqEA0boeobYtkH8PvXjR3sxI+7/yHW2kB4V7Q5b5zCShVWdBDa
         zFn9fJu78eGGAfMbmX+vL726x0LeXwUSp+jApBfX5ha+Rv5082jk9nSDJ0LryUY7Tavu
         HiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261353; x=1712866153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r32DMQp82P31zoRpo8If0ufV8b4eJVGXfVzXwfAkMNY=;
        b=AjRPIc0/6PQWcZAe0dltXOm19nVJYwJJWi2dq7WvbL0zte3DZj0tNlUEFNXLqDgeml
         LiR84l0IkCxYdrrT4udmsd+5TtdX/Mf7vbOoB4vQKvuY8XVO24JZ6ryx3SgburlNZ1en
         n361TiEaIo8JGZ2WMsBORVeYdz2FfiCdElQZktJ2cwOpc1+3Pplr7uOVn0g83c/LGfUR
         Yz8vMjHwEXKFRmyAOK3ibdMtqNP0jNnQ2GXsmcH4oGUahvFNtK9tv027Oryso9ys8oDg
         4oTULwTwuk/F6LTgBpllFwmOLrpGwQB0/j1ALjXgqclPjyRdjMZ8pu/oOFrLMEu/fdBN
         0qZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3cDtNb67FBRi1Uco/nBrzJXAZJBmYND+awcpfoIMGOqfbmI6TnPTFceJck2rtjmgfQQxjnkzHVtxFEJAkcaAPJMoK
X-Gm-Message-State: AOJu0Yznl9RNNjkvBCoqbeipjx+y279eWZRo99d++xKgdDiLl8lq/27g
	wXSC3uGl2VEiSdnA1+DUwAfA/wdKy8VEYHd8NXpXR7z7chb2Q3ygxWEfZpFnpqPgl2Yjst6BkWr
	+H57Ogvp/jBR+gdBM1XWOgq4oDoo=
X-Google-Smtp-Source: AGHT+IH0b5hUMUnkCnExSUPSqID3XFbIO88M+xGRUUVz5wi2fkh9EPbYfICJqi3bApcoYurMEcG9BrXa2W2/LvBGZ/8=
X-Received: by 2002:a17:90a:8a06:b0:29f:ef7f:71d with SMTP id
 w6-20020a17090a8a0600b0029fef7f071dmr779319pjn.37.1712261352887; Thu, 04 Apr
 2024 13:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402225020.2582397-1-andrii@kernel.org> <20240402225020.2582397-2-andrii@kernel.org>
 <CAEf4Bza0QLa8m_iW4Rk_6+8tuJgvhF7gjk-p4HVHTRq2LJgPVg@mail.gmail.com> <791f362c-cdf1-4cd7-8fa2-95d05a4f4b22@linux.dev>
In-Reply-To: <791f362c-cdf1-4cd7-8fa2-95d05a4f4b22@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 13:09:00 -0700
Message-ID: <CAEf4BzYHL5FUB7FdpHQD=A4YZOnDvQ2FBtdjjonB_R0NDDy4NA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add fp-leaking precise
 subprog result tests
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:48=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 4/2/24 4:26 PM, Andrii Nakryiko wrote:
> > On Tue, Apr 2, 2024 at 3:50=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >> Add selftests validating that BPF verifier handles precision marking
> >> for SCALAR registers derived from r10 (fp) register correctly.
> >>
> >> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >> ---
> >>   .../bpf/progs/verifier_subprog_precision.c    | 86 +++++++++++++++++=
++
> >>   1 file changed, 86 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precis=
ion.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> >> index 6f5d19665cf6..e1a8f107f0a7 100644
> >> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> >> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> >> @@ -76,6 +76,92 @@ __naked int subprog_result_precise(void)
> >>          );
> >>   }
> >>
> >> +__naked __noinline __used
> >> +static unsigned long fp_leaking_subprog()
> >> +{
> >> +       asm volatile (
> >> +               "r0 =3D (s8)r10;"
> > Our CI's clang doesn't like this instruction. I guess I'll have to
> > encode it in binary form :(
>
> This patch disappeared from CI so I am not able to check the result.
>
> But I tried with the following small example.
>
> $ cat t.c
> __attribute__((naked)) unsigned long t(void)
> {
>          asm volatile("r0 =3D (s8)r10;"
>                       "exit;"
>                      );
> }
>
> $ clang --target=3Dbpf -O2 -mcpu=3Dv2 -g -c t.c && llvm-objdump -d t.o
>

You are using local clang built from source code, right? I think our
BPF CI still is on Clang 17 or something, so it doesn't yet understand
"(s8)r10" syntax, unfortunately.


> t.o:    file format elf64-bpf
>
> Disassembly of section .text:
>
> 0000000000000000 <t>:
>         0:       bf a0 08 00 00 00 00 00 r0 =3D (s8)r10
>         1:       95 00 00 00 00 00 00 00 exit
>
>
> -mcpu=3Dv3/v4 has the same result.
> Not sure what clang complains.
>
> >
> >> +               "exit;"
> >> +       );
> >> +}
> >> +
> > [...]
> >
