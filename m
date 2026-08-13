Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3C48EBC1;
	Thu, 13 Aug 2026 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638371; cv=none; b=FB0EsKlMtK7yaDnIOC5m6Yt8ooYjld0OhkOWM1dI2RwBOrvX5mdJb3GSGmPcbBnQpIWfGa717+CS9CNqwdPXQLYq8Mql+kEJ1IsDhRhX69K5MYbIV0r8EZCQtQoKsELqgji/dUcwvPy4Q5w/018sK89/aSpJQPhqm8W3IY9N48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638371; c=relaxed/simple;
	bh=Lax2qZ9GB1r4BaQe+F2w3PBCHGlHlV9qaBK786jRFe4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WbcGlEzaul12WqKDcq5DDFGPnETP6tmJl1FD39+msb8jwhnEeLpWvbnO2Yh++UT4Iw338RDiDgcWa+yOQLATblbI1dowpLrmDLmXIsg3yHrvLyqwk+ku0jNm8LjgrMBAFyp486rzM2a+pw5iFHCQFR/g/Qe5UK3B89mVBg0P3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSr8j35B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSr8j35B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DC81F00A3A;
	Thu, 13 Aug 2026 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638368;
	bh=hOTAX7fdd3rZcAVWKYZHC50W+Bb3qZRONDBbaZeiuIw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MSr8j35BjFMcX4ddLYOOuM+/4jBHssj9Z16BZrX90lJyGCNRABhaiGEwNhQZjoui6
	 LGvGMWcbMx3c5c0iL4be2gKLT2+KoorBmPJJMPM/tQI9Tlyvpcgb9ufwTIyGwrsozC
	 JriVlQnvPPDmtUxa0NRDuxZ41O/ZkEiPaURNiNrs46vV//HdnGyewm8zU2bLh4BFpi
	 bV1KicdD0LS0bM0MsIhRTAvbtIbgQDg6qrb9W0+KL979g4RPuy1W/B2DsXQqJaLLTI
	 qB9ezMOBHhgHnTxbw5p+goGsaXfRfXNDWPQGP0+CB6n/9qEzYka0jarUDFj4UGMaSn
	 aHH93cvDJQX/g==
Content-Type: multipart/mixed; boundary="===============3463485423944060497=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <00f7d1a28671561d7ef689774af280b7aff3c6a0f9ca06212b05df2002f2793d@mail.kernel.org>
In-Reply-To: <20260813152324.97937-2-leon.hwang@linux.dev>
References: <20260813152324.97937-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 01/10] bpf: Drop duplicate blank lines in kernel/bpf/
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 16:26:07 +0000 (UTC)

--===============3463485423944060497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 40bd04421a991..a2b18a9f1694c 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
> @@ -214,7 +214,6 @@ static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
>  	return bt->reg_masks[bt->frame] & (1 << reg);
>  }
>
> -
>  /* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
>  static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
>  {

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 164d16c243ca6..cdb79a66b156f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -635,7 +635,6 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg,
>  			      enum bpf_dynptr_type type,
>  			      bool first_slot, int id, int parent_id);
>
> -
>  static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
>  				   struct bpf_reg_state *sreg1,
>  				   struct bpf_reg_state *sreg2,

[ ... ]

> @@ -18361,8 +18352,6 @@ static void release_insn_arrays(struct bpf_verifier_env *env)
>  		bpf_insn_array_release(env->insn_array_maps[i]);
>  }
>
> -
> -
>  /* The verifier does more data flow analysis than llvm and will not
>   * explore branches that are dead at run time. Malicious programs can
>   * have dead code too. Therefore replace all dead at-run-time code
> @@ -18390,8 +18379,6 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
>  	}
>  }
>
> -
> -
>  static void free_states(struct bpf_verifier_env *env)
>  {
>  	struct bpf_verifier_state_list *sl;

This isn't a bug, but it looks like one adjacent blank-line pair is still
left in verifier.c. Inside the kfunc argument loop in check_kfunc_args(),
around the code that checks:

	if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))

there's a blank line pair that appears to fit the same pattern this patch
removes everywhere else. The changelog states the goal is to drop the
adjacent blank lines that have accumulated over time, and the patch removes
30 blank lines across the directory, but this one instance seems to have
been overlooked. Was that one intentionally kept, or could it be folded
into this patch so the whole directory is done in one pass?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31716447858
--===============3463485423944060497==--
