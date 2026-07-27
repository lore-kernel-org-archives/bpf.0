Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00AA245020
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193615; cv=none; b=sOBHUQEKaLZKB7kR+eYqAY1iTLgMJPfi83oH8qDYbN8mgrS+PJrYH5lz5N9kuQM1R/A7370VP4FdUjOIC490mZEIq4S//d0SrOJTZUMA4BR7In+hk4MICXvHS6sAHjFbLNqlxs/xyUfhLOtSYWabA96zqkTL6M+dJBS72QyNwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193615; c=relaxed/simple;
	bh=APZ8k129JZy7YHdkwaCXC1WZgKumzxy2TTW5NbBMjCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EfcHwIIwrimGe5EKmxLw2c37BrvOENrW+li8HoC6mnWRBVy12vg8AVm1CE80aPfKMCuq6fIyCX+AIQaWq1pgRjT7ak5lM8U9eRNzcXNbB7kwpPxHqtpBdOlesEbYlDUzTJ33Ti7obInxeJw4vCZVoN3aNrUcp93t/6VmwMr7+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZJzFwtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZJzFwtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D98C1F000E9;
	Mon, 27 Jul 2026 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785193614;
	bh=jRJzcMacDR+Ei1zcwKRMjmj1XmT5BlsyBTY94smdtA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZJzFwtQvo7DGANamc6pXUZMixciNQ/EV1PN2cv4SFpXfvv3OdifxpDaD4/Y8s4GY
	 jtFaz76kdnGcNmwoQeP7QWb472pJUj2xp35SYfSJQDLYHLM83SU8rnktSFNJppK51u
	 8WG6T+jM0HrzspqtlrB1aecgnfAliDKViGiz029fQnI5AmbCTccFGHw13f6nTCRxyY
	 e0qt82fpfXaO+FNNqOOlwqqRgckH5AvgCNVkM11Y+5/BKLPz2MgHJtt3MsQYPXah19
	 2SDLL1H40AB5kELjJCDJhSdWQxO6As7yfQSSJ+DP3Nd/itRADL1xSwl8iP0K3gzdSn
	 6QETTnCNVWJig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y 3/6] bpf: Restrict JIT predictor flush to cBPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-3-eb80dcf1eb6e@linux.intel.com>
References: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com>
 <20260727-cbpf-jit-spray-hardening-6-1-y-v1-3-eb80dcf1eb6e@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 23:06:53 +0000
Message-Id: <20260727230653.8D98C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Spectre v2 Mitigation Bypass for Unprivileged Native eBPF
--

--- Patch [3]: [PATCH 6.1.y 3/6] bpf: Restrict JIT predictor flush to cBPF =
---
commit 77faa1df216dd9c68cbac9a596c9d2f4b8b6ffef
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Restrict JIT predictor flush to cBPF

This patch restricts the predictor flush on memory reuse to cBPF programs
only, aiming to reduce performance overhead on busy systems. It skips the
flush for native eBPF allocations under the assumption that eBPF is
privileged.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 4643554c6e3a9..f78ee18bab3b5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -947,7 +947,9 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>  	pos =3D 0;
> =20
>  found_free_area:
> -	static_call_cond(bpf_arch_pred_flush)();
> +	/* Flush only for cBPF as it may contain a crafted gadget */
> +	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
> +		static_call_cond(bpf_arch_pred_flush)();

[Severity: High]
Does skipping the predictor flush here for native eBPF bypass the Spectre v2
JIT mitigation for unprivileged users?

The commit message notes that eBPF is privileged by default, but unprivileg=
ed
local users can still load native eBPF programs (such as
BPF_PROG_TYPE_SOCKET_FILTER) on systems where kernel.unprivileged_bpf_disab=
led
is set to 0.

Since native eBPF sets was_classic to false, wouldn't bpf_prog_pack_alloc()
now skip the flush and leave unprivileged native eBPF programs unprotected
against branch target poisoning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-cbpf-jit-s=
pray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com?part=3D3
