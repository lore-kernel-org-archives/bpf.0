Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149311;
	b=gi0mfjweIImwVOAHrsloP+TXECPppiUFWuoSnX0ZrCMfYfV84RpoUh8pcYShXsBD7GfX
	 eFZWNCK9A43PlXPeV3Z6bQb7sxBSzdy1on339aU8+rhWIHFIsAVvZRUaub1y+jlvdORCN
	 sDL0kaI1AUwzayI0TD1OunTJ6LPX0Q9n+k6FgsCgYgTTGe22/QwegrptCcqGHkhGFEC4L
	 NuLr1y4QdL+4o8uyy/3MaSFfHcyHBXvBHCGUFNqen/GqeDI6U2ZFT76EcnhLpb+TLgwac
	 JcZq0uODxobakmMF6Cg+BujHDg+qHB/1fdOncjDkiQhRY5MKCj2sLtTkShFHCTUMPiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7SxndsUIPfOU2xcRYr8t7zUsb3V8DG158mvcBQpxGr4=;
	b=HR47husurYtfelfygKXN56ZzYdD/aTrY4dFojFhHPo4C7dreLIU7MCheNCcwh/uSr5Kg
	 41Xwe98eLozVln7qfTowcQS4gfnY/wH53TEPRYVARgF+mp0pZKINqsyfUnyTcuzJOMABi
	 HuG8YfoSIIQscIQAltIyGMDWT83gX8WIR7YfaM7SBz7kS+0lJfMqNDJzMMwfblgeTZXRE
	 bE3BhpHwi5f6f47bIv5HrUR5NnB24k2jYbDUTmc1BV7/uAZWgIEcVvwUfoI/3IBVnx4bQ
	 7NAR7mTjpJqNrJn5y9qlzEGex9TWcZKgGPvBNi9cVI/ZsKF7Y0478eSBx4/jPq57E8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BIoqDsMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE9606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BIoqDsMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B99D1F031E2;
	Wed, 28 Oct 2026 01:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149310;
	bh=7SxndsUIPfOU2xcRYr8t7zUsb3V8DG158mvcBQpxGr4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BIoqDsMypbtOSYIBub9vXOkQv9vfois63axqRHvHWpV23vGKdGFqSsceEcy3BmVFv
	 Xpp/rFcl6qS51Sztbke8wlcUzgluDQ1+ImUnAauLTJTbWutbs9T3/+XcDAEkcZJCnv
	 2yOf/pj+r2Om+xMZ7yHxEM0gEJ3lSdyUgJ1yCUHstlkGU+NFK6SXCu5IDcG3hQf/I9
	 8ihObyniigsl2+Rm3BvDn4R+QcVxh22b4Pe7k3qrOjRaiUw0d1QxbNx/NzI49pRZez
	 Cw+yTY0N/fO5Se/twklKL71XlB3u67geRDhQFt6stosrxjeMZfXfUHM6SvpbtaQgcP
	 Hwc4U2XLATtEQ==
Message-ID: <sashiko-outbox-187297@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 08/11] bpf: Let the callback of
 bpf_user_ringbuf_drain unwind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <98e3a499d89e01ddfb83fcf91e34b2a0e36e1007.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
 <98e3a499d89e01ddfb83fcf91e34b2a0e36e1007.1793147364.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:01:49 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: missing callback dynptr invalidation on bpf_user_ringbuf_=
drain() unwind
--

commit 5e41f31a219e475ec387e971ce587d69bc948017
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Let the callback of bpf_user_ringbuf_drain unwind

This commit adds an unwind pad to bpf_user_ringbuf_drain() so that its
callback can exit via unwind_exit while releasing the sample, clearing the
busy bit, and queuing any pending wakeup. It also adds
BPF_FUNC_user_ringbuf_drain to helper_has_cb_pad() in the verifier.

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 447863ece26a3..fdd997f36f73d 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
[ ... ]
> @@ -852,8 +854,23 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *,=
 map,
>  		}
> =20
>  		bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0, size);
> -		ret =3D callback((uintptr_t)&dynptr, (uintptr_t)callback_ctx, 0, 0, 0);
> +		bpf_call_cb(callback, &dynptr, callback_ctx, 0, 0, 0, ret, unwound_at);
> +		if (0) {
> +unwound_at:
> +			/*
> +			 * The callback left with unwind_exit. The sample is
> +			 * consumed and counted like after a return, so that
> +			 * the wakeup below is sent for it, and the helper
> +			 * leaves through the door below, as the error paths
> +			 * do, with the r0 of the callback.
> +			 */
> +			unwound =3D true;
> +		}
>  		__bpf_user_ringbuf_sample_release(rb, size, flags);
> +		if (unwound) {
> +			samples++;
> +			goto schedule_work_return;
> +		}
>  	}
>  	ret =3D samples - discarded_samples;
> =20
> @@ -867,6 +884,8 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, =
map,
>  		irq_work_queue(&rb->work);
>  	else if (!(flags & BPF_RB_NO_WAKEUP) && samples > 0)
>  		irq_work_queue(&rb->work);
> +	if (unwound)
> +		bpf_unwind_leave();
>  	return ret;
>  }
> =20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3c39cc0f358a1..fd63ff36eb909 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11409,6 +11409,7 @@ static bool helper_has_cb_pad(enum bpf_func_id fu=
nc_id)
>  	case BPF_FUNC_loop:
>  	case BPF_FUNC_for_each_map_elem:
>  	case BPF_FUNC_find_vma:
> +	case BPF_FUNC_user_ringbuf_drain:
>  		return true;

[Severity: Critical]
Can a callback for bpf_user_ringbuf_drain() smuggle its R1 dynptr (or a
slice derived from it via bpf_dynptr_data() or bpf_dynptr_slice()) out to
the caller's unwind pad in R0 when exiting via unwind_exit?

In bpf_user_ringbuf_drain(), struct bpf_dynptr_kern dynptr lives on the
C stack frame of bpf_user_ringbuf_drain(). When the callback exits via
unwind_exit and jumps to unwound_at, bpf_user_ringbuf_drain() releases the
sample with __bpf_user_ringbuf_sample_release(), clears rb->busy, and
returns ret (the callback's R0) to the caller's unwind pad after its stack
frame is popped.

In the verifier, set_user_ringbuf_callback_state() initializes the
callback's R1 using mark_dynptr_cb_reg(), which sets R1 to
CONST_PTR_TO_DYNPTR with a fresh id that is not backed by a STACK_DYNPTR
slot in the callee's BPF stack:

kernel/bpf/verifier.c:set_user_ringbuf_callback_state() {
	...
	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
	mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
	callee->regs[BPF_REG_2] =3D caller->regs[BPF_REG_3];
	...
}

When the callback executes unwind_exit, prepare_func_exit() only rejects
PTR_TO_STACK in R0, copies callee->regs[BPF_REG_0] into
caller->regs[BPF_REG_0], and calls destroy_dynptrs_in_stack_slots(), which
only invalidates STACK_DYNPTR slots in the callee's stack frame:

kernel/bpf/verifier.c:prepare_func_exit() {
	...
			caller->regs[regno] =3D callee->regs[regno];
			bpf_diag_mod_end(env);
		}
	}

	/* Invalidate callee-local dynptrs and their slices before the frame goes =
away. */
	err =3D destroy_dynptrs_in_stack_slots(env, callee, 0,
					     callee->allocated_stack / BPF_REG_SIZE - 1);
	...
}

On the revisit of BPF_FUNC_user_ringbuf_drain in check_helper_call(),
unwound_r0 is preserved across caller-saved register scrubbing without
invalidating the callback's dynptr id:

kernel/bpf/verifier.c:check_helper_call() {
	...
	if (env->cur_state->unwound) {
		regs[BPF_REG_0] =3D unwound_r0;
		goto unwound;
	}
	...
}

Wouldn't this leave the caller's unwind pad with a live CONST_PTR_TO_DYNPTR
pointing to the popped C stack frame of bpf_user_ringbuf_drain(), or a live
PTR_TO_MEM slice pointing to the already-released user ringbuf sample?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793147364.gi=
t.memxor@gmail.com?part=3D8
