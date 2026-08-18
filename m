Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E53A6F09
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047773; cv=none; b=lEPPr0i4d6rDR7z4aqE25qB8bodWNwEi2A8OgAlUDVX1R4Ckno7DsDIjvyu40mrA2r33LuprcSc+U7YwEscSsvM3yxHbkcndTPmHBAhbjybEpJEZ36IR0a54eeHX5pvuMUMWaetMOBLfHaqRv3CuAcnDpuzyKaspxk0PKZX1l4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047773; c=relaxed/simple;
	bh=oUtS/TCIKFn5IBaGN4iPozeEGcywqoxmOsEXGslPwfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rL7z6RZXybjXVImZi7HQDQrU3guZAsxNOfuPWwbqrrheBy/HQzyZhf8qbsxhDHYEPK49tIfVrBBoCqK8fNxoe84wvPCWAnds/7ojdZ2fx3WwrIPB5PM9HUmlh/vHJGdGEvFs/en011LwA2+pwxA8cuJXqlTeu5O+8dd9ExVuPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEJvZJY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEJvZJY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062EC1F000E9;
	Tue, 18 Aug 2026 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787047769;
	bh=JlRhsI3dSE/l1DKEQhH/NQ3ob4asPJSZDrsA+LHbnG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FEJvZJY1V/279HjViRyNbOJ7zjvsEGPRFi5kdTcoSSYvzuUJcMwEKgolyQjxOdH5B
	 5kvphtV8O3adQq2SBkkF1h9X0fxC/ATVPkYNweOzge/KP6RsNGQDvNXK6QwnGdj2tI
	 vHopL/wMWGaiwaa6C+GJ+9+222m2rYFOYT2bcvYO/xuUzCBAq7o2Gg6pCMQp7X5Zpd
	 yUuAh30ilju2btPEQbSRgFpD3/tgcqeqeBsHmgSM2GyY5JU1jc738VgqD2KaobJ7Vk
	 1wCrs5m1arY8Fvz0nMnNkwFRA3AMkFC2MmJQ5IENOJ0jeLq5tGZzv3fLPi77kogEwE
	 s9/PxDz/HqAqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: guard classic uprobes against private-stack
 corruption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Simon" <simon@swine.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260818095545.314358-1-simon@swine.de>
References: <20260818095545.314358-1-simon@swine.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:09:28 +0000
Message-Id: <20260818100929.062EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch causes a `-Wdiscarded-qualifiers` compiler warning in `bp=
f_prog_run_array_uprobe` and mistakenly removes `const` from `bpf_prog_run_=
array`.

Pre-existing issues:
- [High] Missing recursion context protection in the uprobe-multi path lead=
s to per-CPU private stack corruption.
--

--- Patch [1]: [PATCH bpf] bpf: guard classic uprobes against private-stack=
 corruption ---
commit d583ad326b3c9bb2b3cfd745309987d581a65249
Author: Christian Simon <simon@swine.de>

bpf: guard classic uprobes against private-stack corruption

Eligible BPF programs use one private stack per program and CPU.
bpf_prog_run_array_uprobe() uses migrate_disable() to keep an
invocation on one CPU, but another task can still preempt it and run
the same program on that CPU. The second invocation then reuses and
can overwrite the first invocation's private stack.

> The analogous uprobe-multi path appears affected but is not addressed by
> this patch.

[Severity: High]
This is a pre-existing issue, but since the uprobe-multi path shares this
vulnerability, shouldn't it be addressed as well to prevent private-stack
corruption?

In kernel/trace/bpf_trace.c:uprobe_prog_run(), the BPF program is executed
without recursion context protection:

        err =3D bpf_prog_run(link->link.prog, regs);

If a task executing uprobe_prog_run() is preempted (or yields) and the
preempting task triggers the same program on the same CPU, the private stack
can be overwritten, breaking verifier safety guarantees. Could we add
bpf_prog_get_recursion_context() protection to uprobe_prog_run() too?

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ffa5626411ac2..1d263992213e1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
[ ... ]
>  static __always_inline u32
>  bpf_prog_run_array(const struct bpf_prog_array *array,
>  		   const void *ctx, bpf_prog_run_fn run_prog)
>  {
>  	const struct bpf_prog_array_item *item;
> -	const struct bpf_prog *prog;
> +	struct bpf_prog *prog;

[Severity: Low]
Was this const removal intended for bpf_prog_run_array_uprobe() instead?

Removing the const qualifier here doesn't seem necessary for
bpf_prog_run_array().

[ ... ]
> @@ -2640,15 +2648,30 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_a=
rray *array,
>  	old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>  	item =3D &array->items[0];
>  	while ((prog =3D READ_ONCE(item->prog))) {
> +		/* dummy_bpf_prog has no recursion state. */
> +		if (unlikely(!prog->len)) {
> +			item++;
> +			continue;
> +		}
> +
> +		if (unlikely(!bpf_prog_get_recursion_context(prog))) {

[Severity: Low]
Does passing prog to bpf_prog_get_recursion_context() here cause a
build regression with a -Wdiscarded-qualifiers compiler warning?

Since prog is declared as const struct bpf_prog *prog in
bpf_prog_run_array_uprobe(), and bpf_prog_get_recursion_context() expects a
non-const pointer, this discards the const qualifier.

Should the const removal above have been applied here in
bpf_prog_run_array_uprobe() instead?

> +			bpf_prog_inc_misses_counter(prog);
> +			bpf_prog_put_recursion_context(prog);
> +			item++;
> +			continue;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818095545.3143=
58-1-simon@swine.de?part=3D1
