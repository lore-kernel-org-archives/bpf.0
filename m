Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2151992A
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062215; cv=none; b=lQ8V+usL6DHtf959FlEBpJM0cMDSY046UnwYG5MFY2sgfyMoJRwPxeSzxVdclekOLj8ClieZH8yoLkSWYBWmMrnUNI4zQqVuwy+pQIyICeDa2NAmg1hc9c/hwZPcfvAjU6TkineInjnJ1eLMWShyTYHFx7QMZ/fk4oKdZP2C1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062215; c=relaxed/simple;
	bh=L08RHjwsckR4rNpxMZ++iv7oye/Myx4+xmyeG5zRb+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=himaOJPdubaECZ80+10oXlc2LKroyjf73qeZkNk4j+4YGzumr6l64z0SycfyQyCxRRdTx/Qj3SLye13h5XfSbGtqIR+FbhHvkSgXBG8xzaVt9LixolRSVbPDGVuV56mbonWACmTO92nkx0xEWn+tmD3heD5JmNqDF5bErPR16tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpncQQOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpncQQOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013F91F000FF;
	Tue, 22 Sep 2026 07:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790062212;
	bh=lw2ZmczPsgjupmgqKUNedcWIGTiZNKei9XHdwOpUGlk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LpncQQOVXdFzYo07wX7ZSsdpjcCTfKqKpVoZzhnA2UQWcvCLTSSFhcb8PPEnBNvSf
	 v2gbkzmHyZAUY5ANt/z7+DDw+In3YP9nYgyBrG8FxLWCb/maXabzS4/vZ6xUxqEvBF
	 xBz4cAm4RIYaEbKEVNVX8gMB0Bkzq20qIxyr+KCgbFJ+QrnKggsT3PAI95MfT0yG3M
	 5T8OLDPcM2aDqfIwBdeKZfUNWgxxYs3ACarQLb8IITnPS92UQs3VzLCQTMA6BBRO2b
	 StQA8X/uMbG6MXFpMytg8VR1/5RWDLt1Mma70ICZ9jmZDJXtBcnVr8M6ZiW5TrfEGI
	 Clv6nEbHRLNAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] kallsyms: Add test_kallsyms_perf module to
 benchmark lookup latency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-ksyms-tune-v2-1-a333ee31eac7@gmail.com>
References: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
 <20260922-ksyms-tune-v2-1-a333ee31eac7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 07:30:11 +0000
Message-Id: <20260922073012.013F91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] kallsyms: re-exporting iterators breaks security encapsulation
- [High] kallsyms: missing preemption in tight loops causes soft lockups
- [High] kallsyms: divide by zero in latency calculation via module paramet=
er
- [High] kallsyms: direct 64-bit division breaks 32-bit builds
- [Medium] kallsyms: test module spuriously fails on kernels without IPv4
- [Low] kconfig: test module set to 'default m' pollutes builds
--

commit 6589e2eb779ca1b70f6d786ad47e1be731aba20e
Author: Jim Cromie <jim.cromie@gmail.com>
kallsyms: Add test_kallsyms_perf module to benchmark lookup latency

This commit adds a lightweight microbenchmark module in lib/ to evaluate
optimizations and measure performance regressions across kallsyms lookups.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index aec2f06858afd..b9e573e9a10b9 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -261,6 +261,7 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const c=
har *, unsigned long),
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(kallsyms_on_each_symbol);

[Severity: High]
Does exporting this function directly reverse the security protection
introduced by commit 0bd476e6c6719 ("kallsyms: unexport
kallsyms_lookup_name() and kallsyms_on_each_symbol()")?

It appears this allows any GPL-compatible out-of-tree module to bypass
symbol exports and resolve unexported symbols by passing a custom match
function.

>  int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
>  				  const char *name, void *data)
> @@ -279,6 +280,7 @@ int kallsyms_on_each_match_symbol(int (*fn)(void *, u=
nsigned long),
> =20
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(kallsyms_on_each_match_symbol);

[Severity: High]
Can this export similarly be abused by loadable modules to circumvent the
EXPORT_SYMBOL mechanism and resolve unexported symbols natively?

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 134b15a44625e..2a8b1aaee23b3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3122,6 +3122,16 @@ config TEST_STATIC_KEYS
> =20
>  	  If unsure, say N.
> =20
> +config TEST_KALLSYMS_PERF
> +	tristate "kallsyms performance benchmark test module"
> +	default m

[Severity: Low]
Is it intended to have this test module enabled by default? Setting this
to default m pollutes default configurations and slows down compilation.

[ ... ]

> diff --git a/lib/test_kallsyms_perf.c b/lib/test_kallsyms_perf.c
> new file mode 100644
> index 0000000000000..c649e55dae3b8
> --- /dev/null
> +++ b/lib/test_kallsyms_perf.c
> @@ -0,0 +1,228 @@

[ ... ]

> +static unsigned int num_iters =3D 100000;
> +module_param(num_iters, uint, 0644);
> +MODULE_PARM_DESC(num_iters, "Number of iterations per microbenchmark");

[Severity: High]
What happens if num_iters is set to 0 via sysfs?=20

Since this parameter is globally writable and unchecked, could a user
write 0 and instantly trigger a hardware divide-by-zero exception during
the latency calculations below?

> +static const char * const hit_symbols[] =3D {
> +	"_printk",
> +	"schedule",
> +	"vfs_read",
> +	"do_sys_openat2",
> +	"kernel_clone",
> +	"tcp_v4_rcv",

[Severity: Medium]
Is it guaranteed that tcp_v4_rcv will be present on all kernel=20
configurations?=20

If the kernel is built without IPv4 support (CONFIG_INET), won't this valid
symbol be missing, causing the correctness validation in
run_name_lookup_bench() to emit a false failure?

[ ... ]

> +static void run_name_lookup_bench(void)
> +{
> +	u64 t0, t1, dt_hit, dt_miss;

[ ... ]

> +	/* 2. Name search: Non-existent symbols (Misses - 17 bsearch probes) */
> +	t0 =3D ktime_get_ns();
> +	for (i =3D 0; i < num_iters; i++) {
> +		const char *sym =3D miss_symbols[i % nr_misses];
> +
> +		kallsyms_on_each_match_symbol(match_cb, sym, &addr);
> +		OPTIMIZER_HIDE_VAR(addr);
> +	}

[Severity: High]
Could large values of num_iters in this tight loop stall the CPU and=20
trigger soft lockups on CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY
kernels, since cond_resched() is not invoked?

> +	t1 =3D ktime_get_ns();
> +	dt_miss =3D t1 - t0;
> +
> +	pr_info("Name Search Hit:  %llu ns/lookup (%llu ms total, %u iters)\n",
> +		dt_hit / num_iters, dt_hit / 1000000, num_iters);

[Severity: High]
Does this direct 64-bit division of dt_hit (a u64) by num_iters break=20
32-bit builds?=20

This typically causes link-time failures due to an undefined reference to
__udivdi3 on 32-bit architectures. Even with a transition to div_u64() in
later commits, the divisor would still need to be checked against zero.

[ ... ]

> +static void run_address_lookup_bench(void)
> +{
> +	u64 t0, t1, dt_sprint, dt_bldid;

[ ... ]

> +	/* 1. Address-to-name resolution (sprint_symbol) */
> +	t0 =3D ktime_get_ns();
> +	for (i =3D 0; i < num_iters; i++) {
> +		unsigned long addr =3D addrs[i % nr_addrs];
> +
> +		sprint_symbol(symname, addr);
> +		barrier_data(symname);
> +	}

[Severity: High]
Similar to the name search loop, could this tight loop executing millions=20
of operations without yielding the CPU trigger soft lockup panics?

[ ... ]

> +	pr_info("sprint_symbol:           %llu ns/lookup (%llu ms total, %u ite=
rs)\n",
> +		dt_sprint / num_iters, dt_sprint / 1000000, num_iters);

[Severity: High]
Could this also trigger a divide-by-zero hardware exception if num_iters
is set to 0?

[ ... ]

> +static void run_table_walk_bench(void)
> +{
> +	u64 t0, t1, dt_walk;
> +	unsigned long total_symbols =3D 0;
> +	int iter =3D 50;
> +	int i;
> +
> +	t0 =3D ktime_get_ns();
> +	for (i =3D 0; i < iter; i++) {
> +		total_symbols =3D 0;
> +		kallsyms_on_each_symbol(count_cb, &total_symbols);
> +	}
> +	t1 =3D ktime_get_ns();
> +	dt_walk =3D t1 - t0;
> +
> +	pr_info("Table Full Walk:  %llu us/pass (%lu symbols scanned, %d passes=
)\n",
> +		(dt_walk / iter) / 1000, total_symbols, iter);
> +}

[Severity: High]
Does the 64-bit division here (dt_walk / iter) also break 32-bit builds
with an undefined reference to __udivdi3?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-ksyms-tune=
-v2-0-a333ee31eac7@gmail.com?part=3D1
