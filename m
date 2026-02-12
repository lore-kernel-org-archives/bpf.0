Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAFA2940D
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770862016; cv=pass; b=Fepz9sHWUQwAOBCH2fBMR6Grelyc8km/gjGv48hnedGmJ0Lofn/KNgv2ph8PUdVShAlwd7vaYYPQD5YRkEh+uhj/CLyAmsIN5CAgq2RY77CuMakZGw5nPMCK7VSw3vRMNSm+F8QN44pIJc7S7QyDfTcZ7ihANmmzopnY8GWxiNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770862016; c=relaxed/simple;
	bh=yW2oqYc0y2qvnYL9mK7IDaD2aVn9Nz7mBym5aQMgFH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyscJg7OpQJt0RNtxWLRScI0mCVuoK+6l922BcfiVcQIQPH0y89cSidq1MYGbWeluYvhLvUvFolhdseEUQvctpUKBCKkh9ntzOqWhGwi8PtJY22c5BgOOhxktCXqIVcR6zlBmTTeNkBeqIWqeRmhgd1llpcreCdsl7E1nqxhJpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffEp8e+A; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffEp8e+A"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4362507f0bcso1099342f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:06:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770862013; cv=none;
        d=google.com; s=arc-20240605;
        b=SmwUPnMCgC0dQS6K/n3VZSJXjfw/yF72attBGsKf2WE1mXyCZg5VPCR1Sp9qa5yXDV
         uXwpt27GGrH4HbpcIALl5/Cdo328/52rwIu0KHhV6bCQxIIBYTVBn/n1BA0z0dpyhHys
         0FAUOfyXbdxLZ9rZnf5DFx4/OKhL6z1A4QY53VzP3yX1o3JURy3zomEzyNJIxeov3SH2
         D8myQ4tAMO/FLOmQ7zucNXlJp9UG5V+RLoawjGfYjeYBG/8ZTC46IuYjZDuoBGW+6DJK
         qeEgbvlfVtiP8OE0HvXLVL8RZqK5vfl7jPnhP4nIlHHAFLTkCLBaN1gJxq4AWZFAvKQJ
         WTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVqLCKwqRA1FdKtzrLdx/KgUeP84BgYWWtQeHWMJGqM=;
        fh=daLfeIiCICAD4C8At3fbsQS4NFuQ3TbypFSrirDFhnI=;
        b=fMFLGQxlolzAC5CHRnIALwheFJcQ4T7eXAmx9wI2JNkpchIxZJSs/Qqk/yQWn5Ozem
         E8Oz2K24pzw34JHxbN7IKijZ0tBBrtAHjx8Xe9r5dX9pSnasFVvBbMVcmbr+ae9JTHii
         1++41I2whFd6TzUEAdPRcqIcews6YCcM+0414U5rw5RxLJG9D6ProiFfRbjtI9Ykh7h3
         rehhnNvMiL82BiWNgrCIOPDgshr5s0c/6Ak59z/c3wSfVCTvhi+0FowjFdwUhPIWTMbD
         W8NaEdo7Cg3blYTQR09sBgqh6mf20A+9j2Nsv736hCeYgPR/LFIO5uVaMhua3qDcF0eu
         QrrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770862013; x=1771466813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVqLCKwqRA1FdKtzrLdx/KgUeP84BgYWWtQeHWMJGqM=;
        b=ffEp8e+AMsdZqL79M2EmcCdgoioqc3vCANbhIkH66DAqWWzUGeCzPhQsb7MVw9W+7q
         QNqOaXb57v7k6HtmhrAIUzfFskVvqAKHC2kPMRFnwN+0U/o28LSo8pwwUDWGkfPVu6S3
         4+IsLlOWW4iMGUdJblSyNhjHMkrKawiPudyvtuU6j2a3QCViZhss7HMZqn6J4TnY7Md7
         lZFdpkCETTXM7A8cuApgrBbygSSZ0DN0qBwA9h+NSy6Z7piPAJ5QmXvrwuqR2SgDIpua
         neyD2VjNLk/AC18c9TnHk5CirzTPcfvu8LA/KSUCFSMUD/BVAkzB7F5W52XLf0JArXFA
         PdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770862013; x=1771466813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVqLCKwqRA1FdKtzrLdx/KgUeP84BgYWWtQeHWMJGqM=;
        b=BR9nujKqOpJ8DXcizrU4FrlhZxz+D3y0e8rvhKpm/198HrkKaYdcQ05IWfc/kGdq4+
         ssGxfEPjh8HZigBgwrBgoFvYtDiyrEw6z1Ky4nuAa57NicCd3/SNF2uX9iRf8qSju76y
         ToLzrJZTLz2mIJLy05zZ6cpmvNXr4BQE3jvULOzMf1njl6kbPJFMbAcUAv8/LajyK9hZ
         IWrETsm2WKECP4QB1d2IRAkVdU4pQ5gDmWXgfPCQwPiEQp+RCAz7+d9z/61LGpHU4umk
         8jbj0y2xR8OcRF4X44cVWBDM5LkLzTFbY0F71hXxE73l4ZpSqyDL7+TMnxICZiZWPn4R
         OmZg==
X-Gm-Message-State: AOJu0YxN4rEkxec7Yja+tgWaeBGhZlIitC7Z2GfU/DbEAdV0TiMxId5p
	cCxEjIXYW4MdgrbGsjqNH5o2Fp2HIxKtAYxrHMLke6S6oce6wwe5F3CKie8WQJ2Yld42FvcygCp
	8ixI/c+UoZDkeRaM9rxTMjqVhPr3ekcI=
X-Gm-Gg: AZuq6aJCTyhpahsAgZwJPcf4KQyD5fGH256opoCzclmRLitpZ7e5bkNGZ473+mzr0O3
	ldypTfpzdVSx6mBc1VXcoQSyoxNtJ93hxyXcw4QlCdnvj0b8sMpHzWgtU/bCRUYNVkJP9Mr9+HG
	LrEs72cCIXJRpPYDmLNFGg2LQTGBqQTT8gTGVt/vKy4ZWRXhvDFwugqX5c31a7K3U6zTa03REmt
	/ungd3+Xs4vuXbgaYWbH7aMzvfX8EhdDXDKRavXAXcf8F4dPh2GAGcsMLXn8+ueOIXCG5fsewAj
	peqJfl3JFRfUWqW+erxY0aLttgJIJAJIxWt64KbyW3OEfBUL87aZJx8rG/PFgWvFVusXsKBXAAr
	XaTqWA3enzYhfRWOx+t/qDvIwpXrVyEYB+HR1
X-Received: by 2002:a05:6000:2c10:b0:436:e875:7911 with SMTP id
 ffacd0b85a97d-4378e5c8762mr1341554f8f.4.1770862012817; Wed, 11 Feb 2026
 18:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DG7UG112AVBC.JKYISDTAM30T@bootlin.com> <CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2xGkE-ZNw@mail.gmail.com>
 <DGAQHE0JQEA4.1UVPB2DUTFPJD@bootlin.com> <CAADnVQKrXL2QNMoxTQ+nN1-dAEk0oHYBLy+h8J=mDSYXtVomPw@mail.gmail.com>
 <DGCIL1452266.2618L8NG0SLPN@bootlin.com>
In-Reply-To: <DGCIL1452266.2618L8NG0SLPN@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 18:06:41 -0800
X-Gm-Features: AZwV_QgEv1G-4OsNNapIwzATadIlFt3PZ0TV61jRzV2Tj0dIrJWRNpwikqwd8o8
Message-ID: <CAADnVQKS78vbwdN4Z3Hmt6C9jvY=k0V9rO18M-n6NvLBgsyuuw@mail.gmail.com>
Subject: Re: [RFC] adding KASAN support to JIT compiler(s)
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 3:17=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Tue Feb 10, 2026 at 10:43 PM CET, Alexei Starovoitov wrote:
> > On Mon, Feb 9, 2026 at 1:03=E2=80=AFPM Alexis Lothor=C3=A9
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> >> - bpf stack: when a program allocate some memory on its own stack, =
it is
> >> >>   not tracked by KASAN. To be able to track stack memory misusage, =
JIT
> >> >>   compiler must insert some red zones around the variables on the s=
tack.
> >> >>   This point looks more complex than the previous ones, as we need =
to:
> >> >>   - identify variables that live on bpf program stack instead of
> >> >>     registers
> >> >>   - insert asan left/right red zones, and possibly inter-variables =
red zones
> >> >>   - and so account for this "stack overhead", eg in the verifier
> >> >>   I then propose to put this "stack monitoring" as a next step, to =
be
> >> >>   implemented once we have a basic kasan monitoring integrated in x=
86
> >> >>   JIT compiler.
> >> >
> >> > I'm not sure it can be deferred. Pretty much all bpf programs
> >> > access stack with load/stores.
> >> > So all of such instructions should not be instrumented.
> >>
> >> I am not sure to get your point here. If the matter can not be deferre=
d
> >> (because pretty much all bpf programs access stack with load/stores),
> >> then all of such instructions _should_ be instrumented (so that we
> >> detect invalid stack accesses), right ? Or am I getting it wrong ?
> >
> > As far as I understand compilers don't sanitize stack access
> > because there is no shadow memory behind it.
>
> Is that so ? Because if I take a look at kasan tests in the kernel, I
> find for example this kasan_stack_oob in mm/kasan/kasan_test_c.c:
>
> static void kasan_stack_oob(struct kunit *test)
> {
>         char stack_array[10];
>         /* See comment in kasan_global_oob_right. */
>         char *volatile array =3D stack_array;
>         char *p =3D &array[ARRAY_SIZE(stack_array) + OOB_TAG_OFF];
>
>         KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_STACK);
>
>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
> }
>
> which gives me, for x86:
>
> 0000000000000340 <kasan_stack_oob>:
>      340:       f3 0f 1e fa             endbr64
>      344:       e8 00 00 00 00          call   349 <kasan_stack_oob+0x9>
>      349:       48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx
>      350:       fc ff df
>      353:       41 56                   push   %r14
>      355:       31 c9                   xor    %ecx,%ecx
>      357:       4c 8d b7 e0 01 00 00    lea    0x1e0(%rdi),%r14
>      35e:       41 55                   push   %r13
>      360:       41 54                   push   %r12
>      362:       55                      push   %rbp
>      363:       48 89 fd                mov    %rdi,%rbp
>      366:       53                      push   %rbx
>      367:       48 81 ec c0 00 00 00    sub    $0xc0,%rsp
>      36e:       48 89 e0                mov    %rsp,%rax
>      371:       48 c7 04 24 b3 8a b5    movq   $0x41b58ab3,(%rsp)
>      378:       41
>      379:       48 c7 44 24 08 00 00    movq   $0x0,0x8(%rsp)
>      380:       00 00
>      382:       48 c1 e8 03             shr    $0x3,%rax
>      386:       48 c7 44 24 10 00 00    movq   $0x0,0x10(%rsp)
>      38d:       00 00
>      38f:       48 89 c3                mov    %rax,%rbx
>      392:       48 01 d0                add    %rdx,%rax                <=
=3D %rax =3D (%rsp >> 3) + SHADOW_OFFSET
>      395:       c7 00 f1 f1 f1 f1       movl   $0xf1f1f1f1,(%rax)       <=
=3D left red zone
>      39b:       c7 40 04 f1 f1 01 f2    movl   $0xf201f1f1,0x4(%rax)    <=
=3D left red zone, ??? (1 byte unpoisoned), mid red zone
>      3a2:       c7 40 08 00 f2 f2 f2    movl   $0xf2f2f200,0x8(%rax)    <=
=3D mid red zone, array unpoisoned ?
>      3a9:       c7 40 0c 00 00 f2 f2    movl   $0xf2f20000,0xc(%rax)    <=
=3D ??? (16 bytes unpoisoned), mid red zone
>      3b0:       c7 40 10 00 02 f3 f3    movl   $0xf3f30200,0x10(%rax)   <=
=3D stack_array unpoisoned ? right red zone
>      [...]

hmm. indeed. For arrays on stack passed by pointer deeper
into calls the compiler creates these run-time zones.
The other stack accesses are not instrumented.

How do you propose to support this in JIT?
I see no workable way of doing it.
