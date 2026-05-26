Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321F3AE6E5
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811925; cv=none; b=IVMASMDU4IadmLc7bqZqOOpjUyvXyRxFlp6VB1cscY+Jtdk0sCFmyn7Yt8Vpcd7sDgNltSIuR2YTpUF01BhPXq1RetBA4TMYhRIWYpv0nqnTQmP+MlWQslDIrd/oixCsZss6yAhTvrCIVRoJ2H6woe0VLLIRry0/LFlI8AldRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811925; c=relaxed/simple;
	bh=sD86qSUTAaf3fQnSGi5HDYIkE+vfrZh0vZajIx/dvhs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=noyeYCHxfrL0msdK6wO8jiAtlV1kr6K6LRzaQgCCpPL0bJVFscfrKTHX8PUAYVupQ5Eyby0jQlPXoF/EYm/y1kXV9JaptzRo39LF7qWI/8Uo8aPi19Vb+YrUQfTwqLe/JgIRd2EG8uNTsdvmiNO5YZGP2HYcEU87yRVoQq3HqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cxh914y6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cxh914y6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDFB1F000E9;
	Tue, 26 May 2026 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811924;
	bh=j3Sldf0iyripjAtfDJoyhtQ09bCZ5N303/P3VsHuZLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cxh914y6BbYyO1PqR3RQZTz5Bz/NC7HCeOZexjwZgBatEQprlgYwuvlhZDrYP5Afw
	 vmvYpz7UERs9+uK9WpF3CyryzJH+gSX/d1a/xfftqfwWBg+tL5oCCbgkObaowU6EYV
	 4BUaoqW6kZB9bJxzmJdQdjriUVELLTLDg6LTdbvpzgp9fB3Glqp5dKkrNitY01tlJL
	 iiIpkhAlJtogmqN8zVhE4IQvIWvbVqbEPFyyldmV0dFsRvzt9KvcI/wKDILK7Lm6ey
	 Dsb589oNi6Q378JYRjLQYU/Jojk5iTHwFv6/xd3YdLhJkI3yE2UHLHJ/+pY5PNWb0r
	 BMGzBd9ZrWL4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] preempt: Track NMI nesting to separate per-CPU
 counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: bpf@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260526152148.30514-2-boqun@kernel.org>
References: <20260526152148.30514-2-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 16:12:03 +0000
Message-Id: <20260526161204.6BDFB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Race condition in __nmi_exit() causing preempt_count underflow=
 and severe state corruption.
- [High] Non-atomic update of preempt_count in __nmi_enter() clobbers state=
 changes made by nested NMIs.
--

commit c247872c3bac47f83b6c7df80c559c9576868ea1
Author: Joel Fernandes <joelagnelf@nvidia.com>

preempt: Track NMI nesting to separate per-CPU counter

Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
counter (nmi_nesting) to free up bits for other uses. Reduce NMI_BITS from
4 to 1, using it only to detect if we are in an NMI, and cap nesting at 15.

Link: https://patch.msgid.link/20260121223933.1568682-3-lyude@redhat.com

> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index d57cab4d4c06f..1a0360a1000f1 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
[ ... ]
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

[Severity: High]
Does this non-atomic read-modify-write of preempt_count risk clobbering
state changes?

If a nested non-maskable exception (such as an MCE) interrupts the CPU exac=
tly
after the outer NMI reads preempt_count() but before it executes
preempt_count_set(), the outer NMI retains a stale snapshot.

If the nested exception modifies preempt_count (such as setting the
PREEMPT_NEED_RESCHED flag via set_preempt_need_resched()), those changes
could be unconditionally overwritten and lost when the outer NMI resumes and
blindly writes back its stale snapshot.

>  	} while (0)
> =20
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
> +			__preempt_count_sub(NMI_OFFSET);	\

[Severity: Critical]
Can a nested NMI here cause preempt_count underflow?

If a nested non-maskable exception interrupts execution exactly after
nesting =3D __this_cpu_dec_return(nmi_nesting) but before the outer NMI exe=
cutes
__preempt_count_sub(NMI_OFFSET), the outer NMI will have decremented
nmi_nesting to 0.

The nested exception would then run nmi_enter(), see nmi_nesting =3D=3D 0,
increment it to 1, and set NMI_MASK. On exit, the nested exception will
decrement nmi_nesting back to 0 and clear NMI_MASK via
__preempt_count_sub(NMI_OFFSET).

When the nested exception returns, the outer NMI resumes execution with its
local nesting variable as 0, and blindly executes
__preempt_count_sub(NMI_OFFSET). Since the nested exception already cleared
the NMI_MASK bit, this second subtraction could underflow bit 20 (NMI_OFFSE=
T),
borrowing from the upper bits and corrupting flags like PREEMPT_NEED_RESCHE=
D.

>  		arch_nmi_exit();				\
>  		lockdep_on();					\
>  	} while (0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526152148.3051=
4-1-boqun@kernel.org?part=3D1
