Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE13B961B;
	Sat, 17 Oct 2026 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257436; cv=none; b=hf3E7jJp1fcfWAEAByd9RUieIWk35Ob/p1PsEm+yqlDjsY17cKvJY70DJ8S95EBbmbb8fJIa5au3aZ8ZZpx4nevQp17n2Pkxz/lZ+ux47L1jTEMUye7fxzIoC8bGUTYnHIlmke2gODLnYP7L7nl+ku/DmFnr4/VaAprn/UCUv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257436; c=relaxed/simple;
	bh=dpbVacTCih9lAevxcQgl4BwwWvfS58dLjmD2+ajG0xY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QIg6yllkUy2FQ7xuNnFsGjr6W0I6SuiHlH6YErHe+z5txf+5KvFubvI7Gakc/IuiMoPNp3Qj3F+Kq1O52BctD+t3EZopw/VkM9SLm+yv5DdRo2nLYEarqkV7tcJ66QfhBbou+tzAyif31nKfztzqp6aukR/mdnAy3jQVgGPlSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuDhvFbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuDhvFbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD6F1F000C4;
	Sat, 17 Oct 2026 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257434;
	bh=Edpli9n4lHiurARNXlpLFP1Zik77VFnizkT9GBmCgEs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WuDhvFbGdfXxaUGqwo5Tfp7MmF9FBjzlPIcGzeXsTFCEKj3FawT475YVAxIkpYoL7
	 0eWWG41Mw5lcbCb6Wuey435I7gRjF6X98sQzdQEkPBUcjdYAB7UqbnbMq1DoSdoTrs
	 249HvcTNuRo+WkdGXBxhGJFEDP4Mo00SGn59LL3MDqSyaKXONTGpJ0lga08MKbPtpy
	 CN7D8wQo2zeLd3U/H0CE5yXTi4XSLV/sulhV6o7hblEB0LC09wHNMhsZFUZzzd+UYH
	 Ivcjl2KNzQEINbz9yG/VgI/EEMzk4/vqFgMULsaOduGDbrfS95ot+tmWSn6LoFi8xr
	 J8C+FLiqchxGA==
Content-Type: multipart/mixed; boundary="===============5053280035690465242=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bc2698a797d32d2eced91c2bf78cea931076300bba801e67d2bf1e348eb7626a@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-41-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-41-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 40/43] bpf: Unclone the skb for kfuncs that write through a dynptr
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:17:13 +0000 (UTC)

--===============5053280035690465242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Unclone the skb for kfuncs that write through a dynptr

TL;DR: Dynptr-writing kfuncs may set seen_direct_write for programs with no
skb (XDP, global functions, callbacks), so freplace extensions with non-scalar
args that loaded before may now fail with -EINVAL.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d384b9ec3d93..47e2969928a4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -15689,6 +15689,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	    bpf_is_kfunc_pkt_changing(&meta))
>  		clear_all_pkt_pointers(env);
>
> +	/*
> +	 * These kfuncs write to the head of the skb in place if what they write
> +	 * to is linear. Like a direct write that takes bpf_unclone_prologue().
> +	 */
> +	if (is_kfunc_dynptr_write(&meta) &&
> +	    dynptr_write_changes_pkt_data(meta.dynptr_write_type))
> +		may_access_direct_pkt_data(env, NULL, BPF_WRITE);

Can this set env->seen_direct_write for a program that has no skb to
write to, and make an extension fail to load?

Since commit 19b8e38bcd08 ("bpf: Don't take a dynptr argument for a local
dynptr"), process_dynptr_func() reports every CONST_PTR_TO_DYNPTR argument
as an skb dynptr:

    meta->dynptr.type = is_arg ? BPF_DYNPTR_TYPE_SKB : reg->dynptr.type;

That covers dynptr arguments of global functions and extensions, and
callback dynptrs, in any program type.

may_access_direct_pkt_data(env, NULL, BPF_WRITE) also sets seen_direct_write
for XDP, SK_MSG and CGROUP_SOCKOPT.  None of those can hold an skb or
skb_meta dynptr, since bpf_kfunc_set_skb and bpf_kfunc_set_skb_meta are not
registered for them.  Their gen_prologue is bpf_noop_prologue() or
cg_sockopt_get_prologue(), which emit nothing.

seen_direct_write is now also read by the extension check that commit
222dc092c64e ("bpf: Refuse the prologue for an extension that cannot take
it") added to bpf_convert_ctx_accesses():

    if (env->seen_direct_write &&
        env->prog->type == BPF_PROG_TYPE_EXT &&
        !ext_prog_takes_prologue(env)) {
            verbose(env, "Extension writing packet data must take ctx and scalars only\n");
            return -EINVAL;
    }

This runs before gen_prologue(), so it fires even when the prologue would be
empty.

For example, take an XDP target with a global function:

    int f(struct xdp_md *ctx, struct bpf_dynptr *d)

that calls bpf_dynptr_memset(d, ...), and an freplace program for f that
does the same.  In the extension R2 is CONST_PTR_TO_DYNPTR, so
meta.dynptr_write_type becomes BPF_DYNPTR_TYPE_SKB and the new code sets
seen_direct_write.  ext_prog_takes_prologue() then fails because args[1] is
ARG_PTR_TO_DYNPTR and not ARG_SCALAR, and the load fails with -EINVAL.
Before this patch the program loaded, and nothing in it can touch an skb.

The same applies to bpf_dynptr_copy() and the probe_read/copy_from_user
dynptr kfuncs, and to callback dynptrs (for example bpf_user_ringbuf_drain())
in an extension whose signature has a non-scalar argument.  Extensions on tc
programs with such signatures are refused as well, even when every caller
passes a local dynptr.

Commit 19b8e38bcd08 says "nothing becomes forbidden for the dynptr itself",
but this makes the load fail for those programs.

Should seen_direct_write only be set for program types whose skb dynptr is
writable?  Alternatively, could the extension refusal depend on
gen_prologue() actually emitting instructions?

I did not find a later patch in this series that changes this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============5053280035690465242==--
