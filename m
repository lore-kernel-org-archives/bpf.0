Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71992EBDE9
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151854; cv=none; b=Wny3bz/Z0Xfdh8PPoUT6rDKaTzhvaSOc9eOxItPEcVCR99ZDboDMyG1eAXWrqi2ZOc31YnTEJSd8R52XQBrvFdd+OJy7QekvjFLKYNQ3JQpkdbN2L+Oi5/i8ncjdXLMOl5KT73IetXO0MLNoCaP5EwksCNc0HFewq12Qart2xyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151854; c=relaxed/simple;
	bh=4Yw9WFkLNLNhUpK/xhtXcmt5C6qcpcpSGdTmbT0ZNJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e/YMnCSn1clOvXdAoAgnE8AFs9NpWg99tG4mBHYyUlzA5j9VW6/e27UD2V2nmRs9+i5pK0g06XXA9gH2RNSmqWDHQ/pUMVqlexQRT6wyAutH3iHG0I5PmDIAay+VOtBsTeTy5mrj8W6w2aZ+UpEs9QAFFLyUa9LjaCTFVOjQiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NggqUueN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NggqUueN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770181F000E9;
	Wed, 15 Jul 2026 21:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151853;
	bh=KESvYNy5urvGQFS67dFa25xpSeCxqSZBodjCAnC6itA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NggqUueNDBF/bL3I4QYunlf3iiWAjmMaHUnJlrdSZUEEUl1KEYjTgnU9Z+iaYQIz3
	 Dau0xmyseFJUs3ZFBBPKvNVXk2z1gBjVujpFC1EVqPQZ5feew0ZPMMIzWpPgUw81Wp
	 x54Lx1KPRFe0YCHuhrPZFPox4p9i1/rt+H4ZAuC7JRhX5Z/i2KiOUeNpwJaJIY9B/H
	 fyQf9DCouaw2kIszhA657PMtnXqBH3jBsNTH4WWCHLFAZiT//qTXwp1nGoktcXSjLW
	 n6XxNxvR9ymcLS8nPl18Pu4lniMxe6dcDQ+qgD+LHHc+HKDtZoOWn8wncovXMdChtJ
	 yDAui09l10uFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-2-d8585a9aed80@linux.intel.com>
References: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
 <20260715-cbpf-jit-spray-hardening-6-12-y-v1-2-d8585a9aed80@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:44:12 +0000
Message-Id: <20260715214413.770181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing IBPB flush on BPF JIT allocations larger than BPF_PROG_PAC=
K_SIZE allows unprivileged predictions to poison a privileged >2MB BPF prog=
ram.
- [High] cpu_wants_ibpb_bpf() disables IBPB for BPF JIT when retpoline is u=
sed without verifying if RRSBA is safely disabled, leaving some CPUs vulner=
able to JIT spraying.
--

--- Patch [2]: [PATCH 6.12.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT al=
location ---
commit 90d2e2d257bd12908af084fbafc06d88ea57e96b
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

x86/bugs: Enable IBPB flush on BPF JIT allocation

Enable hardening against JIT spraying when Spectre-v2 mitigations are in
use. Specifically, issue an IBPB flush on BPF JIT memory reuse. Skip
enabling the IBPB flush if the BPF dispatcher is already using a retpoline
sequence.

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 939401b5d2ef0..12544fdcadd6a 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
[ ... ]
> @@ -1868,6 +1881,27 @@ static void __init bhi_select_mitigation(void)
>  	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
>  }
> =20
> +#ifdef CONFIG_BPF_JIT
> +static void __bpf_arch_ibpb(void *unused)
> +{
> +	entry_ibpb();
> +}
> +
> +void bpf_arch_ibpb(void)
> +{
> +	on_each_cpu(__bpf_arch_ibpb, NULL, 1);
> +}
> +
> +static bool __init cpu_wants_ibpb_bpf(void)
> +{
> +	/* A genuine retpoline already neutralizes ring0 indirect predictions */
> +	if (retpoline_seq_enabled())
> +		return false;

[Severity: High]
Does this check need to verify if RRSBA is safely disabled before returning
false?

Unlike bhi_select_mitigation() and spectre_bhi_state() which check
rrsba_disabled, this function skips the IBPB flush based on
retpoline_seq_enabled() alone. On CPUs where Restricted Return Stack Buffer
Alternate (RRSBA) behavior cannot be disabled, wouldn't this allow RET
instructions to speculatively fall back to the BTB, leaving them vulnerable=
 to
JIT spraying attacks?

> +
> +	return boot_cpu_has(X86_FEATURE_IBPB);
> +}
> +#endif
> +
>  static void __init spectre_v2_select_mitigation(void)
>  {
>  	enum spectre_v2_mitigation_cmd cmd =3D spectre_v2_parse_cmdline();
[ ... ]
> @@ -2051,6 +2085,14 @@ static void __init spectre_v2_select_mitigation(vo=
id)
>  		pr_info("Enabling Restricted Speculation for firmware calls\n");
>  	}
> =20
> +#ifdef CONFIG_BPF_JIT
> +	if (cpu_wants_ibpb_bpf()) {
> +		static_call_update(bpf_arch_pred_flush, bpf_arch_ibpb);
> +		static_branch_enable(&bpf_pred_flush_enabled);
> +		pr_info("Enabling IBPB for BPF\n");
> +	}
> +#endif
> +

[Severity: High]
Does this mitigation bypass IBPB flushes for BPF allocations larger than
BPF_PROG_PACK_SIZE?

Looking at bpf_prog_pack_alloc() in kernel/bpf/core.c, allocations larger
than BPF_PROG_PACK_SIZE skip the predictor flush:

kernel/bpf/core.c:bpf_prog_pack_alloc() {
	if (size > BPF_PROG_PACK_SIZE) {
		/*
		 * Allocations larger than a pack get their own pages, and
		 * predictors are not flushed for such allocation. This is only
		 * safe because cBPF programs (the unprivileged attack surface)
		 * are bounded well below a pack size.
		 */
		...
		ptr =3D bpf_jit_alloc_exec(size);

However, when an unprivileged user fills a BPF pack and frees it, the
memory is returned to the global allocator:

kernel/bpf/core.c:bpf_prog_pack_free() {
	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
				       BPF_PROG_CHUNK_COUNT, 0) =3D=3D 0) {
		list_del(&pack->list);
		bpf_jit_free_exec(pack->ptr);
		kfree(pack);
	}

Could this returned memory be re-allocated by the >BPF_PROG_PACK_SIZE path?
If a privileged user then allocates a large BPF program (>2MB), it would
use this unprivileged attacker-poisoned memory without an IBPB flush,
potentially allowing a Spectre v2 exploit against the privileged program.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-cbpf-jit-s=
pray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com?part=3D2
