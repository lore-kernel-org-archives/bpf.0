Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6642F7EE4
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308832; cv=none; b=FDfIWtcQyU2kxspkSPgflvoyhFn4XI7aPhk1JokhRKeInUcKr4l38ErpkGSl4k39MgTR+mGRl4JkhL9p4GmO0DHrlw18muOJjhHm1L2TM1pMPvTVMVSltGH01UxhTJAxj6DpARxh6yxipfljPociizVTZrvnnu3EEhaC3A4TzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308832; c=relaxed/simple;
	bh=qBGsqWs3fysZG/1kRPukzlDtKxGPwfwavUKvF1vyPw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wy1KTkcKHThP/boBtnbdRx+grUpP1uIgztskS9YXALqs+D1HZaVK0ASN5bqXCn8dTOr5Mt/rGKCa6kdzzcfJQnZizGCgGZZVeeQzrTQ0fC5tcDXQeD1P6Bq5bxeqhHLvTC0SmAinYFHRb/n5u1wJKISbNSu7QPUzKV/ErkPO/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIKjHOae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIKjHOae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061111F000E9;
	Fri, 17 Jul 2026 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784308831;
	bh=WGnXUM8BqOfArwiVjryDWYJHWHrEPCG4mN5uQ6IfpAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RIKjHOaeDJuOCkWOVNsY9Yf1ggf2iCAhqtLed3G5KrjFvvM1RKCLE/49KJ8sBZawL
	 SOgInSSAnfeV/0VKiP54/jlf+fMw5COcRwdIMMWIJVYkQTL/BvqRSjzQNEu8ngI8DA
	 RFoHv1BteBfGxz/TjaOJxVQRIuQWWKlaxiQqyT9LyQA69p3O0Q8Ok1wB/WfBTtOITd
	 Iu+VIHcIVd5+W9brNbQvqWa2vWFYTXJtlN1TFxN5L0N0sAp0Xpx6g5sFnEGuBCuVeZ
	 jSkUw3XofxM2T5JyHqrnOvJrbt9vRyhYMHAn8XpKr7EM2gFksTu5iyDjzqzaXM2cYA
	 WWOB2KQwzCaZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 3/6] bpf: Restrict JIT predictor flush to cBPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-3-e04f1b2893de@linux.intel.com>
References: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
 <20260717-cbpf-jit-spray-hardening-6-6-y-v1-3-e04f1b2893de@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:20:30 +0000
Message-Id: <20260717172031.061111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Spectre v2 mitigation bypass in BPF JIT allocator due to restricte=
d predictor flush.
--

--- Patch [3]: [PATCH 6.6.y 3/6] bpf: Restrict JIT predictor flush to cBPF =
---
commit 8a65f5d94c81da9af1257fa2e8b48ff8c73c9963
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Restrict JIT predictor flush to cBPF

This commit restricts the predictor flush on memory reuse for BPF JIT
allocations to only cBPF programs. It adds a was_classic parameter to
bpf_prog_pack_alloc to determine if the flush is necessary, assuming eBPF
allocations do not require the overhead of flushing predictors on reuse.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0d8008711629c..509f1b9c2b2e2 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -951,7 +951,9 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>  	pos =3D 0;
> =20
>  found_free_area:
> -	static_call_cond(bpf_arch_pred_flush)();
> +	/* Flush only for cBPF as it may contain a crafted gadget */
> +	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
> +		static_call_cond(bpf_arch_pred_flush)();

[Severity: High]
Does skipping the flush for eBPF allocations leave the branch predictor
vulnerable if the memory was previously used by a cBPF program?

If an attacker loads a cBPF program, trains the CPU branch predictor to
target a specific offset, and then frees it, could a subsequent eBPF program
allocated in the same memory chunk skip the flush because was_classic is
false? This might allow an attacker to trigger a kernel indirect branch that
mispredicts into the newly loaded eBPF program at the trained offset.

Also, if kernel.unprivileged_bpf_disabled=3D0, couldn't an attacker directly
use unprivileged eBPF programs to bypass the flush completely, since their
type is not BPF_PROG_TYPE_UNSPEC?

>  	bitmap_set(pack->bitmap, pos, nbits);
>  	ptr =3D (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
[ ... ]
> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> index fa3e9225aedc0..b3f164e31c6bb 100644
> --- a/kernel/bpf/dispatcher.c
> +++ b/kernel/bpf/dispatcher.c
> @@ -145,7 +145,7 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher=
 *d, struct bpf_prog *from,
> =20
>  	mutex_lock(&d->mutex);
>  	if (!d->image) {
> -		d->image =3D bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zer=
o);
> +		d->image =3D bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zer=
o, false);

[Severity: High]
Similarly, does explicitly passing false here for the dispatcher skip the
flush, leaving it vulnerable to unintentional gadget exploitation via
leftover branch predictions?

>  		if (!d->image)
>  			goto out;
>  		d->rw_image =3D bpf_jit_alloc_exec(PAGE_SIZE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-cbpf-jit-s=
pray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com?part=3D3
