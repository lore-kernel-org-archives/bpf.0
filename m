Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3F17A31C
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586108; cv=none; b=AcRsXA7baABITRQ4l34X3VXfv9biHms17Yg1jPAtUVkYD2KDRYD+bAgRqsANjDL84GDmA9JrhFVmXACwb7o5d9+tsJB3IPANIX4AmBB8SGtCor1hO4SRR8n/JA40Ewdwr71ORsOm664MwSQTIx0ThY179p3y/KrA1p839ovVS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586108; c=relaxed/simple;
	bh=qVffnjJVz7mI6NMKnlTlRq3bSydGxCqbAw76/81cbuo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cfF1CJkaWljn5LQf851pbvozmLHYStCT5DDc17WWcKtf6nUXOtvBEgVKO/QHDi7YMtQ4mV//yWRluHsSMw8FmHR8oSI6JV5u/b9M/Pj7mcYyvDzcATlVdQk2aKRqyv5AXCpwPUWQ1pkUNSYXkUHe+tPEh8K9WVnsb6DEmYagNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLsH5hXJ; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLsH5hXJ"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so5155858eec.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772586106; x=1773190906; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQVgPxdwuZFyyTKIP6gO5rHHyx6tPfpxBJVDbsYROaI=;
        b=CLsH5hXJmaEFlS/QVIfCkvpEMtej64UjdNqO7t5cDhKoMIKBB0N6oly2zItnUr6Zj8
         SF4UnSJ5Q+fSYG7PNuqurn9de5FWjYImnr/bE1DjcUgJUzXMZTR6jZyTzeksRy4VOJk/
         tS3YCNQqsuvNawLq6CnXUulq2lMypTjLdl6i1aLOuEjGdA2RUwlQlPTyf8ziXH2ZJFFB
         u5RfuyDyE/v0/xP5pkIiNYvIKw1Sx4CwJSSUrsE0ppvZNPHh9VDzQHc9i83y93WBcKeL
         sz+ReIkHituBWbFe1SW+zbj/D/7nIIbXK3vd9mkxIQsdiFWyRTjPtVwJr/+qX8/YsuCp
         2EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772586106; x=1773190906;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQVgPxdwuZFyyTKIP6gO5rHHyx6tPfpxBJVDbsYROaI=;
        b=AOQvCDsNh9tTKKKow0tk0aarnQ5o8g9SdCT8X5GGNRXf3oKj1b7LAb4R92pQcVPmIA
         0qbnhWgxlerU+ZYm4NzN3X15QWrMXY88Ohcgm8THXTt7hM+UY8k8OHJU1qiwAn8Mhp3Q
         uiG0bqEkSp2Mu3VLQNK5V6ZKGQUejlSzSxowqhIJir/c6w6Xey5jP5mrnGwK1fXNiisn
         aNeETMxoR1SSllu3FNAQor7dlH2MYL3mvS1uh1F4t/W1xALO5pRX1IT0HCgzLQKs0eiO
         6hrwjJ/6/4xmFCYHjh+/62scU+Zb8JC8pIf1BvokCB76UFYzXvUe+Ai/RlEXS3dS7RAr
         TVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl5GZGPgk6+q6uGllSDCpVkNH7CLMtCTy63liAQHOd223CHVQrKfUnVBbpRE4ufk4rMZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx14JPqNB9p/9r3zLf3E4m7BN8HX2Mg4P8n6SJfZ22+lSPc/jEH
	/tDv2ZHA45yhN6gsYNKxKJFmVjHJE+C+T9mYqgzMTCi/Ha6ZVT+W9Pl7
X-Gm-Gg: ATEYQzxjqMYHInnU8hpQzgoWk8jxh/mhl/m5/4/AFaSpWQ9yNX2P4Nnwizj3S9qpBH3
	etYy/HRZoX1dbY8yofbEV6w7P43C3duu0eSwwnATNBKf3GRM5QZi0TdbGGiFXAgjC1Xvusiy2R/
	VEGM56fEf4jT8E7+4aXLCKREeif2ZhMgUg3HaDpgnBdCiVjwSCdsMs01s7E1QXP7dozSlNAfOGq
	M7PPI6Dt8enBgkLVnR7+I+HEieHhd9ODaaPgMxSyaubcUMKE/+71o/nqBzw4RsDK7bS+LW0l1Ey
	raQbI86kXoGnx2ss0L7GhYAu7BRQYzGNmxqEJaRdhRPnuSXdtO4HNo15Vgq1CZFaEhTvIId5qWi
	JSOYTIOIFusByRMY68hOlUfDFSG216x47bwnvij0XOBE+9GyFZ1uZQn5TGaA0c8YH/irAuv+7rI
	oK1tAiwCWhWGYuQE2IgzHfD1onhSVMfAnilt2yFSDYoucPq/WwiMIni110Mnzf8wlcIO9rPxIgN
	dGobkZsKTFKd/6GXzo=
X-Received: by 2002:a05:7300:ef97:b0:2ba:6c38:c79e with SMTP id 5a478bee46e88-2be311bce57mr95509eec.28.1772586105914;
        Tue, 03 Mar 2026 17:01:45 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfba0df2fsm10286542eec.7.2026.03.03.17.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:01:45 -0800 (PST)
Message-ID: <592a6eacf7c278137e49acb62f527e07a6c0b473.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Tue, 03 Mar 2026 17:01:43 -0800
In-Reply-To: <20260303043106.406099-2-emil@etsalapatis.com>
References: <20260303043106.406099-1-emil@etsalapatis.com>
	 <20260303043106.406099-2-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-02 at 23:31 -0500, Emil Tsalapatis wrote:
> The BPF verifier currently enforces a call stack depth of 8 frames,
> regardless of the actual stack space consumption of those frames. The
> limit is necessary for static call stacks, because the bookkeeping data
> structures used by the verifier when stepping into static functions
> during verification only support 8 stack frames. However, this
> limitation only matters for static stack frames: Global subprogs are
> verified by themselves and do not require limiting the call depth.
>=20
> Relax this limitation to only apply to static stack frames. Verification
> now only fails when there is a sequence of 8 calls to non-global
> subprogs. Calling into a global subprog resets the counter. This allows
> deeper call stacks, provided all frames still fit in the stack.
>=20
> The change does not increase the maximum size of the call stack, only
> the maximum number of frames we can place in it.
>=20
> Also change the progs/test_global_func3.c selftest to use static
> functions, since with the new patch it would otherwise unexpectedly
> pass verification.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  include/linux/bpf_verifier.h                  |  6 +++
>  kernel/bpf/verifier.c                         | 43 ++++++++++++-------
>  .../selftests/bpf/progs/test_global_func3.c   | 18 ++++----
>  3 files changed, 42 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c1e30096ea7b..39a54e631bcd 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -650,6 +650,8 @@ enum priv_stack_mode {
>  	PRIV_STACK_ADAPTIVE,
>  };
> =20
> +struct bpf_subprog_info;
> +
>  struct bpf_subprog_info {
>  	/* 'start' has to be the first field otherwise find_subprog() won't wor=
k */
>  	u32 start; /* insn idx of function entry point */
> @@ -677,6 +679,10 @@ struct bpf_subprog_info {
> =20
>  	enum priv_stack_mode priv_stack_mode;
>  	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> +

Nit: please add a comment here saying the below are temporary values
     used in check_max_stack_depth_subprog() (tbh, I'd move those to a
     separate array in env but maybe that's an overkill).

> +	int ret_insn;
> +	int frame;
> +	int cidx;

Nit: please rename to `caller` and add a comment.

>  };
> =20
>  struct bpf_verifier_env;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1153a828ce8d..d362ddd47d71 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6652,9 +6652,11 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>  	struct bpf_insn *insn =3D env->prog->insnsi;
>  	int depth =3D 0, frame =3D 0, i, subprog_end, subprog_depth;
>  	bool tail_call_reachable =3D false;
> -	int ret_insn[MAX_CALL_FRAMES];
> -	int ret_prog[MAX_CALL_FRAMES];
> -	int j;
> +	int total;
> +	int tmp;
> +
> +	/* no caller idx */
> +	subprog[idx].cidx =3D -1;
> =20
>  	i =3D subprog[idx].start;
>  	if (!priv_stack_supported)
> @@ -6706,8 +6708,11 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>  	} else {
>  		depth +=3D subprog_depth;
>  		if (depth > MAX_BPF_STACK) {
> +			for (total =3D 1; subprog[idx].cidx >=3D 0 ; total++)
> +				idx =3D subprog[idx].cidx;
> +
>  			verbose(env, "combined stack size of %d calls is %d. Too large\n",
> -				frame + 1, depth);
> +				total, depth);
>  			return -EACCES;
>  		}
>  	}
> @@ -6723,8 +6728,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>  				continue;
>  			if (subprog[idx].is_cb)
>  				err =3D true;

Below the old version of the loop does not include current frame, but
the new version *does* include current frame. Looks like the above
check can be removed.

> -			for (int c =3D 0; c < frame && !err; c++) {
> -				if (subprog[ret_prog[c]].is_cb) {
> +			for (tmp =3D idx; tmp >=3D 0 && !err; tmp =3D subprog[tmp].cidx) {
> +				if (subprog[tmp].is_cb) {
>  					err =3D true;
>  					break;
>  				}

This code checks that bpf_throw() cannot be called from callbacks.
The `is_cb` is set in push_callback_call() both for sync and async
callbacks, it is also set for exception callback separately.
Meaning that check_return_code() can be simplified further.

> @@ -6740,8 +6745,9 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>  		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
>  			continue;
>  		/* remember insn and function to return to */
> -		ret_insn[frame] =3D i + 1;
> -		ret_prog[frame] =3D idx;
> +
> +		subprog[idx].frame =3D frame;
> +		subprog[idx].ret_insn =3D i + 1;

Nit: move this down to `subprog[sidx].cidx =3D idx;`, so that the whole
     "frame" setup is done in one place?

> =20
>  		/* find the callee */
>  		next_insn =3D i + insn[i].imm + 1;
> @@ -6762,6 +6768,9 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>  			}
>  		}
>  		i =3D next_insn;
> +
> +		/* caller idx */
> +		subprog[sidx].cidx =3D idx;
>  		idx =3D sidx;
>  		if (!priv_stack_supported)
>  			subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;
> @@ -6769,7 +6778,7 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>  		if (subprog[idx].has_tail_call)
>  			tail_call_reachable =3D true;
> =20
> -		frame++;
> +		frame =3D subprog_is_global(env, idx) ? 0 : frame + 1;
>  		if (frame >=3D MAX_CALL_FRAMES) {
>  			verbose(env, "the call stack of %d frames is too deep !\n",
>  				frame);
> @@ -6783,12 +6792,12 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>  	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>  	 */
>  	if (tail_call_reachable)

Unrelated to current patch, but looks like an issue.
`tail_call_reachable` is not reset anywhere in
check_max_stack_depth_subprog(). Once it flips to true all calls
visited afterwards trigger spine to be marked.

> -		for (j =3D 0; j < frame; j++) {
> -			if (subprog[ret_prog[j]].is_exception_cb) {
> +		for (tmp =3D idx; tmp >=3D 0; tmp =3D subprog[tmp].cidx) {
> +			if (subprog[tmp].is_exception_cb) {

As with previous such loop, the new code seem to include current frame.
Does this change anything?

>  				verbose(env, "cannot tail call within exception cb\n");
>  				return -EINVAL;
>  			}
> -			subprog[ret_prog[j]].tail_call_reachable =3D true;
> +			subprog[tmp].tail_call_reachable =3D true;
>  		}
>  	if (subprog[0].tail_call_reachable)
>  		env->prog->aux->tail_call_reachable =3D true;
> @@ -6796,13 +6805,15 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>  	/* end of for() loop means the last insn of the 'subprog'
>  	 * was reached. Doesn't matter whether it was JA or EXIT
>  	 */
> -	if (frame =3D=3D 0)
> +	if (frame =3D=3D 0 && subprog[idx].cidx < 0)
>  		return 0;
>  	if (subprog[idx].priv_stack_mode !=3D PRIV_STACK_ADAPTIVE)
>  		depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
> -	frame--;
> -	i =3D ret_insn[frame];
> -	idx =3D ret_prog[frame];
> +
> +	idx =3D subprog[idx].cidx;
> +	frame =3D subprog[idx].frame;
> +	i =3D subprog[idx].ret_insn;
> +
>  	goto continue_func;
>  }
> =20

[...]
