Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF036390CA9
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063175; cv=none; b=O/tdBLEXjGtr6oAmXhB/AriUiF61tKdEcz/YtAuVipOlQnF0o4gTwon4HluTqsCsWNgTyB0LB4r8jiU49BjPflTGjV3UhTeYJuUy63QTaDZfVU0dUMQItLBrzEkDbqiJ8Ot49aAswGkgDBmw/h1c/Ks28f4/NiXh2MI6YePKXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063175; c=relaxed/simple;
	bh=ajkOXEKH73kt4DPUpKvbpi/n5AasuiLNVw2lzF41dAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mErzMCaECYIhHsc2Hk/2q02Xe3+d72EnbeOkJfNLtmFEe2U1RCUlbgHcUoYPsavd5LmCI5f4UWB4cqBZd2mbIyVZbkeiNaUDWoBW/148kJ/ixo2zKbFgvVXODbO3+EOzX84rzapMXeqHucj0/lcc+9Uz2aYC0aV8SVVFEOkhwNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLmd6zo5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLmd6zo5"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso5760f8f.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775063171; x=1775667971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZ3dStir4Do3x8LG44qHlbjbDwCzw8kuHr+WpBKDpYM=;
        b=JLmd6zo5aLrc3auNeOjVNhGkdZO4Nmq9onye0PmX0pbr8oSCiSTjAgm3GEIGFdbp8s
         nnp9/pjxol1LjMtUrPwK3IvQ4C8TpQTDuQ4gq9OtqlHYXWfmQZtCRVjin2QqxINaAuab
         e3MuxkR8mC9QMTh/OGQVJf2tJmilDcx9I9eVsnxSP69g5SZ3v92Hh9B0UaqW/ycQWKNj
         XcUL435bJzh8CafdRgFPWSwf4KRpBnAUaem9VQUfxLmFUv7evJkm4XuWFF3/CcPXhbPe
         rsthR7iU0RyASJKlBe518kipC4MuhdpmxV4lbS/5Bz6bxQjoLnKfL5TScURD8GPMpbdu
         8L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775063171; x=1775667971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZ3dStir4Do3x8LG44qHlbjbDwCzw8kuHr+WpBKDpYM=;
        b=LG4EatcVccXmHBH0zmONRAoJCUMffnJYQNblbwFXjnpZGlZzmQT3YGXc+Ejb0OYLAm
         yTaH53NTrohBWp6SrTLslvWXLre2JScUTne2jzKueujVu2uA2wci5rKfizEPpFoiC7mS
         LH6DKTB/jXwa4xUdsvcj0GhfQ1t/xIdjPXT1/EJKvm3d1z6/5PiMJuM0hon8y1fBBiBs
         AR9X5wrYOUX+O1XgrovzwMp5HA2jLt/3dMtdALbVaj1gojTPI9q9lTOJLMDhhvXQ7UyT
         ntN8xg5f0Dr69aJz4l7TzCAcMg+R0zxBFKEmaIWLTpeol0nA9cxA4KMoAgo4xbqVKDv2
         4t+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3XtF1NWG8dVN9CFYOvgY8HSpu/3JdOhrGJoW5EXEPLMi0xGTpRN1mldT0/cxd5O3pSLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/jE1NGunuoBFYNrghvfNZJ7TWpQQfdTTcY2vJ+3xt4/NbAvE/
	IRgYW6eRxOvk4bwOkYC6SeFBBBKhZrNn05SLapnteF1cJahcjRCO9cgOvA+7sM0Z
X-Gm-Gg: ATEYQzyf7TdqzATubv1Gy7uKBN5qHw2zMcmeYeytps24je4vx2dJ+Tax6jBJJnNWEPk
	MTA/7b9qrvSLr4eWsG9Ta/vln1HUEvreDYW5fvLyHXebbeSKjk9F/iQkc2BCF2brwqgeqJjNZ/T
	E6AIl1qYVPWB8pHh+WjS/r8+ZEi0GfjZB/ltLWyG+Yhmq9tbMOYBVniBzVa1dxp0b3qeob29Esy
	yodVP+wyI/TBTOs8S/7SUII5vL7y7srygU+lyJie44r2NoaZ+bZMWaOSXy9vVFdB+HkhgWfBRkB
	6ZRubthlReLvxf9GoGzzGdYKFT4ULN3LngaJbi+YDSBQG1obzEsgdyWsqrBeeis2FYy6lHuNCNT
	+w9rhkNuny/33noQhOG+MnD1pf85dpRCXYMu1HixfvCDbJLTV3Cn2krvXfUPQ6pMshf8rWXLcB6
	TMfySKhPh1xEGs8wx5259xgDdJEqJuvIltGWa7rs85aPanC/i4lA5iI39XKyaV
X-Received: by 2002:a05:6000:3112:b0:43c:fd7a:e757 with SMTP id ffacd0b85a97d-43d150de778mr7388932f8f.45.1775063170771;
        Wed, 01 Apr 2026 10:06:10 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:ff4a:fb29:5217:3697? ([2620:10d:c092:500::7:b4a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d27a8sm1166865f8f.17.2026.04.01.10.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 10:06:10 -0700 (PDT)
Message-ID: <4e615056-b0a7-41dc-9560-8269cd3eafcd@gmail.com>
Date: Wed, 1 Apr 2026 18:06:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/6] bpf: Sort subprogs in topological order
 after check_cfg()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
 <20260401021635.34636-3-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260401021635.34636-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/26 3:16 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Add a pass that sorts subprogs in topological order so that iterating
> subprog_topo_order[] walks leaf subprogs first, then their callers.
> This is computed as a DFS post-order traversal of the CFG.
> 
> The pass runs after check_cfg() to ensure the CFG has been validated
> before traversing and after postorder has been computed to avoid
> walking dead code.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   include/linux/bpf_verifier.h |  2 +
>   kernel/bpf/verifier.c        | 83 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 85 insertions(+)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..4f492eaad5c2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -787,6 +787,8 @@ struct bpf_verifier_env {
>   	const struct bpf_line_info *prev_linfo;
>   	struct bpf_verifier_log log;
>   	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
> +	/* subprog indices sorted in topological order: leaves first, callers last */
> +	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
>   	union {
>   		struct bpf_idmap idmap_scratch;
>   		struct bpf_idset idset_scratch;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3ec786361698..432806011d47 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3742,6 +3742,85 @@ static int check_subprogs(struct bpf_verifier_env *env)
>   	return 0;
>   }
>   
> +/*
> + * Sort subprogs in topological order so that leaf subprogs come first and
> + * their callers come later. This is a DFS post-order traversal of the call
> + * graph. Scan only reachable instructions (those in the computed postorder) of
> + * the current subprog to discover callees (direct subprogs and sync
> + * callbacks).
> + */
> +static int sort_subprogs_topo(struct bpf_verifier_env *env)
> +{
> +	struct bpf_subprog_info *si = env->subprog_info;
> +	int *insn_postorder = env->cfg.insn_postorder;
> +	struct bpf_insn *insn = env->prog->insnsi;
> +	int cnt = env->subprog_cnt;
> +	int *dfs_stack = NULL;
> +	int top = 0, order = 0;
> +	int i, ret = 0;
> +	u8 *color = NULL;
> +
> +	color = kcalloc(cnt, sizeof(*color), GFP_KERNEL);

It looks like we are using GFP_KERNEL_ACCOUNT consistently in verifier, 
should this be different?

> +	dfs_stack = kmalloc_array(cnt, sizeof(*dfs_stack), GFP_KERNEL);
> +	if (!color || !dfs_stack) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * DFS post-order traversal.
> +	 * Color values: 0 = unvisited, 1 = on stack, 2 = done.
> +	 */
> +	for (i = 0; i < cnt; i++) {
> +		if (color[i])
> +			continue;
> +		color[i] = 1;
> +		dfs_stack[top++] = i;
> +
> +		while (top > 0) {
> +			int cur = dfs_stack[top - 1];
> +			int po_start = si[cur].postorder_start;
> +			int po_end = si[cur + 1].postorder_start;
> +			bool pushed = false;
> +			int j;
> +
> +			for (j = po_start; j < po_end; j++) {

Is there a chance that restarting this loop every time from po_start may 
penalize performance? For example some very big BPF program with a lot 
of different subprog calls, perhaps autogenerated.

> +				int idx = insn_postorder[j];
> +				int callee;
> +
> +				if (!bpf_pseudo_call(&insn[idx]) && !bpf_pseudo_func(&insn[idx]))
> +					continue;
> +				callee = find_subprog(env, idx + insn[idx].imm + 1);
> +				if (callee < 0) {
> +					ret = -EFAULT;
> +					goto out;
> +				}
> +				if (color[callee])
> +					continue;
> +				color[callee] = 1;
> +				dfs_stack[top++] = callee;
> +				pushed = true;
> +				break;
> +			}
> +
> +			if (!pushed) {
> +				color[cur] = 2;
> +				env->subprog_topo_order[order++] = cur;
> +				top--;
> +			}
> +		}
> +	}
> +
> +	if (env->log.level & BPF_LOG_LEVEL2)
> +		for (i = 0; i < cnt; i++)
> +			verbose(env, "topo_order[%d] = %s\n",
> +				i, subprog_name(env, env->subprog_topo_order[i]));
> +out:
> +	kfree(dfs_stack);
> +	kfree(color);
> +	return ret;
> +}
> +
>   static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>   				    int spi, int nr_slots)
>   {
> @@ -26274,6 +26353,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>   	if (ret)
>   		goto skip_full_check;
>   
> +	ret = sort_subprogs_topo(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
>   	ret = compute_scc(env);
>   	if (ret < 0)
>   		goto skip_full_check;

