Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAB2F7F00
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520993; cv=none; b=as9MAW8k3jZPW8hhi22ER9OfA/5hnNnkz6+K/fR55sWHDpADD6xFJ6FbI/0g5Q8GgW3LDX7MY6aK2QCE/C84CZYqACNIMlCtKdKiMlU7APp2COX0YFgaejRJPtel93PghoN/SxvpxzKGmrRHpPZtywDw1CMT5Cso/WvC/S5EqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520993; c=relaxed/simple;
	bh=0EQS4b2y5fOIG2iZZCI3CEnOSxrhC5jpI0oJ+IYFKpA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=fy6Q5w9pcoTDD+Aq/S0sKh+0+vBnzpKimzsLEdC2lMNKkjubw/XF/2J3bJdosPO8piyc1lSbsnv7TbDvovRu3lYAvbuTRdgs+S2p96OMv+/VuRYT1Jg2y37w+AvusS0CRQKQ/VDiDswHEZ84aviO2LNlYhpGo3cVuF0wG5xk2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iWD5e0n/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iWD5e0n/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B31444E40CF8;
	Wed,  8 Jul 2026 14:29:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8266A60339;
	Wed,  8 Jul 2026 14:29:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE14E11BC160C;
	Wed,  8 Jul 2026 16:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783520986; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o82DbF8s8b7G549mLHjy0Ad3pAm9yT4zhlFEQzivpjw=;
	b=iWD5e0n/02jpsLsjZkKAt0xoR+Dy2GDDSHfHeYVi/6V5O6MDjqXzotIgtZQgEHqGqnxScq
	KDkyjz6scUVR5d8WSRiIFxsUgxkMeZ07QrjoKVeaHSXLeeYyC7k8epQVVF29pPNoPysPtg
	K0eRpVfQ9L6ozFI92yclQ9o8a+jSNqfGUxtixsS3mXhvWch6nzJanvqMo6v+x3mAk8jzPV
	uOjbDYD2lhk18CoVv0Kd/aP/oVKdpZ6kfYG1qtaE8tma+zXIfZ5nGY9O2bD4MkYxXwFHvP
	P8J4WDNTl93wXEASW1eivqqkf2HwBJnMqmV5YwkEDrtdmrTxN3tI/jUHVqbATQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 16:29:45 +0200
Message-Id: <DJT9F9K9QAVP.1CW1PL79CYQ3Y@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v4 06/10] bpf, x86: emit KASAN checks into x86
 JITed programs
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-6-d5c177ab8227@bootlin.com>
 <20260708081650.5E8BB1F000E9@smtp.kernel.org>
In-Reply-To: <20260708081650.5E8BB1F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 8, 2026 at 10:16 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] `emit_kasan_check` fails to save and restore the caller-save=
d registers %r10 (`BPF_REG_AX`) and %r11 (`AUX_REG`). This corrupts state d=
uring atomic fetch operations and constant blinding, potentially leading to=
 arbitrary memory corruption or kernel crashes.
> - [Low] Atomic read-modify-write (RMW) operations are incorrectly instrum=
ented as KASAN reads instead of KASAN writes.

[...]

>> @@ -2626,7 +2662,17 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>>  				if (dst_reg =3D=3D BPF_REG_0)
>>  					real_dst_reg =3D BPF_REG_AX;
>> =20
>> +				ip +=3D 3;
>> +			}
>> +			if (!bpf_atomic_is_load_store(insn)) {
>> +				err =3D emit_kasan_check(env, &prog, real_dst_reg,
>> +						       insn, ip, false,
>> +						       accesses_stack_only);
>
> [Severity: Critical]
> Does this KASAN check clobber %r10 (BPF_REG_AX) and %r11 (AUX_REG)?
>
> If this is an atomic fetch operation and BPF_REG_0 is used, the JIT saves
> BPF_REG_0 into BPF_REG_AX (%r10). However, the emit_kasan_check() functio=
n
> emits a C function call without saving %r10 or %r11:
>
> arch/x86/net/bpf_jit_comp.c:emit_kasan_check() {
> 	...
> 	/* Save r8 */
> 	EMIT2(0x41, 0x50);
> 	/* Save r9 */
> 	EMIT2(0x41, 0x51);
>
> 	/* mov rdi, addr_reg */
> 	EMIT_mov(BPF_REG_1, addr_reg);
> 	...
> 	/* call kasan_func */
> 	if (emit_call(&prog, kasan_func, ip))
> 		return -ERANGE;
> 	...
> }
>
> Since C functions can clobber %r10 under the System V ABI, could the
> subsequent use of real_dst_reg (which points to %r10) lead to wild memory
> accesses?

Already discussed multiple times in the previous revisions


> [Severity: Low]
> Are atomic RMW operations incorrectly instrumented as KASAN reads?
>
> The 6th argument to emit_kasan_check() is is_write. Here it is hardcoded =
to
> false for mutating atomic RMW instructions. Should this be true instead, =
so
> that KASAN diagnostics report out-of-bounds writes rather than out-of-bou=
nds
> reads?

It sounded logical to me to flag a RMW operation as a read access, as it
is the first thing performed by the op, but I can change it to a write
it it makes more sense. It should just change the wording in the report
anyway.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

