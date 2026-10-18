Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291D33343C
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288918; cv=none; b=A36nltTGqnxSJ8e5006/QhW8Dcjz7c/ild+LuEZnGDAyGuxBQUqwDuA7zt/8aGiyhLUCZsWMOXk5w49X3OgcaE8416Nb8IOcq1mB8rRm6b0sDbpyEFW3IQDeDSleS8y9eeYafbfvAZI7oyqZGxWQqFnH2JBxUXKIuVHuHRQuX4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288918; c=relaxed/simple;
	bh=AZi2F6VR7pxu0Tp2hTxxC9ifr9ca+mD+rWWXOZ55aiE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YquBzXgkCyNpFpuY93wsyKTh4JdepFRkdyOpu5ikPD0bJJecmzjXlI8NLvd/udq089K1ZZCRT98+BXPY/B9Qk7ZpBdKqHsjr8rnzoVi7jADaV+FVB8RhyAlwQCbDDjIEhQKpz2s3lUU3tsxYdHHogLp1TfuNX5MAcOyxOalvJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVY3DLcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVY3DLcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FA51F000C4;
	Sun, 18 Oct 2026 02:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792288916;
	bh=No9NmT8G/xa1zgsKceKAOhxzlIkaY35v9l+iNF3qZLQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cVY3DLccTzgqLpoiSDUM9+7TYcesqL5mg/0T8FRxg9atdmhaKdA7Aqy7WN23ah/YP
	 9vj/3u7QuH0lvnZcxhKSiv1xqm+y6hJpEFi2KS2obWlNOvpN001t6nqyd3e5EQTxvU
	 O27MfFhwGhrLt75XHi3LPX+iPjgaSls08fY1Ho5wBKO4/GHgTDzMGDPx8ehs2Uhkfz
	 RCiZHEXRDLI7zvtiH0ndDtkSIadNZfGYxjqxE/hoxKw2qviHQ0du+t0bH2lZyv1hYX
	 S86UMIm7CVP/BRT08Y/rjMh0WNqOW5OHF7rVWdSpBMa51w/QbPaqZA0aVNlTpuRNOd
	 cOZLpjPPv44EQ==
Content-Type: multipart/mixed; boundary="===============7127918195001769907=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <58a32cd03e5cd55848a38af4b06aff78fe17357f454b2453ae64f98456f4b114@mail.kernel.org>
In-Reply-To: <20261018012753.1724147-1-alexei.starovoitov@gmail.com>
References: <20261018012753.1724147-1-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Refuse the prologue for an extension if callers keep packet pointers
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 18 Oct 2026 02:01:55 +0000 (UTC)

--===============7127918195001769907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Refuse the prologue for an extension if callers keep packet pointers

TL;DR: bpf_check_ext_prologue() may check a different subprog than the one
attached when func_info type ids are duplicated, so a packet-writing freplace
could replace a function whose callers hold packet pointers, risking
use-after-free.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -22206,12 +22227,36 @@ static int check_unreliable_func_args(struct bpf_verifier_log *log, struct btf *
>
>  	bpf_log(log, "Cannot attach to static function %s: unreliable BTF and stack arguments\n",
>  		tname);
>  	return -EINVAL;
>  }
>
> +/*
> + * The prologue of an extension gives a cloned skb a new head, unless the
> + * prologue of the target program has done that. The callers of the function
> + * that it replaces must not hold on to the old head.
> + */
> +int bpf_check_ext_prologue(struct bpf_verifier_log *log,
> +			   const struct bpf_prog *tgt_prog, u32 btf_id)
> +{
> +	const struct bpf_prog_aux *aux = tgt_prog->aux;
> +	int i;
> +
> +	if (aux->has_prologue)
> +		return 0;
> +
> +	for (i = 0; i < aux->func_info_cnt; i++)
> +		if (aux->func_info[i].type_id == btf_id &&
> +		    !aux->func_info_aux[i].called_with_pkt_ptrs)
> +			return 0;
> +
> +	bpf_log(log,
> +		"Extension writing packet data cannot replace a function whose callers keep packet pointers\n");
> +	return -EINVAL;
> +}
> +

Can this loop pick a different subprog than the one that
bpf_check_attach_target() actually replaces?

The loop accepts the extension if any func_info entry with a matching
type_id has called_with_pkt_ptrs clear.  bpf_check_attach_target() instead
resolves the target to the first entry with that type_id:

    for (i = 0; i < aux->func_info_cnt; i++)
        if (aux->func_info[i].type_id == btf_id) {
            subprog = i;
            break;
        }
    ...
    addr = (long) tgt_prog->aux->func[subprog]->bpf_func;

The kernel does not require func_info type ids to be unique.
prepare_btf_func() only checks that each record's type is BTF_KIND_FUNC and
that insn_off increases, and check_btf_func() only checks that insn_off
matches the start of each subprog.  find_exception_callback_insn_off() also
tolerates duplicates.

So a target loaded with hand-made BTF could do this:

    - global subprogs A (func_info[1]) and B (func_info[2]) share the same
      FUNC type id X
    - main holds a packet pointer in R6 when it calls A, so A gets
      called_with_pkt_ptrs = true
    - main calls B while holding no packet pointers, so B stays false
    - an extension that writes the packet is loaded with attach_btf_id = X
      against this tc target, which has no prologue of its own

bpf_check_attach_target() resolves to subprog 1 (A).  bpf_check_ext_prologue()
skips i=1 and returns 0 at i=2 (B).  The extension then replaces A, and its
bpf_unclone_prologue() gives a cloned skb a new head while main still holds
R6 pointing into the old head, which is the use-after-free described in the
commit message.

The same mismatch exists on the attach path through
bpf_tracing_prog_attach() -> bpf_check_attach_target().

The other checks in bpf_check_attach_target() (func_has_rcu_read_lock(),
tgt_changes_pkt_data, tgt_might_sleep) all index by the resolved subprog.

Would it work to pass the subprog index that bpf_check_attach_target() has
already resolved into bpf_check_ext_prologue()?  Alternatively, deciding on
the first matching entry would also agree with the attach target lookup:

    if (aux->func_info[i].type_id == btf_id)
        return aux->func_info_aux[i].called_with_pkt_ptrs ? -EINVAL : 0;

Triggering this requires the privileges to load tc and freplace programs
(CAP_BPF plus CAP_NET_ADMIN, since BPF_PROG_TYPE_EXT is a net-admin program
type), but the verifier is still expected to enforce memory safety for those
loaders.

[ ... ]

> @@ -22330,12 +22375,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  					       : aux->changes_pkt_data;
>  			if (prog->aux->changes_pkt_data && !tgt_changes_pkt_data) {
>  				bpf_log(log,
>  					"Extension program changes packet data, while original does not\n");
>  				return -EINVAL;
>  			}
> +			if (prog->aux->has_prologue &&
> +			    bpf_check_ext_prologue(log, tgt_prog, btf_id))
> +				return -EINVAL;
>
>  			tgt_might_sleep = aux->func
>  					  ? aux->func[subprog]->aux->might_sleep
>  					  : aux->might_sleep;
>  			if (prog->aux->might_sleep && !tgt_might_sleep) {
>  				bpf_log(log,

Here subprog is already resolved, but only btf_id is passed down to
bpf_check_ext_prologue(), which repeats the lookup.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39087416318
--===============7127918195001769907==--
