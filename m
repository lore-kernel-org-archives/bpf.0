Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792890731;
	b=MEpSODIWnBoulenXJRRAZL5h7GI2fI9ZsMeN8DN01PSjN3Ibozso1iB78Pq6hf0gMpUK
	 CPD0wHWpVVu6QLhdb0ePDJGOamnGEhO7cvCjmSnWJ6tBjPHmm04EMy2YUSidrbdUxXVDE
	 B4z4U4Lu3USFkz8N8sXNjENyYemKE/oDDwkB4fsEBEZgssQC9l3yT0dke/HPzHZWi/aEC
	 +HfdHwS7ngqihj8FqBbhK5vuia3+wbxBCmpsZ5UyqwJ+As+I9dH8ygURLJzM7eILVZeNn
	 TmPU8AjGlMLYTimVG36iGc0OvTC6Jg9y0ur3EQ0U0ebZzxT2Fo7lfw0GExUT0aOlJLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792890731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=JQp1/yEJUO+nFV/d8zf3vA+JnLRO6C01wwC42E0BIC8=;
	b=pXkz1QB/11nr54rI5cGmN29C0YnrHzyHOD/XTm0oX/fb+bzWkgNS8afygtRm+9oAuRVX
	 s6weFHEGCcHTyVHFqR4B0XkZcNWLTRvKOCT/w7PXiAuh8cnZGEHSUv83dwkcGg+suhARg
	 LIWKgiCL1X6R7Lshox+g6vVPL6T7kA3QJi2GfAWimmEtEwnq9QLht01QeJ83pAIqWQ4lB
	 HP/7u8bloCcDsGCQtv5e9mYqe/qC1Jyp5MgqxylFxt8StFQ1e2uFWaUdJdMJrgguFr6l2
	 sLxdckRX5o3RY2DWdC2e3UvOD3bzpQMi73mPc1z7PzLqeMAuJPLlggsCO8ksnrP7Acw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="VGEjkK/0";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7AC606A31D
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 01:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC7AC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VGEjkK/0
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso12252045ad.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 18:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792890730; x=1793495530; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JQp1/yEJUO+nFV/d8zf3vA+JnLRO6C01wwC42E0BIC8=;
        b=VGEjkK/0QJZMzIgfE/4xs00D7+feuZrEI9pKTYht1LO9lQXdYkJRbBA+rc5+3R+D3K
         S4L63spTRD1lcJ6FRV54dhJWvBEjLdW0KPIHXyl4S7G/ZWgiNP3KAKmLLkTgXW4BGh+o
         1fSlVqGiiFljiNTK11HjtDWRJ4BYgjH+Y85SOdLz0BgQPV2QM9+VTTn8xieALZ4Sf89a
         d65vCrx12Ux1P1QuMqyv9XQBqFHmeWrIkIKa6TsE6yRcc/GxbbGgsFQ+Ugt121AJfkUA
         cc13ID2vtXhwNGg2ZzOlQVzXOuPmG5R/d0PLoB4fCTYykfhyDW1t3WdWu/HwJ6p9tbto
         XRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792890730; x=1793495530;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JQp1/yEJUO+nFV/d8zf3vA+JnLRO6C01wwC42E0BIC8=;
        b=QnymDbwS2fTwP35gPPAIEjAeOZ0DQon9J7hWEZKkaO3xNNGrKbp+wnRyhFuIK/UBiM
         +V6AZaETjZ7kGAb2IAlntZhTZ1pg4/iF190gvCvDY2cHe1587YMHrSP95cXKTQVv8b7A
         COjQAAWDQYjIlMiQcFg+zg81dNCb/MWPdk9/QVyB704OgRyMnC14lqBCcL1SpJAdjswE
         3AU3l+OZbm65fkJgQ3vj2VDtDYF7mT9HdercIxq3M6K6ilRqcAQQOlBS9471KIsLbS5R
         ctZhIy1h4b6cIcjmOhi2DriDb4FBiEn0DojCg9KDjRsGsSLuMIoUNEUKCCLjRrOMLl+d
         MNKQ==
X-Gm-Message-State: AFq9FYIOxrzShBi0akmlkxNAYFJYudwDXyrp9yBlyFofPyOYIP283XUT
	Rp29aVHKc7GXdArTQIvSK2TpA7ZNguWCoe8QkCXujzhpnVo0pIrrUdOU
X-Gm-Gg: AYBFou3rZZSp7npbHMn1pe+w2U/Kzn/D/icOO1qmKb2X463TIvSM6kSogS1diQH6LJF
	Yfb7TevZ4ljwhEBqBPUEuri9+cydsPbW4qyeLRHNNIHl7GAI4muXJRr85Cdv8gYpsvZZW1cOD3+
	FwSyHilWeYAmsZ0u6DK4Ko4HUMKdfC2xX47/ea6XgvAl/F+ycLOcJZsX5PhZ9JAplVPs43ZRPCt
	ODX0BYeT3Map+QClsrr6D7kuNcR7fwDXDG9AA26eTecCQ9ZVcznUnd1trl67ssy9ETH5VfS4AOq
	+SLjrAAcYjg475Cii/b/wC/jhL3FwY2rJE5TR5zvKVrx2/z0rJjeJ+U8HHFD9yisSKEk4uffRY6
	P/zbBYtodsJJNRDZ7XMEJN8OWbt9Nf9DmjsdKExDL8lsr4Q5/qNN5aFKyRFp4EyIvPHmVsE4vNX
	UvEF6upy6zcKaTl1E1ERyLyBa4bs/15DsDPSnPG0h8qV+hPKFZfQdZP3DdkbXX3MqKyXdf/p8z1
	USxJkFeNAByoOkrovJIOKRrS6PDZ3KysErkWNTMSeAlW613yNIWgY8Ekjx/jbVR78zZK343ZGT8
	2HYlAH/arngeR8xeCujMfGTTTp69derxeKnFbMxZ21l6ZrTkZ2c8onSVt/sW
X-Received: by 2002:a17:90b:2891:b0:3ac:a7ee:6761 with SMTP id 98e67ed59e1d1-3adead4466fmr2879774a91.21.1792890729981;
        Sat, 24 Oct 2026 18:12:09 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebbb1a13sm3888643a91.2.2026.10.24.18.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 18:12:09 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 01:12:09 +0000
Message-Id: <DMDIPYF3NTY0.3SN2PAZ1PG9J2@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <co+eada64ce90ecebce@bugs.sh>, "Xiang Mei"
 <xmei5@asu.edu>
Subject: Re: [PATCH bpf v2 1/2] bpf: Validate stack arg reads against caller
 state
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261021080100.2663618-1-bestswngs@gmail.com>
In-Reply-To: <20261021080100.2663618-1-bestswngs@gmail.com>

On Wed Oct 21, 2026 at 8:00 AM UTC, Weiming Shi wrote:
> check_stack_arg_read() bounds a stack argument index with the callee's
> BTF-derived argument count, then uses the index in the caller's
> stack_arg_regs[] array. The array's actual logical length is recorded in
> caller->out_stack_arg_cnt, so the bound and indexed object can diverge.
>
> A crafted BPF_PROG_LOAD can use an argument mismatch to mark a static
> subprogram's BTF information unreliable. Later calls return from
> btf_check_subprog_call() before check_outgoing_stack_args(), while
> check_func_call() continues the static call on -EINVAL. The callee can
> then read a slot that the caller never allocated or initialized. The
> earlier commit 4286f5deee14 ("bpf: Validate outgoing stack args when
> btf_prepare_func_args fails") closed this hole for the first call, but
> not for later calls after the subprogram has been marked unreliable.
>
> Callbacks have a related problem. The verifier can make incoming stack
> arguments readable from outgoing slots at the helper call site. However,
> helpers and kfuncs invoke callbacks through an ABI that passes at most fi=
ve
> arguments, so the runtime callback receives no stack arguments. Async
> callback verification can also reach check_stack_arg_read() without a
> caller frame.
>
> On x86-64, KASAN reports the direct-call out-of-bounds copy as:
>
>   BUG: KASAN: slab-out-of-bounds in check_load_mem+0xb51/0xc60
>   Read of size 80 at addr ffff8881009af550 by task poc/131
>   Call Trace:
>    check_stack_arg_read at kernel/bpf/verifier.c:4234
>    (inlined by) check_load_mem at kernel/bpf/verifier.c:6645
>    do_check_common at kernel/bpf/verifier.c:19568
>    bpf_check at kernel/bpf/verifier.c:21318
>    bpf_prog_load at kernel/bpf/syscall.c:3134
>
> Reject callback subprograms with incoming stack arguments before their
> state is pushed. For direct calls, retrieve the slot with
> bpf_get_spilled_stack_arg(), which validates the index against the caller=
's
> out_stack_arg_cnt and rejects uninitialized slots before copying the
> register state.
>
> Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
> Reported-by: <co+eada64ce90ecebce@bugs.sh>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

looks good, but doesn't apply.
please rebase on top of bpf tree.

pw-bot: cr
