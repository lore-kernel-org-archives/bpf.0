Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07DA189B84
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174237; cv=none; b=pm1Us2L0TYO3a+wv5jz0MfABNBWWCFzX1jWeHiTIJl00iHPJKk1mDWfNMbtO3YXe6UX/htgc/cVW+LTpOzSRgGH54PtT3kPuDVpRu1PFu5TXUSQwyPy52BSVi1oSHGaxvvhEBrMiBcf380dVnSJPlWMcHFtM98kHgZFaEvW7GeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174237; c=relaxed/simple;
	bh=7Qsjc8sieTy2NunPo1IUnobN9kKlNcjdypUZQ9CE4Zc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=g/GdwK/+9o4RfTLE6v/OasI8T6bqinevbmT59eIF5AYkRSEur9ON6lEi42Axw3z09s5c6D10psYUEOUnpknwrWaXAEHNo9U6rYOKYphsPClUyLs2ET8UV9VrW6zDgGSEeQhgkFkkR/fwG1YGoglia2FV0uxnvihcX9agGxOx8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S6AAfSv+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S6AAfSv+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 210641A32A8;
	Tue, 14 Apr 2026 13:43:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E416660410;
	Tue, 14 Apr 2026 13:43:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 450DD10450118;
	Tue, 14 Apr 2026 15:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776174232; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fBYaHCpG8hC1NEAoLKhT2eDDnp5ePCFis5i2nukgCY4=;
	b=S6AAfSv+oUeOvIrxD+z5bbdfpbvEOB21uXEtXvB4AqMh4FY8aCuyB3wHwx9r7WuVdHJYL+
	rD0/08M7IBbmkTkrkT4y4rKcwWyqFckHbY0d9PtwNrkx7DaSk7KT0vztBafKaTOmUOws5w
	qAGaNH/SCsFaeSpXq+U1fXnRnSb6RTAFiP4wAme1fA2E/ecJefwxeRaUPgj3ZmXhRt7wxY
	aas0aDmqQnMSQ8xEcyHooL1//5S5S9RSul/ZsJlUWSIBozq2b3PI6l6xl3ldUHUduj47SE
	koioV9P/g0ItanZHdEow/RtOOTONKeljDR3QB5PLNB90x26lfEpu4eQqk7yUEg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 15:43:42 +0200
Message-Id: <DHSX7PABLUSN.1VYMRZ02DFZEL@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "David Ahern" <dsahern@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Shuah Khan"
 <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Andrey Ryabinin"
 <ryabinin.a.a@gmail.com>, "Alexander Potapenko" <glider@google.com>,
 "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo Frascino"
 <vincenzo.frascino@arm.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Xu Kuohai" <xukuohai@huawei.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <kasan-dev@googlegroups.com>,
 <linux-mm@kvack.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Andrey Konovalov" <andreyknvl@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-8-1a5831230821@bootlin.com>
 <CA+fCnZekgcEgsZnRrOB=+HoG=neRg=oLTt2jStyrPJ6mYf2ctQ@mail.gmail.com>
In-Reply-To: <CA+fCnZekgcEgsZnRrOB=+HoG=neRg=oLTt2jStyrPJ6mYf2ctQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Apr 14, 2026 at 12:20 AM CEST, Andrey Konovalov wrote:
> On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundat=
ion)
> <alexis.lothore@bootlin.com> wrote:
>>
>> Add a basic KASAN test runner that loads and test-run programs that can
>> trigger memory management bugs. The test captures kernel logs and ensure
>> that the expected KASAN splat is emitted by searching for the
>> corresponding first lines in the report.
>>
>> This version implements two faulty programs triggering either a
>> user-after-free, or an out-of-bounds memory usage. The bugs are
>> triggered thanks to some dedicated kfuncs in bpf_testmod.c, but two
>> different techniques are used, as some cases can be quite hard to
>> trigger in a pure "black box" approach:
>> - for reads, we can make the used kfuncs return some faulty pointers
>>   that ebpf programs will manipulate, they will generate legitimate
>>   kasan reports as a consequence
>> - applying the same trick for faulty writes is harder, as ebpf programs
>>   can't write kernel data freely. So ebpf programs can call another
>>   specific testing kfunc that will alter the shadow memory matching the
>>   passed memory (eg: a map). When the program will try to write to the
>>   corresponding memory, it will trigger a report as well.
>>
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>> ---
>> The way of bringing kasan_poison into bpf_testmod is definitely not
>> ideal.  But I would like to validate the testing approach (triggering
>> real faulty accesses, which is hard on some cases, VS manually poisoning
>> BPF-manipulated memory) before eventually making clean bridges between
>> KASAN APIs and bpf_testmod.c, if the latter approach is the valid one.
>
> Would it make sense to put these tests into KASAN KUnit tests in
> mm/kasan/kasan_test_c.c? I assume there is a kernel API to JIT BPF
> programs from the kernel itself?

Possibly indeed, but I think one important use case will be the
possibility to run those tests in BPF CI ([1]), and this depends on
those tests being integrated in the test_progs framework
(tools/testing/selftests/bpf)

[1] https://github.com/kernel-patches/bpf/pulls

> There, you can just call kasan_poison(), some tests already do this.
> And you can also extend the KASAN KUnit test framework to find out
> whether the bad access is a read or write, if you want to check this.

Alexis
--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

