Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B6313545
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183519; cv=none; b=AcYmuSb1I6gviIJJYPhM9hEEuWdMF2GFWhh9fH+YWcemj4V0N5cVXeciPT6h7uQAUcHNTZ5sGHNnMmdltAOZGaUjO0ZOLZ1MfJkB9eQSD86c2HktxtAS7jFeMOQuBcC+XK/Mdem+hJ48mwLXv848zOCRIEAbW9UdshtbP1XFhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183519; c=relaxed/simple;
	bh=RtOsdWf1cb2JncZI/usyV1HuZcUJQ4q3HYmnTGQ0P/0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=l5BZ6NrF47Q0d9yLg0niR5oJg8hU0fW0Yc2Fkv2fJOo61ZhKqsyTOgPQ0fidJ6qIVeTylrnFnjWFle+p+39Fq5dUSD/IyRgDaF2igkgJF9dD3GcRq/KOOWj61IsAbeIsLKJvS3y0f9py1v1wDg56pWRI0ayWbfnCFWlMhyCEfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zkA/zLKo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zkA/zLKo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 07B134E40DFD;
	Thu, 16 Jul 2026 06:31:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B06B9602B8;
	Thu, 16 Jul 2026 06:31:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FBDD11BD3CAA;
	Thu, 16 Jul 2026 08:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784183513; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FS5FzyWy0VfO62NFm0sIZD2nYvKIYSFnvkX5egZONHQ=;
	b=zkA/zLKopz0XxJCLV0krxz4dDOWJsu64e5gke2RviB5rXWgXIozXwRxb35FzibCh/MjooZ
	AwXK/gjTZ0auUkr49rhnSWwZkOBZ9nL+kQatDDwg0jPKwbW//wlkjtn+oEK22ZueRH0qtZ
	exytOOxOCJNncuFnhCxRG4dLU3/Gy0xCy5oQkmNkB1wFzB8D9Dos6neoYdLdkN4IpNuTOX
	FF6w4kNecvPxBuTfK024gdPFTn7BuamNtJfwsc9yY8qF8/o8OuhDbkr/7ujkwd7eR3HY4C
	a9mcVaiA09htSeube8Y5QSRsq95iIVQw56DVW8oUCe0+u7cz6e7qp/MpRd6Xpg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 08:31:44 +0200
Message-Id: <DJZS9MSX56HR.1X3HX6LHHDIB9@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Andrey Konovalov" <andreyknvl@gmail.com>
Subject: Re: [PATCH bpf-next v5 06/10] bpf, x86: emit KASAN checks into x86
 JITed programs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-6-1c64af8e4e1e@bootlin.com>
 <293c6a91-d7d7-4870-8f41-b20f6737d7af@linux.dev>
In-Reply-To: <293c6a91-d7d7-4870-8f41-b20f6737d7af@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 16, 2026 at 12:28 AM CEST, Ihor Solodrai wrote:
> On 7/9/26 3:01 AM, Alexis Lothor=C3=83=C2=A9 (eBPF Foundation) wrote:

[...]

>> @@ -1984,6 +2000,10 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>>  			EMIT_ENDBR();
>> =20
>>  		ip =3D image + addrs[i - 1] + (prog - temp);
>> +		insn_idx =3D i - 1 + bpf_prog->aux->subprog_start;
>> +		accesses_stack_only =3D
>> +			env ? !env->insn_aux_data[insn_idx].non_stack_access :
>> +			      false;
>
> I don't like how accesses_stack_only is a boolean argument to
> emit_kasan_check(), that is only used for early return.
> I can see not wanting to do
>
>     if (!accesses_stack_only)
>         err =3D emit_kasan_check(...);
>
> on every call site, but a bool arg is even worse IMO.

Yes, that was indeed the intent, but ok, I can get back to set the
stack access check out of the function.

[...]

>> @@ -2626,7 +2662,17 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>>  				if (dst_reg =3D=3D BPF_REG_0)
>>  					real_dst_reg =3D BPF_REG_AX;
>> =20
>> +				ip +=3D 3;
>
> nit
>
> IIUC the 3 comes from emit_mov_reg() above it (:2659), right?  I was
> thinking to suggest a comment, but well I figured it out from the
> code, so others should too...

Yes, that's indeed where it comes from (and this cost me quite some
debugging time to spot that I was missing this offset !)
>
> Maybe instead of hardcoding 3 we could calculcate the diff
> before/after the mov is emitted?

ACK, I'll remove the hardcoded scalar and set it to (prog - *pprog)

Alexis



--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

