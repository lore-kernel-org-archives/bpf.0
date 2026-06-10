Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F374192EA
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106015; cv=none; b=f7UbUkpKFMorWgIN5Ax2dhB+mkLRTfRE1GVdo9mFUWhzljKsPz6pxySDCQ4T9jZLDbc2Lf5FAd1Y1wYNuW/djcEUKJtj5euq38WfQnWw3YDkfn8agiMLTyHm6ae3y8APxJDnwbGELgOZW8IYCizvq/CJLAZnUpn7jJ/Le70UqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106015; c=relaxed/simple;
	bh=SZo+09VJxPe0aRxDHQZ37YCIqZpsDi3j6Pm9Twc42yE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=fgRKsJ5Kx3Gx2S9zXO+hVUr0trUvIuJOZT4bjdfTfQELfJYTpsXeqpCiWuRcFbuzcsgLXMZMKaZBujJXz0/yJpzbQ2JtVbztpH4ku2isVCBVmR0nXaeJpl2fK5/YMNU+DBotgfwxFjzmQppsD6I/Kbx8eH/M/rpLycea6TT0TOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JkPoYF/G; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JkPoYF/G"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6AD331A383D;
	Wed, 10 Jun 2026 15:40:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F0155FFC9;
	Wed, 10 Jun 2026 15:40:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58747106B97E1;
	Wed, 10 Jun 2026 17:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781106010; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5duFWAYGS7rkhiNuj3l/wN6KVWVUG4NZ+MvKqmTsnpw=;
	b=JkPoYF/GLe+scz7jLExUUOGBmNQDG+GFoMQDpYarEdJu/5vDgmW9wsraL4eYZ+o9NvQvM3
	kvJYPSbbCwUJDspxGKdL6VQXZubtPGaBjBuywpEJrWc7RgDDyXuPXKMVOQUigOuWzpLLbf
	8jJLbM60gll9em2/jTlrHhyO6SKYpRNEXUO0MxsxyFiC2cpLMP4Rx3JgnA0l0IN8TMc1pB
	PWcCHWcpZjIKtdJcP+lbIwTj66J6SeLgXMKKG/GA0bYNTMHNAmTDrX7v5Dcr3UI2SI+Z94
	0mrpBlTFut7Jkz28M1KguonIsgrk8+ovGccPEq0HtKHJXMtexT9JO6Gi+EusRg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 17:40:09 +0200
Message-Id: <DJ5HDX2K5CTF.YRZ9TDI6QCII@bootlin.com>
Subject: Re: [PATCH bpf-next v2 3/8] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260604-kasan-v2-3-c066e627fda8@bootlin.com>
 <20260604205035.CF9C91F00893@smtp.kernel.org>
In-Reply-To: <20260604205035.CF9C91F00893@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jun 4, 2026 at 10:50 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] `emit_kasan_check` fails to save and restore the x86-64 call=
er-saved registers `%r10` and `%r11`, which are actively used by the BPF JI=
T as `BPF_REG_AX` and `AUX_REG`.
> --
>
> commit 77bd053eee8b8130b5fe38c11b29a99d8c12317a
> Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com=
>
>
> bpf, x86: add helper to emit kasan checks in x86 JITed programs
>
> This commit adds the emit_kasan_check() function to insert KASAN shadow
> memory checks before memory accesses in JIT-compiled BPF programs. It wor=
ks
> by saving caller-saved registers, computing the accessed address, invokin=
g
> the relevant KASAN function, and then restoring the registers.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index a0c541a441cfa..0981791014eb3 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>> @@ -1330,6 +1343,86 @@ static void emit_store_stack_imm64(u8 **pprog, in=
t reg, int stack_off, u64 imm64
>>  	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
>>  }
>> =20
>> +static int emit_kasan_check(u8 **pprog, u32 addr_reg, struct bpf_insn *=
insn,
>> +			    u8 *ip, bool is_write, bool accesses_stack_only)
>> +{
> [ ... ]
>> +	/* Save r8 */
>> +	EMIT2(0x41, 0x50);
>> +	/* Save r9 */
>> +	EMIT2(0x41, 0x51);
>> +
>
> [Severity: Critical]
> Does this code fail to save and restore %r10 and %r11?
>
> These registers are caller-saved in the x86-64 System V ABI, and the call=
ed
> C KASAN functions (like __asan_store8) are permitted to clobber them. In
> the BPF JIT, %r10 maps to BPF_REG_AX and %r11 maps to AUX_REG, which are
> actively used as temporary registers right before memory operations. If t=
hey
> are clobbered by the KASAN check, it could lead to corrupted operands or
> invalid memory accesses.

This point has been discussed a bit in the RFC: Alexei suggested to
get rid of it. In theory, r10 and r11 _should_ indeed be saved, as JIT
comp can indeed use BPF_REG_RAX and AUX_REG (eg: simple BPF_ATOMIC insn
with BPF_FETCH). But here, the list of called functions is pretty
limited (__asan_{load,store}{1,2,4,8}), and so we can try to optimize a
bit by skipping those. Those kernel asan functions, when checking on my
vmlinux file, do not touch r10 or r11:

  for i in 1 2 3 4
  do
          for j in load store
          do
                  objdump --disassemble=3D__asan_${j}${i} vmlinux|grep -e r=
10 -e r11
          done
  done

but here, it is just proving that those registers are not clobbered _in
the nominal asan path_ (ie not fault) and _in my kernel, with my
toolchain_. I think dropping those registers is worth, considering the
gain (two less push and two less pop per x86 load or store insn).

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

