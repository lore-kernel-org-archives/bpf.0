Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581F44C65D
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057820; cv=none; b=gXH2x5B8nEAUEY2woLI08Xb3xYj1pqkv3WAXZidIDMjV2fGDVVs+5U7vZN4W976gqATSQj19p2Kcue52pIODXVllijBP520m1OfWLVzJGYimdFn1eJZ0zVmnEIp/pponvzK66eWlE54KuUDHLb3600XEDCfvM897um8vGJKwDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057820; c=relaxed/simple;
	bh=OQjnS5nuIuvGFamZCQm/DXGHls9iVx0JOAiMdbCIXpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMEVdcaMnr+N4e34rbuQOkTKPPzRezji2bvNRIZy9x2fvwNmYSPAge3ez5LlIbwoQ6/74eUgtJw+LdEoq0xtqZTZMJDDWbtOCn+kR3Y8SxEGDwwitFemc9i5iJ5iPEmr9wmHal6e9vwx6zPRQhqZQB/ddDvL4Ul6L8DqH+N5+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU4vsAdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU4vsAdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867CF1F00A3D;
	Tue, 14 Jul 2026 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784057818;
	bh=W7/OXooO/RJ+NnAf6uMC3748khsH3n41j0RE7TcURNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RU4vsAdM63g0pjS/NXXGnBbqvaHvIxvmObU6VZ077swOGIdkwB2hUMsnyysk1MXe+
	 1ZPgJVXm9LhRjbUOVVhjJ9T7XhI4Acq6kDziQU/z7Xr2iMQDurY63fwYJg1VchV5ZY
	 eMMQVFcQBYlPOnxsDYVazt2S6xyIfXrlD27aZ+gwg6p93S/uVso6S2ZOdTlDNyQ1Xq
	 CqvvyI0mM0IiWkKlr1ChiW6xqJ6y79LxhcZukEXTLOVl4BEYQXgXK/HvV/hmP1uY0f
	 iAaO4Dc3moQHPgGabjc4PswPebvql0RcH4M2Ko6qsnvL50kxEfFCjRFenO0g6xDWtm
	 Yk1jUM9T/b+qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.16.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-2-2fc3e16263ac@linux.intel.com>
References: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
 <20260714-cbpf-jit-spray-hardening-6-16-y-v1-2-2fc3e16263ac@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:36:58 +0000
Message-Id: <20260714193658.867CF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The IBPB flush for BPF JIT memory reuse is bypassed for allocation=
s larger than `BPF_PROG_PACK_SIZE`, allowing unprivileged-to-privileged BTB=
 poisoning (JIT spraying) when memory is reused.
- [High] System-wide IPI storm allowing Denial of Service via frequent BPF =
program loads.
--

--- Patch [2]: [PATCH 6.16.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT al=
location ---
commit 952665895a964d3f1620c223a7c5e6f20ea4be8a
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

x86/bugs: Enable IBPB flush on BPF JIT allocation

Enable hardening against JIT spraying when Spectre-v2 mitigations are in
use. Specifically, issue an IBPB flush on BPF JIT memory reuse. Skip
enabling the IBPB flush if the BPF dispatcher is already using a retpoline
sequence.

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 65e253ef52184..512d58d6040c7 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2234,6 +2247,27 @@ static void __init spectre_v2_update_mitigation(vo=
id)
>  		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
>  }
> =20
> +#ifdef CONFIG_BPF_JIT
> +static void __bpf_arch_ibpb(void *unused)
> +{
> +	write_ibpb();
> +}
> +
> +void bpf_arch_ibpb(void)
> +{
> +	on_each_cpu(__bpf_arch_ibpb, NULL, 1);
> +}

[Severity: High]
Could this implementation cause a system-wide IPI storm allowing a denial of
service via frequent BPF program loads?

When bpf_prog_pack_alloc() in kernel/bpf/core.c allocates a chunk, it
synchronously calls bpf_arch_pred_flush() which maps here. This issues
on_each_cpu(), sending inter-processor interrupts to all online CPU cores a=
nd
blocking until they complete write_ibpb().

Because an unprivileged user can loop creating cBPF programs via
setsockopt(..., SO_ATTACH_FILTER, ...) and this allocation has no rate
limiting, won't this trivially cause an IPI storm?

> +
> +static bool __init cpu_wants_ibpb_bpf(void)
> +{
> +	/* A genuine retpoline already neutralizes ring0 indirect predictions */
> +	if (retpoline_seq_enabled())
> +		return false;
> +
> +	return boot_cpu_has(X86_FEATURE_IBPB);
> +}
> +#endif

[ ... ]

> @@ -2310,6 +2344,14 @@ static void __init spectre_v2_apply_mitigation(voi=
d)
>  		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
>  		pr_info("Enabling Restricted Speculation for firmware calls\n");
>  	}
> +
> +#ifdef CONFIG_BPF_JIT
> +	if (cpu_wants_ibpb_bpf()) {
> +		static_call_update(bpf_arch_pred_flush, bpf_arch_ibpb);
> +		static_branch_enable(&bpf_pred_flush_enabled);

[Severity: High]
Does this allow a bypass of the JIT spraying mitigation for allocations
larger than BPF_PROG_PACK_SIZE?

In kernel/bpf/core.c, bpf_prog_pack_alloc() bypasses the predictor flush
for large allocations:

	if (size > BPF_PROG_PACK_SIZE) {
		/* ... */
		if (static_branch_unlikely(&bpf_pred_flush_enabled))
			pr_warn_once("...");
		size =3D round_up(size, PAGE_SIZE);
		ptr =3D bpf_jit_alloc_exec(size);
		goto out;
	}

Could an unprivileged attacker load many small cBPF programs to fill a
BPF_PROG_PACK_SIZE block, poison the branch predictor, and then unload them
to return the block to the execmem allocator?

If a privileged user then loads a large BPF program, couldn't the victim's
program be loaded into this exact poisoned address space without a flush,
allowing the attacker to hijack control flow?

> +		pr_info("Enabling IBPB for BPF\n");
> +	}
> +#endif
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-cbpf-jit-s=
pray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com?part=3D2
