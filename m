Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7238F95E;
	Fri,  3 Apr 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211402; cv=none; b=PNNykN3ela9qXNPEwHZBeI3q5QLK411myIrKUUp3cU8zOCepDjENdl1/SkESW4KZW6LqLMfLIYR1CBhony5aLzmayyQchZORvSYP3A9zUzzgegcjXwnVf19x/3S5FHKfD4suKqRAQnUlR3gjIYuV8ZneMxmjTRMlkVFg69oWKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211402; c=relaxed/simple;
	bh=vJcrMCFWi3eVzyJNqr5vaLE810lzwaTLsguHO5sXDbE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pzbDJfyYKlvX33sSABiFf3f8hrRVToQDP7A4JOqM3DNUR3djOklgGXlAnKbU6wkjtkmeyYjtXRIReuJRYkj2YefGIs02Ebt2galkSrjdQokztEc5imR5Xh11OW3dknEfECqi7p8nCM/WT5i3kW0IngB6bW0u5y/NBv3FnUPPHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ar2Nqmqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ar2Nqmqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C875C19424;
	Fri,  3 Apr 2026 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775211401;
	bh=vJcrMCFWi3eVzyJNqr5vaLE810lzwaTLsguHO5sXDbE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ar2Nqmqrw2/cBEhIRcDPY5fAvwVyfVAcnpauo/1KqYBG2TCbSBd+9gEbEwRxvUDO1
	 hFBOy3+D3FIw60MHO3K1Qp+vVCVkodRVdVJt3/1xfPJGYmW1Cze1Bz2q+J2u1y61pq
	 lresNR+/SiKpq/FDqxNQuzYcI/yZeoy/xjiybBkm0FwFdRZdrS+50Kh9gZoor2TmiA
	 qNKHw1uQKeGhx9JreI1mroZmZRT7tqq9j75FRZm1ItETTCIeV5GRL1pl4H1vYCrr3e
	 zVkQnWTfIei6Z09bdqhDKjjErNF3pvZwz7c+cMfEXny2gwVt9v/UMOUWf07CNex89c
	 N+JmIeVhByILQ==
Content-Type: multipart/mixed; boundary="===============5612373391882020586=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <03e4fec040d9458797f717e7778cc61a69ed1fd862782df81a7b59c82fad03c7@mail.kernel.org>
In-Reply-To: <20260403090915.473493-2-xukuohai@huaweicloud.com>
References: <20260403090915.473493-2-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v11 1/5] bpf: Move constants blinding out of arch-specific JITs
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,alexis.lothore@bootlin.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 10:16:41 +0000 (UTC)

--===============5612373391882020586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a431b7d50e1b..0d6bfccf0dd7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static int jit_subprogs(struct bpf_verifier_env *env)
> +{
> +	int err, i;
> +	bool blinded = false;
> +	struct bpf_insn *insn;
> +	struct bpf_prog *prog, *orig_prog;
> +	u32 *orig_subprog_starts;
> +
> +	if (env->subprog_cnt <= 1)
> +		return 0;
> +
> +	prog = orig_prog = env->prog;
> +	if (bpf_prog_need_blind(orig_prog)) {
> +		if (!IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON)) {
> +			orig_subprog_starts = dup_subprog_starts(env);
> +			if (!orig_subprog_starts) {
> +				err = -ENOMEM;
> +				goto out_cleanup;
> +			}
> +		}
> +		prog = bpf_jit_blind_constants(env, NULL);
> +		if (IS_ERR(prog)) {
> +			err = -ENOMEM;
> +			goto out_restore;

When bpf_jit_blind_constants() fails, prog holds an ERR_PTR value.
The goto out_restore falls through to out_cleanup which dereferences
prog:

    prog->jit_requested = 0;

That would be dereferencing ERR_PTR(-ENOMEM).

> +		}
> +		blinded = true;
> +	}
> +
> +	err = __jit_subprogs(env);
> +	if (blinded) {
> +		if (err) {
> +			bpf_jit_prog_release_other(orig_prog, prog);

Similarly, when blinding succeeds but __jit_subprogs() fails,
bpf_jit_prog_release_other() frees the clone through
bpf_prog_clone_free(). After this, prog points to freed memory,
and the goto out_restore falls through to out_cleanup where
prog->jit_requested is a use-after-free.

Both paths could use orig_prog (or env->prog, which was restored)
at out_cleanup instead of the stale prog local variable.

> +			/* roll back to the clean original prog */
> +			env->prog = orig_prog;
> +			goto out_restore;
> +		} else {
> +			bpf_jit_prog_release_other(prog, orig_prog);
> +			if (!IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON))
> +				kvfree(orig_subprog_starts);
> +		}
> +	} else if (err) {
> +		/* We will fall back to interpreter mode when err is not -EFAULT, before
> +		 * that, insn->off and insn->imm should be restored to their original values
> +		 * since they were modified by __jit_subprogs.
> +		 */
> +		if (err != EFAULT) {

The comment says "when err is not -EFAULT" but the code checks
err != EFAULT (positive 14).  Since __jit_subprogs() returns
negative error codes, this condition is always true.  Should this
be err != -EFAULT?

> +			for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
> +				if (!bpf_pseudo_call(insn))
> +					continue;
> +				insn->off = 0;
> +				insn->imm = env->insn_aux_data[i].call_imm;
> +			}
> +		}
> +		goto out_cleanup;
> +	}
> +
> +	return 0;
> +
> +out_restore:
> +	if (!IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON)) {
> +		restore_subprog_starts(env, orig_subprog_starts);
> +		kvfree(orig_subprog_starts);
> +	}
> +out_cleanup:
> +	/* cleanup main prog to be interpreted */
> +	prog->jit_requested = 0;
> +	prog->blinding_requested = 0;
>  	return err;
>  }

[ ... ]

> @@ -26456,7 +26529,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>  err_unlock:
>  	if (!is_priv)
>  		mutex_unlock(&bpf_verifier_lock);
> -	clear_insn_aux_data(env, 0, env->prog->len);
> +	clear_insn_aux_data(env, 0, env->blinded_insn_aux_len ? : env->prog->len);

When blinding succeeds but JIT fails and jit_subprogs() rolls back
env->prog to the original (shorter) program, blinded_insn_aux_len
is larger than env->prog->len.

clear_insn_aux_data() iterates to blinded_insn_aux_len and calls
bpf_is_ldimm64(&insns[i]) on each entry.  The insns array comes
from env->prog->insnsi, which only has env->prog->len entries.
Can this read past the end of the program instructions array?

>  	vfree(env->insn_aux_data);

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23941975318
--===============5612373391882020586==--
