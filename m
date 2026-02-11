Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D126B741
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770851841; cv=none; b=Jafk0sJmEel+cFnDi6q20JaCjjcHxC6l0H//t1QryVF4zaDrnrlnqKbuBdzZmFASisej9uknkCZpSeO89s9xg4GnnVgGewhgW3GAWEMOOAflbGz6JRfkP2oPCH5KozxRvieJHBIPtrWwvWmWHcrxz1C2cqEFgq0/2N9t6M8SlJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770851841; c=relaxed/simple;
	bh=sUQHabvXbHb5u7I/b1Of0e8FimSV4sOt43YO4E0umP4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=MwYq7N7WDtIw3WXZEhDaS6DFIG1mOr/76dDIo2aG+pQOrglF+aJtCAwgT7pZZIWHGZ5LnBirhzblpfjli7YTHw/+Dc3+GVotYRdCdlE5Qc08uxJIP+v7R1hdKQ1udTWuLiVV0DiZi+/emIrBkN/iNe/pxaFCmt7P9CgARu6yETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QpuSZIDy; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QpuSZIDy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B0640C23D8A;
	Wed, 11 Feb 2026 23:17:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B1479606B1;
	Wed, 11 Feb 2026 23:17:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65CC21194956A;
	Thu, 12 Feb 2026 00:17:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770851834; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MboFByo2KiRht1OZ+sIoIwC5SQo6Vfy1RGQanSlgaFc=;
	b=QpuSZIDyzm3rj/4JUIMmFv5AGvU+FEom0JW/7/A873OoxR9XAaXHsc/GzxzRExy/nASs1v
	NSHPWzzf8BCrTDs52jjmjw+eNTy7Ga9oOqQfVf1cIaCoA/gwfxoKoR7ZBuI0qPeUw2KHc0
	bcqWG7VcKZW/d5/tMB6eue4Bq1GAs2h5eqCYo03kgKtCCdrPWIqqwM4sMA6jTd+8fsRa34
	RumHyRMRqlDni6tvghOGFye1T3zyGHOklaLgXz6mtSK/RWPm+/RWdk7VCHf2xMuOO/CAjm
	oT9Lus4QNaLOu9mnA8U2GngmxEuZf7X6WYC08B+rPVWoyfmjsOOtAnGR+tGVfw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 00:17:12 +0100
Message-Id: <DGCIL1452266.2618L8NG0SLPN@bootlin.com>
Subject: Re: [RFC] adding KASAN support to JIT compiler(s)
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien Curutchet (eBPF
 Foundation)" <bastien.curutchet@bootlin.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Daniel Borkmann" <daniel@iogearbox.net>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DG7UG112AVBC.JKYISDTAM30T@bootlin.com>
 <CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2xGkE-ZNw@mail.gmail.com>
 <DGAQHE0JQEA4.1UVPB2DUTFPJD@bootlin.com>
 <CAADnVQKrXL2QNMoxTQ+nN1-dAEk0oHYBLy+h8J=mDSYXtVomPw@mail.gmail.com>
In-Reply-To: <CAADnVQKrXL2QNMoxTQ+nN1-dAEk0oHYBLy+h8J=mDSYXtVomPw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Feb 10, 2026 at 10:43 PM CET, Alexei Starovoitov wrote:
> On Mon, Feb 9, 2026 at 1:03=E2=80=AFPM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:
>>
>> >> - bpf stack: when a program allocate some memory on its own stack, it=
 is
>> >>   not tracked by KASAN. To be able to track stack memory misusage, JI=
T
>> >>   compiler must insert some red zones around the variables on the sta=
ck.
>> >>   This point looks more complex than the previous ones, as we need to=
:
>> >>   - identify variables that live on bpf program stack instead of
>> >>     registers
>> >>   - insert asan left/right red zones, and possibly inter-variables re=
d zones
>> >>   - and so account for this "stack overhead", eg in the verifier
>> >>   I then propose to put this "stack monitoring" as a next step, to be
>> >>   implemented once we have a basic kasan monitoring integrated in x86
>> >>   JIT compiler.
>> >
>> > I'm not sure it can be deferred. Pretty much all bpf programs
>> > access stack with load/stores.
>> > So all of such instructions should not be instrumented.
>>
>> I am not sure to get your point here. If the matter can not be deferred
>> (because pretty much all bpf programs access stack with load/stores),
>> then all of such instructions _should_ be instrumented (so that we
>> detect invalid stack accesses), right ? Or am I getting it wrong ?
>
> As far as I understand compilers don't sanitize stack access
> because there is no shadow memory behind it.

Is that so ? Because if I take a look at kasan tests in the kernel, I
find for example this kasan_stack_oob in mm/kasan/kasan_test_c.c:

static void kasan_stack_oob(struct kunit *test)
{
        char stack_array[10];
        /* See comment in kasan_global_oob_right. */
        char *volatile array =3D stack_array;
        char *p =3D &array[ARRAY_SIZE(stack_array) + OOB_TAG_OFF];

        KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_STACK);

        KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
}

which gives me, for x86:

0000000000000340 <kasan_stack_oob>:
     340:       f3 0f 1e fa             endbr64
     344:       e8 00 00 00 00          call   349 <kasan_stack_oob+0x9>
     349:       48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx
     350:       fc ff df
     353:       41 56                   push   %r14
     355:       31 c9                   xor    %ecx,%ecx
     357:       4c 8d b7 e0 01 00 00    lea    0x1e0(%rdi),%r14
     35e:       41 55                   push   %r13
     360:       41 54                   push   %r12
     362:       55                      push   %rbp
     363:       48 89 fd                mov    %rdi,%rbp
     366:       53                      push   %rbx
     367:       48 81 ec c0 00 00 00    sub    $0xc0,%rsp
     36e:       48 89 e0                mov    %rsp,%rax
     371:       48 c7 04 24 b3 8a b5    movq   $0x41b58ab3,(%rsp)
     378:       41
     379:       48 c7 44 24 08 00 00    movq   $0x0,0x8(%rsp)
     380:       00 00
     382:       48 c1 e8 03             shr    $0x3,%rax
     386:       48 c7 44 24 10 00 00    movq   $0x0,0x10(%rsp)
     38d:       00 00
     38f:       48 89 c3                mov    %rax,%rbx
     392:       48 01 d0                add    %rdx,%rax 		<=3D %rax =3D (%=
rsp >> 3) + SHADOW_OFFSET
     395:       c7 00 f1 f1 f1 f1       movl   $0xf1f1f1f1,(%rax) 	<=3D lef=
t red zone
     39b:       c7 40 04 f1 f1 01 f2    movl   $0xf201f1f1,0x4(%rax) 	<=3D =
left red zone, ??? (1 byte unpoisoned), mid red zone
     3a2:       c7 40 08 00 f2 f2 f2    movl   $0xf2f2f200,0x8(%rax)	<=3D m=
id red zone, array unpoisoned ?
     3a9:       c7 40 0c 00 00 f2 f2    movl   $0xf2f20000,0xc(%rax) 	<=3D =
??? (16 bytes unpoisoned), mid red zone
     3b0:       c7 40 10 00 02 f3 f3    movl   $0xf3f30200,0x10(%rax)	<=3D =
stack_array unpoisoned ? right red zone
     [...]

Am I misinterpreting something here ?

For the record, my kernel is compiled with GCC, for x86, with generic,
inlined kasan. Digging a bit more in the corresponding commits and
Kconfig file, I see that this stack monitoring is not enabled for all
architectures and compilers, though.  For example, I see that it is
deemed "unsafe" when using clang.

> There is no "allocation of stack" or "deallocation", so no UAF
> or things like that.
> The kernel already has guard pages for stack overflow and that's
> about it.
>
>> I am not familiar yet with the verifier code, but I then expect this
>> work to potentially bring some changes into it as well (aside from the
>> info to pass to JIT comp. mentioned above). Eg, if adding red zones
>> around stack variables is indeed required, it will increase stack usage,
>> and so the verifier may have to account for those (eg when validating
>> max stack depth ?). I'll have to clarify this kind of point.
>
> Redzones? Around what? There is no way to tell where variables
> are and that one access aliases into another.
> imo existing stack guard pages are enough here.
> So no instrumentation of stack ldx/stx.

Aside from the point above, if guard pages are considered enough, ok
then, I can make sure to make JIT comp ignore stack accesses when
instrumenting load/store insns (with the data passing from the verifier
to be implemented, related to Xu's work).

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

