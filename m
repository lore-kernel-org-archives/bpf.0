Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036D3BE632
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007573; cv=none; b=NtCoww5tnTTPb+Osigek/V44yaPte1uP2wb8/UQaPNBTODcrgqifv0bHI3VT8whLGyZSo9hwW8H/Pc3fn/djQsSAMSwVM5o8X47iCVNquUt+IBi7WalqUZf7wy2seLwF63zHByY4+ydolin5/UNwiapuGZUZ0iwGqs+fFKB5Xvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007573; c=relaxed/simple;
	bh=YLB+Fml/+YB9uzd5Ggm/gkGNijcXlstV+lyDy2kHGi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xk6FTQFD8hc+VQHEX4Fk9/+Yse1XMgZn/W8nizbvf8l5auCjoaYRXroRwozJ2ePPOpjCwkBELN8cmCoDrv2e+0R1CqsD0qS0X7GiksVYUIg+8K7MQSXogy8Qx9oaKCSXgmy37n7UlFlTmweyqDuU80Hjma6zBZKpL18IbFITSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLBAZAER; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLBAZAER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C708CC2BCB4;
	Tue,  5 May 2026 18:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778007572;
	bh=YLB+Fml/+YB9uzd5Ggm/gkGNijcXlstV+lyDy2kHGi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gLBAZAEROApyb4gjjqmICM3rtd12XbD/hQxrR3RlQSCZm81MVhBUYKtUFYvsvBumF
	 912DdBwJtH5aZt0kwOQqDfFCXwnMaGIdQVDyLbFpHrrsdqeBDqvZUDyGD4d1ipE8st
	 SAoWprFodGlCHFL4KQDHrYtqonG+CzYpx1ZnEReHWGzlcHKHF4eOIZlQ4156zltTiB
	 NbEF5b25iAbw+WqPCb7f1VR7mXFVbKDQmVOpalzkKZSwhU5/KJKnGro653PmVoywbv
	 x2SbKL6YujCV9VVkbp9rv5s4h96RZSOi0Kco6Q3u7A0SV2L0LipRmlsSkAC/BKW1WU
	 4X0+wEAG2SdkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/19] unwind_user/sframe: Add support for reading
 .sframe contents
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-6-jremus@linux.ibm.com>
References: <20260505121718.3572346-6-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:59:32 +0000
Message-Id: <20260505185932.C708CC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Division by zero in `__find_fre` when `fde->rep_size` is 0.
- [High] `mtree_insert_range` is called with an exclusive end boundary, pre=
venting contiguous SFrame sections.
- [High] Unbounded linear search over user-controlled memory in `__find_fre=
` can cause hard lockups in atomic context.
- [High] Integer overflows in SFrame header parsing allow bypass of bounds =
checks on 32-bit architectures.
- [Medium] Generic SFrame unwinding code uses `unsafe_get_user()` for unali=
gned accesses, breaking strict-alignment architectures.
--

commit 159c92acf3c961aecc6383f6c3f35a955591abf3
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Add support for reading .sframe contents

This commit adds support for reading .sframe section contents to facilitate
user space stack unwinding. It introduces the sframe_find() interface which
uses user_read_access_begin() and unsafe_*() accessors for performance.
Support is included for SFrame V3, internal FDE representations, and
PC-relative offsets.

Link: https://lore.kernel.org/all/77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.=
1737511963.git.jpoimboe@kernel.org/
Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linu=
x.ibm.com/

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index fdb2a49085638..c60aa527984a1 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -15,9 +15,338 @@
>  #include <linux/unwind_user_types.h>
> =20
>  #include "sframe.h"
> +#include "sframe_debug.h"

[ ... ]

> +static __always_inline int __read_fre(struct sframe_section *sec,
> +				      struct sframe_fde_internal *fde,
> +				      unsigned long fre_addr,
> +				      struct sframe_fre_internal *fre)
> +{
[ ... ]
> +	if (fre_addr + addr_size + 1 > sec->fres_end)
> +		return -EFAULT;
> +
> +	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);

Will this cause alignment faults on architectures with strict alignment
requirements?

The .sframe format uses packed structures and variable-length datawords. The
cur pointer might be unaligned here, and UNSAFE_GET_USER_INC() performs
16-bit or 32-bit reads via unsafe_get_user().

[ ... ]

> +static __always_inline int __find_fre(struct sframe_section *sec,
> +				      struct sframe_fde_internal *fde,
> +				      unsigned long ip,
> +				      struct unwind_user_frame *frame)
> +{
> +	unsigned char fde_pctype =3D SFRAME_V3_FDE_PCTYPE(fde->info);
> +	struct sframe_fre_internal *fre, *prev_fre =3D NULL;
> +	struct sframe_fre_internal fres[2];
> +	unsigned long fre_addr;
> +	bool which =3D false;
> +	unsigned int i;
> +	u32 ip_off;
> +
> +	ip_off =3D ip - fde->func_addr;
> +
> +	if (fde_pctype =3D=3D SFRAME_FDE_PCTYPE_MASK)
> +		ip_off %=3D fde->rep_size;

Can a malicious user provide an SFrame section with a rep_size of 0?

Since fde->rep_size is populated directly from the user-provided
_fda.rep_size without validation, a 0 value here would trigger a
divide-by-zero exception and a kernel panic.

> +
> +	fre_addr =3D sec->fres_start + fde->fres_off;
> +
> +	for (i =3D 0; i < fde->fres_num; i++) {

Can this loop cause a hard lockup in atomic context?

fde->fres_num is a 32-bit value copied from user space without validation.
Since sframe_find() is designed to be called by unwinders in NMI context, an
attacker could provide a very large number of valid entries. Executing
billions of iterations and unsafe_get_user() calls could stall the CPU
and trigger the hard lockup detector.

> +		int ret;
> +

[ ... ]

> @@ -120,8 +449,10 @@ int sframe_add_section(unsigned long sframe_start, u=
nsigned long sframe_end,
>  	sec->text_end		=3D text_end;
> =20
>  	ret =3D sframe_read_header(sec);
> -	if (ret)
> +	if (ret) {
> +		dbg_print_header(sec);
>  		goto err_free;
> +	}

Can shdr.fre_len cause an integer overflow on 32-bit architectures during
header parsing?

If a malicious user provides a large fre_len in the header, fres_end
(calculated as fres_start + shdr.fre_len) could wrap around the 32-bit
address space. This would bypass the bounds check in sframe_read_header(),
allowing fres_start and fdes_start to point into kernel memory. Later, when
__read_fde() and __find_fre() use unsafe_get_user(), this could lead to
arbitrary kernel memory disclosure.

> =20
>  	ret =3D mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, s=
ec, GFP_KERNEL);

Does passing sec->text_end directly as the last parameter to
mtree_insert_range() break contiguous mappings?

mtree_insert_range() expects the last boundary to be inclusive, but
sec->text_end represents the exclusive end address of the executable segmen=
t.
If user space maps seamlessly contiguous text segments, the insertion for t=
he
second segment might overlap with the claimed end of the first, causing it =
to
fail with -EEXIST.

>  	if (ret) {
>  		dbg("mtree_insert_range failed: text=3D%lx-%lx\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D5
