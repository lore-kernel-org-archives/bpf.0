Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831E1FC7
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779338670; cv=none; b=qTGcciVQjkk5ekJ8i8LkmqcAZeSBaGmjsiv2WIJySeUHOAqpnM/zDFUZVy9FQHyJeW0Fl7l/DBUaqPITG2JbYQiP3DG1gbCZK+taqu8OZWIRwFMPok+XAQNcAJrV9FFrRbCnSsLWzmE4nI4vvN3+/hb6waTdJBwJMFxOTBfDeyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779338670; c=relaxed/simple;
	bh=WBRRSQvXMuJrAYRkYpkmHiaI+A3tycV4X0eADPzKMTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iGa6zRPbaVkiMCXlGG/qyK6G7e+iABUbkJAD/g1tolee9q6C+lzd/U43qLmFdy3fk0UQXBVnq8hLEU5uHm8lpyobBLR6u8K5jY+M5WX7H6a4QkFdpSeqO7BDG0gmYCpkfYVLm6sDMMQ8+3Z6SKWLzFWskxUlRXajHrQgoJQZc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZb0nfth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZb0nfth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67AB1F000E9;
	Thu, 21 May 2026 04:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779338668;
	bh=bcvwRcbFdU45j0XF3G73HfVxO0rfVyRZLp64eOPxoxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZb0nfth3A/1bhMA3Mqaa8ROBbRg51hWyPmJv6WEvir6wLXR+k5I/w4TWDermRJnh
	 f8tOrqbNNmwjuXJ6dAm6RP3x/J0txD/WRujS26fjq55UrlXP+To3cfhDpB0UtfNvn0
	 FDEqfdsL7i0dC1PxoN6R/7i8cRcf1RFaRXI5LCdLn2hl/37PD3CZzRHH5pDoMinNXR
	 i07y4jV2N7f2Q6h1KwoLZa6CttdglNo8SLlONLcs0Ec9IBZbGqe8TU30SPL/2PoCvc
	 cXZAzS8+qVQjEVD8dZaCDJvCfoqCjMmbI/lyd+6vDf/pTP8OjJ82RCI/dGHkHTNf14
	 00y3HOgjng58Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add kernel-doc for arena page kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dhiraj Shah" <find.dhiraj@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521043553.199781-1-find.dhiraj@gmail.com>
References: <20260521043553.199781-1-find.dhiraj@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 04:44:28 +0000
Message-Id: <20260521044428.A67AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The kernel-doc for bpf_arena_alloc_pages() incorrectly states that =
it returns a "Kernel pointer", when it actually returns a user-space virtua=
l address.
--

commit 8a97e4811ec22b9983c311e1250cbacc95c0359e
Author: Dhiraj Shah <find.dhiraj@gmail.com>

bpf: Add kernel-doc for arena page kfuncs

This patch adds kernel-doc comments for the BPF arena page-management
kfuncs. It also updates the documentation to render these blocks in a new
subsection within Documentation/bpf/kfuncs.rst.

[ ... ]

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef5..b8ec2953dee68 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -870,6 +870,33 @@ static void arena_free_irq(struct irq_work *iw)
> =20
>  __bpf_kfunc_start_defs();
> =20
> +/**
> + * bpf_arena_alloc_pages() - Allocate pages within a BPF arena.

[ ... ]

> + * The underlying allocator may sleep, so this kfunc is only callable fr=
om
> + * sleepable BPF programs.
> + *
> + * Return:
> + * * Kernel pointer to the start of the allocated region on success.

[Severity: Low]
Does this kfunc actually return a kernel pointer?=20

Looking at arena_alloc_pages(), it appears to return a user-space virtual
address derived directly from the arena's user_vm_start:

kernel/bpf/arena.c:arena_alloc_pages() {
        ...
        return clear_lo32(arena->user_vm_start) + uaddr32;
}

Additionally, the kernel-doc for bpf_arena_free_pages() added in this same
patch notes that the pointer is returned "in user-space form" by
bpf_arena_alloc_pages(). Should this documentation be updated to state that
it returns a user-space pointer rather than a kernel pointer?

> + * * %NULL if @p__map is not an arena, @flags is non-zero, @page_cnt is =
zero
> + *   or exceeds the arena size, @addr__ign is misaligned or outside the
> + *   arena, @node_id is invalid, or the kernel is out of memory.
> + */
>  __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u=
32 page_cnt,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521043553.1997=
81-1-find.dhiraj@gmail.com?part=3D1
