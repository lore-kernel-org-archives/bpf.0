Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547498;
	b=Nbq0tGxm5PDF52ffRKLQatVih7gT95XPtY9PfGsAhw7SjuwF7U6QeFx9NqIpyuHfFvjY
	 HTRmqJULu0g6Hyr0o1TNnD+1k4FOrVClNvRVq1jmlRCYxAo/f9XTugr8o6uxJcQVHO9sA
	 HxUeFOoq1Qqor/42cYF1x3olBqkdZPg7k3e13G9KKukxv+MB7yzoKHKPjaDch1hMJpZXD
	 RQdZys/pHl4YAPS/k75gGerCOHfYS0ZaBE6EZ1O3EmnQnTCW4WZXvIvL1BL8zGLcs8uQB
	 6qsV81B9oWmRhOZQ2GJwH0DwUMMwWMxE1BoFVdmJ5QV0XI627JYIoD4IYSu07nq7nPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547498;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sOH12wkBcbLWROqlS/Jk2VsKeWzTadwiaEoEPTLMHAU=;
	b=W/57/PM5X4nrVftyaRFioofrtE1cXK3yS/CtHj0+UbRMUu09gh+rzZg13phZaEMDGI7L
	 FKmXgDdtGp0l8fplyA4U4nt+50oKKxImnQlCmXZaP5F3KUjGfdxLa8IAzgQO9iLY+w8q0
	 zXLc10wCCJVT5K0reHomLFg+3M49z9e60zCjcn4PDVZY3UckzHI21kbWdh6XUkPRg30ON
	 YZcPlRAmXvhLZg7N6GZXAFRZXf96Ka/LiRzPOaSR3wakYw4hZk8XtRSUbWYA0R1bhTe8T
	 m7mGpvLYxdO0kMgu1I/6OgugV1U+8rIk5/9zQRc4RzcVDxQqhDDKcp2VXmZM/gfSZDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a18LEhsc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC7606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a18LEhsc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16CD1F000C6;
	Tue, 24 Nov 2026 19:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795547497;
	bh=sOH12wkBcbLWROqlS/Jk2VsKeWzTadwiaEoEPTLMHAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a18LEhscJJ5yeNfAoTPWWPj5r3e0fr1L7RVgLPdfXE69BlN+KN8RRzO5y4jQ5XAJx
	 75w0mYurTp2G/THLvkPQkrwF5PXwhVjMsopxfgApwY4wX96EPtU+pxUyZ6bhzK3qhF
	 07Pyd2J092vAF9QPqG6Y9v27+bTlqp+q5uQ0/5uFOKlSgm7GK7Rq5v41ldPx/HKXb/
	 h7VxjXjnd7tEGweYNn6SsczF/wfFPdHrFlr8GBglwOw8/i2KJi0XQCm0G2I7MaS7K4
	 J2VqkaJRS88oAJX03igKNbxG5fCbNpgsPgMMsMP433/g7kohCN4OXm7U8Zl5KsuFVG
	 7o8NS1V7Ckdgg==
Message-ID: <sashiko-outbox-231883@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rcu: Mark rcu_read_unlock_special() notrace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261124185659.1370644-1-rhkrqnwk98@gmail.com>
References: <20261124185659.1370644-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:11:37 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] rcu: missing notrace on rcu_unlock_needs_exp_handling() allows
  recursion
--

commit 0062b967b0900da7cf7c59da2e3a111544dc9aec
Author: Sechang Lim <rhkrqnwk98@gmail.com>

rcu: Mark rcu_read_unlock_special() notrace

This commit marks rcu_read_unlock_special() notrace to prevent infinite
recursion when a BPF trampoline attached to it calls rcu_read_unlock().

> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index ae5d21bae7bc0..a887ab69f4860 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -746,7 +746,7 @@ static bool rcu_unlock_needs_exp_handling(struct task=
_struct *t,
>   * notify RCU core processing or task having blocked during the RCU
>   * read-side critical section.
>   */
> -static void rcu_read_unlock_special(struct task_struct *t)
> +static notrace void rcu_read_unlock_special(struct task_struct *t)
>  {
>  	unsigned long flags;
>  	bool irqs_were_disabled;

[Severity: High]
Should rcu_unlock_needs_exp_handling() also be marked notrace (or static
inline)?

In the preempt_bh_were_disabled || irqs_were_disabled path,
rcu_read_unlock_special() disables IRQs and calls
rcu_unlock_needs_exp_handling() while t->rcu_read_unlock_special.s is
still non-zero.  Because rcu_unlock_needs_exp_handling() is neither
notrace nor inline, marking rcu_read_unlock_special() notrace prevents the
compiler from inlining it when notrace expands to
__no_instrument_function__.  Attaching a BPF fentry or fexit program to
rcu_unlock_needs_exp_handling() then triggers the same
rcu_read_unlock() -> rcu_read_unlock_special() recursion and stack
overflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124185659.1370=
644-1-rhkrqnwk98@gmail.com?part=3D1
