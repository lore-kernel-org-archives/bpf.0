Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844953939B6
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768409; cv=none; b=nkbFIqo8iQiVDGf9PKweAtEeEz4XYSPhof494Asq8/0AVVopyIE+TxoibSGnaeK7VXW63IvHGwFV6kt/P5MtpTKz8ZKW2pui443wKHExmSWxF+gFZrD3MLy+XJmskE9/gAZVxrVPW4YL6Y4mOfIwMpmJHHV3JPwNz9pFiMNArBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768409; c=relaxed/simple;
	bh=8lJPATkIO8yVeLALXpxM3SByvo/SRVvOBPy4Ne5Dr78=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=uQ35ucdzFiq30SzcQAooXbxoz8l15MSRY+/b1+T8eNrYUD35m/jEidSzUEcF7oRvb0scXwwgeX2X90iZ4uUDs0CJZSDt0tNWERWWZ3Xa5fi83JVCQ7YWCb/9h2Ggjq7r4/9er9HPBORybPd3m1fDkXIFNhhqitKYieWT1g0uJyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XmiFLXbm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XmiFLXbm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AF6C31A184D;
	Wed, 26 Aug 2026 18:19:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FF95604EC;
	Wed, 26 Aug 2026 18:19:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DDBE11C78378;
	Wed, 26 Aug 2026 20:19:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787768376; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WBiBUcsLXcX/eaDueopmySnIviXz/GZ2Ds1LeB9dC5Q=;
	b=XmiFLXbmLWKb5j0FTvXHQoCADV70832aLxC6lyBoi1jymDUgidISNVp256i+jl42ifbx+1
	pmDhFKeVXaDTl7WiNR7Wv7xKqDv3tMMLMDl8k6v8XoRCJHKdaQZmayjMZ+DulZwvqQZOP4
	Px2iIkJWeCnrgssrkgzCBRPxDI601fec8oh6/UwxK2f5ll4eOylbcN3n4eeqpUbS+14QYO
	f8DRSf5qFzuq8Q3JI2PTo1KlZPXHsMXQ9Ba/NWt+sFaLBTCVUBpzDdPYlnavXKhrjBqTbO
	Nrf1P20h+w4C2ouThybw8dCPoNh3nGzrjG8xqgScY6q0hTKtSp4hRryisjZAEw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 20:19:29 +0200
Message-Id: <DKZ2ZV0RB5XV.2TU1APPGT5OSN@bootlin.com>
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
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
Subject: Re: [PATCH bpf-next v7 9/9] selftests/bpf: add tests to validate
 KASAN on JIT programs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
 <20260822-kasan-v7-9-99afee6ef7fd@bootlin.com>
 <DKWONS3UI84A.382GORI5CXC51@gmail.com>
 <DKWOXOPN11A1.1BNV5J6RJ7MGJ@gmail.com>
In-Reply-To: <DKWOXOPN11A1.1BNV5J6RJ7MGJ@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Kumar,

On Mon Aug 24, 2026 at 12:53 AM CEST, Kumar Kartikeya Dwivedi wrote:
> On Mon Aug 24, 2026 at 12:40 AM CEST, Kumar Kartikeya Dwivedi wrote:
>> On Sat Aug 22, 2026 at 12:39 AM CEST, Alexis Lothor=C3=A9 (eBPF Foundati=
on) wrote:

[...]

>>>   #171     kasan:OK (SKIP: 16/54)
>>>   Summary: 1/38 PASSED, 16 SKIPPED, 0 FAILED
>>>
>>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bo=
otlin.com>
>>> ---
>>
>> 1. Should this test be made serial to make sure bpf_jit_harden sysctl ch=
ange
>> doesn't affect other tests?

Indeed, that makes sense, I'll flag it as serial.

>> 2. Clang currently collapses the intended ST/STX distinction for *_on_st=
ack
>> tests: default/v3 emits STX for both pairs, cpuv4 emits ST for both, and=
 the
>> default st_blinded object is already STX and therefore is not blinded. P=
lease
>> check and assert that xlated insns are correct in the test itself if pos=
sible.
>> It might be necessary to use asm volatile assembly blocks in case you ca=
nnot
>> work around the compiler in C.

Ah, good catch, thanks. For the blinding test, I really checked that the
blinding is inserted, and re-running this again, it looks like I have
been fooled; there's indeed some blinding inserted, but not on ST/STX

> For 2, I guess as a whole you still get coverage, since we run with both =
cpu
> versions in CI. So it should be fine I guess, for the blinded case too, b=
ut
> perhaps it would still make sense and be clearer to verify and only enabl=
e st
> case for v4, and force stx to remain stx on v4.

Ok, I'll update the test so that ST/STX/st blinding are correcly skipped
depending on the CPU version.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

