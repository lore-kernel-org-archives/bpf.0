Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1C44B662
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519900; cv=none; b=J/Uuo8ziUq1Kmjg2wek5nxRSiAtxcVdBtZ+jcvPQCW6KXsVOfIwOnAsD9YxZesDaCLbgGcQnD+cAH4xKG4ottXmfMw+u3wUCU2w274FjH/uIpXdcW/XO6oB9eGwhvtLrtM90sC4mYsvb53b+KFMC2AqQxLi7zZqK8Tewp6G0NiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519900; c=relaxed/simple;
	bh=o5BKzQ5XVNoXoOY1PdEqzQzGn8pvVZbFhJ0nDTsuXlQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=MAyft+N/8HM6RIivOZNEJHeUwrUf4Nj5c/4vtdGMsyT/o/UqpCORTR5wzU1VOcA4ZcnYzWq6nagysW1qW/XfvHbSJfvg7We7Vm0O76xJQVYVmBv3byD+RthysX1skVe/znkc2L0FHuj/Iof/O+p2CbNQgudNT3CLR8EDI5u65EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RKPDLJer; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RKPDLJer"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5B1F34E40CF6
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:11:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1ED1460339;
	Wed,  8 Jul 2026 14:11:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B7F311BC1671;
	Wed,  8 Jul 2026 16:11:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783519895; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PY68Z4msWFK4F7TYEuMFCjHbxpm8rYeAoJBT3xUn7VM=;
	b=RKPDLJermHgBJW/tmxMKD4VCPdLv9YEj3N7H+nsqMIrBNUtkQc/RrMgPizIkBJNFYmaPAS
	u0yIA68Y3NzPqSoTQc44BArl0TcG4Q/T52ts/WH9PiJXFUEIIOqgN6UVvKBT1fgzRXkEiP
	tFiwr5xoYP4wi+Qt5HFSUVmsZYXWznfqtYrnqI8OVYnuSXaBInZ3toM49HWmEkXiqN5U6G
	zo5EBe5ErOxowdZ03RvN2kULrwBru+e7P/rQn2vvgFIFyG6mg+J07LZXoaOsFbb+qVtsGR
	Fs1gcvdfc7hcLPDrRYT5hojd7GeNx0FBFaaExhrAyPUCJLzhzic5TEPlbgJvig==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 16:11:34 +0200
Message-Id: <DJT91CC6V6TS.1U8K4LYH8LMZ2@bootlin.com>
Subject: Re: [PATCH bpf-next v4 01/10] bpf: propagate original instruction
 offset when patching program
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-1-d5c177ab8227@bootlin.com>
 <20260708081937.5D5031F000E9@smtp.kernel.org>
In-Reply-To: <20260708081937.5D5031F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 8, 2026 at 10:19 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Incorrect or inconsistent calculation of `insn_off_in_patch` c=
auses loss or misassignment of `aux_data`.
> - [Medium] A single `insn_off_in_patch` integer is insufficient to propag=
ate KASAN memory markings to patches that emit multiple memory accesses.
> --
>
> --- Patch [1]: [PATCH bpf-next v4 01/10] bpf: propagate original instruct=
ion offset when patching program ---
> commit 6ebaaf2368d2745f393ec38eb53d5857d5ec62b8
> Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com=
>
>
> bpf: propagate original instruction offset when patching program
>
> When the verifier patches an ebpf program with bpf_patch_insn_data, it
> then calls adjust_insn_aux_data to make sure that insn_aux_data takes
> into account the newly inserted patch.
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 12a8a4eb757f1..f515fc9669ce2 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>
> [ ... ]
>
>> @@ -856,16 +862,20 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_e=
nv *env)
>>  			if (!ops->convert_ctx_access)
>>  				continue;
>>  			convert_ctx_access =3D ops->convert_ctx_access;
>> +			insn_off_in_patch =3D 0;
>
> [Severity: Medium]
> Will this properly track context accesses that are converted into multipl=
e
> chained memory loads?
>
> By relying on a single integer to track the offset, it seems we might fai=
l to
> account for multi-load patches emitted by ops->convert_ctx_access() (for
> example, reading skb->dev followed by dev->ifindex). The secondary memory
> accesses will receive zeroed aux_data and lack the required KASAN
> non_stack_access marking.
>
> Additionally, since the original instruction is completely replaced here,=
 does
> it make sense to unconditionally assign its aux_data to the first generat=
ed
> instruction, which might not even be the actual memory access?

Hmmm, true, there's an issue here. I have checked many XXX_convert_ctx
accesses and naively assumed that the generated patch was always a
single ldx or stx, but indeed, there are corner cases:
- bpf_convert_ctx: __skb->ifindex becomes LDX + JPM + LDX
- bpf_convert_ctx: __skb->pkt_type becomes LDX + AND
- bpf_convert_ctx: __skb->queue_mapping becomes (JMP +) ST or STX
- and many more

For all of those XXX_convert_ctx_accesses, the accessed memory should
always be checked with KASAN since we are dealing with ctx pointers, so
it may be simpler just to pass -1 as insn_off_patches to
bpf_patch_insn_data for all of those, so that any LDX/STX/ST in the new
patch is instrumented.

>> @@ -1464,7 +1475,7 @@ static int add_hidden_subprog(struct bpf_verifier_=
env *env, struct bpf_insn *pat
>>  	 * ones for the hidden subprog. Hence all of the adjustment operations
>>  	 * in bpf_patch_insn_data are no-ops.
>>  	 */
>> -	prog =3D bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
>> +	prog =3D bpf_patch_insn_data(env, env->prog->len - 1, patch, len, -1);
>
> [Severity: Medium]
> Is it intentional to pass -1 for the offset here?
>
> Since the original instruction is explicitly preserved in the patch buffe=
r
> in bpf_do_misc_fixups():
>
> 	*patch++ =3D env->prog->insnsi[insn_cnt - 1];
>
> Passing -1 to bpf_patch_insn_data() will cause the aux_data associated wi=
th
> that instruction to be lost.

True, but: unless I am missing some corner cases, eBPF programs end with BP=
F_EXIT,
so it is pointless to forward an original instruction offset. But for
the sake of separating concerns, I'll update this to pass 0 instead of
-1.

>> @@ -1743,7 +1765,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
>>  				*patch++ =3D BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
>>  			cnt =3D patch - insn_buf;
>> =20
>> -			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf,
>> +						       cnt, -1);
>
> [Severity: Medium]
> In this pointer arithmetic rewrite, the original ALU instruction is prese=
rved
> in the patch buffer (*patch++ =3D *insn).
>
> Should we calculate and pass its exact offset inside the patch buffer ins=
tead
> of passing -1, which discards its aux_data?

Ditto: having the exact instruction offset for this case is not useful
as it is not a load or store, but I'll still update the offset value (-1
-> cnt - 1)

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

