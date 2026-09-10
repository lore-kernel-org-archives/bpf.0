Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38544474273
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040018; cv=none; b=Nus4ztcqRH4N+zBAbbU55EXWAU866OxUqNhPp2viZ2VKnOApA/TQFxdoj0JUsTjLxYHvTgBN0uUBr7LjBosTHY5bOXE2lzHEZoXTWSNXHCbynzR8YH0HeqrXmXf7+p7HowQRYZF96aFEXdglaaoMvluMIbClYolMEB149I9BZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040018; c=relaxed/simple;
	bh=Z06eMqIsD+L43P7WyrWfszlPwT12T1sUYvXtnxLu68c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6f3pXmdV1mXdrq5x+5xaFvOuBNOMRbEJxCVewaeroEd1bwrpDcgHcnDlotPWqA7/P3ApBtuRoSB8x5VNcrC8AI61nZH0qLow4Fy3kGUV8HBESXkjD25IOZMeDQIpuiSYNP943LdwK7xqFS9tw5WPah5PdXtlvrmQkrqpnxY0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnffSkns; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnffSkns"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-486e39e007bso236732f8f.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789040009; x=1789644809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ghDGXeTbn5eF1L8/zIRXg3GSvezH8dj4Q9ELzRlBVfg=;
        b=rnffSkns4wr4vt/LQFJyfR/yNDjURJKdxrEntItaqGRk5F894xhsQTayJ3kmeG3W+h
         Si3gaZ10ZLjWC9oni25j0LyFQb9oT93CfbN843XcxO5Iv290ZxynArEnSyrCP2OS+gAf
         +ZICrKQT1lyxNJaDrWNwx2XacTblOQ/JJCscURfywZqrh1sZkmP1okKjadiy1DNOW5Yw
         m1xCJdVNpQgDEVxW8kgCnf7JBAIjRi9oBi674VWk6pcDSnofnxP8R5Uk9oLcsiL8GIjJ
         cXkTM+D5UChQY+UoL9icFgY8zp/4J6+PwbgOUkvbDHFPWR1gAV11xNxFzh/CbcBd5lW/
         0nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789040009; x=1789644809;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghDGXeTbn5eF1L8/zIRXg3GSvezH8dj4Q9ELzRlBVfg=;
        b=kTyM+okh5Ai5fz1erd8h+dhfECGex/hREXmMUp/HsvUSX+hHzhmnpredS+zvWs2rzL
         xdWy6AmLN8FiAx3/BY01a1zz+OX8JLYt/ISiEgGQqG0+FbmRUBPzfSu5KblcwGZs8yE0
         /35V+B+vGfSJZviYX5JXDO22pRDg++arAJ8bPOw0G3QpMwihRDgtSrcwbZvr4wa4W2P+
         uvXh37tqtO+SxcvdkBeQcXLoNklRUQmlP2z1vLXxXkWO8oKnqTNjDOAJ4Mb2TIQAlaZ5
         hSaQFXkANzNSzq2Ez0JJ7piJ0Wt28Gg2pMM4+5506b1On+yx8xpy0ghzNxprU/RwFt9G
         /iVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcQ9ZKGI4NYJHw5guFx4IZt8rChwAsF3LcoT7yOf+1p6SqE7GxWONKjLjWIJ4/7ECkDfU=@vger.kernel.org
X-Gm-Message-State: AFuF++kd+7SjZ0NhcTakNfVGOWqEENq9ywMmVs4GwslQGkMew4qpypnp
	zzSJZ9RgztXiM9T/tdVPvdLaUZmp57L0fIsp97CguWmpwGNHM9QJ4kzJ
X-Gm-Gg: AYBFou0rp/7HmEv9H3KCupXMUrvREw1Ua82QXs29Rl62XcdmTZP2K7g1exfkzIBkTmu
	ev8+KYI6QJew6Zl+Cw3vt6pDejPjysxN5xbRUpng+ZJDQimsEgBkFTqZZP2N8GFXuBMoVLFgwtl
	ly4NGi8NNfuiMMeK95/bRbrhSUEED/X0fvQvUeHn2iHiSf3xb+RniGwY3RKUgVTjy7/NKa4RNdu
	z8Oa9zUzpDvf4fgqCJWKXvbc1/RSNtb3eLm2+0H2yJCz+MoM6H8YX5EQcAGkFvWV2IwMQqgw4/L
	gZIgnD+EpKc9GCksUPIH/kUOqHxwks1T+n+h8QEdDHNgbSStX6zIh9DN0OvyvgTG9f7fLhimGnW
	mo1WGPvIxsGRTiCEVIxyrgFTzi8Bki6wgGb/TljhKWd4poia4H2tHXoWJg9tljGDkzjMmoU829t
	0luPIBRTn9QJtQIiaFcHv7uFAfFHmu7om5qh+WndAsQXqd10r0wL2yfxXD26RRTNzJJ09eEDZQ4
	RXqnzm9jVc/hmxs3Q==
X-Received: by 2002:a05:6000:1785:b0:485:91ac:434f with SMTP id ffacd0b85a97d-48591ac44a5mr32533845f8f.16.1789040009043;
        Thu, 10 Sep 2026 04:33:29 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c81c3sm51410433f8f.26.2026.09.10.04.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:33:28 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:44:07 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, memxor@gmail.com, eddyz87@gmail.com, info@starlabs.sg,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf 2/6] bpf: Bound the number of indirect jump edges in
 a program
Message-ID: <aqKYB0d-2HrQOswL@mail.gmail.com>
References: <20260909204035.24289-1-daniel@iogearbox.net>
 <20260909204035.24289-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909204035.24289-2-daniel@iogearbox.net>

On 26/09/09 10:40PM, Daniel Borkmann wrote:
> Every gotox instruction gets its own copy of the jump table of the subprog
> containing it, and each distinct target in that table is a CFG successor
> of the instruction. The number of such edges is therefore the number of
> gotox instructions times the number of distinct targets, and neither
> factor is bounded by anything except the instruction limit.
> 
> What is expensive is a BPF prog whose gotox instructions are themselves
> the targets, which makes the edge count quadratic. 1024 such gotox are
> already ~1e6 edges and about 4s of CPU to load.
> 
> Bound the total across the program at BPF_COMPLEXITY_LIMIT_INSNS, aka
> the limit as the number of instructions the verifier processes. Progs
> with real switch statements are orders of magnitude below this.
> 
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/cfg.c             | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 36b65797877d..04bb8f71cabe 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -977,6 +977,7 @@ struct bpf_verifier_env {
>  		int cur_stack;
>  		/* current position in the insn_postorder vector */
>  		int cur_postorder;
> +		u32 gotox_edges;
>  	} cfg;
>  	struct backtrack_state bt;
>  	struct bpf_jmp_history_entry *cur_hist_ent;
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 081f7003eae6..e9910228da58 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -9,6 +9,8 @@
>  
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
>  
> +#define BPF_MAX_GOTOX_EDGES	BPF_COMPLEXITY_LIMIT_INSNS
> +
>  /* non-recursive DFS pseudo code
>   * 1  procedure DFS-iterative(G,v):
>   * 2      label v as discovered
> @@ -388,6 +390,19 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
>  			return PTR_ERR(jt);
>  
>  		env->insn_aux_data[t].jt = jt;
> +
> +		if (check_add_overflow(env->cfg.gotox_edges, jt->cnt,
> +				       &env->cfg.gotox_edges) ||
> +		    env->cfg.gotox_edges > BPF_MAX_GOTOX_EDGES) {
> +			verbose(env, "number of indirect jump edges in the program exceeds %u\n",
> +				BPF_MAX_GOTOX_EDGES);
> +			bpf_diag_program_structure(
> +				env, t, "too many indirect jump edges",
> +				"Reduce the number of indirect jumps, or the number of distinct targets they can reach.",
> +				"The program has more than %u indirect jump edges in total, counted over every gotox instruction.",
> +				BPF_MAX_GOTOX_EDGES);
> +			return -E2BIG;
> +		}
>  	}
>  
>  	mark_prune_point(env, t);
> -- 
> 2.43.0

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
