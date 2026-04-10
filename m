Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC766377553
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815858; cv=none; b=GpYftssKp25xobxk5sJQhqDQJV4uyT+nbLRSVnj/LO6DwRyz0oz6uqZk7AvvjTrLzmuJoEasyiXTrU6Z/or88sQd4dwD+6VbHe+cQV7VfmrLftmmJJlE+H8x70vv//Fdkh69E1j0BFgHMDpahIKm9QkKG5jktw9gJGssyzp68VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815858; c=relaxed/simple;
	bh=f8yf074ct/o+Y0vX87aNFOdni0NGlkPZ2ltrRgbL60c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GqHYHGUEBxlmzBInWpu7tgHZegP2/rH+VyTe94SYcgR14HP0S70w3rVU5Z0mQGti1nhcFJKIkBR5CR9TuXg9EqgS/fRrRVN3gD9eVXT9TG4SE4pPl4Nwv2d5M3Wr8M03VFG5JyNmlilQ1l0NfdihubEp+cQTEoXhZI//HvVqPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t70yxe8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t70yxe8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A063C19421;
	Fri, 10 Apr 2026 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775815858;
	bh=f8yf074ct/o+Y0vX87aNFOdni0NGlkPZ2ltrRgbL60c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=t70yxe8ysDMrXrTZkeI96g2fsaWVBDbOuSkgQo2xVozHNvYVgKZnGwRbCV05b8vaP
	 yQX7NtwEybHteKDO3gNLJCwl25BtlBDtqgegriUzKAWFpAomJDssaGtJmHoPoxsVyJ
	 VcRj/nZsLWwjYR6SpZ7HZXqBGZW/h7lnfOPwbLCyUIQO0tS6HOudTB/fsLjdeUxIjW
	 ICloekhpn3GZPi1y3WGNJiHKqozWiCPcvn2NqXDW8KAmMciAqrBbn/MPshwmYkIPZ1
	 ZK3IwIb1YP2AilE8ped91Xj4NOzrqmuXWTkq2FzoSI3023C1SEZLWa2qS7FxVrv3/T
	 oPvkhMdqiH3cA==
Content-Type: multipart/mixed; boundary="===============7219763634372955635=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <71708b827a04ca32a5fc11fe26eee3d958a0990f4900f20f2328462cde0ad722@mail.kernel.org>
In-Reply-To: <20260410-patch-set-v3-7-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-7-1f5826dc0ef2@gmail.com>
Subject: Re: [PATCH bpf-next v3 07/13] bpf: introduce forward arg-tracking dataflow analysis
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 10:10:58 +0000 (UTC)

--===============7219763634372955635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index a3af5972520f..b5ac0800c18a 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +/* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes each) */
> +#define MAX_ARG_SPILL_SLOTS 64

[ ... ]

> +/*
> + * Convert a byte offset from FP to a callee stack slot index (0-7).
> + * Returns -1 if out of range or not 8-byte aligned.
> + * Slot 0 = fp-8, slot 1 = fp-16, ..., slot 7 = fp-64.
> + */
> +static int fp_off_to_slot(s16 off)
> +{
> +	if (off == OFF_IMPRECISE)
> +		return -1;
> +	if (off >= 0 || off < -(int)(MAX_ARG_SPILL_SLOTS * 8))
> +		return -1;

Should the comment above say (0-63) and slot 63 = fp-512 instead of
(0-7) and slot 7 = fp-64?  MAX_ARG_SPILL_SLOTS is 64, and the bounds
check here uses MAX_ARG_SPILL_SLOTS * 8 = 512, matching the comment
on the #define itself ("fp-8 through fp-512 (64 slots of 8 bytes
each)").

> +	if (off % 8)
> +		return -1;
> +	return (-off) / 8 - 1;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24236538770
--===============7219763634372955635==--
