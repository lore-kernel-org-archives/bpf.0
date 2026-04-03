Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD535BDC2
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239375; cv=none; b=uhfjIXVlIgMfVF3+QKT+6tq/yvKg93hnOjJ6SniA9qU6xDuBioePmRIbHu6nsaWZGXSnRlegd6LV5ECkLa8lqbgX+Q4FBD11B8HaAkGYwRy1hJPABP+pp0c9K/PNszh7bKwzjYte48eK8zKFQgkjGv5vrpqlQlBrDcbTWrksu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239375; c=relaxed/simple;
	bh=4MFs4qnlr4W46X0e5ZzkTT4N2qDHUmdeEw3UxBICydg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hyQ770NEWWlDKpian+Zt175VKzPUv6ktfLG+sVs4XwLBD9Q9kvKKhh5eDrBmBQo/hmsWkycNxOjDTywv29YFotvSByKb4NzJEHbAY655tQt3JAzQzm6twvqtwFmB0tSG5zaahV567TvPDEbK53Z+BFEmdw7g70ffmWdz18/nYo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=h2cj7u3E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="h2cj7u3E"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b23f90f53aso19774355ad.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775239370; x=1775844170; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=St1Q+eC0G4ZneHNDCt55t0/J1pND9W4YSxEJDZNyi4U=;
        b=h2cj7u3EdLjm27XssDIkLKUSuJ3Lwi1WF0prXmJkraoP8W4ptCl/wn77ridfTjTeal
         H9bCpRvQftxXPWwRZeUuJahZkCA/HxA7MLZeXtjw8mJ2K890kd6ugLfPWe9TvJyT37J+
         MqSPRB/vc0mkZHX1qazyWLB2olRWvmQqXcjxQXqKNodtlfRUuLjKj23M18Y5sej++xhc
         ABygrt60UdDQz8/Lm8q4CAOCI9pqac3OQXg5XB1FJSohNe+i+vH/VZm5AoKef5qcg2ud
         xau1nmhFhgEM6TC9mEBUWSuS+ZHQpMsow4Sk5IQSQwWsTNVUx29pixs+7eQzNQJt7TBu
         LDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775239370; x=1775844170;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=St1Q+eC0G4ZneHNDCt55t0/J1pND9W4YSxEJDZNyi4U=;
        b=QIg7fkKfqN49YT9Cz3UgoHzQmNnGHZauYR8OU6XDG9ditNi6muD3EM4aEpTVAAu3/T
         Ga2CRbQCtEqJIhySU6uHfRpfW4bPrbrCZJOViTRa0yWTIQ+JSilH5U2RtgisgtrIlAng
         dI3p44YAVNnJt7oa0KguHPIxCOg4bNCwj9kMWf5FxheFqVJyQKo/0UGSP4CXfxxjcawJ
         wCBOWclVCShEPIjxxoI4Iy6iNR9q9UG5Pi57Ov203vwVZTku46YQa9rA7uWr+WZNEXva
         Cvv8zDUTe2fpZ9BzCMPvVr/hLWJ0RsVtYqlhlqKT4hstEh2ZOVyvVSr1GKwefgqXKtwt
         vn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQegYsYEtnYl6bzDoAQ9xfjhEO2ra5zzaCTWWjyc3poYJ/tRIsADclujlTHSjLEhO3374=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/42tVvkRLKeb+e1cxp90VlHNDNIc73GLzKeZnAXJaeS7sKXvp
	RCeFg99NBs5nyCwD408GaIhl1cPHK5rD0UP8M8LmF0ASjHOqoWpJDk5q/SnlUrvN5H0=
X-Gm-Gg: AeBDievrgUdb9kglyzN73PUWjwj5Isv2q9bnnew5cvtKl/gDuiIVLcVXw+vKoNTMqvc
	txn1UzkLHV7D+tDb079A380cfcGbXR90dp1/Fcxd2Ch7x9BcEMiQeTKsGhRFtn3BGTpfFsOQd/X
	0OKBkIjDbkcmZGY4UW8RRQAvEa4wgkRn1hsQ3qEwsgEHy7FyRfTXsi/ppUcH237YGQexpPRU3Zb
	HZDmhX4smDMf3nHCQQiQCPA0u3oZMYhViGJyICRgdM0hx3IsHdv7ByHAXRYWvddqCv8YAICGh3H
	SZHh4JtSvLyMHg3s4SKt55zHlOIpeYfUmU+6Q6LelDC4sVhoI6uUBD0G8XVHXwykEpqCJ9JUA2c
	gR+yhWFOb5hxIk9aSkD4Q0lQbhvCo4ztev7gnlX/Z4tM14Mr6OHVKXtv5fmxPYq9X9vA++3vZEV
	8ZVmjka/U=
X-Received: by 2002:a17:903:1b70:b0:2b0:bebb:1081 with SMTP id d9443c01a7336-2b281799025mr44217265ad.28.1775239369871;
        Fri, 03 Apr 2026 11:02:49 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af26sm63916025ad.49.2026.04.03.11.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 11:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 14:02:47 -0400
Message-Id: <DHJPU2PATPEF.1QNVY25530KTK@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Anton Protopopov" <a.s.protopopov@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Shahab
 Vahedi" <list+bpf@vahedi.org>, "Russell King" <linux@armlinux.org.uk>,
 "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Hengqi Chen"
 <hengqi.chen@gmail.com>, "Johan Almbladh"
 <johan.almbladh@anyfinetworks.com>, "Paul Burton" <paulburton@kernel.org>,
 "Hari Bathini" <hbathini@linux.ibm.com>, "Christophe Leroy"
 <chleroy@kernel.org>, "Naveen N Rao" <naveen@kernel.org>, "Luke Nelson"
 <luke.r.nels@gmail.com>, "Xi Wang" <xi.wang@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "David
 S . Miller" <davem@davemloft.net>, "Wang YanQing" <udknight@gmail.com>
Subject: Re: [PATCH bpf-next v12 3/5] bpf: Add helper to detect indirect
 jump targets
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260403132811.753894-1-xukuohai@huaweicloud.com>
 <20260403132811.753894-4-xukuohai@huaweicloud.com>
In-Reply-To: <20260403132811.753894-4-xukuohai@huaweicloud.com>

On Fri Apr 3, 2026 at 9:28 AM EDT, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Introduce helper bpf_insn_is_indirect_target to check whether a BPF
> instruction is an indirect jump target.
>
> Since the verifier knows which instructions are indirect jump targets,
> add a new flag indirect_target to struct bpf_insn_aux_data to mark
> them. The verifier sets this flag when verifying an indirect jump target
> instruction, and the helper checks the flag to determine whether an
> instruction is an indirect jump target.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
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
> +bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, con=
st struct bpf_prog *prog,
> +				 int insn_idx);
>  #else
>  static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>  					   struct bpf_trampoline *tr,
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b129e0aaee20..cc53877639a5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -578,16 +578,17 @@ struct bpf_insn_aux_data {
> =20
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
> index 093ab0f68c81..439575fa6976 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1570,6 +1570,15 @@ struct bpf_prog *bpf_jit_blind_constants(struct bp=
f_verifier_env *env, struct bp
>  	clone->blinded =3D 1;
>  	return clone;
>  }
> +
> +bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, con=
st struct bpf_prog *prog,
> +				 int insn_idx)
> +{
> +	if (!env)
> +		return false;
> +	insn_idx +=3D prog->aux->subprog_start;
> +	return env->insn_aux_data[insn_idx].indirect_target;
> +}
>  #endif /* CONFIG_BPF_JIT */
> =20
>  /* Base function for offset calculation. Needs to go into .text section,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5084a754a748..e078e6ad5b00 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4049,6 +4049,11 @@ static bool is_jmp_point(struct bpf_verifier_env *=
env, int insn_idx)
>  	return env->insn_aux_data[insn_idx].jmp_point;
>  }
> =20
> +static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
> +{
> +	env->insn_aux_data[idx].indirect_target =3D true;
> +}
> +
>  #define LR_FRAMENO_BITS	3
>  #define LR_SPI_BITS	6
>  #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
> @@ -21227,12 +21232,14 @@ static int check_indirect_jump(struct bpf_verif=
ier_env *env, struct bpf_insn *in
>  	}
> =20
>  	for (i =3D 0; i < n - 1; i++) {
> +		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>  		other_branch =3D push_stack(env, env->gotox_tmp_buf->items[i],
>  					  env->insn_idx, env->cur_state->speculative);
>  		if (IS_ERR(other_branch))
>  			return PTR_ERR(other_branch);
>  	}
>  	env->insn_idx =3D env->gotox_tmp_buf->items[n-1];
> +	mark_indirect_target(env, env->insn_idx);
>  	return 0;
>  }
> =20
> @@ -22158,6 +22165,17 @@ static void adjust_insn_aux_data(struct bpf_veri=
fier_env *env,
>  		data[i].seen =3D old_seen;
>  		data[i].zext_dst =3D insn_has_def32(insn + i);
>  	}
> +
> +	/* The indirect_target flag of the original instruction was moved to th=
e last of the
> +	 * new instructions by the above memmove and memset, but the indirect j=
ump target is
> +	 * actually the first instruction, so move it back. This also matches w=
ith the behavior
> +	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to t=
he first new
> +	 * instruction.
> +	 */
> +	if (data[off + cnt - 1].indirect_target) {
> +		data[off].indirect_target =3D 1;
> +		data[off + cnt - 1].indirect_target =3D 0;
> +	}
>  }
> =20
>  static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off,=
 u32 len)

