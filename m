Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6683101C0
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144779; cv=none; b=EXiiZGbdi3AD6Xvjfneu0z3m9aFFply4P7wl3n4eWuZP61n3Fc2lccPFVTIC1FsnUYe1a+Fhxcr7NpegvLJeUVzEe9ev5cf7O7pN4t6WVyJwqHyi65BR3lIWMK6Qb+szEwhBF0C1VLvtSjh51m8q7x02GWLpMwfk5kGRuok+x98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144779; c=relaxed/simple;
	bh=tsB7mzDOfwHq8aS6zduINY3y7NeyLNqhtiMUIST4wO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+VDp50GnVMjVl7KWpGDGOaDmRf/ab7XIl9br4eVQ5A8f4pdHb964J8GADyq84BeW+XHmSBHSJqTzcPu66D0dmEtK4DBslhOEMa0B/Os55ubTZ57PPsYGCG9sklBlGIPSV66CoJb5af1bouNQVoo3B8n8pz2AyL6m41YNIhaOK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEKGvyNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEKGvyNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E691F000E9;
	Wed, 19 Aug 2026 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787144777;
	bh=t4n1ody0SFKPEciwUqGJEpHjYEeD6n6eagWE1+xLiaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jEKGvyNItjuWAvh0y99Vna9RQ7nru0LA4fC9p3kNbKWnWmVhB4ffeZwCNEIp1RJ9U
	 0ur/EA3npWA4mkqeyl0mqAgxUG4Dmj2+QxOHwfAKqWaHTnTBfJdhAsDCZtmEJSWPin
	 lNwz0HszHVB8Pq+K4CLmvtHW9ibYZulcLgJ6LnhzdZUBxVckjnLz+WJppKA3Cd5OQ1
	 qP/8JR3SxTwQI5Ja7YHAR0U+au/gIbrj+7kAh4Yjv/FnsapXUcOWm7sNw2lGHMEU9s
	 NGwFxS3TEhMlYOrZiKYTyU1G19iyllvozlvgPW1gKmIMxcCqv4rj8xFEyOQMFDkpql
	 JnXitq57UYDZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: fix REG INVARIANTS VIOLATION on
 speculative pointer arithmetic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819125840.286434-1-jiayuan.chen@linux.dev>
References: <20260819125840.286434-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 13:06:17 +0000
Message-Id: <20260819130617.C0E691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The multi-line comment introduced in the patch does not follow the =
preferred BPF subsystem comment style.
--

--- Patch [1]: [PATCH bpf 1/2] bpf: fix REG INVARIANTS VIOLATION on specula=
tive pointer arithmetic ---
commit d06a2ef5d24e558f7ddc1472c5b3c370252aa5c5
Author: Jiayuan Chen <jiayuan.chen@linux.dev>
bpf: fix REG INVARIANTS VIOLATION on speculative pointer arithmetic

This patch defers the clearing of r32 for pointer registers until after
sanitize_ptr_alu() has potentially snapshotted the register state. This
prevents an inconsistent state where the speculative path receives a snapsh=
ot
with an unbounded r32 but a constant var_off, resolving a verifier warning.

Link: https://lore.kernel.org/bpf/CAGM=3DxGB1fJ9kT8XTitVo74B0WGqgjkoUHdLwzy=
twV0AyqeVApw@mail.gmail.com/

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e421ea2b80c3a..ff83c8ef57be4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14570,6 +14567,14 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env, struct bpf_insn
>  			return sanitize_err(env, insn, ret);
>  	}
> =20
> +	/* Pointer types do not carry 32-bit bounds at the moment. Blank r32

[Severity: Low]
This isn't a bug, but the multi-line comment here does not follow the
preferred BPF subsystem style. The opening /* should be on its own line.

> +	 * only after sanitize_ptr_alu() may have snapshotted dst_reg into a
> +	 * speculative path: otherwise that snapshot freezes a const offset
> +	 * with an unbounded r32, which later trips reg_bounds_sanity_check().
> +	 * reg_bounds_sync() below re-derives r32 from the updated offset.
> +	 */
> +	__mark_reg32_unbounded(dst_reg);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819125840.2864=
34-1-jiayuan.chen@linux.dev?part=3D1
