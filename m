Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC746286A4
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776743501; cv=pass; b=Mxv3Uq13zDNUyVqg0P1XyPVLAlTygw9UKqYGiBJQCAqXeJfO1qELHDJJlvE6PJ5K8bDQFe4unFbQZdG5jPP8anbTEr2F2xdIGh2YNqvpKTpabo1/aR7uZBQO6JLVezF56cjPZGCeMtft28LkwogfO2YZFL1hr+Mh8M87HTsdSWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776743501; c=relaxed/simple;
	bh=FkXk/M5IIonbkRR4oTZN4nO/iCJDfwU1LPORLPACIb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7wZEsIkbmNPjE68xT52Im1G1ZpvLNcx5t7SaNTZvxKemaxIkLA7r7JD7BOMKLSvublHzcd6zo00iXcFG9dTAh9y+Q2G9VGtlvqXXtmVMMRZ8YphSd0LRpUpGyIYrWVe+/B/58sONekD6u3lR8HhuLMP6Klm0WvucCfFUrout4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNzYT08O; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNzYT08O"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7645adbdso2048389f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 20:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776743498; cv=none;
        d=google.com; s=arc-20240605;
        b=XPXSKMPWhQkPcEtTjk4afrQUHAjOLp2Hbgxs2OtDGSPKREFLFcRb3CXLlHLy0bXaIw
         JycoLvCPQVUScDfUTBi/E6vOZma/hlfYUIY9Ics6mgO52Uvu1mBAQC2h1umPJSJ0q2Al
         DMFLPd5Lia8t1RaMO9S5qkk0DJmQTdA2NnDWm6+0PmHXCkbomIcHvXvmrEr5UgOoBAXx
         DYuPdoK1w2m5JaROIaGkfCUTEMv8coZYDOXv9WgYHiIH/0SkwHMGW7v+iAh+nghBZU0i
         gV7WRFqiwJXY4ZAmTwDZYnCWbcMiy31hwpZF3p3LdWLGOfWL5pweOm8bI3MHHR3+pToI
         /Kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j2lyxMk+yfCHZPg9lrUflFguuW81rWrpeYyGcbVvD+o=;
        fh=BoExmrCBSDUyE7QUHjQ8Ywu14rYc1XxNTh3NcfYxXbo=;
        b=SpOuCu8BaHTM5Bq56UE0yh7RVQGdRpB9Tk4lw7yqKJZxNN+wJCGgxY8cxALBc1N1Vw
         dA7C8Vu71dx+bmSGn9HgM9HqgeICmcX44rUuFgXRl7ZZ6utT3QuDltbKSNCitn4EUKUX
         ymxg4SniogSKoBz1hTlJNz5dZeJGgwLVE/FtVhB/g4q3+WzKB0SnjMr5LZZvTkctShMG
         iEsI/NsKtpsZrXHLVKwsFvF2ZjDZWnsF+ZJvJkRaopDGLB65fXsXzxha8eFrHHtDMYHA
         v4V45xv2KxELx5QeCl64J40ZV6aBantHEOSRY1dLKBpYYgQbg0b/OU5do7+6uw0q0LLE
         7ZWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776743498; x=1777348298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2lyxMk+yfCHZPg9lrUflFguuW81rWrpeYyGcbVvD+o=;
        b=jNzYT08OzMXG3Ymzox/O+qYpWKuSGUMdv5ZX2hWP0JWqPCCfymxzYhd4QVbE/QTtuD
         fEYqml+if9QwVS6mTtJzr/EqDECoyjljDh80uWc+j7z1ochaYqaVabLigSvh7r9UXXzK
         TgwubE60sGhqRgDoR8CdmHb4qZ2pLfqMDjYA7A0iPr4tn/yP+Vfh3pZFnP1Gy3BJk9gd
         kFVbiPvaoDEcykUYRbFE7wU51V+dIKZRhjjQgqLlOr1894/J++E9ey4GRrAEcPnPto/Z
         Uk/IRHRrtnGHuAZCAm2Rfjsho0HluMUnPGCfw35X2Naqsy+cCfXIBQPvT7+GTguMM6UM
         N/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776743498; x=1777348298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2lyxMk+yfCHZPg9lrUflFguuW81rWrpeYyGcbVvD+o=;
        b=OQZESKWtigvbTzaOSLMm1AhFsvftGzJdOCO8GjQYzOw7dP0hqL1IFHoIdT4NY2eQ/Q
         1KwWUkagJ6/V23zi5pBBeWApNtlr2BWNT9a82tvZ+kMJgb0YrvabgP1J8zdNTAuas4JA
         czR36Uuu/55GkgP1Qz9EVRvKkoqm6fe6CkeQWSSPkz24bBS8f3xsF1c2R+f/opBlShxL
         MLNLKfD7LrYfsJyFhRWJaaC+Ybf1NHbq26NPI+NAVOUHjQpngQ99oKJT5InQKq5i1JPF
         I55u84vBT5Qn3HjNwuUsWbos6cAwgX/EYsOg9XbgKqrotzzFpFSZRKXAFVAeKcezmLwc
         hlPQ==
X-Gm-Message-State: AOJu0YyYbXyDWCwjBl4+yQ6hHVozQ1ItPPUCFZa4LLu0Jjymnz+YYYMX
	uH3aZwRIgA/D//pT1giv0IWb94yzSH2o/VovfOmNfTbRYpHv9SjvPNvi5XWXpX1SCJ90mF2sB0/
	5tFRW/SoEqPDkT1CJFntbteot/qVt/3M=
X-Gm-Gg: AeBDievsM0CJ6U+qKC4dB04y1+H/sQtb3tg+paWQbhhrOEvR+1drB4cU8yBZPSJ2Ll2
	WNwZLGcEpqRXy8yRZe4vyx2os0W9XTRberFv01geswnsyFSeRP/oRxc2R5aF28OlBgw8RMOTbKg
	lUNCK5XlMWa9x3LNavyFoWP9Z6BaH5Dqb+VNdTfzfw8x6M0hv75ekM18uF4xMmcekc3zVEaG8z7
	UPtuobaxd13hVbEHL3XUa1t4eUmHtcHS8MoJEb85q2/xCSBDg0Qgd3KgySyQX/g7cEuZDi/W43B
	ZHlIiH8UwiUgJMEwMTSBJl88278yj0qu24VD3k+A01ZrYMNc1tMwLIRmXXQggnE80d5R4bLk9d5
	ArP9aeqahHM1CL2I4JyzxW64pOMjqVrKid6Uc
X-Received: by 2002:a05:6000:24ca:b0:43d:4a43:53db with SMTP id
 ffacd0b85a97d-43fe3df2552mr23767725f8f.26.1776743497925; Mon, 20 Apr 2026
 20:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421033252.575374-1-yonghong.song@linux.dev> <20260421033333.580534-1-yonghong.song@linux.dev>
In-Reply-To: <20260421033333.580534-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Apr 2026 20:51:26 -0700
X-Gm-Features: AQROBzANdFc9n_HVX199n4X4aHDtoqu9_3mpn2toI5xFGDEubK73rIDt4R3bI7k
Message-ID: <CAADnVQ+vD_06Xs2_=7S4scvv+9_STZVgWtTKTrHRbRJB04OkaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 08/24] bpf: Support stack arguments for bpf functions
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Will Deacon <will@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 8:36=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Currently BPF functions (subprogs) are limited to 5 register arguments.
> With [1], the compiler can emit code that passes additional arguments
> via a dedicated stack area through bpf register BPF_REG_PARAMS (r11),
> introduced in the previous patch.
>
> The compiler uses positive r11 offsets for incoming (callee-side) args
> and negative r11 offsets for outgoing (caller-side) args, following the
> x86_64/arm64 calling convention direction. There is an 8-byte gap at
> offset 0 separating the two regions:
>   Incoming (callee reads):   r11+8 (arg6), r11+16 (arg7), ...
>   Outgoing (caller writes):  r11-8 (arg6), r11-16 (arg7), ...
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
>   Caller (foo)                           Callee (bar)
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                           =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Incoming (positive offsets):           Incoming (positive offsets):
>
>   r11+8:  [incoming arg 6]               r11+8:  [incoming arg 6] <-+
>   r11+16: [incoming arg 7]               r11+16: [incoming arg 7] <-|+
>                                          r11+24: [incoming arg 8] <-||+
>   Outgoing (negative offsets):                                      |||
>   r11-8:  [outgoing arg 6 to bar] -------->-------------------------+||
>   r11-16: [outgoing arg 7 to bar] -------->--------------------------+|
>   r11-24: [outgoing arg 8 to bar] -------->---------------------------+
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
>   Caller (foo)                             Callee (bar2)
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                             =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Incoming (positive offsets):             Incoming (positive offsets):
>
>   r11+8:  [incoming arg 6]                 r11+8:  [incoming arg 6] <+
>   r11+16: [incoming arg 7]                 r11+16: [incoming arg 7] <|+
>                                            r11+24: [incoming arg 8] <||+
>   Outgoing for bar2 (negative offsets):    r11+32: [incoming arg 9] <|||+
>   r11-8:  [outgoing arg 6] ---->----------->-------------------------+|||
>   r11-16: [outgoing arg 7] ---->----------->--------------------------+||
>   r11-24: [outgoing arg 8] ---->----------->---------------------------+|
>   r11-32: [outgoing arg 9] ---->----------->----------------------------+
>
> The verifier tracks stack arguments separately from the regular r10
> stack. The stack_arg_regs are stored in bpf_func_state. This separation
> keeps the stack arg area from interfering with the normal stack and
> frame pointer (r10) bookkeeping. Similar to stacksafe(), introduce
> stack_arg_safe() to do pruning check.
>
> A per-state bitmask out_stack_arg_mask tracks which outgoing stack arg
> slots have been written on the current path. Each bit corresponds to
> an outgoing slot index (bit 0 =3D r11-8 =3D arg6, bit 1 =3D r11-16 =3D ar=
g7,
> etc.). At a call site, the verifier checks that all slots required by
> the callee have their corresponding mask bits set. This enables
> precise per-path tracking: if one branch of a conditional writes arg6
> but another does not, the mask correctly reflects the difference and
> the verifier rejects the uninitialized path. The mask is included in
> stack_arg_safe() so that states with different sets of initialized
> slots are not incorrectly pruned together.

you didn't address my comments.

pw-bot: cr
