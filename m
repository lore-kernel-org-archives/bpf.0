Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520236403C
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293743; cv=none; b=p0BLUq+DqCpg3u+q9A5OfJRSPgtEjQZlMy5njz/nI+vAwbuSw82Ioydh2myT0AT/sv3BsEkeGY7AA5Stq8TRkIPGybL0plKVo82IHkgbnUOTUWmqyb2Sy0tTy/X4Q4cVhBmgpNSjUGZQoMcymITK64/lx0Tza05RNE8cYqf5qd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293743; c=relaxed/simple;
	bh=a1zA5OT6wlwxqNwtmhesrYoLRggxs+x2/SlbZKRt4uU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tDWP3lzAsGSUqYBpiaVnF4RImuwpVXO5Kv5v1nWpQNHuZ5fWw1v634k806LykxSuCkyD+irmqwnyV/ndKS1PIUl8h3HmUQowpd+z336Y7XEEJBJD7KW6i6hyar9hAW8AmISPV0sFa43paglpyAu/X/Bmt2LwSSNAShlfJ3g/Mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+jYl3Ld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+jYl3Ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690781F000E9;
	Wed, 20 May 2026 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779293741;
	bh=0UkXOkEpphEo53T4ramDaETbasdsSbMw98+grDGrZ9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m+jYl3LdvBWHYJJx8ct0L0TseupjNI9gxlNDGjTR+gvXuZlsl6fKCfKpggmhdWvAu
	 8QNtSL8RKeovuyySE4E5Bu4VmyKLbW3U+Pegvm6rEcWqYJFs9tUj65fU2lIBw9jX8I
	 jEHSEt/FbD3XVyeGFDpmprzBKTo+WekY2nzODBK5WrH1a/rsdowh2urjft/va/SiYS
	 m5ttNJF/hJyo5PkQzSPrVsTER7rC7qtZmXhki2UZpaJOUD4Hp9moEDVtG8KFYctBx+
	 RxTerutwatX1tB4grme+CdB5KQpNnN050s33xxB+I4JNBPVK7FN1UoQMLjOPbDa7uW
	 t90igM+nh3L8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 12/20] unwind_user/sframe: Add .sframe validation
 option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-13-jremus@linux.ibm.com>
References: <20260520154004.3845823-13-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:15:30 +0000
Message-Id: <20260520161541.690781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing cond_resched() or fatal signal checking in the nested loop=
s of sframe_validate_section() allows an unprivileged local attacker to tri=
gger a CPU soft lockup.
- [Low] The validation logic in sframe_validate_section() incorrectly rejec=
ts a valid .sframe section if the first function is located at virtual addr=
ess 0.

Pre-existing issues:
- [High] sframe_find() handles read failures by calling sframe_remove_secti=
on(), which acquires a lock inside NMI or IRQ context, leading to deadlocks=
 or PREEMPT_RT panics.
--

commit 07d74be031cf9fade2b9ddd98bfdd8f52c38c2da
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Add .sframe validation option

This commit introduces a debugging feature to optionally validate the
entire .sframe section upon loading, rather than checking on-demand.
It uses user_read_access_begin/end to read FDEs and FREs to verify their
formatting and sorting.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
[ ... ]
> int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
> {
[ ... ]
> 	ret =3D __find_fre(sec, &fde, ip, frame);
> end_uaccess:
> 	user_read_access_end();
>=20
> end:
> 	if (ret && ret !=3D -ENOENT) {
> 		dbg_sec("removing bad .sframe section\n");
> 		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
> 	}
>=20
> 	return ret;
> }

[Severity: High]
This isn't a bug introduced by this patch, but does calling
sframe_remove_section() here risk a deadlock or panic on PREEMPT_RT?

If a page fault occurs during user memory access, unsafe_copy_from_user()
returns -EFAULT to prevent sleeping.

However, sframe_find() handles any error other than -ENOENT by calling
sframe_remove_section(), which in turn calls mtree_erase().

Since mtree_erase() takes an internal spinlock, doing this in NMI context
(where sframe_find() is often called) can deadlock or panic a PREEMPT_RT
kernel, while also permanently deleting a valid unwind section due to
transient memory pressure.

[ ... ]
> +#ifdef CONFIG_SFRAME_VALIDATION
[ ... ]
> +static int sframe_validate_section(struct sframe_section *sec)
> +{
> +	unsigned long prev_ip =3D 0;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < sec->num_fdes; i++) {
> +		struct sframe_fre_internal *fre, *prev_fre =3D NULL;
> +		unsigned long ip, fre_addr;
> +		struct sframe_fde_internal fde;
> +		struct sframe_fre_internal fres[2];
> +		bool which =3D false;
> +		unsigned int j;
> +		int ret;
> +
> +		ret =3D safe_read_fde(sec, i, &fde);
> +		if (ret) {
> +			dbg_sec("safe_read_fde(%u) failed\n", i);
> +			return ret;
> +		}
> +
> +		ip =3D fde.func_addr;
> +		if (ip <=3D prev_ip) {

[Severity: Low]
Does this check accidentally reject valid sections where the first
function is located at virtual address 0?

Since prev_ip is initialized to 0, validating the first FDE when ip is 0
will cause this check to evaluate to true, falsely triggering an -EINVAL.

Valid executables can map their text section at 0 if vm.mmap_min_addr is
set to 0.

> +			dbg_sec("FDE %u not sorted\n", i);
> +			return -EINVAL;
> +		}
> +		prev_ip =3D ip;
> +
> +		fre_addr =3D sec->fres_start + fde.fres_off;
> +		for (j =3D 0; j < fde.fres_num; j++) {
[ ... ]
> +			fre_addr +=3D fre->size;
> +
> +			if (prev_fre && fre->ip_off <=3D prev_fre->ip_off) {
> +				dbg_sec("FDE %u: FRE %u not sorted\n", i, j);
> +				return -EINVAL;
> +			}
> +
> +			prev_fre =3D fre;
> +		}

[Severity: High]
Could a malicious user exploit these loops to trigger a CPU soft lockup?

The variables sec->num_fdes and fde.fres_num are user-controlled and
bounded only by the VMA size.

Without a cond_resched() or fatal signal check, an attacker could supply
large counts and cause these loops to run for seconds without yielding.

On non-preemptible kernels, this monopolizes the CPU and triggers the soft
lockup watchdog, resulting in a local denial of service.

> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D12
