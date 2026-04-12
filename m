Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4A23EAB2
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776032653; cv=pass; b=hfDfVnbozOZO6m64u5K4Q/Nj+OpugVVY2eE9QQFcivSEyn0Rjfn+Evr/fqtlfrxgUnL75+1lQ/GMSKT+wGJz3eoOe7Toj4taDRWbrVbWpjzLIpWHw9a/LAx+q7FppGazd/+2ZaD+t2BpKi44gurFCaECDVHq6zh5XM91mka5EXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776032653; c=relaxed/simple;
	bh=rpqsnzQGIWEGCzp6bs8odggUd6yaG6L14Jokn1Z8z3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KehOn3b70wdgxnEC0SGzW1HoCNMqaTKYf5fiKZBJ1UU5ACj8z9cCyN5c/r5WrRxA9IDJUZYELN6vO+piWsDXwbqnJNm4Zgj7YZG1QYft7W/V4haSmGZWa7nikTs5WGJEql5lftc441cdOtJ/CYrjV5F4fom8F9HJrmcF5WAGUkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtZxJyeW; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtZxJyeW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso34214845e9.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 15:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776032650; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+GJ6Cr2kcDBZxcAZO8Jch5k2Gh4nFurCxZPtR6HcqqT8g4ZXgRcE1tiG+h9e8uBnQ
         S+ithvUCy8YrqK13z2WGCDQ+eYisQ/gfNaD9Pq9SnhINPPNK4cIo7celJ5mWUk4tKJIl
         Y3WONemvsPHtU/7TvVwFdg1Kp+tc1TxfUfuMHIgJcx4UTOn70Srmtk7JXknRlUM5xe5C
         s659O444npgLiyi042WKS1ISAx/yJabZLttAjwN1regaXqwKOxk9pJHeNf1ePURJS1DC
         BkYS6vl3M7V8iY9LFARfID7kTDn4Y+gFgjHCpalB9tl2iq0U1bQSx24bs04BfpZUZ59r
         FHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mF7IBiGst6fyQ0/QVkUWhr+I7m5Kkx49G//lZpHGhsQ=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=L2j060B0OXorjNE4B9vtRmaqv2PqM3m6gTDiirC6BXyF9oXSeVAxdJMRweFLvz8xMC
         XlBsskizrXIbGqvR7hWZewlEfFAj4f34WvsLyTLUbfVm/3K+ORrnNOXPw7FTaJhqua6u
         NyMRD6FgWqOWJiHrR5QZcsJiUjjfRoQY1CvLYOqmRkjWXs3E3UmYV1gVOhgl9ksuBNQ3
         u2xCb6yrXwSbUiIvA5M3CBSb0T2izIzWwruyZ/yGKqhpaV4ZssR4KlYa/0QsET2V/Y5n
         5W39pQgtCmgGA2bD7fWcBE4n+Esw14p2P1snKcLbhjs4LnrSu+mEWCxRvDysGT1w2BiA
         Tptw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776032650; x=1776637450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF7IBiGst6fyQ0/QVkUWhr+I7m5Kkx49G//lZpHGhsQ=;
        b=UtZxJyeWfqePRP0wk8DjJRwsLk2P2UZssRnYUsrI/rrwTWylDfUEK7xBGf0qtlrRbk
         PFnI2iMuNMDiwSCOaBmcHdHGZBEX0s3JhzccrVKGAA5UK0Bmjxjr74UX7SOcF0xYXEnY
         bk963YCS4cim+siX+64tqGGC0/xj1Yke11xnjSKxI71tAHJkiIwk0joBzlOrN9J+gw3C
         BLWJfhE2jiU5FbptSFZbu26CzF92zx2I9Xo0vHoHp/k6HL7XsOHLCA3UTzYDt5KbnFLG
         +4/VV3u1GemN7mUsJDrAY4AgSjupMsaOBEn/tlnAVnsSId1SaWprVyJLQWLKUonrvgXO
         BGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776032650; x=1776637450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mF7IBiGst6fyQ0/QVkUWhr+I7m5Kkx49G//lZpHGhsQ=;
        b=sbxlrHXl3GlTa+hrRBOys3KUWkNMc8jZH44qBriIgf2MfUdVK3XnSla6JHfvURBOwG
         uxPG8/lcyyfgQPH9xGgvcjgs373g/XGtaRTYbr2jNbGDEf8se/cKQ+gR/jEuD+EpVoYJ
         TkLr7brkcycLG8X7uJEahgl5J5tXlNaYhUqA7s+hOZNN0LvRcq+GtJu1wCN0aS07bYja
         KCA8iGDgMrw5UGtoPw61SmQqv08jClYRrfbKWk+4h/opqvptfes2XHQja8dMTQ8sm73/
         io0GMaRUoZy/Go2SKQ3eeu76ifvcTKaU7jW8j0uPC1d92Z4ImpBcWTFxXk4GKVU/omR0
         IlDw==
X-Gm-Message-State: AOJu0Yx8UOitJP6bOy1z3FpuaWyFowaGoqxpnW6le/WE6vquDH5yCx3Q
	qO79JZARHE3fYV0FMyyEGn+2CaThe1l57r5FTw4Lx1aj0MjqvqN2yiDtICDYPPvrYgmcJN5cf0m
	IOKnfVz7dayjh+JstIyjjjZUy6+zevjgBQA==
X-Gm-Gg: AeBDieuH2r69VdulZN4fVJZJvQLvKPwLWJINpWiccAAtj0U9qF7d5qFyX2xLTcaYKd7
	VZCTUMVOJQStVONzEldGUrhN2mLMLgFWbgDbSlTEAlMwMhvdeIinQcXnFh8rReLExMmcvOHq47e
	2T6s+v7c8eG4dTxH/RP29TTUj/J0+cO341EwlsrhrxnVe0OnOcvkIV1u0CzXpyM2NSKLXHEEH/w
	eaozmfwLc/jPoksFr0v+BGBwv85ft7SZx6Ws8Y4ToEf0vJ7YudIXn5rqOQyP/YMWDqzVkM/lLtj
	y4lqGBd0gIQp0yM90REP1aTQX+ri6qKOW29c4g9MLT9mRExOqmx9kjrI71pIxC7spUXUJw/Zd02
	66Mx8H8EYvVP07Hnd4kPl+2TuMQ==
X-Received: by 2002:a05:600c:c0c9:b0:487:1826:d89b with SMTP id
 5b1f17b1804b1-488d67e262cmr99436905e9.9.1776032649866; Sun, 12 Apr 2026
 15:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412045826.254200-1-yonghong.song@linux.dev> <20260412045955.257613-1-yonghong.song@linux.dev>
In-Reply-To: <20260412045955.257613-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 15:23:58 -0700
X-Gm-Features: AQROBzDqY6DCHnXiCwfYmfdg989abbR9zuk69GbF5WpTCGd3YQzx1EnFusdKEaE
Message-ID: <CAADnVQLPruMzAt+jFMhwS_OHyMcqoviHDAPSKAYK8VW1k1FBKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 09/18] bpf: Support stack arguments for bpf functions
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 10:00=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> Currently BPF functions (subprogs) are limited to 5 register arguments.
> With [1], the compiler can emit code that passes additional arguments
> via a dedicated stack area through bpf register
> BPF_REG_STACK_ARG_BASE (r12), introduced in the previous patch.
>
> The compiler uses positive r12 offsets for incoming (callee-side) args
> and negative r12 offsets for outgoing (caller-side) args, following the
> x86_64/arm64 calling convention direction. There is an 8-byte gap at
> offset 0 separating the two regions:
>
>   Incoming (callee reads):   r12+8 (arg6), r12+16 (arg7), ...
>   Outgoing (caller writes):  r12-N*8 (arg6), ..., r12-8 (last arg)
>
> The following is an example to show how stack arguments are saved
> and transferred between caller and callee:
>
>   int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>     ...
>     bar(a1, a2, a3, a4, a5, a6, a7, a8);
>     ...
>   }
>
>    Caller (foo)                           Callee (bar)
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                           =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    Incoming (positive offsets):           Incoming (positive offsets):
>
>    r12+8:  [incoming arg 6]               r12+8:  [incoming arg 6] <-+
>    r12+16: [incoming arg 7]               r12+16: [incoming arg 7] <-|+
>                                           r12+24: [incoming arg 8] <-||+
>    Outgoing (negative offsets):                                      |||
>    r12-24: [outgoing arg 6 to bar] -------->-------------------------+||
>    r12-16: [outgoing arg 7 to bar] -------->--------------------------+|
>    r12-8:  [outgoing arg 8 to bar] -------->---------------------------+
>
> Note the reversed order: the caller's most negative outgoing offset
> (arg6) maps to the callee's first positive incoming offset (arg6).
> The caller stores arg6 at r12-24 (=3D -3*8 for 3 stack args), and
> the callee reads it at r12+8.
>
> If the bpf function has more than one call:
>
>   int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>     ...
>     bar1(a1, a2, a3, a4, a5, a6, a7, a8);
>     ...
>     bar2(a1, a2, a3, a4, a5, a6, a7, a8, a9);
>     ...
>   }
>
>    Caller (foo)                             Callee (bar2)
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                             =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    Incoming (positive offsets):             Incoming (positive offsets):
>
>    r12+8:  [incoming arg 6]                 r12+8:  [incoming arg 6] <+
>    r12+16: [incoming arg 7]                 r12+16: [incoming arg 7] <|+
>                                             r12+24: [incoming arg 8] <||+
>    Outgoing for bar2 (negative offsets):    r12+32: [incoming arg 9] <|||=
+
>    r12-32: [outgoing arg 6] ---->----------->-------------------------+||=
|
>    r12-24: [outgoing arg 7] ---->----------->--------------------------+|=
|
>    r12-16: [outgoing arg 8] ---->----------->---------------------------+=
|
>    r12-8:  [outgoing arg 9] ---->----------->----------------------------=
+

The diagram looks good.
When I suggested to use r12 I thought the whole support will take
much longer and by that time we will land Eduard's r11 work.
Now it looks like 6+ args will land first,
so let's swap them. Please use r11 as a base and Eduard's spill/fill
will use r12 if/when it happens.

>   [1] https://github.com/llvm/llvm-project/pull/189060

Same for llvm. pls update it to use r11.
I feel it can land soon-ish.

> +struct bpf_stack_arg_state {
> +       struct bpf_reg_state spilled_ptr; /* for spilled scalar/pointer s=
emantics */
> +       u8 slot_type[BPF_REG_SIZE];
> +};

This is pointless. Not sure whether claude came up with this idea
or you, but please think harder. Why slot_type[] is there?
What does it give?
Whether we pass u8 or u64 the slot is still 8 byte and this is
still the same spilled_ptr..
which is also wrong name here. Call it 'arg' ?

Also think through how i128 and structs of 8,16,24,32 bytes will be
passed.
