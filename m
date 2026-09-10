Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3194B511E8C
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060129; cv=none; b=j3DObsmzz1J+nASZMK1fJrPDXZJtEWLOC/cQ4qYPW6XCBcsBLaTk4zcLz0ynHbGbIak8+RqYmQeAgQdYqAtzxEgRci8sCMq9Jo8PEE8OiudKCWNuEfyO/w5bZZXxPV7GBj2JHfbFCfx38lp0P8g7Y0zmFXdbxEg0/lHSOl4ZEo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060129; c=relaxed/simple;
	bh=34cEz4OKIavNvETITx4Q4J3RuLRXk6W/2UlZ/pd36nk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EH9Di8cBco0DVV36HJgCgceKRwTWPq+uPo3KUvE5xu3z+xPKJgJL4BiiMpKroAlxsk1onjCXNlcBZhvOAbcM0hdPiS+mgbt4SAAJIo4RI5Xusrntrxw9Rh9EwfI3Cm7SheCQRFT+UE2nacjPxT/Wm85Eo1ovQLOGSuKb1K0V1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoxMs7PB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoxMs7PB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC551F000FF;
	Thu, 10 Sep 2026 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060111;
	bh=BEPCEFVUaeAmRjQZvcP+7UGmYV6vHgcgwaqQZ/mWuME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aoxMs7PBjKU9VRxLmrT58a812qI7lY1PpyF2/rv7mARjdB469r7k+cLVjqee4moNO
	 JN6UeaB6NMB+fJXB09WLLpAVtNbAgw3dACqER5nxfkybED78FBFYWtzWx5A68TTrvg
	 VVXrZaFipcORuK0bJu2srVXcX6z6jFVt4RJSnzqtKJYffwmlRAwP8X8cr3tYVB8lh/
	 EBWeVa4TL9NeXNVURiaqcz8XrfoNbWbPkO/3/ri1O9V9pQuhTdvhglLuLy1Dd4zhhZ
	 Aj2gyMCIgJcpe6beTJEP2+WjDIK5Mynz5s94mkBy8/zsNzXlzyNepnQijecigjcNMB
	 BJCQ+AggKhxuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 05/13] bpf: keep the range across a sign
 extension that cannot change it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910164635.459558-6-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-6-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:08:30 +0000
Message-Id: <20260910170830.DFC551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete fix for bounds precision loss on zero-straddling sign=
 extensions in the verifier.

Pre-existing issues:
- [High] Out-of-bounds array read in BPF memory cgroup kfuncs due to bypass=
able enum bounds check.
--

commit 971a50869c707d4ac0627b912bd2423344987acc
Author: Vineet Gupta <vineet.gupta@linux.dev>

bpf: keep the range across a sign extension that cannot change it

This commit improves the verifier's handling of sign extensions in
coerce_reg_to_size_sx() by recognizing when a register's bounds already fit
within the target field. This prevents unnecessary precision loss when a va=
lue
range straddles zero, allowing valid programs to pass verification.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 58e788f53ae58..eb093194e2a36 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -5773,6 +5774,27 @@ static void coerce_reg_to_size_sx(struct bpf_reg_s=
tate *reg, int size)
>  		return;
>  	}
> =20
> +	if (size =3D=3D 1) {
> +		field_smin =3D S8_MIN;
> +		field_smax =3D S8_MAX;
> +	} else if (size =3D=3D 2) {
> +		field_smin =3D S16_MIN;
> +		field_smax =3D S16_MAX;
> +	} else {
> +		/* size =3D=3D 4 */
> +		field_smin =3D S32_MIN;
> +		field_smax =3D S32_MAX;
> +	}
> +
> +	/*
> +	 * The range already fits the field, so (sN)v =3D=3D v for every value =
the
> +	 * register can hold and the sign extension changes nothing. The tests
> +	 * below cannot reach this case once smin is negative: a negative smin
> +	 * and a non-negative smax never share their high bits.
> +	 */
> +	if (reg_smin(reg) >=3D field_smin && reg_smax(reg) <=3D field_smax)
> +		return;
> +
>  	top_smax_value =3D ((u64)reg_smax(reg) >> num_bits) << num_bits;
>  	top_smin_value =3D ((u64)reg_smin(reg) >> num_bits) << num_bits;

[Severity: Medium]
Does the 32-bit counterpart function coerce_subreg_to_size_sx() need the sa=
me
fix?

It seems to retain the same precision loss flaw when handling 32-bit sign
extensions on ranges that straddle zero (e.g., [-4095, 0]). Valid BPF progr=
ams
using 32-bit MOVSX on such ranges will needlessly lose bounds precision and
might be incorrectly rejected by the verifier.

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds array
read in the BPF memory cgroup kfuncs.

Enums are treated as scalars by the verifier and can be negative. The bounds
checks in these functions use single-sided signed comparisons, which bypass
negative values:

mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events() {
    ...
	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

	return atomic_long_read(&memcg->memory_events[event]);
}

If a BPF program passes -1, the check evaluates to false, leading to an
out-of-bounds read on memcg->memory_events[-1].

A similar issue exists in bpf_mem_cgroup_vm_events(), where the bounds check
delegates to memcg_vm_event_item_valid():

mm/memcontrol.c:memcg_vm_event_item_valid() {
    ...
	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;
    ...
}

This also performs a single-sided check and fails to catch negative indices.
Should these be updated to explicitly check for negative values as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910164635.4595=
58-1-vineet.gupta@linux.dev?part=3D5
