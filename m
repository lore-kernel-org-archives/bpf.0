Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810137E5E7
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309474; cv=none; b=lCiNCe+hN+MANJwkeS0FX2GfnDF+1B25Vn/of6YidGZRRqTZiXzUuAJF773T7G0Q0dDJ+I9CrcoTPPEzMRHKRzaZJA8WrPKdD8Yj+1tsEpog+eQpQGjlyNRCCOoW7D0JJBX7ERo7WRs6BhFbkEQRcX3H57VB0HmsfKi8mtLnMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309474; c=relaxed/simple;
	bh=nycHs2+wkPZROAaukizAYgDR/ASWovYp7jorHb7bQ5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zp2mkd5ohxXkpLM0oM29UoZWhdHl2A1UBbMIr22V3F5Rd2GDXQt70+8bYcq8lf7piX9it9rXYqTxeJp29xBlKlw2YsfqGyNRPzWrnc0RCuLXEv/cNcsMnNm1YndyBrEXRmZSklyzbpQUJBRtQWpcWKjRUA7+AWpa0z5WyPAkNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEaRF5Pa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEaRF5Pa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BFF1F00ACA;
	Fri, 17 Jul 2026 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784309473;
	bh=zb3OorBq26OCtGW3zsBVv0CWMfzmUgrUItVKeO8nUiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IEaRF5Pac1ZovBf5B7Y1u1H9bKuWzLcdkD45SijVNxy3HsBldTayJEHKBbGoU00hk
	 WdcOkkaejb5jVZxfr5nE0sW91kxrrqe5VIp2OaZauMIoQdCSK14KNBcQegeijifVvZ
	 kOPFlfCDVjIOak4UHCcdaEPTOBW8VZNfd+oHT3vtxqDvRLkezT3klJyWIftnc14KUh
	 qE16DD4tkhkNa982iw072ZEvUwCW+9WtzSfPyp+hdCJNz0+ihrAdaRaR/1qfPJ57x6
	 NuW6axRzRouApWz4J7P4DiKUNaMq0EiH3whbqcmQOmf/R5Lgxe55QEEraAHMX16Osv
	 DenOZxWquMjsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-6-e04f1b2893de@linux.intel.com>
References: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
 <20260717-cbpf-jit-spray-hardening-6-6-y-v1-6-e04f1b2893de@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:31:12 +0000
Message-Id: <20260717173112.D6BFF1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch actively steers eBPF programs into dirty packs without f=
lushing the branch predictor, leaving privileged eBPF vulnerable to Cross-D=
omain BTB Poisoning and allowing unprivileged eBPF to preserve BTB pre-trai=
ning.
--

--- Patch [6]: [PATCH 6.6.y 6/6] bpf: Prefer dirty packs for eBPF allocatio=
ns ---
commit b2416181326f994ad8a8ff6f867915a656a73187
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Prefer dirty packs for eBPF allocations

This commit modifies bpf_prog_pack_alloc() to prefer dirty packs for eBPF
allocations. It steers eBPF programs into dirty packs and keeps clean packs
free for cBPF to reduce branch predictor flushes.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7dc59570cd25a..4669a57265ad7 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -950,10 +950,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_ho=
le_t bpf_fill_ill_insns, bool
>  			goto found_free_area;
>  		/*
>  		 * cBPF reuse of a dirty pack triggers a flush, so prefer a
> -		 * clean pack for cBPF. eBPF never flushes, so pick the first
> -		 * free pack, dirty or clean.
> +		 * clean pack for cBPF. eBPF never flushes, so steer it to a
> +		 * dirty pack and keep clean packs free for cBPF.
>  		 */
> -		if (!was_classic || !pack->arch_flush_needed)
> +		if (was_classic ^ pack->arch_flush_needed)
>  			goto found_free_area;

[Severity: High]
Does steering eBPF programs into dirty packs without flushing the branch
predictor expose them to Cross-Domain BTB Poisoning?

If an attacker loads a cBPF program to train the branch predictor and then
frees it, the pack becomes dirty. When an eBPF program is subsequently load=
ed,
this logic steers it directly into the dirty pack.

Because the flush condition later in bpf_prog_pack_alloc() only triggers wh=
en
was_classic is true:

	/* Flush only for cBPF as it may contain a crafted gadget */
	if (static_branch_unlikely(&bpf_pred_flush_enabled) &&
	    pack->arch_flush_needed &&
	    was_classic) {
		...
	}

Could this bypass the IBPB flush for eBPF allocations, leaving pre-trained
malicious BTB predictions intact for an attacker to exploit?

>  		if (!fallback_pack) {
>  			fallback_pack =3D pack;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-cbpf-jit-s=
pray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com?part=3D6
