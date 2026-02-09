Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64C309DDD
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770671004; cv=none; b=FdOA6rOvHTK1g8O2DZ1tNfWZh07wdhFXWArNnF+hZgQtQVPT/yBuaAyaFn0WTXJbalp2wLHu5B2KeTI/z0mMcpTbsiE3kv5uLCKzAoWWtui5rrLje2OMcvehAD3AvAyUaN68PxXugN0pMql0NtCeWWoF4xerybz9zC08x8/+ZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770671004; c=relaxed/simple;
	bh=GJDfJnOHaI79H0tXxzcuV10vLmE0KsXZO5C2svzj+bE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=LfmK4wu2s7QVup2MgRUesxwpQGfBcc1Sb8C1Hzvft1s/0B2eGyymv9HwxavkxYF4o9R1YPIxnqzRyofuwHSoZkGgE/K1ED0gKGDld3J4RogK3kJFtbGA+h/R1E6Xkr1miLljCVJAV9fKeAewayGUeOqmSAXn6a9VOXb5GkW+8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ysCue2q5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ysCue2q5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 64078C6B3B9;
	Mon,  9 Feb 2026 21:03:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 39F49606BA;
	Mon,  9 Feb 2026 21:03:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4CAE119D0AE7;
	Mon,  9 Feb 2026 22:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770670998; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AwEuGSIsGoW4IUeidE6k0iFlF5XjwSsvISymkqXS4B4=;
	b=ysCue2q5UWCLjO0nklHCexSzUMuAb5Q+UeZJooytE5IAZLix22K7vrNN9+SRb4+yqr2nkg
	i7SAcsHDRHNcMgLvUIFBsJKWytLu2u1mMTyw46LHiLeIV+ldwRhSZ9wY1YDi54ESm29mx7
	zv0GISBHzdcI0Q/Z5I8cL7O5d8rgcsficTRmYY3sFgRcAYcHgBDVkmtyozis6pFbY70oVD
	fEshbeABuUDMGtevREn2SgRteR/++kI5vU80iS4Nm6dOkYsex3fueABzAPMHASHcI1mED4
	B9Yk4KJurraJWJ4iAAkQ4OhKxZYQOKQzvFl+r7A/07/J3w82S0R144KvzB/yPQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Feb 2026 22:03:16 +0100
Message-Id: <DGAQHE0JQEA4.1UVPB2DUTFPJD@bootlin.com>
Subject: Re: [RFC] adding KASAN support to JIT compiler(s)
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien Curutchet (eBPF
 Foundation)" <bastien.curutchet@bootlin.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Daniel Borkmann" <daniel@iogearbox.net>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DG7UG112AVBC.JKYISDTAM30T@bootlin.com>
 <CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2xGkE-ZNw@mail.gmail.com>
In-Reply-To: <CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2xGkE-ZNw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Alexei, thanks for the feedback,

On Sat Feb 7, 2026 at 4:02 AM CET, Alexei Starovoitov wrote:
> On Fri, Feb 6, 2026 at 3:31=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:

[...]

>> - similarly to what ASAN is doing ([2]), possibly implement a fast path/=
slow
>>   path, mechanism:
>>   - fast path: emit instructions to first check the whole corresponding
>>     shadow byte, it it's 0, access is legitimate, jump back to the
>>     actual memory access
>>   - slow path: if the shadow byte is not 0, emit a call to the relevant
>>     __asan_load/storeXXX to validate or report the access.
>
> Are you sure compilers do this optimization for KASAN?
> I don't remember ever seeing it in assembly.
> It sounds interesting, but let's do it in phase 2 when the whole
> thing is working and we start optimizing speed.

I've seen it described in ASAN documentation, but now that you mention
it, I did not see it in generated machine code... Anyway, that's indeed
likely some premature optimization, I'll keep this aside for now.

[...]

>> - bpf global variables: global variables in bpf programs are turned into
>>   maps. Those maps, when created by the kernel, are then already
>>   monitored (ie: poisoned/unpoisoned) when the corresponding memory is
>>   allocated/deallocated. I did not check all maps, but looking at a few
>>   of those, they are vmalloc'ed, so the proper monitoring will depend
>>   directly on CONFIG_KASAN_VMALLOC
>
> bpf global vars are in bpf array. So there is a shadow memory for it.
>
> As far as other map types. There is arena and it's special.
> load/store to arena are JITed differently already.
> They cannot be instrumented for kasan.

ACK, thanks for the clarification.

>> - bpf stack: when a program allocate some memory on its own stack, it is
>>   not tracked by KASAN. To be able to track stack memory misusage, JIT
>>   compiler must insert some red zones around the variables on the stack.
>>   This point looks more complex than the previous ones, as we need to:
>>   - identify variables that live on bpf program stack instead of
>>     registers
>>   - insert asan left/right red zones, and possibly inter-variables red z=
ones
>>   - and so account for this "stack overhead", eg in the verifier
>>   I then propose to put this "stack monitoring" as a next step, to be
>>   implemented once we have a basic kasan monitoring integrated in x86
>>   JIT compiler.
>
> I'm not sure it can be deferred. Pretty much all bpf programs
> access stack with load/stores.
> So all of such instructions should not be instrumented.

I am not sure to get your point here. If the matter can not be deferred
(because pretty much all bpf programs access stack with load/stores),
then all of such instructions _should_ be instrumented (so that we
detect invalid stack accesses), right ? Or am I getting it wrong ?

> It shouldn't be hard to do though.
> The verifier knows all stack accesses.
> It can mark such LDX/STX insns in insn_aux_data with some flag.
> Currently JITs don't have access to verifier info,
> but that's the direction we're going to:
> See proposal:
> https://lore.kernel.org/all/CAADnVQLha64x_LQ1Ph+0dEdP2sNms71k41pwEVMwxrbB=
G78M5Q@mail.gmail.com/
> It was couple weeks ago. If Xu Kuohai isn't going to follow up
> then this can be a prerequisite.

ACK. I'll follow Xu's work (and collaborate with him if
relevant/helpful), so that JIT comp can use verifier info to properly
monitor stack memory accesses.

I am not familiar yet with the verifier code, but I then expect this
work to potentially bring some changes into it as well (aside from the
info to pass to JIT comp. mentioned above). Eg, if adding red zones
around stack variables is indeed required, it will increase stack usage,
and so the verifier may have to account for those (eg when validating
max stack depth ?). I'll have to clarify this kind of point.

[...]

>> - I am also thinking about adding a sysctl (present and enabled by
>>   default if CONFIG_KASAN_EBPF=3D1), to allow temporarily disabling KASA=
N
>>   for ebpf programs. When set to 0, JIT compiler would stop inserting
>>   checking instructions in new programs being loaded.
>
> I'm not sure that sysctl is necessary. If the kernel is compiled
> with kasan and JIT supports it, it should go and instrument all progs.
> We can add sysctl later if necessary.

ACK.

Thanks,

Alexis


--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

