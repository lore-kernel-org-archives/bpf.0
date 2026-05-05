Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5665492182
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006798; cv=none; b=XLaHgM2EIikIaDYXT1NhGakrZ0w3xi9CusLlOo7ZrIeJNEgfoyCZMHuV436rm8m2RC6oy6PQiufIUfDAcgIkxfLqzSZG6NRx9e4PItN5xkBPV2cHfPuCPeWFAvABwR/8FsQ95qw9Jqm1aDdeSPfezH5MwPIn54/K5rpVe0ZkOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006798; c=relaxed/simple;
	bh=PKxmz5JC6CFp96LM1l8k/KVrXqAYYMPzNh9IPKpgoU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aSBT4UPamSdf/l+q7uWgUysYYyloBGZckyqUABh1Muvll2JxCx5gWnHtIVBRbqNzld/4MqLI5GPl2xIjW3icdi34Fj/EX/jVGSn4uxWSP4NqWtN1DIb6zaffYYAlJCOchx5Ah55V+sf5aGSy4Ps0+6RODhCQkw+dBe/XBrXiwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvT6a3Jy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvT6a3Jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5648DC2BCB4;
	Tue,  5 May 2026 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778006798;
	bh=PKxmz5JC6CFp96LM1l8k/KVrXqAYYMPzNh9IPKpgoU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BvT6a3JyID+2AYrdEyvIdD6vaOl/T1Kz4/Cv2XkhgS/Gu1zEQAZg7Rbp2nxDoYJmR
	 rJlNfOCrWwBC87Yy9ZdRvg5yFM+vNjBLMZ2GiTc0xjD9aagSNjnmg3KOjv4U+G0jRb
	 uiQ3XzAQto1aMUOAwyabhTcMRTDHdhK9Y3P+y63dx3cS+B1FgfmW27RJI66OLCxcF8
	 LWy0cIy4vP3d/ctWvOASn+SfqNIF25ZcD8EjZk313FlbJj8prHHc/xyPYncj5dZAN3
	 DbQ7eaZhAI64I4+ga1a/nSl3WijELSrXTmhZcO50KQjmFVSyI/iiSRK4fuVC7w3NjO
	 /KlLFH1+kq0Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 11/19] unwind_user/sframe: Show file name in debug
 output
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-12-jremus@linux.ibm.com>
References: <20260505121718.3572346-12-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:46:37 +0000
Message-Id: <20260505184638.5648DC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Potential use-after-free of `sec` and `sec->filename` in the error=
 path of `__sframe_remove_section`.
- [High] A race condition in the `-EFAULT` error path of `sframe_find()` al=
lows an unprivileged local attacker to trigger a `WARN_ON_ONCE` and potenti=
ally panic the kernel.
- [High] Unbounded kernel memory allocations controlled by user space do no=
t use `__GFP_ACCOUNT`, allowing memory cgroup limit bypass.
- [Medium] dbg_init() fails to fall back to other VMA naming methods if vma=
->vm_ops->name(vma) returns NULL.
- [Medium] Directly checking `vma->vm_file` in a conditional to classify th=
e VMA violates VMA architectural rules.
- [Medium] The functions `sframe_find()` and `sframe_add_section()` mix sco=
pe-based cleanup helpers with manual `goto`-based cleanup labels, violating=
 kernel refactoring guidelines.
--

commit d6a437647b4507fcb6d70115c0d08b1d68cafa8a
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Show file name in debug output

This commit adds the file name to debug output messages for sframe sections
to make debugging easier. It records the filename when the section is added
by inspecting the associated VMA.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 8eed6a7d96256..4419626f01734 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -359,14 +359,17 @@ int sframe_find(unsigned long ip, struct unwind_use=
r_frame *frame)
>  end:
>  	user_read_access_end();
> =20
> -	if (ret =3D=3D -EFAULT)
> +	if (ret =3D=3D -EFAULT) {
> +		dbg_sec("removing bad .sframe section\n");
>  		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
> +	}

Can concurrent executions of this error path trigger the WARN_ON_ONCE()? If
two threads hit the EFAULT path concurrently, the first successfully removes
the section, but the second fails to find it and returns EINVAL, which
triggers the warning.

Also, does this code mix goto-based error handling with scope-based cleanup
helpers? The sframe_find() function uses guard(srcu)(&sframe_srcu) while
also using the goto end label. The sframe_add_section() function similarly
mixes scoped_guard with goto. The guidelines specify that functions should
convert all resources to scope-based cleanup or convert none of them.

[ ... ]
> @@ -496,7 +501,7 @@ static int __sframe_remove_section(struct mm_struct *=
mm,
>  				   struct sframe_section *sec)
>  {
>  	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> -		dbg("mtree_erase failed: text=3D%lx\n", sec->text_start);
> +		dbg_sec("mtree_erase failed: text=3D%lx\n", sec->text_start);

Does accessing sec->filename in dbg_sec() risk a use-after-free here? If
mtree_erase() fails, it indicates the section might have been concurrently
removed. The SRCU grace period could expire, causing sec to be freed before
dbg_sec() is called.

[ ... ]
> diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
> index 36352124cde81..e568be4172b1b 100644
> --- a/kernel/unwind/sframe_debug.h
> +++ b/kernel/unwind/sframe_debug.h
[ ... ]
> +static inline void dbg_init(struct sframe_section *sec)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	struct vm_area_struct *vma;
> +
> +	guard(mmap_read_lock)(mm);
> +	vma =3D vma_lookup(mm, sec->sframe_start);
> +	if (!vma)
> +		sec->filename =3D kstrdup("(vma gone???)", GFP_KERNEL);
> +	else if (vma->vm_file)
> +		sec->filename =3D kstrdup_quotable_file(vma->vm_file, GFP_KERNEL);

Does checking vma->vm_file directly skip proper classification for some
anonymous VMAs? According to the VMA guidelines, certain anonymous VMAs like
private mappings of /dev/zero have vma->vm_file set. Should this use
!vma_is_anonymous(vma) instead?

Do these string allocations need __GFP_ACCOUNT? Since they are triggered by
user space and persist until the section is removed, could a user allocate
large amounts of uncharged memory and bypass memory cgroup limits?

> +	else if (vma->vm_ops && vma->vm_ops->name)
> +		sec->filename =3D kstrdup(vma->vm_ops->name(vma), GFP_KERNEL);

If vma->vm_ops->name(vma) returns NULL, will kstrdup() return NULL and skip
the subsequent fallback naming methods? Does this leave sec->filename as
NULL, causing debug logs to print (null)?

> +	else if (arch_vma_name(vma))
> +		sec->filename =3D kstrdup(arch_vma_name(vma), GFP_KERNEL);
> +	else if (!vma->vm_mm)
> +		sec->filename =3D kstrdup("(vdso)", GFP_KERNEL);
> +	else
> +		sec->filename =3D kstrdup("(anonymous)", GFP_KERNEL);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D11
