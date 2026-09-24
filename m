Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6621F7916
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790227997; cv=none; b=PKzuoefBaekUBp9Au6EsWosF+QqJ6yuQ5LPyXVCKinTqyOyMxjJ/6WmawNcW5ctgAD6XPoOEpY1ecOxRHqDCjLbIowrVr8FemZAn4Mmvg65+p9tqG0n0BVn2Ixsp4pzX7UFHVgk/O01pAsUsDXi8GW03aNHsA7s+c69vOTU1W5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790227997; c=relaxed/simple;
	bh=u6Y9/dCLmQox4L/nbUTgkvBWZsHKNrgUxU+OM7N4QdY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T6urVAiUVygqwOOAB5GsggwIZP3SnNcDe8b1Sh8YEbejlQrj9+cNS7S/rJJWbT9odBMAeu+I4QR23baNJKss0A6R5SdCTh6DVgrrINzKjpeejNC5NGitFt+/UuY2TPl+qVEHvBApr7Phvpk7YZcoHxatCB5o5Qf4VQf8HZXvg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFKhc028; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFKhc028"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so894329a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790227995; x=1790832795; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MUWnwYnt77FHWIx1aRGTB1yKqNYWNGX8KhdqfYRsPvs=;
        b=XFKhc0280YC/0MlHvlAiJ0w2dJle3XJp64cOU8ikyjRch776gUr9/KxtHXNtKxLCDl
         V7wv4xFWI+VnGPgvxiEBP8xdY6rMH83nL8ap44CH99CY18fJTxEgLcli/zPjnmyDYXAR
         lVp7N0JYHkoZSn4ebHzAQ49VPo+P+zvETSiJCSk1mkcvHm+laaLYJVuHG1hGliW7EUpC
         1MgzcTAdcYqyGvVVrGuYj4K5ZeoyrGest7YN/vpUsJwStXFwDYxPSIDZw2429IZeLYyt
         Glu2J65evxDjQbL61a+ru3iDPGco3hjh6Hjl71MdCiukGu0Nuz4BrFng4P5xwGFSUjQN
         OE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790227995; x=1790832795;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUWnwYnt77FHWIx1aRGTB1yKqNYWNGX8KhdqfYRsPvs=;
        b=y+We/bwYLTR4vjjot+ac/Bd6wYKGZFQhJ/jMSpV8wSmtOdW4r90Dex/bMOTADxu8Hn
         mqt9qZ1nCuxLpdC/BLirV6tadHR+0NO+hsbnZoCYc4Y8xBQh7ebL1rWWqFR1A/D5dw2y
         xMZ3mATR+k6M1fvEh+HK9m0N3dytsQLx8XpenEPmKfv5CLXSbJqROosSkc4s7dP+AYG6
         1cERR6+83U+dJ117FxbyNbnS9Yz8pXcqWIYmMHc2ci96WgP3cO5+neo/1XykYwEIFmFc
         OG8v0djs6+L5Lp8O0i8vAmJXhEumpCU/KB11BZ0wJSM+Dr6UgY5HG5BJXMK+ExWD90Ho
         Edkg==
X-Forwarded-Encrypted: i=1; AKwUvBxidsPQnxedwDK1IjqEtFNPOCraKRWU15WXentYOdN6tb2qxk3XocKMsUDkwqp1eiutrj8=@vger.kernel.org
X-Gm-Message-State: AFuF++mu4wQ8J7Y3Hc8A32APdWnbIERaIMPF6YIDn7cohMMhBcmZ2xQJ
	JApHlo3QQm+w8R1dKTU/jPwdbncfE6q+1MVbZnFz0/74E2i6dG6DVhW7tuE/7g==
X-Gm-Gg: AYBFou244KsYRk6eBUujXsNeglv+IIomBRfGAPY6lJ3UtMcllwFVywSCaYlTUjcrm4o
	Estq2YZoGEbK0QAV8zZlIQ3FZo5K5byUCysplXQDo7gD4Bz6q0EPCyVrb4TM5E7CVMWdlUOAscJ
	sNFMbcZ5fzfXswZLNfhbeKZ/d6AajuAUToRar88Ys7qp8lOEk5kIpmiLYvlOc8zO/NS6lovgl/T
	31pTCYv5HRqeDlyymha5K/raAlR6EYpU4mf8UaRtdv6ys2wWOEka8lvaKDezTapuDn0DZNkpAaS
	V/A0I66/P8yH89RKSOrZ9MHvuQX4/JeftD+L+oTKJ/GShtBQ9iDSN2/tOBxiQJmNbet54FH/Bgy
	RzPsSPQt4hXrgCYkpji3xft4gHe6tuYEuCpw98oaF4RicigLCpjalTp59EdWOAR3rpEyk3GijHv
	FbySpaIalacibkHdGVUyjQ45/oURtrYIRzlvLHKFfwXRng6n4/nSYRgJnQQEFcCPhh464XGATfd
	lHaydJ5VH4LygkSbfz1EMX/H4bBO3O5mJewfg==
X-Received: by 2002:a17:90b:57c6:b0:3a0:22bd:6ef6 with SMTP id 98e67ed59e1d1-3a09853a6cdmr1024345a91.2.1790227995593;
        Wed, 23 Sep 2026 22:33:15 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972efa0bsm2609931a91.8.2026.09.23.22.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:33:15 -0700 (PDT)
Message-ID: <fff46b2598a74aa51a8d686829522b6f490aa677.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 07/17] bpf, x86: Add JIT support for callx
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Wed, 23 Sep 2026 22:33:12 -0700
In-Reply-To: <20260924031042.1690890-8-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
	 <20260924031042.1690890-8-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-24 at 03:10 +0000, Alexei Starovoitov wrote:

...

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d4a980140b48..9fbef7504e51 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -749,6 +749,46 @@ static void emit_indirect_jump(u8 **pprog, int bpf_r=
eg, u8 *ip)
>  	*pprog =3D prog;
>  }
> =20
> +static void __emit_indirect_call(u8 **pprog, int reg, bool ereg)
> +{
> +	u8 *prog =3D *pprog;
> +
> +	if (ereg)
> +		EMIT1(0x41);
> +
> +	EMIT2(0xFF, 0xD0 + reg);
> +
> +	*pprog =3D prog;
> +}
> +
> +/* call *bpf_reg */
> +static int emit_indirect_call(u8 **pprog, int bpf_reg, u8 *ip)
> +{
> +	u8 *prog =3D *pprog;
> +	int reg =3D reg2hex[bpf_reg];
> +	bool ereg =3D is_ereg(bpf_reg);
> +	int err =3D 0;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
> +		OPTIMIZER_HIDE_VAR(reg);

This is quite unexpected. LLM points to [1].
A comment would be nice.

[1] commit be8a096521ca ("x86,bpf: Avoid IBT objtool warning")

> +		err =3D emit_call(&prog, its_static_thunk(reg + 8*ereg), ip);
> +	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
> +		EMIT_LFENCE();
> +		__emit_indirect_call(&prog, reg, ereg);
> +	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> +		OPTIMIZER_HIDE_VAR(reg);
> +		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
> +			err =3D emit_call(&prog, &__x86_indirect_call_thunk_array[reg + 8*ere=
g], ip);
> +		else
> +			err =3D emit_call(&prog, &__x86_indirect_thunk_array[reg + 8*ereg], i=
p);
> +	} else {
> +		__emit_indirect_call(&prog, reg, ereg);
> +	}
> +
> +	*pprog =3D prog;
> +	return err;
> +}
> +
>  static void emit_return(u8 **pprog, u8 *ip)
>  {
>  	u8 *prog =3D *pprog;
> @@ -2941,6 +2981,24 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
>  			break;
>  		}
> =20
> +			/* callx: call of a bpf subprog whose address is in dst_reg */
> +		case BPF_JMP | BPF_CALL | BPF_X:
> +			/*
> +			 * The verifier makes sure that callees of callx are
> +			 * not tail call reachable, hence unlike a direct call
> +			 * of a subprog there is no need to pass
> +			 * tail_call_cnt_ptr in rax.
> +			 */
> +			if (priv_frame_ptr) {
> +				push_r9(&prog);
> +				ip +=3D 2;

LLM tells me the following:

  This matters when emit_indirect_call() emits a relative call to a mitigat=
ion thunk:
        =20
    displacement =3D thunk_address - (call_address + 5)

  Without ip +=3D 2, that displacement would be calculated from the
  push=E2=80=99s address, and the call would land two bytes past the intend=
ed
  target.

Which is not obvious at all.
Is it the reason for +=3D 2?

> +			}
> +			if (emit_indirect_call(&prog, insn->dst_reg, ip))
> +				return -EINVAL;
> +			if (priv_frame_ptr)
> +				pop_r9(&prog);
> +			break;
> +
>  		case BPF_JMP | BPF_TAIL_CALL:
>  			if (imm32)
>  				emit_bpf_tail_call_direct(bpf_prog,

...
