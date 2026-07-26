Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682526AC5
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785032735; cv=none; b=m5yAYUBr1rqJCnyLhN/SBoNWopkWr8m5NQTGtG3ioXTpBPcwOtiDxrhpsrt6UkLFSMI2Pi5QCiSxVejotyh9EjqbgiFm7qK/wk5CAsuCljR6qLQSm1VJT4UwS3pUj09FD4/DtplIwOBw7449w6ga/JnJNwZODJ8RgXbMuxL9K78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785032735; c=relaxed/simple;
	bh=KdQLKAPtaFg8fF+84GR7UXM7F8PtezJ51SdSXQQxhsU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cByBI8DbFGd+Xf1hEzJCGJE2NONw9Z6os7PX8EEyf5BtT4kyF6NdARkBADdZFGN6VVSZA2nbQn7AguNj0N6a2PZUWyGV17rJ/aeMRyuteui4TGnh36+wYZb7rcJD3UWmi3QfRbnwRXVjEW3u2kbmo8u6drPKvlCUknQIiwFjfek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9Fdk6u7; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9Fdk6u7"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso658045f8f.1
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 19:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785032732; x=1785637532; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1BraonShgnVaifxGA2wnAyOgOoltyCIEJeUws1RlsU8=;
        b=m9Fdk6u7eE52TV3P9KF7GnKvH9inqyfToMEPphpkI6bSr9HCKUI8+IJ4Tz5rxFTp8R
         trz7gEJkxzsa57U5l5NgJzTndhfeZ8z11tFiDyZhJsS9e/WxUqXWaq0lq4f2QyD0+OiX
         JdkvUJNsUdIA9U+kvwj29DSRTGzPmHaN1ivTCHHOqiwrh2Lk6iEKVRhhh+ajcV11Sy9/
         mTXBqZJycL9eIKGFw3U8b5SSqJ3jqCs+y5GlFE5eFGjBp+ZPj8nxXiVq3+i/lugEBEqh
         sRN+fPdnn77PPQBAR1FL5gDF5wr9ozuCBLArswDiY4Hy/b1lz7/qepoeejgjJGFmKku8
         c6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785032732; x=1785637532;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BraonShgnVaifxGA2wnAyOgOoltyCIEJeUws1RlsU8=;
        b=mjgNkViItUHf8mpF22im19IFXs8AUSef9RhqRrMkhdCzNYcVOaf27t1S1Zqj4KeWAj
         9Cgs5+rffj8cyomcHBpvoM4mw3ymMTTPGL+erzuj4/o9xxXt4/FspjGoZsGYDMKyUmhB
         qBdPR8O1HOFKgod9rZK/krzsXJnN+kSN+q7TN8DbGO9a9TxFBSDSX7gjamZ378QLowM5
         aZUvgLMcOd9UmzlYAI/5l/MRHlC+Ac5AMPKgZFypi0GBq1hwV84pD+4cWjs8Aj/Ez6o7
         uFEKDs3ZV4Zw1HnI4P3isiTS6x47JkrJ/jXY1nWMWAf5uAuU56HD6TcrwGVnZjodr1X5
         hhUg==
X-Forwarded-Encrypted: i=1; AHgh+RpIcaCaG/Ff6OrQ2FQ8jx9ZF+DtQq9Vt4BtZFZ6TPt67Bguv+luhVq/lQGkcHzD5MBKnso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQ1tkCR88mwgjF2t5U+VfdoOqmy4cXPZD+vvrlldfF1tdC4Hf
	ngyAuHdChKyvHpvZtwuD7S6S0YO26fs92wu9W2EWThq2cVxcELb92IsE
X-Gm-Gg: AR+sD10wPhg67VwUosgXfBwtE2UG7vdJncTTdIlRD3Qh3toGWm6GGF10mNt1W6RJKAn
	uFWT9/6wcqnxKw+VGlKgH84/0hzc4nxa5r0AkJFawCflVsG+DS0oZmWaL4c7Ti9nGJE7laQvf5Z
	sG5+I21cOSNt3UpsDr0JpnhziBOZdNcpxRJ4YhpGZba0Imc55IJ8gRHuB14ZVcerRO8chjwmDeI
	T0NtioUFGyCywX9kHE3Daq3ZnibnZ51K0cYmmj/aeq0FWuj1bXJ0PGIOZ4AkIQbvBAIHLx1ZSS6
	Wfs1dMijakq4QzziFIGw2InM/rE4Si+039qeaE2iMnO035k3BNW6FI3hL6ixFlmcHCDVB3apJd6
	8pUxhWTR6qLeLZ5bOicWBTcDUuwspbJ5pgU3pCSoKUsAlabu/78GO+2DQ1ips0rhgovy+WiJWZN
	4tyvpf+9YBWOFYOcVyJE6pvk9BZ6tT9ibCD5lJCxAO9Rk7zO6SL6dINVFAiVbY6qkA10FB/CDbu
	KxjodhibemX/P7ujsmwuCLWisTPBQLMu0z4OE9qNhcj
X-Received: by 2002:a05:6000:605:b0:47f:8810:cc64 with SMTP id ffacd0b85a97d-47f9fc976f0mr4249229f8f.19.1785032732002;
        Sat, 25 Jul 2026 19:25:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm37421812f8f.6.2026.07.25.19.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 19:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Jul 2026 04:25:31 +0200
Message-Id: <DK85AK3KBMGT.26YEC0E62HKCO@gmail.com>
Cc: <tj@kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 3/9] bpf, x86: JIT __arena kfunc argument
 rebasing
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260726013105.3689867-4-memxor@gmail.com>
 <22f76e29c963794d5650486124e295ffc275c5e548dfc7fbae022f24c9d5d1ad@mail.kernel.org>
In-Reply-To: <22f76e29c963794d5650486124e295ffc275c5e548dfc7fbae022f24c9d5d1ad@mail.kernel.org>

On Sun Jul 26, 2026 at 4:22 AM CEST, bot+bpf-ci wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index b2feec81e231..08013c2fcfaa 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1678,6 +1678,50 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u=
8 *ip,
>>  	return 0;
>>  }
>>
>> +/*
>> + * Rebase the __arena args of a kfunc call to arena kernel addresses,
>> + * rN =3D kern_vm_start + (u32)rN, with R12 holding kern_vm_start. A nu=
llable
>> + * arg preserves NULL by skipping the add, tested on the truncated valu=
e as
>> + * arena NULL is offset 0. Return the number of emitted bytes.
>> + */
>> +static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
>> +				 const struct bpf_insn *insn, u8 **pprog)
>> +{
>> +	const struct btf_func_model *fm;
>> +	u8 *prog =3D *pprog;
>> +	u8 *start =3D prog;
>> +	int i;
>> +
>> +	fm =3D bpf_jit_find_kfunc_model(bpf_prog, insn);
>> +	if (!fm)
>> +		return -EINVAL;
>> +
>> +	for (i =3D 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++)=
 {
>> +		u8 flags =3D fm->arg_flags[i];
>> +		u32 reg =3D BPF_REG_1 + i;
>> +
>> +		if (!(flags & BTF_FMODEL_ARENA_ARG))
>> +			continue;
>> +		if (WARN_ON_ONCE(!bpf_prog->aux->arena))
>> +			return -EINVAL;
>> +
>> +		/* mov eN, eN: truncate and clear the upper 32 bits */
>> +		emit_mov_reg(&prog, false, reg, reg);
>> +		if (flags & BTF_FMODEL_NULLABLE_ARG) {
>> +			/* test eN, eN; jz over the 3-byte add */
>> +			maybe_emit_mod(&prog, reg, reg, false);
>> +			EMIT2(0x85, add_2reg(0xC0, reg, reg));
>> +			EMIT2(X86_JE, 3);
>> +		}
>> +		/* add rN, r12 */
>> +		maybe_emit_mod(&prog, reg, X86_REG_R12, true);
>> +		EMIT2(0x01, add_2reg(0xC0, reg, X86_REG_R12));
>> +	}
>> +
>> +	*pprog =3D prog;
>> +	return prog - start;
>> +}
>
> In v1 review, Eduard Zingerman raised a concern about the JIT-based
> implementation approach, suggesting that it spreads complexity across
> multiple JITs (verifier.c + 6 jits) instead of keeping the bulk of the
> implementation in one place. He proposed an alternative using R0 by defau=
lt
> with a jit_has_dedicated_arena_register() predicate to avoid the
> 64-immediate move overhead while centralizing the logic in verifier.c.
>
> Kumar responded that while this approach is reasonable for kfuncs, struct=
_ops
> would require uglier code with reloading/translating/storing. The v2 patc=
h
> retained the JIT-based approach.
>

Yes, it was discussed offlist, we'll move ahead with JIT-based approach.

> [...]
