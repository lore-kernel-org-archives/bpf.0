Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F48344040
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440259; cv=none; b=B5Q3XJC4edRrv4aIojW0IvEpC1BRKTute1ljvApVXhApRStSkWyKhRzNWMTfYIbdSXrmdnH0x9DynfxoMvCcsBieSjj+MRDifB6nLm/1ZpqQqTeX7NMOb9TeLiR1n6lbC8fX2BWy0b2qZrRWa+51vEZeesh36uLkv9CHklZJ5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440259; c=relaxed/simple;
	bh=mA3wDyGgvvT3L4SxyRlPHE8hcpVdHLXRJxefdbH1DEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IahzWuE8PevIofygarymXpZqnCeRMDI+xbB0N/Xxw257lTtD60gQKPxPjbOVf3w7wO2rEF9IGZBTZNiYmxXsVzLm9Ai5vGq9HLhbpuJqfszwpI3smxl1r2IpwmWXzE/TbciiwNT6YlqDxDwCmBOenNh26JK+ewoSQ6wEapax8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ffyWOHNX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ffyWOHNX"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so807558a12.2
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786440256; x=1787045056; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=stsMPChIW4ftsXJaYyCb4X3ea6+ls8dfSAjMU/k+EX8=;
        b=ffyWOHNXTaUurmxjOFX2qbFShdI68uKuNf/e9jUHQsT7fTB4wVjPSxczewwonoIGkf
         wUKmv9dSIoRxYUNtHp5yh6riOQAAIKuUO+LMWv7d7OFaJzVo2atkdYG3xKBLusqdl0UQ
         VmPoQ7+ncDGU62wi9e9+VFxvlKyaJwh3UsYMeRXlQVo8KfkiShAxzIv/4kY5S5uHyUWL
         njakAeBMHEnX/DQjd/jB6enkf8eF/GscEysE4xWeUa6yN16THubjxC3E16Tcm+7VWs0U
         nd5uaP4b5ksoa+mqseXCXNoiVttvkCy/dMshtzNvsYs57dzKE7Bt9iy/ZshUbVVPCKo8
         qG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440256; x=1787045056;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=stsMPChIW4ftsXJaYyCb4X3ea6+ls8dfSAjMU/k+EX8=;
        b=IYmgUz/o3CPVmvH6s71aQ32TNxNY0HJ8yOD4FNppNXlOrcWlnWdn9wYAXY/Vl2b2VC
         IXrugRtcKDs3YLY7ggzH/IwY4Lejf7rQhdZSRY0O3U2lEOMvCvGk5nOiGcmUVMEWL3aD
         ODC9mYYlSrw/uSrXgxJ83ekqGWnYFNb+v+PM25z2zHm7tLXI9zm6jUQoV8Llq5txTxKv
         og1b0oNExgBvNUwy6KAadmoIyUP0GrHuGjj2ifXqnweJOZuY1ZVpPZPcEJgVnxj40483
         TvsS/DmjJZadUdYOP/L4MMk5blel2+5U6oMewJ2XWRxjuMl+f/BuZDGv9Bnlr/mQfyp6
         /+8A==
X-Forwarded-Encrypted: i=1; AHgh+Ro4n66Bi+hn7zLst1ma5rcXX5WPXMLloAg6v+RSJfDyd9qgLPb6i3CghASM+FJ/YB+0dK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5Hz99OqUS/eov3XU0DIDwWztrBQKabavjr/j8rPrBa1PV9E5
	Fm6JO919uYLf56XNQ2mq69sXyNhKn73hv8D8Hr0h8EOuYulxzfMzYaBL8n7bKvmVie8=
X-Gm-Gg: AR+sD12zsOb+7T8VVOVMVZDoxRWgqDtr3cOzzO49nQ84gdYiGJd+y48gKcqx9ETsOod
	g60IJqYTPGjba/wxvP2CHEHZLSGEvS7i6W5NcVtgsN+f4dlEkoOeygl0V6g5mPKxkEirqPciAy5
	mbSZ+OhnEXWtrSBWsZHbQsanM3ZRW5xECgoAfh/sxknezqdpKEVpg7nOfvyMg1z0P8+e6183OFb
	Ac65qjh1tTicMI3mMxqzRLr63BShL/NeU1WRHt4QK+00NdrJdji1dUkkGX6P7aVmX90AEEZP+zI
	t4Io8wh7/Z8JWtkeD0glqpEZLjKdJ60hy0qS1/N5PCK/89sjpyjrTFsbGbinFOWNwjRDS89KHBj
	VhGt5m5IgUtYNlL+48cy0cYMywo29XyciLu/zOGesofjPfN2txkV7Rvn5eB1SJiJdzwolI3IpdY
	CB465Hwll2vDnAtW+cmWh/GmTTdJ8zAwmo9iZ3uNWVYee+GisZl0vPWOLVxP39Flc=
X-Received: by 2002:a05:6402:380b:b0:6a1:23f3:26b7 with SMTP id 4fb4d7f45d1cf-6a3645207ddmr1123785a12.14.1786440256355;
        Tue, 11 Aug 2026 02:24:16 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a362e16994sm427794a12.5.2026.08.11.02.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:24:15 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com,  eddyz87@gmail.com,  puranjay@kernel.org,
  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Derive the atomic load register in
 one place
In-Reply-To: <20260810221811.481040-1-daniel@iogearbox.net> (Daniel Borkmann's
	message of "Tue, 11 Aug 2026 00:18:06 +0200")
References: <20260810221811.481040-1-daniel@iogearbox.net>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 11 Aug 2026 11:24:15 +0200
Message-ID: <87jypx6mdc.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 11, 2026 at 12:18 AM +02, Daniel Borkmann wrote:
> check_atomic_rmw() open codes the mapping from a BPF_ATOMIC to the register
> it reads the old value into, the BPF_STX case of insn_def_regno() open codes
> the very same mapping a second time, and BPF JITs need it as well to know
> which register a faulting BPF_PROBE_ATOMIC has to clear. Having the
> derivations sit in different files is how the JITs came to disagree with
> the verifier in the first place. Add a small helper so that all of them can
> share it. No functional change. The BPF_LOAD_ACQ case is there for the JITs,
> which do walk all instruction classes.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  v1 -> v2:
>    - also convert insn_def_regno (Eduard, sashiko)
>
>  include/linux/filter.h | 24 ++++++++++++++++++++++++
>  kernel/bpf/fixups.c    | 11 +----------
>  kernel/bpf/verifier.c  | 17 ++++++-----------
>  3 files changed, 31 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 4edba8182db1..15d83684c6e9 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -414,6 +414,30 @@ static inline bool bpf_atomic_is_load_acq(const struct bpf_insn *insn)
>  	       insn->imm == BPF_LOAD_ACQ;
>  }
>  
> +/*
> + * Given an instruction @insn, return the number of the BPF register that a
> + * BPF_ATOMIC reads the value at its memory operand into, or -1 if there is
> + * no such register. That is the register a BPF_PROBE_ATOMIC has to clear when
> + * the access faults. Like bpf_atomic_is_load_acq(), @insn is not assumed to
> + * be a BPF_ATOMIC here.
> + */
> +static inline int bpf_atomic_load_reg(const struct bpf_insn *insn)
> +{
> +	if (BPF_CLASS(insn->code) != BPF_STX ||
> +	    (BPF_MODE(insn->code) != BPF_ATOMIC &&
> +	     BPF_MODE(insn->code) != BPF_PROBE_ATOMIC))
> +		return -1;
> +
> +	switch (insn->imm) {
> +	case BPF_LOAD_ACQ:
> +		return insn->dst_reg;
> +	case BPF_CMPXCHG:
> +		return BPF_REG_0;
> +	default:
> +		return (insn->imm & BPF_FETCH) ? insn->src_reg : -1;
> +	}
> +}
> +
>  /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>  
>  #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 661e2d13a604..c4bd70befbb5 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -49,16 +49,7 @@ static int insn_def_regno(const struct bpf_insn *insn)
>  	case BPF_ST:
>  		return -1;
>  	case BPF_STX:
> -		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
> -		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
> -			if (insn->imm == BPF_CMPXCHG)
> -				return BPF_REG_0;
> -			else if (insn->imm == BPF_LOAD_ACQ)
> -				return insn->dst_reg;
> -			else if (insn->imm & BPF_FETCH)
> -				return insn->src_reg;
> -		}
> -		return -1;
> +		return bpf_atomic_load_reg(insn);
>  	default:
>  		return insn->dst_reg;
>  	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index add3affc5703..73a2e8bb1782 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6485,21 +6485,16 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>  
> -	if (insn->imm & BPF_FETCH) {
> -		if (insn->imm == BPF_CMPXCHG)
> -			load_reg = BPF_REG_0;
> -		else
> -			load_reg = insn->src_reg;
> -
> +	/*
> +	 * A negative load_reg means that this instruction accesses a memory
> +	 * location but doesn't actually load it into a register.
> +	 */

Nit: This sounds like it's part of bpf_atomic_load_reg doc. Describes
the return value. Consider moving.

> +	load_reg = bpf_atomic_load_reg(insn);
> +	if (load_reg >= 0) {
>  		/* check and record load of old value */
>  		err = check_reg_arg(env, load_reg, DST_OP);
>  		if (err)
>  			return err;
> -	} else {
> -		/* This instruction accesses a memory location but doesn't
> -		 * actually load it into a register.
> -		 */
> -		load_reg = -1;
>  	}
>  
>  	dst_reg = cur_regs(env) + insn->dst_reg;
