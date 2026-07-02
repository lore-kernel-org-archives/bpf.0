Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00B8C1F
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959734; cv=none; b=e/fnAcZnq1X6rPpA4qWkbaFQHmipbNLSOLjvD+MCW1aTr7Z9cAP4Ycmd57NafECX8zaOC/KwXCyzB7Uez8VlnczHb32DdBRgNEDDTdFpHJY0A9muPHXvtSioQMe80tRRcQ2qt8u4a2bflwF1GGfRFga4L1KQetUTpTu5icepiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959734; c=relaxed/simple;
	bh=tZsDRv2TQoDa2rupq101WIbYWUvJ4uQXtYwlr3+s184=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NJEp+/PdCMqmuX0I8I6U0RJfXASFvspz+2ZaVX5sutn9z52/2goKsfHcawbSwtvkquUqWfERfOi4a3A17OGHQKDFB3rLzvIVXXIxwGm3Iqgoe4EXI3Ar08bdIRNwxxZ80p181OqrIGZhoalF5e33rifZAMqjkiwcDsusmDTcARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbX2uWi5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbX2uWi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1201F000E9;
	Thu,  2 Jul 2026 02:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782959733;
	bh=PdAX4hy5FkIPNcuW74lPHFXvlNihDvxrwwPzRqTDppA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbX2uWi56KJI9JPNAngzsN48G2UwmGAh/UCTvF4UgiPEOxj7sUJGE/I9ujMZsN/44
	 vBBKENGlWaKa6jAjnSppjT3fTZH7dXJ5PQYy/4TBuEKbWsnwfOzKk3LOS5Y1092FAb
	 bPPV47mUh+x1o992KZuQNcc8ue+nCUezceecXmURQ1UebvomhepPAqf7er6+JrV7Ku
	 GZ66dyZDMh0snq2JGmLKbEqPLpV2+K2Rs/Um+AV6b12O45x5dVm6250e8wFEbehtHk
	 AhaDT9QUGXz6xcef2VWxIyJ6sd14o6TFLx6itKCfJPl4tXw4twOoe1/rZYn9mPtDOC
	 SoQcCN1OWvP6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 01/11] LoongArch: BPF: Fix tail call count
 pointer offset for arena programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702022322.51033-2-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
 <20260702022322.51033-2-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:35:32 +0000
Message-Id: <20260702023533.2E1201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added multi-line comments violate the BPF subsystem's pre=
ferred comment style.
--

commit a7174bab96fc4c6edb488f83bc8733f74eac78c7
Author: George Guo <guodongtai@kylinos.cn>

LoongArch: BPF: Fix tail call count pointer offset for arena programs

This commit replaces the BPF_TAIL_CALL_CNT_PTR_STACK_OFF macro with a helper
function, tail_call_cnt_ptr_stack_off(). This function properly accounts fo=
r=20
the REG_ARENA slot in arena programs, resolving an issue where the JIT load=
ed
the counter value instead of the tail call count pointer.

Link: https://lore.kernel.org/all/20260629085511.359546-1-dongtai.guo@linux=
.dev

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index ad7e28375aa95..5e34e9e3f5086 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -25,7 +25,23 @@
> =20
>  #define REG_TCC		LOONGARCH_GPR_A6
>  #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
> -#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
> +
> +static int tail_call_cnt_ptr_stack_off(struct jit_ctx *ctx)
> +{
> +	/* Ten words are pushed below the BPF stack: ra, fp, s0-s5, and the
> +	 * tail call count plus its pointer, which occupy the two deepest
> +	 * slots of the callee-saved area.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment format adhere to the BPF
subsystem's preferred style? Multi-line comments in BPF-related paths usual=
ly
require the opening /* to be on its own line.

> +	int offset =3D sizeof(long) * 10;
> +
> +	/* An arena program reserves one extra word above them (REG_ARENA),
> +	 * which pushes the tail call count pointer down by one slot.
> +	 */

[Severity: Low]
This isn't a bug, but this comment also doesn't follow the preferred BPF
subsystem multi-line comment style of placing the opening /* on its own lin=
e.

> +	if (ctx->arena_vm_start)
> +		offset +=3D sizeof(long);
> +
> +	return round_up(ctx->stack_size, 16) - offset;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702022322.5103=
3-1-dongtai.guo@linux.dev?part=3D1
