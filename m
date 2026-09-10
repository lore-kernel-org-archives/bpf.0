Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784251991C
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059973; cv=none; b=gmvN2QJUGpHtpIRaxwvgTl9J72DkBxgW0GRe3asUzLOTULfEC/7TRjOPzzV85IDM3pao9/Ftd98IExmf4qf6lyt6xZy+dvRdpTAK7L3RoUWBibSPDk+m8gp8l9dIjTuqxkUHAFMdDNYLiYWjkJXNZ9hp1murLqednDi3IYh3PLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059973; c=relaxed/simple;
	bh=LZqY09zWR3pNCnFZd0qbTTssHVjGaU9lG5TxaQ4FmPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Spy8GFMDKrj0NNtlIPhIDCcqf26F/TbORaV9QPYRRt0WDxj1oK6z/U4SfwOCRHTe32NBkr7NPFRPFmoI70OAMrx0LY3OxcZQDE6SBw64oBF3+KubRAj77wuZTOpeLLFUIXcaZZ0pPNZIeFdBJ0i/5der/Gld0QSFm4KSpr0S4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd2fzPkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd2fzPkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFBA1F00893;
	Thu, 10 Sep 2026 17:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059960;
	bh=CVICiXBqqdj+q5fPZ4Trhmnx8WnJuFSqWUMJZMnMyWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hd2fzPkDJLjnaOwvRoAOdtnrMlyLK8gzyNmk2U8fw6oz3eaCk43sSEakjh/CBMqqP
	 y8+yHoKaJiTxNaRJdznFVLM8mJ/tJvjjqqw3N092Nk5pc8PmfxMRlzBQx0l6bCqaGW
	 SyqFpaHa5z506MYQjg4NXkHXx1RPIIQi1yA3sA/GYx+ScXS50C5nEQoQ6SD79w3Clr
	 hioD+rRuGpZcHvsfpqml6xhQbsPS3f0diNgeDqaXcaIK2YBgKMB1UkimRdbXXaQFg0
	 t3ubVDbHDhExCtqlYBIuqwosOV+8wfG0SlgzeeATHDghoX+GPweyoygJcqq2RBE/7/
	 lT2hWCFw/XNEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 12/13] bpf: track low-32 scalar equality
 across narrowing stack spills
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910164635.459558-13-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-13-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:05:59 +0000
Message-Id: <20260910170600.0DFBA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Sign-extending loads from 32-bit narrowing spills incorrectly =
inherit and preserve a `SUBREG_ZEXT` link, causing a critical discrepancy b=
etween verifier bounds and runtime values.
--

commit 3396576ba1c56571ccd9a040716058594f558da8
Author: Vineet Gupta <vineet.gupta@linux.dev>

bpf: track low-32 scalar equality across narrowing stack spills

This commit allows the verifier to track a SUBREG_ZEXT relationship when a
64-bit scalar is narrowed during a 4-byte stack spill. This preserves the
knowledge of the lower 32 bits for subsequent loads.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6cb35fc0d0fb0..9e63eddb9023b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -3678,8 +3687,15 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
>  			 * it came from.
>  			 */
>  			coerce_reg_to_size(&state->stack[spi].spilled_ptr, size);
> -			/* Break the relation on a narrowing spill. */
> -			clear_scalar_id(&state->stack[spi].spilled_ptr);
> +			if (subreg_link && reg->id)
> +				state->stack[spi].spilled_ptr.subreg =3D SUBREG_ZEXT;

[Severity: Critical]
Can this lead to verifier state corruption when the spilled value is later
read with a 4-byte sign-extending load (BPF_MEMSX)?

If a BPF program performs 64-bit arithmetic to create an unknown scalar and
spills it to the stack via a 4-byte narrowing store, it records a SUBREG_ZE=
XT
link here and coerces its bounds to 32 bits.

If it then reads it back via a 4-byte sign-extending load, when processing
the read in check_stack_read_fixed_off(), narrowing evaluates to false since
the bounds were already truncated during the spill:

	bool narrowing =3D get_reg_width(reg) > size * BITS_PER_BYTE;

As a result, subreg_link is false, and the verifier skips the
is_ldsx ? SUBREG_SEXT : SUBREG_ZEXT correction logic. The destination
register blindly inherits the stack slot's SUBREG_ZEXT link.

In check_mem_access(), coerce_reg_to_size_sx() properly sign-extends the
loaded value's bounds, but because the subreg link is non-zero, it skips
breaking the scalar ID:

	if (!no_sext && !regs[value_regno].subreg)
		clear_scalar_id(&regs[value_regno]);

The register now has sign-extended bounds but a SUBREG_ZEXT link to the
original 64-bit scalar.

If the original scalar is later refined, sync_linked_regs() will invoke
reconstruct_zext32(), completely overwriting the sign-extended bounds with
zero-extended bounds. The verifier will incorrectly assume the register hol=
ds
a positive value, while at runtime it holds a negative sign-extended value.

Does this permit arbitrary out-of-bounds kernel memory accesses?

> +			else
> +				/*
> +				 * Nothing to relate: either the source has no
> +				 * id to share, or the store is narrower than
> +				 * the 32 bits a link can describe.
> +				 */
> +				clear_scalar_id(&state->stack[spi].spilled_ptr);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910164635.4595=
58-1-vineet.gupta@linux.dev?part=3D12
