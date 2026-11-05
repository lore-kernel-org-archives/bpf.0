Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914535;
	b=SmRcgQnyqFbwr6zY0XaQRIU2S3oVmByGD8lcXdGy28PtbVCs4xvCWyWdF6L1rXyI03jb
	 Wv0Nz6kauiC1aJiFZ30mi/CaCtrmVo1dVXIkf4L4ht7apfiDZh2MZIBpN1Kg+MX1O0AEg
	 quHAwGGAallJ45B5SVYbSLfxBBYlLqR+c+fXCyXGWJtPHGK/zwyQo/ATr25xJKs6/FuV5
	 LLN/GgnaVG2bg03aDrhjgg8ONn1ulFdKmP0X9P8t6cyV2ZTn7EDeVInVBAsY/qlXaVLc0
	 bMyRPeCe4XL+g3FUDoCmVU6yHehjLCBYRwlzzD2UOPbuloeKUzd2J+Nkv7iWC7IUI0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914535;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=9FGQUegOaaQT634bDhwUDilpNXicheHEUtIGIlQhoeE=;
	b=TRH/1EUuewfi6nOHZG/RxiqE6A8RtLg42omYl4RDwMTFZXRZ9m01gpgsDvUXmIEO4Lq/
	 jVKW8Vn2BAOGsJ2OIi8kJVruh5Qpl5PzzSjGpL7nT1Y0nNJWWjWMCsUGI+bh4MMxzRi5v
	 X9qsxWnf6OnR3ZOkcduRuxO64RkmW1LaBm7ri8yRAVruipB8x0DzGrIhVzShEb9Db4jzE
	 f60183L+vrfdWoLTfJp1sq7p/27VByENF/Q8LYLQNrNAneq/IHrf96dz9COjC/s2n0itu
	 9wD5zPK0cdipG9EMHrHlA9+ni3BP36RydZFuVOGTfrRjuYrta3HQzWd4zAIxvtvH+KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUlwUoPh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC9606EEB5
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUlwUoPh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EB51F008A7;
	Thu,  5 Nov 2026 21:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914534;
	bh=9FGQUegOaaQT634bDhwUDilpNXicheHEUtIGIlQhoeE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FUlwUoPhsEx1dxvzi6Lbx87EwRfTz8IVVbjGonGTRJQSzl4xwt9rz3/ddjScXtdgw
	 OVsk9YcGDH4D07ZdeZSOAhT/twhY991qk9LTND8OeGHb1Co8HDIVtYducKz8abYZbr
	 2dlJVUQ+3FnNyLGkKr+mg9SvlFyoGgU8w/hlEvj7N4m+RWhiZNViwRghQqLITvo6cF
	 OJptC4lnaIbZQObDTSJPgQJjSbYjPB+jp4IdNd4UkyBumcKyDbnEE1LTvrXY+rYb3A
	 h3JdZfjEq796d1CwIB2NjwxB+Ek0JuPbiw/4jcswgGxJHMVPLMc0fN6PJiHBti9G6C
	 HlHkgrRabg3nw==
Content-Type: multipart/mixed; boundary="===============4446528159296328330=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <eab464b37245729bd129597e075035c95c5500226cde18846cd92d505afb1783@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-16-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-16-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 15/35] bpf: Move states along edges, into loops and subprogs and out of them
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:34 +0000 (UTC)

--===============4446528159296328330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Move states along edges, into loops and subprogs and out of them

TL;DR: Nit only: the comment on bpf_flow_exit() says @st "is taken", but when
an existing exit subsumes it, st is left unfreed. No leak today; a caller
written to the comment could leak.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> +/* @st came to exit of the function that is verified on its own. It is taken. */
> +int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx)
> +{

[ ... ]

> +	list_for_each_entry_safe(o, on, &entry->exits, node) {
> +		if (bpf_state_subsumes(env, &o->st, st))
> +			return 0;

This isn't a bug today, but is the comment above bpf_flow_exit() accurate
when it says @st "is taken"?

Elsewhere in flow.c "taken" means the contents are moved and the source is
left empty, as in bpf_flow_deliver() ("What it holds is taken and @st is
left empty") and bpf_flow_call() (memset(caller, 0, ...)).

When an existing exit subsumes @st, this return 0 leaves *st holding its
frames and refs.  If an earlier iteration already joined st with another
exit, st holds the joined state from flow->tmp.

The only caller, exit_func_on_its_own(), returns PROCESS_BPF_EXIT, and
do_check_block() then calls bpf_free_verifier_state(state, false), so
nothing leaks.  A caller written to match the comment would leak one
verifier state per subsumed exit.

Could the comment say that @st is left for the caller to free when an
existing exit covers it, or could this path free and clear st so it matches
"taken"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============4446528159296328330==--
