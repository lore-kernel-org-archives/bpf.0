Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B60194AE6
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004659; cv=none; b=StBjeDMAsEvXQ7Ls87v9oyQ1jAwq+el/wkYy+Qpgc7QRD4GTRgjdxY18b5mNg73CoBAnOHKDJdEOlq/QYWaAcviHHRyVgzklRkr5QqKWPB0HyGZPPhnm81SiTrsyl6dwB9AE9uLn8uy8UlGWI1i/5UlKOlvBcQQOlLN5Hxnmgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004659; c=relaxed/simple;
	bh=WlonSPQ2g716u2nSc0F9X3bgiefCnEaVc+eX1vcV/OI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r60HYaCfuBqL6Dz/TkdhIMu/V2vWIyUkf9K4qW41WJa2qbkBalBICY6OhCe/ZuOBuqc+FoscQfbNJzUiyvvx4tH9ft9PLzgzpbYgOILRet6lvSCkB1feO+cbxy6ENH3gydlu+OpQmbc7TLFdxgTvEgXFriXtb8mzveLYeJPNaKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgsIQwTV; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgsIQwTV"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso14774945e9.0
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779004656; x=1779609456; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G64BVp3q67RyijZWjKJBHXbSCK7MIF2ZOshnisNgmf0=;
        b=IgsIQwTVclVyjfuFycSjXlhkqF8ckMDaUCkA2KSJFZITSE4i5/WIyi++T/5kX6u0sE
         6Qc8LH42xazeOzMTUsn+fs4v/RUX90L/zYWRiHujLLV0ONq4aZi6KdzPgcYEtKQDisUR
         NKcXtFRNNZT5IJpRy//Zhi51uWwh5NbAaR449BIlAgMBrl4Q4PvLube1xInNL0L6zOX7
         73/DPJm7S4i4p76zy44asArwelhOFbLsvzxWaoEibCvP56NgGA02l2RU4BvmjKuPazX9
         kyVl8djcuHoLFP64bxYExuIpFP7y6AykrJP3XcWb+k7/HgLAoSi2EY4bDxBrRDydZbxM
         m3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779004656; x=1779609456;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G64BVp3q67RyijZWjKJBHXbSCK7MIF2ZOshnisNgmf0=;
        b=GbeWB9WLr5Tp8G8ArvF/eIHZCKfRG0bQykHS2pGz+2oZiWtpFR1Akvbgj1Kr9RehiY
         ahA/SKE8iz/q/Hy7N4LzkB+sDOiAChHRiMwXLsG3wDVDy9gy7QlJmFnvIEl9jC1G1uFQ
         43mCHG3Q7obTehF4QIhNGtW3ZDD5NUl4sBP/OE0MmygQ7gQmean77qKUpHzJo1RjCPda
         LuADh3MCMP6WIpQ6t+JellHm1QZmyzbKDDJ3BbST+1yDs7TWL+fyjK01t4mwtoBSgjjY
         YKgY10V2pKV4CYCZKKH0tMqTZRfRG+YcInhO6X03FfcFJykwIOFvVLybfwBQwkQQ2RUz
         +N5g==
X-Forwarded-Encrypted: i=1; AFNElJ9qIWIpjZt0Hm1HoFOiqKh/Y4bEc4n6gIsqbwJgubGvdVFjyT/2EwaoKzPcZb3eICrA0Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIsY0qgdxIx5DajQy/cWLnwpIZN1lZLPvpOxOdmksw47TAB9i
	2z4Q1R5TvEVZYC3LT1HaZfkTk34q+1hDZmXOvBb/e8CzGPvCxVHK1sPu
X-Gm-Gg: Acq92OFh3MpGt/IlflCP/rVPUjQgRQmgPvcRCFpmhbX4pl7cObgAfVHRYpadFgJz6cZ
	myHGolbNp7+GHcSwDIMfsmRE9I1x+O+JWoVWE7GU8fBKZAePqHzYK/oDF3W7P/sNgb8041cKeMu
	tIiLo8TDiYEPLqgiSgeBmgxh37wTel7h/DjC/4svM9PCvVD+QP7B28PPxoHwhhbgDy28hpwy+n4
	1VnRCT3he1RMxB3gXRJNf++LuBKLxVIT4PBGuRlO1KB2lVd0PJkDawUaRDRNXM0Wp4qrclqcQNu
	oAOOvGl3KeFa73ah/C1JvxvOfItegJQNyOlU9CxK9V/42iNWtvkd1Q5Z4gmRummhcxmK1TJ0d0l
	fuMFbnOqsCYCJLCLd0VZzwWUfnyWRjpZkmpKFUoxQZC6XHvv/gfWWK/YTbaI1SurIGal1O5HidT
	ypLh7Ld0amiIYNJG0PtLDwUkdKDsS2Md8auxtOpVzeaqZ2mgJj8aFmFwhU4hrtv/hBf3dWH7/rQ
	WbjuBtvNhcUGCJL9rTDZXfji+7cZBKxuhwQyZOO3R4yTWxWvnexJQkasAkku8WU1GmWmZo2HCDj
X-Received: by 2002:a05:600c:48a8:b0:48f:e230:d5ab with SMTP id 5b1f17b1804b1-48fe651e11cmr91890175e9.31.1779004655928;
        Sun, 17 May 2026 00:57:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab882sm180848485e9.13.2026.05.17.00.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 17 May 2026 09:57:34 +0200
Message-Id: <DIKSIO0A3O95.1L6CGZBD8YRRE@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>, "Martin KaFai Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 6/7] bpf,x86: Fix exception unwinding with
 outgoing stack arguments
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260515225035.821178-1-yonghong.song@linux.dev>
 <20260515225106.824804-1-yonghong.song@linux.dev>
 <DIKJM7FYGJ9K.2H5U2EPKDENME@gmail.com>
 <d023d1a7-73dd-46eb-b763-3b2004380a8a@linux.dev>
In-Reply-To: <d023d1a7-73dd-46eb-b763-3b2004380a8a@linux.dev>

On Sun May 17, 2026 at 6:55 AM CEST, Yonghong Song wrote:
>
>
> On 5/16/26 5:59 PM, Alexei Starovoitov wrote:
>> On Fri May 15, 2026 at 3:51 PM PDT, Yonghong Song wrote:
>>> When a main program with exception_boundary has outgoing stack
>>> arguments (e.g. from calling subprogs with >5 args), bpf_throw() fails
>>> to correctly restore callee-saved registers, causing a kernel crash.
>>>
>>> The x86 JIT allocates the outgoing stack arg area below the
>>> callee-saved registers via 'sub rsp, outgoing_rsp' in the prologue.
>>> When bpf_throw() unwinds, it captures the main program's sp (which
>>> includes this outgoing area) and passes it to the exception callback.
>>> The callback gets rsp and rbp, followed by pop_callee_regs, but rsp
>>> points into the outgoing arg area rather than the callee-saved
>>> registers, so the pops restore garbage values. Returning to the
>>> kernel with corrupted callee-saved registers causes a crash.
>>>
>>> Fix this by passing the main program's outgoing_rsp as the 4th
>>> argument to the exception callback. The callback adjusts rsp with
>>> 'add rsp, rcx' before popping callee-saved registers, correctly
>>> skipping the outgoing arg area. When outgoing_rsp is 0 (the common
>>> case), this is a no-op.
>>>
>>> Fixes: 324c3ca6eed6 ("bpf,x86: Implement JIT support for stack argument=
s")
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   arch/x86/net/bpf_jit_comp.c | 9 ++++++++-
>>>   include/linux/bpf.h         | 3 ++-
>>>   kernel/bpf/fixups.c         | 1 +
>>>   kernel/bpf/helpers.c        | 2 +-
>>>   4 files changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index ceefefb4da21..f4fdceedaad7 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>> @@ -557,10 +557,15 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32=
 stack_depth, bool ebpf_from_cb
>>>   			/* Keep the same instruction layout. */
>>>   			emit_nops(&prog, 3);     /* nop3 */
>>>   	}
>>> -	/* Exception callback receives FP as third parameter */
>>> +	/*
>>> +	 * Exception callback receives:
>>> +	 *   rsi =3D main program's SP, rdx =3D main program's FP,
>>> +	 *   rcx =3D main program's outgoing stack arg area size
>>> +	 */
>>>   	if (is_exception_cb) {
>>>   		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
>>>   		EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */
>>> +		EMIT3(0x48, 0x01, 0xCC); /* add rsp, rcx */
>> Maybe let's do it on C side like:
>> bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_adjust, ctx.bp, 0);
>
> This sounds better!
>
>> Avoids the need to use 'rcx'.
>>
>>>   		/* The main frame must have exception_boundary as true, so we
>>>   		 * first restore those callee-saved regs from stack, before
>>>   		 * reusing the stack frame.
>>> @@ -1789,6 +1794,8 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>>>   	 * Arg 6 goes into r9 register, not on stack.
>>>   	 */
>>>   	outgoing_rsp =3D out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8=
 : 0;
>>> +	if (bpf_prog->aux->exception_boundary)
>>> +		bpf_prog->aux->stack_arg_adjust =3D outgoing_rsp;
>>>   	emit_sub_rsp(&prog, outgoing_rsp);
>>>
>>>   	if (arena_vm_start)
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 242f9597d9ab..2a1616c769a9 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -1735,7 +1735,8 @@ struct bpf_prog_aux {
>>>   	int cgroup_atype; /* enum cgroup_bpf_attach_type */
>>>   	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
>>>   	char name[BPF_OBJ_NAME_LEN];
>>> -	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
>>> +	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64 stack_arg_adj=
ust, u64);
>> no need to change this.
>
> Indeed, with the above=C2=A0'ctx.sp + ctx.aux->stack_arg_adjust',
> the 4th argument does not need any change.
>
>>> +	u16 stack_arg_adjust;
>> this one is still needed, but maybe let's call it stack_arg_sp_adjust?
>
> Okay. Will use the stack_arg_sp_adjust.
>
>>
>> Looking at arch/arm64/net/bpf_jit_comp.c:590
>> it doesn't use SP, so should it fine.
>>
>> and arm64 seems to work already?
>
> I will take a look at arm64 as well.
>

Please also remove guards on tests to allow them to run on arm64, once it i=
s
handled properly.
