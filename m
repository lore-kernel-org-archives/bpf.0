Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA619242D72
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985617; cv=none; b=UW7Qy4+aDhP1ZvJ3Apd9cDatGto0XmP4dYtnnWWUR3HGpZKQujoYRiO1WzlHkJSksTVSNGA1N0eA9nkomHLk3pXl49eRHUINdWscBVBpt49h8gexYFtQBpyU0fPS7giHz2ZH9JVRUMkZ4pUjriczyNVB8c5mwv9cCgaIMdKzToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985617; c=relaxed/simple;
	bh=zuj4Yr23PJ0UKZfcFRe5I6jNMxUuBafQfs90DMeszlw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FkJjz1ZrvpqnMETdBEcfbbZu5Su2tgfREPf+6iHvHn0I5xacWj24ioHp1ddqdWr0PFkvZKbsptNbdBADriuUA+45jofSv5ssJiW/sW22Hu9zBqeRzm79MZ3JunQbeNkNlChYaM5zq6FqDdzI0Ck3y9SO37ijYGbAZDMDJ+V2Ww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8iwjjZJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8iwjjZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A36C2BCB4;
	Tue,  5 May 2026 12:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777985616;
	bh=zuj4Yr23PJ0UKZfcFRe5I6jNMxUuBafQfs90DMeszlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=J8iwjjZJwhJWtcD4WXWfPJiFtDmds9kpCo5NFyvCjPlqRciQgPGyIbE3uVvZ4ZqAw
	 EgD/c5+oJ1Z9XKhGfkLG9L18DeOKIkBZOGztkRqFDvuB3JK4f8ScyHyvwybAbTyPGx
	 rKj8G0sndzvS1JkVLJB53VFIMnZQYwCmY247zO4I6JdolU5CVRRmddBxIrJzRO+hA1
	 tXheKzg3apqjfCpKBgd1WUskRHtZo5sBatCAc5XGui5VyL5TyzQaLez/w/X3hG+aVz
	 DhCoqQVfaPQJYSm/38ypQFtwUxiJu2/du4Zahi19BDkcjoxEXj9w/jCd7hUwrkmaeG
	 NjS6q+Xft3tmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/19] unwind_user/sframe: Detect .sframe sections
 in executables
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-7-jremus@linux.ibm.com>
References: <20260505121718.3572346-7-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 12:53:35 +0000
Message-Id: <20260505125336.72A36C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `PT_LOAD` segment type check when registering executable s=
ections for sframe unwinding.
- [High] Off-by-one error in maple tree insertion bounds causes adjacent ex=
ecutable segments to fail registration.
--

commit 610ebc2ab2a7fd5ae4cd4a346076c9d5c2acc195
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Detect .sframe sections in executables

When loading an ELF executable, automatically detect an .sframe section
and associate it with the mm_struct.

> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 16a56b6b3f6ca..55047659a3cf4 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
[ ... ]
> @@ -637,6 +638,21 @@ static inline int make_prot(u32 p_flags, struct arch=
_elf_state *arch_state,
>  	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
>  }
> =20
> +static void elf_add_sframe(struct elf_phdr *text, struct elf_phdr *sfram=
e,
> +			   unsigned long base_addr)
> +{
> +	unsigned long sframe_start, sframe_end, text_start, text_end;
> +
> +	sframe_start =3D base_addr + sframe->p_vaddr;
> +	sframe_end   =3D sframe_start + sframe->p_memsz;
> +
> +	text_start   =3D base_addr + text->p_vaddr;
> +	text_end     =3D text_start + text->p_memsz;

Should text_end be calculated as text_start + text->p_memsz - 1?

Since the maple tree API strictly expects inclusive ranges [first, last] fo=
r=20
insertions, passing the exclusive text_end would cause the inserted range=20
to cover one byte beyond the actual segment.

If an ELF binary has adjacent executable PT_LOAD segments, could the first=
=20
segment's inclusive end overlap with the next segment's start and fail=20
subsequent insertions?

> +
> +	/* Ignore return value, sframe section isn't critical */
> +	sframe_add_section(sframe_start, sframe_end, text_start, text_end);
> +}
> +
[ ... ]
> @@ -712,6 +729,19 @@ static unsigned long load_elf_interp(struct elfhdr *=
interp_elf_ex,
>  				error =3D -ENOMEM;
>  				goto out;
>  			}
> +			break;
> +		}
> +		case PT_GNU_SFRAME:
> +			sframe_phdr =3D eppnt;
> +			break;
> +		}
> +	}
> +
> +	if (sframe_phdr) {
> +		eppnt =3D interp_elf_phdata;
> +		for (i =3D 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
> +			if (eppnt->p_flags & PF_X)
> +				elf_add_sframe(eppnt, sframe_phdr, load_addr);

Does this need to verify the segment is loadable (eppnt->p_type =3D=3D PT_L=
OAD)?

If non-loadable segments like PT_GNU_STACK have the PF_X flag set, they
typically have p_vaddr and p_memsz as 0. Processing these segments would
compute bogus text boundaries and bypass VMA validation. If a legitimate
PT_LOAD segment overlaps with these bogus ranges, could its insertion fail
silently and break stack unwinding for the executable?

>  		}
>  	}
> =20
[ ... ]
> @@ -1242,6 +1276,14 @@ static int load_elf_binary(struct linux_binprm *bp=
rm)
>  			elf_brk =3D k;
>  	}
> =20
> +	if (sframe_phdr) {
> +		for (i =3D 0, elf_ppnt =3D elf_phdata;
> +		     i < elf_ex->e_phnum; i++, elf_ppnt++) {
> +			if ((elf_ppnt->p_flags & PF_X))
> +				elf_add_sframe(elf_ppnt, sframe_phdr, load_bias);

Similarly, should this also check if the segment is a PT_LOAD segment befor=
e=20
adding it to the sframe sections?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D6
