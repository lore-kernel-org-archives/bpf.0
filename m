Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91B34250D
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985388; cv=none; b=gxfKZNsQ35z+2idY7yRnrcq0UaLNyPp5T4b83cGuyX2ZJSnze7/vad97w3P1LuRqJlAjLAQZHAfnOuzULApuEpYt8s/QYsYH1PUeotjXnJ3QA7OaYpba8DRUtjRFTX1OMSKb6KuPalJCoTCNtEpa9AeaUkRLQ4wIImJk3KXOZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985388; c=relaxed/simple;
	bh=jG+JayU0NiOJchomLTK5WSAt2BuNGCFnbzEKeRi7r20=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iP91J6SiF8xWS80/d8bcPg4/Dp6TXhz0IGQZJCMcUXoj4fV2CISzIdefajfeDm7ytwvW4DbOIlzkrzHN+FuzfrdqLd34eYAnupvQURh5fEqgf9ABY9Ib+1AAZm5fWjJ2+vj3vO5cgf7jm3QtSUlextid7YB8CV5wDyI3/7RxoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baPe5rau; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baPe5rau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669E2C2BCB4;
	Tue,  5 May 2026 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777985388;
	bh=jG+JayU0NiOJchomLTK5WSAt2BuNGCFnbzEKeRi7r20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=baPe5rauYuRvLsCIGxFpDP46BgNiO+gCM+qGG1WR8bggAsKbz3sECn9sxi3P6LwBA
	 EynzyQlHYXL0HE/We21fj67KRUyhzd3H9IiUu8VB+ybCCcDYHGoj7y6NeKNcCN7GOG
	 I5RDbwmdjpMQxvTMuOVGScmATGI893TjdOXyzLO430cAEZiGnV0kwgCjpqCHgHtgou
	 dgQ1YeuHs7oNEUiumPmLWk66hY9MNurqf07PPfMiRSwfRtwhqMS4Cy0mGaA22Z8AHV
	 S2igY7G7JxKkFgx5jlAJGzXtSsYtwnapG6DMzQnFSta1cKL8qzvA3+1xw+JSFiSYKo
	 IlGCes4O0iQ0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/19] unwind_user/sframe: Add support for reading
 .sframe headers
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-3-jremus@linux.ibm.com>
References: <20260505121718.3572346-3-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 12:49:46 +0000
Message-Id: <20260505124948.669E2C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing validation of shdr.abi_arch allows parsing SFrame data f=
rom mismatched architectures.
- [Medium] VMA addresses are incorrectly evaluated as boolean flags to chec=
k for zero-length inputs.
- [Low] Mixing goto error handling with scoped_guard scope-based cleanup.
--

commit afe7c9eb6f0e6fc3f73d0b6a555f8d3926cf6ccf
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Add support for reading .sframe headers

This commit introduces basic infrastructure for unwinding user space stacks
with SFrame. It adds support for parsing the .sframe section header.

Link: https://lore.kernel.org/all/f27e8463783febfa0dabb0432a3dd6be8ad98412.=
1737511963.git.jpoimboe@kernel.org/

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> new file mode 100644
> index 0000000000000..c128c1eeaca20
> --- /dev/null
> +++ b/kernel/unwind/sframe.c
[ ... ]
> +static int sframe_read_header(struct sframe_section *sec)
> +{
> +	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
> +	struct sframe_header shdr;
> +	unsigned int num_fdes;
> +
> +	if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr=
))) {
> +		dbg("header usercopy failed\n");
> +		return -EFAULT;
> +	}
> +
> +	if (shdr.preamble.magic !=3D SFRAME_MAGIC ||
> +	    shdr.preamble.version !=3D SFRAME_VERSION_3 ||
> +	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> +	    !(shdr.preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
> +	    shdr.auxhdr_len) {
> +		dbg("bad/unsupported sframe header\n");
> +		return -EINVAL;
> +	}

Should we also validate shdr.abi_arch to ensure it matches the expected
architecture?

If malformed or foreign-architecture SFrame data is passed in (for instance,
with an unexpected endianness or register mapping), the kernel might interp=
ret
it incorrectly and generate invalid stack traces.

Furthermore, accepting arbitrary values here could risk ABI calcification if
userspace starts supplying invalid values that we later want to reject.

[ ... ]
> +int sframe_add_section(unsigned long sframe_start, unsigned long sframe_=
end,
> +		       unsigned long text_start, unsigned long text_end)
> +{
> +	struct vm_area_struct *sframe_vma, *text_vma;
> +	struct mm_struct *mm =3D current->mm;
> +	struct sframe_section *sec;
> +	int ret;
> +
> +	if (!sframe_start || !sframe_end || !text_start || !text_end) {

Is it safe to use VMA start addresses as boolean flags?

Since vm_start can legitimately be zero in certain configurations (if
mmap_min_addr permits), evaluating !sframe_start or !text_start could
incorrectly reject perfectly valid mappings at address 0.

Also, to check for zero-length sections, would it be better to explicitly u=
se
comparisons like sframe_start >=3D sframe_end instead?

> +		dbg("zero-length sframe/text address\n");
> +		return -EINVAL;
> +	}
> +
> +	scoped_guard(mmap_read_lock, mm) {
[ ... ]
> +	sec =3D kzalloc(sizeof(*sec), GFP_KERNEL);
> +	if (!sec)
> +		return -ENOMEM;
> +
> +	sec->sframe_start	=3D sframe_start;
> +	sec->sframe_end		=3D sframe_end;
> +	sec->text_start		=3D text_start;
> +	sec->text_end		=3D text_end;
> +
> +	ret =3D sframe_read_header(sec);
> +	if (ret)
> +		goto err_free;

Is it acceptable to mix goto error handling with scoped_guard() cleanup
helpers in the same function?

The kernel's cleanup subsystem guidelines generally suggest that usage of
goto and cleanup helpers shouldn't be mixed in the same routine.

Could sec be allocated using __free(kfree) to avoid the goto entirely?

> +
> +	/* TODO nowhere to store it yet - just free it and return an error */
> +	ret =3D -ENOSYS;
> +
> +err_free:
> +	free_section(sec);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D2
