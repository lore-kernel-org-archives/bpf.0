Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704C2D6E64
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151865; cv=none; b=OR1TA/zGTprSE790EjtosG6r9QTh12xAab5J4dVDdvj/iWPOVq20P2HKG8iG0/DIqGvq7+kV5B30wChtEQwU38bENAzrNV0cCC1dQY0faT2xX56HHAXOy8a5XAMoX9NJlbV2fOcKTPunaRlkP9KMe8bOBya6pftrnGgcADA4VRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151865; c=relaxed/simple;
	bh=kXnkzmsEIpLNnxpFccov+AFDV2Igv0qBAJ12KB+Euh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LuB1nNok5o49zNnCHSAXlGTQeDKHSTh7bpktaR0j9FtrcPTx1NAs7n1Koqcc9h6p5dToAQBEDRFgELfspil41PP17z1pi341lN7My145UrDxtBmEQC2MoOQEoS/20/iU8+IDGvLx+9U0cJWkQkLftTkQaxmTR7awfnYP9KUqv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU50Gnlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU50Gnlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED7C1F000E9;
	Wed, 15 Jul 2026 21:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151864;
	bh=Lov0UwJqbKDmdvSF21fwUsCCAXWvghgyM6pvKpqti5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YU50GnlmLVr56oxSc/pz06JZAbQCncXaDg1cWEwlzN5rPm9EdxinWCsEyyts1sRuh
	 c41aHzLllRhRzbrIGjjOo8WpyFB3I/XZTCD5bvl/HUHrWln08nZRsvePrFA44YdNXM
	 nY4C79hosd3YbMjexp9lkSJEn/ZEbSPjZtovg6oKSK1ja6vdVx7DBU7jBxrbu4t4sr
	 QkBDTj3zkPg6nAMRZEpXjwlCZWowqEEGIlhMe+D+zWyQ3A6lnF8VzuLAK97n5+mEtM
	 GPp1gnzMuVsY9cMmmt7tGEo/9NPIAzQwLS8ZVhlfcX1oG5FZpjscA8rA05ib/KJsy/
	 GrSjYNkw/CGwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-6-d8585a9aed80@linux.intel.com>
References: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
 <20260715-cbpf-jit-spray-hardening-6-12-y-v1-6-d8585a9aed80@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:44:23 +0000
Message-Id: <20260715214424.3ED7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The BPF JIT memory accounting variable (`bpf_jit_current`) leaks w=
hen `bpf_jit_binary_pack_finalize()` fails, eventually leading to a Denial =
of Service for future BPF JIT allocations.
--

--- Patch [6]: [PATCH 6.12.y 6/6] bpf: Prefer dirty packs for eBPF allocati=
ons ---
commit 085581ec0f6019415f4ae6868940e7810acae213
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: bpf: Prefer dirty packs for eBPF allocations

This commit modifies the pack allocator to prefer dirty packs for eBPF
allocations and clean packs for cBPF. This optimization helps avoid
triggering extra flushes when cBPF reuses a dirty pack. eBPF reuse of dirty
packs is harmless as it does not trigger flushes.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 665f8423b7600..d9131b235f797 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -998,10 +998,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_ho=
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
>  		if (!fallback_pack) {
>  			fallback_pack =3D pack;

While reviewing this area, I noticed a separate issue in the same file:

kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
...
	if (IS_ERR(ptr)) {
		bpf_prog_pack_free(ro_header, ro_header->size);
		return PTR_ERR(ptr);
	}
...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leak
the JIT memory accounting (bpf_jit_current)?

When bpf_arch_text_copy() fails here, it frees the pack memory via
bpf_prog_pack_free(), but misses uncharging the module memory accounting
via bpf_jit_uncharge_modmem().

Additionally, the caller reacts to this failure by permanently skipping
the cleanup that would have reverted the counter:

arch/x86/net/bpf_jit_comp.c:bpf_int_jit_compile() {
...
			if (WARN_ON(bpf_jit_binary_pack_finalize(header, rw_header))) {
				/* header has been freed */
				header =3D NULL;
				goto out_image;
			}
...
}

By nullifying the header, the accounting uncharge in bpf_jit_binary_pack_fr=
ee()
is skipped entirely. Can this eventually lead to a Denial of Service by
preventing future BPF JIT allocations once the global limit is reached?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-cbpf-jit-s=
pray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com?part=3D6
