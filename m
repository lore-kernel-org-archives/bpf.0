Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319468;
	b=AAmJltJik0E0wmHIu8e4T6dI0tDSctv3id2gfqFGmiyQYT0vmeHzs8i4xKckmGaXhpU7
	 ccchFwGS0ljOUSl4mr/0XqUovBgmMgWsjGnXDVzKveZq2Q5XYRdo669wUu0wrzFABhLrl
	 vz72lNMzik1L/dWxCGQeHft1QiouXljrOM+wRuF1gqTEeMlCAI5Qih/XP4RzjTI/+XgVS
	 CF/EKCFxz7oB+Xum1EmJdkWoXCwAoQGdgXAHLAv8Z425t+jjEIHRXwoNhdTFHkR7Q5YYx
	 nhpdN4fqUAcElfMsmsr6KxQihobQrqEs4QGzQyHppo70yQuEOi0dxYlydXAWVv2R6Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319468;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V8t9jhz351xKTmcFjayYlilTTZur1zaK0N2Io8W5JAU=;
	b=DWyCIWg648jwJwY/We78L1uXtuWhiYdvQfDGhmc9Qu4wxtI7qZ2gTiGWTkuOd/XAXQ1l
	 Kmr1yoUJ3dFQA3QVS61HYlc7G3v/77yTmQ8v1rcdrOADUvs2jw91AqF3fMd5N0eBlOhVL
	 RAAZi1pTAnxiAHRdm+X0RPPhSHQWEEdUHBQXX65UoNFVIlRDNRTECT4vZe7GqM0+gTJ2J
	 o9Y/RJr/f9yg7hAT7twB8ipB7Tcq40qSlSd24tmqiQdc7okLHZm0E+MbIt7Iire+xqQ7M
	 qZHLHGP9vdHGytRQiu/9SQxWjUEPdOphrGS2DCsgR+GlHWHFCQJie4PkWHVuA5fO1NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcygYArj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D20606A337;
	Tue, 10 Nov 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcygYArj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744101F008A2;
	Tue, 10 Nov 2026 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319468;
	bh=V8t9jhz351xKTmcFjayYlilTTZur1zaK0N2Io8W5JAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GcygYArjMFSf9OwD4DQqSfVyl0miUi14dmAXnlY3hFvsdilSH0K9PQRaVK7BMzVz8
	 uTHUahEsTwt4VfYX1GOGDIQbKfmDVXSs/HqjSiY9bbI5rgH/5dMSIBxP+1iOry2a2N
	 zJBf9JJuAHYqgAuSVW7V7HT5nBExY+M1pm5Ena2Vda93iuigsOTpLc+t1PvK+lj3Na
	 LGcotnCEzUpWMfMYOMq1apG6Q9yDvPdkvZGAU273whKy4rmHPyaG/2dRVcooh3G0c4
	 wroQA5VrUqp/ZRyu/bsaIlHLm1/TmTFqGZFtS/jXYp1z0Jc0LTRRuFkojXFluWb9XG
	 zMP+2vjo9mL5Q==
Message-ID: <sashiko-outbox-207174@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] riscv: hwprobe: report whether AMO is faster
 than LR/SC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110-lrsc-only-v6-6-bafc3cc0fcae@mobileye.com>
References: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
 <20261110-lrsc-only-v6-6-bafc3cc0fcae@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 14:04:25 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] riscv: hwprobe: stale vDSO cache for AMO_PERF in
  check_amo_speed_all_cpus()
- [Low] riscv: hwprobe: set_amo_speed_param() returns -EINVAL in
  __setup() handler
- [Low] riscv: hwprobe: amo_speed=3D override skips Zaamo check in
  check_amo_speed_all_cpus()
--

commit cbf5a1a3f9510f96205199ac1c58f59ae0d5cfb9
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

riscv: hwprobe: report whether AMO is faster than LR/SC

This commit measures the relative speed of uncontended AMO instructions
versus LR/SC loops on each CPU at boot and exposes the result to userspace
via the RISCV_HWPROBE_KEY_AMO_PERF hwprobe key.

> diff --git a/arch/riscv/kernel/amo_speed.c b/arch/riscv/kernel/amo_speed.c
> new file mode 100644
> index 0000000000000..933891b69db62
> --- /dev/null
> +++ b/arch/riscv/kernel/amo_speed.c

[ ... ]

> +static int amo_speed_online_cpu(unsigned int cpu)
> +{
> +	if (per_cpu(amo_speed, cpu) !=3D RISCV_HWPROBE_AMO_UNKNOWN)
> +		return 0;
> +
> +	if (amo_speed_param !=3D RISCV_HWPROBE_AMO_UNKNOWN)
> +		per_cpu(amo_speed, cpu) =3D amo_speed_param;
> +	else
> +		check_amo_speed(NULL);
> +
> +	return 0;
> +}
> +
> +static int __init set_amo_speed_param(char *str)
> +{
> +	if (!strcmp(str, "slow"))
> +		amo_speed_param =3D RISCV_HWPROBE_AMO_SLOW;
> +	else if (!strcmp(str, "fast"))
> +		amo_speed_param =3D RISCV_HWPROBE_AMO_FAST;
> +	else
> +		return -EINVAL;
> +
> +	return 1;
> +}
> +__setup("amo_speed=3D", set_amo_speed_param);

[Severity: Low]
Does returning -EINVAL from a __setup() callback cause invalid amo_speed=3D
values to be treated as handled?  obsolete_checksetup() treats any
non-zero return value from setup_func() as success, so an unrecognized
argument is silently accepted instead of being reported as an unknown
boot option.  __setup() handlers return 0 on failure.

> +static int __init check_amo_speed_all_cpus(void)
> +{
> +	int cpu;
> +
> +	if (amo_speed_param !=3D RISCV_HWPROBE_AMO_UNKNOWN) {
> +		pr_info("AMO speed set to '%s' (%lu) by command line\n",
> +			amo_speed_param =3D=3D RISCV_HWPROBE_AMO_FAST ? "fast" : "slow",
> +			amo_speed_param);
> +		for_each_online_cpu(cpu)
> +			per_cpu(amo_speed, cpu) =3D amo_speed_param;

[Severity: Low]
Does the amo_speed=3D command-line override bypass the Zaamo extension check
in check_amo_speed_all_cpus() and amo_speed_online_cpu()?  If amo_speed=3D
is passed on a CPU without RISCV_ISA_EXT_ZAAMO, per_cpu(amo_speed, cpu) is
set to RISCV_HWPROBE_AMO_FAST or RISCV_HWPROBE_AMO_SLOW instead of
RISCV_HWPROBE_AMO_UNSUPPORTED, reporting to userspace that AMO
instructions are usable on hardware where they trap as illegal
instructions.

> +	} else {
> +		on_each_cpu(check_amo_speed, NULL, 1);
> +	}
> +
> +	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:amo_speed",
> +				  amo_speed_online_cpu, NULL);
> +
> +	return 0;
> +}
> +
> +/*
> + * Same level as the unaligned access probe: after clocksource_done_boot=
ing()
> + * so that amo_speed_measure() uses a stable clocksource, but before
> + * rootfs_initcall() enables usermode helpers that can reach hwprobe.
> + */
> +fs_initcall_sync(check_amo_speed_all_cpus);

[Severity: High]
Does running check_amo_speed_all_cpus() at fs_initcall_sync leave the vDSO
hwprobe table with a stale RISCV_HWPROBE_AMO_UNKNOWN value for
RISCV_HWPROBE_KEY_AMO_PERF?

init_hwprobe_vdso_data() populates avd->all_cpu_hwprobe_values[] earlier
at arch_initcall_sync:

arch/riscv/kernel/sys_hwprobe.c:init_hwprobe_vdso_data() {
    ...
	for (key =3D 0; key <=3D RISCV_HWPROBE_MAX_KEY; key++) {
		pair.key =3D key;
		hwprobe_one_pair(&pair, cpu_online_mask);

		WARN_ON_ONCE(pair.key < 0);

		avd->all_cpu_hwprobe_values[key] =3D pair.value;
    ...
}

Because per_cpu(amo_speed, cpu) is still RISCV_HWPROBE_AMO_UNKNOWN when
init_hwprobe_vdso_data() runs, and check_amo_speed_all_cpus() does not
update vdso_k_arch_data->all_cpu_hwprobe_values[RISCV_HWPROBE_KEY_AMO_PERF]
after probing, userspace queries routed through __vdso_riscv_hwprobe()
always receive RISCV_HWPROBE_AMO_UNKNOWN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-lrsc-only-=
v6-0-bafc3cc0fcae@mobileye.com?part=3D6
