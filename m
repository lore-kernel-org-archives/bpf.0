Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9D3D6479
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740300; cv=none; b=fcv/UgXFhGtr9LRZsd2f9KB/j2TlZ6hAGDI6ABaWfi/cJZKSokpsP+6hMAKnJ5URX/RD5bPvT1or2z8PR+OLRMkQN7DwWruAj7lljW3PvSxLr0rn0hmt4/aag53NO3lJvVRVSiaQCOpJbGnXZnWC6CRSlBBTzm5c3mgQ42sGoFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740300; c=relaxed/simple;
	bh=emrVq9nfCYjua+ImV8ic9KvnWto6cw74R0B28dzshtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mogM0gkz3Wk4n8O22sn/aOxiwgK+RPFlzB9xwFrSwfhkQEE5aCbHIxLxYkHboJpcd58VkvKVj3/++QbVJG7raDF74X+hDYDYC4n1Avst/VDFDYD02Vku9gxhyxVad9BMbcqX5+FgXD4F/S00wnoptPcb78rAXUBt3322sfVWOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc9UhAr1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc9UhAr1"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso18851065ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786740298; x=1787345098; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ueMVV2CkE7S/JWoTeRcfcRk5CIhzAhibPReUJDsm3gk=;
        b=jc9UhAr1rqX10VP4kx0J4PsA6NvlhdXUX8EifGRFTMNdibbvOfqmSdc9rBmNAYA9BO
         2OYyhD6Gnh+STFO0NYqgzjTpuswNjKc6861t5wS9h5LpEZ98k2RntiomVHAOKCd9Zoi8
         OtD33NIyLhUoVi3iN2Xm00oYNfrooUi6CnwhozUD3a3Zcsvxz4SNj+s34U/m3RT0aphg
         BNptQQOkQNqKWzFxiH4vD69M04B3fHXjUNuFK/TZGUthX9I45X7Rrl1P9pWuG3wbI63g
         f+XpzlNr5PfPtK4fkDifZyquns/HZN4JN/P7PL5M7ZqwF/TkMz6G/1+TJLOTbRhyYQ+x
         Yr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740298; x=1787345098;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ueMVV2CkE7S/JWoTeRcfcRk5CIhzAhibPReUJDsm3gk=;
        b=MJ5pYIJco1zu8I6AUH400w1zEffvgcOQ7KiCQccsbt0ubi9bdXllffgGGIosf8XjNo
         WwdKi8BxzwFFbYN/mZgSqRawEqsHfpqVg+20Qc3vkZBDcZc1uDE4Uu5TO028SCRdvTgE
         YAtnHuTG1H63ReZaUAyCFE1W95gxJCB8kH88RLDYW2wLa2MB2Qpdi9eQdUTSytM36a63
         JA1VvM9mIYUQdM2HaNfMsYaqLgfo1chn/YCKQJ5u54knMLdJIuywFpH0xXte+tcUWDEw
         5fDQRi3ChsQ6A2GychqsrWC7C+0+jqa64SMVGpGzmZb02RMItnPVyvQ51l+CxO/+kzpq
         nu9A==
X-Forwarded-Encrypted: i=1; AHgh+RrD+DJWBUEL4BFN0dHnUJaKlq4ev7k184Dy1ZSW4cfxrgssejkmd1RHXgIXzB6HGa4FDl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIDEU7OwgXvifa/MtqSnXqe0T20AsBa7vU6Tbjtr/3xwiS10c
	y0Ap8g44O7vO6Ex6HAG0zs+mWfJf4kibk8nHq2JsSZ9Wb+mZ6PZiS/JnDlzihC+0
X-Gm-Gg: AR+sD112Kmw3wRwhKGZM2K6Y/RH8aZEGM0TLQHDgwoVleu0IqbhvCm4/CCQiiWF1ozY
	u9+fM3DeeSX1VEv6OSSvywajP+CZ6QsEha3IsumsXbMqs+OQTDUMe2QpHic82NQUVyL6bt36FNl
	K6AFiRcd65B0/+Q4V3IafhvIUm1UUIm7awiF1j/Oe2FKFxoiFln3XkywQJvAjaRpVFAoflWn6nh
	IQg+Y09hRO2V3pgY+vgajc4bwkxwmuKynrRRqYVvdKaIitSNUvBmwxNk1zsBwUWU8OpzUT9RFmL
	7tkHTydX4Na0c3Q3vIjQPqIoJvLzStaYhXGG0TwWzyvUYribc2adnHeIvEsFLINcwiPkdgw0rld
	NjP+w7bxHOzMaF5w1VDLQ1saz+mE6LcKNKahEW6d7r7j14Wi/KSK7Nu2YDaLpcDhgvdzbLMGYYC
	w5Quy0o6uN1LuxEsuOpXJkJKNrDrTIk9nkXWZbINJdN0zR8m8CZ1eilicl0QmDgYi+GjRH4TkL3
	5lc0rrQ48bmJAKoD2znHvqsZXjL4Em5n24HCnVD4gSCFXInp1/CBeUa
X-Received: by 2002:a05:6a21:6b16:b0:3c8:e0b4:cd9b with SMTP id adf61e73a8af0-3cc71eb5e50mr10363565637.38.1786740298372;
        Fri, 14 Aug 2026 13:44:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd918fsm7689027eec.2.2026.08.14.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 13:44:58 -0700 (PDT)
Message-ID: <3338fd93155ac14b3b824ce232ae7be288072608.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf, x86: Fix per-CPU address resolution
 into an extended register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
 	stable@vger.kernel.org
Date: Fri, 14 Aug 2026 13:44:56 -0700
In-Reply-To: <20260814203248.3714536-2-vineet.gupta@linux.dev>
References: <20260814203248.3714536-1-vineet.gupta@linux.dev>
	 <20260814203248.3714536-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 13:32 -0700, Vineet Gupta wrote:
> The destination of the per-CPU address MOV is encoded in ModRM.reg,
> which is extended by REX.R, but the REX prefix is built with
> add_1mod(), which sets REX.B. REX.B extends ModRM.rm and SIB.base, and
> this instruction addresses memory as disp32 with no base, so the bit
> has no effect at all and the high register bit is simply lost.
>=20
> Every is_ereg() destination therefore resolves to the wrong register,
> picking whichever one shares the low three bits:
>=20
>   R5 -> RAX    R7 -> RBP    R8 -> RSI    R9 -> RDI
>=20
> With BPF_REG_5, whose reg2hex is 0, the emitted
>=20
>   65 49 03 04 25 <off>	add %gs:<off>,%rax
>=20
> adds the per-CPU offset to RAX rather than R8. The destination keeps
> the unadjusted address and RAX is clobbered, so the program goes on to
> dereference a pointer that was never made per-CPU:
>=20
>   BUG: unable to handle page fault for address: 0000607e386a8894
>   RIP: bpf_prog_707837aafd2aa9ae_update_percpu_data+0x93/0xc9
>   Call Trace:
>    __bpf_prog_test_run_raw_tp+0x2dc/0x7d0
>    __flush_smp_call_function_queue+0x1e9/0xc80
>   Kernel panic - not syncing: Fatal exception in interrupt
>=20
> R5 is the mildest of the four, aliasing a scratch register and faulting
> at the store. R7 aliases RBP and would corrupt the frame pointer, R8
> and R9 alias the argument registers.
>=20
> Use add_2mod() so the register goes through REX.R, matching how
> add_2reg() places it in ModRM.reg and how emit_priv_frame_ptr()
> hardcodes 0x4c for the same instruction with R9. Encodings for the
> non-extended registers are unchanged.
>=20
> Problem showed up when trying to resurrect BPF_GCC CI (selftests built
> with BPF_GCC).
>=20
> This has gone unnoticed because clang reloads the address into R1
> before each per-CPU access, so the destination is never an extended
> register. GCC keeps several per-CPU addresses live at once, and
> test_progs-bpf_gcc panics the kernel in global_percpu_data/init, where
> the address of a .percpu variable ends up in R5.
>=20
> Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to r=
esolve per-CPU addrs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

Please don't drop acks.
