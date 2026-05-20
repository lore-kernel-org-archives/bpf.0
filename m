Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6233AD9D
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294171; cv=none; b=Wye7/XfDjsTRDg3p9MOZ4DP2L05rIPv862RkaY7JMMroJnXeNhKe9ySZoK0dBiccJ6eELxzuIPRE6EpMD8bxks7tTiXVmfPA5qL1FNzIH4P8AUjYk/+ZefuOo4T+U46tH4s74aUfvgJmjQeYHKA43OhVWhop+QVIsonBKW00m3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294171; c=relaxed/simple;
	bh=4UlL7hUowYscmhe/62/BN4YKDhoCjWbIrmXKoXB3TEI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iJFovZZYwsKmWePs/G/8zReUOCPD+TCSPE2xz5eCSwujYoSPDaScCY7gJkWvFEj6ZXC24pt397Vd7hn+z9y9DWctK0nRCoAMh7mD4I7t6x9OtNR7mIvxmtqh3yd5MhkjlWOUVCT25NcuZr3u/n58Cehwbaesl5UZ2wD7YKO+akY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFbguN9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFbguN9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E65E1F000E9;
	Wed, 20 May 2026 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294169;
	bh=BX2z+wxymci+TTR32BMVLVpnNm/3uf6waRPTJ7w0x6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFbguN9jjggLhG5r1SEhVCwT03un7vR/ByELFezTGTPwTd5G/9ISXXSky8v+f9SS3
	 rab8VaaxmoUABltoWXUXb0VIfll+ntxYFRtTQbrPsOQJVCkgtl4CaHwoJxEP+0smJg
	 BFQmxvTkQoPI4GIZqeY7rPJooI8icSTeNQ0gCewtuaecSENWONxcCi0+v4/oL5NV6O
	 QcpbZrSRCfGShfHPB5kQY+Kgp79Kjsm3ZZxaacWZ00kmolYwxM6EZmqCPUDwr9Ht9V
	 0wLBYz1Nm9DRkpACRxgGx7x22pp00wGgV/KZJ+2SAO6fft5HDmOj/uDkI0iiVWgNOZ
	 pn49TVJALiGeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 15/20] unwind_user: Flexible CFA recovery rules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-16-jremus@linux.ibm.com>
References: <20260520154004.3845823-16-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:22:48 +0000
Message-Id: <20260520162249.1E65E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The size of an SFrame Frame Row Entry (FRE) is incorrectly calcula=
ted because the `dataword_count` variable is decremented to zero before the=
 size calculation is performed.
--

commit b8c75c92fee05bcde0ff7d5c03df68927b72d4f5
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user: Flexible CFA recovery rules

To enable support for SFrame V3 flexible FDEs with a subsequent patch,
add support for the following flexible Canonical Frame Address (CFA)
recovery rules.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index e82d1dcdd471f..6187379750db5 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -283,6 +283,18 @@ static __always_inline int __read_fre(struct sframe_=
section *sec,
>  	return -EFAULT;
>  }
> =20

[Severity: High]
This isn't a bug introduced by this patch, but is the size of an SFrame Fra=
me
Row Entry (FRE) incorrectly calculated here because dataword_count is
decremented to zero before the size calculation is performed?

In __read_fre(), dataword_count is decremented as offsets are parsed:

kernel/unwind/sframe.c:__read_fre() {
	...
	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
	dataword_count--;

	ra_off =3D sec->ra_off;
	if (!ra_off && dataword_count) {
		dataword_count--;
		UNSAFE_GET_USER_INC(ra_off, cur, dataword_size, Efault);
	}
	...
}

By the time the code reaches the done: label, dataword_count is guaranteed
to be 0. Does this cause the fre->size calculation to completely ignore the
size of the data words?

kernel/unwind/sframe.c:__read_fre() {
	...
done:
	fre->size =3D addr_size + 1 + (dataword_count * dataword_size);
	...
}

Because the computed size is too small, when the unwinder advances to the n=
ext
FRE, does it misalign the pointer and start interpreting the previous FRE's
data words as the next FRE's header, reading garbage data and failing with
-EINVAL or -EFAULT?

I notice this is fixed later in the series in commit 9c045164b82cb
("unwind_user/sframe: Separate reading of FRE from reading of FRE data word=
s")
which properly preserves dataword_count.

> +static __always_inline void
> +sframe_init_cfa_rule_data(struct unwind_user_cfa_rule_data *cfa_rule_dat=
a,
> +			  unsigned char fre_info,
> +			  s32 offset)
> +{
> +	if (SFRAME_V3_FRE_CFA_BASE_REG_ID(fre_info) =3D=3D SFRAME_BASE_REG_FP)
> +		cfa_rule_data->rule =3D UNWIND_USER_CFA_RULE_FP_OFFSET;
> +	else
> +		cfa_rule_data->rule =3D UNWIND_USER_CFA_RULE_SP_OFFSET;
> +	cfa_rule_data->offset =3D offset;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D15
