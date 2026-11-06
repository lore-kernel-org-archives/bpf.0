Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939096;
	b=U3BtRjrKCtPs/xqB8Tb/MU0Ia7FRNIr3wI3WJnxkEt/De4EI9Gf0xfTCrnXzl2Aveky9
	 skYAl1+V8cA6c8dN3F7qpFmyYMYIyCw+tRQxqSAnLzUM9fKoT9FD5ZJ0OzepLwzWW20sv
	 8P7H0mT0217p6/gxjlSd3uO/UDtzEIPCE2TWbpgxNt9xFJeMfzpD8I8NwcHB3rGJ2kT4D
	 gJP3BQaqlEWriaPQSbimYHHQd0idWxGoXLgVFUoTwDLwDf3b9+N8xicIT+fV71uIVA+eh
	 1wd4GBJpoGKZxs5wYl9G4ZgnuR6dX4Orc+rJeHGwoGYz3Df8YgM4E63IZu4gm5r3xjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939096;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=K3YC03LXMBHnrltgz0YXpshx7mYyhApaQ7YnoTjGfXQ=;
	b=Mu+7e5pOgVlkKKk82L6H7GP6Kbels3AsTu1/wzSrmfyw1vIiHRJIMHoFCTg1AyJ46vhx
	 FB5aI+yy1SHoUpt0JUl2tzMmk95aaE1tYiU0M7GF+uulsQ3hvdROm/nEHA+qPZGOxWq/E
	 rzXOURxvzWX/vCvaOhcgeeVizug3ERCsAqYoCUYa01b8s3duMpuobIFHZ1BDHgoZ3p4aO
	 w2mmnDzbTt+BTi4M+sUCBUR1E4rL9eTwuNNCDun2JNqb1ZTy4Mu3tDJ32eylvSv9knCrc
	 fEb6S7oc6/Ph/uT6FPrTOLQLdtG1lEbP/C74nLyqUN0lCHx0RFSDVqDNhUQ4lLLCAuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boluBaJk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDC606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boluBaJk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A14E1F0089F;
	Fri,  6 Nov 2026 04:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939096;
	bh=K3YC03LXMBHnrltgz0YXpshx7mYyhApaQ7YnoTjGfXQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=boluBaJki0IUJrmpdrPzINSyxsy4hBqsJokWytFToy0ucNR81Ir2bmN5NNZ2vqL0J
	 n+iNZThoteG7xnhvft1ovfvixKRwx8YmgU+MYE7QfywpQXLcVyPOtq5WWd5EClQqsM
	 Obc1FQaVBqDcgMK2WdgX5SPquy3Qe4/iOD0lHq0dQnmU5QnWC1O8gf+BBX1mDEksZa
	 3PWeLVorP8eKD+ie75uUWW/+GWr7/jbKDYsw26pLr8g8e0maMSwfh7xN1j7Z3uD/q/
	 e2iYUV5mL4ZQOV21EyrfswuICt21q7NAQaa/TFWH7xwBN4u3DdcJm85A2+Mzg30uW0
	 6GA6yqEtSFujw==
Content-Type: multipart/mixed; boundary="===============9020079507517317093=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c5cd652a5014ef6157278403838481eb2f4a8c5add5e6de5a2837b3121f30074@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-33-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-33-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 32/45] bpf: Keep the frames of the caller for a subprog that loads data_end
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:24:56 +0000 (UTC)

--===============9020079507517317093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep the frames of the caller for a subprog that loads data_end

TL;DR:
- loads_pkt_end isn't propagated to callers, so valid programs may be rejected
  when data_end is loaded through a nested subprog
- A subprog loading data and data_end without passing a packet pointer may
  also be rejected; testing it in func_is_on_its_own() is suggested

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> @@ -714,6 +714,8 @@ static enum flow_kind flow_loaded_kind(struct bpf_verifier_env *env, const struc
>  		env->ops->is_valid_access(insn->off, size, BPF_READ, env->prog, &info);
>  	/* it notes what the prog reads, and this is a question */
>  	env->prog->tstamp_type_access = tstamp;
> +	if (valid && info.reg_type == PTR_TO_PACKET_END)
> +		bpf_find_containing_subprog(env, insn - env->prog->insnsi)->loads_pkt_end = true;

loads_pkt_end is set only on the subprog whose insn loads data_end, and
nothing passes it up the call graph.  The sibling flags changes_pkt_data,
might_sleep and might_throw are propagated to every caller by
merge_callee_effects() in bpf_check_cfg().

Can the program from the commit message still be rejected if has() is
called through one more static subprog?

  static __noinline bool has(struct xdp_md *ctx, void *p, u32 n)
  {
          return p + n <= (void *)(long)ctx->data_end;
  }
  static __noinline int parse(struct xdp_md *ctx, void *p)
  {
          return has(ctx, p, 14);
  }
  ...
  void *p = (void *)(long)ctx->data;
  if (!parse(ctx, p))
          return XDP_DROP;
  return *(char *)(p + 13) ? XDP_PASS : XDP_DROP;

At the call of parse(), arg_needs_caller() sees r1 as PTR_TO_CTX and r2 as
PTR_TO_PACKET with id 0.  parse()->loads_pkt_end is false, so parse() is
verified on its own with only its own frame.

Inside that pass has() keeps the frames, but find_good_pkt_pointers() can
only widen the registers of parse() and has().  The main prog's r6 is not
in that state, and the code that rebuilds the caller's state from the exit
state copies back only R0 and the references.  So r6 keeps r=0 and the load
fails with the same error as in the commit message:

  invalid access to packet, off=13 size=1, R6(id=0,off=13,r=0)

Before the series, static subprogs were always verified in the caller's
frames, so this program loaded.

loads_pkt_end is computed in bpf_flow_compute_kinds(), after
bpf_check_cfg() has run merge_callee_effects(), so propagating it would
need its own pass after the kinds are computed, for example over
env->subprog_topo_order, callees first.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11602,7 +11602,8 @@ static bool arg_needs_caller(const struct bpf_verifier_state *state,
>  	if (reg_is_pkt_pointer(reg) && reg->id)
>  		return true;
>  	/* it checks how much of the packet is there, for the caller */
> -	if (reg->type == PTR_TO_PACKET_END && !sub->recursive)
> +	if ((reg->type == PTR_TO_PACKET_END ||
> +	     (reg->type == PTR_TO_PACKET && sub->loads_pkt_end)) && !sub->recursive)
>  		return true;
>  	/* or whether there is something to point to */
>  	return type_may_be_null(reg->type) && !sub->recursive;

This condition keeps the caller's frames only if a PTR_TO_PACKET is one of
the arguments, but find_good_pkt_pointers() widens every register in every
frame with the same type and id as dst_reg.  A subprog that loads both
data and data_end therefore widens every id-0 packet pointer the caller
holds, whether or not it was passed:

  static __noinline bool has(struct xdp_md *ctx, u32 n)
  {
          return (void *)(long)ctx->data + n <= (void *)(long)ctx->data_end;
  }
  ...
  void *p = (void *)(long)ctx->data;
  if (!has(ctx, 14))
          return XDP_DROP;
  return *(char *)(p + 13) ? XDP_PASS : XDP_DROP;

Here has()->loads_pkt_end is set, but its live arguments are r1 as
PTR_TO_CTX and r2 as a scalar, so arg_needs_caller() returns false for
each of them.  has() is then verified without main's frames, the compare
does not reach main's r6, and p + 13 is rejected.  Before the series this
program loaded.

Would it be better to test loads_pkt_end once in func_is_on_its_own(), for
example:

  if (sub->loads_pkt_end && !sub->recursive)
          return false;

rather than ANDing it with the type of each argument?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============9020079507517317093==--
