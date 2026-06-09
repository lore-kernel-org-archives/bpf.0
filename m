Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F264383982;
	Tue,  9 Jun 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994873; cv=none; b=rKIAGHkP2VTFriXUV53Wt8jrS3a6f23sHt93zT+T7FwCiNEBr1kf7/So2dh1Ans+SvMtOiXeDh2DYUrdpnF412DDgV/dt4p348bNGyNgl+jvtZ3N+1afoiuMImL1SjujkTm353gBOttjEY56qi59xOujKAl68ZqlZ6HCrxVnBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994873; c=relaxed/simple;
	bh=B5zAEOf8R+GXxcdL/bb2XYRmO9k5KeskzXUSgYrauDk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=Sh113+Z3yGNWWbBZsvfT47IxOBLVJAp5DM9roKqK+0eqe5HhuiZPXcshJW3azSMGOZy9CytkVheCCRBxq2TE1JV2AfCesG2yheBTyVarkaDJHweH03ueDqsv1x9EVo0dBveGQ/fKtjxHQkeaOeZW0/ZvCY7uhsgtAzzUV1qSxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ISpERdkX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ISpERdkX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8A8854E42C7D;
	Tue,  9 Jun 2026 08:47:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4810A5FFC1;
	Tue,  9 Jun 2026 08:47:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4163106A2AC4;
	Tue,  9 Jun 2026 10:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780994866; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YjDdX3vciOF19PxithdDPrRHmvsQu1FVpC/1SU6RqHs=;
	b=ISpERdkX3duCHiXejPbFzvffW7F4yI9mZSAqibAXZRDOS5dhq7ubqMdN+moqHgxnQLg9Jx
	hwdzoXVU1SAANvZTq6vsCFH6SkPou/QuDLszyJnJGCnVdeB6K3ZueYWLl1rzgLpgfeOnUV
	nCRWeqc0nVSwoMk2hh6S8OrKQu7NyzzNmyugGBsRatDQur+H+PxeD2mxojrJg1SYJxPM+i
	Zt3uw97k9gKDSFAAyoOXMWF4HRHbS68V71sngePYfbVIzefB5XUJKKlmT7rgb7EyJnHVEJ
	CD3h8BarmuhxOLzK2tLJGvI+HiyjkzyCcgYZ3BAbGUrsuN2M3YepKtLuaqcrWA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 10:47:36 +0200
Message-Id: <DJ4DZHRVAV59.SPVM2QDQN0C@bootlin.com>
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <martin.lau@kernel.org>,
 <clm@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <john.fastabend@gmail.com>,
 <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
 <shuah@kernel.org>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260604-kasan-v2-2-c066e627fda8@bootlin.com>
 <1e7ab52954b9ff584d6871c2ec234a7155b577f29128564d0d597809cafad826@mail.kernel.org>
In-Reply-To: <1e7ab52954b9ff584d6871c2ec234a7155b577f29128564d0d597809cafad826@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jun 4, 2026 at 11:13 PM CEST, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
>> index eb3de35734f0..a8e004f88b92 100644
>> --- a/kernel/bpf/Kconfig
>> +++ b/kernel/bpf/Kconfig
>
> [ ... ]
>
>> @@ -101,4 +105,9 @@ config BPF_LSM
>>
>>  	  If you are unsure how to answer this question, answer N.
>>
>> +config BPF_JIT_KASAN
>> +	bool
>> +	depends on HAVE_EBPF_JIT_KASAN
>> +	default y if BPF_JIT && KASAN_GENERIC && KASAN_VMALLOC && VMAP_STACK
>> +
>>  endmenu # "BPF subsystem"
>
> This isn't a bug, but a design concern raised on an earlier posting of
> this work doesn't look fully resolved.
>
> In the v1 (RFC) discussion, the suggestion was to not add a config knob
> at all and instead do the instrumentation inside the JIT whenever
> KASAN_GENERIC is set:
>
>   "Let's not add more config knobs. Even this patch looks redundant.
>    Inside JIT do instrumentation when KASAN_GENERIC is set."
>
>   https://lore.kernel.org/bpf/CAADnVQLj=3DUosnsC-4V2+mN92Fe0-kW++U+m-O9c9=
3kk6BwiXgw@mail.gmail.com/
>
> The reasoning given for keeping the internal Kconfig was that it lets
> selftests adapt their behavior without sprinkling arch and KASAN
> conditionals, and another reviewer agreed that approach was reasonable.
>
> That "this patch looks redundant" objection was never explicitly
> retracted or re-acked, yet the BPF_JIT_KASAN config is retained here.
>
> Has this design point been settled?

I still advocate to keep this BPF_JIT_KASAN, which is used later in
patch 7/8 to check whether kasan tests should be executed or not.

Alexis
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/269783=
80520




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

