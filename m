Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17042E888A
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086024; cv=none; b=sW7qZFohouPZpDdjcC5ElPiClbafMcTg+T0P606FdU39VSv1sxajkNldKZO3BORT8YBty0blLr3vftFWq4AgRXn3se0pKQtXFB7t15elaFIjx7NaAcYUX/tyzF5BpT+9nLe5/UZFv4MrRkDpk7OYYKj8azllGsNSAfHb4GDIEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086024; c=relaxed/simple;
	bh=Z+Mvw2sOAEZQ38B8htRdPuDm7SBTFhxqUrUlrDaU3U0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gipjp6JsBOSEE0uxANJ92mG1yRnLOOGWAUpH/r8ghuwSko1697PugqO8WiaB4HN9PC9+0oJCip254ckfh5bF+sK0azOEXAm5446UAA3BcVN92/1Y76CNKdc8SACfkIKdRMaTdRua7EPoSyOTdJQfxQczP0HRq99ndOQs+gDwrfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DymCpAS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DymCpAS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6911F000E9;
	Tue, 18 Aug 2026 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787086023;
	bh=eFJKnWRZ+7JUD1sq5JNUNJlALC7dakErcRQKotRQI+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DymCpAS9WN1rpSB6hqtjnePDPJn2/dDsD8KC/NXljGlUoFrCF8GRpdbpt6Zdnkk7o
	 JwAnxgvSaQYExQ5a51Bhz6HlDzI7cDeUWJQVk6+ReSJ4WPy6pyiUZd1pNTfcfJMzzp
	 B+VRp0R3/Ls5iui461kRhiFARuLvIdaDmRQNDB9H3V4QTGga+GK+D/Dtaz8piq8E6o
	 cgiG4V7nmveZV4F+wfqFI+jcx8ffO7WQjObsdBKsNVQwtslzICPkiHywUu7Nqz7lOs
	 0QAepY0Itbd/Ylho5zGVc1v4lytJwzVF2y9LSych2aVHb6b1c093EOqhaf6/874bif
	 Kg+B4xcbqJExQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: guard uprobes against private-stack
 corruption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Simon" <simon@swine.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260818203234.1142913-1-simon@swine.de>
References: <20260818203234.1142913-1-simon@swine.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 20:47:02 +0000
Message-Id: <20260818204703.2F6911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for private stack corruption: BPF programs attached=
 to both uprobes and kprobes/tracepoints bypass recursion protection.
--

--- Patch [1]: [PATCH bpf v2] bpf: guard uprobes against private-stack corr=
uption ---
commit 91e05311e6d3a25ea1742394d64f625138f2c862
Author: Christian Simon <simon@swine.de>

bpf: guard uprobes against private-stack corruption

Eligible BPF programs use one private stack per program and CPU. This
commit adds per-program recursion protection to the uprobe execution
paths to prevent a second invocation from overwriting the first invocation's
private stack.

Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrumentatio=
n/issues/3056

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f65284456..a94fc9898ecef 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> @@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_a=
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

[Severity: High]
This is a pre-existing issue, but does this leave the private stack vulnera=
ble
to corruption if a program is attached to both an uprobe and a kprobe?

The uprobe path increments the per-program recursion counter here via
bpf_prog_get_recursion_context(), but it does not increment the global
bpf_prog_active counter.

If an interrupt triggers a kprobe while the uprobe is executing on the same
CPU, the kprobe dispatcher only checks the global counter:

kernel/trace/bpf_trace.c:trace_call_bpf() {
    if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1)) {
        ...
        ret =3D bpf_prog_run_array(..., bpf_prog_run);
    ...
}

Because the uprobe didn't increment the global bpf_prog_active counter,
trace_call_bpf() will proceed and execute the same BPF program again,
bypassing the per-program recursion protection and potentially overwriting
the first invocation's stack frames.

Does kprobe_multi_link_prog_run() also have this same vulnerability since
it relies solely on bpf_prog_active before executing bpf_prog_run()?

> +			bpf_prog_inc_misses_counter(prog);
> +			bpf_prog_put_recursion_context(prog);
> +			item++;
> +			continue;
> +		}
> +
>  		if (!prog->sleepable)
>  			rcu_read_lock();
> =20
>  		run_ctx.bpf_cookie =3D item->bpf_cookie;
>  		ret &=3D run_prog(prog, ctx);
> -		item++;
> =20
>  		if (!prog->sleepable)
>  			rcu_read_unlock();
> +
> +		bpf_prog_put_recursion_context(prog);
> +		item++;
>  	}
>  	bpf_reset_run_ctx(old_run_ctx);
>  	migrate_enable();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818203234.1142=
913-1-simon@swine.de?part=3D1
