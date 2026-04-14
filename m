Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C23E6DD4
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173067; cv=none; b=PAR5CCtVM7DtZAXWzKz1AOcqsapcwLSc8C+TY8EGfFsBlBvZwJv4efk40D/ndYHj7XDj+RWVMbjLrIeyEsh3rKX0ODIKD/Twxm6Efz8RgpR8xgFQFj14a8QmUlq+yJ5fr2wGL9ULVDHJTBT50rpjVq4/P80dhTeXyVrgBMxk3Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173067; c=relaxed/simple;
	bh=hrlp+8/wSmW3Jx7uBVXodU++OJHYVgQMsMTogDvagaY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=sDCLTCpVBIiK8t2fedKkaSSic1DAUcdZJuldY87otpMfbD12Zy5CHvJSMwRYrMXpt0JxhQosASbhN+LBJSBGjqvbCdRHVYXoIY0WiKds5YNmuJw4EWAqQfFAlzIJ2YrJHiE3TnI0lfT5aj7IifE4pw+tJm/ag0axhWL6N9qP3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X6A4tqU3; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X6A4tqU3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3638AC5AAAC;
	Tue, 14 Apr 2026 13:25:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15A6960410;
	Tue, 14 Apr 2026 13:24:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91474104500A2;
	Tue, 14 Apr 2026 15:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776173062; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cMPO/P6ZptnY7PwA9Kq6DHiKsIFPvqoz4r+zqZlAlBc=;
	b=X6A4tqU3MkoqM6hdV2BYcurk14+6JZDEN/gbqla0kWX1zkUOVhzepr1g+eqrPNbNUv/huV
	YvRVcaXQMDSoKNvHHEev5avgGrcMFEKbpEaqiYiDYgm7Bt3jlvoqJQ5ERrTOmbM6hkpZ4c
	lSZlrap8zNk/UzuRZwSWbVolH6CoRl3/X0CCVwBfc1YF32vGuKDzOTtnFMST1koqfhy2JQ
	FHgxzpJuT7y8RT0NzKx5KsKEo6MlgAJgguOw61CCS91aw38/mmn96yQctauQKN1Mw/26EC
	Mku30aEpcpuqoVCUdGMmoRzHpFjahdvvfYrXfOquex2Iaj6Ff2PksIHe5lfBCw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 15:24:14 +0200
Message-Id: <DHSWSSYRPUVC.2W3G3OU27L3HG@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
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
 <20260413-kasan-v1-3-1a5831230821@bootlin.com>
 <CA+fCnZf-o8tiv_tX9YB5eBUGx17OpztKZsEB6Awjw3WAqBAiUw@mail.gmail.com>
In-Reply-To: <CA+fCnZf-o8tiv_tX9YB5eBUGx17OpztKZsEB6Awjw3WAqBAiUw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Apr 14, 2026 at 12:20 AM CEST, Andrey Konovalov wrote:
> On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundat=
ion)
> <alexis.lothore@bootlin.com> wrote:
>>
>> Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enables
>> KASAN (Kernel Address Sanitizer) memory access checks for JIT-compiled
>> BPF programs, when both KASAN and JIT compiler are enabled. When
>> enabled, the JIT compiler will emit shadow memory checks before memory
>> loads and stores to detect use-after-free, out-of-bounds, and other
>> memory safety bugs at runtime. The option is gated behind
>> HAVE_EBPF_JIT_KASAN, as it needs proper arch-specific implementation.
>>
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>> ---
>>  kernel/bpf/Kconfig | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
>> index eb3de35734f0..28392adb3d7e 100644
>> --- a/kernel/bpf/Kconfig
>> +++ b/kernel/bpf/Kconfig
>> @@ -17,6 +17,10 @@ config HAVE_CBPF_JIT
>>  config HAVE_EBPF_JIT
>>         bool
>>
>> +# KASAN support for JIT compiler
>> +config HAVE_EBPF_JIT_KASAN
>> +       bool
>> +
>>  # Used by archs to tell that they want the BPF JIT compiler enabled by
>>  # default for kernels that were compiled with BPF JIT support.
>>  config ARCH_WANT_DEFAULT_BPF_JIT
>> @@ -101,4 +105,9 @@ config BPF_LSM
>>
>>           If you are unsure how to answer this question, answer N.
>>
>> +config BPF_JIT_KASAN
>> +       bool
>> +       depends on HAVE_EBPF_JIT_KASAN
>> +       default y if BPF_JIT && KASAN_GENERIC
>
> Should this be "depends on KASAN && KASAN_GENERIC"?

Meaning, making it an explicit user-selectable option ?

If so, the current design choice is voluntary and based on the feedback
received on the original RFC, where I have been suggested to
automatically enable the KASAN instrumentation in BPF programs if KASAN
support is enabled in the kernel ([1]). But if a user-selectable toggle
is eventually a better solution, I'm fine with changing it.

[1] https://lore.kernel.org/bpf/CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2=
xGkE-ZNw@mail.gmail.com/

>
>
>> +
>>  endmenu # "BPF subsystem"
>>
>> --
>> 2.53.0
>>




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

