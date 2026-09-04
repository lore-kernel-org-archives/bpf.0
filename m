Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA53F39FF
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512559; cv=none; b=ow/UjTQbtb7ldddbkItGDoHPGJ6xSNrpQ7HP3cWSO2DcJRCwxw10f9aUXmkA0oxREYyDzfQCIM8PnDr0ocs3G0pIS3uyMMcvQWP7vKOh1dgAkHvWF4mfDT7j+nuKhoYwpzLxfpZeDJ6EJLlZ4M1FbgwXdK7Be/QD/KhLb4S5eJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512559; c=relaxed/simple;
	bh=FocYj1Tg6JeoZyTDyfHblEWp+ZMU7BmLVvhrp05G4mE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gZrdpLXX/5vJ/vNmuk8ken2DdJQLDhEiyCoU+cq2oYx9mcQ7qclvV+V01vY0Qk/QgQrndtRMyYFmfqMb6PJblvGfWfHmQZ8AqPStysUSB+gD4Mv1dPPAVXRUQQfiWL0kez0stvNOvZ0ZXuNjPmq/2UR3EGQ8bafAqJ1wWtC1qsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahLmHHkU; arc=none smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahLmHHkU"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c166aef4f02so37012566b.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788512556; x=1789117356; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VSBcA76yWuklBIVlW8nFJkprKtYg80K7J6L7TsEg75w=;
        b=ahLmHHkUUY5GyLFEnMgSOAo6lncxD0syIQsq9xaGV+PMU31VF/R0AWp1T1/XGVjJ7m
         HyWJ6ezyl+fjWFsxwts/r4gMnEFYYrohLFL5iEBQs0Ti1XSxFN+F8sASHgWbPzuuUwBw
         liwG7psGLFP2IfFG7ov6CWJztbtotCJ7nUQDDS7u54xWuXRJjljy+C3dSPaOZDET/eyh
         HxP26qOtsXoJVsZ3a7Q6u2BZqigbdT7cq82dDmGsB2NfrnjNUpYaKE1jtCldZD4m9KSc
         y6PHgMqjCn5Qi0tG5orQ4q1fLkSmUKySZBUVCNIz1CfwAeb5G+VvDVjMSghbqXxAgCVZ
         a8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512556; x=1789117356;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSBcA76yWuklBIVlW8nFJkprKtYg80K7J6L7TsEg75w=;
        b=c212g5GmyVuaUWbPMo1L0z1Y7GXR28/EsDNn06GDL3CQablvicd53c2vtz22SqT3uX
         dL5KGGEMF4HYnVO8U/3GYfOZlAT/YiNxaXJ5C4BiaCcG5783UPXFLcTRTz5jKjdRA9Jx
         nUoG7NvSKvxHMsOKFlEm0xxEEt4OAs/IvfDpOI0MDj8GAngpPPNRIIC8tIGdLgJ4d22O
         65p46Rmo2vmMMX8hVOar31mpPHmBZA7aZCPS90v3X3651gOuzslr9wOEUMlBW6tdjpzz
         B1CFkhj2h2yOFLk41xNnbA26yJenI9f7bB7H3p3r4xHa/em8KZnvIzsXL2mqS/VUNuaY
         UiFw==
X-Forwarded-Encrypted: i=1; AKwUvBzN9ycSeMhMUsGr9D1NipgXuujryHM4uiQYV+rfTX9fyxvhr2stQdbeYxEgNoOWNaUIb/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lsmncpKazpcs7amWWL7G4yCw/Ak/0gu5OjVjmLVLcpCBiPqjhg
	ZKjOhP6w8JmvSPbTVcBuvtPg/sA86ahOYbtPcIqxETUmn9+SEFHd6gA8
X-Gm-Gg: AYBFou1uGQZKqx0wt72mIOamZ9Wu135ksbU9ZMSba8HedRpZscgQJKAqUldi71/zTek
	Jt5jGoAZHrWW9Kf25dmeOHTCqX0qYIbLq0y5L7FWHwoKOUFQk3vwMnQXOnE5JNHkBBFE+Dw+i1Y
	75WWlQefka20AZCaZ2Bm4Dy+j/bGWXm4S2GEmx8EI0qolpOldtsyaWZMyE58qT/AFPh5GN1wKKH
	JEcBFJsFiFCgeI4q7DL5lL1wr/rONDPAs9ocj3rhgEOEH4hR3oYgk5VTIURIvxaALDx9BgyWIIC
	V9Zw0kvKyvLOQBYW2vwCFmWDz2G/CAgziduF2tx1J46ywptznoq8BIwdG3I5nfj9sI6dC/2zxaY
	8fMf4pSz8rf7MiY7ksRfZueUIp7dZgq1g3lexMgszGENzdoIOMFMdO2wm6+zeCr53exFFKXvzOv
	GkNdUi3FHAw8K4JiAat97o+Gw+b6STJiJHjl45do16nLQfrXTtZ3I4gxfaeRZp8Qzr4yn4KeEWG
	QgIIwO3L+Do6FppAe9kx5GZq2GCRxDYfywhlIabMTQUjK6re/WNDvoXTWuCul0OfGR8yGaBfCXh
	CxSgZzbGfRlyYM10zxfQHaniYRI=
X-Received: by 2002:a17:907:c81a:b0:c25:659:89ba with SMTP id a640c23a62f3a-c260c8d4e21mr198032866b.9.1788512555920;
        Fri, 04 Sep 2026 02:02:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d503f96sm77028066b.26.2026.09.04.02.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 11:02:34 +0200
Message-Id: <DL6ESCNVJ52D.3NSNU8FZDQTU@gmail.com>
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v9 0/8] bpf: add support for KASAN checks in
 JITed programs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Andrey Konovalov" <andreyknvl@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Yafang Shao" <laoar.shao@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
In-Reply-To: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>

On Thu Sep 3, 2026 at 3:51 PM CEST, Alexis Lothor=C3=A9 (eBPF Foundation) w=
rote:
> Hello,
> this is v9 of the series aiming to bring basic support for KASAN checks
> to BPF JITed programs. Among a few minor optimizations, this revision
> fixes some wrong kasan instrumentation on some unwanted stack access
> (stack access ending up being instrumented AND targeting the wrong stack
> offset). To mitigate this risk further, this revision introduces a
> systematic KASAN check skip when (addr_reg =3D=3D BPF_REG_FP || addr_reg =
=3D=3D
> BPF_REG_PARAMS) in emit_kasan_check. This secondary check (on top of the
> non_stack_access flag), should hopefully prevent the issues raised in
> v8. I've also reworked the emit_st refactoring to realign it with
> BPF_STX management in the x86 JIT compiler, as the "arguments on stack"
> feature made me realize that it could be kept more symmetric with
> BPF_STX; so I've dropped Ihor's Acked-by on this.
>
> Original cover letter:
>
> "Traditional" KASAN allows to spot memory management mistakes by
> reserving a fraction of memory as "shadow memory" that will map to the
> rest of the memory and allow its monitoring. Each memory-accessing
> instruction is then instrumented at build time to call some ASAN check
> function, that will analyze the corresponding bits in shadow memory, and
> if it detects the access as invalid, trigger a detailed report. The goal
> of this series is to replicate this mechanism for BPF programs when they
> are being JITed into native instructions: that's then the JIT compiler
> that is in charge of inserting calls to the corresponding kasan checks,
> when a program is being loaded into the kernel. This task involves:
> - identifying at program load time the instructions performing memory
>   accesses
> - identifying those accesses properties (size ? read or write ?) to
>   define the relevant kasan check function to call
> - just before the identified instructions:
>   - perform the basic context saving (ie: saving registers)
>   - inserting a call to the relevant kasan check function
>   - restore context
> - whenever the instrumented program executes, if it performs an invalid
>   access, it triggers a kasan report identical to those instrumented on
>   kernel side at build time.
>
> The series comes with new selftests programs that generate a wide
> variety of kasan reports: those need the kernel to be running with
> kasan_multi_shot enabled.
>
> As discussed in [1], this series is based on some choices and
> assumptions:
> - it focuses on x86_64 for now, and so only on KASAN_GENERIC
> - not all memory accessing BPF instructions are being instrumented:
>   - it discards instructions accessing BPF program stack (already
>     monitored by page guards)
>   - it discards possibly faulting instructions, like BPF_PROBE_MEM or
>     BPF_PROBE_ATOMIC insns
>

For the series:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

If there are remaining issues, we can fix forward, but I think we should tr=
y and
land this for now.

> [...]
