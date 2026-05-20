Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592473DA5B6
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294555; cv=none; b=PSo3YWzCNbSIM/n+/p1IpKjc4lLAlfS6YfiVUmUDMgVybjfqkSLkqWd3Rt/MP0cm87+LQwlQuwXeimU/OqGevgVVB2NslFR/0e2FYY5W8cy+XGwGnbdrHhWtV6zl7ObJryQeD8OMxFvcXqMnWDSdpt9eNiIo1sLTNAjr+ox/O2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294555; c=relaxed/simple;
	bh=bNMI6shsEBS/HwQd3SI19kWxawK2B1eXxaycjHZBA5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a1glaHEMvuKqGenTptfXEHdTOzhocw1q2L+JEwh++Mjs7f5OcW+LFrQIrw1DPf3dKVoQ0zqb/N7CpJbTxhlGihop5Y/A+M2t415/SnIml4IK6BAk2bSvXoS7KkbBbFlkHv17ZX1cnh4uhnXH0L5tmndLFR02nqa4vbJ9tN3L+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGebrdTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGebrdTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A0F1F000E9;
	Wed, 20 May 2026 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294554;
	bh=haDWIoNr4hfRqRZCHiVtCe4BLGRY4pS+glLRwX/fofM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KGebrdTouEw8ZlMoxILp/OJ2MxWeOJu3B1opAWO4bV/dsDz8fWoKfFIOUWUTPjLhN
	 jyda12BEBeEO8EZbrc6fSIUh3VVVrdAWz7r9jjdwgmWNiDG40axe2iXawGPlipWCu0
	 9PVCz3HROg9XAwvjoAMtYXVs5hLcm9K2aJmWAnABa0wnyGhTTwt7mHkxwUr3sDCNEi
	 ElPXHkQC+rRPxYx2NIb1OYmMoeJVOfnq3a4lnVggf4EEM7LuEx9xldheYvhJxEPAuB
	 yITKvSXX1XxoVyi6IRs9YUq4m5/Ys7lSyJWK/QgUAel9jQC0d3gM3cjKBalZFeqGwT
	 b1aAEQ/HroB/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 03/20] unwind_user/sframe: Store .sframe section
 data in per-mm maple tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-4-jremus@linux.ibm.com>
References: <20260520154004.3845823-4-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:29:12 +0000
Message-Id: <20260520162914.13A0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Missing `MT_FLAGS_USE_RCU` during maple tree initialization causes=
 Use-After-Free of tree internal nodes.
- [High] Synchronous `kfree()` of `sframe_section` bypasses SRCU/RCU grace =
periods, causing Use-After-Free for concurrent readers.
- [Low] Undeclared identifier `sframe_srcu` causes build failure.
- [Low] Macro expansion of `INIT_MM_SFRAME` breaks compilation on non-x86 a=
rchitectures.
--

commit ce5ec4616b79b2c0aa851c150b33143b5d3876af
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Store .sframe section data in per-mm maple tree

Associate an .sframe section with its mm by adding it to a per-mm maple
tree which is indexed by the corresponding text address range. A single
.sframe section can be associated with multiple text ranges.

> diff --git a/include/linux/sframe.h b/include/linux/sframe.h
[ ... ]
> @@ -19,18 +21,31 @@ struct sframe_section {
>  	signed char	fp_off;
>  };
> =20
> +#define INIT_MM_SFRAME .sframe_mt =3D MTREE_INIT(sframe_mt, 0),

[Severity: High]
Does this maple tree need to be initialized with MT_FLAGS_USE_RCU?

Without it, the tree operates in non-RCU mode, so lockless iterations
might race with in-place node modifications and synchronous node frees,
potentially causing use-after-free of the internal nodes.

> diff --git a/kernel/fork.c b/kernel/fork.c
[ ... ]
> @@ -1073,6 +1075,13 @@ static void mmap_init_lock(struct mm_struct *mm)
>  #endif
>  }
> =20
> +static void mm_init_sframe(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> +	mt_init(&mm->sframe_mt);

[Severity: High]
Similar to MTREE_INIT above, does mt_init() need to use mt_init_flags()
with MT_FLAGS_USE_RCU here to prevent use-after-free during lockless reads?

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
[ ... ]
> +static int __sframe_remove_section(struct mm_struct *mm,
> +				   struct sframe_section *sec)
> +{
> +	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> +		dbg("mtree_erase failed: text=3D%lx\n", sec->text_start);
> +		return -EINVAL;
> +	}
> +
> +	free_section(sec);

[Severity: High]
Can this synchronous free cause a use-after-free for concurrent readers?

If an unwinder or other thread is iterating the tree locklessly and has
already obtained the section pointer before it is erased, freeing it
immediately here without waiting for an RCU or SRCU grace period would
pull the structure out from under them.

> +
> +	return 0;
> +}
> +
>  int sframe_remove_section(unsigned long sframe_start)
>  {
[ ... ]
> +	struct mm_struct *mm =3D current->mm;
> +	struct sframe_section *sec;
> +	unsigned long index =3D 0;
> +	bool found =3D false;
> +	int ret =3D 0;
> +
> +	guard(srcu)(&sframe_srcu);

[Severity: Low]
Is sframe_srcu defined anywhere? It doesn't appear to be declared in this
file or its headers, which would cause a build failure.

> diff --git a/mm/init-mm.c b/mm/init-mm.c
[ ... ]
> @@ -49,6 +50,7 @@ struct mm_struct init_mm =3D {
>  #endif
>  	.flexible_array	=3D MM_STRUCT_FLEXIBLE_ARRAY_INIT,
>  	INIT_MM_CONTEXT(init_mm)
> +	INIT_MM_SFRAME
>  };

[Severity: Low]
Can this cause compilation failures on non-x86 architectures?

If architectures like PowerPC or UML define INIT_MM_CONTEXT without a
trailing comma, placing INIT_MM_SFRAME (which expands to .sframe_mt =3D ...)
immediately after it might result in a missing-comma syntax error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D3
