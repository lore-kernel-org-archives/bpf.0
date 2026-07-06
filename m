Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F542E8F0;
	Mon,  6 Jul 2026 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347394; cv=none; b=GFAFwDeJFN0PYmxZMrwJ7GswrqCkSJ44Qey7n1yECu8yNUAzPkVCxj8EzIBtvBnKjgGIr6gPxqnWGCysRejuRx99jZnD3BpFlAau10sji1rl5UQfpfjQaW/Qz0uC/Sr6FUUlOi2XyLzdlv3tAC3p0T7aS5JgbK1/J5EHVieY63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347394; c=relaxed/simple;
	bh=Z462dJVLhUuc7O3el4wqGSe9NqpHGqLyckYou6DakcM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=GbA31pL6V0gr5ytrNIT2s8qrKTGYp+eCFpZ8/pWkjqX8ntHHpkgdbS6sRn9bOpD/Y06YO3o0iI2KuLqSaZq+N9IWzBErs69V/iT6Sa49K8pgGfFBLc50ywtmp/htn71Ke77tLDQptmwjcDq3yhGjk+dFAM3kh3xBZqQP5Ts3Jro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tAqfGVWm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tAqfGVWm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 09F7A1A0E96;
	Mon,  6 Jul 2026 14:16:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCBD1601A2;
	Mon,  6 Jul 2026 14:16:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75E6D11BBA535;
	Mon,  6 Jul 2026 16:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783347390; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FscgQS9V09PYtyLYPG4VcMCZ6avrrSFZcTEyFdiSxYU=;
	b=tAqfGVWmAZg/iwU6s4lGdM16t/Xf//Nx5f/zM7B71tyxxHcNX06EUZ6Qcaq/Ngp2w9foIX
	2WHeo+6KO1vjhgS9xbgywpk6UNKQfBSlREP3haVmhwmt7/X11kAn0PIABByEPnMeSs79Aa
	5/GrXgnYw7qgHnhuYMDP4Uasdqa8lT2BR0fqiX9obfEk7XCvZwbJe8G9sudTuvWbBjT6fG
	qtjzxk8u56JjuPN2OVv7NK0Yi1nqY2jEiqo6hFUXlH9p4r1m3mTMl2c06APK0ftt3/Nphe
	f5g9oDkj32en8mko7MFZ97PXHxh4EbYDk3jphBdOSeB4aeyjE0rnRvm2nBrUgA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 16:16:23 +0200
Message-Id: <DJRJVY5TTS73.2NQ1NZ8XI5WWL@bootlin.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Andrey Konovalov" <andreyknvl@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v3 03/10] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
 <20260701-kasan-v3-3-bd09bb942d86@bootlin.com>
 <CA+fCnZcJzRvq9942LXgTpq5067u4DvXQRjdNDpq-5vOZpQuCVQ@mail.gmail.com>
In-Reply-To: <CA+fCnZcJzRvq9942LXgTpq5067u4DvXQRjdNDpq-5vOZpQuCVQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrey,

On Wed Jul 1, 2026 at 3:43 PM CEST, Andrey Konovalov wrote:
> On Wed, Jul 1, 2026 at 12:03=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundat=
ion)
> <alexis.lothore@bootlin.com> wrote:

[...]

>> +config BPF_JIT_KASAN
>> +       bool
>> +       depends on HAVE_EBPF_JIT_KASAN
>> +       default y if BPF_JIT && KASAN_GENERIC && KASAN_VMALLOC && VMAP_S=
TACK
>
> I think it make sense to put KASAN_GENERIC into the "depends on"
> section, as __asan_load/storeX() are only defined for the Generic
> mode. SW_TAGS mode is expected to be soon implemented for x86-64, and
> that mode uses different checking function names.

I guess I can move most of the kconfig options that currently are in the
`default y if ...` into dedicated `depends on ...` lines, and just keep
a `default y if KASAN`, something like:

  config BPF_JIT_KASAN
          bool
          depends on HAVE_EBPF_JIT_KASAN
          depends on KASAN_GENERIC
          depends on KASAN_VMALLOC
          depends on VMAP_STACK
          depends on BPF_JIT
          default y if KASAN

> Would also be great to add description for this config option.

I can fill a help field with a basic description, but it will be visible
only by reading the Kconfig file, it will not appear in menuconfig
unless we make the knob user-selectable, which I would like to avoid.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

