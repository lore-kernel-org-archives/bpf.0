Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1463ECBEE
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076936; cv=none; b=NR1jrDvtgxPEloWDkjwSIg9G9+iSjF0uwOXlEPMdI7g2iCDW9j2E7CmOmq/Tv5plq7yan6SjVsNARnGsPxCXBUaH8/Yke+Yt1cuL1pep8D8cm5lXpN90FOmue3NJ9YnBP17App34y/2q+Fkub5JwYY3F8e6ZS2bduZ09tGBeu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076936; c=relaxed/simple;
	bh=gMhr3ZdeBB/k2u9IpfotCM/7puJUP5X4j5k+2W7E5L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs0V1BTXxana4/UkhG1no4feZ6YS8kjL9sSDG4MGKtabdQAWxc/HxziFVetp/cEdvj7lol9epZ8tlfT5vi8ijBQNyzcpsrHq0NkjpQhFSVY3RnEIz7+DCFeiQMgcuqWwMUfIKrSswoSgRdbjd7J2Dbh8HJn/H+t4crBqLH5flbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfBLKUfl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfBLKUfl"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439ce3605ecso3323358f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773076933; x=1773681733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=popiN9giVNSxFEXNtoVkUQBWgWnWRyzWI0B1NJHLewA=;
        b=cfBLKUflY1XYxeYboF0/rctJC5VcwgSi6Ic7FNwcdRyqEWHlp+yzgP8CUXUOxkihs0
         LvIlj309PDT/pCsMlSwvnrcCND5+LEhrW7CELIi3soJHNoFtZoV8tEwBviebP5GcknMH
         qJEA60GbDKUh/K4oUZhFTKNR56dxV5Vo8ec9L07eNXEuDinUMcpKpSr4XcO0GfYuB8wm
         JamN7j0VzgdFOrrjA8Gb+UlWPPNPOg9fr7oxamSryMrlaW8lMItX8InlbWvWB2QeeIWp
         ClOIis6uitdtiWTwO6q/w3YySRcv4nCk68LItMwp1/lT1jdziSPBpbNu5wugxf6OL7ah
         GWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076933; x=1773681733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=popiN9giVNSxFEXNtoVkUQBWgWnWRyzWI0B1NJHLewA=;
        b=IAmU9qQaZwjbmShj95mtNAU4uniY6txKsSQQVUy21etj6Tff84I66vsMmrYBrpn2yJ
         hVIxjq6VQkZoKXXSGV6LyJ07seKwPtSZoza5wcaIn58w6hRSaLg6qavpEwgRcGYgLjqL
         +EuRh5CAIKSc8ZaVNK21yPN31OSBJKpHYxNzyFXtgk5+QhRWHAFqNNVLxpRzRNNnWglD
         kaesBoQfOcdhzRWw9xXV2bwXJEaWKtSoXcn++Dg3b4LNAI9A6E7d9SBGxLQpyHKMBCwy
         FqtWJzHQUbvILlvONFy59NidORtiBY5o4iDA6lizdnE4hH0Z6rULCqFrk6nbNVoFPylz
         eiBg==
X-Gm-Message-State: AOJu0YwkAg6jfkTrWRZ/2n7ANRzm0kXJXagQF//2xnahemkbFdKQbIrj
	7sp8HSvAAoHumSBbE5AJrYLVooALezbokbEZDyXf/k+uQo2rHvwUKso9
X-Gm-Gg: ATEYQzzoasreYvCpBiMamxHQr6LTOSdy6JWl+jaXtSYpuCozJEjR1B0fR6Tf5Ejy3sJ
	tNvalX0SLPsGTo6u2h5wDMuLOPDdGdZe5zEwqoWaTsdNKlyY3ooAXZRtP+wTv/O7igRNdiW0gE7
	tXIJWHgbxOKKtUYTyRxLDyqQ02Vc5CI9NVUl43ZCDQ9VEGHFJ+IZxck+BsTxucEhSo9M5eL+3Np
	n86MlUVcm9qBEZf9kYi4i1fTwllwNPtvaQM5nvo8a9L9pEpHmRWsJisI7pPUWSgsYQLIIUg7YU2
	NlvlkLariTXFMBJX9SVcS1GM900X+Utk7SQCQ2Fu8ZumzWo8TmP9w82SUHqp1uR6N+qlRSXt309
	KkymvvcZMG/Y4orrErsGyxil9GeSKvAIyFH+LosP/C+cnfy1XpGPIUqjm5+gMdhkIMwT2VW8L+P
	kJqa67ifr8FdP5mbIZwOSXVFO6R+WKSJUf
X-Received: by 2002:a05:6000:26d1:b0:439:b486:ba6b with SMTP id ffacd0b85a97d-439da89401fmr21299511f8f.39.1773076933239;
        Mon, 09 Mar 2026 10:22:13 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae49177sm27108030f8f.35.2026.03.09.10.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:22:12 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:30:45 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: Re: [bpf-next v8 3/5] bpf: Add helper to detect indirect jump targets
Message-ID: <aa8DxUESQAI/zAEs@mail.gmail.com>
References: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
 <20260309140044.2652538-4-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309140044.2652538-4-xukuohai@huaweicloud.com>

On 26/03/09 10:00PM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> Introduce helper bpf_insn_is_indirect_target to check whether a BPF
> instruction is an indirect jump target.
> 
> Since the verifier knows which instructions are indirect jump targets,
> add a new flag indirect_target to struct bpf_insn_aux_data to mark
> them. The verifier sets this flag when verifing an indirect jump target
> instruction, and the helper checks it to determine whether an
> instruction is an indirect jump target.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/bpf.h          |  2 ++
>  include/linux/bpf_verifier.h |  9 +++++----
>  kernel/bpf/core.c            |  9 +++++++++
>  kernel/bpf/verifier.c        | 18 ++++++++++++++++++
>  4 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05b34a6355b0..90760e250865 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1541,6 +1541,8 @@ bool bpf_has_frame_pointer(unsigned long ip);
>  int bpf_jit_charge_modmem(u32 size);
>  void bpf_jit_uncharge_modmem(u32 size);
>  bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
> +bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struct bpf_prog *prog,
> +				 int insn_idx);
>  #else
>  static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>  					   struct bpf_trampoline *tr,
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..6431b94746cf 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -578,16 +578,17 @@ struct bpf_insn_aux_data {
>  
>  	/* below fields are initialized once */
>  	unsigned int orig_idx; /* original instruction index */
> -	bool jmp_point;
> -	bool prune_point;
> +	u32 jmp_point:1;
> +	u32 prune_point:1;
>  	/* ensure we check state equivalence and save state checkpoint and
>  	 * this instruction, regardless of any heuristics
>  	 */
> -	bool force_checkpoint;
> +	u32 force_checkpoint:1;
>  	/* true if instruction is a call to a helper function that
>  	 * accepts callback function as a parameter.
>  	 */
> -	bool calls_callback;
> +	u32 calls_callback:1;
> +	u32 indirect_target:1; /* if it is an indirect jump target */
>  	/*
>  	 * CFG strongly connected component this instruction belongs to,
>  	 * zero if it is a singleton SCC.
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 88a1834030a0..ccc618a50103 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1480,6 +1480,15 @@ int bpf_jit_blind_constants(struct bpf_verifier_env *env)
>  	prog->blinded = 1;
>  	return 0;
>  }
> +
> +bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struct bpf_prog *prog,
> +				 int insn_idx)
> +{
> +	if (!env)
> +		return false;
> +	insn_idx += prog->aux->subprog_start;
> +	return env->insn_aux_data[insn_idx].indirect_target;
> +}
>  #endif /* CONFIG_BPF_JIT */
>  
>  /* Base function for offset calculation. Needs to go into .text section,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fc3ba380b74a..8d8e349f98cd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4022,6 +4022,11 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
>  	return env->insn_aux_data[insn_idx].jmp_point;
>  }
>  
> +static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
> +{
> +	env->insn_aux_data[idx].indirect_target = true;
> +}
> +
>  #define LR_FRAMENO_BITS	3
>  #define LR_SPI_BITS	6
>  #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
> @@ -21082,12 +21087,14 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>  	}
>  
>  	for (i = 0; i < n - 1; i++) {
> +		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>  		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
>  					  env->insn_idx, env->cur_state->speculative);
>  		if (IS_ERR(other_branch))
>  			return PTR_ERR(other_branch);
>  	}
>  	env->insn_idx = env->gotox_tmp_buf->items[n-1];
> +	mark_indirect_target(env, env->insn_idx);
>  	return 0;
>  }
>  
> @@ -22013,6 +22020,17 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>  		data[i].seen = old_seen;
>  		data[i].zext_dst = insn_has_def32(insn + i);
>  	}
> +
> +	/* The indirect_target flag of the original instruction was moved to the last of the
> +	 * new instructions by the above memmove and memset, but the indirect jump target is
> +	 * actually the first instruction, so move it back. This also matches with the behavior
> +	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to the first new
> +	 * instruction.
> +	 */
> +	if (data[off + cnt - 1].indirect_target) {
> +		data[off].indirect_target = 1;
> +		data[off + cnt - 1].indirect_target = 0;
> +	}
>  }
>  
>  static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
> -- 
> 2.47.3
> 

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
