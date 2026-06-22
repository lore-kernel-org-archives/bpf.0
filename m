Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BFF3101B6
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140289; cv=none; b=XqB51oS/LVyIFIr4Jr1LwDsf4YSLttV33vdcQ9QFmXyPO2nq7pFNUb7S1oVbfKbxghkHShFYpyqCr+tCuVnnqDOIrmFZ5VmlkDEApdDoJPxerA/d6R0Wqh/dPxQC5wzzWIyyXjVMuhWrzaNhtBsSbNB07y0jhvWEyIZR/oYegco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140289; c=relaxed/simple;
	bh=k28+ZIV2l5YWcgHsEzl4opaw1tbnkXbA/EEb1aiO1qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK9zXuAjNBHXojo4H52J0/Kr1h7QcdrWALP1AAc3ceP60gHo/QLy/YDCEuoiqI+5EzBp6GYx3zEvfokeNCt99liVjTy6JErrkEaeH9mXArvGM1qY/Y1twkxnc90qkQ0Oh1G8Z08nKuVK6dYC0NMSHi0KfxlDAlHdFDp+RIUliz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ssml1LFe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssml1LFe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso46808165e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782140286; x=1782745086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fezmz/BGRlRBwNLlrK8/Pu93nh9Kq6eKRwwsJESYo0=;
        b=Ssml1LFeFKEqZ0sDnVVK2+DjoK+Wc5rOcLsSGE74gwnFinoQGlvQkDnfNg1OUBLSHi
         CYfaZPny3LDPqzgyfee248VGqhcCaR9fGQDqJOkCl62nga6Z0Q2sMVFsvr3P6mI3YRDh
         9Zmc0Dd0xxs81HNCCbRin4wB77sCVEw5VndivQWwgjuLhzC6Bt02ualjT9+iWQD/vit/
         ahPLqqRbCMdI1S1LDtjF5T+xD4umZPgv8lLm0/kXFYQCATnT7sORkpsCK5M8IjRd9nuV
         mg6mMnr8wizcT7pk36fG83buqBMX2XGP/vmFQKmUd1Jd4sn47CH/jfe76B6ZIwk1MhOo
         kyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782140286; x=1782745086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fezmz/BGRlRBwNLlrK8/Pu93nh9Kq6eKRwwsJESYo0=;
        b=X6WCja6rAyQJp9Yd06CfI+Hsb+bkOhU0hb1qS6VJjcOAmuEGRObfQeXE0/pvcop12h
         q1UcPmyDpEplS0vO77UOVJFyJj6aXTgI1NC+VbUTMrDuw7lZxFDqYzOn9XwTYjPQSP2p
         eyx3iZVLSbo3QQJs5lbrUbqFaHqrYINGgZ3BAx10SHT5GuayvDNz7str+YbaY7wJaMxM
         ndHfi+4gy0a3NNg+5E9k06CR2OSmWxndNCwPVaP/28SBrDdtsY8XAXFTJZY0LCUJT72M
         0UotMhOL3ktGoitSjdlwdRiyvm0/9U7C+Vkqu484u2m2d0INr3mNPqV2LKGJeKqWkxmM
         o3WQ==
X-Gm-Message-State: AOJu0Yxh1ZzfrCtUk3ggt1uFghvGrDdXn6vDo2/V3+1dwlIdsjk9tsPS
	ZgNDt5Hmhk3vYWdB68J48F06dQG7Q9KElgnSfucZV0ONzCY0ADakfIqm
X-Gm-Gg: AfdE7cmWELb4SbsrLhWqDVOBFJixKhQwIZtd7xNBSyHE4kmjeiXGHaVlva+cVZ6dZB+
	VTkpZPVM+HLQj0yi+/fVvZ4dHLvihzHolJpW66xcRdHtBK0b5rRg1e2ZfuDJ9OvjeiQA3czPSdk
	ekLfdGRBRAo/JaMKdzusDWJft+CyIf2YAYbUVOqvW5soAI0U4eqHyeIhbuznLEQ0wZYz7FVI7Wz
	f5PSCjOjKbtyWinqDxcT49Dp5gVZZz/sE2L9kyLsmm2n9QY/Y330BUqgyJEFYCTNIKkP7wG7ohg
	xjEbURq9pAzdcDI2ubHDR6WLZHxoAu1tbuFHthWphK+HtyQJI2FpfwkRVouFkQBPa8Ml0DC1CdE
	vbypo77w1fdv4UyVTgz3Ru+U5ehwX7JzIAyE5Uc5S7Ot0s8x0+YPSty7IRzePUIDj5UPQzpCLWf
	n6KaSDQdVb+13Pq/so7JiDsw==
X-Received: by 2002:a05:600c:5489:b0:492:4668:27b5 with SMTP id 5b1f17b1804b1-4924668299emr206920795e9.6.1782140286009;
        Mon, 22 Jun 2026 07:58:06 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46667221da1sm26522740f8f.36.2026.06.22.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:58:05 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:08:03 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Enforce gotox targets against
 subprog bounds
Message-ID: <ajlP057yizpEQJ0r@mail.gmail.com>
References: <20260613-f01-02-gotox-bpf-next-v2-send-v2-0-ff980bc5a329@mails.tsinghua.edu.cn>
 <20260613-f01-02-gotox-bpf-next-v2-send-v2-1-ff980bc5a329@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613-f01-02-gotox-bpf-next-v2-send-v2-1-ff980bc5a329@mails.tsinghua.edu.cn>

On 26/06/13 05:33PM, Nuoqi Gui wrote:
> CFG construction records the modeled gotox target set in
> insn_aux_data->jt. It includes INSN_ARRAY maps based on whether the map
> target is in the current subprog. check_indirect_jump() later validates and
> follows the current PTR_TO_INSN register's actual INSN_ARRAY map. The
> verifier does not check that targets copied from that map stay inside the
> same subprog as the gotox instruction.
> 
> This lets one gotox instruction observe two different INSN_ARRAY maps. CFG
> can select a map whose target is in the current subprog. Another path to
> the same gotox can carry a PTR_TO_INSN value from a map whose target points
> at a different subprog. The verifier then accepts a cross-subprog edge that
> CFG construction did not allow for this gotox instruction.

Functionally, the patch is ok. But IMHO the commit message is too complex.
Please consider making it shorter, if it will be respinned.

> On x86, gotox becomes a raw indirect jump in the JIT image. Accepting a
> target outside the gotox subprog can enter another subprog without a
> matching BPF call frame and crash when executed. Validation observed a GPF
> in bpf_test_run().
> 
> Fix this by requiring every target copied from the actual PTR_TO_INSN
> map to stay within the subprog that contains the current gotox instruction.

'the subprog that contains the current gotox instruction' -> 'the calling subprog'?

> Reject the program before pushing verifier states for any cross-subprog
> target.

Is this sentence needed at all? ^

> 
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index eb46a81a8c51..98d3fa2f162a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17145,9 +17145,11 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
>  static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  {
>  	struct bpf_verifier_state *other_branch;
> +	struct bpf_subprog_info *subprog;
>  	struct bpf_reg_state *dst_reg;
>  	struct bpf_map *map;
>  	u32 min_index, max_index;
> +	int subprog_start, subprog_end;
>  	int err = 0;
>  	int n;
>  	int i;
> @@ -17188,6 +17190,25 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>  		return -EINVAL;
>  	}
>  
> +	subprog = bpf_find_containing_subprog(env, env->insn_idx);
> +	if (verifier_bug_if(!subprog, env,
> +			    "gotox insn %d is outside subprog bounds\n",
> +			    env->insn_idx))
> +		return -EFAULT;
> +	subprog_start = subprog->start;
> +	subprog_end = (subprog + 1)->start;
> +
> +	for (i = 0; i < n; i++) {
> +		u32 target = env->gotox_tmp_buf->items[i];
> +
> +		if (target < subprog_start || target >= subprog_end) {
> +			verbose(env,
> +				"gotox target %u from map id=%d is outside subprog [%d,%d)\n",
> +				target, map->id, subprog_start, subprog_end);
> +			return -EINVAL;
> +		}
> +	}
> +

This could have been a helper to share code with create_jt(),
but looks small enough to keep it as is.

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>

>  	for (i = 0; i < n - 1; i++) {
>  		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>  		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
> 
> -- 
> 2.34.1
> 
