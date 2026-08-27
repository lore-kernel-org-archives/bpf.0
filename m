Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F74332601;
	Thu, 27 Aug 2026 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814120; cv=none; b=mLhlru0B8KGmm2iuc6sQod8MECq/0nLiltCptxL9+Kny06KbCYI+fTaQrLPr8Wf+Fn6H3o4Om3PJ7u8SIk326quPO6wo2sl0jQWRe1oxRfGTdGAwyR2qLM18PEWHq/2Jm3VI/VuoAZc74jwTZEIvEKWLCDYPfUC8dY4stQ5vgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814120; c=relaxed/simple;
	bh=rMYhr+FFl3KMzJ4WopkMeaMaQqMYKgr/4WQwGO/gP5w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=kwJrvhLRoTjhu3gDVaKBPAsxE7DCt9pjfIcsucRn88Wrs3D1i4aq5kFs8v5xmJaEzSfW1GWiM98OZ23lPrPuLHl1ss8y3vomHXdpVC0HNSG7fHwgH403W5WS/t+y7xgmOhtpOn4Nsu+LPmskAqRV3hYPNQEeQjDGEH+pf+RrMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zr5vWxlS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zr5vWxlS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 552701A185D;
	Thu, 27 Aug 2026 07:01:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1EF17602B8;
	Thu, 27 Aug 2026 07:01:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA8F311C78051;
	Thu, 27 Aug 2026 09:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787814109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LZbe2GS1y6n+NqZR8SC8iK/SbIh328ZBAhni88rkOIk=;
	b=zr5vWxlScZ74+veUzn/MjjgAqEdRSSd6vg5uIl4X2OuAsAhLCDBhknPQZqRPSirB3PvGS1
	0BZNIFc3f6hxlAI0A5Lis6e61+Nyyx8Wxl0y7YHgyVj2KmLJv8sV/lO2qc4EITOrKExqPh
	KCRwUpP7ocG4fcdDhJEtLE7wK7CDgPL+eHBd0hDK1gKYE5IJqFl5lInz6ej4wcM2nBagZX
	8oLn2uoGmYSRsjBWxj3BDaqP5xD6u+7eTtIIY3KG5MAnfApd9ywkc4Gzom1U+2rbcXNRhG
	2QtleX3T+FB8C5xp8wGyqT53jUlpfEbfuLETeJBrzTp4eQox/y14vJy+afq6Aw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 09:01:42 +0200
Message-Id: <DKZJ7GFLAU12.1WHACTBREQQV2@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>,
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
 Tsalapatis" <emil@etsalapatis.com>, "Yafang Shao" <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next v7 0/9] bpf: add support for KASAN checks in
 JITed programs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
 <DKWOY12R4ZJJ.A8KDS1DU1PHS@gmail.com>
 <1c34603a-9170-4074-b826-e98d9871e2d8@linux.dev>
In-Reply-To: <1c34603a-9170-4074-b826-e98d9871e2d8@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ihor,

On Wed Aug 26, 2026 at 11:00 PM CEST, Ihor Solodrai wrote:
> On 2026-08-23 3:53 p.m., Kumar Kartikeya Dwivedi wrote:
>> On Sat Aug 22, 2026 at 12:39 AM CEST, Alexis Lothor=C3=A9 (eBPF Foundati=
on) wrote:
>>> Hello,
>>> this is v7 of the series aiming to bring basic support for KASAN checks
>>> to BPF JITed programs. This new revision just makes the series rebased
>>> on top of current bpf-next_base.
>>>
>>> Please note that with the recent kernel splat detector introduced in
>>> kernel-patches/vmtest through commit 8109e5928cd0 ("ci: own the kernel
>>> splat matching (#509)"), CI runs on this series will fail with the
>>> following error.
>>>
>>>     Error: kernel splat detected: [  100.689549] BUG: KASAN: \
>>>     slab-use-after-free in \
>>>     bpf_prog_eba69524d1d949b1_st_not_on_stack+0x12f/0x17a \
>>>
>>> which is pretty normal, as the new selftests introduced by this series
>>> are expected to trigger KASAN splats (the test_progs part will pass,
>>> only the kernel_splats part will trigger errors). The right fix may be
>>> to just put a list of regex matching all the kasan subtests progs in th=
e
>>> relevant SPLAT_ALLOWLIST file; something like:
>>>
>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){=
16}_(st|ld)(x)?(_not)?_on_stack\+
>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){=
16}_simple_atomic(_fetch)?(_not)_on_stack\+
>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){=
16}_ldx_patched(_not)?_on_stack\+
>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){=
16}_verifier_paths_stack_and_non_stack\+
>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){=
16}_ldx_oob\+
>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){=
16}_st_blinded\+
>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){=
16}_(load_acquire|store_release)(_not)?_on_stack\+
>>>
>>> I can take care of opening the relevant PR in kernel-patches/vmtest wit=
h
>>> this if it ends up being the correct solution, but it will make sense t=
o
>>> do so only once the selftests list is validated (but before merging the
>>> series).
>>=20
>> We need to resolve this before landing the set. To me it looks inevitabl=
e, esp.
>> if we exercise the support and produce such warnings. That said I'll let=
 Ihor
>> respond and provide guidance for this. We should probably land the vmtes=
t PR
>> before v8 is posted, so that v8 can go through CI and be processed witho=
ut
>> failures.
>
> This is a tricky one.
>
> IIUC the suggested allowlist regex will also mask the real splats, which
> the whole KASAN-in-JIT project was supposed to catch.

Not really: the proposed list of regex above just discards the splat
emitted by the progs used by the tests related to the KASAN feature (so
any prog in tools/testing/selftests/bpf/prog/{kasan.c,kasan_harden.c},
which anyway generate "fake" KASAN splat for most of them, since we are
manually poisoning some valid memory to trigger the splats. Any other
program that generate a splat will be caught by the splat detector.
>
> I think a good way to resolve this is to teach the kasan splat
> detection script about these tests, and drop/skip them from the dmesg
> log it inspects. For example, match begin / end of the test set.
> Might require special log anchors printed by the test itself, but
> you get the idea.
>
> Alexis, do you mind trying this?

If despite the comment above, teaching check-kernel-splat.sh how to
ignore the kasan selftests specific splats remains a better solution,
sure, I can work on this.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

