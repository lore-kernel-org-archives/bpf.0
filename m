Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002141B8FB;
	Mon, 20 Jul 2026 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552171; cv=none; b=G67+/b3Y6nKUCZW4K31A5bF+VWA6l8UkB0N0p4R4CndhOBFgwKOQ3ZCZ+R4zgQMiSvNXHdOLY9dpduWlvPxvY3T+G9ggzsms0HimiE28MlAy0kTdQB9zJdN+Yb5Nq22Z+b59HZLCKhYjcrQ0/KcRbt7FUAt58RxF4kamhn96mUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552171; c=relaxed/simple;
	bh=NLCD4MyHNwLEeRIEmoTn0hyPF48QDNzMnfwGiPP783o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XE6W6ZbwKE+HvB0155JN2wjvPd74OChJG3xkvvE66LOokTKDs0UghHEkqzRMEtA+sUjNO8YJhUvLJMTZja4Bx/MRGtlb5W6uyTdX96YSpUSXMRTObkbBsJBKm1DwKHGos2Pp1tszsCMouMvuZtYgSOhxbfxCVL1f8QBP6zfd/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocl+VZAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocl+VZAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030E31F000E9;
	Mon, 20 Jul 2026 12:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784552170;
	bh=nPuEan/ndgKEJU8EyTzHJC706e1R6jLrfdYM1L8UXeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ocl+VZAVZn6JGJsNoubD59ioGpmLioPI/E2WONMNEda7xDhbaQDWxaR67Kg5o3E9t
	 g5U7iq8mX82sfJ9DacF+IelPsgO6fONAGv/3952NZ0y9YQRkk4VMRyiCY1zVGahe+y
	 c8R8IjZONY+FcOHYj7Wsh5B7oeplR/2ZGiOT/ivOt9r6BCi8tnY8YrZehwFJ9NF7Nn
	 bH5zaOo/S6wLRi9ySIXuBFmlwpOt3BqTKIoAvy5TTKywUiCgcuIG83+B17X0QQKUMR
	 Ui84lMTCzN8RXQ0+12XqNdm+1YRK2RPs4ZOmYTh5lZ+DU/tI30ZwM7N42ses5RTIdd
	 2vUkusHw239EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next v4 1/8] mm/slab, slub_kunit: register
 kprobe to trigger _nolock APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260720-kfree_rcu_nolock-v4-1-964e03c41a4e@kernel.org>
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-1-964e03c41a4e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:56:08 +0000
Message-Id: <20260720125609.030E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The globally registered kprobe pre-handler executes system-wide on=
 all CPUs, causing non-test tasks to inadvertently execute KUnit test logic=
 and concurrently mutate the test thread's stack-allocated context.
- [Medium] The refactoring to `kmalloc_obj(*objects[j], gfp)` incorrectly e=
valuates the allocation size to 1 byte instead of the intended 64 bytes.
--

--- Patch [1]: [PATCH slab/for-next v4 1/8] mm/slab, slub_kunit: register k=
probe to trigger _nolock APIs ---
commit 632627083aa5c71fb7be8b45f24099b08c94d6a7
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab, slub_kunit: register kprobe to trigger _nolock APIs

This commit registers a kprobe pre-handler in slub_kunit to invoke and
test kmalloc_nolock() and kfree_nolock() from within the slab allocator.
It adds a wrapper for lockdep_assert_held() to attach the kprobe, and
refactors the test allocation loop into a shared helper function.

Link: https://lore.kernel.org/linux-mm/20260427-nolock-api-fix-v2-0-a6b83a9=
2d9a4@kernel.org [1]
Link: https://lore.kernel.org/linux-mm/6edebc2b-5f5a-4b9c-9a4c-564310acee1b=
@kernel.org  [2]

> diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
> index fa6d31dbca166..a391467c1aa6e 100644
> --- a/lib/tests/slub_kunit.c
> +++ b/lib/tests/slub_kunit.c

[ ... ]

> @@ -302,26 +303,40 @@ struct test_nolock_context {
>  	int callback_count;
>  	int alloc_ok;
>  	int alloc_fail;
> +#ifdef CONFIG_PERF_EVENTS
>  	struct perf_event *event;
> +#endif
> +#if defined(CONFIG_KPROBES) && defined(CONFIG_SMP)
> +	struct kprobe kprobe;
> +#endif
>  };
> =20
> -static struct perf_event_attr hw_attr =3D {
> -	.type =3D PERF_TYPE_HARDWARE,
> -	.config =3D PERF_COUNT_HW_CPU_CYCLES,
> -	.size =3D sizeof(struct perf_event_attr),
> -	.pinned =3D 1,
> -	.disabled =3D 1,
> -	.freq =3D 1,
> -	.sample_freq =3D 100000,
> -};
> +static void test_kmalloc_kfree(void)
> +{
> +	int i, j;
> +
> +	for (i =3D 0; i < NR_ITERATIONS; i++) {
> +		for (j =3D 0; j < NR_OBJECTS; j++) {
> +			gfp_t gfp =3D (i % 2) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
> =20
> -static void overflow_handler_test_kmalloc_kfree_nolock(struct perf_event=
 *event,
> -						       struct perf_sample_data *data,
> -						       struct pt_regs *regs)
> +			objects[j] =3D kmalloc_obj(*objects[j], gfp);

[Severity: Medium]
Does this refactoring unintentionally reduce the allocation size to 1 byte?

Since objects is declared as an array of void *, the dereferenced type
of *objects[j] is void. The kmalloc_obj() macro evaluates
sizeof(typeof(VAR_OR_TYPE)), which resolves to sizeof(void). Under GCC,
sizeof(void) evaluates to 1.

Does this silently reduce the test coverage by targeting kmalloc-8 instead
of the original 64-byte allocations targeted in the previous code?

> +			if (!objects[j]) {
> +				j--;
> +				while (j >=3D 0)
> +					kfree(objects[j--]);
> +				return;
> +			}
> +		}
> +

[ ... ]

> +#if defined(CONFIG_KPROBES) && defined(CONFIG_SMP)
> +static int slab_kprobe_pre_handler(struct kprobe *p, struct pt_regs *reg=
s)
> +{
> +	struct test_nolock_context *ctx;
> +
> +	ctx =3D container_of(p, struct test_nolock_context, kprobe);
> +	test_nolock(ctx);
> +	return 0;
> +}

[Severity: High]
Does this kprobe pre-handler execute for all CPUs system-wide?

Since this function is invoked via the kprobe attached to
slab_attach_kprobe_locked(), and there is no check ensuring
current =3D=3D test_task, it appears any non-test task executing SLUB
slowpaths (like add_partial or remove_full) will also trigger this
handler.

Could this allow unrelated tasks to inadvertently execute test_nolock()
from arbitrary contexts and concurrently mutate the test thread's
stack-allocated ctx, causing a data race on ctx->alloc_ok and
ctx->callback_count?

> +
> +static bool register_slab_kprobes(struct test_nolock_context *ctx)
> +{
> +	ctx->kprobe.symbol_name =3D "slab_attach_kprobe_locked";
> +	ctx->kprobe.pre_handler =3D slab_kprobe_pre_handler;
> +
> +	if (register_kprobe(&ctx->kprobe))
> +		return false;
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-kfree_rcu_=
nolock-v4-0-964e03c41a4e@kernel.org?part=3D1
