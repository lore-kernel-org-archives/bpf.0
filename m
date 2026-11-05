Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914481;
	b=AKjJeZntzIobl01e79RoGbG0bTsLjhiXQ3MB09kP2xR9uErNayXvvk+4IOAwuTqUSzoR
	 zWku8Qsnttc9IK6EYI12hbTYZAcL1KGnU9skl2Ely4BywMDlJ144Y8g8+umaFE9+SWd90
	 Xq4uh8WfDyrhLJngZgrRQqlDnmi9lfXgZaSyR/kVsv/OxI8tBAT2ZIRNIvURr+ye9BFf+
	 ww+yGo/dcd3bwL3HLOMhJGgpKvasUKpJDycdg20BrJUKbmrQ+vsth/rslzIojp0lJwbJa
	 oEsyB1yGnixa8h3lhuWtNyVfQlePe9JrBNNcE+LELKJxErTHIHxMbFw58zakgJVo51w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914481;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=8uiM6/5T0D+2nJ/9y1bWBy3dvmlZmSx1rh7MMo2f/T0=;
	b=FFvYSprK4ejXevjMlQLTmwaQowWOLEkP79xPo2MvmRJMmf8n9qTPD0rSXsLojV/3MSTe
	 VluOJvHS+N3YwKZzI8aUeyR4gC0WDRnJ7bwA+i0c1hRIrTZPDV/Anc9ciWJHQwZGu/eBJ
	 ERbxcVBGsKw/CT5vqSZlQXoh0f0qY40gKwjeMUMeNqLNiBephBBHdQisIVzSGFv59sr1u
	 qtx0C8J9lXs5KIZc2cgilLvXPPJij9XAn1f9zcEfSWd8wWZUXzBFCFflxxyOqEsr8hvFf
	 VBH4f2y0laMTlw3AgEdyZWqi18c23EXG5tH8fisLhj6VhI6HarA1Y5quVzBr5mGOZPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b60LTqSa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CAE606D817
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b60LTqSa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B08B1F008A2;
	Thu,  5 Nov 2026 21:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914481;
	bh=8uiM6/5T0D+2nJ/9y1bWBy3dvmlZmSx1rh7MMo2f/T0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b60LTqSa6EbwiM9W7bgXpiZ5VGe0K6uFsniDtdZbhzoVq4vVAOZ4c4Mu9XqakXGZ+
	 QeimTcuDV6v/ub2AHerzzcg5sTCMRaEQYmGrCbTbBolzlpqP4+ra6bjUMdCyEnX2ec
	 IlMtli5fyCaKKJJu9STcKiTuMfP+eLHCkV7ITEDaUsAzfnQydHG2K8kEDa6T+8O7co
	 hsvMJavYcICxQTmABgHateew+1DLcQCHYcP4NH7Eg7KLV/oKPm9ePpdxg3NOqTV3Ro
	 0JjxYNhvts7cy4wDUNyNaEr99D6ovM3UQtbFR8oqZsmEdUqZlvVsgBFhqfH35Y7UMK
	 Itt16iMTpfpYw==
Content-Type: multipart/mixed; boundary="===============6676608717106392418=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <18c874b2cfa07ba233f2f47a10a94d70493397c35ba59eb7b1c7f01e710af049@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-4-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/35] bpf: Add union and widening of the range of a register
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:34:41 +0000 (UTC)

--===============6676608717106392418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add union and widening of the range of a register

TL;DR: Nit only: the join.c prototypes and env->join member in bpf_verifier.h
may belong in the patch that adds join.c, and the changelog doesn't mention
them.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -1341,6 +1341,7 @@ struct bpf_verifier_env {
>  	struct bpf_iarray *gotox_tmp_buf;
>  	int *idoms;
>  	struct scev *scev;
> +	struct bpf_join_state *join;
>  };

[ ... ]

> @@ -1531,6 +1532,13 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
>  int mark_chain_precision(struct bpf_verifier_env *env, int regno);
>  
>  int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
> +
> +/* join.c */
> +int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
> +		    const struct bpf_verifier_state *a, const struct bpf_verifier_state *b,
> +		    bool widen);
> +void bpf_join_free(struct bpf_verifier_env *env);
> +

This isn't a bug, but would the join.c prototypes and the env->join member
fit better in the patch that adds kernel/bpf/join.c?

At this commit there is no join.c, struct bpf_join_state is not defined, and
nothing uses env->join, bpf_states_join() or bpf_join_free().  The changelog
describes only the three range helpers and says nothing calls them yet, but
it does not mention these join declarations.

>  int bpf_insert_loop_guards(struct bpf_verifier_env *env);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============6676608717106392418==--
