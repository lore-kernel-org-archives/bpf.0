Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4685474F
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498291; cv=none; b=aL3Gk7/rRkweLZEN0uI5tlIkRNxFlr+YXDCv2I3LahNyxfX/IgBxo/tKIYiueS/4gV1sIgHpGF8E4lHFj1X03QZ/qTEWt0magMAzRRIbAugv8ZyP7Z7VlQXzuK7MST040Kc5otO+kvUtjMFZxpkDqKcyLWiRHz42kSM8a4l4WF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498291; c=relaxed/simple;
	bh=+My9DTjOCuWyhF3CS8RgMFRbM0cHQ68Q7W+MomrR2dI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=fyFIMcjTUtVtKqHcsIp50mxUN5tvRMCXyoqGhRIeGO5+1h9H7ZWSwtZcBdRZVj8wDrJy5SI8hClvI2WJyjDUcOwrDFsS5qu/xyCxFB8QANU+ZpZkiiiGSYS6EtZI6UZ4g9uk9Z2YxrvS+508B22eVm0DOi2K2qzIfa73TyuGMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S7JyE9z0; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S7JyE9z0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 654F3C5CD5D
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:32:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F142A5FD43;
	Wed, 29 Apr 2026 21:31:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 076EF1072B383;
	Wed, 29 Apr 2026 23:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777498287; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lCWh6tcZi9k3OV9RSuqq38Tvxh/sTNtCBC/zukANFHM=;
	b=S7JyE9z0P7UerB5WFHq+rvcwzKIuIAcvzzH1TlWgzRp61FPF8OAr2I/0UnM0Qg+WRluGcC
	vhxlHfZYENDs+eT6XTme7hlhWaB7lOVp4H6mBPHhE/v5nDcOwDK0pIDXw1hsz/h1/Xmz8c
	9CY/7jHgNKBYWWdcAAyxqZsiIrsjAWAoTxNBDFPOzij/5EVGEGYn7G8/o1tDhHdM15hUV9
	4JoGt1EApZM2oBezHhcnUuYBuP2iNNiYmLaXMGwYGkreetROLgxvTYLYCIlc5FILtGxgei
	AuSpYKI355vYAVsSNyyzCwLgznw3l+0xgUb28RWGlRoJWdUR0vmicDZ9dFziDA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 23:31:26 +0200
Message-Id: <DI5YJZV8HWWA.2Y1YLSO42IH4D@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 4/8] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-4-1a5831230821@bootlin.com>
 <20260425054606.612E9C2BCB0@smtp.kernel.org>
In-Reply-To: <20260425054606.612E9C2BCB0@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sat Apr 25, 2026 at 7:46 AM CEST, sashiko-bot wrote:
> Sashiko AI review found 3 potential issue(s):
> - [High] Missing call depth accounting for Retbleed mitigations leads to =
call depth counter underflow.
> - [Medium] BPF_ST instructions are incorrectly classified as memory reads=
 instead of writes.
> - [Low] Flawed stack realignment logic wastes stack space.
> --

[...]

>> @@ -1301,6 +1305,95 @@ static void emit_store_stack_imm64(u8 **pprog, in=
t reg, int stack_off, u64 imm64
>>  	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
>>  }
>> =20
>> +static int emit_kasan_check(u8 **pprog, u32 addr_reg, struct bpf_insn *=
insn,
>> +			    u8 *ip, bool accesses_stack)
>> +{
>> +#ifdef CONFIG_BPF_JIT_KASAN
>> +	bool is_write =3D BPF_CLASS(insn->code) =3D=3D BPF_STX;
>
> Does this code incorrectly classify BPF_ST instructions as memory reads?
>
> The BPF instruction set includes the BPF_ST class for storing immediate
> values into memory. Because BPF_CLASS(insn->code) for BPF_ST evaluates to
> 0x02, the is_write condition evaluates to false. This causes the helper t=
o
> inject KASAN load checks instead of store checks, leading to inaccurate
> error reporting.

This helper is called in do_jit only for BPF_STX and BPF_LDX insns in the n=
ext
commit, so it will never wrongly classify wrongly a BPF_ST insn. But I
can add a comment, or even enforce a stricter check to make it
future-proof.

>> +	u32 bpf_size =3D BPF_SIZE(insn->code);
>> +	s32 off =3D insn->off;
>> +	u8 *prog =3D *pprog;
>> +	void *kasan_func;
>> +
>> +	if (accesses_stack)
>> +		return 0;
>> +
>> +	/* Derive KASAN check function from access type and size */
>> +	switch (bpf_size) {
>
> [ ... ]
>
>> +	/* Save r10 */
>> +	EMIT2(0x41, 0x52);
>> +	/* Save r11 */
>> +	EMIT2(0x41, 0x53);
>> +	/* We have pushed 72 bytes, realign stack to 16 bytes: sub rsp, 8 */
>> +	EMIT4(0x48, 0x83, 0xEC, 8);
>
> Is this stack realignment logic correct?
>
> The x86 BPF JIT prologue pushes a variable number of callee-saved registe=
rs
> and subtracts an 8-byte aligned stack_depth, meaning the stack pointer ca=
n
> be 8-byte misaligned prior to the check. If the stack is initially 8-byte
> misaligned, pushing 72 bytes and subtracting 8 preserves the 8-byte
> misalignment. Because the Linux kernel is compiled with 8-byte stack
> alignment, the sub rsp, 8 instruction seems unnecessary and wastes 8 byte=
s
> of stack space.

Hmmm, I have been assuming that stack was aligned when reaching the
emit_kasan_check, but indeed, as we could be anywhere in the prog, rsp
can already be misaligned. However, I understand for SytemV ABI, sec
3.2.2 that the stack must systematically be aligned on 16 bytes before
any function call. So I'll have to find a way to make this part a bit
smarter and add the alignment only if needed.

>> +
>> +	/* mov rdi, addr_reg */
>> +	EMIT_mov(BPF_REG_1, addr_reg);
>> +
>> +	/* add rdi, off (if offset is non-zero) */
>> +	if (off) {
>
> [ ... ]
>
>> +	/* Adjust ip to account for the instrumentation generated so far */
>> +	ip +=3D (prog - *pprog);
>> +	/* call kasan_func */
>> +	if (emit_call(&prog, kasan_func, ip))
>> +		return -ERANGE;
>
> Does this call need call depth accounting for Retbleed mitigations?
>
> When CONFIG_CALL_DEPTH_TRACKING is enabled, every call instruction execut=
ed
> in the kernel must be properly accounted for to increment the call depth
> counter. Other dynamically emitted calls in the BPF JIT explicitly emit
> this tracking via x86_call_depth_emit_accounting() prior to emitting the
> actual call.
>
> By omitting this accounting, the call to the KASAN function will not
> increment the call depth counter. When the KASAN function returns, its
> return thunk will decrement the counter, causing it to underflow. This
> causes the return thunks to assume the Return Stack Buffer is empty and
> trigger expensive RSB stuffing on subsequent returns.

I completely missed out this (and that's likely not the only one). I'll
take a look into it.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

