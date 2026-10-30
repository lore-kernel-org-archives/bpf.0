Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365175;
	b=b7Li4151AhLB8yNpvRfvNGK5AZTHk4+1S/5p2/kgmykx2WFBh0NlUv+BhZsj2J0zXPQa
	 GhyYevLQ2VSq7kWxXxH6s+CyR07Ypv6UrLMIN8xLPQnwyHInh5XJkEyJzOEQmbis4izmi
	 5hGc8XGUWc3kqKRDIqjTtYLfW+yIYmeeT05hSd05kHcWGWw3lRC7fcJlHQmjUbsH2MA7d
	 AUf4z/MxfcloHOYlpp2E/KCObyo4gbRjnfde2uVLMAtGLq+2Btknohj7AZkpf7JjNaeV/
	 YDxPSIzmjOX9cTpSOZSq6FCZEMdZNazzOTg69Rr3ZJFt3Nv3j+3fAwdIrPC/IVQzLPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365175;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=lvKBwCgVqUax5qNd5AsU9XWWoRcofUbjmwMFYfXyy7E=;
	b=LkkSgGNm3PIp5xUEn/iax54YX+QqaDN/rmS46YmnL8e4SZqmYb/mZysyg5iIXnOl+uyS
	 R9yEQVY/YY2IbenqbJhwGoNNyxOHaK9+KNLpInS1QB/5qmFpKSC4SfUDRMKG458oG3nm+
	 GBhQCC4DVM2FQv7mgAfp/lGEyFn68fkXLZF5Aw658i81VDS9lXENX/TgZNrNtGudpt7Au
	 xWhSW04nMzBH2Bw4KRsgfdUT/L/saxwp371SpxabYHEM+v97EgilJUYeYEfxpgEGvXamD
	 fi/Khy8hQIZxfU+K5PeYrugBMLIZ1NV0klgiqSRyFDAo2WJrv2SFhqxGsqAaDQz9Pww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQKgJKF9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6C60A260B;
	Fri, 30 Oct 2026 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQKgJKF9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542A71F0093A;
	Fri, 30 Oct 2026 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793365174;
	bh=lvKBwCgVqUax5qNd5AsU9XWWoRcofUbjmwMFYfXyy7E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JQKgJKF9p6qlA5gouG7fJ0kHH6t0mI6CrViW/uM10YWP1FaEbN9GumCYOR6ssW553
	 9ftiwE9mcUj52Dz6FaDjbfklj958jE07w7v6gZithw8B0TX56TOvTVAqPlWOc3o+XY
	 neMZqgYK1p10DqbeRn1B5ApEHlaGJFCizlNgHuWHTd/buTdZvUG4mFfwl+hvfc6tPC
	 hSCj0EwJTakAuzrgBTWIzl+0VHWl7qSLzowJy9hw1cyRpNihw2ElXwb4hYvrtCWCGp
	 6HpiCPYLvYp5h+hgi6KQb+IiBqJs2uKRBzDFA6Li2vxQ+NxAvrsQXHtuckzTRIQQUl
	 hbGSAE754Vl+g==
Content-Type: multipart/mixed; boundary="===============1236647830006293705=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7b3485c45dbd413cc9c48ca9f1891a307181ab0db3a999aaa41823284e700831@mail.kernel.org>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-5-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-5-55cd43439f7c@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/22] bpf: Expand a backward may_goto to gotol when patches push it out of range
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 30 Oct 2026 12:59:34 +0000 (UTC)

--===============1236647830006293705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Expand a backward may_goto to gotol when patches push it out of range

TL;DR: Nits only: the new may_goto_expand() comment on 'reach' overstates
coverage, since forward jumps are still unadjusted, and it detaches the older
function comment.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index c9963d8d8135..1d281428acbb 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1968,16 +1968,21 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
>   * may_goto when it is zero, then the tail that updates the count.
>   * Use gotol when the target is too far for 16-bit offset of a conditional jump.
>   */
> -static int may_goto_expand(struct bpf_insn *insn_buf, int off, int stack_off,
> -			   const struct bpf_insn *tail, int tail_cnt)
> +/*
> + * 'off' is the offset of may_goto, 'reach' how far it jumps once the patches
> + * in between are applied, which decides whether a 16-bit jump will do.
> + */
> +static int may_goto_expand(struct bpf_insn *insn_buf, int off, int reach,
> +			   int stack_off, const struct bpf_insn *tail, int tail_cnt)

This isn't a bug, but the new comment says 'reach' is how far may_goto jumps
once the patches in between are applied.  Does that hold for forward jumps?

may_goto_off() returns the unpatched offset for them:

	if (off >= 0)
		return off;

so reach == off for a forward may_goto, and a forward may_goto that later
patches push past S16_MAX still gets a 16-bit JEQ.  That then fails in
bpf_patch_list_commit() -> patch_list_adj_insn() -> insn_set_rel() with
-ERANGE, the same as before this patch.

Could the comment say that 'reach' only accounts for the patches already
queued, so only backward jumps are covered?

Also, the new comment block sits directly below the existing comment for
may_goto_expand(), which leaves the older comment detached from the function
it describes.  Could the two be merged into one?

>  {
>  	int cnt = 0;
>
>  	/* Forward jump has to step over the tail */
>  	off = off >= 0 ? off + tail_cnt : off - 1;
> +	reach = reach >= 0 ? reach + tail_cnt : reach - 1;
>
>  	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
> -	if (off == (s16)off) {
> +	if (reach == (s16)reach) {
>  		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
>  	} else {
>  		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
> @@ -1987,6 +1992,23 @@ static int may_goto_expand(struct bpf_insn *insn_buf, int off, int stack_off,
>  	return cnt + tail_cnt;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41053659762
--===============1236647830006293705==--
