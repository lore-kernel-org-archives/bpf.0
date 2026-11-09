Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246148;
	b=i8XmHOteEfXaTxvinkY12gltltowndps3l1DUj8x165BzztFwaGfAiloFmJVDdqb3VQE
	 wZngASXnaCwEMOl7X+CbW0AYu4yrUpuK36dY0Qn20V8OUnm7TjsbiM599WfpfZoU0YfFn
	 0j+zsELt28Nrex+K3z0UsLG3rRxuvE+sWrdkBM2KpwoMCLRWQzoi8P8sZLt3A2UDDzpyQ
	 y5vxY9rtSydvNiGt/quaLcPwhyHkagggC2IkjRidpII80MRJOr5/MlEI1zzyw0DRdWJ5C
	 ZUTr5cw7IFtcCvsnwg3LQ/hZkKmv1EZ0EMgS6AuE8Apn+7qHI5UKRJRAE/PcJOhf3hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246148;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=lqx2H9imt9WgEJPnN4yc6UALedXuR2BknQ9XVjKX4Bw=;
	b=tF66ql7CxwQOJlrcHm7wEemj7wkYPy7oCOJ1Wq7ov8HRExA1lEKrWXWRgWlzoQbEaBX2
	 yGpOj4oDndigz3/mbiL+GUR/muigWrBsm2ymSbACQErkJdWwFVr2zDtSQOazbCv3AbUPX
	 FXyaFVF4U+lkqBoMmWwo2LvfTjCvZitcTEQSrdR0GfBbYhe7orq0T1nktFWPUZJXijbZJ
	 NE9JgwMEX3aoUZjLoWPt+yawSbSV92LYqMocR+571NLc7tsFJD3FypAsWCsM746bvTs5S
	 /1dePG+mNXRm1fRwo+sAFMPLFL6hUc0p7tYie91Nw0p1xwJ7VW3+SLDOgoVr3hygq2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrPH3rY0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A48606A333;
	Mon,  9 Nov 2026 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrPH3rY0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504B01F008A1;
	Mon,  9 Nov 2026 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246147;
	bh=lqx2H9imt9WgEJPnN4yc6UALedXuR2BknQ9XVjKX4Bw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HrPH3rY0gLQYe/WZzm3/88Kf8/og3tlEoULrbOoRpal5x2YrKXCGQi38zq3eS+NCJ
	 IL/7H1z1smHBPqZUSTVWfN784VNJ5zzlTBVHG4OUNCRdnDjgEBVV5nmpF+XFTpzb9E
	 xTKyOjZvi6VAFwyV4+JSvUdvJHANuf/Y3HzNb3d0Qo7kilY/96K57Y+WXG5EtIXERC
	 IhmOYEaUN+12UkKA8/UsumHPRyxeLxjgxm6ic4wPI/DhMQBcozh8u9UDpKwAge4pOb
	 MRfoce8h/Ct8IgJbWPJg+dR+W5Af23NbA5xawctN+uYdMg4t5llwehl3xmjF8DwF1X
	 y095DapFgGn4g==
Content-Type: multipart/mixed; boundary="===============4528103460114025577=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1760ad16d930af8fe5c9bdcc74de2ecb3307c2ae57db0bdcead7505d5d9ff630@mail.kernel.org>
In-Reply-To: <20261109170550.141443-14-a.s.protopopov@gmail.com>
References: <20261109170550.141443-14-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 13/18] bpf: Check the return values of fmod_ret programs on found targets
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 17:42:27 +0000 (UTC)

--===============4528103460114025577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check the return values of fmod_ret programs on found targets

TL;DR: The fmod_ret return check may wrongly reject valid programs: when
states returning two allowed constants merge at a shared exit, R0 becomes a
range, not a constant, and the load fails.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +/* The program must return a constant: 0 or one of the values of the tag */
> +static int check_fmodret_retval(struct bpf_verifier_env *env, int regno,
> +				const char *exit_ctx, const char *reg_name)
> +{
> +	const struct bpf_prog_aux *aux = env->prog->aux;
> +	struct bpf_reg_state *reg = reg_state(env, regno);
> +	u32 i;
> +
> +	if (reg->type == SCALAR_VALUE && tnum_is_const(reg->var_off) &&
> +	    fmodret_retval_allowed(aux, reg->var_off.value))
> +		return 0;

Can this reject valid programs when two allowed constants are joined at a
shared exit?

The main pass is the fixpoint in kernel/bpf/flow.c, and flow_merge() joins
states that reach the same basic-block head.  For SCALAR_VALUE, join_reg()
-> join_range() produces the union range.  flow_join_makes_up() only
refuses the join when flow_gap() finds values in the union that neither
state has, and only while flow_has_room().  The FLOW_NEED_ARG table has no
entry for R0 at BPF_EXIT, so flow_needed_consts_differ() does not keep the
constants apart.

For a target tagged "bpf_fmodret_retval:-12,-11":

  r2 = *(u64 *)(r1 + 0)
  r0 = -11
  if r2 == 0 goto +1
  r0 = -12
  exit

The states at exit (R0=-11 and R0=-12) are disjoint but leave no gap, so
they become R0=[-12,-11] and tnum_is_const() fails.  The load then fails
with:

  At program exit the register R0 must be a constant, it should be 0 or
  one of -12,-11

even though every path returns an allowed value.

The same can happen with the common pattern "r0 = 0 ... r0 = -1; exit" when
the tag contains -1, since the 64-bit constants 0 and 0xffffffffffffffff
touch on the circle and are joined.  Once a program uses half of the state
limits, flow_has_room() is false and even gapped values such as -34 and -22
are joined.

The selftest join_both_paths avoids this only by using two separate exit
instructions, and whether exits are merged is the compiler's choice.

Every other exit check so far was a range check via retval_range_within(),
but this one needs set membership.  Should R0 at the main-prog exit (and R1
at bpf_throw without a callback) be added to the FLOW_NEED_ARG table for
programs with fmodret_retvals, or should a small bounded range be accepted
when every value in it is 0 or in the list?

The feature becomes reachable once 1c163e52401e ("resolve_btfids: Tag
fmod_ret candidates as targets") emits the tags, and no later commit in the
series changes this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42662799554
--===============4528103460114025577==--
