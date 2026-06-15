Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED33E3179;
	Mon, 15 Jun 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522076; cv=none; b=DExxpW8hIRFBI3HrfF6YLNS7JlNLdfShN003Fw9erYfHmsqL4IPANpSelJlFcmZ9w4D+OY4yMWqtrTB75Nc/RwCU/FqfDIcQ3WbmLi5shGY7OBqF2LNs9ahxbyyQ937USTA0WNAcxZGuS/8Ojg/RpcUuUY6/CMWbwojm59a/1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522076; c=relaxed/simple;
	bh=nl7AO8XFVnrG7utorb37BNu2539wy0Vm+qu9RGtYhQc=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H4tkK3ZChTNll+oa7SYId36O8AzQxNSWlHQ9rJLMtOdAqcGvSlaeF/o1DLyJkQE9kU9Fhj6uBV8bY4tlhUS6TFoSf2YuXW90uJjYuH+bLdAsC3bZ2KSnGzqUHjbx2UL5gspnUgHGlDmP6vMusCmyjJjTjABZDmEVfH3UlwQwKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCkmoQhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCkmoQhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802AD1F00A3A;
	Mon, 15 Jun 2026 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522075;
	bh=ckPle9xHOTYL2Rr9xWtmB+mp35JEg6AUg5pDjAj3bkY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oCkmoQhrtA/HgKdSOzyvRlXHx3KXD8/RVlaEY4GBoPoxC+PcX7FQbcUtRiax3i+7m
	 5OCHGHb1fkE1xxHHt2hxO0ix2RdF0hfV+R97W3FBOpkHn1ZSmF7TAAAnO7O/bbjfD9
	 qsoHEqDOQHtrd+G4SNoYdWuFYQdAubswzALjx6a6AU0EJTdS7kCX22Qq/vg5Sl4Lf5
	 cVV5pIKs4ZNITesJHRIcwk6+xgZbuqZ9newJni/p+rs4mKA1NSq7LtxEaoB7JuI3m1
	 cBsJIogLL0jQSfHZmUtfpuK2fck7j6pXFnQTD+zKRRi/aCrVFYuqrVmmV/Ce55FCkG
	 EetFUXkgETmnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-next v3 1/9] slub_kunit: fall back to SW perf events
 when HW PMU is not available
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>
References: <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 11:14:34 +0000
Message-Id: <20260615111434.802AD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test cleanup function reads and logs test context variables =
before disabling the asynchronous perf event, introducing a data race and c=
ausing the reported counts to be inaccurate.
--

commit 4fccf2c0f65ae8a2788eab369ec35d223d9c897d
Author: Harry Yoo (Oracle) <harry@kernel.org>

slub_kunit: fall back to SW perf events when HW PMU is not available

This commit introduces a fallback mechanism in the slub_kunit tests to use
software perf events when a hardware PMU is unavailable. This ensures the
tests can still execute in virtualized environments that lack virtual PMUs.

> diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
> --- a/lib/tests/slub_kunit.c
> +++ b/lib/tests/slub_kunit.c
[ ... ]
> +static void disable_perf_events(struct test_nolock_context *ctx)
> +{
> +	kunit_info(ctx->test, "%s perf events: callback_count: %d, alloc_ok: %d=
, alloc_fail: %d\n",
> +		   ctx->is_perf_type_hw ? "HW" : "SW",
> +		   ctx->callback_count, ctx->alloc_ok, ctx->alloc_fail);
> +
> +	perf_event_disable(ctx->event);

[Severity: Medium]
Could reading the counters before disabling the perf event result in missed
counts?

Since the perf event continues to fire asynchronously in NMI or IRQ context
until perf_event_disable() is called, the variables might be incremented
after kunit_info() has already read them.=20

Would it be safer to disable the perf event before reading and logging the
results, restoring the original ordering from the previous cleanup block?

> +	perf_event_release_kernel(ctx->event);
> +}
[ ... ]
> @@ -368,11 +412,7 @@ static void test_kmalloc_kfree_nolock(struct kunit *=
test)
>  	}
> =20
>  cleanup:
> -	perf_event_disable(ctx.event);
> -	perf_event_release_kernel(ctx.event);
> -
> -	kunit_info(test, "callback_count: %d, alloc_ok: %d, alloc_fail: %d\n",
> -		   ctx.callback_count, ctx.alloc_ok, ctx.alloc_fail);
> +	disable_perf_events(&ctx);
> =20
>  	if (alloc_fail)
>  		kunit_skip(test, "Allocation failed");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-kfree_rcu_=
nolock-v3-0-70a54f3775bb@kernel.org?part=3D1
