Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9E31E859
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641456; cv=none; b=tDu2A1CoKl+oOHem0NzmrQihX7FBtWXuT32IVcFd1bVkTA+Jx/YGj+VYC0HLlBDBWipDtU42rpHFnVHKTQgND1/Mov3/PHeRDClLQ+NR6x9r2WgzE9QoY+jkZ+N7NfAhrLlQh+VUZXISIImEwv2IiUpzSgmHup4kfc+ps5QSxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641456; c=relaxed/simple;
	bh=7QzfSxxXOZc7Sg+1rnXXpNsNdIw13HsMt9k9cbp05dg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=e7/BfeeleyJ3YEcgRRq4NF65ntX2+Ukaju/P4ibXNwoZqljdzoepeoXEdXW+h9shanoW2kKj4PQwnzmgLvhLsBraL58Eye1JrkFG9LRgBevMZ1j88l5G8p9EtOYSLlA5YufAU2rWjNXjwuI3YMsfY8S5DYDgZ21n5sYXRq+NQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wlufZJ8k; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wlufZJ8k"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 56E734E413AA;
	Tue, 25 Aug 2026 07:04:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15286604C4;
	Tue, 25 Aug 2026 07:04:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBE6711C79627;
	Tue, 25 Aug 2026 09:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787641441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=waD4o/I1Ndx/IZ1UJER8xvX3Xn3Bx5OwJxxwZTGepWA=;
	b=wlufZJ8kpt2bS0nqetdBOK2T+x5s8+LmgGaijPyZZyvw8eoPNBHAFykY8Tyj68tr2Ah8Ml
	Us3oCCmJzGgDfzgh6cMGH7/FZVRsTHSki2MPBndKcTQ+V/0OeroxXV4yo8giHkPGRPdWwo
	g8Cd7lj5BupqgmvDA1xBzrii/ju8oVZljIiNiDG18hi9LHqGh9IpDITjw8lRrcQbnIinvn
	JdUicZOxqdwpgZG7pFwvBPdvFmAlbU3xQGF2nM6Y7YmjTh2JjdhS2CVWNRY0VX9Sz1ZOs/
	VYHh+/RKfkambEAAQpuag/tT9Mv6+oaCAiqiy0psg5nyYy5v8N13LYN8jQa3Fw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 09:03:59 +0200
Message-Id: <DKXU03VFF1HG.1LI7OCCH41D5E@bootlin.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v7 4/9] bpf, x86: emit KASAN checks in x86
 JITed programs
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
 <20260822-kasan-v7-4-99afee6ef7fd@bootlin.com>
 <20260821233332.1D2201F00A3A@smtp.kernel.org>
 <DKWOG6YKM2NY.1FJHLE7BKZW9Y@gmail.com>
 <fa7cc4ad-6b8d-4bdf-8e2c-66d98ddef7df@linux.dev>
 <DKXLJLAMA1KZ.14CXAXXD5S0WQ@gmail.com>
In-Reply-To: <DKXLJLAMA1KZ.14CXAXXD5S0WQ@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ihor, Kumar,

On Tue Aug 25, 2026 at 2:26 AM CEST, Kumar Kartikeya Dwivedi wrote:

[...]

>>>> If %r10 is clobbered, could this corrupt the stashed BPF_REG_0 and pot=
entially
>>>> cause a crash when real_dst_reg is used as a memory pointer in the sub=
sequent
>>>> emit_ldx() call?
>>>>
>>>> arch/x86/net/bpf_jit_comp.c:do_jit() {
>>>>     ...
>>>>     /* Load old value */
>>>>     emit_ldx(&prog, BPF_SIZE(insn->code), BPF_REG_0, real_dst_reg, ins=
n->off);
>>>>     ...
>>>>     /* Restore R0 after clobbering RAX */
>>>>     emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
>>>>     ...
>>>> }
>>>
>>> This looks like a real bug, R10 is used for both atomics and constant b=
linding.
>>> We probably also should save R11.
>>
>>
>> Hi Kumar, Alexis.
>>
>> This topic has a bit of history now [1][2].
>
> From [1],
>
> "I built the kernel with gcc 11.5, gcc 15.2 and clang 22 and
> disassembled __asan_{load,store}{1,2,4,8}: none of them touch r10 or
> r11. gcc goes up to r8, clang uses nothing above rdi."
>
> Isn't this dependent on register pressure inside the function, i.e. depen=
ding on
> different code or whatever, it might begin using those registers?
>
>> I don't quite like it, but IMO we should give in to the bots.
>>
>> Reasons to save r10 and r11:
>> * SystemV ABI
>> * bots wouldn't shut up about it (think of future llm bot reports!)
>> * if our analysis of the kasan helpers is wrong about r10/r11 usage OR
>>   if something changes (the helpers themselves, the compilers, build
>>   flags, JIT's usage of r10/r11 etc.) - we'll get clobbered regs

Indeed, there's this risk of future versions of compilers deciding to
change the way those asan helpers are compiled, it will then silently
break (not sure how big of a risk it is, though).

>> Reasons to *not* save r10 and r11:
>> * we make the bpf prog a bit smaller and faster, the win is not very
>>   clear but it's percentages, not a factor
>>
>
> Yeah, also, we're already saving a ton of other registers, I don't know w=
hether
> saving two would matter, even if it wasn't incorrect. I wouldn't worry to=
o much
> about KASAN performance, it's already orders of magnitude slower than nor=
mal
> kernel build.

Ok, let's settle this then, I'll re-apply the r10/r11 save/restore
mechanism. If we eventually end up wanting to optimize it, this can be
revisited later.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

