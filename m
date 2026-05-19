Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764B383C8F
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217411; cv=none; b=ZilF0v+hx7vxaD7cWAymiXkUPMn8WV85uZqmXRfTaxTYE7OMkACy/jyvfs43o4IQICTURf9vE7FcVH2dhvh581Oako1653eGyq74E/vvFsK8o9p/wBcaO5g509X2o7HIvljiDyJClI0zItiii+3bHvgNj5HMrwTIfgp9gJ1IMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217411; c=relaxed/simple;
	bh=NMUvKikhf/L0a49QoY46V+AxTYBJG5AMcrqBG+qZOXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UZscJsNy4Ps8N9rKwWvXzj2uR6ZG/XMwJ/r3D6XQLz1j/CItbRLvEbsgp8QrzSGnIW33RTDxZsq7u/4Un1swzb6v8/rmDjQgVpcZ9G6E1uq+LUoJxJQwi8w5G/KVslmqactW3CKBReXawp3ce/omST9O8s4GtVCc6PZV/WCyJ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEw0mQXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEw0mQXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207401F000E9;
	Tue, 19 May 2026 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779217410;
	bh=qk/S0LFn7byRWpAykBeF7G1bOaSkw08IbZOZsz3bPuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DEw0mQXNFWMSv5jzp/DX3Cn5/5J49lmTvNKavGI7zFkXli+2RbgVPojDuOgj5GrCH
	 YCZvcQQmMtMLQiosqARzJDye82cV/jn+sESRmYXo6Yd+LRUbfaJpydS1MegGHgsZMV
	 tAcH2jS9KGwmMiX9igr0Q/zCWoeBJVrXO+p7LbsuLRryYur9Pctw80Keej4rAmjyZo
	 8DIAI/MrZDmMo9quGhYOSBPkO1sj7i5llKxV+g5vR1qF62uN0P+sFDWMaX/cQdEJVk
	 TG/gTx07eLNPKYAP8qMBYb9wSy0xweENOs5dAC7YbNBF/xapYKJOOshgXCjl4sUWiE
	 d0J/QCjpkC4lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 10/14] bpf: Fix dynptr ref counting to scan
 all call frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519181314.2731658-11-ameryhung@gmail.com>
References: <20260519181314.2731658-11-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 19:03:29 +0000
Message-Id: <20260519190330.207401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The macro `bpf_for_each_reg_in_vstate_mask` incorrectly comput=
es the `stack` pointer when iterating over outgoing stack arguments. The ne=
w `dynptr_ref_cnt` function uses this macro and dereferences the invalid po=
inter, leading to a verifier crash or security bypass.
--

commit 2fbeda3e91d76b77c3a4fe5a3269d7a89c9d8588
Author: Amery Hung <ameryhung@gmail.com>

bpf: Fix dynptr ref counting to scan all call frames
   =20
This commit extracts dynptr reference counting into a new dynptr_ref_cnt()=
=20
function to check whether a referenced dynptr can be overwritten. It uses=20
bpf_for_each_reg_in_vstate_mask() to scan dynptr stack slots across all=20
call frames instead of just the current frame.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b7984c42ca145..97eb8033d732e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -786,10 +786,29 @@ static void mark_reg_invalid(const struct bpf_verif=
ier_env *env, struct bpf_reg_
[ ... ]
> +static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
> +{
> +	struct bpf_stack_state *stack;
> +	struct bpf_func_state *state;
> +	struct bpf_reg_state *reg;
> +	int ref_cnt =3D 0;
> +
> +	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, 1 <<=
 STACK_DYNPTR, ({
> +		if (!stack || stack->slot_type[0] !=3D STACK_DYNPTR)
> +			continue;

[Severity: Critical]
Does bpf_for_each_reg_in_vstate_mask() safely provide the stack pointer when
iterating over outgoing stack arguments?

Looking at the macro definition in include/linux/bpf_verifier.h:

    bpf_for_each_spilled_stack_arg(___j, __state, __reg) { \
        if (!__reg)                              \
            continue;                        \
        __stack =3D &__state->stack[___j];         \
        (void)(__expr);                          \
    }

When iterating over outgoing stack arguments, it calculates __stack using t=
he
local stack array (__state->stack). Since out_stack_arg_cnt is independent
of allocated_stack, __state->stack could be NULL.

If ___j > 0 and __state->stack is NULL, __stack would evaluate to a non-NULL
offset. Would this bypass the !stack check above and result in an
out-of-bounds read or page fault when evaluating stack->slot_type[0]?

Additionally, if __state->stack is valid, could this evaluate the same local
stack slot twice, artificially inflating ref_cnt and potentially bypassing
the ref_cnt <=3D 1 check?

> +		if (!stack->spilled_ptr.dynptr.first_slot)
> +			continue;
> +		if (stack->spilled_ptr.parent_id =3D=3D v_parent_id)
> +			ref_cnt++;
> +	}));
> +
> +	return ref_cnt;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519181314.2731=
658-1-ameryhung@gmail.com?part=3D10
