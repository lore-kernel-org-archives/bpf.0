Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F563A9015
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103427; cv=none; b=bN57B1JXLOWMKVrq7a8gwK4z/4xFsQ4t5PAiK5zLcDO4HN+O3IkW5ABerEX50IiCEYJIuYb7v9NtrefCrBf40Vls4zePNTXWC9pkTBWjY7N6ArsyQw0QIvWi+MCY0GHo+STP9edQCbLD3xwi+Ro0HexSf4ONnBdulDEozERy+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103427; c=relaxed/simple;
	bh=QVonsYCWms0kor1g9R3eYSA23PN5sRPCLcHDjI6fsOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FZ39Z+iPG2H0Jnmmcg0jGkNlF6HW886SJ29HgBddmWgDyq+J0rz6W/gWNyfae1WbkycDy+GdqygkbQVYwnvSN+i/B6L5fkVXoLBa7Xg13IldM5D4ay8Yhq1bHbV4nLiQTbacxx2Gca809wFioaoXi8ZY8mznUFcBQ40ie9fPOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKeayGCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKeayGCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DDD1F000FF;
	Tue, 22 Sep 2026 18:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103425;
	bh=c8a3PnF1TQ/wmtJ9VNObPH91mMpa1d+jv/0QxiVpEe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKeayGCLhKt2KKUMFHGyWRBMoghltDW8/Nd4Qv01/FSd1uEgLxLJLQ4LlJsORjmbt
	 1shad93IewEQco4fBb7eEw4QC+TbWotDz8aMDx+GzA9i7PJt05QWtILRwdvTnSjrUe
	 lf7tzQazA5MFeskjl+cuPWAXQj4bKsI+yTf8awAip/ezUk5E9pu5PBfS2qgcHnra1U
	 PcMUZBMyTya4xjLsTS6OZTTkdDiZran44T7tB1c8ij+p5DCe9S2KbP4/F+BnYaxHB6
	 5Sj3dMwRS+Wn1+62xz+XTS9/p3XTmC8bhBGnEuqfoj8YkTCqe9p2yR3aL2aCE3oy22
	 o9tV+nt21jmvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] kallsyms: Add test_kallsyms_perf module to
 benchmark lookup latency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-ksyms-tune-v3-1-681a34ea05d9@gmail.com>
References: <20260922-ksyms-tune-v3-0-681a34ea05d9@gmail.com>
 <20260922-ksyms-tune-v3-1-681a34ea05d9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 18:57:05 +0000
Message-Id: <20260922185705.C4DDD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] kallsyms: NULL pointer dereference in early boot via run_test para=
meter
- [High] kallsyms: divide-by-zero kernel panic via sysfs num_iters TOCTOU
- [Medium] kallsyms: multi-second boot stall on every boot when config is e=
nabled
- [Low] kallsyms: benchmark latency skewed by cond_resched() preemption
--

commit 1f88a15d1a75733470768014a06f1b4c5dac957f
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: kallsyms: Add test_kallsyms_perf module to benchmark lookup latency

This commit adds a microbenchmark module for the kallsyms subsystem to
evaluate name-to-address, address-to-name, and full table walk performance.
It is configured as a built-in boolean test and includes a sysfs trigger
as well as an automatic run during late boot.

> diff --git a/lib/test_kallsyms_perf.c b/lib/test_kallsyms_perf.c
> index 0000000000000..4d0c39c0a94f7
> --- /dev/null
> +++ b/lib/test_kallsyms_perf.c
> @@ -0,0 +1,241 @@
[ ... ]
> +static void run_name_lookup_bench(void)
> +{
> +	u64 t0, t1, dt_hit, dt_miss;
> +	unsigned long addr =3D 0;
> +	unsigned int i, nr_hits, nr_misses;
[ ... ]
> +	/* 1. Name search: Existing symbols (Hits) */
> +	t0 =3D ktime_get_ns();
> +	for (i =3D 0; i < num_iters; i++) {
> +		const char *sym =3D hit_symbols[i % nr_hits];
> +
> +		if (unlikely(!(i & 0x3fff)))
> +			cond_resched();

[Severity: Low]
Because this is inside the ktime_get_ns() timing loop, if preemption occurs,
will the elapsed wall-clock time include the sleep time? Could this heavily
inflate the measured latency per iteration, especially since
kallsyms_on_each_match_symbol() already calls cond_resched() internally?

> +
> +		kallsyms_on_each_match_symbol(match_cb, sym, &addr);
> +		OPTIMIZER_HIDE_VAR(addr);
> +	}
> +	t1 =3D ktime_get_ns();
> +	dt_hit =3D t1 - t0;
[ ... ]
> +	pr_info("Name Search Hit:  %llu ns/lookup (%llu ms total, %u iters)\n",
> +		div_u64(dt_hit, num_iters), div_u64(dt_hit, 1000000), num_iters);

[Severity: High]
Since num_iters is exposed via sysfs with 0644 permissions, could a concurr=
ent
write change num_iters to 0 while this benchmark is running? Does this dyna=
mic
read of the global variable risk a divide-by-zero kernel panic here, despite
the initial check in run_kallsyms_benchmark()?

> +	pr_info("Name Search Miss: %llu ns/lookup (%llu ms total, %u iters)\n",
> +		div_u64(dt_miss, num_iters), div_u64(dt_miss, 1000000), num_iters);
> +}
[ ... ]
> +static int param_set_trigger(const char *val, const struct kernel_param =
*kp)
> +{
> +	return run_kallsyms_benchmark();
> +}
> +
> +static const struct kernel_param_ops param_ops_trigger =3D {
> +	.set =3D param_set_trigger,
> +};
> +module_param_cb(run_test, &param_ops_trigger, NULL, 0200);

[Severity: High]
If this module parameter is passed on the kernel command line during early
boot, parse_args() will invoke this callback before timekeeping_init() has
run. Will this cause a NULL pointer dereference when the benchmark
subsequently calls ktime_get_ns() and tries to read the uninitialized
tk_core timekeeper?

> +MODULE_PARM_DESC(run_test, "Write 1 to trigger kallsyms benchmark run");
> +
> +static int __init test_kallsyms_init(void)
> +{
> +	return run_kallsyms_benchmark();
> +}
> +late_initcall(test_kallsyms_init);

[Severity: Medium]
Because CONFIG_TEST_KALLSYMS_PERF is a built-in bool, this late_initcall
will execute the heavy benchmark unconditionally on every boot. Will this
introduce a multi-second boot stall for any kernel built with this config
enabled?

> +
> +MODULE_DESCRIPTION("Microbenchmark test module for kallsyms subsystem");
> +MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
> +MODULE_LICENSE("GPL");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-ksyms-tune=
-v3-0-681a34ea05d9@gmail.com?part=3D1
