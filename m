Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579683;
	b=oMYSmzocoBI9g48n8M46mQS3d80OO8+X8uL4mFNWNDUnPXmWpdhyXC5+WrYniRQzClwE
	 0fu1T3gLdHU02EBsF8qFbe7+eWONS+shbVVQKsGYazGqBq7IRt7nNBZK6Gs4bgYYdCRQI
	 lNVmTtjCq+T/9q95fhsYSnFPojA2c/ygNGNVoTY/QxcUTXt+j8KVH3vcrhNBKLQXHE1Zh
	 YFeyE5ZDFXR9Bf1WU8Z2bSgk0n8q8CMk9elqSF0PHx1aF4L7kPeqMUQe74gh5sm5wUIye
	 nc+4dHbr+FYQATd04A1ozCcMrORROmYoltdoLM98IPVSm5gX0SUI6Bn4FOynwxadRsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579683;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uGLy1/aQEi5z1IyTDHHxXa/AIlYBpD6FYJ1Jq8T5y+U=;
	b=lEj/K/tW5kOjzOsWvVWhfIKdlVEFSwvLszYyylgviWG+BJxeI0UhkGyGrU+KuksDGV4z
	 dtkdIxIZssPSEz20BqhBy43rHpNjeYVYuEtLih7gqw5WlcnJcG7y+DtWADrD2Wm/GHS1D
	 Q36RGo3rr4vOJHcr6h7IuQ5EccDOauEEPcMv4qkthHmWEmeLKEzsrk+wQrrxODfbC95Rw
	 5gCnQ/q2rdebwGLvuro2putayjcfQaQfE7EcWhtIvvkA9HXqPPvRqmgODNRTaPhuDgOvP
	 N7B809gkT/8pcRXKdExycUTLzTDVZ4p7MoWRa/I8ZKzRVBG5qqEmfN99zmJHLefRXxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+6zV6sq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535F606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+6zV6sq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB351F000C0;
	Wed, 25 Nov 2026 04:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795579682;
	bh=uGLy1/aQEi5z1IyTDHHxXa/AIlYBpD6FYJ1Jq8T5y+U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=N+6zV6sqryFrbtSQcYdOoHLw6zpqmEFmrZuKNPPBbTDEjVzBp30QXCagpIFwrmTK0
	 F3Zr7SBYoMfrGKEC1HEEWCphdWk5GfgTTJwxk1iSisfIgqbvbqOPM1e6rc2m85xPXH
	 ueMeXpHximEQ4CNXYqUBHLcX4jnAj9tKiE+n0V+zNPaP2PD1olrbscozkk4WbJcwrQ
	 AP1/t7WhftkcTc3GdqtOMx3hbicu08Jbled3ecsFMksDFrsOOWnh3ewIz14mhnvACB
	 NviJ5YC1DHBSBsFidZ8Ln315eg2X2EMkFPXfi/bMUixJUIPTGbTOc9Z1EZhk6yaC4N
	 evCqQ+VWL8EcA==
Content-Type: multipart/mixed; boundary="===============1620715916966486844=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <bc7e0d9a3d4ffdba358268cd6908d970ddac4a8bb94fdfd50af294b40cce6cee@mail.kernel.org>
In-Reply-To: <20261125032938.670542-48-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-48-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 47/47] bpf: Check the type of R0 at the exit of a struct_ops program
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 04:08:01 +0000 (UTC)

--===============1620715916966486844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check the type of R0 at the exit of a struct_ops program

TL;DR: Patch looks correct, but a pre-existing gap may remain: a void or
int-returning struct_ops program might exit with a referenced R0 and pass
verification, leaking a cgroup or skb reference.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 554d99c1c943..d4b31990fcb9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19608,7 +19608,8 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>  		 * matches the operator's return type and is in its unmodified
>  		 * form. A scalar zero (i.e., a null pointer) is also allowed.
>  		 */
> -		reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
> +		reg_type = base_type(reg->type) == PTR_TO_BTF_ID ?
> +			   btf_type_by_id(reg->btf, reg->btf_id) : NULL;
>  		ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
>  						prog->aux->attach_func_proto->type,
>  						NULL);

This change itself looks correct.  The following problem predates this patch
(it comes from 8d9f547f74c7), but it is in the same R0 check and this patch
does not close it.

check_reference_leak() lets a struct_ops program exit with a REF_TYPE_PTR
reference whose id equals R0's id, without looking at the operator's return
type:

    if (type == BPF_PROG_TYPE_STRUCT_OPS && !exception_exit &&
        reg->id == state->refs[i].id)
            continue;

That exemption relies on check_return_code() verifying that R0 is a
referenced kptr matching the operator's return type.  Two paths in
check_return_code() return 0 without that check.

First, a void operator:

    /* LSM and struct_ops func-ptr's return type could be "void" */
    if (!frame->in_async_callback_fn && program_returns_void(env))
            return 0;

Second, an operator returning a non-pointer such as int or u32, where
ret_type is NULL.  is_pointer_value() returns false for every struct_ops
program because is_perfmon_prog_type() includes BPF_PROG_TYPE_STRUCT_OPS, so
the function reaches:

    if (prog_type == BPF_PROG_TYPE_STRUCT_OPS && !ret_type)
            return 0;

Can a tcp_congestion_ops .init program (void) then do this and pass
verification?

    cg = bpf_cgroup_from_id(1);
    if (!cg)
            return;
    r0 = cg;
    exit

bpf_cgroup_from_id() is KF_ACQUIRE|KF_RET_NULL in generic_kfunc_set, which is
registered for BPF_PROG_TYPE_STRUCT_OPS, so a cgroup reference would be
leaked on every call.  Similarly, an int-returning op with a __ref argument
(such as the skb in Qdisc enqueue) that sets r0 = skb looks like it would be
accepted, with the skb neither freed nor enqueued.

Should check_reference_leak() exempt R0 only when the operator returns a
struct pointer?  Alternatively, could check_return_code() reject a referenced
R0 when ret_type is NULL or the operator returns void?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45542192835
--===============1620715916966486844==--
