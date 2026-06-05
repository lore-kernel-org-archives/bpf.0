Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC789309EE7;
	Fri,  5 Jun 2026 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674635; cv=none; b=gsi1kT5ICkdE9FqJTCsaidBiPX5JKqQ1LUKLwyTW/EEnOsRnur/nR4IBY4+vYtMRd7S6eTdepUdD8kFLK8mykQtOrqTuBHsAK5FFPc8i5p99WcbUG9jD9YbJoPzAF/vkoyaLhL2coyXaZKkOdMDCfEzBk01ybdg5CTvjln4BiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674635; c=relaxed/simple;
	bh=nbjYk6B7APotbe5x7phztqX7yFh8Fo16iMH/wnsG64k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=ZUM5x0AulXrpRb4ynyyiVlT2ajzUTVN2g48g6ZSyVCR+SC5otWUgszAwZs8ULjNC58KCc+5mXzuhbx9nJu0ps+mSvP3ewr8S+wyhkdz5VjF5FFr4WpjvVltctDmTvInOc1V7qpN+bXwYqRPnIljPOyka3lSaie+pZVy/1CywOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=El9/+tTc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="El9/+tTc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D8384C58476;
	Fri,  5 Jun 2026 15:50:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 132FF5FED1;
	Fri,  5 Jun 2026 15:50:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32D1B106A250B;
	Fri,  5 Jun 2026 17:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780674630; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SK9KuxS1ziFhMMC1VuJ1L9c3rL5t3987G0g0RIOVuXY=;
	b=El9/+tTcBzEyeAzQTFeFhzTs0NAXSig/ZmmOW1SkHrjIZN/GGwlVIMVAMjCgFkoboVMyT5
	GjqQxVRcv5LIvnYTgCxLDTFrCHFkkG9ZpREs9AebRMiO649TyfFEUKADbh5Xe/oUUqZ/ZX
	BBTHkMNYQzk5Yih1Piqd+yX310sr7lzevEA+8dCEFlH4D0j0NZqN8+zLzGEDToLFop1RjW
	dJgjW+AxMlIIi7Ao/uumGpK5HXwY6DuBuPOeSE+IvU4b2LCLeOVbgcDRJYvL98/D7m2469
	PNHd/uU5/VwmiNsRGylx6YZaYjEQwEVQYHCQyPImefg1ag9BSF3eIjhLakZsIA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 17:50:24 +0200
Message-Id: <DJ18H1FKONSJ.QNJHYMX6AW6B@bootlin.com>
To: "Yonghong Song" <yonghong.song@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Shuah Khan"
 <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 5/8] bpf, x86: emit KASAN checks into x86
 JITed programs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
 <20260604-kasan-v2-5-c066e627fda8@bootlin.com>
 <78009c06-4233-4e0a-88ec-33eba10ad8b3@linux.dev>
In-Reply-To: <78009c06-4233-4e0a-88ec-33eba10ad8b3@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hi Yonghong,

On Fri Jun 5, 2026 at 4:54 PM CEST, Yonghong Song wrote:
>

[...]

>>   			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX ||
>>   			    BPF_MODE(insn->code) =3D=3D BPF_MEMSX)
>> @@ -2592,13 +2622,13 @@ static int do_jit(struct bpf_verifier_env *env, =
struct bpf_prog *bpf_prog, int *
>>   			fallthrough;
>>   		case BPF_STX | BPF_ATOMIC | BPF_W:
>>   		case BPF_STX | BPF_ATOMIC | BPF_DW:
>> +			bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
>> +			u32 real_src_reg =3D src_reg;
>> +			u32 real_dst_reg =3D dst_reg;
>
> With llvm23, I got the following build failure:
>
>      /home/yhs/work/bpf-next/arch/x86/net/bpf_jit_comp.c:2625:4: error:
>              label followed by a declaration is a C23 extension [-Werror,=
-Wc23-extensions]
>       2625 |                         bool is64 =3D BPF_SIZE(insn->code) =
=3D=3D BPF_DW;
>            |                         ^
>      1 error generated.
>
> The below is a fix:

Thanks for the test, the report and the fix. So this warning looks
specific to llvm23, as CI does not trigger it with LLVM21. I'll bring
the fix in in the next revision.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

