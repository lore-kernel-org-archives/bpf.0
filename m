Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32F3446CB
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894040; cv=none; b=WeaNCr/gxNfQBnMj2hD7E443RT4o+kooTD6JvHE4lZq++kCYAkSHY98av/4qpP+rfiu9Y9fV1k7WyfwpcmQhfRSZeBF+lcSUJF3onu71JANvaoWq9MvSdawUFIO92bXalg8nh1siVM+huOqxTtLNAXDr38PyWtYonKDf8WaOqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894040; c=relaxed/simple;
	bh=iFcJSWBHOItlshi8Qk4TlVQkzEFkUvJ7sT0Kfvg7MPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nLDDBVN8wUXJ3Drvk34SS4iItpRoPMztsDSSFgl7IdnVGsdPnlnFZJpRmvx7b5yua4rkS2rm0U2LOwOW8rAUS4MTLz5hsYiad69r0MOGJTVNKs0BjDfse/79qbqg8eGR8rCw+hxp5yeJVQGVOjgoeYs0+9rXCvDwwKc6rc7NFz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS+eYm3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS+eYm3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475151F000E9;
	Wed,  5 Aug 2026 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785894038;
	bh=lqc8PuB5bBmhOaei4Ph4aQIZC8qgFTAvvTk3tN3ZcNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nS+eYm3BTv8EqpRchbyhSPjp83mjAhLrMdm292N+YMb++qsk5bf/lw932f/aQxnaH
	 izEH9O8+iRz5JeIwKDYaS9Qa7c0immkFQOn0fMUixjH9Eu3Uq+djYnqE6NRJOIhcRD
	 qfl0/J63Q74NvY/2pCgoo79myngOFQkgzbB5R3JZvAnHUEXQUhmqts5UptHnoPT8lx
	 mMJWVXaA2CmI6eOW+4N+yw8dNnVYN4aKGdDPFj6CQtOlKJA65mZ6qvsCGkPuGq9MZY
	 MeP0ce6BUZxMd/Zx11xuDKEC7vEonz78lwBd7MNV5PALbG9/rV39VA3vvSP9doPwar
	 yt6vxfos/fS2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 2/6] bpf: Propagate async callback
 instructions to scheduling subprograms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805011517.1717238-3-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
 <20260805011517.1717238-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 01:40:37 +0000
Message-Id: <20260805014038.475151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Unbounded `async_stats_subprog_cnt` causes OOB write in `push_=
async_cb` and OOB read/write in `account_current_path`.
--

--- Patch [2]: [PATCH bpf-next v6 2/6] bpf: Propagate async callback instru=
ctions to scheduling subprograms ---
commit e22fc6d02fda1f775515a1bbc9834113d0ba7767
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Propagate async callback instructions to scheduling subprograms

This commit propagates the instruction budget from asynchronous callback
executions back to the subprograms that originally scheduled them. It tracks
active subprogram IDs when a callback is queued and adds the inclusive
subtotal of the async frame-zero path to the saved scheduling subprograms.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -447,6 +447,8 @@ static_assert(MAX_BPF_STACK / 8 <=3D (1 << 6));
>  struct bpf_verifier_state {
>  	/* call stack tracking */
>  	struct bpf_func_state *frame[MAX_CALL_FRAMES];
> +	u32 async_stats_subprog_ids[MAX_CALL_FRAMES];
> +	u32 async_stats_subprog_cnt;

[Severity: Critical]
Is it possible for the accumulated call chains of all ancestral scheduling
events to exceed MAX_CALL_FRAMES? If a BPF program chains async callbacks
(like a timer callback scheduling another timer callback), the count might
grow indefinitely.

>  	struct bpf_verifier_state *parent;
>  	/* Acquired reference states */
>  	struct bpf_reference_state *refs;

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2293,6 +2298,12 @@ static struct bpf_verifier_state *push_async_cb(st=
ruct bpf_verifier_env *env,
>  			0 /* frameno within this callchain */,
>  			subprog /* subprog number within this prog */);
>  	elem->st.frame[0] =3D frame;
> +	cnt =3D env->cur_state->async_stats_subprog_cnt;
> +	memcpy(elem->st.async_stats_subprog_ids, env->cur_state->async_stats_su=
bprog_ids,
> +	       cnt * sizeof(elem->st.async_stats_subprog_ids[0]));
> +	for (i =3D 0; i <=3D env->cur_state->curframe; i++)
> +		elem->st.async_stats_subprog_ids[cnt++] =3D env->cur_state->frame[i]->=
subprogno;
> +	elem->st.async_stats_subprog_cnt =3D cnt;

[Severity: Critical]
Can this loop overflow the async_stats_subprog_ids array? Since cnt is
incremented without checking against MAX_CALL_FRAMES, it appears this could
write past the end of the array, corrupting adjacent fields in struct
bpf_verifier_state like the parent pointer.

>  	return &elem->st;
>  }

[ ... ]

> @@ -9828,16 +9839,24 @@ static void account_processed_insns(struct bpf_ve=
rifier_env *env,
>  	if (caller)
>  		caller->insns_subtotal +=3D insns;
>  	callee->insns_subtotal =3D 0;
> +	return insns;
>  }
> =20
>  static void account_current_path(struct bpf_verifier_env *env)
>  {
>  	struct bpf_verifier_state *state =3D env->cur_state;
> -	int frame;
> +	u32 insns;
> +	int frame, i;
> =20
>  	for (frame =3D state->curframe; frame >=3D 0; frame--)
> -		account_processed_insns(env, state->frame[frame],
> -					frame ? state->frame[frame - 1] : NULL);
> +		insns =3D account_processed_insns(env, state->frame[frame],
> +						frame ? state->frame[frame - 1] : NULL);
> +
> +	if (!state->async_stats_subprog_cnt)
> +		return;
> +
> +	for (i =3D 0; i < state->async_stats_subprog_cnt; i++)
> +		env->subprog_info[state->async_stats_subprog_ids[i]].insns_total +=3D =
insns;

[Severity: Critical]
If async_stats_subprog_cnt was corrupted and grew beyond MAX_CALL_FRAMES, d=
oes
this result in an out-of-bounds read from async_stats_subprog_ids? This cou=
ld
read from the corrupted parent pointer and cause an arbitrary kernel memory
write into env->subprog_info.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805011517.1717=
238-1-memxor@gmail.com?part=3D2
