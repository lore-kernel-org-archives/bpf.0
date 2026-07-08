Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E113783C3
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520151; cv=none; b=TxTEaL/Q+5xNRrZDdit7AjIjW+hNEjP3DmETvdvd+gempbonka1LYEj5OtemlOqaZsKyPTi3XTkfMelv3tsjXndvY6LXbeEBnp4sky33IqZriKhwq6rZ+waJBGXR9ijPU6OjMGZ9ZeoawS7HqGVXtoyBX7js2Io7thrCIDNu5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520151; c=relaxed/simple;
	bh=qFYi9R5XF/tPfB9b8MczKI4Pm7qhRYAEoOgJudkQ9gM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=MTREYUrIp1o56dSvZERAz5rc2dzzxWUb5j5t4PrFep2sfcz12+eEZ/uGByZhKtETHdabrpsQ2wt90QBSnCx4FLaOWpzq5OEzxukJsZSWh/wb6MCnRjUPAwT9l07iBr2dhrLScpFkTZx4Ume2wQjKavTHWebES2DUdYFD2vsh6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CgkwsLHt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CgkwsLHt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BAF164E40CF6
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:15:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7558760339;
	Wed,  8 Jul 2026 14:15:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC86211BC0E94;
	Wed,  8 Jul 2026 16:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783520148; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GiBSUKr/VC8/9k1Cknl66kr0ElTnjG9j76/41tHCAr4=;
	b=CgkwsLHtrYibj5urTFHeuV9fJ1bfVQXH7fLMdDWvm7ndpZm05xlG7W0O1+vR3pztLM9r7E
	tCkhE3d7o6ARUcGGHgBE04l0DYYWcHMnBUB+U9O78/zCy2uDz1fdM4qCEkFdNtsoJQugsA
	t+fqgqIn4+5O3kOgQui4jUfuJV68k7akX4iuxu4nb8yaYxehXQmMmp3yo81X4NRZ4vK4JP
	ISehL7W+GXwILVJ1UfmkaUEvldfVVifkDOZmH+2uUjEgD6I/MSuXxJPcGfvMX47vH3EABj
	DUiRVi2u+vZgMdf2aCwxjN6aElkNXJ2fCXHOjTNA0TCBSrvvUt6WV4u3np2RrQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 16:15:47 +0200
Message-Id: <DJT94KN9O0VZ.1T3XAMIDEATEI@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v4 02/10] bpf: mark instructions accessing
 program stack
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-2-d5c177ab8227@bootlin.com>
 <20260708081008.402A51F000E9@smtp.kernel.org>
In-Reply-To: <20260708081008.402A51F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 8, 2026 at 10:10 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] In `adjust_insn_aux_data()`, when replacing an instruction with =
a single new instruction (`cnt =3D=3D 1`), `data[off].non_stack_access` is =
incorrectly set by evaluating `is_mem_insn(insn)` instead of `is_mem_insn(i=
nsn + off)`.
> --
>
> --- Patch [2]: [PATCH bpf-next v4 02/10] bpf: mark instructions accessing=
 program stack ---
> commit 764c11844e954d2fc0370d170803b0deb684733a
> Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com=
>
>
> bpf: mark instructions accessing program stack
>
> This commit introduces tracking of instructions that access non-stack mem=
ory
> to help JIT compilers emit KASAN checks. It adds logic to mark BPF
> instructions as stack-only by default and overrides this if any state
> indicates non-stack access, including adjustments during verifier patchin=
g.
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index f515fc9669ce2..feee1f33de9d5 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>
> [ ... ]
>
>> @@ -172,8 +184,14 @@ static void adjust_insn_aux_data(struct bpf_verifie=
r_env *env,
>>  	 */
>>  	data[off].zext_dst =3D insn_has_def32(insn + off + cnt - 1);
>> =20
>> -	if (cnt =3D=3D 1)
>> +	if (cnt =3D=3D 1) {
>> +		/* A non-memory accessing insn could have been replaced by a
>> +		 * memory accessing insn, systematically mark it for non-stack
>> +		 * access
>> +		 */
>> +		data[off].non_stack_access =3D is_mem_insn(insn);
>
> [Severity: High]
> Should this check be using is_mem_insn(insn + off) instead of
> is_mem_insn(insn)?

Aouch, true, my mistake.

> Since insn points to the start of the program (new_prog->insnsi), calling
> is_mem_insn(insn) evaluates the very first instruction of the program rat=
her
> than the newly patched instruction at the targeted offset.
>
> If the first instruction happens to not be a memory access, will this
> incorrectly mark the patched instruction as not accessing non-stack memor=
y
> and cause us to miss KASAN instrumentation?
>
>>  		return;
>> +	}
>>  	prog_len =3D new_prog->len;




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

