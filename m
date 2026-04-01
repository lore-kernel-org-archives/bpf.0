Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E413E8C63
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059007; cv=none; b=bi+CT6a45jfooF5girk79vUosR9C896yUK/hQj2YRS23z/EL9mOP7+GcXKWDoz/vX80qr5XxfQKxbtBCOiGmRTxwV4PuqAdCH3ZU4sCwUgaofwoeLGjCp3dg7m35TSDCnxLqHLO00rV10PAm23VtJN6XiZzjUOI0iWaoUddaww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059007; c=relaxed/simple;
	bh=uF5a2XJKBX9+Zh27O8oOoJwsXxfp5MDJw8H9Lq15gQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2JGzC7VpEuukBZy7J942nXWsEjm0NPVXLRRKNrdw2Erh8uVpdcYMi1VsOyPHOBCV5UyyaARxKIW5XT7aUwyImQslgdK1fNfUI81d+syoyk5AOTEL4TbaTbtGTcPKq9nyxIUIDGy0nW7WH2nUQhkFkFxjMOuRlzbYJTFdLlEnyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG0+75kZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG0+75kZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so5360404f8f.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775059003; x=1775663803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7v8EB6eHIufxEt5xCjdeo7cea7r51MdH/37tsl+JXlU=;
        b=JG0+75kZd5MTv3MJkYBzU4ARdVeCGULZS/S61BNFAycx+hAUH/I7fVck2WMROk5yaX
         /dnspj/FErZQkoIGuc3MP6O9Hwp1rZT2Z5NFWaSTmTg4+PP6sBzBEMrM/DSxWQxgbq+h
         UXPu/QwDyCcnbxYPbMTg6hQLs2V6jjnHfXTLHCkTil6sV5gnn0gTc1NLvnz2hVVNqbUK
         zwvHVycnWn1hzvnLMbP7hQjqS06pFr4Vf6fwfajOfDpySieFucYAwIZQhyG/CdUY5lV/
         dJ9WARo6PkcphbtPr94eq9ZkiooMMalZCEHwhkBaKj2A+RIKwPBYzJK72AWTEsHN3uzH
         u4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059003; x=1775663803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v8EB6eHIufxEt5xCjdeo7cea7r51MdH/37tsl+JXlU=;
        b=aXLJRxvABccd/Y9w5jBjhhZWqpzSDLfZ66UJE6grOl+CTQOuhNkXDnGrCuyJVOQaqm
         DRDcVcepRJQqi3P9EaJDQP5TiRX5HiHx0Cp3tRMjUzti/xZ8qu+2LoMQaCEdUrYKJyRo
         qD9PEgrsxwr5BBaWk9xgpdrV+8zIna8fCr2FsNwKKnZ4BShJGiODpilvJmJySle5TJeS
         flTjc4uinECn7VQSufZNaURpqr6ya9PmTPOlETZzBshj0m3bP7MtssofKaLqZMAAFpCx
         hOz4IBT5PLP9ucnNlCRx4PbKPb8DEEiIZFtUNjUPqJeKu2/SR01yiBW+Hk0d1qoDfQP1
         AgiA==
X-Forwarded-Encrypted: i=1; AJvYcCXptDaruTTGJhPK42JSnc6lB49v2dMTX9vs4sBj/0hgj9KSfpSDMp13Kvnp3uWHsU9GRnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASHheb5z/TJdLGXucxQfSk4L+qFjFdeJjn8FexuthE5DW9JgO
	NCh5XTtFdDkyHDYd0XxRZ4DqAb1xpcLgbbRaG9Yl1Xp44Dyf5wZr66mr
X-Gm-Gg: ATEYQzz66LHnnQ2MnaKTPoDUj79zUkKxRIflbU8oC+6yMasp1n0K/94ux1YKGDM/LAZ
	7wsdsbf5t3sWWeiPyIbO4XUW5XdXvGUCZeGoiToneYlPWcLXqBDIwIN8Af6GOqvSFhZMIuSKoyu
	XlR24NvfBNa9pcab2Xoq8F1YH2p2/8HzHhj1eJMiL1UfKO9fp7WfN4uqceZrt4GlMknLTxEctKb
	WSCFgiXpVaUx/5wyJmF03R0eQ69SPKy6SnDs5a9Y4LEzFApUQA74ZvCJisNB7kryTJPokn1WeJe
	jUM+ojO9EE50VumVYQ2zGLZc8odKdyxStwO9gm4xjEVKTMUhdmDOl/dv3nJTLmijiR5hH7nhy2I
	nnsvz5AHL6GIDGJ8fbvl28tPzZTGSFUVS4H7I6H/qHtbtlhN7qVFDKgEyFgDbXKvLlpcw6mVQME
	kaHqvWQTOxCJI1b1VwvCUY/hp6gguoTg4LkmjyYnyRSGXOMs7NvQxFn8ES+wtQ
X-Received: by 2002:adf:cd8d:0:b0:43d:1c21:efd1 with SMTP id ffacd0b85a97d-43d1c21efffmr2756744f8f.4.1775059002915;
        Wed, 01 Apr 2026 08:56:42 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:ff4a:fb29:5217:3697? ([2620:10d:c092:500::7:b4a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm769436f8f.9.2026.04.01.08.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 08:56:42 -0700 (PDT)
Message-ID: <4f283d2c-dc06-4598-bb21-d4d2491a7fff@gmail.com>
Date: Wed, 1 Apr 2026 16:56:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/6] bpf: Do register range validation early
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
 <20260401021635.34636-2-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260401021635.34636-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/26 3:16 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Instead of checking src/dst range multiple times during
> the main verifier pass do them once.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
resolve_pseudo_ldimm64() runs earlier into verification, so it makes 
sense to move this basic check there and remove from other places. Looks 
good, other than issue that AI found.
>   kernel/bpf/verifier.c | 34 ++++++++--------------------------
>   1 file changed, 8 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c1cf2eb6cbb..3ec786361698 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2249,13 +2249,6 @@ static void __mark_reg_const_zero(const struct bpf_verifier_env *env, struct bpf
>   static void mark_reg_known_zero(struct bpf_verifier_env *env,
>   				struct bpf_reg_state *regs, u32 regno)
>   {
> -	if (WARN_ON(regno >= MAX_BPF_REG)) {
> -		verbose(env, "mark_reg_known_zero(regs, %u)\n", regno);
> -		/* Something bad happened, let's kill all regs */
> -		for (regno = 0; regno < MAX_BPF_REG; regno++)
> -			__mark_reg_not_init(env, regs + regno);
> -		return;
> -	}
>   	__mark_reg_known_zero(regs + regno);
>   }
>   
> @@ -2908,13 +2901,6 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
>   static void mark_reg_unknown(struct bpf_verifier_env *env,
>   			     struct bpf_reg_state *regs, u32 regno)
>   {
> -	if (WARN_ON(regno >= MAX_BPF_REG)) {
> -		verbose(env, "mark_reg_unknown(regs, %u)\n", regno);
> -		/* Something bad happened, let's kill all regs except FP */
> -		for (regno = 0; regno < BPF_REG_FP; regno++)
> -			__mark_reg_not_init(env, regs + regno);
> -		return;
> -	}
>   	__mark_reg_unknown(env, regs + regno);
>   }
>   
> @@ -2947,13 +2933,6 @@ static void __mark_reg_not_init(const struct bpf_verifier_env *env,
>   static void mark_reg_not_init(struct bpf_verifier_env *env,
>   			      struct bpf_reg_state *regs, u32 regno)
>   {
> -	if (WARN_ON(regno >= MAX_BPF_REG)) {
> -		verbose(env, "mark_reg_not_init(regs, %u)\n", regno);
> -		/* Something bad happened, let's kill all regs except FP */
> -		for (regno = 0; regno < BPF_REG_FP; regno++)
> -			__mark_reg_not_init(env, regs + regno);
> -		return;
> -	}
>   	__mark_reg_not_init(env, regs + regno);
>   }
>   
> @@ -3958,11 +3937,6 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
>   	struct bpf_reg_state *reg;
>   	bool rw64;
>   
> -	if (regno >= MAX_BPF_REG) {
> -		verbose(env, "R%d is invalid\n", regno);
> -		return -EINVAL;
> -	}
> -
>   	mark_reg_scratched(env, regno);
>   
>   	reg = &regs[regno];
> @@ -22070,6 +22044,14 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>   			verbose(env, "unknown opcode %02x\n", insn->code);
>   			return -EINVAL;
>   		}
> +		if (insn->dst_reg >= MAX_BPF_REG) {
> +			verbose(env, "R%d is invalid\n", insn->dst_reg);
> +			return -EINVAL;
> +		}
> +		if (insn->src_reg >= MAX_BPF_REG) {
> +			verbose(env, "R%d is invalid\n", insn->src_reg);
> +			return -EINVAL;
> +		}
>   	}
>   
>   	/* now all pseudo BPF_LD_IMM64 instructions load valid


