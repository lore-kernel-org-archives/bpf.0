Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5035A3BF
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729879; cv=none; b=KuDfoKT23A9yDhOZ5ydk85Uk3TzpAzIYcEtipzhI7e1K2NWdpaJiCSSmz6z5CHYllQXFJ6nR5xfJVtBM/wVXGPLoCwPnz7dcp7Wf5fo6NToQ6qcA5wADKRYThNTFfnHFGaL2XzWwEvEPs62DUpj2g29DpX8izupckWmZvzt/QVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729879; c=relaxed/simple;
	bh=dRs2c71jRPbUpwOBRbAUEGhOdQ4mFhsjJvVAMbHgR4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uyXyqPFPEEdse8ET50zgmugap2qoL9Tk8vkozM3hsXtzs/p9cRZdgdbGMvdYA7y9lOmruhu//iqn6lczYgSPAlQP4nf7QhRdxze1HMAMddB09/EcPKFNUysjGVhqNx8ZV61tP3FGZDGiYOQzPDQkhW5RLko2sN0vLKvqRbfIWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+wabIG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+wabIG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278E51F00A3A;
	Wed, 22 Jul 2026 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784729877;
	bh=a4eUqd6E1y2YilU/k2rhAzvhhImMekwBVp5DqZ40p+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+wabIG7lclIJN+zUt/Nwgenp28jgHf6Dzums3wE+NfM7tGHVTVbfj6g8NvMK+9Ry
	 XAfJ7fqb8SCCneyqUO6ro7kWFudfwtuntDD2YcApaw6FiaavMBVCSsGqKHYDKE1BUN
	 dtj93JhxLB+XTY6CvsUfZEw39cITvS7if9suvdZXu8aYloTKuzphaxqnaWbJ5mDCyA
	 mZA1hk4uMyK78O4/jkgBosOCpB6hGbmoRx3MYkZb/Uk2+wD3irxpA5SJaU+Jvq1ZZw
	 sVNp8WT3M7u0LaQZC2byY0KTFXjLglakBSJReYL01wSbruDbXWEsN9tfu1Cv6Rr5kF
	 Je5J3MzAsspuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/6] riscv, stacktrace: Implement
 arch_bpf_stack_walk() for BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Varun R Mallya" <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722140015.1982158-4-varunrmallya@gmail.com>
References: <20260722140015.1982158-1-varunrmallya@gmail.com>
 <20260722140015.1982158-4-varunrmallya@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:17:56 +0000
Message-Id: <20260722141757.278E51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arch_bpf_stack_walk is incorrectly placed inside the #ifdef CONF=
IG_FRAME_POINTER block, silently breaking BPF stack walking features when f=
rame pointers are disabled.
--

--- Patch [3]: [PATCH bpf-next v3 3/6] riscv, stacktrace: Implement arch_bp=
f_stack_walk() for BPF ---
commit 0c8984f224c945ac7ba31a2cde4b91bf4740e71c
Author: Varun R Mallya <varunrmallya@gmail.com>

riscv, stacktrace: Implement arch_bpf_stack_walk() for BPF
   =20
This patch implements arch_bpf_stack_walk() for RISC-V by wrapping
walk_stackframe(). It is intended to be used by bpf_throw() for unwinding,
passing the required state to the consume callback.

> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 30b369dd28151..c0f2393e5163c 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c

[ ... ]

> @@ -104,6 +105,30 @@ void notrace walk_stackframe(struct task_struct *tas=
k, struct pt_regs *regs,
>  	}
>  }
> =20
> +struct bpf_unwind_consume_entry_data {
> +	bool (*consume_entry)(void *cookie, u64 ip, u64 sp, u64 fp);
> +	void *cookie;
> +};
> +
> +static bool bpf_unwind_consume_entry(void *arg, unsigned long pc,
> +				     unsigned long sp, unsigned long fp)
> +{
> +	struct bpf_unwind_consume_entry_data *data =3D arg;
> +
> +	return data->consume_entry(data->cookie, pc, sp, fp);
> +}
> +
> +void notrace arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip=
, u64 sp, u64 bp),
> +				 void *cookie)
> +{
> +	struct bpf_unwind_consume_entry_data data =3D {
> +		.consume_entry =3D consume_fn,
> +		.cookie =3D cookie,
> +	};
> +
> +	walk_stackframe(current, NULL, bpf_unwind_consume_entry, &data);
> +}
> +
>  #else /* !CONFIG_FRAME_POINTER */

[Severity: Medium]
Will arch_bpf_stack_walk() be excluded when CONFIG_FRAME_POINTER is disable=
d?

It looks like this function is placed inside the #ifdef CONFIG_FRAME_POINTER
block. Since walk_stackframe() has a valid implementation for
!CONFIG_FRAME_POINTER that does stack-scanning, shouldn't
arch_bpf_stack_walk() be defined outside the #ifdef block so BPF stack
walking continues to work when frame pointers are disabled?

If this is omitted, the kernel will fall back to the weak empty stub in
kernel/bpf/core.c, which causes bpf_prog_find_from_stack() to return NULL=20
and could make BPF diagnostic features silently fail.

> =20
>  void notrace walk_stackframe(struct task_struct *task,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722140015.1982=
158-1-varunrmallya@gmail.com?part=3D3
