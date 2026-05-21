Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D233EF
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375739; cv=none; b=kD/xg8/HboyUAiw2ND/u7fQZqbm7i6/gi2Cps1NMtEVtpv/6N+Hl7PCs8e2Sf1UW0dnYdjS/JT1OnAf216I74VKtersd2KuZLhU1CQzWBV86S4gmftn46ShQG2UMeXOzTjQF9Rx16OagF1g+VlfNz0AO0cwoecskjE1niTa+A/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375739; c=relaxed/simple;
	bh=/9bfE0UGwInDBSR36gB7wyiMag40xp7tGSb7NegJtWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bxWe4SNYr/Iumnp+IhvvJOcEXZZofnNpUR3x3XTMa01AxKAjhLOSG9/dSdzli2+mphhqRgIImbIS6vhVuMAxLANUpqEDMN6bij2PBa1AG2s4GdweYyn9DoFDxZ5g+n6HhgwYoEySC8fHmIG2upF/xTtX3BuFRZCKtdhpf3cWznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT6WLPXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT6WLPXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9991F00A3B;
	Thu, 21 May 2026 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375738;
	bh=vgf5MhX/gAR/3wruv60CjQFk6cvRSKYrhRaowKrFSVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aT6WLPXbqrLD0m8Wz9VYS/uc07quDpV2XctNfRxPutkAXNH/6vC+egsVc9NGwiA30
	 60wHXh3zk1tHJq7Sc+ii0X2gFdk8aaBBmy4IZXfO63C/panYhRGCT1vf+cCe7ZyC1k
	 deLu5GmSgmBNimPT2io9FEJ0S7u1Po7UvQZ8JhRoXoeYp6lYxZS61DypfOY+nyJn3o
	 Xy8KwkiSJkZiVsm0bEldDYk25xvKNSjiGY0zzk3SoWASAMUsbXUieKH1JI9X9whYI0
	 +SGtw9kIsUa6Lits0iPXSuAnWU1evTz5RlJ14eBlZz/hXASmqCfL3+MC0lmQdytNF2
	 D7p9tbA3n5WUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 12/20] unwind_user/sframe: Add .sframe validation
 option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-13-jremus@linux.ibm.com>
References: <20260521142546.3908498-13-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:02:16 +0000
Message-Id: <20260521150217.5B9991F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `.sframe` validation loop in `sframe_validate_section` lacks `=
cond_resched()`, allowing maliciously large or crafted `.sframe` sections t=
o cause CPU soft lockups.
--

commit 134a5da326c64a7bfc6e8145805fff7efe4a4cc1
Author: Josh Poimboeuf <jpoimboe@kernel.org>
unwind_user/sframe: Add .sframe validation option

This commit introduces a debug feature to validate all .sframe sections
when first loading the file rather than on demand. The feature reads the
entire .sframe section for every loaded executable and shared library.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 2cfa274cd8dcf..e6d66ae8e7ac6 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c

[ ... ]

> @@ -384,6 +384,94 @@ int sframe_find(unsigned long ip, struct unwind_user=
_frame *frame)
>  	goto end;
>  }
> =20
> +#ifdef CONFIG_SFRAME_VALIDATION

[ ... ]

> +static int sframe_validate_section(struct sframe_section *sec)
> +{
> +	struct sframe_fde_internal fde;
> +	unsigned long prev_func_addr;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < sec->num_fdes; i++) {
> +		struct sframe_fre_internal fre;
> +		unsigned long fre_addr;
> +		u32 prev_ip_off;
> +		unsigned int j;
> +		int ret;
> +
> +		ret =3D safe_read_fde(sec, i, &fde);
> +		if (ret) {
> +			dbg_sec("safe_read_fde(%u) failed\n", i);
> +			return ret;
> +		}
> +
> +		if (i && fde.func_addr <=3D prev_func_addr) {
> +			dbg_sec("FDE %u not sorted\n", i);
> +			return -EINVAL;
> +		}
> +		prev_func_addr =3D fde.func_addr;
> +
> +		fre_addr =3D sec->fres_start + fde.fres_off;
> +		for (j =3D 0; j < fde.fres_num; j++) {
> +			ret =3D safe_read_fre(sec, &fde, fre_addr, &fre);

[Severity: High]
Could a large or crafted .sframe section cause a CPU soft lockup here?

Since sec->num_fdes and fde.fres_num are bounded only by the mapped user
memory region size, a .sframe section could be crafted with millions of FDEs
pointing to the same valid array of FREs.

Without a cond_resched() or fatal_signal_pending() check in these nested
loops, iterating over these entries could monopolize the CPU in kernel mode
without yielding, potentially triggering the soft lockup watchdog.

> +			if (ret) {
> +				dbg_sec("FDE %u: safe_read_fre(%u) failed\n", i, j);
> +				dbg_sec("FDE: func_addr:%#lx func_size:%#x fda_off:%#x fres_off:%#x =
fres_num:%u info:%u info2:%u rep_size:%u\n",
> +					fde.func_addr, fde.func_size,
> +					fde.fda_off,
> +					fde.fres_off, fde.fres_num,
> +					fde.info, fde.info2,
> +					fde.rep_size);
> +				return ret;
> +			}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D12
