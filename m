Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295A385534
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279552; cv=none; b=G7Pww2qs+NcuCU+XSWrh5gVSOO1avszPHIjIJcXzCOLltt8OgUvkHYPr75G2I0xmyNd+eZPBYtecc0mH12ZmSMrxvBf4c1onqwCveGsDatcnVdL2iQEAawjh4lCGu+V0KKNxbraH9M/fizyej8lfLG3VlKd3eH8uaOieMZh+bbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279552; c=relaxed/simple;
	bh=NPtBWtScyAtExi26HJQOX3Bl9JaCMW7W8B+qRRIyHcU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=WPczh2hE4ve3CaLOHlYQquJmTygZOHGyOEl20cRu2ALycRO93tyO7JMFh2iVqidBtl4Zi2oDkr3fB+SAu+q6XTKnxPTWe8NbxJP6KH1LHJUuyiyfKzWTKZjunAaot/RddqEv0Z/PP44xExKLEUmOe0Tr2b6qNetmkv8ye8mn8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WJbcAplo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WJbcAplo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9D718C5CD44;
	Mon, 27 Apr 2026 08:46:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6D3D9600D1;
	Mon, 27 Apr 2026 08:45:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E94B10722389;
	Mon, 27 Apr 2026 10:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777279546; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=enlPWmXbCXiBTtPjtrqyyDQhH4YVYS+iBt6pkMFkQHE=;
	b=WJbcAploUg0VmF8Pr+sfgdotkcsE+3i3sOgj0VN9GILZjM/dn7k2l6yEnDFaLgNnsHB2ke
	rIiFoGiqvbcbZUtxKswbsaRljyz+xXTtAxqH/KKDTh71KwOwbOw8l/vQCMnSwhlcMo4xCC
	xoIgVMfDds0upX6YXNRrk8BNT5gtD69tE0EPWoJGdDPyPEFVH4WSMc76pnmesP3PyyGxoi
	WSBqZVZb+deNlGfh7SjsbGBSVzPwbj+XpuWgjdaPkUDHoOr+AiZQXiqXcxWBxKDn39Kuzf
	8xtuEKI55YCnUaxvGQOliOLdPRRmK0uaNRPXrzMWGxybldX6FdIJZBopPxlCjQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 10:45:34 +0200
Message-Id: <DI3T0IKVGW9X.KVYWOQJN3PCI@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 0/8] bpf: add support for KASAN checks in
 JITed programs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Xu Kuohai" <xukuohai@huawei.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <kasan-dev@googlegroups.com>,
 <linux-mm@kvack.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, "David
 Ahern" <dsahern@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>, "Andrey Konovalov"
 <andreyknvl@gmail.com>, "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <71fb19ff-6dde-43f4-a0e9-5c8cf2ba4ed4@linux.dev>
In-Reply-To: <71fb19ff-6dde-43f4-a0e9-5c8cf2ba4ed4@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ihor,
thanks a lot for the review and help !

On Sat Apr 25, 2026 at 1:10 AM CEST, Ihor Solodrai wrote:
> On 4/13/26 11:28 AM, Alexis Lothor=C3=83=C2=A9 (eBPF Foundation) wrote:
>> Hello,
>> this series aims to bring basic support for KASAN checks to BPF JITed
>> programs. This follows the first RFC posted in [1].

[...]

>> The series is marked and sent as RFC:
>> - to allow collecting feedback early and make sure that it goes into the
>>   right direction
>> - because it depends on Xu's work to pass data between the verifier and
>>   JIT compilers. This work is not merged yet, see [2]. I have been
>>   tracking the various revisions he sent on the ML and based my local
>>   branch on his work
>> - because tests brought by this series currently can't run on BPF CI:
>>   they expect kasan multishot to be enabled, otherwise the first test
>>   will make all other kasan-related tests fail.
>
> AFAICT this can be trivially fixed on BPF CI side, we just need to set
> kasan_multi_shot for the VMs running the tests. I will do that, your
> next revision doesn't have to be and RFC.

Sweet, much appreciated :)

I've started receiving some Sashiko reviews on the series (likely thanks
to some of your actions), I'll take a look into those and prepare a
(non-RFC) v2.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

