Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793036900;
	b=Hy4rpQNq8pzs2PO5vwvjhfQ0a8oixjn4nkPAyr9TYyfEjX0NC4GhEnu/aWIUxTyJQ4b2
	 FR8bJyEMnSGIBI/yWYeOrHvMCoNKwfzXUtXfz4CzMx9l/JEVMcRUjmvxBfOpJaJgNbKKq
	 48bO3xic9bFwmcAq9gWRF3ZTxWFaiQ+D39vXoevAtOWCHUpC8+6NRtuVyYA4FcHwtsLJU
	 30YWK5PVaUTlnn4obThLn4thwdK5lRJLYxDb1xI1UDEnIAkLFk9i4JZVUEonFd9UFWoF1
	 wHdoCtABYoidUCKeQowEKjSoiRH2Ykmn/Eopore5FN56g/ILVSJQG28m3a+V/dcSMUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=u8Me18as49kmZFUxGjK3FWSa7UQILM8WohnEj818+Jk=;
	b=zbDgc/y2YdNdoGcI1FYvJ/ZeK8UqweKyryuiuQIG2OmQhMAN0xTPgo9jETl/ID0sEdj3
	 b1EZIdcsCYqCEcBqdM6Kaj4RikMYxHiYqulBYM802qbc5J06SxJ9WjYdp+X83fQiCVPaZ
	 8K/zR1axDjsWECDesY5AmBvRqkAN1HpQpwWK8J6mh605oyDNq8jDi4QZ+QZwmQ9l1GwYB
	 L7FORVjO4bdIA9QQ6ZXzlhlLSO3Sf+s/kXjJ6tcHnx8auHwzr/GjBX1td+cPDnljUIWAx
	 URx8SunnbDXf1EqptStDW3dmjnrQnNKWhMO901S0SSqb9cvYsIZsFr1CVUnNFPdMa7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ey9IuHtQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.65
Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748D606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 17:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D748D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ey9IuHtQ
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-48e0c9fdb31so1296080f8f.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 10:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793036898; cv=none;
        d=google.com; s=arc-20260327;
        b=otBjcBT9fMWHdTB5jAEUCsMoFV66/9K1ySdVoosN31Fp5AnM2oMKz7NomZdiC5O6Bx
         z1GeN4N/V5w4PoWSRoVYc2MA8vqBZxVX5g8UNfAhfxEs9308AbSABBz3VmJ8lz+aepql
         EIpNxUoENyRqA8Ix4AHwq4NzS2gAe+ccynbj4TiPSP1CCVDATgZm3lnCKVzXBo4j/ZrV
         HXax/T2+Lwf/0HIpYQf5QzbsnosqzdA5BoceblNoCSPU4rDgr9C2SClHSSWM25ciXvWs
         ldC+t9J9k8Txh0K0wkntZ+TsXFSXt4Ro/ZvtMm//pYv74HQWqtjDGKNbpiuJEDJ5Jwi/
         e41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u8Me18as49kmZFUxGjK3FWSa7UQILM8WohnEj818+Jk=;
        fh=nK4o+E/nKAvNbzKwQovufHGBef//cfTPEviVumPIXzA=;
        b=rwdSwKWR0MDJsCh8iRPyI2RgNAnmADaZ0vof4idlsFc5QQA5jPD+5fKj31FEEH8w4j
         PSVtLDHOCOoL3JBOHe7kpbtoM7GXFugIEYsFmNOI8/1OHdlk0th6Xc20/eaJkLWhKdEU
         bluXXmw9e3NHBXlGJeOyM9u4ebZyINzdPBktmSYRb5/bHQgrpizjg+8fUhPsCT5hqJ+c
         SyyMoWkTbk2uce0ABJTGvUXOj9gF8z3biT3CrDNMECt8UFhbE3ZnWRWqyeGkhocswi5b
         oNvaCEbwM0hzyXIeJg4TYC2nhfNLtArSFE6xbiN1+AjzMRkomj74AQ69nMImEepOSlpC
         Lvhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793036898; x=1793641698; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u8Me18as49kmZFUxGjK3FWSa7UQILM8WohnEj818+Jk=;
        b=ey9IuHtQ33O4BociJ/sNogTkBC8Z8Ca+GRq6kLrCaAdHk0jN066XoKVMHdXq21fRPI
         WhgYz6aR59n6KLepIhlwMXceoqMEOE2cmixG3KVYmUWQgAtz/YLyHEMB4k9NM3k6W/4H
         KQSqJwlNJvdZbwmVCxnbA9iodSEu8LRfsRxLe5oMIVvQlqfkvkmkNaZWvET02ufKE/kY
         NveKFwGyV7IUH567MK1tEsKHgI4JhLFojuPKoz8Ca0rG0C0+eYio5MUNGCilwn2to+Fc
         VmFquO9NdMqFoy4ySTWgfPvRku+hmetdAwyfxffPW6lL8gGe/cvEw/sbnHf68X0YLHoj
         CViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036898; x=1793641698;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u8Me18as49kmZFUxGjK3FWSa7UQILM8WohnEj818+Jk=;
        b=TsTUBXbQ7qB9qs6Yi/1NwTgVGTh2rMTJcjzd8M8NET2LYR5erwb8O4cjXVwq2r1ebS
         EobXQ0IAkxumJKGV7PLrL2ZsuEvgbQ64RGwGXDpoWkpAA+ZYTh/CAalq1Qa94/EqLyYC
         NgTkBoHwJuDFo9YGr9MXrGk8lBZS3QsX2qjElYggb+UVXtX/6SwmKCfo+QZicSyvYLqd
         EeVfgeh7WzwKyKys5wknzsph01bqvwHVBvfeGrt5ngpBtcQWsKqpOx+WqjzyUiyZP6UK
         qD1ZiVWw7fWdSp6vXdnB03C44kTm1Z6Uhuh8VKbDpJOsu6WDxoEQ2hvURqzH0tdxWMMQ
         zbrA==
X-Gm-Message-State: AFq9FYIXnXMeB/WdW2WUNMMJ9o/hTreYfJkFqtzkuifHS3vNbqWbmEVQ
	AKr/WsHZig1bemCL7+hj11e+cviAjFbqguwdT0ari32I3zC6KxaVmFDMRKWNmLi4bw/J2ZgF1mz
	oECbGrTUf7gAJX+/qkRKLF0plBT6P9DJ32bJU
X-Gm-Gg: AYBFou1uBN4GdLW+CZZCQHFSqHTfFSg5/MWVDJoQ89rnm/I7wINtKiXvwtb6he/Z5IZ
	VFl6t8pghkcHdyRJnD/d6hsUg5cwGS1/tTvfGfQ+93qJ/+X18C+DbbbVGZB+fkQOl2PJVdQ8haN
	a8T2k7gZN3zt4K1U6eGRF2m9dPA/ngXllNRyE/0LhF00m0rSKFVCZliRcOaOJMxgRQjCvpmMB6T
	ky1XiA0EMurw3siTymLW7HGJfCyH0M89hRDzaA7apHOeV81oDwj6yRqm8JshAPYu8izWFO1lnNy
	LxWR+m2mxWsEcy6Tf4hp/VvQ8YGMmFUcVjGi7RKkmdXjJ8J8A+7TPSJybeYB55lV+5zQFX89F7W
	pQZAy73K5W0vFGW+hf4foOFcgSoeE5x9QFIB113+w9hHry/f5NIlYjSmE4qUYrhxlVBTA3bUZpA
	b5CKAxQsGDMNE4sddvc8UVXVhpAj9WAOxN0KYS0tBcrbYBv6f2n1ubJwQ3ZeZ2dK1YVq0viOqm9
	Q9MzKzppIS459lG
X-Received: by 2002:a5d:5e0a:0:b0:48e:44fa:251b with SMTP id
 ffacd0b85a97d-48e44fa2675mr11138272f8f.47.1793036898025; Mon, 26 Oct 2026
 10:48:18 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <20261026025943.404450-27-alexei.starovoitov@gmail.com>
In-Reply-To: <20261026025943.404450-27-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 26 Oct 2026 18:47:40 +0100
X-Gm-Features: AclHuK_Sw76X7e5WvWFhqzfFiCVQKkSgE0ydCVKbh-8lBxYOAb_b6XUxzHPEcCE
Message-ID: <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 04:02, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> In Rust &local, &heap and &static are the same type of pointer, and the
> same insn dereferences all of them. The heap and the statics of a Rust prog
> are in arena. Thus a local variable whose address is taken must be in arena
> too. Spills and all other local variables stay in the r10 stack.
>
> Add a second stack, in arena. r12 (BPF_REG_ARENA_SP) is its stack pointer.
> The stack grows up, and r12 points to the end of the frame of the current
> function:
>
>   f:
>     r12 += 32                  ; the frame of f, 32 bytes in arena
>     *(u64 *)(r12 - 8) = r1     ; a local variable
>     r1 = r12
>     r1 += -8                   ; its address, a number (scalar)
>     call g                     ; g accesses the variable through r1
>     exit                       ; the verifier adds 'r12 += -32' here
>
> The verifier tracks neither r12 nor the content of this stack. It does not
> track the rest of arena either. r12 holds the low 32 bits of the address,
> and the JIT adds the base of the arena. Thus an access through r12 stays in
> arena. But the code at the exit of the prog needs r12 to find the stack
> that it must give back. Thus accept r12 in 4 insns only:
>
>   r12 += N                           first insn of a function, N % 16 == 0
>   rX = r12                           number (scalar): user space address
>   rX = *(size *)(r12 - off)          off is not checked against N
>   *(size *)(r12 - off) = rX or imm
>
> Only the compiler knows N, the size of the frame. The verifier cannot
> calculate it, because callees access the frame through numbers. The frames
> of a call chain have 32 Kbyte at most.
>
> Each run takes a stack, see "bpf: Add stacks for programs to arena". The
> verifier adds this code to the main prog. busy, size and base are per-cpu:
>
>   entry                                  before each exit
>
>   old = busy++                           if (r12 & BPF_ARENA_STACK_SLOW)
>   if (old == 0 && size is sufficient)            bpf_arena_stack_put()
>           r12 = base                     else
>   else                                           busy = 0
>           r12 = bpf_arena_stack_get()
>           no memory: return 0
>
> The usual path has 8 insns at the entry and 4 insns at the exit. The kernel
> does not pass r12 to a callback. Thus a callback that uses r12 gets the
> same code and takes a stack too.
>
> Progs without r12 get the same code. A prog that uses r12 in one of its
> functions pays in each run: up to 22 more x86 insns, no call, no lock
> prefix. The cost on x86-64 (Zen 5), in nsec more than the same prog with
> r10:
>
>   each run, hot caches                               0.23 to 2.12
>   each run, cold caches and TLB                      73
>   each run that finds the per-cpu stack taken        8.45
>   iteration of bpf_loop(), the callback uses r12     17.5 (1.13 -> 18.6)
>   call of a function with a frame, load, store       below 0.23
>
> A callback of bpf_loop() always finds the per-cpu stack taken, because the
> main prog has it. The verifier also does not inline such a loop.
>
> Limitations:
>  - The JIT must report bpf_jit_supports_arena_stack(). No JIT does in this
>    patch.
>  - The verifier rejects tail calls, because the prog would not give the
>    stack back.
>  - It rejects extension progs. The code at the entry uses r2-r5, and an
>    extension prog has arguments there.
>  - It rejects a jump to 'r12 += N', because the insn would run again.
>  - It rejects a direct call of a callback that takes a stack, because the
>    caller would get the r12 of the callee.
>  - Nothing can attach to a subprog, because trampolines do not keep r12.
>  - The private stack is off, because the x86 JIT has one register for the
>    two.
>  - bpf_throw() does not give the stack back. The stack stays taken until
>    the arena is freed, for all progs of the arena on that cpu. After 17
>    throws on a cpu each run there allocates a stack.
>
> The test "invalid src register in LDX" of test_verifier used r12. Use r13.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Some initial questions without reading the code:
How will this split stack model work with trusted objects whose
pointers on the stack are taken and passed around (dynptrs, iterators,
etc.)?
Also, will this lead to miscompiled cases where ptr to ptr to trusted is
passed to supbprog as r12 relative access? (As a way for the callee to
fill a trusted pointer for the caller, etc.)?
