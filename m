Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1152121D
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865079; cv=none; b=rHvKpaSeS11L749yuDuqfGr1cYogmam6DCcJJEMhhE0ySIhxiR1ZLkQ6Jmq3R3SSe3oiLoq65h5b4SrufPU0nJ0X8A693CewVwLcxGpOhyEuovTV2sgi0H6e8jucR6njiyQXtcLwDQA/31fUbD5e1gXNS1EaYv+Ml/q4Vz4HjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865079; c=relaxed/simple;
	bh=h8l42kgFIs9n+Gxj1rCugy0SQHr15d4fJDcOgpU9sSE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZbwKtlmaaVxGHEJ+FdtLLdrldDr8ZztU+knihZa/wqPuEApmiDB26B8e0KxhQ+62uMAjK86VxbxEWN1xzIq8vDTcd0oRf8Q934rdQfZIg3WqEK+wXJkvT5JplQ7WeQ1BCQvMDnz3JfuvNtgt60e/QibPZypD2Rstn09eghzgYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWxHmes4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWxHmes4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CC41F000FF;
	Thu,  1 Oct 2026 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865073;
	bh=IiBXF3gXKlg6uADxSjpX49mXYILmvIFu2R2gpVl41Rs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mWxHmes4Q8LzTJuVrkhmWiWk4QxGBEsn3SvgqbiV0QG+OF7J9OpTGbmx14tC4ybhq
	 vIKEBB0NusSKouak1DNMKJybJ/etf0A8LD0AB7ngnPLv1OFWsox/tcxRmw4VAi3qRu
	 sSPbH6sOrFP2RHj3XEnzAeasAvEI9WRy8dRXoEWENwh6/APrxodwQdBDv3KL0UCD/I
	 Abr//bcCh/HYGxLtYFcjGtmRO/tl4OfdigR5gUk+cXJTZUv0ezN93w0VwrwvL2AnaW
	 sSNbCbKhh2e0FKMknNQQ6CKO5m3N12ILcNNQd8H3j/FKb9TDFgu/aclDoUufUEPCOT
	 S3ze3KGSADfzg==
Content-Type: multipart/mixed; boundary="===============0606346392735967780=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0660232bb0b94d963dba9a2f9022669c4e97c5e0a94bd7acc674f21f18b036e6@mail.kernel.org>
In-Reply-To: <20261001133032.1338455-1-yonghong.song@linux.dev>
References: <20261001133032.1338455-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 05/22] bpf: Prepare for an exception cleanup table before the CFG walk
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 14:31:13 +0000 (UTC)

--===============0606346392735967780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Prepare for an exception cleanup table before the CFG walk

TL;DR: bpf_exc_check_prog() rescans the whole program for bpf_throw, and a
later patch calls it at every bpf_unwind() visit, so verification time may
balloon on large programs; suggests caching the result.

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index 3ea1bff5cc90..e12cdb12cde3 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c
> @@ -141,6 +141,85 @@ int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_attr *attr,

[ ... ]

> +static int reject_throw(struct bpf_verifier_env *env)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < env->prog->len; i++) {
> +		if (!bpf_is_throw_kfunc(&env->prog->insnsi[i]))
> +			continue;
> +		verbose(env,
> +			"exception cleanup cannot be combined with bpf_throw at insn %u\n",
> +			i);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

[ ... ]

> +int bpf_exc_check_prog(struct bpf_verifier_env *env)
> +{
> +	int err;
> +

[ ... ]

> +	err = reject_throw(env);
> +	if (err)
> +		return err;
> +	env->prog->jit_required = 1;
> +	return 0;
> +}

Can this scan make verification time grow with the number of bpf_unwind()
instructions the verifier visits?

The commit message says the checks in bpf_exc_check_prog() are also run
"at every bpf_unwind()", and a later patch in the series (5de314709a62
"bpf: Dispatch cleanup pads by rewriting return addresses") does that from
process_bpf_unwind():

    static int process_bpf_unwind(struct bpf_verifier_env *env, ...)
    {
        ...
        err = bpf_exc_check_prog(env);

Each of those calls reaches reject_throw(), which walks all env->prog->len
instructions looking for bpf_throw.

None of the things bpf_exc_check_prog() tests can change once do_check()
is running: the offload flag, jit_requested, exception_callback_subprog and
whether a bpf_throw insn exists are all fixed before the main pass.  Only
env->ops can change, and only for struct_ops, in check_attach_btf_id()
before do_check().

So the scan gives the same answer each time, but every visit costs
O(prog->len) instead of O(1).  That means the BPF_COMPLEXITY_LIMIT_INSNS
budget no longer bounds verifier cost linearly; the cost becomes roughly
visits * prog_len.

For example, a program with about 500K reachable insns plus a bounded loop
of the form "if (x == i) bpf_unwind();" could reach bpf_unwind() tens of
thousands of times within the 1M processed insn budget.  Each visit would
rescan 500K insns, which is around 10^10 to 10^11 extra iterations, or
tens of seconds of extra verifier CPU for a single load.

Would it make sense to run reject_throw() once and cache the result in
env?  Alternatively, the bpf_unwind() path could re-check only the
gen_epilogue condition, which is the one that becomes known after
bpf_exc_prepare().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36872142096
--===============0606346392735967780==--
