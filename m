Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793036141;
	b=hSzZbtprABcKl24mgyBxi1/oQIxpEYGMN0NCgcBhQDopW2+VX8dHpRGK42g/ntf30g9G
	 nrCN1oE3KRmPEjxeSV7nV0y1khSyRgYna/f0FAimK5uIpfeoQ/zve2qIXVV1jzzIPdLT5
	 mnmDTRlPt2+dMqyiI59ilx7TBQz0H9Gyp6yp+9G/OobTEKTRBFS8iEDSjlJh+/2iw56H3
	 ETo3QqXZ312mRddWM4srXKsN23kYRCivE4Eh4bxvRTxQE3sLlae506IRo4IXDBh7X5l/W
	 LEZEW/46ZeOcC7pQpu+Rh7W1lGTcAEMK2r9d+AZoRXp26Pb4iETZuqCjDcviP8rebQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=tLgfmSdv0p6cBpkZmUSgL9B1WtHPSZQAUFmd/cXcMqo=;
	b=rhn7YwDH83FuIEuuErjM3k6xAZDpSd1WgH1kKvW2uvpxu9wYRQdt7LkGtHmC27aCPqds
	 vJvyeemIZgV6I7K+HXqVfYUHnAxQrDtIVHX8wDMlzzLUU+jmtA8qsRGUuyQJJPQT7PhmL
	 QyOrTQKpMEU7NiprmXliwGTM1scvJxdV3hQaCY5vLIK5TynsBE7Mys9olISYxMdVkcIsu
	 W2bLCH8aPUYn8a9w7+hcHp1ZaV3je9FqtdgebE//H0aCIxq6ExyoIT6D9FEZwkao7yQcM
	 DJ2u8nzJfNDJ6crr9sAF/id11Gn3bwZsLbV0iIClgJZkI9u5qHbKJNZZ5lt225tCKuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qZUJwTf2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.65
Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F1606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 17:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C9F1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qZUJwTf2
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-48e0c9fdb31so1292504f8f.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 10:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793036139; cv=none;
        d=google.com; s=arc-20260327;
        b=ULe9GoevwrxX1hOzMNk1Zacgn3d5Po+WbhXuVBjJguEUbO4D8m6HoFG9FnxCfDomD8
         jvdI8lKMm7KAYvdDqmW4/PoPJt8tPqdLgfRcGv1n2HjbIppCZKPUkDkC3Q7pYN/eG2SE
         8JrkfVG3Ier2V0zlHRMv59NqmEaRUu8I0AJzOXKbucTmr3Sh4hJ/URTFHnDWAeO/gsVf
         B6hX0ANtIHwkDr2oxx7Xn3qb4o0W5V6U8Vyh3/iM9MPiwPEJuA1VNABDr+IQ59OVw/I6
         j9B92XplKhtYs6/CYXKTeVrHFQGGvdBD5mLlzdkdAp9pbmd2B9YX0b1zYOkVcE6w/1hL
         y1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tLgfmSdv0p6cBpkZmUSgL9B1WtHPSZQAUFmd/cXcMqo=;
        fh=nK4o+E/nKAvNbzKwQovufHGBef//cfTPEviVumPIXzA=;
        b=Sd92YZQJ1Ad/IW2TcJTybzZXRtN58+zCVRZHGud3G256RUj2o0z8q5cu1+01dMiGd4
         9jaKGGskR1kB3maR4UBgM8op4lJLIy1pdlFxHwLPitirmWMuY1JdJK7DiC7+edUbziTZ
         wDhW6Dc+Ge7wwjVNjyQr+G/JDuaGZIczsP+m8ktkkcmGfP8RSeyfTs4MX1/hvCvljkAl
         9ZJ8EfK7T/fgw/QgePweyxKig6so/TUxVwNAjBKfhZ2iq+fIHh9EFshJP2z9NXFx2Cve
         KRCd7/KqjHvBc5kFVBu7jYPvYk4dCH7aanyHn8ngBcSI9yns+8HJ3RlVBJEJiwsjLRke
         1mjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793036139; x=1793640939; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLgfmSdv0p6cBpkZmUSgL9B1WtHPSZQAUFmd/cXcMqo=;
        b=qZUJwTf2vgto2ne2MRI9jHYL30Wx6Xq5w1hlaZ3ZDRPUQR6Xx7/qhtADSCouZCyJUj
         75SCItcdwQdEH3dMQMTyqKRf9J439BwWyTSevxkbUz2loJMAx/H4r38+vN30yov1r9Qp
         UcMPwhFgIrwPCPlwI4h57TirVtI1McSocFMkIwdAmGlCJcFj2IUBlju/fpRNivPAQPRZ
         DQGSeRoV5lBFX0YyvRIfa4/K3jSjdJFeCjYKg6uVIf9jpiFXWVInS0CZ8RSsOQckFseC
         Mrhc0JN13SkawX5UCsettmvqN+QzNF6B1SZzoJcp/cdHgw/P6vQF8ypkyKM4n0Uyq0/P
         gEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036139; x=1793640939;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tLgfmSdv0p6cBpkZmUSgL9B1WtHPSZQAUFmd/cXcMqo=;
        b=MaGm0riMPfqJiLgD01U7n43TiSKV4l0lxS+hiKCwLavFX9P/EkyfNL5QoXVKY5RiWp
         PJ9m5nX32Df9hn6b/tsL5xLCg5BEUJv05VmA7SeK26/z+/7PfIkhUbLTMvQRdmFlySr7
         a+u1PDyr9evze2pxzB7IXoDyk39xZu6atSkfzuSEcHz4UUTvdYNZPIDpVoukg65ejBMH
         4exfL3alxuST1GGGqJbfwqrj7AyABdaetd2SpwASMOUoZGx2rEwrehqTCwAfiD5lmJZt
         ppfr+02ABG4TuuqSQTbwAg5Uip5kdxn1BZU5HdmxlMtFyHxu+Kg9/DtFWbzZfgcZkkDA
         KrtQ==
X-Gm-Message-State: AFq9FYJ8E5LJ/IpqX54gUhmZangSxIUCi8rZ2iekgH9nKXEj0gYttqGq
	clJ3Hhpi+i5sMCOFvZUO7ZM/m/TmoTfu6aJP1xzCFbA1PNDJDwujmEXGE7hiZiTCYv+SYzC3GGC
	KBHx7qGVP0BxlBjKSVQLCbA2yLIZhaAEZekLP
X-Gm-Gg: AYBFou0an127QtHcegyl3+PMCOYmIzxvighFcykpx56EyziFTFVQjlcmnKik56qWoeA
	OfBN97Qjoc7lEUE+20U/JNTKk/MKXPCl2oGB3ounKHU3mEXwfU+LJHK++KzHui1SrIAwYex2y8M
	pc6BNCAljrAg4GmdMXS4l4EcnIQ3VzBTf3bcQezH8CtesrdRuoLCuJtS2yrEeKAFbfmQ1SNBz0i
	8bhUcNlgL0FfZddgV5ywM4b0avUPBsaAbIjS18oOb/djhLOFCs1m/PzCBR5Z+uEpiUx/MWW8eAQ
	YdAGfuaP2f+6ZF3SrJl66itlqdy0vV4TJGpkSa6TSgUJ5AkZMwMKRl/DSpcdfzT4VMT4FAoSaoH
	kvqBl5iNJ5IFjMzHvI9FCTwR4pL9RjNMBJ8bddWir1JR8BjbcpF4ntGVw3wUU7tNOyWgBvt/wQS
	eo3CybpR5csvR1U02owwRodryrhjWakiBAWOr9zki+6OVt2TV5e5KyQcHx9yG7DItR7YlC6C/my
	mL0ap/ipzQD4pEuaIf67pWr/TUx8CJQE5Anmw==
X-Received: by 2002:a05:6000:27c9:10b0:48e:1299:663f with SMTP id
 ffacd0b85a97d-48e3ebbc92bmr10115995f8f.56.1793036139114; Mon, 26 Oct 2026
 10:35:39 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <20261026025943.404450-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20261026025943.404450-8-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 26 Oct 2026 18:35:02 +0100
X-Gm-Features: AclHuK9cLHIC5ydrOB7Tp_taVgTXB2F0ScoiHbmX8uAl5BPQ12HQ6bMLgcrkTDY
Message-ID: <CAP01T76T5qLDHd8jMx69_+hcj2vCZt+W6+UsGGqdaRJ0BpwTHA@mail.gmail.com>
Subject: Re: [PATCH bpf 07/81] bpf: One time slice of may_goto for a run of a prog
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 04:00, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> may_goto stops a loop that the verifier cannot bound: after 250 ms the loop
> must exit. The count and the timestamp are in the stack frame of the
> function that contains the loop. Thus the limit applies to one call of a
> subprog, not to one run of the prog. Loops that nest across calls multiply
> the limit.
>
>   main:                 sub:
>   1: call sub           1: may_goto 2f
>      may_goto 2f           goto 1b
>      goto 1b            2: r0 = 0
>   2: r0 = 1                exit
>      exit
>
>   main  | sub: 250 ms | sub: 250 ms | ... | sub: 250 ms |
>         1             2                   65535         ^
>                                    main reads the clock here
>
> Each call of sub spins for 250 ms. main reads the clock one time in
> 65535 iterations. Thus the prog runs for 65535 * 250 ms: 9 insns cause a
> soft lockup. bpf_loop(1 << 23, cb) with such a loop in cb has the same
> result.
>
> The count has the same problem. A subprog that makes fewer than
> 65535 iterations in each call never reads the clock. An endless loop that
> calls a subprog with 60000 iterations runs for 3.5 sec. Three levels of
> such loops lock up a cpu.
>
> Give one time slice and one count to the full run. A run is one call of the
> main prog, or of an async callback, by the kernel, together with all the
> subprogs that it calls. The main prog gets a per-cpu budget.
>
>   the kernel calls the prog  budget.start = 0
>             |                budget.count = 65535
>             v
>   entry of a subprog         frame.count = budget.count
>             |
>             v
>   may_goto                   frame.count -= 1
>             |                At 0, read the clock:
>             |                 < 250 ms   refill frame.count, budget.count
>             |                >= 250 ms   budget.count = 0, exit the loop
>             v
>   exit of the subprog        budget.count = min(budget.count, frame.count)
>
> Iterations now add up across calls. After 250 ms the budget is empty:
>  - A subprog that starts after this time exits its loops immediately.
>  - A frame that is already on the stack exits its loop when it reads the
>    clock again.
>
> The progs above return after 250 ms.
>
> Only JITed progs that have may_goto in a subprog or in a callback get
> different code: 0 of 144 progs of Cilium, 53 of 495 progs of scx. The cost
> on x86-64 (Zen 5) with hot caches, in nsec:
>
>   entry of the main prog, once per run    4 insns, 34 bytes   +0.52
>   entry of a subprog with may_goto        3 insns, 19 bytes   +0.03
>   each exit of such a subprog             6 insns, 36 bytes   +0.15
>   async callback (bpf_timer), all progs   reset the budget    +0.35 on 34.6
>   read of the clock, once in 65535        stack walk to find  26 -> 179
>   iterations, all progs                   the budget
>
> An iteration has no added cost. A run with one call of such a subprog costs
> +0.97 nsec. It costs +90 nsec when the budget is not in the cache.
>
> Limitations:
>  - A second run of the same prog on the same cpu, in an interrupt or after
>    preemption, starts the time slice again. The timestamp in the frame
>    continues to limit each frame to 250 ms.
>  - The JIT must support a stack walk and per-cpu insns. x86-64 with ORC,
>    arm64 and powerpc64 do. Nothing changes on riscv, loongarch and s390.
>  - Nothing changes for extension progs. They cannot find the start of a
>    run.
>
> Fixes: e723608bf428 ("bpf: Add verifier support for timed may_goto")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Why not copy the state from the caller's frame into the callee iff it
uses may_goto? At least it will work correctly without various holes
listed here in the limitations.
