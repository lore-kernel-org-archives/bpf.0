Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25C386575;
	Thu, 16 Jul 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187673; cv=none; b=S1CCFnC5eerkUEnMqZbx3kQ8Yp8RgKptPMWjdn3M8uxzRTPnvQoaoqCDiodkJ/ruKl2YWqLGvv8MlCaT1W7mKQaI4qjLfe3Ithgge+BmxtXYcRDd2A4MzAZASWBJaRnFFLOX9nFM+anEi7PxIfkuraVPzOH2zF0AGSK0bAYeKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187673; c=relaxed/simple;
	bh=CPasxW6bFRdLma9I5DJcbcNl+2UHOaRXpdpD3+smO20=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=a+pFWpdNKpm1cfobdwbJIIyVj8Fb9n7YGcZ14T5uRkwV5ZIURVHvMowO1ZdaFOd36x4tXVPdQxHOQVAuZjd+nVV3ZbYlrAZ4o/FVZj02kPRxJz+08DTVWHX3JZjxUlTsa/uiwFkTubmkzh/3GfL1SCt993f/ai4hlzVQGU3Gmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kfr6p+jl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kfr6p+jl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 27565C2B9DC;
	Thu, 16 Jul 2026 07:41:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCD5B602B8;
	Thu, 16 Jul 2026 07:41:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E1ED11BD1CD7;
	Thu, 16 Jul 2026 09:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784187667; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ew/fD4jWBVAQDnPravt+reICzwd3JTPlrxsci8ADgg8=;
	b=Kfr6p+jl4q6Z9eE2gdJZ1Nxao/8Y5nJ4EOT3tRcczKgoHoFMoS6TWScZJ7DXORKu8Y86Wn
	7+SSWG3JPjl62ArNqCUvu6OVXw4hKDmRkIubOfm6E9ZnEFZA98ljM9nokujm/2VQGXFLAf
	1g7qGl4Ny7wg/iaX0PxZfrcSV2+76pI3dW7GDOzr04UYZAcy3sKBrnuiAkhEBWVjgCd2e6
	gcjzlXBibADXojNLXmvJpPvyTs9gEGZtwooUOHZSTX6Rp9WUPHJv2mYGpYMIi1YrdSioii
	lxDW4rSXZM+dWi/cNubYRf1tGV1Vp33qY7FqS0qpsSIHtIpwppzrUxmusuU9jw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 09:41:00 +0200
Message-Id: <DJZTQNZDG8G7.3GLNML4I7INNS@bootlin.com>
Subject: Re: [PATCH bpf-next v5 04/10] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-4-1c64af8e4e1e@bootlin.com>
 <5f38c9a5-a8a3-4bed-bb8c-b7260a1c1a11@linux.dev>
In-Reply-To: <5f38c9a5-a8a3-4bed-bb8c-b7260a1c1a11@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 15, 2026 at 2:53 AM CEST, Ihor Solodrai wrote:
> On 7/9/26 3:01 AM, Alexis Lothor=C3=83=C2=A9 (eBPF Foundation) wrote:
>> Add the emit_kasan_check() function that emits KASAN shadow memory
>> checks before memory accesses in JIT-compiled BPF programs. The
>> implementation relies on the existing __asan_{load,store}X functions
>> from KASAN subsystem. The helper:
>> - ensures that the kasan instrumention is actually needed: if the
>>   instruction being processed accesses the program stack, we skip the
>>   instrumentation, as those accesses are already protected with page
>>   guards
>> - saves registers. This includes caller-saved registers, but also
>>   temporary registers, as those were possibly used by the
>>   affected program. Theoretically, r10 and r11 should be saved as well,
>>   but the number of called function and their scope being limited, they
>>   are skipped for the sake of reducing the overhead
>
> My clanker got very excited about r10 and r11 not being saved, just
> like sashiko. So I looked at this a bit closer. TL;DR it's fine
>
> I built the kernel with gcc 11.5, gcc 15.2 and clang 22 and
> disassembled __asan_{load,store}{1,2,4,8}: none of them touch r10 or
> r11. gcc goes up to r8, clang uses nothing above rdi.

Thanks for the double-check, my observations are aligned with yours :)

(https://lore.kernel.org/all/DJ5HDX2K5CTF.YRZ9TDI6QCII@bootlin.com/)

> However, kasan_check_range() does use r10/r11.  And looks like we are
> ok only because the fixed-size helpers inline the shadow check and
> never call kasan_check_range().
>
> If any of the fixed-size 1/2/4/8 helpers ever actually call
> kasan_check_range(), r10 may get clobbered.
>
> Maybe we should leave a comment on emit_kasan_check() about this?..

Ok, I'll add a comment about this in emit_kasan_check.

[...]

>>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
>> =20
>>  static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
>> @@ -1110,6 +1121,90 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, =
bool is64)
>>  	*pprog =3D prog;
>>  }
>> =20
>> +static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
>> +			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
>> +			    bool is_write, bool accesses_stack_only)
>
>
> nit: IMO it's not nice to introduce functions with no caller as a
> separate patch: it triggers -Wunused-function on this commit, which
> may or may not be used in a build. I'd fold this in patch #6 where the
> function is actually called.

Ok, I'll fold it in the commit actually using the helper.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

