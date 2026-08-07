Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB282DA759
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139539; cv=none; b=BolrlTsEo2pZ3BNTtmVwT1BOei7MDEwMYYMcvuNVe2Ak8qn26knP5+j9vdR46fBFR97st/fmThTIQYJH8VAGtJ2Jczkeej7wmRCXNPiH8unJ5heD++OwPnc7ehPkfKKW4grcOleZCBmANrOVKFzMhA7sDymqDyIksnGTOIHZDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139539; c=relaxed/simple;
	bh=DqWYN2eJYfKlUcst68H4ljwxQQx1PELkPVD829imahY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tLpRn9lyyrB2ldoigwlIGRgTLISYFlrh8eUW8OsUd9Suf0RLYKjIwABi503G3ZPXXMpQYHLNDEedaiuUUcFn9F7lW1zEHpJMh4bvmJX+bR1MK8k8eJoS1nyGufZj0Q68Y0vsanaGJQdVeqqfXLkCSwf08PapEkcgCkB0X9j4SBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdRoLvof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdRoLvof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657D51F000E9;
	Fri,  7 Aug 2026 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786139538;
	bh=jM4+6hBocIGYe7ZSU/SN9pNaNYFE2ASo9mcHtAV0zxE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NdRoLvof9ldwxxZepgk8pdQ91hKedoKE6mQdKQ88GzA88voWw8Yxzy1qTH947oKFO
	 Fv9IuRCLdicsaWKwLW03NoMoVhqpnfLAYditv/8c1Q1j/XU2Z2zOES3tmPcDAw3IJd
	 aRr8U71Y3a4fKfCIaN05crVK3FwhaRjrfrBr+nYmReLDPKWHViucdaLLYtXz4mrbJm
	 pRQeglYhR2k3zw32rr6GtsyoTijHBXGxGeAvPLo7vGxk2UfKwUM/wa8QcdaxxIJVeR
	 bKiObepz8ue7MWVa/EI7wwktc01R+BBw5jGF+wqzt6IEU9xE9KXInpuW6g6PzvQX8v
	 6Rt2aX4h+8Rxw==
Content-Type: multipart/mixed; boundary="===============6906703682029055666=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <866402a885d28810f2dde7a7deceb995c88725278d40d2455f2ad97aaa925cf0@mail.kernel.org>
In-Reply-To: <20260807-static-zext-v4-3-b6c270013c77@gmail.com>
References: <20260807-static-zext-v4-3-b6c270013c77@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: move bpf_is_reg64() to fixups.c
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,iii@linux.ibm.com,gimm78064@gmail.com,info@starlabs.sg,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Aug 2026 21:52:17 +0000 (UTC)

--===============6906703682029055666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 5f7843648189..d2ff416d7ad6 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -64,6 +64,96 @@ static int insn_def_regno(const struct bpf_insn *insn)
>  	}
>  }
>
> +/* This function is supposed to be used by the zero extension optimization
> + * code only. It returns TRUE if the source or destination register operates
> + * on 64-bit, otherwise return FALSE.
> + */

A subsystem pattern flags this as potentially concerning: the BPF
subsystem guide requires multi-line comments in kernel/bpf/ to follow
the modern style with the opening /* on its own line. This comment
puts text on the same line as the opening delimiter.

The guide states this applies even when surrounding code uses the old
style, and this comment's first line is modified by this patch ('the
following 32-bit optimization code only' -> 'the zero extension
optimization code only'), so it is a modified line rather than
untouched pre-existing text.

I noticed a later commit in the series (87fabf17dd53) rewrites this
comment into the compliant form, so the deviation is transient within
the series. Is it worth adjusting now, or acceptable to fix in the
later patch?

> +bool bpf_is_reg64(struct bpf_insn *insn,
> +		  u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
> +{

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index be8818b9e640..abb325194168 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3058,96 +3058,6 @@ static void mark_stack_slots_scratched(struct bpf_verifier_env *env,
>  		mark_stack_slot_scratched(env, spi - i);
>  }
>
> -/* This function is supposed to be used by the following 32-bit optimization
> - * code only. It returns TRUE if the source or destination register operates
> - * on 64-bit, otherwise return FALSE.
> - */
> -bool bpf_is_reg64(struct bpf_insn *insn,
> -	      u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
> -{

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31219172145
--===============6906703682029055666==--
