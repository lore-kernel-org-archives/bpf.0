Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE063F39FB
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433108; cv=none; b=G/jutvE6UmbOfBnn0dbOR/WftILRdotsvLuDVQ38NuAeskmOaFtByGz/4GRduSOhf6v6IbYtRkT3yHkdAKpzsfE/RvecLJj4TpPe6nZtk9d+99G5N3sQqEDco6of08DhtbikfpyINtMmm0qS7AiTl6TGdbQX/B4s6GA0yhilGJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433108; c=relaxed/simple;
	bh=pEFT6WeztpCTvfIFAjJAcG1cKkrs/gnI4BG5N0hY8CY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Xk6cs50WPSPizVAq6MLtaSvBcgK0wUQatr6+ut0Tz9+QAMgA0jwgSYWFZjxEtecubQdff4h23uTqpEwrQu5RDNugOFxUi5NasilZsI7H+tNGQOW+NDRehPciFHrAk+y6UBiH6ZNY1o+dm4CMtqXFOfXpmd1kstiuD80muRBTVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YpsiodHL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YpsiodHL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 360491A0EB6;
	Tue,  7 Jul 2026 14:05:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01CAE60333;
	Tue,  7 Jul 2026 14:05:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4992E11BC01F8;
	Tue,  7 Jul 2026 16:04:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783433103; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lcSDRtHq3Dpy3y/yyenKBFvLuGnIqUD0sdDpTe70hjs=;
	b=YpsiodHLF4Fu2CN3/Ve3t0/lbJHwGcj0987mu1gwRA7IKBWIc1IS7PHhyc6+qLhrqKSMyj
	xB8drnJHM5Vn6NNZ30y2N25GBvL9+hYZnmyt+eB6z+p/qZI7e3td929fAczfho+EFtfp1K
	0dQvMPdUYy4jKaM4Y4azETEHdCJStY8bME1sQsxWoBtfg741R/kVsXr3BTRCqXvCAuXRFI
	DgykAWTAKixa+TtmoPGGdW72zYb+UKXo3nvi6zoODu5387/6BmEv7RVg8raDTu9cQN0CZK
	9bKzWP0+cul/H79GfGTFFdzx4wSPcLE/26ftqKtxOQq3sqlIFsQeNVEZydjYJQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 16:04:56 +0200
Message-Id: <DJSE9Q4E27GM.1V83GRFWOE4E2@bootlin.com>
Subject: Re: [PATCH bpf-next v3 04/10] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>, <ihor.solodrai@linux.dev>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, <hpa@zytor.com>, <shuah@kernel.org>, <mingo@redhat.com>,
 <andreyknvl@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-kasan-v3-4-bd09bb942d86@bootlin.com>
 <d173a3958e4fb9cfe928b4ecfb7799ffaf12029cdde1a1d9c493c5ecba1e9b7f@mail.kernel.org>
In-Reply-To: <d173a3958e4fb9cfe928b4ecfb7799ffaf12029cdde1a1d9c493c5ecba1e9b7f@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 1, 2026 at 12:44 PM CEST, bot+bpf-ci wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 054e043ffcd2..68c5f9f94e5e 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>
> [ ... ]
>
>> @@ -1110,6 +1121,90 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, =
bool is64)
>
> [ ... ]
>
>> +	/* Save rax */
>> +	EMIT1(0x50);
>> +	/* Save rcx */
>> +	EMIT1(0x51);
>> +	/* Save rdx */
>> +	EMIT1(0x52);
>> +	/* Save rsi */
>> +	EMIT1(0x56);
>> +	/* Save rdi */
>> +	EMIT1(0x57);
>> +	/* Save r8 */
>> +	EMIT2(0x41, 0x50);
>> +	/* Save r9 */
>> +	EMIT2(0x41, 0x51);
>
> [ ... ]
>
>> +	EMIT2(0x41, 0x59);
>> +	EMIT2(0x41, 0x58);
>> +	EMIT1(0x5F);
>> +	EMIT1(0x5E);
>> +	EMIT1(0x5A);
>> +	EMIT1(0x59);
>> +	EMIT1(0x58);
>
> This isn't a bug, but the save block annotates each push with its target
> register (/* Save rax */, /* Save rcx */, ... /* Save r9 */), while the
> matching restore block emits the seven pops with no comments at all.
> Would adding the mirrored comments here (/* Restore r9 */, /* Restore r8 =
*/,
> ... /* Restore rax */) make the push/pop symmetry easier to check at a
> glance?

I am not convinced this brings much value, aside from adding more noise
around the code.

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

