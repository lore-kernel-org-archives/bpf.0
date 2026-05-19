Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311330E853
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216339; cv=none; b=VowLWekbICoZyP9Jko/BVyR/tz2j/TchONEDuVE7o5xp9VavS9qB4/6NX6BGFoDMzXwCI1ciOivWqnZi+6o9+YCqDnXZXUZ4GgKBQwlf9sXHcFEpD0Shfhi73g1guRDgbbviirYy2vPWh+5qqBdvqfuSKCLrVX+aFp/0HoTHMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216339; c=relaxed/simple;
	bh=GMU4c7rfGsGNw/iuIQBApzQMONTqTb86Qov6bFwupNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Grf40r5kQNKk9MzJIlBb2hhlBtkC3VTA7JC/7E4kRoFGTjZvvKkOSjjgjCJNa/z51azd1P0X2KhIQkj6yIAKjvEMYCXZm4JLtqyog+DU1WnNOPBz3IbP1fulPWWyVljI4BKIbqpVQfILCGurBM3oa42hx51UFUcz9vLxmaC/6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foURA0BQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foURA0BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A705C2BCB3;
	Tue, 19 May 2026 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779216338;
	bh=GMU4c7rfGsGNw/iuIQBApzQMONTqTb86Qov6bFwupNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=foURA0BQbZx+NQrbeJvNBbEhh9tgut4nSNDgS1f28tcohIr5lK2Q4XOAvi3dIU+1A
	 K+/rSrFhyX38JZuQ7hyGDB8zoG4MdK2q7tjHMqZiNip50XDDEKhruvTAnfhPHjmSkN
	 F1g7gTPWigLYORRbFauB9MvnJ6LDWzfSOrNMjTAzr5gmkQcGuVrnAS897cLN6CFKkc
	 wuEeBSXT5YEO3bdJj5n+ZL0/LyUdkcdby+eGEx8n7Ni7EyeWYzO6L34rTrCyB2Zk7C
	 nU/7y0bn2gjKhqMb5GUg5fm6rlgDbWEK4QtvTaoEms/DKA0vq18b2YFeXH9E/dqY20
	 Ge1S4iFd+L1LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 05/14] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519181314.2731658-6-ameryhung@gmail.com>
References: <20260519181314.2731658-6-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 18:45:37 +0000
Message-Id: <20260519184538.7A705C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Incorrect indexing of `__state->stack` for outgoing stack argu=
ments in the `bpf_for_each_reg_in_vstate_mask` macro leads to out-of-bounds=
 heap access and potential memory corruption.
--

commit 936dee8aae85e40857f1379da85e7a73536e2261
Author: Amery Hung <ameryhung@gmail.com>

bpf: Refactor object relationship tracking and fix dynptr UAF bug

This commit refactors object relationship tracking in the verifier and fixes
a dynptr use-after-free bug where file/skb dynptrs are not invalidated when
the parent referenced object is freed.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2cb4c7b0eab68..d83b9fbfef7f0 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -585,7 +591,7 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_s=
tate *frame)
>  	     iter < frame->out_stack_arg_cnt;                          \
>  	     iter++, reg =3D bpf_get_spilled_stack_arg(iter, frame))
> =20
> -#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, _=
_expr)   \
> +#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __stack, =
__mask, __expr)   \
>  	({                                                               \
>  		struct bpf_verifier_state *___vstate =3D __vst;            \
>  		int ___i, ___j;                                          \

[ ... ]

> @@ -600,19 +607,26 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func=
_state *frame)
>  			bpf_for_each_spilled_reg(___j, __state, __reg, __mask) { \
>  				if (!__reg)                              \
>  					continue;                        \
> +				__stack =3D &__state->stack[___j];         \
>  				(void)(__expr);                          \
>  			}                                                \
>  			bpf_for_each_spilled_stack_arg(___j, __state, __reg) { \
>  				if (!__reg)                              \
>  					continue;                        \
> +				__stack =3D &__state->stack[___j];         \

[Severity: Critical]
Is it safe to index the stack array using the out_stack_arg_cnt index here?

In the bpf_for_each_spilled_stack_arg loop, ___j represents the index into
the stack_arg_regs array, which is bounded by out_stack_arg_cnt. However,
this line sets __stack =3D &__state->stack[___j], which indexes the local
function stack array (bounded by allocated_stack / BPF_REG_SIZE).

Since a BPF program can push stack arguments without allocating a local
stack, ___j might exceed the local stack size, computing an out-of-bounds
pointer.

When release_reference() iterates over these registers, it evaluates
stack->slot_type[BPF_REG_SIZE - 1], which reads out-of-bounds memory.
If this memory coincidentally contains the value for STACK_DYNPTR (2),
could this result in invalidate_dynptr() being called erroneously,
writing STACK_INVALID across multiple slots and corrupting adjacent
kernel memory?

>  				(void)(__expr);                          \
>  			}						 \
>  		}                                                        \
>  	})

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519181314.2731=
658-1-ameryhung@gmail.com?part=3D5
