Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405883;
	b=EkU48SvTwRC+moT6tcLA0iQGD7XAIexapcF4Vess67B9pTdWR5xwaF4Ly+V/zua9J7+9
	 64ssnj7gOCOGBYcOWd4mSXPprO55LWEn6HbNjidbTm4LNoNpHOCSSlu41/Iecc653D+70
	 t6Ob6uMV99avauPtkIJREc98H56s1FwlSl4BReCAT/5Lwb3hZKuir+5D9wjOcIOSVrYZR
	 A7AQ8XVqxsmrvOxgA6rWbIAJgn1qfFhFbW9ld1MGsFkw/PmwxGHdjlz3pYLsvraPAJBYA
	 ikVeGYMLJtjbZTOFID5Z3W7S4Ug+6MZq2wNR29fW/taBENbGd1w21WyP1bmCtCV7v3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405883;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=TeSF1MOBRCgVjCyKZp5aEmkmpvhtzGO9AJPMgWHFfuQ=;
	b=NOwdDKeINDd5wvSf74FGm65Gc6gzt28QByJa/DsdmpTb5yLst5iqG6/0QXme9VgWbuwX
	 XYa1InJwWS2SDZmRGIXZhsD9lnjoEetIBEYkbyKV4Gdc7AinVzQ6gF4GD2L2yC1bfpORp
	 ipsNEdy4o6k5X7OxOli/87dm93DMdm+COLQSVNBbUz87NxUKFs2q2FbPHwMX6e7jWH5tR
	 e9LFZiWrg9+2kWFvBS5KdWVEgNT4em8rD2cC0/RLLBJpb/H0mD/kLvPuDCE0xobTlrTQi
	 QTxe/H1A3L5k5YSr7IMjsg1sUiU14C9ZXcoNH82Ii0Sp9XjcIp6LQdlMO9dwg4G55eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hq7VOkCw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42FB606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hq7VOkCw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8D21F00A06;
	Wed, 11 Nov 2026 14:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405883;
	bh=TeSF1MOBRCgVjCyKZp5aEmkmpvhtzGO9AJPMgWHFfuQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hq7VOkCw8WgvQiHhTF3qaHGY9QhqCAXwxL6QcqWHlmyGHdcQeJEMLw9wTCO7HcuSv
	 BrATQZRaTF1BSwxUI4RnhDcHgEJhAxctoh9zma4y7dLAw7q4sQRf5EPHeSm4YVK8SY
	 VxUxKRnOd8663EqoDnRBCL9+VjqsWB3f68dO7aQ/qtzpvLrrBMRpfP5y/BUvy8xyUe
	 vZuXDIK6/0w3T2v9we7NextunpuigEclMp4drdY8+Qs4nEtadktfcScEU4oDEkPlnY
	 phIUrG0/6kZjHURHY/QB/Dx8O1KjpfCnEYynm5Ziwxoa88HzJiiNUSXCJ8iUwckli8
	 NHlnL1UUJAhgw==
Content-Type: multipart/mixed; boundary="===============7391559523468997025=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <adc5bcd78b212b602b8838a0268fa43fa613fc1a8782031c9a8a1f830462a654@mail.kernel.org>
In-Reply-To: <97453d9e1f65a31c7f6ffbc09a7eb9f89913c5f3.1794399387.git.memxor@gmail.com>
References: <97453d9e1f65a31c7f6ffbc09a7eb9f89913c5f3.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 20/29] bpf: Transfer a reference to the callee that releases it
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 14:04:42 +0000 (UTC)

--===============7391559523468997025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Transfer a reference to the callee that releases it

TL;DR: bpf_frame_desc_record_call() skips its speculative-state guard for
callbacks and callx (state is NULL), so a speculatively explored call may
wrongly mark an argument entry_none and cause the verifier to reject a valid
program.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> index d2ad02925f06..6679f134b14e 100644
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c

[ ... ]

> +int bpf_frame_desc_record_call(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
> +			       struct bpf_func_state *callee, int callsite)
> +{
> +	struct bpf_subprog_info *sub = &env->subprog_info[callee->subprogno];
> +	struct bpf_reference_state *ref;
> +	int i, k, acq, err;
> +	s16 adj;
> +
> +	if (!env->describe_frames || (st && st->speculative))
> +		return 0;

setup_func_entry() passes st == NULL for every callback and every callx:

	err = bpf_frame_desc_record_call(env, set_callee_state_cb == set_callee_state &&
					 bpf_pseudo_call(&env->prog->insnsi[callsite]) ? state : NULL,
					 callee, callsite);

Can the state still be speculative in those cases?  push_callback_call()
builds callback_state with push_stack(), which copies cur_state including
->speculative, and check_func_callx_one() -> check_static_func_call() ->
setup_func_entry() runs on env->cur_state.  Speculative states come from
sanitize_speculative_path() on the dead side of a decided branch when
!env->bypass_spec_v1, and from the code after an unwind_goto.

With st == NULL the speculative guard is skipped:

> +	for (k = BPF_REG_1; k <= BPF_REG_5; k++) {
> +		struct bpf_reg_state *reg = &callee->regs[k];
> +
> +		callee->entry_arg_id[k - 1] = 0;
> +		callee->entry_arg_acq[k - 1] = 0;
> +		if (reg->type == SCALAR_VALUE || reg->type == NOT_INIT) {
> +			if ((sub->consumes & BIT(k)) && !bpf_register_is_null(reg))
> +				sub->entry_none |= BIT(k);
> +			continue;
> +		}
> +		callee->entry_arg_id[k - 1] = reg->id;
> +		if (!(sub->consumes & BIT(k)))
> +			continue;
> +		for (i = 0, ref = NULL; st && i < st->acquired_refs; i++) {

[ ... ]

> +		if (!ref) {
> +			sub->entry_none |= BIT(k);
> +			continue;
> +		}

For a consumed register holding a pointer or a non-zero scalar this sets
sub->entry_none |= BIT(k).  entry_none lasts for the whole round, and
bpf_frame_desc_resolve() then rejects the program with "R%d of the subprog
at insn %d is what its caller holds on some calls only" when the subprog's
BPF_RES_F_ENTRY acquisition needs a hidden slot.

Every other recorder (bpf_frame_desc_record_acquire(), _record_release(),
_record_exit(), _record_return(), _record_site()) skips speculative states,
and so does the direct-call path of this function.  Could a callback call
such as bpf_loop(..., cb, ctx, ...), or a callx of a consuming subprog,
that is reached only on a speculatively explored path wrongly mark the
argument as one that some call passes something else in, and cause a
program the non-speculative paths would accept to be rejected?

Would testing env->cur_state->speculative (or the passed state) separately
from whether the call hands anything over make this consistent with the
other recorders?

The later commit acd08268bd12 ("bpf: Support callx when a callee releases
resources") changes setup_func_entry() to pass the state for callx, so the
guard covers callx from then on.  Callbacks still pass NULL at the end of
the series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============7391559523468997025==--
