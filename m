Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C85232470A
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275384; cv=none; b=YR26mNrB8gZ2PFYq/H9pY/QesMrM8j7RboWCaRyk72QbCTv5gamstfryibBfheUf50qMFP9dhURVph3iZCFo/H/alKtDJUGxqL8r2ghr7ZdcYrAEjdPc+BSru1psPksw0v8a86Jn7XjZu38QW4+UBrZwRjqEfNP3Kyn54Wma4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275384; c=relaxed/simple;
	bh=30GgcY6UW+M9qOh+90q1PY6I7u9QtU+KWstA8AMAoSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hTNlbIa9MdmR4ZxNxbBInBDUwhSV9c179PQG/kxvU5dsSXElocn2q5s59UKJ1/VRSk5T0ImwNfOBtLTx1GzoH3dolLjxeTYtWtz4NK5BlGJ1aYvVNHykKJ+6CD079CGcdSbzfao1vP2FaTpBwcihss5sXOTqZM3XgY3fW/NwxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9VUoraL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9VUoraL"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fb14227cso1810515e9.3
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774275382; x=1774880182; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lM3zxBG4jnlTh9eoP4afFD1w/5HJMGWcFKGiqosUU0=;
        b=U9VUoraLV0xkVUtwVavhVIi1XwpJqHTeqGnJ2epl3zDpSd+vvjVEAxlB0HNQjEmJRO
         GfB9TyuOKkCumdotwKuHiHiUM5s8m+FciEVfrh2ddlTPlJO5HKSSqlBVmpEdfdTEdLXP
         ps8T5qzEm7j76rcAFnNSQhvkVnWeYuj2PZYFM5LwGAOxoZARs/CHd8T4eu0i8sx9XLxs
         t8zycZnEStiyctJy8V/tyiZsxqv2gAO+LQUxToMvq8AW6Y+839md0d+AcRcNnsrg5jci
         OkOcphwP5bE6oeaKpVflyje7F4Jd7yQPkCFghC7XOV+sFaEdHNZzX2mFubtNIZ7R2o6T
         v+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275382; x=1774880182;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lM3zxBG4jnlTh9eoP4afFD1w/5HJMGWcFKGiqosUU0=;
        b=sVZvThjXYN1wHx5enHJ+xsSXC+W+ZOZHTu3BFtPUL0tnVVEynY8WJ9x3O6qarizm9y
         nHOTvERcLacm0h49nnCO5Q/saueO4OpxX1IfjD5BZFvIjRqv8L1bqlE1YE/EKmosG1tv
         CKzRczhwaVtHJKm3lkNRoClLcXDYb67YEZS8uA27eJ6YUp6G2sRxY6xPgY1EuUxZ5McP
         J68eHYOnrir0EovCP1CuvpKtxOUeaIYc0Ohd3V0+V5xiKNZ4tDJR16qsnHOWyv2MWvQ/
         w6z5+ZT3jxLc/LLtiPgEuvTNBuBGbv6Dxgkoqyq+OWqpdg/XvrI47DxfeyHn4U0YHFti
         3Icw==
X-Forwarded-Encrypted: i=1; AJvYcCU58qxGqpp2aZNilXaLJTlcSmJ1ejiy0s3r3kTJkty7aa9I8O3ozubVoRiwDRaCm2MEVF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd2/LH8d2dEaW9DELe4KrPN8baUFbfRlAIXEjI/qYZUfurDr28
	YnK+2y+bfgkrxa6fuj/oJ0e1Kngps79iHB/jZOJRyaK45uVkmoJMsEbm
X-Gm-Gg: ATEYQzxBmcBQWbbHvlqIpvpAwUMZPdngPht9F/CDkRj4p++LO5QLDPE5CFVHJWf35OE
	9kKHolhwolP/FhcOC2vBTnTPIaYVEMKY/prWSCLoGABTy7S9jh5Cfm/CAQvLlnPTDy4D2Y+m8gO
	DKDEhguFIl701NCt5f8TA53gyj9AofTmWCOCprEMQRje7+tiIW2dgltbMdct5Fnj97s4IF5sTOn
	pFK15lf/H9GdPdahKZFkPU+iEMAwCfLX4fbzBeb40OIQAvH0KzBLoFdFYAApBnuKwLKL2h8c8YG
	x+mzVWu9YKy900wtZhpi673C1dKhp0oN14xhAfIGCDW8LZRzYvBqMZQYFO9wqZKj/tgRT9pAJiX
	WyDATo8TYeeqmTY5p1r8NX1yvK8IeKvp1ngElV1aH91ysDtx1VA6SDPOMz9KBqJM1KU/aWaQ3yy
	teUbDEAGOOvii6cSQ=
X-Received: by 2002:a05:600c:4707:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-486fee231cdmr166151375e9.21.1774275381047;
        Mon, 23 Mar 2026 07:16:21 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:a228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fc4d90f4sm391476075e9.1.2026.03.23.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 07:16:20 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 1/6] bpf: Refactor reg_bounds_sanity_check
In-Reply-To: <d328e04c67b520973e295d0f1c2fd88715a6390e.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <d328e04c67b520973e295d0f1c2fd88715a6390e.1774025082.git.paul.chaignon@gmail.com>
Date: Mon, 23 Mar 2026 14:16:19 +0000
Message-ID: <87qzpak4wc.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Chaignon <paul.chaignon@gmail.com> writes:

> From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
>
> This commit refactors reg_bounds_sanity_check to factor out the logic
> that performs the sanity check from the logic that does the reporting.
>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  kernel/bpf/verifier.c | 50 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01c18f4268de..b638ab841c10 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2802,40 +2802,60 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
>  	__update_reg_bounds(reg);
>  }
>  
> -static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
> -				   struct bpf_reg_state *reg, const char *ctx)
> +static bool range_bounds_violation(struct bpf_reg_state *reg)
>  {
> -	const char *msg;
> -
> -	if (reg->umin_value > reg->umax_value ||
> -	    reg->smin_value > reg->smax_value ||
> -	    reg->u32_min_value > reg->u32_max_value ||
> -	    reg->s32_min_value > reg->s32_max_value) {
> -		    msg = "range bounds violation";
> -		    goto out;
> -	}
> +	return (reg->umin_value > reg->umax_value || reg->smin_value > reg->smax_value ||
> +		reg->u32_min_value > reg->u32_max_value ||
> +		reg->s32_min_value > reg->s32_max_value);
> +}
>  
> +static bool const_tnum_out_of_sync_with_range_bounds(struct bpf_reg_state *reg)
> +{
>  	if (tnum_is_const(reg->var_off)) {
>  		u64 uval = reg->var_off.value;
>  		s64 sval = (s64)uval;
>  
>  		if (reg->umin_value != uval || reg->umax_value != uval ||
>  		    reg->smin_value != sval || reg->smax_value != sval) {
> -			msg = "const tnum out of sync with range bounds";
> -			goto out;
> +			return true;
nit: maybe it's going to look simpler if you rewrite it with early return?
static bool const_tnum_out_of_sync_with_range_bounds(struct bpf_reg_state *reg)
{
	u64 uval = reg->var_off.value;
	s64 sval = (s64)uval;

  	if (!tnum_is_const(reg->var_off))
                return false;

        return reg->umin_value != uval || reg->umax_value != uval ||
               reg->smin_value != sval || reg->smax_value != sval;
}

same principle can be applied to
const_subreg_tnum_out_of_sync_with_range_bounds(), which looks like a
very long function name, will something like
subreg_tnum_range_mismatch() capture the idea?
>  
> +static bool const_subreg_tnum_out_of_sync_with_range_bounds(struct bpf_reg_state *reg)
> +{
>  	if (tnum_subreg_is_const(reg->var_off)) {
>  		u32 uval32 = tnum_subreg(reg->var_off).value;
>  		s32 sval32 = (s32)uval32;
>  
>  		if (reg->u32_min_value != uval32 || reg->u32_max_value != uval32 ||
>  		    reg->s32_min_value != sval32 || reg->s32_max_value != sval32) {
> -			msg = "const subreg tnum out of sync with range bounds";
> -			goto out;
> +			return true;
>  		}
>  	}
> +	return false;
> +}
> +
> +static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
> +				   struct bpf_reg_state *reg, const char *ctx)
> +{
> +	const char *msg;
> +
> +	if (range_bounds_violation(reg)) {
> +		msg = "range bounds violation";
> +		goto out;
> +	}
> +
> +	if (const_tnum_out_of_sync_with_range_bounds(reg)) {
> +		msg = "const tnum out of sync with range bounds";
> +		goto out;
> +	}
> +
> +	if (const_subreg_tnum_out_of_sync_with_range_bounds(reg)) {
> +		msg = "const subreg tnum out of sync with range bounds";
> +		goto out;
> +	}
Other than those few nits, the change looks good.
>  
>  	return 0;
>  out:
> -- 
> 2.43.0
