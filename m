Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072A3D8104
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296475; cv=none; b=s8BeJa+zo+yULRnTdSK49lDDeoZ3qgQ+gdIhaqWohBgoN8AyhmZucu8wxcTXPQtVuq1/kbWRkepN5cdvuiHFWSmCiexbV+Q8U5h0lE+Qjm9MHJRfuv+6G3MG3L7aTzgVXPsUADLkJriMEnjnKBAmONMP0RvUmEEnhUJfGTRQum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296475; c=relaxed/simple;
	bh=Le0Ub96CiIXHq22RcwhDSYQ1lcF6cnpCYcMNT8APP2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e01pHQfiteTBuXSZYs4JNTcr541VShQpTgd/Ymw2/p2lH4EANLCxuIWFhJZgUAPj8nuNSdKtWRxW3Eh9ZjZReCmIrg5aZqYoEBCSUVbs4ctlYjRKpDz//FYWZJuVbhB3JCbZBZOwYRMlGsQATDNiQQYHnKsXywjpNHcsuub1KRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGFu+XFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGFu+XFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AA41F00893;
	Wed, 20 May 2026 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779296472;
	bh=lWjoGYGv42nyl/m48DPrMELFW/3JHdSSCfg5FnJaDX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iGFu+XFNA99sg3+wCCiPUhguFxmwm7sTTmdF75G2ChsdaFOu3ri/1kDzVAoJqAT94
	 MIPwS7S47CPuJV854ZQ92Fi0z8V0fv4jOaTd8bI8roDB/S0EQX77HyuRzVKy7KCJrm
	 cvMPsSR8NYXGWVxv/gKr4Wu/t4xNvMjrAN/qP7acZwv97xxtpJ476tD3xr/kxJBvqM
	 BgQigMduXuHtFfG+iF5DMq+dG+UVzgumJc8K751OuecRR4QK/SQdFcYa14KMBqHxeb
	 mUxjfPPUoUaFo1wT5NQuhWLC4k3AZB5NK2T0PhA05X06yfhz6uUbGucLGQ6LnkUm5z
	 QHr7cBWQ535IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 18/20] unwind_user/sframe: Duplicate registered
 .sframe section data on clone/fork
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-19-jremus@linux.ibm.com>
References: <20260520154004.3845823-19-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 17:01:12 +0000
Message-Id: <20260520170112.A8AA41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Mixing goto-based error handling with guard() scope-based cleanu=
p in sframe_dup_mm().
- [Low] Redundant #ifdef blocks around sframe functions in dup_mmap().
--

commit 06e12a491c0dc4cc93fac24f7de9fe0b02b9a9e0
Author: Jens Remus <jremus@linux.ibm.com>
Subject: unwind_user/sframe: Duplicate registered .sframe section data on c=
lone/fork

When duplicating a process' virtual memory mappings also duplicate all
of its registered .sframe sections stored in the per-mm maple tree to
enable stacktracing using sframe of the child process.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index ec8318977a2ef..0661090dd5bcd 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
[ ... ]
> @@ -886,6 +886,54 @@ int sframe_remove_section(unsigned long sframe_start)
[ ... ]
> +int sframe_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
> +{
> +	struct sframe_section *sec, *oldsec;
> +	unsigned long index =3D 0;
> +	int ret;
> +
> +	guard(srcu)(&sframe_srcu);
> +
> +	mt_for_each(&oldmm->sframe_mt, oldsec, index, ULONG_MAX) {
> +		sec =3D kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);
> +		if (!sec)
> +			return -ENOMEM;
> +
> +		__sframe_dup_section(sec, oldsec);
> +
> +		ret =3D mtree_insert_range(&mm->sframe_mt,
> +					 sec->text_start,
> +					 sec->text_end - 1,
> +					 sec, GFP_KERNEL_ACCOUNT);
> +		if (ret)
> +			goto err_free;

[Severity: Medium]
Is it intentional to mix goto-based error handling with scope-based cleanup
in the same function?

The cleanup subsystem guidelines recommend against mixing goto labels and
guard declarations to prevent confusing ownership semantics and lifecycle
bugs. Would it be better to drop the err_free label entirely and explicitly
call free_section(sec) followed by returning ret directly inside this block?

> +	}
> +
> +	return 0;
> +
> +err_free:
> +	free_section(sec);
> +	return ret;
> +}
[ ... ]
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2311ae7c2ff45..d5aa8c54f8c1c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
[ ... ]
> @@ -1846,6 +1847,11 @@ __latent_entropy int dup_mmap(struct mm_struct *mm=
, struct mm_struct *oldmm)
>  	}
>  	/* a new mm has just been created */
>  	retval =3D arch_dup_mmap(oldmm, mm);
> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> +	if (!retval) {
> +		retval =3D sframe_dup_mm(mm, oldmm);
> +	}
> +#endif

[Severity: Low]
This isn't a bug, but are these preprocessor guards necessary?

Since include/linux/sframe.h already provides static inline dummy versions
of sframe_dup_mm() and sframe_free_mm() when CONFIG_HAVE_UNWIND_USER_SFRAME
is disabled, these conditional blocks could potentially be removed to keep
the C source code cleaner.

>  loop_out:
>  	vma_iter_free(&vmi);
>  	if (!retval) {
[ ... ]
> @@ -1893,6 +1899,9 @@ __latent_entropy int dup_mmap(struct mm_struct *mm,=
 struct mm_struct *oldmm)
>  			vm_unacct_memory(charge);
>  		}
>  		__mt_destroy(&mm->mm_mt);
> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> +		sframe_free_mm(mm);
> +#endif

[Severity: Low]
This isn't a bug, but similarly, could this block be dropped since the dummy
stub handles the disabled case without needing explicit conditionals?

>  		/*
>  		 * The mm_struct is going to exit, but the locks will be dropped
>  		 * first.  Set the mm_struct as unstable is advisable as it is

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D18
