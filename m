Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6F4499AA
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636637; cv=none; b=nAkOOYvqYcYdOm65+0keJqnFGjGvxXQeRhlTn2WFuGeC0pQ1xcPfmNPLlFc2qd3gXBo4e3EiBe6kinwcTcYwI8K0a1FZpQN3o85zH/RmPOV897BwCbMNbiaTRSDpfKPk7TwUeqsh0iBfaFaQu2EBEgoUqy0/BJVGPRqi0vBTQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636637; c=relaxed/simple;
	bh=9BlS/gYZ7Rb3oMBedhLPhtdsUAGc6JCR+ouH8uP7bRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p5rUvcAAzx0GvPrtdL9wP3GDizzU/FDJTL5j+yA1GxQjPP0p7ks6cIXhYFNvUH1LoS0mjd7I3IILbGZUhf1L+nQiy6Y4bIBsij7J+QxWQrTwXHTZsxtgZbjR+JbZqPmAxg/4fl2GRuzmzaHXZcgsP2taBVHSX1HuTDpJg6o2HaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxvvHt9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxvvHt9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C851F00A3E;
	Thu,  9 Jul 2026 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636635;
	bh=BMM2Bw6S237awgvP8yLpAbH7Tym2rwDliC7+4hZEkRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QxvvHt9RG7W0Z65DrTXYvBjz9hr2xmOkG+M5OzV8GOdfykdnDF4wQG1JkvT2bi9iO
	 UNmA8Yuliu1LFKn/OJmwXYXk0uzgcKS+xZmF0EsB26CKqR0apBmooKPRrs1PUrejv1
	 zAObUo9USQLZKaMXR6ohmqbshIz3Ql3pp8GkNnMFBjr3yzUHD5dKg1iYPVOIIzzYMi
	 1YLsPSZkGnHsXRLSV+dNPlKikeUeGBov7TtwvFNst12iuXv+WWBeAbJSQ95i8Hdyzm
	 DyMag1Abw5TaOrVzfnzLcCZI7GkGC6cwvsIivZzzCZED6ZA3a5eSicJGGnQENWRtYC
	 F1o69w6nYWqTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.1.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-2-5ac5a2d6797f@linux.intel.com>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
 <20260709-cbpf-jit-spray-hardening-7-1-y-v1-2-5ac5a2d6797f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 22:37:15 +0000
Message-Id: <20260709223715.93C851F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incomplete Spectre v2 / BHI mitigation for BPF JIT spraying on CPU=
s with RRSBA.
- [High] Unprivileged local Denial of Service (DoS) via synchronous IPI bro=
adcast storm.
--

--- Patch [2]: [PATCH 7.1.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT all=
ocation ---
commit 9b68eba3d351f7dea03fa0a56d5f7eb7c06e801c
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

x86/bugs: Enable IBPB flush on BPF JIT allocation

Enable hardening against JIT spraying when Spectre-v2 mitigations are in
use. Specifically, issue an IBPB flush on BPF JIT memory reuse. Skip
enabling the IBPB flush if the BPF dispatcher is already using a retpoline
sequence.

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 83f51cab0b1e3..d9af230c05125 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
[ ... ]
> @@ -2238,6 +2251,27 @@ static void __init spectre_v2_update_mitigation(vo=
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
Does this expose the system to a Denial of Service (DoS) attack from
unprivileged users?

Since this static call is invoked during BPF JIT allocations (e.g. via
bpf_arch_pred_flush() in bpf_prog_pack_alloc()), an unprivileged user can
repeatedly attach and detach classic BPF socket filters using
setsockopt(SO_ATTACH_FILTER).

This would trigger on_each_cpu(..., 1) repeatedly, overwhelming all online
CPUs with a synchronous IPI broadcast and waiting for them to complete the
expensive write_ibpb() operation.

> +
> +static bool __init cpu_wants_ibpb_bpf(void)
> +{
> +	/* A genuine retpoline already neutralizes ring0 indirect predictions */
> +	if (retpoline_seq_enabled())
> +		return false;

[Severity: High]
Is it safe to assume retpolines are a complete mitigation here without also
verifying that RRSBA is safely disabled?

In other mitigation paths like bhi_apply_mitigation() and spectre_bhi_state=
(),
the kernel checks rrsba_disabled along with retpoline_seq_enabled() because
an RSB underflow on CPUs with Restricted Return Stack Buffer Alternate (RRS=
BA)
behavior can cause RET instructions to fall back to the BTB (which could be
poisoned by an attacker).

If a system has RRSBA that cannot be disabled, skipping the IBPB flush here
could leave the BPF JIT spraying mitigation incomplete.

> +
> +	return boot_cpu_has(X86_FEATURE_IBPB);
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-cbpf-jit-s=
pray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com?part=3D2
