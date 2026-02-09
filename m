Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE412221F15
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672644; cv=none; b=MWWrNN5fT12Rkrf11mvPZNEcFlykBNx7UVHzlm1iobP9/oqgaDcSh0OgTYm5BTUl9WU10w+1itr3PUjgc6zexPY7B0/HhpjtU9wjSx0PWghKG5bsay+VdFWQOIG5FFib2ODpwZ+sXGpL3LAu8FqlPylGcWqohb1aLwo4WDcyYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672644; c=relaxed/simple;
	bh=qI0RIxO0mONxKjvFfgFzYqf+OgXn3djrJEmyIaQDoUo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=oP/4ludlQ8M7FXHEryyvumhaI2p3ep9M0swIhcnqa/Zly1aOX9J3P3AQSVxHTSQqUuWM5fUJthxBWO5aC2sK/N86mvAFwU4CgobDiqGI9WPL3JRWqYkKbRVf6dXWhby5Mx8ziz1xdT6RzGJt9qHXqEvhfcOMpE2EWpzY9yMAz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Y6XZ1Cze; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Y6XZ1Cze"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c6d8751c88so516833485a.2
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 13:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770672642; x=1771277442; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpvEbqGZKSU4mp3Iw9aJ/xMN22ZV9omtq3gJ1rsfKV8=;
        b=Y6XZ1CzeZAs7bH7gz97VTRLTw9jzPEcrABBUgvLC8KyXiv47oTlKblwLydWgiWXTUl
         ypYJAT+ygAvINA7FIuT9sgLGefymTuc9FTUg71l7Zb/CrJXVJqGqU54Sc4mg+CuMtoT2
         Kf6SkGVblFItfjF+bzCDoTpU0x19/ZAn6lSA9kSRfW7Ue/CbzxNCP42wZnlklh8UjhEQ
         t3yGtxZYfsGsoYaodsIBZFANQFkccNe6PHQ5rDdmxLD7WmQGxyEnkYmhHlZwtcAzzm15
         lyBSxeWNgZW+2ZQgdqchGLhaF2iDITNvl0T4MADZN2kiygv+rJ+Z8dvkwBymV9xjrac8
         mA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672642; x=1771277442;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpvEbqGZKSU4mp3Iw9aJ/xMN22ZV9omtq3gJ1rsfKV8=;
        b=vIRt5pCRPY/OEaog7nP91n3pJh3WqMl2DwMsSEuSbX95ULlF/cdOMa8viQl3tyhzAy
         /QxrG6alPa2xaIZcDc6571hifsvLKwfEDee0IU/7EFaG34nVZo2T7JYpJO67edULzL95
         i4srDtXVb76bylqgc3SEYuHtTFq0Xc1cMvLNvtOH2Cp05lpYtmMMNmC3wGwWNYNVKAzd
         qPJVpmpiqiHNuXcUT1jbpi0JnFNIuq/0IKTPq1pneNQtRKd3lS8Wa8/BfZ7YMbOQ5V7C
         x2vM1hfaLtdV+GpdqGEWmuAcoLik5rRAlcERf/QUPehx9hYUxPG91EB8vpujPS3pOODb
         DsmQ==
X-Gm-Message-State: AOJu0YxyeGKFhh415gxeO9dqHXgcgZ0uKpAl299DknDQ//9FzXrjfLyH
	/216RiSs7Heck4Qpo4f0Te0j2yvN8IoOux25V22RUEvYbB7bFGziUsmHSG82YOofC2y9onhJ9uX
	SPpr/sm0=
X-Gm-Gg: AZuq6aLj2mNp1TCV8U0PDoAj5cXxC5e9ng18tqEkk3NarWkXWsQLZDpUIk/uo0zb5nf
	O2E4K1eFS1lWNvwsobZjLF7IzUVoGp9fFPrzQo13Lk3e71Z7daDxDjwsaPRENyk2whT86iT8cQS
	hlqe1hxDW/8bgJfthW+s4Jm5MKqnrOxiFN3NkiTA3suKQyDFUZw3blTKELq5VTTqbYrQBWox/gI
	fi+46Z66co9K/MZqzvoQIQAoRTJD1Oqz0aC9jWSxUaV8fr+j4YZiG1ahSlRVw/mSHsrdXwrfUSs
	aD9ZEC7K/rBFHjQXddUfiP6rJGJZWc7UF+z+b4Z3U0GGm7//L569H0Ao1RBQmdn36a17n6+4X/1
	faHTxGFeHgWns3o7JnEarqxbfHyF4IiYLe+vtEn7woWD0G0cH29TMc3z8cjNWNVxneElojRWaFq
	L9XRN0Nc//gqA=
X-Received: by 2002:a05:620a:1aa0:b0:8b2:f191:2b3a with SMTP id af79cd13be357-8caf0c45752mr1715236085a.53.1770672641618;
        Mon, 09 Feb 2026 13:30:41 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cafa3bf1a2sm973837685a.47.2026.02.09.13.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 13:30:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Feb 2026 16:30:40 -0500
Message-Id: <DGAR2DEF3Y8X.1G2DQMTFLNTJG@etsalapatis.com>
Subject: Re: [RFC] adding KASAN support to JIT compiler(s)
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Alexei
 Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien Curutchet (eBPF
 Foundation)" <bastien.curutchet@bootlin.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>
X-Mailer: aerc 0.20.1
References: <DG7UG112AVBC.JKYISDTAM30T@bootlin.com>
 <CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2xGkE-ZNw@mail.gmail.com>
 <DGAQHE0JQEA4.1UVPB2DUTFPJD@bootlin.com>
In-Reply-To: <DGAQHE0JQEA4.1UVPB2DUTFPJD@bootlin.com>

On Mon Feb 9, 2026 at 4:03 PM EST, Alexis Lothor=C3=A9 wrote:
> Hi Alexei, thanks for the feedback,
>
> On Sat Feb 7, 2026 at 4:02 AM CET, Alexei Starovoitov wrote:
>> On Fri, Feb 6, 2026 at 3:31=E2=80=AFAM Alexis Lothor=C3=A9
>> <alexis.lothore@bootlin.com> wrote:
>
> [...]
>
>>> - similarly to what ASAN is doing ([2]), possibly implement a fast path=
/slow
>>>   path, mechanism:
>>>   - fast path: emit instructions to first check the whole corresponding
>>>     shadow byte, it it's 0, access is legitimate, jump back to the
>>>     actual memory access
>>>   - slow path: if the shadow byte is not 0, emit a call to the relevant
>>>     __asan_load/storeXXX to validate or report the access.
>>
>> Are you sure compilers do this optimization for KASAN?
>> I don't remember ever seeing it in assembly.
>> It sounds interesting, but let's do it in phase 2 when the whole
>> thing is working and we start optimizing speed.
>
> I've seen it described in ASAN documentation, but now that you mention
> it, I did not see it in generated machine code... Anyway, that's indeed
> likely some premature optimization, I'll keep this aside for now.
>

Short note on that, LLVM ASAN has code for automatically doing what sounds=
=20
like this optimization [1]. If the pass is configured to generate ASAN=20
code directly instead of injecting runtime calls, it does pretty much what=
=20
you're describing.

[1] https://github.com/llvm/llvm-project/blob/8418c4196d5c5a60003b0f19257df=
ef2ffbe008e/llvm/lib/Transforms/Instrumentation/AddressSanitizer.cpp#L1937

> [...]
>
>>> - bpf global variables: global variables in bpf programs are turned int=
o
>>>   maps. Those maps, when created by the kernel, are then already
>>>   monitored (ie: poisoned/unpoisoned) when the corresponding memory is
>>>   allocated/deallocated. I did not check all maps, but looking at a few
>>>   of those, they are vmalloc'ed, so the proper monitoring will depend
>>>   directly on CONFIG_KASAN_VMALLOC
>>
>> bpf global vars are in bpf array. So there is a shadow memory for it.
>>
>> As far as other map types. There is arena and it's special.
>> load/store to arena are JITed differently already.
>> They cannot be instrumented for kasan.
>
> ACK, thanks for the clarification.
>
>>> - bpf stack: when a program allocate some memory on its own stack, it i=
s
>>>   not tracked by KASAN. To be able to track stack memory misusage, JIT
>>>   compiler must insert some red zones around the variables on the stack=
.
>>>   This point looks more complex than the previous ones, as we need to:
>>>   - identify variables that live on bpf program stack instead of
>>>     registers
>>>   - insert asan left/right red zones, and possibly inter-variables red =
zones
>>>   - and so account for this "stack overhead", eg in the verifier
>>>   I then propose to put this "stack monitoring" as a next step, to be
>>>   implemented once we have a basic kasan monitoring integrated in x86
>>>   JIT compiler.
>>
>> I'm not sure it can be deferred. Pretty much all bpf programs
>> access stack with load/stores.
>> So all of such instructions should not be instrumented.
>
> I am not sure to get your point here. If the matter can not be deferred
> (because pretty much all bpf programs access stack with load/stores),
> then all of such instructions _should_ be instrumented (so that we
> detect invalid stack accesses), right ? Or am I getting it wrong ?
>
>> It shouldn't be hard to do though.
>> The verifier knows all stack accesses.
>> It can mark such LDX/STX insns in insn_aux_data with some flag.
>> Currently JITs don't have access to verifier info,
>> but that's the direction we're going to:
>> See proposal:
>> https://lore.kernel.org/all/CAADnVQLha64x_LQ1Ph+0dEdP2sNms71k41pwEVMwxrb=
BG78M5Q@mail.gmail.com/
>> It was couple weeks ago. If Xu Kuohai isn't going to follow up
>> then this can be a prerequisite.
>
> ACK. I'll follow Xu's work (and collaborate with him if
> relevant/helpful), so that JIT comp can use verifier info to properly
> monitor stack memory accesses.
>
> I am not familiar yet with the verifier code, but I then expect this
> work to potentially bring some changes into it as well (aside from the
> info to pass to JIT comp. mentioned above). Eg, if adding red zones
> around stack variables is indeed required, it will increase stack usage,
> and so the verifier may have to account for those (eg when validating
> max stack depth ?). I'll have to clarify this kind of point.
>
> [...]
>
>>> - I am also thinking about adding a sysctl (present and enabled by
>>>   default if CONFIG_KASAN_EBPF=3D1), to allow temporarily disabling KAS=
AN
>>>   for ebpf programs. When set to 0, JIT compiler would stop inserting
>>>   checking instructions in new programs being loaded.
>>
>> I'm not sure that sysctl is necessary. If the kernel is compiled
>> with kasan and JIT supports it, it should go and instrument all progs.
>> We can add sysctl later if necessary.
>
> ACK.
>
> Thanks,
>
> Alexis

