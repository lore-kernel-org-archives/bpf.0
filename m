Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914504;
	b=dTwsbYMfTE/wV9iJNllOLHUf2tTRy+w3WkLwtVdCpVMIqtEWmHqqzyKQyMwQCVIK2IO1
	 K7ziPbNelpcoj4DJy9/m89E6gPbuyllXcIbqItPtSIZwhv6rKhpyAzJzsB+SQrjuN4WI8
	 ykd5aODqDDAkKMZfJx3wUqHR3sAiE/d8q7zPiwPe+073HlcEl6ATMLHPSpJU0G65V/Ufm
	 ElB61F05m6PdborQXmH8BUDsxfTbDAyLTcOt4udP1XadTVoCcK3WOPA8rWe0S2PZMcwNv
	 dxz+zF2A5uD+jBj8rCFwj0YDNX9+Eux6zSXmvmgGgaXz/S7j4sSAV6qT84o1O9slnCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914504;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=syxBVkyq9ek6zZUYcDwWrZvqw1dLPqtMoX6lUnZvyHQ=;
	b=1o/q1Bsr4u61jN0SP7rLUs60mKuoJMa/MrT66dISdK8FbvThBuelBbrNRs46qTnyah2R
	 qdqunkur93EK0RDi4WD+kXRbcUlYjGY0zTtuQCLli5RYIcUbyzPO/uDNrJjxhdCX+6r9m
	 4etJ7CDkudvuLhS3Pa7bOruqLvBdQuewOzWXtVSG6SHK/cyvh7W1E/eFNDWQsueGUWYAv
	 +G3iFoKHn9V0gIwgh1JvzxBpLB5sRu+MHIuNvM96CLZaTG7aQlGLyCWqmL196EdooZxGC
	 q72DG7NKWFPx5qjvnN5+ToT3yu2+cEVxt7yF97OuLkN+teqGNjKCj8tNbduH3lAf7MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtvFO+tk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE8606A32D
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtvFO+tk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7E31F008A3;
	Thu,  5 Nov 2026 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914504;
	bh=syxBVkyq9ek6zZUYcDwWrZvqw1dLPqtMoX6lUnZvyHQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NtvFO+tkk6UJdd5bFT+kgMiaRaGoD0QCqs1Ps6i1u7MYgU8XAlyBDgZBa5Occk7rR
	 h5hneAl/WNvqHRJTn+dYq0Cc5AT3fOeIS+A/LH/7zKMnA3G2EIiZM1G7Gsd9pyKhHi
	 VsJitUIyppqtDKwJhjBS8kY6EWWoWtH7tv+bFEm68fSlJKwYUVusXbMAcf6UOecqpY
	 l+RBjhGT/K6ZIsi6Ck9KwmYUx+CzISm3zCvNWUt/6GnJxDStm5ZbA6WFXoh3MXNnix
	 YY703TMMdENocJQnKPwCl6Mw0UMweGBVT9tJW36djtptSVp9KdQXW7vah48kPKKlPb
	 wKT9cQ7E5HZqA==
Content-Type: multipart/mixed; boundary="===============5018264798367766871=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4b3b87eff5e1a656d18c1d5284221964e3d5bca566ed6ce735eff3bf7e9ae238@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-15-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-15-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 14/35] bpf: Merge the state that arrives into the set at an insn
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:03 +0000 (UTC)

--===============5018264798367766871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Merge the state that arrives into the set at an insn

TL;DR: Nit only: flow_merge() takes a double pointer (struct flow_state **ps)
but never writes through it; suggests passing a plain pointer, or clearing *ps
where the state is freed.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> +/*
> + * Put *@ps into @set, one of the sets of states at its insn. Returns
> + * 1 if it is within a state of the set. It is gone then.
> + * 0 if it is in the set now, as it was or joined with states of the set.
> + * @cycle: it came around a cycle, what grew is forgotten.
> + */
> +static int flow_merge(struct bpf_verifier_env *env, struct flow_set *set,
> +		      struct flow_state **ps, enum flow_cycle cycle)
> +{
> +	struct bpf_flow *flow = env->flow;
> +	struct flow_state *s = *ps, *t, *tn;

[ ... ]

this isn't a bug, but *ps is only read once here and never written back,
and a join replaces s->st in place so the flow_state pointer does not
change.

Could flow_merge() take struct flow_state *s directly?

Or, if the double pointer is meant to show that the state is consumed,
should *ps be set to NULL on the paths where s is freed (the "within" and
error paths)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============5018264798367766871==--
