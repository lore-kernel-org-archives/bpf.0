Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA52BE63F
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857263; cv=none; b=dac0NEhCgLfqT7lw2C+P4lfP0rdW6+lyiTZf1pae+7WcYGsk3qbf+Uw/EXjEFc0YZ+Are4lSS12uRAiiYOEyqwmF2yY4+aCs1yb+CtUfIZJVH5smSxi+FILSVeN+ySqCcQpDsTg44SGPSN3y+8wTcD7TZ+eDAuRg7vUzQL64A4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857263; c=relaxed/simple;
	bh=w5OExVs13bravhrIoFw1hWFhF4Ny7Vq6OyG6/eP4y4A=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=W9OL5cm7WBoxkZT/vnRsrgSaMpzelBuSAm+c1cIZMpHQ04CYWFZ4hB7CzKjJHCSU9GhAoWdZwT4Zke7BcGFQGE3muBTi0kZc4Y3C8JC28uL0puLgujf82DGQUWDZwDU7StFcwAuwRC5SuH0cMqrxbMpvqKEeLYpk5lotCE2/V4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf6ojdi0; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf6ojdi0"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9c6ae2a79so9965a34.3
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 15:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782857261; x=1783462061; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3JOUSD04HW8Lb07ylAFIaXu2WfSDfMlOMu/+z8QnRw=;
        b=Gf6ojdi0ts1hiRsKzLF7VBTfYzzTr8zFvhAuQa99x6QsQDTmAkjGwUzRgAy0h2KdTU
         ZeJLZ4qQ2aXAIzzQxRdV0Jp5N9IaiNZ1tDWsPrSCYfYrfUwnGQIGyYGs9YRxdP5wGNmh
         Mi1t8wqJYKv4R4L00TLyeJtDvOricQXY1KvVeXAPpL+4YcxXQ1BaYrpJFTff8FWDzk7N
         cmobdDiJhx4eeoUVaSdTBVsGzo/cBnAtk4wbcFsnI4zpm7CCB45xxUrDityOK8egmGVE
         cEHrhy23B/aaCFIUT2WtlhvjxVR/73a8OzH7LSBkSTLtHBm6KOEE/j8DpbrOh9/q1AcZ
         k6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782857261; x=1783462061;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3JOUSD04HW8Lb07ylAFIaXu2WfSDfMlOMu/+z8QnRw=;
        b=mHeZ/d3Q6noBacPqU1a8/Qv+yjugiY+73OdnCDoZtHj4CGGwZFoKy67/vAyNS9BXKC
         FpRTxxLJ5ZE684tE0nzZQQImjAlkr2xNdW9dtIyO77UzlO45xNRGovq2B3n+7NxSBf/G
         qX6qQ8CvCBcuzDeYuiRnZ8LQYeEcvVcas0rQVtJKrjOxPjZ07TmNoPC864+6taGqeCkB
         tcE5pSdAOFb4Yjv7alc5KPkzgiKuowNoutamfLsrTplwkXf1Grt/rprg/xH4eWqYWgLs
         NkasC753+dF8gA6t7fEBredDxis0V5jt+WRdoRI+Awyt6oaWl6dhEtX9Hdf/ly1TrqC3
         1Zvg==
X-Forwarded-Encrypted: i=1; AFNElJ+9vfTcu694kTnOoWxaFpPMtOj+iarzmYEoqqbtujQOyosvI1b2iHXN4dtizFnChg1ElOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwflymyKBfHPiChNGL2DTqdCMxz7dLW5d42IRcKH6DLcF0NHwhU
	j1BenpujNbnVb4ogov7mve8nPdM0jq8t9WM96BcU/LoNU/LpuY7SgLNY
X-Gm-Gg: AfdE7ckoxSw4fMfVy8YkRv+d8L5nx8tfYsY/pGfK9z6b0plLSPRS3EeJtH75xuTYM3/
	efA0b/J8D4iLXkIbTTFQPiyBs4T2iRBQk5qQqA2aiqPwWjYf0UED/xUdWmiFKXOr0lKtafcCkmh
	o5z3/v3yRGm2eHpehOuRvKTDPjqHgEd03VuuYpQ2VsvuuGZT5w3BfjOvaz+KVBDpwNdOzRSz27U
	02IAngBD6ftf0FEc0Z+yoBnL6JZ9yaDQP3B/zIMLnq98/CtKlGZ2b9IzwG7SqqEXReFYzIfwbj2
	7dFCRxbmpN0p848xdg6Rjr4fvNQBJOh6vyEeYt9SZMbl/OnIGrh/7LRWSUQyIGcjkT9JPoIWBNM
	toxop/Ti/2nrYbzXGH1c3EgftafxFIchCCfc32fwNXa2yS6E8QmjGeqpfYpBbZMrOk9AYZwk4eo
	AFQOJJtEoIepEac/icRw1fq8txRO8swzzQd1brXsWLZgqA/smsWe9uEF5q/RxSWtL52FO+UnE04
	+niRg==
X-Received: by 2002:a05:6830:6d0f:b0:7e9:b4d0:df75 with SMTP id 46e09a7af769-7e9ec7bf3b3mr4563949a34.29.1782857260458;
        Tue, 30 Jun 2026 15:07:40 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebf89176sm3428179a34.1.2026.06.30.15.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 15:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 15:07:39 -0700
Message-Id: <DJMQ5HY26JFM.3QOFH7X8RTPIL@gmail.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "KP Singh" <kpsingh@kernel.org>, "Anton Protopopov"
 <a.s.protopopov@gmail.com>, "Amery Hung" <ameryhung@gmail.com>, "Eyal
 Birger" <eyal.birger@gmail.com>, "Rong Tao" <rongtao@cestc.cn>
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined
 tracing probe for BPF
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <cover.1782571533.git.xukuohai@huawei.com>
In-Reply-To: <cover.1782571533.git.xukuohai@huawei.com>

On Sat Jun 27, 2026 at 3:51 PM PDT, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> This series introduces static-defined tracing probes for BPF programs.
> BPF SDT (static-defined tracing) works similarly to USDT. User defines
> probes in the BPF source code. The probes are built into NOP instructions
> in the ELF. At runtime, when an observer is attached, the NOP instruction
> is patched to a CALL instruction to the observer prog trampoline.
>
> Unlike USDT, BPF SDT requires explicit macros to generate the function
> prototype BTF for each probe. This allows the verifier to validate the
> probe sites against the declared types, and observer programs can be
> attached similarly to normal tracing programs using the function prototyp=
e
> information.
>
> A probe with two arguments in the target program can be declared and defi=
ned
> like:
>
>     BPF_SDT_DECLARE2(my_trace, int, int);
>
>     SEC("xdp")
>     int xdp_prog(struct xdp_md *ctx)
>     {
>         int len =3D ctx->data_end - ctx->data;
>         int ret =3D XDP_DROP;
>         ...
>         BPF_SDT_PROBE2(my_trace, len, ret);
>         ...
>     }
>
> An observer would be like:
>
>     SEC("bpf_sdt")
>     int BPF_PROG(observer_prog, int len, int ret)
>     {
>         bpf_printk("len=3D%d ret=3D%d\n", len, ret);
>         return 0;
>     }
>
> The target program and probe site for the observer program should be set
> at load time via bpf_program__set_attach_target() manually, since program
> names are not unique and program IDs are allocated at runtime - there is
> no static way to identify the target program.
>
> For BPF_SDT_DECLARE2(my_trace, int, int) and BPF_SDT_PROBE2(my_trace, len=
, ret)
> macros, the compiler produces:
>
>   [code section, e.g. xdp]
>       goto +0                  // NOP, patched to CALL at attach time
>
>   [.bpf_sdt_notes section]
>       ___sdt_jt_my_trace:      // symbol marking this entry's boundary
>       .quad  0b                // 8 bytes: offset of the NOP in the code
>                                // section (resolved by the linker via
>                                // R_BPF_64_ABS64 relocation)
>       r1 =3D %[arg1_reg]         // 8 bytes per argument: BPF move insn
>                                // whose src_reg field encodes the BPF
>                                // register holding each probe argument
>       r2 =3D %[arg2_reg]
>
>       ....
>
>   [.BTF section]
>       FUNC_PROTO (int, int) -> void   // from BPF_SDT_DECLARE2 stub
>       DECL_TAG "bpf_sdt:my_trace:2"   // keyed by name + nargs

Interesting idea and encoding scheme, but I don't think we need it.
I'd rather see static_branch/jmp work that Anton started to be completed.
That would be more generic and folks that need SDT-like observability
inside bpf progs can instead guard their debug code with static_branches.
SDT equivalent would be static branch plus a call to nop function
which can be freplaced.

