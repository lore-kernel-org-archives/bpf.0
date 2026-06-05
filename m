Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4F2F6565
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639159; cv=none; b=IakQsl2UXkuhC4yz+toM5F7pANXwrOSFtxEZwK2bY5kyjafWm8xnN1cPwq3zLAgWGjmLTJbGHVlXyhSra5dcdUBC35TLuNi9L2obYnJ0RntMhFB4WEOSf8hjHObJc4sHCagF6bHn/y1ILDFQqF/QNLMoIv9AlTQjJVcP5/khfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639159; c=relaxed/simple;
	bh=8/ieZolUmgaC6ZhsErVKLHGjd/LV0no0+cdJBSX68Xw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K/80htBHR7BmehDUXXA0O/M5uTLSYgBysPbCH4tXEoH47De5kT6FY+xzTHZqHcVDt+ijVdM/DTxpF2XOEPufaq2ZJ/+tK1La7s64FpltIkU8jlN4DdqlAmqmQfFeOlspDeKhZhkC6Al9dv75BOJhRMc+P+ezQYQQF0lGcgcHziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxUPVIu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxUPVIu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755661F00893;
	Fri,  5 Jun 2026 05:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780639157;
	bh=0JbV/RbmEDPwgwN4LNWapvf2AiXN3E+LeZ4DrI037Pk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxUPVIu1I0Rf1iuup+hSQtqc2l+xiSxbQE2RIgl0CbKrOwfExpBQeePdOSDKOQa73
	 dKvhQo6r7nRcfdLuGWSYYCAfdQgbGlmbW8hpBf36f4hrcJPmE0S+FI/7geCgjeIFUw
	 IFzqQmd+KKfnbSjEuFWcymIq16YG/e+SGHfVDGr3vHIZwA+jObVYljOET0l0SPcTY4
	 U3UfAyxNAnhUakdl6/AoYUxH0Ry47TN+nos89C8XZxfuq/ZHYi5zBOTCQMQzrRWwRX
	 vnn9htIzwvHlOBbe9Ux+PC+BS7ujl+taCjp85/Q/DAzGD3H8ado8y9ZnJS8JDhIzHj
	 KogmfmzNSuyJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/13] preempt: Track NMI nesting to separate per-CPU
 counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: bpf@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260605054128.5925-2-boqun@kernel.org>
References: <20260605054128.5925-2-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 05:59:17 +0000
Message-Id: <20260605055917.755661F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Arithmetic overflow of `HARDIRQ_COUNT` carrying into `NMI_MASK` pe=
rmanently corrupts `preempt_count` and causes a fatal kernel panic on neste=
d NMI exit.
--

commit fea264f43839ad70d356b7c0bdb7708892c51c22
Author: Joel Fernandes <joelagnelf@nvidia.com>

preempt: Track NMI nesting to separate per-CPU counter

Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
counter (nmi_nesting). This frees up the NMI bits in the preempt_count,
allowing those bits to be repurposed for other uses.

Link: https://patch.msgid.link/20260121223933.1568682-3-lyude@redhat.com

> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -102,14 +104,17 @@ void irq_exit_rcu(void);
>   */
> =20
>  /*
> - * nmi_enter() can nest up to 15 times; see NMI_BITS.
> + * nmi_enter() can nest - nesting is tracked in a per-CPU counter.
>   */
>  #define __nmi_enter()						\
>  	do {							\
>  		lockdep_off();					\
>  		arch_nmi_enter();				\
> -		BUG_ON(in_nmi() =3D=3D NMI_MASK);			\
> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
> +		/* Maximum NMI nesting is 15. */		\
> +		BUG_ON(__this_cpu_read(nmi_nesting) >=3D 15);	\
> +		__this_cpu_inc(nmi_nesting);			\
> +		__preempt_count_add(HARDIRQ_OFFSET);		\
> +		preempt_count_set(preempt_count() | NMI_MASK);	\
>  	} while (0)

[ ... ]

>  #define nmi_enter()						\
> @@ -124,8 +129,12 @@ void irq_exit_rcu(void);
> =20
>  #define __nmi_exit()						\
>  	do {							\
> +		unsigned int nesting;				\
>  		BUG_ON(!in_nmi());				\
> -		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
> +		__preempt_count_sub(HARDIRQ_OFFSET);		\
> +		nesting =3D __this_cpu_dec_return(nmi_nesting);	\
> +		if (!nesting)					\
> +			preempt_count_set(preempt_count() & ~NMI_MASK);	\
>  		arch_nmi_exit();				\
>  		lockdep_on();					\
>  	} while (0)

[Severity: High]
Does this combination of __preempt_count_add() and bitwise OR in __nmi_ente=
r()
break arithmetic symmetry when NMIs nest deeply?

Because HARDIRQ_BITS is 4, it can hold a maximum value of 15. The patch
explicitly allows NMI nesting up to 15 levels. If an NMI interrupts an acti=
ve
hardirq (where the hardirq count is already 1) and then nests 15 times, the
total number of __preempt_count_add(HARDIRQ_OFFSET) operations reaches 16.

This overflows the 4-bit HARDIRQ field and carries a 1 into the NMI_MASK bit
(bit 20). The overflow mathematically clears bit 20 and sets bit 21. By then
forcing bit 20 back to 1 with a bitwise OR, the state is corrupted.

When the innermost NMI exits, __preempt_count_sub(HARDIRQ_OFFSET) subtracts
from this corrupted state, borrowing from bit 20 and clearing it. Because t=
he
inner NMI does not explicitly restore NMI_MASK on exit (as nesting is 14),
it returns to the outer NMI with bit 20 cleared.

When the outer NMI eventually exits, won't it fail the BUG_ON(!in_nmi()) in
__nmi_exit() and trigger a kernel panic?

Also, doesn't this permanently leak a carry bit into the higher fields of
preempt_count (e.g., bit 21), which can accumulate and corrupt other states
like PREEMPT_NEED_RESCHED?

I note that a later patch in the series (commit "preempt: Introduce
HAS_SEPARATE_PREEMPT_RESCHED_BITS") fixes this for 64-bit architectures by
restoring the old algebraic logic, but 32-bit architectures without
CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS appear to continue using this flaw=
ed
bitwise-OR logic and remain vulnerable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605054128.5925=
-1-boqun@kernel.org?part=3D1
