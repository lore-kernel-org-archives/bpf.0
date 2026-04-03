Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02963C5DDB;
	Fri,  3 Apr 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226653; cv=none; b=EJUDBzafuFfAM5+2NDY4jbI7LfyxOeAdmu3xyF6pgYGT0F6RsFbdgw+M+1YyNaBGWcGFjt/mWOuRBxoas4miIJC3d3Mfrj4RmyyrfAZjoOepea3oDu9z8yKp/0mfdmzzJ3nlfV/s1/u1LjNpnqRhTeWxAfjM33MphxeKsSdamT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226653; c=relaxed/simple;
	bh=Ph0s8jNFWIbP2rJPQvULbZ2x0gslejGFneauyzarkl0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YMwAO12ulrkM1zsqmUrEYe9ou4WgklyL4G+n9L8drK3EG+M83fNA/epZn446qb2K5GgMJ4ffYqWEW9iT54k9RGiHxVNURViqoYwGy0zAm/B60arNqHibeb+IZA5JQrgpwqQZwP+m9ZxhNySMSfa+VRIvchjY/b7iCnkePFnSDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Njo06mBf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Njo06mBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EEEC19421;
	Fri,  3 Apr 2026 14:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775226653;
	bh=Ph0s8jNFWIbP2rJPQvULbZ2x0gslejGFneauyzarkl0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Njo06mBfUW4Vie5R5F38MZRVRU7KKvM6YoYP1OUXT9wHYW4E89HvJoMu4bKIxmyYO
	 1D4jT8ZVQFtD6ZHGnSnAUreicxMxZbfcD6hfzOdN237AY1KOmYr4JT7mvB+XZsKVKC
	 GlX7o4nH4syMNF0dYaxEo0A3oULo1LpsTL5MxE3Xzq0fudTO8aBWAKwRcaoGl+tV1n
	 bR0ZmoH8yWHqfncMlE/m7wd2UdJktk5+apZ5fcsaZ9kfW3DdKqG/cqQB4BjA5bB2lF
	 M0pGg6DY+qWOWbaBfpWOsVBvxB6FgRfl1zPsJbYo7dj+l4XyaTNNdNB53hrrOof/ZT
	 lXjE1ZSfOdlDw==
Content-Type: multipart/mixed; boundary="===============9218033960697897612=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ad939c6a7364bd33eabc4eeadb80f904a947bb769093b550002d2cd818260a36@mail.kernel.org>
In-Reply-To: <20260403132811.753894-3-xukuohai@huaweicloud.com>
References: <20260403132811.753894-3-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v12 2/5] bpf: Pass bpf_verifier_env to JIT
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,alexis.lothore@bootlin.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 14:30:52 +0000 (UTC)

--===============9218033960697897612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index cc61fe57b98d..093ab0f68c81 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -2551,47 +2528,63 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
>  	return select_interpreter;
>  }
>
> -static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
> +static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
>  {
>  #ifdef CONFIG_BPF_JIT
>  	bool blinded = false;
>  	struct bpf_prog *orig_prog = prog;
> +	struct bpf_insn_aux_data *orig_insn_aux;
>
>  	if (bpf_prog_need_blind(orig_prog)) {
> +		if (env) {
> +			/* If env is not NULL, we are called from the end of bpf_check(), at this
> +			 * point, only insn_aux_data is used after failure, so we only restore it
> +			 * here.
> +			 */
> +			orig_insn_aux = bpf_dup_insn_aux_data(env);
> +			if (!orig_insn_aux)
> +				return orig_prog;
> +		}
> +		prog = bpf_jit_blind_constants(env, orig_prog);

[ ... ]

> +	return prog;
> +
> +out_restore:
> +	bpf_restore_insn_aux_data(env, orig_insn_aux);
> +out_free:
> +	kvfree(orig_insn_aux);
>  #endif
>  	return prog;
>  }

When the out_restore label is reached (blinding or JIT failure with
env != NULL), bpf_restore_insn_aux_data() sets env->insn_aux_data to
point to orig_insn_aux:

kernel/bpf/verifier.c:bpf_restore_insn_aux_data() {
    vfree(env->insn_aux_data);
    env->insn_aux_data = orig_insn_aux;
}

The code then falls through to the out_free label, which calls
kvfree(orig_insn_aux). This frees the memory that env->insn_aux_data
now points to, leaving it as a dangling pointer.

Since this function is called from inside bpf_check() via
__bpf_prog_select_runtime(), the subsequent cleanup in bpf_check()
accesses the freed memory:

kernel/bpf/verifier.c:bpf_check() {
    ...
    clear_insn_aux_data(env, 0, env->prog->len);
    vfree(env->insn_aux_data);
}

Could the out_restore path return directly instead of falling through
to out_free, since after the restore env now owns orig_insn_aux and
bpf_check() will free it during normal cleanup?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23948799625
--===============9218033960697897612==--
