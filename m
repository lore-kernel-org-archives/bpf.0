Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CA29A30E
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770989490; cv=none; b=gkUPIbxY1tuIBLqr8z35EIs5vXQ4zFzmILRS4bI1Gek89ESFMSkwIpygGcq7UZD5FtFmjK06IMrFb2zopNRXkhJ6lLL5DkBstACP5BBZqZdQi0Jd1snzI2f55HyHSGOv4Q6S8DXGNZNq0Y+Wid4QHI/xDZXVwP3gEmR2XtubIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770989490; c=relaxed/simple;
	bh=7ORPbNA8YS+x2330HYPMQLGeO7+C3Lc67adICDN5+J0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=cE8VX5NDvHZhfn7LNiXNwmeMXKmTrZU1EEd4rckLwRcDlYu3rlH5NOb48vk2oTHlvUGKokZGwr0knEEq/75xonizVTlllxzyvnv5FiOby1EgLCiFori1ReybAd+6IAWvJ+rWAnlyuSvkq+4DELOVqPx8aoG0bKG5LCqkbv/ZVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iD7NZrz7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iD7NZrz7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7AB981A0E6C;
	Fri, 13 Feb 2026 13:31:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FC44606BE;
	Fri, 13 Feb 2026 13:31:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 807BD10368E92;
	Fri, 13 Feb 2026 14:31:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770989484; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+VkGexTFiMl4GTjkhWi4NIEwOEPfIA3ju4QM9Ebu1dw=;
	b=iD7NZrz7ARniqczpvyq+JISpX5tN+RCxXoNR7G5jebWoN5ld5BBxh5D/9sMPPoILK9+Gbp
	BFCKBg7wCKT9XLDxAKRMWPlLdNs+/mEbWn4HWI1U1IDRZ5uLfixq5Qhyhqmv7Fs5Hf6psh
	6bkoL3z1w5ek/AQrPn7EflWVL/4N4iGKydcmoQ9wVAL1Ms8Sec1zoN5toMSFQGkZRQlvNu
	h27bdwQdtPY12yfvKk1+0o9Kvtw0YdRQB9X50K5OjN3ZRFPM091dWSiRxdn5fBaZEKduSL
	XA9+6uCdGn4RBK8bRGoTcWaFxBXlu7Z9i3BBLdjBU4lB0WxPrMc9/quGZLUtrg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 14:31:22 +0100
Message-Id: <DGDVDKRNKOZX.1TKXZO951OFH1@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: Re: [RFC] adding KASAN support to JIT compiler(s)
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien Curutchet (eBPF
 Foundation)" <bastien.curutchet@bootlin.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Daniel Borkmann" <daniel@iogearbox.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DG7UG112AVBC.JKYISDTAM30T@bootlin.com>
 <CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2xGkE-ZNw@mail.gmail.com>
 <DGAQHE0JQEA4.1UVPB2DUTFPJD@bootlin.com>
 <CAADnVQKrXL2QNMoxTQ+nN1-dAEk0oHYBLy+h8J=mDSYXtVomPw@mail.gmail.com>
 <DGCIL1452266.2618L8NG0SLPN@bootlin.com>
 <CAADnVQKS78vbwdN4Z3Hmt6C9jvY=k0V9rO18M-n6NvLBgsyuuw@mail.gmail.com>
In-Reply-To: <CAADnVQKS78vbwdN4Z3Hmt6C9jvY=k0V9rO18M-n6NvLBgsyuuw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Feb 12, 2026 at 3:06 AM CET, Alexei Starovoitov wrote:
> On Wed, Feb 11, 2026 at 3:17=E2=80=AFPM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:
>>
>> On Tue Feb 10, 2026 at 10:43 PM CET, Alexei Starovoitov wrote:
>> > On Mon, Feb 9, 2026 at 1:03=E2=80=AFPM Alexis Lothor=C3=A9
>> > <alexis.lothore@bootlin.com> wrote:
>> >>
>> >> >> - bpf stack: when a program allocate some memory on its own stack,=
 it is
>> >> >>   not tracked by KASAN. To be able to track stack memory misusage,=
 JIT
>> >> >>   compiler must insert some red zones around the variables on the =
stack.
>> >> >>   This point looks more complex than the previous ones, as we need=
 to:
>> >> >>   - identify variables that live on bpf program stack instead of
>> >> >>     registers
>> >> >>   - insert asan left/right red zones, and possibly inter-variables=
 red zones
>> >> >>   - and so account for this "stack overhead", eg in the verifier
>> >> >>   I then propose to put this "stack monitoring" as a next step, to=
 be
>> >> >>   implemented once we have a basic kasan monitoring integrated in =
x86
>> >> >>   JIT compiler.
>> >> >
>> >> > I'm not sure it can be deferred. Pretty much all bpf programs
>> >> > access stack with load/stores.
>> >> > So all of such instructions should not be instrumented.
>> >>
>> >> I am not sure to get your point here. If the matter can not be deferr=
ed
>> >> (because pretty much all bpf programs access stack with load/stores),
>> >> then all of such instructions _should_ be instrumented (so that we
>> >> detect invalid stack accesses), right ? Or am I getting it wrong ?
>> >
>> > As far as I understand compilers don't sanitize stack access
>> > because there is no shadow memory behind it.
>>
>> Is that so ? Because if I take a look at kasan tests in the kernel, I
>> find for example this kasan_stack_oob in mm/kasan/kasan_test_c.c:
>>
>> static void kasan_stack_oob(struct kunit *test)
>> {
>>         char stack_array[10];
>>         /* See comment in kasan_global_oob_right. */
>>         char *volatile array =3D stack_array;
>>         char *p =3D &array[ARRAY_SIZE(stack_array) + OOB_TAG_OFF];
>>
>>         KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_STACK);
>>
>>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>> }
>>
>> which gives me, for x86:
>>
>> 0000000000000340 <kasan_stack_oob>:
>>      340:       f3 0f 1e fa             endbr64
>>      344:       e8 00 00 00 00          call   349 <kasan_stack_oob+0x9>
>>      349:       48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx
>>      350:       fc ff df
>>      353:       41 56                   push   %r14
>>      355:       31 c9                   xor    %ecx,%ecx
>>      357:       4c 8d b7 e0 01 00 00    lea    0x1e0(%rdi),%r14
>>      35e:       41 55                   push   %r13
>>      360:       41 54                   push   %r12
>>      362:       55                      push   %rbp
>>      363:       48 89 fd                mov    %rdi,%rbp
>>      366:       53                      push   %rbx
>>      367:       48 81 ec c0 00 00 00    sub    $0xc0,%rsp
>>      36e:       48 89 e0                mov    %rsp,%rax
>>      371:       48 c7 04 24 b3 8a b5    movq   $0x41b58ab3,(%rsp)
>>      378:       41
>>      379:       48 c7 44 24 08 00 00    movq   $0x0,0x8(%rsp)
>>      380:       00 00
>>      382:       48 c1 e8 03             shr    $0x3,%rax
>>      386:       48 c7 44 24 10 00 00    movq   $0x0,0x10(%rsp)
>>      38d:       00 00
>>      38f:       48 89 c3                mov    %rax,%rbx
>>      392:       48 01 d0                add    %rdx,%rax                =
<=3D %rax =3D (%rsp >> 3) + SHADOW_OFFSET
>>      395:       c7 00 f1 f1 f1 f1       movl   $0xf1f1f1f1,(%rax)       =
<=3D left red zone
>>      39b:       c7 40 04 f1 f1 01 f2    movl   $0xf201f1f1,0x4(%rax)    =
<=3D left red zone, ??? (1 byte unpoisoned), mid red zone
>>      3a2:       c7 40 08 00 f2 f2 f2    movl   $0xf2f2f200,0x8(%rax)    =
<=3D mid red zone, array unpoisoned ?
>>      3a9:       c7 40 0c 00 00 f2 f2    movl   $0xf2f20000,0xc(%rax)    =
<=3D ??? (16 bytes unpoisoned), mid red zone
>>      3b0:       c7 40 10 00 02 f3 f3    movl   $0xf3f30200,0x10(%rax)   =
<=3D stack_array unpoisoned ? right red zone
>>      [...]
>
> hmm. indeed. For arrays on stack passed by pointer deeper
> into calls the compiler creates these run-time zones.
> The other stack accesses are not instrumented.
>
> How do you propose to support this in JIT?
> I see no workable way of doing it.

I did not think deeply enough about it to identify clear blockers, but I
was imagining quite some difficulties to do it, hence my initial
proposal to "postpone" this specific monitoring :) (before you suggested
to rather take it into account to actually make sure to _ignore_ all the
corresponding stack accesss insns in the monitoring).

I was initially imagining that I could somehow benefit from a program
BTF info to identify variables on stack and their location, but it would
not work on this kind of example, as this really is a local variable,
not a function argument, and so this is not described in the BTF info. I
guess this is only one issue amongst all those I did not even think of,
but remembering about the issues encountered when working on trampolines
for ARM64, I guess there's also a wide variety of corner cases about
variables location and size, eg when they have custom attributes...
On top of that, I am not sure how frequent could the example I mentioned
above be present in in BPF programs. More likely pretty uncommon ?

So as for myself, I'm fine with your proposal to rather make JIT comp
aware of stack-related insns and just ignore those :)

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

