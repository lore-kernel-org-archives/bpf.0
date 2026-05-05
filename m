Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE81309F1D
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005975; cv=none; b=A4/PtdyQIj31pA4x72FVoLewoq6ir2czaJDqvy0dEq2GmesuOy2Bn34Q/9MV/sG48wyf2HwTvB0F7H7lp6ig3K5zGIZgKEBjMITeoTQUC9BRqZ30ProC+vNAmptxarschljTwZaiFQNv4frfZQwgTy/3s1cJawfN4EpAlTiwpOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005975; c=relaxed/simple;
	bh=LIcscJcVVLqUCcOXfjCP3LEG10P/ux94nhxWp+r/ilM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p26PlMifHHjbf+aJlzOqdVXpqO+nU+8sfKy9pqzHK+Dx97RGH9yqOibGtLc8OA8QQmWy6qhvE5ikf+28+wrDsxrubz3HmJGPmZ0l74MMlI3Le4e1n0hAesGB/EOEW23huVTdvZHbWe8+xL44qJgv+Y4msdSaWd7nPMaox6x/jUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njHnCTAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njHnCTAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF63AC2BCB4;
	Tue,  5 May 2026 18:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005974;
	bh=LIcscJcVVLqUCcOXfjCP3LEG10P/ux94nhxWp+r/ilM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=njHnCTARWSID9EX0eeIVXmChdV+n9iS3C5msY7t7Vl27qwNMA2YtEwzSUqUXG8EtS
	 Z7GKqDF7n29xq2MX+nrPwJl5bEbAW107PlWd70GvbNI9bTUzDUj3ahyaZyfIEfXRhe
	 gSE/UEipea3FM3zmg+oVgiqGPVAAqAMoeMli/zsfo3fVXHnAF7gJcz0sVKbw10RvxJ
	 Ag7AVhKpiJn6zuBF/5Ul3i63sduFydQejtD7AJUIlJcakCxt2te5O3wgK2dpH/M/vF
	 8K1FVikLK/+WtN9EVOY6zlYvUQs69qHWmcYo8mTWx5X0jKFqwZku5OqhV+V6wHIPsp
	 R7+4/GF1kjTgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 12/19] unwind_user/sframe: Add .sframe validation
 option
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-13-jremus@linux.ibm.com>
References: <20260505121718.3572346-13-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:32:54 +0000
Message-Id: <20260505183254.AF63AC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Denial of Service (Soft Lockup) due to unyielding loops in .sframe=
 section validation.
- [High] Integer overflows on 32-bit architectures bypass bounds checks, al=
lowing arbitrary kernel/MMIO reads.
- [Low] Incorrect format specifier '%d' used for unsigned 32-bit integer.
--

commit 1f173c4dc22a264948bc63183c96747aa7022119
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Add .sframe validation option

This commit adds a debug feature to validate all .sframe sections when
first loading the file rather than on demand.=20

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 4419626f01734..45988cdc5c37a 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c

[ ... ]

> +static int sframe_validate_section(struct sframe_section *sec)
> +{
> +	unsigned long prev_ip =3D 0;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < sec->num_fdes; i++) {

Can a maliciously crafted .sframe mapping with extremely large values for
sec->num_fdes and fde.fres_num cause a soft lockup?

The outer and inner loops iterate over values parsed directly from the
user-provided .sframe section header, which could be up to 4 billion.

Since there is no cond_resched() called within these loops, processing a
large section might monopolize the CPU for an extended period and trigger
the soft lockup watchdog.=20

> +		struct sframe_fre_internal *fre, *prev_fre =3D NULL;
> +		unsigned long ip, fre_addr;
> +		struct sframe_fde_internal fde;
> +		struct sframe_fre_internal fres[2];
> +		bool which =3D false;
> +		unsigned int j;
> +		int ret;
> +
> +		ret =3D safe_read_fde(sec, i, &fde);

[ ... ]

> +		fre_addr =3D sec->fres_start + fde.fres_off;
> +		for (j =3D 0; j < fde.fres_num; j++) {
> +			int ret;
> +
> +			fre =3D which ? fres : fres + 1;
> +			which =3D !which;
> +
> +			ret =3D safe_read_fre(sec, &fde, fre_addr, fre);
> +			if (ret) {
> +				dbg_sec("FDE %u: safe_read_fre(%u) failed\n", i, j);
> +				dbg_sec("FDE: func_addr:%#lx func_size:%#x fda_off:%#x fres_off:%#x =
fres_num:%d info:%u info2:%u rep_size:%u\n",

This isn't a bug, but does fres_num use the wrong format specifier?

The fres_num field is defined as a u32, so %u should probably be used
instead of %d. If a user provides a fres_num exceeding 0x7FFFFFFF, it will
incorrectly print as a negative number in the debug output.

> +					fde.func_addr, fde.func_size,
> +					fde.fda_off,
> +					fde.fres_off, fde.fres_num,
> +					fde.info, fde.info2,
> +					fde.rep_size);
> +				return ret;
> +			}
> +
> +			fre_addr +=3D fre->size;

Could this addition overflow on 32-bit architectures?

Calculations like fre_addr +=3D fre->size (and similarly
fda_addr =3D sec->fres_start + _fde.fres_off in __read_fde() called by
safe_read_fde()) use 32-bit arithmetic on 32-bit architectures.

A maliciously crafted .sframe section could cause these calculations to wrap
around to a small value, which perfectly bypasses the bounds checks.

Because user_read_access_begin() validates the whole section range upfront
and UNSAFE_GET_USER_INC omits per-access access_ok() checks, this wrap
around could allow arbitrary kernel or MMIO reads.

> +
> +			if (prev_fre && fre->ip_off <=3D prev_fre->ip_off) {
> +				dbg_sec("FDE %u: FRE %u not sorted\n", i, j);
> +				return -EFAULT;
> +			}
> +
> +			prev_fre =3D fre;
> +		}
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D12
