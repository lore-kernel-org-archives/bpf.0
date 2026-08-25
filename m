Received: from mail-ej2-f11.google.com (mail-ej2-f11.google.com [74.125.228.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B122472AE
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787617581; cv=none; b=S153IGLbs73nO6sGP5Nvd6YIOBtu/EIIskRbmdCI00bgumHYq9Hqk4edu6Y4J8dBYROQDEyDtawO7aa5zBUrUODEwrzCh6hiYr1YKBR/BgmrbQGnKtBuZSjyGNVdAFffjG8hZ3BZAYP3OV1E9q1EBOkSmp0DQL4hs1+4BmXZu1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787617581; c=relaxed/simple;
	bh=RcK/jm1DBXe3uZ1HDvtAM829lcU4p2dQo7ZxD/YAhFA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OnVQP/A/wHkahXiajOxwblYAmh9WUw1nApAtSEagitsUNwox/Q8LE987aVSBiqz3pGQcOSN8OAS3XGvYoPTSOw+58LXg+atTJVutq2eFV2RtfGCnudMBPBGCMIOYrDT8K2sach+liFMWiFLEJEF16teu1t/KKkVGYRb08fkADQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMNuhVny; arc=none smtp.client-ip=74.125.228.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMNuhVny"
Received: by mail-ej2-f11.google.com with SMTP id a640c23a62f3a-c243d41dc07so214576666b.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 17:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787617577; x=1788222377; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1r5pGf7pB6Tz21mOnRGX4uuKNZKB56rhqyOYIJ+ZYnY=;
        b=QMNuhVnyEIK0/G7/hiyaYg022sE/YSUjYoy6TAQz9BtPvqnb/h/P7Bf/lwseFBossC
         GRxUlSZCcqTeNtvKteYIL0CGJ0ANJjluyh0qcA+nimHmmr0DuX6HVeci6uoty8kBCKSb
         d/0271DvJdsUf+LHe3hdjr3yPKNCRFcYxwK34UhwPfA7XZ5aKRnZMOTe03yc5QQEmFyZ
         mF+DP8wZRkj6eZBR0YhmzlBqFgclZnFKzs1wcjF2FYZnE9Sb3fCrxjGU7hHnJmxE7Tc1
         8QbFxvVVHpDluEX1yUUgH4M1KsiUBKEixY5h4h78UxtPp5ZUXmVxbHx1ziXzLu9ZbuvK
         kG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787617577; x=1788222377;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1r5pGf7pB6Tz21mOnRGX4uuKNZKB56rhqyOYIJ+ZYnY=;
        b=bq9ObYHXuoDKymtu44jQEtzEGgvNmlEMHIqdAq+M/3G1lAABYfr3GDQ//wap16GmnV
         6IvLpix9aHjXRUc92GV07PD0clWcHXf437loHm6LpUbfWZ5nEYYXa1fwgfVWQWS9wI7e
         l0cTDMwPmACJPOA2Cfg0SCC0XGGDnIL1M/MROpxdgTkLoWGXgebMId8BF5M9HJjHNfN9
         6Ze/X25Y5NyTEAra6oc8lpBmQBnxwVwZEgGpT0gmXRBeKLhl5itOaYXG1wKtfNaw7huC
         ePViTKLlv4ju8YpTd92D78rQ8nrW1z+84IZP/1sJp2oPgE+DSD5B15C9PSdZPFIZRxtv
         hsRQ==
X-Gm-Message-State: AFuF++mdgig8Wf9AsNli70BlHhYBR8wAwmD40QgY+ThatR404niJWx9e
	4hikcicupo5kS1HEy6G5Q8Km0GKOUlwMourLgZuCZhpuN2tvXF7GlqBk
X-Gm-Gg: AR+sD1093bW7kKN9bIKxDqsUVNkWDT9fkd37JbHDsEU0LUMTt4RLdZ8RQJDujY82sJQ
	VgWWEx/SP2Pcgo4eU6fKEbVpujQUv48Tj1GrY3AtnnfJgj1s9PosoBAigRjxhhIuEmDkrEwMhhN
	PDqRBHe5Oe02KD1Qth3Mu3RIp1nlVq/voHOuJRU2Qm2WYqHRKHcLDQ1qW8nZsXOoz6TYjpv73LX
	mvnWtBoZFec3uAhokINtII+N6HvRnoyfOi1hdA3Odcqe2V93KR66Jk2z7hY/hpZZMbigeVr5Wb5
	ghLqL8eb+WaznVxgsTziv2OKuqA81hQOiwxbqG5m7iK1N6qzhs+sNIpTaciczz27lrmuiiQAvNH
	HC3G0aGRXeD5jnU+A6DLOE3xzVdRH6iKNQd6q0F5c6RN0fW9K4kcTJOsnenP4XgnzSagAumoaw8
	xOwJLK3LgUIn3teSJPC4YznvrhOGQChvgU0IX5od9STKVWe28uYstJ4Dh16OsPT5I6GTYM9baj4
	QdZhIB3yW2r9iJE2fXviSNv/mRf41LA+e1pI1b5p3Y8GrAuqN2chlAtxTd/Swvbf7Y+8b9JFr+S
	s9yZZVNXG4x/ud8XZZ4Ff7cxA28=
X-Received: by 2002:a17:907:6090:b0:c12:695b:8876 with SMTP id a640c23a62f3a-c24e5c8b8ccmr220330666b.5.1787617576967;
        Mon, 24 Aug 2026 17:26:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b60asm1391447966b.9.2026.08.24.17.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 17:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 02:26:15 +0200
Message-Id: <DKXLJLAMA1KZ.14CXAXXD5S0WQ@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>
Subject: Re: [PATCH bpf-next v7 4/9] bpf, x86: emit KASAN checks in x86
 JITed programs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
 <20260822-kasan-v7-4-99afee6ef7fd@bootlin.com>
 <20260821233332.1D2201F00A3A@smtp.kernel.org>
 <DKWOG6YKM2NY.1FJHLE7BKZW9Y@gmail.com>
 <fa7cc4ad-6b8d-4bdf-8e2c-66d98ddef7df@linux.dev>
In-Reply-To: <fa7cc4ad-6b8d-4bdf-8e2c-66d98ddef7df@linux.dev>

On Tue Aug 25, 2026 at 2:12 AM CEST, Ihor Solodrai wrote:
> On 8/23/26 3:30 PM, Kumar Kartikeya Dwivedi wrote:
>> On Sat Aug 22, 2026 at 1:33 AM CEST, sashiko-bot wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
>>> - [High] `emit_kasan_check` fails to save the caller-saved register %r1=
0 (BPF_REG_AX), which corrupts BPF_REG_0 and memory pointers during atomic =
fetch operations.
>>> --
>>>
>>> --- Patch [4]: [PATCH bpf-next v7 4/9] bpf, x86: emit KASAN checks in x=
86 JITed programs ---
>>> commit 6bca50db6e9af9416363fe2e60f4e42f924950c9
>>> Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.c=
om>
>>>
>>> bpf, x86: emit KASAN checks in x86 JITed programs
>>>
>>> Insert KASAN shadow memory checks before memory load and store
>>> operations in JIT-compiled BPF programs. This helps detect memory safet=
y
>>> bugs such as use-after-free and out-of-bounds accesses at runtime.
>>>
>>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>>> index 13ba3232993ac..8134d028a2f2c 100644
>>>> --- a/arch/x86/net/bpf_jit_comp.c
>>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>>
>>> [ ... ]
>>>
>>>> @@ -1110,6 +1121,92 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg=
, bool is64)
>>>>  	*pprog =3D prog;
>>>>  }
>>>>
>>>> +static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
>>>> +			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
>>>> +			    bool is_write)
>>>> +{
>>>> +#ifdef CONFIG_BPF_JIT_KASAN
>>>> +	u32 bpf_size =3D BPF_SIZE(insn->code);
>>>> +	s32 off =3D insn->off;
>>>> +	u8 *prog =3D *pprog;
>>>> +	void *kasan_func;
>>>> +
>>>> +	if (!env)
>>>> +		return 0;
>>>> +
>>>> +	/* Derive KASAN check function from access type and size */
>>>> +	switch (bpf_size) {
>>>> +	case BPF_B:
>>>> +		kasan_func =3D is_write ? __asan_store1 : __asan_load1;
>>>> +		break;
>>>> +	case BPF_H:
>>>> +		kasan_func =3D is_write ? __asan_store2 : __asan_load2;
>>>> +		break;
>>>> +	case BPF_W:
>>>> +		kasan_func =3D is_write ? __asan_store4 : __asan_load4;
>>>> +		break;
>>>> +	case BPF_DW:
>>>> +		kasan_func =3D is_write ? __asan_store8 : __asan_load8;
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* Save rax */
>>>> +	EMIT1(0x50);
>>>> +	/* Save rcx */
>>>> +	EMIT1(0x51);
>>>> +	/* Save rdx */
>>>> +	EMIT1(0x52);
>>>> +	/* Save rsi */
>>>> +	EMIT1(0x56);
>>>> +	/* Save rdi */
>>>> +	EMIT1(0x57);
>>>> +	/* Save r8 */
>>>> +	EMIT2(0x41, 0x50);
>>>> +	/* Save r9 */
>>>> +	EMIT2(0x41, 0x51);
>>>> +	/*
>>>> +	 * SystemV ABI states that we should also save r10/r11, but in
>>>> +	 * practice those registers are _not_ used by the limited set of
>>>> +	 * kasan helpers we are calling here, so that's fine not to save tho=
se.
>>>> +	 */
>>>> +
>>>> +	/* mov rdi, addr_reg */
>>>
>>> [Severity: High]
>>> Is it safe to skip saving %r10 and %r11 here?
>>>
>>> In the x86 BPF JIT, %r10 is mapped to BPF_REG_AX. During atomic fetch
>>> operations, BPF_REG_0 is stashed into BPF_REG_AX before calling
>>> emit_kasan_check():
>>>
>>> arch/x86/net/bpf_jit_comp.c:do_jit() {
>>>     ...
>>>     /* Will need RAX as a CMPXCHG operand so save R0 */
>>>     emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
>>>     if (src_reg =3D=3D BPF_REG_0)
>>>         real_src_reg =3D BPF_REG_AX;
>>>     if (dst_reg =3D=3D BPF_REG_0)
>>>         real_dst_reg =3D BPF_REG_AX;
>>>
>>>     if (!bpf_atomic_is_load_store(insn)) {
>>>         if (!accesses_stack_only) {
>>>             err =3D emit_kasan_check(env, &prog, real_dst_reg, insn, ip=
, true);
>>>     ...
>>> }
>>>
>>> Since the KASAN helpers are standard C functions, they are permitted by=
 the
>>> System V AMD64 ABI to clobber caller-saved registers like %r10 (especia=
lly if
>>> kasan_report is called).
>>>
>>> If %r10 is clobbered, could this corrupt the stashed BPF_REG_0 and pote=
ntially
>>> cause a crash when real_dst_reg is used as a memory pointer in the subs=
equent
>>> emit_ldx() call?
>>>
>>> arch/x86/net/bpf_jit_comp.c:do_jit() {
>>>     ...
>>>     /* Load old value */
>>>     emit_ldx(&prog, BPF_SIZE(insn->code), BPF_REG_0, real_dst_reg, insn=
->off);
>>>     ...
>>>     /* Restore R0 after clobbering RAX */
>>>     emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
>>>     ...
>>> }
>>
>> This looks like a real bug, R10 is used for both atomics and constant bl=
inding.
>> We probably also should save R11.
>
>
> Hi Kumar, Alexis.
>
> This topic has a bit of history now [1][2].

From [1],

"I built the kernel with gcc 11.5, gcc 15.2 and clang 22 and
disassembled __asan_{load,store}{1,2,4,8}: none of them touch r10 or
r11. gcc goes up to r8, clang uses nothing above rdi."

Isn't this dependent on register pressure inside the function, i.e. dependi=
ng on
different code or whatever, it might begin using those registers?

> I don't quite like it, but IMO we should give in to the bots.
>
> Reasons to save r10 and r11:
> * SystemV ABI
> * bots wouldn't shut up about it (think of future llm bot reports!)
> * if our analysis of the kasan helpers is wrong about r10/r11 usage OR
>   if something changes (the helpers themselves, the compilers, build
>   flags, JIT's usage of r10/r11 etc.) - we'll get clobbered regs
>
> Reasons to *not* save r10 and r11:
> * we make the bpf prog a bit smaller and faster, the win is not very
>   clear but it's percentages, not a factor
>

Yeah, also, we're already saving a ton of other registers, I don't know whe=
ther
saving two would matter, even if it wasn't incorrect. I wouldn't worry too =
much
about KASAN performance, it's already orders of magnitude slower than norma=
l
kernel build.

> A counter-argument to clobbering is that a kasan bug here most likely
> means a bug in the verifier, so it doesn't matter if machine dies.
>
> A counter-argument to that would be: why deliberately increase the bug
> surface and let the machine die if we can easily prevent it?
>
> Pasting below a clobbering reproducer from my clanker.
>
> [1] https://lore.kernel.org/all/5f38c9a5-a8a3-4bed-bb8c-b7260a1c1a11@linu=
x.dev/
> [2] https://lore.kernel.org/all/CAADnVQ+c9h_wuNwj8pjx885oNErGY7bxxCwKi+Di=
J0XKSpyYfg@mail.gmail.com/
>
> [...]
