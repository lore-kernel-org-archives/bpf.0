Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1485382F10
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918305; cv=none; b=uNYmajjAhKt644HMZ6dW7GTm9uISqOs4/N9qXXH5HYnuqBLNiNcTuY1MehVVtcRR94cXnkMSDNJqy0nhfGMYpt7ix29LeJXEG4Ip7h1IoC2SmdWAeg6UsyMrsgqIuzf432l3R6fte1ibhkiMH3RipooK8G9aWMkCQRxJhshWUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918305; c=relaxed/simple;
	bh=j7pg1eQ8bwfhdZWt7vrmy2tAkRrPgKImJQlDd8A8ksY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=nlgmfNORCpfEEnwltGg8eoxSjt1JF/KA6mPp+uG0xzkg167utT3ZIq3yNQsojbRVnDK/pNeKWnWlRRqqslOsTTdbFDqH3ae1dq+j7DHqUeaLP2xXUYqWoB1IoWY1uJoI6S7J/MuMXqFKveC7kpHpd/xbKQDMHSm1zy2l1Ct4np4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1zBsVh5B; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1zBsVh5B"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B51D04E410C9
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 08:24:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8085B602AB;
	Wed,  5 Aug 2026 08:24:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90AA611C34397;
	Wed,  5 Aug 2026 10:24:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785918299; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/fgYSdKnrDojrnMpuodU72uOJdhwVUwt+MqzVMP9kI8=;
	b=1zBsVh5BufIcqCt507tCwbmWMw+SnHOlbduaqY0jWWxoaWBCFqd1h3pJAu/D+nneVGY13E
	63MNQ1FAQoGJV05TGOwo723pH++2gJ6rNjCw708ME1wF4UQ+JpjQL26YrTefha/3B+3IKD
	A+r4LG/JP3sEdNo4i5edNSMc2paoQmyh4EWTy3viOpYg5iWzHNoAsdE3lQ87IrSQ/4wjFD
	cPYcxay95m1EUCXuWYJG8VghUpLjnmF4u2Gs5wIL1BHkc4N9lQ1LQMfIA7fkQR639g68Id
	arGcEKRsLA+msvqFdIs4Dpr1zb3dUiAxjoXsXloOPLy8O52sIHvwXRB+EH+xyg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 10:24:57 +0200
Message-Id: <DKGV77RFHLUM.1SCIGQ894DYQ3@bootlin.com>
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: add tests to validate
 KASAN on JIT programs
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
 <20260804-kasan-v6-9-549ef845f491@bootlin.com>
 <20260804183540.464031F000E9@smtp.kernel.org>
In-Reply-To: <20260804183540.464031F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Aug 4, 2026 at 8:35 PM CEST, sashiko-bot wrote:

[...]

>> @@ -2449,6 +2583,11 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>>  				/* populate jmp_offset for JAE above to jump to start_of_ldx */
>>  				start_of_ldx =3D prog;
>>  				end_of_jmp[-1] =3D start_of_ldx - end_of_jmp;
>> +			} else if (!accesses_stack_only) {
>> +				err =3D emit_kasan_check(env, &prog, src_reg,
>> +						       insn, ip, false);
>> +				if (err)
>> +					return err;
>>  			}
>
> [Severity: High]
> Does this code emit KASAN checks for BPF_PROBE_MEM and BPF_PROBE_MEMSX
> instructions?
>
> Tracing programs frequently probe pointers that may be NULL or point to
> userspace memory using BPF_PROBE_MEM. The verifier emits these
> instructions to use the BPF exception table, which safely faults without
> crashing or logging.
>
> If emit_kasan_check() is called here unconditionally, it evaluates the
> pointer using __asan_load*, which will call kasan_report() on NULL or
> userspace pointers. Won't this bypass the exception table entirely and
> print a KASAN BUG report to dmesg for every expected invalid pointer,
> potentially causing log spam?

Aside from the usual r10/r11 complain: I am confused about why the bot
is raising this concern in an answer to the selftests patch, I guess it
should have been an answer to patch 4/9.

Anyway, no, this is not instrumenting BPF_PROBE_MEM/BPF_PROBE_MEMSX
insns, and it should not. We are in the else branch of the if
actually checking if we are dealing with PROBE_MEM/PROBE_MEMSX.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

