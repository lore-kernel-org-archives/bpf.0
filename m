Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540B1B4156
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 06:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182695; cv=none; b=frAlUYeAFEwty5DYasL5I3pLpCYkZCrBkSOoDOARuyZHpeUyFKefQCFTQlBMotbHQhl11MOJbisJ3uzRbjogzetZbhc0B1ohqu+Xr4DKgLDUjYumc7iKKf2XAealfox/aBMN2P0roFS5L+Gr6aiGKmUrh1P1rmOrNlSmCIF3t2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182695; c=relaxed/simple;
	bh=ePdGJB6kbu+Hy9JiGKnY6zl5s2WLNxMt9uE1yitqa9A=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=k6ufEgorjufup/iPiyu4LUlf1EtWmsju5RsX+3H6kXfaRfuUvYaoF956luDTCO63JvDzzafpN7v7Mx+CbyrDhUIfsemYH6QYGJBAtPaAoeZenDWX2tYZjjfMWo/x54mY/OAyzwnV3qOXMIwTnorgP2evjWPY3VB0xOZHWdAm1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OyLjLsIn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OyLjLsIn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AA525C2B9DC;
	Thu, 16 Jul 2026 06:18:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 615316035F;
	Thu, 16 Jul 2026 06:18:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2B6D11BD3C9C;
	Thu, 16 Jul 2026 08:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784182685; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QTv98aiWmLb8Il/n2EQE66t9E9VKwKWB+oc06j7+jAA=;
	b=OyLjLsInu8+p/ce/sioxWdpRR4suLqVy0FGnPgYmdRbQXQ1uWhHpmppy7m0jzBi7qikxU1
	xorZFxvJSPQfUZzw936knZhqIL3MePCadmoM1ZsHKrJx5NYcaPr30snZeSbgEt6xoLIccl
	oA2Husq2COVB8vPMmb3ItcYZn0qp7k63rN5pW15RnRApBqJmP3/vBGhRwiTiHhrb2dOFui
	Yk29v3hwhNhCj0sHTYoGrdwE8IUUGssfiwlSpQ+yy2G54QAM45JfcPksyvKSzAsIFBvkLn
	cxSI4gg2L3fvCMqPlWTB6OBdXmDFM4QQAEjO7bhhP/pT1/MVaFP1YuIUACiWuw==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 08:17:55 +0200
Message-Id: <DJZRZ1WQ82BG.3UJGK4IH5703@bootlin.com>
Subject: Re: [PATCH bpf-next v5 01/10] bpf: propagate original instruction
 offset when patching program
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-1-1c64af8e4e1e@bootlin.com>
 <bbbcbae7-a819-4f86-b116-6d5e31973a0e@linux.dev>
In-Reply-To: <bbbcbae7-a819-4f86-b116-6d5e31973a0e@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ihor,
thanks for the thorough review !

On Wed Jul 15, 2026 at 2:47 AM CEST, Ihor Solodrai wrote:
> On 7/9/26 3:01 AM, Alexis Lothor=C3=83=C2=A9 (eBPF Foundation) wrote:
>> When the verifier patches an ebpf program with bpf_patch_insn_data, it
>> then calls adjust_insn_aux_data to make sure that insn_aux_data takes
>> into account the newly inserted patch. Some of the data offset is pretty
>> straightforward to deduce, it is for example the case for
>> indirect_target, as any patch affecting indirect calls will
>> systematically move the original instruction to the end of the new
>> patch.
>
> I think an additional KASAN-specific argument to adjust_insn_aux_data()
> is not a good idea. It's threaded through ~30 call sites, and it's
> been error-prone too: you had to fix the offsets a few times already.

Agree. I've indeed already made a few back and forth on it, it looks
like there are still more to do, and not in the good direction (I mean,
just passing -1 to ignore original insn offset), so that sounds more and
more like a hassle for no significant gain. This ends up being pretty
intrusive for a debug feature, and as you state below, the only downside
of not tracking too finely those stack accesses is about getting a few
unecessary KASAN checks.

> indirect_target needs no help from the callers, so it's not really the
> same pattern. Similar for the other aux fields: seen is broadcast and
> zext_dst is re-derived.
>
>>=20
>> In order to introduce KASAN support for eBPF JIT, we need to mark any
>> load/store instruction that accesses non-stack memory, but updating this
>> new marking after a patch is not as straightforward as for indirect
>> calls: the original BPF_ST/BPF_STX/BPF_LDX can be at the beginning, at
>> the end or somewhere in the middle of the new patch: we then need some
>> additional info to properly update this marking.
>
> I don't think we need to track the exact offset here.
>
> It looks like .non_stack_access is set to is_mem_insn(insn + off) in
> every single case *except* for when a stack access happens to be in
> the middle of a patch.
>
> Given that the cost of getting the flag "wrong" is an unnecessary
> kasan check only for that case, I think it'll be cleaner to just
> unconditionally do:
>
>     data[off].non_stack_access =3D is_mem_insn(insn + off);
>
> in adjust_insn_aux_data()
>
> And then the code change can be folded in patch #2
>
> The only problem with this I can think of is that in reality *most*
> stack accesses go trough that special case, which would defeat the
> purpose of the .non_stack_access flag. This can be checked empirically
> however.

> Anything else I'm missing here?

Sounds good to me. I'll try to get a rough idea about how often the
flag, in this scenario, correctly triggers or not.

Thanks,

Alexis


--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

